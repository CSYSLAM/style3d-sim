"""Serial real-Solver A/B for affine rigidity branches, retaining strict failures and full launch metadata."""
import argparse
import hashlib
import itertools
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

from reconstruction.csrc.audit_cudahook import compare as compare_launches, schemas
from reconstruction.demo_ab import compare

ROOT = Path(__file__).resolve().parents[2]
EXAMPLE = 'reconstruction/csrc/affine_rigidity_scene.py'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=30)
    parser.add_argument('--worlds', type=int, nargs='+', default=[1, 2, 3])
    parser.add_argument('--rigidity', nargs='+', default=['so3', 'springs', 'corotated', 'abd'])
    parser.add_argument('--reference-baseline', type=Path)
    parser.add_argument('--original-only', action='store_true')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/affine-host/cudahook.so'
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env['LD_PRELOAD'] = str(hook)
    schema, entries = schemas()
    results = []
    for worlds, rigidity, mode, variant in itertools.product(args.worlds, args.rigidity, ('newton', 'pd'),
                                                             ('default', 'block', 'zero', 'zero-block')):
        name = f'{rigidity}-{mode}-{variant}'
        case = args.output/f'w{worlds}-{name}'
        extra = ['--rigidity', rigidity, '--mode', mode]
        if variant in ('block', 'zero-block'):
            extra += ['--body-block']
        if variant in ('zero', 'zero-block'):
            extra += ['--alpha', '0']
        if worlds != 1:
            extra += ['--worlds', str(worlds)]
        for backend in ('original',) if args.original_only else ('original', 'source'):
            if manifest.read_bytes() != saved:
                raise RuntimeError('Source image changed during the batch')
            directory = case/backend
            directory.mkdir(parents=True)
            baseline = args.reference_baseline/name if args.reference_baseline else None
            nested = args.reference_baseline/f'w{worlds}-{name}'/'original' if args.reference_baseline else None
            if nested and nested.is_dir():
                baseline = nested
            if backend == 'original' and baseline and baseline.is_dir() and worlds == 1:
                runtime = json.loads((baseline/'capture.runtime.json').read_text())
                from reconstruction.csrc.host_api_probe import REFERENCE_SHA
                if (runtime['backend'] != 'original' or runtime['image_sha256'] != REFERENCE_SHA or
                    runtime['frames'] != args.frames or runtime['extra'] != extra or
                    runtime['example_sha256'] != hashlib.sha256((ROOT/EXAMPLE).read_bytes()).hexdigest() or
                    runtime['launch_hook_sha256'] != hashlib.sha256(hook.read_bytes()).hexdigest()):
                    raise RuntimeError(f'{baseline}: reference inputs differ')
                for file in baseline.iterdir():
                    if file.is_file():
                        shutil.copy2(file, directory/file.name)
                continue
            env['CUDAHOOK_DIR'] = str(directory)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                       '--tag', 'capture', '--example', EXAMPLE, '--frames', str(args.frames),
                       '--output', str(directory), '--', *extra]
            (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
            with (directory/'run.log').open('w') as log:
                run = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=600)
            if run.returncode:
                raise RuntimeError(f'{case.name}/{backend}: exit {run.returncode}')
        row = {'case': case.name}
        if not args.original_only:
            a, b = case/'original', case/'source'
            row['metadata'] = compare_launches(a/'launches.txt', b/'launches.txt', schema)
            left, right = np.load(a/'capture.npz'), np.load(b/'capture.npz')
            row['all_states_finite'] = all(np.isfinite(run[key]).all() for run in (left, right) for key in run.files)
            if not row['all_states_finite']:
                raise RuntimeError(f'{case.name}: nonfinite state')
            row['strict_states'] = compare(left, right)
            expected = sum(json.loads((b/'capture.launches.json').read_text()).values())
            row['source_hook_coverage'] = expected == row['metadata']['right_launches']
        (case/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        results.append(row)
        (args.output/'report.json').write_text(json.dumps({'abi_entries': entries,
            'source_sha256': json.loads(saved)['extension_sha256'], 'results': results}, indent=2)+'\n')
        print(case.name, row.get('metadata', {}).get('equal'), row.get('strict_states', {}).get('bitwise'), flush=True)
    return int(any(not row['metadata']['equal'] or not row['strict_states']['bitwise'] or
                   not row['source_hook_coverage'] for row in results)) if not args.original_only else 0


if __name__ == '__main__':
    raise SystemExit(main())
