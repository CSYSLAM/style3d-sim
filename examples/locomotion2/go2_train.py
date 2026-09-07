import argparse
import os
import pickle
import shutil
from importlib import metadata
from pathlib import Path

try:
    if int(metadata.version("rsl-rl-lib").split(".")[0]) < 5:
        raise ImportError
except (metadata.PackageNotFoundError, ImportError) as e:
    raise ImportError("Please install 'rsl-rl-lib>=5.0.0'.") from e
from rsl_rl.runners import OnPolicyRunner

import torch

from go2_env import Go2Env


def start_tensorboard(log_dir, port):
    from tensorboard import program

    tensorboard = program.TensorBoard()
    tensorboard.configure(
        argv=[
            None,
            "--logdir",
            str(Path(log_dir).resolve()),
            "--host",
            "127.0.0.1",
            "--port",
            port,
        ]
    )
    url = tensorboard.launch()
    print(f"TensorBoard: {url}", flush=True)
    return tensorboard


def get_train_cfg(exp_name):
    train_cfg_dict = {
        "algorithm": {
            "class_name": "PPO",
            "clip_param": 0.2,
            "desired_kl": 0.01,
            "entropy_coef": 0.01,
            "gamma": 0.99,
            "lam": 0.95,
            "learning_rate": 0.001,
            "max_grad_norm": 1.0,
            "num_learning_epochs": 5,
            "num_mini_batches": 4,
            "schedule": "adaptive",
            "use_clipped_value_loss": True,
            "value_loss_coef": 1.0,
        },
        "actor": {
            "class_name": "MLPModel",
            "hidden_dims": [512, 256, 128],
            "activation": "elu",
            "distribution_cfg": {
                "class_name": "bounded_distribution:TanhGaussianDistribution",
                "init_std": 0.3,
                "std_type": "scalar",
            },
        },
        "critic": {
            "class_name": "MLPModel",
            "hidden_dims": [512, 256, 128],
            "activation": "elu",
        },
        "obs_groups": {
            "actor": ["policy"],
            "critic": ["policy"],
        },
        "num_steps_per_env": 24,
        "save_interval": 100,
        "run_name": exp_name,
        "logger": "tensorboard",
    }

    return train_cfg_dict


