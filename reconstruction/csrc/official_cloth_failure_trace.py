"""Observe the first eager substep inside the unchanged official worker, outside its acceptance cohort."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path

from . import host_api_probe, host_particles_ab, official_cloth_balls_ab


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    args = parser.parse_args()
    assert args.frames >= 30
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    observer = ctypes.CDLL(None)
    observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
    owner = host_api_probe if args.backend == 'original' else host_particles_ab
    factory_name = 'load_reference' if args.backend == 'original' else 'native_source'
    factory = getattr(owner, factory_name)
    steps = 0

    def selected():
        core = factory()
        step = core.Solver.step

        def observed(solver, *values, **keywords):
            nonlocal steps
            if steps == 0:
                observer.solver_trace_begin(str(args.output / 'native').encode())
            result = step(solver, *values, **keywords)
            steps += 1
            if steps == 1:
                observer.solver_trace_end()
            return result

        core.Solver.step = observed
        (args.output / 'diagnostic-runtime.json').write_text(json.dumps({
            'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
            'observed_substeps': 1, 'acceptance_cohort_changed': False,
            'must_compare_actual_states_with_frozen_candidates': True,
            'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (
                Path(__file__), Path(official_cloth_balls_ab.__file__), official_cloth_balls_ab.EXAMPLE)},
        }, indent=2) + '\n')
        return core

    setattr(owner, factory_name, selected)
    official_cloth_balls_ab.worker(argparse.Namespace(
        worker=args.backend, mode='eager', frames=args.frames, output=args.output))
    assert steps == args.frames * 2


if __name__ == '__main__':
    main()
