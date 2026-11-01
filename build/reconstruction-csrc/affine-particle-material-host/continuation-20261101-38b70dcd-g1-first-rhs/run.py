"""Collect the two fixed prefix traces and replay them once, recording every actual child exit."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env

plan = json.loads((BASE / 'plan.json').read_text())
status_path = BASE / 'run.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name


def wait_gpu():
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
        dump()
        if not live:
            return
        print('Waiting for observed GPU processes:', live, flush=True)
        time.sleep(5)


def execute(label, command):
    verify()
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': label, 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': label, 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False}, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)


dump()
for run in plan['runs']:
    wait_gpu()
    execute(run['label'], [sys.executable, '-m', 'reconstruction.csrc.g1_first_rhs',
                          '--backend', run['backend'], '--plan', str(BASE / 'plan.json'),
                          '--output', str(BASE / run['label'])])
status['complete'] = True
dump()
status_path = BASE / 'followup.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}
dump()
execute('independent-cpu-audit', [sys.executable, str(BASE / 'independent-cpu-audit.py')])
wait_gpu()
execute('replay', [sys.executable, '-m', 'reconstruction.csrc.g1_first_rhs', '--phase', str(BASE), '--replay'])
execute('replay-independent-cpu-audit', [sys.executable, '-m', 'reconstruction.csrc.g1_first_rhs',
                                       '--phase', str(BASE), '--audit'])
status['complete'] = True
dump()
