"""Actual first-H1 self producers and first full tangent; contact prefixes require observed counter coverage guards."""
from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import integer

TOKENS = {'vf': None, 'ee': None, 'ef': None, 'tangent': None}
CONTACT_RECORDS = 131072
FULL_CONTACT_RECORDS = 7284101


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 6120 and body_count == 46 and dof_count == 51
    n, vertices, edges, triangles, opposite, slots = 33887, 33703, 100634, 66930, 200790, 31
    result = []
    for key, rank in [('vf', 75), ('ee', 76), ('ef', 77), ('tangent', 102)]:
        node = nodes[rank]
        if key == 'vf':
            assert '22accumulate_vertex_faceE' in node['name'] and integer(node, 2) == 0
            assert node['geometry'] == [132, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (15, 16, 17, 18)] == [vertices, vertices, n, slots]
            sizes = {0: n * 12, 1: vertices * 4, 3: triangles * 12, 4: vertices * 4,
                     5: vertices * slots * 4, 6: n * 4, 11: n * 12, 12: n * 36}
            contact, counter, outputs = 13, 14, [11, 12, 13, 14]
        elif key == 'ee':
            assert '20accumulate_edge_edgeE' in node['name']
            assert node['geometry'] == [394, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (13, 14, 15, 16)] == [edges, edges, n, slots]
            sizes = {0: n * 12, 1: edges * 16, 2: (edges + 1) * 4, 3: opposite * 4,
                     4: edges * 4, 5: edges * slots * 4, 6: n * 4, 9: n * 12, 10: n * 36}
            contact, counter, outputs = 11, 12, [9, 10, 11, 12]
        elif key == 'ef':
            assert '20accumulate_edge_faceE' in node['name']
            assert node['geometry'] == [394, 1, 1, 256, 1, 1, 0]
            assert [integer(node, i) for i in (14, 15, 16, 17)] == [edges, edges, n, slots]
            sizes = {0: n * 12, 1: edges * 16, 2: (edges + 1) * 4, 3: opposite * 4,
                     4: triangles * 12, 5: edges * 4, 6: edges * slots * 4, 7: n * 4, 10: n * 12, 11: n * 36}
            contact, counter, outputs = 12, 13, [10, 11, 12, 13]
        else:
            assert '25multiply_contact_tangentsE' in node['name']
            assert node['geometry'] == [256, 1, 1, 256, 1, 1, 0]
            sizes = {2: n * 12, 3: n * 12}
            contact, counter, outputs = 0, 1, [3]
        sizes.update({contact: CONTACT_RECORDS * 60, counter: 4})
        pointers = {i for i, kind in enumerate(parameter_types(node['name'])) if '*' in kind and integer(node, i)}
        assert set(sizes) == pointers
        for left in outputs:
            for right in sizes:
                if left != right:
                    assert min(integer(node, left) + sizes[left], integer(node, right) + sizes[right]) <= max(
                        integer(node, left), integer(node, right)), (key, left, right, 'Unexpected output alias')
        result.append({'key': key, 'kernel_key': key, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': [],
                       'full_kernel_input_capture_requires_dynamic_prefix_guard': True,
                       'dynamic_contact_span': {'argument': contact, 'counter_argument': counter, 'record_bytes': 60,
                                                'captured_capacity': CONTACT_RECORDS,
                                                'actual_full_allocation_records': FULL_CONTACT_RECORDS}})
    return result


def validate_packet(stage, arrays):
    span = stage['dynamic_contact_span']
    counter, contact = span['counter_argument'], span['argument']
    before = int.from_bytes(arrays[f'before-arg-{counter}'].tobytes(), 'little')
    after = int.from_bytes(arrays.get(f'after-arg-{counter}', arrays[f'before-arg-{counter}']).tobytes(), 'little')
    assert 0 <= before <= after <= span['captured_capacity'], (stage['key'], before, after, 'Uncaptured active contacts')
    if contact in stage['outputs']:
        left, right = arrays[f'before-arg-{contact}'], arrays[f'after-arg-{contact}']
        assert left[:before * 60].tobytes() == right[:before * 60].tobytes()
        assert left[after * 60:].tobytes() == right[after * 60:].tobytes(), 'Unexpected writes beyond actual contact count'
    return {'before': before, 'after': after, 'all_active_contact_records_captured': True}
