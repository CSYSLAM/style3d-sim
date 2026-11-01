"""Verify the closed SDK/source matrix directly from frozen array and force-buffer bytes on the CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

base = Path(__file__).resolve().parent
reference, source = base / 'original32', base / 'source32-38b70dcd'
proof = json.loads((source / 'report.json').read_text())
assert proof['complete'] and len(proof['cases']) == 32
rows, states, forces, launches = [], 0, 0, 0
for case in proof['cases']:
    name = case['case']
    assert case['passed'] and case['metadata']['equal'] and case['source_coverage_equal']
    assert case['metadata']['geometry_and_shared_memory_complete']
    old, new = reference / name, source / name
    with np.load(old / 'capture.npz') as a, np.load(new / 'capture.npz') as b:
        assert set(a.files) == set(b.files) == {'particle_q', 'particle_qd', 'body_q', 'body_qd'}
        for field in a.files:
            assert a[field].dtype == b[field].dtype and a[field].shape == b[field].shape
            assert a[field].shape[0] == 3 and np.isfinite(a[field]).all() and np.isfinite(b[field]).all()
            assert a[field].tobytes() == b[field].tobytes(), (name, field)
            states += 1
    files = sorted(old.glob('dump_*.bin'))
    assert len(files) in (72, 90)
    for path in files:
        a, b = path.read_bytes(), (new / path.name).read_bytes()
        assert a == b and np.isfinite(np.frombuffer(a, dtype='<f4')).all(), (name, path.name)
        forces += 1
    launches += case['metadata']['left_launches']
    assert case['metadata']['left_launches'] == case['metadata']['right_launches']
    rows.append({'case': name, 'state_fields': 4, 'three_steps_bitwise_equal': True,
                 'force_buffers': len(files), 'all_force_buffers_bitwise_equal': True,
                 'owned_launches': case['metadata']['left_launches']})
assert states == 128 and forces == 2448 and launches == 18624
result = {'source_sha256': proof['source_sha256'], 'cases': rows, 'state_fields_checked': states,
          'force_buffers_checked': forces, 'owned_launches': launches, 'all_passed': True,
          'GPU_used': False, 'production_changed_by_audit': False, 'whole_solver_complete': False,
          'report_sha256': hashlib.sha256((source / 'report.json').read_bytes()).hexdigest(),
          'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(base / 'source32-independent-audit.json').write_text(json.dumps(result, indent=2) + '\n')
print('source32 CPU audit: state fields', states, 'force buffers', forces, 'owned launches', launches)
