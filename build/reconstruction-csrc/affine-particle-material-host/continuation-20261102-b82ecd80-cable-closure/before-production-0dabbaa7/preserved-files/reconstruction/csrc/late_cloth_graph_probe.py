"""Inspect first-step caches only after the existing target download, without pre-step graph/CUDA hooks."""
import argparse
from pathlib import Path
import sys


def sample(graph, result, output):
    # Import inspection machinery only after the existing worker download completed.
    import ctypes as ct
    import hashlib
    import json
    import re
    import numpy as np
    from .capture_cloth_graph_parameters import KernelParams
    from .demo_source_ab import ROOT

    driver = ct.CDLL('libcuda.so.1')
    for name, types in {
        'cuGraphDebugDotPrint': [ct.c_void_p, ct.c_char_p, ct.c_uint],
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
    }.items():
        getattr(driver, name).argtypes = types
        getattr(driver, name).restype = ct.c_int
    manifest = json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())
    dot = output / 'sampled-graph.dot'
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
                      'parameters': [value.hex() for value in payloads]})

    def first(token):
        return next(node for node in nodes if token in node['name'])

    def uint(node, index):
        return int.from_bytes(bytes.fromhex(node['parameters'][index]), 'little')

    start, rhs = first('15initialize_step'), first('14initialize_rhs')
    pre, matrix = first('23precondition_and_reduce'), first('26multiply_matrix_and_reduce')
    build, apply = first('32build_affine_body_preconditioner'), first('32apply_affine_body_preconditioner')
    update = first('28update_solution_and_residual')
    count, local = uint(start, 23), uint(start, 24)
    groups, states, bodies = count // uint(pre, 5), uint(build, 19), uint(build, 20)
    boundary = first('20apply_nonlinear_step')['index']
    iterations = sum('23precondition_and_reduce' in node['name'] and node['index'] < boundary for node in nodes)
    assert uint(pre, 3) == 1
    fields = {
        'previous': (start, 20, count * 12), 'target': (start, 21, count * 12),
        'q_final': (start, 5, count * 12), 'qd_input': (start, 4, count * 12),
        'mass': (start, 17, local * 4), 'flags': (start, 18, local * 4),
        'force': (rhs, 7, count * 12), 'rhs_last_nl': (rhs, 9, count * 12),
        'inverse_last_nl': (pre, 0, count * 36), 'z_last': (pre, 2, count * 12),
        'affine_inverse_last_nl': (build, 17, states * 144 * 4),
        'affine_valid': (build, 18, states * 4), 'body_indices': (apply, 0, bodies * 16),
        'residual_final': (update, 7, count * 12), 'p_last': (matrix, 4, count * 12),
        'ap_last': (matrix, 6, count * 12), 'extra_last': (matrix, 5, count * 12),
        'numerator_last_nl': (pre, 6, groups * iterations * 4),
        'denominator_last_nl': (matrix, 9, groups * iterations * 4),
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
    assert result.shape == (count, 3) and arrays['q_final'].tobytes() == result.tobytes()
    np.savez_compressed(output / 'post-step.npz', **arrays)
    (output / 'post-step.json').write_text(json.dumps({
        'graph': 14, 'step': 0, 'cache_nonlinear_iteration': 'last', 'groups': groups,
        'particles': count, 'per_world': local, 'body_states': states, 'bodies_per_world': bodies,
        'linear_iterations': iterations, 'fields': layout, 'nodes': nodes,
        'GPU_allocations_added': 0, 'graph_nodes_added': 0, 'graph_parameters_changed': False,
        'graph_capture_and_launch_hooks_added': False,
        'probe_driver_loaded_only_after_existing_state_numpy': True,
        'replaces_fixed_candidate': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    import warp as wp
    from . import affine_cloth_graph_ab as worker
    from .affine_cloth_ab import cases

    fixtures = list(cases())
    assert fixtures[-1][0] == 'w3-newton-b1-d1-c1-s1-p1'
    lengths = [6 if '--contacts' in extra else 4 for _, _, _, extra in fixtures]
    target_download = args.frames * (2 * sum(lengths[:-1]) + lengths[-1]) + 1
    expected_downloads = args.frames * 2 * sum(lengths)
    original_numpy, downloads, sampled = wp.array.numpy, 0, False

    def inspected_numpy(array, *values, **kwargs):
        nonlocal downloads, sampled
        result = original_numpy(array, *values, **kwargs)
        frame = sys._getframe(1)
        if frame.f_code is worker.worker.__code__:
            downloads += 1
            if downloads == target_download:
                # Do not materialize f_locals on earlier fixtures: its dictionary could retain old scene objects.
                state = frame.f_locals
                assert state['name'] == fixtures[-1][0] and state['graph'] and state['step'] == 0
                assert state['key'] == 'particle_q'
                sample(state['graphs'][0], result, args.output)
                sampled = True
        return result

    wp.array.numpy = inspected_numpy
    args.worker = args.backend
    worker.worker(args)
    assert sampled and downloads == expected_downloads, (downloads, expected_downloads)


if __name__ == '__main__':
    main()
