"""One-substep replay of an example from a recorded legacy state, on the legacy library or on the reconstruction.

    .venv/bin/python -m reconstruction.diagnostics.replay_step --backend native --example examples/X.py \
        --input build/reconstruction-demos/X-spread/native0.npz --substeps 7,8,9 --repeats 5 --output OUT.npz

For every substep t the particle state recorded after substep t-1 is loaded into state_0, then the example's own
substep body (clear_forces, collide, solver.step) runs once; this repeats `--repeats` times from the same input.
Where the legacy library is not reproducible against itself (cloth element atomics), this separates "the
reconstruction computes a different step" from "small ordering differences grew over many steps": the
reconstruction's one-step result must lie within the legacy one-step spread.
"""
import argparse
import importlib.util
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--backend', choices=('native', 'shim'), required=True)
    parser.add_argument('--atomic-order', default='descending')
    parser.add_argument('--example', required=True)
    parser.add_argument('--input', required=True)
    parser.add_argument('--substeps', required=True)
    parser.add_argument('--repeats', type=int, default=5)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()

    import resource
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    sys.path.insert(0, str(ROOT))
    sys.path.insert(0, str(Path(args.example).resolve().parent))
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    from reconstruction import demo_ab
    if args.backend == 'native':
        from reconstruction import validate
        validate.install_reference(validate.LEGACY)
    else:
        if args.atomic_order != 'descending':
            demo_ab._patch_atomic_order(args.atomic_order)
        from reconstruction import core
        core.install()
    spec = importlib.util.spec_from_file_location('demo_under_test', args.example)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.Example.capture = lambda self: setattr(self, 'graph', None)
    import newton.examples
    sys.argv = [Path(args.example).stem, '--viewer', 'null', '--num-frames', '1']
    viewer, demo_args = newton.examples.init(demo_ab._parser_for(module, args.example))
    example = module.Example(viewer, demo_args)

    recorded = np.load(args.input)
    substeps = [int(t) for t in args.substeps.split(',')]
    out = {}
    for t in substeps:
        if t < 1:
            raise SystemExit('substep 0 has no recorded input state; use the demo A/B for it')
        results = []
        for _ in range(args.repeats):
            state_in, state_out = example.state_0, example.state_1
            state_in.particle_q.assign(recorded['particle_q'][t-1])
            state_in.particle_qd.assign(recorded['particle_qd'][t-1])
            state_in.clear_forces()
            example.viewer.apply_forces(state_in)
            example.model.collide(state_in, example.contacts)
            example.solver.step(state_in, state_out, example.control, example.contacts, example.sim_dt)
            results.append(np.stack((state_out.particle_q.numpy(), state_out.particle_qd.numpy())))
        out[f't{t}'] = np.stack(results)      # (repeats, q/qd, particles, 3)
    np.savez_compressed(args.output, **out)
    print('replay_complete', flush=True)


if __name__ == '__main__':
    main()
