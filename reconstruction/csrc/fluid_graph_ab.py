"""Serial eager/CUDA-graph comparison for cached fluid rows, boundaries and rigid-contact coupling."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT
from reconstruction.demo_ab import compare


def worker(backend, output, frames, suite='fluid'):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_bodies_ab import bridge
        from .host_particles_ab import native_source
        core = native_source()
        bridge(core)
    if suite == 'self-granular':
        from .self_granular_scene import Example
        fixture = ROOT/'reconstruction/csrc/self_granular_scene.py'
        variants = ([], ['--subset', '--bonds', 'authored', '--contacts'],
                    ['--subset', '--bonds', 'mixed', '--contacts', '--worlds', '3', '--seed', '3', '--diagonal-only'])
    elif suite == 'self-fluid':
        from .self_fluid_material_scene import Example
        fixture = ROOT/'reconstruction/csrc/self_fluid_material_scene.py'
        variants = ([], ['--diagonal-only'], ['--worlds', '3', '--seed', '3'])
    else:
        from .fluid_host_scene import Example
        fixture = ROOT/'reconstruction/csrc/fluid_host_scene.py'
        variants = (['--layout', 'isolated'], ['--boundaries'],
                    ['--boundaries', '--contacts', '--body', '--body-block'])
    image = Path(core.__file__)
    metadata = {'backend': backend, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
                'fixture_sha256': hashlib.sha256(fixture.read_bytes()).hexdigest(), 'suite': suite,
                'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'frames': frames}
    if suite != 'fluid':
        base = 'fluid_material_scene.py' if suite == 'self-fluid' else 'granular_host_scene.py'
        metadata['base_fixture_sha256'] = hashlib.sha256(
            (ROOT/'reconstruction/csrc'/base).read_bytes()).hexdigest()
    (output/(backend+'.runtime.json')).write_text(json.dumps(metadata, indent=2)+'\n')
    for variant, extra in enumerate(variants):
        for mode in ('newton', 'pd'):
            for graph in (False, True):
                scene = Example(None, Example.create_parser().parse_args(['--mode', mode, *extra]))
                graphs = []
                if graph:
                    for source, destination in ((scene.state_0, scene.state_1), (scene.state_1, scene.state_0)):
                        with wp.ScopedCapture(device='cuda:0') as capture:
                            scene.solver.step(source, destination, scene.control, scene.contacts, 1/240)
                        graphs.append(capture.graph)
                records = {name: [] for name in ('particle_q', 'particle_qd', 'body_q', 'body_qd')
                           if getattr(scene.state_0, name) is not None and getattr(scene.state_0, name).shape[0]}
                if scene.contacts is not None:
                    records['soft_count'] = []
                for step in range(frames):
                    scene.state_0.clear_forces()
                    if scene.pipeline is not None:
                        scene.pipeline.collide(scene.state_0, scene.contacts)
                    if graph:
                        wp.capture_launch(graphs[step % 2])
                    else:
                        scene.solver.step(scene.state_0, scene.state_1, scene.control, scene.contacts, 1/240)
                    scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                    for name in records:
                        value = (scene.contacts.soft_contact_count if name == 'soft_count'
                                 else getattr(scene.state_0, name))
                        records[name].append(value.numpy().copy())
                records = {key: np.asarray(value) for key, value in records.items()}
                assert all(np.isfinite(value).all() for value in records.values())
                if suite == 'fluid' and variant == 2:
                    assert records['soft_count'].max() > 0, 'Coupled case must include actual fluid/body contacts'
                np.savez_compressed(output/f'{backend}-v{variant}-{mode}-{int(graph)}.npz', **records)
                if backend == 'source':
                    assert sum(scene.solver._native_solver.source_launch_counts.values()) > 0
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=30)
    parser.add_argument('--suite', choices=('fluid', 'self-fluid', 'self-granular'), default='fluid')
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output, args.frames, args.suite)
    args.output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD')}
    for backend in ('original', 'source'):
        command = [sys.executable, '-m', 'reconstruction.csrc.fluid_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--suite', args.suite, '--output', str(args.output)]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1800)
    records = {path.stem: np.load(path) for path in args.output.glob('*.npz')}
    report = {}
    for variant in range(3):
        for mode in ('newton', 'pd'):
            key = f'v{variant}-{mode}'
            for graph in (0, 1):
                report[f'original-source-{key}-{graph}'] = compare(records[f'original-{key}-{graph}'],
                                                                  records[f'source-{key}-{graph}'])
            for backend in ('original', 'source'):
                report[f'{backend}-eager-graph-{key}'] = compare(records[f'{backend}-{key}-0'],
                                                               records[f'{backend}-{key}-1'])
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({key: value['bitwise'] for key, value in report.items()}))
    return any(not value['bitwise'] for value in report.values())


if __name__ == '__main__':
    raise SystemExit(main())
