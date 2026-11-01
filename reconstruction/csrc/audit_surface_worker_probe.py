"""Audit selected worker-stage outputs and explicitly test whether the probe reproduced frozen candidate trajectories."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

import numpy as np

from reconstruction.demo_ab import compare as compare_states
from .audit_cudahook import compare as compare_launches, schemas


OUTPUTS = {
    '15initialize_step': (20, 21, 22), '14initialize_rhs': (9,),
    '30evaluate_surface_contact_force': (1,), '35add_surface_contact_stiffness_scale': (1,),
    '27evaluate_soft_contact_force': (36, 37, 40, 41),
    '51evaluate_affine_body_so3_augmented_lagrangian_force': (6,),
    '21evaluate_spring_force': (4,), '22evaluate_stretch_force': (5,), '22evaluate_bending_force': (7,),
    '25initialize_block_diagonal': (1, 2), '34add_surface_contact_preconditioner': (1,),
    '55add_affine_body_so3_augmented_lagrangian_preconditioner': (4,), '20add_hessian_diagonal': (1,),
    '27invert_block_preconditioner': (3,), '32build_affine_body_preconditioner': (17, 18),
    '35apply_block_diagonal_preconditioner': (2,), '32apply_affine_body_preconditioner': (4,),
    '23precondition_and_reduce': (2, 6), '19update_cg_direction': (6,),
    '32multiply_surface_contact_tangent': (2,), '53multiply_affine_body_so3_augmented_lagrangian_tangent': (5,),
    '26multiply_matrix_and_reduce': (6, 9), '28update_solution_and_residual': (6, 7),
    '20apply_nonlinear_step': (1,), '15update_velocity': (3,),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--original', type=Path, required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--cohort', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    captures = (args.original, args.source)
    probes = [json.loads((folder / 'probe.json').read_text()) for folder in captures]
    assert probes[0]['case'] == probes[1]['case'] and probes[0]['fields'] == probes[1]['fields']
    selected = []
    for tag, folder, probe in zip(('original', 'source'), captures, probes):
        full = (folder / 'launches.txt').read_text().splitlines()
        selection = probe['selection']
        lines = full[selection['first_log_line']:selection['last_log_line_exclusive']]
        selected.append(lines)
        # The log auditor requires contiguous zero-based sequences; keep original raw sequences in the capture.
        normalized = [str(i) + ' ' + line.split(' ', 1)[1] for i, line in enumerate(lines)]
        (args.output / f'{tag}-selected-launches.txt').write_text('\n'.join(normalized) + '\n')
    metadata = compare_launches(args.output / 'original-selected-launches.txt',
                               args.output / 'source-selected-launches.txt', schemas()[0])
    assert metadata['equal'], 'Resolve an actual ABI/geometry difference before interpreting numerical stages'
    ordinals, checks = Counter(), []
    for index, line in enumerate(selected[0]):
        name = line.split(' symbol:', 1)[1].split()[0]
        matches = [token for token in OUTPUTS if token in name]
        if not matches:
            continue
        assert len(matches) == 1
        token = matches[0]
        ordinal = ordinals[token]
        ordinals[token] += 1
        for argument in OUTPUTS[token]:
            filename = f'dump_{token}_call{ordinal:03d}_post_arg{argument}.bin'
            paths = [folder / filename for folder in captures]
            assert paths[0].exists() == paths[1].exists()
            if not paths[0].exists():
                continue
            values = [p.read_bytes() for p in paths]
            assert len(values[0]) == len(values[1])
            a, b = [np.frombuffer(value, dtype='u4') for value in values]
            different = np.flatnonzero(a != b)
            row = {'selected_launch': index, 'token': token, 'ordinal': ordinal, 'argument': argument,
                   'bytes': len(values[0]), 'bitwise_equal': not len(different),
                   'different_words': len(different), 'sha256': [hashlib.sha256(value).hexdigest() for value in values]}
            if len(different):
                row['first_word'] = int(different[0])
                row['first_bits'] = [int(value[different[0]]) for value in (a, b)]
            checks.append(row)
    reproduction = {}
    for tag, folder in zip(('original', 'source'), captures):
        filename = f'{tag}-{probes[0]["case"]}-0.npz'
        frozen_path = args.cohort / (tag + '0') / filename
        with np.load(folder / filename) as probe, np.load(frozen_path) as frozen:
            reproduction[tag] = {'full_trajectory': compare_states(frozen, probe),
                                 'first_step_equal': {key: probe[key][0].tobytes() == frozen[key][0].tobytes()
                                                      for key in frozen.files},
                                 'frozen_npz_sha256': hashlib.sha256(frozen_path.read_bytes()).hexdigest()}
    report = {'metadata': metadata, 'defined_output_checks': checks,
              'first_defined_output_difference': next((row for row in checks if not row['bitwise_equal']), None),
              'frozen0_reproduction': reproduction, 'pointer_aliases_compared': False,
              'allocation_relative_offsets_compared': False, 'all_kernel_pointees_compared': False,
              'pre_write_undefined_outputs_compared': False, 'frozen_candidate_replaced': False,
              'whole_solver_complete': False,
              'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('selected ABI', metadata['left_launches'], 'defined output comparisons', len(checks),
          'first difference', report['first_defined_output_difference'], flush=True)


if __name__ == '__main__':
    main()
