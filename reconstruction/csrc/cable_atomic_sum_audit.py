"""Explain captured first-PCG cable scalars with exact float32 summation permutations.

This CPU diagnostic does not infer the order of an earlier GPU launch or accept a full demo. It requires equal
per-particle operands, and records a concrete permutation reproducing every captured original/source scalar.
"""
import argparse
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction.pcg import dot


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    tags = ('original0', 'original1', 'original2', 'source')
    sets = {'numerator': ('23precondition_and_reduce', ('post', 2), ('pre', 1), ('pre', 6), ('post', 6)),
            'denominator': ('26multiply_matrix_and_reduce', ('post', 6), ('pre', 4), ('pre', 9), ('post', 9))}
    report, arrays = {}, {}
    for key, (kernel, left, right, initial, final) in sets.items():
        def read(tag, field):
            phase, argument = field
            return np.fromfile(args.directory/tag/f'dump_{kernel}_{phase}_arg{argument}.bin', dtype='f4')
        a, b = read(tags[0], left).reshape(-1, 3), read(tags[0], right).reshape(-1, 3)
        start = read(tags[0], initial)
        assert start.size == 1 and start[0] == 0.
        targets = {}
        for tag in tags:
            assert read(tag, left).tobytes() == a.tobytes()
            assert read(tag, right).tobytes() == b.tobytes()
            assert read(tag, initial).tobytes() == start.tobytes()
            value = read(tag, final)
            assert value.size == 1 and np.isfinite(value).all()
            targets[tag] = int(value.view('u4')[0])
        contributions = dot(a, b)
        assert np.isfinite(contributions).all() and np.all(contributions >= 0)
        arrays[key+'_contributions'] = contributions
        missing = set(targets.values())
        matches = {}
        rng = np.random.default_rng(604)
        for trial in range(10000):
            order = rng.permutation(len(contributions)) if trial else np.arange(len(contributions))
            total = np.float32(start[0])
            for index in order:
                total = np.float32(total + contributions[index])
            value = int(total.view('u4'))
            if value in missing:
                missing.remove(value)
                arrays[f'{key}_order_{value}'] = order.astype('i4')
                matches[str(value)] = {'trial': trial,
                                       'order_sha256': hashlib.sha256(order.astype('i4').tobytes()).hexdigest()}
            if not missing:
                break
        report[key] = {'operands_equal': True, 'contributions': len(contributions), 'targets': targets,
                       'exact_permutations': matches, 'unexplained': sorted(missing)}
    report['production_order_inferred'] = False
    report['whole_demo_accepted'] = False
    np.savez(args.output/'permutations.npz', **arrays)
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))
    return any(report[k]['unexplained'] for k in sets)


if __name__ == '__main__':
    raise SystemExit(main())
