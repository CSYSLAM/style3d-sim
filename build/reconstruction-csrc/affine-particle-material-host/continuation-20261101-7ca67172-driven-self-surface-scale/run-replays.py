"""Replay the four fixed surface-scale packets serially, checking GPU idleness and preserving actual worker exits."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
OUTPUT = BASE / 'replays'
OUTPUT.mkdir(exist_ok=False)
hashes = dict(plan['input_sha256'])
for path in (Path(__file__), BASE / 'replay-worker.py', BASE / 'plan.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for row in plan['packets']:
    for path in Path(row['capture']).iterdir():
        assert path.is_file()
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
(OUTPUT / 'plan.json').write_text(json.dumps({'jobs': plan['packets'], 'input_sha256': hashes,
    'operation': 'stiffness', 'old_fixed_samples_replaced': False, 'candidate_promoted': False,
    'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'error': None,
          'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}


def save():
    path = OUTPUT / 'status.json.tmp'
    path.write_text(json.dumps(status, indent=2) + '\n')
    path.replace(OUTPUT / 'status.json')


def verify():
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name


save()
try:
    for row in plan['packets']:
        verify()
        while True:
            apps = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': apps})
            save()
            if not apps:
                break
            time.sleep(5)
        directory = OUTPUT / str(row['worker'])
        command = [sys.executable, str(BASE / 'replay-worker.py'), '--capture', row['capture'],
                   '--output', str(directory), '--operation', 'stiffness']
        (OUTPUT / (str(row['worker']) + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (OUTPUT / (str(row['worker']) + '.log')).open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {**row, 'pid': process.pid}
            save()
            code = process.wait()
        status['completed'].append({**row, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        save()
        print('Surface-scale worker', row['worker'], 'actual exit', code, flush=True)
        verify()
    status['complete'] = True
except BaseException as error:
    status['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    save()
raise SystemExit(int(any(row['actual_exit'] != 0 for row in status['completed'])))
