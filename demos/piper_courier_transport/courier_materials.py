"""Opaque gray polyethylene appearance for the courier scene's USD export."""

from pxr import Gf, Sdf, UsdShade
from export_scene import SceneUSD

BAG_COLOR = (0.32, 0.35, 0.39)


class CourierSceneUSD(SceneUSD):
    def __init__(self, path, sim, frames):
        super().__init__(path, sim, frames)
        for name in ('film_0', 'film_1'):
            prim = self.stage.GetPrimAtPath('/World/' + name)
            material, _ = UsdShade.MaterialBindingAPI(prim).ComputeBoundMaterial()
            shader = UsdShade.Shader(material.ComputeSurfaceSource()[0])
            shader.CreateInput('diffuseColor', Sdf.ValueTypeNames.Color3f).Set(Gf.Vec3f(*BAG_COLOR))
            shader.CreateInput('opacity', Sdf.ValueTypeNames.Float).Set(1.0)
            shader.CreateInput('roughness', Sdf.ValueTypeNames.Float).Set(0.55)
