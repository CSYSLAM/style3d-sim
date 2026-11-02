"""Describe complete pointer extents for the actual fixed ANYmal first-NL extra-product kernels."""
from functools import lru_cache

from reconstruction.csrc.audit_cudahook import parameter_types

N, P, W, B, S, J, D, C, Q = 544, 68, 8, 17, 56, 12, 18, 1000, 30464
SO3 = '53multiply_affine_body_so3_augmented_lagrangian_tangent'
CONTACT = '24evaluate_contact_tangent'
SOFT = '42multiply_soft_contact_hessian_off_diagonal'
DRIVE = '28multiply_joint_drive_tangent'
LIMIT = '23evaluate_angular_limits'
ROLL = '32multiply_rolling_contact_tangent'
DIRECTION, MATRIX = '19update_cg_direction', '26multiply_matrix_and_reduce'
KEYS = (DIRECTION, SO3, CONTACT, SOFT, DRIVE, LIMIT, ROLL, MATRIX)
FLAT = {
    DIRECTION: {1: N * 12, 2: N * 4, 4: W * 4, 5: W * 4, 6: N * 12},
    SO3: {0: N * 12, 1: B * 16, 2: B * 4, 3: B * W * 36, 5: N * 12},
    CONTACT: {0: 4, 2: C * 4, 3: C * 4, **{i: C * 12 for i in range(4, 9)}, 9: C * 4, 10: C * 4,
              11: S * 4, 12: S * 4, 13: S * 28, 14: S * 12, **{i: S * 4 for i in range(15, 19)},
              23: B * 4, 24: B * 16, 25: B * 12, **{i: N * 12 for i in range(27, 31)}, 33: N * 36, 34: N * 36},
    SOFT: {0: 4, 2: Q * 4, 3: Q * 4, 4: Q * 12, 5: Q * 12, 6: P * 4, 7: S * 4, 8: S * 4,
           9: S * 28, 10: S * 12, 11: P * 4, 12: P * 4, 13: S * 4, 14: S * 4, 15: S * 4,
           19: B * 4, 20: B * 16, 21: B * 12, 23: N * 12, 24: N * 12, 25: N * 12,
           31: 4, 33: S * 4, 34: S * 4, 37: Q * 12, 38: N * 12},
    DRIVE: {0: N * 12, 1: N * 12, 2: B * 16, 3: J * 4, 4: J * 8, 5: J * 12, 6: J * 12, 7: J * 12,
            **{i: J * 16 for i in range(8, 13)}, 13: J * 4, 14: D * 4, 15: D * 4, 16: D * 4, 18: N * 12},
    LIMIT: {2: N * 12, 3: N * 12, 4: J * W * 4, 5: J * W * 4, 7: N * 12, 8: N * 12, 9: N * 36},
    ROLL: {1: N * 12, 2: N * 12},
    MATRIX: {0: N * 4, 1: N * 19 * 40, 3: N * 36, 4: N * 12, 5: N * 12,
             6: N * 12, 7: N * 4, 9: W * 4},
}
JOINT = {0: B * 16, 8: J * 4, 16: J * 8, 24: J * 12, 32: J * 12, 40: J * 12,
         **{i: J * 16 for i in range(48, 88, 8)}, 88: J * 4}
ROLLING = {0: 4, 16: C * 4, 24: C * 4, **{i: C * 12 for i in range(32, 72, 8)},
           72: C * 4, 80: C * 4, 88: S * 4, 96: S * 4, 104: S * 28, 112: S * 12,
           **{i: S * 4 for i in range(120, 152, 8)}, 176: B * 4, 184: B * 16, 192: B * 12,
           200: B * 36, 224: N * 12, 232: N * 12}
VIEWS = {LIMIT: {0: ('JointCoordinateView', 120, JOINT),
                 1: ('AngularLimitView', 32, {i: D * 4 for i in range(0, 32, 8)})},
         ROLL: {0: ('RollingContactView', 248, ROLLING)}}
WRITES = {DIRECTION: [6], SO3: [5], CONTACT: [30], SOFT: [25], DRIVE: [18], LIMIT: [8], ROLL: [2], MATRIX: [6, 9]}


def integer(node, argument, offset=0, width=8):
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][argument])[offset:offset + width], 'little')


@lru_cache(maxsize=None)
def types(name):
    return parameter_types(name)


def fields(node):
    key = node['key']
    kinds = types(node['name'])
    assert {i for i, kind in enumerate(kinds) if '*' in kind} == set(FLAT[key]), (key, kinds)
    result = [{'argument': i, 'offset': 0, 'bytes': size, 'label': 'arg-' + str(i)}
              for i, size in FLAT[key].items()]
    for i, (kind, width, pointers) in VIEWS.get(key, {}).items():
        assert kinds[i].endswith(kind) and node['parameter_widths'][i] == width
        result.extend({'argument': i, 'offset': offset, 'bytes': size, 'label': f'view-{i}-{offset}'}
                      for offset, size in pointers.items())
    return result


def validate_scalars(node):
    key = node['key']
    expected = {
        SO3: {6: B * W, 7: B, 8: P}, CONTACT: {1: C, 20: S, 21: 55, 22: W, 26: B, 32: P},
        SOFT: {1: Q, 16: S, 17: 55, 18: W, 22: B, 27: P, 30: N, 32: 0},
        DRIVE: {19: J * W, 20: J, 21: P}, MATRIX: {2: 19, 8: P, 10: N, 11: N},
        DIRECTION: {3: P, 7: N},
    }.get(key, {})
    for i, value in expected.items():
        assert integer(node, i, width=node['parameter_widths'][i]) == value, (key, i)
    if key == LIMIT:
        assert {i: integer(node, 0, i) for i in (96, 104, 112)} == {96: J, 104: J * W, 112: P}
    if key == ROLL:
        assert {i: integer(node, 0, i) for i in (8, 152, 160, 168, 208, 216)} == {
            8: C, 152: S, 160: 55, 168: W, 208: B, 216: P}
