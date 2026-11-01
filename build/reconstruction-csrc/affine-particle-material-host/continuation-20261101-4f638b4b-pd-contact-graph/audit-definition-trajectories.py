"""Evaluate the four independent diagnostics against the untouched fixed C8 without adopting new samples."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.demo_ab import spread_report

old = BASE.parent / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
case = 'w3-b1-n2-s1-mixed-pd-b0-both-hit0'
cohort = old / 'graph-fixed-C8/cohorts' / (case + '-g1')
captures = BASE / 'definitions4-v2'
terminal = json.loads((captures / 'status.json').read_text())
assert terminal['complete'] and len(terminal['completed']) == 4
hashes = {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in sorted(cohort.glob('*.npz'))}
rows = []
with ExitStack() as stack:
    originals = [stack.enter_context(np.load(cohort / f'original{i}.npz')) for i in range(8)]
    for index, backend in enumerate(('original', 'source', 'source', 'source')):
        folder = captures / str(index)
        provenance = json.loads((folder / 'provenance.json').read_text())
        assert provenance['complete'] and provenance['queries_after_complete_worker']
        path = folder / (backend + '-' + case + '-1.npz')
        hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        data = stack.enter_context(np.load(path))
        assert set(data.files) == set(originals[0].files)
        assert all(len(data[key]) == 60 and np.isfinite(data[key]).all() for key in data.files)
        statistics = spread_report(originals, [data])
        outside = {key: value for key, value in statistics.items() if value['substeps_within_spread'] != 60}
        rows.append({'index': index, 'backend': backend, 'within_existing_fixed_C8': not outside,
                     'outside_fields': list(outside), 'statistics': statistics})
for path, sha in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == sha, path
record = {'cases': rows, 'input_sha256': hashes, 'new_runs_added_to_original_cohort': False,
          'fixed_source0_replaced': False, 'SDK_diagnostic_also_outside_existing_C8': not rows[0]['within_existing_fixed_C8'],
          'fixed_C8_reclassified': False, 'GPU_used': False, 'whole_solver_complete': False}
(BASE / 'definition-trajectory-audit.json').write_text(json.dumps(record, indent=2) + '\n')
print('Existing C8 for independent diagnostics:', [(row['backend'], row['within_existing_fixed_C8']) for row in rows])
