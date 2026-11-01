"""Freeze immutable preparation files only; leave the existing live GPU queue and mutable outputs untouched."""
import ast
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
output = BASE / 'preparation-manifest.json'
assert not output.exists()
static = json.loads((BASE / 'static-proof.json').read_text())
atomic = json.loads((BASE / 'atomic-access-proof.json').read_text())
assert len(static['proofs']) == 46 and len(atomic['proofs']) == 20
preflight = json.loads((BASE / 'CPU-preflight.json').read_text())
assert len(preflight['virtual_DAG_checks']) == 8 and preflight['preplanned_replay_frames'] == [0, 31, 32, 59]
plan = json.loads((BASE / 'tangent-captures/plan.json').read_text())
for name, expected in plan['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
names = ['CPU-preflight.json', 'capture-observer.py', 'tangent-worker.py', 'run-tangent.py',
         'static-proof.py', 'static-proof.json', 'static-proof.log', 'atomic-access-proof.py',
         'atomic-access-proof.json', 'atomic-access-proof.log', 'compare-graphs.py', 'model-normalizer.py',
         'run-audit.py', 'audit-as-run.py', 'audit-flow.py', 'audit-replays.py', 'run-pipeline.py',
         'capture-driver-receipt.json', 'tangent-captures/plan.json',
         'checkpoint-preparation.py', 'refresh-preparation-snapshot.py']
paths = [BASE / name for name in names]
for path in [*paths, ROOT / 'reconstruction/csrc/pd_contact_tangent_schema.py',
             ROOT / 'reconstruction/csrc/pd_contact_full_replay.py']:
    if path.suffix == '.py':
        ast.parse(path.read_text())
        assert all(len(line) <= 128 for line in path.read_text().splitlines()), path
files = {str(path.relative_to(ROOT)): {'bytes': path.stat().st_size,
         'sha256': hashlib.sha256(path.read_bytes()).hexdigest()} for path in paths}
assert all(entry['bytes'] < 100 * 1024 * 1024 for entry in files.values())
capture = json.loads((BASE / 'tangent-captures/status.json').read_text())
record = {'files': files, 'phase_open': True, 'checkpoint_kind': 'immutable preparation only',
          'checkpoint_UTC': datetime.now(timezone.utc).isoformat(), 'static_write_entries_checked': 46,
          'static_atomic_access_entries_checked': 20, 'capture_complete_when_checkpointed': capture['complete'],
          'completed_GPU_workers_when_checkpointed': len(capture['completed']),
          'GPU_runtime_validation_claimed': False, 'mutable_status_logs_and_GPU_outputs_not_included': True,
          'candidate_promoted': False, 'production_changed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen preparation:', len(files), 'immutable files;phase OPEN;GPU results not claimed')
