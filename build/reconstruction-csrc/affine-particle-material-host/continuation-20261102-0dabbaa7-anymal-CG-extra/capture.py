"""Capture all50 first-NL extra-product chains with every non-null flat and embedded-view pointer."""
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
from schema import KEYS, WRITES, fields, validate_scalars

PREVIOUS = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-first-CG'
FOOT = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-foot-contact'
OUTPUT = BASE / 'capture'
OUTPUT.mkdir(exist_ok=False)
log = PREVIOUS / 'full50/original/launches.txt'
selected = {}
for line in log.read_text().splitlines():
    node = decode(line)
    if node['key'] in KEYS and node['key'] not in selected:
        validate_scalars(node)
        selected[node['key']] = fields(node)
assert set(selected) == set(KEYS)
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
worker = FOOT / 'common-step.py'
manifest = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
assets = json.loads(manifest.read_text())
asset_root = BASE / 'asset-cache' / assets['cache_directory'] / assets['asset_name']
spans_path = PREVIOUS / 'full50/original/report.json'
spans = json.loads(spans_path.read_text())['native_model_span_sizes']
for name, expected in {'affine_body_indices': 17, 'shape_types': 56, 'joint_drive_types': 12,
                       'joint_target_modes': 18, 'particle_masses': 68}.items():
    assert spans[name] == expected
inputs = [Path(__file__), BASE / 'schema.py', worker, hook, manifest, BASE / 'asset-restore.json', log, spans_path,
          ROOT / 'reconstruction/csrc/kernels/rolling_contacts.cu', ROOT / 'reconstruction/csrc/kernels/joints.cu',
          ROOT / 'reconstruction/csrc/native/source_solver.cpp']
for name, entry in assets['files'].items():
    path = asset_root / name
    data = path.read_bytes()
    assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256']
    inputs.append(path)
hashes = {str(path.resolve()): hashlib.sha256(path.read_bytes()).hexdigest() for path in inputs}
plan = {'fields': selected, 'outputs': WRITES, 'input_sha256': hashes, 'dump_limit_per_key': 52,
        'iterations': 50, 'scope': 'first native step; first NL; six extra producers plus direction and matrix',
        'capture52_covers_angular_force_preconditioner_then50_tangents': True,
        'all_nonnull_flat_and_view_pointer_inputs_captured': True, 'GPU_admission_policy': 'available-memory',
        'production_changed': False, 'old_failures_reclassified': False, 'whole_solver_complete': False}
(OUTPUT / 'plan.json').write_text(json.dumps(plan, indent=2) + '\n')
environment = {key: value for key, value in os.environ.items()
               if not key.startswith(('CUDAHOOK_', 'DEMO_', 'RECON_ORACLE_', 'CUPTI_'))
               and key not in ('LD_PRELOAD', 'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
environment.update({'PYTHONPATH': str(ROOT), 'PYTHONDONTWRITEBYTECODE': '1', 'LD_PRELOAD': str(hook),
                    'CUDAHOOK_DUMP_LIMIT': '52', 'NEWTON_CACHE_PATH': str(BASE / 'asset-cache')})
environment['CUDAHOOK_DUMP'] = ';'.join(key + '=' + ','.join(
    str(f['argument']) + '+' + str(f['offset']) + ':' + str(f['bytes']) for f in selected[key]) for key in KEYS)
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
    print('Actual50-CG extra-chain capture', backend, 'exit', code, flush=True)
status['complete'] = True
save()
