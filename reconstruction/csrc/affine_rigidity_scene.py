"""Affine rigidity alternatives for recovering the original constitutive/six-spring host branches."""
import newton
import newton.examples

import style3d_sim as s3d
from reconstruction.csrc.host_bodies_ab import build


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--rigidity', choices=('so3', 'springs', 'corotated', 'abd'), default='so3')
        parser.add_argument('--body-block', action='store_true')
        parser.add_argument('--alpha', type=float, default=100.)
        return parser

    def __init__(self, viewer, args):
        self.model = build('two_bodies', args.worlds)
        self.solver = s3d.NewtonSolver(self.model)
        config = self.solver.config
        config.affine_body_rigidity_model = {'so3': s3d.AffineBodyRigidityModel.SO3_AUGMENTED_LAGRANGIAN,
                                            'springs': s3d.AffineBodyRigidityModel.SIX_SPRINGS,
                                            'corotated': s3d.AffineBodyRigidityModel.CO_ROTATED,
                                            'abd': s3d.AffineBodyRigidityModel.ABD_ORTHOGONALITY}[args.rigidity]
        config.affine_body_block_preconditioner = args.body_block
        config.constraint_alpha = args.alpha
        config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON
        config.nonlinear_iterations = 3
        config.linear_iterations = 5
        self.state_0, self.state_1 = self.model.state(), self.model.state()
        self.control = self.model.control()

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, 1/120)
        self.state_0, self.state_1 = self.state_1, self.state_0
