"""Run one real demo per backend, preserving strict state failures and full owned launch metadata."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--example', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--frames', type=int, default=60)
    parser.add_argument('--launch-hook', type=Path,
                        default=ROOT/'build/reconstruction-csrc/granular-host/cudahook.so')
    parser.add_argument('--timeout', type=int, default=1800)
    parser.add_argument('--original-reference', type=Path,
                        help='Reuse one immutable original capture after checking image, fixture, hook, frames and args')
    parser.add_argument('extra', nargs='*')
    args = parser.parse_args()
    assert args.frames > 0
    args.example = args.example.resolve()
    args.output = args.output.resolve()
    args.launch_hook = args.launch_hook.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook_hash = hashlib.sha256(args.launch_hook.read_bytes()).hexdigest()
    fixture_hash = hashlib.sha256(args.example.read_bytes()).hexdigest()
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env['LD_PRELOAD'] = str(args.launch_hook)
    for backend in ('original', 'source'):
        assert build.read_bytes() == saved, 'Source build changed during comparison'
        assert hashlib.sha256(args.example.read_bytes()).hexdigest() == fixture_hash
        assert hashlib.sha256(args.launch_hook.read_bytes()).hexdigest() == hook_hash
        directory = args.output/backend
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        if backend == 'original' and args.original_reference:
            reference = args.original_reference.resolve(strict=True)
            runtime = json.loads((reference/'capture.runtime.json').read_text())
            assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
            assert runtime['example_sha256'] == fixture_hash and runtime['launch_hook_sha256'] == hook_hash
            assert runtime['frames'] == args.frames and runtime['extra'] == args.extra
            adopted = []
            for name in ('capture.npz', 'capture.runtime.json', 'run.log', 'launches.txt', 'command.json'):
                source = reference/name
                shutil.copy2(source, directory/name)
                adopted.append({'from': str(source), 'sha256': hashlib.sha256(source.read_bytes()).hexdigest()})
            (args.output/'adopted-original.json').write_text(json.dumps(adopted, indent=2)+'\n')
            print('original reused with matching inputs and SHA guards', flush=True)
            continue
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(args.example), '--frames', str(args.frames),
                   '--output', str(directory), '--', *args.extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            run = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                 timeout=args.timeout)
        if run.returncode:
            failure = {'backend': backend, 'worker_exit': run.returncode, 'command': command}
            (args.output/'failure.json').write_text(json.dumps(failure, indent=2)+'\n')
            print(json.dumps(failure), flush=True)
            return 2
        runtime = json.loads((directory/'capture.runtime.json').read_text())
        expected_image = REFERENCE_SHA if backend == 'original' else json.loads(saved)['extension_sha256']
        assert runtime['image_sha256'] == expected_image and runtime['backend'] == backend
        assert runtime['example_sha256'] == fixture_hash and runtime['launch_hook_sha256'] == hook_hash
        print(backend, 'complete', flush=True)
    left, right = args.output/'original', args.output/'source'
    with np.load(left/'capture.npz') as original, np.load(right/'capture.npz') as source:
        finite = all(np.isfinite(r[k]).all() for r in (original, source) for k in r.files)
        states = compare(original, source)
    metadata = compare_launches(left/'launches.txt', right/'launches.txt', schemas()[0])
    coverage = sum(json.loads((right/'capture.launches.json').read_text()).values()) == metadata['right_launches']
    report = {'source_sha256': json.loads(saved)['extension_sha256'], 'hook_sha256': hook_hash,
              'example': str(args.example), 'frames': args.frames, 'extra': args.extra,
              'states_finite': bool(finite), 'strict_states': states, 'metadata': metadata,
              'source_hook_coverage': coverage, 'library_runtime_launches_completely_observed': False}
    (args.output/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print('finite', finite, 'strict', states['bitwise'], 'metadata', metadata['equal'],
          'coverage', coverage, 'launches', metadata['right_launches'], flush=True)
    return int(not finite or not states['bitwise'] or not metadata['equal'] or not coverage)


if __name__ == '__main__':
    raise SystemExit(main())
