"""Serial hard-contact A/B, including matched history, query reuse, Newton/PD and replicated worlds."""
import argparse
import itertools
import json
import subprocess
import sys
from pathlib import Path

from reconstruction.csrc.demo_source_ab import ROOT


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--body-block', action='store_true')
    parser.add_argument('--frames', type=int, default=30)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    results = []
    for mode, worlds, variant in itertools.product(('newton', 'pd'), (1, 2, 3), range(4)):
        name = f'{mode}-w{worlds}-v{variant}'
        case = args.output/name
        extra = ['--mode', mode, '--worlds', str(worlds)]
        if variant:
            extra += ['--beta', '500']
        if variant >= 2:
            extra += ['--history', '--sliding']
        if variant == 3:
            extra += ['--reuse']
        if args.body_block:
            extra += ['--body-block']
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--example',
                   'reconstruction/csrc/hard_contact_scene.py', '--frames', str(args.frames), '--output', str(case),
                   '--', *extra]
        run = subprocess.run(command, cwd=ROOT)
        results.append({'case': name, 'exit': run.returncode})
        (args.output/'status.json').write_text(json.dumps(results, indent=2)+'\n')
        print(name, 'exit', run.returncode, flush=True)
        if run.returncode:
            return run.returncode
    return 0


if __name__ == '__main__':
    sys.exit(main())
