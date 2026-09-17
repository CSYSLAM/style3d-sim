# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Authors
# SPDX-License-Identifier: Apache-2.0

"""Compare Synreal and Genesis with parallel Unitree H1 simulation worlds.

Examples:
    python benchmarks/benchmark_robot_h1_genesis.py --solver genesis --world-count 1024 --headless
    python benchmarks/benchmark_robot_h1_genesis.py --solver synreal --world-count 1024 --headless
"""

from __future__ import annotations

import argparse
import csv
import json
import platform
import statistics
import subprocess
import sys
from datetime import datetime, timezone
from importlib import metadata as importlib_metadata
from pathlib import Path
from time import perf_counter

FRAME_DT = 1.0 / 50.0
SIM_SUBSTEPS = 4
DEFAULT_WORLD_COUNT = 16


def positive_int(value: str) -> int:
    parsed = int(value)
    if parsed <= 0:
        raise argparse.ArgumentTypeError("must be greater than zero")
    return parsed


def non_negative_int(value: str) -> int:
    parsed = int(value)
    if parsed < 0:
        raise argparse.ArgumentTypeError("must be zero or greater")
    return parsed


class BenchmarkProgress:
    def __init__(self, total: int):
        self.total = total
        self.interactive = sys.stdout.isatty()
        report_count = 20 if self.interactive else 10
        self.report_interval = max(1, (total + report_count - 1) // report_count)
        self.next_report = self.report_interval
        self.line_width = 0

    def start(self) -> None:
        self._write(f"Benchmark progress:   0.0% (0/{self.total} frames submitted)")

    def update(self, completed: int) -> None:
        if completed < self.next_report and completed < self.total:
            return
        percent = 100.0 * completed / self.total
        self._write(
            f"Benchmark progress: {percent:5.1f}% "
            f"({completed}/{self.total} frames submitted)"
        )
        while self.next_report <= completed:
            self.next_report += self.report_interval

    def waiting_for_gpu(self, completed: int) -> None:
        self._write(
            f"Benchmark progress: frames submitted ({completed}/{self.total}); "
            "waiting for GPU"
        )

    def finish(self, completed: int) -> None:
        if completed == self.total:
            message = f"Benchmark progress: 100.0% ({completed}/{self.total} frames complete)"
        else:
            message = f"Benchmark progress: stopped ({completed}/{self.total} frames complete)"
        self._write(message, final=True)

    def _write(self, message: str, *, final: bool = False) -> None:
        if self.interactive:
            padded = message.ljust(self.line_width)
            print(f"\r{padded}", end="\n" if final else "", flush=True)
            self.line_width = max(self.line_width, len(message))
        else:
            print(message, flush=True)


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Compare Synreal and Genesis on parallel Unitree H1 worlds."
    )
    parser.add_argument(
        "--solver",
        choices=("synreal", "genesis"),
        default="genesis",
        help="physics solver to benchmark (default: genesis)",
    )
    parser.add_argument(
        "--world-count",
        "--worlds",
        type=positive_int,
        default=DEFAULT_WORLD_COUNT,
        help=f"number of parallel simulation worlds (default: {DEFAULT_WORLD_COUNT})",
    )
    parser.add_argument(
        "--steps",
        type=positive_int,
        default=1000,
        help="number of measured 50 Hz frames (default: 1000)",
    )
    parser.add_argument(
        "--warmup-steps",
        type=non_negative_int,
        default=20,
        help="number of untimed warm-up frames (default: 20)",
    )
    parser.add_argument(
        "--repeats",
        type=positive_int,
        default=1,
        help="number of independent measured runs (default: 1)",
    )
    parser.add_argument(
        "--headless",
        action="store_true",
        help="disable rendering for performance measurement",
    )
    parser.add_argument(
        "--asset-file",
        type=Path,
        help=(
            "custom H1 asset: h1.urdf for Genesis or h1.usda for Synreal "
            "(default: the unitree_h1 Newton asset)"
        ),
    )
    parser.add_argument(
        "--output",
        type=Path,
        help="write structured results to a .json or .csv file",
    )
    return parser


