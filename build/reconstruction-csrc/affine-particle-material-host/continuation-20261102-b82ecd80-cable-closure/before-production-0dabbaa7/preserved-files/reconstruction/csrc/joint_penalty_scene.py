"""Joint penalty-mode reference scene; existing driven and undriven fixtures remain frozen."""
import newton.examples
import style3d_sim as s3d
from reconstruction.csrc.joint_body_scene import Example as Driven
from reconstruction.csrc.undriven_joint_scene import Example as Undriven


class Example:
    @staticmethod
    def create_parser():
        parser = newton.examples.create_parser()
        parser.add_argument('--joint-kind', choices=('fixed', 'ball', 'revolute', 'prismatic'), required=True)
        parser.add_argument('--worlds', type=int, default=1)
        parser.add_argument('--seed', type=int, default=1)
        parser.add_argument('--mode', choices=('newton', 'pd'), default='newton')
        parser.add_argument('--body-block', action='store_true')
        return parser

    def __init__(self, viewer, args):
        base = Undriven if args.joint_kind in ('fixed', 'ball') else Driven
        extra = ['--joint-kind', args.joint_kind, '--worlds', str(args.worlds), '--seed', str(args.seed)]
        if base is Driven:
            extra.extend(['--armature', '.007', '--derive-velocity'])
        scene = base(viewer, base.create_parser().parse_args(extra))
        self.__dict__.update(scene.__dict__)
        mode = type(self.solver.config.joint_constraint_mode)
        self.solver.config.joint_constraint_mode = mode.PENALTY
        assert int(self.solver.config.joint_constraint_mode) == 0
        self.solver.config.nonlinear_solver = (
            s3d.NonlinearSolver.PD_NEWTON if args.mode == 'pd' else s3d.NonlinearSolver.NEWTON)
        self.solver.config.affine_body_block_preconditioner = args.body_block
        self.solver.config.nonlinear_iterations, self.solver.config.linear_iterations = 3, 5

    def step(self):
        self.state_0.clear_forces()
        self.solver.step(self.state_0, self.state_1, self.control, None, self.sim_dt)
        self.state_0, self.state_1 = self.state_1, self.state_0
