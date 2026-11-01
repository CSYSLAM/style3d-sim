"""Freeze a one-world actual SDK support discovery and the unchanged source guard baseline."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
snapshot = json.loads((ROOT / 'RECONSTRUCTION_SNAPSHOT.json').read_text())
build_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
build = json.loads(build_path.read_text())
assert build['extension_sha256'] == '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49'
paths = [ROOT / 'reconstruction/csrc/granular_affine_scene.py', ROOT / 'reconstruction/csrc/demo_source_ab.py',
         ROOT / 'reconstruction/csrc/host_bodies_ab.py', ROOT / 'reconstruction/csrc/host_particles_ab.py',
         ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so', build_path,
         ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so',
         ROOT / 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so',
         Path(__file__), BASE / 'run.py', BASE / 'independent-cpu-audit.py']
for name in build['sources']:
    path = ROOT / name
    assert path.exists() and name in snapshot['files']
    paths.append(path)
    assert hashlib.sha256(path.read_bytes()).hexdigest() == snapshot['files'][name]['sha256']
for p in (ROOT / 'reconstruction/csrc/granular_affine_scene.py', Path(__file__), BASE / 'run.py',
          BASE / 'independent-cpu-audit.py'):
    ast.parse(p.read_text())
    assert all(len(line) <= 128 for line in p.read_text().splitlines()), str(p)
hashes = {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}
runs = []
for backend in ('original', 'source'):
    for mode in ('newton', 'pd'):
        for block in (False, True):
            runs.append({'label': backend + '-' + mode + '-b' + str(int(block)), 'backend': backend,
                         'extra': ['--mode', mode] + (['--body-block'] if block else [])})
plan = {'input_sha256': hashes, 'runs': runs, 'frames': 3,
        'fields': {'32initialize_affine_body_so3_state': {1: 16}, '14initialize_rhs': {9: 144},
                   '15granular_kernel10build_grid': {7: 32, 8: 32},
                   '15granular_kernel19accumulate_contacts': {1: 144, 2: 432}},
        'previous_published': '3470071652bbb62c09203f77d6da603d6ae3f11d',
        'support_discovery_only': True, 'source_guard_kept': True, 'production_changed': False,
        'world_count': 1, 'ordinary_particles': 8, 'native_proxy_particles': 4,
        'whole_solver_complete': False}
output = BASE / 'plan.json'
assert not output.exists()
output.write_text(json.dumps(plan, indent=2) + '\n')
print('Frozen four SDK support probes and four unchanged-source guard baselines; no GPU context', flush=True)
