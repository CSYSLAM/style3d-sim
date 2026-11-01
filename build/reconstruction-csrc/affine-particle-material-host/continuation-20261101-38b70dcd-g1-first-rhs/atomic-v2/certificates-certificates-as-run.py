"""Verify every authentic drive output scalar using real operands, pre-call values and GPU global F32 atomics."""
import argparse
import ctypes as ct
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k


FOLD_PTX = '''.version 8.4
.target sm_52
.address_size 64
.visible .entry audit_variable_atomic_folds(
 .param .u64 values, .param .u64 offsets, .param .u64 initial,
 .param .u64 output, .param .u64 history, .param .u32 count)
{
 .reg .b64 %rd<16>;
 .reg .b32 %r<10>;
 .reg .f32 %f<3>;
 .reg .pred %p<3>;
 mov.u32 %r0, %tid.x;
 mov.u32 %r1, %ctaid.x;
 mov.u32 %r2, %ntid.x;
 mad.lo.u32 %r0, %r1, %r2, %r0;
 ld.param.u32 %r3, [count];
 setp.ge.u32 %p0, %r0, %r3;
 @%p0 bra DONE;
 ld.param.u64 %rd0, [values];
 ld.param.u64 %rd1, [offsets];
 ld.param.u64 %rd2, [initial];
 ld.param.u64 %rd3, [output];
 ld.param.u64 %rd4, [history];
 mul.wide.u32 %rd5, %r0, 4;
 add.u64 %rd6, %rd1, %rd5;
 ld.global.u32 %r4, [%rd6];
 ld.global.u32 %r5, [%rd6+4];
 add.u64 %rd7, %rd2, %rd5;
 ld.global.u32 %r6, [%rd7];
 add.u64 %rd8, %rd3, %rd5;
 st.global.u32 [%rd8], %r6;
 membar.gl;
 setp.ge.u32 %p1, %r4, %r5;
 @%p1 bra DONE;
LOOP:
 mul.wide.u32 %rd9, %r4, 4;
 add.u64 %rd10, %rd0, %rd9;
 ld.global.f32 %f0, [%rd10];
 atom.global.add.f32 %f1, [%rd8], %f0;
 add.u64 %rd11, %rd4, %rd9;
 st.global.f32 [%rd11], %f1;
 add.u32 %r4, %r4, 1;
 setp.lt.u32 %p2, %r4, %r5;
 @%p2 bra LOOP;
DONE:
 ret;
}
'''


def ftz(value):
    tiny = np.finfo('f4').tiny
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


