"""Run every predeclared scalar target after the uninstrumented kernel replay has terminated."""
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
assert json.loads((base / 'replay.status.json').read_text())['exit'] == 0
command = [sys.executable, '-m', 'reconstruction.csrc.g1_last_matrix_certificates',
           '--capture', str(base), '--output', str(base / 'certificates')]
(base / 'certificates.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (base / 'certificates.log').open('w') as log:
    code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
(base / 'certificates.status.json').write_text(json.dumps({'exit': code, 'complete': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Final-matrix certificates terminal exit:', code, flush=True)
raise SystemExit(code)
