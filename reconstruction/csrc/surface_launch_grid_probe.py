"""Probe real original/source surface launch geometry across capacity boundaries with one initialized contact."""
import argparse
import copy
from pathlib import Path
from types import SimpleNamespace

import numpy as np


CAPACITIES = (1, 255, 256, 257, 8191, 8192, 8193, 16385, 90567)


def cases(seed):
    from .surface_host_cases import base_fixtures
    base = next(case for name, case in base_fixtures(seed) if name == 'surface_w1_basic')
    for capacity in CAPACITIES:
        case = copy.deepcopy(base)
        case['soft_max_count'], case['iterations'], case['linear_iterations'] = capacity, 1, 1
        for key in ('soft_indices', 'soft_barycentric', 'soft_shape', 'soft_body_pos', 'soft_body_vel', 'soft_normal'):
            original = case[key]
            padded = np.zeros((capacity, *original.shape[1:]), dtype=original.dtype)
            if key == 'soft_indices':
                padded.fill(-1)
            padded[:len(original)] = original
            case[key] = padded
        assert case['soft_count'].tolist() == [1]
        yield f'surface_capacity{capacity}', case


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    from . import host_particles_ab as host
    host.selected_fixtures = lambda options: cases(options.seed)
    host.worker(SimpleNamespace(worker='legacy' if args.backend == 'original' else 'source', output=str(args.output),
        scenario='surface', seed=1, trace_case=None, trace_label='grid-probe', adapter=False))


if __name__ == '__main__':
    main()
