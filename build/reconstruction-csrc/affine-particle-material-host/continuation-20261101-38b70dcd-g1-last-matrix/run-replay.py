"""Run the predeclared final-matrix replay after both capture processes have terminated."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
frozen = json.loads((base / 'capture-files-and-replay-source.json').read_text())
for name, entry in frozen['files'].items():
    path = Path(name)
    assert path.stat().st_size == entry['bytes'] and hashlib.sha256(path.read_bytes()).hexdigest() == entry['sha256']
runner = root / 'reconstruction/csrc/g1_last_matrix_replay.py'
assert hashlib.sha256(runner.read_bytes()).hexdigest() == frozen['replay_runner_sha256']
command = [sys.executable, '-m', 'reconstruction.csrc.g1_last_matrix_replay',
           '--capture', str(base), '--output', str(base / 'replay')]
(base / 'replay.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (base / 'replay.log').open('w') as log:
    code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
(base / 'replay.status.json').write_text(json.dumps({'exit': code, 'complete': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Final-matrix replay terminal exit:', code, flush=True)
raise SystemExit(code)
