"""Replay actual stretch operands with disjoint vertices, then explain captured sums by exact float32 orders."""
import argparse
import ctypes as c
import hashlib
import itertools
import json
from pathlib import Path

import numpy as np

from reconstruction import kernel_ab as k
from .host_particles_ab import native_source
from .library_entries import entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--launch', default='000003.22evaluate_stretch_forceE')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--worlds', type=int, default=1, help='Exact captured world count for local element indices')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    roots = {key: args.trace/key/('actual' if (args.trace/key/'actual').is_dir() else '')
             for key in ('legacy', 'source')}
    prefix = args.launch.removesuffix('.json')+'.'
    paths = {}

    def read(backend, label, dtype='f4'):
        p = roots[backend]/(prefix+label+'.bin')
        paths[str(p.resolve())] = hashlib.sha256(p.read_bytes()).hexdigest()
        return np.fromfile(p, dtype=dtype)

    spring = '21evaluate_spring_force' in args.launch
    arity = 2 if spring else 3
    material_fields = ('stiffness', 'rest') if spring else ('area', 'pose', 'stiffness')
    inputs = {name: read('legacy', 'before.'+name, 'i4' if name == 'indices' else 'f4')
              for name in ('x', 'indices', 'rhs', *material_fields)}
    for name, value in inputs.items():
        assert value.tobytes() == read('source', 'before.'+name,
                                      'i4' if name == 'indices' else 'f4').tobytes(), name
    x = inputs['x'].reshape(-1, 3)
    local_indices = inputs['indices'].reshape(-1, arity)
    n = len(x)
    assert args.worlds > 0 and n % args.worlds == 0
    per_world = n//args.worlds
    assert local_indices.min() >= 0 and local_indices.max() < per_world
    triangles = np.concatenate([local_indices+world*per_world for world in range(args.worlds)])
    count = len(triangles)
    assert len(inputs['stiffness']) == len(local_indices)*(1 if spring else 3)
    iso_x = x[triangles].reshape(-1, 3).copy()
    iso_indices = np.arange(count*arity, dtype='i4').reshape(count, arity)
    materials = {key: np.tile(inputs[key], args.worlds) for key in material_fields}
    metadata = json.loads((roots['legacy']/(prefix+'json')).read_text())
    name = metadata['name']
    ptx_path = next(p for p in Path('build/reconstruction-ptx/64a0be7f7a3c03cb').glob('*.ptx')
                    if name in entries(p.read_text()))
    (args.output/'input-provenance.json').write_text(json.dumps({
        'input_sha256': paths, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'original_ptx_sha256': hashlib.sha256(ptx_path.read_bytes()).hexdigest(),
    }, indent=2)+'\n')
    driver = k.Driver()
    source = native_source()._KernelDriver()
    functions = {'legacy': driver.function(ptx_path.read_text(), name), 'source': c.c_void_p(source.function(name))}
    isolated = {}
    try:
        for backend, function in functions.items():
            signed = []
            for negative in (False, True):
                initial = np.full_like(iso_x, np.float32(-0.) if negative else np.float32(0.))
                values = (iso_x, iso_indices, materials['stiffness'], materials['rest'], initial) if spring else (
                    iso_x, materials['area'], materials['pose'], iso_indices, materials['stiffness'], initial)
                pointers = [driver.upload(value) for value in values]
                driver.launch(function, count, pointers+[k.u64(count), k.u64(count), k.u64(len(iso_x))],
                              block=metadata['block'])
                value = driver.download(pointers[-1], initial)
                assert np.isfinite(value).all()
                signed.append(value)
                driver.free()
            # Adding -0 retains an operand's zero sign; +0 can erase it. Both are checked on both backends.
            assert np.array_equal(signed[0], signed[1])
            isolated[backend] = signed
        np.savez_compressed(args.output/'isolated-runs.npz', **{
            backend+('_negative_zero' if i else '_positive_zero'): value
            for backend, signed in isolated.items() for i, value in enumerate(signed)})
        failures = {}
        for i in range(2):
            a, b = isolated['legacy'][i].view('u4'), isolated['source'][i].view('u4')
            if not np.array_equal(a, b):
                failures[str(i)] = {'different_scalars': int(np.count_nonzero(a != b)),
                                    'first_indices': np.argwhere(a != b)[:16].tolist()}
        (args.output/'isolated-comparison.json').write_text(json.dumps(failures, indent=2)+'\n')
        assert not failures, 'Isolated operands differ; inspect preserved isolated-runs.npz'
        contribution = isolated['legacy'][1].reshape(count, arity, 3)
        incident = [[] for _ in range(n)]
        for triangle, vertices in enumerate(triangles):
            for corner, vertex in enumerate(vertices):
                incident[vertex].append((triangle, corner))
        degrees = np.asarray([len(row) for row in incident], dtype='i4')
        assert degrees.max() <= 8, 'Use a separate bounded strategy for higher-valence captures'
        before = inputs['rhs'].reshape(n, 3)
        targets = {backend: read(backend, 'after.rhs').reshape(n, 3) for backend in roots}
        matched = {backend: np.zeros((n, 3), dtype=bool) for backend in roots}
        witness = {backend: np.full((n, 3, int(degrees.max())), -1, dtype='i4') for backend in roots}
        trials = {}
        for degree in np.unique(degrees):
            selected = np.flatnonzero(degrees == degree)
            values = np.asarray([[contribution[t, corner] for t, corner in incident[row]]
                                 for row in selected], dtype='f4').reshape(len(selected), degree, 3)
            trials[int(degree)] = 0
            for order in itertools.permutations(range(degree)):
                total = before[selected].copy()
                for index in order:
                    total = np.add(total, values[:, index], dtype='f4')
                for backend in roots:
                    new = (total.view('u4') == targets[backend][selected].view('u4')) & ~matched[backend][selected]
                    rows, components = np.nonzero(new)
                    witness[backend][selected[rows], components, :degree] = order
                    matched[backend][selected[rows], components] = True
                trials[int(degree)] += 1
                if all(matched[backend][selected].all() for backend in roots):
                    break
        saved = {'isolated_contributions': contribution, 'degrees': degrees, 'before': before}
        for backend in roots:
            saved[backend+'_target'] = targets[backend]
            saved[backend+'_orders'] = witness[backend]
            saved[backend+'_matched'] = matched[backend]
        np.savez_compressed(args.output/'witnesses.npz', **saved)
        build = json.loads(Path('build/reconstruction-csrc/host-particles/build.json').read_text())
        report = {'source_sha256': build['extension_sha256'], 'source_cuda_digest': build['cuda_source_digest'],
                  'input_sha256': paths, 'original_ptx_sha256': hashlib.sha256(ptx_path.read_bytes()).hexdigest(),
                  'launch': args.launch, 'particles': n, 'triangles': count, 'equal_operands': True,
                  'element_arity': arity, 'captured_worlds': args.worlds,
                  'isolated_scalar_checks_per_zero_sign': int(contribution.size), 'both_zero_signs_equal': True,
                  'permutations_tried_by_degree': trials,
                  'captured_scalars_explained': {key: int(value.sum()) for key, value in matched.items()},
                  'unexplained': {key: np.argwhere(~value).tolist() for key, value in matched.items()},
                  'original_solver_mapped': '_core.cpython-' in Path('/proc/self/maps').read_text(),
                  'production_order_inferred': False, 'whole_trajectory_accepted': False}
        (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        print(json.dumps({key: value for key, value in report.items() if key != 'input_sha256'}), flush=True)
        assert not report['original_solver_mapped']
        return int(any(not value.all() for value in matched.values()))
    finally:
        driver.free()


if __name__ == '__main__':
    raise SystemExit(main())