def fold(initial, values, order):
    current, history = initial, []
    for index in order:
        history.append(current)
        current = ftz(np.float32(ftz(current) + ftz(values[index])))
    return int(current.view('u4')), history


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--capture', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    capture, output = args.capture.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    plan = json.loads((capture / 'certification-plan.json').read_text())
    for path, sha in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
    replay_path = capture / 'replay/report.json'
    assert hashlib.sha256(replay_path.read_bytes()).hexdigest() == plan['replay_report_sha256']
    replay = json.loads(replay_path.read_text())
    replay['packets'] = [row for row in replay['packets'] if row['stage'] == 'joint']
    assert len(replay['packets']) == 2
    assert replay['all_per_thread_per_target_operand_sequences_equal'] and replay['all_unwritten_bytes_unchanged']
    lookup = {(row['side'], row['frame']): row for row in replay['packets']}
    (output / 'variable-atomic-folds.ptx').write_text(FOLD_PTX)
    driver = k.Driver()
    function = driver.function(FOLD_PTX, 'audit_variable_atomic_folds')
    stream = ct.c_void_p()
    driver.check(driver.cu.cuStreamCreate(ct.byref(stream), ct.c_uint(1)))
    report_rows = []
    try:
        for number, case in enumerate(plan['packets']):
            side, frame = case['side'], case['frame']
            row = lookup[(side, frame)]
            with np.load(capture / side / 'joint-packets' / f'frame-{frame:02d}.npz') as packet, np.load(
                    capture / 'replay' / f'joint-{side}-frame-{frame:02d}.npz') as arrays:
                initial = packet['before-arg-10'].view('<f4')
                counts, records = arrays['original-counts'], arrays['original-records']
                terms = [[] for _ in initial]
                cursor = 0
                for lane, size in enumerate(counts):
                    seen = set()
                    for record in records[cursor:cursor + int(size)]:
                        address = int.from_bytes(record[:8].tobytes(), 'little')
                        scalar = (address - row['actual_output_replay_addresses']['10']) // 4
                        assert scalar not in seen, 'A repeated thread/target requires a constrained interleaving search'
                        seen.add(scalar)
                        bits = int.from_bytes(record[8:12].tobytes(), 'little')
                        value = np.asarray(bits, dtype='<u4').view('<f4')[()]
                        assert np.isfinite(value)
                        terms[scalar].append((lane, bits))
                    cursor += int(size)
                assert cursor == len(records) and np.isfinite(initial).all()
                scalars, target_words, initial_words, offsets = [], [], [], [0]
                lanes, value_words, expected_history = [], [], []
                unexplained = []
                for scalar, targets in enumerate(case['targets']):
                    values = np.asarray([bits for _, bits in terms[scalar]], dtype='<u4').view('<f4')
                    assert len(values) <= 8, 'This corpus is expected to allow exhaustive permutations'
                    wanted, orders = set(targets), {}
                    for order in itertools.permutations(range(len(values))):
                        word, history = fold(initial[scalar], values, order)
                        if word in wanted:
                            orders[word] = (order, history)
                            wanted.remove(word)
                        if not wanted:
                            break
                    for word in targets:
                        if word not in orders:
                            unexplained.append({'scalar': scalar, 'target_bits': word})
                            continue
                        order, history = orders[word]
                        scalars.append(scalar)
                        target_words.append(word)
                        initial_words.append(int(initial[scalar].view('u4')))
                        for index in order:
                            lanes.append(terms[scalar][index][0])
                            value_words.append(terms[scalar][index][1])
                        offsets.append(len(lanes))
                        expected_history.extend(history)
                scalar_array = np.asarray(scalars, dtype='<u4')
                target_array = np.asarray(target_words, dtype='<u4')
                initial_array = np.asarray(initial_words, dtype='<u4')
                offsets_array = np.asarray(offsets, dtype='<u4')
                values_array = np.asarray(value_words, dtype='<u4')
                output_zero = np.zeros(len(scalars), dtype='<u4')
                history_zero = np.zeros(len(lanes), dtype='<u4')
                assert len(scalars)
                pointers = [driver.upload(value) for value in
                            (values_array, offsets_array, initial_array, output_zero, history_zero)]
                params = [*pointers, ct.c_uint(len(scalars))]
                holders = (ct.c_void_p * len(params))(*[ct.cast(ct.byref(value), ct.c_void_p) for value in params])
                driver.check(driver.cu.cuLaunchKernel(function, (len(scalars) + 127) // 128, 1, 1, 128, 1, 1,
                                                     0, stream, holders, None))
                driver.check(driver.cu.cuStreamSynchronize(stream))
                actual = driver.download(pointers[3], output_zero)
                history = driver.download(pointers[4], history_zero)
                assert actual.tobytes() == target_array.tobytes()
                assert history.tobytes() == np.asarray(expected_history, dtype='<f4').tobytes()
                np.savez_compressed(output / f'{side}-frame-{frame:02d}.npz', scalars=scalar_array,
                    target_bits=target_array, initial_bits=initial_array, offsets=offsets_array,
                    term_lanes=np.asarray(lanes, dtype='<u4'), term_value_bits=values_array,
                    hardware_output_bits=actual, hardware_history_bits=history)
                report_rows.append({'side': side, 'frame': frame, 'certificates': len(scalars),
                                    'hardware_history_values': len(lanes), 'unexplained': unexplained,
                                    'max_terms_per_scalar': max(map(len, terms)),
                                    'per_thread_same_target_sequence_preserved': True})
                driver.free()
                if number % 10 == 0:
                    print('joint RHS scalar GPU certificates', number + 1, '/', len(plan['packets']), flush=True)
        report = {'packets': report_rows, 'certificates': sum(row['certificates'] for row in report_rows),
                  'hardware_history_values': sum(row['hardware_history_values'] for row in report_rows),
                  'all_passed': all(not row['unexplained'] for row in report_rows),
                  'authentic_pre_call_initial_used': True, 'all_actual_operands_retained_including_signed_zeros': True,
                  'per_scalar_legal_orders_only': True, 'single_global_thread_or_warp_schedule_proven': False,
                  'actual_production_order_inferred': False, 'production_changed': False,
                  'frozen_failure_reclassified': False, 'whole_solver_complete': False,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
        (output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
        checked = report['certificates'] + sum(len(row['unexplained']) for row in report_rows)
        assert checked == plan['unique_scalar_certificates']
        print('Joint RHS scalar certificates:', report['certificates'], 'all passed', report['all_passed'], flush=True)
        return 0 if report['all_passed'] else 1
    finally:
        driver.free()
        driver.check(driver.cu.cuStreamDestroy_v2(stream))


if __name__ == '__main__':
    raise SystemExit(main())
