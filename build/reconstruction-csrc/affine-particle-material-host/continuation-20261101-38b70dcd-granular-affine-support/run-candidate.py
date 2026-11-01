"""Run fixed real SDK discovery and source guard baselines serially, recording failures without early exit."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
plan = json.loads((BASE / 'candidate-run-plan.json').read_text())
status_path = BASE / 'candidate.run.status.json'
assert not status_path.exists()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_wait_observations': [], 'whole_solver_complete': False}


def dump():
    status_path.write_text(json.dumps(status, indent=2) + '\n')


def verify():
    for name, digest in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == digest, name


def wait_gpu():
    while True:
        value = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_wait_observations'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': value})
        dump()
        if not value:
            return
        print('Waiting for actual GPU processes:', value, flush=True)
        time.sleep(5)


dump()
for run in plan['runs']:
    verify()
    wait_gpu()
    folder = BASE / run['label']
    folder.mkdir(exist_ok=False)
    command = [sys.executable, str(BASE / 'candidate-worker.py'), '--worker', run['backend'],
               '--tag', 'capture', '--example', str(ROOT / 'reconstruction/csrc/granular_affine_scene.py'),
               '--frames', str(plan['frames']), '--output', str(folder), '--', *run['extra']]
    env = {k: v for k, v in os.environ.items() if not k.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_'))
           and k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    fields = plan['fields']
    env.update(LD_PRELOAD=str(ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'),
               CUDAHOOK_DIR=str(folder), CUDAHOOK_DUMP_LIMIT='1', GRANULAR_AFFINE_MODEL_OUTPUT=str(folder),
               CUDAHOOK_DUMP=';'.join(token + '=' + ','.join(str(i) + ':' + str(n) for i, n in sizes.items())
                                     for token, sizes in fields.items()))
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'label': run['label'], 'pid': process.pid}
        dump()
        code = process.wait()
    status['completed'].append({'label': run['label'], 'pid': process.pid, 'actual_exit': code})
    status['running'] = None
    dump()
    print(run['label'], 'actual exit', code, flush=True)
status['complete'] = True
dump()
verify()
command = [sys.executable, str(BASE / 'candidate-independent-cpu-audit.py')]
(BASE / 'candidate-independent-cpu-audit.command.json').write_text(json.dumps(command, indent=2) + '\n')
with (BASE / 'candidate-independent-cpu-audit.log').open('w') as log:
    process = subprocess.Popen(command, cwd=ROOT, stdout=log, stderr=subprocess.STDOUT)
    code = process.wait()
cpu_status = BASE / 'candidate-independent-cpu-audit.status.json'
cpu_status.write_text(json.dumps({'actual_exit': code, 'pid': process.pid}, indent=2) + '\n')
print('Independent support discovery CPU actual exit', code, flush=True)
assert code == 0