def resolve_asset_file(asset_file: Path | None, solver: str) -> Path:
    if asset_file is not None:
        resolved = asset_file.expanduser().resolve()
    else:
        try:
            import newton.utils
        except ImportError as exc:
            raise SystemExit(
                "Could not locate the H1 asset because Newton is not installed. "
                "Pass its path with --asset-file."
            ) from exc
        asset_root = newton.utils.download_asset("unitree_h1")
        if solver == "genesis":
            resolved = asset_root / "urdf" / "h1.urdf"
        else:
            resolved = asset_root / "usd_structured" / "h1.usda"

    if not resolved.is_file():
        raise SystemExit(f"H1 asset file does not exist: {resolved}")
    return resolved


def synchronize_torch(device) -> None:
    if device.type == "cuda":
        import torch

        torch.cuda.synchronize(device)


def _show_genesis_loading_window(stop_event) -> None:
    try:
        import tkinter as tk
        from tkinter import ttk
    except ImportError:
        return

    try:
        root = tk.Tk()
        root.title("Genesis H1")
        root.resizable(False, False)
        root.attributes("-topmost", True)

        panel = ttk.Frame(root, padding=24)
        panel.grid()
        ttk.Label(panel, text="Building Genesis GPU scene...").grid(sticky="w")
        progress = ttk.Progressbar(panel, mode="indeterminate", length=320)
        progress.grid(pady=(14, 0))
        progress.start(12)

        root.update_idletasks()
        x = (root.winfo_screenwidth() - root.winfo_width()) // 2
        y = (root.winfo_screenheight() - root.winfo_height()) // 2
        root.geometry(f"+{x}+{y}")

        def poll_stop_event() -> None:
            if stop_event.is_set():
                root.destroy()
            else:
                root.after(100, poll_stop_event)

        root.after(100, poll_stop_event)
        root.mainloop()
    except (OSError, RuntimeError, tk.TclError):
        # A loading indicator must never prevent the simulation from starting.
        return


def start_genesis_loading_window():
    from multiprocessing import get_context

    context = get_context("spawn")
    stop_event = context.Event()
    process = context.Process(
        target=_show_genesis_loading_window,
        args=(stop_event,),
        daemon=True,
    )
    process.start()
    return process, stop_event


def stop_genesis_loading_window(handle) -> None:
    process, stop_event = handle
    stop_event.set()
    process.join(timeout=2.0)
    if process.is_alive():
        process.terminate()
        process.join()


