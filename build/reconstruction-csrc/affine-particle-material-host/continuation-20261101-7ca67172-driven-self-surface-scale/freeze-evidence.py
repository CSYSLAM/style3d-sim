"""Freeze finished driven-self evidence and fixed body-block inputs, excluding a live operator's mutable outputs."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PARENT = BASE.parent
SELF = PARENT / 'continuation-20261101-0dabbaa7-driven-cloth-self'
FLOW = PARENT / 'continuation-20261101-7ca67172-driven-self-flow'
REPLAY = PARENT / 'continuation-20261101-7ca67172-driven-self-replay'
BODY = PARENT / 'continuation-20261101-7ca67172-driven-self-body-block'
OUTPUT = BASE / 'evidence-manifest.json'
assert not OUTPUT.exists()
flow_status = json.loads((FLOW / 'linear-captures-v2/status.json').read_text())
assert flow_status['complete'] and len(flow_status['completed']) == 5
assert all(row['actual_exit'] == 0 for row in flow_status['completed'])
replay_status = json.loads((REPLAY / 'pipeline/status.json').read_text())
assert replay_status['complete'] and all(row['actual_exit'] == 0 for row in replay_status['completed'])
replay = json.loads((REPLAY / 'complete-input-replays/independent-cpu.json').read_text())
assert replay['metrics']['packets'] == replay['metrics']['strict_packets'] == 1188
assert replay['metrics']['calls'] == replay['metrics']['strict_calls'] == 3564
scale = json.loads((BASE / 'independent-cpu.json').read_text())
assert scale['isolated_three_backend_calls'] == 792 and scale['GPU_scalar_certificates'] == 155
scalar = json.loads((SELF / 'surface-scalar-certificates-isolated/independent-cpu-audit.json').read_text())
assert scalar['isolated_gate_satisfied'] and scalar['metrics']['actual_GPU_calls'] == 593
old_c8 = json.loads((SELF / 'short-fixed-C8/report.json').read_text())
assert len(old_c8['cases']) == 2 and all(row['sources_within_C8'] == [False] * 3 for row in old_c8['cases'])
for report in (replay, scale, scalar):
    for name, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
body_capture = json.loads((BODY / 'captures/status.json').read_text())
assert body_capture['complete'] and all(row['actual_exit'] == 0 for row in body_capture['completed'])
body_status = json.loads((BODY / 'operator-status.json').read_text())
body_pending = not body_status['complete']
if not body_pending:
    body_audit = json.loads((BODY / 'replay-independent-cpu-audit.json').read_text())
    assert body_audit['counts']['actual_calls'] == 594
paths = []
for scope in (SELF, FLOW, REPLAY, BASE, BODY):
    for path in sorted(scope.rglob('*')):
        if not path.is_file() or '__pycache__' in path.parts or path.suffix in ('.pyc', '.tmp'):
            continue
        relative = path.relative_to(scope)
        if scope == BODY and body_pending:
            if str(relative) in {'operator-status.json', 'operators-driver.log', 'three-backend-GPU.log',
                                  'independent-CPU.log'}:
                continue
            if relative.parts[:2] == ('full-input-replays', 'packets'):
                continue
            if str(relative) in {'full-input-replays/report.json', 'replay-independent-cpu-audit.json'}:
                continue
        paths.append(path)
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(row['bytes'] < 100 * 1024 * 1024 for row in files.values())
record = {'files': files, 'full_input_replay_packets_strict': 1188, 'full_input_replay_actual_calls': 3564,
          'scale_isolated_three_backend_calls': 792, 'scale_actual_GPU_scalar_certificates': 155,
          'prior_isolated_force_actual_GPU_scalar_calls': 593,
          'prior_root_tool_actual_exits': {str(k): None for k in (67261, 2752, 37865, 97272)},
          'prior_recorded_children_actual_exit_zero': True, 'two_old_fixed_C8_failures_retained': True,
          'body_block_operator_pending': body_pending, 'body_block_packets_prepared': 198,
          'body_block_calls_planned': 594, 'body_block_dynamic_claims_made': not body_pending,
          'mutable_body_outputs_excluded_while_live': body_pending,
          'production_changed': False, 'candidate_promoted': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen actual completed evidence:', len(files), 'files;body-block pending', body_pending, flush=True)
