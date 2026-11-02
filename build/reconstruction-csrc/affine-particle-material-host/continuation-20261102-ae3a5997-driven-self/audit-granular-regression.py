"""Recheck all six combined-candidate contact regressions and their actual SDK model, ABI and buffer bytes."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

folder = BASE / 'granular-regression'
reference = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts/discovery-v2'
plan = json.loads((folder / 'plan.json').read_text())
report = json.loads((folder / 'report.json').read_text())
status = json.loads((folder / 'status.json').read_text())
assert status['complete'] and status['running'] is None and len(status['completed']) == 6
assert all(row['actual_exit'] == 0 for row in status['completed'])
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
hashes, rows = {}, []
for case, row in zip(plan['cases'], report['cases'], strict=True):
    assert case['label'] == row['case'] and row['actual_exit'] == 0
    left, right = reference / case['label'] / 'original', folder / case['label']
    for name in ('capture.npz', 'model-before.npz', 'actual-layout.npz'):
        for path in (left / name, right / name):
            hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        with np.load(left / name, allow_pickle=False) as a, np.load(right / name, allow_pickle=False) as b:
            assert set(a.files) == set(b.files)
            if name == 'capture.npz':
                assert all(np.isfinite(data[key]).all() for data in (a, b) for key in data.files)
                assert compare(a, b) == row['states']
            else:
                assert all(a[key].shape == b[key].shape and a[key].dtype == b[key].dtype
                           and a[key].tobytes() == b[key].tobytes() for key in a.files)
    abi = compare_launches(left / 'launches.txt', right / 'launches.txt', schemas()[0])
    assert abi == row['metadata'] and abi['equal']
    coverage = sum(json.loads((right / 'capture.launches.json').read_text()).values()) == abi['right_launches']
    assert coverage and row['complete_owned_coverage']
    buffers = {}
    for name, equal in row['buffers'].items():
        a, b = (left / name).read_bytes(), (right / name).read_bytes()
        assert len(a) == len(b)
        buffers[name] = a == b
        assert equal == buffers[name]
    for path in left.iterdir():
        if path.is_file():
            expected = snapshot['files'][str(path.relative_to(ROOT))]
            raw = path.read_bytes()
            assert len(raw) == expected['bytes'] and hashlib.sha256(raw).hexdigest() == expected['sha256']
    strict = row['states']['bitwise'] and abi['equal'] and coverage and all(buffers.values())
    assert strict == row['strict_passed']
    rows.append({'case': case['label'], 'strict': strict, 'state_strict': row['states']['bitwise'],
                 'different_buffers': [name for name, equal in buffers.items() if not equal],
                 'model_and_layout_all_bytes_equal': True, 'owned_calls': abi['right_launches']})
assert sum(row['strict'] for row in rows) == 4
output = BASE / 'granular-regression-independent-cpu.json'
assert not output.exists()
output.write_text(json.dumps({'cases': rows, 'input_sha256': hashes, 'original_SDK_bytes_match_primary_snapshot': True,
    'GPU_runs': 0, 'whole_solver_complete': False}, indent=2) + '\n')
print('Six granular regressions independently reproduced: four strict, same two W3 failures retained')
