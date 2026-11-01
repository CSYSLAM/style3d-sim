"""Compare an actual runtime kernel and original/source PTX kernels using the exact same device allocations."""
import argparse
import ctypes as c
import hashlib
import json
from pathlib import Path
import struct

import numpy as np

from reconstruction import kernel_ab as k
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries


class Dim3(c.Structure):
    _fields_ = [('x', c.c_uint), ('y', c.c_uint), ('z', c.c_uint)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--launch', required=True)
    parser.add_argument('--trials', type=int, default=64)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    directory = args.trace/'legacy/actual'
    prefix = args.launch.removesuffix('.json')+'.'
    meta = json.loads((directory/(prefix+'json')).read_text())
    name = meta['name']
    precondition = '23precondition_and_reduce' in name
    assert precondition or '26multiply_matrix_and_reduce' in name
    sha = {}

    def payload(label, optional=False):
        path = directory/(prefix+label+'.bin')
        if optional and not path.exists():
            return None
        data = path.read_bytes()
        sha[str(path.resolve())] = hashlib.sha256(data).hexdigest()
        return data

    pointwise = 'z' if precondition else 'ap'
    aggregate = 'numerator' if precondition else 'denominator'
    expected_output = payload('after.'+pointwise)
    initial = np.frombuffer(payload('before.'+aggregate), dtype='f4').copy()
    world = payload('before.world', True)
    per_group = struct.unpack('<I', payload('before.per_group'))[0]
    if precondition:
        assert payload('before.precomputed') == b'\0'
    assert np.all(initial == 0)
    n = len(expected_output)//12
    driver = k.Driver()
    load_reference()
    library = c.CDLL(str(REFERENCE))
    launch_runtime = library.cudaLaunchKernel
    launch_runtime.argtypes = [c.c_void_p, Dim3, Dim3, c.POINTER(c.c_void_p), c.c_size_t, c.c_void_p]
    launch_runtime.restype = c.c_int
    runtime_function = c.cast(getattr(library, name), c.c_void_p)
    source_image = native_source()
    source = source_image._KernelDriver()
    reference_ptx = next(p for p in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                         if name in entries(p.read_text()))
    functions = {'original-runtime': runtime_function, 'original-driver': driver.function(reference_ptx.read_text(), name),
                 'source-driver': c.c_void_p(source.function(name))}
    stream = c.c_void_p()
    driver.check(driver.cu.cuStreamCreate(c.byref(stream), c.c_uint(1)))
    outputs, checks = [], []
    try:
        def captured_pointer(label, dtype='f4', optional=False):
            data = payload(label, optional)
            return driver.upload(np.frombuffer(data, dtype=dtype)) if data is not None else c.c_void_p()

        z_initial = np.zeros((n, 3), dtype='f4')
        pz = driver.upload(z_initial)
        pw = driver.upload(np.frombuffer(world, dtype='i4')) if world is not None else c.c_void_p()
        pn = driver.upload(initial)
        if precondition:
            parameters = [captured_pointer('before.inverse'), captured_pointer('before.r'), pz, c.c_bool(False),
                          pw, c.c_uint(per_group), pn, k.u64(n)]
        else:
            maximum = struct.unpack('<Q', payload('before.max_count'))[0]
            rows = struct.unpack('<Q', payload('before.rows'))[0]
            row_count = captured_pointer('before.row_count', 'i4') if maximum else c.c_void_p()
            entries_pointer = captured_pointer('before.entries', 'u1') if maximum else c.c_void_p()
            parameters = [row_count, entries_pointer, k.u64(maximum), captured_pointer('before.blocks'),
                          captured_pointer('before.p'), captured_pointer('before.extra', optional=True), pz,
                          pw, c.c_uint(per_group), pn, k.u64(n), k.u64(rows)]
        holders = (c.c_void_p*len(parameters))(*[c.cast(c.byref(p), c.c_void_p) for p in parameters])
        backends = list(functions)
        for trial in range(args.trials):
            order = backends[trial % 3:]+backends[:trial % 3]
            for backend in order:
                for pointer, array in ((pn, initial), (pz, z_initial)):
                    driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, c.c_void_p(array.ctypes.data), c.c_size_t(array.nbytes)))
                function = functions[backend]
                if backend == 'original-runtime':
                    status = launch_runtime(function, Dim3(meta['grid'], 1, 1), Dim3(meta['block'], 1, 1),
                                            holders, 0, stream)
                    assert status == 0, ('cudaLaunchKernel', status)
                else:
                    driver.check(driver.cu.cuLaunchKernel(function, meta['grid'], 1, 1, meta['block'], 1, 1,
                                                         0, stream, holders, None))
                driver.check(driver.cu.cuStreamSynchronize(stream))
                total = driver.download(pn, initial)
                value = driver.download(pz, z_initial)
                outputs.append(total.copy())
                checks.append({'trial': trial, 'backend': backend, 'scalar_bits': total.view('u4').tolist(),
                               'pointwise_equal': value.tobytes() == expected_output})
        np.savez_compressed(args.output/'outputs.npz', scalars=np.asarray(outputs))
        report = {'source_sha256': hashlib.sha256(Path(source_image.__file__).read_bytes()).hexdigest(),
                  'reference_sha256': REFERENCE_SHA, 'input_sha256': sha,
                  'original_ptx_sha256': hashlib.sha256(reference_ptx.read_bytes()).hexdigest(),
                  'method': 'Identical buffers and nonblocking stream; rotate actual runtime/original PTX/source PTX order',
                  'kernel': name, 'pointwise_output': pointwise, 'atomic_output': aggregate,
                  'particles': n, 'groups': len(initial), 'trials_per_backend': args.trials, 'checks': checks,
                  'patterns': {backend: sorted({tuple(v['scalar_bits']) for v in checks if v['backend'] == backend})
                               for backend in backends},
                  'all_pointwise_equal': all(v['pointwise_equal'] for v in checks),
                  'diagnostic_intentionally_maps_original': True, 'whole_solver_accepted': False}
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(json.dumps({key: value for key, value in report.items() if key not in ('checks', 'input_sha256')}), flush=True)
        assert report['all_pointwise_equal']
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
