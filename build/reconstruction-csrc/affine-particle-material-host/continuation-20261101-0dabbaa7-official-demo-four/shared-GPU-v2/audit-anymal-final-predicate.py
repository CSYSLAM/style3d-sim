"""Reproduce a multiline-lambda false pass on saved ANYmal states;do not modify the example, solver or acceptance threshold."""
import ast
import hashlib
import inspect
import json
from pathlib import Path
import subprocess
from types import SimpleNamespace

import numpy as np
import warp as wp
import newton.examples
from warp._src.codegen import Adjoint

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'functional-tests/anymal-predicate'
PHASE.mkdir(exist_ok=False)
example = ROOT / 'examples/example_robot_anymal_d.py'
tree = ast.parse(example.read_text())
method = next(node for node in ast.walk(tree) if isinstance(node, ast.FunctionDef) and node.name == 'test_final')
lambdas = [node for node in ast.walk(method) if isinstance(node, ast.Lambda)]
assert len(lambdas) == 2
predicate = eval(compile(ast.Expression(lambdas[1]), str(example), 'eval'))
extracted = Adjoint.extract_lambda_source(predicate, only_body=True)
assert extracted.strip() == 'max(abs(qd))'
free = int(subprocess.check_output(
    ['nvidia-smi', '--id=0', '--query-gpu=memory.free', '--format=csv,noheader,nounits'], text=True).strip())
assert free >= 4096
apps = subprocess.check_output(
    ['nvidia-smi', '--query-compute-apps=pid,process_name', '--format=csv,noheader'], text=True).strip()


@wp.func
def velocity_small(q: wp.transform, qd: wp.spatial_vector):
    return wp.max(wp.abs(qd)) < 0.25


@wp.kernel
def direct_check(qd: wp.array(dtype=wp.spatial_vector), failures: wp.array(dtype=wp.int32)):
    i = wp.tid()
    failures[i] = wp.int32(wp.max(wp.abs(qd[i])) >= 0.25)


rows, hashes = [], {}
for path in (Path(__file__), example, Path(inspect.getfile(newton.examples.test_body_state)),
             Path(inspect.getfile(wp.utils.create_warp_function)), Path(inspect.getfile(Adjoint))):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for backend in ('original', 'source'):
    path = BASE / 'functional-tests/anymal' / (backend + '.npz')
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(path, allow_pickle=False) as data:
        q, qd = data['body_q'].copy(), data['body_qd'].copy()
    expected = np.max(np.abs(qd), axis=1) >= 0.25
    python_failures = np.asarray([not bool(predicate(a, b)) for a, b in zip(q, qd)])
    assert np.array_equal(python_failures, expected) and expected.all()
    model = SimpleNamespace(body_count=len(q), body_label=[str(i) for i in range(len(q))])
    with wp.ScopedDevice('cuda:0'):
        state = SimpleNamespace(body_q=wp.array(q, dtype=wp.transform), body_qd=wp.array(qd, dtype=wp.spatial_vector))
        newton.examples.test_body_state(model, state, 'authored multiline predicate', predicate)
        caught = None
        try:
            newton.examples.test_body_state(model, state, 'explicit original bound', velocity_small)
        except ValueError as error:
            caught = str(error)
        assert caught is not None
        failures = wp.zeros(len(q), dtype=wp.int32)
        wp.launch(direct_check, len(q), inputs=[state.body_qd], outputs=[failures])
        raw = failures.numpy()
        assert np.array_equal(raw, expected.astype('i4'))
    output = PHASE / (backend + '-raw.npz')
    np.savez_compressed(output, GPU_failures=raw, CPU_failures=expected, q=q, qd=qd)
    hashes[str(output.resolve())] = hashlib.sha256(output.read_bytes()).hexdigest()
    rows.append({'backend': backend, 'authored_python_predicate_failure_count': int(python_failures.sum()),
                 'existing_helper_with_authored_lambda_returned_without_error': True,
                 'explicit_same_bound_helper_raised': caught, 'GPU_direct_failure_count': int(raw.sum()),
                 'minimum_body_z': float(q[:, 2].min()), 'maximum_absolute_body_velocity': float(np.abs(qd).max()),
                 'settled_velocity_requirement_passed': False})
cache = Path.home() / '.cache/warp/1.16.0'
for path in cache.glob('wp_test_body_state__locals__test_fn_kernel_46f8bbf0*/*.cu'):
    content = path.read_text()
    if '// return max(abs(qd))' in content:
        target = PHASE / 'actual-first-functional-run-generated.cu'
        assert not target.exists()
        target.write_bytes(path.read_bytes())
        hashes[str(target.resolve())] = hashlib.sha256(target.read_bytes()).hexdigest()
assert (PHASE / 'actual-first-functional-run-generated.cu').is_file()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
report = {'rows': rows, 'extracted_Warp_lambda_body': extracted,
          'reason': 'The extracted lambda omits the next-line comparison, returning a positive float treated as True',
          'input_sha256': hashes, 'free_memory_MiB_before_launch': free, 'compute_apps': apps,
          'solver_or_example_modified': False, 'threshold_changed': False, 'whole_solver_complete': False}
(PHASE / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
print('ANYmal false pass reproduced on actual saved states;both backends fail all136 explicit velocity bounds')
