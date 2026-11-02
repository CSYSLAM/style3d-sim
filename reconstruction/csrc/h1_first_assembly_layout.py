"""Complete actual first-H1 soft-force, membrane-Hessian and soft-preconditioner inputs after accumulator localization."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer

TOKENS = {'soft-force': None, 'membrane': None, 'soft-matrix': None}


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 6120 and body_count == 46 and dof_count == 51
    n, shapes, bodies, capacity, triangles, result = 33887, 99, 46, 3354813, 66930, []
    for key, rank in [('soft-force', 66), ('membrane', 83), ('soft-matrix', 86)]:
        node = nodes[rank]
        if key.startswith('soft'):
            assert '27evaluate_soft_contact_forceE' in node['name']
            assert node['geometry'] == [13105, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (1, 10, 11, 21, 22, 23, 31)] == [capacity, n, n, shapes, shapes, 1, bodies]
            assert integer(node, 38) == integer(node, 39) == 0
            sizes = {0: 4, 2: capacity * 4, 3: capacity * 4, 4: capacity * 12, 5: capacity * 12, 6: capacity * 12,
                     7: n * 4, 8: n * 4, 9: n * 4, 12: shapes * 4, 13: shapes * 4, 14: shapes * 28,
                     15: shapes * 12, **{i: shapes * 4 for i in range(16, 21)},
                     28: bodies * 4, 29: bodies * 16, 30: bodies * 12, 32: n * 12, 33: n * 12, 34: n * 12}
            if key == 'soft-force':
                assert integer(node, 40) == integer(node, 41) == 0
                sizes.update({36: n * 12, 37: n * 4})
                outputs = [36, 37]
            else:
                assert integer(node, 36) == integer(node, 37) == 0
                sizes.update({40: n * 36, 41: n * 36})
                outputs = [40, 41]
        else:
            assert 'add_cloth_membrane_gauss_newton_hessian' in node['name']
            assert node['geometry'] == [262, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (8, 9, 10, 11, 12)] == [27, triangles, triangles, n, n]
            sizes = {0: n * 12, 1: triangles * 12, 2: triangles * 16, 3: triangles * 4,
                     4: triangles * 12, 5: n * 36, 6: n * 4, 7: n * 27 * 40}
            outputs = [5, 7]
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind and integer(node, i)}
        assert set(sizes) == pointers
        for left in outputs:
            for right in sizes:
                if left == right:
                    continue
                assert min(integer(node, left) + sizes[left], integer(node, right) + sizes[right]) <= max(
                    integer(node, left), integer(node, right)), (key, left, right, 'Unexpected output alias')
        result.append({'key': key, 'kernel_key': key, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': [],
                       'full_kernel_input_capture': True})
    return result
