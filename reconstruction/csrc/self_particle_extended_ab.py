"""Serial real-solver PP host trajectories and complete owned launch comparison across boundary cases."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from .audit_cudahook import compare as compare_launches, schemas
from .demo_source_ab import ROOT
from .host_api_probe import REFERENCE_SHA
from reconstruction.demo_ab import compare


def cases():
    for worlds in (1, 2, 3):
        for mode in ('newton', 'pd'):
            for diagonal in (False, True):
                yield f'w{worlds}-{mode}-d{int(diagonal)}', 60, [
                    '--worlds', str(worlds), '--seed', str(worlds), '--mode', mode,
                    *(['--diagonal-only'] if diagonal else [])]
    for mode in ('newton', 'pd'):
        for worlds in (1, 3):
            yield f'subset-vary-w{worlds}-{mode}', 30, [
                '--subset', '--vary', '--worlds', str(worlds), '--seed', str(worlds+3), '--mode', mode]
        for count in (2, 3, 17, 257, 2115):
            yield f'n{count}-{mode}', 3 if count == 2115 else 10, ['--count', str(count), '--mode', mode]
        for switch in ('hessian', 'enabled', 'stiffness'):
            yield f'switch-{switch}-{mode}', 60, ['--mode', mode, '--switch', switch]
    for scale in ('0', '-1', 'nan'):
        for diagonal in (False, True):
            yield f'scale-{scale}-d{int(diagonal)}', 30, [
                '--scale', scale, *(['--diagonal-only'] if diagonal else [])]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--fixture', type=Path, default=ROOT/'reconstruction/csrc/self_particle_variants.py')
    parser.add_argument('--valid-only', action='store_true', help='Invalid factors are checked by the contract probe')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    build = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = build.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    fixture = args.fixture.resolve(strict=True)
    fixture_sha = hashlib.sha256(fixture.read_bytes()).hexdigest()
    hook = ROOT/'build/reconstruction-csrc/full-owned-hook-129/cudahook.so'
    hook_sha = hashlib.sha256(hook.read_bytes()).hexdigest()
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env['LD_PRELOAD'] = str(hook)
    reports = []
    for name, frames, extra in cases():
        if args.valid_only and name.startswith(('scale--1-', 'scale-nan-')):
            continue
        out = args.output/name
        out.mkdir()
        row = {'case': name, 'frames': frames, 'extra': extra, 'workers': {}}
        for backend in ('original', 'source'):
            directory = out/backend
            directory.mkdir()
            env['CUDAHOOK_DIR'] = str(directory)
            assert build.read_bytes() == saved
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                       '--tag', 'capture', '--example', str(fixture), '--frames', str(frames),
                       '--output', str(directory), '--', *extra]
            (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
            with (directory/'run.log').open('w') as log:
                code = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT,
                                      timeout=900).returncode
            row['workers'][backend] = code
            runtime = json.loads((directory/'capture.runtime.json').read_text())
            assert runtime['example_sha256'] == fixture_sha and runtime['launch_hook_sha256'] == hook_sha
            expected_image = REFERENCE_SHA if backend == 'original' else json.loads(saved)['extension_sha256']
            assert runtime['image_sha256'] == expected_image
        if not any(row['workers'].values()):
            with np.load(out/'original/capture.npz') as original, np.load(out/'source/capture.npz') as source:
                row['states'] = compare(original, source)
                row['finite'] = bool(all(np.isfinite(r[k]).all() for r in (original, source) for k in r.files))
            row['metadata'] = compare_launches(out/'original/launches.txt', out/'source/launches.txt', schemas()[0])
            row['hook_coverage'] = sum(json.loads((out/'source/capture.launches.json').read_text()).values()) == \
                row['metadata']['right_launches']
        row['passed'] = bool(not any(row['workers'].values()) and row.get('states', {}).get('bitwise') and
                             row['finite'] and row['metadata']['equal'] and row['hook_coverage'])
        reports.append(row)
        (out/'report.json').write_text(json.dumps(row, indent=2)+'\n')
        (args.output/'report.json').write_text(json.dumps({
            'source_sha256': json.loads(saved)['extension_sha256'], 'cases': reports,
            'library_runtime_launches_completely_observed': False}, indent=2)+'\n')
        print(name, 'passed', row['passed'], 'states', row.get('states', {}).get('bitwise'),
              'metadata', row.get('metadata', {}).get('equal'), flush=True)
    return int(any(not row['passed'] for row in reports))


if __name__ == '__main__':
    raise SystemExit(main())
