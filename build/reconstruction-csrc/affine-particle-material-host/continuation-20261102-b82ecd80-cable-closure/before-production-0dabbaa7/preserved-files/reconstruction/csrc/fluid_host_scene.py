"""Small native-fluid scenes for host recovery: uncoupled/cached/fallback rows, boundaries and contact coupling."""
import itertools

import newton
import newton.examples
import numpy as np
import warp as wp

import style3d_sim as s3d


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--layout', choices=('isolated', 'cached', 'fallback'), default='cached')
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--boundaries', action='store_true')
        parser.add_argument('--contacts', action='store_true')
        parser.add_argument('--body', action='store_true')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--viscosity', type=float, default=.02)
        parser.add_argument('--relaxation', type=float, default=.5)
        parser.add_argument('--step-ratio', type=float, default=.25)
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        if args.layout == 'isolated':
            positions = np.asarray([[.2, .2, .2]], dtype='f4')
        else:
            width, spacing = (2, .045) if args.layout == 'cached' else (5, .012)
            positions = np.asarray(list(itertools.product(range(width), repeat=3)), dtype='f4') * spacing + .2
            positions += rng.uniform(-.001, .001, positions.shape).astype('f4')
        velocities = rng.uniform(-.05, .05, positions.shape).astype('f4')
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        template.add_particles(pos=positions, vel=velocities, mass=np.full(len(positions), .45),
                               radius=np.full(len(positions), .015))
        if args.contacts:
            template.add_shape_plane(xform=wp.transform(wp.vec3(0., 0., .18), wp.quat_identity()),
                                     cfg=newton.ModelBuilder.ShapeConfig(ke=1500., kd=5.))
        if args.body:
            body = template.add_body(xform=wp.transform(wp.vec3(.27, .22, .23), wp.quat_identity()), mass=0.)
            template.add_shape_sphere(body, radius=.045, cfg=newton.ModelBuilder.ShapeConfig(density=900., ke=1500.))
            template.body_qd[-1] = (.1, -.05, -.2, .2, .1, -.1)
        if args.worlds > 1:
            builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        boundary = np.asarray([[x, y, .17] for x, y in itertools.product((.19, .24), repeat=2)], dtype='f4')
        s3d.configure_fluid(self.model, np.arange(self.model.particle_count, dtype='i4'),
                            smoothing_radius=.13, bulk_modulus=1200., viscosity=args.viscosity,
                            boundary_positions=boundary if args.boundaries else None,
                            boundary_volumes=np.full(len(boundary), .0003) if args.boundaries else None)
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations = 3
        config.linear_iterations = 5
        config.fluid_relaxation = args.relaxation
        config.fluid_max_step_ratio = args.step_ratio
        config.affine_body_block_preconditioner = args.body_block
        self.pipeline = newton.CollisionPipeline(self.model) if args.contacts or args.body else None
        self.contacts = self.model.contacts(self.pipeline) if self.pipeline else None
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        if self.pipeline:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
