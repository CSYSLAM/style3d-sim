"""Check whether the two strict failures received identical soft-contact records in a different input order."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
initial = json.loads((BASE / 'candidate-captures/report.json').read_text())
fields = ('soft_particle', 'soft_shape', 'soft_body_pos', 'soft_body_vel', 'soft_normal')
rows, hashes = [], {}
for row in initial['cases']:
    if row['strict_passed']:
        continue
    label = row['case']
    paths = [BASE / 'discovery-v2' / label / 'original/contacts-0.npz',
             BASE / 'candidate-captures' / label / 'contacts-0.npz']
    hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
    with np.load(paths[0], allow_pickle=False) as original, np.load(paths[1], allow_pickle=False) as source:
        n = int(original['soft_count'][0])
        assert int(source['soft_count'][0]) == n
        assert original['shape_body'].tobytes() == source['shape_body'].tobytes()
        records = [[b''.join(data[key][i].tobytes() for key in fields) for i in range(n)]
                   for data in (original, source)]
        assert records[0] != records[1] and sorted(records[0]) == sorted(records[1])
    rows.append({'case': label, 'active_soft_contacts': n, 'same_complete_record_multiset_bytes': True,
                 'actual_input_order_different': True})
assert len(rows) == 2
record = {'cases': rows, 'input_sha256': hashes, 'sorting_used_only_for_this_CPU_comparison': True,
          'solver_or_collision_inputs_modified': False, 'production_changed': False,
          'initial_strict_failures_reclassified': False, 'whole_solver_complete': False}
(BASE / 'initial-contact-order.json').write_text(json.dumps(record, indent=2) + '\n')
print('Two cases: complete soft-contact record multisets identical; actual input order differs')
