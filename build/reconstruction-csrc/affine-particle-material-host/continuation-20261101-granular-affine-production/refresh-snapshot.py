"""Publish immutable production checkpoint files without claiming a matching Core or runtime acceptance."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path.cwd()
path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(path.read_text())
prior = snapshot['files']
pyc = {name: item for name, item in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != path.name}
files = {}
for name in sorted(names):
    data = (ROOT / name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == item for name, item in pyc.items())
sdk = 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert files[sdk]['sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
host = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
assert host['kernel_count'] == 176 and not host['solver_api_ready']
assert files['build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so']['sha256'] == \
    host['extension_sha256']
for name, sha in host['sources'].items():
    assert files[name]['sha256'] == sha, name
snapshot['source_image_sha256'] = host['extension_sha256']
snapshot['public_core_matches_current_host'] = snapshot['public_core_host_sha256'] == host['extension_sha256']
snapshot['solver_api_ready'] = False
snapshot['checkpoint_runtime_validation_complete'] = False
snapshot['checkpoint_note'] = 'Granular-affine production promotion; current GPU validation remains pending'
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files),
                  'current_host': host['extension_sha256'], 'SDK_and_360_pyc_unchanged': True,
                  'public_core_matches_current_host': snapshot['public_core_matches_current_host'],
                  'runtime_acceptance_claimed': False}, indent=2))
