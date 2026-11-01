"""Isolate frozen mixed contributions with SDK runtime/PTX/source and verify every three-term atomic fold on GPU."""
import argparse
import ctypes as c
import itertools
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import native_source
from .library_entries import entries
from .host_api_probe import load_reference, REFERENCE, REFERENCE_SHA
from .pcg_same_buffer_probe import Dim3

BLOCK = np.dtype([('column', '<i4'), ('value', '<f4', (9,))])


def pattern(rows, arity):
    result = np.zeros((arity - 1, rows), dtype=BLOCK)
    for row in range(rows):
        siblings = [row // arity * arity + j for j in range(arity) if j != row % arity]
        result['column'][:, row] = siblings
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--sum-ptx', type=Path, required=True)
    parser.add_argument('--side', choices=('legacy', 'source'))
    parser.add_argument('--offset', type=int, default=0)
    parser.add_argument('--force-only', action='store_true', help='Audit the two force entries of a PD mixed path')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    folders = {'legacy': args.directory/'legacy/native', 'source': args.directory/'source/native'}
    inputs = {}
    selected_sides = [args.side] if args.side else ['legacy', 'source']
    base_side = args.side or 'legacy'

    def metadata(index):
        path = next(folders[base_side].glob(f'{index:06d}.*.json'))
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        return path

    def read(index, label, dtype='f4', backend=None):
        backend = backend or base_side
        prefix = metadata(index).name[:-5]
        path = folders[backend]/(prefix+'.'+label+'.bin')
        inputs[str(path)] = hashlib.sha256(path.read_bytes()).hexdigest()
        return np.fromfile(path, dtype=dtype)

    driver = k.Driver()
    source = native_source()._KernelDriver()
    load_reference()
    runtime = c.CDLL(str(REFERENCE))
    launch_runtime = runtime.cudaLaunchKernel
    launch_runtime.argtypes = [c.c_void_p, Dim3, Dim3, c.POINTER(c.c_void_p), c.c_size_t, c.c_void_p]
    launch_runtime.restype = c.c_int
    folds = driver.function(args.sum_ptx.read_text(), 'atomic_fold_three')
    orders = np.array(list(itertools.permutations(range(3))), dtype='i4')
    stages = []
    saved = {}
    try:
        definitions = ((2, 2, 2, True), (3, 3, 3, True))
        if not args.force_only:
            definitions += ((5, 3, 3, False), (6, 2, 2, False))
        for base_index, base_geometry, arity, is_force in definitions:
            index, geometry = base_index + args.offset, base_geometry + args.offset
            name = json.loads(metadata(index).read_text())['name']
            original = next(p.read_text() for p in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                            if name in entries(p.read_text()))
            functions = {'runtime': c.cast(getattr(runtime, name), c.c_void_p),
                         'legacy': driver.function(original, name), 'source': c.c_void_p(source.function(name))}
            x = read(geometry, 'before.x').reshape(-1, 3)
            local_indices = read(geometry, 'before.indices', 'i4').reshape(3, arity)
            assert np.all(local_indices == np.arange(3 - arity, 3))
            for label in ('x', 'indices', 'stiffness', *(('area', 'pose') if arity == 3 else ('rest',))):
                if not args.side:
                    assert read(geometry, 'before.'+label).tobytes() == read(geometry, 'before.'+label,
                                                                                     backend='source').tobytes()
            worlds, local = len(x) // 3, 3
            count = worlds * local
            iso_x = np.concatenate([x[local_indices[t % local] + 3 * (t // local)] for t in range(count)])
            iso_indices = np.arange(count * arity, dtype='i4').reshape(-1, arity)
            rows = len(iso_x)
            if arity == 3:
                material = [np.tile(read(geometry, 'before.'+key).reshape(3, width), (worlds, 1))
                            for key, width in (('area', 1), ('pose', 4), ('stiffness', 3))]
            else:
                material = [np.tile(read(geometry, 'before.'+key), worlds) for key in ('stiffness', 'rest')]
            outputs = {}
            for backend, function in functions.items():
                px, pi = driver.upload(iso_x), driver.upload(iso_indices)
                pm = [driver.upload(value) for value in material]
                width = 3 if is_force else 9
                like = np.zeros((rows, width), dtype='f4')
                po = driver.upload(like)
                if is_force:
                    params = ([px, pm[0], pm[1], pi, pm[2]] if arity == 3 else [px, pi, *pm]) + \
                             [po, k.u64(count), k.u64(count), k.u64(rows)]
                else:
                    ell = pattern(rows, arity)
                    pe = driver.upload(ell)
                    pr = driver.upload(np.full(rows, arity - 1, dtype='i4'))
                    head = [px, pi, pm[1], pm[0], pm[2]] if arity == 3 else [px, pi, *pm]
                    params = head + [po, pr, pe, k.u64(arity - 1), k.u64(count), k.u64(count),
                                     k.u64(rows), k.u64(rows)]
                if backend == 'runtime':
                    holders = (c.c_void_p * len(params))(*[c.cast(c.byref(p), c.c_void_p) for p in params])
                    status = launch_runtime(function, Dim3((count + 255) // 256, 1, 1), Dim3(256, 1, 1), holders, 0, None)
                    assert status == 0
                    driver.check(driver.cu.cuCtxSynchronize())
                else:
                    driver.launch(function, count, params)
                outputs[backend] = {'diagonal': driver.download(po, like)}
                if not is_force:
                    outputs[backend]['entries'] = driver.download(pe, ell)['value'].copy()
                driver.free()
            for key in outputs['legacy']:
                assert outputs['runtime'][key].tobytes() == outputs['legacy'][key].tobytes() == \
                       outputs['source'][key].tobytes(), (index, key)
                assert np.isfinite(outputs['legacy'][key]).all()
                assert np.all(outputs['legacy'][key] != 0), 'Zero operands require a signed-zero operand probe'
                saved[f'{index}_{key}'] = outputs['legacy'][key]
            checks = {}
            for field, delta in outputs['legacy'].items():
                width = delta.shape[-1]
                if field == 'diagonal':
                    contributions = np.zeros((3, len(x), width), dtype='f4')
                    touched = np.zeros(len(x), dtype=bool)
                    v = delta.reshape(worlds, local, arity, width)
                    for world in range(worlds):
                        for element in range(local):
                            contributions[element, local_indices[element] + 3 * world] = v[world, element]
                            touched[local_indices[element] + 3 * world] = True
                    label = 'rhs' if is_force else 'blocks'
                else:
                    contributions = np.zeros((3, 2, len(x), width), dtype='f4')
                    touched = np.zeros((2, len(x)), dtype=bool)
                    v = delta.reshape(arity - 1, worlds, local, arity, width)
                    for world in range(worlds):
                        for element in range(local):
                            vertices = local_indices[element] + 3 * world
                            for corner, row in enumerate(vertices):
                                for slot in range(arity - 1):
                                    target = slot if arity == 3 else 1
                                    contributions[element, target, row] = v[slot, world, element, corner]
                                    touched[target, row] = True
                    label = 'entries'
                for backend in selected_sides:
                    before, after = [read(index, phase+'.'+label, BLOCK if field == 'entries' else 'f4', backend)
                                     for phase in ('before', 'after')]
                    if field == 'entries':
                        assert np.array_equal(before['column'], pattern(len(x), 3)['column'].reshape(-1))
                        assert np.array_equal(before['column'], after['column'])
                        before = before['value'].reshape(2, len(x), width)
                        after = after['value'].reshape(2, len(x), width)
                    else:
                        before, after = before.reshape(len(x), width), after.reshape(len(x), width)
                    match = np.zeros(after.shape, dtype=bool)
                    for order in itertools.permutations(range(3)):
                        value = before.copy()
                        for element in order:
                            value = np.add(value, contributions[element], dtype='f4')
                        match |= value.view('u4') == after.view('u4')
                    assert np.all(match[touched]), (index, field, backend, np.argwhere(~match & touched[..., None])[:5])
                    assert before[~touched].tobytes() == after[~touched].tobytes()
                    values = np.ascontiguousarray(contributions.reshape(3, -1))
                    hardware = np.zeros((6, before.size), dtype='f4')
                    pointers = [driver.upload(value) for value in (before.reshape(-1), values, orders, hardware)]
                    driver.launch(folds, hardware.size, [*pointers, k.u64(before.size)])
                    hardware = driver.download(pointers[3], hardware).reshape((6,) + before.shape)
                    gpu_match = (hardware.view('u4') == after.view('u4')[None]).any(axis=0)
                    assert gpu_match.all(), (index, field, backend, 'unexplained hardware atomic fold')
                    saved[f'{index}_{field}_{backend}_hardware_folds'] = hardware
                    saved[f'{index}_{field}_{backend}_before'] = before.copy()
                    saved[f'{index}_{field}_{backend}_after'] = after.copy()
                    checks[('rhs' if is_force else field)+'/'+backend] = int(match[touched].size)
                    driver.free()
            stages.append({'call': index, 'name': name, 'isolated_contributions_equal': True,
                           'isolated_scalar_checks': sum(v.size for v in outputs['legacy'].values()),
                           'captured_scalars_explained_by_exact_permutations': checks})
        assert hashlib.sha256(REFERENCE.read_bytes()).hexdigest() == REFERENCE_SHA
        np.savez(args.output/'contributions.npz', **saved)
        build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
        report = {'stages': stages, 'captured_side': args.side, 'offset': args.offset, 'force_only': args.force_only,
                  'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  'sum_ptx_sha256': hashlib.sha256(args.sum_ptx.read_bytes()).hexdigest(),
                  'whole_solver_bitwise_equal': False, 'diagnostic_intentionally_maps_original': True,
                  'reference_sha256': REFERENCE_SHA, 'all_three_backends_pointwise_equal': True,
                  'all_captured_atomic_folds_verified_on_gpu': True, 'input_sha256': inputs,
                  'source_image_sha256': build['extension_sha256'], 'source_cuda_digest': build['cuda_source_digest']}
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(json.dumps(report))
    finally:
        driver.free()


if __name__ == '__main__':
    main()
