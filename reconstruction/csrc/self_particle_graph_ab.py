"""Compare eager and actual CUDA-graph PP trajectories, with four fixed graphs for mutable config phases."""
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


def cases(suite='particles'):
    if suite == 'materials':
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for diagonal in (False, True):
                    yield f'all-w{worlds}-{mode}-d{int(diagonal)}', [
                        '--material', 'all', '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
                        *(['--diagonal-only'] if diagonal else [])]
        return
    if suite == 'cloth':
        for worlds in (1, 3):
            for mode in ('newton', 'pd'):
                for variant, extra in (('membrane', []), ('hinge', ['--hinges']),
                                       ('contact-hinge', ['--contacts', '--hinges'])):
                    yield f'w{worlds}-{variant}-{mode}', [
                        '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode, *extra]
        for mode in ('newton', 'pd'):
            yield f'diagonal-contact-hinge-{mode}', ['--mode', mode, '--contacts', '--hinges', '--diagonal-only']
            yield f'pinned-free-{mode}', ['--mode', mode, '--hinges', '--pinned', '--free']
        return
    if suite == 'mesh':
        for worlds in (1, 2, 3):
            for mode in ('newton', 'pd'):
                for diagonal in (False, True):
                    yield f'w{worlds}-{mode}-d{int(diagonal)}', [
                        '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
                        *(['--diagonal-only'] if diagonal else [])]
        for mode in ('newton', 'pd'):
            for switch in ('hessian', 'enabled', 'stiffness'):
                yield f'switch-{switch}-{mode}', ['--mode', mode, '--switch', switch]
        return
    for worlds in (1, 2, 3):
        for mode in ('newton', 'pd'):
            for diagonal in (False, True):
                yield f'w{worlds}-{mode}-d{int(diagonal)}', [
                    '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
                    *(['--diagonal-only'] if diagonal else [])]
    for mode in ('newton', 'pd'):
        yield f'subset-vary-{mode}', ['--mode', mode, '--worlds', '3', '--seed', '5', '--subset', '--vary']
        for switch in ('hessian', 'enabled', 'stiffness'):
            yield f'switch-{switch}-{mode}', ['--mode', mode, '--switch', switch]


def worker(backend, output, frames, suite, case_name):
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
    if suite == 'materials':
        from .self_material_graph_scene import Example
    elif suite == 'cloth':
        from .self_cloth_graph_scene import Example
    elif suite == 'mesh':
        from .self_mesh_mixed_scene import Example
    else:
        from .self_particle_valid_switch_scene import Example
    fixture = ROOT/'reconstruction/csrc'/{'materials': 'self_material_cloth_contact_scene.py',
                                        'cloth': 'self_cloth_scene.py', 'mesh': 'self_mesh_mixed_scene.py',
                                        'particles': 'self_particle_variants.py'}[suite]
    runtime = {'backend': backend, 'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
               'fixture_sha256': hashlib.sha256(fixture.read_bytes()).hexdigest(), 'suite': suite,
               'switch_fixture_sha256': hashlib.sha256(
                   (ROOT/'reconstruction/csrc/self_particle_valid_switch_scene.py').read_bytes()).hexdigest(),
               'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'frames': frames,
               'case_name': case_name}
    if suite == 'cloth':
        runtime['graph_wrapper_sha256'] = hashlib.sha256(
            (ROOT/'reconstruction/csrc/self_cloth_graph_scene.py').read_bytes()).hexdigest()
    elif suite == 'materials':
        runtime['graph_wrapper_sha256'] = hashlib.sha256(
            (ROOT/'reconstruction/csrc/self_material_graph_scene.py').read_bytes()).hexdigest()
    (output/(backend+'.runtime.json')).write_text(json.dumps(runtime, indent=2)+'\n')
    coverage, failures = {}, {}
    for name, options in cases(suite):
        if case_name and name != case_name:
            continue
        for graph in (0, 1):
            key = name+f'-g{graph}'
            try:
                scene = Example(None, Example.create_parser().parse_args(options))
                graphs = []
                if graph:
                    # Config values are kernel launch arguments. Capture each phase explicitly; do not
                    # assume changing a Python/C++ config field updates an already captured graph.
                    for phase in range(4):
                        scene.steps = phase
                        scene.configure()
                        source, destination = (scene.state_0, scene.state_1) if phase % 2 == 0 else \
                            (scene.state_1, scene.state_0)
                        with wp.ScopedCapture(device='cuda:0') as capture:
                            scene.solver.step(source, destination, scene.control, getattr(scene, 'contacts', None), 1/240)
                        graphs.append(capture.graph)
                    scene.steps = 0
                records = {'particle_q': [], 'particle_qd': []}
                for step in range(frames):
                    if graph:
                        scene.configure()
                        scene.state_0.clear_forces()
                        if getattr(scene, 'pipeline', None) is not None:
                            scene.pipeline.collide(scene.state_0, scene.contacts)
                        wp.capture_launch(graphs[step % 4])
                        scene.state_0, scene.state_1 = scene.state_1, scene.state_0
                        scene.steps += 1
                    else:
                        scene.step()
                    for key in records:
                        records[key].append(getattr(scene.state_0, key).numpy().copy())
                arrays = {key: np.asarray(value) for key, value in records.items()}
                assert all(np.isfinite(value).all() for value in arrays.values())
                np.savez_compressed(output/f'{backend}-{name}-g{graph}.npz', **arrays)
                if backend == 'source':
                    counts = dict(scene.solver._native_solver.source_launch_counts)
                    assert sum(counts.values()) > 0
                    coverage[name+f'-g{graph}'] = counts
                print(backend, name, graph, 'complete', flush=True)
            except (ValueError, RuntimeError) as error:
                failures[name+f'-g{graph}'] = [type(error).__name__, str(error)]
                print(backend, name, graph, failures[name+f'-g{graph}'], flush=True)
            (output/(backend+'-failures.json')).write_text(json.dumps(failures, indent=2)+'\n')
    if backend == 'source':
        (output/'source-coverage.json').write_text(json.dumps(coverage, indent=2)+'\n')
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--suite', choices=('particles', 'mesh', 'cloth', 'materials'), default='particles')
    parser.add_argument('--case-name', help='Run one unchanged fixture for a repeated original/source observation')
    args = parser.parse_args()
    if args.worker:
        return worker(args.worker, args.output, args.frames, args.suite, args.case_name)
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    workers = {}
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved
        command = [sys.executable, '-m', 'reconstruction.csrc.self_particle_graph_ab', '--worker', backend,
                   '--frames', str(args.frames), '--suite', args.suite, '--output', str(args.output)]
        if args.case_name:
            command += ['--case-name', args.case_name]
        with (args.output/(backend+'.log')).open('w') as log:
            workers[backend] = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                              timeout=1800).returncode
    report, missing = {}, []
    for name, _ in cases(args.suite):
        if args.case_name and name != args.case_name:
            continue
        for left, right, suffix in (
            ('original', 'source', '-g0'), ('original', 'source', '-g1'),
            ('original', 'original', ''), ('source', 'source', ''),
        ):
            a = args.output/f'{left}-{name}{suffix or "-g0"}.npz'
            b = args.output/f'{right}-{name}{suffix or "-g1"}.npz'
            key = f'{left}-{right}-{name}{suffix}'
            if not a.exists() or not b.exists():
                missing.append(key)
                continue
            with np.load(a) as first, np.load(b) as second:
                report[key] = compare(first, second)
    failures = [key for key, value in report.items() if not value['bitwise']]
    (args.output/'report.json').write_text(json.dumps({
        'source_sha256': json.loads(saved)['extension_sha256'], 'worker_exits': workers,
        'comparisons': report, 'missing': missing, 'strict_failures': failures}, indent=2)+'\n')
    print(json.dumps({'comparisons': len(report), 'workers': workers, 'missing': missing, 'strict_failures': failures}))
    return int(bool(missing or failures or any(workers.values())))


if __name__ == '__main__':
    raise SystemExit(main())
