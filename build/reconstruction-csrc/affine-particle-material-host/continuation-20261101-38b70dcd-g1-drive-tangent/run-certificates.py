"""Verify every closed scalar target with authentic pre-call bytes and actual GPU F32 atomic operations."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

root = Path.cwd()
sys.path.insert(0, str(root))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

base = Path(__file__).resolve().parent
assert json.loads((base / 'isolation.status.json').read_text())['exit'] == 0
proof = json.loads((base / 'isolation/report.json').read_text())
assert proof['calls'] == 30960 and proof['all_actual_SDK_isolated_outputs_match_real_PTX_lane_operands']
runner = root / 'reconstruction/csrc/g1_drive_tangent_certificates.py'
(base / 'certificate-runner.json').write_text(json.dumps({'runner_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
    'plan_sha256': hashlib.sha256((base / 'certification-plan.json').read_bytes()).hexdigest(),
    'whole_solver_complete': False}, indent=2) + '\n')
command = [sys.executable, '-m', 'reconstruction.csrc.g1_drive_tangent_certificates',
           '--capture', str(base), '--output', str(base / 'certificates')]
(base / 'certificates.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (base / 'certificates.log').open('w') as log:
    code = subprocess.run(command, cwd=root, env=clean_env(), stdout=log, stderr=subprocess.STDOUT, timeout=1800).returncode
(base / 'certificates.status.json').write_text(json.dumps({'exit': code, 'complete': True,
    'whole_solver_complete': False}, indent=2) + '\n')
print('Drive tangent certificates terminal exit:', code, flush=True)
raise SystemExit(code)
