"""Short inclined cable touching a plane, for cable/contact host-order captures and serial A/B."""
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
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--hard', action='store_true')
        parser.add_argument('--history', action='store_true')
        parser.add_argument('--reuse', action='store_true')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--no-contact-block', action='store_true')
        parser.add_argument('--grow-contacts', action='store_true')
        return parser

    def __init__(self, viewer, args):
        self.args = args
        rng = np.random.default_rng(args.seed)
        template = s3d.ModelBuilder(gravity=(.12, -.17, -3.))
        template.add_ground_plane(cfg=newton.ModelBuilder.ShapeConfig(ke=1500., mu_rolling=.01, mu_torsional=.01))
        direction = wp.normalize(wp.vec3(1., .2, -.15))
        points = newton.utils.create_straight_cable_points(
            start=wp.vec3(.1, -.2, .06), direction=direction, length=.6, num_segments=2)
        quats = newton.utils.create_parallel_transport_cable_quaternions(points)
        bodies, _ = template.add_rod(positions=points, quaternions=quats, radius=.035,
                                    stretch_stiffness=1200., bend_stiffness=30., twist_stiffness=22.,
                                    bend_damping=.7, twist_damping=.4, body_frame_origin='com')
        template.body_mass[bodies[0]] = template.body_inv_mass[bodies[0]] = 0.
        template.body_inertia[bodies[0]] = template.body_inv_inertia[bodies[0]] = wp.mat33(0.)
        template.body_qd[bodies[1]] = tuple(rng.uniform(-.1, .1, 6))
        if args.worlds > 1:
            builder = s3d.ModelBuilder(gravity=(.12, -.17, -3.))
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations = 3
        config.linear_iterations = 5
        config.cable_linear_beta = config.cable_angular_beta = 150.
        config.cable_linear_k_start = 4.
        config.cable_angular_k_start = 2.
        config.cable_penalty_gamma = .93
        config.rigid_contact_hard = args.hard
        config.rigid_contact_history = args.history
        config.rigid_contact_sliding_tangent = True
        config.rigid_contact_beta = 500.
        config.rigid_contact_k_start = 50.
        config.affine_body_block_preconditioner = args.body_block
        config.affine_body_contact_block_preconditioner = not args.no_contact_block
        self.pipeline = newton.CollisionPipeline(self.model, contact_matching='latest' if args.history else 'disabled')
        self.contacts = self.model.contacts(self.pipeline)
        self.solver.prepare_contacts(self.contacts)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.step_index = 0

    def step(self):
        if self.args.grow_contacts and self.step_index == 14:
            self.solver._native_solver.reserve_rigid_contact_capacity(5000)
        self.state_0.clear_forces()
        refresh = not self.args.reuse or self.step_index % 3 == 0
        if refresh:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.set_rigid_history_update(refresh)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1/240)
        self.state_0, self.state_1 = self.state_1, self.state_0
        self.step_index += 1
