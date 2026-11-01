"""Run the first-joint operand proof, actual SDK isolation and GPU scalar witnesses in sequence."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, PARENT = Path.cwd(), Path(__file__).resolve().parent
BASE = PARENT / 'atomic'
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

plan = json.loads((BASE / 'plan.json').read_text())
path = BASE / 'run.status.json'
assert not path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}
for label, command, gpu in [
    ('probe', [sys.executable, '-m', 'reconstruction.csrc.g1_first_joint_probe', '--phase', str(BASE)], True),
    ('probe-independent-cpu-audit', [sys.executable, str(PARENT / 'probe-independent-cpu-audit.py')], False),
    ('prepare-followup', [sys.executable, str(PARENT / 'prepare-followup.py')], False),
    ('isolation', [sys.executable, str(BASE / 'isolation-wrapper.py'),
                   '--capture', str(BASE), '--output', str(BASE / 'isolation')], True),
    ('certificates', [sys.executable, str(BASE / 'certificates-wrapper.py'),
                      '--capture', str(BASE), '--output', str(BASE / 'certificates')], True),
    ('atomic-followup-cpu-audit', [sys.executable, str(BASE / 'atomic-followup-cpu-audit.py')], False),
]:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if gpu:
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            path.write_text(json.dumps(status, indent=2) + '\n')
            if not live:
                break
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(5)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        path.write_text(json.dumps(status, indent=2) + '\n')
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    path.write_text(json.dumps(status, indent=2) + '\n')
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
status['complete'] = True
path.write_text(json.dumps(status, indent=2) + '\n')
