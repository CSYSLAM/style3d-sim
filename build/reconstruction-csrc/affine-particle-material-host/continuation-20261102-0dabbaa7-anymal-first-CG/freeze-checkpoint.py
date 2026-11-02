"""Freeze completed CG diagnostics without changing production or reclassifying trajectory failures."""
import ast
import hashlib
import json
from pathlib import Path

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'completion-manifest.json'
assert not OUTPUT.exists()


def read(name):
    return json.loads((BASE / name).read_text())


for name in ('capture/status.json', 'full50/status.json'):
    status = read(name)
    assert status['complete'] and status['running'] is None
    assert len(status['completed']) == 2 and all(row['actual_exit'] == 0 for row in status['completed'])
for prefix, packets, calls, strict in [('capture', 16, 48, 8), ('full50', 430, 1290, 232)]:
    result = read(prefix + '/full-input-replays/report.json')
    assert result['complete'] and result['error'] is None and result['actual_calls'] == calls
    assert len(result['packets']) == packets and result['strict_packets'] == strict
    status = read(prefix + '/operator-status-v2.json')
    assert status['complete'] and [row['actual_exit'] for row in status['completed']] == [1, 0]
context = read('full50/context-independent-cpu.json')
assert context['all1096_links_equal'] and not context['all_intermediate_extra_operator_producers_verified']
operands = read('full50/atomic-operands/independent-cpu.json')
assert operands['atomic_operands_equal'] == 108800
folds = read('full50/scalar-folds-v2/GPU-report.json')
audit = read('full50/scalar-folds-v2/independent-cpu.json')
assert folds['complete'] and folds['error'] is None and folds['actual_GPU_calls'] == 2303
assert audit['actual_GPU_scalar_calls'] == 2303 and audit['differing_PCG_replay_words_covered'] == 1017
assert audit['history_words_checked'] == 156604
assert not audit['production_global_order_inferred'] and not audit['whole_solver_complete']
scripts = []
for path in sorted(BASE.rglob('*.py')):
    text = path.read_text()
    ast.parse(text)
    assert all(len(line) <= 128 for line in text.splitlines()), path
    scripts.append(str(path.relative_to(ROOT)))
checks = {'Python_AST_and_128_column_files_checked': scripts, 'all_passed': True,
          'production_changed': False, 'GPU_used_for_this_freeze': False, 'whole_solver_complete': False}
(BASE / 'publication-checks.json').write_text(json.dumps(checks, indent=2) + '\n')
files = {}
for path in sorted(BASE.rglob('*')):
    if not path.is_file() or path == OUTPUT:
        continue
    data = path.read_bytes()
    assert len(data) < 100 * 1024 * 1024, path
    files[str(path.relative_to(ROOT))] = {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
result = {'files': files, 'partial_packets': 16, 'partial_three_backend_calls': 48, 'partial_strict_packets': 8,
          'full50_packets': 430, 'full50_three_backend_calls': 1290, 'full50_strict_packets': 232,
          'all_full50_vector_and_matrix_outputs_same_input_strict': True,
          'full50_matching_actual_atomic_operands': 108800, 'full50_observed_links_equal': 1096,
          'full50_differing_words': 1017, 'full50_real_GPU_fold_targets': 2303,
          'full50_GPU_history_words': 156604, 'full50_scalar_fold_independent_CPU_actual_exit': 0,
          'scalar_witnesses_prove_production_joint_global_order': False,
          'all_matrix_extra_producers_verified': False, 'old_failures_reclassified': False,
          'production_changed': False, 'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('Frozen CG phase:', len(files), 'files; actual results retained; extra producers still pending')
