"""Check the finite domain of inverse commutation and actual residual/zero/vector links independently."""
import hashlib
import json
from pathlib import Path

import numpy as np

BASE = Path(__file__).resolve().parent
plan = json.loads((BASE / 'plan.json').read_text())
for filename, digest in plan['input_sha256'].items():
    assert hashlib.sha256(Path(filename).read_bytes()).hexdigest() == digest, filename
result = {}
for label in ('sdk0', 'rebuilt0'):
    trace = BASE / label / 'trace'
    paths = {key: trace / (key + '-packets/frame-00.npz') for key in
             ('inverse', 'rhs', 'precondition_first', 'precondition_last', 'direction_first', 'update_first', 'update_last')}
    packets = {}
    for key, path in paths.items():
        with np.load(path, allow_pickle=False) as packet:
            packets[key] = {field: packet[field].copy() for field in packet.files}
    inverse = packets['inverse']
    matrix = inverse['before-arg-0'].view('<f4').reshape(176, 3, 3)
    assert np.isfinite(matrix).all()
    mass, flags = inverse['before-arg-1'].view('<f4'), inverse['before-arg-2'].view('<i4')
    assert np.isfinite(mass).all()
    active = (mass > 0) & ((flags & 1) != 0)
    s01, s02, s12 = [np.float32(np.float32(matrix[:, i, j] + matrix[:, j, i]) * np.float32(0.5))
                       for i, j in ((0, 1), (0, 2), (1, 2))]
    s00, s11, s22 = matrix[:, 0, 0], matrix[:, 1, 1], matrix[:, 2, 2]
    c00 = np.float32(np.float32(s11 * s22) - np.float32(s12 * s12))
    c01 = np.float32(np.float32(s02 * s12) - np.float32(s01 * s22))
    c02 = np.float32(np.float32(s01 * s12) - np.float32(s11 * s02))
    determinant = np.float32(np.float32(np.float32(s00 * c00) + np.float32(s01 * c01)) + np.float32(s02 * c02))
    assert np.isfinite(s01).all() and np.isfinite(s02).all() and np.isfinite(s12).all()
    assert np.isfinite(c00).all() and np.isfinite(c01).all() and np.isfinite(c02).all()
    assert np.isfinite(determinant).all()
    positive = determinant > np.float32(1e-30)
    for suffix in ('first', 'last'):
        precondition, update = packets['precondition_' + suffix], packets['update_' + suffix]
        assert precondition['before-arg-1'].tobytes() == update['before-arg-7'].tobytes()
        assert not precondition['before-arg-6'].view('<u4').any()
    assert not packets['update_first']['before-arg-6'].view('<u4').any()
    assert packets['precondition_first']['after-arg-2'].tobytes() == packets['direction_first']['after-arg-6'].tobytes()
    rhs_finite = {}
    for i in (1, 2, 3, 7):
        rhs_finite[str(i)] = bool(np.isfinite(packets['rhs']['before-arg-' + str(i)].view('<f4')).all())
    assert all(rhs_finite.values())
    result[label] = {'input_sha256': {str(path): hashlib.sha256(path.read_bytes()).hexdigest()
                                      for path in paths.values()},
                     'all_inverse_blocks_and_cofactors_finite': True,
                     'inverse_active_rows': int(active.sum()),
                     'inverse_positive_finite_determinant_rows': int(np.count_nonzero(active & positive)),
                     'inverse_diagonal_fallback_rows': int(np.count_nonzero(active & ~positive)),
                     'minimum_active_determinant': float(determinant[active].min()),
                     'finite_rhs_float_inputs': rhs_finite,
                     'first_solution_and_first_last_numerators_positive_zero': True,
                     'first_last_residual_consumer_and_first_direction_links_equal': True}
output = BASE / 'linear-input-audit.json'
assert not output.exists()
output.write_text(json.dumps({'sides': result, 'commuted_inverse_multiplication_finite_domain_checked': True,
                              'production_changed': False, 'whole_solver_complete': False}, indent=2) + '\n')
print(json.dumps({label: {k: v for k, v in side.items() if k != 'input_sha256'} for label, side in result.items()}, indent=2))
