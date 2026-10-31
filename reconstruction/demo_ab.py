"""Bitwise A/B of an unmodified example script on the original library and on the reconstruction.

    .venv/bin/python -m reconstruction.demo_ab --example examples/example_body_spring.py --frames 60 \
        --output build/reconstruction-demos/body_spring

Runs the example twice in separate processes, once with the legacy `_core` (normal login, SHA-checked) and once
with the reconstructed core, records the solver output state after every substep and compares the float32 bit
patterns. `--repeat-native` adds a second legacy run to measure the original's own run-to-run spread.

Both backends run the same eager step path: `capture()` is replaced by a no-op (`graph = None`) because the Python
core cannot execute inside a CUDA graph. The example code itself is not modified.
"""
import argparse
import importlib.util
import json
import subprocess
import sys
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[1]


def _parser_for(module, path):
    import newton.examples
    if 'cable' in Path(path).parts:
        from examples.cable.cable_utils import create_cable_parser
        return create_cable_parser(Path(path).stem)
    example = module.Example
    if hasattr(example, 'create_parser'):
        return example.create_parser()
    parser = _main_block_parser(module, path)
    return parser if parser is not None else newton.examples.create_parser()


def _main_block_parser(module, path):
    """Replay the parser setup of a script that builds its parser inside `if __name__ == "__main__":`.

    Only the statements before the `newton.examples.init(...)` call are executed, so the demo itself is not started.
    """
    import ast
    tree = ast.parse(Path(path).read_text())
    for node in tree.body:
        test = getattr(node, 'test', None)
        if not (isinstance(node, ast.If) and isinstance(test, ast.Compare) and isinstance(test.left, ast.Name)
                and test.left.id == '__name__'):
            continue
        setup = []
        for statement in node.body:
            if 'init(' in ast.unparse(statement):
                break
            setup.append(statement)
        namespace = dict(vars(module))
        exec(compile(ast.Module(body=setup, type_ignores=[]), str(path), 'exec'), namespace)
        return namespace.get('parser')
    return None


def _patch_atomic_order(order):
    """Replace numerics.element_atomic_add with another warp order (ascending or random:<seed>).

    The legacy element kernels accumulate with red.global.add and the warp order changes from run to run, so the
    original is not reproducible against itself. Running the reconstruction with several warp orders gives a spread
    of the same nature to compare with the spread of repeated legacy runs.
    """
    from reconstruction import numerics
    rng = np.random.default_rng(int(order.split(':')[1])) if order.startswith('random:') else None
    if order != 'ascending' and rng is None:
        raise SystemExit(f'unknown atomic order {order}')

    def element_atomic_add(target, indices, values, valid=None, warp=32):
        starts = np.arange(0, len(indices), warp)
        for start in (starts if rng is None else rng.permutation(starts)):
            lanes = np.arange(start, min(start+warp, len(indices)))
            if valid is not None:
                lanes = lanes[valid[lanes]]
            for slot in range(indices.shape[1]):
                numerics.atomic_add_at(target, indices[lanes, slot], values[lanes, slot])
    numerics.element_atomic_add = element_atomic_add


def worker(args):
    import resource
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    sys.path.insert(0, str(ROOT))
    sys.path.insert(0, str(Path(args.example).resolve().parent))
    import warp as wp
    wp.config.kernel_cache_dir = str(ROOT/'build/reconstruction-warp')
    if args.backend == 'native':
        from reconstruction import validate
        validate.install_reference(validate.LEGACY)
        import style3d_sim._core as core
        assert Path(core.__file__).resolve() == validate.LEGACY.resolve(), core.__file__
    else:
        if args.atomic_order != 'descending':
            _patch_atomic_order(args.atomic_order)
        from reconstruction import core
        core.install()
    spec = importlib.util.spec_from_file_location('demo_under_test', args.example)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if not hasattr(module.Example, 'capture'):
        raise SystemExit('example has no capture() method; add a per-example adapter first')
    def eager_capture(self):
        # Some examples also branch on `use_graph` (e.g. copy-back of the final state with an odd substep count).
        self.graph = None
        self.use_graph = False
    module.Example.capture = eager_capture
    import newton.examples
    sys.argv = [Path(args.example).stem, '--viewer', 'null', '--num-frames', str(args.frames)] + args.extra
    viewer, demo_args = newton.examples.init(_parser_for(module, args.example))
    example = module.Example(viewer, demo_args)
    record = {'particle_q': [], 'particle_qd': [], 'body_q': [], 'body_qd': []}
    step = example.solver.step

    def recorded(state_in, state_out, *rest, **kw):
        step(state_in, state_out, *rest, **kw)
        for name in record:
            array = getattr(state_out, name, None)
            if array is not None and array.shape[0]:
                record[name].append(array.numpy().copy())
    example.solver.step = recorded
    out = Path(args.output)
    for frame in range(args.frames):
        example.step()
        if frame % 10 == 9 or frame == args.frames-1:
            np.savez_compressed(out/f'{args.tag}.npz', **{k: np.array(v) for k, v in record.items() if v})
    (out/f'{args.tag}.done').write_text(json.dumps({'frames': args.frames, 'substeps': len(record['body_q'] or
                                                                                          record['particle_q'])}))
    print('demo_ab_complete', flush=True)


