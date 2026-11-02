"""Serial cable host comparisons, including penalty API state and legal ramp boundaries."""
import argparse
import hashlib
import itertools
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np

from reconstruction.demo_ab import compare
from reconstruction.csrc.demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True)
    parser.add_argument('--body-block', action='store_true')
    args = parser.parse_args()
    output = Path(args.output).resolve()
    output.mkdir(parents=True, exist_ok=False)
    results = []
    configs = [(0, 0, .93, False), (150, 0, .93, False), (150, 150, .93, True), (150, 150, 1., True)]
    env = {k: v for k, v in os.environ.items() if k not in ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD')}
    for mode, (linear, angular, gamma, actions), seed in itertools.product(('newton', 'pd'), configs, (1, 2, 3)):
        name = f'{mode}-s{seed}-w{seed}-b{linear}-{angular}-g{gamma}-a{int(actions)}'
        case = output/name
        extra = ['--mode', mode, '--seed', str(seed), '--worlds', str(seed), '--linear-beta', str(linear),
                 '--angular-beta', str(angular), '--gamma', str(gamma)] + (['--penalty-actions'] if actions else [])
        if args.body_block:
            extra += ['--body-block']
        for backend in ('original', 'source'):
            directory = case/backend
            directory.mkdir(parents=True)
            command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                       '--tag', 'capture', '--example', 'reconstruction/csrc/cable_host_scene.py',
                       '--frames', '30', '--output', str(directory), '--', *extra]
            with (directory/'run.log').open('w') as log:
                run = subprocess.run(command, cwd=ROOT, env={**env, 'CABLE_PROBE_DIR': str(directory)},
                                     stdout=log, stderr=subprocess.STDOUT, timeout=900)
            if run.returncode:
                raise RuntimeError(f'{name}/{backend} exited {run.returncode}; see {directory}/run.log')
        state = compare(np.load(case/'original/capture.npz'), np.load(case/'source/capture.npz'))
        penalty = {}
        if actions:
            with np.load(case/'original/penalties.npz') as ref, np.load(case/'source/penalties.npz') as src:
                assert ref.files == src.files
                penalty = {k: ref[k].tobytes() == src[k].tobytes() for k in ref.files}
        report = {'case': name, 'state': state, 'penalty': penalty,
                  'bitwise': state['bitwise'] and all(penalty.values())}
        (case/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        results.append(report)
        (output/'summary.json').write_text(json.dumps(results, indent=2)+'\n')
        print(name, report['bitwise'], len(penalty), flush=True)
        if not report['bitwise']:
            return 1
    manifest = {str(p.relative_to(output)): hashlib.sha256(p.read_bytes()).hexdigest()
                for p in output.rglob('*') if p.is_file()}
    (output/'hashes.json').write_text(json.dumps(manifest, indent=2)+'\n')
    return 0


if __name__ == '__main__':
    sys.exit(main())
