"""CPU tests for the Unitree RL Lab compatible Go2 task."""

from __future__ import annotations

import sys
from pathlib import Path
from types import SimpleNamespace

import torch

_EXAMPLES = Path(__file__).parents[1] / "examples"
sys.path.insert(0, str(_EXAMPLES))

from locomotion_unitree.config import load_config  # noqa: E402
from locomotion_unitree.contacts import classify_shapes  # noqa: E402
from locomotion_unitree.env import UnitreeGo2Env  # noqa: E402
from locomotion_unitree.mujoco_eval import torque_speed_limit  # noqa: E402
from locomotion_unitree.observations import (  # noqa: E402
    actor_observation,
    critic_observation,
)
from locomotion_unitree.rewards import unitree_go2_reward  # noqa: E402
from locomotion_unitree.train import rsl_rl_config  # noqa: E402


def test_unitree_policy_and_ppo_contract() -> None:
    spec, _ = load_config()
    cfg = rsl_rl_config()
    assert spec.observation_dim == 45
    assert spec.action_dim == 12
    assert spec.policy_dt == 0.02
    assert spec.randomization.base_mass_add == (0.0, 0.0)
    assert spec.randomization.link_mass_scale == (1.0, 1.0)
    assert spec.command_ranges["lin_vel_x"] == (-0.3, 0.3)
    assert spec.standing_probability == 0.05
    assert cfg["num_steps_per_env"] == 24
    assert cfg["max_iterations"] == 50000
    assert cfg["policy"]["init_noise_std"] == 1.0
    assert cfg["algorithm"]["learning_rate"] == 1.0e-3
    assert cfg["algorithm"]["entropy_coef"] == 0.01


def test_actor_and_privileged_critic_dimensions() -> None:
    batch = 3
    zero3 = torch.zeros(batch, 3)
    zero12 = torch.zeros(batch, 12)
    default = torch.zeros(12)
    generator = torch.Generator().manual_seed(1)
    actor = actor_observation(
        angular_velocity_body=zero3,
        gravity_body=zero3,
        commands=zero3,
        joint_position=zero12,
        joint_velocity=zero12,
        last_action=zero12,
        default_joint_position=default,
        corrupt=False,
        generator=generator,
    )
    critic = critic_observation(
        linear_velocity_body=zero3,
        angular_velocity_body=zero3,
        gravity_body=zero3,
        commands=zero3,
        joint_position=zero12,
        joint_velocity=zero12,
        joint_effort=zero12,
        last_action=zero12,
        default_joint_position=default,
    )
    assert actor.shape == (batch, 45)
    assert critic.shape == (batch, 60)


def test_foot_shape_attached_to_calf_is_not_undesired() -> None:
    body_labels = ["base", "FR_calf", "FL_calf", "RR_calf", "RL_calf"] * 2
    shape_labels = []
    shape_bodies = []
    for env in range(2):
        offset = env * 5
        shape_labels.append(f"/env_{env}/base/collisions/body")
        shape_bodies.append(offset)
        for slot, leg in enumerate(("FR", "FL", "RR", "RL"), start=1):
            shape_labels.extend(
                (
                    f"/env_{env}/{leg}_calf/collisions/mesh",
                    f"/env_{env}/{leg}_foot/collisions/sphere",
                )
            )
            shape_bodies.extend((offset + slot, offset + slot))
    result = classify_shapes(
        shape_labels=shape_labels,
        shape_bodies=shape_bodies,
        body_labels=body_labels,
        body_per_env=5,
        num_envs=2,
    )
    for shape, label in enumerate(shape_labels):
        if "_foot/collisions/" in label:
            assert result.shape_to_foot[shape] >= 0
            assert result.shape_to_undesired[shape] == -1
        if "_calf/collisions/" in label:
            assert result.shape_to_foot[shape] == -1
            assert result.shape_to_undesired[shape] >= 0
    assert result.undesired_per_env == 4


