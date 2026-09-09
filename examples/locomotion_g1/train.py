#!/usr/bin/env python3
"""Train Unitree RL Lab's G1 velocity task with the SynReal environment."""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import asdict
from datetime import UTC, datetime
from pathlib import Path
from typing import Any

import torch

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from locomotion_g1.config import G1EnvConfig, make_ppo_config
    from locomotion_g1.env import SynRealG1LocomotionEnv
else:
    from .config import G1EnvConfig, make_ppo_config
    from .env import SynRealG1LocomotionEnv


def _json_default(value: Any) -> str:
    if isinstance(value, Path):
        return str(value)
    raise TypeError(f"Cannot serialize {type(value).__name__}")


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", action="store_true", help="start PPO training")
    parser.add_argument(
        "--smoke-steps",
        type=int,
        default=0,
        help="construct the environment and run this many zero-action steps",
    )
    parser.add_argument(
        "--smoke-action-std",
        type=float,
        default=0.0,
        help="standard deviation of Gaussian actions used by smoke mode",
    )
    parser.add_argument(
        "--smoke-report-interval",
        type=int,
        default=1,
        help="print one smoke record every N steps",
    )
    parser.add_argument("--num-envs", type=int, default=512)
    parser.add_argument("--iterations", type=int, default=50_000)
    parser.add_argument("--device", default="cuda:0")
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--asset", type=Path)
    parser.add_argument("--resume", type=Path)
    parser.add_argument("--log-root", type=Path, default=Path("runs"))
    parser.add_argument("--disable-logs", action="store_true")
    parser.add_argument("--visualize", action="store_true")
    parser.add_argument("--disable-self-collisions", action="store_true")
    parser.add_argument("--disable-cuda-graph", action="store_true")
    parser.add_argument(
        "--mesh-approximation",
        choices=("convex_hull", "bounding_box"),
        default="convex_hull",
    )
    return parser


def main() -> None:
    args = create_parser().parse_args()
    if (
        args.num_envs <= 0
        or args.iterations <= 0
        or args.smoke_steps < 0
        or args.smoke_action_std < 0.0
        or args.smoke_report_interval <= 0
    ):
        raise SystemExit("environment, iteration, and smoke-step counts are invalid")
    environment_config = G1EnvConfig(
        num_envs=args.num_envs,
        device=args.device,
        seed=args.seed,
        asset_path=args.asset,
        enable_self_collisions=not args.disable_self_collisions,
        mesh_approximation=args.mesh_approximation,
        use_cuda_graph=not args.disable_cuda_graph,
    )
    ppo_config = make_ppo_config(args.iterations)
    summary = {
        "environment": "synreal_g1_locomotion",
        "policy_observation_dim": SynRealG1LocomotionEnv.num_obs,
        "critic_observation_dim": SynRealG1LocomotionEnv.num_privileged_obs,
        "action_dim": SynRealG1LocomotionEnv.num_actions,
        "contact_semantics": "debounced_geometry_not_force_threshold",
        "friction_semantics": "single_coulomb_coefficient_64_bucket_per_shape",
        "mass_randomization": False,
        "environment_config": asdict(environment_config),
        "rsl_rl": ppo_config,
    }
    print(json.dumps(summary, indent=2, default=_json_default))
    if not args.run and args.smoke_steps == 0:
        print("configuration valid; pass --run or --smoke-steps N")
        return

    viewer = None
    if args.visualize:
        import newton

        viewer = newton.viewer.ViewerGL(vsync=True)
    env = SynRealG1LocomotionEnv(environment_config, viewer=viewer)
    print(
        json.dumps(
            {
                "resolved_asset": str(env.asset_path),
                "asset_source": env.asset_source,
                "contact_capacity": int(env.contacts.rigid_contact_max),
                "self_collisions": environment_config.enable_self_collisions,
                "friction": env.friction_summary,
            },
            indent=2,
        )
    )
    if args.smoke_steps:
        try:
            for step in range(args.smoke_steps):
                actions = args.smoke_action_std * torch.randn(
                    (env.num_envs, env.num_actions),
                    device=env.device,
                    generator=env.generator,
                )
                observation, reward, done, extras = env.step(actions)
                should_report = (
                    step == 0
                    or step + 1 == args.smoke_steps
                    or (step + 1) % args.smoke_report_interval == 0
                    or bool(torch.any(done))
                )
                if not should_report:
                    continue
                state = env._current_state()
                metrics = extras["metrics"]
                print(
                    json.dumps(
                        {
                            "step": step + 1,
                            "observation_finite": bool(
                                torch.isfinite(observation).all()
                            ),
                            "mean_reward": float(reward.mean()),
                            "done_count": int(done.sum()),
                            "contact_overflow": bool(metrics["contact_overflow"]),
                            "mean_root_height": float(
                                state["root_position"][:, 2].mean()
                            ),
                            "left_foot_contact_rate": float(
                                metrics["geometry_contact/left"]
                            ),
                            "right_foot_contact_rate": float(
                                metrics["geometry_contact/right"]
                            ),
                            "mean_undesired_contact_bodies": float(
                                metrics["geometry_contact/undesired_bodies"]
                            ),
                            "gpu_max_memory_mb": round(
                                torch.cuda.max_memory_allocated(env.device)
                                / (1024 * 1024),
                                1,
                            ),
                        }
                    ),
                    flush=True,
                )
        finally:
            env.close()
        return

    try:
        from rsl_rl.runners import OnPolicyRunner
    except ImportError as error:
        env.close()
        raise SystemExit(
            "RSL-RL is not installed. Run `uv sync --extra locomotion`."
        ) from error

    log_dir = None
    if not args.disable_logs:
        stamp = datetime.now(UTC).strftime("%Y-%m-%d_%H-%M-%S")
        log_dir = args.log_root / ppo_config["experiment_name"] / stamp
        log_dir.mkdir(parents=True, exist_ok=False)
        (log_dir / "environment.json").write_text(
            json.dumps(summary, indent=2, default=_json_default), encoding="utf-8"
        )
    runner = OnPolicyRunner(
        env,
        ppo_config,
        log_dir=str(log_dir) if log_dir is not None else None,
        device=args.device,
    )
    if args.disable_logs:
        runner.disable_logs = True
    if args.resume is not None:
        runner.load(str(args.resume.expanduser().resolve()))
    try:
        runner.learn(
            num_learning_iterations=args.iterations,
            init_at_random_ep_len=True,
        )
    finally:
        env.close()


if __name__ == "__main__":
    main()
