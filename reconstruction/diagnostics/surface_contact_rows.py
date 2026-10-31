"""Check each real captured surface contact separately against legacy PTX kernels.

Removing cross-contact writes isolates the per-contact formulas from accumulation
order. This is a local kernel test, not an end-to-end solver or native SASS replay.
"""
import argparse
import copy
import json
from pathlib import Path

import numpy as np

from reconstruction import surface_contact
from reconstruction.contact_replay import load
from reconstruction.diagnostics.compare_contact_stages import compare
from reconstruction.kernel_ab import Driver, legacy_ptx, surface_view
from reconstruction.solver import ReconstructedSolver
from reconstruction.validate import ANALYSIS_SHA, sha


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--native-hook', type=Path, required=True)
    parser.add_argument('--source-trace', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    record = load(args.input)
    if record['reference_sha256'] != ANALYSIS_SHA:
        raise RuntimeError('Wrong reference')
    x = np.fromfile(args.native_hook/'dump_14initialize_rhs_pre_arg1.bin', np.float32).reshape(-1, 3)
    source_x = np.load(args.source_trace/'initialize_rhs-in1.npy')
    if x.tobytes() != source_x.tobytes():
        raise RuntimeError('Predicted positions differ')
    solver = ReconstructedSolver(record['model'])
    contacts = solver._surface_inputs(x, record['particle_q'], record['contacts'], np.float32(record['dt']))
    transform = record['model'].shape_transform.numpy()
    direction = np.load(args.source_trace/'update_solution_residual_and_reduce-in3.npy')
    f0 = np.zeros_like(x)
    b0 = np.fromfile(args.native_hook/'dump_27invert_block_preconditioner_pre_arg0.bin', np.float32).reshape(-1, 9)
    driver = Driver()
    entries = {'force': '30evaluate_surface_contact_force', 'preconditioner': '34add_surface_contact_preconditioner',
               'tangent': '32multiply_surface_contact_tangent'}
    functions = {key: driver.function(*legacy_ptx(value)) for key, value in entries.items()}
    report = {'input_sha256': sha(args.input), 'reference_sha256': ANALYSIS_SHA, 'contacts': []}
    try:
        for index in range(contacts.count):
            c = copy.copy(contacts)
            c.count = 1
            for name in ('indices', 'barycentric', 'shape', 'body_pos', 'body_vel', 'normal'):
                setattr(c, name, getattr(contacts, name)[index:index+1])
            view = surface_view(driver, c, transform)
            result = {'index': index}
            for key, base in (('force', f0), ('preconditioner', b0), ('tangent', f0)):
                buf = driver.upload(base)
                params = [view, buf] if key != 'tangent' else [view, driver.upload(direction), buf]
                driver.launch(functions[key], 1, params)
                actual = base.copy()
                if key == 'force':
                    surface_contact.evaluate_surface_contact_force(c, actual)
                elif key == 'preconditioner':
                    surface_contact.add_surface_contact_preconditioner(c, actual)
                else:
                    surface_contact.multiply_surface_contact_tangent(c, direction, actual)
                expected = driver.download(buf, base)
                result[key] = compare(actual, expected)
                result[key]['changed'] = int(np.count_nonzero(expected.view(np.uint32) != base.view(np.uint32)))
            report['contacts'].append(result)
            driver.free()
    finally:
        driver.free()
    report['bitwise_equal'] = all(row[key]['different_bits'] == 0 for row in report['contacts'] for key in entries)
    report['active_contacts'] = {key: sum(row[key]['changed'] > 0 for row in report['contacts']) for key in entries}
    args.output.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({k: v for k, v in report.items() if k != 'contacts'}))
    if not report['bitwise_equal']:
        raise SystemExit(1)


if __name__ == '__main__':
    main()
