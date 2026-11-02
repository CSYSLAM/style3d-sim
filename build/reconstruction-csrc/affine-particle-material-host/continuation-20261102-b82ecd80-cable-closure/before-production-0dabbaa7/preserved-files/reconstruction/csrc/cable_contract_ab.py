"""Compare lazy cable/config validation and size errors against the original, in serial workers."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

from reconstruction.csrc.demo_source_ab import ROOT


def worker(backend, output):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from reconstruction.csrc.host_api_probe import load_reference
        core = load_reference()
    else:
        from reconstruction.csrc.host_bodies_ab import bridge
        from reconstruction.csrc.host_particles_ab import native_source
        core = native_source()
        bridge(core)
    from reconstruction.csrc.cable_host_scene import Example
    from reconstruction.csrc.host_bodies_ab import build
    import style3d_sim as s3d
    result = {}
    cable_fields = ('cable_linear_beta', 'cable_angular_beta', 'cable_penalty_gamma',
                    'cable_linear_k_start', 'cable_angular_k_start')
    step_fields = ('constraint_alpha', 'rigid_contact_alpha', 'rigid_contact_gamma', 'rigid_contact_beta',
                   'rigid_contact_k_start', 'rigid_contact_friction_epsilon', 'joint_constraint_primal_iterations',
                   'affine_body_rigidity_primal_iterations', 'linear_iterations', 'nonlinear_iterations')
    for topology in ('cable', 'no-cable'):
        if topology == 'cable':
            example = Example(None, Example.create_parser().parse_args([]))
            solver, model, state0, state1, control = (example.solver, example.model, example.state_0,
                                                    example.state_1, example.control)
            count = 1
        else:
            model = build('free_body', 1)
            solver = s3d.NewtonSolver(model)
            state0, state1, control = model.state(), model.state(), model.control()
            count = 0
        native = solver._native_solver
        span = type(solver._synreal_model.cable_stiffnesses)
        data = wp.full(4, wp.vec4(-123.), dtype=wp.vec4, device='cuda:0')
        mask = wp.ones(4, dtype=wp.int32, device='cuda:0')
        calls = {'copy': lambda: native.copy_cable_penalties(span(data.ptr, count)),
                 'reset': lambda: native.reset_cable_penalty_state(),
                 'step': lambda: solver.step(state0, state1, control, None, 1/240)}

        def invoke(key, call):
            try:
                call()
                wp.synchronize()
                result[topology+'/'+key] = 'accepted'
            except (ValueError, RuntimeError) as error:
                result[topology+'/'+key] = [type(error).__name__, str(error)]

        for field in (*cable_fields, *step_fields):
            old = getattr(solver.config, field)
            values = (-1, 0, 1, 999, 1000) if isinstance(old, int) else (-1., 0., 1., 1.15, float('nan'), float('inf'))
            for value in values:
                setattr(solver.config, field, value)
                for operation in ('copy', 'reset', 'step'):
                    invoke(f'{field}/{value}/{operation}', calls[operation])
            setattr(solver.config, field, old)
        for size in (0, 1, 2, 3):
            invoke(f'copy-size/{size}', lambda: native.copy_cable_penalties(span(data.ptr, size)))
            invoke(f'reset-size/{size}', lambda: native.reset_cable_penalty_state(mask=span(mask.ptr, size)))
        solver.config.cable_penalty_gamma = 1.15
        solver.config.cable_linear_beta = -1.
        invoke('priority/gamma-ramp-copy', calls['copy'])
        invoke('priority/gamma-size-copy', lambda: native.copy_cable_penalties(span(data.ptr, 4)))
        invoke('priority/gamma-size-reset', lambda: native.reset_cable_penalty_state(mask=span(mask.ptr, 4)))
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
    output.write_text(json.dumps(result, indent=2)+'\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output)
    args.output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    for backend in ('original', 'source'):
        command = [sys.executable, '-m', 'reconstruction.csrc.cable_contract_ab', '--worker', backend,
                   '--output', str(args.output/(backend+'.json'))]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    original, source = [json.loads((args.output/(b+'.json')).read_text()) for b in ('original', 'source')]
    differences = {k: {'original': original.get(k), 'source': source.get(k)}
                   for k in original.keys() | source.keys() if original.get(k) != source.get(k)}
    report = {'checks': len(original), 'differences': differences}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))
    return bool(differences)


if __name__ == '__main__':
    sys.exit(main())
