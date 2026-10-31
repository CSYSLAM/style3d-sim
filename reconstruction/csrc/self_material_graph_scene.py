"""Capture adapter for the frozen compound Style3D scene; all configuration phases are constant."""
from reconstruction.csrc.self_material_cloth_contact_scene import Example as BaseExample


class Example(BaseExample):
    def configure(self):
        pass
