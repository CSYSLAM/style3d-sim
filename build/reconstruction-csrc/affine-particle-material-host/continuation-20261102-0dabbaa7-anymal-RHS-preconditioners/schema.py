"""Complete flat and embedded-view extents for all five actual ANYmal RHS/preconditioner assemblies."""
from collections import Counter
import importlib.util
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
EXTRA = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-CG-extra'
spec = importlib.util.spec_from_file_location('verified_extra_schema', EXTRA / 'schema.py')
extra = importlib.util.module_from_spec(spec)
spec.loader.exec_module(extra)
N, P, W, B, S, J, D, C, Q = extra.N, extra.P, extra.W, extra.B, extra.S, extra.J, extra.D, extra.C, extra.Q
I, PRE, U = '27invert_block_preconditioner', '23precondition_and_reduce', '28update_solution_and_residual'
APPLY = '20apply_nonlinear_step'
RHS, FORCE = '14initialize_rhs', '22evaluate_contact_force'
ROLL_FORCE, SOFT = '30evaluate_rolling_contact_force', '27evaluate_soft_contact_force'
BODY, JOINT = '26evaluate_body_spring_force', '53evaluate_joint_body_spring_augmented_lagrangian_force'
LOAD, SO3 = '25evaluate_joint_drive_load', '51evaluate_affine_body_so3_augmented_lagrangian_force'
BLOCK = '25initialize_block_diagonal'
SO3_PRE, DRIVE_PRE = '55add_affine_body_so3_augmented_lagrangian_preconditioner', '30add_joint_drive_preconditioner'
ROLL_PRE = '34add_rolling_contact_preconditioner'
SO3_STATE = '49update_affine_body_so3_augmented_lagrangian_state'
JOINT_STATE = '51update_joint_body_spring_augmented_lagrangian_state'
VELOCITY, ANGLE = '15update_velocity', '30update_joint_drive_angle_state'
CONTACT, LIMIT = extra.CONTACT, extra.LIMIT
core_path = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-first-CG/full50/plan.json'
core = json.loads(core_path.read_text())['fields']
FLAT = {key: {int(i): n for i, n in core[key].items()} for key in (I, PRE, U, APPLY)}
FLAT.update({
    RHS: {1: N * 12, 2: N * 12, 3: P * 4, 4: P * 4, 5: P * 19 * 8, 7: N * 12, 8: P * 4, 9: N * 12},
    FORCE: {**{i: n for i, n in extra.FLAT[CONTACT].items() if i < 27}, 28: N * 12, 29: N * 12,
            30: N * 12, 32: N * 12, 33: N * 4},
    ROLL_FORCE: {1: N * 12},
    SOFT: {0: 4, 2: Q * 4, 3: Q * 4, 4: Q * 12, 5: Q * 12, 6: Q * 12, 7: P * 4, 8: P * 4,
           9: P * 4, 12: S * 4, 13: S * 4, 14: S * 28, 15: S * 12, **{i: S * 4 for i in range(16, 21)},
           28: B * 4, 29: B * 16, 30: B * 12, 32: N * 12, 33: N * 12, 34: N * 12, 36: N * 12,
           37: N * 4, 38: 4, 40: N * 36, 41: N * 36},
    BODY: {0: N * 12, 1: B * 16, 2: 36 * 8, 3: 36 * 12, 4: 36 * 12, 5: 36 * 16, 6: 36 * 16,
           7: 36 * 4, 8: 36 * 4, 12: N * 12},
    JOINT: {0: N * 12, 1: B * 16, 2: 36 * 8, 3: 36 * 12, 4: 36 * 12, 5: 36 * 16, 6: 36 * 16,
            7: 36 * 4, 8: 36 * W * 12, 10: N * 12},
    LOAD: {0: N * 12, 1: N * 12, 2: J * W * 4, 3: J * W * 4, 4: J * W * 4, 5: B * 16,
           6: J * 4, 7: J * 8, 8: J * 12, 9: J * 12, 10: J * 12, **{i: J * 16 for i in range(11, 16)},
           16: J * 4, 17: J * 4, **{i: D * 4 for i in range(18, 23)},
           **{i: D * W * 4 for i in range(23, 26)}, 26: N * 12},
    SO3: {0: N * 12, 1: B * 16, 2: B * 4, 3: B * W * 36, 4: B * W * 36, 6: N * 12},
    BLOCK: {0: N * 4, 1: N * 36, 2: N * 36},
    CONTACT: extra.FLAT[CONTACT], LIMIT: extra.FLAT[LIMIT],
    SO3_PRE: {0: B * 16, 1: B * 4, 2: B * W * 36, 4: N * 36},
    DRIVE_PRE: {0: N * 12, 1: B * 16, 2: J * 4, 3: J * 8, 4: J * 12, 5: J * 12, 6: J * 12,
                **{i: J * 16 for i in range(7, 12)}, 12: J * 4, 13: D * 4, 14: D * 4, 15: D * 4, 17: N * 36},
    ROLL_PRE: {1: N * 36},
    SO3_STATE: {0: N * 12, 1: B * 16, 2: B * W * 36, 3: B * W * 36},
    JOINT_STATE: {0: N * 12, 1: B * 16, 2: 36 * 8, 3: 36 * 12, 4: 36 * 12, 5: 36 * 16, 6: 36 * 16,
                  7: 36 * W * 12},
    VELOCITY: {1: N * 12, 2: N * 12, 3: N * 12},
    ANGLE: {0: N * 12, 1: J * W * 4, 2: J * W * 4, 3: B * 16, 4: J * 4, 5: J * 8,
            6: J * 12, 7: J * 12, 8: J * 12, **{i: J * 16 for i in range(9, 14)}},
})
VIEWS = {LIMIT: extra.VIEWS[LIMIT], ROLL_FORCE: extra.VIEWS[extra.ROLL], ROLL_PRE: extra.VIEWS[extra.ROLL]}
integer, types = extra.integer, extra.types


