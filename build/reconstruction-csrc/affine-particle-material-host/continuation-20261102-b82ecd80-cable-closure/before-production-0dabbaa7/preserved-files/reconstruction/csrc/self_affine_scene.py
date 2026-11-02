"""Affine body and disjoint free-particle self contacts share the original Solver's PCG system."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--diagonal-only', action='store_true')
        parser.add_argument('--ground', action='store_true')
        return parser

    def __init__(self, viewer, args):
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        if args.ground:
            template.add_ground_plane()
        height = .16 if args.ground else 1.5
        body = template.add_body(xform=wp.transform(wp.vec3(.05, -.02, height), wp.quat_rpy(.25, -.15, .3)),
                                 mass=0.)
        template.add_shape_box(body, hx=.2, hy=.15, hz=.1,
                               cfg=newton.ModelBuilder.ShapeConfig(density=750, mu_rolling=0., mu_torsional=0.))
        template.body_qd[-1] = (.1, -.05, -.4, .2, .1, -.1)
        points = np.asarray([[1., .2, .5], [1.04, .2, .5], [1.3, .2, .5], [1.34, .2, .5]], dtype='f4')
        velocities = np.random.default_rng(17).uniform(-.025, .025, points.shape).astype('f4')
        template.add_particles(pos=points, vel=velocities, mass=np.full(4, 1.5), radius=np.full(4, .025))
        builder = template
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.enable_self_collision = True
        config.self_collision_radius = .003
        config.self_collision_particle_particle_stiffness = 1.
        config.enable_collision_hessian_non_diagonal = not args.diagonal_only
        config.affine_body_block_preconditioner = args.body_block
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.pipeline = newton.CollisionPipeline(self.model) if args.ground else None
        self.contacts = self.pipeline.contacts() if self.pipeline else None

    def step(self):
        self.state_0.clear_forces()
        if self.pipeline:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
