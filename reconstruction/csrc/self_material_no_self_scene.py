"""Scheduling control for the frozen self/material scene: use identical topology with self collisions disabled."""
from reconstruction.csrc.self_material_scene import Example as BaseExample


class Example(BaseExample):
    def __init__(self, viewer, args):
        super().__init__(viewer, args)
        self.solver.config.enable_self_collision = False
