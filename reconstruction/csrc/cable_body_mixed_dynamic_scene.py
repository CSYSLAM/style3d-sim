"""Exercise a cable and two plain constraints between two moving bodies, in explicit worlds."""
import newton
import newton.examples
import numpy as np
import warp as wp

import style3d_sim as s3d


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--constraint', choices=('spring-distance', 'point-line-distance'), required=True)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        builder = s3d.ModelBuilder(gravity=(.12, -.17, -3.0), affine_body_particle_radius=0.)
        builder.default_shape_cfg.has_shape_collision = False
        builder.default_shape_cfg.has_particle_collision = False
        # Construct each world's custom constraints explicitly; base replicate omits these authored lists.
        for _ in range(args.worlds):
            builder.begin_world()
            rng = np.random.default_rng(args.seed)
            direction = wp.normalize(wp.vec3(*rng.uniform(.2, 1.0, 3)))
            points = newton.utils.create_straight_cable_points(
                start=wp.vec3(.1, -.2, 1.5), direction=direction, length=.6, num_segments=2)
            quats = newton.utils.create_parallel_transport_cable_quaternions(points)
            bodies, _ = builder.add_rod(positions=points, quaternions=quats, radius=.035,
                                       stretch_stiffness=1200., bend_stiffness=30., twist_stiffness=22.,
                                       bend_damping=.7, twist_damping=.4, body_frame_origin='com')
            builder.body_qd[bodies[0]] = (.13, -.09, .05, -.12, .08, .17)
            builder.body_qd[bodies[1]] = tuple(rng.uniform(-.25, .25, 6))
            # Both constraint endpoints and cable segments remain dynamic.
            point = wp.vec3(-.07, .03, .05)
            anchor = wp.vec3(.06, -.04, -.09)
            if args.constraint == 'spring-distance':
                builder.add_body_spring(bodies[1], bodies[0], point, anchor, stiffness=45.125, rest_length=.13)
            elif args.constraint == 'point-line-distance':
                builder.add_body_point_line(bodies[1], bodies[0], point, anchor, wp.vec3(.13, .05, .08),
                                            stiffness=45.125, damping=0.)
            builder.add_body_distance_constraint(bodies[1], bodies[0], point, anchor, rest_length=.13)
            builder.end_world()
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1. / 240.)
        self.state_0, self.state_1 = self.state_1, self.state_0
