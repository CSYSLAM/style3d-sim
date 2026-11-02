"""Freeze the complete five-NL phase without altering current images, old failures or acceptance rules."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()
audit = json.loads((BASE / 'close-independent-cpu.json').read_text())
assert audit['all_5_NL_250_CG_captured_same_run'] and audit['non_reduction_outputs_strict'] == 7620
assert audit['strict_scalar_failures_retained'] == 1704 and audit['atomic_actual_calls']['certificate'] == 2633
reference = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(reference.read_bytes()).hexdigest() == \
    '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
new_sources = [ROOT / ('reconstruction/csrc/' + name) for name in
               ('g1_fourth_full_cg.py', 'g1_fourth_full_cg_atomic.py')]
for path in [*BASE.glob('*.py'), *new_sources]:
    text = path.read_text()
    ast.parse(text)
    if path.name != 'worker-template.py':
        assert all(len(line) <= 128 for line in text.splitlines()), path
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
summary = {key: value for key, value in audit.items() if key not in ('input_sha256', 'runner_sha256')}
summary.update({'files': files, 'batch_commit_requested': True, 'old_failures_reclassified': False,
                'SDK_and_360pyc_unchanged': True, 'one_substep_scope_not_all_six_substeps_CG': True,
                'default_switched': False, 'source_API_ready': False, 'WSL_cross_path_diagnostics_claimed': False})
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
assert snapshot['source_image_sha256'] == audit['host_sha256']
assert snapshot['public_core_image_sha256'] == audit['core_sha256']
refresh = [manifest_path, *new_sources, ROOT / 'reconstruction/csrc/CURRENT_G1_CORE_55D6.md',
           ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md']
for path in refresh:
    raw = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
raw_manifest = manifest_path.read_bytes()
descriptor = {'path': str(manifest_path.relative_to(ROOT)), 'bytes': len(raw_manifest),
              'sha256': hashlib.sha256(raw_manifest).hexdigest(), 'file_count': len(files)}
assert all(row['path'] != descriptor['path'] for row in snapshot['evidence_file_manifests'])
snapshot['evidence_file_manifests'].append(descriptor)
snapshot['current_G1_Core55_fourth_substep_all_five_NL'] = {key: value for key, value in summary.items() if key != 'files'}
snapshot['current_G1_Core55_fourth_substep_all_five_NL']['manifest'] = descriptor['path']
snapshot['indexed_frozen_file_count'] = len(snapshot['files']) + sum(row['file_count'] for row in
                                                                snapshot['evidence_file_manifests'])
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen five-NL phase:', len(files), 'indexed files; primary', len(snapshot['files']),
      ';total', snapshot['indexed_frozen_file_count'], ';root bytes', len(raw))
