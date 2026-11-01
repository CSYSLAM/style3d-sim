"""Capture authentic G1 contact RHS and matrix branches without changing production solver code."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

from .audit_cudahook import parameter_types
from .demo_source_ab import ROOT
from .g1_drive_tangent_capture import Observer as Transport, integer
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


STAGES = {'rhs': '14initialize_rhsE',
 'inverse': '27invert_block_preconditionerE',
 'precondition_first': '23precondition_and_reduceI',
 'direction_first': '19update_cg_directionE',
 'matrix_first': '26multiply_matrix_and_reduceI',
 'update_first': '28update_solution_and_residualE',
 'precondition_last': '23precondition_and_reduceI',
 'direction_last': '19update_cg_directionE',
 'matrix_last': '26multiply_matrix_and_reduceI',
 'update_last': '28update_solution_and_residualE'}


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 17467 and body_count == 44 and dof_count == 49
    result = []
    for key, token in STAGES.items():
        matches = [i for i in range(9329, 9905) if token in nodes[i].get('name', '')]
        assert len(matches) == (1 if key in ('rhs', 'inverse') else 50)
        rank = matches[-1] if key.endswith('_last') else matches[0]
        node = nodes[rank]
        kind = key.split('_', 1)[0]
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        if kind == 'rhs':
            assert rank == 9332 and node['parameter_widths'] == [4] + [8] * 11
            assert [integer(node, i) for i in (6, 10, 11)] == [19, 176, 176]
            sizes = {1: 2112, 2: 2112, 3: 704, 4: 704, 5: 26752, 7: 2112, 8: 704, 9: 2112}
            outputs = [9]
        elif kind == 'inverse':
            assert rank == 9350 and node['parameter_widths'] == [8] * 6
            assert integer(node, 4) == integer(node, 5) == 176 and integer(node, 0) == integer(node, 3)
            sizes, outputs = {0: 6336, 1: 704, 2: 704, 3: 6336}, [3]
        elif kind == 'precondition':
            assert node['parameter_widths'] == [8, 8, 8, 1, 8, 4, 8, 8]
            assert integer(node, 3) == integer(node, 4) == 0 and integer(node, 5) == integer(node, 7) == 176
            sizes, outputs = {0: 6336, 1: 2112, 2: 2112, 6: 4}, [2, 6]
        elif kind == 'direction':
            assert node['parameter_widths'] == [4, 8, 8, 4, 8, 8, 8, 8]
            assert integer(node, 0) == (49 if key.endswith('_last') else 0)
            assert integer(node, 2) == 0 and integer(node, 3) == integer(node, 7) == 176
            assert bool(integer(node, 5)) == key.endswith('_last')
            sizes, outputs = {1: 2112, 4: 4, 6: 2112}, [6]
            if integer(node, 5):
                sizes[5] = 4
        elif kind == 'matrix':
            assert node['parameter_widths'] == [8] * 8 + [4] + [8] * 3
            assert integer(node, 2) == 19 and integer(node, 7) == 0
            assert [integer(node, i) for i in (8, 10, 11)] == [176, 176, 176]
            sizes, outputs = {0: 704, 1: 133760, 3: 6336, 4: 2112, 5: 2112, 6: 2112, 9: 4}, [6, 9]
        else:
            assert kind == 'update' and node['parameter_widths'] == [8, 4, 8, 8, 8, 8, 8, 8, 8]
            assert integer(node, 0) == 0 and integer(node, 1) == integer(node, 8) == 176
            sizes, outputs = {2: 4, 3: 4, 4: 2112, 5: 2112, 6: 2112, 7: 2112}, [6, 7]
        pointers = {i for i, t in enumerate(parameter_types(node['name'])) if '*' in t and integer(node, i)}
        assert set(sizes) == pointers
        overlaps = []
        for a in outputs:
            for b in sizes:
                if a == b:
                    continue
                start, end = max(integer(node, a), integer(node, b)), min(
                    integer(node, a) + sizes[a], integer(node, b) + sizes[b])
                if start < end:
                    assert kind == 'inverse' and {a, b} == {0, 3} and end - start == 6336
                    overlaps.append({'arguments': [a, b], 'overlap_bytes': end - start})
        result.append({'key': key, 'kernel_key': key, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': overlaps})
    assert [s['rank'] for s in result] == [9332, 9350, 9355, 9356, 9364, 9365, 9894, 9895, 9903, 9904]
    return result

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
        self.checked('cuMemAlloc_v2', ct.byref(self.device), self.bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        assert '32initialize_affine_body_so3_stateE' in nodes[8750]['name']
        model_map_source = integer(nodes[8750], 1)
        model_map = ct.create_string_buffer(704)
        self.checked('cuMemcpyDtoH_v2', model_map, ct.c_uint64(model_map_source), 704)
        (self.output / 'model-body-indices.bin').write_bytes(model_map.raw)
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
        self.layout = {'device_base': self.device.value, 'model_map_source': model_map_source,
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
        for stage in self.layout['stages']:
            arrays = {'parameter-' + str(i): np.frombuffer(bytes.fromhex(value), dtype='u1')
                      for i, value in enumerate(stage['node']['parameter_hex'])}
            for row in self.layout['snapshots']:
                if row['stage'] != stage['key']:
                    continue
                value = payload.raw[row['offset']:row['offset'] + row['bytes']]
                arrays[row['phase'] + '-arg-' + str(row['argument'])] = np.frombuffer(value, dtype='u1').copy()
            path = self.output / (stage['key'] + '-packets') / ('frame-' + str(self.frames).zfill(2) + '.npz')
            np.savez_compressed(path, **arrays)
        self.frames += 1


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
    for anchor, addition in [
        ('        original_step = example.step\n', '        contact_observer.attach(example)\n'),
        ('                    records[key].append(array.numpy().copy())\n', '            contact_observer.record()\n'),
    ]:
        assert text.count(anchor) == 1
        text = text.replace(anchor, anchor + addition)
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
              'contact_observer': observer})
        assert observer.frames == args.frames
        provenance['complete'] = True
    finally:
        provenance['frames_read'] = observer.frames
        (output / 'provenance.json').write_text(json.dumps(provenance, indent=2) + '\n')
        observer.close()


if __name__ == '__main__':
    main()
