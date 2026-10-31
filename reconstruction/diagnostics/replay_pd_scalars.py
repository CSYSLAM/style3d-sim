"""Check PD transform reductions, directions and vector updates on exact native call inputs."""
import argparse
import json
from pathlib import Path
import re

import numpy as np

from reconstruction import pcg
from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.validate import sha


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--native', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    record = load(args.input)
    if record['config']['nonlinear_solver'] != 1:
        raise ValueError('Expected PD input')
    linear = record['config']['linear_iterations']
    total = linear*record['config']['nonlinear_iterations']
    keys = ('19update_cg_direction', '28update_solution_and_residual')
    lines = (args.native/'launches.txt').read_text().splitlines()
    for key in keys:
        rows = [line for line in lines if f' {key} ' in line]
        if len(rows) != total:
            raise RuntimeError(f'Expected {total} {key} calls')
        for i, line in enumerate(rows):
            if int(re.search(r' i:(\d+)', line)[1]) != i % linear:
                raise RuntimeError('Unexpected iteration ordering')

    def read(key, call, arg, phase='pre', width=1):
        data = np.fromfile(args.native/f'dump_{key}_call{call:03d}_{phase}_arg{arg}.bin', np.float32)
        return data.reshape(-1, width) if width > 1 else data

    report = {'input_sha256': sha(args.input), 'calls': []}
    for call in range(total):
        k = call % linear
        d, u = keys
        inverse = read(d, call, 1, width=9)
        residual = read(d, call, 2, width=3)
        num = read(d, call, 3)
        direction_before = read(d, call, 4, width=3)
        direction = read(d, call, 4, 'post', 3)
        if direction.tobytes() != read(u, call, 3, width=3).tobytes():
            raise RuntimeError('Direction output does not match update input')
        product = read(u, call, 4, width=3)
        den = read(u, call, 2)
        solution, updated_residual = pcg.update_solution_and_residual(
            k, read(u, call, 1), den, direction, product, read(u, call, 5, width=3), read(u, call, 6, width=3))
        num_expected = np.array([num[k]], np.float32)
        den_expected = np.array([den[k]], np.float32)
        num_actual = np.array([pcg.cub_sum(pcg.dot(pcg.mat_vec(inverse, residual), residual))], np.float32)
        den_actual = np.array([pcg.cub_sum(pcg.dot(direction, product))], np.float32)
        report['calls'].append({
            'call': call, 'iteration': call//linear, 'k': k,
            'num': compare(num_actual, num_expected), 'den': compare(den_actual, den_expected),
            'direction': compare(pcg.update_cg_direction(k, inverse, residual, num, direction_before), direction),
            'solution': compare(solution, read(u, call, 5, 'post', 3)),
            'residual': compare(updated_residual, read(u, call, 6, 'post', 3))})
    fields = ('num', 'den', 'direction', 'solution', 'residual')
    report['mismatched_calls'] = {f: sum(row[f]['different_bits'] > 0 for row in report['calls']) for f in fields}
    report['bitwise_equal'] = not any(report['mismatched_calls'].values())
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report['mismatched_calls']))
    if not report['bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
