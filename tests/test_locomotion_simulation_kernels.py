"""CUDA tests for capture-safe locomotion simulation kernels."""

from __future__ import annotations

import sys
from pathlib import Path

import pytest
import torch
import warp as wp


_EXAMPLES = Path(__file__).parents[1] / "examples"
sys.path.insert(0, str(_EXAMPLES))

from locomotion.simulation_kernels import update_limited_joint_targets  # noqa: E402


@pytest.mark.skipif(not wp.is_cuda_available(), reason="kernel requires CUDA")
def test_update_limited_joint_targets_matches_torch_formula() -> None:
    device = torch.device("cuda:0")
    num_envs, num_actions = 2, 3
    q_per_env, qd_per_env, target_per_env = 5, 4, 4
    joint_q = torch.tensor(
        [[0.1, -0.4, 0.7, 0.2, -0.3], [0.5, 0.3, -0.2, 0.9, -0.8]], device=device
    )
    joint_qd = torch.tensor(
        [[0.2, -1.0, 0.5, 0.7], [-0.6, 0.4, 1.2, -0.3]], device=device
    )
    desired = torch.tensor([[2.0, -2.0, 0.1], [-1.0, 1.5, -0.4]], device=device)
    stiffness = torch.tensor([100.0, 80.0, 50.0], device=device)
    damping = torch.tensor([2.0, 3.0, 4.0], device=device)
    effort = torch.tensor([10.0, 12.0, 8.0], device=device)
    stiffness_scale = torch.tensor([[1.0, 0.5, 1.5], [0.8, 1.2, 0.7]], device=device)
    damping_scale = torch.tensor([[1.1, 0.9, 1.0], [0.6, 1.3, 0.8]], device=device)
    motor_strength = torch.tensor([[1.0, 0.75, 1.2], [0.9, 1.1, 0.8]], device=device)
    policy_q = torch.tensor([3, 1, 4], dtype=torch.long, device=device)
    policy_qd = torch.tensor([2, 0, 3], dtype=torch.long, device=device)
    policy_targets = torch.tensor([2, 0, 3], dtype=torch.long, device=device)
    control_targets = torch.full((num_envs, target_per_env), -99.0, device=device)

    q = joint_q.index_select(1, policy_q)
    qd = joint_qd.index_select(1, policy_qd)
    kp = stiffness * stiffness_scale
    kd = damping * damping_scale
    limit = effort * motor_strength
    torque = (kp * (desired - q) - kd * qd).clamp(-limit, limit)
    expected = q + (torque + kd * qd) / kp.clamp_min(1.0e-6)

    wp.launch(
        update_limited_joint_targets,
        dim=num_envs * num_actions,
        inputs=[
            wp.from_torch(joint_q.flatten()),
            wp.from_torch(joint_qd.flatten()),
            wp.from_torch(desired),
            wp.from_torch(stiffness),
            wp.from_torch(damping),
            wp.from_torch(effort),
            wp.from_torch(stiffness_scale),
            wp.from_torch(damping_scale),
            wp.from_torch(motor_strength),
            wp.from_torch(policy_q),
            wp.from_torch(policy_qd),
            wp.from_torch(policy_targets),
            num_actions,
            q_per_env,
            qd_per_env,
            target_per_env,
        ],
        outputs=[wp.from_torch(control_targets.flatten())],
        device="cuda:0",
    )
    wp.synchronize_device("cuda:0")

    assert torch.allclose(control_targets[:, policy_targets], expected, atol=1.0e-6, rtol=1.0e-6)
    assert torch.equal(control_targets[:, 1], torch.full((num_envs,), -99.0, device=device))

