"""Observe authentic RHS and PCG spans in the fixed PD contact graph without changing solver arithmetic."""
import ctypes as ct
import json

import numpy as np

from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import Observer as Transport, integer
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


def select_stages(nodes):
    result = []
    for rank, node in enumerate(nodes):
        name = node.get('name', '')
        bindings, outputs, kind, full = [], [], None, True

        def bind(label, argument, size, offset=0, writable=False):
            raw = bytes.fromhex(node['parameter_hex'][argument])
            address = int.from_bytes(raw[offset:offset + 8], 'little')
            assert len(raw[offset:offset + 8]) == 8 and address and size > 0
            bindings.append({'label': label, 'argument': argument, 'offset': offset, 'bytes': size, 'address': address})
            if writable:
                outputs.append(label)

        def flat(sizes, writes):
            for argument, size in sizes.items():
                bind('arg-' + str(argument), argument, size, writable=argument in writes)

        if '14initialize_rhsE' in name:
            kind = 'rhs-initialize'
            assert [integer(node, i) for i in (6, 10, 11)] == [2, 36, 36]
            flat({1: 432, 2: 432, 3: 144, 4: 144, 5: 576, 7: 432, 8: 144, 9: 432}, [9])
        elif '15granular_kernel19accumulate_contactsE' in name:
            kind = 'grain-contacts'
            view = bytes.fromhex(node['parameter_hex'][0])
            assert len(view) == 120 and int.from_bytes(view[88:92], 'little') == 12
            assert int.from_bytes(view[92:96], 'little') == 32
            for offset, size in {0: 128, 8: 48, 16: 48, 24: 48, 32: 144, 40: 144,
                                 48: 144, 56: 48, 64: 48, 72: 1536, 80: 6144}.items():
                bind('view-' + str(offset), 0, size, offset)
            flat({1: 432, 2: 1296, 3: 48, 4: 1536, 5: 6144}, [1, 2, 3, 4, 5])
            assert [b['address'] for b in bindings[8:11]] == [b['address'] for b in bindings[-3:]]
        elif '15granular_kernel16accumulate_bondsE' in name:
            count = integer(node, 8)
            assert count in (6, 36)
            kind = 'authored-bonds' if count == 6 else 'dynamic-bonds'
            flat({1: 432, 2: 432, 4: count * 8, 5: count * 4, 6: count * 4, 7: count * 4,
                  10: 432, 11: 1296, 12: count * 36}, [10, 11, 12])
        elif '22evaluate_contact_forceE' in name:
            kind, full = 'rigid-force', False
            flat({0: 4, 28: 432, 29: 432, 30: 432, 32: 432, 33: 144}, [32, 33])
        elif '30evaluate_rolling_contact_forceE' in name:
            kind, full = 'rolling-force', False
            flat({1: 432}, [1])
        elif '27evaluate_soft_contact_forceE' in name and integer(node, 36):
            kind, full = 'soft-force', False
            flat({0: 4, 32: 432, 33: 432, 34: 432, 36: 432, 37: 144}, [36, 37])
        elif '51evaluate_affine_body_so3_augmented_lagrangian_forceE' in name:
            kind = 'SO3-force'
            assert [integer(node, i) for i in (7, 8, 9)] == [3, 3, 36]
            flat({0: 432, 1: 48, 2: 12, 3: 108, 4: 108, 6: 432}, [6])
        elif '27invert_block_preconditionerE' in name:
            kind = 'inverse-block'
            assert [integer(node, i) for i in (4, 5)] == [36, 36]
            flat({0: 1296, 1: 144, 2: 144, 3: 1296}, [3])
            assert bindings[0]['address'] == bindings[-1]['address'], 'The original inverse is in place'
        elif '23precondition_and_reduceI' in name:
            kind = 'CG-precondition'
            assert integer(node, 4) == 0 and integer(node, 5) == 12 and integer(node, 7) == 36
            flat({0: 1296, 1: 432, 2: 432, 6: 12}, [2, 6])
        elif '19update_cg_directionE' in name:
            kind = 'CG-direction'
            assert integer(node, 2) == 0 and integer(node, 3) == 12 and integer(node, 7) == 36
            sizes = {1: 432, 4: 12, 6: 432}
            if integer(node, 5):
                sizes[5] = 12
            flat(dict(sorted(sizes.items())), [6])
        elif '26multiply_matrix_and_reduceI' in name:
            kind = 'CG-product'
            assert [integer(node, i) for i in (2, 7, 8, 10, 11)] == [2, 0, 12, 36, 36]
            flat({0: 144, 1: 576, 3: 1296, 4: 432, 5: 432, 6: 432, 9: 12}, [6, 9])
        elif '28update_solution_and_residualE' in name:
            kind = 'CG-solution'
            assert integer(node, 0) == 0 and integer(node, 1) == 12 and integer(node, 8) == 36
            flat({2: 12, 3: 12, 4: 432, 5: 432, 6: 432, 7: 432}, [6, 7])
        elif '20apply_nonlinear_stepE' in name:
            kind = 'apply'
            assert integer(node, 3) == 36
            flat({0: 432, 1: 432, 2: 432}, [1, 2])
        if kind is None:
            continue
        pointers = {i for i, typ in enumerate(parameter_types(name)) if '*' in typ and integer(node, i)}
        if full:
            assert pointers == {b['argument'] for b in bindings if b['offset'] == 0 and b['label'].startswith('arg-')}
        result.append({'key': f'{rank:03d}-{kind}', 'rank': rank, 'kind': kind, 'node': node,
                       'bindings': bindings, 'outputs': outputs, 'all_flat_pointer_inputs_captured': full,
                       'opaque_Model_only_previously_audited_read_scalars_relevant': 'accumulate_bondsE' in name})
    assert len(nodes) == 276 and len(result) == 90
    assert sum(s['kind'] == 'apply' for s in result) == 3
    return result


