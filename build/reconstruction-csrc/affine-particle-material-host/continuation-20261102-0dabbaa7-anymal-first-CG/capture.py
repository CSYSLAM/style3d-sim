"""Capture complete first contact/PCG inputs on both fixed backends;preserve shared model and per-world state sizes."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.audit_cudahook import parameter_types
from reconstruction.csrc.hook_parameter_bytes import decode

PREVIOUS = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-foot-contact'
OUTPUT = BASE / 'capture'
OUTPUT.mkdir(exist_ok=False)
N, P, W = 544, 68, 8
nodes, seen = [], set()
for line in (PREVIOUS / 'native-contact/original/launches.txt').read_text().splitlines():
    node = decode(line)
    if node['key'] not in seen:
        nodes.append(node)
        seen.add(node['key'])
by_key = {node['key']: node for node in nodes}
fields = {key: {int(i): size for i, size in sizes.items()} for key, sizes in
          json.loads((PREVIOUS / 'native-contact/plan.json').read_text())['fields'].items()}
fields.update({
    '27invert_block_preconditioner': {0: N * 36, 1: P * 4, 2: P * 4, 3: N * 36},
    '23precondition_and_reduce': {0: N * 36, 1: N * 12, 2: N * 12, 6: W * 4},
    '19update_cg_direction': {1: N * 12, 4: W * 4, 6: N * 12},
    '26multiply_matrix_and_reduce': {0: N * 4, 1: N * 19 * 40, 3: N * 36,
                                    4: N * 12, 5: N * 12, 6: N * 12, 9: W * 4},
    '28update_solution_and_residual': {2: W * 4, 3: W * 4, 4: N * 12, 5: N * 12, 6: N * 12, 7: N * 12},
    '20apply_nonlinear_step': {0: N * 12, 1: N * 12, 2: N * 12},
})
writes = {'22evaluate_contact_force': [32, 33], '24evaluate_contact_tangent': [33, 34],
          '27invert_block_preconditioner': [3], '23precondition_and_reduce': [2, 6],
          '19update_cg_direction': [6], '26multiply_matrix_and_reduce': [6, 9],
          '28update_solution_and_residual': [6, 7], '20apply_nonlinear_step': [1, 2]}
for key, sizes in fields.items():
    node = by_key[key]
    actual = {i for i, kind in enumerate(parameter_types(node['name']))
              if '*' in kind and int.from_bytes(bytes.fromhex(node['parameter_hex'][i]), 'little')}
    assert actual == set(sizes), (key, actual, sizes)
matrix = by_key['26multiply_matrix_and_reduce']
assert int.from_bytes(bytes.fromhex(matrix['parameter_hex'][2]), 'little') == 19
assert int.from_bytes(bytes.fromhex(matrix['parameter_hex'][11]), 'little') == N
inverse = by_key['27invert_block_preconditioner']
assert int.from_bytes(bytes.fromhex(inverse['parameter_hex'][5]), 'little') == P
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
worker = PREVIOUS / 'common-step.py'
asset_manifest = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
assets = json.loads(asset_manifest.read_text())
asset_root = BASE / 'asset-cache' / assets['cache_directory'] / assets['asset_name']
inputs = [Path(__file__), worker, hook, asset_manifest, BASE / 'asset-restore.json',
          ROOT / 'reconstruction/csrc/revisions/pcg_23fb797.cu', ROOT / 'reconstruction/csrc/kernels/pcg.cu',
          PREVIOUS / 'native-contact/original/launches.txt']
for name, entry in assets['files'].items():
    path = asset_root / name
    assert path.stat().st_size == entry['bytes'] and hashlib.sha256(path.read_bytes()).hexdigest() == entry['sha256']
    inputs.append(path)
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
(OUTPUT / 'plan.json').write_text(json.dumps({'fields': fields, 'outputs': writes, 'input_sha256': hashes,
    'sizes': {'state_particles': N, 'shared_particles': P, 'worlds': W, 'matrix_rows': N, 'matrix_ELL_slots': 19},
    'all_nonnull_flat_pointer_inputs_captured': True, 'first_CG_iterations_captured': 1,
    'first_apply_follows50_CG_iterations': True, 'full50_iteration_propagation_proved': False,
    'GPU_admission_policy': 'available-memory', 'old_failures_reclassified': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                    'CUDAHOOK_DUMP_LIMIT': '1', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
environment['CUDAHOOK_DUMP'] = ';'.join(key + '=' + ','.join(str(i) + ':' + str(size) for i, size in sizes.items())
                                       for key, sizes in fields.items())


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for backend in ('original', 'source'):
    for path, digest in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
    while True:
        free = int(subprocess.check_output(
            ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
        apps = subprocess.check_output(
            ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
        status['GPU_waits'].append({'backend': backend, 'free_memory_MiB': free, 'compute_apps': apps})
        save()
        if free >= 4096:
            break
        time.sleep(5)
    directory = OUTPUT / backend
    command = [sys.executable, '-B', str(worker), backend, 'synced', str(directory)]
    (OUTPUT / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
    with (OUTPUT / (backend + '.log')).open('w') as log:
        child = subprocess.Popen(command, cwd=ROOT, env={**environment, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': child.pid}
        save()
        code = child.wait()
    status['running'] = None
    status['completed'].append({'backend': backend, 'pid': child.pid, 'actual_exit': code})
    save()
    assert code == 0
    print('Actual ANYmal complete first-CG capture', backend, 'exit', code, flush=True)
status['complete'] = True
save()
