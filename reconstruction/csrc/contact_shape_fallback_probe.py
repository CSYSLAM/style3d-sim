"""Exercise actual single-world default shape tiles and explicit/shared tiles without changing standard fixtures."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
from types import SimpleNamespace

import numpy as np


def static_cases(seed):
    from .surface_host_cases import base_fixtures
    for worlds in (1, 2, 3):
        template_worlds = min(worlds, 2)
        base = next(case for name, case in base_fixtures(seed) if name == f'surface_w{template_worlds}_basic')
        for tile in (0, 1):
            case = copy.deepcopy(base)
            if worlds == 3:
                for key in ('q', 'v', 'force'):
                    case[key] = np.tile(base[key][:3], (worlds, 1))
                case['gravity'] = np.tile(base['gravity'][:1], (worlds, 1))
                case['soft_indices'] = np.arange(worlds * 3, dtype='i4').reshape(-1, 3)
                for key in ('soft_barycentric', 'soft_body_pos', 'soft_body_vel', 'soft_normal'):
                    case[key] = np.tile(base[key][:1], (worlds, 1))
                case['soft_count'] = np.array([worlds], dtype='i4')
                case['soft_max_count'] = worlds
                case['worlds'] = worlds
            case['shape_replicated_count'] = tile
            case['soft_shape'] = np.arange(worlds, dtype='i4') if tile else np.zeros(worlds, dtype='i4')
            case['iterations'], case['linear_iterations'] = 1, 2
            yield f'shape_w{worlds}_tile{tile}', case


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--suite', choices=('static', 'body'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    if args.suite == 'static':
        from . import host_particles_ab as host
        host.selected_fixtures = lambda options: static_cases(options.seed)
        host.worker(SimpleNamespace(worker='legacy' if args.backend == 'original' else 'source',
            output=str(args.output), scenario='surface', seed=1, trace_case=None, trace_label='shape-probe', adapter=False))
        return
    import warp as wp
    wp.init()
    if args.backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_particles_ab import native_source
        from .host_bodies_ab import bridge
        core = native_source()
        bridge(core)
    initialize = core.Solver.initialize

    def default_tile(solver, model, *values, **keywords):
        assert model.world_count == 1 and model.shape_count == 2
        model.shape_replicated_count = 0
        return initialize(solver, model, *values, **keywords)

    core.Solver.initialize = default_tile
    import style3d_sim as s3d
    from .host_bodies_ab import simulate
    constructor = s3d.NewtonSolver.__init__
    records = {}
    for hard in (False, True):
        def configured(solver, *values, **keywords):
            constructor(solver, *values, **keywords)
            solver.config.rigid_contact_hard = hard
        s3d.NewtonSolver.__init__ = configured
        for mode in ('newton', 'pd'):
            solver, arrays = simulate('ground_box', 1, mode, 3)
            assert max(int(value[0]) for key, value in arrays.items() if key.startswith('rigid_contact_count/')) > 0
            assert all(np.isfinite(value).all() for value in arrays.values())
            records.update({f'hard{int(hard)}-{mode}/{key}': value for key, value in arrays.items()})
    np.savez_compressed(args.output / 'body.npz', **records)
    if args.backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    (args.output / 'runtime.json').write_text(json.dumps({
        'backend': args.backend, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
        'forced_single_world_shape_replicated_count': 0, 'finite_and_active_contact': True,
        'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}, indent=2) + '\n')


if __name__ == '__main__':
    main()
