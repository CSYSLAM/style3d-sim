"""Observe real fourth-substep CG coefficients and nonlinear updates without changing production arithmetic."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import sys

import numpy as np

from .demo_source_ab import ROOT
from .g1_checkpoint_substeps import TraceHook, rendered_worker
from .g1_drive_tangent_capture import Observer as Transport, integer
from .graph_definition_compare import linear_order
from .graph_definition_dump import Copy3D, dump_graph


def select_events(nodes):
    starts = [i for i, n in enumerate(nodes) if '15initialize_stepE' in n.get('name', '')]
    assert len(nodes) == 17467 and starts == [17 + 2910 * i for i in range(6)]
    left, right = starts[3:5]
    applies = [(i, n) for i, n in enumerate(nodes[left:right], left) if '20apply_nonlinear_stepE' in n.get('name', '')]
    assert [i for i, _ in applies] == [9328, 9905, 10483, 11060, 11638]
    mapping = nodes[8750]
    assert '32initialize_affine_body_so3_stateE' in mapping['name']
    result, previous = [], left
    for nonlinear, (rank, node) in enumerate(applies):
        updates = [(i, n) for i, n in enumerate(nodes[previous:rank], previous)
                   if '28update_solution_and_residualE' in n.get('name', '')]
        assert len(updates) == 50
        numerator_base, denominator_base = integer(updates[0][1], 2), integer(updates[0][1], 3)
        for iteration, (i, update) in enumerate(updates):
            assert update['parameter_widths'] == [8, 4, 8, 8, 8, 8, 8, 8, 8]
            assert update['geometry'] == [1, 1, 1, 256, 1, 1, 0]
            assert integer(update, 0) == 0 and integer(update, 1) == integer(update, 8) == 176
            assert integer(update, 2) == numerator_base + 4 * iteration
            assert integer(update, 3) == denominator_base + 4 * iteration
            assert '26multiply_matrix_and_reduceI' in nodes[i - 1]['name']
            before = [{'label': 'cg-' + str(nonlinear) + '-' + str(iteration) + '-' + label,
                       'source_rank': i, 'parameter': arg, 'bytes': 4}
                      for label, arg in [('numerator', 2), ('denominator', 3)]]
            if nonlinear == iteration == 0:
                before.insert(0, {'label': 'model-body-indices', 'source_rank': 8750, 'parameter': 1, 'bytes': 704})
            result.append({'rank': i, 'kind': 'cg', 'nonlinear': nonlinear, 'iteration': iteration,
                           'node': update, 'before': before, 'after': []})
        assert node['parameter_widths'] == [8] * 4 and integer(node, 3) == 176
        assert node['geometry'] == [1, 1, 1, 256, 1, 1, 0]
        before = [{'label': 'apply-' + str(nonlinear) + '-before-' + str(arg),
                   'source_rank': rank, 'parameter': arg, 'bytes': 2112} for arg in (0, 1, 2)]
        after = [{'label': 'apply-' + str(nonlinear) + '-after-' + str(arg),
                  'source_rank': rank, 'parameter': arg, 'bytes': 2112} for arg in (1, 2)]
        result.append({'rank': rank, 'kind': 'apply', 'nonlinear': nonlinear,
                       'node': node, 'before': before, 'after': after})
        previous = rank + 1
    velocities = [(i, n) for i, n in enumerate(nodes) if '15update_velocityE' in n.get('name', '')]
    assert len(velocities) == 6
    for step, (rank, node) in enumerate(velocities):
        assert node['parameter_widths'] == [4, 8, 8, 8, 8]
        assert integer(node, 0) == 0x43b40000 and integer(node, 4) == 176
        result.append({'rank': rank, 'kind': 'velocity', 'substep': step, 'node': node, 'before': [],
                       'after': [{'label': 'velocity-' + str(step), 'source_rank': rank, 'parameter': 3, 'bytes': 2112}]})
    result.sort(key=lambda event: event['rank'])
    assert len(result) == 261
    assert sum(len(e['before']) + len(e['after']) for e in result) == 532
    assert sum(w['bytes'] for e in result for w in [*e['before'], *e['after']]) == 68176
    return result


class Observer(Transport):
    def __init__(self, output, abi):
        self.output, self.abi, self.frames = output, abi, 0
        self.driver, self.device = None, ct.c_uint64()

    def attach(self, example):
        assert self.driver is None and example.graph.graph_exec is None
        dump_graph(example.graph, self.output / 'definition-before', self.abi)
        definition = json.loads((self.output / 'definition-before/graph.json').read_text())
        nodes = linear_order(definition)[0]
        events = select_events(nodes)
        self.driver = ct.CDLL('libcuda.so.1')
        signatures = {
            'cuCtxGetCurrent': [ct.POINTER(ct.c_void_p)],
            'cuMemAlloc_v2': [ct.POINTER(ct.c_uint64), ct.c_size_t], 'cuMemFree_v2': [ct.c_uint64],
            'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
            'cuGraphAddMemcpyNode': [ct.POINTER(ct.c_void_p), ct.c_void_p, ct.POINTER(ct.c_void_p),
                                     ct.c_size_t, ct.POINTER(Copy3D), ct.c_void_p],
            'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.c_size_t],
            'cuGraphMemcpyNodeGetParams': [ct.c_void_p, ct.POINTER(Copy3D)],
            'cuGraphGetNodes': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
            'cuGraphGetEdges': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_size_t)],
        }
        for name, signature in signatures.items():
            getattr(self.driver, name).argtypes, getattr(self.driver, name).restype = signature, ct.c_int
        assert ct.sizeof(Copy3D) == self.abi['copy_size'] == 200
        self.bytes = 68176
        self.checked('cuMemAlloc_v2', ct.byref(self.device), self.bytes)
        context = ct.c_void_p()
        self.checked('cuCtxGetCurrent', ct.byref(context))
        assert context.value
        offset, snapshots, last_after = 0, [], {}

        def copy(watch, phase, event, previous):
            nonlocal offset
            address = integer(nodes[watch['source_rank']], watch['parameter'])
            assert address
            params = Copy3D()
            params.srcMemoryType = params.dstMemoryType = 2
            params.srcDevice, params.dstDevice = address, self.device.value + offset
            params.WidthInBytes, params.Height, params.Depth = watch['bytes'], 1, 1
            handle = ct.c_void_p()
            self.checked('cuGraphAddMemcpyNode', ct.byref(handle), example.graph.graph, ct.byref(previous),
                         1, ct.byref(params), context)
            actual = Copy3D()
            self.checked('cuGraphMemcpyNodeGetParams', handle, ct.byref(actual))
            assert actual.srcMemoryType == actual.dstMemoryType == 2
            assert actual.srcDevice == address and actual.dstDevice == self.device.value + offset
            assert (actual.WidthInBytes, actual.Height, actual.Depth) == (watch['bytes'], 1, 1)
            snapshots.append({**watch, 'phase': phase, 'rank': event['rank'], 'source': address,
                              'offset': offset, 'handle': handle.value, 'predecessor': previous.value,
                              'actual_copy_parameters_hex': bytes(actual).hex()})
            offset += watch['bytes']
            return handle

        for event in events:
            rank = event['rank']
            target = ct.c_void_p(event['node']['handle'])
            if event['before']:
                previous = last_after.get(rank - 1, ct.c_void_p(nodes[rank - 1]['handle']))
                for watch in event['before']:
                    previous = copy(watch, 'before', event, previous)
                self.checked('cuGraphAddDependencies', example.graph.graph, ct.byref(previous), ct.byref(target), 1)
            if event['after']:
                previous = target
                for watch in event['after']:
                    previous = copy(watch, 'after', event, previous)
                following = ct.c_void_p(nodes[rank + 1]['handle'])
                self.checked('cuGraphAddDependencies', example.graph.graph, ct.byref(previous), ct.byref(following), 1)
                last_after[rank] = previous
        assert offset == self.bytes
        count, edge_count = ct.c_size_t(), ct.c_size_t()
        self.checked('cuGraphGetNodes', example.graph.graph, None, ct.byref(count))
        handles = (ct.c_void_p * count.value)()
        self.checked('cuGraphGetNodes', example.graph.graph, handles, ct.byref(count))
        self.checked('cuGraphGetEdges', example.graph.graph, None, None, ct.byref(edge_count))
        left, right = (ct.c_void_p * edge_count.value)(), (ct.c_void_p * edge_count.value)()
        self.checked('cuGraphGetEdges', example.graph.graph, left, right, ct.byref(edge_count))
        topology = {'nodes': [{'handle': int(h)} for h in handles], 'edges': [(int(a), int(b)) for a, b in zip(left, right)]}
        assert count.value == 17999 and edge_count.value == 18264
        assert set(map(tuple, definition['edges'])) <= set(topology['edges'])
        positions = {n['handle']: i for i, n in enumerate(linear_order(topology)[0])}
        for watch in snapshots:
            rank = watch['rank']
            assert positions[nodes[rank - 1]['handle']] < positions[watch['handle']] < positions[nodes[rank]['handle']] \
                if watch['phase'] == 'before' else \
                positions[nodes[rank]['handle']] < positions[watch['handle']] < positions[nodes[rank + 1]['handle']]
        self.layout = {'events': events, 'snapshots': snapshots, 'bytes': self.bytes, 'device_base': self.device.value,
                       'partial_read_only_watches_not_full_CG_input_capture': True,
                       'production_changed': False, 'whole_solver_complete': False}
        (self.output / 'layout.json').write_text(json.dumps(self.layout, indent=2) + '\n')
        (self.output / 'graph-after-topology.json').write_text(json.dumps(topology, indent=2) + '\n')

    def record(self):
        payload = ct.create_string_buffer(self.bytes)
        self.checked('cuMemcpyDtoH_v2', payload, self.device, self.bytes)
        np.savez_compressed(self.output / ('observations-' + str(self.frames) + '.npz'),
                            blob=np.frombuffer(payload.raw, dtype='u1').copy())
        self.frames += 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--plan', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    plan = json.loads(args.plan.read_text())
    for name, expected in plan['input_sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest() == expected, name
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    trace = output / 'trace'
    trace.mkdir()
    observer = Observer(trace, json.loads(Path(plan['abi']).read_text()))
    hook = TraceHook(plan, output, observer)
    text = rendered_worker()
    assert hashlib.sha256(text.encode()).hexdigest() == plan['patched_worker_sha256']
    script = output / 'worker-as-run.py'
    script.write_text(text)
    sys.argv = [str(script), '--backend', args.backend, '--core-build', plan['core_build'],
                '--example', str(ROOT / 'examples/example_robot_g1.py'), '--frames', '1',
                '--output', str(output / 'worker'), '--', '--solver', 'synreal', '--world-count', '1']
    try:
        exec(compile(text, str(script), 'exec'), {'__name__': '__main__', '__package__': 'reconstruction.csrc',
                                               '__file__': str(script), 'checkpoint_hook': hook})
        assert observer.frames == 1
    finally:
        observer.close()
        (output / 'trace-provenance.json').write_text(json.dumps({
            'frames_read': observer.frames, 'wrapper_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'diagnostic_snapshots_may_change_atomic_schedule': True, 'original_velocity_helper_bug_retained': True,
            'production_changed': False, 'old_C8_reclassified': False, 'whole_solver_complete': False,
        }, indent=2) + '\n')


if __name__ == '__main__':
    main()
