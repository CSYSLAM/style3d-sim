"""Replay actual duplicate spring/cloth force contributions and explain every captured scalar by float32 sums."""
import argparse
import ctypes as c
import itertools
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import native_source
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    original = k.Driver()
    core = native_source()
    source = core._KernelDriver()
    modules = [p.read_text() for p in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')]
    reports = []
    contributions = {}
    for backend in ('legacy', 'source'):
        directory = args.directory/backend
        for meta in sorted(directory.glob('*.json')):
            name = json.loads(meta.read_text())['name']
            if not any(token in name for token in ('21evaluate_spring_forceE', '22evaluate_stretch_forceE')):
                continue
            prefix = meta.name[:-5]

            def read(label, dtype='f4'):
                return np.fromfile(directory/(prefix+'.'+label+'.bin'), dtype=dtype)

            arity = 3 if '22evaluate_stretch_forceE' in name else 2
            x = read('before.x').reshape(-1, 3)
            indices = read('before.indices', 'i4').reshape(-1, arity)
            assert len(indices) == 3 and np.all(indices == np.arange(3-arity, 3))
            assert len(x) % 3 == 0
            worlds, count = len(x)//3, len(x)
            isolated = np.concatenate([x[indices[t % 3]+3*(t//3)] for t in range(count)])
            isolated_indices = np.arange(count*arity, dtype='i4').reshape(-1, arity)
            material = [np.tile(read('before.'+label).reshape(3, width), (worlds, 1))
                        for label, width in ((('area', 1), ('pose', 4), ('stiffness', 3)) if arity == 3
                                             else (('stiffness', 1), ('rest', 1)))]
            ptx = next(ptx for ptx in modules if name in entries(ptx))
            functions = {'original': original.function(ptx, name), 'source': c.c_void_p(source.function(name))}
            outputs = {}
            for implementation, function in functions.items():
                px, pi = original.upload(isolated), original.upload(isolated_indices)
                pm = [original.upload(value) for value in material]
                zero = np.zeros_like(isolated)
                po = original.upload(zero)
                head = [px, pm[0], pm[1], pi, pm[2]] if arity == 3 else [px, pi, *pm]
                original.launch(function, count, head+[po, k.u64(count), k.u64(count), k.u64(len(isolated))])
                outputs[implementation] = original.download(po, zero)
                original.free()
            assert outputs['original'].tobytes() == outputs['source'].tobytes(), (backend, prefix)
            assert np.isfinite(outputs['original']).all()
            assert np.all(outputs['original'] != 0), 'Signed-zero contributions need a separate operand probe'
            delta = outputs['original'].reshape(worlds, 3, arity, 3)
            terms = np.zeros((3, len(x), 3), dtype='f4')
            touched = np.zeros(len(x), dtype=bool)
            for world in range(worlds):
                for element in range(3):
                    vertices = indices[element]+3*world
                    terms[element, vertices] = delta[world, element]
                    touched[vertices] = True
            before, after = [read(phase+'.rhs').reshape(-1, 3) for phase in ('before', 'after')]
            matches = np.zeros(after.shape, dtype=bool)
            for order in itertools.permutations(range(3)):
                value = before.copy()
                for element in order:
                    value = np.add(value, terms[element], dtype='f4')
                matches |= value.view('u4') == after.view('u4')
            assert np.all(matches[touched]), (backend, prefix, np.argwhere(~matches & touched[:, None])[:8])
            assert before[~touched].tobytes() == after[~touched].tobytes()
            contributions[backend+'/'+prefix] = terms
            reports.append({'backend': backend, 'capture': meta.name, 'name': name,
                            'isolated_contributions_bitwise_equal': True, 'isolated_scalars': int(delta.size),
                            'captured_scalars_explained_by_exact_permutations': int(matches[touched].size)})
    assert len(reports) == 36, 'Expected 3 steps * 3 nonlinear iterations * 2 force kernels * 2 captured backends'
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    np.savez_compressed(args.output/'contributions.npz', **contributions)
    build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
    report = {'captures': reports, 'source_sha256': build['extension_sha256'],
              'cuda_source_digest': build['cuda_source_digest'], 'original_solver_mapped': False,
              'whole_solver_bitwise_equal': False}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(len(reports), 'captured force calls explained')


if __name__ == '__main__':
    raise SystemExit(main())
