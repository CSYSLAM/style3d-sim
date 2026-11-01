"""Verify how the unchanged multiline G1 velocity predicate is translated by the installed Warp helper."""
import ast
import hashlib
import inspect
import json
import os
from pathlib import Path
import subprocess
import time
import types

import numpy as np
import warp as wp
import newton.examples

BASE = Path(__file__).resolve().parent
ROOT = Path.cwd()
plan = json.loads((BASE / 'plan.json').read_text())
example = ROOT / 'examples/example_robot_g1.py'
assert hashlib.sha256(example.read_bytes()).hexdigest() == plan['input_sha256'][str(example)]
output = BASE / 'end-test-translation-audit.json'
assert not output.exists()
tree = ast.parse(example.read_text())
cls = next(node for node in tree.body if isinstance(node, ast.ClassDef) and node.name == 'Example')
method = next(node for node in cls.body if isinstance(node, ast.FunctionDef) and node.name == 'test_final')
captured = []


def collect(*args, **kwargs):
    captured.append((args[2], args[3]))


namespace = {'newton': types.SimpleNamespace(examples=types.SimpleNamespace(test_body_state=collect))}
exec(compile(ast.Module(body=[method], type_ignores=[]), str(example), 'exec'), namespace)
namespace['test_final'](types.SimpleNamespace(model=None, state_0=None))
name, predicate = next((name, fn) for name, fn in captured if name == 'all body velocities are small')
converted, _ = wp.utils.create_warp_function(predicate)
source = converted.adj.source
assert 'return max(abs(qd))' in source and '<' not in source
wp.config.kernel_cache_dir = str(BASE / 'end-test-cache')
profiles = {
    'zero': np.zeros(6, dtype='f4'),
    'small_angular': np.asarray([0, 0, 0, 0, 0.01, 0], dtype='f4'),
    'large_angular': np.asarray([0, 0, 0, 0, 23, 0], dtype='f4'),
    'large_all': np.full(6, 23, dtype='f4'),
}
q = np.asarray([[0, 0, 1, 0, 0, 0, 1]], dtype='f4')
rows, waits = [], []
for device in ('cpu', 'cuda:0'):
    if device == 'cuda:0':
        while True:
            live = subprocess.check_output(
                ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()
            foreign = [line for line in live.splitlines() if int(line.split(',', 1)[0]) != os.getpid()]
            waits.append({'compute_apps': live, 'own_context_excluded': os.getpid(), 'foreign': foreign})
            if not foreign:
                break
            print('Waiting for observed foreign GPU processes:', foreign, flush=True)
            time.sleep(2)
    for label, velocity in profiles.items():
        state = types.SimpleNamespace(body_q=wp.array(q, dtype=wp.transform, device=device),
                                      body_qd=wp.array(velocity.reshape(1, 6), dtype=wp.spatial_vector, device=device))
        model = types.SimpleNamespace(body_count=1, body_label=['sentinel'])
        expected = bool(predicate(q[0], velocity))
        error, passed = None, True
        try:
            newton.examples.test_body_state(model, state, name, predicate)
        except ValueError as problem:
            error, passed = str(problem), False
        rows.append({'device': device, 'case': label, 'velocity': velocity.tolist(),
                     'original_Python_predicate': expected, 'actual_Newton_Warp_helper_passed': passed,
                     'ValueError_preserved': error, 'different_from_intended_predicate': passed != expected})
        print(device, label, 'Python intended', expected, 'actual helper', passed, flush=True)
assert len(rows) == 8
assert all(row['actual_Newton_Warp_helper_passed'] == (row['case'] != 'zero') for row in rows)
intended_on_recorded = []
for run in plan['runs']:
    with np.load(BASE / run['label'] / 'recorded-states.npz', allow_pickle=False) as data:
        velocities = data['body_qd'][0]
        intended = [bool(predicate(data['body_q'][0, body], value)) for body, value in enumerate(velocities)]
        intended_on_recorded.append({'label': run['label'], 'max_abs_body_qd': float(np.abs(velocities).max()),
                                     'intended_velocity_condition_all_bodies': all(intended)})
sources = [example, Path(inspect.getsourcefile(newton.examples.test_body_state)),
           Path(inspect.getsourcefile(wp.utils.create_warp_function)), Path(inspect.__file__), Path(__file__)]
result = {
    'original_predicate_source_from_inspect': inspect.getsource(predicate),
    'Warp_converted_function_source': source, 'original_test_name': name, 'sentinel_results': rows,
    'controlled_recorded_state_intended_checks': intended_on_recorded,
    'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest() for path in sources},
    'GPU_wait_observations': waits, 'original_example_or_test_helper_modified': False,
    'CLI_exit0_is_not_evidence_of_the_intended_velocity_bound': True,
    'diagnostic_numeric_C_comparison_unchanged': True, 'old_C8_reclassified': False, 'whole_solver_complete': False,
}
output.write_text(json.dumps(result, indent=2) + '\n')
print('Original multiline velocity comparison is missing from the translated helper on CPU and CUDA', flush=True)
