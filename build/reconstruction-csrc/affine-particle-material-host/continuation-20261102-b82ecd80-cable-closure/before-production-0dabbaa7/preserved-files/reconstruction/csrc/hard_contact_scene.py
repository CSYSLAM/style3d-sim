"""Supplementary hard-contact scene: tilted moving box, rolling/sliding friction, optional history and query reuse."""
import newton
import newton.examples
import warp as wp

import style3d_sim as s3d
from reconstruction.csrc.host_bodies_ab import build


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--history', action='store_true')
        parser.add_argument('--reuse', action='store_true')
        parser.add_argument('--sliding', action='store_true')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--beta', type=float, default=0.0)
        return parser

    def __init__(self, viewer, args):
        self.args = args
        self.model = build('ground_box', args.worlds)
        self.solver = s3d.NewtonSolver(self.model)
        self.solver.config.rigid_contact_hard = True
        self.solver.config.rigid_contact_history = args.history
        self.solver.config.rigid_contact_sliding_tangent = args.sliding
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.rigid_contact_alpha = .91
        self.solver.config.rigid_contact_beta = args.beta
        self.solver.config.rigid_contact_gamma = .97
        self.solver.config.rigid_contact_k_start = 50.0
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.solver.config.nonlinear_solver = (s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd'
                                               else s3d.NonlinearSolver.NEWTON)
        self.pipeline = newton.CollisionPipeline(self.model, contact_matching='latest' if args.history else 'disabled')
        self.contacts = self.model.contacts(self.pipeline)
        self.solver.prepare_contacts(self.contacts)
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()
        self.step_index = 0

    def step(self):
        self.state_0.clear_forces()
        refresh = not self.args.reuse or self.step_index % 3 == 0
        if refresh:
            self.pipeline.collide(self.state_0, self.contacts)
        self.solver.set_rigid_history_update(refresh)
        self.solver.step(self.state_0, self.state_1, self.control, self.contacts, 1.0 / 120.0)
        self.state_0, self.state_1 = self.state_1, self.state_0
        self.step_index += 1