def get_cfgs():
    env_cfg = {
        "num_actions": 12,
        # joint/link names
        "default_joint_angles": {  # [rad]
            "FL_hip_joint": 0.0,
            "FR_hip_joint": 0.0,
            "RL_hip_joint": 0.0,
            "RR_hip_joint": 0.0,
            "FL_thigh_joint": 0.8,
            "FR_thigh_joint": 0.8,
            "RL_thigh_joint": 1.0,
            "RR_thigh_joint": 1.0,
            "FL_calf_joint": -1.5,
            "FR_calf_joint": -1.5,
            "RL_calf_joint": -1.5,
            "RR_calf_joint": -1.5,
        },
        "joint_names": [
            "FR_hip_joint",
            "FR_thigh_joint",
            "FR_calf_joint",
            "FL_hip_joint",
            "FL_thigh_joint",
            "FL_calf_joint",
            "RR_hip_joint",
            "RR_thigh_joint",
            "RR_calf_joint",
            "RL_hip_joint",
            "RL_thigh_joint",
            "RL_calf_joint",
        ],
        # PD
        "kp": 80.0,
        "kd": 2.0,
        # contact
        "contact_stiffness": 4.0e4,
        "contact_damping": 4.5e2,
        # termination
        "termination_if_roll_greater_than": 35,  # degree
        "termination_if_pitch_greater_than": 35,
        # base pose
        "base_init_pos": [0.0, 0.0, 0.42],
        "base_init_quat": [1.0, 0.0, 0.0, 0.0],
        "episode_length_s": 20.0,
        "resampling_time_s": 4.0,
        # This same actuator envelope must be used by evaluation and deployment.
        "action_scale": [
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
            0.25,
        ],
        "joint_target_limits": {
            "FR_hip_joint": [-0.5, 0.5],
            "FR_thigh_joint": [0.4, 1.4],
            "FR_calf_joint": [-2.3, -0.85],
            "FL_hip_joint": [-0.5, 0.5],
            "FL_thigh_joint": [0.4, 1.4],
            "FL_calf_joint": [-2.3, -0.85],
            "RR_hip_joint": [-0.5, 0.5],
            "RR_thigh_joint": [0.4, 1.4],
            "RR_calf_joint": [-2.3, -0.85],
            "RL_hip_joint": [-0.5, 0.5],
            "RL_thigh_joint": [0.4, 1.4],
            "RL_calf_joint": [-2.3, -0.85],
        },
        "torque_limits": 23.5,
        "simulate_action_latency": True,
        "clip_actions": 1.0,
    }
    obs_cfg = {
        "obs_scales": {
            "lin_vel": 2.0,
            "ang_vel": 0.25,
            "dof_pos": 1.0,
            "dof_vel": 0.05,
        },
    }
    reward_cfg = {
        "tracking_sigma": 0.25,
        "base_height_target": 0.3,
        "feet_height_target": 0.075,
        "reward_scales": {
            "tracking_lin_vel": 3.0,
            "tracking_ang_vel": 1.0,
            "lin_vel_z": -1.0,
            "base_height": -50.0,
            "action_rate": -0.005,
            "similar_to_default": -0.1,
        },
    }
    command_cfg = {
        "num_commands": 3,
        "lin_vel_x_range": [0.5, 0.5],
        "lin_vel_y_range": [0, 0],
        "ang_vel_range": [0, 0],
    }

    return env_cfg, obs_cfg, reward_cfg, command_cfg


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-e", "--exp-name", type=str, default="go2-walking", help="Experiment name; also the log directory under logs/")
    parser.add_argument("-b", "--num-envs", type=int, default=512, help="Number of parallel environments")
    parser.add_argument("--max-iterations", type=int, default=20000, help="Number of learning iterations; additional iterations when resuming")
    parser.add_argument("--seed", type=int, default=1, help="Random seed")
    parser.add_argument("--headless", action="store_true", help="Disable Newton Viewer during training")
    parser.add_argument("--resume", type=Path, help="Resume from an RSL-RL .pt checkpoint")
    parser.add_argument("--no-tensorboard", action="store_true", help="Do not start the TensorBoard web server")
    parser.add_argument(
        "--tensorboard-port",
        default="default",
        help="TensorBoard port, or 'default' to use 6006 and find a nearby free port",
    )
    args = parser.parse_args()

    resume_path = None
    if args.resume is not None:
        resume_path = args.resume.expanduser().resolve()
        if resume_path.suffix.lower() != ".pt" or not resume_path.is_file():
            raise SystemExit(f"Resume checkpoint must be an existing .pt file: {resume_path}")
        config_path = resume_path.parent / "cfgs.pkl"
        if not config_path.is_file():
            raise SystemExit(f"Resume configuration does not exist: {config_path}")
        with config_path.open("rb") as f:
            env_cfg, obs_cfg, reward_cfg, command_cfg, train_cfg = pickle.load(f)
        log_dir = str(resume_path.parent)
    else:
        log_dir = f"logs/{args.exp_name}"
        env_cfg, obs_cfg, reward_cfg, command_cfg = get_cfgs()
        train_cfg = get_train_cfg(args.exp_name)

        if os.path.exists(log_dir):
            shutil.rmtree(log_dir)
        os.makedirs(log_dir, exist_ok=True)

        with open(f"{log_dir}/cfgs.pkl", "wb") as f:
            pickle.dump([env_cfg, obs_cfg, reward_cfg, command_cfg, train_cfg], f)

    _tensorboard = None
    if not args.no_tensorboard:
        _tensorboard = start_tensorboard(log_dir, args.tensorboard_port)

    # Parallel environments provide training throughput and require a CUDA GPU.
    torch.manual_seed(args.seed)
    torch.cuda.manual_seed_all(args.seed)

    print(f"Initializing {args.num_envs} Newton environments on CUDA...", flush=True)
    env = Go2Env(
        num_envs=args.num_envs,
        env_cfg=env_cfg,
        obs_cfg=obs_cfg,
        reward_cfg=reward_cfg,
        command_cfg=command_cfg,
        show_viewer=not args.headless,
    )

    try:
        runner = OnPolicyRunner(env, train_cfg, log_dir, device=env.device)
        if resume_path is not None:
            runner.load(str(resume_path))
            resumed_iteration = runner.current_learning_iteration
            runner.current_learning_iteration += 1
            print(
                f"Resuming after iteration {resumed_iteration} for {args.max_iterations} additional iterations...",
                flush=True,
            )
        runner.learn(num_learning_iterations=args.max_iterations, init_at_random_ep_len=True)
    finally:
        env.close()


if __name__ == "__main__":
    main()

"""
# training
python examples/locomotion2/go2_train.py
"""
