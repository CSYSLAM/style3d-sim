"""Run the frozen SDK isolation, GPU scalar certificates and independent CPU audit in sequence."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path.cwd()
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

BASE = Path(__file__).resolve().parent
status_path = BASE / 'atomic-followup.status.json'
assert not status_path.exists(), 'Do not restart a live or completed followup'
plan = json.loads((BASE / 'isolation-plan.json').read_text())
status = {'complete': False, 'running': None, 'completed': [], 'whole_solver_complete': False}
commands = [
    ('isolation', [sys.executable, '-m', 'reconstruction.csrc.g1_joint_rhs_isolated',
                   '--capture', str(BASE), '--output', str(BASE / 'isolation')]),
    ('certificates', [sys.executable, '-m', 'reconstruction.csrc.g1_joint_rhs_certificates',
                      '--capture', str(BASE), '--output', str(BASE / 'certificates')]),
    ('atomic-followup-cpu-audit', [sys.executable, str(BASE / 'atomic-followup-cpu-audit.py')]),
]
for label, command in commands:
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    if label != 'atomic-followup-cpu-audit':
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not live:
                break
            print('Waiting for observed live GPU processes:', live, flush=True)
            time.sleep(10)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'step': label, 'pid': process.pid,
                             'started_UTC': datetime.now(timezone.utc).isoformat()}
        status_path.write_text(json.dumps(status, indent=2) + '\n')
        code = process.wait()
    status['completed'].append({'step': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    status_path.write_text(json.dumps(status, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
status['complete'] = True
status_path.write_text(json.dumps(status, indent=2) + '\n')
