"""Independently read complete replay outputs, actual ABI bytes, alias spans and raw read-only/guard data on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
output = BASE / 'full-input-replays'
plan = json.loads((output / 'plan.json').read_text())
report = json.loads((output / 'report.json').read_text())
assert report['complete'] and report['actual_calls'] == 6336 and len(report['packets']) == len(plan['packets']) == 2112
hashes = dict(plan['input_sha256'])
hashes[str(output / 'report.json')] = hashlib.sha256((output / 'report.json').read_bytes()).hexdigest()
counts = {'actual_calls': 0, 'actual_parameter_bytes': 0, 'complete_output_bytes': 0,
          'raw_group_bytes': 0, 'protected_bytes': 0, 'alias_groups': 0}
failures, checked, current, saved = [], [], None, None
try:
    for packet, row in zip(plan['packets'], report['packets']):
        assert all(packet[k] == row[k] for k in ('worker', 'frame'))
        stage = packet['stage']
        assert stage['key'] == row['stage'] and stage['kind'] == row['kind']
        path = Path(row['output'])
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        assert hashes[str(path)] == row['output_sha256']
        if current != packet['input']:
            if saved is not None:
                saved.close()
            current = packet['input']
            saved = np.load(current, allow_pickle=False)
        before = {b['label']: saved[stage['key'] + '/before/' + b['label']].copy() for b in stage['bindings']}
        expected = {label: saved[stage['key'] + '/after/' + label].tobytes() for label in stage['outputs']}
        by_label = {b['label']: b for b in stage['bindings']}
        with np.load(path, allow_pickle=False) as data:
            raw = [bytearray.fromhex(v) for v in stage['node']['parameter_hex']]
            for binding in stage['bindings']:
                label = binding['label']
                pointer = row['pointers'][label]
                assert pointer % 256 == binding['address'] % 256
                i, offset = binding['argument'], binding['offset']
                raw[i][offset:offset + 8] = pointer.to_bytes(8, 'little')
            for i, actual in enumerate(raw):
                assert data['actual-parameter-' + str(i)].tobytes() == bytes(actual)
                counts['actual_parameter_bytes'] += len(actual)
            group_initial, group_masks = [], []
            for group in row['groups']:
                value = np.full(group['prefix'] + group['bytes'] + 256, 211, dtype='u1')
                mask, seen = np.ones(len(value), dtype=bool), np.zeros(group['bytes'], dtype=bool)
                for label in group['labels']:
                    binding = by_label[label]
                    offset = binding['address'] - group['start']
                    assert offset >= 0 and offset + len(before[label]) <= group['bytes']
                    assert row['pointers'][label] == group['device_base'] + group['prefix'] + offset
                    target = value[group['prefix'] + offset:group['prefix'] + offset + len(before[label])]
                    overlap = seen[offset:offset + len(target)]
                    assert target[overlap].tobytes() == before[label][overlap].tobytes()
                    target[:] = before[label]
                    seen[offset:offset + len(target)] = True
                    if label in expected:
                        mask[group['prefix'] + offset:group['prefix'] + offset + len(target)] = False
                assert seen.all()
                counts['alias_groups'] += len(group['labels']) > 1
                group_initial.append(value)
                group_masks.append(mask)
            packet_checks = []
            for backend in plan['backends']:
                equal = {}
                for index, (value, mask) in enumerate(zip(group_initial, group_masks)):
                    after = data[backend + '-group-' + str(index)]
                    assert after.dtype == np.dtype('u1') and after.shape == value.shape
                    assert after[mask].tobytes() == value[mask].tobytes()
                    counts['protected_bytes'] += int(mask.sum())
                    counts['raw_group_bytes'] += len(after)
                for label, target in expected.items():
                    actual = data[backend + '-output-' + label].tobytes()
                    group_index = next(i for i, g in enumerate(row['groups']) if label in g['labels'])
                    group = row['groups'][group_index]
                    offset = row['pointers'][label] - group['device_base']
                    assert data[backend + '-group-' + str(group_index)][offset:offset + len(target)].tobytes() == actual
                    equal[label] = actual == target
                    counts['complete_output_bytes'] += len(actual)
                original = next(check for check in row['checks'] if check['backend'] == backend)
                assert equal == original['complete_output_equal_to_capture']
                packet_checks.append(all(equal.values()))
                if not all(equal.values()):
                    failures.append({'number': row['number'], 'backend': backend, 'worker': row['worker'],
                                     'frame': row['frame'], 'stage': row['stage'], 'kind': row['kind'],
                                     'different_output_labels': [label for label, ok in equal.items() if not ok]})
                counts['actual_calls'] += 1
            checked.append(all(packet_checks))
finally:
    if saved is not None:
        saved.close()
assert counts['actual_calls'] == 6336 and sum(checked) == report['strict_packets']
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
record = {'counts': counts, 'strict_packets': sum(checked), 'packets': len(checked), 'failures': failures,
          'input_sha256': hashes, 'GPU_used_for_this_audit': False, 'original_frozen_failure_reclassified': False,
          'whole_solver_complete': False}
(BASE / 'replay-independent-cpu-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('Independent CPU replay checks:', counts, 'strict packets', sum(checked), '/2112;failed backend calls', len(failures))
