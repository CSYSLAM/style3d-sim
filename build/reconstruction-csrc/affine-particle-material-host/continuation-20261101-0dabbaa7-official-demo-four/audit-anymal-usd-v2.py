"""Validate the fixed ANYmal USD dependencies and authored rigid-body topology on CPU without solver imports."""
from collections import Counter
import hashlib
import json
from pathlib import Path

from pxr import Sdf, Usd, UsdPhysics, UsdShade, UsdUtils

ROOT, BASE = Path.cwd(), Path(__file__).resolve().parent
OUTPUT = BASE / 'anymal-USD-independent-cpu-v2.json'
assert not OUTPUT.exists()
restored = json.loads((BASE / 'asset-restore.json').read_text())
manifest_path = ROOT / 'reconstruction/assets/anybotics_anymal_d/manifest.json'
manifest = json.loads(manifest_path.read_text())
asset = Path(restored['asset_path'])
files = {}
for name, expected in manifest['files'].items():
    path = asset / name
    data = path.read_bytes()
    assert len(data) == expected['bytes'] and hashlib.sha256(data).hexdigest() == expected['sha256']
    files[str(path.resolve())] = expected['sha256']
stage_path = asset / 'usd/anymal_d.usda'
layers, assets, unresolved = UsdUtils.ComputeAllDependencies(str(stage_path))
assert set(unresolved) == {'OmniPBR.mdl'}, unresolved
stage = Usd.Stage.Open(str(stage_path))
assert stage
prims = list(stage.Traverse())
rigid = [prim.GetPath().pathString for prim in prims if prim.HasAPI(UsdPhysics.RigidBodyAPI)]
joints = [prim.GetPath().pathString for prim in prims if prim.IsA(UsdPhysics.Joint)]
assert len(rigid) > 0 and len(joints) > 0
shader_assets = []
for prim in prims:
    for attribute in prim.GetAttributes():
        value = attribute.Get()
        if isinstance(value, Sdf.AssetPath) and value.path in unresolved:
            assert prim.IsA(UsdShade.Shader), str(attribute.GetPath())
            shader_assets.append(str(attribute.GetPath()))
assert shader_assets

resolved = []
for path in [Path(layer.realPath) for layer in layers] + [Path(path) for path in assets]:
    assert path.is_file() and path.resolve().is_relative_to(asset.resolve()), path
    relative = path.relative_to(asset).as_posix()
    assert relative in manifest['files'], relative
    resolved.append(relative)
for path in (Path(__file__), manifest_path, BASE / 'asset-restore.json'):
    files[str(path.resolve())] = hashlib.sha256(path.read_bytes()).hexdigest()
result = {'usd_version': list(Usd.GetVersion()), 'prim_types': dict(Counter(str(p.GetTypeName()) for p in prims)),
          'rigid_bodies': rigid, 'joints': joints, 'resolved_dependencies': sorted(set(resolved)),
          'unresolved_dependencies': list(unresolved), 'unresolved_shader_asset_attributes': shader_assets,
          'all_resolvable_dependencies_local_and_pinned': True, 'input_sha256': files,
          'GPU_used': False, 'solver_imported': False, 'Newton_model_construction_verified': False,
          'whole_solver_complete': False}
OUTPUT.write_text(json.dumps(result, indent=2) + '\n')
print('ANYmal USD CPU:', len(rigid), 'rigid bodies,', len(joints), 'joints;',
      len(set(resolved)), 'local dependencies;OmniPBR.mdl unresolved only on shader attributes', flush=True)
