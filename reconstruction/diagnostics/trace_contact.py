"""Record the first Newton/PCG stages of a captured source step, without changing arithmetic."""
import argparse
import functools
import json
from pathlib import Path
import shutil
from types import SimpleNamespace

import numpy as np

from reconstruction import pcg, surface_contact
from reconstruction.contact_replay import load, replay
from reconstruction.validate import ANALYSIS_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--all-calls', action='store_true', help='Save numbered calls through every Newton/PCG iteration')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if list(args.output.iterdir()):
        raise RuntimeError('Use a new empty output directory')
    record = load(args.input)
    shutil.copyfile(args.input, args.output / f"step-{record['step']:04d}.npz")
    (args.output/'capture-complete.json').write_text(json.dumps({'steps': [record['step']], 'sha': ANALYSIS_SHA}))
    originals = {}

    def instrument(name, inputs, module=pcg, mutated=()):
        original = getattr(module, name)
        originals[module, name] = original
        calls = 0

        @functools.wraps(original)
        def wrapped(*a, **kw):
            nonlocal calls
            capture = args.all_calls or calls == 0
            prefix = f'{name}_call{calls:03d}' if args.all_calls else name
            calls += 1
            if capture:
                for i in inputs:
                    np.save(args.output/f'{prefix}-in{i}.npy', np.asarray(a[i]))
            result = original(*a, **kw)
            if capture:
                outputs = () if result is None else (result if isinstance(result, tuple) else (result,))
                for i, value in enumerate(outputs):
                    np.save(args.output/f'{prefix}-out{i}.npy', np.asarray(value))
                for i in mutated:
                    np.save(args.output/f'{prefix}-post{i}.npy', np.asarray(a[i]))
            return result
        setattr(module, name, wrapped)

    instrument('initialize_rhs', (0, 1, 2, 3, 4, 5))
    instrument('invert_block_preconditioner', (0, 1, 2))
    instrument('initialize_zero_solution_and_reduce', (0, 1))
    instrument('update_solution_residual_and_reduce', tuple(range(8)))
    instrument('evaluate_surface_contact_force', (1,), surface_contact, (1,))
    instrument('add_surface_contact_preconditioner', (1,), surface_contact, (1,))
    try:
        replay(SimpleNamespace(output=args.output))
    finally:
        for (module, name), original in originals.items():
            setattr(module, name, original)


if __name__ == '__main__':
    main()
