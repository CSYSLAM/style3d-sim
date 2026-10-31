"""Real contacts around the original 32-block soft-product launch limit."""
import newton

from reconstruction.csrc.fluid_host_scene import Example as FluidExample


class Example(FluidExample):
    @staticmethod
    def create_parser():
        parser = FluidExample.create_parser()
        parser.add_argument('--capacity', type=int, default=8193)
        parser.set_defaults(contacts=True, body=True)
        return parser

    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.pipeline = newton.CollisionPipeline(self.model, soft_contact_max=args.capacity)
        self.contacts = self.model.contacts(self.pipeline)
