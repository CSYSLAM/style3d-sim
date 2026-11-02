"""Certify all closed final-matrix scalar targets using actual GPU operands and real serial F32 atomics."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import kernel_ab as k
from . import ptx_compare as pc
from .demo_source_ab import ROOT
from .g1_last_matrix_capture import TOKEN
from .host_api_probe import REFERENCE_SHA
from .library_entries import entries
from .particle_reduction_certificates import SERIAL_PTX
from .pcg_alias_replay import span_groups
from .surface_atomic_operands import instrument


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    capture, output = args.capture.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    plan = json.loads((capture / 'certification-plan.json').read_text())
    replay = capture / 'replay/report.json'
    assert hashlib.sha256(replay.read_bytes()).hexdigest() == plan['original_replay_report_sha256']
    build_file = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    build_bytes = build_file.read_bytes()
    build = json.loads(build_bytes)
    name = next(name for name in build['kernels'] if TOKEN in name)
    header = (build_file.parent / 'source_ptx_bundle.h').read_text()
    modules = re.findall(r'\{"([^"]+)", R"([^\s(]+)\((.*?)\)\2"\}', header, re.S)
    original_path = next(path for path in (ROOT / 'build/reconstruction-ptx' / REFERENCE_SHA[:16]).glob('*.ptx')
                         if name in entries(path.read_text()))
    closed_replay = json.loads(replay.read_text())
    assert hashlib.sha256(original_path.read_bytes()).hexdigest() == closed_replay['input_sha256'][str(original_path)]
    texts = {'original': original_path.read_text(), 'source': modules[build['kernels'][name]['module']][2]}
    normalized_equal = pc.normalise(entries(texts['original'])[name]) == pc.normalise(entries(texts['source'])[name])
    driver = k.Driver()
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    functions = {}
    for side, text in texts.items():
        changed, sites = instrument(text, name)
        assert sites == 1
        (output / (side + '-instrumented.ptx')).write_text(changed)
        functions[side] = driver.function(changed, name)
    (output / 'serial-atomic.ptx').write_text(SERIAL_PTX)
    serial = driver.function(SERIAL_PTX, 'audit_serial_atomic')
    rows = []

    def launch(function, parameters, geometry):
        holders = (ct.c_void_p * len(parameters))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in parameters])
        driver.check(driver.cu.cuLaunchKernel(function, *geometry[:6], geometry[6], stream, holders, None))
        driver.check(driver.cu.cuStreamSynchronize(stream))

    def reset(pointer, array):
        driver.check(driver.cu.cuMemcpyHtoD_v2(pointer, ct.c_void_p(array.ctypes.data), array.nbytes))

    try:
        for number, case in enumerate(plan['packets']):
            assert build_file.read_bytes() == build_bytes
            side, frame = case['side'], case['frame']
            layout = json.loads((capture / side / 'readback-layout.json').read_text())
            node = layout['matrix']
            assert node['name'] == name and node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            path = capture / side / 'packets' / ('frame-' + str(frame).zfill(2) + '.npz')
            arrays = {}
            with np.load(path) as packet:
                raw = [packet['parameter-' + str(index)].tobytes() for index in range(12)]
                values = [int.from_bytes(value, 'little') for value in raw]
                assert values[10] == values[11] == values[8] == 176 and values[7] == 0
                bindings = {int(index): packet['post-frame-arg-' + str(index)].tobytes() for index in layout['sizes']}
                expected = bindings[6]
                bindings[6], bindings[9] = bytes(len(bindings[6])), bytes(4)
                groups = span_groups(values, bindings)
                pointers = {}
                for group in groups:
                    padding = group['start'] % 256
                    initial = np.zeros(padding + len(group['initial']), dtype='u1')
                    initial[padding:] = group['initial']
                    device = driver.upload(initial)
                    assert device.value % 256 == 0
                    group.update(device=device, upload=initial)
                    for index in group['indices']:
                        pointers[index] = device.value + padding + values[index] - group['start']
                        assert pointers[index] % 256 == values[index] % 256
                parameters = [(ct.c_ubyte * len(value)).from_buffer_copy(
                    pointers[index].to_bytes(8, 'little') if index in pointers else value)
                    for index, value in enumerate(raw)]
                trace_zero, count_zero = np.zeros((256, 128, 16), dtype='u1'), np.zeros(256, dtype='u4')
                trace, counts = driver.upload(trace_zero), driver.upload(count_zero)
                operand_values = []
                for backend in ('original', 'source'):
                    for group in groups:
                        reset(group['device'], group['upload'])
                    reset(trace, trace_zero)
                    reset(counts, count_zero)
                    launch(functions[backend], [*parameters, trace, counts], node['geometry'])
                    actual_counts = driver.download(counts, count_zero)
                    records = driver.download(trace, trace_zero)[:176, 0].copy()
                    addresses = records[:, :8].copy().view('<u8').reshape(-1)
                    operands = records[:, 8:12].copy().view('<f4').reshape(-1)
                    assert np.all(actual_counts[:176] == 1) and not actual_counts[176:].any()
                    assert np.all(addresses == pointers[9]) and np.isfinite(operands).all()
                    ap = driver.download(ct.c_uint64(pointers[6]), np.zeros(len(expected), dtype='u1'))
                    assert ap.tobytes() == expected
                    arrays[backend + '-raw-atomic-records'] = records
                    arrays[backend + '-lane-operands'] = operands
                    arrays[backend + '-counts'] = actual_counts
                    operand_values.append(operands)
                assert operand_values[0].tobytes() == operand_values[1].tobytes()
                operands = operand_values[0]
                tiny = np.finfo('f4').tiny
                normalized = operands.copy()
                subnormal = (np.abs(normalized) > 0) & (np.abs(normalized) < tiny)
                normalized.view('u4')[subnormal] &= np.uint32(0x80000000)
                missing = set(case['target_bits'])
                orders = {}
                rng = np.random.default_rng(int(hashlib.sha256(f'{side}/{frame}'.encode()).hexdigest()[:16], 16))
                for trial in range(plan['fixed_search_limit_per_packet']):
                    order = np.arange(176) if trial == 0 else rng.permutation(176)
                    prefix = np.cumsum(np.concatenate((np.zeros(1, dtype='f4'), normalized[order])), dtype='f4')
                    if np.any((np.abs(prefix) > 0) & (np.abs(prefix) < tiny)):
                        total, history = np.float32(0), []
                        for lane in order:
                            history.append(total)
                            total = np.float32(total + normalized[lane])
                            if 0 < abs(total) < tiny:
                                total = np.copysign(np.float32(0), total)
                        prefix = np.concatenate((np.asarray(history, dtype='f4'), np.asarray([total], dtype='f4')))
                    word = int(prefix[-1].view('u4'))
                    if word in missing:
                        missing.remove(word)
                        orders[word] = (order.astype('u4'), prefix[:-1].copy())
                    if not missing:
                        break
                checks = []
                for word in case['target_bits']:
                    row = {'target_bits': word, 'passed': False}
                    checks.append(row)
                    if word not in orders:
                        continue
                    order, before = orders[word]
                    serial_values = driver.upload(operands)
                    serial_order = driver.upload(order)
                    total_zero, history_zero = np.zeros(1, dtype='f4'), np.zeros(176, dtype='f4')
                    total, history = driver.upload(total_zero), driver.upload(history_zero)
                    launch(serial, [serial_values, serial_order, total, history, ct.c_uint(176)], [1, 1, 1, 1, 1, 1, 0])
                    actual = driver.download(total, total_zero)
                    actual_history = driver.download(history, history_zero)
                    assert int(actual.view('u4')[0]) == word and actual_history.tobytes() == before.tobytes()
                    arrays[str(word) + '-order'], arrays[str(word) + '-hardware-history'] = order, actual_history
                    row.update(passed=True, hardware_global_F32_atomic_verified=True)
                np.savez_compressed(output / (side + '-frame-' + str(frame).zfill(2) + '.npz'), **arrays)
                rows.append({'side': side, 'frame': frame, 'real_original_source_operands_equal': True,
                             'negative_operands': int(np.count_nonzero(operands < 0)),
                             'subnormal_operands': int(np.count_nonzero(subnormal)),
                             'search_trials': trial + 1, 'certificates': checks, 'unexplained_bits': sorted(missing)})
                driver.free()
                if number % 10 == 0:
                    print('certified final-matrix packet', number + 1, '/', len(plan['packets']), flush=True)
        report = {'packets': rows, 'packet_count': len(rows),
                  'certificates': sum(len(row['certificates']) for row in rows),
                  'all_passed': all(check['passed'] for row in rows for check in row['certificates']),
                  'normalized_original_source_matrix_PTX_equal': normalized_equal,
                  'actual_pre_call_output_bytes_captured': False, 'controlled_zero_seed': True,
                  'actual_production_order_inferred': False, 'production_changed': False,
                  'frozen_source_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        assert report['certificates'] == plan['unique_target_count']
        print('GPU atomic certificates', report['certificates'], 'all passed', report['all_passed'], flush=True)
        return 0 if report['all_passed'] else 1
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
