"""Freeze the combined recovery, actual candidate ELFs, all raw controls and unresolved failures in one indexed batch."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()
audit = json.loads((BASE / 'close-independent-cpu.json').read_text())
assert audit['actual_GPU_jobs'] == 68 and audit['source_short_strict'] == 10
assert audit['constructor_classes_five_checks_passed'] == 4 and audit['frozen_SDK_constructor_files_reused'] == 392
assert audit['normal_public_H1_graph4_source_C8'] == [True, False, False]
assert audit['normal_public_H1_SDK_controls_C8'] == [True, True, False]
assert audit['H1_complete_graph_typed_parameters_equal'] and audit['H1_graph_nodes'] == 6120
assert not audit['source_candidate_promoted'] and not audit['H1_initcheck_failures_rejudged']
elf = json.loads((BASE / 'four-source-images-elf/report.json').read_text())
assert len(elf['images']) == 4 and elf['empty_needed_list_rejected']
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
summary = {key: value for key, value in audit.items() if key != 'input_sha256'}
summary.update({'files': files, 'batch_commit_requested': True, 'default_switched': False,
                'source_API_ready': False, 'all_old_failures_retained': True,
                'four_actual_ELF_nonempty_needed_lists_checked': True,
                'WSL_real_machine_validation_claimed': False})
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
assert snapshot['source_image_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert snapshot['public_core_image_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
refresh = [manifest_path, ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md',
           ROOT / 'reconstruction/csrc/DRIVEN_CLOTH_SELF_HOST_RECOVERY.md']
for path in refresh:
    raw = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
raw_manifest = manifest_path.read_bytes()
descriptor = {'path': str(manifest_path.relative_to(ROOT)), 'bytes': len(raw_manifest),
              'sha256': hashlib.sha256(raw_manifest).hexdigest(), 'file_count': len(files)}
assert all(row['path'] != descriptor['path'] for row in snapshot['evidence_file_manifests'])
snapshot['evidence_file_manifests'].append(descriptor)
key = 'current_combined_self_drive_candidate_f07_public_core_aa'
snapshot[key] = {name: value for name, value in summary.items() if name != 'files'}
snapshot[key]['manifest'] = descriptor['path']
snapshot['indexed_frozen_file_count'] = len(snapshot['files']) + sum(
    row['file_count'] for row in snapshot['evidence_file_manifests'])
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen combined phase:', len(files), 'indexed files; primary', len(snapshot['files']),
      ';total', snapshot['indexed_frozen_file_count'], ';root bytes', len(raw))
