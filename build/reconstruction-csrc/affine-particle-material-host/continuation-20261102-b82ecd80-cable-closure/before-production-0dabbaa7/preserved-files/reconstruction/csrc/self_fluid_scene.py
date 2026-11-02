"""Enable self contacts on the frozen fluid scene to verify fluid group exclusion and scheduling."""
from reconstruction.csrc.fluid_host_scene import Example as BaseExample


class Example(BaseExample):
    @staticmethod
    def create_parser():
        parser = BaseExample.create_parser()
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.solver.config.enable_self_collision = True
        self.solver.config.self_collision_radius = .003
        self.solver.config.enable_collision_hessian_non_diagonal = not args.diagonal_only
