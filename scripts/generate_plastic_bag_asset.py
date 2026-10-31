"""Generate a local replacement USD for the standalone plastic-bag example.

The public checkout lacks the original plastic_bag.usd. Reuse the welded bag
and panel coordinates from example_cloth_balls; this is not the original asset.
"""

from __future__ import annotations

from pathlib import Path
import sys

import numpy as np
from pxr import Sdf, Usd, UsdGeom, Vt

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from examples.example_cloth_balls import create_bag_mesh

DESTINATION = ROOT / "assets" / "plastic_bag.usd"
PRIM_PATH = "/Root/plastic_bag/Root_Garment"


def main() -> None:
    if DESTINATION.exists():
        raise SystemExit(f"Asset already exists; refusing to overwrite: {DESTINATION}")

    points, triangles, panels, panel_triangles, _ = create_bag_mesh()
    corners = panels[panel_triangles]
    a, b = corners[:, 1] - corners[:, 0], corners[:, 2] - corners[:, 0]
    areas = (a[:, 0] * b[:, 1] - a[:, 1] * b[:, 0]) * 0.5
    if not np.isfinite(points).all() or not np.all(areas > 0):
        raise ValueError("Generated mesh has invalid positions or panel areas")
    if triangles.shape != panel_triangles.shape:
        raise ValueError("Physical mesh and panel face corners do not match")

    stage = Usd.Stage.CreateInMemory()
    root = UsdGeom.Xform.Define(stage, "/Root")
    UsdGeom.Xform.Define(stage, "/Root/plastic_bag")
    stage.SetDefaultPrim(root.GetPrim())
    UsdGeom.SetStageUpAxis(stage, UsdGeom.Tokens.z)
    UsdGeom.SetStageMetersPerUnit(stage, 1.0)
    stage.GetRootLayer().customLayerData = {
        "source": "examples/example_cloth_balls.py:create_bag_mesh",
        "generator": "scripts/generate_plastic_bag_asset.py",
        "description": "Locally generated replacement; not the missing original plastic_bag.usd.",
    }

    mesh = UsdGeom.Mesh.Define(stage, PRIM_PATH)
    mesh.CreatePointsAttr(Vt.Vec3fArray.FromNumpy(points))
    mesh.CreateFaceVertexCountsAttr(Vt.IntArray.FromNumpy(np.full(len(triangles), 3, dtype=np.int32)))
    mesh.CreateFaceVertexIndicesAttr(Vt.IntArray.FromNumpy(triangles.ravel()))
    mesh.CreateSubdivisionSchemeAttr(UsdGeom.Tokens.none)
    mesh.CreateOrientationAttr(UsdGeom.Tokens.rightHanded)
    mesh.CreateDoubleSidedAttr(True)
    mesh.CreateExtentAttr(Vt.Vec3fArray.FromNumpy(np.stack([points.min(axis=0), points.max(axis=0)])))
    mesh.CreateDisplayColorAttr([(0.82, 0.88, 0.94)])
    # The consuming example reflects V; author clockwise UVs to preserve its rest metric.
    uv = panels.copy()
    uv[:, 1] *= -1.0
    st = UsdGeom.PrimvarsAPI(mesh).CreatePrimvar("st", Sdf.ValueTypeNames.TexCoord2fArray, UsdGeom.Tokens.faceVarying)
    st.Set(Vt.Vec2fArray.FromNumpy(uv))
    st.SetIndices(Vt.IntArray.FromNumpy(panel_triangles.ravel()))

    DESTINATION.parent.mkdir(parents=True, exist_ok=True)
    if not stage.GetRootLayer().Export(str(DESTINATION)):
        raise RuntimeError(f"Failed to export asset: {DESTINATION}")
    print(f"Generated replacement asset: {DESTINATION}")
    print(f"Vertices: {len(points)}; triangles: {len(triangles)}; indexed panel UVs: {len(panels)}")


if __name__ == "__main__":
    main()
