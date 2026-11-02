"""Run five real public-API final tests on both fixed backends strictly in sequence, retaining every failure."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'functional-tests'
OUTPUT.mkdir(exist_ok=False)
cases = [
    ('cloth-particles', 'examples/example_cloth_particles.py', 100),
    ('ball-cloth', 'examples/example_ball_cloth.py', 100),
    ('cable-bundle', 'examples/cable/example_cable_bundle_hysteresis.py', 180),
    ('cable-bend', 'examples/cable/example_cable_bend_stiffness.py', 510),
    ('anymal', 'examples/example_robot_anymal_d.py', 500),
]
inputs = [Path(__file__), BASE / 'functional-worker.py', ROOT / 'src/style3d_sim/newton_solver.py',
          ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
          ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614/_core.cpython-312-x86_64-linux-gnu.so']
inputs += [ROOT / example for _, example, _ in cases]
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
plan = {'cases': cases, 'input_sha256': hashes, 'GPU_admission_policy': 'available-memory',
        'frames_rationale': {'cloth-particles': 'Authored default100', 'ball-cloth': 'Newton default100',
            'cable-bundle': '180 reaches release2s + mandatory0.4s;default100 skips final assertions',
            'cable-bend': 'Authored ramp2s + hold6s +30frames =510',
            'anymal': 'Authored CUDA test comment requires500 frames to settle'},
        'demo_final_tests_modified': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1',
                    'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for name, example, frames in cases:
    directory = OUTPUT / name
    directory.mkdir(exist_ok=False)
    for backend in ('original', 'source'):
        for path, digest in hashes.items():
            assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
        while True:
            free = int(subprocess.check_output(
                ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
            apps = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'case': name, 'backend': backend, 'free_memory_MiB': free, 'compute_apps': apps})
            save()
            if free >= 4096:
                break
            time.sleep(5)
        command = [sys.executable, '-B', str(BASE / 'functional-worker.py'), backend,
                   str(directory / (backend + '.json')), str(ROOT / example),
                   '--viewer', 'null', '--num-frames', str(frames), '--test']
        (directory / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (directory / (backend + '.log')).open('w') as log:
            child = subprocess.Popen(command, cwd=ROOT, env=environment, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': name, 'backend': backend, 'pid': child.pid}
            save()
            code = child.wait()
        status['running'] = None
        status['completed'].append({'case': name, 'backend': backend, 'pid': child.pid, 'actual_exit': code})
        save()
        print('Actual final-test', name, backend, 'exit', code, flush=True)
status['complete'] = True
save()
print('All10 functional workers completed;failed tests retained;no trajectory acceptance inferred', flush=True)
