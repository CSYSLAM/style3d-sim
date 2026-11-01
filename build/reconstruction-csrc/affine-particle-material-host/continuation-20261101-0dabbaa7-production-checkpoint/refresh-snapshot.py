"""Pin the promoted source host/Core and finished checks without inheriting the previous image's regression."""
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
core_dir = ROOT / 'build/reconstruction-csrc/source-core/5037032b98b9d614'
core = json.loads((core_dir / 'build.json').read_text())
assert host['extension_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert core['extension_sha256'] == '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'
assert core['source_host_sha256'] == host['extension_sha256']
for metadata in (host, core):
    for name, sha in metadata['sources'].items():
        assert files[name]['sha256'] == sha, name
validation = ROOT / 'build/reconstruction-csrc/affine-particle-material-host/' \
    'continuation-20261101-granular-affine-bonds-production/validation-0dabbaa7-v2'
reports = []
for name in ('core-dzhanibekov60', 'core-plastic-bag3', 'core-g1-graph60'):
    p = validation / (name + '.json')
    data = json.loads(p.read_text())
    assert data['exit'] == 0 and data['source_only'] and data['public_core_abi']
    assert not data['reference_solver_mapped'] and data['source_sha256'] == core['extension_sha256']
    reports.append(str(p.relative_to(ROOT)))
historical = {key: snapshot.get(key) for key in ('current_host_regression74_status', 'current_host_regression74_strict',
              'current_host_regression74_failures', 'current_host_fixed_C10_three_passed',
              'current_host_constructor_five_checks_passed')}
if any(value is not None for value in historical.values()):
    snapshot['previous_dec858e5_acceptance'] = historical
for key in historical:
    snapshot.pop(key, None)
snapshot.update(source_image_sha256=host['extension_sha256'], public_core_image_sha256=core['extension_sha256'],
                public_core_host_sha256=host['extension_sha256'], public_core_matches_current_host=True,
                public_core_normal_entrypoint_reports=reports, public_core_normal_entrypoints_validated=True,
                current_host_regression_pending=True, current_host_constructor_pending=True,
                checkpoint_runtime_validation_complete=False, solver_api_ready=False)
snapshot['checkpoint_note'] = 'Promoted bonds source; current short16/graph24/normal3/contracts pass; full current gates pending'
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_360pyc_unchanged': True,
                  'current_host': host['extension_sha256'], 'matching_Core': core['extension_sha256'],
                  'old_regression_not_inherited': True, 'whole_solver_complete': False}, indent=2))
