"""Isolate the captured duplicate cloth/spring contributions and check exact atomic sum permutations."""
import argparse
import ctypes as c
import itertools
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import native_source
from .library_entries import entries

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
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    folders = {key: args.directory/key for key in ('legacy', 'source')}

    def metadata(index):
        return next(folders['legacy'].glob(f'{index:06d}.*.json'))

    def read(index, label, dtype='f4', backend='legacy'):
        prefix = metadata(index).name[:-5]
        return np.fromfile(folders[backend]/(prefix+'.'+label+'.bin'), dtype=dtype)

    driver = k.Driver()
    source = native_source()._KernelDriver()
    stages = []
    saved = {}
    try:
        for index, geometry, arity in ((3, 3, 3), (5, 3, 3), (6, 2, 2)):
            name = json.loads(metadata(index).read_text())['name']
            original = next(p.read_text() for p in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                            if name in entries(p.read_text()))
            functions = {'legacy': driver.function(original, name), 'source': c.c_void_p(source.function(name))}
            x = read(geometry, 'before.x').reshape(-1, 3)
            local_indices = read(geometry, 'before.indices', 'i4').reshape(3, arity)
            assert np.all(local_indices == np.arange(3 - arity, 3))
            for label in ('x', 'indices', 'stiffness', *(('area', 'pose') if arity == 3 else ('rest',))):
                assert read(geometry, 'before.'+label).tobytes() == read(geometry, 'before.'+label,
                                                                                 backend='source').tobytes()
            worlds, local = len(x) // 3, 3
            count = worlds * local
            iso_x = np.concatenate([x[local_indices[t % local] + 3 * (t // local)] for t in range(count)])
            iso_indices = np.arange(count * arity, dtype='i4').reshape(-1, arity)
            rows = len(iso_x)
            if arity == 3:
                material = [np.tile(read(3, 'before.'+key).reshape(3, width), (worlds, 1))
                            for key, width in (('area', 1), ('pose', 4), ('stiffness', 3))]
            else:
                material = [np.tile(read(2, 'before.'+key), worlds) for key in ('stiffness', 'rest')]
            outputs = {}
            for backend, function in functions.items():
                px, pi = driver.upload(iso_x), driver.upload(iso_indices)
                pm = [driver.upload(value) for value in material]
                width = 3 if index == 3 else 9
                like = np.zeros((rows, width), dtype='f4')
                po = driver.upload(like)
                if index == 3:
                    params = [px, pm[0], pm[1], pi, pm[2], po, k.u64(count), k.u64(count), k.u64(rows)]
                else:
                    ell = pattern(rows, arity)
                    pe = driver.upload(ell)
                    pr = driver.upload(np.full(rows, arity - 1, dtype='i4'))
                    head = [px, pi, pm[1], pm[0], pm[2]] if arity == 3 else [px, pi, *pm]
                    params = head + [po, pr, pe, k.u64(arity - 1), k.u64(count), k.u64(count),
                                     k.u64(rows), k.u64(rows)]
                driver.launch(function, count, params)
                outputs[backend] = {'diagonal': driver.download(po, like)}
                if index != 3:
                    outputs[backend]['entries'] = driver.download(pe, ell)['value'].copy()
                driver.free()
            for key in outputs['legacy']:
                assert outputs['legacy'][key].tobytes() == outputs['source'][key].tobytes(), (index, key)
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
                    label = 'rhs' if index == 3 else 'blocks'
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
                for backend in folders:
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
                    checks[('rhs' if index == 3 else field)+'/'+backend] = int(match[touched].size)
            stages.append({'call': index, 'name': name, 'isolated_contributions_equal': True,
                           'isolated_scalar_checks': sum(v.size for v in outputs['legacy'].values()),
                           'captured_scalars_explained_by_exact_permutations': checks})
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
        np.savez(args.output/'contributions.npz', **saved)
        build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
        report = {'stages': stages, 'whole_solver_bitwise_equal': False, 'source_original_mapped': False,
                  'source_image_sha256': build['extension_sha256'], 'source_cuda_digest': build['cuda_source_digest']}
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(json.dumps(report))
    finally:
        driver.free()


if __name__ == '__main__':
    main()
