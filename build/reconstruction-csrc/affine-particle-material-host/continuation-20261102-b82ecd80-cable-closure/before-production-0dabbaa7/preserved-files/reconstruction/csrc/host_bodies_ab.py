"""Bitwise A/B of affine-body scenes through the unchanged official style3d_sim Newton adapter.

    .venv/bin/python -m reconstruction.csrc.host_bodies_ab --scene free_body --steps 3

Runs the processed original (project-internal 64a0be7f reference, no login) and the compiled source module in
separate, strictly serialised worker processes on the same scene, records particle_q/qd (the affine-body proxy
particles) and body_q/qd after every step, and compares them bit for bit. Exits 1 on any difference.
"""
import argparse
import json
import subprocess
import sys
import types
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT/'build/reconstruction-csrc/host-bodies'
SCENES = ('free_body', 'two_bodies', 'ground_box', 'ground_box_smooth')
FIELDS = ('particle_q', 'particle_qd', 'body_q', 'body_qd')


def build(scene, worlds):
    import newton
    import warp as wp

    def world(builder):
        if scene in ('ground_box', 'ground_box_smooth'):
            # A tilted box just above the ground: one corner reaches the plane within the first steps. The smooth
            # variant clears rolling/torsional friction to observe when the original launches the rolling kernels.
            smooth = dict(mu_rolling=0.0, mu_torsional=0.0) if scene == 'ground_box_smooth' else {}
            builder.add_ground_plane(cfg=newton.ModelBuilder.ShapeConfig(**smooth))
            body = builder.add_body(xform=wp.transform(wp.vec3(.05, -.02, .16), wp.quat_rpy(.25, -.15, .3)), mass=0.0)
            builder.add_shape_box(body, hx=.2, hy=.15, hz=.1, cfg=newton.ModelBuilder.ShapeConfig(density=750, **smooth))
            builder.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        if scene in ('free_body', 'two_bodies'):
            body = builder.add_body(xform=wp.transform(wp.vec3(.1, .2, 1.5), wp.quat_rpy(.3, -.2, .1)), mass=0.0)
            builder.add_shape_box(body, hx=.2, hy=.15, hz=.1, cfg=newton.ModelBuilder.ShapeConfig(density=750))
            builder.body_qd[-1] = (.2, -.1, .05, .3, .1, -.2)
        if scene == 'two_bodies':
            body = builder.add_body(xform=wp.transform(wp.vec3(-.4, .1, 1.2), wp.quat_rpy(-.1, .25, .4)), mass=0.0)
            builder.add_shape_sphere(body, radius=.12, cfg=newton.ModelBuilder.ShapeConfig(density=500))
            builder.body_qd[-1] = (-.1, .05, .2, -.4, .3, .15)

    builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
    if worlds > 1:
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        world(template)
        builder.replicate(template, worlds)
    else:
        world(builder)
    return builder.finalize(device='cuda:0')


def bridge(core):
    """Expose the source module as style3d_sim._core; it neither reads credentials nor calls proprietary code."""
    adapter = types.ModuleType('style3d_sim._core')
    for name in dir(core):
        if not name.startswith('__'):
            setattr(adapter, name, getattr(core, name))
    adapter.is_logged_in = lambda: True

    def no_login(*args, **kwargs):
        raise RuntimeError('The source solver does not use login')

    adapter.login = no_login
    sys.modules['style3d_sim._core'] = adapter


