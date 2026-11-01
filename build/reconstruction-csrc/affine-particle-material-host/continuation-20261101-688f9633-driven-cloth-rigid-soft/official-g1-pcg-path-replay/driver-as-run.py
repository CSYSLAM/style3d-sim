"""Replay every captured PCG operator on identical allocations across SDK runtime, original PTX and source PTX."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_same_buffer_probe import Dim3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build_path.read_bytes()
    build = json.loads(saved)
    (args.output / 'build.json').write_bytes(saved)
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = core._KernelDriver()
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    inputs, functions, reports = {}, {}, []
    originals = {}
    for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx'):
        text = path.read_text()
        for name in entries(text):
            if '23precondition_and_reduceIN3glm' in name or '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry' in name:
                originals[name] = text
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()

    def read(path):
        data = path.read_bytes()
        inputs[str(path.resolve())] = hashlib.sha256(data).hexdigest()
        return data

    try:
        for side in ('legacy', 'source'):
            folder = args.trace / side / 'actual'
            paths = [p for p in sorted(folder.glob('*.json')) if
                     '23precondition_and_reduceIN3glm' in p.name or
                     '26multiply_matrix_and_reduceINS_17BlockNonZeroEntry' in p.name]
            assert paths, side
            for index, path in enumerate(paths):
                assert build_path.read_bytes() == saved
                metadata = json.loads(read(path))
                name, prefix = metadata['name'], path.name[:-4]
                precondition = '23precondition_and_reduce' in name
                pointwise, aggregate = ('z', 'numerator') if precondition else ('ap', 'denominator')

                def payload(label, optional=False):
                    filename = folder / (prefix + label + '.bin')
                    return read(filename) if filename.exists() or not optional else None

                def upload(label, optional=False):
                    data = payload(label, optional)
                    return driver.upload(np.frombuffer(data, dtype='u1')) if data is not None else ct.c_void_p()

                expected = payload('after.' + pointwise)
                n = len(expected) // 12
                assert len(expected) == n * 12 and n > 0
                initial = np.frombuffer(payload('before.' + aggregate), dtype='f4').copy()
                assert np.all(initial == 0)
                target = np.frombuffer(payload('after.' + aggregate), dtype='u4')
                divisor = int.from_bytes(payload('before.per_group'), 'little')
                world = upload('before.world', optional=True)
                if precondition:
                    raw = payload('before.precomputed')
                    assert raw in (b'\0', b'\1')
                    precomputed = raw == b'\1'
                    z_initial = (np.frombuffer(payload('before.z'), dtype='u1').copy() if precomputed else
                                 np.zeros(n * 12, dtype='u1'))
                else:
                    z_initial = np.zeros(n * 12, dtype='u1')
                z, counter = driver.upload(z_initial), driver.upload(initial)
                if precondition:
                    inverse = upload('before.inverse', optional=precomputed)
                    if precomputed and not inverse.value:
                        inverse = driver.upload(np.zeros((n, 9), dtype='f4'))
                    parameters = [inverse, upload('before.r'), z, ct.c_bool(precomputed), world,
                                  ct.c_uint(divisor), counter, k.u64(n)]
                else:
                    maximum = int.from_bytes(payload('before.max_count'), 'little')
                    rows = int.from_bytes(payload('before.rows'), 'little')
                    parameters = [upload('before.row_count') if maximum else ct.c_void_p(),
                                  upload('before.entries') if maximum else ct.c_void_p(), k.u64(maximum),
                                  upload('before.blocks'), upload('before.p'), upload('before.extra', optional=True),
                                  z, world, ct.c_uint(divisor), counter, k.u64(n), k.u64(rows)]
                if name not in functions:
                    functions[name] = {
                        'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                        'original-ptx': driver.function(originals[name], name),
                        'source-ptx': ct.c_void_p(source.function(name)),
                    }
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(p), ct.c_void_p) for p in parameters])
                backends = list(functions[name])
                backends = backends[index % 3:] + backends[:index % 3]
                checks = []
                for backend in backends:
                    for pointer, data in ((z, z_initial), (counter, initial)):
                        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(data.ctypes.data), data.nbytes))
                    function = functions[name][backend]
                    if backend == 'original-runtime':
                        assert launch_runtime(function, Dim3(metadata['grid'], 1, 1),
                                              Dim3(metadata['block'], 1, 1), holders, 0, stream) == 0
                    else:
                        driver.check(driver.cu.cuLaunchKernel(function, metadata['grid'], 1, 1,
                                                             metadata['block'], 1, 1, 0, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    actual = driver.download(z, z_initial)
                    total = driver.download(counter, initial)
                    checks.append({'backend': backend, 'pointwise_equal': actual.tobytes() == expected,
                                   'scalar_bits': total.view('u4').tolist(),
                                   'captured_scalar_equal': total.view('u4').tolist() == target.tolist()})
                    if actual.tobytes() != expected:
                        np.savez_compressed(args.output / (side + '-' + prefix + '-' + backend + '.npz'),
                                            actual=actual, expected=np.frombuffer(expected, dtype='u1'))
                reports.append({'side': side, 'launch': path.name, 'particles': n,
                                'captured_scalar_bits': target.tolist(), 'checks': checks})
                driver.free()
                if index % 50 == 0:
                    print(side, index + 1, '/', len(paths), flush=True)
        report = {'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'packets': reports, 'input_sha256': inputs,
                  'all_pointwise_equal': all(c['pointwise_equal'] for row in reports for c in row['checks']),
                  'diagnostic_intentionally_maps_original': True, 'production_changed': False,
                  'frozen_candidate_replaced': False, 'whole_solver_complete': False}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print('PCG packets', len(reports), 'all pointwise equal', report['all_pointwise_equal'], flush=True)
        return int(not report['all_pointwise_equal'])
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
