"""Render an existing .blend project, keeping hand-edited scene settings intact.

blender -b outputs/scene.blend --python demos/utils/render_frames.py -- --frames 0,60 --preview
blender -b outputs/scene.blend --python demos/utils/render_frames.py -- --animation
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

import bpy

sys.path.insert(0, str(Path(__file__).resolve().parent))
from usd_cache import validate_usd_sources  # noqa: E402


def select_device(scene, backend):
    if scene.render.engine != "CYCLES":
        if backend is not None:
            raise ValueError("--device is only supported for Cycles scenes")
        return
    if backend == "CPU" or (backend is None and scene.cycles.device == "CPU"):
        scene.cycles.device = "CPU"
        return
    prefs = bpy.context.preferences.addons["cycles"].preferences
    # Device preferences are machine-local, so restore a usable backend for a saved GPU project.
    backends = (backend,) if backend else ("OPTIX", "CUDA", "HIP", "ONEAPI", "METAL")
    for candidate in backends:
        try:
            prefs.compute_device_type = candidate
            prefs.get_devices()
        except (TypeError, RuntimeError):
            continue
        for device in prefs.devices:
            device.use = device.type == candidate
        if any(device.use for device in prefs.devices):
            scene.cycles.device = "GPU"
            return
    if backend:
        raise RuntimeError(f"No {backend} render device is available")
    scene.cycles.device = "CPU"


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--frames", help="Comma-separated frame indices")
    group.add_argument("--animation", action="store_true")
    parser.add_argument("--preview", action="store_true")
    parser.add_argument("--overwrite", action="store_true")
    parser.add_argument(
        "--output-dir", type=Path, help="Frame directory; defaults to frames/ or previews/ beside the .blend",
    )
    parser.add_argument("--config", type=Path, help="Optional JSON with preview_samples and preview_percentage")
    parser.add_argument("--device", choices=("CPU", "OPTIX", "CUDA", "HIP", "ONEAPI", "METAL"))
    args = parser.parse_args(sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else [])
    scene = bpy.context.scene
    if not bpy.data.filepath:
        raise RuntimeError("Load the saved .blend project before running this script")
    validate_usd_sources(scene)
    select_device(scene, args.device)
    folder = args.output_dir or Path(bpy.data.filepath).parent / ("previews" if args.preview else "frames")
    folder = folder.resolve()
    folder.mkdir(parents=True, exist_ok=True)
    if args.preview:
        cfg = json.loads(args.config.read_text(encoding="utf-8")) if args.config else {}
        if scene.render.engine == "CYCLES":
            scene.cycles.samples = cfg.get("preview_samples", 32)
        scene.render.resolution_percentage = cfg.get("preview_percentage", 60)
    frames = range(scene.frame_start, scene.frame_end + 1) if args.animation else map(int, args.frames.split(","))
    start = time.monotonic()
    for frame in frames:
        target = folder / f"frame_{frame:04d}.png"
        if target.exists() and not args.overwrite:
            print(f"SKIP {target.name}", flush=True)
            continue
        scene.frame_set(frame)
        scene.render.filepath = str(target)
        bpy.ops.render.render(write_still=True)
        print(f"FINISHED frame={frame} elapsed={time.monotonic() - start:.1f}s", flush=True)


if __name__ == "__main__":
    main()
