"""Publish closed source-only diagnostics and the unaccepted contact candidate without changing active-host gates."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(path.read_text())
prior = snapshot['files']
pyc = {name: item for name, item in prior.items() if name.endswith('.pyc')}
assert len(pyc) == snapshot['pyc_count'] == 360
phase_root = BASE.parent
mixed = phase_root / 'continuation-20261101-0dabbaa7-mixed-newton-fixed'
contacts = phase_root / 'continuation-20261101-0dabbaa7-granular-affine-contacts'
for phase in (mixed, contacts):
    record = json.loads((phase / 'phase-manifest.json').read_text())
    assert not record['phase_open'] and not record['whole_solver_complete']
    for name, metadata in record['files'].items():
        data = (ROOT / name).read_bytes()
        assert len(data) == metadata['bytes'] and hashlib.sha256(data).hexdigest() == metadata['sha256'], name
fixture = 'reconstruction/csrc/granular_affine_contacts_scene.py'
baseline = subprocess.check_output(['git', 'show', '6ae6cd227e7d1ab7b7ad2393866b09b52de5e40c:' + fixture], text=True)


def model_and_math(text):
    tree = ast.parse(text)
    steps = [node for node in ast.walk(tree) if isinstance(node, ast.FunctionDef) and node.name == 'step']
    assert len(steps) == 1
    steps[0].body = [node for node in steps[0].body if not
                     (isinstance(node, ast.If) and isinstance(node.test, ast.Name) and node.test.id == 'output')]
    return ast.dump(tree, include_attributes=False)


assert model_and_math(baseline) == model_and_math((ROOT / fixture).read_text())
changed = subprocess.check_output(['git', 'diff', '--cached', '--name-only', '--diff-filter=ACMRT', '-z'])
names = set(prior) | {name for name in changed.decode().split('\0') if name and name != path.name}
files = {}
for name in sorted(names):
    data = (ROOT / name).read_bytes()
    assert len(data) < 100 * 1024 * 1024, name
    files[name] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
assert all(files[name] == item for name, item in pyc.items())
assert sum(name.endswith('.pyc') for name in files) == 360
sdk = 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert files[sdk]['sha256'] == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
host = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
assert host['extension_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
assert snapshot['source_image_sha256'] == host['extension_sha256']
for name, sha in host['sources'].items():
    assert files[name]['sha256'] == sha, name
snapshot['current_mixed_frozen_path_evidence'] = str((mixed / 'phase-manifest.json').relative_to(ROOT))
snapshot['granular_affine_contact_candidate'] = {
    'sha256': '4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326',
    'phase': str((contacts / 'phase-manifest.json').relative_to(ROOT)), 'production_promoted': False,
    'constructor_classes_passed': 4, 'short_strict': 4, 'short_total': 6, 'short_failed_C8_passed': 2,
    'graph_strict': 16, 'graph_total': 24, 'dual_initcheck_zero_error_tasks': 6,
    'long_C8_source0_passed': 11, 'long_C8_all3_passed': 10, 'long_C8_total': 12,
    'beef_low_resolution_three_frame_fixed_C8_passed': True, 'full_acceptance_passed': False}
snapshot['checkpoint_note'] = 'Host0dab unchanged; mixed F32 path audited; contacts candidate long PD/mixed C8 still false'
snapshot['solver_api_ready'] = False
snapshot['files'] = files
path.write_text(json.dumps(snapshot, indent=2) + '\n')
print(json.dumps({'files_before': len(prior), 'files_after': len(files), 'SDK_360pyc_unchanged': True,
                  'production_host_unchanged': True, 'contact_fixture_model_and_math_AST_unchanged': True,
                  'candidate_promoted': False, 'whole_solver_complete': False}, indent=2))
