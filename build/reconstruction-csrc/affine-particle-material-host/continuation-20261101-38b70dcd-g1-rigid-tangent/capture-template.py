"""Diagnostic-only snapshots around the last G1 rigid tangent; retain authentic pre-call accumulator bytes."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

from .audit_cudahook import parameter_types
from .demo_source_ab import ROOT
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


TOKEN = '24evaluate_contact_tangentE'


def integer(node, index):
    return int.from_bytes(bytes.fromhex(node['parameter_hex'][index]), 'little')


def sizes_for(node, body_count, dof_count):
    capacity, shapes, worlds = (integer(node, index) for index in (1, 20, 22))
    assert capacity == 1000 and shapes == integer(node, 21) == 105 and worlds == 1
    assert body_count == integer(node, 26) == 44 and integer(node, 32) == 176
    assert integer(node, 33) == integer(node, 34) == 0
    result = {0: 4, 2: capacity * 4, 3: capacity * 4, 9: capacity * 4, 10: capacity * 4,
              11: shapes * 4, 12: shapes * 4, 13: shapes * 28, 14: shapes * 12,
              23: body_count * 4, 24: body_count * 16, 25: body_count * 12}
    result.update({index: capacity * 12 for index in (4, 5, 6, 7, 8)})
    result.update({index: shapes * 4 for index in (15, 16, 17, 18)})
    result.update({index: 176 * 12 for index in (27, 28, 29, 30)})
    pointers = {index for index, kind in enumerate(parameter_types(node['name'])) if '*' in kind}
    assert set(result) == {index for index in pointers if integer(node, index)}
    return dict(sorted(result.items()))

class Observer:
    def __init__(self, output, abi):
        self.output, self.abi, self.frames = output, abi, 0
        self.driver = None
        self.device = ct.c_uint64()
        (output / 'packets').mkdir(exist_ok=False)

    def checked(self, name, *arguments):
        code = getattr(self.driver, name)(*arguments)
        if code:
            raise RuntimeError(f'{name} returned CUDA status {code}')

    def attach(self, example):
        assert self.driver is None
        graph = example.graph
        assert graph is not None and graph.graph_exec is None
        dump_graph(graph, self.output / 'definition-before', self.abi)
        definition = json.loads((self.output / 'definition-before/graph.json').read_text())
        nodes = linear_order(definition)[0]
        rank = max(index for index, node in enumerate(nodes) if TOKEN in node.get('name', ''))
        node = nodes[rank]
        assert rank == 17451 and len(nodes) == 17467
        sizes = sizes_for(node, int(example.model.body_count), int(example.model.joint_dof_count))
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
        total_bytes = sum(sizes.values()) + sizes[30]
        self.checked('cuMemAlloc_v2', ct.byref(self.device), total_bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        offset, snapshots = 0, []

        def snapshot(previous, argument, phase):
            nonlocal offset
            size = sizes[argument]
            address = integer(node, argument)
            assert address
            params = Copy3D()
            params.srcMemoryType = params.dstMemoryType = 2
            params.srcDevice, params.dstDevice = address, self.device.value + offset
            params.WidthInBytes, params.Height, params.Depth = size, 1, 1
            handle = ct.c_void_p()
            self.checked('cuGraphAddMemcpyNode', ct.byref(handle), graph.graph, ct.byref(previous),
                         1, ct.byref(params), context)
            snapshots.append({'phase': phase, 'argument': argument, 'source': address, 'bytes': size,
                              'offset': offset, 'node': handle.value, 'predecessor': previous.value})
            offset += size
            return handle

        previous = ct.c_void_p(nodes[rank - 1]['handle'])
        for argument in sizes:
            previous = snapshot(previous, argument, 'before')
        target = ct.c_void_p(node['handle'])
        self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(target), 1)
        previous = snapshot(target, 30, 'after')
        following = ct.c_void_p(nodes[rank + 1]['handle'])
        self.checked('cuGraphAddDependencies', graph.graph, ct.byref(previous), ct.byref(following), 1)
        assert offset == total_bytes
        self.bytes = total_bytes
        self.node = node
        count = ct.c_size_t()
        self.checked('cuGraphGetNodes', graph.graph, None, ct.byref(count))
        handles = (ct.c_void_p * count.value)()
        self.checked('cuGraphGetNodes', graph.graph, handles, ct.byref(count))
        edge_count = ct.c_size_t()
        self.checked('cuGraphGetEdges', graph.graph, None, None, ct.byref(edge_count))
        left, right = (ct.c_void_p * edge_count.value)(), (ct.c_void_p * edge_count.value)()
        self.checked('cuGraphGetEdges', graph.graph, left, right, ct.byref(edge_count))
        assert count.value == len(nodes) + len(snapshots)
        edges = [(int(a), int(b)) for a, b in zip(left, right)]
        assert len(edges) == len(definition['edges']) + len(snapshots) + 2
        assert set(map(tuple, definition['edges'])) <= set(edges)
        topology = {'nodes': [{'handle': int(handle)} for handle in handles], 'edges': edges}
        order = linear_order(topology)[0]
        positions = {entry['handle']: index for index, entry in enumerate(order)}
        assert all(positions[row['node']] < positions[node['handle']]
                   if row['phase'] == 'before' else positions[node['handle']] < positions[row['node']]
                   for row in snapshots)
        assert max(positions[row['node']] for row in snapshots if row['phase'] == 'after') < positions[following.value]
        self.layout = {'node': node, 'rank': rank, 'sizes': sizes, 'snapshots': snapshots,
                       'total_snapshot_bytes': total_bytes, 'GPU_allocations_added': 1,
                       'graph_nodes_added': len(snapshots), 'actual_pre_call_output_bytes_captured': True,
                       'original_nodes_and_edges_preserved': True, 'whole_solver_complete': False}
        (self.output / 'snapshot-layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')
        (self.output / 'graph-after-topology.json').write_text(json.dumps(topology, indent=2) + '\n')

    def record(self):
        assert self.device.value
        payload = ct.create_string_buffer(self.bytes)
        self.checked('cuMemcpyDtoH_v2', payload, self.device, self.bytes)
        raw = payload.raw
        arrays = {'parameter-' + str(index): np.frombuffer(bytes.fromhex(value), dtype='u1')
                  for index, value in enumerate(self.node['parameter_hex'])}
        for row in self.layout['snapshots']:
            value = raw[row['offset']:row['offset'] + row['bytes']]
            arrays[row['phase'] + '-arg-' + str(row['argument'])] = np.frombuffer(value, dtype='u1').copy()
        np.savez_compressed(self.output / 'packets' / ('frame-' + str(self.frames).zfill(2) + '.npz'), **arrays)
        self.frames += 1

    def close(self):
        if self.device.value:
            self.checked('cuMemFree_v2', self.device)
            self.device.value = 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--abi', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    observer = Observer(output, json.loads(args.abi.read_text()))
    runner = ROOT / ('build/reconstruction-csrc/affine-particle-material-host/'
                     'continuation-20261101-688f9633-driven-cloth-rigid-soft/'
                     'official-g1-public-core-graph60/worker-as-run.py')
    text = runner.read_text()
    anchor = '        original_step = example.step\n'
    assert text.count(anchor) == 1
    text = text.replace(anchor, anchor + '        drive_observer.attach(example)\n')
    anchor = '                    records[key].append(array.numpy().copy())\n'
    assert text.count(anchor) == 1
    text = text.replace(anchor, anchor + '            drive_observer.record()\n')
    patched = output / 'worker-as-run.py'
    patched.write_text(text)
    provenance = {'base_worker_sha256': hashlib.sha256(runner.read_bytes()).hexdigest(),
                  'patched_worker_sha256': hashlib.sha256(patched.read_bytes()).hexdigest(),
                  'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  'frames': args.frames, 'complete': False, 'frames_read': 0,
                  'diagnostic_graph_snapshots_change_atomic_schedule': True,
                  'production_changed': False, 'frozen_failure_replaced': False, 'whole_solver_complete': False}
    sys.argv = [str(patched), '--backend', args.backend, '--core-build',
                str(ROOT / 'build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json'),
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', str(args.frames),
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(text, str(patched), 'exec'),
             {'__name__': '__main__', '__package__': 'reconstruction.csrc', '__file__': str(patched),
              'drive_observer': observer})
        assert observer.frames == args.frames
        provenance['complete'] = True
    finally:
        provenance['frames_read'] = observer.frames
        (output / 'provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')
        observer.close()


if __name__ == '__main__':
    main()
