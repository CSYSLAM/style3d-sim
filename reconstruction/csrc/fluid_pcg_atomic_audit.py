"""Check the first coupled-fluid PCG difference without accepting a whole trajectory.

Requires captured pointwise operands/results to match exactly, then finds float32 addition permutations for
each recorded world scalar. These permutations explain possible sums, not the historical GPU thread order.
"""
import argparse
import json
from pathlib import Path

import numpy as np

from reconstruction.pcg import dot


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--captures', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--particles-per-world', type=int, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    tags = ('original0', 'original1', 'source')
    kernel = '26multiply_matrix_and_reduce_call000'

    def read(tag, phase, argument):
        path = args.captures/tag/f'dump_{kernel}_{phase}_arg{argument}.bin'
        return np.fromfile(path, dtype='f4')

    left = read(tags[0], 'post', 6).reshape(-1, 3)
    right = read(tags[0], 'pre', 4).reshape(-1, 3)
    for tag in tags:
        assert read(tag, 'post', 6).tobytes() == left.tobytes()
        assert read(tag, 'pre', 4).tobytes() == right.tobytes()
    contribution = dot(left, right).reshape(-1, args.particles_per_world)
    assert np.isfinite(contribution).all()
    rng = np.random.default_rng(604)
    arrays, worlds = {'contributions': contribution}, []
    for world, values in enumerate(contribution):
        targets = {tag: int(read(tag, 'post', 9).view('u4')[world]) for tag in tags}
        starts = [read(tag, 'pre', 9)[world] for tag in tags]
        assert all(value == 0 for value in starts)
        missing, matches = set(targets.values()), {}
        for trial in range(10000):
            order = rng.permutation(len(values)) if trial else np.arange(len(values))
            total = np.float32(0)
            for index in order:
                total = np.float32(total + values[index])
            bits = int(total.view('u4'))
            if bits in missing:
                missing.remove(bits)
                arrays[f'world{world}_order_{bits}'] = order.astype('i4')
                matches[str(bits)] = {'trial': trial, 'order': order.tolist()}
            if not missing:
                break
        worlds.append({'world': world, 'targets': targets, 'matches': matches, 'unexplained': sorted(missing)})
    report = {'capture_tags': tags, 'operands_and_products_bitwise_equal': True, 'worlds': worlds,
              'production_order_inferred': False, 'whole_trajectory_accepted': False}
    np.savez(args.output/'permutations.npz', **arrays)
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))
    return any(row['unexplained'] for row in worlds)


if __name__ == '__main__':
    raise SystemExit(main())
