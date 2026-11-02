"""Freeze the completed body-block replays and CPU propagation evidence with actual tool receipts."""
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'body-evidence-manifest.json'
assert not OUTPUT.exists()
status = json.loads((BASE / 'operator-status-v2.json').read_text())
assert status['complete'] and status['strict_packets'] == 198
assert all(row['actual_exit'] == 0 for row in status['completed'])
audit = json.loads((BASE / 'replay-independent-cpu-audit.json').read_text())
assert audit['strict_packets'] == audit['packets'] == 198 and not audit['failures']
assert audit['counts']['actual_calls'] == 594
flow = json.loads((BASE / 'propagation-independent-cpu-v2.json').read_text())
assert flow['owned_metadata_equal'] and len(flow['comparisons']) == 243
assert len(flow['workers']) == 2 and all(w['stages'] == 243 and w['snapshots'] == 2106 for w in flow['workers'])
for report in (audit, flow):
    for name, expected in report['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
previous = BASE.parent / 'continuation-20261101-7ca67172-driven-self-surface-scale/evidence-manifest.json'
for name, row in json.loads(previous.read_text())['files'].items():
    raw = (ROOT / name).read_bytes()
    assert len(raw) == row['bytes'] and hashlib.sha256(raw).hexdigest() == row['sha256'], name
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or '__pycache__' in path.parts or path.suffix in ('.pyc', '.tmp'):
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
record = {'files': files, 'previous_manifest_sha256': hashlib.sha256(previous.read_bytes()).hexdigest(),
          'strict_packets': 198, 'actual_three_backend_calls': 594, 'independent_CPU_actual_exit': 0,
          'corrected_operator_root_actual_exit': 0, 'first_operator_root_actual_exit': 1,
          'propagation_v1_actual_exit': 1, 'propagation_v2_actual_exit': 0,
          'paired_context_stages': 243, 'snapshots_per_worker': 2106,
          'producer_consumer_links_per_worker': [sum(w['links'].values()) for w in flow['workers']],
          'first_body_inverse_equal': True, 'first_CG_residual_already_differs': True,
          'new_capture_particle_qd_max_abs': flow['public_states']['particle_qd']['max_abs_difference'],
          'old_fixed_failures_reclassified': False, 'candidate_promoted': False,
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen completed body-block evidence:', len(files), 'files;198/198 strict,594 calls', flush=True)
