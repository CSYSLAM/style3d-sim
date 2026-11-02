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
 'precondition_00': '23precondition_and_reduceI',
 'direction_00': '19update_cg_directionE',
 'matrix_00': '26multiply_matrix_and_reduceI',
 'update_00': '28update_solution_and_residualE',
 'precondition_01': '23precondition_and_reduceI',
 'direction_01': '19update_cg_directionE',
 'matrix_01': '26multiply_matrix_and_reduceI',
 'update_01': '28update_solution_and_residualE',
 'precondition_02': '23precondition_and_reduceI',
 'direction_02': '19update_cg_directionE',
 'matrix_02': '26multiply_matrix_and_reduceI',
 'update_02': '28update_solution_and_residualE',
 'precondition_03': '23precondition_and_reduceI',
 'direction_03': '19update_cg_directionE',
 'matrix_03': '26multiply_matrix_and_reduceI',
 'update_03': '28update_solution_and_residualE',
 'precondition_04': '23precondition_and_reduceI',
 'direction_04': '19update_cg_directionE',
 'matrix_04': '26multiply_matrix_and_reduceI',
 'update_04': '28update_solution_and_residualE',
 'precondition_05': '23precondition_and_reduceI',
 'direction_05': '19update_cg_directionE',
 'matrix_05': '26multiply_matrix_and_reduceI',
 'update_05': '28update_solution_and_residualE',
 'precondition_06': '23precondition_and_reduceI',
 'direction_06': '19update_cg_directionE',
 'matrix_06': '26multiply_matrix_and_reduceI',
 'update_06': '28update_solution_and_residualE',
 'precondition_07': '23precondition_and_reduceI',
 'direction_07': '19update_cg_directionE',
 'matrix_07': '26multiply_matrix_and_reduceI',
 'update_07': '28update_solution_and_residualE',
 'precondition_08': '23precondition_and_reduceI',
 'direction_08': '19update_cg_directionE',
 'matrix_08': '26multiply_matrix_and_reduceI',
 'update_08': '28update_solution_and_residualE',
 'precondition_09': '23precondition_and_reduceI',
 'direction_09': '19update_cg_directionE',
 'matrix_09': '26multiply_matrix_and_reduceI',
 'update_09': '28update_solution_and_residualE',
 'precondition_10': '23precondition_and_reduceI',
 'direction_10': '19update_cg_directionE',
 'matrix_10': '26multiply_matrix_and_reduceI',
 'update_10': '28update_solution_and_residualE',
 'precondition_11': '23precondition_and_reduceI',
 'direction_11': '19update_cg_directionE',
 'matrix_11': '26multiply_matrix_and_reduceI',
 'update_11': '28update_solution_and_residualE',
 'precondition_12': '23precondition_and_reduceI',
 'direction_12': '19update_cg_directionE',
 'matrix_12': '26multiply_matrix_and_reduceI',
 'update_12': '28update_solution_and_residualE',
 'precondition_13': '23precondition_and_reduceI',
 'direction_13': '19update_cg_directionE',
 'matrix_13': '26multiply_matrix_and_reduceI',
 'update_13': '28update_solution_and_residualE',
 'precondition_14': '23precondition_and_reduceI',
 'direction_14': '19update_cg_directionE',
 'matrix_14': '26multiply_matrix_and_reduceI',
 'update_14': '28update_solution_and_residualE',
 'precondition_15': '23precondition_and_reduceI',
 'direction_15': '19update_cg_directionE',
 'matrix_15': '26multiply_matrix_and_reduceI',
 'update_15': '28update_solution_and_residualE',
 'precondition_16': '23precondition_and_reduceI',
 'direction_16': '19update_cg_directionE',
 'matrix_16': '26multiply_matrix_and_reduceI',
 'update_16': '28update_solution_and_residualE',
 'precondition_17': '23precondition_and_reduceI',
 'direction_17': '19update_cg_directionE',
 'matrix_17': '26multiply_matrix_and_reduceI',
 'update_17': '28update_solution_and_residualE',
 'precondition_18': '23precondition_and_reduceI',
 'direction_18': '19update_cg_directionE',
 'matrix_18': '26multiply_matrix_and_reduceI',
 'update_18': '28update_solution_and_residualE',
 'precondition_19': '23precondition_and_reduceI',
 'direction_19': '19update_cg_directionE',
 'matrix_19': '26multiply_matrix_and_reduceI',
 'update_19': '28update_solution_and_residualE',
 'precondition_20': '23precondition_and_reduceI',
 'direction_20': '19update_cg_directionE',
 'matrix_20': '26multiply_matrix_and_reduceI',
 'update_20': '28update_solution_and_residualE',
 'precondition_21': '23precondition_and_reduceI',
 'direction_21': '19update_cg_directionE',
 'matrix_21': '26multiply_matrix_and_reduceI',
 'update_21': '28update_solution_and_residualE',
 'precondition_22': '23precondition_and_reduceI',
 'direction_22': '19update_cg_directionE',
 'matrix_22': '26multiply_matrix_and_reduceI',
 'update_22': '28update_solution_and_residualE',
 'precondition_23': '23precondition_and_reduceI',
 'direction_23': '19update_cg_directionE',
 'matrix_23': '26multiply_matrix_and_reduceI',
 'update_23': '28update_solution_and_residualE',
 'precondition_24': '23precondition_and_reduceI',
 'direction_24': '19update_cg_directionE',
 'matrix_24': '26multiply_matrix_and_reduceI',
 'update_24': '28update_solution_and_residualE',
 'precondition_25': '23precondition_and_reduceI',
 'direction_25': '19update_cg_directionE',
 'matrix_25': '26multiply_matrix_and_reduceI',
 'update_25': '28update_solution_and_residualE',
 'precondition_26': '23precondition_and_reduceI',
 'direction_26': '19update_cg_directionE',
 'matrix_26': '26multiply_matrix_and_reduceI',
 'update_26': '28update_solution_and_residualE',
 'precondition_27': '23precondition_and_reduceI',
 'direction_27': '19update_cg_directionE',
 'matrix_27': '26multiply_matrix_and_reduceI',
 'update_27': '28update_solution_and_residualE',
 'precondition_28': '23precondition_and_reduceI',
 'direction_28': '19update_cg_directionE',
 'matrix_28': '26multiply_matrix_and_reduceI',
 'update_28': '28update_solution_and_residualE',
 'precondition_29': '23precondition_and_reduceI',
 'direction_29': '19update_cg_directionE',
 'matrix_29': '26multiply_matrix_and_reduceI',
 'update_29': '28update_solution_and_residualE',
 'precondition_30': '23precondition_and_reduceI',
 'direction_30': '19update_cg_directionE',
 'matrix_30': '26multiply_matrix_and_reduceI',
 'update_30': '28update_solution_and_residualE',
 'precondition_31': '23precondition_and_reduceI',
 'direction_31': '19update_cg_directionE',
 'matrix_31': '26multiply_matrix_and_reduceI',
 'update_31': '28update_solution_and_residualE',
 'precondition_32': '23precondition_and_reduceI',
 'direction_32': '19update_cg_directionE',
 'matrix_32': '26multiply_matrix_and_reduceI',
 'update_32': '28update_solution_and_residualE',
 'precondition_33': '23precondition_and_reduceI',
 'direction_33': '19update_cg_directionE',
 'matrix_33': '26multiply_matrix_and_reduceI',
 'update_33': '28update_solution_and_residualE',
 'precondition_34': '23precondition_and_reduceI',
 'direction_34': '19update_cg_directionE',
 'matrix_34': '26multiply_matrix_and_reduceI',
 'update_34': '28update_solution_and_residualE',
 'precondition_35': '23precondition_and_reduceI',
 'direction_35': '19update_cg_directionE',
 'matrix_35': '26multiply_matrix_and_reduceI',
 'update_35': '28update_solution_and_residualE',
 'precondition_36': '23precondition_and_reduceI',
 'direction_36': '19update_cg_directionE',
 'matrix_36': '26multiply_matrix_and_reduceI',
 'update_36': '28update_solution_and_residualE',
 'precondition_37': '23precondition_and_reduceI',
 'direction_37': '19update_cg_directionE',
 'matrix_37': '26multiply_matrix_and_reduceI',
 'update_37': '28update_solution_and_residualE',
 'precondition_38': '23precondition_and_reduceI',
 'direction_38': '19update_cg_directionE',
 'matrix_38': '26multiply_matrix_and_reduceI',
 'update_38': '28update_solution_and_residualE',
 'precondition_39': '23precondition_and_reduceI',
 'direction_39': '19update_cg_directionE',
 'matrix_39': '26multiply_matrix_and_reduceI',
 'update_39': '28update_solution_and_residualE',
 'precondition_40': '23precondition_and_reduceI',
 'direction_40': '19update_cg_directionE',
 'matrix_40': '26multiply_matrix_and_reduceI',
 'update_40': '28update_solution_and_residualE',
 'precondition_41': '23precondition_and_reduceI',
 'direction_41': '19update_cg_directionE',
 'matrix_41': '26multiply_matrix_and_reduceI',
 'update_41': '28update_solution_and_residualE',
 'precondition_42': '23precondition_and_reduceI',
 'direction_42': '19update_cg_directionE',
 'matrix_42': '26multiply_matrix_and_reduceI',
 'update_42': '28update_solution_and_residualE',
 'precondition_43': '23precondition_and_reduceI',
 'direction_43': '19update_cg_directionE',
 'matrix_43': '26multiply_matrix_and_reduceI',
 'update_43': '28update_solution_and_residualE',
 'precondition_44': '23precondition_and_reduceI',
 'direction_44': '19update_cg_directionE',
 'matrix_44': '26multiply_matrix_and_reduceI',
 'update_44': '28update_solution_and_residualE',
 'precondition_45': '23precondition_and_reduceI',
 'direction_45': '19update_cg_directionE',
 'matrix_45': '26multiply_matrix_and_reduceI',
 'update_45': '28update_solution_and_residualE',
 'precondition_46': '23precondition_and_reduceI',
 'direction_46': '19update_cg_directionE',
 'matrix_46': '26multiply_matrix_and_reduceI',
 'update_46': '28update_solution_and_residualE',
 'precondition_47': '23precondition_and_reduceI',
 'direction_47': '19update_cg_directionE',
 'matrix_47': '26multiply_matrix_and_reduceI',
 'update_47': '28update_solution_and_residualE',
 'precondition_48': '23precondition_and_reduceI',
 'direction_48': '19update_cg_directionE',
 'matrix_48': '26multiply_matrix_and_reduceI',
 'update_48': '28update_solution_and_residualE',
 'precondition_49': '23precondition_and_reduceI',
 'direction_49': '19update_cg_directionE',
 'matrix_49': '26multiply_matrix_and_reduceI',
 'update_49': '28update_solution_and_residualE'}


def select_stages(nodes, body_count, dof_count):
    assert len(nodes) == 17467 and body_count == 44 and dof_count == 49
    result = []
    for key, token in STAGES.items():
        matches = [i for i in range(9329, 9905) if token in nodes[i].get('name', '')]
        assert len(matches) == (1 if key in ('rhs', 'inverse') else 50)
        iteration = int(key.rsplit('_', 1)[1]) if '_' in key else 0
        rank = matches[iteration]
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
            assert integer(node, 0) == iteration
            assert integer(node, 2) == 0 and integer(node, 3) == integer(node, 7) == 176
            assert bool(integer(node, 5)) == (iteration > 0)
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
        result.append({'key': key, 'kernel_key': kind, 'rank': rank, 'node': node,
                       'sizes': dict(sorted(sizes.items())), 'outputs': outputs, 'output_overlaps': overlaps})
    expected = [9332, 9350] + [9355 + 11 * i + j for i in range(50) for j in (0, 1, 9, 10)]
    assert [s['rank'] for s in result] == expected
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
