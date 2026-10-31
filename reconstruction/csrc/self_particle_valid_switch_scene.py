"""Positive stiffness switching for trajectories; invalid factors remain in the separate contract probe."""
from reconstruction.csrc.self_particle_variants import Example as BaseExample


class Example(BaseExample):
    def configure(self):
        if self.args.switch == 'stiffness':
            self.solver.config.self_collision_particle_particle_stiffness = (1., 0., .5, 2.)[self.steps % 4]
        else:
            super().configure()
