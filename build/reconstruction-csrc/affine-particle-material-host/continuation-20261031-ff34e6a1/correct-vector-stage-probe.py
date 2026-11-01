"""Trace the first eager step of one surface case while retaining the complete frozen worker's scene sequence."""
import argparse
import hashlib
import json
import os
from pathlib import Path

from .demo_source_ab import ROOT


def fields():
    n, worlds = 36, 3
    vector, matrix = n * 12, n * 36
    return {
        '15initialize_step': {4: vector, 5: vector, 20: vector, 21: vector, 22: n * 4},
        '14initialize_rhs': {1: vector, 2: vector, 7: vector, 9: vector},
        '30evaluate_surface_contact_force': {1: vector},
        '35add_surface_contact_stiffness_scale': {1: n * 4},
        '27evaluate_soft_contact_force': {36: vector, 37: n * 4, 40: matrix, 41: matrix},
        '51evaluate_affine_body_so3_augmented_lagrangian_force': {6: vector},
        '21evaluate_spring_force': {4: vector},
        '22evaluate_stretch_force': {5: vector},
        '22evaluate_bending_force': {7: vector},
        '25initialize_block_diagonal': {0: n * 4, 1: matrix, 2: matrix},
        '34add_surface_contact_preconditioner': {1: matrix},
        '55add_affine_body_so3_augmented_lagrangian_preconditioner': {4: matrix},
        '20add_hessian_diagonal': {0: matrix, 1: matrix},
        '27invert_block_preconditioner': {0: matrix, 3: matrix},
        '32build_affine_body_preconditioner': {4: matrix, 16: worlds * 144 * 4,
                                              17: worlds * 144 * 4, 18: worlds * 4},
        '35apply_block_diagonal_preconditioner': {0: matrix, 1: vector, 2: vector},
        '32apply_affine_body_preconditioner': {3: vector, 4: vector},
        '23precondition_and_reduce': {0: matrix, 1: vector, 2: vector, 6: worlds * 4},
        '19update_cg_direction': {1: vector, 4: worlds * 4, 6: vector},
        '32multiply_surface_contact_tangent': {1: vector, 2: vector},
        '53multiply_affine_body_so3_augmented_lagrangian_tangent': {0: vector, 5: vector},
        '26multiply_matrix_and_reduce': {4: vector, 5: vector, 6: vector, 9: worlds * 4},
        '28update_solution_and_residual': {2: worlds * 4, 3: worlds * 4, 6: vector, 7: vector},
        '20apply_nonlinear_step': {0: vector, 1: vector, 2: vector},
        '15update_velocity': {1: vector, 2: vector, 3: vector},
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--case', default='w3-newton-b1-d1-s1-p1')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.frames == 60 and args.case.startswith('w3-') and '-b1-' in args.case
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    hook = ROOT / 'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    assert os.environ.get('LD_PRELOAD') == str(hook)
    assert os.environ.get('CUDAHOOK_DIR') == str(args.output)
    assert not os.environ.get('CUDAHOOK_DUMP'), 'Earlier scenes must not consume per-kernel dump ordinals'
    from .audit_cudahook import schemas, parameter_types
    layout = schemas()[0]
    for token, arguments in fields().items():
        matching = [schema for name, schema in layout.items() if token in name]
        assert matching, token
        for schema in matching:
            assert all(schema[i] == 'pointer' for i in arguments), (token, schema)
        for name in json.loads((ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_text())['kernels']:
            if token not in name:
                continue
            types = parameter_types(name)
            for i, size in arguments.items():
                if size == 36 * 12:
                    assert 'glm::vec<3,float,' in types[i].replace(' ', ''), (token, i, types[i])
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT / 'build/reconstruction-warp')
    from . import affine_surface_graph_ab as worker
    from . import host_api_probe, host_particles_ab
    loaders = []
    installed, target_id, selected, observed = False, None, 0, False
    saved_build = (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes()
    selection = {}

    def install(core):
        nonlocal installed
        if installed:
            return core
        installed = True
        if args.backend == 'source':
            from .host_bodies_ab import bridge
            bridge(core)
        from .affine_surface_scene import Example
        import style3d_sim as s3d
        original_init, original_step = Example.__init__, s3d.NewtonSolver.step

        def init(scene, viewer, options):
            nonlocal target_id, selected
            original_init(scene, viewer, options)
            name = (f'w{options.worlds}-{options.mode}-b{int(options.body_block)}'
                    f'-d{int(options.diagonal_only)}-s{int(options.self)}-p{int(options.springs)}')
            if name == args.case:
                selected += 1
                if selected == 1:
                    # Keep only an integer identity; retaining a scene or bound method would alter allocation lifetimes.
                    target_id = id(scene.solver)

        def step(solver, *values, **keywords):
            nonlocal observed
            if id(solver) != target_id or observed:
                return original_step(solver, *values, **keywords)
            observed = True
            assert selected == 1
            log = args.output / 'launches.txt'
            selection['first_log_line'] = len(log.read_text().splitlines()) if log.exists() else 0
            os.environ['CUDAHOOK_DUMP'] = ';'.join(
                token + '=' + ','.join(f'{i}:{size}' for i, size in arguments.items())
                for token, arguments in fields().items())
            os.environ['CUDAHOOK_DUMP_LIMIT'] = '15'
            try:
                return original_step(solver, *values, **keywords)
            finally:
                os.environ.pop('CUDAHOOK_DUMP', None)
                selection['last_log_line_exclusive'] = len(log.read_text().splitlines())

        Example.__init__, s3d.NewtonSolver.step = init, step
        return core

    for owner, name in ((host_api_probe, 'load_reference'), (host_particles_ab, 'native_source')):
        original = getattr(owner, name)

        def load(original=original):
            return install(original())

        loaders.append((owner, name, original))
        setattr(owner, name, load)
    args.worker = args.backend
    worker.worker(args)
    assert observed and selected == 2
    assert (ROOT / 'build/reconstruction-csrc/host-particles/build.json').read_bytes() == saved_build
    (args.output / 'probe.json').write_text(json.dumps({
        'case': args.case, 'graph': False, 'step': 0, 'selection': selection, 'fields': fields(),
        'full_worker_frames': args.frames, 'fixed_candidate_replaced': False,
        'observer_synchronizes': True, 'scene_lifetimes_intentionally_extended': False,
        'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'hook_sha256': hashlib.sha256(hook.read_bytes()).hexdigest(),
        'source_build': json.loads(saved_build), 'whole_solver_complete': False,
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
