"""Simulate, validate, render and encode the supplied reference-video reconstruction."""

import argparse
import json
from pathlib import Path
import subprocess
import sys

import imageio_ffmpeg

HERE = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=HERE.parents[1] / 'build/reference-match-8')
    parser.add_argument('--blender', type=Path, default=Path('D:/software/blender/blender.exe'))
    parser.add_argument('--render-only', action='store_true')
    args = parser.parse_args()
    folder = args.output.resolve()
    if not args.render_only:
        subprocess.run([sys.executable, str(HERE / 'demo_reference_package_transport.py'),
                        '--viewer=false', '--output', str(folder)], check=True)
    subprocess.run([sys.executable, str(HERE.parent / 'piper_package_transport/validate.py'), str(folder)], check=True)
    subprocess.run([str(args.blender), '--background', '--python-exit-code', '1', '--python',
                    str(HERE / 'render_reference.py'), '--', '--output', str(folder), '--animation'], check=True)
    subprocess.run([imageio_ffmpeg.get_ffmpeg_exe(), '-y', '-framerate', '30', '-start_number', '0',
                    '-i', str(folder / 'reference_frames/frame_%04d.png'), '-frames:v', '900',
                    '-c:v', 'libx264', '-crf', '18', '-pix_fmt', 'yuv420p', '-movflags', '+faststart',
                    str(folder / 'reference_reconstruction.mp4')], check=True)
    reference = Path(json.loads((HERE / 'reference_style.json').read_text(encoding='utf8'))['reference_video'])
    if reference.exists():
        subprocess.run([imageio_ffmpeg.get_ffmpeg_exe(), '-y', '-i', str(reference),
                        '-i', str(folder / 'reference_reconstruction.mp4'), '-filter_complex',
                        '[0:v]fps=30,scale=960:544,setsar=1[left];[1:v]setsar=1[right];'
                        '[left][right]hstack=inputs=2[v]', '-map', '[v]', '-an', '-frames:v', '900',
                        '-c:v', 'libx264', '-crf', '18', '-pix_fmt', 'yuv420p', '-movflags', '+faststart',
                        str(folder / 'reference_side_by_side.mp4')], check=True)


if __name__ == '__main__':
    main()
