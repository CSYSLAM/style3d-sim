"""Capture real original Solver constructors, then replay their primitive boxes through source BVH construction.

The standalone source prototype uses accepted CUDA kernels and the source-built CUDA 12.4 library bridge.
It does not load the original .so. Particle-box construction and full Solver integration remain separate checks.
"""
import argparse
import ctypes as ct
import hashlib
import json
import os
from pathlib import Path
import resource
import struct
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT

COUNTS = (1, 2, 8, 257, 1025, 4097, 4864, 4865, 65537)


def capture_solver(backend, output):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_particles_ab import native_source
        from .host_bodies_ab import bridge
        core = native_source()
        bridge(core)
    import newton
    import style3d_sim as s3d
    for count in COUNTS:
        directory = output/f'n{count}'
        directory.mkdir()
        os.environ['CUDAHOOK_DIR'] = str(directory)
        nodes = 2*count - 1
        os.environ['CUDAHOOK_DUMP'] = (
            f'20build_particle_aabbs=3:{count*24};21generate_morton_codes=0:{count*4};'
            f'16build_radix_tree=2:{count*4};18build_escape_nodes=0:{nodes*4},1:{nodes*4},2:{max(count-1, 1)*8};'
            f'26build_primitive_leaf_nodes=0:{count*4},1:{count*4}')
        rng = np.random.default_rng(604 + count)
        positions = rng.uniform(-3., 3., (count, 3)).astype('f4')
        positions[::5] = positions[0]
        builder = newton.ModelBuilder()
        builder.add_particles(pos=positions.tolist(), vel=np.zeros_like(positions).tolist(),
                              mass=np.ones(count).tolist(), radius=np.full(count, .015).tolist())
        model = builder.finalize(device='cuda:0')
        solver = s3d.NewtonSolver(model)
        wp.synchronize()
        assert isinstance(solver._native_solver, core.Solver)
        (directory/'case.json').write_text(json.dumps({'count': count, 'seed': 604 + count,
            'backend': backend, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest()}, indent=2)+'\n')
        if backend == 'solver-source':
            (directory/'launch-counts.json').write_text(json.dumps(dict(solver._native_solver.source_launch_counts),
                                                                 indent=2)+'\n')
        print(backend, 'constructor', count, flush=True)
    if backend == 'solver-source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def replay_source(output, original, library_path):
    from .host_particles_ab import native_source
    from .audit_cudahook import compare, schemas
    core = native_source()
    cuda = ct.CDLL('libcuda.so.1')
    assert cuda.cuInit(0) == 0
    cuda.cuDevicePrimaryCtxRetain.argtypes = [ct.POINTER(ct.c_void_p), ct.c_int]
    cuda.cuCtxSetCurrent.argtypes = [ct.c_void_p]
    context = ct.c_void_p()
    assert cuda.cuDevicePrimaryCtxRetain(ct.byref(context), 0) == 0
    assert cuda.cuCtxSetCurrent(context) == 0
    driver = core._KernelDriver()
    proof = json.loads((library_path.parent/'build.json').read_text())
    assert proof['library_sha256'] == hashlib.sha256(library_path.read_bytes()).hexdigest()
    assert all(proof['device_entries_identical_to_accepted_source'].values())
    for name, expected in proof['inputs'].items():
        assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest() == expected, 'Stale bridge input: '+name
    library = ct.CDLL(str(library_path.resolve()))
    library.source_bvh_sequence_fill.argtypes = [ct.c_void_p, ct.c_void_p, ct.c_uint, ct.c_void_p]
    library.source_bvh_reduce.argtypes = [ct.c_void_p, ct.POINTER(ct.c_size_t), ct.c_void_p, ct.c_void_p,
                                         ct.c_uint, ct.c_void_p]
    library.source_bvh_sort.argtypes = [ct.c_void_p, ct.POINTER(ct.c_size_t), ct.c_void_p, ct.c_void_p,
                                       ct.c_void_p, ct.c_void_p, ct.c_uint, ct.POINTER(ct.c_int), ct.c_void_p]
    manifest = json.loads((ROOT/'build/reconstruction-csrc/host-particles/build.json').read_text())
    keys = ('21generate_morton_codes', '16build_radix_tree', '18build_escape_nodes', '26build_primitive_leaf_nodes')
    symbols = {key: next(name for name in manifest['kernels'] if 'kernel'+key in name) for key in keys}
    reports = []
    for count in COUNTS:
        source = original/f'n{count}'
        directory = output/f'n{count}'
        directory.mkdir()
        os.environ['CUDAHOOK_DIR'] = str(directory)
        nodes, allocations = 2*count - 1, []

        def captured(key, phase, argument):
            paths = list(source.glob(f'dump_{key}_*_{phase}_arg{argument}.bin'))
            assert len(paths) == 1, (source, key, phase, argument, paths)
            return paths[0].read_bytes()

        def upload(data):
            pointer = driver.upload(data)
            allocations.append(pointer)
            return pointer

        def allocate(size):
            return upload(bytes(size)) if size else 0

        def launch(key, threads, parameters):
            driver.launch(driver.function(symbols[key]), (threads+255)//256, 256, parameters)

        q = lambda pointer: struct.pack('<Q', pointer)
        u = lambda value: struct.pack('<I', value)
        parents, children = allocate(nodes*4), allocate((count-1)*8)
        sorted_ids, primitive_leaf, escape = allocate(count*4), allocate(count*4), allocate(nodes*4)
        assert library.source_bvh_sequence_fill(sorted_ids, parents, count, None) == 0
        result = {}
        if count > 1:
            boxes = upload(captured('20build_particle_aabbs', 'post', 3))
            scene, codes = allocate(24), allocate(count*4)
            alternate_codes, alternate_ids = allocate(count*4), allocate(count*4)
            size = ct.c_size_t()
            assert library.source_bvh_reduce(None, ct.byref(size), boxes, scene, count, None) == 0
            temporary = allocate(size.value)
            assert library.source_bvh_reduce(temporary, ct.byref(size), boxes, scene, count, None) == 0
            driver.synchronize()
            scene_bytes = driver.download(scene, 24)
            reference_line = next(line for line in (source/'launches.txt').read_text().splitlines()
                                  if line.split()[1] == '21generate_morton_codes')
            scene_token = next(word for word in reference_line.split() if word.startswith('aabb:'))
            reference_scene = struct.pack('<6f', *(float(word) for word in scene_token[5:].split(',')))
            result['scene-box'] = scene_bytes == reference_scene
            launch('21generate_morton_codes', count, [q(codes), q(boxes), scene_bytes, u(count)])
            driver.synchronize()
            result['codes-before-sort'] = driver.download(codes, count*4) == captured('21generate_morton_codes', 'post', 0)
            size, selectors = ct.c_size_t(), (ct.c_int*2)()
            assert library.source_bvh_sort(None, ct.byref(size), codes, alternate_codes, sorted_ids, alternate_ids,
                                            count, selectors, None) == 0
            temporary = allocate(size.value)
            assert library.source_bvh_sort(temporary, ct.byref(size), codes, alternate_codes, sorted_ids, alternate_ids,
                                            count, selectors, None) == 0
            assert selectors[0] in (0, 1) and selectors[1] in (0, 1)
            codes = (codes, alternate_codes)[selectors[0]]
            sorted_ids = (sorted_ids, alternate_ids)[selectors[1]]
            driver.synchronize()
            result['codes-after-sort'] = driver.download(codes, count*4) == captured('16build_radix_tree', 'pre', 2)
            launch('16build_radix_tree', count-1, [q(parents), q(children), q(codes), u(count)])
        launch('18build_escape_nodes', nodes, [q(escape), q(parents), q(children), u(nodes)])
        launch('26build_primitive_leaf_nodes', count, [q(primitive_leaf), q(sorted_ids), u(count)])
        driver.synchronize()
        for name, pointer, size, key, phase, argument in (
                ('parents', parents, nodes*4, '18build_escape_nodes', 'pre', 1),
                ('children', children, (count-1)*8, '18build_escape_nodes', 'pre', 2),
                ('escape', escape, nodes*4, '18build_escape_nodes', 'post', 0),
                ('sorted', sorted_ids, count*4, '26build_primitive_leaf_nodes', 'pre', 1),
                ('primitive-leaf', primitive_leaf, count*4, '26build_primitive_leaf_nodes', 'post', 0)):
            if size:
                actual = driver.download(pointer, size)
                (directory/(name+'.bin')).write_bytes(actual)
                result[name] = actual == captured(key, phase, argument)
        paths = []
        for path in (source, directory):
            lines = (path/'launches.txt').read_text().splitlines()
            selected = [line for line in lines if line.split()[1] in keys]
            target = directory/('reference-owned.txt' if path == source else 'source-owned.txt')
            target.write_text('\n'.join(str(i)+' '+line.split(' ', 1)[1]
                                        for i, line in enumerate(selected))+'\n')
            paths.append(target)
        metadata = compare(*paths, schemas()[0])
        row = {'count': count, 'buffers_bitwise': result, 'owned_metadata': metadata,
               'filtered_owned_logs_rebased': True, 'library_launches_completely_observed': False}
        reports.append(row)
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        print('source constructor prototype', count, all(result.values()), metadata['equal'], flush=True)
        for pointer in allocations:
            driver.release(pointer)
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    report = {'source_solver_image': manifest['extension_sha256'], 'library_sha256':
              hashlib.sha256(library_path.read_bytes()).hexdigest(), 'original_mapped': False,
              'full_solver_integrated': False, 'cases': reports}
    (output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    del driver
    assert cuda.cuCtxSetCurrent(None) == 0
    assert cuda.cuDevicePrimaryCtxRelease(0) == 0
    return any(not all(row['buffers_bitwise'].values()) or not row['owned_metadata']['equal'] for row in reports)


def compare_native(output, original, source):
    from .audit_cudahook import compare, schemas
    fields = (('20build_particle_aabbs', 'post', 3), ('21generate_morton_codes', 'post', 0),
              ('16build_radix_tree', 'pre', 2), ('18build_escape_nodes', 'pre', 1),
              ('18build_escape_nodes', 'pre', 2), ('18build_escape_nodes', 'post', 0),
              ('26build_primitive_leaf_nodes', 'pre', 1), ('26build_primitive_leaf_nodes', 'post', 0))
    reports = []
    for count in COUNTS:
        left, right, directory = original/f'n{count}', source/f'n{count}', output/f'n{count}'
        directory.mkdir()
        checks = {}
        for key, phase, argument in fields:
            if count == 1 and (key in ('21generate_morton_codes', '16build_radix_tree') or
                               (key == '18build_escape_nodes' and argument == 2)):
                continue
            paths = [list(path.glob(f'dump_{key}_*_{phase}_arg{argument}.bin')) for path in (left, right)]
            assert all(len(group) == 1 for group in paths), (count, key, phase, argument)
            checks[f'{key}/{phase}/{argument}'] = paths[0][0].read_bytes() == paths[1][0].read_bytes()
        logs = []
        for path, name in ((left, 'reference-owned.txt'), (right, 'source-owned.txt')):
            lines = (path/'launches.txt').read_text().splitlines()
            target = directory/name
            target.write_text('\n'.join(str(i)+' '+line.split(' ', 1)[1] for i, line in enumerate(lines))+'\n')
            logs.append(target)
        metadata = compare(*logs, schemas()[0])
        counts = json.loads((right/'launch-counts.json').read_text())
        assert sum(counts.values()) == metadata['right_launches']
        row = {'count': count, 'buffers_bitwise': checks, 'owned_metadata': metadata,
               'source_owned_launch_counts': counts, 'raw_case_logs_rebased': True,
               'library_runtime_launches_completely_observed': False}
        (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        reports.append(row)
    runtime = json.loads((source/'n1/case.json').read_text())
    report = {'source_solver_image': runtime['image_sha256'], 'source_solver_integrated': True, 'cases': reports}
    (output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    passed = all(all(row['buffers_bitwise'].values()) and row['owned_metadata']['equal'] for row in reports)
    print(json.dumps({'cases': len(reports), 'buffers': sum(len(row['buffers_bitwise']) for row in reports),
                      'owned_launches': sum(row['owned_metadata']['right_launches'] for row in reports), 'equal': passed}))
    return not passed


def main():
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--worker', choices=('original', 'source', 'solver-source', 'compare-native'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--original', type=Path)
    parser.add_argument('--source', type=Path)
    parser.add_argument('--library', type=Path)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    if args.worker in ('original', 'solver-source'):
        return capture_solver(args.worker, args.output)
    if args.worker == 'compare-native':
        if not args.original or not args.source:
            parser.error('Native comparison requires --original and --source')
        return compare_native(args.output, args.original.resolve(), args.source.resolve())
    if not args.original or not args.library:
        parser.error('Source prototype requires --original and --library')
    return replay_source(args.output, args.original.resolve(), args.library.resolve())


if __name__ == '__main__':
    sys.exit(main())
