"""Control the first failed SDK capture with launch logging but without any intermediate-buffer reads."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
case = plan['cases'][0]
folder = BASE / 'no-dump-control'
folder.mkdir(exist_ok=False)
fixture = ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
assert hashlib.sha256(fixture.read_bytes()).hexdigest() == plan['input_sha256'][str(fixture)]
assert not subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
env.update(LD_PRELOAD=str(hook), CUDAHOOK_DIR=str(folder), GRANULAR_AFFINE_MODEL_OUTPUT=str(folder))
command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'original', '--tag', 'capture',
           '--example', str(fixture), '--frames', '3', '--output', str(folder), '--', *case['extra']]
(folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
with (folder / 'run.log').open('w') as log:
    code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT).returncode
record = {'actual_exit': code, 'same_fixture_and_case': True, 'buffer_dumping_enabled': False,
          'launch_logging_enabled': True, 'whole_solver_complete': False}
(folder / 'report.json').write_text(json.dumps(record, indent=2) + '\n')
assert code == 0
with np.load(folder / 'capture.npz', allow_pickle=False) as arrays:
    assert arrays['particle_q'].shape == (3, 12, 3)
    assert all(np.isfinite(arrays[key]).all() for key in arrays.files)
print('No-dump SDK control: actual exit0, three steps finite')
