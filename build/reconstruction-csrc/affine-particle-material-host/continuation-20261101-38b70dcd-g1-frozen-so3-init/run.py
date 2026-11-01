"""Wait for actual GPU availability, then run the frozen SO3 kernel comparison and independent CPU audit once."""
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
state_path = BASE / 'run.status.json'
assert not state_path.exists() and not (BASE / 'execute.status.json').exists()
plan = json.loads((BASE / 'plan.json').read_text())
state = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}
state_path.write_text(json.dumps(state, indent=2) + '\n')
commands = [
    ('execute', [sys.executable, '-m', 'reconstruction.csrc.g1_frozen_so3_initialization',
                 '--phase', str(BASE), '--execute']),
    ('independent-cpu-audit', [sys.executable, str(BASE / 'independent-cpu-audit.py')]),
]
for label, command in commands:
    for path, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path
    if label == 'execute':
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            state['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            state_path.write_text(json.dumps(state, indent=2) + '\n')
            if not live:
                break
            print('Waiting for observed GPU processes:', live, flush=True)
            time.sleep(10)
    (BASE / (label + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (BASE / (label + '.log')).open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT)
        state['running'] = {'step': label, 'pid': process.pid, 'started_UTC': datetime.now(timezone.utc).isoformat()}
        state_path.write_text(json.dumps(state, indent=2) + '\n')
        code = process.wait()
    (BASE / (label + '.status.json')).write_text(json.dumps({
        'actual_exit': code, 'complete': code == 0, 'whole_solver_complete': False,
    }, indent=2) + '\n')
    state['completed'].append({'step': label, 'pid': process.pid, 'actual_exit': code})
    state['running'] = None
    state_path.write_text(json.dumps(state, indent=2) + '\n')
    print(label, 'actual exit', code, flush=True)
    assert code == 0, (label, code)
state['complete'] = True
state_path.write_text(json.dumps(state, indent=2) + '\n')
