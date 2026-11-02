"""Test the documented FK synchronization and equivalent single-line velocity predicate on both unchanged backends."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PREVIOUS = BASE.parent / 'continuation-20261101-0dabbaa7-official-demo-four/shared-GPU-v2'
example = BASE / 'example_robot_anymal_d_synced.py'
OUTPUT = BASE / 'first-predictors'
OUTPUT.mkdir(exist_ok=False)
inputs = [Path(__file__), example, BASE / 'synced-variant.json', BASE / 'capture-first-predictor.py']
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
(OUTPUT / 'plan.json').write_text(json.dumps({'input_sha256': hashes, 'frames': 1,
    'production_or_original_example_changed': False, 'original_failures_reclassified': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1',
            'NEWTON_CACHE_PATH': str(PREVIOUS / 'asset-cache')})


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


for backend, variant in [('original', 'original'), ('source', 'original'),
                         ('original', 'synced'), ('source', 'synced')]:
    for path, digest in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
    status['GPU_waits'].append({'backend': backend, 'free_memory_MiB': free, 'compute_apps': apps})
    assert free >= 4096
    tag = backend + '-' + variant
    command = [sys.executable, '-B', str(BASE / 'capture-first-predictor.py'), backend, variant, str(OUTPUT / tag)]
    (OUTPUT / (tag + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (OUTPUT / (tag + '.log')).open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'variant': variant, 'pid': child.pid}
        save()
        code = child.wait()
    status['running'] = None
    status['completed'].append({'backend': backend, 'variant': variant, 'pid': child.pid, 'actual_exit': code})
    save()
    print('Actual ANYmal first predictor', tag, 'exit', code, flush=True)
status['complete'] = True
save()
