"""Two moving offset-COM bodies with one plain constraint; reverse attachment order to expose template rounding."""
import newton
import newton.examples
import numpy as np
import style3d_sim as s3d
import warp as wp


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--constraint', choices=('spring', 'point-line', 'distance'), required=True)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        rng = np.random.default_rng(args.seed)
        template = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.)
        cfg = template.default_shape_cfg.copy()
        cfg.density = 350.
        cfg.has_shape_collision = cfg.has_particle_collision = False
        first = template.add_body(xform=wp.transform(wp.vec3(.2, -.1, 1.5), wp.quat_rpy(.2, -.1, .3)))
        second = template.add_body(xform=wp.transform(wp.vec3(-.1, .05, 1.35), wp.quat_rpy(-.15, .2, -.1)))
        for body in (first, second):
            center = rng.uniform(-.08, .08, 3)
            template.add_shape_box(body, hx=.17, hy=.09, hz=.13, cfg=cfg,
                                   xform=wp.transform(wp.vec3(*center), wp.quat_identity()))
        template.body_qd[first] = (.1, -.05, -.4, .2, .1, -.1)
        template.body_qd[second] = (-.13, .08, .12, -.1, .3, .2)
        point = wp.vec3(-.11, .04, -.08)
        other = wp.vec3(.12, -.06, .1)
        if args.constraint == 'spring':
            template.add_body_spring(second, first, point, other, stiffness=45.125, rest_length=.13)
        elif args.constraint == 'point-line':
            template.add_body_point_line(second, first, point, wp.vec3(-.15, -.07, .03),
                                         wp.vec3(.2, .09, .07), stiffness=45.125, damping=0.)
        else:
            template.add_body_distance_constraint(second, first, point, other, rest_length=.13)
        if args.worlds > 1:
            builder = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.)
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_iterations, self.solver.config.linear_iterations = 3, 5
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1 / 240)
        self.state_0, self.state_1 = self.state_1, self.state_0
