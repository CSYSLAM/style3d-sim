"""Capture the first actual Newton cable bend PCG operators; preserve all earlier frozen failures."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'first-CG'
OUTPUT.mkdir(exist_ok=False)
initial = json.loads((BASE / 'status.json').read_text())
hashes = dict(initial['input_sha256'])
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
for path in (Path(__file__), hook, BASE / 'cohort8/independent-cpu.json', BASE / 'native-controls/independent-cpu.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
fields = {'14initialize_rhs': {'1': 2304, '2': 2304, '9': 2304},
          '27invert_block_preconditioner': {'0': 6912, '1': 768, '2': 768, '3': 6912},
          '23precondition_and_reduce': {'0': 6912, '1': 2304, '2': 2304, '6': 4},
          '19update_cg_direction': {'1': 2304, '4': 4, '6': 2304},
          '26multiply_matrix_and_reduce': {'0': 768, '3': 6912, '4': 2304, '5': 2304, '6': 2304, '9': 4},
          '28update_solution_and_residual': {'2': 4, '3': 4, '4': 2304, '5': 2304, '6': 2304, '7': 2304},
          '20apply_nonlinear_step': {'0': 2304, '1': 2304, '2': 2304}}
spec = ';'.join(key + '=' + ','.join(field + ':' + str(size) for field, size in values.items())
                for key, values in fields.items())
plan = {'input_sha256': hashes, 'fields': fields, 'dump_limit_per_kernel': 1, 'frames': 1, 'mode': 'synreal',
        'particle_state_count': 192, 'body_state_count': 48, 'worlds': 1,
        'complete_input_kinds_to_verify': ['precondition_and_reduce', 'update_cg_direction',
                                           'update_solution_and_residual', 'apply_nonlinear_step'],
        'matrix_input_capture_complete': False, 'original_fixed_failures_reclassified': False,
        'production_changed': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
status = {'complete': False, 'completed': [], 'GPU_waits': []}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
env.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
            'CUDAHOOK_DUMP': spec, 'CUDAHOOK_DUMP_LIMIT': '1'})


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for side in ('original', 'source'):
    for name, expected in hashes.items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    while True:
        live = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'backend': side, 'compute_apps': live, 'epoch': time.time()})
        save()
        if not live:
            break
        time.sleep(5)
    directory = OUTPUT / side
    directory.mkdir(exist_ok=False)
    command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', side, '--tag', 'capture',
               '--example', str(ROOT / 'examples/cable/example_cable_bend_stiffness.py'), '--frames', '1',
               '--output', str(directory), '--', '--solver', 'synreal']
    (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    with (directory / 'run.log').open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env={**env, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=log, stderr=subprocess.STDOUT)
        code = child.wait()
    status['completed'].append({'backend': side, 'pid': child.pid, 'actual_exit': code})
    save()
    assert code == 0
    print('Actual first cable CG capture', side, 'exit', code, flush=True)
status['complete'] = True
save()
