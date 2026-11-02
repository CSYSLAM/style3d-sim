"""Independently check saved GPU velocity failures and the actual generated CUDA predicate on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
PHASE = BASE / 'functional-tests/anymal-predicate'
OUTPUT = PHASE / 'independent-cpu.json'
assert not OUTPUT.exists()
report = json.loads((PHASE / 'report.json').read_text())
hashes = dict(report['input_sha256'])
assert report['extracted_Warp_lambda_body'].strip() == 'max(abs(qd))'
cuda = (PHASE / 'actual-first-functional-run-generated.cu').read_text()
body = cuda.split('static CUDA_CALLABLE wp::float32 func_', 1)[1].split('return var_1;', 1)[0]
assert 'wp::abs(var_qd)' in body and 'wp::max(var_0)' in body and '0.25' not in body
rows = []
for row in report['rows']:
    backend = row['backend']
    path = PHASE / (backend + '-raw.npz')
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    with np.load(path, allow_pickle=False) as raw:
        with np.load(BASE / 'functional-tests/anymal' / (backend + '.npz'), allow_pickle=False) as final:
            assert np.array_equal(raw['q'].view('<u4'), final['body_q'].view('<u4'))
            assert np.array_equal(raw['qd'].view('<u4'), final['body_qd'].view('<u4'))
        failed = np.any(np.abs(raw['qd']) >= 0.25, axis=1)
        assert failed.shape == (136,) and failed.all()
        assert np.array_equal(raw['GPU_failures'], failed.astype('i4'))
        assert np.array_equal(raw['CPU_failures'], failed)
        assert row['GPU_direct_failure_count'] == row['authored_python_predicate_failure_count'] == 136
        assert not row['settled_velocity_requirement_passed']
        assert row['existing_helper_with_authored_lambda_returned_without_error']
        assert row['explicit_same_bound_helper_raised'].startswith('Test "explicit original bound" failed')
    rows.append({'backend': backend, 'actual_GPU_velocity_bound_failures_independently_verified': 136,
                 'false_pass_confirmed': True, 'settling_accepted': False})
for path in (Path(__file__), PHASE / 'report.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest, path
OUTPUT.write_text(json.dumps({'rows': rows, 'input_sha256': hashes, 'GPU_used': False,
                              'original_and_source_settling_failures_retained': True}, indent=2) + '\n')
print('CPU verified272 actual GPU velocity failures and generated CUDA omission;ANYmal settling remains failed')
