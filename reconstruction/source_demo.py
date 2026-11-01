"""Run an unchanged example with the reconstructed source solver, without loading the reference SDK."""
import argparse
import hashlib
import json
from pathlib import Path
import runpy
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
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
    from .csrc.host_particles_ab import native_source
    from .csrc.host_bodies_ab import bridge
    core = native_source()
    assert core.source_only
    bridge(core)
    import style3d_sim as s3d
    assert s3d.Solver is core.Solver
    assert '_core.cpython-' not in Path('/proc/self/maps').read_text()
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
        'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), 'exit': 0,
        'reference_solver_mapped': False, 'source_launch_counts': counts,
        'count_semantics': 'Maximum observed per-instance counters; graph capture counted, graph replay not recounted',
    }
    print('source_solver', report['source_sha256'], 'solver_api_ready', report['solver_api_ready'], flush=True)
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
        report['reference_solver_mapped'] = '_core.cpython-' in Path('/proc/self/maps').read_text()
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
