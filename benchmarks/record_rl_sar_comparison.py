#!/usr/bin/env python3
"""Record matching rl_sar rollouts and place MuJoCo beside SynReal."""

from __future__ import annotations

import argparse
import math
import os
import subprocess
import sys
from pathlib import Path

import imageio_ffmpeg

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
FPS = 50
ROBOTS = ("g1", "go2", "a1")


def _run_player(
    simulator: str, script: str, args: argparse.Namespace, output: Path
) -> None:
    command = [
        sys.executable,
        str(REPOSITORY_ROOT / "benchmarks" / script),
        "--robot",
        args.robot,
        "--cmd-vx",
        str(args.cmd_vx),
        "--cmd-vy",
        str(args.cmd_vy),
        "--cmd-yaw",
        str(args.cmd_yaw),
        "--duration",
        str(args.duration),
        "--width",
        str(args.width),
        "--height",
        str(args.height),
        "--record",
        str(output / f"{simulator}.mp4"),
        "--summary",
        str(output / f"{simulator}.summary.json"),
    ]
    if args.checkpoint is not None:
        command.extend(("--checkpoint", str(args.checkpoint.resolve())))
    if simulator == "mujoco":
        command.extend(("--trajectory", str(output / "mujoco.npz")))
    else:
        command.append("--headless")

    environment = os.environ.copy()
    if simulator == "mujoco":
        environment["MUJOCO_GL"] = "egl"
    subprocess.run(command, cwd=REPOSITORY_ROOT, env=environment, check=True)


def _validate_video(path: Path, expected_frames: int, duration: float) -> None:
    frames, seconds = imageio_ffmpeg.count_frames_and_secs(str(path))
    if frames != expected_frames or not math.isclose(
        seconds, duration, abs_tol=1.0 / FPS
    ):
        raise RuntimeError(
            f"video timing validation failed for {path}: "
            f"frames={frames}, seconds={seconds}, expected={expected_frames}/{duration:g}"
        )


def _combine_videos(left: Path, right: Path, output: Path) -> None:
    subprocess.run(
        [
            imageio_ffmpeg.get_ffmpeg_exe(),
            "-y",
            "-loglevel",
            "warning",
            "-i",
            str(left),
            "-i",
            str(right),
            "-filter_complex",
            "[0:v][1:v]hstack=inputs=2[v]",
            "-map",
            "[v]",
            "-an",
            "-c:v",
            "libx264",
            "-pix_fmt",
            "yuv420p",
            str(output),
        ],
        check=True,
    )


def run(args: argparse.Namespace) -> tuple[Path, Path, Path]:
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)

    _run_player("mujoco", "play_rl_sar_mujoco.py", args, output)
    _run_player("synreal", "play_rl_sar_synreal.py", args, output)

    mujoco_video = output / "mujoco.mp4"
    synreal_video = output / "synreal.mp4"
    comparison_video = output / "mujoco_left_synreal_right.mp4"
    expected_frames = round(args.duration * FPS)
    _validate_video(mujoco_video, expected_frames, args.duration)
    _validate_video(synreal_video, expected_frames, args.duration)
    _combine_videos(mujoco_video, synreal_video, comparison_video)
    _validate_video(comparison_video, expected_frames, args.duration)

    print(f"MuJoCo: {mujoco_video}")
    print(f"SynReal: {synreal_video}")
    print(f"comparison: {comparison_video}")
    return mujoco_video, synreal_video, comparison_video


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--robot", choices=ROBOTS, required=True)
    parser.add_argument("--checkpoint", type=Path)
    parser.add_argument("--cmd-vx", type=float, default=0.5)
    parser.add_argument("--cmd-vy", type=float, default=0.0)
    parser.add_argument("--cmd-yaw", type=float, default=0.0)
    parser.add_argument("--duration", type=float, default=10.0)
    parser.add_argument("--width", type=int, default=960)
    parser.add_argument("--height", type=int, default=544)
    parser.add_argument("--output", type=Path, required=True)
    return parser


def main() -> None:
    args = create_parser().parse_args()
    if args.duration <= 0 or args.width <= 0 or args.height <= 0:
        raise SystemExit("duration, width, and height must be positive")
    run(args)


if __name__ == "__main__":
    main()
