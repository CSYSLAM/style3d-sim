"""Recheck every SDK-isolated output, actual isolated ABI and all GPU scalar certificate histories."""
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def add_bits(left, right):
    # GPU global F32 atomics flush subnormal operands and results, retaining the sign of zero.
    values = np.asarray([left, right], dtype='<u4').view('<f4')
    assert np.isfinite(values).all()
    tiny = np.finfo('f4').tiny
    values[(np.abs(values) < tiny) & (values != 0)] = np.copysign(
        np.float32(0), values[(np.abs(values) < tiny) & (values != 0)])
    result = np.float32(values[0] + values[1])
    if 0 < abs(result) < tiny:
        result = np.copysign(np.float32(0), result)
    assert np.isfinite(result)
    return int(result.view('u4'))


plan = json.loads((BASE / 'certification-plan.json').read_text())
isolation_plan = json.loads((BASE / 'isolation-plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert digest(Path(name)) == expected, name
assert plan['input_sha256'] == isolation_plan['input_sha256']
replay = json.loads((BASE / 'replay/report.json').read_text())
lookup = {(row['side'], row['frame']): row for row in replay['packets'] if row['stage'] == 'drive'}
isolated = json.loads((BASE / 'isolation/report.json').read_text())
certified = json.loads((BASE / 'certificates/report.json').read_text())
assert len(lookup) == len(isolated['packets']) == len(certified['packets']) == 120
for kind, suffix in [('isolation', 'isolation'), ('certificates', 'certificates')]:
    as_run = BASE / (kind + '-' + suffix + '-as-run.py')
    assert as_run.read_bytes() == (BASE / (kind + '-template.py')).read_bytes()
    report = isolated if kind == 'isolation' else certified
    assert report['runner_sha256'] == digest(as_run)
iso_lookup = {(row['side'], row['frame']): row for row in isolated['packets']}
cert_lookup = {(row['side'], row['frame']): row for row in certified['packets']}
counts = Counter()
inputs = {}
for case in plan['packets']:
    side, frame = case['side'], case['frame']
    row, iso, cert = lookup[side, frame], iso_lookup[side, frame], cert_lookup[side, frame]
    paths = [BASE / side / 'drive-packets' / f'frame-{frame:02d}.npz',
             BASE / 'replay' / f'drive-{side}-frame-{frame:02d}.npz',
             BASE / 'isolation' / f'{side}-frame-{frame:02d}.npz',
             BASE / 'certificates' / f'{side}-frame-{frame:02d}.npz']
    for path in paths:
        inputs[str(path)] = digest(path)
    with np.load(paths[0], allow_pickle=False) as packet, np.load(paths[1], allow_pickle=False) as replay_data, \
            np.load(paths[2], allow_pickle=False) as iso_data, np.load(paths[3], allow_pickle=False) as cert_data:
        terms, per_lane = [[] for _ in range(528)], [[] for _ in range(43)]
        records, sizes = replay_data['original-records'], replay_data['original-counts']
        cursor = 0
        for lane, size in enumerate(sizes):
            seen = set()
            for record in records[cursor:cursor + size]:
                address = int.from_bytes(record[:8].tobytes(), 'little')
                scalar = (address - row['actual_output_replay_addresses']['26']) // 4
                assert 0 <= scalar < 528 and scalar not in seen and lane < 43
                seen.add(scalar)
                word = int.from_bytes(record[8:12].tobytes(), 'little')
                terms[scalar].append((lane, word))
                per_lane[lane].append((scalar, word))
            cursor += int(size)
        assert cursor == len(records) and max(map(len, terms)) <= 8
        predicted = np.empty((2, 43, 528), dtype='<u4')
        for seed_index, seed in enumerate(isolation_plan['initial_output_bits']):
            predicted[seed_index].fill(seed)
            for lane, entries in enumerate(per_lane):
                for scalar, word in entries:
                    predicted[seed_index, lane, scalar] = add_bits(seed, word)
        assert iso_data['expected_from_real_operands'].tobytes() == predicted.tobytes()
        assert iso_data['outputs'].shape == (3, 2, 43, 528)
        for backend in range(3):
            assert iso_data['outputs'][backend].tobytes() == predicted.tobytes()
            counts['complete_isolated_output_words'] += predicted.size
        assert iso['all_three_equal'] and all(iso['matches_real_lane_operands'].values())
        counts['actual_SDK_PTX_source_isolated_calls'] += iso['calls']
        raw = [packet['parameter-' + str(i)].tobytes() for i in range(33)]
        original = [int.from_bytes(value, 'little') for value in raw]
        pointers = {int(i): value for i, value in iso['actual_binding_replay_addresses'].items()}
        assert set(pointers) == set(range(27))
        shifted = {2: 4, 3: 4, 4: 4, 6: 4, 7: 8, 8: 12, 9: 12, 10: 12,
                   11: 16, 12: 16, 13: 16, 14: 16, 15: 16, 16: 4, 17: 4}
        for i, pointer in pointers.items():
            assert pointer % 256 == original[i] % 256
        for lane in range(43):
            for i, value in enumerate(raw):
                expected = pointers[i] + shifted.get(i, 0) * lane if i in pointers else None
                if i in (27, 28):
                    expected = 1
                expected_bytes = value if expected is None else expected.to_bytes(8, 'little')
                actual = iso_data['actual-parameter-' + str(i)]
                assert actual.shape == (43, len(value)) and actual[lane].tobytes() == expected_bytes
                counts['actual_isolated_ABI_bytes_rechecked'] += len(value)
        initial = packet['before-arg-26'].view('<u4')
        scalars, targets = cert_data['scalars'], cert_data['target_bits']
        offsets, values = cert_data['offsets'], cert_data['term_value_bits']
        lanes = cert_data['term_lanes']
        hardware, history = cert_data['hardware_output_bits'], cert_data['hardware_history_bits']
        assert len(offsets) == len(scalars) + 1 and offsets[0] == 0 and offsets[-1] == len(values)
        assert len(values) == len(lanes) == len(history) and np.all(offsets[1:] >= offsets[:-1])
        assert targets.tobytes() == hardware.tobytes()
        observed = set()
        for i, (scalar, target) in enumerate(zip(scalars, targets)):
            scalar, target = int(scalar), int(target)
            assert (scalar, target) not in observed
            observed.add((scalar, target))
            a, b = map(int, offsets[i:i + 2])
            assert Counter(zip(map(int, lanes[a:b]), map(int, values[a:b]))) == Counter(terms[scalar])
            current = int(initial[scalar])
            assert int(cert_data['initial_bits'][i]) == current
            for j in range(a, b):
                assert int(history[j]) == current
                current = add_bits(current, int(values[j]))
            assert current == target == int(hardware[i])
        assert observed == {(scalar, word) for scalar, words in enumerate(case['targets']) for word in words}
        assert not cert['unexplained'] and cert['certificates'] == len(scalars)
        assert cert['hardware_history_values'] == len(history)
        counts['GPU_scalar_certificates'] += len(scalars)
        counts['GPU_F32_atomic_histories_rechecked'] += len(history)
        counts['packets'] += 1
assert counts['actual_SDK_PTX_source_isolated_calls'] == isolation_plan['expected_calls'] == 30960
assert counts['GPU_scalar_certificates'] == plan['unique_scalar_certificates'] == certified['certificates']
assert isolated['all_three_backends_equal'] and certified['all_passed']
report = {'counts': dict(counts), 'input_sha256': inputs, 'runner_sha256': digest(Path(__file__)),
          'all_actual_SDK_isolated_calls_and_real_operand_predictions_bitwise_equal': True,
          'all_saved_actual_isolated_ABI_bytes_rechecked': True, 'all_GPU_histories_and_targets_rechecked': True,
          'per_scalar_legal_orders_only': True, 'single_global_schedule_proven': False,
          'frozen_failure_reclassified': False, 'whole_solver_complete': False}
output = BASE / 'atomic-followup-cpu-audit.json'
assert not output.exists(), 'Preserve closed reports'
output.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps({'counts': dict(counts), 'whole_solver_complete': False}, indent=2), flush=True)
