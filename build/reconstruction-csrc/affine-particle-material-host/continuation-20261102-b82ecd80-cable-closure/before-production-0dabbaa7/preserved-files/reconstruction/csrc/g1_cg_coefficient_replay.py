"""Check actual captured alpha/beta scalar pairs on SDK/PTX/source using unit-vector controlled CG calls."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from .demo_source_ab import ROOT


BACKENDS = ('original-runtime', 'original-ptx', 'source-ptx')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def prepare(phase):
    assert not (phase / 'coefficient-replay-plan.json').exists()
    plan = json.loads((phase / 'plan.json').read_text())
    for name, digest in plan['input_sha256'].items():
        assert sha(Path(name)) == digest, name
    paths = [phase / 'coefficients.npz', phase / 'trace-independent-cpu-audit.json',
             phase / 'independent-cpu-audit.json', Path(__file__)]
    hashes = dict(plan['input_sha256'])
    for path in paths:
        hashes[str(path)] = sha(path)
    with np.load(phase / 'coefficients.npz', allow_pickle=False) as data:
        assert data['alpha_num'].shape == data['alpha_den'].shape == (2750,)
        assert data['beta_num'].shape == data['beta_den'].shape == (2695,)
    (phase / 'coefficient-replay-plan.json').write_text(json.dumps({
        'input_sha256': hashes, 'kernels': plan['coefficient_kernels'], 'pairs': {'alpha': 2750, 'beta': 2695},
        'per_particle_world_width_for_controlled_replay': 1, 'actual_graph_world_width': 176,
        'beta_iteration_for_controlled_nonfirst_branch': 1, 'controlled_unit_vectors_not_actual_CG_vector_replay': True,
        'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False,
    }, indent=2) + '\n')
    print('Fixed2750 alpha and2695 beta actual scalar pairs for SDK/PTX/source controlled calls', flush=True)


def expected_arrays(kind, data):
    num, den = data[kind + '_num'].copy(), data[kind + '_den'].copy()
    count = len(num)
    ones = np.zeros((count, 3), dtype='<f4')
    ones[:, 0] = 1
    if kind == 'alpha':
        product = np.zeros((count, 3), dtype='<f4')
        product[:, 1] = 1
        solution = np.tile(np.asarray([-0.0, 2, 3], dtype='<f4'), (count, 1))
        residual = np.tile(np.asarray([4, -0.0, 5], dtype='<f4'), (count, 1))
        return {2: num, 3: den, 4: ones, 5: product, 6: solution, 7: residual}, [6, 7]
    z = np.tile(np.asarray([-0.0, 2, 3], dtype='<f4'), (count, 1))
    return {1: z, 4: num, 5: den, 6: ones}, [6]


def execute(phase):
    from reconstruction import kernel_ab as k
    from .g1_contact_rhs_replay import kernel_texts
    from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
    from .host_particles_ab import native_source
    from .pcg_same_buffer_probe import Dim3

    plan = json.loads((phase / 'coefficient-replay-plan.json').read_text())
    for name, digest in plan['input_sha256'].items():
        assert sha(Path(name)) == digest, name
    output = phase / 'coefficient-replay'
    output.mkdir(exist_ok=False)
    build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    driver = k.Driver()
    assert sha(REFERENCE) == REFERENCE_SHA
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch = runtime.cudaLaunchKernel
    launch.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch.restype = ct.c_int
    module = native_source()
    assert sha(Path(module.__file__)) == build['extension_sha256']
    source = module._KernelDriver()
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    rows = []
    try:
        with np.load(phase / 'coefficients.npz', allow_pickle=False) as data:
            for kind in ('alpha', 'beta'):
                name, count = plan['kernels'][kind], plan['pairs'][kind]
                texts, _ = kernel_texts(build, name)
                functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                             'original-ptx': driver.function(texts['original'], name),
                             'source-ptx': ct.c_void_p(source.function(name))}
                initial, outputs = expected_arrays(kind, data)
                devices, uploads, pointers = {}, {}, {}
                for i, value in initial.items():
                    raw = np.full(value.nbytes + 512, 211, dtype='u1')
                    raw[256:256 + value.nbytes] = value.view('u1').reshape(-1)
                    uploads[i] = raw
                    devices[i] = driver.upload(raw)
                    assert devices[i].value % 256 == 0
                    pointers[i] = devices[i].value + 256
                if kind == 'alpha':
                    parameters = [ct.c_uint64(0), ct.c_uint(1),
                                  *(ct.c_uint64(pointers[i]) for i in (2, 3, 4, 5, 6, 7)), ct.c_uint64(count)]
                else:
                    parameters = [ct.c_int(1), ct.c_uint64(pointers[1]), ct.c_uint64(0), ct.c_uint(1),
                                  *(ct.c_uint64(pointers[i]) for i in (4, 5, 6)), ct.c_uint64(count)]
                assert list(map(ct.sizeof, parameters)) == build['kernels'][name]['parameters']
                arrays = {'actual-parameter-' + str(i): np.frombuffer(bytes(v), dtype='u1').copy()
                          for i, v in enumerate(parameters)}
                holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(v), ct.c_void_p) for v in parameters])
                grid = (count + 255) // 256
                for backend in BACKENDS:
                    for i, value in uploads.items():
                        driver.check(driver.cu.cuMemcpyHtoD_v2(devices[i], ct.c_void_p(value.ctypes.data), value.nbytes))
                    if backend == 'original-runtime':
                        assert launch(functions[backend], Dim3(grid, 1, 1), Dim3(256, 1, 1), holders, 0, stream) == 0
                    else:
                        driver.check(driver.cu.cuLaunchKernel(functions[backend], grid, 1, 1, 256, 1, 1,
                                                             0, stream, holders, None))
                    driver.check(driver.cu.cuStreamSynchronize(stream))
                    for i, before in uploads.items():
                        after = driver.download(devices[i], before)
                        arrays[backend + '-buffer-' + str(i)] = after
                        assert after[:256].tobytes() == before[:256].tobytes()
                        assert after[-256:].tobytes() == before[-256:].tobytes()
                        if i not in outputs:
                            assert after.tobytes() == before.tobytes()
                strict = {backend: all(arrays[backend + '-buffer-' + str(i)].tobytes() ==
                                       arrays['original-runtime-buffer-' + str(i)].tobytes() for i in outputs)
                          for backend in BACKENDS}
                path = output / (kind + '.npz')
                np.savez_compressed(path, **arrays)
                rows.append({'kind': kind, 'pairs': count, 'geometry': [grid, 256], 'outputs': outputs,
                             'device_bases': {str(i): device.value for i, device in devices.items()},
                             'sha256': sha(path), 'complete_output_checks': strict,
                             'all_complete_outputs_bitwise_equal': all(strict.values())})
                driver.free()
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))
    (phase / 'coefficient-replay-report.json').write_text(json.dumps({
        'rows': rows, 'actual_kernel_calls': 6, 'actual_scalar_pair_checks': 16335,
        'runner_sha256': sha(Path(__file__)), 'whole_solver_complete': False,
    }, indent=2) + '\n')
    print('Controlled5445-pair complete-output comparisons:',
          {row['kind']: row['complete_output_checks'] for row in rows}, flush=True)


def audit(phase):
    plan = json.loads((phase / 'coefficient-replay-plan.json').read_text())
    for name, digest in plan['input_sha256'].items():
        assert sha(Path(name)) == digest, name
    report = json.loads((phase / 'coefficient-replay-report.json').read_text())
    counts, metrics = {'actual_ABI_bytes': 0, 'full_after_bytes': 0, 'complete_output_words': 0}, {}
    with np.load(phase / 'coefficients.npz', allow_pickle=False) as coefficients:
        for row in report['rows']:
            kind, count = row['kind'], row['pairs']
            path = phase / 'coefficient-replay' / (kind + '.npz')
            assert sha(path) == row['sha256']
            initial, outputs = expected_arrays(kind, coefficients)
            pointers = {int(i): address + 256 for i, address in row['device_bases'].items()}
            raw = ([0, 1, *[pointers[i] for i in (2, 3, 4, 5, 6, 7)], count] if kind == 'alpha'
                   else [1, pointers[1], 0, 1, *[pointers[i] for i in (4, 5, 6)], count])
            widths = [8, 4, 8, 8, 8, 8, 8, 8, 8] if kind == 'alpha' else [4, 8, 8, 4, 8, 8, 8, 8]
            with np.load(path, allow_pickle=False) as saved:
                for i, (value, width) in enumerate(zip(raw, widths, strict=True)):
                    assert saved['actual-parameter-' + str(i)].tobytes() == value.to_bytes(width, 'little')
                    counts['actual_ABI_bytes'] += width * 3
                for i, value in initial.items():
                    before = np.full(value.nbytes + 512, 211, dtype='u1')
                    before[256:-256] = value.view('u1').reshape(-1)
                    for backend in BACKENDS:
                        after = saved[backend + '-buffer-' + str(i)]
                        assert after.shape == before.shape
                        assert after[:256].tobytes() == before[:256].tobytes()
                        assert after[-256:].tobytes() == before[-256:].tobytes()
                        if i not in outputs:
                            assert after.tobytes() == before.tobytes()
                        else:
                            counts['complete_output_words'] += value.size
                        counts['full_after_bytes'] += after.nbytes
                actual_checks = {backend: all(saved[backend + '-buffer-' + str(i)].tobytes() ==
                                              saved['original-runtime-buffer-' + str(i)].tobytes() for i in outputs)
                                 for backend in BACKENDS}
                assert actual_checks == row['complete_output_checks']
                field = 6
                measured = saved['original-runtime-buffer-' + str(field)][256:-256].copy().view('<f4').reshape(count, 3)[:, 0]
                num, den = coefficients[kind + '_num'].view('<f4'), coefficients[kind + '_den'].view('<f4')
                valid = (np.abs(den) > np.float32(1e-30)) & ~np.isnan(num) & ~np.isnan(den)
                predicted = np.zeros(count, dtype='<f4')
                with np.errstate(all='ignore'):
                    predicted[valid] = num[valid] / den[valid]
                metrics[kind] = {'pairs': count, 'complete_output_checks': actual_checks,
                                 'guarded_to_zero': int(np.count_nonzero(~valid)),
                                 'negative_denominator': int(np.count_nonzero(den < 0)),
                                 'CPU_RN_division_mismatched_words': int(np.count_nonzero(
                                     predicted.view('<u4') != measured.copy().view('<u4'))),
                                 'maximum_abs_GPU_coefficient': float(np.nanmax(np.abs(measured)))}
    output = phase / 'coefficient-replay-independent-cpu-audit.json'
    assert not output.exists()
    output.write_text(json.dumps({'counts': counts, 'metrics': metrics,
                                  'controlled_unit_vector_tests_not_full_actual_CG_vector_replay': True,
                                  'production_changed': False, 'old_C8_reclassified': False,
                                  'whole_solver_complete': False}, indent=2) + '\n')
    print(json.dumps({'counts': counts, 'metrics': metrics}, indent=2))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', type=Path, required=True)
    parser.add_argument('--mode', choices=('prepare', 'execute', 'audit'), required=True)
    args = parser.parse_args()
    {'prepare': prepare, 'execute': execute, 'audit': audit}[args.mode](args.phase.resolve())


if __name__ == '__main__':
    main()
