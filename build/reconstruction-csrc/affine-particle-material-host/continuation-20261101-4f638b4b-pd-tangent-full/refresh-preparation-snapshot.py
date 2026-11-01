"""Publish immutable preparation and CPU proof only, retaining all earlier runtime acceptance claims unchanged."""
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
prior = snapshot['files']
checkpoint = json.loads((BASE / 'preparation-manifest.json').read_text())
assert checkpoint['phase_open'] and not checkpoint['GPU_runtime_validation_claimed']
for name, entry in checkpoint['files'].items():
    data = (ROOT / name).read_bytes()
    assert len(data) == entry['bytes'] and hashlib.sha256(data).hexdigest() == entry['sha256'], name
pyc = {name: entry for name, entry in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != snapshot_path.name}
files = {}
for name in sorted(names):
    data = (ROOT / name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == entry for name, entry in pyc.items())
assert sum(name.endswith('.pyc') for name in files) == 360
sdk = 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
host = 'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so'
assert files[sdk]['sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
host_sha = '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert files[host]['sha256'] == snapshot['source_image_sha256'] == host_sha
production = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
for name, expected in production['sources'].items():
    assert files[name]['sha256'] == expected, name
candidate = snapshot['granular_affine_contact_candidate']
assert not candidate['production_promoted'] and candidate['long_C8_all3_passed'] == 10
candidate['full_tangent_preparation'] = {'checkpoint': str((BASE / 'preparation-manifest.json').relative_to(ROOT)),
    'phase_open': True, 'stage_schema_count': 213, 'static_write_entries_checked': 46,
    'static_atomic_access_entries_checked': 20, 'GPU_runtime_validation_claimed': False}
snapshot['checkpoint_note'] = 'Host0dab unchanged;full PD tangent preparation published;GPU queue still pending'
snapshot['solver_api_ready'] = False
snapshot['files'] = files
snapshot_path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_360pyc_unchanged': True,
                  'production_host_unchanged': True, 'phase_open': True, 'whole_solver_complete': False}, indent=2))
