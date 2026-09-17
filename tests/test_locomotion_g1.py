"""Pure-Torch contract tests for the independent G1 locomotion task."""

from __future__ import annotations

import sys
from pathlib import Path

import torch

sys.path.insert(0, str(Path(__file__).parents[1] / "examples"))

from locomotion_g1.config import (
    CRITIC_OBSERVATION_DIM,
    DEFAULT_JOINT_POS,
    JOINT_EFFORT_LIMIT,
    JOINT_KD,
    JOINT_KP,
    JOINT_NAMES,
    POLICY_OBSERVATION_DIM,
    G1EnvConfig,
    RewardConfig,
)
from locomotion_g1.math_ops import TermHistory
from locomotion_g1.mujoco_eval import TermHistory as MuJoCoTermHistory
from locomotion_g1.mujoco_eval import resolve_training_asset
from locomotion_g1.observations import (
    critic_terms,
    policy_terms,
    root_terms,
)
from locomotion_g1.rewards import RewardInputs, compute_reward


def test_g1_contract_dimensions_and_actuators() -> None:
    assert len(JOINT_NAMES) == 29
    assert len(set(JOINT_NAMES)) == 29
    assert len(DEFAULT_JOINT_POS) == 29
    assert POLICY_OBSERVATION_DIM == 480
    assert CRITIC_OBSERVATION_DIM == 495
    config = G1EnvConfig()
    assert config.simulation.contact_stiffness == 50000.0
    assert config.simulation.contact_damping == 500.0
    assert config.simulation.contact_friction_gain == 1000.0
    assert config.simulation.ground_friction == 1.0
    assert config.simulation.constraint_alpha == 200.0
    assert config.simulation.joint_constraint_primal_iterations == 2
    assert config.simulation.nonlinear_iterations == 30
    assert config.simulation.linear_iterations == 10
    assert config.randomization.friction_range == (0.3, 1.0)
    assert config.randomization.friction_buckets == 64
    assert not hasattr(config.randomization, "mass_range")
    knee = JOINT_NAMES.index("left_knee_joint")
    wrist_yaw = JOINT_NAMES.index("right_wrist_yaw_joint")
    waist_yaw = JOINT_NAMES.index("waist_yaw_joint")
    assert (JOINT_KP[knee], JOINT_KD[knee], JOINT_EFFORT_LIMIT[knee]) == (
        150.0,
        4.0,
        139.0,
    )
    assert JOINT_EFFORT_LIMIT[wrist_yaw] == 5.0
    assert (JOINT_KP[waist_yaw], JOINT_KD[waist_yaw]) == (200.0, 5.0)


def test_term_history_is_oldest_to_newest_and_term_major() -> None:
    history = TermHistory(1, (1, 2), 3, device=torch.device("cpu"))
    history.fill(
        (torch.tensor([[0.0]]), torch.tensor([[10.0, 20.0]])), torch.tensor([0])
    )
    history.update((torch.tensor([[1.0]]), torch.tensor([[11.0, 21.0]])))
    output = history.update((torch.tensor([[2.0]]), torch.tensor([[12.0, 22.0]])))
    assert output.tolist() == [[0.0, 1.0, 2.0, 10.0, 20.0, 11.0, 21.0, 12.0, 22.0]]


def test_mujoco_history_matches_training_layout() -> None:
    import numpy as np

    history = MuJoCoTermHistory((1, 2), 3)
    history.fill((np.asarray([0.0]), np.asarray([10.0, 20.0])))
    history.update((np.asarray([1.0]), np.asarray([11.0, 21.0])))
    output = history.update((np.asarray([2.0]), np.asarray([12.0, 22.0])))
    assert output.tolist() == [0.0, 1.0, 2.0, 10.0, 20.0, 11.0, 21.0, 12.0, 22.0]


