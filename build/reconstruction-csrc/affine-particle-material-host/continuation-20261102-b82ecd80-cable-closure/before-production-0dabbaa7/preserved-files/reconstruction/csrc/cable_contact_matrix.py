"""Serial cable/contact combinations, including full blocks, history reuse and contact capacity growth."""
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
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    status = []
    variants = [[], ['--body-block'], ['--hard', '--history', '--reuse'],
                ['--hard', '--history', '--reuse', '--body-block'],
                ['--hard', '--history', '--reuse', '--body-block', '--no-contact-block', '--grow-contacts']]
    for mode, seed, variant in itertools.product(('newton', 'pd'), (1, 2, 3), range(len(variants))):
        name = f'{mode}-s{seed}-w{seed}-v{variant}'
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--example',
                   'reconstruction/csrc/cable_contact_scene.py', '--frames', '30', '--output', str(args.output/name),
                   '--', '--mode', mode, '--seed', str(seed), '--worlds', str(seed), *variants[variant]]
        run = subprocess.run(command, cwd=ROOT)
        status.append({'case': name, 'command': command, 'exit': run.returncode})
        (args.output/'status.json').write_text(json.dumps(status, indent=2)+'\n')
        if run.returncode:
            return run.returncode
    return 0


if __name__ == '__main__':
    sys.exit(main())
