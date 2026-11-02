"""Compare all Newton updates while checking each trace's update/continuity identities."""
import argparse
import json
from pathlib import Path

import numpy as np

from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.validate import sha


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--native', type=Path, required=True)
    parser.add_argument('--native-output', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    record = load(args.input)
    count, linear = record['config']['nonlinear_iterations'], record['config']['linear_iterations']
    source_final = np.load(args.source/f"replayed-step-{record['step']:04d}.npz")['q']
    native_final = np.load(args.native_output/'native-0.npz')['q']

    def source(name, call, field):
        return np.load(args.source/f'{name}_call{call:03d}-{field}.npy')

    def native(name, call, phase, arg, width=3):
        a = np.fromfile(args.native/f'dump_{name}_call{call:03d}_{phase}_arg{arg}.bin', np.float32)
        return a.reshape(-1, width)

    report = {'input_sha256': sha(args.input), 'iterations': [], 'trace_checks': []}
    prior_native = None
    for i in range(count):
        sx = source('initialize_rhs', i, 'in1')
        delta = source('update_solution_residual_and_reduce', (i+1)*linear-1, 'out0')
        source_after = source('initialize_rhs', i+1, 'in1') if i+1 < count else source_final
        nx = native('20apply_nonlinear_step', i, 'pre', 0)
        nd = native('20apply_nonlinear_step', i, 'pre', 2)
        native_after = native('20apply_nonlinear_step', i, 'post', 1)
        checks = {'iteration': i, 'source_addition_exact': (sx+delta).tobytes() == source_after.tobytes(),
                  'native_addition_exact': (nx+nd).tobytes() == native_after.tobytes(),
                  'native_continuity_exact': prior_native is None or prior_native.tobytes() == nx.tobytes(),
                  'native_delta_cleared': bool(np.all(native('20apply_nonlinear_step', i, 'post', 2) == 0))}
        report['trace_checks'].append(checks)
        prior_native = native_after
        row = {'iteration': i, 'positions_before': compare(sx, nx), 'newton_delta': compare(delta, nd),
               'positions_after': compare(source_after, native_after),
               'rhs_before_cg': compare(source('initialize_zero_solution_and_reduce', i, 'in0'),
                                        native('35initialize_zero_solution_and_reduce', i, 'pre', 0)),
               'inverse': compare(source('initialize_zero_solution_and_reduce', i, 'in1'),
                                  native('35initialize_zero_solution_and_reduce', i, 'pre', 1, 9))}
        report['iterations'].append(row)
        print(json.dumps({'iteration': i, **{k: v['max_abs'] for k, v in row.items() if isinstance(v, dict)}}))
    report['final_native_matches_saved_output'] = prior_native.tobytes() == native_final.tobytes()
    report['trace_valid'] = report['final_native_matches_saved_output'] and all(
        all(v for k, v in c.items() if k != 'iteration') for c in report['trace_checks'])
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    if not report['trace_valid']:
        raise SystemExit('Trace identity failed; do not interpret this as a solver mismatch')


if __name__ == '__main__':
    main()
