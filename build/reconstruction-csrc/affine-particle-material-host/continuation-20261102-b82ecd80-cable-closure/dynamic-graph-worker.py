"""Coupled cable/body constraints:24 cases, unchanged arithmetic, eager and real CUDA graphs."""
import argparse
__package__ = 'reconstruction.csrc'
import importlib.util
from contextlib import ExitStack
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np
sys.path.insert(0, str(Path.cwd()))

from reconstruction.demo_ab import compare
from .affine_tetrahedron_contact_ab import clean_env
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA


def cases():
    for kind in ('spring-distance', 'point-line-distance'):
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for block in (False, True):
                    name = f'{kind}-w{worlds}-{mode}-b{int(block)}'
                    extra = ['--constraint', kind, '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode]
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
    from .cable_body_mixed_dynamic_scene import Example
    paths = (Path(__file__), ROOT / 'reconstruction/csrc/cable_body_mixed_dynamic_scene.py')
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
                force = ('distance_force' if name.startswith('distance') else
                         'point_line_force' if name.startswith('point-line') else 'body_spring_force')
                assert counts.get(force, 0) > 0 and counts.get('cable_evaluate', 0) > 0
                assert counts.get('distance_force', 0) > 0
                if '--body-block' in extra:
                    assert counts.get('affine_apply', 0) > 0
                    assert counts.get('affine_build', 0) + counts.get('affine_build_scalar', 0) > 0
    if args.worker == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'), required=True)
    parser.add_argument('--candidate-build', type=Path, required=True)
    args = parser.parse_args()
    assert args.frames > 0 and args.output.is_dir()
    from reconstruction.csrc import host_particles_ab
    candidate_build = json.loads(args.candidate_build.read_text())
    image = Path(candidate_build['image'])
    assert hashlib.sha256(image.read_bytes()).hexdigest() == candidate_build['image_sha256']
    for path, expected in candidate_build['input_sha256'].items():
        assert hashlib.sha256(Path(path).read_bytes()).hexdigest() == expected, path

    def candidate():
        spec = importlib.util.spec_from_file_location('_source_solver', image)
        core = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(core)
        assert core.source_only and not core.solver_api_ready
        return core

    if args.worker == 'source':
        host_particles_ab.native_source = candidate
    from reconstruction.csrc.host_api_probe import REFERENCE
    try:
        worker(args)
    finally:
        mapped = str(REFERENCE.resolve()) in Path('/proc/self/maps').read_text()
        (args.output / (args.worker + '-mapping.json')).write_text(json.dumps({
            'SDK_mapped': mapped, 'backend': args.worker, 'source_calculated_independently': args.worker == 'source',
            'whole_solver_complete': False}, indent=2) + '\n')
        assert mapped == (args.worker == 'original')
