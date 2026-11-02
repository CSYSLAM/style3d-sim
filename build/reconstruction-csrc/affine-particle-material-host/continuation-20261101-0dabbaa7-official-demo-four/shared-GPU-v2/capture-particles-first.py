"""Capture the first real particle-cloth force and PCG buffers, permitting other GPU jobs without changing numerics."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'particles-first'
OUTPUT.mkdir(exist_ok=False)
N = 8625
fields = {
    '14initialize_rhs': {'1': N * 12, '2': N * 12, '9': N * 12},
    '22evaluate_stretch_force': {'5': N * 12}, '22evaluate_bending_force': {'7': N * 12},
    '22accumulate_vertex_face': {'11': N * 12, '12': N * 36},
    '20accumulate_edge_edge': {'9': N * 12, '10': N * 36},
    '20accumulate_edge_face': {'10': N * 12, '11': N * 36},
    '27invert_block_preconditioner': {'0': N * 36, '1': N * 4, '2': N * 4, '3': N * 36},
    '23precondition_and_reduce': {'0': N * 36, '1': N * 12, '2': N * 12, '6': 4},
    '19update_cg_direction': {'1': N * 12, '4': 4, '6': N * 12},
    '26multiply_matrix_and_reduce': {'0': N * 4, '3': N * 36, '4': N * 12, '5': N * 12, '6': N * 12, '9': 4},
    '28update_solution_and_residual': {'2': 4, '3': 4, '4': N * 12, '5': N * 12, '6': N * 12, '7': N * 12},
    '20apply_nonlinear_step': {'0': N * 12, '1': N * 12, '2': N * 12},
}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
inputs = [Path(__file__), hook, ROOT / 'reconstruction/csrc/demo_source_ab.py',
          ROOT / 'examples/example_cloth_particles.py', BASE / 'long60/independent-cpu.json']
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
plan = {'particle_count': N, 'frames': 1, 'fields': fields, 'input_sha256': hashes,
        'GPU_admission_policy': 'available-memory', 'original_frozen_failure_replaced': False,
        'complete_matrix_inputs_claimed': False, 'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
            'CUDAHOOK_DUMP_LIMIT': '1', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
env['CUDAHOOK_DUMP'] = ';'.join(key + '=' + ','.join(k + ':' + str(n) for k, n in values.items())
                               for key, values in fields.items())


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for side in ('original', 'source'):
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected
    while True:
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        status['GPU_waits'].append({'backend': side, 'compute_apps': apps, 'free_memory_MiB': free,
                                   'GPU_admission_policy': 'available-memory', 'epoch': time.time()})
        save()
        if free >= 4096:
            break
        time.sleep(5)
    directory = OUTPUT / side
    directory.mkdir(exist_ok=False)
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.demo_source_ab', '--worker', side, '--tag', 'capture',
               '--example', str(ROOT / 'examples/example_cloth_particles.py'), '--frames', '1',
               '--output', str(directory), '--']
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'run.log').open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env={**env, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': side, 'pid': child.pid}
        save()
        code = child.wait()
    status['completed'].append({'backend': side, 'pid': child.pid, 'actual_exit': code})
    status['running'] = None
    save()
    assert code == 0
    print('Actual particles first-force/CG', side, 'exit', code, flush=True)
status['complete'] = True
save()
