"""Run an unmodified example with either the reference solver image or the compiled source image.

    .venv/bin/python -m reconstruction.run_demo --backend original examples/example_fluid.py
    .venv/bin/python -m reconstruction.run_demo --backend source   examples/example_fluid.py [example options...]

`original` loads the project-internal processed SDK image (64a0be7f, no login); `source` loads the compiled
_source_solver image and installs it as style3d_sim._core. Example options are passed through unchanged
(e.g. `--viewer null --num-frames 100`). Login credentials are never read; they are removed from the environment.
With --save-final the final state is written to an .npz so the two backends can be compared (compare_final.py).
"""
import argparse
import hashlib
import os
import runpy
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('example', type=Path)
    parser.add_argument('--save-final', type=Path, help='write the final particle/body state to this .npz')
    args, rest = parser.parse_known_args()
    for key in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD'):
        os.environ.pop(key, None)
    sys.path.insert(0, str(ROOT))
    if args.backend == 'original':
        from reconstruction.csrc.host_api_probe import load_reference
        core = load_reference()
    else:
        from reconstruction.csrc.host_bodies_ab import bridge
        from reconstruction.csrc.host_particles_ab import native_source
        core = native_source()
        bridge(core)
    image = Path(core.__file__).resolve()
    print(f'[run_demo] backend={args.backend} image={image} '
          f'sha256={hashlib.sha256(image.read_bytes()).hexdigest()[:16]}', flush=True)
    if args.save_final:
        import newton.examples
        import numpy as np
        run = newton.examples.run

        def run_and_save(example, demo_args):
            # The example object only exists inside the example's __main__, so capture it where it is run.
            result = run(example, demo_args)
            state = getattr(example, 'state_0', None)
            arrays = {name: getattr(state, name).numpy() for name in ('particle_q', 'particle_qd', 'body_q', 'body_qd')
                      if getattr(state, name, None) is not None and getattr(state, name).shape[0]}
            np.savez(args.save_final, **arrays)
            print(f'[run_demo] final state saved to {args.save_final}: {sorted(arrays)}', flush=True)
            return result
        newton.examples.run = run_and_save
    example = args.example.resolve()
    sys.path.insert(0, str(example.parent))
    sys.argv = [str(example)] + rest
    runpy.run_path(str(example), run_name='__main__')


if __name__ == '__main__':
    main()
