"""Broader granular/affine layouts with actual Newton material remapping across multiple worlds."""
import itertools
import os
from pathlib import Path

import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, choices=(1, 3), default=1)
        parser.add_argument('--bodies', type=int, choices=(1, 2), default=1)
        parser.add_argument('--width', type=int, choices=(2, 3), default=2)
        parser.add_argument('--subset', action='store_true')
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        for i in range(args.bodies):
            body = template.add_body(xform=wp.transform(wp.vec3(.7 + .6 * i, -.1, 1.5 + .2 * i),
                                                       wp.quat_rpy(.25, -.15, .3)), mass=0.)
            template.add_shape_box(body, hx=.2, hy=.15, hz=.1,
                                   cfg=newton.ModelBuilder.ShapeConfig(density=750., mu_rolling=0., mu_torsional=0.))
            template.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        points = np.asarray(list(itertools.product(range(args.width), repeat=3)), dtype='f4')
        points = points * np.float32(.04) + np.float32(.2)
        rng = np.random.default_rng(17)
        points += rng.uniform(-.001, .001, points.shape).astype('f4')
        velocities = rng.uniform(-.2, .2, points.shape).astype('f4')
        n = len(points)
        template.add_particles(pos=points, vel=velocities, mass=np.full(n, .45), radius=np.full(n, .025))
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        selected = np.concatenate([np.arange(n, dtype='i4')[::2 if args.subset else 1] + w * n
                                   for w in range(args.worlds)])
        # The public wrapper remaps these global Newton indices when it inserts affine proxies per world.
        s3d.configure_granular(self.model, selected, contact_stiffness=1200., friction=.4, friction_damping=12.,
                               cohesion=0., bond_damping=3., yield_strain=.03, max_compaction=.3, break_strain=.08,
                               bond_indices=np.empty((0, 2), dtype='i4'), adhesion=0., bond_formation_gap=.005,
                               bond_formation_speed=1., max_dynamic_bonds=3)
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        config.affine_body_block_preconditioner = args.body_block
        config.enable_self_collision = False
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        output = os.environ.get('GRANULAR_AFFINE_MODEL_OUTPUT')
        if output:
            path = Path(output) / 'actual-layout.npz'
            assert not path.exists()
            np.savez_compressed(path, particle_q=self.model.particle_q.numpy(), particle_qd=self.model.particle_qd.numpy(),
                                particle_world=self.model.particle_world.numpy(),
                                particle_mass=self.model.particle_mass.numpy(),
                                particle_radius=self.model.particle_radius.numpy(),
                                granular_indices=self.model.synreal_granular_particle_indices.numpy(),
                                body_indices=self.solver._affine_body_indices.numpy(),
                                body_world=self.model.body_world.numpy(),
                                body_q=self.model.body_q.numpy(), body_qd=self.model.body_qd.numpy())

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1 / 240)
        self.state_0, self.state_1 = self.state_1, self.state_0
