"""Freeze the complete recovery/integration batch, including prior failures and the full0dab checkpoint."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()
audit = json.loads((BASE / 'current-image-independent-cpu.json').read_text())
assert audit['production_cable_cases_strict'] == 104 and audit['regression74_strict'] == 71
assert audit['current_fixed_C10_all3_within'] and audit['normal_public_core_actual_exits0'] == 8
host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host = json.loads(host_path.read_text())
core_directory = ROOT / 'build/reconstruction-csrc/source-core/9cb2fcaa1082d1df'
core = json.loads((core_directory / 'build.json').read_text())
assert host['extension_sha256'] == audit['host_sha256'] == core['source_host_sha256']
assert core['extension_sha256'] == audit['core_sha256']
for name, expected in host['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
cpp = ROOT / 'reconstruction/csrc/native/source_solver.cpp'
assert cpp.read_bytes() == (BASE / 'candidate-weight-order/source_solver.cpp').read_bytes()
for path in [*BASE.glob('*.py'), ROOT / 'reconstruction/csrc/cable_body_mixed_scene.py',
             ROOT / 'reconstruction/csrc/cable_body_mixed_dynamic_scene.py']:
    text = path.read_text()
    ast.parse(text)
    assert max(map(len, text.splitlines())) <= 128, path
assert max(map(len, cpp.read_text().splitlines())) <= 128
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
summary = {'files': files, 'production_host_sha256': host['extension_sha256'], 'public_core_sha256': core['extension_sha256'],
           'kernel_specs_and_CUDA_digest_unchanged': True, 'production_cable_cases_strict': 104,
           'production_cable_penalty_arrays': 840, 'production_cable_owned_calls': 25512,
           'regression74_strict': 71, 'regression74_retained_strict_failures': audit['regression74_retained_strict_failures'],
           'fixed_C10_current_particles_all3_within': True, 'normal_public_core_actual_exits0': 8,
           'old_constructor_upload_failure_retained': True, 'old_0dab_C10_failure_reclassified': False,
           'full_0dab_checkpoint_preserved': True, 'normal_CLI_proves_numerical_equivalence': False,
           'batch_commit_requested': True, 'default_switched': False, 'whole_solver_complete': False}
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
old_files = len(snapshot['files'])
previous_keys = [key for key in snapshot if key.startswith(('current_host_', 'public_core_'))]
previous_keys += ['source_image_sha256', 'current_mixed_frozen_path_evidence']
snapshot['previous_0dabbaa7_acceptance'] = {key: snapshot[key] for key in previous_keys if key in snapshot}
snapshot['source_image_sha256'] = host['extension_sha256']
snapshot['historical_public_core_image_sha256'] = snapshot['public_core_image_sha256']
snapshot['public_core_image_sha256'] = core['extension_sha256']
snapshot['public_core_host_sha256'] = host['extension_sha256']
snapshot['public_core_matches_current_host'] = True
snapshot['current_host_regression_pending'] = False
snapshot['current_host_regression74_status'] = str((BASE / 'validation-d09d4be9-v2/regression74/status.json').relative_to(ROOT))
snapshot['current_host_regression74_strict'] = 71
snapshot['current_host_regression74_failures'] = audit['regression74_retained_strict_failures']
snapshot['current_host_fixed_C10_results'] = {name: True for name in audit['regression74_retained_strict_failures']}
snapshot['current_host_fixed_C10_independent_CPU_reproduced'] = True
snapshot['current_host_regression_acceptance_passed'] = True
snapshot['current_host_constructor_pending'] = False
snapshot['current_host_constructor_five_checks_passed'] = True
snapshot['current_host_constructor_classes'] = ['spring-distance-w3-pd-b1', 'point-line-distance-w3-pd-b1']
snapshot.pop('current_mixed_frozen_path_evidence', None)
reports = [BASE / 'validation-d09d4be9-v2' / (name + '.json') for name in
           ('core-dzhanibekov60', 'core-plastic-bag3', 'core-g1-graph60')]
reports += [BASE / 'normal-core-five60' / (name + '.json') for name in
            ('cloth-particles', 'ball-cloth', 'cable-bend', 'cable-bundle', 'anymal')]
snapshot['public_core_normal_entrypoint_reports'] = [str(path.relative_to(ROOT)) for path in reports]
snapshot['public_core_normal_entrypoints_validated'] = True
snapshot['checkpoint_runtime_validation_complete'] = True
snapshot['checkpoint_note'] = ('Integrated exact d09 host;Core55 matches.104 cable cases strict,71/74 strict,'
                               ' three fixed particle C10 within,8 normal API exits0. '
                               'Old failures retained;full solver replacement incomplete;default/readyFalse unchanged.')
refresh = [manifest_path, cpp, host_path, host_path.parent / '_source_solver.cpython-312-x86_64-linux-gnu.so',
           ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/csrc/cable_body_mixed_scene.py',
           ROOT / 'reconstruction/csrc/cable_body_mixed_dynamic_scene.py', *[p for p in core_directory.iterdir() if p.is_file()]]
for path in refresh:
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
raw_manifest = manifest_path.read_bytes()
descriptor = {'path': str(manifest_path.relative_to(ROOT)), 'bytes': len(raw_manifest),
              'sha256': hashlib.sha256(raw_manifest).hexdigest(), 'file_count': len(files)}
assert all(row['path'] != descriptor['path'] for row in snapshot['evidence_file_manifests'])
snapshot['evidence_file_manifests'].append(descriptor)
snapshot['cable_cache_and_constraint_production'] = {key: value for key, value in summary.items() if key != 'files'}
snapshot['cable_cache_and_constraint_production']['manifest'] = descriptor['path']
snapshot['indexed_frozen_file_count'] = len(snapshot['files']) + sum(row['file_count'] for row in
                                                                snapshot['evidence_file_manifests'])
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen batch:', len(files), 'indexed files; primary', old_files, '->', len(snapshot['files']),
      ';total', snapshot['indexed_frozen_file_count'], ';root bytes', len(raw))
