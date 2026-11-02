"""Select all real linear calls in the first nonlinear solve of the unchanged H1 inline graph."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer

TOKENS = {'rhs': '14initialize_rhsE', 'inverse': '27invert_block_preconditionerE'}
for iteration in range(20):
    TOKENS.update({f'{kind}_{iteration:02d}': token for kind, token in (
        ('precondition', '23precondition_and_reduceI'), ('direction', '19update_cg_directionE'),
        ('matrix', '26multiply_matrix_and_reduceI'), ('update', '28update_solution_and_residualE'))})
TOKENS['apply'] = '20apply_nonlinear_stepE'


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 6120 and body_count == 46 and dof_count == 51
    assert '15initialize_stepE' in nodes[55]['name']
    n, maximum, result = 33887, 27, []
    for key, token in TOKENS.items():
        matches = [i for i in range(56, 359) if token in nodes[i].get('name', '')]
        kind = key.split('_', 1)[0]
        assert len(matches) == (1 if kind in ('rhs', 'inverse', 'apply') else 20)
        iteration = int(key.rsplit('_', 1)[1]) if '_' in key else 0
        rank = matches[iteration]
        node = nodes[rank]
        assert node['geometry'] == [133, 1, 1, 256, 1, 1, 0]
        if kind == 'rhs':
            assert rank == 63 and node['parameter_widths'] == [4] + [8] * 11
            assert [integer(node, i) for i in (6, 10, 11)] == [maximum, n, n]
            sizes = {1: n * 12, 2: n * 12, 3: n * 4, 4: n * 4, 5: maximum * n * 8,
                     7: n * 12, 8: n * 4, 9: n * 12}
            outputs = [9]
        elif kind == 'inverse':
            assert rank == 93 and node['parameter_widths'] == [8] * 6
            assert integer(node, 4) == integer(node, 5) == n and integer(node, 0) == integer(node, 3)
            sizes, outputs = {0: n * 36, 1: n * 4, 2: n * 4, 3: n * 36}, [3]
        elif kind == 'precondition':
            assert node['parameter_widths'] == [8, 8, 8, 1, 8, 4, 8, 8]
            assert integer(node, 3) == integer(node, 4) == 0 and integer(node, 5) == integer(node, 7) == n
            sizes, outputs = {0: n * 36, 1: n * 12, 2: n * 12, 6: 4}, [2, 6]
        elif kind == 'direction':
            assert node['parameter_widths'] == [4, 8, 8, 4, 8, 8, 8, 8]
            assert integer(node, 0) == iteration and integer(node, 2) == 0
            assert integer(node, 3) == integer(node, 7) == n and bool(integer(node, 5)) == (iteration > 0)
            sizes, outputs = {1: n * 12, 4: 4, 6: n * 12}, [6]
            if integer(node, 5):
                sizes[5] = 4
        elif kind == 'matrix':
            assert node['parameter_widths'] == [8] * 8 + [4] + [8] * 3
            assert integer(node, 2) == maximum and integer(node, 7) == 0
            assert [integer(node, i) for i in (8, 10, 11)] == [n, n, n]
            sizes = {0: n * 4, 1: maximum * n * 40, 3: n * 36, 4: n * 12,
                     5: n * 12, 6: n * 12, 9: 4}
            outputs = [6, 9]
        elif kind == 'update':
            assert node['parameter_widths'] == [8, 4, 8, 8, 8, 8, 8, 8, 8]
            assert integer(node, 0) == 0 and integer(node, 1) == integer(node, 8) == n
            sizes, outputs = {2: 4, 3: 4, 4: n * 12, 5: n * 12, 6: n * 12, 7: n * 12}, [6, 7]
        else:
            assert kind == 'apply' and rank == 358 and node['parameter_widths'] == [8] * 4
            assert integer(node, 3) == n
            sizes, outputs = {0: n * 12, 1: n * 12, 2: n * 12}, [1, 2]
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind and integer(node, i)}
        assert set(sizes) == pointers
        overlaps = []
        for left in outputs:
            for right in sizes:
                if left == right:
                    continue
                start = max(integer(node, left), integer(node, right))
                end = min(integer(node, left) + sizes[left], integer(node, right) + sizes[right])
                if start < end:
                    assert key == 'inverse' and {left, right} == {0, 3} and end - start == n * 36
                    overlaps.append({'arguments': [left, right], 'overlap_bytes': end - start})
        result.append({'key': key, 'kernel_key': key.split('_', 1)[0], 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': overlaps})
    assert len(result) == 83 and [s['rank'] for s in result] == sorted(s['rank'] for s in result)
    return result
