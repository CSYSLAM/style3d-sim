"""Record an unchanged example's real graph frames through the native public _core ABI, without an A/B bridge."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import runpy
import sys

import numpy as np

from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE, REFERENCE_SHA


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', choices=('original', 'source'), required=True)
    parser.add_argument('--core-build', type=Path, required=True)
    parser.add_argument('--example', type=Path, required=True)
    parser.add_argument('--frames', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('extra', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    assert args.frames > 0
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    metadata = json.loads(args.core_build.read_text())
    assert metadata['module'] == '_core' and metadata['source_only']
    image = REFERENCE if args.backend == 'original' else args.core_build.resolve().parent / REFERENCE.name
    expected = REFERENCE_SHA if args.backend == 'original' else metadata['extension_sha256']
    assert hashlib.sha256(image.read_bytes()).hexdigest() == expected
    for name, digest in metadata['sources'].items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == digest, name
    name = 'style3d_sim._core'
    assert name not in sys.modules
    spec = importlib.util.spec_from_file_location(name, image)
    core = importlib.util.module_from_spec(spec)
    sys.modules[name] = core
    spec.loader.exec_module(core)
    import style3d_sim as s3d
    import newton.examples
    assert s3d.Solver is core.Solver
    previous_run = newton.examples.run
    records = {key: [] for key in ('body_q', 'body_qd', 'particle_q', 'particle_qd')}
    graphs = []

    def recorded_run(example, options):
        original_step = example.step
        graph = getattr(example, 'graph', None)
        assert graph is not None, 'This worker requires a real captured example graph'
        graphs.append(graph)

        def step():
            original_step()
            state = example.state_0
            for key in records:
                array = getattr(state, key, None)
                if array is not None and array.shape[0]:
                    records[key].append(array.numpy().copy())

        example.step = step
        return previous_run(example, options)

    newton.examples.run = recorded_run
    example = args.example.resolve(strict=True)
    extra = args.extra[1:] if args.extra[:1] == ['--'] else args.extra
    sys.path.insert(0, str(example.parent))
    arguments = ['--viewer', 'null', '--num-frames', str(args.frames), '--test', *extra]
    sys.argv = [str(example), *arguments]
    runtime = {'backend': args.backend, 'image_sha256': expected, 'example_sha256': hashlib.sha256(example.read_bytes()).hexdigest(),
               'frames': args.frames, 'extra': extra, 'ab_bridge_used': False, 'public_core_abi': True,
               'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'exit': None,
               'reference_solver_mapped': None, 'whole_solver_complete': False}
    try:
        runpy.run_path(str(example), run_name='__main__')
        runtime['exit'] = 0
    except SystemExit as error:
        runtime['exit'] = error.code if isinstance(error.code, int) else int(error.code is not None)
        if runtime['exit']:
            raise
    except BaseException as error:
        runtime['exit'] = 1
        runtime['error'] = f'{type(error).__name__}: {error}'
        raise
    finally:
        runtime['reference_solver_mapped'] = str(REFERENCE.resolve()) in Path('/proc/self/maps').read_text()
        runtime['real_graph_observed'] = bool(graphs)
        runtime['recorded_frames'] = {key: len(values) for key, values in records.items()}
        (output / 'runtime.json').write_text(json.dumps(runtime, indent=2) + '\n')
    assert runtime['exit'] == 0 and graphs
    assert all(not values or len(values) == args.frames for values in records.values())
    assert any(records.values())
    assert runtime['reference_solver_mapped'] == (args.backend == 'original')
    arrays = {key: np.asarray(values) for key, values in records.items() if values}
    assert all(np.isfinite(array).all() for array in arrays.values())
    np.savez_compressed(output / 'states.npz', **arrays)
    from reconstruction.csrc.graph_definition_dump import dump_graph
    abi = json.loads(Path('/home/oem/code/agent/style3d-sim/build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-graph-definition/abi.json').read_text())
    for index, graph in enumerate(graphs):
        dump_graph(graph, output / ('definition-' + str(index)), abi)
    print(args.backend, 'public _core real graph and test completed', args.frames, flush=True)


if __name__ == '__main__':
    main()
