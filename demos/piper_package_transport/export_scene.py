"""Export only simulated geometry and the original Piper visual meshes."""

import json
import sys
from pathlib import Path
import newton
import numpy as np
import style3d_sim as s3d
from pxr import Gf, Usd, UsdGeom, UsdShade, Vt

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'demos/piper_bag_transport'))
from export_simulation import SimulationUSD, set_pose, bounds
from demo_piper_bag_transport import PIPER_ASSET
from piper_materials import match_material, read_materials


class SceneUSD(SimulationUSD):
    def __init__(self, path, sim, frames):
        self.path = Path(path)
        self.stage = Usd.Stage.CreateNew(str(path))
        self.stage.SetFramesPerSecond(30)
        self.stage.SetTimeCodesPerSecond(30)
        self.stage.SetStartTimeCode(0)
        self.stage.SetEndTimeCode(frames)
        UsdGeom.SetStageUpAxis(self.stage, UsdGeom.Tokens.z)
        UsdGeom.SetStageMetersPerUnit(self.stage, 1)
        self.stage.SetDefaultPrim(UsdGeom.Xform.Define(self.stage, '/World').GetPrim())
        self.materials, self.textures, self.meshes, self.bodies = {}, {}, [], []
        self.deformables = []
        colors = ((0.90, 0.80, 0.53), (0.59, 0.88, 0.90), (0.05, 0.55, 0.30))
        for group, color in zip(sim.groups, colors):
            mesh = self.add_mesh('/World/' + group['name'], group['rest'], group['faces'], color, 0.25, 0)
            self.deformables.append((group['start'], group['end'], mesh))
        paths = {-1: '/World/Piper_base'}
        for i in range(sim.model.body_count):
            path = f'/World/body_{i:02d}'
            body = UsdGeom.Xform.Define(self.stage, path)
            self.bodies.append((i, body.AddTranslateOp(), body.AddOrientOp()))
            paths[i] = path
        model = sim.model
        catalog = read_materials(s3d.get_asset(PIPER_ASSET))
        robot_materials = {}
        flags, parents = model.shape_flags.numpy(), model.shape_body.numpy()
        scales, transforms, colors = model.shape_scale.numpy(), model.shape_transform.numpy(), model.shape_color.numpy()
        for i, source in enumerate(model.shape_source):
            if source is None or not flags[i] & int(newton.ShapeFlags.VISIBLE):
                continue
            name = 'carton' if parents[i] == sim.carton else f'robot_{i:03d}'
            color = colors[i]
            roughness = 0.4 if source.roughness is None else source.roughness
            if name != 'carton':
                appearance = match_material(catalog, color)
                # Display RGB is encoded for a screen; USD shader constants are scene-linear, like decoded textures.
                color = appearance['color_linear']
                roughness = appearance['roughness'] if source.roughness is None else source.roughness
                robot_materials[name] = dict(appearance, roughness=float(roughness))
                robot_materials[name]['metallic'] = 0 if source.metallic is None else float(source.metallic)
                robot_materials[name]['texture'] = None if source.texture is None else str(source.texture)
            normals = None if source.normals is None else np.asarray(source.normals) / scales[i]
            if normals is not None:
                normals /= np.maximum(np.linalg.norm(normals, axis=1, keepdims=True), 1e-12)
            mesh = self.add_mesh(f'{paths[int(parents[i])]}/{name}', source.vertices * scales[i], source.indices,
                                 color, roughness,
                                 0 if source.metallic is None else source.metallic,
                                 normals=normals, uvs=source.uvs, texture=source.texture)
            if name != 'carton':
                mesh.GetPrim().SetCustomDataByKey('piper:color_srgb', Gf.Vec3f(*appearance['color_srgb']))
            transform = UsdGeom.Xformable(mesh)
            set_pose(transform.AddTranslateOp(), transform.AddOrientOp(), transforms[i])
        (self.path.parent / 'piper_materials.json').write_text(json.dumps(dict(
            **catalog, meshes=robot_materials), indent=2))

    def sample(self, frame, particles, bodies):
        for start, end, mesh in self.deformables:
            points = particles[start:end]
            mesh.GetPointsAttr().Set(Vt.Vec3fArray.FromNumpy(points), frame)
            mesh.GetExtentAttr().Set(Vt.Vec3fArray.FromNumpy(bounds(points)), frame)
        for i, translation, orientation in self.bodies:
            set_pose(translation, orientation, bodies[i], frame)


def refresh_piper_materials(path):
    """Upgrade a recorded USD's robot appearance without modifying any geometry or animation samples."""
    path = Path(path)
    stage = Usd.Stage.Open(str(path))
    catalog = read_materials(s3d.get_asset(PIPER_ASSET))
    meshes = {}
    for prim in stage.Traverse():
        if not prim.IsA(UsdGeom.Mesh) or not prim.GetName().startswith('robot_'):
            continue
        mesh = UsdGeom.Mesh(prim)
        color = prim.GetCustomDataByKey('piper:color_srgb')
        if color is None:
            color = mesh.GetDisplayColorAttr().Get()[0]
        appearance = match_material(catalog, color)
        material, _ = UsdShade.MaterialBindingAPI(prim).ComputeBoundMaterial()
        shader = UsdShade.Shader(material.ComputeSurfaceSource()[0])
        texture = None
        if shader.GetInput('diffuseColor').HasConnectedSource():
            texture_shader = UsdShade.Shader(shader.GetInput('diffuseColor').GetConnectedSource()[0])
            texture_asset = texture_shader.GetInput('file').Get()
            if texture_asset:
                texture = texture_asset.path
            else:
                raise ValueError(f'Cannot locate the recorded Piper texture on {prim.GetPath()}')
        if not shader.GetInput('diffuseColor').HasConnectedSource():
            shader.GetInput('diffuseColor').Set(Gf.Vec3f(*appearance['color_linear']))
        shader.GetInput('roughness').Set(appearance['roughness'])
        mesh.GetDisplayColorAttr().Set([Gf.Vec3f(*appearance['color_linear'])])
        prim.SetCustomDataByKey('piper:color_srgb', Gf.Vec3f(*appearance['color_srgb']))
        meshes[prim.GetName()] = dict(appearance, metallic=float(shader.GetInput('metallic').Get()), texture=texture)
    if not meshes:
        raise ValueError(f'No original Piper visual meshes in {path}')
    (path.parent / 'piper_materials.json').write_text(json.dumps(dict(**catalog, meshes=meshes), indent=2))
    stage.GetRootLayer().Save()


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Refresh original Piper materials in an existing simulation USD.')
    parser.add_argument('usd', type=Path)
    refresh_piper_materials(parser.parse_args().usd)
