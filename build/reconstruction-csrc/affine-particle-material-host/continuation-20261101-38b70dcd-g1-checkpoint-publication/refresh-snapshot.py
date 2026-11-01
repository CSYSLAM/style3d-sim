"""Refresh hashes for the staged checkpoint, preserving the exact SDK, production images, and frozen pyc."""
import hashlib
import json
from pathlib import Path
import subprocess

path = Path('RECONSTRUCTION_SNAPSHOT.json')
snapshot = json.loads(path.read_text())
assert snapshot['solver_api_ready'] is False
prior = snapshot['files']
pyc = {name: entry for name, entry in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != str(path)}
files = {}
for name in sorted(names):
    data = Path(name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == entry for name, entry in pyc.items())
images = {
    'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so':
        '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63',
    'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so':
        '38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49',
    'build/reconstruction-csrc/source-core/a318a3ce42f6a731/_core.cpython-312-x86_64-linux-gnu.so':
        '7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53',
}
for name, digest in images.items():
    assert files[name]['sha256'] == digest, name
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print('Snapshot regenerated:', len(prior), '->', len(files), 'files; SDK, host, Core and all360 pyc unchanged')
