"""Graph adapter for the frozen material/self-collision fixture; configuration is constant across phases."""
from reconstruction.csrc.self_cloth_scene import Example as BaseExample


class Example(BaseExample):
    def configure(self):
        pass