def test_mujoco_requires_the_asset_recorded_by_training(tmp_path: Path) -> None:
    import hashlib

    import pytest

    asset = tmp_path / "g1.usd"
    asset.write_bytes(b"training asset")
    snapshot = {
        "resolved_asset": str(asset),
        "asset_sha256": hashlib.sha256(asset.read_bytes()).hexdigest(),
        "environment_config": {"asset_path": None},
    }
    resolved, source, verified = resolve_training_asset(snapshot, None)
    assert resolved == asset.resolve()
    assert source == "training_resolved_asset"
    assert verified

    asset.write_bytes(b"modified asset")
    with pytest.raises(ValueError, match="differs from the training snapshot"):
        resolve_training_asset(snapshot, None)


def test_observation_terms_match_unitree_scaling() -> None:
    from locomotion_g1.config import ObservationNoiseConfig

    quaternion = torch.tensor([[0.0, 0.0, 0.0, 1.0]])
    root_velocity = torch.tensor([[1.0, 2.0, 3.0, 4.0, 5.0, 6.0]])
    linear, angular, gravity = root_terms(quaternion, root_velocity)
    joint_position = torch.tensor(DEFAULT_JOINT_POS).unsqueeze(0)
    joint_velocity = torch.ones((1, 29)) * 2.0
    actions = torch.ones((1, 29)) * 0.25
    command = torch.tensor([[0.3, -0.1, 0.2]])
    policy = policy_terms(
        angular,
        gravity,
        command,
        joint_position,
        joint_position,
        joint_velocity,
        actions,
        ObservationNoiseConfig(enabled=False),
        torch.Generator().manual_seed(1),
    )
    critic = critic_terms(
        linear,
        angular,
        gravity,
        command,
        joint_position,
        joint_position,
        joint_velocity,
        actions,
    )
    assert torch.allclose(policy[0], torch.tensor([[0.8, 1.0, 1.2]]))
    assert torch.allclose(policy[1], torch.tensor([[0.0, 0.0, -1.0]]))
    assert torch.count_nonzero(policy[3]) == 0
    assert torch.allclose(policy[4], torch.full((1, 29), 0.1))
    assert torch.equal(critic[0], linear)
    assert sum(term.shape[1] for term in policy) == 96
    assert sum(term.shape[1] for term in critic) == 99


def test_reward_matches_dt_scaled_upstream_terms() -> None:
    batch = 1
    zeros_29 = torch.zeros((batch, 29))
    default = torch.tensor(DEFAULT_JOINT_POS).unsqueeze(0)
    command = torch.tensor([[0.2, 0.0, 0.0]])
    reward, terms = compute_reward(
        RewardInputs(
            commands=command,
            root_position=torch.tensor([[0.0, 0.0, 0.78]]),
            root_quaternion=torch.tensor([[0.0, 0.0, 0.0, 1.0]]),
            root_linear_velocity_world=torch.tensor([[0.2, 0.0, 0.0]]),
            root_linear_velocity_body=torch.tensor([[0.2, 0.0, 0.0]]),
            root_angular_velocity_body=torch.zeros((batch, 3)),
            projected_gravity=torch.tensor([[0.0, 0.0, -1.0]]),
            joint_position=default,
            default_joint_position=default,
            joint_velocity=zeros_29,
            previous_joint_velocity=zeros_29,
            actions=zeros_29,
            previous_actions=zeros_29,
            estimated_torque=zeros_29,
            soft_joint_lower=torch.full((batch, 29), -10.0),
            soft_joint_upper=torch.full((batch, 29), 10.0),
            foot_position_world=torch.tensor([[[0.0, 0.0, 0.1], [0.0, 0.0, 0.1]]]),
            foot_linear_velocity_world=torch.zeros((batch, 2, 3)),
            foot_contact=torch.tensor([[True, False]]),
            recent_foot_contact=torch.tensor([[True, False]]),
            recent_undesired_contact=torch.zeros((batch, 25), dtype=torch.bool),
            episode_steps=torch.tensor([8]),
            terminated=torch.tensor([False]),
        ),
        RewardConfig(),
        0.02,
        torch.arange(15, 29),
        torch.arange(12, 15),
        torch.tensor([1, 2, 7, 8]),
    )
    assert torch.allclose(terms["track_lin_vel_xy"], torch.tensor([0.02]))
    assert torch.allclose(terms["gait"], torch.tensor([0.02]))
    assert torch.allclose(reward, torch.tensor([0.073]), atol=1.0e-6)
