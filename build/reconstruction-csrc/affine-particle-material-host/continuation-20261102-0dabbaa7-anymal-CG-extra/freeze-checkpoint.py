"""Freeze actual first-NL extra-chain evidence without changing any failed trajectory or production image."""
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
assert result['complete'] and result['error'] is None and result['actual_calls'] == 2400
assert len(result['packets']) == 800 and result['strict_packets'] == 552
cpu = read('capture/replay-independent-cpu-audit.json')
allowed = {'24evaluate_contact_tangent': ['arg-30'], '28multiply_joint_drive_tangent': ['arg-18'],
           '32multiply_rolling_contact_tangent': ['arg-2'], '26multiply_matrix_and_reduce': ['arg-9']}
assert all(row['different_output_labels'] == allowed[row['kind']] for row in cpu['failures'])
context = read('capture/context-independent-cpu.json')
assert context['all1300_observed_links_have_same_address_and_bytes'] and context['all100_initial_extra_buffers_zero']
operands = read('capture/atomic-operands/independent-cpu.json')
assert operands['atomic_operands_equal'] == 545056
folds = read('capture/scalar-folds-v2/GPU-report.json')
audit = read('capture/scalar-folds-v2/independent-cpu.json')
assert folds['complete'] and folds['error'] is None and folds['actual_GPU_calls'] == 1785
assert audit['actual_GPU_scalar_calls'] == 1785 and audit['differing_extra_chain_replay_words_covered'] == 892
assert audit['history_words_checked'] == 62940
assert not audit['production_global_order_inferred'] and not audit['whole_solver_complete']
scripts = []
for path in sorted(BASE.rglob('*.py')):
    text = path.read_text()
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), path
    scripts.append(str(path.relative_to(ROOT)))
(BASE / 'publication-checks.json').write_text(json.dumps({
    'Python_AST_and_128_column_files_checked': scripts, 'all_passed': True,
    'production_changed': False, 'GPU_used_for_this_freeze': False, 'whole_solver_complete': False}, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == OUTPUT:
        continue
    data = path.read_bytes()
    assert len(data) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
result = {'files': files, 'complete_first_NL_extra_chain_iterations': 50, 'complete_packets': 800,
          'three_backend_calls': 2400, 'strict_packets': 552, 'non_strict_packets': 248,
          'actual_instrumented_calls': 496, 'matching_actual_atomic_operands': 545056,
          'observed_same_address_and_byte_links': 1300, 'differing_words': 892, 'real_GPU_target_certificates': 1785,
          'actual_GPU_history_words_verified': 62940, 'independent_fold_CPU_actual_exit': 0,
          'local_packets_checked_by_strict_outputs_or_actual_operands_and_F32_targets': 800,
          'production_joint_global_order_inferred': False, 'full_RHS_and_preconditioner_assembly_verified': False,
          'all_five_NL_iterations_verified': False, 'old_failures_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Frozen complete first-NL extra chains:', len(files), 'files; RHS/preconditioners/later NL still pending')
