"""Simulate, validate, render and encode without installing or changing Python packages."""

import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys

import imageio_ffmpeg

DIRECTORY = Path(__file__).resolve().parent


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=DIRECTORY / 'output_wrist_flick_drop')
    parser.add_argument('--blender', type=Path)
    parser.add_argument('--substeps', type=int, help='Override simulation substeps for this recording.')
    parser.add_argument('--render-only', action='store_true')
    parser.add_argument('--quality', choices=('preview', 'final'), default='preview')
    args = parser.parse_args(argv)
    output = args.output.resolve()
    if not args.render_only:
        simulation = [sys.executable, str(DIRECTORY / 'demo_piper_package_transport.py'),
                      '--viewer=false', '--output', str(output)]
        if args.substeps is not None:
            simulation.extend(('--substeps', str(args.substeps)))
        subprocess.run(simulation, check=True)
    subprocess.run([sys.executable, str(DIRECTORY / 'validate.py'), str(output)], check=True)
    if not (output / 'piper_materials.json').exists():
        subprocess.run([sys.executable, str(DIRECTORY / 'export_scene.py'), str(output / 'simulation.usdc')], check=True)
    blender = args.blender or shutil.which('blender')
    if not blender:
        candidate = Path('D:/Program Files/Blender Foundation/Blender 5.2/blender.exe')
        if candidate.exists():
            blender = candidate
    if not blender:
        parser.error('Specify the installed Blender executable with --blender.')
    subprocess.run([str(blender), '--background', '--python-exit-code', '1',
                    '--python', str(DIRECTORY / 'render_preview.py'),
                    '--', '--output', str(output), '--animation', '--quality', args.quality], check=True)
    render = json.loads((output / f'{args.quality}_render.json').read_text())
    fps = render['fps']
    preset, crf = ('slow', '16') if args.quality == 'final' else ('medium', '20')
    video = output / f'piper_package_transport_{args.quality}.mp4'
    subprocess.run([
        imageio_ffmpeg.get_ffmpeg_exe(), '-y', '-framerate', str(fps), '-start_number', '0',
        '-i', str(output / render['frame_directory'] / 'frame_%04d.png'), '-frames:v', str(render['frames']),
        '-c:v', 'libx264', '-preset', preset, '-crf', crf, '-pix_fmt', 'yuv420p',
        '-movflags', '+faststart', str(video),
    ], check=True)
    print(video)


if __name__ == '__main__':
    main()
