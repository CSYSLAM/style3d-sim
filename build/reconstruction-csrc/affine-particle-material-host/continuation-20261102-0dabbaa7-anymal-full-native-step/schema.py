"""Complete all35 observed owned-kernel ABIs for the fixed ANYmal native step, including real CSR extents."""
from collections import Counter
import importlib.util
import json
from pathlib import Path

BASE = Path(__file__).resolve().parent
RHS_PATH = BASE.parent / 'continuation-20261102-0dabbaa7-anymal-RHS-preconditioners/schema.py'
spec = importlib.util.spec_from_file_location('verified_rhs5_schema', RHS_PATH)
rhs = importlib.util.module_from_spec(spec)
spec.loader.exec_module(rhs)
extra = rhs.extra
N, P, W, B, S, J, D, C, Q = rhs.N, rhs.P, rhs.W, rhs.B, rhs.S, rhs.J, rhs.D, rhs.C, rhs.Q
prefix = json.loads((BASE / 'csr-prefix/report.json').read_text())
assert prefix['original_source_all_prefix_bytes_equal']
actual_counts = {(r['kind'], r['argument']): r['actual_terminal_count']
                 for r in prefix['prefix_arrays'] if r['backend'] == 'original'}
REFRESH, DIAGONALS = '31refresh_inertial_cache_nonzeros', '32refresh_inertial_cache_diagonals'
STEP, SO3_INIT = '15initialize_step', '32initialize_affine_body_so3_state'
JOINT_INIT, COMBINE = '34initialize_joint_body_spring_state', '27combine_system_non_diagonal'
BLOCK_INIT = '29initialize_block_non_diagonal'
assert actual_counts == {(REFRESH, 1): 102, (REFRESH, 4): 102, (DIAGONALS, 1): 51}
ELL, MASS_VALUES = P * 19, 51
FLAT = dict(rhs.FLAT)
for key, values in extra.FLAT.items():
    if key in FLAT:
        assert FLAT[key] == values
    else:
        FLAT[key] = values
FLAT.update({
    REFRESH: {0: MASS_VALUES * 4, 1: (ELL + 1) * 8, 2: max(actual_counts[REFRESH, 1], 1) * 4,
              3: B * 4, 4: (ELL + 1) * 8, 5: max(actual_counts[REFRESH, 4], 1) * 4, 6: ELL * 8, 7: ELL * 8},
    DIAGONALS: {0: B * 4, 1: (P + 1) * 8, 2: max(actual_counts[DIAGONALS, 1], 1) * 4, 3: P * 4, 4: P * 4},
    STEP: {1: W * 12, 3: P * 4, 4: N * 12, 5: N * 12, 6: P * 4, 7: P * 4,
           9: P * 4, 11: P * 4, 13: P * 4, 15: P * 4, 17: P * 4, 18: P * 4, 19: P * 4,
           20: N * 12, 21: N * 12, 22: N * 4},
    SO3_INIT: {0: N * 12, 1: B * 16, 2: B * W * 36, 3: B * W * 36},
    JOINT_INIT: {0: 36 * W * 12},
    COMBINE: {i: ELL * 8 for i in range(6, 14)},
    BLOCK_INIT: {0: ELL * 8, 1: P * 4, 4: N * 19 * 40},
})
VIEWS = {**rhs.VIEWS, **extra.VIEWS}
integer, types = rhs.integer, rhs.types
assert len(FLAT) == 35


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


outputs = rhs.outputs


def validate(node):
    key = node['key']
    if key in rhs.FLAT:
        rhs.validate(node)
    elif key in extra.FLAT:
        extra.validate_scalars(node)
    else:
        expected = {REFRESH: {8: ELL}, DIAGONALS: {5: P}, STEP: {2: W, 23: N, 24: P},
                    SO3_INIT: {4: B * W, 5: B, 6: P}, JOINT_INIT: {1: 36 * W},
                    COMBINE: {14: ELL}, BLOCK_INIT: {2: P, 3: 19, 5: N}}[key]
        for i, value in expected.items():
            assert integer(node, i, width=node['parameter_widths'][i]) == value, (key, i)


def select(nodes):
    counts, selected, nl, cg = Counter(), [], -1, -1
    assert len(nodes) == 2608
    assert [n['owned_launch'] for n in nodes] == list(range(2608))
    assert {n['key'] for n in nodes} == set(FLAT)
    for node in nodes:
        key = node['key']
        ordinal = counts[key]
        counts[key] += 1
        if key == rhs.RHS:
            nl += 1
            cg = -1
        if key == rhs.PRE:
            cg += 1
            assert integer(node, 7) == N
        if key == extra.DIRECTION:
            assert integer(node, 0, width=4) == cg
        assert -1 <= nl < 5 and -1 <= cg < 50
        segment = 'initial' if nl == -1 else f'NL-{nl}-CG-{max(cg, 0) // 10}'
        selected.append({'node': node, 'call_ordinal': ordinal, 'NL_iteration': nl, 'CG_iteration': cg,
                         'segment': segment})
    assert nl == 4 and cg == 49
    assert all(counts[key] == 250 for key in (rhs.PRE, extra.DIRECTION, extra.MATRIX, rhs.U))
    return selected
