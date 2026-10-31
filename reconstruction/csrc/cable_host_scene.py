"""Small cable scene for serial original/source A/B: rotated rods, damping, copied worlds and penalty state."""
import os
from pathlib import Path

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
        parser.add_argument('--linear-beta', type=float, default=0.0)
        parser.add_argument('--angular-beta', type=float, default=0.0)
        parser.add_argument('--gamma', type=float, default=.93)
        parser.add_argument('--penalty-actions', action='store_true')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        self.args = args
        rng = np.random.default_rng(args.seed)
        template = s3d.ModelBuilder(gravity=(.12, -.17, -3.0))
        template.default_shape_cfg.has_shape_collision = False
        template.default_shape_cfg.has_particle_collision = False
        direction = wp.normalize(wp.vec3(*rng.uniform(.2, 1.0, 3)))
        points = newton.utils.create_straight_cable_points(
            start=wp.vec3(.1, -.2, 1.5), direction=direction, length=.6, num_segments=2)
        quats = newton.utils.create_parallel_transport_cable_quaternions(points)
        bodies, joints = template.add_rod(positions=points, quaternions=quats, radius=.035,
                                          stretch_stiffness=1200.0, bend_stiffness=30.0, twist_stiffness=22.0,
                                          bend_damping=.7, twist_damping=.4, body_frame_origin='com')
        template.body_mass[bodies[0]] = template.body_inv_mass[bodies[0]] = 0.0
        template.body_inertia[bodies[0]] = template.body_inv_inertia[bodies[0]] = wp.mat33(0.0)
        template.body_qd[bodies[1]] = tuple(rng.uniform(-.25, .25, 6))
        if args.worlds > 1:
            builder = s3d.ModelBuilder(gravity=(.12, -.17, -3.0))
            builder.replicate(template, args.worlds)
        else:
            builder = template
        self.model = builder.finalize(device='cuda:0')
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.nonlinear_solver = (s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd'
                                               else s3d.NonlinearSolver.NEWTON)
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.cable_linear_beta = args.linear_beta
        self.solver.config.cable_angular_beta = args.angular_beta
        self.solver.config.cable_penalty_gamma = args.gamma
        self.solver.config.cable_linear_k_start = 4.0
        self.solver.config.cable_angular_k_start = 2.0
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.step_index = 0
        self.penalties = {}

    def save_penalties(self, tag):
        native = self.solver._native_solver
        model = self.solver._synreal_model
        count = int(model.cable_count) * (int(model.particle_state_count) // int(model.particle_count))
        output = wp.full(count, wp.vec4(-123.0), dtype=wp.vec4, device='cuda:0')
        span = type(self.solver._synreal_model.cable_stiffnesses)
        native.copy_cable_penalties(span(output.ptr, count))
        self.penalties[tag] = output.numpy().copy()
        directory = os.environ.get('CABLE_PROBE_DIR')
        if directory:
            np.savez(Path(directory)/'penalties.npz', **self.penalties)

    def step(self):
        if self.args.penalty_actions:
            self.save_penalties(f'before-{self.step_index}')
            if self.step_index in (4, 9):
                self.solver._native_solver.reset_cable_penalty_state()
                self.save_penalties(f'reset-{self.step_index}')
            if self.step_index == 14:
                model = self.solver._synreal_model
                count = int(model.cable_count) * (int(model.particle_state_count) // int(model.particle_count))
                mask = wp.array((np.arange(count) % 2 == 0).astype('i4'), dtype=wp.int32, device='cuda:0')
                span = type(model.cable_stiffnesses)
                self.solver._native_solver.reset_cable_penalty_state(mask=span(mask.ptr, count))
                self.save_penalties('masked-reset')
            if self.step_index in (19, 24):
                enable = self.step_index == 24
                self.solver.config.cable_linear_beta = self.args.linear_beta if enable else 0.0
                self.solver.config.cable_angular_beta = self.args.angular_beta if enable else 0.0
                self.save_penalties('ramp-on' if enable else 'ramp-off')
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1.0 / 240.0)
        self.state_0, self.state_1 = self.state_1, self.state_0
        self.step_index += 1
