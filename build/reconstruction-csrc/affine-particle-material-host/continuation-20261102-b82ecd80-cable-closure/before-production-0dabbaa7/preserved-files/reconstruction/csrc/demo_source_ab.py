"""A/B of an unmodified example: project-internal original _core (64a0be7f, no login) vs the compiled source solver.

    .venv/bin/python -m reconstruction.csrc.demo_source_ab --example examples/example_basic_dzhanibekov.py \
        --frames 60 [--original-runs 3]

Workers run strictly one after another (never two solver processes at once). Every solver substep's output state is
recorded and compared bit for bit (demo_ab.compare). With --original-runs > 1 the original is repeated; when it is
not reproducible against itself, demo_ab.spread_report gives the per-substep criterion C (source error vs the
original's leave-one-out spread). Like demo_ab, capture() is replaced by eager stepping so every substep is recorded.
"""
import argparse
import hashlib
import importlib.util
import inspect
import json
import os
import subprocess
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[2]


def worker(args):
    import resource
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    sys.path.insert(0, str(ROOT))
    sys.path.insert(0, str(Path(args.example).resolve().parent))
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if args.worker == 'original':
        from reconstruction.csrc.host_api_probe import load_reference
        core = load_reference()
    else:
        from reconstruction.csrc.host_bodies_ab import bridge
        from reconstruction.csrc.host_particles_ab import native_source
        core = native_source()
        assert core.source_only
        bridge(core)
    memory_directory = os.environ.get('DEMO_MEMORY_TRACE_DIR')
    if memory_directory:
        import ctypes
        memory_observer = ctypes.CDLL(None)
        memory_observer.solver_memory_trace_begin.argtypes = [ctypes.c_char_p, ctypes.c_char_p]
        memory_observer.solver_memory_trace_mark.argtypes = [ctypes.c_char_p]
        native_initialize = core.Solver.initialize

        def traced_initialize(solver, *values, **keywords):
            memory_observer.solver_memory_trace_begin(
                str(Path(memory_directory).resolve()).encode(), str(Path(core.__file__).resolve()).encode())
            result = native_initialize(solver, *values, **keywords)
            memory_observer.solver_memory_trace_mark(b'end_initialize')
            return result
        core.Solver.initialize = traced_initialize
    out = Path(args.output)
    image = Path(core.__file__)
    runtime = {'backend': args.worker, 'image': str(image.resolve()),
               'image_sha256': hashlib.sha256(image.read_bytes()).hexdigest(),
               'example': str(Path(args.example).resolve()),
               'example_sha256': hashlib.sha256(Path(args.example).read_bytes()).hexdigest(),
               'frames': args.frames, 'extra': args.extra}
    hook = os.environ.get('LD_PRELOAD')
    if hook and Path(hook).is_file():
        runtime['launch_hook_sha256'] = hashlib.sha256(Path(hook).read_bytes()).hexdigest()
    (out/f'{args.tag}.runtime.json').write_text(json.dumps(runtime, indent=2)+'\n')
    from reconstruction.demo_ab import _parser_for
    spec = importlib.util.spec_from_file_location('demo_under_test', args.example)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)

    def eager_capture(self):
        self.graph = None
        self.use_graph = False
    if not hasattr(module, 'Example'):
        raise SystemExit('example has no Example class (does not drive the solver through the harness)')
    if hasattr(module.Example, 'capture'):
        module.Example.capture = eager_capture
    elif 'ScopedCapture' in inspect.getsource(module.Example.step) and hasattr(module.Example, 'simulate'):
        # step() captures simulate() into a CUDA graph inline; record every substep by stepping eagerly instead.
        def eager_step(self):
            self.simulate()
            self.sim_time += self.frame_dt
        module.Example.step = eager_step
    import newton.examples
    sys.argv = [Path(args.example).stem, '--viewer', 'null', '--num-frames', str(args.frames)] + args.extra
    viewer, demo_args = newton.examples.init(_parser_for(module, args.example))
    example = module.Example(viewer, demo_args)
    record = {'particle_q': [], 'particle_qd': [], 'body_q': [], 'body_qd': []}
    step = example.solver.step
    trace_directory = os.environ.get('DEMO_NATIVE_TRACE_DIR')
    trace_substeps = int(os.environ.get('DEMO_NATIVE_TRACE_SUBSTEPS', '1'))
    observed_substeps = 0
    if trace_directory:
        import ctypes
        observer = ctypes.CDLL(None)
        observer.solver_trace_begin.argtypes = [ctypes.c_char_p]

    def recorded(state_in, state_out, *rest, **kw):
        nonlocal observed_substeps
        if trace_directory and observed_substeps == 0:
            observer.solver_trace_begin(str(Path(trace_directory).resolve()).encode())
        step(state_in, state_out, *rest, **kw)
        observed_substeps += 1
        if trace_directory and observed_substeps == trace_substeps:
            observer.solver_trace_end()
        for name in record:
            array = getattr(state_out, name, None)
            if array is not None and array.shape[0]:
                record[name].append(array.numpy().copy())
    example.solver.step = recorded
    for _ in range(args.frames):
        before = sum(len(values) for values in record.values())
        example.step()
        if sum(len(values) for values in record.values()) == before:
            raise RuntimeError('No solver substep recorded in this frame; adapt the example to eager execution')
    if memory_directory:
        memory_observer.solver_memory_trace_end()
    if not any(record.values()):
        raise RuntimeError('An empty state capture cannot establish equivalence')
    native = getattr(example.solver, '_native_solver', None)
    if not isinstance(native, core.Solver):
        raise RuntimeError('The example did not use the selected native SynReal Solver; check its --solver option')
    np.savez_compressed(out/f'{args.tag}.npz', **{k: np.array(v) for k, v in record.items() if v})
    if args.worker == 'source':
        counts = dict(native.source_launch_counts)
        if not counts or not sum(counts.values()):
            raise RuntimeError('The source Solver did not launch any compiled source kernels')
        (out/f'{args.tag}.launches.json').write_text(json.dumps(counts, indent=1)+'\n')
        assert '_core.cpython-' not in Path('/proc/self/maps').read_text(), 'original solver mapped in source worker'
    if os.environ.get('DEMO_POINTERS'):
        # Diagnostic: pointer -> Model span name, to name captured kernel arguments.
        model = getattr(example.solver, '_synreal_model', None)
        pointers = {hex(v.ptr): f'model.{n}[{v.size}]' for n in dir(model or object())
                    for v in [getattr(model, n, None)] if getattr(v, 'ptr', 0) and hasattr(v, 'size')}
        (out/f'{args.tag}.pointers.json').write_text(json.dumps(pointers, indent=1)+'\n')
    print('demo_source_ab_complete', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--example', required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--original-runs', type=int, default=1)
    parser.add_argument('--output')
    parser.add_argument('--worker', choices=('original', 'source'))
    parser.add_argument('--tag')
    parser.add_argument('--timeout', type=int, default=3600)
    parser.add_argument('extra', nargs='*', help='extra example arguments after --')
    args = parser.parse_args()
    out = Path(args.output or ROOT/'build/reconstruction-demos-source'/Path(args.example).stem)
    out.mkdir(parents=True, exist_ok=True)
    args.output = str(out)
    if args.worker:
        return worker(args)
    from reconstruction.demo_ab import compare, spread_report
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    tags = [('original', f'original{i}') for i in range(args.original_runs)] + [('source', 'source')]
    for backend, tag in tags:
        cmd = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend, '--tag', tag,
               '--example', args.example, '--frames', str(args.frames), '--output', str(out), '--'] + args.extra
        with (out/f'{tag}.log').open('w') as log:
            code = subprocess.run(cmd, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                  timeout=args.timeout).returncode
        if code or not (out/f'{tag}.npz').exists():
            print(json.dumps({'example': args.example, 'failed_worker': tag, 'exit': code}))
            return 2
    originals = [np.load(out/f'original{i}.npz') for i in range(args.original_runs)]
    source = np.load(out/'source.npz')
    report = {'example': args.example, 'frames': args.frames, 'bitwise': compare(originals[0], source)}
    if len(originals) > 1:
        report['original_self'] = [compare(originals[0], o)['bitwise'] for o in originals[1:]]
        if not all(report['original_self']) and len(originals) >= 3:
            report['spread'] = spread_report(originals, [source])
    (out/'report.json').write_text(json.dumps(report, indent=1)+'\n')
    summary = {'example': args.example, 'bitwise': report['bitwise']['bitwise'],
               'original_self_bitwise': report.get('original_self'),
               'first_diff': {k: v.get('first_diff_substep') for k, v in report['bitwise'].items()
                              if isinstance(v, dict) and v.get('first_diff_substep') is not None}}
    print(json.dumps(summary))
    return 0 if report['bitwise']['bitwise'] else 1


if __name__ == '__main__':
    sys.exit(main())
