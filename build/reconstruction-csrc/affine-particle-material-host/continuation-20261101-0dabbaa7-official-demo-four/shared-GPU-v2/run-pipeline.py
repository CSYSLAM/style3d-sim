"""Run four unchanged official demos on fixed SDK/current source with serial GPU gates and complete state capture."""
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
import numpy as np
from reconstruction.demo_ab import compare

OUTPUT = BASE / 'short3'
OUTPUT.mkdir(exist_ok=False)
cases = [
    {'name': 'cloth-particles', 'example': 'examples/example_cloth_particles.py', 'substeps': 30},
    {'name': 'ball-cloth', 'example': 'examples/example_ball_cloth.py', 'substeps': 6},
    {'name': 'cable-bundle', 'example': 'examples/cable/example_cable_bundle_hysteresis.py', 'substeps': 30},
    {'name': 'anymal', 'example': 'examples/example_robot_anymal_d.py', 'substeps': 12},
]
inputs = [ROOT / case['example'] for case in cases]
inputs += [ROOT / name for name in ['examples/example_ball.py', 'examples/cable/cable_utils.py',
    'reconstruction/demo_ab.py', 'reconstruction/csrc/demo_source_ab.py',
    'src/style3d_sim/newton_solver.py', 'src/style3d_sim/cable_material.py',
    'build/reconstruction-csrc/host-particles/build.json',
    'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so',
    'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so']]
inputs += [Path(__file__), BASE / 'asset-restore.json', ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json']
asset = json.loads((BASE / 'asset-restore.json').read_text())
inputs += sorted(Path(asset['asset_path']).rglob('*'))
installed = ROOT / '.venv/lib/python3.12/site-packages/newton'
inputs += sorted(installed.rglob('*.py'))
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs if path.is_file()}
source = str((ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so').resolve())
reference = str((ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so').resolve())
assert hashes[source] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert hashes[reference] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
versions = {}
for name in ('newton', 'warp-lang', 'numpy'):
    try:
        versions[name] = importlib.metadata.version(name)
    except importlib.metadata.PackageNotFoundError:
        versions[name] = None
plan = {'cases': cases, 'frames': 3, 'input_sha256': hashes, 'package_versions': versions,
        'python': sys.version, 'default_scene_and_solver_parameters_unchanged': True,
        'execution': 'same eager path;every substep captured', 'full_demo_acceptance_claimed': False,
        'production_changed': False, 'GPU_admission_policy': 'available-memory', 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'error': None}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1'})


def save():
    temporary = OUTPUT / 'status.json.tmp'
    temporary.write_text(json.dumps(status, indent=2) + '\n')
    temporary.replace(OUTPUT / 'status.json')


def verify():
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name


save()
try:
    for case in cases:
        directory = OUTPUT / case['name']
        directory.mkdir(exist_ok=False)
        rows = []
        for side in ('original', 'source'):
            verify()
            while True:
                live = subprocess.check_output(
                    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
                free = int(subprocess.check_output(
                    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
                status['GPU_waits'].append({'case': case['name'], 'backend': side,
                    'compute_apps': live, 'epoch': time.time(), 'free_memory_MiB': free,
                    'GPU_admission_policy': 'available-memory'})
                save()
                if free >= 4096:
                    break
                time.sleep(5)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', side, '--tag', side,
                       '--example', str(ROOT / case['example']), '--frames', '3', '--output', str(directory), '--']
            (directory / (side + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
            worker_env = {**env, 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')}
            with (directory / (side + '.log')).open('w') as log:
                child = subprocess.Popen(command, cwd=ROOT, env=worker_env, stdout=log, stderr=subprocess.STDOUT)
                status['running'] = {'case': case['name'], 'backend': side, 'pid': child.pid}
                save()
                code = child.wait()
            row = {'case': case['name'], 'backend': side, 'pid': child.pid, 'actual_exit': code,
                   'capture_exists': (directory / (side + '.npz')).exists()}
            rows.append(row)
            status['completed'].append(row)
            status['running'] = None
            save()
            verify()
            print('Actual official short', case['name'], side, 'exit', code, flush=True)
        result = {'case': case, 'workers': rows, 'frames': 3, 'default_parameters_unchanged': True,
                  'test_final_invoked': False, 'full_demo_accepted': False}
        if all(row['actual_exit'] == 0 and row['capture_exists'] for row in rows):
            with np.load(directory / 'original.npz', allow_pickle=False) as left:
                with np.load(directory / 'source.npz', allow_pickle=False) as right:
                    assert all(len(array) == case['substeps'] for state in (left, right) for array in state.values())
                    result['states_finite'] = all(np.isfinite(array).all() for state in (left, right)
                                                   for array in state.values())
                    result['comparison'] = compare(left, right)
        (directory / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
    status['complete'] = True
except BaseException as problem:
    status['error'] = f'{type(problem).__name__}: {problem}'
    raise
finally:
    save()
print('Four official short diagnostics complete;individual failures retained', flush=True)

# Continue in one serial process after all A/B workers finish.
state = Path('/proc/self/stat').read_text().rsplit(')', 1)[1].split()
(BASE / 'short-waiter-identity.json').write_text(json.dumps({'process': {
    'pid': os.getpid(), 'start_ticks': int(state[19]),
    'boot_id': Path('/proc/sys/kernel/random/boot_id').read_text().strip()}}, indent=2) + '\n')
pipeline = {'complete': False, 'completed': [], 'other_GPU_jobs_allowed': True}
for label, command in [
    ('normal-core', [sys.executable, '-B', str(BASE / 'run-normal-core.py')]),
    ('independent-CPU', [sys.executable, '-B', '-m', 'reconstruction.csrc.official_demo_audit', '--phase', str(BASE)])]:
    with (BASE / (label + '.log')).open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        code = child.wait()
    pipeline['completed'].append({'label': label, 'pid': child.pid, 'actual_exit': code})
    (BASE / 'pipeline-status.json').write_text(json.dumps(pipeline, indent=2) + '\n')
    print('Actual post-stage', label, 'exit', code, flush=True)
    assert code == 0
pipeline['complete'] = True
(BASE / 'pipeline-status.json').write_text(json.dumps(pipeline, indent=2) + '\n')
