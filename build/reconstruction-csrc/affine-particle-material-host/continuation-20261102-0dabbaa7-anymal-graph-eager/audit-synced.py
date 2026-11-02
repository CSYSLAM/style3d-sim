"""Audit unchanged SDK/source diagnostic variants and exact first-predictor input/output equivalence entirely on CPU."""
import hashlib
import json
from pathlib import Path

import numpy as np

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'synced-independent-cpu.json'
assert not OUTPUT.exists()
hashes, rows, predictors = {}, [], {}


def read(path):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
    return json.loads(path.read_text())


for directory, expected_count in [('synced-tests', 2), ('first-predictors', 4)]:
    plan = read(BASE / directory / 'plan.json')
    hashes.update(plan['input_sha256'])
    status = read(BASE / directory / 'status.json')
    assert status['complete'] and status['running'] is None and len(status['completed']) == expected_count
    for worker in status['completed']:
        backend = worker['backend']
        if directory == 'synced-tests':
            report = read(BASE / directory / (backend + '.json'))
            assert worker['actual_exit'] == report['exit'] == 1
            assert report['final_test_entered'] and not report['final_test_returned']
            assert report['error'].startswith('ValueError: Test "all bodies are above the ground" failed')
            assert report['reference_solver_mapped'] == (backend == 'original')
            path = BASE / directory / (backend + '.npz')
            with np.load(path, allow_pickle=False) as data:
                assert all(np.isfinite(data[key]).all() for key in data.files)
                height_failure = data['body_q'][:, 2] <= -0.006
                velocity_failure = np.max(np.abs(data['body_qd']), axis=1) >= 0.25
                assert height_failure.sum() == 32 and not velocity_failure.any()
                rows.append({'backend': backend, 'actual_exit': 1, 'height_failure_count': int(height_failure.sum()),
                             'minimum_body_z': float(data['body_q'][:, 2].min()),
                             'maximum_body_z': float(data['body_q'][:, 2].max()),
                             'maximum_absolute_spatial_velocity': float(np.abs(data['body_qd']).max()),
                             'velocity_bound_passed': True, 'whole_authored_test_passed': False})
        else:
            assert worker['actual_exit'] == 0
            tag = backend + '-' + worker['variant']
            report = read(BASE / directory / tag / 'report.json')
            assert report['reference_mapped'] == (backend == 'original')
            assert report['first_predictor_observed_before_native_step']
            path = BASE / directory / tag / 'raw.npz'
            assert hashlib.sha256(path.read_bytes()).hexdigest() == report['raw_sha256']
            with np.load(path, allow_pickle=False) as data:
                predictors[tag] = {key: data[key].copy() for key in data.files}
        hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
checks = []
for variant in ('original', 'synced'):
    a, b = predictors['original-' + variant], predictors['source-' + variant]
    fields = ['body_q', 'predicted_body_q', 'indices', 'body_ids', 'body_com', 'particle_q', 'dt',
              'actual_first_predictor_particle_qd']
    assert all(a[key].dtype == b[key].dtype and a[key].tobytes() == b[key].tobytes() for key in fields)
    centers = a['indices'][:, 0]
    values = a['actual_first_predictor_particle_qd'][centers]
    checks.append({'variant': variant, 'all_actual_predictor_inputs_and_outputs_bitwise_equal': True,
                   'center_z_velocity_min': float(values[:, 2].min()),
                   'center_z_velocity_max': float(values[:, 2].max())})
for path in (Path(__file__), BASE / 'synced-variant.json'):
    hashes[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
for path, digest in hashes.items():
    assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == digest
OUTPUT.write_text(json.dumps({'synced_Graph500': rows, 'first_predictors': checks, 'input_sha256': hashes,
    'GPU_used': False, 'original_example_and_solver_changed': False, 'diagnostic_variant_promoted': False,
    'old_frozen_failures_reclassified': False, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({'synced_Graph500': rows, 'first_predictors': checks}, indent=2))
