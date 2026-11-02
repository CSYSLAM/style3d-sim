"""Observe the real first H1 nonlinear solve; snapshots can change atomic scheduling."""
import ctypes as ct
import json
import numpy as np
from reconstruction.csrc.g1_drive_tangent_capture import Observer as Transport, integer
from reconstruction.csrc.graph_definition_compare import linear_order
from reconstruction.csrc.graph_definition_dump import Copy3D, dump_graph
from reconstruction.csrc.h1_first_cg_layout import TOKENS as STAGES, select_stages


def validate_backing_ranges(observer, example, stages):
    import warp as wp
    from warp._src.types import type_size_in_bytes
    logical, result = [], {}
    objects = [('model', example.model), ('state', example.state), ('state1', example.state1),
               ('solver', example.solver), ('control', example.control), ('contacts', example.contacts)]
    for owner, obj in objects:
        for name, array in getattr(obj, '__dict__', {}).items():
            if isinstance(array, wp.array) and array.device.is_cuda and array.ptr and array.is_contiguous:
                logical.append({'base': int(array.ptr), 'bytes': array.size * type_size_in_bytes(array.dtype),
                                'provider': 'declared Warp array', 'label': owner + '.' + name})
    for stage in stages:
        for index, size in stage['sizes'].items():
            address = integer(stage['node'], index)
            key = str(address) + ':' + str(size)
            if key in result:
                continue
            matches = [span for span in logical if span['base'] <= address
                       and address + size <= span['base'] + span['bytes']]
            if matches:
                backing = min(matches, key=lambda span: span['bytes'])
            else:
                base, capacity = ct.c_uint64(), ct.c_size_t()
                observer.checked('cuMemGetAddressRange_v2', ct.byref(base), ct.byref(capacity), address)
                backing = {'base': base.value, 'bytes': capacity.value, 'provider': 'CUDA allocation query'}
            assert backing['base'] <= address and address + size <= backing['base'] + backing['bytes']
            result[key] = {'address': address, 'captured_bytes': size, **backing}
    return list(result.values())


