"""Watch actual accumulator buffers through first H1 force/Hessian assembly; this is not a full-input kernel audit."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer

RANKS = (63, 64, 65, 66, 68, 69, 70, 71, 72, 75, 76, 77, 78, 79, 80,
         81, 83, 85, 86, 87, 88, 89, 90, 91, 92)
TOKENS = {f'rank-{rank:03d}': None for rank in RANKS}


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 6120 and body_count == 46 and dof_count == 51
    assert '14initialize_rhsE' in nodes[63]['name'] and '27invert_block_preconditionerE' in nodes[93]['name']
    assert 'self_collision_kernel20add_hessian_diagonalE' in nodes[88]['name']
    first_matrix = next(node for node in nodes[98:359] if '26multiply_matrix_and_reduceI' in node.get('name', ''))
    n = 33887
    buffers = {integer(nodes[63], 9): ('rhs', n * 12), integer(nodes[93], 0): ('blocks', n * 36),
               integer(nodes[81], 2): ('base_blocks', n * 36),
               integer(first_matrix, 1): ('entries', 27 * n * 40),
               integer(nodes[88], 0): ('self_hessian', n * 36),
               integer(nodes[81], 0): ('diagonal', n * 4)}
    assert len(buffers) == 6 and 0 not in buffers
    result = []
    for rank in RANKS:
        node = nodes[rank]
        assert node['type'] == 0 and node['owned_kernel']
        selected = {i: buffers[integer(node, i)] for i, kind in enumerate(parameter_types(node['name']))
                    if '*' in kind and integer(node, i) in buffers}
        assert selected, (rank, node['name'])
        sizes = {i: item[1] for i, item in selected.items()}
        result.append({'key': f'rank-{rank:03d}', 'kernel_key': f'rank-{rank:03d}', 'rank': rank,
                       'node': node, 'sizes': sizes, 'outputs': list(sizes), 'output_overlaps': [],
                       'watched_buffers': {i: item[0] for i, item in selected.items()},
                       'full_kernel_input_capture': False})
    return result
