"""Capture every owned native-step launch and every complete flat/view pointer in one actual context."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.hook_parameter_bytes import decode
from schema import fields, validate, outputs, select, FLAT

PREVIOUS = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-RHS-preconditioners'
FOOT = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-foot-contact'
OUTPUT = BASE / 'capture'
OUTPUT.mkdir(exist_ok=False)
log = PREVIOUS / 'capture/original/launches.txt'
selected_nodes = select([decode(line) for line in log.read_text().splitlines()])
selected = {}
for row in selected_nodes:
    node = row['node']
    validate(node)
    selected[node['key']] = fields(node)
assert set(selected) == set(FLAT)
ranks = [row['node']['owned_launch'] for row in selected_nodes]
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
worker = FOOT / 'common-step.py'
manifest = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
assets = json.loads(manifest.read_text())
asset_root = BASE / 'asset-cache' / assets['cache_directory'] / assets['asset_name']
spans_path = PREVIOUS / 'capture/original/report.json'
spans = json.loads(spans_path.read_text())['native_model_span_sizes']
for name, expected in {'affine_body_indices': 17, 'shape_types': 56, 'joint_drive_types': 12,
                       'joint_target_modes': 18, 'particle_masses': 68}.items():
    assert spans[name] == expected
inputs = [Path(__file__), BASE / 'schema.py', worker, hook, manifest, BASE / 'asset-restore.json', log, spans_path,
          PREVIOUS / 'schema.py', BASE / 'discover-csr.py', BASE / 'csr-prefix/report.json',
          PREVIOUS.parent / 'continuation-20261102-0dabbaa7-anymal-CG-extra/schema.py',
          ROOT / 'reconstruction/csrc/kernels/step.cu', ROOT / 'reconstruction/csrc/kernels/pcg.cu',
          ROOT / 'reconstruction/csrc/kernels/rolling_contacts.cu', ROOT / 'reconstruction/csrc/kernels/joints.cu',
          ROOT / 'reconstruction/csrc/native/source_solver.cpp']
for name, entry in assets['files'].items():
    path = asset_root / name
    data = path.read_bytes()
    assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256']
    inputs.append(path)
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
hashes.update(json.loads((BASE / 'csr-prefix/report.json').read_text())['input_sha256'])
plan = {'fields': selected, 'selected_nodes_from_previous_metadata': selected_nodes, 'selected_owned_ranks': ranks,
        'input_sha256': hashes, 'dump_limit_per_key': 260, 'NL_iterations': 5,
        'scope': 'all35 observed owned kinds; all2608 launches; initialization; all5 NL and250 CG; final state',
        'all_nonnull_flat_and_view_pointer_inputs_captured': True, 'GPU_admission_policy': 'available-memory',
        'all_owned_calls_selected': True, 'all_intermediate_CG_iterations_planned': True,
        'production_changed': False, 'old_failures_reclassified': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                    'CUDAHOOK_DUMP_LIMIT': '260', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
environment['CUDAHOOK_DUMP'] = ';'.join(key + '=' + ','.join(
    str(f['argument']) + '+' + str(f['offset']) + ':' + str(f['bytes']) for f in selected[key]) for key in selected)
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': []}


def save():
    (OUTPUT / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


save()
for backend in ('original', 'source'):
    for path, expected in hashes.items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected
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
    with (OUTPUT / (backend + '.log')).open('w') as output:
        child = subprocess.Popen(command, cwd=ROOT, env={**environment, 'CUDAHOOK_DIR': str(directory)},
                                 stdout=output, stderr=subprocess.STDOUT)
        status['running'] = {'backend': backend, 'pid': child.pid}
        save()
        code = child.wait()
    status['running'] = None
    status['completed'].append({'backend': backend, 'pid': child.pid, 'actual_exit': code})
    save()
    assert code == 0
    print('Actual complete2608-owned native-step capture', backend, 'exit', code, flush=True)
status['complete'] = True
save()
