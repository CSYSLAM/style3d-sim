"""Plain body spring/line/distance constraints exchanging real ground contact and rolling forces."""
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
        builder = s3d.ModelBuilder(gravity=(.15, -.23, -9.81), affine_body_particle_radius=0.)
        for _ in range(args.worlds):
            builder.begin_world()
            rng = np.random.default_rng(args.seed)
            cfg = builder.default_shape_cfg.copy()
            cfg.density = 350.
            cfg.has_shape_collision, cfg.has_particle_collision = True, False
            cfg.mu_rolling, cfg.mu_torsional = .017, .011
            first = builder.add_body(xform=wp.transform(wp.vec3(.2, -.1, .11), wp.quat_rpy(.2, -.1, .3)))
            second = builder.add_body(xform=wp.transform(wp.vec3(-.1, .05, .17), wp.quat_rpy(-.15, .2, -.1)))
            for body in (first, second):
                center = rng.uniform(-.08, .08, 3)
                builder.add_shape_box(body, hx=.17, hy=.09, hz=.13, cfg=cfg,
                                      xform=wp.transform(wp.vec3(*center), wp.quat_identity()))
            builder.body_qd[first] = (.1, -.05, -.4, .2, .1, -.1)
            builder.body_qd[second] = (-.13, .08, .12, -.1, .3, .2)
            point = wp.vec3(-.11, .04, -.08)
            other = wp.vec3(.12, -.06, .1)
            if args.constraint == 'spring':
                builder.add_body_spring(second, first, point, other, stiffness=45.125, rest_length=.13)
            elif args.constraint == 'point-line':
                builder.add_body_point_line(second, first, point, wp.vec3(-.15, -.07, .03),
                                            wp.vec3(.2, .09, .07), stiffness=45.125, damping=0.)
            else:
                builder.add_body_distance_constraint(second, first, point, other, rest_length=.13)
            builder.end_world()
        ground = builder.default_shape_cfg.copy()
        ground.has_shape_collision, ground.has_particle_collision = True, False
        ground.mu_rolling, ground.mu_torsional = .017, .011
        builder.add_ground_plane(cfg=ground)
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        field = {'spring': 'body_spring_count', 'point-line': 'body_point_line_count',
                 'distance': 'body_distance_constraint_count'}[args.constraint]
        native = self.solver._synreal_model
        assert native.particle_state_count == 8 * args.worlds
        assert getattr(native, field) * (native.particle_state_count // native.particle_count) == args.worlds
        self.solver.config.nonlinear_iterations, self.solver.config.linear_iterations = 3, 5
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.solver.config.rigid_contact_hard = False
        self.pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.pipeline.contacts()
        self.steps = 0

    def step(self):
        self.state_0.clear_forces()
        self.pipeline.collide(self.state_0, self.contacts)
        if self.steps == 0:
            count = int(self.contacts.rigid_contact_count.numpy()[0])
            assert count > 0, 'This fixture requires actual box/ground contacts'
            print('plain_body_contact_layout', {'rigid_count': count}, flush=True)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1 / 240)
        self.steps += 1
        self.state_0, self.state_1 = self.state_1, self.state_0
