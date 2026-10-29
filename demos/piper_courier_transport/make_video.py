"""Render and encode a complete courier scene video from its existing simulation cache."""

import argparse
import json
from pathlib import Path
import subprocess

import imageio_ffmpeg

HERE = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=HERE.parents[1] / 'build/courier-package')
    parser.add_argument('--blender', default='D:/software/blender/blender.exe')
    parser.add_argument('--encode-only', action='store_true')
    parser.add_argument('--hd', action='store_true', help='Native 1920x1080, 64 samples, separate output files.')
    args = parser.parse_args()
    folder = args.output.resolve()
    if not args.encode_only:
        script = 'render_hd.py' if args.hd else 'render_courier.py'
        subprocess.run([args.blender, '--background', '--python-exit-code', '1', '--python',
                        str(HERE / script), '--', '--output', str(folder)]
                       + ([] if args.hd else ['--animation']), check=True)
    ffmpeg = imageio_ffmpeg.get_ffmpeg_exe()
    video = folder / ('courier_package_transport_1080p.mp4' if args.hd else 'courier_package_transport.mp4')
    frame_folder = 'hd_frames' if args.hd else 'reference_frames'
    subprocess.run([ffmpeg, '-y', '-v', 'error', '-framerate', '30', '-start_number', '0',
                    '-i', str(folder / frame_folder / 'frame_%04d.png'), '-frames:v', '900',
                    '-c:v', 'libx264', '-preset', 'slow', '-crf', '16' if args.hd else '18',
                    '-pix_fmt', 'yuv420p', '-movflags', '+faststart', str(video)], check=True)
    subprocess.run([ffmpeg, '-v', 'error', '-i', str(video), '-f', 'null', '-'], check=True)
    frames, seconds = imageio_ffmpeg.count_frames_and_secs(str(video))
    if frames != 900 or abs(seconds - 30) > 0.05:
        raise RuntimeError(f'Incomplete video: {frames} frames, {seconds} seconds')
    report = 'video_verification_hd.json' if args.hd else 'video_verification.json'
    (folder / report).write_text(json.dumps(dict(
        video=str(video), frames=frames, seconds=seconds, full_decode_passed=True), indent=2), encoding='utf8')
    print(video, flush=True)


if __name__ == '__main__':
    main()
