"""Run an unchanged example through the recovered public _core ABI, without the A/B bridge or reference SDK."""
import argparse
import hashlib
import json
import importlib.util
from pathlib import Path
import runpy
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--core-build', type=Path, required=True, help='build_core output build.json')
    parser.add_argument('--report', type=Path, help='Write a new execution record; existing records are never overwritten')
    parser.add_argument('example', type=Path)
    parser.add_argument('example_args', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    example = args.example.resolve(strict=True)
    if args.report:
        args.report = args.report.resolve()
        if args.report.exists():
            parser.error('The report already exists; choose a new path')
        args.report.parent.mkdir(parents=True, exist_ok=True)
    root = Path(__file__).resolve().parents[1]
    metadata = json.loads(args.core_build.read_text())
    assert metadata['module'] == '_core' and metadata['source_only']
    image = args.core_build.resolve().parent / '_core.cpython-312-x86_64-linux-gnu.so'
    assert hashlib.sha256(image.read_bytes()).hexdigest() == metadata['extension_sha256']
    for name, digest in metadata['sources'].items():
        assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
    name = 'style3d_sim._core'
    assert name not in sys.modules, 'Start a fresh process for the selected native backend'
    spec = importlib.util.spec_from_file_location(name, image)
    core = importlib.util.module_from_spec(spec)
    sys.modules[name] = core
    spec.loader.exec_module(core)
    assert core.source_only
    reference = root / 'style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so'
    def reference_mapped():
        return str(reference.resolve()) in Path('/proc/self/maps').read_text()
    import style3d_sim as s3d
    assert s3d.Solver is core.Solver
    assert not reference_mapped()
    counts = {}
    original_step = core.Solver.step

    def step(solver, *values, **keywords):
        result = original_step(solver, *values, **keywords)
        # Retain counters, not solver instances: example allocation lifetimes must remain unchanged.
        for name, value in solver.source_launch_counts.items():
            counts[name] = max(counts.get(name, 0), value)
        return result

    core.Solver.step = step
    arguments = args.example_args[1:] if args.example_args[:1] == ['--'] else args.example_args
    sys.path.insert(0, str(example.parent))
    sys.argv = [str(example), *arguments]
    report = {
        'example': str(example), 'example_sha256': hashlib.sha256(example.read_bytes()).hexdigest(),
        'arguments': arguments, 'source_image': str(Path(core.__file__).resolve()),
        'source_sha256': hashlib.sha256(Path(core.__file__).read_bytes()).hexdigest(),
        'source_only': True, 'solver_api_ready': bool(core.solver_api_ready),
        'public_core_abi': True, 'ab_bridge_used': False,
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'exit': 0,
        'reference_solver_mapped': False, 'source_launch_counts': counts,
        'count_semantics': 'Maximum observed per-instance counters; graph capture counted, graph replay not recounted',
    }
    print('source_core_abi', report['source_sha256'], 'solver_api_ready', report['solver_api_ready'], flush=True)
    try:
        runpy.run_path(str(example), run_name='__main__')
    except SystemExit as error:
        report['exit'] = error.code if isinstance(error.code, int) else int(error.code is not None)
        if report['exit']:
            raise
    except BaseException as error:
        report['exit'] = 1
        report['error'] = f'{type(error).__name__}: {error}'
        raise
    finally:
        report['reference_solver_mapped'] = reference_mapped()
        if not report['exit'] and not sum(counts.values()):
            report['exit'] = 1
            report['error'] = 'The example did not step the reconstructed native solver'
        if args.report:
            with args.report.open('x') as file:
                file.write(json.dumps(report, indent=2) + '\n')
        assert not report['reference_solver_mapped'], 'The reference solver was loaded during a source-only run'
    return report['exit']


if __name__ == '__main__':
    raise SystemExit(main())
