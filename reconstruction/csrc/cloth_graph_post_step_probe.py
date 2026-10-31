"""Read existing CG caches after the worker's first completed state download; never change graph nodes or allocate GPU data."""
import argparse
import ctypes as ct
import hashlib
import json
from pathlib import Path
import re

import numpy as np

from .capture_cloth_graph_parameters import KernelParams
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import affine_cloth_graph_ab
    driver = ct.CDLL('libcuda.so.1')
    apis = {
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
    }
    for name, types in apis.items():
        getattr(driver, name).argtypes = types
        getattr(driver, name).restype = ct.c_int
    manifest = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    previous_exit, previous_launch, previous_numpy = wp.ScopedCapture.__exit__, wp.capture_launch, wp.array.numpy
    graph_count, watched, pending, sampled = 0, None, None, False

    def inspected_exit(capture, *values):
        nonlocal graph_count, watched
        result = previous_exit(capture, *values)
        if capture.graph is not None:
            if graph_count == 14:
                watched = capture.graph
            graph_count += 1
        return result

    def inspected_launch(graph, *values, **kwargs):
        nonlocal pending
        result = previous_launch(graph, *values, **kwargs)
        if graph is watched and not sampled:
            pending = graph
        return result

    def inspected_numpy(array, *values, **kwargs):
        nonlocal pending, sampled
        result = previous_numpy(array, *values, **kwargs)
        if pending is None:
            return result
        # The worker already downloaded its state. The first step has completed before any probe CUDA API runs.
        graph, pending, sampled = pending, None, True
        dot = args.output/'sampled-graph.dot'
        assert driver.cuGraphDebugDotPrint(graph.graph, str(dot).encode(), 1) == 0
        nodes = []
        for block in dot.read_text().split('\n\n'):
            if 'label="{KERNEL' not in block:
                continue
            handle = re.search(r'node handle \| func handle\}\s*\|\s*\{(0x[0-9A-Fa-f]+)', block)
            assert handle
            params = KernelParams()
            assert driver.cuGraphKernelNodeGetParams(int(handle[1], 16), ct.byref(params)) == 0
            name = ct.c_char_p()
            assert driver.cuFuncGetName(ct.byref(name), params.func) == 0
            name = name.value.decode()
            if name not in manifest['kernels']:
                continue
            widths = manifest['kernels'][name]['parameters']
            payloads = [ct.string_at(params.params[i], width) for i, width in enumerate(widths)]
            nodes.append({'index': int(re.search(r'\| \{ID \| (\d+)', block)[1]), 'name': name,
                          'geometry': [params.gx, params.gy, params.gz, params.bx, params.by, params.bz, params.shared],
                          'parameters': [v.hex() for v in payloads]})

        def first(token):
            return next(n for n in nodes if token in n['name'])

        def uint(node, index):
            return int.from_bytes(bytes.fromhex(node['parameters'][index]), 'little')

        start, rhs = first('15initialize_step'), first('14initialize_rhs')
        pre, matrix = first('23precondition_and_reduce'), first('26multiply_matrix_and_reduce')
        build, apply = first('32build_affine_body_preconditioner'), first('32apply_affine_body_preconditioner')
        update = first('28update_solution_and_residual')
        count, local = uint(start, 23), uint(start, 24)
        groups = count//uint(pre, 5)
        states, bodies = uint(build, 19), uint(build, 20)
        boundary = first('20apply_nonlinear_step')['index']
        iterations = sum('23precondition_and_reduce' in n['name'] and n['index'] < boundary for n in nodes)
        assert uint(pre, 3) == 1, 'This fixture must exercise the precomputed full body preconditioner'
        fields = {
            'previous': (start, 20, count*12), 'target': (start, 21, count*12),
            'q_final': (start, 5, count*12), 'qd_input': (start, 4, count*12),
            'mass': (start, 17, local*4), 'flags': (start, 18, local*4),
            'force': (rhs, 7, count*12), 'rhs_last_nl': (rhs, 9, count*12),
            'inverse_last_nl': (pre, 0, count*36), 'z_last': (pre, 2, count*12),
            'affine_inverse_last_nl': (build, 17, states*144*4),
            'affine_valid': (build, 18, states*4), 'body_indices': (apply, 0, bodies*16),
            'residual_final': (update, 7, count*12), 'p_last': (matrix, 4, count*12),
            'ap_last': (matrix, 6, count*12), 'extra_last': (matrix, 5, count*12),
            'numerator_last_nl': (pre, 6, groups*iterations*4),
            'denominator_last_nl': (matrix, 9, groups*iterations*4),
        }
        arrays, layout = {}, {}
        for label, (node, index, size) in fields.items():
            pointer = uint(node, index)
            if not pointer:
                continue
            payload = ct.create_string_buffer(size)
            assert driver.cuMemcpyDtoH_v2(payload, pointer, size) == 0, label
            arrays[label] = np.frombuffer(payload.raw, dtype=np.uint8).copy()
            layout[label] = {'bytes': size, 'pointer': hex(pointer)}
        assert result.shape == (count, 3), 'The fixture state includes its affine proxy particles'
        assert arrays['q_final'].tobytes() == result.tobytes(), 'Probe must follow the actual particle_q download'
        np.savez_compressed(args.output/'post-step.npz', **arrays)
        (args.output/'post-step.json').write_text(json.dumps({
            'graph': 14, 'step': 0, 'cache_nonlinear_iteration': 'last', 'groups': groups,
            'particles': count, 'per_world': local, 'body_states': states, 'bodies_per_world': bodies,
            'linear_iterations': iterations, 'fields': layout, 'nodes': nodes,
            'GPU_allocations_added': 0, 'graph_nodes_added': 0, 'graph_parameters_changed': False,
            'probe_CUDA_apis_only_after_existing_state_numpy': True, 'replaces_fixed_candidate': False,
            'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        }, indent=2)+'\n')
        return result

    wp.ScopedCapture.__exit__, wp.capture_launch, wp.array.numpy = inspected_exit, inspected_launch, inspected_numpy
    args.worker = args.backend
    affine_cloth_graph_ab.worker(args)
    assert graph_count == 16 and sampled


if __name__ == '__main__':
    main()
