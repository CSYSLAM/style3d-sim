"""Run the unchanged cable bend stiffness demo against fixed SDK and current source, with serial idle gates."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
import numpy as np
from reconstruction.demo_ab import compare

EXAMPLE = ROOT / 'examples/cable/example_cable_bend_stiffness.py'
REFERENCE = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
SOURCE = ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
expected = {str(REFERENCE): '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63',
            str(SOURCE): '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'}
for path in [EXAMPLE, ROOT / 'examples/cable/cable_utils.py', ROOT / 'reconstruction/csrc/demo_source_ab.py',
             ROOT / 'reconstruction/csrc/native/source_solver.cpp', Path(__file__)]:
    expected[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
status = {'complete': False, 'frames': 60, 'substeps_per_frame': 10, 'completed': [], 'GPU_waits': [],
          'input_sha256': expected, 'production_changed': False, 'whole_solver_complete': False}
OUTPUT = BASE / 'status.json'
assert not OUTPUT.exists()
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env['PYTHONPATH'] = str(ROOT)


def save():
    OUTPUT.write_text(json.dumps(status, indent=2) + '\n')


save()
for mode in ('synreal', 'pd'):
    directory = BASE / mode
    directory.mkdir(exist_ok=False)
    rows = []
    for side in ('original', 'source'):
        for name, digest in expected.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'mode': mode, 'backend': side, 'compute_apps': live, 'epoch': time.time()})
            save()
            if not live:
                break
            time.sleep(5)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', side, '--tag', side,
                   '--example', str(EXAMPLE), '--frames', '60', '--output', str(directory), '--', '--solver', mode]
        (directory / (side + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (directory / (side + '.log')).open('w') as log:
            child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            code = child.wait()
        row = {'mode': mode, 'backend': side, 'pid': child.pid, 'actual_exit': code,
               'capture_exists': (directory / (side + '.npz')).exists()}
        status['completed'].append(row)
        rows.append(row)
        save()
        print(mode, side, 'actual exit', code, flush=True)
    result = {'workers': rows, 'default_material_and_solver_profiles_unchanged': True,
              'frames': 60, 'full_8_second_settling_test_run': False, 'whole_solver_complete': False}
    if all(row['actual_exit'] == 0 and row['capture_exists'] for row in rows):
        with np.load(directory / 'original.npz', allow_pickle=False) as left:
            with np.load(directory / 'source.npz', allow_pickle=False) as right:
                result['strict_comparison'] = compare(left, right)
    (directory / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
status['complete'] = True
save()
print('Cable bend60 eager-frame diagnostic finished;per-mode reports preserve failures', flush=True)
