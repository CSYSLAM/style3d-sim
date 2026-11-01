"""Compare the isolated source candidate to fixed actual SDK states, full buffers and complete launch metadata."""
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

plan = json.loads((BASE / 'candidate-run-plan.json').read_text())
for name, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
status = json.loads((BASE / 'candidate.run.status.json').read_text())
assert status['complete'] and status['running'] is None
assert [r['label'] for r in status['completed']] == [r['label'] for r in plan['runs']]
schema = schemas()[0]
rows = []
for run, terminal in zip(plan['runs'], status['completed'], strict=True):
    folder, reference = BASE / run['label'], BASE / run['label'].replace('candidate-', 'original-', 1)
    row = {'label': run['label'], 'actual_exit': terminal['actual_exit'], 'passed': False}
    if terminal['actual_exit'] == 0:
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == plan['image_sha256']
        old_runtime = json.loads((reference / 'capture.runtime.json').read_text())
        assert runtime['example_sha256'] == old_runtime['example_sha256']
        assert runtime['extra'] == old_runtime['extra'] and runtime['frames'] == old_runtime['frames']
        with np.load(folder / 'model-before.npz', allow_pickle=False) as left, \
                np.load(reference / 'model-before.npz', allow_pickle=False) as right:
            assert set(left.files) == set(right.files) and all(left[k].tobytes() == right[k].tobytes() for k in left.files)
        with np.load(folder / 'capture.npz', allow_pickle=False) as source, \
                np.load(reference / 'capture.npz', allow_pickle=False) as original:
            row['states_finite'] = bool(all(np.isfinite(a[k]).all() for a in (source, original) for k in a.files))
            row['states'] = compare(original, source)
        row['metadata'] = compare_launches(reference / 'launches.txt', folder / 'launches.txt', schema)
        buffers = {}
        for token, sizes in plan['fields'].items():
            for i in sizes:
                for prefix in ('pre', 'post'):
                    name = 'dump_' + token + '_' + prefix + '_arg' + i + '.bin'
                    buffers[name] = (folder / name).read_bytes() == (reference / name).read_bytes()
        row['buffers'] = buffers
        counts = json.loads((folder / 'capture.launches.json').read_text())
        row['complete_owned_coverage'] = sum(counts.values()) == row['metadata']['right_launches']
        row['source_completed_without_reference_mapping_assertion_failure'] = 'demo_source_ab_complete' in \
            (folder / 'run.log').read_text()
        row['passed'] = bool(row['states_finite'] and row['states']['bitwise'] and row['metadata']['equal'] and
                             row['complete_owned_coverage'] and all(buffers.values()))
    else:
        row['exception_tail'] = (folder / 'run.log').read_text().splitlines()[-8:]
    rows.append(row)
output = BASE / 'candidate-independent-cpu-audit.json'
assert not output.exists()
output.write_text(json.dumps({'rows': rows, 'passed': sum(r['passed'] for r in rows), 'cases': len(rows),
                              'production_changed': False, 'trial_not_promoted': True,
                              'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({'cases': len(rows), 'passed': sum(r['passed'] for r in rows)}, indent=2))
