"""Freeze actual coupled cable recovery, retaining unsuccessful discovery/constructor evidence and production baseline."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
manifest_path = BASE / 'completion-manifest.json'
assert not manifest_path.exists()


def read(name):
    return json.loads((BASE / name).read_text())


discovery = read('discovery-independent-cpu.json')
assert discovery['SDK_supported_cases'] == discovery['production_guard_rejections'] == 24
for name in ('scope-only', 'cache-order'):
    short = read('independent-' + name + '-short.json')
    assert short['strict_cases'] == 24 and short['owned_launches'] == 10680
graphs = read('graph60-independent-cpu.json')
assert len(graphs['candidates']) == 2 and all(row['strict_pairs'] == 96 for row in graphs['candidates'])
ctor_status = read('constructors-cache-order/status.json')
assert ctor_status['complete'] and ctor_status['running'] is None
assert len(ctor_status['completed']) == 42 and all(row['actual_exit'] == 0 for row in ctor_status['completed'])
constructors = read('constructors-cache-order/report.json')
assert len(constructors['cases']) == 6 and all(all(row['checks'].values()) for row in constructors['cases'])
old_failure = read('constructors-scope-only/spring-w1-newton-b0/audit.json')
assert not old_failure['all_captured_checks_passed'] and old_failure['typed_initializer_counts'] == [33, 27]
views = read('cable-view-independent-cpu.json')
assert views['complete_view_pairs'] == 459 and len(views['cases']) == 6
sanitizer = read('initcheck60-independent-cpu.json')
assert sanitizer['actual_sanitizer_workers'] == 12 and sanitizer['all_zero_errors']
portable = read('portable-candidate-check/report.json')
assert portable['actual_worker_exit'] == 0 and portable['full_three_step_state_bytes_equal']
assert len(portable['negative_controls']) == 3 and all(row['rejected_before_GPU'] for row in portable['negative_controls'])
host_path = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
host = json.loads(host_path.read_text())
assert host['extension_sha256'] == '0dabbaa7a57b57187549f814632efebdc5612095765932be112c2c9ca1868e3e'
for name, expected in host['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
image = host_path.parent / '_source_solver.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(image.read_bytes()).hexdigest() == host['extension_sha256']
sdk = ROOT / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
assert hashlib.sha256(sdk.read_bytes()).hexdigest() == '64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63'
scripts = [*BASE.rglob('*.py'), ROOT / 'reconstruction/csrc/cable_body_constraint_scene.py',
           ROOT / 'reconstruction/csrc/candidate_demo_worker.py']
for path in scripts:
    content = path.read_text()
    ast.parse(content)
    if path.name != 'prepare-graph-worker-as-run.py':
        assert max(map(len, content.splitlines())) <= 128, path
notes = {'all_current_Python_AST_and128_column_checks_passed': True,
         'historical131_column_generator_preserved_as_run': 'prepare-graph-worker-as-run.py',
         'all_current_production_build_sources_and_image_unchanged': True,
         'raw_disassembly_whitespace_preserved': True, 'SDK_and_source_frozen_failures_retained': True,
         'production_modified': False, 'whole_solver_complete': False}
(BASE / 'publication-checks.json').write_text(json.dumps(notes, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == manifest_path:
        continue
    raw = path.read_bytes()
    assert len(raw) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
summary = {'files': files, 'SDK_supported_coupled_classes': 24, 'production_guard_rejections_retained': 24,
           'scope_candidate_image': 'd2c07018090056b4bc0f25fb998f7d481f8029a69e4c99f7ccea63e2b7d1cdf4',
           'cache_candidate_image': 'b82ecd80c2d8b355645e5d8d0b131636da74d55f550d2293c6bcada70bfb226d',
           'cache_candidate_short_strict': 24, 'owned_calls_each_candidate': 10680,
           'cache_candidate_graph60_strict': 96, 'constructor_classes_all5_passed': 6,
           'complete_CableView_pairs': 459, 'six_typed_zero_caches_restored': True,
           'actual_initcheck60_workers_zero_errors': 12, 'portable_candidate_actual_source_exit0': True,
           'portable_negative_controls_before_GPU': 3, 'old_constructor_failure_retained': True,
           'production_promoted': False, 'mixed_plain_combinations_and_penalty_API_followup_pending': True,
           'old_normal_demo_C8_C10_failures_reclassified': False, 'whole_solver_complete': False}
manifest_path.write_text(json.dumps(summary, indent=2) + '\n')
snapshot_path = ROOT / 'RECONSTRUCTION_SNAPSHOT.json'
snapshot = json.loads(snapshot_path.read_text())
old_count = len(snapshot['files'])
for name, entry in files.items():
    assert name not in snapshot['files'], name
    snapshot['files'][name] = entry
refresh = [manifest_path, ROOT / 'RECONSTRUCTION_CURRENT_STATUS.md', ROOT / 'RECONSTRUCTION_HANDOFF.md',
           ROOT / 'reconstruction/csrc/HANDOFF.md', ROOT / 'reconstruction/WORK_LOG.md',
           ROOT / 'reconstruction/csrc/cable_body_constraint_scene.py',
           ROOT / 'reconstruction/csrc/candidate_demo_worker.py']
for path in refresh:
    raw = path.read_bytes()
    snapshot['files'][str(path.relative_to(ROOT))] = {'bytes': len(raw), 'sha256': hashlib.sha256(raw).hexdigest()}
snapshot['cable_plain_constraint_and_cache_recovery'] = {key: value for key, value in summary.items() if key != 'files'}
snapshot['cable_plain_constraint_and_cache_recovery']['manifest'] = str(manifest_path.relative_to(ROOT))
snapshot['checkpoint_note'] = ('Isolated b82 restores six SDK typed cable caches;24 coupled short cases/10680 owned calls,'
                               ' six constructor classes,96 graph60 comparisons and12 initchecks passed. '
                               'Production0dab/Core715 and frozen normal trajectory failures unchanged.')
snapshot['indexed_frozen_file_count'] = (len(snapshot['files']) +
    sum(entry['file_count'] for entry in snapshot.get('evidence_file_manifests', [])))
raw = (json.dumps(snapshot, separators=(',', ':')) + '\n').encode()
assert len(raw) < 100 * 1024 * 1024
snapshot_path.write_bytes(raw)
print('Frozen', len(files), 'phase files; primary', old_count, '->', len(snapshot['files']),
      '; total', snapshot['indexed_frozen_file_count'], '; root bytes', len(raw))