def simulate(scene, worlds, mode, steps):
    """Shared by the A/B workers and body_capture.py so that captures and comparisons run the same scene."""
    import newton
    import style3d_sim as s3d
    import warp as wp
    model = build(scene, worlds)
    solver = s3d.NewtonSolver(model)
    solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if mode == 'pd' else s3d.NonlinearSolver.NEWTON
    pipeline = contacts = None
    if scene.startswith('ground_box'):
        pipeline = newton.CollisionPipeline(model)
        contacts = model.contacts(pipeline)
        simulate.last_contacts = contacts   # diagnostic access for body_capture.py
    state0, state1 = model.state(), model.state()
    control = model.control()
    records = {}
    for step in range(steps):
        state0.clear_forces()
        if pipeline is not None:
            pipeline.collide(state0, contacts)
        solver.step(state0, state1, control, contacts, 1 / 120)
        state0, state1 = state1, state0
        wp.synchronize()
        for name in FIELDS:
            array = getattr(state0, name, None)
            if array is not None and array.shape[0]:
                records[f'{name}/{step}'] = array.numpy().copy()
        if contacts is not None:
            records[f'rigid_contact_count/{step}'] = contacts.rigid_contact_count.numpy().copy()
    return solver, records


def worker(args):
    import warp as wp
    wp.init()
    if args.worker == 'legacy':
        from .host_api_probe import load_reference
        core = load_reference()
        sys.modules['style3d_sim._core'] = core
    else:
        from .host_particles_ab import native_source
        core = native_source()
        assert core.source_only
        bridge(core)
    import style3d_sim as s3d
    assert s3d.Solver is core.Solver
    solver, records = simulate(args.scene, args.worlds, args.mode, args.steps)
    target = Path(args.output)/args.worker
    np.savez(target.with_suffix('.npz'), **records)
    if args.worker == 'source':
        inner = getattr(solver, '_native_solver', None)
        counts = dict(inner.source_launch_counts) if inner is not None and hasattr(inner, 'source_launch_counts') else {}
        target.with_suffix('.launches.json').write_text(json.dumps(counts, indent=1)+'\n')
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text(), 'original solver mapped in source worker'
    print(f'{args.worker}_complete', len(records), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--scene', default='free_body', choices=SCENES)
    parser.add_argument('--mode', default='newton', choices=('newton', 'pd'))
    parser.add_argument('--worlds', type=int, default=1)
    parser.add_argument('--steps', type=int, default=3)
    parser.add_argument('--worker', choices=('legacy', 'source'))
    parser.add_argument('--output')
    args = parser.parse_args()
    if args.worker:
        return worker(args)
    out = Path(args.output) if args.output else OUT/f'{args.scene}-{args.mode}-w{args.worlds}'
    out.mkdir(parents=True, exist_ok=True)
    for name in ('legacy', 'source'):     # strictly serialised: never two solver processes at once
        command = [sys.executable, '-m', 'reconstruction.csrc.host_bodies_ab', '--worker', name, '--output', str(out),
                   '--scene', args.scene, '--mode', args.mode, '--worlds', str(args.worlds), '--steps', str(args.steps)]
        with (out/f'{name}.log').open('w') as log:
            subprocess.run(command, cwd=ROOT, check=True, stdout=log, stderr=subprocess.STDOUT,
                           env={k: v for k, v in __import__('os').environ.items()
                                if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')})
    legacy, source = np.load(out/'legacy.npz'), np.load(out/'source.npz')
    failures = {}
    for name in sorted(set(legacy.files) | set(source.files)):
        if name not in legacy.files or name not in source.files:
            failures[name] = 'missing'
            continue
        a, b = legacy[name], source[name]
        if a.shape != b.shape or not np.array_equal(a.view('u4'), b.view('u4')):
            diff = np.abs(a.astype(np.float64)-b.astype(np.float64)) if a.shape == b.shape else None
            failures[name] = 'shape' if diff is None else float(np.nanmax(diff))
    report = {'scene': args.scene, 'mode': args.mode, 'worlds': args.worlds, 'steps': args.steps,
              'arrays': len(legacy.files), 'failures': failures}
    (out/'comparison.json').write_text(json.dumps(report, indent=1)+'\n')
    print(('PASS' if not failures else 'FAIL'), json.dumps(report))
    return 1 if failures else 0


if __name__ == '__main__':
    sys.exit(main())
