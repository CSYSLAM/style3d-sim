"""Check the first semantic payload difference of the adopted pair against its actual GPU atomic folds."""
import hashlib
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent
left = base / 'frozen-reproduced-pd-pair/legacy/native'
right = base / 'frozen-reproduced-pd-pair/source/native'
first = None
for metadata in sorted(left.glob('*.json')):
    if metadata.name == 'deferred-receipt.json':
        continue
    prefix = metadata.name[:-4]
    changed = []
    for path in sorted(left.glob(prefix + '*.bin')):
        if 'before.param_' not in path.name and path.read_bytes() != (right / path.name).read_bytes():
            changed.append(path.name.removeprefix(prefix))
    if changed:
        first = metadata.name, changed
        break
assert first == ('000002.21evaluate_spring_forceE.json', ['after.rhs.bin'])
prefix = first[0][:-4]
inputs = {}
for label in ('before.x', 'before.indices', 'before.stiffness', 'before.rest', 'before.rhs'):
    a = (left / (prefix + label + '.bin')).read_bytes()
    b = (right / (prefix + label + '.bin')).read_bytes()
    assert a == b
    inputs[label] = {'bytes': len(a), 'sha256': hashlib.sha256(a).hexdigest()}
a = np.fromfile(left / (prefix + 'after.rhs.bin'), dtype='u4')
b = np.fromfile(right / (prefix + 'after.rhs.bin'), dtype='u4')
different = np.flatnonzero(a != b)
assert different.tolist() == [772, 959]
with np.load(base / 'force-audits18/legacy-0/contributions.npz') as old:
    hardware = old['2_diagonal_legacy_hardware_folds'].copy()
with np.load(base / 'force-audits18/source-0/contributions.npz') as new:
    assert hardware.tobytes() == new['2_diagonal_source_hardware_folds'].tobytes()
rows = []
for index in different:
    candidates = hardware.view('u4').reshape(6, -1)[:, index]
    assert int(a[index]) in candidates and int(b[index]) in candidates
    assert abs(int(a[index]) - int(b[index])) == 1
    rows.append({'scalar': int(index), 'particle': int(index // 3), 'component': int(index % 3),
                 'world': int(index // 9), 'original_bits': int(a[index]), 'source_bits': int(b[index]),
                 'actual_GPU_three_atomic_fold_bits': candidates.tolist()})
result = {'adopted_source_run': 'raw-only-trace4/1', 'first_launch': first[0], 'different_fields': first[1],
          'same_captured_inputs': inputs, 'different_scalars': rows,
          'both_targets_are_real_GPU_fold_outputs': True, 'actual_production_order_inferred': False,
          'fixed_C10_still_failed': True, 'whole_solver_complete': False,
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'first-spring-divergence.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
