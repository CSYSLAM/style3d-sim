"""Freeze complete actual cloth evidence as one batch while preserving the SDK, images and old failures."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()
audit = json.loads((BASE / 'close-independent-cpu.json').read_text())
assert audit['actual_GPU_jobs'] == 13 and audit['driver_independent_CPU_children'] == 1
assert audit['native_self_aggregate_outputs_strict'] == 36 and audit['native_self_aggregate_outputs_total'] == 78
assert audit['native_PTX_source_query_calls_strict'] == 850560
assert audit['original_selected_query_controls_strict'] == 40
assert audit['independent_integer_F32_steps'] == 6225792
assert audit['active_EF_EE_tangent_fixture_GPU_calls_strict'] == 76
assert audit['normal_H1_source_C8_retained'] == [True, False, False]
assert not audit['source_candidate_promoted'] and not audit['numeric_failures_rejudged']
for path in BASE.glob('*.py'):
    text = path.read_text()
    ast.parse(text)
    assert max(map(len, text.splitlines()), default=0) <= 128, path
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
summary = {key: value for key, value in audit.items() if key != 'input_sha256'}
summary.update({'files': files, 'batch_commit_requested': True, 'upload_requested': False, 'default_switched': False,
                'source_API_ready': False, 'all_old_failures_retained': True,
                'WSL_real_machine_validation_claimed': False})
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
assert snapshot['source_image_sha256'] == 'd09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68'
assert snapshot['public_core_image_sha256'] == '55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5'
refresh = [manifest_path, ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md',
           ROOT / 'reconstruction/csrc/DRIVEN_CLOTH_SELF_HOST_RECOVERY.md',
           ROOT / 'reconstruction/csrc/h1_self_assembly_layout.py',
           ROOT / 'reconstruction/csrc/self_contact_operand_trace.py']
for path in refresh:
    raw = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
raw_manifest = manifest_path.read_bytes()
descriptor = {'path': str(manifest_path.relative_to(ROOT)), 'bytes': len(raw_manifest),
              'sha256': hashlib.sha256(raw_manifest).hexdigest(), 'file_count': len(files)}
assert all(row['path'] != descriptor['path'] for row in snapshot['evidence_file_manifests'])
snapshot['evidence_file_manifests'].append(descriptor)
key = 'current_f07_H1_first_NL_self_producers_native_queries'
snapshot[key] = {name: value for name, value in summary.items() if name != 'files'}
snapshot[key]['manifest'] = descriptor['path']
snapshot['indexed_frozen_file_count'] = len(snapshot['files']) + sum(
    row['file_count'] for row in snapshot['evidence_file_manifests'])
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen actual self phase:', len(files), 'indexed files; primary', len(snapshot['files']),
      ';total', snapshot['indexed_frozen_file_count'], ';root bytes', len(raw))
