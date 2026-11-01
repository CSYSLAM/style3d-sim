"""Verify the dimension rename is the only replay change and retain all600 original capture hashes."""
import hashlib
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
OLD = BASE / 'replay-variable-v1-error'
before = (OLD / 'replay-template.py').read_text()
changes = [
    ('grid, lanes =', 'grid, trace_lanes ='),
    ('np.zeros((lanes, TRACE_RECORDS, 16)', 'np.zeros((trace_lanes, TRACE_RECORDS, 16)'),
    ("np.zeros(lanes, dtype='u4')", "np.zeros(trace_lanes, dtype='u4')"),
    ("'trace_lanes': lanes,", "'trace_lanes': trace_lanes,"),
]
for old, new in changes:
    assert before.count(old) == 1
    before = before.replace(old, new)
assert before == (BASE / 'replay-template.py').read_text()
old_plan = json.loads((OLD / 'plan.json').read_text())
new_plan = json.loads((BASE / 'plan.json').read_text())
assert old_plan.keys() == new_plan.keys()
assert all(old_plan[key] == new_plan[key] for key in old_plan if key != 'input_sha256')
changed = {name for name, old in old_plan['input_sha256'].items() if new_plan['input_sha256'][name] != old}
assert len(changed) == 2 and any(name.endswith('/g1_drive_state_replay.py') for name in changed)
assert any(name.endswith('/replay-template.py') for name in changed)
closed = json.loads((BASE / 'closed-packets.json').read_text())
for name, expected in closed['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
report = {'only_changed_input_pins': sorted(changed), 'exact_template_changes': changes,
          'capture_plan_sha256': hashlib.sha256((OLD / 'plan.json').read_bytes()).hexdigest(),
          'revised_replay_plan_sha256': hashlib.sha256((BASE / 'plan.json').read_bytes()).hexdigest(),
          'all600_capture_packets_unchanged': True, 'production_changed': False, 'whole_solver_complete': False}
output = BASE / 'replay-revision.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print('Only the trace dimension rename changed; all600 actual captured packets remain unchanged', flush=True)
