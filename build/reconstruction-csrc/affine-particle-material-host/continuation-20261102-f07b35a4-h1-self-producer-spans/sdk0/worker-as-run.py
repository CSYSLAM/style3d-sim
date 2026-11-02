"""Run the unchanged H1 example through a real public Core, recording its inline graph and final states."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import runpy
import sys

import numpy as np

ROOT, BASE = Path.cwd(), asset_manifest_base
sys.path.insert(0, str(ROOT))
from reconstruction.csrc.host_api_probe import REFERENCE, REFERENCE_SHA

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backend', choices=('original', 'source'), required=True)
parser.add_argument('--core-build', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--frames', type=int, default=4)
args = parser.parse_args()
output = args.output.resolve()
output.mkdir(parents=True, exist_ok=False)
metadata = json.loads(args.core_build.read_text())
for name, expected in metadata['sources'].items():
    assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == expected, name
image = REFERENCE if args.backend == 'original' else args.core_build.resolve().parent / REFERENCE.name
expected = REFERENCE_SHA if args.backend == 'original' else metadata['extension_sha256']
assert hashlib.sha256(image.read_bytes()).hexdigest() == expected
name = 'style3d_sim._core'
assert name not in sys.modules
spec = importlib.util.spec_from_file_location(name, image)
core = importlib.util.module_from_spec(spec)
sys.modules[name] = core
spec.loader.exec_module(core)
import style3d_sim as s3d
import newton.examples
import newton.utils

assert s3d.Solver is core.Solver
assets = json.loads((BASE / 'h1-asset-manifest.json').read_text())
for asset in assets['assets'].values():
    for relative, entry in asset['files'].items():
        path = Path(asset['root']) / relative
        raw = path.read_bytes()
        assert len(raw) == entry['bytes'] and hashlib.sha256(raw).hexdigest() == entry['sha256']


def pinned_asset(folder, cache_dir=None, force_refresh=False, ref=None):
    assert folder in assets['assets'] and cache_dir is None and not force_refresh
    assert ref is None or ref == assets['ref']
    return Path(assets['assets'][folder]['root'])


newton.utils.download_asset = pinned_asset
original_run = newton.examples.run
records = {key: [] for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
graph_steps, before = [], {}


def record_run(example, options):
    state = example.state
    for key in records:
        before[key] = getattr(state, key).numpy().copy()
    np.savez_compressed(output / 'before.npz', **before)
    counts = {key: int(getattr(example.model, key)) for key in
              ('body_count', 'particle_count', 'joint_count', 'joint_dof_count')}
    (output / 'model-counts.json').write_text(json.dumps(counts, indent=2) + '\n')
    original_step = example.step

    def step():
        old_graph = example.graph is not None
        original_step()
        if not old_graph:
            probe_self_static(example)
        graph_steps.append({'graph_before': old_graph, 'graph_after': example.graph is not None})
        for key in records:
            records[key].append(getattr(example.state, key).numpy().copy())

    example.step = step
    return original_run(example, options)


newton.examples.run = record_run
example_path = ROOT / 'examples/example_cloth_h1_free.py'
sys.path.insert(0, str(example_path.parent))
sys.argv = [str(example_path), '--viewer', 'null', '--num-frames', str(args.frames), '--test']
runtime = {'backend': args.backend, 'image_sha256': expected, 'public_core_abi': True, 'ab_bridge_used': False,
           'example_sha256': hashlib.sha256(example_path.read_bytes()).hexdigest(),
           'original_physics_and_test_final_modified': False, 'asset_ref': assets['ref'],
           'asset_resolver_only_pins_existing_same_revision_cache': True, 'downloads_started': False,
           'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
           'frames': args.frames, 'exit': None, 'whole_solver_complete': False}
try:
    runpy.run_path(str(example_path), run_name='__main__')
    runtime['exit'] = 0
except BaseException as error:
    runtime['exit'] = error.code if isinstance(error, SystemExit) and isinstance(error.code, int) else 1
    runtime['error'] = f'{type(error).__name__}: {error}'
    raise
finally:
    runtime['reference_solver_mapped'] = str(REFERENCE.resolve()) in Path('/proc/self/maps').read_text()
    runtime['recorded_frames'] = {key: len(values) for key, values in records.items()}
    runtime['graph_steps'] = graph_steps
    (output / 'runtime.json').write_text(json.dumps(runtime, indent=2) + '\n')
    if any(records.values()):
        np.savez_compressed(output / 'states.npz', **{key: np.asarray(values) for key, values in records.items()})
    assert runtime['reference_solver_mapped'] == (args.backend == 'original')
assert runtime['exit'] == 0 and all(len(values) == args.frames for values in records.values())
assert graph_steps[0] == {'graph_before': False, 'graph_after': True}
assert all(item == {'graph_before': True, 'graph_after': True} for item in graph_steps[1:])
assert all(np.isfinite(values).all() for values in records.values())
print(args.backend, 'H1 public API, original graph and test_final completed', args.frames, flush=True)
