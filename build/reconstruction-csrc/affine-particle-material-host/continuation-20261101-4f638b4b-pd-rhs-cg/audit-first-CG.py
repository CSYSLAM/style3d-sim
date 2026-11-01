"""Independently validate saved ABI/buffers, SDK isolation results and all hardware F32 fold histories on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
output = BASE / 'first-CG-replay'
plan = json.loads((output / 'plan.json').read_text())
report = json.loads((output / 'report.json').read_text())
assert report['complete'] and report['actual_calls'] == 72 and report['error'] is None
assert len(plan['cases']) == len(report['cases']) == 3
hashes = dict(plan['input_sha256'])
hashes[str(output / 'report.json')] = hashlib.sha256((output / 'report.json').read_bytes()).hexdigest()
pointwise, operand_words, isolated_words, fold_words, ABI_fields, unwritten_bytes = 0, 0, 0, 0, 0, 0
summaries = []
tiny = np.finfo('f4').tiny


def ftz(value):
    return np.copysign(np.float32(0), value) if 0 < abs(value) < tiny else value


for case, row in zip(plan['cases'], report['cases']):
    assert all(case[k] == row[k] for k in ('source_worker', 'stage', 'frame'))
    actual_path = Path(row['actual_output_packet'])
    hashes[str(actual_path)] = hashlib.sha256(actual_path.read_bytes()).hexdigest()
    assert hashes[str(actual_path)] == row['actual_output_sha256']
    with np.load(case['input_packet'], allow_pickle=False) as packet, np.load(actual_path, allow_pickle=False) as data:
        node = case['actual_stages'][0]['node']
        pointers = {int(i): v for i, v in row['unmodified_replay_pointers'].items()}
        before = {int(b['argument']): packet['SDK-before-' + b['label']] for b in case['actual_stages'][0]['bindings']}
        for i in before:
            assert before[i].tobytes() == packet['source-before-arg-' + str(i)].tobytes()
        assert packet['SDK-after-arg-6'].tobytes() == packet['source-after-arg-6'].tobytes()
        tags = sorted({key.rsplit('-parameter-', 1)[0] for key in data.files if '-parameter-' in key})
        assert len(tags) == 17
        for tag in tags:
            isolated = tag.endswith('-isolated')
            for i, raw in enumerate(node['parameter_hex']):
                actual = data[tag + '-parameter-' + str(i)].tobytes()
                expected = bytes.fromhex(raw)
                if i in pointers:
                    expected = pointers[i].to_bytes(8, 'little')
                if isolated and i in (7, 9):
                    key = 'controlled_world_pointer' if i == 7 else 'controlled_counter_pointer'
                    expected = row[key].to_bytes(8, 'little')
                assert actual == expected
                ABI_fields += 1
            for i, payload in before.items():
                prefix = row['padding'][str(i)]
                initial = np.full(prefix + len(payload) + 256, 211, dtype='u1')
                initial[prefix:prefix + len(payload)] = payload
                actual = data[tag + '-buffer-' + str(i)]
                assert actual.shape == initial.shape and actual.dtype == np.dtype('u1')
                assert pointers[i] - row['base_pointers'][str(i)] == prefix
                assert pointers[i] % 256 == int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little') % 256
                mask = np.ones(len(initial), dtype=bool)
                if i == 6 or (i == 9 and not isolated):
                    mask[prefix:prefix + len(payload)] = False
                assert actual[mask].tobytes() == initial[mask].tobytes()
                unwritten_bytes += int(mask.sum())
            prefix = row['padding']['6']
            assert data[tag + '-buffer-6'][prefix:prefix + 432].tobytes() == packet['SDK-after-arg-6'].tobytes()
            pointwise += 1
        patterns = {}
        for check in row['checks']:
            tag = check['tag']
            prefix = row['padding']['9']
            actual = data[tag + '-buffer-9'][prefix:prefix + 12]
            assert check['counter_bits'] == actual.view('<u4').tolist()
            assert check['same_as_captured_SDK'] == (actual.tobytes() == packet['SDK-after-arg-9'].tobytes())
            assert check['same_as_captured_source'] == (actual.tobytes() == packet['source-after-arg-9'].tobytes())
            if '-trial-' in tag:
                patterns.setdefault(tag.split('-trial-')[0], set()).add(tuple(check['counter_bits']))
        operands = []
        for side in ('original', 'source'):
            counts, trace = data[side + '-counts'], data[side + '-trace']
            assert counts.shape == (256,) and trace.shape == (256, 128, 16)
            assert np.all(counts[:36] == 1) and not counts[36:].any()
            addresses = trace[:36, 0, :8].copy().view('<u8').reshape(-1)
            pointer = int.from_bytes(data[side + '-probe-parameter-9'].tobytes(), 'little')
            assert np.array_equal(addresses, pointer + (np.arange(36, dtype='<u8') // 12) * 4)
            values = trace[:36, 0, 8:12].copy().view('<f4').reshape(-1)
            assert values.tobytes() == data[side + '-operands'].tobytes() and np.isfinite(values).all()
            operands.append(values)
        assert operands[0].tobytes() == operands[1].tobytes()
        operand_words += 36
        expected_effective = np.asarray([ftz(np.float32(np.float32(0) + ftz(v))) for v in operands[0]], dtype='<f4')
        effective = data['effective-hardware-atomic-buffer']
        assert np.all(effective[:256] == 211) and np.all(effective[-256:] == 211)
        assert effective[256:-256].tobytes() == expected_effective.tobytes()
        for backend in ('original-runtime', 'original-ptx', 'source-ptx'):
            controlled = data[backend + '-isolated-controlled-counter-buffer']
            assert controlled.shape == (656,)
            assert np.all(controlled[:256] == 211) and np.all(controlled[-256:] == 211)
            assert controlled[256:-256].tobytes() == expected_effective.tobytes()
            isolated_words += 36
        assert len(row['certificates']) == 6
        for certificate in row['certificates']:
            side, group = certificate['side'], certificate['group']
            tag = side + '-group-' + str(group)
            values, sequence = data[tag + '-fold-operands'], data[tag + '-fold-order']
            total, hardware_history = data[tag + '-fold-total'], data[tag + '-fold-history']
            assert values.tobytes() == operands[0][group * 12:(group + 1) * 12].tobytes()
            assert sorted(sequence.tolist()) == list(range(12))
            assert total.view('<u4')[0] == packet[side + '-after-arg-9'].view('<u4')[group] == certificate['target_bits']
            value, history = np.float32(0), []
            for lane in sequence:
                history.append(value)
                value = ftz(np.float32(value + ftz(values[int(lane)])))
            assert np.asarray(history, dtype='<f4').tobytes() == hardware_history.tobytes()
            assert int(value.view('<u4')) == certificate['target_bits']
            assert certificate['real_GPU_atomic_witness_passed'] and not certificate['actual_global_schedule_inferred']
            fold_words += 12
        summaries.append({'source_worker': row['source_worker'], 'frame': row['frame'], 'stage': row['stage'],
                          'unmodified_counter_patterns': {k: sorted(v) for k, v in patterns.items()},
                          'raw_operands_equal': True, 'SDK_runtime_controlled_contributions_equal': True,
                          'all_six_target_groups_have_hardware_F32_fold_witnesses': True})
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
assert pointwise == 51 and operand_words == 108 and isolated_words == 324 and fold_words == 216
record = {'cases': summaries, 'actual_calls': 72, 'complete_Ap_output_checks': pointwise,
          'real_per_lane_raw_operand_words_checked': operand_words, 'runtime_PTXX_source_isolated_word_checks': isolated_words,
          'hardware_F32_fold_history_words_checked': fold_words, 'actual_ABI_fields_checked': ABI_fields,
          'unwritten_and_guard_bytes_checked': unwritten_bytes, 'input_sha256': hashes,
          'GPU_used_for_this_audit': False, 'original_fixed_failure_reclassified': False,
          'captured_map_bytes_not_saved_but_creation_code_and_output_correspondence_retained': True,
          'whole_solver_complete': False}
(BASE / 'first-CG-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('CPU:51 complete Ap checks,108 raw operands,324 isolated words,216 hardware fold-history words;all strict')
