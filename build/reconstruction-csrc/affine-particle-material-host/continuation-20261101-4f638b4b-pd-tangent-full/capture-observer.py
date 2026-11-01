"""Observe complete contact and tangent spans in the fixed PD contact graph without changing solver arithmetic."""
import ctypes as ct
import json

import numpy as np

from .audit_cudahook import parameter_types
from .g1_drive_tangent_capture import Observer as Transport, integer
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


from .pd_contact_tangent_schema import select_stages


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

        tails = {}
        for stage in stages:
            rank = stage['rank']
            previous = ct.c_void_p(tails.get(rank - 1, nodes[rank - 1]['handle']))
            for binding in stage['bindings']:
                previous = snapshot(stage, binding, previous, 'before')
            target = ct.c_void_p(stage['node']['handle'])
            self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(target), 1)
            previous = target
            for binding in stage['bindings']:
                if binding['label'] in stage['outputs']:
                    previous = snapshot(stage, binding, previous, 'after')
            # Adjacent observed kernels must wait for the prior after-snapshots before their before-snapshots.
            tails[rank] = previous.value
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
