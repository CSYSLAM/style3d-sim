"""Replay every captured PCG update and preconditioner inversion on exact native inputs."""
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
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    record = load(args.input)
    iterations, linear = record['config']['nonlinear_iterations'], record['config']['linear_iterations']
    prefix = 'update_solution_residual_and_reduce'
    files = sorted(args.native.glob(f'dump_{prefix}_call*_pre_arg1.bin'))
    if len(files) != iterations*linear:
        raise RuntimeError(f'Expected {iterations*linear} PCG calls; got {len(files)}')
    launches = [line for line in (args.native/'launches.txt').read_text().splitlines()
                if '35update_solution_residual_and_reduce ' in line]
    if len(launches) != len(files):
        raise RuntimeError('Every captured PCG call requires logged iteration and reduction flags')
    flags = []
    for call, line in enumerate(launches):
        k = re.search(r' i:(\d+)', line)
        flag = re.search(r' c:([01])(?: |$)', line)
        if k is None or flag is None or int(k[1]) != call % linear:
            raise RuntimeError(f'Invalid PCG launch metadata for call {call}')
        flags.append(bool(int(flag[1])))

    def read(key, call, arg, phase='pre', width=1, dtype=np.float32):
        data = np.fromfile(args.native/f'dump_{key}_call{call:03d}_{phase}_arg{arg}.bin', dtype)
        return data.reshape(-1, width) if width > 1 else data

    def source(call, field):
        return np.load(args.source/f'{prefix}_call{call:03d}-{field}.npy')

    report = {'input_sha256': sha(args.input), 'updates': [], 'inverse': [], 'iterations': []}
    for call in range(iterations*linear):
        k = call % linear
        num, den = read(prefix, call, 1), read(prefix, call, 2)
        if len(num) != linear+1 or len(den) != linear:
            raise RuntimeError('Incomplete scalar arrays')
        outputs = pcg.update_solution_residual_and_reduce(
            k, num, den, read(prefix, call, 3, width=3), read(prefix, call, 4, width=3),
            read(prefix, call, 5, width=9), read(prefix, call, 6, width=3), read(prefix, call, 7, width=3))
        row = {'call': call, 'iteration': call//linear, 'k': k, 'reduction_enabled': flags[call],
               'native_num': float(num[k]),
               'native_den': float(den[k]), 'native_alpha': float(pcg.guarded_ratio(num[k], den[k])),
               'source_num': float(source(call, 'in1')[k]), 'source_den': float(source(call, 'in2')[k])}
        row['source_alpha'] = float(pcg.guarded_ratio(np.float32(row['source_num']), np.float32(row['source_den'])))
        for name, actual, arg, width in zip(('solution', 'residual', 'partial'), outputs, (6, 7, 8), (3, 3, 1)):
            if name == 'partial' and not flags[call]:
                # The native output is intentionally unwritten; compare its pre/post bytes, not a fresh norm.
                row[name] = compare(read(prefix, call, arg), read(prefix, call, arg, 'post'))
                row[name]['meaning'] = 'unwritten buffer preserved, not a computed reduction'
            else:
                row[name] = compare(actual, read(prefix, call, arg, 'post', width))
        row['native_rMr_recomputed'] = float(pcg.cub_sum(outputs[2]))
        if k+1 < linear and flags[call]:
            # With 53 particles there is one reduction block; check the assumed call/iteration indexing.
            nxt = read(prefix, call+1, 1)[k+1]
            row['reduction_continuity'] = nxt.tobytes() == read(prefix, call, 8, 'post')[0].tobytes()
        report['updates'].append(row)
    key = '27invert_block_preconditioner'
    for i in range(iterations):
        actual = pcg.invert_block_preconditioner(read(key, i, 0, width=9), read(key, i, 1),
                                                 read(key, i, 2, dtype=np.int32))
        report['inverse'].append(compare(actual, read(key, i, 3, 'post', 9)))
        rows = report['updates'][i*linear:(i+1)*linear]
        native_end = rows[-1]['native_rMr_recomputed']
        source_end = pcg.cub_sum(source((i+1)*linear-1, 'out2'))
        report['iterations'].append({
            'iteration': i, 'native_initial_rMr': rows[0]['native_num'], 'source_initial_rMr': rows[0]['source_num'],
            'native_final_rMr_recomputed': float(native_end), 'source_final_rMr': float(source_end),
            'native_guarded_updates': sum(row['native_alpha'] == 0 for row in rows),
            'source_guarded_updates': sum(row['source_alpha'] == 0 for row in rows),
            'max_alpha_difference': max(abs(row['native_alpha']-row['source_alpha']) for row in rows)})
    report['bitwise_equal'] = all(row[k]['different_bits'] == 0 for row in report['updates']
                                  for k in ('solution', 'residual', 'partial')) and all(
                                      row['different_bits'] == 0 for row in report['inverse'])
    report['indexing_valid'] = all(row.get('reduction_continuity', True) for row in report['updates'])
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: v for k, v in report.items() if k not in ('updates', 'inverse')}, indent=2))
    if not report['bitwise_equal'] or not report['indexing_valid']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
