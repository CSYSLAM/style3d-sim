"""Capture a native PD step with nonzero edge damping configured before solver initialization.

The old output in the input NPZ is only a zero-damping comparison, not the expected
answer for this variant. Promote the newly saved native output before source replay.
"""
import argparse
from pathlib import Path
import sys

import numpy as np

from reconstruction import core, contact_native_replay
from reconstruction.contact_replay import load, save


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--variant', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--damping', type=float, default=1e-4)
    parser.add_argument('--runtime-update', action='store_true',
                        help='Negative control: mutate damping after native initialization instead of configuring the builder')
    args = parser.parse_args()
    if args.variant.exists():
        raise RuntimeError('Use a new variant file')
    record = load(args.input)
    if record['config']['nonlinear_solver'] != 1 or not np.isfinite(args.damping) or args.damping <= 0:
        raise ValueError('A PD input and positive finite damping are required')
    properties = record['model'].edge_bending_properties.numpy().copy()
    properties[:, 1] = np.float32(args.damping)
    record['model'].edge_bending_properties = core._Host(properties)
    record['diagnostic_variant'] = ('runtime' if args.runtime_update else 'initial') + \
        ' edge damping change; old out_q/out_qd are not this variant reference'
    save(args.variant, record)
    original = contact_native_replay.make_example

    def make_example(*a, **kw):
        # Native initialization may cache whether damping kernels are needed. Configure the builder first.
        if args.runtime_update:
            example = original(*a, **kw)
            core._write(example.solver._synreal_model.edge_bending_properties, properties)
            return example
        a[0].edge_damping = args.damping
        return original(*a, **kw)

    contact_native_replay.make_example = make_example
    sys.argv = [sys.argv[0], '--input', str(args.variant), '--output', str(args.output), '--repeats', '1']
    try:
        contact_native_replay.main()
    finally:
        contact_native_replay.make_example = original


if __name__ == '__main__':
    main()
