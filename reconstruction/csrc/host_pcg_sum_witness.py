"""Explain one captured first PCG scalar difference by exact float32 permutations of identical operands."""
import argparse
import json
from pathlib import Path

import numpy as np

from reconstruction.pcg import dot


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--trace', type=Path, required=True)
    parser.add_argument('--launch', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--group-index', type=int, help='Select one explicitly captured PCG group; default requires one group')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    prefix = args.launch.removesuffix('.json')+'.'
    if '26multiply_matrix' in prefix:
        labels = ('after.ap', 'before.p', 'before.denominator', 'after.denominator')
    else:
        assert '23precondition' in prefix
        labels = ('after.z', 'before.r', 'before.numerator', 'after.numerator')
    directories = {}
    for backend in ('legacy', 'source'):
        path = args.trace/backend
        if not (path/(prefix+labels[0]+'.bin')).exists():
            path /= 'actual'
        directories[backend] = path

    def read(backend, label):
        return np.fromfile(directories[backend]/(prefix+label+'.bin'), dtype='f4')

    a, b = [read('legacy', label).reshape(-1, 3) for label in labels[:2]]
    initial = read('legacy', labels[2])
    if args.group_index is None:
        assert len(initial) == 1, 'Use --group-index for a multiworld capture'
    group = args.group_index if args.group_index is not None else 0
    assert 0 <= group < len(initial)
    start = initial[group:group+1]
    assert start[0] == 0
    targets = {}
    for backend in ('legacy', 'source'):
        assert read(backend, labels[0]).tobytes() == a.tobytes()
        assert read(backend, labels[1]).tobytes() == b.tobytes()
        assert read(backend, labels[2]).tobytes() == initial.tobytes()
        target = read(backend, labels[3])
        assert len(target) == len(initial) and np.isfinite(target).all()
        targets[backend] = int(target.view('u4')[group])
    indices = np.arange(len(a))
    if len(initial) > 1:
        world_file = directories['legacy']/(prefix+'before.world.bin')
        if world_file.exists():
            worlds = np.fromfile(world_file, dtype='i4')
            assert len(worlds) == len(a)
        else:
            path = directories['legacy']/(prefix+'before.per_group.bin')
            width = np.fromfile(path, dtype='u4')
            assert len(width) == 1 and width[0] > 0
            worlds = indices//int(width[0])
        assert int(worlds.max())+1 == len(initial)
        indices = indices[worlds == group]
        a, b = a[indices], b[indices]
    values = dot(a, b)
    assert np.isfinite(values).all()
    missing, matches = set(targets.values()), {}
    arrays = {'contributions': values, 'initial': start, 'particle_indices': indices.astype('i4')}
    rng = np.random.default_rng(257)
    for trial in range(10000):
        order = rng.permutation(len(values)) if trial else np.arange(len(values))
        total = start[0]
        for index in order:
            total = np.float32(total + values[index])
        bits = int(total.view('u4'))
        if bits in missing:
            missing.remove(bits)
            arrays['order_'+str(bits)] = order.astype('i4')
            matches[str(bits)] = {'trial': trial, 'exact_sum_bits': bits}
        if not missing:
            break
    np.savez_compressed(args.output/'witnesses.npz', **arrays)
    report = {'trace': str(args.trace.resolve()), 'launch': args.launch, 'equal_operands': True,
              'contributions': len(values), 'group': group, 'targets': targets, 'exact_permutations': matches,
              'unexplained': sorted(missing), 'production_order_inferred': False, 'whole_trajectory_accepted': False}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report), flush=True)
    return int(bool(missing))


if __name__ == '__main__':
    raise SystemExit(main())
