"""Fixed original/source cohorts of the unchanged cloth-balls example, eagerly and with its real CUDA graph."""
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

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare, spread_report


EXAMPLE = ROOT / 'examples/example_cloth_balls.py'


def worker(args):
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT / 'build/reconstruction-warp')
    if args.worker == 'original':
        from .host_api_probe import load_reference
        core = load_reference()
    else:
        from .host_bodies_ab import bridge
        from .host_particles_ab import native_source
        core = native_source()
        bridge(core)
    runtime = {'backend': args.worker, 'mode': args.mode, 'frames': args.frames,
               'image_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
               'example_sha256': hashlib.sha256(EXAMPLE.read_bytes()).hexdigest(),
               'harness_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
               'sample_axis': 'solver_substep' if args.mode == 'eager' else 'graph_frame'}
    (args.output / 'runtime.json').write_text(json.dumps(runtime, indent=2) + '\n')
    spec = importlib.util.spec_from_file_location('official_cloth_balls_under_test', EXAMPLE)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if args.mode == 'eager':
        def eager_capture(example):
            example.graph = None
        module.Example.capture = eager_capture
    import newton.examples
    sys.argv = [str(EXAMPLE), '--viewer', 'null', '--num-frames', str(args.frames)]
    viewer, options = newton.examples.init(module.Example.create_parser())
    example = module.Example(viewer, options)
    assert (example.graph is not None) == (args.mode == 'graph')
    record = {key: [] for key in ('particle_q', 'particle_qd', 'body_q', 'body_qd', 'rigid_count', 'soft_count')}

    def snapshot(state):
        for key in record:
            array = getattr(example.contacts, key.removesuffix('_count') + '_contact_count') if key.endswith('_count') \
                else getattr(state, key)
            record[key].append(array.numpy().copy())

    if args.mode == 'eager':
        step = example.solver.step

        def recorded(state_in, state_out, *values, **keywords):
            step(state_in, state_out, *values, **keywords)
            snapshot(state_out)

        example.solver.step = recorded
    for _ in range(args.frames):
        example.step()
        if args.mode == 'graph':
            snapshot(example.state_0)
    arrays = {key: np.asarray(value) for key, value in record.items()}
    expected = args.frames * (example.sim_substeps if args.mode == 'eager' else 1)
    assert all(len(value) == expected and np.isfinite(value).all() for value in arrays.values())
    np.savez_compressed(args.output / 'states.npz', **arrays)
    assert arrays['rigid_count'].max() > 0 and arrays['soft_count'].max() > 0
    native = example.solver._native_solver
    assert isinstance(native, core.Solver)
    physical = {'finite': True, 'real_graph': example.graph is not None, 'recorded_steps': expected,
                'substeps_per_frame': example.sim_substeps, 'physical_test_passed': False}
    try:
        example.test_final()
        physical['physical_test_passed'] = True
    finally:
        (args.output / 'physical.json').write_text(json.dumps(physical, indent=2) + '\n')
    if args.worker == 'source':
        counts = dict(native.source_launch_counts)
        assert counts and sum(counts.values()) > 0
        (args.output / 'launches.json').write_text(json.dumps(counts, indent=2) + '\n')
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
        (args.output / 'source-attestation.json').write_text(json.dumps({
            'source_only': bool(core.source_only), 'original_solver_mapped': False,
            'real_graph': example.graph is not None}, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--mode', choices=('eager', 'graph'))
    args = parser.parse_args()
    args.output = args.output.resolve()
    assert args.frames >= 30
    if args.worker:
        assert args.mode
        return worker(args)
    assert args.mode is None
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT / 'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    metadata = json.loads(saved)
    (args.output / 'build.json').write_bytes(saved)
    harness_sha = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    example_sha = hashlib.sha256(EXAMPLE.read_bytes()).hexdigest()
    env = {key: value for key, value in os.environ.items() if key not in (
        'STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP',
        'CUDAHOOK_DUMP_LIMIT', 'DEMO_MEMORY_TRACE_DIR', 'DEMO_NATIVE_TRACE_DIR', 'DEMO_NATIVE_TRACE_SUBSTEPS')}
    state = {'originals_per_mode': 8, 'sources_per_mode': 3, 'frames': args.frames, 'source0_replaced': False,
             'source_sha256': metadata['extension_sha256'], 'completed': [], 'running': None, 'complete': False}
    report = {'source_sha256': metadata['extension_sha256'], 'reference_sha256': REFERENCE_SHA,
              'full_solver_complete': False, 'modes': {}}

    def save():
        (args.output / 'status.json').write_text(json.dumps(state, indent=2) + '\n')

    for mode in ('eager', 'graph'):
        # Counts are fixed before observing output; retain the first actual original/source pair verbatim.
        jobs = [('original', 0), ('source', 0), *[('original', i) for i in range(1, 8)],
                ('source', 1), ('source', 2)]
        for backend, index in jobs:
            assert build.read_bytes() == saved
            assert hashlib.sha256(Path(__file__).read_bytes()).hexdigest() == harness_sha
            assert hashlib.sha256(EXAMPLE.read_bytes()).hexdigest() == example_sha
            folder = args.output / f'{mode}-{backend}{index}'
            folder.mkdir()
            command = [sys.executable, '-m', 'reconstruction.csrc.official_cloth_balls_ab', '--worker', backend,
                       '--mode', mode, '--frames', str(args.frames), '--output', str(folder)]
            (folder / 'command.json').write_text(json.dumps(command, indent=2) + '\n')
            state['running'] = folder.name
            save()
            with (folder / 'run.log').open('w') as log:
                code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                      timeout=3600).returncode
            assert code == 0, (folder, code)
            runtime = json.loads((folder / 'runtime.json').read_text())
            assert runtime['image_sha256'] == (REFERENCE_SHA if backend == 'original' else metadata['extension_sha256'])
            assert runtime['example_sha256'] == example_sha and runtime['harness_sha256'] == harness_sha
            assert json.loads((folder / 'physical.json').read_text())['physical_test_passed']
            state['completed'].append(folder.name)
            state['running'] = None
            save()
            print(folder.name, 'physical/finite passed', flush=True)
        with ExitStack() as stack:
            original = [stack.enter_context(np.load(args.output / f'{mode}-original{i}/states.npz')) for i in range(8)]
            sources = [stack.enter_context(np.load(args.output / f'{mode}-source{i}/states.npz')) for i in range(3)]
            rows = []
            for index, source in enumerate(sources):
                statistics = spread_report(original, [source], checkpoints=args.frames)
                outside = {key: value for key, value in statistics.items()
                           if value['substeps_within_spread'] != value['substeps']}
                rows.append({'source': index, 'strict': compare(original[0], source), 'statistics': statistics,
                             'every_step_within_spread': not outside, 'outside': list(outside)})
            report['modes'][mode] = {'sources': rows, 'primary_c_passed': all(
                row['every_step_within_spread'] for row in rows),
                'original_self_strict': [compare(original[0], run)['bitwise'] for run in original[1:]]}
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    state['complete'] = True
    save()
    report['primary_c_passed'] = all(mode['primary_c_passed'] for mode in report['modes'].values())
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('official cloth-balls fixed C', report['primary_c_passed'], flush=True)
    return int(not report['primary_c_passed'])


if __name__ == '__main__':
    raise SystemExit(main())