def run_genesis(
    args: argparse.Namespace,
    asset_file: Path,
    loading_window=None,
) -> tuple[str, list[tuple[int, float]]]:
    try:
        import genesis as gs
        import torch
    except ImportError as exc:
        raise SystemExit(
            "Genesis is required to run this benchmark. Install the genesis-world package first."
        ) from exc
    if not hasattr(gs, "init"):
        raise SystemExit(
            "The installed 'genesis' package is not the Genesis simulator. Remove it with "
            "'uv pip uninstall genesis', then reinstall the simulator with "
            "'uv pip install --reinstall genesis-world'."
        )

    gs.init(
        backend=gs.gpu,
        performance_mode=args.headless,
        logging_level="warning",
    )
    if gs.device.type != "cuda":
        raise SystemExit(
            "Genesis fell back to CPU. Install a CUDA-enabled PyTorch "
            "build (for example: uv pip install --reinstall --torch-backend cu128 "
            "torch==2.9.1 torchvision==0.24.1)."
        )

    scene = gs.Scene(
        sim_options=gs.options.SimOptions(
            dt=FRAME_DT,
            substeps=SIM_SUBSTEPS,
        ),
        rigid_options=gs.options.RigidOptions(
            enable_self_collision=False,
            constraint_solver=gs.constraint_solver.Newton,
            iterations=20,
            ls_iterations=10,
        ),
        viewer_options=gs.options.ViewerOptions(
            camera_pos=(4.0, -4.0, 2.5),
            camera_lookat=(0.0, 0.0, 1.0),
            camera_fov=40,
        ),
        vis_options=gs.options.VisOptions(rendered_envs_idx=[0]),
        show_viewer=not args.headless,
    )

    scene.add_entity(
        gs.morphs.Plane(),
        material=gs.materials.Rigid(friction=0.75),
    )
    robot = scene.add_entity(
        gs.morphs.URDF(
            file=str(asset_file),
            pos=(0.0, 0.0, 1.06),
            fixed=False,
        ),
        material=gs.materials.Rigid(friction=0.75),
    )
    try:
        scene.build(n_envs=args.world_count, env_spacing=(3.0, 3.0))
    finally:
        if loading_window is not None:
            stop_genesis_loading_window(loading_window)

    actuated_dofs = slice(6, robot.n_dofs)
    target = torch.zeros(
        (args.world_count, robot.n_dofs - 6),
        dtype=gs.tc_float,
        device=gs.device,
    )
    robot.set_dofs_kp(
        torch.full_like(target[0], 150.0),
        dofs_idx_local=actuated_dofs,
    )
    robot.set_dofs_kv(
        torch.full_like(target[0], 5.0),
        dofs_idx_local=actuated_dofs,
    )
    robot.control_dofs_position(target, dofs_idx_local=actuated_dofs)

    step_options = {
        "update_visualizer": not args.headless,
        "refresh_visualizer": not args.headless,
    }
    measurements: list[tuple[int, float]] = []
    for repeat in range(1, args.repeats + 1):
        if args.repeats > 1:
            print(f"Run {repeat}/{args.repeats}")
        for _ in range(args.warmup_steps):
            scene.step(**step_options)
        synchronize_torch(gs.device)

        progress = BenchmarkProgress(args.steps)
        progress.start()
        start = perf_counter()
        for frame in range(args.steps):
            scene.step(**step_options)
            progress.update(frame + 1)
        progress.waiting_for_gpu(args.steps)
        synchronize_torch(gs.device)
        elapsed = perf_counter() - start
        progress.finish(args.steps)
        measurements.append((args.steps, elapsed))

    return gs.device.type, measurements


def run_synreal(
    args: argparse.Namespace, asset_file: Path
) -> tuple[str, list[tuple[int, float]]]:
    import newton
    import newton.viewer
    import synreal_solver
    import warp as wp
    from newton import JointTargetMode

    wp.set_device("cuda")

    h1 = newton.ModelBuilder()
    h1.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
        limit_ke=1.0e3,
        limit_kd=1.0e1,
        friction=1.0e-5,
    )
    h1.default_shape_cfg.ke = 2.0e3
    h1.default_shape_cfg.kd = 1.0e2
    h1.default_shape_cfg.kf = 1.0e3
    h1.default_shape_cfg.mu = 0.75
    h1.add_usd(
        str(asset_file),
        ignore_paths=["/GroundPlane"],
        enable_self_collisions=False,
    )
    h1.approximate_meshes("bounding_box")

    for dof in range(len(h1.joint_target_ke)):
        h1.joint_target_ke[dof] = 150
        h1.joint_target_kd[dof] = 5
        h1.joint_target_mode[dof] = int(JointTargetMode.POSITION)

    builder = newton.ModelBuilder()
    builder.replicate(h1, args.world_count)
    builder.default_shape_cfg.ke = 1.0e3
    builder.default_shape_cfg.kd = 1.0e2
    builder.add_ground_plane()

    model = builder.finalize()
    solver = synreal_solver.NewtonSolver(model)
    solver.config.constraint_alpha = 200
    solver.config.nonlinear_iterations = 10
    solver.config.linear_iterations = 10

    state_0 = model.state()
    state_1 = model.state()
    control = model.control()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_0)

    collision_pipeline = newton.CollisionPipeline(model)
    contacts = collision_pipeline.contacts()
    if args.headless:
        viewer = newton.viewer.ViewerNull()
    else:
        viewer = newton.viewer.ViewerGL()
    viewer.set_model(model)
    viewer.set_world_offsets((3.0, 3.0, 0.0))

    def simulate() -> None:
        nonlocal state_0, state_1
        collision_pipeline.collide(state_0, contacts)
        for _ in range(SIM_SUBSTEPS):
            state_0.clear_forces()
            viewer.apply_forces(state_0)
            solver.step(state_0, state_1, control, contacts, FRAME_DT / SIM_SUBSTEPS)
            state_0, state_1 = state_1, state_0

    with wp.ScopedCapture() as capture:
        simulate()
    graph = capture.graph

    sim_time = FRAME_DT

    def step(render: bool) -> bool:
        nonlocal sim_time
        if render and not viewer.is_running():
            return False
        wp.capture_launch(graph)
        sim_time += FRAME_DT
        if render:
            viewer.begin_frame(sim_time)
            viewer.log_state(state_0)
            viewer.log_contacts(contacts, state_0)
            viewer.end_frame()
        return True

    measurements: list[tuple[int, float]] = []
    try:
        for repeat in range(1, args.repeats + 1):
            if args.repeats > 1:
                print(f"Run {repeat}/{args.repeats}")
            for _ in range(args.warmup_steps):
                if not step(render=not args.headless):
                    raise SystemExit("Viewer closed during benchmark warm-up.")
            wp.synchronize_device(model.device)

            measured_steps = 0
            progress = BenchmarkProgress(args.steps)
            progress.start()
            start = perf_counter()
            for _ in range(args.steps):
                if not step(render=not args.headless):
                    break
                measured_steps += 1
                progress.update(measured_steps)
            progress.waiting_for_gpu(measured_steps)
            wp.synchronize_device(model.device)
            elapsed = perf_counter() - start
            progress.finish(measured_steps)
            if measured_steps == 0:
                raise SystemExit("No frames were measured because the viewer was closed.")
            measurements.append((measured_steps, elapsed))
    finally:
        viewer.close()

    return str(model.device), measurements


