"""Freeze the entire candidate/Core validation phase, retaining failures and the unchanged production identity."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()
audit = json.loads((BASE / 'close-independent-cpu.json').read_text())
assert audit['constructor_classes_five_checks_passed'] == 4
assert audit['short_failed2_fixed_C8_all_three_within']
assert audit['long_fixed_C8_first_source_passed_groups'] == 9
assert audit['long_fixed_C8_all_three_passed_groups'] == 8
assert not audit['source_guard_candidate_promoted'] and audit['SDK_heldout_passed_groups'] == [10, 9, 9]
assert audit['normal_public_beef3_fixed_C8_all_three_within']
elf = json.loads((BASE / 'four-source-images-elf/report.json').read_text())
assert len(elf['images']) == 4 and elf['empty_needed_list_rejected']
assert all(len(row['ELF_needed']) == 6 and row['only_CUDA_and_standard_system_dependencies'] for row in elf['images'])
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(reference.read_bytes()).hexdigest() == \
    '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
for path in BASE.glob('*.py'):
    text = path.read_text()
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), path
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
excluded = ('input_sha256', 'current_initial_model_and_layout_files_equal')
summary = {key: value for key, value in audit.items() if key not in excluded}
summary.update({'files': files, 'batch_commit_requested': True, 'old_failures_reclassified': False,
                'SDK_and_360pyc_unchanged': True, 'default_switched': False, 'source_API_ready': False,
                'four_actual_ELF_nonempty_needed_lists_checked': True,
                'localized_ELF_parser_pre_fix_results_preserved_not_counted_as_proof': True,
                'WSL_real_machine_validation_claimed': False})
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
assert snapshot['source_image_sha256'] == audit['production_host_sha256']
assert snapshot['public_core_image_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
refresh = [manifest_path, ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md',
           ROOT / 'reconstruction/csrc/GRANULAR_AFFINE_CONTACT_HOST_RECOVERY.md']
for path in refresh:
    raw = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
raw_manifest = manifest_path.read_bytes()
descriptor = {'path': str(manifest_path.relative_to(ROOT)), 'bytes': len(raw_manifest),
              'sha256': hashlib.sha256(raw_manifest).hexdigest(), 'file_count': len(files)}
assert all(row['path'] != descriptor['path'] for row in snapshot['evidence_file_manifests'])
snapshot['evidence_file_manifests'].append(descriptor)
snapshot['current_granular_external_contact_candidate_ae_public_core5688'] = {
    key: value for key, value in summary.items() if key != 'files'}
snapshot['current_granular_external_contact_candidate_ae_public_core5688']['manifest'] = descriptor['path']
snapshot['indexed_frozen_file_count'] = len(snapshot['files']) + sum(row['file_count'] for row in
                                                                snapshot['evidence_file_manifests'])
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen candidate phase:', len(files), 'indexed files; primary', len(snapshot['files']),
      ';total', snapshot['indexed_frozen_file_count'], ';root bytes', len(raw))
