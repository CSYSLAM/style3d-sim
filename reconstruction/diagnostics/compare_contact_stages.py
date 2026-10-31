"""Compare first-stage source traces to CUDA hook dumps; replay PCG on identical inputs."""
import argparse
import json
from pathlib import Path

import numpy as np

from reconstruction import pcg


PAIRS = [
    ('initial_positions', 'initialize_rhs-in1', '14initialize_rhs_pre_arg1'),
    ('inertia_target', 'initialize_rhs-in2', '14initialize_rhs_pre_arg2'),
    ('mass', 'initialize_rhs-in3', '14initialize_rhs_pre_arg3'),
    ('external_force', 'initialize_rhs-in4', '14initialize_rhs_pre_arg7'),
    ('rhs', 'initialize_rhs-out0', '14initialize_rhs_post_arg9'),
    ('matrix_before_inverse', 'invert_block_preconditioner-in0', '27invert_block_preconditioner_pre_arg0'),
    ('inverse', 'invert_block_preconditioner-out0', '27invert_block_preconditioner_post_arg3'),
    ('rhs_before_cg', 'initialize_zero_solution_and_reduce-in0', '35initialize_zero_solution_and_reduce_pre_arg0'),
    ('initial_cg_sum', 'initialize_zero_solution_and_reduce-out2', '35initialize_zero_solution_and_reduce_post_arg4'),
    ('first_direction', 'update_solution_residual_and_reduce-in3', 'update_solution_residual_and_reduce_pre_arg3'),
    ('first_product', 'update_solution_residual_and_reduce-in4', 'update_solution_residual_and_reduce_pre_arg4'),
    ('first_solution', 'update_solution_residual_and_reduce-out0', 'update_solution_residual_and_reduce_post_arg6'),
    ('first_residual', 'update_solution_residual_and_reduce-out1', 'update_solution_residual_and_reduce_post_arg7'),
    ('surface_force_before', 'evaluate_surface_contact_force-in1', '30evaluate_surface_contact_force_pre_arg1'),
    ('surface_force_after', 'evaluate_surface_contact_force-post1', '30evaluate_surface_contact_force_post_arg1'),
    ('surface_preconditioner_before', 'add_surface_contact_preconditioner-in1',
     '34add_surface_contact_preconditioner_pre_arg1'),
    ('surface_preconditioner_after', 'add_surface_contact_preconditioner-post1',
     '34add_surface_contact_preconditioner_post_arg1'),
]


def compare(a, b):
    a, b = a.reshape(-1), b.reshape(-1)
    if a.shape != b.shape or a.dtype != b.dtype:
        raise ValueError('Incompatible dump shapes/dtypes')
    if not np.isfinite(a).all() or not np.isfinite(b).all():
        raise ValueError('Nonfinite dump')
    i = int(np.abs(a-b).argmax())
    return {'max_abs': float(np.abs(a-b)[i]), 'worst_flat_index': i,
            'source_at_worst': float(a[i]), 'native_at_worst': float(b[i]),
            'different_bits': int(np.count_nonzero(a.view(np.uint32) != b.view(np.uint32)))}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--native', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = {'comparisons': {}, 'unavailable': []}
    for name, source, native in PAIRS:
        s, n = args.source/(source+'.npy'), args.native/('dump_'+native+'.bin')
        if not s.exists() or not n.exists():
            report['unavailable'].append(name)
            continue
        report['comparisons'][name] = compare(np.load(s), np.fromfile(n, dtype=np.float32))

    def read(key, arg, phase='pre', width=1, dtype=np.float32):
        a = np.fromfile(args.native/f'dump_{key}_{phase}_arg{arg}.bin', dtype=dtype)
        return a.reshape(-1, width) if width > 1 else a

    if 'inverse' in report['comparisons']:
        key = '27invert_block_preconditioner'
        actual = pcg.invert_block_preconditioner(read(key, 0, width=9), read(key, 1), read(key, 2, dtype=np.int32))
        report['comparisons']['inverse_same_input'] = compare(actual, read(key, 3, 'post', 9))
    if 'first_solution' in report['comparisons']:
        key = 'update_solution_residual_and_reduce'
        # The dump is the first PCG iteration, so only num[0] and den[0] are consumed.
        x, residual, partial = pcg.update_solution_residual_and_reduce(
            0, read(key, 1), read(key, 2), read(key, 3, width=3), read(key, 4, width=3),
            read(key, 5, width=9), read(key, 6, width=3), read(key, 7, width=3))
        for name, a, arg, width in [('solution', x, 6, 3), ('residual', residual, 7, 3), ('sum', partial, 8, 1)]:
            report['comparisons'][f'cg_{name}_same_input'] = compare(a, read(key, arg, 'post', width))
    if not report['comparisons']:
        raise RuntimeError('No matching captured stages')
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
