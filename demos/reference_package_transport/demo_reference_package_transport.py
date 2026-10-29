"""Run the package simulation used by the reference-video reconstruction."""

from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / 'piper_package_transport'))
from demo_piper_package_transport import main


if __name__ == '__main__':
    arguments = sys.argv[1:]
    if not any(arg == '--substeps' or arg.startswith('--substeps=') for arg in arguments):
        arguments += ['--substeps', '8']
    if not any(arg == '--output' or arg.startswith('--output=') for arg in arguments):
        arguments += ['--output', str(HERE.parents[1] / 'build/reference-match-8')]
    main(arguments)
