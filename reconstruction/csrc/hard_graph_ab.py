"""Serial original/source hard-contact state comparison, including captured solver graph replay."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.csrc.demo_source_ab import ROOT
from reconstruction.demo_ab import compare


def worker(backend, output, frames):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if backend == 'original':
        from reconstruction.csrc.host_api_probe import load_reference
        core = load_reference()
    else:
        from reconstruction.csrc.host_bodies_ab import bridge
        from reconstruction.csrc.host_particles_ab import native_source
        core = native_source()
        bridge(core)
    from reconstruction.csrc.hard_contact_scene import Example
    image = Path(core.__file__)
    metadata = {'backend': backend, 'image': str(image), 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
                'fixture_sha256': hashlib.sha256((ROOT/'reconstruction/csrc/hard_contact_scene.py').read_bytes()).hexdigest(),
                'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'frames': frames}
    (output/(backend+'.runtime.json')).write_text(json.dumps(metadata, indent=2)+'\n')
    all_records = {}
    for mode in ('newton', 'pd'):
        for graph in (False, True):
            args = Example.create_parser().parse_args(['--mode', mode, '--worlds', '2', '--history',
                                                       '--body-block', '--beta', '500', '--sliding'])
            scene = Example(None, args)
            graphs = []
            if graph:
                for source, destination in ((scene.state_0, scene.state_1), (scene.state_1, scene.state_0)):
                    with wp.ScopedCapture(device='cuda:0') as capture:
                        scene.solver.step(source, destination, scene.control, scene.contacts, 1/120)
                    graphs.append(capture.graph)
            records = {name: [] for name in ('particle_q', 'particle_qd', 'body_q', 'body_qd', 'contacts')}
            for step in range(frames):
                scene.state_0.clear_forces()
                scene.pipeline.collide(scene.state_0, scene.contacts)
                if graph:
                    wp.capture_launch(graphs[step % 2])
                    scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                else:
                    scene.solver.step(scene.state_0, scene.state_1, scene.control, scene.contacts, 1/120)
                    scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                for name in records:
                    array = scene.contacts.rigid_contact_count if name == 'contacts' else getattr(scene.state_0, name)
                    records[name].append(array.numpy().copy())
            all_records[f'{mode}-{int(graph)}'] = {key: np.asarray(value) for key, value in records.items()}
            assert np.asarray(records['contacts']).max() > 0, 'The history test must contain actual rigid contacts'
            assert all(np.isfinite(value).all() for value in all_records[f'{mode}-{int(graph)}'].values())
            np.savez_compressed(output/f'{backend}-{mode}-{int(graph)}.npz', **all_records[f'{mode}-{int(graph)}'])
    if backend == 'source':
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=30)
    parser.add_argument('--worker', choices=('original', 'source'))
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output, args.frames)
    args.output.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    for backend in ('original', 'source'):
        command = [sys.executable, '-m', 'reconstruction.csrc.hard_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--output', str(args.output)]
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=900)
    records = {p.stem: np.load(p) for p in args.output.glob('*.npz')}
    report = {}
    for mode in ('newton', 'pd'):
        for graph in (0, 1):
            key = f'{mode}-{graph}'
            report['original-source-'+key] = compare(records['original-'+key], records['source-'+key])
        for backend in ('original', 'source'):
            report[f'{backend}-eager-graph-{mode}'] = compare(records[f'{backend}-{mode}-0'],
                                                           records[f'{backend}-{mode}-1'])
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({key: value['bitwise'] for key, value in report.items()}))
    return any(not value['bitwise'] for value in report.values())


if __name__ == '__main__':
    sys.exit(main())
