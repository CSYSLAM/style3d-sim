"""Supplementary native joint cases: retain revolute/prismatic constraints and omit drive descriptors explicitly."""
from argparse import Namespace

import newton.examples
import style3d_sim as s3d
from style3d_sim import newton_solver as adapter

from reconstruction.csrc.joint_body_scene import Example as DrivenExample


class Example(DrivenExample):
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--joint-kind', choices=('revolute', 'prismatic'), required=True)
        parser.add_argument('--constraint-mode', choices=('al', 'penalty'), default='al')
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        assemble = adapter.NewtonSolver._assemble_joint_constraints

        def constraints_without_drive(solver, **options):
            assemble(solver, **options)
            # This fixture requests the native zero-drive branch; all generated joint geometry stays intact.
            solver._joint_drive_types = None

        adapter.NewtonSolver._assemble_joint_constraints = constraints_without_drive
        try:
            super().__init__(viewer, Namespace(joint_kind=args.joint_kind, worlds=args.worlds, seed=args.seed,
                                              armature=0., derive_velocity=False))
        finally:
            adapter.NewtonSolver._assemble_joint_constraints = assemble
        native = self.solver._synreal_model
        assert native.joint_drive_count == 0 and native.particle_state_count == 8 * args.worlds
        assert (native.joint_body_point_line_count if args.joint_kind == 'prismatic' else
                native.joint_body_spring_count) > 0
        self.solver.config.nonlinear_iterations = 3
        self.solver.config.linear_iterations = 5
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.joint_constraint_mode = (
            s3d.JointConstraintMode.AUGMENTED_LAGRANGIAN if args.constraint_mode == 'al' else
            s3d.JointConstraintMode.PENALTY)
