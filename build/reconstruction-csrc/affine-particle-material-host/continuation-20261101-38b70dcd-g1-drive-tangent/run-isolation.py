"""Run the predeclared30960 actual SDK/PTX/source single-drive arithmetic comparisons."""
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
assert json.loads((base / 'replay.status.json').read_text())['exit'] == 0
command = [sys.executable, '-m', 'reconstruction.csrc.g1_drive_tangent_isolated',
           '--capture', str(base), '--output', str(base / 'isolation')]
(base / 'isolation.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (base / 'isolation.log').open('w') as log:
    code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
(base / 'isolation.status.json').write_text(json.dumps({'exit': code, 'complete': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Drive tangent isolation terminal exit:', code, flush=True)
raise SystemExit(code)
