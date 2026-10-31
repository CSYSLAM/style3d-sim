"""Real authored bonds with independently configured cohesion, including disabled cohesion and active adhesion."""
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
        parser.add_argument('--bonds', choices=('none', 'authored', 'dynamic', 'mixed'), default='none')
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--contacts', action='store_true')
        parser.add_argument('--subset', action='store_true')
        parser.add_argument('--bond-damping', type=float, default=3.)
        parser.add_argument('--dynamic-capacity', type=int, default=3)
        parser.add_argument('--cohesion', type=float, default=0.)
        parser.add_argument('--reverse-authored', action='store_true')
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        width, spacing = (4, .008) if args.layout == 'fallback' else (2, .04)
        points = np.asarray(list(itertools.product(range(width), repeat=3)), dtype='f4')*spacing+.2
        if args.layout == 'isolated':
            points *= 4.
        points += rng.uniform(-.001, .001, points.shape).astype('f4')
        velocities = rng.uniform(-.2, .2, points.shape).astype('f4')
        template = newton.ModelBuilder(gravity=(.125, -.25, -9.81))
        template.add_particles(pos=points, vel=velocities, mass=np.full(len(points), .45),
                               radius=np.full(len(points), .025))
        if args.contacts:
            template.add_shape_plane(xform=wp.transform(wp.vec3(0., 0., .18), wp.quat_identity()),
                                     cfg=newton.ModelBuilder.ShapeConfig(ke=1500., kd=5.))
        builder = newton.ModelBuilder(gravity=(.125, -.25, -9.81)) if args.worlds > 1 else template
        if args.worlds > 1:
            builder.replicate(template, args.worlds)
        self.model = builder.finalize(device='cuda:0')
        authored = args.bonds in ('authored', 'mixed')
        local_selection = np.arange(0, len(points), 2 if args.subset else 1, dtype='i4')
        selection = np.concatenate([local_selection+w*len(points) for w in range(args.worlds)])
        pairs = np.asarray([(w*len(points)+local_selection[a], w*len(points)+local_selection[b])
                            for w in range(args.worlds)
                            for a, b in ((0, 1), (1, 2))], dtype='i4')
        if args.reverse_authored:
            pairs = np.ascontiguousarray(pairs[:, ::-1])
        s3d.configure_granular(self.model, selection,
                               contact_stiffness=1200., friction=.4, friction_damping=12.,
                               cohesion=args.cohesion if authored else 0., bond_damping=args.bond_damping,
                               yield_strain=.03, max_compaction=.3, break_strain=.08,
                               bond_indices=pairs if authored else np.empty((0, 2), dtype='i4'),
                               adhesion=500. if args.bonds in ('dynamic', 'mixed') else 0.,
                               bond_formation_gap=.005, bond_formation_speed=1.,
                               max_dynamic_bonds=args.dynamic_capacity)
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations, config.linear_iterations = 3, 5
        self.pipeline = newton.CollisionPipeline(self.model) if args.contacts else None
        self.contacts = self.model.contacts(self.pipeline) if self.pipeline else None
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        if self.pipeline:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
