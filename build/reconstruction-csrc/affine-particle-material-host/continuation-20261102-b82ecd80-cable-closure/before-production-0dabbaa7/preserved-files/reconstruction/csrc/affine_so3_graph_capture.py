"""Diagnostic graph snapshots of all SO3 initialization/update calls in the fixed PD contact fixture."""
import ctypes as ct
import json

import numpy as np

from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import Observer as Transport, integer
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


INITIALIZE = '32initialize_affine_body_so3_stateE'
UPDATE = '49update_affine_body_so3_augmented_lagrangian_stateE'


def select_stages(nodes, particle_count, body_count):
    result = []
    for rank, node in enumerate(nodes):
        name = node.get('name', '')
        if INITIALIZE not in name and UPDATE not in name:
            continue
        initialize = INITIALIZE in name
        assert node['parameter_widths'] == ([8] * 7 if initialize else [8] * 4 + [1] + [8] * 3)
        count, local, per_world = (integer(node, i) for i in ((4, 5, 6) if initialize else (5, 6, 7)))
        assert count > 0 and local > 0 and count % local == 0
        assert count == body_count and count // local * per_world == particle_count
        assert node['geometry'] == [(count + 255) // 256, 1, 1, 256, 1, 1, 0]
        sizes = {0: particle_count * 12, 1: local * 16, 2: count * 36, 3: count * 36}
        pointer_arguments = {i for i, kind in enumerate(parameter_types(name)) if '*' in kind}
        assert pointer_arguments == set(sizes) and all(integer(node, i) for i in sizes)
        # Preserve all pointer relationships; these small SO3 buffers should be disjoint in this fixture.
        for a in sizes:
            for b in sizes:
                if a < b:
                    assert min(integer(node, a) + sizes[a], integer(node, b) + sizes[b]) <= max(
                        integer(node, a), integer(node, b)), 'SO3 pointer spans unexpectedly overlap'
        result.append({'key': 'initialize' if initialize else 'update-' + str(len(result)),
                       'rank': rank, 'node': node, 'sizes': sizes, 'outputs': [2, 3],
                       'count': count, 'bodies_per_world': local, 'particles_per_world': per_world,
                       'advance': None if initialize else integer(node, 4)})
    assert [stage['rank'] for stage in result] == [8, 94, 180, 266]
    assert [(s['count'], s['bodies_per_world'], s['particles_per_world']) for s in result] == [(3, 3, 36)] * 4
    assert [s['advance'] for s in result] == [None, 1, 0, 0]
    assert len(nodes) == 276
    return result


class Observer(Transport):
    def __init__(self, output, abi, particle_count, body_count):
        self.output, self.abi, self.frames = output, abi, 0
        self.particle_count, self.body_count = particle_count, body_count
        self.driver, self.device = None, ct.c_uint64()
        output.mkdir(parents=True, exist_ok=False)
        (output / 'packets').mkdir()

    def attach(self, graph):
        assert self.driver is None and graph is not None and graph.graph_exec is None
        dump_graph(graph, self.output / 'definition-before', self.abi)
        definition = json.loads((self.output / 'definition-before/graph.json').read_text())
        nodes = linear_order(definition)[0]
        stages = select_stages(nodes, self.particle_count, self.body_count)
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
        self.bytes = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages)
        assert self.bytes == 3648
        self.checked('cuMemAlloc_v2', ct.byref(self.device), self.bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        offset, snapshots = 0, []

        def snapshot(stage, previous, argument, phase):
            nonlocal offset
            size, address = stage['sizes'][argument], integer(stage['node'], argument)
            params = Copy3D()
            params.srcMemoryType = params.dstMemoryType = 2
            params.srcDevice, params.dstDevice = address, self.device.value + offset
            params.WidthInBytes, params.Height, params.Depth = size, 1, 1
            handle = ct.c_void_p()
            self.checked('cuGraphAddMemcpyNode', ct.byref(handle), graph.graph, ct.byref(previous),
                         1, ct.byref(params), context)
            snapshots.append({'stage': stage['key'], 'phase': phase, 'argument': argument, 'source': address,
                              'bytes': size, 'offset': offset, 'node': handle.value})
            offset += size
            return handle

        for stage in stages:
            rank = stage['rank']
            previous = ct.c_void_p(nodes[rank - 1]['handle'])
            for argument in stage['sizes']:
                previous = snapshot(stage, previous, argument, 'before')
            target = ct.c_void_p(stage['node']['handle'])
            self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(target), 1)
            previous = target
            for argument in stage['outputs']:
                previous = snapshot(stage, previous, argument, 'after')
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
        assert count.value == len(nodes) + len(snapshots) == 300
        assert len(edges) == len(definition['edges']) + len(snapshots) + 2 * len(stages) == 307
        assert set(map(tuple, definition['edges'])) <= set(edges)
        topology = {'nodes': [{'handle': int(handle)} for handle in handles], 'edges': edges}
        positions = {row['handle']: i for i, row in enumerate(linear_order(topology)[0])}
        for stage in stages:
            rows = [row for row in snapshots if row['stage'] == stage['key']]
            target = stage['node']['handle']
            previous, following = (nodes[stage['rank'] + delta]['handle'] for delta in (-1, 1))
            assert all(positions[previous] < positions[row['node']] < positions[target]
                       if row['phase'] == 'before' else
                       positions[target] < positions[row['node']] < positions[following] for row in rows)
        self.layout = {'stages': stages, 'snapshots': snapshots, 'total_snapshot_bytes': self.bytes,
                       'GPU_allocations_added': 1, 'graph_nodes_added': len(snapshots),
                       'actual_pre_call_output_bytes_captured': True, 'original_nodes_and_edges_preserved': True,
                       'uninitialized_initializer_before_bytes_are_not_semantic_state': True,
                       'whole_solver_complete': False}
        (self.output / 'snapshot-layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')
        (self.output / 'graph-after-topology.json').write_text(json.dumps(topology, indent=2) + '\n')

    def record(self, frame, public_q):
        assert self.driver is not None and self.device.value
        payload = ct.create_string_buffer(self.bytes)
        self.checked('cuMemcpyDtoH_v2', payload, self.device, self.bytes)
        final_q = None
        for stage in self.layout['stages']:
            arrays = {'parameter-' + str(i): np.frombuffer(bytes.fromhex(value), dtype='u1')
                      for i, value in enumerate(stage['node']['parameter_hex'])}
            for row in self.layout['snapshots']:
                if row['stage'] == stage['key']:
                    value = payload.raw[row['offset']:row['offset'] + row['bytes']]
                    arrays[row['phase'] + '-arg-' + str(row['argument'])] = np.frombuffer(value, dtype='u1').copy()
            if stage is self.layout['stages'][-1]:
                final_q = arrays['before-arg-0'].tobytes()
            path = self.output / 'packets' / (f'{stage["key"]}-frame-{frame:02d}.npz')
            np.savez_compressed(path, **arrays)
        # This final state read is independent of the staging buffer and detects stale/wrong ping-pong snapshots.
        assert final_q == np.ascontiguousarray(public_q).tobytes()
        self.frames += 1
