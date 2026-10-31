"""Self contacts between fluid and an unbound particle, alongside disjoint frozen material topology."""
import numpy as np

from reconstruction.csrc.fluid_material_scene import Example as BaseExample


class Example(BaseExample):
    @staticmethod
    def create_parser():
        parser = BaseExample.create_parser()
        parser.add_argument('--diagonal-only', action='store_true')
        return parser

    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        local = self.model.particle_count//args.worlds
        assert local in (16, 20)
        # Particle 15 is outside the frozen material stencils. Displace only its initial state near fluid 7;
        # its model rest pose and every material coefficient remain the authored values.
        points = self.state_0.particle_q.numpy()
        for world in range(args.worlds):
            points[world*local+15] = points[world*local+7]+np.asarray([.007, .003, .002], dtype='f4')
        self.state_0.particle_q.assign(points)
        self.state_1.particle_q.assign(points)
        self.solver.config.enable_self_collision = True
        self.solver.config.self_collision_radius = .003
        self.solver.config.enable_collision_hessian_non_diagonal = not args.diagonal_only
