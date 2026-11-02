"""Measure one additional real SDK trajectory per unchanged demo, without replacing any frozen first candidate."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.official_demo_audit import compare_states, load_states, SDK

OUTPUT = BASE / 'native-repeat60'
OUTPUT.mkdir(exist_ok=False)
plan = json.loads((BASE / 'long60/plan.json').read_text())
hashes = dict(plan['input_sha256'])
hashes[str(Path(__file__).resolve())] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
rows = []


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for case in plan['cases']:
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
    while True:
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'case': case['name'], 'free_memory_MiB': free, 'other_compute_apps': apps})
        save()
        if free >= 4096:
            break
        time.sleep(5)
    directory = OUTPUT / case['name']
    directory.mkdir(exist_ok=False)
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'original', '--tag', 'repeat',
               '--example', str(ROOT / case['example']), '--frames', '60', '--output', str(directory), '--']
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'repeat.log').open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'case': case['name'], 'pid': child.pid}
        save()
        code = child.wait()
    status['running'] = None
    status['completed'].append({'case': case['name'], 'pid': child.pid, 'actual_exit': code})
    save()
    assert code == 0
    runtime = json.loads((directory / 'repeat.runtime.json').read_text())
    assert runtime['image_sha256'] == SDK and runtime['frames'] == 60 and runtime['extra'] == []
    original_path = BASE / 'long60' / case['name'] / 'original.npz'
    source_path = BASE / 'long60' / case['name'] / 'source.npz'
    repeat_path = directory / 'repeat.npz'
    original, source, repeated = [load_states(path) for path in (original_path, source_path, repeat_path)]
    rows.append({'case': case['name'], 'original_vs_original': compare_states(original, repeated),
                 'first_source_vs_repeated_original': compare_states(repeated, source),
                 'two_originals_are_not_a_C8_acceptance_cohort': True, 'frozen_first_source_replaced': False})
    for path in (original_path, source_path, repeat_path, directory / 'repeat.runtime.json', directory / 'repeat.log'):
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    print('Actual SDK repeat60', case['name'], 'exit', code, flush=True)
for path, expected in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
status['complete'] = True
save()
(OUTPUT / 'report.json').write_text(json.dumps({'cases': rows, 'input_sha256': hashes,
    'original_runs_per_case': 2, 'statistical_acceptance_claimed': False,
    'old_frozen_failures_reclassified': False, 'whole_solver_complete': False}, indent=2) + '\n')
