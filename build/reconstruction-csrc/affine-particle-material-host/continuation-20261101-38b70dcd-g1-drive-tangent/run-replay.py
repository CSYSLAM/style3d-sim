"""Run all closed drive packets once with three uninstrumented backends and two operand probes."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
assert json.loads((base / 'status.json').read_text())['complete']
command = [sys.executable, '-m', 'reconstruction.csrc.g1_drive_tangent_replay',
           '--capture', str(base), '--output', str(base / 'replay')]
(base / 'replay.command.json').write_text(json.dumps(command, indent=2) + '\n')
(base / 'replay-source.json').write_text(json.dumps({'runner_sha256': hashlib.sha256(
    (root / 'reconstruction/csrc/g1_drive_tangent_replay.py').read_bytes()).hexdigest(),
    'packets': 120, 'uninstrumented_backends_per_packet': 3, 'probes_per_packet': 2,
    'actual_pre_call_accumulator': True, 'whole_solver_complete': False}, indent=2) + '\n')
with (base / 'replay.log').open('w') as log:
    code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
(base / 'replay.status.json').write_text(json.dumps({'exit': code, 'complete': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Drive tangent replay terminal exit:', code, flush=True)
raise SystemExit(code)
