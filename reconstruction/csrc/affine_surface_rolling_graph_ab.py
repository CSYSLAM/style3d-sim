"""Serial eager/real graph trajectories for simultaneous rigid, rolling and barycentric contacts."""
import argparse
from contextlib import ExitStack
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from .affine_surface_rolling_ab import cases
from reconstruction.demo_ab import compare


def worker(args):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if args.worker == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_bodies_ab import bridge
        from .host_particles_ab import native_source
        core = native_source()
        bridge(core)
    from .affine_surface_rolling_scene import Example
    image = Path(core.__file__)
    paths = [Path(__file__), ROOT/'reconstruction/csrc/affine_surface_rolling_scene.py',
             ROOT/'reconstruction/csrc/affine_surface_rolling_ab.py']
    runtime = {'backend': args.worker, 'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
               'frames': args.frames, 'sha256': {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in paths}}
    (args.output/(args.worker+'.runtime.json')).write_text(json.dumps(runtime, indent=2)+'\n')
    for name, worlds, extra in cases():
        for graph in (False, True):
            scene = Example(None, Example.create_parser().parse_args(extra))
            graphs = []
            if graph:
                for source, target in ((scene.state_0, scene.state_1), (scene.state_1, scene.state_0)):
                    with wp.ScopedCapture(device='cuda:0') as capture:
                        scene.solver.step(source, target, scene.control, scene.contacts, 1/240)
                    graphs.append(capture.graph)
            record = {key: [] for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd')}
            if scene.contacts is not None:
                record['rigid_count'] = []
                record['soft_count'] = []
            for step in range(args.frames):
                scene.state_0.clear_forces()
                if scene.pipeline is not None:
                    scene.pipeline.collide(scene.state_0, scene.contacts)
                if graph:
                    wp.capture_launch(graphs[step % 2])
                else:
                    scene.solver.step(scene.state_0, scene.state_1, scene.control, scene.contacts, 1/240)
                scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                for key in record:
                    if key in ('rigid_count', 'soft_count'):
                        array = getattr(scene.contacts, key.removesuffix('_count')+'_contact_count')
                    else:
                        array = getattr(scene.state_0, key)
                    record[key].append(array.numpy().copy())
            record = {key: np.asarray(value) for key, value in record.items()}
            assert all(np.isfinite(value).all() for value in record.values())
            if '--contacts' in extra:
                assert record['soft_count'].max() > 0, 'Coupled fixture must exercise actual soft contacts'
            np.savez_compressed(args.output/f'{args.worker}-{name}-{int(graph)}.npz', **record)
            if args.worker == 'source':
                assert sum(scene.solver._native_solver.source_launch_counts.values()) > 0
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
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    for backend in ('original', 'source'):
        assert manifest.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.affine_surface_rolling_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--output', str(args.output)]
        (args.output/(backend+'.command.json')).write_text(json.dumps(command, indent=2)+'\n')
        with (args.output/(backend+'.log')).open('w') as log:
            subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, check=True, timeout=3600)
        runtime = json.loads((args.output/(backend+'.runtime.json')).read_text())
        expected = REFERENCE_SHA if backend == 'original' else json.loads(saved)['extension_sha256']
        assert runtime['image_sha256'] == expected
        assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest() == sha for p, sha in runtime['sha256'].items())
    report = {}
    for name, worlds, extra in cases():
        with ExitStack() as stack:
            arrays = {(backend, graph): stack.enter_context(np.load(args.output/f'{backend}-{name}-{graph}.npz'))
                      for backend in ('original', 'source') for graph in (0, 1)}
            for graph in (0, 1):
                report[f'original-source/{name}/{graph}'] = compare(arrays['original', graph], arrays['source', graph])
            for backend in ('original', 'source'):
                report[f'{backend}-eager-graph/{name}'] = compare(arrays[backend, 0], arrays[backend, 1])
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({key: value['bitwise'] for key, value in report.items()}), flush=True)
    return int(any(not value['bitwise'] for value in report.values()))


if __name__ == '__main__':
    raise SystemExit(main())
