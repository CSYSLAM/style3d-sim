"""Separate original/source eager behavior from the existing ANYmal Graph anomaly;keep every original sample."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PREVIOUS = BASE.parent / 'continuation-20261101-0dabbaa7-official-demo-four/shared-GPU-v2'
example = ROOT / 'examples/example_robot_anymal_d.py'
inputs = [Path(__file__), example, ROOT / 'reconstruction/csrc/demo_source_ab.py',
          PREVIOUS / 'functional-worker.py', PREVIOUS / 'functional-tests/anymal/original.npz',
          PREVIOUS / 'functional-tests/anymal/source.npz', PREVIOUS / 'functional-tests/anymal-predicate/independent-cpu.json']
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
plan_path = BASE / 'plan.json'
assert not plan_path.exists()
plan_path.write_text(json.dumps({'input_sha256': hashes, 'frames': 500, 'default_world_count': 8,
    'eager_capture_replaced_only_by_existing_AB_harness': True,
    'Graph_repeat_uses_unchanged_public_example': True, 'settling_speed_bound': 0.25,
    'old_samples_replaced': False, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1',
                    'NEWTON_CACHE_PATH': str(PREVIOUS / 'asset-cache')})


def save():
    (BASE / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for tag, backend in [('original-eager', 'original'), ('source-eager', 'source'), ('original-graph-repeat', 'original')]:
    for path, digest in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
    directory = BASE / tag
    directory.mkdir(exist_ok=False)
    while True:
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'tag': tag, 'free_memory_MiB': free, 'compute_apps': apps})
        save()
        if free >= 4096:
            break
        time.sleep(5)
    if tag.endswith('eager'):
        command = [sys.executable, '-B', '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(example), '--frames', '500', '--output', str(directory), '--']
    else:
        command = [sys.executable, '-B', str(PREVIOUS / 'functional-worker.py'), backend,
                   str(directory / 'report.json'), str(example), '--viewer', 'null', '--num-frames', '500', '--test']
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'tag': tag, 'pid': process.pid}
        save()
        code = process.wait()
    status['running'] = None
    status['completed'].append({'tag': tag, 'backend': backend, 'pid': process.pid, 'actual_exit': code})
    save()
    print('Actual ANYmal', tag, 'exit', code, flush=True)
    assert code == 0
status['complete'] = True
save()
