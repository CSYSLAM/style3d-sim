"""Measure actual SDK support and current guards for granular/SO3 coupling with active external contacts."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

ROOT, PHASE = Path.cwd(), Path(__file__).resolve().parent
BASE = PHASE / 'discovery-v2'
BASE.mkdir(exist_ok=False)
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
saved = build_path.read_bytes()
build = json.loads(saved)
fixture = ROOT / 'reconstruction/csrc/granular_affine_contacts_scene.py'
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
paths = [Path(__file__), fixture, hook, sdk, ROOT / 'reconstruction/csrc/demo_source_ab.py']
hashes = {str(ROOT / name): sha for name, sha in build['sources'].items()}
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths})
assert hashes[str(sdk)] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
assert build['extension_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
cases = []
for worlds, bodies, width, subset, bonds, mode, block, contact, hit in [
    (1, 1, 2, False, 'none', 'newton', False, 'particle', False),
    (1, 1, 3, False, 'authored', 'pd', True, 'rigid', False),
    (1, 1, 2, False, 'dynamic', 'newton', True, 'both', False),
    (3, 1, 2, True, 'mixed', 'pd', False, 'both', False),
    (3, 2, 2, False, 'authored', 'newton', True, 'both', True),
    (1, 2, 3, True, 'mixed', 'pd', False, 'particle', False),
]:
    label = f'w{worlds}-b{bodies}-n{width}-s{int(subset)}-{bonds}-{mode}-b{int(block)}-{contact}-hit{int(hit)}'
    extra = ['--worlds', str(worlds), '--bodies', str(bodies), '--width', str(width), '--bonds', bonds,
             '--mode', mode, '--contact-mode', contact]
    extra += ['--subset'] if subset else []
    extra += ['--body-block'] if block else []
    extra += ['--body-hit'] if hit else []
    total = worlds * (width ** 3 + 4 * bodies)
    fields = {'14initialize_rhs': {9: total * 12},
              '15granular_kernel19accumulate_contacts': {1: total * 12, 2: total * 36},
              '27evaluate_soft_contact_force': {36: total * 12},
              '22evaluate_contact_force': {32: total * 12, 33: total * 4}}
    cases.append({'label': label, 'worlds': worlds, 'bodies': bodies, 'width': width, 'subset': subset,
                  'bonds': bonds, 'contact': contact, 'body_hit': hit, 'extra': extra, 'fields': fields})
with (BASE / 'plan.json').open('x') as out:
    out.write(json.dumps({'cases': cases, 'input_sha256': hashes, 'source_sha256': build['extension_sha256'],
                         'frames': 3, 'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_waits': [], 'whole_solver_complete': False}
env = {key: value for key, value in os.environ.items()
       if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_', 'CUPTI_'))
       and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'GRANULAR_AFFINE_MODEL_OUTPUT')}
rows = []


def dump():
    (BASE / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for case in cases:
    total = case['worlds'] * (case['width'] ** 3 + 4 * case['bodies'])
    for backend in ('original', 'source'):
        assert build_path.read_bytes() == saved
        for name, sha in hashes.items():
            assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == sha, name
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            status['GPU_waits'].append({'UTC': datetime.now(timezone.utc).isoformat(), 'compute_apps': live})
            dump()
            if not live:
                break
            time.sleep(5)
        folder = BASE / case['label'] / backend
        folder.mkdir(parents=True, exist_ok=False)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend, '--tag', 'capture',
                   '--example', str(fixture), '--frames', '3', '--output', str(folder), '--', *case['extra']]
        task_env = {**env, 'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder), 'CUDAHOOK_DUMP_LIMIT': '1',
                    'GRANULAR_AFFINE_MODEL_OUTPUT': str(folder),
                    'CUDAHOOK_DUMP': ';'.join(key + '=' + ','.join(str(i) + ':' + str(n) for i, n in fields.items())
                                            for key, fields in case['fields'].items())}
        (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
        with (folder / 'run.log').open('w') as log:
            process = subprocess.Popen(command, cwd=ROOT, env=task_env, stdout=log, stderr=subprocess.STDOUT)
            status['running'] = {'case': case['label'], 'backend': backend, 'pid': process.pid}
            dump()
            code = process.wait()
        status['completed'].append({'case': case['label'], 'backend': backend, 'pid': process.pid, 'actual_exit': code})
        status['running'] = None
        dump()
        row = {'case': case['label'], 'backend': backend, 'actual_exit': code}
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == (hashes[str(sdk)] if backend == 'original' else build['extension_sha256'])
        assert runtime['extra'] == case['extra'] and runtime['example_sha256'] == hashes[str(fixture)]
        with np.load(folder / 'contacts-0.npz', allow_pickle=False) as contacts, \
                np.load(folder / 'actual-layout.npz', allow_pickle=False) as layout:
            rigid, soft = int(contacts['rigid_count'][0]), int(contacts['soft_count'][0])
            assert len(contacts['rigid_shape0']) == rigid and len(contacts['soft_shape']) == soft
            shapes, particle = contacts['soft_shape'], contacts['soft_particle']
            assert np.all((shapes >= 0) & (shapes < len(contacts['shape_body'])))
            assert np.all((particle >= 0) & (particle < total))
            granular_body = np.isin(particle, layout['granular_indices']) & (contacts['shape_body'][shapes] >= 0)
            row.update(rigid_count=rigid, soft_count=soft, granular_body_contacts=int(granular_body.sum()),
                       intended_contact_types_active=(rigid > 0 if case['contact'] == 'rigid' else soft > 0)
                       and (rigid > 0 and soft > 0 if case['contact'] == 'both' else True))
        if backend == 'original' and code == 0:
            with np.load(folder / 'capture.npz', allow_pickle=False) as arrays:
                assert arrays['particle_q'].shape == (3, total, 3)
                assert all(np.isfinite(arrays[key]).all() for key in arrays.files)
            row['three_steps_finite'] = True
        if backend == 'source':
            row['actual_external_contact_guard'] = code == 1 and \
                'Granular bodies with other rigidity, self or external contacts are not captured' in \
                (folder / 'run.log').read_text()
        rows.append(row)
        (BASE / 'report.json').write_text(json.dumps({'rows': rows, 'whole_solver_complete': False}, indent=2) + '\n')
        print(case['label'], backend, code, 'rigid', rigid, 'soft', soft,
              'grain/body', row['granular_body_contacts'], flush=True)
assert all(row['intended_contact_types_active'] for row in rows)
assert all(row['granular_body_contacts'] > 0 for row in rows if '-hit1' in row['case'])
assert all(row.get('three_steps_finite', False) and row['actual_exit'] == 0 for row in rows if row['backend'] == 'original')
assert all(row['actual_external_contact_guard'] for row in rows if row['backend'] == 'source')
status['complete'] = True
dump()
print('SDK active-contact support and current source rejection confirmed for all six cases', flush=True)
