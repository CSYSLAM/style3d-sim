"""Freeze complete native-step evidence and the independently reproduced checker fix without promoting the solver."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'completion-manifest.json'
assert not OUTPUT.exists()


def read(name):
    return json.loads((BASE / name).read_text())


for prefix in ('csr-prefix', 'capture'):
    status = read(prefix + '/status.json')
    assert status['complete'] and status['running'] is None
    assert len(status['completed']) == 2 and all(row['actual_exit'] == 0 for row in status['completed'])
for prefix, total, calls, strict in [('capture', 5216, 15648, 3718),
                                     ('upload-sync-control', 1500, 4500, 1487),
                                     ('upload-sync-control-balanced', 1500, 4500, 1494),
                                     ('capture-synchronized', 5216, 15648, 3756)]:
    status = read(prefix + '/operator-status-v2.json')
    assert status['complete'] and [row['actual_exit'] for row in status['completed']] == [1, 0]
    report = read(prefix + '/full-input-replays/report.json')
    assert report['complete'] and report['error'] is None
    assert len(report['packets']) == total and report['actual_calls'] == calls and report['strict_packets'] == strict
allowed = {'22evaluate_contact_force': {'arg-32', 'arg-33'},
           '53evaluate_joint_body_spring_augmented_lagrangian_force': {'arg-10'},
           '23precondition_and_reduce': {'arg-6'}, '26multiply_matrix_and_reduce': {'arg-9'},
           '24evaluate_contact_tangent': {'arg-30', 'arg-33', 'arg-34'},
           '28multiply_joint_drive_tangent': {'arg-18'}, '25evaluate_joint_drive_load': {'arg-26'},
           '32multiply_rolling_contact_tangent': {'arg-2'}, '30evaluate_rolling_contact_force': {'arg-1'}}
cpu = read('capture-synchronized/replay-independent-cpu-audit.json')
assert all(set(row['different_output_labels']) <= allowed[row['kind']] for row in cpu['failures'])
report = read('capture-synchronized/full-input-replays/report.json')
assert sum(row['kind'] == '53multiply_affine_body_so3_augmented_lagrangian_tangent' and
           all(check['all_complete_outputs_strict'] for check in row['checks']) for row in report['packets']) == 500
context = read('capture/context-independent-cpu.json')
assert context['all_observed_value_links_equal'] and context['observed_link_count'] == 12298
assert context['all250_CG_iteration_observed_links_checked'] and len(context['public_particle_outputs']) == 4
initial = read('initial-cache-independent-cpu.json')
assert initial['cross_backend_comparison_count'] == 88 and len(initial['CPU_recomputed_outputs']) == 8
controls = read('upload-control-independent-cpu.json')['controls']
assert [row['unsafe_failed_packets'] for row in controls] == [13, 6]
assert all(row['fenced_strict_packets'] == 750 for row in controls)
operands = read('capture-synchronized/atomic-operands/independent-cpu.json')
assert operands['atomic_operands_equal'] == 2071168
gpu = read('capture-synchronized/scalar-folds-v2/GPU-report.json')
folds = read('capture-synchronized/scalar-folds-v2/independent-cpu.json')
assert gpu['complete'] and gpu['error'] is None and gpu['actual_GPU_calls'] == 12885
assert folds['differing_assembly_replay_words_covered'] == 6054 and folds['history_words_checked'] == 708910
index = read('snapshot-index-CPU-checks.json')
verifier = ROOT / 'scripts/verify_reconstruction_snapshot.py'
assert index['all10_actual_entry_point_checks_passed']
assert index['verifier_sha256'] == hashlib.sha256(verifier.read_bytes()).hexdigest()
fixes = []
for name, added in {
    'pd_contact_full_replay.py': (
        '                # Pageable H2D may return before DMA; the nonblocking launch stream does not order that copy.\n'
        '                driver.check(driver.cu.cuCtxSynchronize())\n'),
    'g1_contact_rhs_replay.py': (
        '                            # Complete all pageable uploads before the independent nonblocking launch stream.\n'
        '                            driver.check(driver.cu.cuCtxSynchronize())\n'),
    'particle_reduction_certificates.py': (
        '        # Resets use pageable H2D copies outside this nonblocking stream; wait for their DMA completion.\n'
        '        self.driver.check(self.driver.cu.cuCtxSynchronize())\n'),
}.items():
    before = BASE / ('before-upload-fence-' + name)
    after = ROOT / 'reconstruction/csrc' / name
    old, new = before.read_text(), after.read_text()
    assert new.count(added) == 1 and new.replace(added, '') == old
    fixes.append({'path': str(after.relative_to(ROOT)), 'before_sha256': hashlib.sha256(before.read_bytes()).hexdigest(),
                  'after_sha256': hashlib.sha256(after.read_bytes()).hexdigest(), 'only_comment_and_upload_fence_added': True})
(BASE / 'checker-source-fix-audit.json').write_text(json.dumps(fixes, indent=2) + '\n')
scripts = list(BASE.rglob('*.py')) + [verifier, *[ROOT / row['path'] for row in fixes]]
for path in scripts:
    text = path.read_text()
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), path
(BASE / 'publication-checks.json').write_text(json.dumps({
    'Python_AST_and_128_column_files_checked': [str(path.relative_to(ROOT)) for path in scripts],
    'all_passed': True, 'GPU_used_for_freeze': False, 'production_changed': False}, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == OUTPUT:
        continue
    data = path.read_bytes()
    assert len(data) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
result = {'files': files, 'observed_owned_kinds': 35, 'owned_calls_each_backend': 2608,
          'nonlinear_iterations': 5, 'CG_iterations': 250, 'complete_input_packets': 5216,
          'synchronized_three_backend_calls': 15648, 'synchronized_strict_packets': 3756,
          'synchronized_non_strict_packets': 1460, 'observed_value_links_equal': 12298,
          'initial_cross_backend_full_buffers_equal': 88, 'initial_CSR_outputs_CPU_recomputed_equal': 8,
          'balanced_control_unsafe_failures': 6, 'balanced_control_fenced_strict': 750,
          'original_rotating_control_unsafe_failures': 13, 'actual_instrumented_calls': 2920,
          'matching_actual_atomic_operands': 2071168, 'differing_words': 6054, 'real_GPU_target_certificates': 12885,
          'actual_GPU_history_words_verified': 708910, 'all_original_unsafe_results_retained': True,
          'production_joint_global_order_inferred': False, 'old_demo_C8_C10_failures_reclassified': False,
          'production_math_or_images_changed': False, 'default_switched': False, 'whole_solver_complete': False}
data = (json.dumps(result, indent=2) + '\n').encode()
assert len(data) < 100 * 1024 * 1024
OUTPUT.write_bytes(data)
print('Frozen complete native step:', len(files), 'files;', len(data), 'manifest bytes;trajectory acceptance still pending')