def make_run_record(
    args: argparse.Namespace,
    repeat: int,
    device: str,
    measured_steps: int,
    elapsed: float,
) -> dict[str, float | int | str]:
    world_frames = args.world_count * measured_steps
    return {
        "repeat": repeat,
        "device": str(device),
        "measured_frames": measured_steps,
        "elapsed_seconds": elapsed,
        "milliseconds_per_frame": elapsed * 1000.0 / measured_steps,
        "world_frames_per_second": world_frames / elapsed,
        "aggregate_realtime": world_frames * FRAME_DT / elapsed,
    }


def summarize_runs(
    records: list[dict[str, float | int | str]],
) -> dict[str, float | int]:
    elapsed = [float(record["elapsed_seconds"]) for record in records]
    frame_times = [float(record["milliseconds_per_frame"]) for record in records]
    throughput = [float(record["world_frames_per_second"]) for record in records]
    realtime = [float(record["aggregate_realtime"]) for record in records]
    return {
        "repeat_count": len(records),
        "median_elapsed_seconds": statistics.median(elapsed),
        "median_milliseconds_per_frame": statistics.median(frame_times),
        "median_world_frames_per_second": statistics.median(throughput),
        "min_world_frames_per_second": min(throughput),
        "max_world_frames_per_second": max(throughput),
        "median_aggregate_realtime": statistics.median(realtime),
    }


def collect_metadata(device: str | None = None) -> dict[str, str]:
    repository = Path(__file__).resolve().parents[1]
    try:
        git_commit = subprocess.run(
            ("git", "rev-parse", "HEAD"),
            cwd=repository,
            check=True,
            capture_output=True,
            text=True,
        ).stdout.strip()
    except (FileNotFoundError, subprocess.CalledProcessError):
        git_commit = "unknown"

    metadata = {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "hostname": platform.node(),
        "platform": platform.platform(),
        "python_version": platform.python_version(),
        "git_commit": git_commit,
    }
    if device is not None:
        metadata["runtime_device"] = str(device)
    for package, key in (
        ("newton", "newton_version"),
        ("warp-lang", "warp_version"),
        ("synreal-solver", "synreal_solver_version"),
    ):
        try:
            metadata[key] = importlib_metadata.version(package)
        except importlib_metadata.PackageNotFoundError:
            metadata[key] = "unavailable"
    if device is not None and str(device).startswith("cuda"):
        try:
            import warp as wp

            runtime_device = wp.get_device(str(device))
            metadata["gpu_name"] = str(runtime_device.name)
            metadata["gpu_arch"] = str(runtime_device.arch)
        except (ImportError, RuntimeError, ValueError):
            metadata["gpu_name"] = "unavailable"
            metadata["gpu_arch"] = "unavailable"
    return metadata


