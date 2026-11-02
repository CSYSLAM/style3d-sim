"""Freeze all five real RHS/preconditioner assemblies, keeping incomplete CG and trajectory scope explicit."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'completion-manifest.json'
assert not OUTPUT.exists()


def read(name):
    return json.loads((BASE / name).read_text())


status = read('capture/status.json')
assert status['complete'] and status['running'] is None
assert len(status['completed']) == 2 and all(row['actual_exit'] == 0 for row in status['completed'])
status = read('capture/operator-status-v2.json')
assert status['complete'] and [row['actual_exit'] for row in status['completed']] == [1, 0]
result = read('capture/full-input-replays/report.json')
assert result['complete'] and result['error'] is None and result['actual_calls'] == 666
assert len(result['packets']) == 222 and result['strict_packets'] == 181
cpu = read('capture/replay-independent-cpu-audit.json')
allowed = {'53evaluate_joint_body_spring_augmented_lagrangian_force': ['arg-10'],
           '25evaluate_joint_drive_load': ['arg-26'], '23precondition_and_reduce': ['arg-6'],
           '22evaluate_contact_force': ['arg-32'], '24evaluate_contact_tangent': ['arg-33', 'arg-34'],
           '30evaluate_rolling_contact_force': ['arg-1']}
assert all(row['different_output_labels'] == allowed[row['kind']] for row in cpu['failures'])
plan = read('capture/full-input-replays/plan.json')
assert plan['all2608_launches_have_unchanged_normalized_metadata']
assert all(row['no_unselected_or_missing_raw_dumps'] and row['exact_expected_dump_files'] == 3098
           for row in plan['selected_copy_coverage'])
context = read('capture/context-independent-cpu.json')
assert context['all_observed_value_links_equal'] and context['observed_link_count'] == 298
assert len(context['public_particle_outputs']) == 4
operands = read('capture/atomic-operands/independent-cpu.json')
assert operands['atomic_operands_equal'] == 175840
folds = read('capture/scalar-folds-v2/GPU-report.json')
audit = read('capture/scalar-folds-v2/independent-cpu.json')
assert folds['complete'] and folds['error'] is None and folds['actual_GPU_calls'] == 1477
assert audit['actual_GPU_scalar_calls'] == 1477 and audit['differing_assembly_replay_words_covered'] == 726
assert audit['history_words_checked'] == 19004
assert not audit['production_global_order_inferred'] and not audit['whole_solver_complete']
hook = read('build-hook.json')
original = ROOT / 'reconstruction/diagnostics/cudahook.c'
assert hashlib.sha256(original.read_bytes()).hexdigest() == hook['original_hook_source_sha256']
scripts = []
for path in sorted(BASE.rglob('*.py')):
    text = path.read_text()
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), path
    scripts.append(str(path.relative_to(ROOT)))
assert all(len(line) <= 128 for line in (BASE / 'cudahook-selected-owned.c').read_text().splitlines())
(BASE / 'publication-checks.json').write_text(json.dumps({
    'Python_AST_and_128_column_files_checked': scripts, 'selected_hook_C_128_columns_passed': True,
    'all_passed': True, 'production_changed': False, 'GPU_used_for_this_freeze': False,
    'whole_solver_complete': False}, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == OUTPUT:
        continue
    data = path.read_bytes()
    assert len(data) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
result = {'files': files, 'nonlinear_iterations': 5, 'complete_packets': 222, 'three_backend_calls': 666,
          'strict_packets': 181, 'non_strict_packets': 41, 'actual_instrumented_calls': 82,
          'matching_actual_atomic_operands': 175840, 'observed_value_links_equal': 298,
          'public_particle_native_outputs_equal': 4, 'differing_words': 726, 'real_GPU_target_certificates': 1477,
          'actual_GPU_history_words_verified': 19004, 'independent_fold_CPU_actual_exit': 0,
          'raw_dump_files_each_backend': 3098, 'selected_copy_coverage_exact_both_APIs': True,
          'normalized_launches_unchanged_each_backend': 2608,
          'local_packets_checked_by_strict_outputs_or_actual_operands_and_F32_targets': 222,
          'all_five_RHS_preconditioner_assemblies_and_outer_states_checked': True,
          'all_five_complete_CG_loops_captured_in_one_context': False,
          'production_joint_global_order_inferred': False, 'old_failures_reclassified': False,
          'production_or_original_hook_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Frozen five-NL assembly:', len(files), 'files; all-five full CG and trajectory still pending')
