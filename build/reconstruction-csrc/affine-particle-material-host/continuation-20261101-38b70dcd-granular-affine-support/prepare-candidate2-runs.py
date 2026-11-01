"""Pin the compiled isolated candidate and existing SDK evidence before running the four source cases."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
build = json.loads((BASE / 'candidate2/build.json').read_text())
baseline = json.loads((BASE / 'plan.json').read_text())
hashes = dict(baseline['input_sha256'])
hashes.update(build['input_sha256'])
paths = [BASE / p for p in ('candidate2/build.json', 'candidate2/plan.json', 'candidate2-worker.py', 'run-candidate2.py',
                           'candidate2-independent-cpu-audit.py', 'independent-cpu-audit-v2.json', 'audit-revision.json')]
paths.append(Path(build['image']))
for folder in BASE.glob('original-*'):
    paths.extend(p for p in folder.iterdir() if p.is_file())
paths.append(Path(__file__))
for p in paths:
    hashes[str(p)] = hashlib.sha256(p.read_bytes()).hexdigest()
for name, digest in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
for p in [BASE / n for n in ('candidate2-worker.py', 'run-candidate2.py', 'candidate2-independent-cpu-audit.py',
                             'prepare-candidate2-runs.py', 'build-candidate2.py')]:
    ast.parse(p.read_text())
    assert all(len(line) <= 128 for line in p.read_text().splitlines()), str(p)
runs = [{**run, 'label': run['label'].replace('source-', 'candidate2-', 1)}
        for run in baseline['runs'] if run['backend'] == 'source']
plan = {**baseline, 'input_sha256': hashes, 'runs': runs, 'image_sha256': build['image_sha256'],
        'production_changed': False, 'trial_not_promoted': True, 'whole_solver_complete': False}
path = BASE / 'candidate2-run-plan.json'
assert not path.exists() and len(runs) == 4
path.write_text(json.dumps(plan, indent=2) + '\n')
print('Frozen four source candidate cases against unchanged SDK captures', flush=True)
