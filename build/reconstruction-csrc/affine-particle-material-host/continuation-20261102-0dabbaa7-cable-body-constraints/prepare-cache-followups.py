"""Version identical validation budgets for the observed cache fix; preserve the earlier candidate and failure."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
jobs = [
    ('run-cases.py', 'run-cases-cache-order.py', [
        ("args.stage + '-v2-'", "args.stage + '-cache-order-v2-'"),
    ]),
    ('check-constructors.py', 'check-constructors-cache-order.py', [
        ("candidate-scope-only/build.json", "candidate-cache-order/build.json"),
        ("candidate-v2-3/status.json", "candidate-cache-order-v2-3/status.json"),
        ("constructors-scope-only", "constructors-cache-order"),
    ]),
    ('run-graph60.py', 'run-graph60-cache-order.py', [
        ("candidate-scope-only/build.json", "candidate-cache-order/build.json"),
        ("candidate-v2-3/status.json", "candidate-cache-order-v2-3/status.json"),
        ("BASE / 'graph60'", "BASE / 'graph60-cache-order'"),
    ]),
]
rows = []
for previous, next_name, changes in jobs:
    source = BASE / previous
    text = source.read_text()
    for old, new in changes:
        count = text.count(old)
        assert count > 0, old
        text = text.replace(old, new)
    compile(text, next_name, 'exec')
    assert max(map(len, text.splitlines())) <= 128
    target = BASE / next_name
    assert not target.exists()
    target.write_text(text)
    rows.append({'source': str(source), 'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                 'target': str(target), 'target_sha256': hashlib.sha256(target.read_bytes()).hexdigest(),
                 'changes': changes})
(BASE / 'cache-validation-versions.json').write_text(json.dumps({
    'versions': rows, 'only_candidate_and_output_locations_changed': True,
    'frames_cases_thresholds_and_budgets_unchanged': True, 'production_modified': False,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Prepared same24 short cases, six constructor classes and96 graph60 comparisons for cache fix')