class Observer(Transport):
    def __init__(self, output, abi):
        self.output, self.abi, self.frames = output, abi, 0
        self.driver, self.device = None, ct.c_uint64()
        for key in STAGES:
            (output / (key + '-packets')).mkdir(exist_ok=False)

    def attach(self, example):
        assert self.driver is None
        graph = example.graph
        assert graph is not None and graph.graph_exec is None
        dump_graph(graph, self.output / 'definition-before', self.abi)
        definition = json.loads((self.output / 'definition-before/graph.json').read_text())
        nodes = linear_order(definition)[0]
        stages = select_stages(nodes, int(example.model.body_count), int(example.model.joint_dof_count))
        self.driver = ct.CDLL('libcuda.so.1')
        api = {
            'cuCtxGetCurrent': [ct.POINTER(ct.c_void_p)],
            'cuMemGetAddressRange_v2': [ct.POINTER(ct.c_uint64), ct.POINTER(ct.c_size_t), ct.c_uint64],
            'cuMemAlloc_v2': [ct.POINTER(ct.c_uint64), ct.c_size_t],
            'cuMemFree_v2': [ct.c_uint64],
            'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
            'cuGraphAddMemcpyNode': [ct.POINTER(ct.c_void_p), ct.c_void_p, ct.POINTER(ct.c_void_p),
                                     ct.c_size_t, ct.POINTER(Copy3D), ct.c_void_p],
            'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.c_size_t],
            'cuGraphMemcpyNodeGetParams': [ct.c_void_p, ct.POINTER(Copy3D)],
            'cuGraphGetNodes': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
            'cuGraphGetEdges': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
        }
        for name, arguments in api.items():
            getattr(self.driver, name).argtypes = arguments
            getattr(self.driver, name).restype = ct.c_int
        assert ct.sizeof(Copy3D) == self.abi['copy_size'] == 200
        self.bytes = sum(sum(s['sizes'].values()) + sum(s['sizes'][i] for i in s['outputs']) for s in stages)
        backing_ranges = validate_backing_ranges(self, example, stages)
        self.checked('cuMemAlloc_v2', ct.byref(self.device), self.bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        offset, snapshots = 0, []

        def snapshot(stage, previous, argument, phase):
            nonlocal offset
            size, address = stage['sizes'][argument], integer(stage['node'], argument)
            assert address
            params = Copy3D()
            params.srcMemoryType = params.dstMemoryType = 2
            params.srcDevice, params.dstDevice = address, self.device.value + offset
            params.WidthInBytes, params.Height, params.Depth = size, 1, 1
            handle = ct.c_void_p()
            self.checked('cuGraphAddMemcpyNode', ct.byref(handle), graph.graph, ct.byref(previous),
                         1, ct.byref(params), context)
            actual = Copy3D()
            self.checked('cuGraphMemcpyNodeGetParams', handle, ct.byref(actual))
            assert actual.srcMemoryType == actual.dstMemoryType == 2
            assert actual.srcDevice == address and actual.dstDevice == self.device.value + offset
            assert (actual.WidthInBytes, actual.Height, actual.Depth) == (size, 1, 1)
            snapshots.append({'actual_copy_parameters_hex': bytes(actual).hex(),
                              'stage': stage['key'], 'phase': phase, 'argument': argument, 'source': address,
                              'bytes': size, 'offset': offset, 'node': handle.value, 'predecessor': previous.value})
            offset += size
            return handle

        last_after = {}
        for stage in stages:
            rank, node = stage['rank'], stage['node']
            previous = last_after.get(rank - 1, ct.c_void_p(nodes[rank - 1]['handle']))
            for argument in stage['sizes']:
                previous = snapshot(stage, previous, argument, 'before')
            target = ct.c_void_p(node['handle'])
            self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(target), 1)
            previous = target
            for argument in stage['outputs']:
                previous = snapshot(stage, previous, argument, 'after')
            last_after[rank] = previous
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
            rows = [row for row in snapshots if row['stage'] == stage['key']]
            target = stage['node']['handle']
            previous, following = (nodes[stage['rank'] + delta]['handle'] for delta in (-1, 1))
            assert all(positions[previous] < positions[row['node']] < positions[target]
                       if row['phase'] == 'before' else
                       positions[target] < positions[row['node']] < positions[following] for row in rows)
        self.layout = {'device_base': self.device.value, 'backing_ranges': backing_ranges,
                       'stages': stages,
                       'snapshots': snapshots, 'total_snapshot_bytes': self.bytes,
                       'GPU_allocations_added': 1, 'graph_nodes_added': len(snapshots),
                       'actual_pre_call_output_bytes_captured': True, 'original_nodes_and_edges_preserved': True,
                       'whole_solver_complete': False}
        (self.output / 'snapshot-layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')
        (self.output / 'graph-after-topology.json').write_text(json.dumps(topology, indent=2) + '\n')

    def record(self):
        payload = ct.create_string_buffer(self.bytes)
        self.checked('cuMemcpyDtoH_v2', payload, self.device, self.bytes)
        raw = payload.raw
        for stage in self.layout['stages']:
            arrays = {'parameter-' + str(i): np.frombuffer(bytes.fromhex(value), dtype='u1')
                      for i, value in enumerate(stage['node']['parameter_hex'])}
            for row in self.layout['snapshots']:
                if row['stage'] != stage['key']:
                    continue
                value = raw[row['offset']:row['offset'] + row['bytes']]
                arrays[row['phase'] + '-arg-' + str(row['argument'])] = np.frombuffer(value, dtype='u1').copy()
            path = self.output / (stage['key'] + '-packets') / ('frame-' + str(self.frames).zfill(2) + '.npz')
            np.savez_compressed(path, **arrays)
        self.frames += 1