def test_reward_uses_unitree_weights_and_step_dt() -> None:
    _, task = load_config()
    batch = 2
    zero3 = torch.zeros(batch, 3)
    zero12 = torch.zeros(batch, 12)
    zero4 = torch.zeros(batch, 4)
    reward, terms = unitree_go2_reward(
        commands=zero3,
        linear_velocity_body=zero3,
        angular_velocity_body=zero3,
        gravity_body=torch.tensor([[0.0, 0.0, -1.0]]).repeat(batch, 1),
        joint_position_error=zero12,
        joint_velocity=zero12,
        joint_acceleration=zero12,
        joint_torque=zero12,
        actions=zero12,
        previous_actions=zero12,
        soft_joint_lower=torch.full((12,), -1.0),
        soft_joint_upper=torch.full((12,), 1.0),
        joint_position=zero12,
        first_foot_contact=zero4,
        last_air_time=zero4,
        last_contact_time=zero4,
        foot_contact=zero4,
        foot_velocity_xy=torch.zeros(batch, 4, 2),
        undesired_contact=torch.zeros(batch, 12),
        weights={key: float(value) for key, value in task["rewards"].items()},
        step_dt=0.02,
    )
    assert torch.allclose(terms["track_lin_vel_xy"], torch.full((batch,), 0.03))
    assert torch.allclose(terms["track_ang_vel_z"], torch.full((batch,), 0.015))
    assert torch.allclose(reward, torch.full((batch,), 0.045))


def test_command_curriculum_uses_completed_episode_at_next_interval() -> None:
    spec, task = load_config()
    env = object.__new__(UnitreeGo2Env)
    env.max_episode_length = spec.max_episode_length
    env.policy_step_count = env.max_episode_length - 1
    env.command_ranges = {
        "lin_vel_x": [-0.3, 0.3],
        "lin_vel_y": [-0.1, 0.1],
    }
    env.command_limits = {
        "lin_vel_x": (-1.0, 1.0),
        "lin_vel_y": (-0.4, 0.4),
    }
    env.episode_sums = {"track_lin_vel_xy": torch.tensor([30.0])}
    env.reward_weights = {"track_lin_vel_xy": 1.5}
    env.spec = spec
    env.unitree_cfg = task
    env.curriculum_score_sum = 0.0
    env.curriculum_episode_count = 0
    UnitreeGo2Env._update_command_curriculum(env, torch.tensor([True]))
    assert env.command_ranges["lin_vel_x"] == [-0.3, 0.3]
    assert env.curriculum_episode_count == 1

    env.policy_step_count = env.max_episode_length
    UnitreeGo2Env._update_command_curriculum(env, torch.tensor([False]))
    assert env.command_ranges["lin_vel_x"] == [-0.4, 0.4]
    assert env.command_ranges["lin_vel_y"] == [-0.2, 0.2]
    assert env.curriculum_score_sum == 0.0
    assert env.curriculum_episode_count == 0


def test_unitree_solver_configuration_uses_newton_six_springs() -> None:
    env = object.__new__(UnitreeGo2Env)
    config = SimpleNamespace()
    env.solver = SimpleNamespace(config=config)
    env.synreal_solver = SimpleNamespace(
        JointConstraintMode=SimpleNamespace(AUGMENTED_LAGRANGIAN="al"),
        AffineBodyRigidityModel=SimpleNamespace(SIX_SPRINGS="six_springs"),
        InertiaMode=SimpleNamespace(MIDPOINT_CAYLEY="midpoint_cayley"),
        NonlinearSolver=SimpleNamespace(NEWTON="newton"),
    )
    UnitreeGo2Env._configure_solver(env)
    assert config.joint_constraint_mode == "al"
    assert config.affine_body_rigidity_model == "six_springs"
    assert config.inertia_mode == "midpoint_cayley"
    assert config.nonlinear_solver == "newton"
    assert config.joint_constraint_primal_iterations == 2
    assert config.nonlinear_iterations == 30
    assert config.linear_iterations == 10


def test_mujoco_torque_speed_curve_matches_training_kernel() -> None:
    import numpy as np

    desired = np.asarray((30.0, 30.0, 30.0, -30.0, -30.0))
    velocity = np.asarray((0.0, 13.5, 21.75, -21.75, 31.0))
    actual = torque_speed_limit(
        desired,
        velocity,
        x1=13.5,
        x2=30.0,
        y1=20.2,
        y2=23.4,
    )
    assert np.allclose(actual, (23.4, 20.2, 10.1, -10.1, 0.0))
