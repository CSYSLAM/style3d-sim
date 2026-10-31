"""Replay all direction and block-ELL matvec calls on captured native buffers."""
import argparse
import json
import re
from pathlib import Path

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
    n = len(record['particle_q'])
    linear = record['config']['linear_iterations']
    total = linear*record['config']['nonlinear_iterations']
    lines = (args.native/'launches.txt').read_text().splitlines()
    direction_key, matrix_key = '19update_cg_direction', '26multiply_matrix_and_reduce'
    direction_lines = [line for line in lines if f' {direction_key} ' in line]
    matrix_lines = [line for line in lines if f' {matrix_key} ' in line]
    if len(direction_lines) != total or len(matrix_lines) != total:
        raise RuntimeError('Incomplete call metadata')
    entry_dtype = np.dtype([('col', '<i4'), ('m', '<f4', (9,))])
    assert entry_dtype.itemsize == 40

    def read(key, call, arg, phase='pre', width=1, dtype=np.float32):
        data = np.fromfile(args.native/f'dump_{key}_call{call:03d}_{phase}_arg{arg}.bin', dtype)
        return data.reshape(-1, width) if width > 1 else data

    report = {'input_sha256': sha(args.input), 'calls': []}
    for call in range(total):
        k_match = re.search(r' i:(\d+)', direction_lines[call])
        if k_match is None or int(k_match[1]) != call % linear:
            raise RuntimeError('Direction calls are out of order')
        meta = [int(x, 16) for x in re.findall(r' u:([0-9a-f]+)', matrix_lines[call])]
        if len(meta) != 10 or meta[8:] != [n, n]:
            raise RuntimeError('Unexpected matrix dimensions/layout')
        max_nnz = meta[2]
        row_nnz = read(matrix_key, call, 0, dtype=np.int32)
        raw = read(matrix_key, call, 1, dtype=entry_dtype)
        if row_nnz.shape != (n,) or raw.size != n*max_nnz:
            raise RuntimeError('Truncated ELL buffers')
        raw = raw.reshape(max_nnz, n)
        p = pcg.update_cg_direction(call % linear, read(direction_key, call, 1, width=9),
                                    read(direction_key, call, 2, width=3), read(direction_key, call, 3),
                                    read(direction_key, call, 4, width=3))
        native_p = read(direction_key, call, 4, 'post', 3)
        matrix_p = read(matrix_key, call, 4, width=3)
        if native_p.tobytes() != matrix_p.tobytes():
            raise RuntimeError('Direction output is not the next matrix input')
        product, partial = pcg.multiply_matrix_and_reduce(
            read(matrix_key, call, 3, width=9), matrix_p, read(matrix_key, call, 5, width=3),
            (row_nnz, raw['col'].copy(), raw['m'].copy(), max_nnz))
        report['calls'].append({'call': call, 'iteration': call//linear, 'k': call % linear,
                                'direction': compare(p, native_p),
                                'product': compare(product, read(matrix_key, call, 6, 'post', 3)),
                                'partial': compare(partial, read(matrix_key, call, 7, 'post'))})
    report['bitwise_equal'] = all(row[key]['different_bits'] == 0 for row in report['calls']
                                  for key in ('direction', 'product', 'partial'))
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({'calls': len(report['calls']), 'bitwise_equal': report['bitwise_equal']}))
    if not report['bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
