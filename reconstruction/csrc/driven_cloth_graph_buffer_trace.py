"""Diagnostic driven-cloth graph snapshots, with actual multi-body and scalar/block row dimensions."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from .audit_cudahook import parameter_types
from .capture_cloth_graph_parameters import KernelParams
from .demo_source_ab import ROOT


class Copy3D(ct.Structure):
    _fields_ = [(prefix+name, kind) for prefix in ('src', 'dst') for name, kind in (
        ('XInBytes', ct.c_size_t), ('Y', ct.c_size_t), ('Z', ct.c_size_t), ('LOD', ct.c_size_t),
        ('MemoryType', ct.c_int), ('Host', ct.c_void_p), ('Device', ct.c_uint64), ('Array', ct.c_void_p),
        ('Reserved', ct.c_void_p), ('Pitch', ct.c_size_t), ('Height', ct.c_size_t))] + [
            ('WidthInBytes', ct.c_size_t), ('Height', ct.c_size_t), ('Depth', ct.c_size_t)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--graphs', type=int, nargs='+', default=[10, 14, 26, 30])
    parser.add_argument('--snapshot-runs', type=int, default=10)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import driven_cloth_graph_ab
    driver = ct.CDLL('libcuda.so.1')
    definitions = {
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuMemAlloc_v2': [ct.POINTER(ct.c_uint64), ct.c_size_t],
        'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
        'cuGraphAddMemcpyNode': [ct.POINTER(ct.c_void_p), ct.c_void_p, ct.POINTER(ct.c_void_p),
                                 ct.c_size_t, ct.POINTER(Copy3D), ct.c_void_p],
        'cuGraphAddDependencies': [ct.c_void_p, ct.POINTER(ct.c_void_p), ct.POINTER(ct.c_void_p), ct.c_size_t],
        'cuCtxGetCurrent': [ct.POINTER(ct.c_void_p)],
    }
    for name, types in definitions.items():
        getattr(driver, name).argtypes = types
        getattr(driver, name).restype = ct.c_int
    assert ct.sizeof(Copy3D) == 200
    manifest = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    previous_exit, previous_launch = wp.ScopedCapture.__exit__, wp.capture_launch
    graphs, records = {}, []

    def inspected_exit(capture, *values):
        result = previous_exit(capture, *values)
        if capture.graph is None:
            return result
        index = len(records)
        records.append({'graph': index, 'snapshots': []})
        if index not in args.graphs:
            return result
        assert capture.graph.graph_exec is None
        path = args.output/f'graph-{index:02d}.dot'
        assert driver.cuGraphDebugDotPrint(capture.graph.graph, str(path).encode(), 1) == 0
        context = ct.c_void_p()
        assert driver.cuCtxGetCurrent(ct.byref(context)) == 0
        blocks = path.read_text().split('\n\n')
        handles = {}
        for block in blocks:
            if 'node handle' not in block:
                continue
            node = re.search(r'"graph_\d+_node_(\d+)"', block)
            handle = re.search(r'0x[0-9A-Fa-f]+', block)
            assert node and handle
            handles[int(node[1])] = int(handle[0], 16)
        assert sorted(handles) == list(range(len(handles)))
        owned = []
        for block in blocks:
            if 'label="{KERNEL' not in block:
                continue
            node = int(re.search(r'\| \{ID \| (\d+)', block)[1])
            params = KernelParams()
            assert driver.cuGraphKernelNodeGetParams(handles[node], ct.byref(params)) == 0
            name = ct.c_char_p()
            assert driver.cuFuncGetName(ct.byref(name), params.func) == 0
            name = name.value.decode()
            if name.startswith('_ZN7synreal'):
                owned.append((node, name, params))
        records[index]['owned_nodes'] = [
            {'index': node, 'name': name,
             'geometry': [params.gx, params.gy, params.gz, params.bx, params.by, params.bz, params.shared],
             'raw_hex': [ct.string_at(params.params[i], width).hex()
                         for i, width in enumerate(manifest['kernels'][name]['parameters'])]}
            for node, name, params in owned]
        start = next(p for _, name, p in owned if '15initialize_step' in name)
        scalar = lambda p, i: ct.c_uint64.from_address(p.params[i]).value
        total, local = scalar(start, 23), scalar(start, 24)
        worlds = total//local
        rhs = next(p for _, name, p in owned if '14initialize_rhs' in name)
        maximum = scalar(rhs, 6)
        build = next(p for _, name, p in owned if '32build_affine_body_preconditioner' in name)
        body_states, local_bodies = scalar(build, 19), scalar(build, 20)
        assert total == 36 and local == 12 and worlds == 3
        assert body_states == 6 and local_bodies == 2
        records[index]['dimensions'] = {'particles': total, 'local': local, 'worlds': worlds,
                                        'body_states': body_states, 'local_bodies': local_bodies, 'maximum': maximum}
        layouts = {
            '15initialize_step': {20: total*12, 21: total*12, 22: total*4},
            '14initialize_rhs': {9: total*12},
            '27combine_system_non_diagonal': {13: local*maximum*8},
            '29initialize_block_non_diagonal': {4: total*maximum*40},
            '25initialize_block_diagonal': {1: total*36},
            '27invert_block_preconditioner': {3: total*36},
            '32initialize_affine_body_so3_state': {2: body_states*36, 3: body_states*36},
            '51evaluate_affine_body_so3_augmented_lagrangian_force': {6: total*12},
            '55add_affine_body_so3_augmented_lagrangian_preconditioner': {4: total*36},
            '22evaluate_bending_force': {7: total*12},
            '21evaluate_spring_force': {4: total*12},
            '22evaluate_stretch_force': {5: total*12},
            '27evaluate_soft_contact_force': {36: total*12, 37: total*4, 40: total*36, 41: total*36},
            '39add_cloth_membrane_gauss_newton_hessian': {5: total*36, 7: total*maximum*40},
            '22accumulate_vertex_face': {11: total*12, 12: total*36},
            '20accumulate_edge_edge': {9: total*12, 10: total*36},
            '20accumulate_edge_face': {10: total*12, 11: total*36},
            '20add_hessian_diagonal': {1: total*36},
            '32build_affine_body_preconditioner': {17: body_states*144*4, 18: body_states*4},
            '35apply_block_diagonal_preconditioner': {2: total*12},
            '32apply_affine_body_preconditioner': {4: total*12},
            '23precondition_and_reduce': {2: total*12, 6: worlds*4},
            '19update_cg_direction': {6: total*12},
            '25multiply_hessian_diagonal': {2: total*12},
            '25multiply_contact_tangents': {3: total*12},
            '26multiply_matrix_and_reduce': {6: total*12, 9: worlds*4},
            '28update_solution_and_residual': {6: total*12, 7: total*12},
            '20apply_nonlinear_step': {1: total*12},
            '15update_velocity': {3: total*12},
        }
        buffers = []

        def snapshot(previous, name, label, pointer, size):
            destination = ct.c_uint64()
            assert driver.cuMemAlloc_v2(ct.byref(destination), size) == 0
            copy = Copy3D()
            copy.srcMemoryType = copy.dstMemoryType = 2
            copy.srcDevice, copy.dstDevice = pointer, destination.value
            copy.WidthInBytes, copy.Height, copy.Depth = size, 1, 1
            inserted = ct.c_void_p()
            assert driver.cuGraphAddMemcpyNode(ct.byref(inserted), capture.graph.graph, ct.byref(previous),
                                               1, ct.byref(copy), context) == 0
            records[index]['snapshots'].append({'key': label, 'bytes': size, 'name': name})
            buffers.append((label, destination.value, size))
            return inserted

        for node, name, params in owned:
            matches = [key for key in layouts if key in name]
            if not matches:
                continue
            assert len(matches) == 1
            key = matches[0]
            types = parameter_types(name)
            before = {}
            if key == '15initialize_step':
                before = {4: total*12, 5: total*12, **{i: local*4 for i in (6, 7, 9, 11, 13, 15, 17, 18, 19)}}
            elif key == '14initialize_rhs':
                before = {1: total*12, 2: total*12, 3: local*4, 4: local*4, 5: local*maximum*8,
                          7: total*12, 8: local*4}
            elif key == '32build_affine_body_preconditioner':
                before = {4: total*36, 5: total*4, 6: total*maximum*40, 16: body_states*144*4}
                if 'NonZeroEntry' in types[6] and 'BlockNonZeroEntry' not in types[6]:
                    before[5] = local*4
                    before[6] = local*maximum*8
            elif key == '26multiply_matrix_and_reduce':
                rows, maximum_entries = scalar(params, 11), scalar(params, 2)
                assert scalar(params, 10) == total and scalar(params, 8) == local
                before = {3: total*(36 if 'glm::mat' in types[3] else 4), 4: total*12, 5: total*12,
                          7: total*4, 9: worlds*4}
                if maximum_entries:
                    before[0] = rows*4
                    before[1] = rows*maximum_entries*(40 if 'BlockNonZeroEntry' in types[1] else 8)
            elif key == '23precondition_and_reduce':
                before = {0: total*(36 if 'glm::mat' in types[0] else 4), 1: total*12, 6: worlds*4}
                if ct.c_bool.from_address(params.params[3]).value:
                    before[2] = total*12
            if before:
                previous = ct.c_void_p(handles[node-1])
                for argument, size in before.items():
                    assert '*' in types[argument]
                    source = scalar(params, argument)
                    if source:
                        previous = snapshot(previous, name, f'n{node:03d}-{key}-pre-a{argument}', source, size)
                following = ct.c_void_p(handles[node])
                assert driver.cuGraphAddDependencies(capture.graph.graph, ct.byref(previous),
                                                     ct.byref(following), 1) == 0
            previous = ct.c_void_p(handles[node])
            for argument, size in layouts[key].items():
                assert '*' in types[argument], (name, argument)
                source = scalar(params, argument)
                if not source:
                    continue
                label = f'n{node:03d}-{key}-a{argument}'
                previous = snapshot(previous, name, label, source, size)
            if node+1 in handles:
                following = ct.c_void_p(handles[node+1])
                assert driver.cuGraphAddDependencies(capture.graph.graph, ct.byref(previous),
                                                     ct.byref(following), 1) == 0
        graphs[id(capture.graph)] = [index, buffers, 0]
        return result

    def inspected_launch(graph, *values, **kwargs):
        result = previous_launch(graph, *values, **kwargs)
        if id(graph) not in graphs:
            return result
        index, buffers, ordinal = graphs[id(graph)]
        # Bound snapshots independently of the complete trajectories used to detect observer effects.
        if ordinal < args.snapshot_runs:
            wp.synchronize()
            arrays = {}
            for label, pointer, size in buffers:
                payload = ct.create_string_buffer(size)
                assert driver.cuMemcpyDtoH_v2(payload, pointer, size) == 0
                arrays[label] = np.frombuffer(payload.raw, dtype=np.uint8).copy()
            np.savez_compressed(args.output/f'trace-g{index:02d}-run{ordinal:02d}.npz', **arrays)
        graphs[id(graph)][2] += 1
        return result

    wp.ScopedCapture.__exit__, wp.capture_launch = inspected_exit, inspected_launch
    args.worker = args.backend
    driven_cloth_graph_ab.worker(args)
    assert len(records) == 32
    (args.output/'trace.json').write_text(json.dumps({
        'graphs': records, 'diagnostic_only': True, 'replaces_fixed_candidate': False,
        'observer_can_affect_atomic_order': True,
        'selected_graphs': args.graphs, 'snapshot_runs_per_graph': args.snapshot_runs,
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2)+'\n')


if __name__ == '__main__':
    main()
