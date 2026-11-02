"""Replay both actual first-surface packets in both failing cases; keep the fixed failures intact."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
capture = BASE / 'first-surface-inputs'
assert json.loads((capture / 'status.json').read_text())['complete']
plan = json.loads((capture / 'plan.json').read_text())
out = BASE / 'first-surface-replays'
out.mkdir(exist_ok=False)
hashes = dict(plan['input_sha256'])
for path in (Path(__file__), BASE / 'surface-replay-worker.py',
             ROOT / 'reconstruction/csrc/surface_common_input_replay.py',
             ROOT / 'reconstruction/csrc/surface_atomic_operands.py'):
    hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
(out / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'cases': plan['cases'],
    'isolated_and_full_same_input_replays': True, 'frozen_failure_reclassified': False,
    'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}


def dump():
    (out / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in plan['cases']:
    for backend in ('original', 'source'):
        for name, expected in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            if not live:
                break
            status['GPU_waits'].append(live)
            dump()
            time.sleep(5)
        directory = out / case['name'] / backend
        directory.parent.mkdir(parents=True, exist_ok=True)
        command = [sys.executable, str(BASE / 'surface-replay-worker.py'), '--capture',
                   str(capture / case['name'] / backend), '--output', str(directory)]
        log_path = directory.parent / (backend + '.log')
        with log_path.open('w') as log:
            worker = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['name'], 'backend': backend, 'pid': worker.pid}
            dump()
            code = worker.wait()
        status['completed'].append({**status['running'], 'actual_exit': code})
        status['running'] = None
        dump()
        print(case['name'], backend, 'replay actual exit', code, flush=True)
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status['complete'] = True
dump()
raise SystemExit(int(any(row['actual_exit'] != 0 for row in status['completed'])))
