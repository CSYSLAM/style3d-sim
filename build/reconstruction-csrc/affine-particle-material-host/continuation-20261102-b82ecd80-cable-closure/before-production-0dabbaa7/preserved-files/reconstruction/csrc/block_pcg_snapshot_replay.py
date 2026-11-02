"""Replay an actual block/affine/precomputed-PCG chain on identical allocations across three implementations."""
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
    parser.add_argument('--snapshot', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--trials', type=int, default=32)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    metadata = json.loads((args.snapshot / 'post-step.json').read_text())
    arrays = np.load(args.snapshot / 'post-step.npz')
    count, groups = metadata['particles'], metadata['groups']
    states, bodies, local = metadata['body_states'], metadata['bodies_per_world'], metadata['per_world']
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    source_image = native_source()
    source = source_image._KernelDriver()
    tokens = ('35apply_block_diagonal_preconditioner', '32apply_affine_body_preconditioner',
              '23precondition_and_reduce')
    nodes = [next(row for row in metadata['nodes'] if token in row['name']) for token in tokens]
    original_ptx, inputs, functions = {}, {}, {}
    for path in (ROOT / 'build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx'):
        text = path.read_text()
        for row in nodes:
            if row['name'] in entries(text):
                original_ptx[row['name']] = text
                inputs[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    for node in nodes:
        name = node['name']
        functions[name] = {
            'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
            'original-ptx': driver.function(original_ptx[name], name),
            'source-ptx': ct.c_void_p(source.function(name)),
        }
    pointers = {key: driver.upload(arrays[key]) for key in
                ('inverse_last_nl', 'rhs_last_nl', 'body_indices', 'affine_inverse_last_nl', 'affine_valid')}
    z_zero, num_zero = np.zeros((count, 3), dtype='f4'), np.zeros(groups, dtype='f4')
    z, numerator = driver.upload(z_zero), driver.upload(num_zero)
    assert int.from_bytes(bytes.fromhex(nodes[2]['parameters'][4]), 'little') == 0
    params = [
        [pointers['inverse_last_nl'], pointers['rhs_last_nl'], z, k.u64(count)],
        [pointers['body_indices'], pointers['affine_inverse_last_nl'], pointers['affine_valid'],
         pointers['rhs_last_nl'], z, k.u64(states), k.u64(bodies), k.u64(local)],
        [pointers['inverse_last_nl'], pointers['rhs_last_nl'], z, ct.c_bool(True), k.null(),
         ct.c_uint(local), numerator, k.u64(count)],
    ]
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    backends = ('original-runtime', 'original-ptx', 'source-ptx')
    rows, outputs, first, pointwise = [], {}, None, True
    try:
        for trial in range(args.trials):
            order = backends[trial % 3:] + backends[:trial % 3]
            for backend in order:
                for pointer, value in ((z, z_zero), (numerator, num_zero)):
                    driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(value.ctypes.data), value.nbytes))
                stages = []
                for index, (node, arguments) in enumerate(zip(nodes, params)):
                    kernel = functions[node['name']][backend]
                    holders = (ct.c_void_p * len(arguments))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in arguments])
                    gx, gy, gz, bx, by, bz, shared = node['geometry']
                    if backend == 'original-runtime':
                        status = launch_runtime(kernel, Dim3(gx, gy, gz), Dim3(bx, by, bz), holders, shared, stream)
                        assert status == 0, status
                    else:
                        driver.check(driver.cu.cuLaunchKernel(kernel, gx, gy, gz, bx, by, bz, shared,
                                                             stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    value = driver.download(z, z_zero)
                    stages.append(value.copy())
                scalar = driver.download(numerator, num_zero)
                if first is None:
                    first = stages
                same = [a.tobytes() == b.tobytes() for a, b in zip(first, stages)]
                pointwise &= all(same)
                key = f'{backend}-{trial}'
                outputs[key + '-z'] = np.asarray(stages)
                outputs[key + '-numerator'] = scalar.copy()
                rows.append({'backend': backend, 'trial': trial, 'stages_pointwise_equal': same,
                             'numerator_bits': scalar.view('u4').tolist()})
        np.savez_compressed(args.output / 'outputs.npz', **outputs)
        snapshot_bits = arrays['numerator_last_nl'].view('u4')[:groups].tolist()
        report = {
            'reference_sha256': REFERENCE_SHA,
            'source_sha256': hashlib.sha256(Path(source_image.__file__).read_bytes()).hexdigest(),
            'same_allocations_for_all_backends': True, 'trials_per_backend': args.trials,
            'last_nonlinear_iteration_only': True, 'precomputed_flag': True,
            'all_three_stages_pointwise_equal': bool(pointwise), 'snapshot_first_numerator_bits': snapshot_bits,
            'patterns': {backend: sorted({tuple(row['numerator_bits']) for row in rows if row['backend'] == backend})
                         for backend in backends},
            'checks': rows, 'diagnostic_intentionally_maps_original': True,
            'fixed_candidate_replaced': False, 'whole_solver_accepted': False,
            'inputs': {**inputs, **{str(p.resolve()): hashlib.sha256(p.read_bytes()).hexdigest() for p in
                                  (Path(__file__), args.snapshot / 'post-step.json', args.snapshot / 'post-step.npz')}},
        }
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        print(json.dumps({key: value for key, value in report.items() if key not in ('checks', 'inputs')}), flush=True)
        assert pointwise
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    main()
