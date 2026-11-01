"""Isolate each captured G1 drive on SDK runtime/PTX/source, including both signs of zero accumulators."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA, load_reference
from .host_particles_ab import native_source
from .library_entries import entries
from .pcg_alias_replay import span_groups
from .pcg_same_buffer_probe import Dim3


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    capture, output = args.capture.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    replay_path = capture / 'replay/report.json'
    replay = json.loads(replay_path.read_text())
    replay['packets'] = [row for row in replay['packets'] if row['stage'] == 'drive']
    assert len(replay['packets']) == 120
    assert replay['all_per_thread_per_target_operand_sequences_equal']
    plan = json.loads((capture / 'isolation-plan.json').read_text())
    for path, sha in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    assert plan['replay_report_sha256'] == hashlib.sha256(replay_path.read_bytes()).hexdigest()
    build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_path.read_bytes()
    build = json.loads(build_bytes)
    name = json.loads((capture / 'plan.json').read_text())['kernels']['drive']
    original = next(path for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx')
                    if name in entries(path.read_text()))
    driver = k.Driver()
    load_reference()
    runtime = ct.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [ct.c_void_p, Dim3, Dim3, ct.POINTER(ct.c_void_p), ct.c_size_t, ct.c_void_p]
    launch_runtime.restype = ct.c_int
    core = native_source()
    assert hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest() == build['extension_sha256']
    source = core._KernelDriver()
    functions = {'original-runtime': ct.cast(getattr(runtime, name), ct.c_void_p),
                 'original-ptx': driver.function(original.read_text(), name),
                 'source-ptx': ct.c_void_p(source.function(name))}
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    # Shift only drive-local inputs to k; keep full body, particle, DOF and target arrays.
    shifted = {2: 4, 3: 4, 4: 4, 6: 4, 7: 8, 8: 12, 9: 12, 10: 12,
               11: 16, 12: 16, 13: 16, 14: 16, 15: 16, 16: 4, 17: 4}
    rows = []
    try:
        for packet_number, row in enumerate(replay['packets']):
            side, frame = row['side'], row['frame']
            assert build_path.read_bytes() == build_bytes
            layout = next(stage for stage in json.loads(
                (capture / side / 'snapshot-layout.json').read_text())['stages'] if stage['key'] == 'drive')
            with np.load(capture / side / 'drive-packets' / f'frame-{frame:02d}.npz') as packet:
                raw = [packet['parameter-' + str(index)].tobytes() for index in range(33)]
                values = [int.from_bytes(value, 'little') for value in raw]
                assert values[27:32] == [43, 43, 176, 49, 49]
                bindings = {int(index): packet['before-arg-' + str(index)].tobytes() for index in layout['sizes']}
                assert np.all(np.frombuffer(bindings[6], dtype='<i4') == 1)
                assert np.all(np.frombuffer(bindings[4], dtype='<i4') == 1)
                groups = span_groups(values, bindings)
                pointers = {}
                for group in groups:
                    padding = group['start'] % 256
                    initial = np.zeros(padding + len(group['initial']), dtype='u1')
                    initial[padding:] = group['initial']
                    device = driver.upload(initial)
                    group.update(device=device, upload=initial, padding=padding)
                    for index in group['indices']:
                        pointers[index] = device.value + padding + values[index] - group['start']
                        assert pointers[index] % 256 == values[index] % 256
                actual_outputs = np.empty((3, 2, 43, 528), dtype='<u4')
                predicted = np.empty((2, 43, 528), dtype='<u4')
                for seed_index, seed in enumerate(plan['initial_output_bits']):
                    predicted[seed_index].fill(seed)
                with np.load(capture / 'replay' / f'drive-{side}-frame-{frame:02d}.npz') as operand_packet:
                    actual_counts = operand_packet['original-counts']
                    records = operand_packet['original-records']
                    cursor = 0
                    for lane, size in enumerate(actual_counts[:43]):
                        seen = set()
                        for record in records[cursor:cursor + int(size)]:
                            address = int.from_bytes(record[:8].tobytes(), 'little')
                            scalar = (address - row['actual_output_replay_addresses']['26']) // 4
                            assert scalar not in seen
                            seen.add(scalar)
                            value = record[8:12].copy().view('<f4')[0]
                            tiny = np.finfo('f4').tiny
                            if 0 < abs(value) < tiny:
                                value = np.copysign(np.float32(0), value)
                            for seed_index, seed in enumerate(plan['initial_output_bits']):
                                start = np.asarray(seed, dtype='<u4').view('<f4')[()]
                                result = np.float32(start + value)
                                if 0 < abs(result) < tiny:
                                    result = np.copysign(np.float32(0), result)
                                predicted[seed_index, lane, scalar] = result.view('u4')
                        cursor += int(size)
                    assert cursor == len(records)
                backend_names = list(functions)
                parameter_bytes = {i: np.empty((43, len(value)), dtype='u1') for i, value in enumerate(raw)}
                for lane in range(43):
                    patched = list(raw)
                    for index in pointers:
                        patched[index] = (pointers[index] + shifted.get(index, 0) * lane).to_bytes(8, 'little')
                    patched[27] = (1).to_bytes(8, 'little')
                    patched[28] = (1).to_bytes(8, 'little')
                    params = [(ct.c_ubyte * len(value)).from_buffer_copy(value) for value in patched]
                    for i, value in enumerate(params):
                        parameter_bytes[i][lane] = np.frombuffer(bytes(value), dtype='u1')
                    holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in params])
                    for seed_index, seed in enumerate(plan['initial_output_bits']):
                        for backend in backend_names:
                            for group in groups:
                                initial = group['upload']
                                driver.check(driver.cu.cuMemcpyHtoD_v2(group['device'],
                                             ct.c_void_p(initial.ctypes.data), initial.nbytes))
                            initial = np.full(528, seed, dtype='<u4')
                            driver.check(driver.cu.cuMemcpyHtoD_v2(ct.c_uint64(pointers[26]),
                                         ct.c_void_p(initial.ctypes.data), initial.nbytes))
                            function = functions[backend]
                            if backend == 'original-runtime':
                                assert launch_runtime(function, Dim3(1, 1, 1), Dim3(256, 1, 1),
                                                      holders, 0, stream) == 0
                            else:
                                driver.check(driver.cu.cuLaunchKernel(function, 1, 1, 1, 256, 1, 1,
                                                                     0, stream, holders, None))
                            driver.check(driver.cu.cuStreamSynchronize(stream))
                            actual_outputs[backend_names.index(backend), seed_index, lane] = driver.download(
                                ct.c_uint64(pointers[26]), initial)
                comparisons = {backend_names[index]: bool(np.array_equal(actual_outputs[0], actual_outputs[index]))
                               for index in (1, 2)}
                expected = {backend: bool(np.array_equal(actual_outputs[index], predicted))
                            for index, backend in enumerate(backend_names)}
                np.savez_compressed(output / f'{side}-frame-{frame:02d}.npz', outputs=actual_outputs,
                                    expected_from_real_operands=predicted,
                                    **{'actual-parameter-' + str(i): value
                                       for i, value in parameter_bytes.items()})
                rows.append({'side': side, 'frame': frame, 'comparisons': comparisons,
                             'actual_binding_replay_addresses': {str(i): p for i, p in pointers.items()},
                             'all_three_equal': all(comparisons.values()), 'matches_real_lane_operands': expected,
                             'calls': 3 * 2 * 43})
                driver.free()
                if packet_number % 10 == 0:
                    print('actual SDK drive load isolation', packet_number + 1, '/', len(replay['packets']), flush=True)
        report = {'packets': rows, 'calls': sum(row['calls'] for row in rows),
                  'all_three_backends_equal': all(row['all_three_equal'] for row in rows),
                  'all_actual_SDK_isolated_outputs_match_real_PTX_lane_operands': all(
                      all(row['matches_real_lane_operands'].values()) for row in rows),
                  'backend_order': list(functions), 'initial_output_bits': plan['initial_output_bits'],
                  'shifted_drive_local_arrays': shifted, 'count_and_local_for_isolation': 1,
                  'particle_world_width_unchanged': 176, 'production_changed': False,
                  'source_sha256': build['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
                  'frozen_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert report['calls'] == plan['expected_calls']
        print('Isolated drive load calls', report['calls'], 'all three equal', report['all_three_backends_equal'], flush=True)
        return 0 if (report['all_three_backends_equal'] and
                     report['all_actual_SDK_isolated_outputs_match_real_PTX_lane_operands']) else 1
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
