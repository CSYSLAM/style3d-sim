"""Prepare the complementary stages with the exact completed full-replay transport and unchanged fixed frames."""
import ast
from collections import Counter
import difflib
import hashlib
import json
from pathlib import Path
import re
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.pd_contact_full_replay import KINDS

full = json.loads((BASE / 'full-input-replays/report.json').read_text())
assert full['complete'] and full['actual_calls'] == 6336 and full['strict_packets'] == 2112
layout_path = BASE / 'tangent-captures/0/tangent-graph-0/snapshot-layout.json'
layout = json.loads(layout_path.read_text())
remaining = {stage['kind'] for stage in layout['stages']} - KINDS
counts = Counter(stage['kind'] for stage in layout['stages'] if stage['kind'] in remaining)
assert sum(counts.values()) == 81 and len(remaining) == 11
base = ROOT / 'reconstruction/csrc/pd_contact_full_replay.py'
text = base.read_text()
assignment = next(node for node in ast.parse(text).body
                  if isinstance(node, ast.Assign) and any(isinstance(t, ast.Name) and t.id == 'KINDS'
                                                         for t in node.targets))
lines = text.splitlines(keepends=True)
replacement = 'KINDS = {\n' + ''.join('    ' + repr(kind) + ',\n' for kind in sorted(remaining)) + '}\n'
text = ''.join(lines[:assignment.lineno - 1]) + replacement + ''.join(lines[assignment.end_lineno:])
for old, new in ((132, 81), (2112, 1296), (6336, 3888)):
    text = re.sub(r'\b' + str(old) + r'\b', str(new), text)
text = text.replace('full-input-replays', 'remaining-input-replays')
text = text.replace('every newly captured contact/tangent stage', 'every complementary RHS/preconditioner/CG stage')
target = BASE / 'remaining-replays-as-run.py'
audit_base = BASE / 'audit-replays.py'
audit = audit_base.read_text().replace('full-input-replays', 'remaining-input-replays')
audit = audit.replace('replay-independent-cpu-audit.json', 'remaining-independent-cpu-audit.json')
for old, new in ((2112, 1296), (6336, 3888)):
    audit = re.sub(r'\b' + str(old) + r'\b', str(new), audit)
audit_target = BASE / 'audit-remaining-replays.py'
for path, content in ((target, text), (audit_target, audit)):
    assert not path.exists()
    ast.parse(content)
    assert all(len(line) <= 128 for line in content.splitlines()), path
    path.write_text(content)
    diff = difflib.unified_diff((base if path == target else audit_base).read_text().splitlines(True),
                                content.splitlines(True), fromfile=str(base if path == target else audit_base),
                                tofile=str(path))
    path.with_suffix('.diff').write_text(''.join(diff))
paths = [Path(__file__), base, audit_base, target, audit_target, layout_path, BASE / 'full-input-replays/report.json']
record = {'complementary_stage_counts': dict(counts), 'fixed_frames': [0, 31, 32, 59],
          'packets_planned': 1296, 'calls_planned': 3888,
          'transport_reused_from_completed_strict_2112_packet_batch': True,
          'changes': ['complementary KINDS', 'packet and call counts', 'separate output names and log messages'],
          'solver_math_changed': False, 'frozen_failure_replaced': False, 'whole_solver_complete': False,
          'input_sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
(BASE / 'remaining-preflight.json').write_text(json.dumps(record, indent=2) + '\n')
print('Remaining81 stages/frame;1296 complete packets and3888 same-input calls planned;solver math unchanged')
