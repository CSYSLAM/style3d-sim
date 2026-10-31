"""Compare compiled-source real Solver runs with version-pinned granular reference captures."""
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--references', type=Path, nargs='+', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    hook = ROOT/'build/reconstruction-csrc/granular-host/cudahook.so'
    example = ROOT/'reconstruction/csrc/granular_host_scene.py'
    schema, count = schemas()
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'LD_PRELOAD', 'CUDAHOOK_DIR',
            'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env['LD_PRELOAD'] = str(hook)
    reports = []
    for base in args.references:
        for runtime_path in sorted(base.glob('*/capture.runtime.json')):
            reference = runtime_path.parent.resolve()
            runtime = json.loads(runtime_path.read_text())
            assert runtime['backend'] == 'original' and runtime['image_sha256'] == REFERENCE_SHA
            assert runtime['example_sha256'] == hashlib.sha256(example.read_bytes()).hexdigest()
            assert runtime['launch_hook_sha256'] == hashlib.sha256(hook.read_bytes()).hexdigest()
            assert manifest.read_bytes() == saved, 'Source image changed during this batch'
            directory = args.output/reference.name
            directory.mkdir()
            env['CUDAHOOK_DIR'] = str(directory)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', 'source',
                       '--tag', 'capture', '--example', str(example), '--frames', str(runtime['frames']),
                       '--output', str(directory), '--', *runtime['extra']]
            (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
            with (directory/'run.log').open('w') as log:
                run = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=900)
            row = {'case': reference.name, 'reference': str(reference), 'worker_exit': run.returncode}
            if not run.returncode:
                left, right = np.load(reference/'capture.npz'), np.load(directory/'capture.npz')
                row['states_finite'] = all(np.isfinite(r[k]).all() for r in (left, right) for k in r.files)
                row['strict_states'] = compare(left, right)
                row['metadata'] = compare_launches(reference/'launches.txt', directory/'launches.txt', schema)
                launches = sum(json.loads((directory/'capture.launches.json').read_text()).values())
                row['source_hook_coverage'] = launches == row['metadata']['right_launches']
                row['library_runtime_launches_completely_observed'] = False
            (directory/'report.json').write_text(json.dumps(row, indent=2)+'\n')
            reports.append(row)
            (args.output/'report.json').write_text(json.dumps({'source_sha256': json.loads(saved)['extension_sha256'],
                'abi_entries_checked': count, 'cases': reports}, indent=2)+'\n')
            print(row['case'], row['worker_exit'], row.get('metadata', {}).get('equal'),
                  row.get('strict_states', {}).get('bitwise'), flush=True)
            if run.returncode:
                return run.returncode
    assert reports, 'No reference captures found'
    return int(any(not r['states_finite'] or not r['strict_states']['bitwise'] or not r['metadata']['equal'] or
                   not r['source_hook_coverage'] for r in reports))


if __name__ == '__main__':
    raise SystemExit(main())