class Observer(Transport):
    def __init__(self, output, abi, particle_count, body_count):
        assert (particle_count, body_count) == (36, 3)
        self.output, self.abi, self.frames = output, abi, 0
        self.driver, self.device = None, ct.c_uint64()
        output.mkdir(parents=True, exist_ok=False)
        (output / 'frames').mkdir()

    def attach(self, graph):
        assert self.driver is None and graph is not None and graph.graph_exec is None
        dump_graph(graph, self.output / 'definition-before', self.abi)
        definition = json.loads((self.output / 'definition-before/graph.json').read_text())
        nodes = linear_order(definition)[0]
        stages = select_stages(nodes)
        self.driver = ct.CDLL('libcuda.so.1')
        api = {
            'cuCtxGetCurrent': [ct.POINTER(ct.c_void_p)],
            'cuMemAlloc_v2': [ct.POINTER(ct.c_uint64), ct.c_size_t],
            'cuMemFree_v2': [ct.c_uint64],
            'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
            'cuGraphAddMemcpyNode': [ct.POINTER(ct.c_void_p), ct.c_void_p, ct.POINTER(ct.c_void_p),
                                     ct.c_size_t, ct.POINTER(Copy3D), ct.c_void_p],
            'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.c_size_t],
            'cuGraphGetNodes': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
            'cuGraphGetEdges': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
        }
        for name, arguments in api.items():
            getattr(self.driver, name).argtypes = arguments
            getattr(self.driver, name).restype = ct.c_int
        assert ct.sizeof(Copy3D) == self.abi['copy_size'] == 200
        self.bytes = sum(sum(b['bytes'] for b in s['bindings']) +
                         sum(b['bytes'] for b in s['bindings'] if b['label'] in s['outputs']) for s in stages)
        self.checked('cuMemAlloc_v2', ct.byref(self.device), self.bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        offset, snapshots = 0, []

        def snapshot(stage, binding, previous, phase):
            nonlocal offset
            params = Copy3D()
            params.srcMemoryType = params.dstMemoryType = 2
            params.srcDevice, params.dstDevice = binding['address'], self.device.value + offset
            params.WidthInBytes, params.Height, params.Depth = binding['bytes'], 1, 1
            handle = ct.c_void_p()
            self.checked('cuGraphAddMemcpyNode', ct.byref(handle), graph.graph, ct.byref(previous),
                         1, ct.byref(params), context)
            snapshots.append({'stage': stage['key'], 'phase': phase, 'label': binding['label'],
                              'source': binding['address'], 'bytes': binding['bytes'], 'offset': offset, 'node': handle.value})
            offset += binding['bytes']
            return handle

        for stage in stages:
            rank = stage['rank']
            previous = ct.c_void_p(nodes[rank - 1]['handle'])
            for binding in stage['bindings']:
                previous = snapshot(stage, binding, previous, 'before')
            target = ct.c_void_p(stage['node']['handle'])
            self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(target), 1)
            previous = target
            for binding in stage['bindings']:
                if binding['label'] in stage['outputs']:
                    previous = snapshot(stage, binding, previous, 'after')
            following = ct.c_void_p(nodes[rank + 1]['handle'])
            self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(following), 1)
        assert offset == self.bytes
        count, edge_count = ct.c_size_t(), ct.c_size_t()
        self.checked('cuGraphGetNodes', graph.graph, None, ct.byref(count))
        handles = (ct.c_void_p * count.value)()
        self.checked('cuGraphGetNodes', graph.graph, handles, ct.byref(count))
        self.checked('cuGraphGetEdges', graph.graph, None, None, ct.byref(edge_count))
        left, right = (ct.c_void_p * edge_count.value)(), (ct.c_void_p * edge_count.value)()
        self.checked('cuGraphGetEdges', graph.graph, left, right, ct.byref(edge_count))
        edges = [(int(a), int(b)) for a, b in zip(left, right)]
        assert count.value == len(nodes) + len(snapshots)
        assert len(edges) == len(definition['edges']) + len(snapshots) + 2 * len(stages)
        assert set(map(tuple, definition['edges'])) <= set(edges)
        topology = {'nodes': [{'handle': int(handle)} for handle in handles], 'edges': edges}
        positions = {row['handle']: i for i, row in enumerate(linear_order(topology)[0])}
        for stage in stages:
            previous, target, following = (nodes[stage['rank'] + d]['handle'] for d in (-1, 0, 1))
            for row in snapshots:
                if row['stage'] != stage['key']:
                    continue
                assert positions[previous] < positions[row['node']] < positions[target] if row['phase'] == 'before' else (
                    positions[target] < positions[row['node']] < positions[following])
        self.layout = {'stages': stages, 'snapshots': snapshots, 'total_snapshot_bytes': self.bytes,
                       'GPU_allocations_added': 1, 'graph_nodes_added': len(snapshots),
                       'original_nodes_and_edges_preserved': True, 'whole_solver_complete': False}
        (self.output / 'snapshot-layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')
        (self.output / 'graph-after-topology.json').write_text(json.dumps(topology, indent=2) + '\n')

    def record(self, frame, public_q):
        payload = ct.create_string_buffer(self.bytes)
        self.checked('cuMemcpyDtoH_v2', payload, self.device, self.bytes)
        arrays = {}
        for row in self.layout['snapshots']:
            key = row['stage'] + '/' + row['phase'] + '/' + row['label']
            arrays[key] = np.frombuffer(payload.raw[row['offset']:row['offset'] + row['bytes']], dtype='u1').copy()
        final = next(s for s in reversed(self.layout['stages']) if s['kind'] == 'apply')
        assert arrays[final['key'] + '/after/arg-1'].tobytes() == np.ascontiguousarray(public_q).tobytes()
        np.savez_compressed(self.output / 'frames' / f'frame-{frame:02d}.npz', **arrays)
        self.frames += 1
