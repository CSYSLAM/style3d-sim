"""Drive real accepted steps into granular plasticity, fracture and contact-bond formation."""
import numpy as np

from reconstruction.csrc.granular_host_scene import Example as GranularExample


class Example(GranularExample):
    @staticmethod
    def create_parser():
        parser = GranularExample.create_parser()
        parser.add_argument('--history-case', choices=('plastic', 'break', 'form'), default='plastic')
        return parser

    def __init__(self, viewer, args):
        if args.worlds != 1 or args.layout != 'cached' or args.subset:
            raise ValueError('This history fixture uses the single-world, full cached selection')
        args.bonds = 'dynamic' if args.history_case == 'form' else 'authored'
        super().__init__(viewer, args)
        positions = self.state_0.particle_q.numpy()
        velocity = np.zeros_like(positions)
        if args.history_case != 'form':
            first, second = self.model.synreal_granular_bond_indices.numpy()[0]
            direction = positions[second]-positions[first]
            direction /= np.linalg.norm(direction)
            sign = 1. if args.history_case == 'plastic' else -1.
            velocity[first], velocity[second] = direction*sign, -direction*sign
        self.state_0.particle_qd.assign(velocity)
        self.state_1.particle_qd.assign(velocity)
