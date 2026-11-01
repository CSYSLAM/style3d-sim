"""Locate the preserved public-state spike and inspect its affine input matrices without inferring hidden state."""
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
fixed = BASE.parent / 'continuation-20261101-38b70dcd-g1-public-core/graph60-fixed-original-C8/report.json'
assert hashlib.sha256(fixed.read_bytes()).hexdigest() == '32b6e2a7337aaa80442fa3fd6232896410eb8163e875d35d845d4a8ae82d4e42'
cohort = json.loads(fixed.read_text())
inputs = {str(fixed): hashlib.sha256(fixed.read_bytes()).hexdigest()}
for label, name in cohort['input_npz_paths'].items():
    actual = hashlib.sha256(Path(name).read_bytes()).hexdigest()
    assert actual == cohort['input_npz_sha256'][label], label
    inputs[name] = actual
mapping_path = BASE / 'original/so3_true-packets/frame-00.npz'
with np.load(mapping_path, allow_pickle=False) as packet:
    body_particles = packet['before-arg-1'].view('<i4').reshape(44, 4).copy()
assert sorted(body_particles.flatten().tolist()) == list(range(176))
inputs[str(mapping_path)] = hashlib.sha256(mapping_path.read_bytes()).hexdigest()


def affine_spectrum(positions, indices):
    matrix = positions[indices[1:]].astype(np.float64).T
    singular = np.linalg.svd(matrix, compute_uv=False)
    return {'columns': matrix.T.tolist(), 'determinant': float(np.linalg.det(matrix)),
            'singular_values': singular.tolist(), 'condition_number': float(singular[0] / singular[-1]),
            'orthogonality_residual': float(np.linalg.norm(matrix.T @ matrix - np.eye(3)))}


with ExitStack() as stack:
    arrays = {label: stack.enter_context(np.load(path, allow_pickle=False))
              for label, path in cohort['input_npz_paths'].items()}
    originals = [arrays['original' + str(i)] for i in range(8)]
    source = arrays['source1']
    for data in arrays.values():
        assert data['body_qd'].shape == (60, 44, 6) and data['particle_q'].shape == (60, 176, 3)
    values = np.stack([data['body_qd'].astype(np.float64) for data in originals])
    total, candidate = values.sum(0), source['body_qd'].astype(np.float64)
    error = np.abs(candidate - total / 8)
    frame, body, component = np.unravel_index(error.argmax(), error.shape)
    assert (int(frame), int(body), int(component)) == (31, 12, 4)
    assert float(error[frame, body, component]) == 23.851294673979282
    spread = np.maximum.reduce([np.abs(values[i] - (total - values[i]) / 7).max(axis=(1, 2)) for i in range(8)])
    assert float(spread[31]) == 1.2091027029923032
    neighbors = []
    for f in range(28, 34):
        indices = body_particles[body]
        particle_values = np.stack([data['particle_qd'][f].astype(np.float64) for data in originals])
        particle_error = np.abs(source['particle_qd'][f].astype(np.float64) - particle_values.mean(0))
        neighbors.append({
            'zero_based_frame': f, 'body_qd_max_error': float(error[f].max()),
            'body_qd_frozen_LOO_spread': float(spread[f]),
            'source_body12_qd': source['body_qd'][f, body].tolist(),
            'original_mean_body12_qd': (total[f, body] / 8).tolist(),
            'body12_proxy_particle_indices': indices.tolist(),
            'body12_proxy_qd_max_error': float(particle_error[indices].max()),
            'source_body12_affine': affine_spectrum(source['particle_q'][f], indices),
            'original_body12_affine': [affine_spectrum(data['particle_q'][f], indices) for data in originals],
        })
    spectra = []
    for f in (30, 31):
        for label, data in arrays.items():
            for b, indices in enumerate(body_particles):
                spectra.append({'label': label, 'zero_based_frame': f, 'body': b,
                                **affine_spectrum(data['particle_q'][f], indices)})
    report = {
        'spike': {'label': 'source1', 'zero_based_frame': int(frame), 'body': int(body),
                  'component': int(component), 'flat_component': int(body * 6 + component),
                  'error': float(error[frame, body, component]), 'LOO_spread': float(spread[frame]),
                  'ratio': float(error[frame, body, component] / spread[frame])},
        'neighbors': neighbors, 'all_body_affine_spectra_at_frames30_31': spectra,
        'next_step': 'Use the exact saved public particle positions as shared inputs to SDK/PTX/source SO3 initialization',
        'historical_hidden_multiplier_and_drive_angle_not_recorded': True,
        'replaying_old_internal_state_or_old_atomic_schedule_not_claimed': True,
        'GPU_test_of_frozen_public_inputs_done': False,
        'input_sha256': inputs, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'old_failure_reclassified': False, 'whole_solver_complete': False,
    }
output = BASE / 'frozen-spike-context.json'
assert not output.exists()
output.write_text(json.dumps(report, indent=2) + '\n')
print('Preserved spike:', report['spike'], flush=True)
print('Body12 spectra:', [(row['zero_based_frame'], row['source_body12_affine']['condition_number'],
                          row['source_body12_affine']['determinant']) for row in neighbors], flush=True)
