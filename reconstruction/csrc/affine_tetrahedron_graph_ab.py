"""Full eager/real-graph trajectories for the captured SO3/tetrahedron combination."""
import argparse
from contextlib import ExitStack
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.demo_ab import compare
from .affine_tetrahedron_ab import cases
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def worker(args):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT / 'build/reconstruction-warp')
    if args.worker == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_particles_ab import native_source
        from .host_bodies_ab import bridge
        core = native_source()
        bridge(core)
    spec = importlib.util.spec_from_file_location('tetrahedron_graph_fixture', args.fixture)
    fixture = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(fixture)
    Example = fixture.Example
    inputs = [Path(__file__), args.fixture,
              ROOT / 'reconstruction/csrc/affine_tetrahedron_ab.py']
    (args.output / (args.worker + '.runtime.json')).write_text(json.dumps({
        'backend': args.worker, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
        'frames': args.frames, 'particles_per_world': args.particles_per_world, 'diagonal_only': args.diagonal_only,
        'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}},
        indent=2) + '\n')
    for name, worlds, extra in cases():
        if args.diagonal_only:
            extra = [*extra, '--diagonal-only']
        for graph in (False, True):
            scene = Example(None, Example.create_parser().parse_args(extra))
            graphs = []
            if graph:
                for source, target in ((scene.state_0, scene.state_1), (scene.state_1, scene.state_0)):
                    with wp.ScopedCapture(device='cuda:0') as capture:
                        scene.solver.step(source, target, scene.control, None, 1 / 240)
                    graphs.append(capture.graph)
            record = {key: [] for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
            for step in range(args.frames):
                scene.state_0.clear_forces()
                if graph:
                    wp.capture_launch(graphs[step % 2])
                else:
                    scene.solver.step(scene.state_0, scene.state_1, scene.control, None, 1 / 240)
                scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                for key in record:
                    record[key].append(getattr(scene.state_0, key).numpy().copy())
            arrays = {key: np.asarray(value) for key, value in record.items()}
            assert arrays['particle_q'].shape == (args.frames, args.particles_per_world * worlds, 3)
            assert all(np.isfinite(value).all() for value in arrays.values())
            np.savez_compressed(args.output / f'{args.worker}-{name}-{int(graph)}.npz', **arrays)
            if args.worker == 'source':
                counts = dict(scene.solver._native_solver.source_launch_counts)
                assert counts['tetrahedron_force'] > 0 and counts['tetrahedron_tangent'] > 0
                if scene.solver.config.enable_self_collision:
                    assert all(counts.get(key, 0) > 0 for key in ('self_accumulate_pp', 'self_accumulate_vf',
                                                                'self_accumulate_ee', 'self_accumulate_ef'))
    if args.worker == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--fixture', type=Path, default=ROOT / 'reconstruction/csrc/affine_tetrahedron_scene.py')
    parser.add_argument('--particles-per-world', type=int, default=8)
    parser.add_argument('--diagonal-only', action='store_true')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.fixture = args.fixture.resolve(strict=True)
    assert args.frames > 0 and args.particles_per_world > 0
    if args.worker:
        return worker(args)
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('CUDAHOOK_', 'RECON_ORACLE_', 'DEMO_'))
           and key not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.affine_tetrahedron_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--output', str(args.output), '--fixture', str(args.fixture),
                   '--particles-per-world', str(args.particles_per_world)]
        if args.diagonal_only:
            command.append('--diagonal-only')
        (args.output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (args.output / (backend + '.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1200)
        runtime = json.loads((args.output / (backend + '.runtime.json')).read_text())
        assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else
                                          json.loads(saved)['extension_sha256'])
    rows = {}
    for name, _, _ in cases():
        with ExitStack() as stack:
            data = {(backend, graph): stack.enter_context(np.load(args.output / f'{backend}-{name}-{graph}.npz'))
                    for backend in ('original', 'source') for graph in (0, 1)}
            for graph in (0, 1):
                rows[f'original-source/{name}/{graph}'] = compare(data['original', graph], data['source', graph])
            for backend in ('original', 'source'):
                rows[f'{backend}-eager-graph/{name}'] = compare(data[backend, 0], data[backend, 1])
    (args.output / 'report.json').write_text(json.dumps(rows, indent=2) + '\n')
    print('body/tet graph comparisons', sum(row['bitwise'] for row in rows.values()), '/', len(rows), flush=True)
    return int(not all(row['bitwise'] for row in rows.values()))


if __name__ == '__main__':
    raise SystemExit(main())
