"""Control for the same affine/free-particle fixture with self contacts disabled after construction."""
from reconstruction.csrc.self_affine_scene import Example as BaseExample


class Example(BaseExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.solver.config.enable_self_collision = False
