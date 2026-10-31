"""Capture the first real fluid grid/row evaluation, sizing dumps from a prior real launch log."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--template-log', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--example', type=Path, default=ROOT/'examples/example_fluid.py')
    parser.add_argument('--launch-hook', type=Path, default=ROOT/'build/reconstruction-csrc/bodies/cudahook.so')
    parser.add_argument('extra', nargs='*')
    args = parser.parse_args()
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    args.example = args.example.resolve(strict=True)
    args.launch_hook = args.launch_hook.resolve(strict=True)
    manifest = ROOT/'build/reconstruction-csrc/host-particles/build.json'
    saved = manifest.read_bytes()
    (args.output/'build.json').write_bytes(saved)
    (args.output/'provenance.json').write_text(json.dumps({'sha256': {
        str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__), args.example, args.launch_hook)
    }}, indent=2)+'\n')
    line = next(line for line in args.template_log.read_text().splitlines()
                if line.split()[1] == '12fluid_kernel13evaluate_rows')
    words = dict((int(offset), int(value, 16)) for offset, value in re.findall(r'(\d+):([0-9a-f]+)\(', line))
    view = struct.pack('<14Q', *(words[offset] for offset in range(0, 112, 8)))
    slots, points, local, rows = struct.unpack_from('<4i', view, 80)
    grid = {2: points*12, 3: points*4, 4: points*4, 5: points*4, 6: points*12, 7: slots*4, 8: points*4}
    inputs = {0: slots*4, 8: points*4, 16: points*4, 24: points*4, 32: points*12, 40: points*12, 48: points*4}
    outputs = {1: rows*12, 2: rows*4, 3: rows*4, 4: rows*4, 5: rows*64*4, 6: rows*64*16}
    specification = '12fluid_kernel10build_grid='+','.join(f'{i}:{size}' for i, size in grid.items())+';'
    specification += '12fluid_kernel13evaluate_rows='+','.join(
        [f'0+{offset}:{size}' for offset, size in inputs.items()] + [f'{i}:{size}' for i, size in outputs.items()])
    env = {k: v for k, v in os.environ.items() if k not in
           ('STYLE3D_SIM_ACCOUNT', 'STYLE3D_SIM_PASSWORD', 'CUDAHOOK_DIR', 'CUDAHOOK_DUMP', 'CUDAHOOK_DUMP_LIMIT')}
    env.update(LD_PRELOAD=str(args.launch_hook),
               CUDAHOOK_DUMP=specification, CUDAHOOK_DUMP_LIMIT='1')
    (args.output/'capture-settings.json').write_text(json.dumps(
        {'template': str(args.template_log.resolve()), 'slots': slots, 'points': points, 'local': local,
         'rows': rows, 'dump_specification': specification, 'extra': args.extra}, indent=2)+'\n')
    for backend, tag in [('original', 'original0'), ('original', 'original1'), ('original', 'original2'),
                         ('source', 'source0')]:
        assert manifest.read_bytes() == saved
        directory = args.output/tag
        directory.mkdir()
        env['CUDAHOOK_DIR'] = str(directory)
        command = [sys.executable, '-m', 'reconstruction.csrc.demo_source_ab', '--worker', backend,
                   '--tag', 'capture', '--example', str(args.example), '--frames', '1',
                   '--output', str(directory), '--',
                   *(['--no-capture'] if args.example.name == 'example_fluid.py' else []), *args.extra]
        (directory/'command.json').write_text(json.dumps(command, indent=2)+'\n')
        with (directory/'run.log').open('w') as log:
            run = subprocess.run(command, cwd=ROOT, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=600)
        print(tag, run.returncode, flush=True)
        if run.returncode:
            return run.returncode
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