def fields(node):
    key = node['key']
    kinds = types(node['name'])
    assert {i for i, kind in enumerate(kinds) if '*' in kind} == set(FLAT[key]), (key, kinds)
    result = [{'argument': i, 'offset': 0, 'bytes': size, 'label': 'arg-' + str(i)}
              for i, size in FLAT[key].items()]
    for i, (kind, width, pointers) in VIEWS.get(key, {}).items():
        assert kinds[i].endswith(kind) and node['parameter_widths'][i] == width
        result.extend({'argument': i, 'offset': o, 'bytes': n, 'label': f'view-{i}-{o}'} for o, n in pointers.items())
    return result


def outputs(node):
    return ['arg-' + str(i) for i, kind in enumerate(types(node['name']))
            if '*' in kind and 'const' not in kind and integer(node, i)]


def validate(node):
    key = node['key']
    expected = {
        RHS: {6: 19, 10: N, 11: P}, FORCE: {1: C, 20: S, 21: 55, 22: W, 26: B, 27: P},
        SOFT: {1: Q, 10: P, 11: N, 21: S, 22: 55, 23: W, 31: B, 39: 0},
        BODY: {10: 36, 11: 0, 13: 36 * W, 14: 36, 15: P}, JOINT: {11: 36 * W, 12: 36, 13: 36, 14: P},
        LOAD: {27: J * W, 28: J, 29: P, 30: D, 31: D}, SO3: {7: B * W, 8: B, 9: P}, BLOCK: {3: N},
        SO3_PRE: {5: B * W, 6: B, 7: P}, DRIVE_PRE: {18: J * W, 19: J, 20: P}, I: {4: N, 5: P},
        PRE: {5: P, 7: N}, U: {1: P, 8: N}, APPLY: {3: N}, SO3_STATE: {5: B * W, 6: B, 7: P},
        JOINT_STATE: {8: 36 * W, 9: 36, 10: 36, 11: P}, VELOCITY: {4: N}, ANGLE: {14: J * W, 15: J, 16: P},
    }.get(key, {})
    for i, value in expected.items():
        assert integer(node, i, width=node['parameter_widths'][i]) == value, (key, i)
    if key in (CONTACT, LIMIT):
        extra.validate_scalars(node)
    if key in (ROLL_FORCE, ROLL_PRE):
        extra.validate_scalars({**node, 'key': extra.ROLL})


def select(nodes):
    counts, selected, nl = Counter(), [], -1
    for node in nodes:
        key = node['key']
        ordinal = counts[key]
        counts[key] += 1
        if key == RHS:
            nl += 1
        keep = key in FLAT
        if key == CONTACT:
            keep = integer(node, 30) == 0
        elif key == LIMIT:
            keep = integer(node, 7) == 0
        elif key == PRE:
            keep = ordinal % 50 == 0
        elif key == U:
            keep = ordinal % 50 == 49
        if keep:
            assert 0 <= nl < 5
            selected.append({'node': node, 'call_ordinal': ordinal, 'NL_iteration': nl})
    assert nl == 4 and len(selected) == 111, (nl, len(selected))
    assert Counter(row['node']['key'] for row in selected)[JOINT_STATE] == 4
    return selected
