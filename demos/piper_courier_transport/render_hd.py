"""Render the approved courier scene at native Full HD with higher sampling."""

import argparse
from pathlib import Path
import sys

import bpy

ROOT = Path(__file__).resolve().parents[2]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'build/courier-package')
    parser.add_argument('--frames', default=None)
    args = parser.parse_args(sys.argv[sys.argv.index('--') + 1:])
    folder = args.output.resolve()
    bpy.ops.wm.open_mainfile(filepath=str(folder / 'reference_scene.blend'))
    scene = bpy.context.scene
    scene.render.resolution_x = 1920
    scene.render.resolution_y = 1080
    scene.render.resolution_percentage = 100
    scene.cycles.samples = 64
    scene.cycles.use_adaptive_sampling = True
    scene.cycles.adaptive_threshold = 0.02
    scene.cycles.use_denoising = True
    scene.render.use_persistent_data = True
    scene.render.image_settings.file_format = 'PNG'
    scene.render.image_settings.color_depth = '8'
    target = folder / 'hd_frames'
    target.mkdir(exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=str(folder / 'courier_hd.blend'))
    frames = range(900) if args.frames is None else [int(item) for item in args.frames.split(',')]
    for frame in frames:
        destination = target / f'frame_{frame:04d}.png'
        if destination.exists():
            continue
        scene.frame_set(frame)
        scene.render.filepath = str(destination)
        bpy.ops.render.render(write_still=True)
        print(f'HD_FRAME {frame}', flush=True)


if __name__ == '__main__':
    main()
