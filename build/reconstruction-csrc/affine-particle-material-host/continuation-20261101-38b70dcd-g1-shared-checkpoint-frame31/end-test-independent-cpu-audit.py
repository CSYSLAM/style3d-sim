"""Audit saved negative controls and the original Python predicate without launching a GPU job."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import types

import numpy as np

BASE = Path(__file__).resolve().parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, default=BASE / 'end-test-independent-cpu-audit.json')
args = parser.parse_args()
assert not args.output.exists(), args.output
audit_path = BASE / 'end-test-translation-audit.json'
saved = json.loads(audit_path.read_text())
plan = json.loads((BASE / 'plan.json').read_text())
for name, expected in saved['input_sha256'].items():
    assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
example = next(Path(name) for name in saved['input_sha256'] if name.endswith('/examples/example_robot_g1.py'))
assert hashlib.sha256(example.read_bytes()).hexdigest() == plan['input_sha256'][str(example)]
tree = ast.parse(example.read_text())
cls = next(node for node in tree.body if isinstance(node, ast.ClassDef) and node.name == 'Example')
method = next(node for node in cls.body if isinstance(node, ast.FunctionDef) and node.name == 'test_final')
captured = []


def collect(*values, **kwargs):
    captured.append((values[2], values[3]))


namespace = {'newton': types.SimpleNamespace(examples=types.SimpleNamespace(test_body_state=collect))}
exec(compile(ast.Module(body=[method], type_ignores=[]), str(example), 'exec'), namespace)
namespace['test_final'](types.SimpleNamespace(model=None, state_0=None))
predicate = next(fn for name, fn in captured if name == 'all body velocities are small')
q = np.asarray([0, 0, 1, 0, 0, 0, 1], dtype='f4')
rows = saved['sentinel_results']
assert {(row['device'], row['case']) for row in rows} == {
    (device, case) for device in ('cpu', 'cuda:0')
    for case in ('zero', 'small_angular', 'large_angular', 'large_all')
}
assert len(rows) == 8
for row in rows:
    velocity = np.asarray(row['velocity'], dtype='f4')
    intended = bool(predicate(q, velocity))
    assert intended == bool(np.max(np.abs(velocity)) < 0.015) == row['original_Python_predicate']
    assert row['actual_Newton_Warp_helper_passed'] == bool(np.max(np.abs(velocity)))
    assert row['different_from_intended_predicate'] == (intended != row['actual_Newton_Warp_helper_passed'])
    assert (row['ValueError_preserved'] is not None) == (row['case'] == 'zero')
assert '<' not in saved['Warp_converted_function_source']
assert 'return max(abs(qd))' in saved['Warp_converted_function_source']
rechecked = []
for run, recorded in zip(plan['runs'], saved['controlled_recorded_state_intended_checks'], strict=True):
    assert run['label'] == recorded['label']
    with np.load(BASE / run['label'] / 'recorded-states.npz', allow_pickle=False) as data:
        qd, body_q = data['body_qd'][0], data['body_q'][0]
        intended = all(bool(predicate(q, v)) for q, v in zip(body_q, qd, strict=True))
        assert intended == recorded['intended_velocity_condition_all_bodies']
        assert float(np.abs(qd).max()) == recorded['max_abs_body_qd']
        assert not intended
        rechecked.append(run['label'])
old_report = next(Path(name) for name in plan['input_sha256'] if name.endswith('/report.json'))
assert hashlib.sha256(old_report.read_bytes()).hexdigest() == plan['old_fixed_report_sha256']
result = {
    'sentinels_rechecked': len(rows), 'recorded_outputs_rechecked': rechecked,
    'input_sha256': saved['input_sha256'],
    'saved_audit_sha256': hashlib.sha256(audit_path.read_bytes()).hexdigest(),
    'original_Python_predicate_and_recorded_numeric_values_rechecked': True,
    'actual_GPU_process_exit_not_observed_after_context_truncation': True,
    'GPU_process_exit_inferred_from_output': False,
    'original_example_and_dependencies_unchanged': True, 'old_C8_reclassified': False,
    'whole_solver_complete': False,
}
args.output.write_text(json.dumps(result, indent=2) + '\n')
print('CPU audit rechecked eight saved CPU/CUDA negative controls and eleven recorded velocity arrays')
