"""Describe first-drive input spreads before each response change without changing any acceptance criterion."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
status = json.loads((BASE / 'run.status.json').read_text())
assert status['complete'] and len(status['completed']) == 11
output = BASE / 'substep-input-spread.json'
assert not output.exists()
rows, hashes = [], {}
float_args = {0, 1, 2, 3, *range(8, 16), 18, 19, 20, *range(22, 27)}
for step in range(6):
    data, velocities = [], []
    for run in plan['runs']:
        folder = BASE / run['label'] / 'trace'
        path = folder / ('drive' + str(step) + '-packets/frame-00.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            data.append({i: packet['before-arg-' + str(i)].copy() for i in range(27)})
        path = folder / ('velocity' + str(step) + '-packets/frame-00.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(path, allow_pickle=False) as packet:
            v = packet['after-arg-3'].view('<f4').reshape(176, 3)
            ids = data[-1][5].view('<i4').reshape(44, 4)[12]
            velocities.append({'label': run['label'], 'max_abs_body12_proxy_qd': float(np.abs(v[ids]).max())})
    fields = {}
    for i in range(27):
        groups = {}
        for run, packet in zip(plan['runs'], data, strict=True):
            digest = hashlib.sha256(packet[i].tobytes()).hexdigest()
            groups.setdefault(digest, []).append(run['label'])
        row = {'bitwise_equal_groups': list(groups.values()), 'unique_payloads': len(groups)}
        if i in float_args:
            sdk = np.stack([packet[i].view('<f4').astype('f8') for packet in data[:8]])
            assert np.isfinite(sdk).all()
            row['SDK_pairwise_range_max'] = float((sdk.max(axis=0) - sdk.min(axis=0)).max())
            row['source_max_abs_error_to_first_SDK'] = [
                float(np.abs(packet[i].view('<f4').astype('f8') - sdk[0]).max()) for packet in data[8:]]
            if i in (0, 1):
                xyz = sdk.reshape(8, 176, 3)[:, ids]
                row['body12_SDK_pairwise_range_max'] = float((xyz.max(axis=0) - xyz.min(axis=0)).max())
        fields[str(i)] = row
    rows.append({'substep': step, 'first_drive_before_fields': fields, 'end_velocity': velocities})
result = {'substeps': rows, 'input_sha256': hashes, 'descriptive_only_not_a_new_acceptance_test': True,
          'old_C8_reclassified': False, 'production_changed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(result, indent=2) + '\n')
for row in rows:
    print('Substep', row['substep'],
          'body12 predicted-position SDK range', row['first_drive_before_fields']['0']['body12_SDK_pairwise_range_max'],
          'end proxy speed maxima', [round(v['max_abs_body12_proxy_qd'], 6) for v in row['end_velocity']], flush=True)
