"""Freeze the completed diagnostic batch, preserving strict failures and all earlier preparation artifacts."""
import ast
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.g1_contact_rhs_replay import kernel_texts
from reconstruction.csrc.library_entries import entries

output = BASE / 'completion-manifest.json'
assert not output.exists()
capture = json.loads((BASE / 'tangent-captures/status.json').read_text())
pipeline = json.loads((BASE / 'pipeline-status.json').read_text())
assert capture['complete'] and pipeline['complete'] and len(capture['completed']) == 4
assert all(row['actual_exit'] == 0 for row in capture['completed'] + pipeline['completed'])
for pid in (3118261, 3167336, *(row['pid'] for row in capture['completed'])):
    path = Path('/proc') / str(pid) / 'cmdline'
    assert not path.exists() or 'pd-tangent-full' not in path.read_bytes().decode(errors='replace'), pid
proofs = ['tangent-independent-cpu-audit.json', 'extra-flow-independent-cpu-audit.json',
          'replay-independent-cpu-audit.json', 'remaining-independent-cpu-audit.json',
          'reduction-independent-cpu-audit.json', 'first-difference-bridge.json',
          'static-proof.json', 'static-read-coverage.json']
for name in proofs:
    data = json.loads((BASE / name).read_text())
    for path, expected in data['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
full = json.loads((BASE / 'full-input-replays/report.json').read_text())
remaining = json.loads((BASE / 'remaining-input-replays/report.json').read_text())
reduction = json.loads((BASE / 'reduction-independent-cpu-audit.json').read_text())
assert full['complete'] and full['actual_calls'] == 6336 and full['strict_packets'] == 2112
assert remaining['complete'] and remaining['actual_calls'] == 3888 and remaining['strict_packets'] == 1165
assert reduction['metrics']['cases'] == 131 and reduction['metrics']['actual_calls'] == 1048
assert len(json.loads((BASE / 'first-difference-bridge.json').read_text())['rows']) == 3
read_proofs = json.loads((BASE / 'static-read-coverage.json').read_text())
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
header_path = ROOT / 'build/reconstruction-csrc/host-particles/source_ptx_bundle.h'
build = json.loads(build_path.read_text())
texts_by_name, entry_count = {}, 0
for row in read_proofs['proofs']:
    if row['name'] not in texts_by_name:
        texts_by_name[row['name']] = kernel_texts(build, row['name'])[0]
    entry = entries(texts_by_name[row['name']][row['side']])[row['name']]
    assert hashlib.sha256(entry.encode()).hexdigest() == row['global_read_base_proof']['actual_entry_sha256']
    entry_count += 1
assert entry_count == 46
binding = {'actual_entries_checked': entry_count, 'GPU_used': False,
           'source_bundle_sha256': hashlib.sha256(header_path.read_bytes()).hexdigest(),
           'read_proof_sha256': hashlib.sha256((BASE / 'static-read-coverage.json').read_bytes()).hexdigest()}
(BASE / 'read-proof-entry-binding-check.json').write_text(json.dumps(binding, indent=2) + '\n')
receipts = {'recorded_UTC': datetime.now(timezone.utc).isoformat(), 'reported_from_actual_tool_terminal_results': True,
            'runs': [{'script': 'run-tangent.py', 'session': 12388, 'actual_exit': 0},
                     {'script': 'run-pipeline.py', 'session': 81124, 'actual_exit': 0},
                     {'script': 'static-read-coverage.py', 'session': 98631, 'actual_exit': 0},
                     {'script': 'run-remaining-replays.py --phase <this phase> --prepare',
                      'session': 49615, 'actual_exit': 0},
                     {'script': 'run-remaining-replays.py --phase <this phase> --execute',
                      'session': 52924, 'actual_exit': 1, 'runtime_error': None, 'strict_difference_packets': 131},
                     {'script': 'audit-remaining-replays.py', 'session': 80352, 'actual_exit': 0},
                     {'script': 'python -m reconstruction.csrc.pd_contact_reduction_replay --phase <this phase> --prepare',
                      'terminal_tool_chunk': '840384', 'actual_exit': 0},
                     {'script': 'python -m reconstruction.csrc.pd_contact_reduction_replay --phase <this phase> --execute',
                      'session': 4793, 'actual_exit': 0},
                     {'script': 'audit-reduction-differences.py', 'session': 91470, 'actual_exit': 0},
                     {'script': 'audit-first-difference-bridge.py', 'terminal_tool_chunk': '4e6b56', 'actual_exit': 0}]}
(BASE / 'execution-receipts.json').write_text(json.dumps(receipts, indent=2) + '\n')
paths = sorted(p for p in BASE.rglob('*') if p.is_file() and '__pycache__' not in p.parts and p.suffix != '.pyc')
for path in [*paths, ROOT / 'reconstruction/csrc/pd_contact_reduction_replay.py']:
    if path.suffix == '.py':
        ast.parse(path.read_text())
        assert all(len(line) <= 128 for line in path.read_text().splitlines()), path
files = {str(p.relative_to(ROOT)): {'bytes': p.stat().st_size,
         'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths}
assert all(v['bytes'] < 100 * 1024 * 1024 for v in files.values())
record = {'files': files, 'phase_open': False, 'stage_packets_captured': 51120,
          'fixed_replay_frames': [0, 31, 32, 59], 'unmodified_calls': 10224, 'strict_packets': 3277,
          'reduction_difference_packets_preserved': 131, 'reduction_diagnostic_calls': 1048,
          'complete_joint_GPU_scalar_vectors': 262, 'old_failure_reclassified': False,
          'candidate_promoted': False, 'production_changed': False, 'whole_solver_complete': False}
output.write_text(json.dumps(record, indent=2) + '\n')
print('Frozen complete PD diagnostic batch:', len(files), 'files;3277 strict/131 reduction-witness packets;ready remainsFalse')
