"""Actual driven-joint body-block route; preserve the previously frozen PD fixture unchanged."""
import style3d_sim as s3d

from reconstruction.csrc.joint_body_scene import Example as JointExample


class Example(JointExample):
    @staticmethod
    def create_parser():
        parser = JointExample.create_parser()
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        return parser

    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.solver.config.affine_body_block_preconditioner = True
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