def compare(a, b):
    """First differing substep and max abs difference per array (bit patterns of float32)."""
    report = {}
    for name in sorted(set(a.files) | set(b.files)):
        if name not in a.files or name not in b.files:
            report[name] = {'missing_in': 'native' if name not in a.files else 'candidate'}
            continue
        x, y = a[name], b[name]
        steps = min(len(x), len(y))
        same = [np.array_equal(x[t].view(np.uint32), y[t].view(np.uint32)) for t in range(steps)]
        first = same.index(False) if False in same else None
        report[name] = {'substeps': steps, 'length_match': len(x) == len(y), 'bitwise_substeps': int(sum(same)),
                        'first_diff_substep': first,
                        'max_abs': float(np.abs(x[:steps].astype(np.float64)-y[:steps]).max()) if steps else 0.0,
                        'nonfinite': bool(not np.isfinite(y[:steps]).all())}
    report['bitwise'] = all(isinstance(v, dict) and v.get('first_diff_substep', 0) is None and v.get('length_match')
                            for k, v in report.items() if k != 'bitwise')
    return report


def spread_report(natives, shims, checkpoints=12):
    """Compare reconstruction runs with the run-to-run spread of the legacy library.

    Per substep and array: each legacy run's max |run - mean(other legacy runs)| (leave-one-out, so the run is not
    compared with itself) gives the legacy spread; each reconstruction run's max |run - mean(all legacy runs)| is its
    error. `ratio` = worst reconstruction error / worst legacy spread at that substep; <= 1 means within the spread.
    """
    report = {}
    for name in sorted(set.intersection(*(set(r.files) for r in natives+shims))):
        steps = min(len(r[name]) for r in natives+shims)
        nat = np.stack([r[name][:steps].astype(np.float64) for r in natives])
        sim = np.stack([r[name][:steps].astype(np.float64) for r in shims])
        total = nat.sum(0)
        axes = tuple(range(1, nat.ndim-1))   # per run: (substeps, items, components) -> substeps
        legacy = np.stack([np.abs(nat[i]-(total-nat[i])/(len(nat)-1)).max(axis=axes) for i in range(len(nat))])
        error = np.stack([np.abs(sim[j]-total/len(nat)).max(axis=axes) for j in range(len(sim))])
        envelope, worst = legacy.max(0), error.max(0)
        with np.errstate(divide='ignore', invalid='ignore'):
            ratio = np.where(envelope > 0, worst/envelope, np.where(worst > 0, np.inf, 0.0))
        picks = sorted(set(np.linspace(0, steps-1, checkpoints).astype(int).tolist()))
        report[name] = {
            'substeps': steps, 'legacy_runs': len(nat), 'reconstruction_runs': len(sim),
            'legacy_spread_max': float(envelope.max()), 'reconstruction_error_max': float(worst.max()),
            'substeps_within_spread': int((worst <= envelope).sum()),
            'ratio_median': float(np.median(ratio)), 'ratio_max': float(ratio.max()),
            'checkpoints': {int(t): {'legacy_spread': float(envelope[t]), 'reconstruction_error': float(worst[t]),
                                     'ratio': float(ratio[t])} for t in picks}}
    return report


