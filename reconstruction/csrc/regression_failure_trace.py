"""Trace a selected regression failure inside its full worker order, retaining preceding allocations."""
import argparse
import ctypes
import hashlib
import json
from pathlib import Path

from . import host_api_probe, host_particles_ab


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('legacy', 'source'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--scenario', required=True)
    parser.add_argument('--seed', type=int, required=True)
    parser.add_argument('--case', required=True)
    parser.add_argument('--adapter', action='store_true')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    target = args.case
    state = {'fixture': None, 'observed_steps': 0, 'active': False}
    observer = ctypes.CDLL(None)
    observer.solver_trace_begin.argtypes = [ctypes.c_char_p]
    fixtures = host_particles_ab.selected_fixtures

    def ordered_fixtures(options):
        for name, case in fixtures(options):
            state['fixture'] = name
            yield name, case

    host_particles_ab.selected_fixtures = ordered_fixtures
    owner = host_api_probe if args.backend == 'legacy' else host_particles_ab
    factory_name = 'load_reference' if args.backend == 'legacy' else 'native_source'
    factory = getattr(owner, factory_name)

    def selected():
        core = factory()
        initialize, step = core.Solver.initialize, core.Solver.step

        def initialize_traced(solver, *values, **keywords):
            result = initialize(solver, *values, **keywords)
            if state['fixture'] == target:
                assert not state['active'] and state['observed_steps'] == 0
                observer.solver_trace_begin(str(args.output / 'native').encode())
                state['active'] = True
            return result

        def step_traced(solver, *values, **keywords):
            result = step(solver, *values, **keywords)
            if state['active']:
                state['observed_steps'] += 1
                if state['observed_steps'] == 3:
                    observer.solver_trace_end()
                    state['active'] = False
            return result

        core.Solver.initialize, core.Solver.step = initialize_traced, step_traced
        (args.output / 'diagnostic-runtime.json').write_text(json.dumps({
            'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
            'classification': 'synchronizing diagnostic; must compare with frozen first candidate',
            'full_worker_order_preserved': True, 'target': target,
            'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in
                       (Path(__file__), Path(host_particles_ab.__file__),
                        *sorted(Path(host_particles_ab.__file__).parent.glob('*host_cases.py')))}}, indent=2) + '\n')
        return core

    setattr(owner, factory_name, selected)
    host_particles_ab.worker(argparse.Namespace(
        worker=args.backend, seed=args.seed, scenario=args.scenario, adapter=args.adapter,
        output=str(args.output), trace_case=None, trace_label='unused'))
    assert state['observed_steps'] == 3 and not state['active']


if __name__ == '__main__':
    main()
