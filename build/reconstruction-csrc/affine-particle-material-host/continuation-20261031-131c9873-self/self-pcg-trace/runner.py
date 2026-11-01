"""Observe three eager steps of the fixed self/tet graph worker without changing its fixture order."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path

from reconstruction.demo_ab import compare
from . import affine_tetrahedron_graph_ab as worker
from . import host_api_probe, host_particles_ab
from .demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--baseline', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    observer = ctypes.CDLL(None)
    observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
    target, current, observed = 'w3-pd-b1', None, 0
    cases = worker.cases

    def ordered_cases():
        nonlocal current
        for name, worlds, extra in cases():
            current = name
            yield name, worlds, extra

    worker.cases = ordered_cases
    owner = host_api_probe if args.backend == 'original' else host_particles_ab
    name = 'load_reference' if args.backend == 'original' else 'native_source'
    factory = getattr(owner, name)

    def install():
        core = factory()
        if args.backend == 'source':
            from .host_bodies_ab import bridge
            bridge(core)
        import style3d_sim as s3d
        original_step = s3d.NewtonSolver.step

        def step(solver, *values, **keywords):
            nonlocal observed
            active = current == target and observed < 3
            if active and observed == 0:
                observer.solver_trace_begin(str(args.output / 'native').encode())
            result = original_step(solver, *values, **keywords)
            if active:
                observed += 1
                if observed == 3:
                    observer.solver_trace_end()
            return result

        s3d.NewtonSolver.step = step
        return core

    setattr(owner, name, install)
    saved = (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
    fixture = ROOT / 'reconstruction/csrc/affine_tetrahedron_self_scene.py'
    options = argparse.Namespace(worker=args.backend, fixture=fixture, particles_per_world=24,
                                 diagonal_only=False, frames=60, output=args.output)
    worker.worker(options)
    assert observed == 3
    assert (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved
    runtime_name = args.backend + '.runtime.json'
    assert (args.baseline / runtime_name).read_bytes() == (args.output / runtime_name).read_bytes()
    import numpy as np
    filename = f'{args.backend}-{target}-0.npz'
    with np.load(args.baseline / filename) as old, np.load(args.output / filename) as new:
        reproduction = compare(old, new)
        first_three = {k: np.array_equal(old[k][:3].view('u4'), new[k][:3].view('u4')) for k in old.files}
        first_three['bitwise'] = all(first_three.values())
    (args.output / 'probe.json').write_text(json.dumps({
        'target': target, 'observed_steps': observed, 'baseline': str(args.baseline.resolve()),
        'frozen_target_reproduction': reproduction, 'first_three_reproduction': first_three,
        'synchronizing_diagnostic': True, 'frozen_candidate_replaced': False,
        'whole_solver_complete': False, 'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }, indent=2) + '\n')
    print(args.backend, 'frozen target reproduced', reproduction['bitwise'],
          'first three', first_three['bitwise'], flush=True)


if __name__ == '__main__':
    main()
