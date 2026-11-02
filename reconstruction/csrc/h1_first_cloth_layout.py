"""Full actual first-H1 stretch/bend inputs and the self-Hessian diagonal consumer, with exact graph ABI guards."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer

TOKENS = {'stretch': None, 'bend': None, 'self-add': None}


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 6120 and body_count == 46 and dof_count == 51
    n, triangles, edges, result = 33887, 66930, 100634, []
    for key, rank in [('stretch', 79), ('bend', 80), ('self-add', 88)]:
        node = nodes[rank]
        if key == 'stretch':
            assert '22evaluate_stretch_forceE' in node['name']
            assert node['geometry'] == [262, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (6, 7, 8)] == [triangles, triangles, n]
            sizes = {0: n * 12, 1: triangles * 4, 2: triangles * 16,
                     3: triangles * 12, 4: triangles * 12, 5: n * 12}
            outputs = [5]
        elif key == 'bend':
            assert '22evaluate_bending_forceE' in node['name']
            assert node['geometry'] == [394, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (8, 9, 10)] == [edges, edges, n]
            sizes = {0: n * 12, 1: n * 12, 2: edges * 4, 3: edges * 16,
                     4: edges * 16, 5: edges * 8, 7: n * 12}
            outputs = [7]
        else:
            assert 'self_collision_kernel20add_hessian_diagonalE' in node['name']
            assert node['geometry'] == [133, 1, 1, 256, 1, 1, 0] and integer(node, 2) == n
            sizes, outputs = {0: n * 36, 1: n * 36}, [1]
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind and integer(node, i)}
        assert set(sizes) == pointers
        for left in outputs:
            for right in sizes:
                if left != right:
                    assert min(integer(node, left) + sizes[left], integer(node, right) + sizes[right]) <= max(
                        integer(node, left), integer(node, right)), (key, left, right, 'Unexpected output alias')
        result.append({'key': key, 'kernel_key': key, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': [],
                       'full_kernel_input_capture': True})
    return result
