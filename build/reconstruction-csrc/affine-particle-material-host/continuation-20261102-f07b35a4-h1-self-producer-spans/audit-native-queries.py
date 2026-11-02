"""Rebuild native query outputs and every expected F32 step using the frozen independent integer adder."""
import ast
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
previous = BASE.parent / 'continuation-20261102-f07b35a4-h1-first-cg'
manifest = json.loads((previous / 'completion-manifest.json').read_text())
adder = previous / 'audit-membrane-native-isolation.py'
assert hashlib.sha256(adder.read_bytes()).hexdigest() == manifest['files'][str(adder.relative_to(ROOT))]['sha256']
node = next(node for node in ast.parse(adder.read_text()).body if isinstance(node, ast.FunctionDef)
            and node.name == 'integer_add')
namespace = {}
exec(compile(ast.Module(body=[node], type_ignores=[]), str(adder), 'exec'), namespace)
integer_add = namespace['integer_add']
plan = json.loads((BASE / 'native-query-plan.json').read_text())
terminal = json.loads((BASE / 'native-query-isolation.status.json').read_text())
assert terminal['complete'] and terminal['running'] is None
assert [row['actual_exit'] for row in terminal['completed']] == [0] * 6
hashes = dict(plan['input_sha256'])
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
totals, cases = Counter(), []
for case in plan['cases']:
    folder = BASE / 'native-query-isolation' / case['tag']
    report = json.loads((folder / 'report.json').read_text())
    layout = json.loads((folder / 'layout.json').read_text())
    assert report['complete'] and report['queries'] == case['queries']
    assert report['native_PTX_source_calls'] == case['queries'] * 3
    assert report['original_selected_query_calls'] == len(case['gated_control_queries'])
    assert report['reference_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
    assert report['source_host_sha256'] == 'f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20'
    with np.load(case['packet'], allow_pickle=False) as packet:
        raw = [packet[f'parameter-{i}'].tobytes() for i in range(case['parameter_count'])]
        bindings = {int(key.rsplit('-', 1)[1]): packet[key].tobytes()
                    for key in packet.files if key.startswith('before-arg-')}
    with np.load(case['normalized_file'], allow_pickle=False) as packet:
        normalized = {key: packet[key] for key in packet.files}
    fields = {int(i): field for i, field in layout['fields'].items()}
    contact, counter = case['contact_argument'], case['counter_argument']
    cursor, offsets = 0, {}
    for i, field in fields.items():
        address = int.from_bytes(raw[i], 'little')
        offset = (cursor + 255) // 256 * 256 + 256 + address % 256
        size = (case['counter_before'] + 31) * 60 if i == contact else len(bindings[i])
        assert field == {'offset': offset, 'bytes': size}
        offsets[i] = offset // 4
        cursor = offset + size + 256
    assert layout['flat_bytes'] == (cursor + 3) // 4 * 4 and layout['dummy_bytes'] == 512
    seed = np.full(layout['flat_bytes'], 211, dtype='u1')
    for i, field in fields.items():
        seed[field['offset']:field['offset'] + field['bytes']] = np.frombuffer(bindings[i][:field['bytes']], dtype='u1')
    seed_words, dummy = seed.view('u4'), np.full(128, 0xd3d3d3d3, dtype='u4')
    n0, n1 = len(seed_words), len(dummy)
    assert report['words_compared_per_call'] == n0 + n1
    first_output = next(iter(fields))
    actual_params = [bytes.fromhex(value) for value in layout['actual_parameter_hex']]
    gate_params = [bytes.fromhex(value) for value in layout['gated_actual_parameter_hex']]
    actual_base = int.from_bytes(actual_params[first_output], 'little') - fields[first_output]['offset']
    assert actual_base % 256 == 0
    for i, value in enumerate(raw):
        assert len(actual_params[i]) == len(gate_params[i]) == len(value)
        if i in bindings:
            assert actual_params[i] == gate_params[i]
            assert int.from_bytes(actual_params[i], 'little') % 256 == int.from_bytes(value, 'little') % 256
            if i in fields:
                assert int.from_bytes(actual_params[i], 'little') == actual_base + fields[i]['offset']
        else:
            assert gate_params[i] == value
            wanted = (1).to_bytes(len(value), 'little') if i == layout['original_count_parameter_replaced_with_one'] else value
            assert actual_params[i] == wanted
    controls = json.loads((folder / 'helper-controls.json').read_text())
    points = {0, n0 - 1, n0, n0 + n1 // 2, n0 + n1 - 1}
    for field in fields.values():
        start, size = field['offset'] // 4, field['bytes'] // 4
        points.update((start - 1, start, start + size // 2, start + size - 1, start + size))
    points = sorted(points)
    assert [row['mutated_words'] for row in controls] == [[], *[[point] for point in points], points]
    for control in controls:
        expected = [seed_words.copy(), dummy.copy()]
        selected = control['mutated_words']
        for point in selected:
            side, index = (0, point) if point < n0 else (1, point - n0)
            expected[side][index] ^= np.uint32(1)
        assert control['GPU_status'] == [len(selected), min(selected) if selected else 0xffffffff]
        assert control['complete_CPU_readback_verified']
        assert control['actual_complete_SHA256'] == [hashlib.sha256(array.tobytes()).hexdigest() for array in expected]
    starts = np.concatenate(([0], np.cumsum(normalized['counts'], dtype='i8')))
    append_starts = np.concatenate(([0], np.cumsum(normalized['append_counts'], dtype='i8')))

    def rebuild(row):
        updates, history_left, history_right = {}, [], []
        for pos in range(int(starts[row]), int(starts[row + 1])):
            target = int(normalized['targets'][pos])
            arg, word = target >> 32, target & 0xffffffff
            assert arg in fields and word * 4 < fields[arg]['bytes']
            index = offsets[arg] + word
            before = updates.get(index, int(seed_words[index]))
            after = integer_add(before, int(normalized['operands'][pos]))
            updates[index] = after
            history_left.append(before)
            history_right.append(after)
        if case['stage'] != 'tangent':
            first, last = int(append_starts[row]), int(append_starts[row + 1])
            words = normalized['contact_records'][first:last].view('u4').ravel()
            index = offsets[contact] + case['counter_before'] * 15
            for i, word in enumerate(words):
                updates[index + i] = int(word)
            updates[offsets[counter]] = case['counter_before'] + last - first
        changed = sorted(index for index, value in updates.items() if value != int(seed_words[index]))
        return np.asarray(changed, dtype='u4'), np.asarray([updates[index] for index in changed], dtype='u4'), \
            history_left, history_right

    gate_controls = json.loads((folder / 'original-selected-query-controls.json').read_text())
    assert [row['query'] for row in gate_controls] == case['gated_control_queries']
    for control in gate_controls:
        targets, expected_values, _, _ = rebuild(control['query'])
        assert np.array_equal(targets, np.asarray(control['targets'], dtype='u4'))
        assert np.array_equal(expected_values, np.asarray(control['actual_words'], dtype='u4'))
        assert control['status'] == [0, 0xffffffff]
    expected_start, F32_steps, changed_words = 0, 0, 0
    for chunk in report['chunks']:
        assert chunk['first'] == expected_start
        first, last = chunk['first'], chunk['last']
        path = Path(chunk['file'])
        assert hashlib.sha256(path.read_bytes()).hexdigest() == chunk['sha256']
        hashes[str(path)] = chunk['sha256']
        with np.load(path, allow_pickle=False) as packet:
            data = {key: packet[key] for key in packet.files}
        bounds = data['patch_offsets']
        assert len(bounds) == last - first + 1 and bounds[0] == 0 and np.all(bounds[1:] >= bounds[:-1])
        assert data['patch_actual'].shape == (3, int(bounds[-1]))
        assert int(bounds[-1]) == len(data['patch_targets']) == len(data['patch_expected'])
        assert data['status'].shape == (last - first, 3, 2)
        assert not data['status'][:, :, 0].any() and np.all(data['status'][:, :, 1] == 0xffffffff)
        history_offset = 0
        for row in range(first, last):
            targets, expected_values, before, after = rebuild(row)
            a, b = int(bounds[row - first]), int(bounds[row - first + 1])
            assert np.array_equal(targets, data['patch_targets'][a:b])
            assert np.array_equal(expected_values, data['patch_expected'][a:b])
            assert np.array_equal(np.broadcast_to(expected_values, (3, len(expected_values))), data['patch_actual'][:, a:b])
            end = history_offset + len(before)
            assert np.array_equal(data['F32_before'][history_offset:end], np.asarray(before, dtype='u4'))
            assert np.array_equal(data['F32_after'][history_offset:end], np.asarray(after, dtype='u4'))
            history_offset = end
            F32_steps += len(before)
            changed_words += len(targets)
        assert history_offset == len(data['F32_before']) == len(data['F32_after'])
        expected_start = last
    assert expected_start == case['queries'] and F32_steps == int(starts[-1])
    for path in (folder / 'layout.json', folder / 'report.json', folder / 'helper-controls.json',
                 folder / 'original-selected-query-controls.json', folder / 'original-selected-query.ptx'):
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
    totals['queries'] += case['queries']
    totals['native_PTX_source_calls'] += report['native_PTX_source_calls']
    totals['original_query_controls'] += len(gate_controls)
    totals['independent_integer_F32_steps'] += F32_steps
    totals['complete_output_and_guard_words_GPU_compared'] += case['queries'] * 3 * (n0 + n1)
    totals['actual_changed_words_recorded'] += changed_words * 3
    cases.append({'case': case['tag'], 'queries': case['queries'], 'F32_steps': F32_steps,
                  'all_three_backends_complete_outputs_strict': True,
                  'actual_original_query_controls_and_full_readback_comparator_controls_verified': True})
    print('Independent native self query CPU audit:', cases[-1], flush=True)
assert totals['native_PTX_source_calls'] == 850560 and totals['independent_integer_F32_steps'] == 6225792
assert totals['original_query_controls'] == 40
hashes[str(Path(__file__))] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
hashes[str(adder)] = hashlib.sha256(adder.read_bytes()).hexdigest()
target = BASE / 'native-query-isolation-independent-cpu.json'
assert not target.exists()
target.write_text(json.dumps({'cases': cases, 'counts': dict(totals), 'input_sha256': hashes,
    'integer_RNE_FTZ_expected_histories_and_all_actual_final_outputs_verified': True,
    'all_full_outputs_determined_by_seeds_actual_changed_words_and_complete_GPU_bitwise_checks': True,
    'both_actual_endpoint_output_seeds_preserved': True, 'old_C8_or_aggregate_failures_rejudged': False,
    'joint_global_schedule_proven': False, 'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Native query audit complete:', dict(totals))
