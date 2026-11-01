"""Pin the matching current Core and immutable completed observations, leaving pending jobs unclaimed."""
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
core_base = ROOT / 'build/reconstruction-csrc/source-core/95f700673f9a3e0b'
core = json.loads((core_base / 'build.json').read_text())
assert host['extension_sha256'] == 'dec858e551f015374453713edc46910028cae95a210b33acd6c9e9006a1c0282'
assert core['extension_sha256'] == '47ae97200081256af5f5530d180bca1f664fd31214474db4efc0216a52aec2e7'
assert core['source_host_sha256'] == host['extension_sha256']
assert files[str((core_base / '_core.cpython-312-x86_64-linux-gnu.so').relative_to(ROOT))]['sha256'] == \
    core['extension_sha256']
assert len(core['sources']) == 27 and core['kernel_count'] == host['kernel_count'] == 176
for meta in (host, core):
    for name, sha in meta['sources'].items():
        assert files[name]['sha256'] == sha, name
validation = ROOT / 'build/reconstruction-csrc/affine-particle-material-host/' \
    'continuation-20261101-granular-affine-production/validation-dec858e5'
normal_reports = []
for name in ('core-dzhanibekov60', 'core-plastic-bag3', 'core-g1-graph60'):
    report_path = validation / (name + '.json')
    report = json.loads(report_path.read_text())
    assert report['exit'] == 0 and report['source_only'] and report['public_core_abi']
    assert not report['reference_solver_mapped'] and not report['ab_bridge_used']
    assert report['source_sha256'] == core['extension_sha256']
    normal_reports.append(str(report_path.relative_to(ROOT)))
snapshot.update(source_image_sha256=host['extension_sha256'], public_core_image_sha256=core['extension_sha256'],
                public_core_host_sha256=host['extension_sha256'], public_core_matches_current_host=True,
                public_core_normal_entrypoint_reports=normal_reports, public_core_normal_entrypoints_validated=True,
                checkpoint_runtime_validation_complete=False, solver_api_ready=False)
snapshot['checkpoint_note'] = 'Current host short4/layout6/graph16 strict, matching Core normal3 passed; full gates pending'
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_and_360_pyc_unchanged': True,
                  'current_host': host['extension_sha256'], 'matching_Core': core['extension_sha256'],
                  'normal_entrypoints': len(normal_reports), 'whole_solver_complete': False}, indent=2))
