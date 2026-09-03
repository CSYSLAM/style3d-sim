"""GPU reward and termination functions for flat-ground locomotion."""

from __future__ import annotations

import torch


def locomotion_reward(
    *,
    robot: str,
    commands: torch.Tensor,
    linear_velocity_body: torch.Tensor,
    angular_velocity_body: torch.Tensor,
    gravity_body: torch.Tensor,
    joint_position_error: torch.Tensor,
    joint_velocity: torch.Tensor,
    actions: torch.Tensor,
    previous_actions: torch.Tensor,
    foot_height: torch.Tensor,
    foot_speed_xy: torch.Tensor,
    contact: torch.Tensor,
) -> tuple[torch.Tensor, dict[str, torch.Tensor]]:
    linear_error = (commands[:, :2] - linear_velocity_body[:, :2]).square().sum(-1)
    yaw_error = (commands[:, 2] - angular_velocity_body[:, 2]).square()
    track_linear = torch.exp(-linear_error / 0.25)
    track_yaw = torch.exp(-yaw_error / 0.25)
    upright = (-gravity_body[:, 2]).clamp(-1.0, 1.0)
    vertical = linear_velocity_body[:, 2].square()
    roll_pitch_rate = angular_velocity_body[:, :2].square().sum(-1)
    action_rate = (actions - previous_actions).square().sum(-1)
    joint_motion = joint_velocity.square().sum(-1)
    posture = joint_position_error.square().sum(-1)
    slide = (foot_speed_xy.square().sum(-1) * contact.float()).sum(-1)
    clearance = torch.relu(0.035 - foot_height).square().sum(-1)

    if robot == "go2":
        # Reward diagonal trot support without prescribing a clock in the actor.
        diagonal_a = contact[:, 0] & contact[:, 3]
        diagonal_b = contact[:, 1] & contact[:, 2]
        gait = (diagonal_a ^ diagonal_b).float()
        reward = (
            3.0 * track_linear
            + 1.5 * track_yaw
            + upright
            + 0.25 * gait
            - 2.0 * vertical
            - 0.05 * roll_pitch_rate
            - 0.01 * action_rate
            - 2.5e-4 * joint_motion
            - 0.02 * posture
            - 0.1 * slide
            - clearance
        )
    else:
        single_support = (contact.sum(-1) == 1).float()
        reward = (
            3.0 * track_linear
            + 1.0 * track_yaw
            + upright
            + 0.25 * single_support
            - 0.2 * vertical
            - 0.1 * roll_pitch_rate
            - 0.005 * action_rate
            - 1.0e-7 * joint_motion
            - 0.01 * posture
            - 0.2 * slide
            - clearance
        )
    terms = {
        "track_linear": track_linear,
        "track_yaw": track_yaw,
        "upright": upright,
        "foot_slide": slide,
        "action_rate": action_rate,
    }
    return reward, terms


def terminated(
    root_height: torch.Tensor,
    gravity_body: torch.Tensor,
    fall_height: float,
    finite: torch.Tensor,
) -> torch.Tensor:
    return (root_height < fall_height) | ((-gravity_body[:, 2]) < 0.45) | ~finite
