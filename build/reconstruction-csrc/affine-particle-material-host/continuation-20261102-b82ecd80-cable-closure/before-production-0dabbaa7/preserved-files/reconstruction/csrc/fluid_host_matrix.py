"""Serial small-fluid host A/B across worlds, boundaries, viscosity, limiter controls and rigid coupling."""
import argparse
import itertools
import json
from pathlib import Path
import subprocess
import sys

from reconstruction.csrc.demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--keep-going', action='store_true', help='Record every case while retaining a failing exit status')
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    variants = [['--layout', 'isolated'], [],
                ['--boundaries', '--viscosity', '0', '--relaxation', '1', '--step-ratio', '0'],
                ['--boundaries', '--contacts', '--body', '--body-block']]
    status = []
    for mode, seed, variant in itertools.product(('newton', 'pd'), (1, 2, 3), range(len(variants))):
        name = f'{mode}-s{seed}-w{seed}-v{variant}'
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--example',
                   'reconstruction/csrc/fluid_host_scene.py', '--frames', '30', '--output', str(args.output/name),
                   '--', '--mode', mode, '--seed', str(seed), '--worlds', str(seed), *variants[variant]]
        run = subprocess.run(command, cwd=ROOT)
        status.append({'case': name, 'command': command, 'exit': run.returncode})
        (args.output/'status.json').write_text(json.dumps(status, indent=2)+'\n')
        if run.returncode and not args.keep_going:
            return run.returncode
    return int(any(row['exit'] for row in status))


if __name__ == '__main__':
    sys.exit(main())
