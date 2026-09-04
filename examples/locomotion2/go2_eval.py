import argparse
import pickle
from importlib import metadata
from pathlib import Path

import torch

try:
    if int(metadata.version("rsl-rl-lib").split(".")[0]) < 5:
        raise ImportError
except (metadata.PackageNotFoundError, ImportError, ValueError) as e:
    raise ImportError("Please install 'rsl-rl-lib>=5.0.0'.") from e
from go2_env import Go2Env
from rsl_rl.runners import OnPolicyRunner


def _checkpoint_iteration(path: Path) -> int:
    try:
        return int(path.stem.removeprefix("model_"))
    except ValueError:
        return -1


def _resolve_run(exp_name: str, checkpoint: int | None) -> tuple[Path, Path, Path]:
    log_dir = Path("logs") / exp_name
    config_path = log_dir / "cfgs.pkl"
    train_command = (
        "uv run --extra locomotion2 python examples/locomotion2/go2_train.py "
        f"--exp-name {exp_name}"
    )
    if not config_path.is_file():
        raise SystemExit(
            f"No trained run found at {log_dir.resolve()}.\n"
            "Evaluation requires cfgs.pkl and a model checkpoint produced by training.\n"
            f"Start training with:\n  {train_command}"
        )

    if checkpoint is not None:
        checkpoint_path = log_dir / f"model_{checkpoint}.pt"
        if not checkpoint_path.is_file():
            available = sorted(
                (_checkpoint_iteration(path) for path in log_dir.glob("model_*.pt")),
                reverse=True,
            )
            choices = ", ".join(str(value) for value in available[:10] if value >= 0)
            suffix = (
                f" Available checkpoints: {choices}."
                if choices
                else " No checkpoints exist yet."
            )
            raise SystemExit(
                f"Checkpoint does not exist: {checkpoint_path.resolve()}.{suffix}"
            )
        return log_dir, config_path, checkpoint_path

    checkpoints = sorted(log_dir.glob("model_*.pt"), key=_checkpoint_iteration)
    if not checkpoints:
        raise SystemExit(
            f"No checkpoints found in {log_dir.resolve()}.\n"
            f"Run training first:\n  {train_command}"
        )
    return log_dir, config_path, checkpoints[-1]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-e",
        "--exp-name",
        type=str,
        default="go2-walking",
        help="Experiment name; also the log directory under logs/",
    )
    parser.add_argument(
        "--ckpt",
        type=int,
        help="Checkpoint iteration; defaults to the latest available",
    )
    args = parser.parse_args()

    log_dir, config_path, checkpoint_path = _resolve_run(args.exp_name, args.ckpt)
    with config_path.open("rb") as f:
        env_cfg, obs_cfg, reward_cfg, command_cfg, train_cfg = pickle.load(f)
    reward_cfg["reward_scales"] = {}

    env = Go2Env(
        num_envs=1,
        env_cfg=env_cfg,
        obs_cfg=obs_cfg,
        reward_cfg=reward_cfg,
        command_cfg=command_cfg,
        show_viewer=True,
    )

    runner = OnPolicyRunner(env, train_cfg, str(log_dir), device=env.device)
    runner.load(str(checkpoint_path))
    policy = runner.get_inference_policy(device=env.device)

    obs_dict = env.reset()
    with torch.no_grad():
        while env.is_running():
            actions = policy(obs_dict)
            obs_dict, _rews, _dones, _infos = env.step(actions)


if __name__ == "__main__":
    main()

"""
# evaluation
python examples/locomotion2/go2_eval.py -e go2-walking
"""