def benchmark_config(args: argparse.Namespace, asset_file: Path) -> dict[str, object]:
    return {
        "solver": args.solver,
        "world_count": args.world_count,
        "frame_dt": FRAME_DT,
        "substeps": SIM_SUBSTEPS,
        "measured_frames": args.steps,
        "warmup_frames": args.warmup_steps,
        "repeats": args.repeats,
        "headless": args.headless,
        "asset_file": str(asset_file),
    }


def write_results(
    output: Path,
    config: dict[str, object],
    metadata: dict[str, str],
    records: list[dict[str, float | int | str]],
) -> None:
    output = output.expanduser().resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    suffix = output.suffix.lower()
    if suffix == ".json":
        payload = {
            "benchmark": "unitree_h1",
            "config": config,
            "metadata": metadata,
            "runs": records,
            "summary": summarize_runs(records),
        }
        output.write_text(
            json.dumps(payload, indent=2) + "\n", encoding="utf-8", newline="\n"
        )
    elif suffix == ".csv":
        rows = [config | metadata | record for record in records]
        with output.open("w", newline="", encoding="utf-8") as stream:
            writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
            writer.writeheader()
            writer.writerows(rows)
    else:
        raise SystemExit("Benchmark output must use a .json or .csv extension.")


def print_results(
    args: argparse.Namespace,
    records: list[dict[str, float | int | str]],
) -> None:
    summary = summarize_runs(records)
    print(f"{args.solver.capitalize()} H1 benchmark")
    print(f"  device:               {records[0]['device']}")
    print(f"  mode:                 {'headless' if args.headless else 'viewer'}")
    print(f"  worlds:               {args.world_count}")
    print(f"  frame rate:           {1.0 / FRAME_DT:.0f} Hz")
    print(f"  substeps per frame:   {SIM_SUBSTEPS}")
    print(f"  measured frames:      {records[0]['measured_frames']}")
    print(f"  repeats:              {len(records)}")
    print(f"  median elapsed:       {summary['median_elapsed_seconds']:.3f} s")
    print(f"  median frame time:    {summary['median_milliseconds_per_frame']:.3f} ms")
    print(f"  median throughput:    {summary['median_world_frames_per_second']:,.0f} world-frames/s")
    print(f"  throughput range:     {summary['min_world_frames_per_second']:,.0f} - {summary['max_world_frames_per_second']:,.0f} world-frames/s")
    print(f"  aggregate real-time:  {summary['median_aggregate_realtime']:,.1f}x")


def main() -> None:
    args = create_parser().parse_args()
    asset_file = resolve_asset_file(args.asset_file, args.solver)
    loading_window = None
    if args.solver == "genesis" and not args.headless:
        loading_window = start_genesis_loading_window()
    try:
        if args.solver == "genesis":
            device, measurements = run_genesis(args, asset_file, loading_window)
        else:
            device, measurements = run_synreal(args, asset_file)
    finally:
        if loading_window is not None:
            stop_genesis_loading_window(loading_window)
    records = [
        make_run_record(args, repeat, device, measured_steps, elapsed)
        for repeat, (measured_steps, elapsed) in enumerate(measurements, start=1)
    ]

    config = benchmark_config(args, asset_file)
    metadata = collect_metadata(records[0]["device"])
    print_results(args, records)
    if args.output is not None:
        write_results(args.output, config, metadata, records)
        print(f"  results:              {args.output.expanduser().resolve()}")


if __name__ == "__main__":
    main()
