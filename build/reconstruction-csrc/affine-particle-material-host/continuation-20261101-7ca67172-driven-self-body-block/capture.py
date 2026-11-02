"""Capture the previously unobserved body-block assembly/application in the unchanged SIX/self failing fixture."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PARENT = BASE.parent
SELF = PARENT / 'continuation-20261101-0dabbaa7-driven-cloth-self'
FLOW = PARENT / 'continuation-20261101-7ca67172-driven-self-flow'
OUTPUT = BASE / 'captures'
OUTPUT.mkdir(exist_ok=False)
case = json.loads((FLOW / 'linear-flow-plan.json').read_text())['jobs'][2]['case']
candidate_path = SELF / 'candidate-force-order/build.json'
candidate = json.loads(candidate_path.read_text())
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
# Owned extents were checked against the actual same-fixture constructor; external spans are model-local.
fields = {
    'build_affine_body_preconditioner': {'0': 32, '1': 8, '2': 64, '3': 64, '4': 1728, '5': 192, '6': 13440,
        '9': 216, '11': 32, '11+8': 24, '11+16': 72, '12': 24, '15': 8, '17': 3456, '18': 24},
    'apply_block_diagonal_preconditioner': {'0': 1728, '1': 576, '2': 576},
    'apply_affine_body_preconditioner': {'0': 32, '1': 3456, '2': 24, '3': 576, '4': 576},
    '27invert_block_preconditioner': {'0': 1728, '1': 64, '2': 64, '3': 1728},
    '23precondition_and_reduce': {'0': 1728, '1': 576, '2': 576, '6': 12},
    '14initialize_rhs': {'9': 576},
    '34add_surface_contact_preconditioner': {'1': 1728},
    '35add_surface_contact_stiffness_scale': {'1': 192},
    '22accumulate_vertex_face': {'6': 192, '12': 1728},
    '28update_solution_and_residual': {'2': 12, '3': 12, '4': 576, '5': 576, '6': 576, '7': 576},
    '20apply_nonlinear_step': {'0': 576, '1': 576, '2': 576},
}
specification = ';'.join(key + '=' + ','.join(argument + ':' + str(size) for argument, size in values.items())
                         for key, values in fields.items())
paths = [Path(__file__), SELF / 'worker.py', candidate_path, Path(candidate['image']), hook,
         FLOW / 'linear-flow-plan.json', ROOT / 'reconstruction/csrc/driven_cloth_self_scene.py']
hashes = dict(candidate['input_sha256'])
hashes.update({str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
(BASE / 'plan.json').write_text(json.dumps({'case': case, 'fields': fields, 'input_sha256': hashes,
    'frames': 3, 'body_block_full_input_kernel_types': 3, 'old_samples_replaced': False,
    'candidate_promoted': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'error': None}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
       and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}


def save():
    path = OUTPUT / 'status.json.tmp'
    path.write_text(json.dumps(status, indent=2) + '\n')
    path.replace(OUTPUT / 'status.json')


def verify():
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path


save()
try:
    for side in ('original', 'source'):
        verify()
        while True:
            apps = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': apps})
            save()
            if not apps:
                break
            time.sleep(5)
        directory = OUTPUT / side
        directory.mkdir()
        command = [sys.executable, str(SELF / 'worker.py'), '--backend', side, '--output', str(directory),
                   '--candidate-build', str(candidate_path), '--frames', '3', '--', *case['extra']]
        (directory / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (directory / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env={**env, 'LD_PRELOAD': str(hook),
                'CUDAHOOK_DIR': str(directory), 'CUDAHOOK_DUMP': specification, 'CUDAHOOK_DUMP_LIMIT': '999',
                'DRIVEN_SELF_LAYOUT_OUTPUT': str(directory / 'layout.json')}, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'backend': side, 'pid': process.pid}
            save()
            code = process.wait()
        status['completed'].append({'backend': side, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        save()
        assert code == 0
        verify()
        print('Actual body-block capture', side, 'exit', code, flush=True)
    status['complete'] = True
except BaseException as error:
    status['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    save()
