"""Freeze the shared-GPU cache and fixed mixed checks without changing solver acceptance."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()


def read(name):
    return json.loads((BASE / name).read_text())


cache = read('cache-independent-cpu.json')
mixed = read('mixed-independent-cpu.json')
assert cache['cases'] == 39 and cache['full_payload_bytes_CPU_checked'] == 22704176
assert mixed['packets'] == 732 and mixed['actual_calls'] == 4392
assert read('mixed-worker-status.json')['actual_exit'] == 0
before = BASE / 'before-mixed-pointwise.py'
canonical = ROOT / 'reconstruction/csrc/mixed_pointwise_packet_replay.py'
added = ('                        # Pageable H2D must complete before a nonblocking stream consumes these buffers.\n'
         '                        driver.check(driver.cu.cuCtxSynchronize())\n')
assert canonical.read_text().count(added) == 1
assert canonical.read_text().replace(added, '') == before.read_text()
images = {
    'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so':
        '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63',
    'build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so':
        '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e',
    'build/reconstruction-csrc/source-core/5037032b98b9d614/_core.cpython-312-x86_64-linux-gnu.so':
        '7151054e4597e6ea919c0caee576579e577aca233ea4de4dc8ad7aa20fa4b4e7'}
for name, expected in images.items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
build = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
assert str(canonical.relative_to(ROOT)) not in build['sources']
for name, expected in build['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
scripts = list(BASE.rglob('*.py')) + [canonical]
for path in scripts:
    content = path.read_text()
    ast.parse(content)
    if path.name != 'before-audit-mixed-token-fix.py':
        assert all(len(line) <= 128 for line in content.splitlines()), path
checks = {'only_comment_and_fence_added_to_canonical': True,
          'historical_failed_CPU_audit_preserved_verbatim_with_one129_column_line': True,
          'all_current_Python_AST_and128_column_checks_passed': True,
          'frozen_images_unchanged': images, 'all_production_build_sources_unchanged': True,
          'production_math_changed': False, 'whole_solver_complete': False}
(BASE / 'publication-checks.json').write_text(json.dumps(checks, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    data = path.read_bytes()
    assert len(data) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
manifest = {'files': files, 'cache_calls': 39, 'nonblocking_consumers': 33, 'mixed_packets': 732,
            'mixed_actual_calls': 4392, 'mixed_strict_packets': 732, 'independent_CPU_passed': True,
            'external_GPU_apps_allowed': True, 'own_GPU_workers_serial': True,
            'minimum_sampled_free_MiB': mixed['minimum_sampled_free_MiB'],
            'old_fixed_failures_retained': True, 'production_modified': False, 'whole_solver_complete': False}
manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
old_count = len(snapshot['files'])
for name, entry in files.items():
    assert name not in snapshot['files'], name
    snapshot['files'][name] = entry
refresh = [manifest_path, canonical, ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/csrc/CURRENT_MIXED_FIXED_0DABBAA7.md',
           ROOT / 'reconstruction/WORK_LOG.md']
for path in refresh:
    data = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
snapshot['cache_return_and_mixed_fenced_followup'] = {
    'manifest': str(manifest_path.relative_to(ROOT)), 'cache_calls': 39, 'nonblocking_consumers': 33,
    'fixed_mixed_inputs': 732, 'actual_three_backend_calls': 4392, 'all_packets_strict': True,
    'CPU_independent_checked': True, 'minimum_sampled_free_MiB': mixed['minimum_sampled_free_MiB'],
    'external_apps_allowed': True, 'own_GPU_workers_serial': True, 'production_changed': False,
    'old_failed_cohort_reclassified': False, 'whole_solver_complete': False}
snapshot['checkpoint_note'] = ('Shared GPU:39 cache calls ready,33 consumers correct;732 fixed mixed inputs/'
                               '4392 fenced calls strict and complete raw bytes independently CPU checked. '
                               'Production images/math and frozen trajectory failures unchanged.')
snapshot['indexed_frozen_file_count'] = (len(snapshot['files']) +
    sum(entry['file_count'] for entry in snapshot.get('evidence_file_manifests', [])))
data = (json.dumps(snapshot, indent=2) + '\n').encode()
assert len(data) < 100 * 1024 * 1024
snapshot_path.write_bytes(data)
print('Frozen', len(files), 'phase files; root primary', old_count, '->', len(snapshot['files']),
      '; total', snapshot['indexed_frozen_file_count'], '; primary bytes', len(data))
