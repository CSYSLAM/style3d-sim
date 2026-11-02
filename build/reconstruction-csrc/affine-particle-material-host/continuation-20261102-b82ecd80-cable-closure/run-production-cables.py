"""Revalidate the new active host on all104 cable cases against fixed SDK captures, without replacing any reference."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.affine_tetrahedron_contact_ab import clean_env
from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host_bytes = host_path.read_bytes()
host = json.loads(host_bytes)
prior = BASE.parent / 'continuation-20261102-0dabbaa7-cable-body-constraints'
output = BASE / ('production-cables-' + host['extension_sha256'][:8])
output.mkdir(exist_ok=False)
groups = [
    (prior / 'discovery-v2-3', 'cable_body_constraint_scene.py', False),
    (BASE / 'mixed-short', 'cable_body_mixed_scene.py', True),
    (BASE / 'dynamic-mixed-short', 'cable_body_mixed_dynamic_scene.py', True),
    (BASE / 'penalty30', 'cable_host_scene.py', True),
]
jobs, hashes = [], {str(ROOT / name): sha for name, sha in host['sources'].items()}
hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
for directory, fixture_name, nested in groups:
    plan = json.loads((directory / 'plan.json').read_text())
    fixture = ROOT / 'reconstruction/csrc' / fixture_name
    hashes[str(fixture)] = hashlib.sha256(fixture.read_bytes()).hexdigest()
    for case in plan['cases']:
        reference = directory / case['name'] / 'original'
        jobs.append({'case': case, 'fixture': str(fixture), 'frames': plan['frames'], 'group': directory.name,
                     'reference': str(reference), 'reference_actual': str(reference / 'actual' if nested else reference),
                     'owned_hook': directory.name != 'penalty30'})
        for path in reference.rglob('*'):
            if path.is_file():
                hashes[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
assert len(jobs) == 104
hashes.update({str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in (Path(__file__), hook, host_path)})
(output / 'plan.json').write_text(json.dumps({'jobs': jobs, 'input_sha256': hashes,
    'source_image_sha256': host['extension_sha256'], 'original_first_captures_unchanged': True,
    'own_GPU_workers_serial': True, 'external_apps_allowed': True, 'whole_solver_complete': False}, indent=2) + '\n')
status = {'complete': False, 'running': None, 'completed': [], 'GPU_admission': [], 'whole_solver_complete': False}
layout, reports = schemas()[0], []


def dump():
    (output / 'status.json').write_text(json.dumps(status, indent=2) + '\n')


dump()
for index, job in enumerate(jobs):
    assert host_path.read_bytes() == host_bytes
    case, reference = job['case'], Path(job['reference_actual'])
    free = int(subprocess.check_output(
        ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
    apps = subprocess.check_output(
        ['nvidia-smi', '--query-compute-apps=pid,process_name,used_memory', '--format=csv,noheader'], text=True).strip()
    status['GPU_admission'].append({'case': index, 'free_memory_MiB': free, 'compute_apps': apps,
                                    'UTC': datetime.now(timezone.utc).isoformat()})
    assert free >= 4096
    folder = output / f'{index:03d}'
    folder.mkdir()
    command = [sys.executable, '-B', '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source', '--tag', 'capture',
               '--example', job['fixture'], '--frames', str(job['frames']), '--output', str(folder), '--', *case['extra']]
    (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
    env = {**clean_env(), 'PYTHONDONTWRITEBYTECODE': '1', 'CABLE_PROBE_DIR': str(folder)}
    if job['owned_hook']:
        env.update({'LD_PRELOAD': str(hook), 'CUDAHOOK_DIR': str(folder)})
    with (folder / 'run.log').open('w') as log:
        process = subprocess.Popen(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT)
        status['running'] = {'index': index, 'case': case['name'], 'pid': process.pid}
        dump()
        code = process.wait()
    row = {'index': index, 'case': case['name'], 'group': job['group'], 'pid': process.pid,
           'actual_exit': code, 'passed': False}
    if code == 0:
        runtime = json.loads((folder / 'capture.runtime.json').read_text())
        original_runtime = json.loads((reference / 'capture.runtime.json').read_text())
        assert runtime['image_sha256'] == host['extension_sha256']
        assert original_runtime['image_sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
        for key in ('example_sha256', 'extra', 'frames'):
            assert runtime[key] == original_runtime[key]
        with np.load(reference / 'capture.npz', allow_pickle=False) as old, \
                np.load(folder / 'capture.npz', allow_pickle=False) as new:
            assert all(np.isfinite(data[key]).all() for data in (old, new) for key in data.files)
            row['states'] = compare(old, new)
        row['passed'] = row['states']['bitwise']
        if job['owned_hook']:
            row['metadata'] = compare_launches(Path(job['reference']) / 'launches.txt', folder / 'launches.txt', layout)
            counts = json.loads((folder / 'capture.launches.json').read_text())
            row['owned_coverage'] = sum(counts.values()) == row['metadata']['right_launches']
            row['passed'] &= row['metadata']['equal'] and row['owned_coverage']
        if case.get('actions'):
            with np.load(reference / 'penalties.npz', allow_pickle=False) as old, \
                    np.load(folder / 'penalties.npz', allow_pickle=False) as new:
                assert set(old.files) == set(new.files)
                row['penalties'] = {key: old[key].tobytes() == new[key].tobytes() for key in old.files}
                row['passed'] &= all(row['penalties'].values())
    status['completed'].append(row)
    status['running'] = None
    dump()
    print(index, case['name'], 'actual exit', code, 'strict', row['passed'], flush=True)
assert host_path.read_bytes() == host_bytes
for name, expected in hashes.items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
status['complete'] = True
dump()
passed = sum(row['passed'] for row in status['completed'])
print('New production cable checks', passed, '/104 strict', flush=True)
raise SystemExit(int(passed != 104))