def run_backend(args, backend, tag, attempts=4, order='descending'):
    out = Path(args.output)
    for attempt in range(attempts):
        log = out/f'{tag}.log'
        cmd = [sys.executable, '-m', 'reconstruction.demo_ab', '--worker', backend, '--tag', tag,
               '--atomic-order', order,
               '--example', args.example, '--frames', str(args.frames), '--output', args.output, '--']+args.extra
        with open(log, 'w') as f:
            code = subprocess.run(cmd, cwd=ROOT, stdout=f, stderr=subprocess.STDOUT, timeout=args.timeout).returncode
        if (out/f'{tag}.done').exists():
            return code
        if backend == 'shim':
            break
        import time
        time.sleep(120)      # legacy login failures are intermittent
    return code


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--example', required=True)
    parser.add_argument('--frames', type=int, default=30)
    parser.add_argument('--output', required=True)
    parser.add_argument('--worker', choices=('native', 'shim'))
    parser.add_argument('--tag')
    parser.add_argument('--repeat-native', action='store_true')
    parser.add_argument('--timeout', type=int, default=7200)
    parser.add_argument('--native-runs', type=int, default=0,
                        help='spread mode: number of legacy runs (>= 3) instead of the single bitwise A/B')
    parser.add_argument('--shim-orders', default='descending,ascending,random:1,random:2',
                        help='spread mode: element-atomic warp orders for the reconstruction runs')
    parser.add_argument('--atomic-order', default='descending', help=argparse.SUPPRESS)
    parser.add_argument('extra', nargs='*', help='extra example arguments after --')
    args = parser.parse_args()
    if args.worker:
        args.backend = args.worker
        return worker(args)
    out = Path(args.output)
    out.mkdir(parents=True, exist_ok=True)
    if args.native_runs:
        return spread_main(args, out)
    codes = {'native': run_backend(args, 'native', 'native'), 'shim': run_backend(args, 'shim', 'shim')}
    if args.repeat_native:
        codes['native_repeat'] = run_backend(args, 'native', 'native_repeat')
    report = {'example': args.example, 'frames': args.frames, 'extra': args.extra, 'exit_codes': codes}
    files = {tag: out/f'{tag}.npz' for tag in codes}
    if all((out/f'{tag}.done').exists() for tag in codes):
        load = {tag: np.load(path) for tag, path in files.items()}
        report['shim_vs_native'] = compare(load['native'], load['shim'])
        if 'native_repeat' in load:
            report['native_vs_native'] = compare(load['native'], load['native_repeat'])
    else:
        report['incomplete'] = [tag for tag in codes if not (out/f'{tag}.done').exists()]
    (out/'report.json').write_text(json.dumps(report, indent=1))
    summary = report.get('shim_vs_native', {})
    print(json.dumps({'example': args.example, 'bitwise': summary.get('bitwise'), 'incomplete': report.get('incomplete'),
                      **{k: (v.get('bitwise_substeps'), v.get('substeps'), v.get('first_diff_substep'), v.get('max_abs'))
                         for k, v in summary.items() if isinstance(v, dict)}}))
    return 0 if summary.get('bitwise') else 1



def spread_main(args, out):
    """Legacy runs one after another (never concurrently), then the reconstruction with each warp order."""
    runs = {f'native{i}': ('native', 'descending') for i in range(args.native_runs)}
    runs.update({'shim_'+o.replace(':', ''): ('shim', o) for o in args.shim_orders.split(',')})
    codes = {}
    for tag, (backend, order) in runs.items():
        if not (out/f'{tag}.done').exists():      # resumable: finished runs are kept
            codes[tag] = run_backend(args, backend, tag, order=order)
    done = [tag for tag in runs if (out/f'{tag}.done').exists()]
    natives = [np.load(out/f'{t}.npz') for t in done if runs[t][0] == 'native']
    shims = [np.load(out/f'{t}.npz') for t in done if runs[t][0] == 'shim']
    report = {'example': args.example, 'frames': args.frames, 'runs': done, 'missing': sorted(set(runs)-set(done)),
              'exit_codes': codes}
    if len(natives) >= 3 and shims:
        report['spread'] = spread_report(natives, shims)
    (out/'spread.json').write_text(json.dumps(report, indent=1))
    print(json.dumps({'example': args.example, 'missing': report['missing'],
                      **{k: {f: v[f] for f in ('legacy_spread_max', 'reconstruction_error_max', 'substeps',
                                              'substeps_within_spread', 'ratio_median', 'ratio_max')}
                         for k, v in report.get('spread', {}).items()}}))
    return 0


if __name__ == '__main__':
    sys.exit(main() or 0)
