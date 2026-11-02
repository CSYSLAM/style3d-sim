"""Record original/source run distributions without changing strict bitwise comparisons or physics.

This reports only the distribution prerequisite from NATIVE_HOST_PROGRESS.md. Kernel schedule/arguments and the
cause of the first difference require separate captures before this observation can count as acceptance.
"""
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

import numpy as np

from reconstruction.demo_ab import compare, spread_report

ROOT = Path(__file__).resolve().parents[2]


def capture_dump_protocol(path):
    raw = json.loads(path.read_text())
    fields = raw.get('fields', raw)
    assert fields and all(isinstance(v, dict) and all(int(n) > 0 for n in v.values()) for v in fields.values())
    return {'fields': fields, 'dump_limit': 1, 'specification': str(path.resolve()),
            'specification_sha256': hashlib.sha256(path.read_bytes()).hexdigest()}


def apply_dump_protocol(env, protocol):
    if protocol:
        env['CUDAHOOK_DUMP'] = ';'.join(key+'='+','.join(f'{i}:{n}' for i, n in sizes.items())
                                       for key, sizes in protocol['fields'].items())
        env['CUDAHOOK_DUMP_LIMIT'] = str(protocol['dump_limit'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--example', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--original-runs', type=int, default=8)
    parser.add_argument('--source-runs', type=int, default=3)
    parser.add_argument('--original-baseline', type=Path, help='Reuse originals with matching image/example/frames')
    parser.add_argument('--reuse-original-runs', type=int, help='Reuse this many originals, then collect the remainder')
    parser.add_argument('--source-baseline', type=Path, help='Keep these exact source candidates while adding originals')
    parser.add_argument('--launch-hook', type=Path, help='Use this exact diagnostic hook for every new worker')
    parser.add_argument('--dump-spec', type=Path, help='Keep the adopted candidate\'s bounded dump/synchronization protocol')
    parser.add_argument('extra', nargs='*', help='Extra example arguments after --')
    args = parser.parse_args()
    if args.original_runs < 8 or args.source_runs < 3:
        parser.error('The agreed distribution observation requires at least 8 originals and 3 sources')
    if args.reuse_original_runs is not None and not args.original_baseline:
        parser.error('--reuse-original-runs requires --original-baseline')
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    expected = build.read_bytes()
    (args.output/'build.json').write_bytes(expected)
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD',
           'LD_PRELOAD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    hook_sha = None
    dump = capture_dump_protocol(args.dump_spec) if args.dump_spec else None
    if dump:
        assert args.launch_hook, 'A dump protocol requires its launch hook'
        (args.output/'launch-dump-spec.json').write_text(json.dumps(dump, indent=2)+'\n')
        apply_dump_protocol(env, dump)
    if args.launch_hook:
        args.launch_hook = args.launch_hook.resolve(strict=True)
        hook_sha = hashlib.sha256(args.launch_hook.read_bytes()).hexdigest()
        env['LD_PRELOAD'] = str(args.launch_hook)
    status = {'source_sha256': json.loads(expected)['extension_sha256'], 'completed': []}
    status['launch_hook_sha256'] = hook_sha
    jobs = []
    def reuse(tag, backend, directory, image_sha):
        previous_file = directory/'launch-dump-spec.json'
        previous = json.loads(previous_file.read_text()) if previous_file.exists() else None
        assert bool(previous) == bool(dump), 'Adopted capture synchronization protocol differs'
        if dump:
            assert previous['fields'] == dump['fields'] and previous['dump_limit'] == dump['dump_limit']
        example_sha = hashlib.sha256(Path(args.example).read_bytes()).hexdigest()
        runtime = json.loads((directory/f'{tag}.runtime.json').read_text())
        if (runtime['backend'] != backend or runtime['image_sha256'] != image_sha or
                runtime['example_sha256'] != example_sha or runtime['frames'] != args.frames or
                runtime['extra'] != args.extra or runtime.get('launch_hook_sha256') != hook_sha):
            raise ValueError(f'{tag}: inputs/version differ')
        for suffix in ('npz', 'runtime.json', 'log'):
            shutil.copy2(directory/f'{tag}.{suffix}', args.output/f'{tag}.{suffix}')
        digest = hashlib.sha256((args.output/f'{tag}.npz').read_bytes()).hexdigest()
        status['completed'].append({'tag': tag, 'exit': 0, 'reused_from': str(directory), 'npz_sha256': digest})

    if args.original_baseline:
        from .host_api_probe import REFERENCE_SHA
        count = args.original_runs if args.reuse_original_runs is None else args.reuse_original_runs
        if not 0 <= count <= args.original_runs:
            parser.error('Invalid original reuse count')
        for i in range(count):
            reuse(f'original{i}', 'original', args.original_baseline, REFERENCE_SHA)
        jobs += [('original', f'original{i}') for i in range(count, args.original_runs)]
    else:
        jobs += [('original', f'original{i}') for i in range(args.original_runs)]
    if args.source_baseline:
        for i in range(args.source_runs):
            reuse(f'source{i}', 'source', args.source_baseline, status['source_sha256'])
    else:
        jobs += [('source', f'source{i}') for i in range(args.source_runs)]
    for backend, tag in jobs:
        if build.read_bytes() != expected:
            raise RuntimeError('Source image changed during repeated runs')
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--example', args.example,
                   '--frames', str(args.frames), '--worker', backend, '--tag', tag, '--output', str(args.output),
                   '--', *args.extra]
        if args.launch_hook:
            hook_dir = args.output/(tag+'-hook')
            hook_dir.mkdir()
            env['CUDAHOOK_DIR'] = str(hook_dir.resolve())
        with (args.output/f'{tag}.log').open('w') as log:
            result = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=3600)
        status['completed'].append({'tag': tag, 'exit': result.returncode, 'command': command})
        (args.output/'status.json').write_text(json.dumps(status, indent=2)+'\n')
        print(tag, 'exit', result.returncode, flush=True)
        if result.returncode:
            return 2
    originals = [np.load(args.output/f'original{i}.npz') for i in range(args.original_runs)]
    sources = [np.load(args.output/f'source{i}.npz') for i in range(args.source_runs)]
    for run in originals + sources:
        if set(run.files) != set(originals[0].files):
            raise ValueError('Run field coverage differs')
        for key in run.files:
            if run[key].shape != originals[0][key].shape or not np.isfinite(run[key]).all():
                raise ValueError(f'Invalid/missing samples: {key}')
    source_stats = {f'source{i}': spread_report(originals, [run]) for i, run in enumerate(sources)}
    original_stats = {f'original{i}': spread_report(originals[:i]+originals[i+1:], [run])
                      for i, run in enumerate(originals)}
    observed = {}
    for name, fields in source_stats.items():
        observed[name] = {}
        for key, stats in fields.items():
            baseline = [run[key] for run in original_stats.values()]
            observed[name][key] = {
                'within_count_at_least_original_worst': stats['substeps_within_spread'] >=
                    min(row['substeps_within_spread'] for row in baseline),
                'ratio_no_larger_than_original_worst': stats['ratio_max'] <= max(row['ratio_max'] for row in baseline),
            }
    report = {'originals': args.original_runs, 'sources': args.source_runs,
              'source_sha256': status['source_sha256'], 'source_statistics': source_stats,
              'original_leave_one_out_statistics': original_stats, 'observations': observed,
              'strict_original_repeats': [compare(originals[0], run) for run in originals[1:]],
              'strict_sources': [compare(originals[0], run) for run in sources],
              'acceptance_requires_separate_capture_evidence': True}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    outside = [(tag, key, criterion) for tag, fields in observed.items() for key, checks in fields.items()
               for criterion, equal in checks.items() if not equal]
    print(json.dumps({'distribution_observation_outside': outside, 'strict_sources':
                     [r['bitwise'] for r in report['strict_sources']]}))
    return int(bool(outside))


if __name__ == '__main__':
    raise SystemExit(main())
