"""Extend the late post-download probe to the three real Warp graph nodes, including defined array payloads."""
import argparse
from pathlib import Path
import sys


def sample_warp(graph, result, output):
    import ctypes as ct
    import hashlib
    import json
    import re
    import struct

    import numpy as np

    from .capture_cloth_graph_parameters import KernelParams

    driver = ct.CDLL('libcuda.so.1')
    for name, signature in {
        'cuGraphKernelNodeGetParams': [ct.c_void_p, ct.POINTER(KernelParams)],
        'cuFuncGetName': [ct.POINTER(ct.c_char_p), ct.c_void_p],
        'cuFuncGetParamInfo': [ct.c_void_p, ct.c_size_t, ct.POINTER(ct.c_size_t), ct.POINTER(ct.c_size_t)],
        'cuMemcpyDtoH_v2': [ct.c_void_p, ct.c_uint64, ct.c_size_t],
    }.items():
        getattr(driver, name).argtypes = signature
        getattr(driver, name).restype = ct.c_int
    expected = {
        '_predict_affine_body_inertia_': [24, *([56] * 8), 4, 4, 56, 56],
        '_predict_affine_body_velocities_': [24, *([56] * 6), 4, 56],
        '_update_affine_body_poses_': [24, *([56] * 7), 4, 4, 56, 56],
    }
    nodes, payloads = [], {}
    for block in (output / 'sampled-graph.dot').read_text().split('\n\n'):
        if 'label="{KERNEL' not in block or not any(token in block for token in expected):
            continue
        handle = re.search(r'node handle \| func handle\}\s*\|\s*\{(0x[0-9A-Fa-f]+)', block)
        assert handle
        params = KernelParams()
        assert driver.cuGraphKernelNodeGetParams(int(handle[1], 16), ct.byref(params)) == 0
        name = ct.c_char_p()
        assert driver.cuFuncGetName(ct.byref(name), params.func) == 0
        name = name.value.decode()
        widths = next(widths for token, widths in expected.items() if name.startswith(token))
        index = int(re.search(r'\| \{ID \| (\d+)', block)[1])
        assert params.params and not params.extra
        arguments = []
        for arg, width in enumerate(widths):
            offset, size = ct.c_size_t(), ct.c_size_t()
            assert driver.cuFuncGetParamInfo(params.func, arg, ct.byref(offset), ct.byref(size)) == 0
            assert size.value == width, (name, arg, size.value, width)
            data = ct.string_at(params.params[arg], width)
            entry = {'index': arg, 'offset': offset.value, 'width': width, 'hex': data.hex()}
            if width == 56:
                pointer, gradient = struct.unpack_from('<QQ', data)
                shape, strides = struct.unpack_from('<4i', data, 16), struct.unpack_from('<4i', data, 32)
                ndim, flags = struct.unpack_from('<HH', data, 48)
                assert ndim in (0, 1) and gradient == 0
                length = shape[0] * strides[0] if ndim == 1 else 0
                assert 0 <= length <= 1024 * 1024
                entry.update(data_pointer=pointer, shape=shape, strides=strides, ndim=ndim, flags=flags)
                if pointer and length:
                    host = ct.create_string_buffer(length)
                    assert driver.cuMemcpyDtoH_v2(host, pointer, length) == 0
                    key = f'node{index}_arg{arg}'
                    payloads[key] = np.frombuffer(host.raw, dtype='u1').copy()
                    entry['post_step_array_key'] = key
            arguments.append(entry)
        # Verify the end of the actual CUDA parameter table rather than guessing its extent.
        assert driver.cuFuncGetParamInfo(params.func, len(widths), ct.byref(offset), ct.byref(size)) == 1
        nodes.append({'index': index, 'name': name, 'parameters': arguments,
                      'geometry': [params.gx, params.gy, params.gz, params.bx, params.by, params.bz, params.shared]})
    assert [node['index'] for node in nodes] == [2, 3, 265]
    np.savez_compressed(output / 'warp-post-step.npz', **payloads)
    (output / 'warp-parameters.json').write_text(json.dumps({
        'nodes': nodes, 'read_after_existing_download': True, 'GPU_allocations_added': 0,
        'graph_parameters_changed': False, 'post_step_pointees_are_not_prelaunch_inputs': True,
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--source-checkpoint', type=Path)
    args = parser.parse_args()
    from . import late_cloth_graph_probe as probe
    original_sample = probe.sample

    def combined(graph, result, output):
        original_sample(graph, result, output)
        sample_warp(graph, result, output)

    probe.sample = combined
    if args.source_checkpoint:
        assert args.backend == 'source'
        from . import host_particles_ab as particles

        def frozen_source():
            import hashlib
            import importlib.util
            import json
            import sysconfig
            from .demo_source_ab import ROOT

            metadata = json.loads((args.source_checkpoint / 'checkpoint.json').read_text())
            for name, sha in metadata['files'].items():
                assert hashlib.sha256((args.source_checkpoint / 'preserved-files' / name).read_bytes()).hexdigest() == sha
            folder = 'build/reconstruction-csrc/host-particles/'
            saved = json.loads((args.source_checkpoint / 'preserved-files' / folder / 'build.json').read_text())
            active = json.loads((ROOT / folder / 'build.json').read_text())
            assert saved['kernels'] == active['kernels']
            path = args.source_checkpoint / 'preserved-files' / folder / ('_source_solver' +
                                                                        sysconfig.get_config_var('EXT_SUFFIX'))
            assert hashlib.sha256(path.read_bytes()).hexdigest() == metadata['source_sha256']
            spec = importlib.util.spec_from_file_location('_source_solver', path)
            module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(module)
            assert module.source_only
            return module

        particles.native_source = frozen_source
    sys.argv = [sys.argv[0], '--backend', args.backend, '--frames', '60', '--output', str(args.output)]
    probe.main()


if __name__ == '__main__':
    main()
