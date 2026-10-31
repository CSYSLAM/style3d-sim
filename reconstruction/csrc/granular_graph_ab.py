"""Compare real granular eager/graph trajectories across three seeds and world counts, keeping strict failures."""
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


def worker(backend, output, frames):
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
    from .granular_host_scene import Example
    from .granular_disabled_bonds_scene import Example as DisabledExample
    image = Path(core.__file__)
    runtime = {'backend': backend, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
               'fixture_sha256': hashlib.sha256((ROOT/'reconstruction/csrc/granular_host_scene.py').read_bytes()).hexdigest(),
               'disabled_fixture_sha256': hashlib.sha256(
                   (ROOT/'reconstruction/csrc/granular_disabled_bonds_scene.py').read_bytes()).hexdigest(),
               'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'frames': frames}
    (output/(backend+'.runtime.json')).write_text(json.dumps(runtime, indent=2)+'\n')
    coverage = {}
    for worlds in (1, 2, 3):
        for bonds in ('none', 'authored', 'dynamic', 'mixed', 'disabled'):
            extra = ['--subset', '--contacts'] if bonds in ('mixed', 'disabled') else []
            for mode in ('newton', 'pd'):
                for graph in (0, 1):
                    name = f'w{worlds}-{bonds}-{mode}-g{graph}'
                    options = ['--worlds', str(worlds), '--seed', str(worlds), '--bonds',
                               'mixed' if bonds == 'disabled' else bonds, '--mode', mode, *extra]
                    fixture = DisabledExample if bonds == 'disabled' else Example
                    scene = fixture(None, fixture.create_parser().parse_args(options))
                    graphs = []
                    if graph:
                        for source, destination in ((scene.state_0, scene.state_1), (scene.state_1, scene.state_0)):
                            with wp.ScopedCapture(device='cuda:0') as capture:
                                scene.solver.step(source, destination, scene.control, scene.contacts, 1/240)
                            graphs.append(capture.graph)
                    records = {'particle_q': [], 'particle_qd': []}
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
                        for key in records:
                            value = scene.contacts.soft_contact_count if key == 'soft_count' else getattr(scene.state_0, key)
                            records[key].append(value.numpy().copy())
                    arrays = {key: np.asarray(value) for key, value in records.items()}
                    assert all(np.isfinite(value).all() for value in arrays.values()), name
                    if scene.contacts is not None:
                        assert arrays['soft_count'].max() > 0, 'The contact variant must contain real soft contacts'
                    np.savez_compressed(output/f'{backend}-{name}.npz', **arrays)
                    if backend == 'source':
                        counts = dict(scene.solver._native_solver.source_launch_counts)
                        assert sum(counts.values()) > 0
                        coverage[name] = counts
                    print(backend, name, 'complete', flush=True)
    if backend == 'source':
        (output/'source-coverage.json').write_text(json.dumps(coverage, indent=2)+'\n')
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output, args.frames)
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    env = {key: value for key, value in os.environ.items() if key not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.granular_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--output', str(args.output.resolve())]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=1800)
    report = {}
    for worlds in (1, 2, 3):
        for bonds in ('none', 'authored', 'dynamic', 'mixed', 'disabled'):
            for mode in ('newton', 'pd'):
                key = f'w{worlds}-{bonds}-{mode}'
                for graph in (0, 1):
                    with np.load(args.output/f'original-{key}-g{graph}.npz') as original:
                        with np.load(args.output/f'source-{key}-g{graph}.npz') as source:
                            report[f'original-source-{key}-g{graph}'] = compare(original, source)
                for backend in ('original', 'source'):
                    with np.load(args.output/f'{backend}-{key}-g0.npz') as eager:
                        with np.load(args.output/f'{backend}-{key}-g1.npz') as graph:
                            report[f'{backend}-eager-graph-{key}'] = compare(eager, graph)
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    failures = [key for key, value in report.items() if not value['bitwise']]
    print(json.dumps({'comparisons': len(report), 'strict_failures': failures}), flush=True)
    return int(bool(failures))


if __name__ == '__main__':
    raise SystemExit(main())
