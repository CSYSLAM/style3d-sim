"""Mixed plain body constraints, W1/W3, both modes and body blocks, real graphs."""
import argparse
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.demo_ab import compare
from .affine_tetrahedron_contact_ab import clean_env
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def cases():
    for kind in ('spring-line', 'spring-distance', 'line-distance', 'all'):
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for block in (False, True):
                    name = f'{kind}-w{worlds}-{mode}-b{int(block)}'
                    extra = ['--constraints', kind, '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode]
                    if block:
                        extra.append('--body-block')
                    yield name, worlds, extra


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
    from .plain_body_mixed_scene import Example
    paths = (Path(__file__), ROOT / 'reconstruction/csrc/plain_body_mixed_scene.py')
    (args.output / (args.worker + '.runtime.json')).write_text(json.dumps({
        'backend': args.worker, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
        'frames': args.frames, 'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
    }, indent=2) + '\n')
    for name, worlds, extra in cases():
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
            assert arrays['particle_q'].shape == (args.frames, 8 * worlds, 3)
            assert all(np.isfinite(value).all() for value in arrays.values())
            np.savez_compressed(args.output / f'{args.worker}-{name}-{int(graph)}.npz', **arrays)
            if args.worker == 'source':
                counts = dict(scene.solver._native_solver.source_launch_counts)
                kind = extra[extra.index('--constraints') + 1]
                forces = {'spring-line': ('body_spring_force', 'point_line_force'),
                          'spring-distance': ('body_spring_force', 'distance_force'),
                          'line-distance': ('point_line_force', 'distance_force'),
                          'all': ('body_spring_force', 'point_line_force', 'distance_force')}[kind]
                assert all(counts.get(key, 0) > 0 for key in forces)
                if '--body-block' in extra:
                    assert counts.get('affine_apply', 0) > 0
                    assert counts.get('affine_build', 0) + counts.get('affine_build_scalar', 0) > 0
    if args.worker == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    args.output = args.output.resolve()
    assert args.frames > 0
    if args.worker:
        return worker(args)
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output / 'build.json').write_bytes(saved)
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.plain_body_mixed_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--output', str(args.output)]
        (args.output / (backend + '.command.json')).write_text(json.dumps(command, indent=2) + '\n')
        with (args.output / (backend + '.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=clean_env(), stdout=log, stderr=subprocess.STDOUT,
                           timeout=3600, check=True)
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
    print('Mixed plain graph comparisons', sum(row['bitwise'] for row in rows.values()), '/', len(rows), flush=True)
    return int(not all(row['bitwise'] for row in rows.values()))


if __name__ == '__main__':
    raise SystemExit(main())
