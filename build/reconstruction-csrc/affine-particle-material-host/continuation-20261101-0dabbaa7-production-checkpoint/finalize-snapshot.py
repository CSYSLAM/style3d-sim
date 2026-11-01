"""Publish finished current-image evidence without converting failed gates into solver acceptance."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path.cwd()
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
phase = ROOT / 'build/reconstruction-csrc/affine-particle-material-host/' \
    'continuation-20261101-granular-affine-bonds-production'
record = json.loads((phase / 'terminal-verification.json').read_text())
assert not record['phase_open'] and not record['whole_solver_complete']
for name, metadata in record['files'].items():
    data = (ROOT / name).read_bytes()
    assert len(data) == metadata['bytes'] and hashlib.sha256(data).hexdigest() == metadata['sha256'], name
prior = snapshot['files']
pyc = {name: metadata for name, metadata in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != snapshot_path.name}
files = {}
for name in sorted(names):
    data = (ROOT / name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == item for name, item in pyc.items())
assert sum(name.endswith('.pyc') for name in files) == 360
sdk = 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert files[sdk]['sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
assert snapshot['source_image_sha256'] == record['production_host_sha256']
assert snapshot['public_core_image_sha256'] == record['matching_Core_sha256']
assert snapshot['public_core_host_sha256'] == record['production_host_sha256']
assert record['regression74_strict'] == 69
assert not record['current_regression_acceptance_passed']
regression = phase / 'validation-0dabbaa7-v2/regression74/status.json'
snapshot.update(current_host_regression_pending=False, current_host_constructor_pending=False,
                current_host_regression74_status=str(regression.relative_to(ROOT)),
                current_host_regression74_strict=record['regression74_strict'],
                current_host_regression74_failures=record['regression74_failures'],
                current_host_fixed_C10_results=record['fixed_source0_C10_every_array_and_step_within'],
                current_host_fixed_C10_independent_CPU_reproduced=True,
                current_host_constructor_five_checks_passed=True, current_host_constructor_classes=3,
                current_host_regression_acceptance_passed=False, checkpoint_runtime_validation_complete=True,
                solver_api_ready=False)
snapshot['checkpoint_note'] = 'Current checks finished; Newton mixed fixed C10 false; whole solver remains incomplete'
snapshot['files'] = files
snapshot_path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_360pyc_unchanged': True,
                  'current_strict': 69, 'current_fixed_C10': snapshot['current_host_fixed_C10_results'],
                  'current_constructor_classes_passed': 3, 'whole_solver_complete': False}, indent=2))
