#!/usr/bin/env python3
"""Play pinned rl_sar locomotion policies in SynReal, entirely on CUDA."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import select
import sys
import time
import urllib.request
from contextlib import contextmanager
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator

import imageio_ffmpeg
import newton
import numpy as np
import torch
import warp as wp
from newton import JointTargetMode
from newton._src.utils.download_assets import MENAGERIE_REF, MENAGERIE_URL, download_git_folder

import synreal_solver


DEVICE = "cuda:0"
DT = 0.005
DECIMATION = 4
FPS = 50
RL_SAR_COMMIT = "376d42c9b128f963ab08579762d5a216a976ce39"
RL_SAR_ZOO_COMMIT = "7dd30bdc7806898950b354260655d5a7f0ce844e"
RL_SAR_RAW = f"https://raw.githubusercontent.com/fan-ziqi/rl_sar/{RL_SAR_COMMIT}"
RL_SAR_ZOO_URL = "https://github.com/fan-ziqi/rl_sar_zoo.git"


@dataclass(frozen=True)
class PolicyProfile:
    name: str
    checkpoint_url: str
    checkpoint_sha256: str
    observation_dim: int
    action_dim: int
    history: tuple[int, ...]
    sdk_joint_names: tuple[str, ...]
    joint_mapping: tuple[int, ...]
    default_dof_pos: tuple[float, ...]
    action_scale: tuple[float, ...]
    kp: tuple[float, ...]
    kd: tuple[float, ...]
    torque_limits: tuple[float, ...]
    ang_vel_scale: float
    dof_vel_scale: float
    commands_scale: tuple[float, float, float]
    asset_kind: str
    asset_folder: str
    asset_relative_path: str
    initial_height: float
    fall_height: float
    contact_ke: float
    contact_kd: float
    solver_iterations: int
    camera: tuple[float, float, float, float, float]

    @property
    def policy_joint_names(self) -> tuple[str, ...]:
        """Joint names in training/policy order."""
        return tuple(self.sdk_joint_names[i] for i in self.joint_mapping)

    @property
    def policy_input_dim(self) -> int:
        return self.observation_dim * (len(self.history) or 1)


G1_JOINTS = (
    "left_hip_pitch_joint", "left_hip_roll_joint", "left_hip_yaw_joint",
    "left_knee_joint", "left_ankle_pitch_joint", "left_ankle_roll_joint",
    "right_hip_pitch_joint", "right_hip_roll_joint", "right_hip_yaw_joint",
    "right_knee_joint", "right_ankle_pitch_joint", "right_ankle_roll_joint",
    "waist_yaw_joint", "waist_roll_joint", "waist_pitch_joint",
    "left_shoulder_pitch_joint", "left_shoulder_roll_joint", "left_shoulder_yaw_joint",
    "left_elbow_joint", "left_wrist_roll_joint", "left_wrist_pitch_joint", "left_wrist_yaw_joint",
    "right_shoulder_pitch_joint", "right_shoulder_roll_joint", "right_shoulder_yaw_joint",
    "right_elbow_joint", "right_wrist_roll_joint", "right_wrist_pitch_joint", "right_wrist_yaw_joint",
)
QUAD_JOINTS = tuple(f"{leg}_{joint}_joint" for leg in ("FR", "FL", "RR", "RL") for joint in ("hip", "thigh", "calf"))

PROFILES = {
    "g1": PolicyProfile(
        name="g1",
        checkpoint_url=f"{RL_SAR_RAW}/policy/g1/robomimic/locomotion/policy_29dof.pt",
        checkpoint_sha256="d1d91b0201beeb649a4624ba40052d10fe4aebe98bf6f4847decf75dd1fee2da",
        observation_dim=96,
        action_dim=29,
        history=(),
        sdk_joint_names=G1_JOINTS,
        joint_mapping=(0, 6, 12, 1, 7, 13, 2, 8, 14, 3, 9, 15, 22, 4, 10, 16, 23, 5, 11, 17, 24, 18, 25, 19, 26, 20, 27, 21, 28),
        default_dof_pos=(-0.20, -0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.42, 0.42, 0.35, 0.35, -0.23, -0.23, 0.18, -0.18, 0.0, 0.0, 0.0, 0.0, 0.87, 0.87, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
        action_scale=(0.25,) * 29,
        kp=(200, 200, 200, 150, 150, 200, 150, 150, 200, 200, 200, 100, 100, 20, 20, 100, 100, 20, 20, 50, 50, 50, 50, 40, 40, 40, 40, 40, 40),
        kd=(5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
        torque_limits=(88, 88, 88, 88, 88, 88, 88, 88, 88, 139, 139, 25, 25, 50, 50, 25, 25, 50, 50, 25, 25, 25, 25, 5, 5, 5, 5, 5, 5),
        ang_vel_scale=1.0,
        dof_vel_scale=1.0,
        commands_scale=(1.0, 1.0, 1.0),
        asset_kind="zoo_mjcf",
        asset_folder="g1_description",
        asset_relative_path="mjcf/g1_29dof.xml",
        initial_height=0.793,
        fall_height=0.35,
        contact_ke=5.0e5,
        contact_kd=2.0e3,
        solver_iterations=20,
        camera=(1.8, -2.6, 1.25, -8.0, 110.0),
    ),
    "go2": PolicyProfile(
        name="go2",
        checkpoint_url=f"{RL_SAR_RAW}/policy/go2/robot_lab/policy.pt",
        checkpoint_sha256="9f14cb95e74ac9e5e30954da0fc0c33eaa41e337852ebed19fcee869279ade0b",
        observation_dim=45,
        action_dim=12,
        history=(),
        sdk_joint_names=QUAD_JOINTS,
        joint_mapping=tuple(range(12)),
        default_dof_pos=(0.0, 0.8, -1.5) * 4,
        action_scale=(0.125, 0.25, 0.25) * 4,
        kp=(20.0,) * 12,
        kd=(0.5,) * 12,
        torque_limits=(23.5,) * 12,
        ang_vel_scale=0.25,
        dof_vel_scale=0.05,
        commands_scale=(1.0, 1.0, 1.0),
        asset_kind="zoo_mjcf",
        asset_folder="go2_description",
        asset_relative_path="mjcf/go2.xml",
        initial_height=0.445,
        fall_height=0.16,
        contact_ke=2.0e3,
        contact_kd=1.0e2,
        solver_iterations=10,
        camera=(1.25, -1.75, 0.75, -10.0, 110.0),
    ),
    "a1": PolicyProfile(
        name="a1",
        checkpoint_url=f"{RL_SAR_RAW}/policy/a1/legged_gym/model.pt",
        checkpoint_sha256="b0045ccca07d13fec36e4dc4981df1d7e4495dd81d0c6b9c4909699520ec0cf6",
        observation_dim=45,
        action_dim=12,
        history=(5, 4, 3, 2, 1, 0),
        sdk_joint_names=QUAD_JOINTS,
        joint_mapping=(3, 4, 5, 0, 1, 2, 9, 10, 11, 6, 7, 8),
        default_dof_pos=(0.1, 0.8, -1.5, -0.1, 0.8, -1.5, 0.1, 1.0, -1.5, -0.1, 1.0, -1.5),
        action_scale=(0.125, 0.25, 0.25) * 4,
        kp=(20.0,) * 12,
        kd=(0.5,) * 12,
        torque_limits=(33.5,) * 12,
        ang_vel_scale=0.25,
        dof_vel_scale=0.05,
        commands_scale=(2.0, 2.0, 0.25),
        asset_kind="menagerie_mjcf",
        asset_folder="unitree_a1",
        asset_relative_path="a1.xml",
        initial_height=0.43,
        fall_height=0.14,
        contact_ke=2.0e3,
        contact_kd=1.0e2,
        solver_iterations=10,
        camera=(1.25, -1.75, 0.75, -10.0, 110.0),
    ),
}


def quat_rotate_inverse(quat_xyzw: torch.Tensor, vector: torch.Tensor) -> torch.Tensor:
    """Rotate a world-frame vector into the quaternion's local frame."""
    qvec = quat_xyzw[..., :3]
    qw = quat_xyzw[..., 3:4]
    twice_cross = 2.0 * torch.linalg.cross(qvec, vector)
    return vector - qw * twice_cross + torch.linalg.cross(qvec, twice_cross)


def body_angular_velocity(body_qd: torch.Tensor) -> torch.Tensor:
    """Return Newton's angular component from [linear, angular] spatial vectors."""
    return body_qd[..., 3:]


def signed_contact_gap(
    point0_world: np.ndarray,
    point1_world: np.ndarray,
    normal: np.ndarray,
    margin0: float,
    margin1: float,
) -> float:
    """Return the signed gap using the contact fields consumed by SynReal."""
    return float(np.dot(point1_world - point0_world, normal) - margin0 - margin1)


def quat_rotate(quat_xyzw: torch.Tensor, vector: torch.Tensor) -> torch.Tensor:
    """Rotate local-frame vectors into world coordinates."""
    qvec = quat_xyzw[..., :3]
    qw = quat_xyzw[..., 3:4]
    twice_cross = 2.0 * torch.linalg.cross(qvec, vector)
    return vector + qw * twice_cross + torch.linalg.cross(qvec, twice_cross)


def update_history(history: torch.Tensor, observation: torch.Tensor) -> torch.Tensor:
    """Insert newest at index zero, matching rl_sar ObservationBuffer."""
    return torch.cat((observation.unsqueeze(0), history[:-1]), dim=0)


def ordered_history(history: torch.Tensor, order: tuple[int, ...]) -> torch.Tensor:
    indices = torch.tensor(order, dtype=torch.long, device=history.device)
    return history.index_select(0, indices).reshape(1, -1)


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def ensure_checkpoint(profile: PolicyProfile, override: Path | None = None) -> Path:
    path = override or Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "synreal_solver" / "rl_sar" / f"{profile.name}.pt"
    path = path.expanduser().resolve()
    if path.exists() and _sha256(path) == profile.checkpoint_sha256:
        return path
    if override:
        raise ValueError(f"checkpoint SHA256 mismatch: {path}")
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(".download")
    urllib.request.urlretrieve(profile.checkpoint_url, temporary)
    if _sha256(temporary) != profile.checkpoint_sha256:
        temporary.unlink(missing_ok=True)
        raise ValueError(f"downloaded checkpoint SHA256 mismatch: {profile.name}")
    temporary.replace(path)
    return path


def resolve_asset(profile: PolicyProfile) -> Path:
    if profile.asset_kind == "newton_mjcf":
        root = newton.utils.download_asset(profile.asset_folder)
    elif profile.asset_kind == "menagerie_mjcf":
        root = download_git_folder(MENAGERIE_URL, profile.asset_folder, ref=MENAGERIE_REF)
    else:
        root = download_git_folder(
            RL_SAR_ZOO_URL,
            profile.asset_folder,
            ref=RL_SAR_ZOO_COMMIT,
        )
    path = root / profile.asset_relative_path
    if not path.is_file():
        raise FileNotFoundError(path)
    return path


def _basename(label: str) -> str:
    return label.rsplit("/", 1)[-1]


def map_policy_joints(builder: newton.ModelBuilder, profile: PolicyProfile) -> tuple[list[int], list[int]]:
    joints = {_basename(label): index for index, label in enumerate(builder.joint_label)}
    missing = sorted(set(profile.policy_joint_names) - joints.keys())
    if missing:
        raise ValueError(f"asset is missing policy joints: {missing}")
    joint_indices = [joints[name] for name in profile.policy_joint_names]
    q_indices = [builder.joint_q_start[index] for index in joint_indices]
    qd_indices = [builder.joint_qd_start[index] for index in joint_indices]
    if len(set(q_indices)) != profile.action_dim or len(set(qd_indices)) != profile.action_dim:
        raise ValueError("policy joint mapping is not one-to-one")
    return q_indices, qd_indices


def build_model(
    profile: PolicyProfile,
    asset_path: Path,
    *,
    floating: bool = True,
    ground: bool = True,
):
    newton.use_coord_layout_targets = True
    robot = newton.ModelBuilder(up_axis=newton.Axis.Z)
    robot.default_joint_cfg = newton.ModelBuilder.JointDofConfig(limit_ke=1.0e3, limit_kd=10.0, friction=1.0e-5)
    robot.default_shape_cfg.ke = profile.contact_ke
    robot.default_shape_cfg.kd = profile.contact_kd
    robot.default_shape_cfg.kf = 1.0e3
    robot.default_shape_cfg.mu = 0.75
    kwargs = dict(floating=floating, collapse_fixed_joints=True, enable_self_collisions=False)
    if profile.asset_kind.endswith("urdf"):
        robot.add_urdf(str(asset_path), xform=wp.transform(wp.vec3(0.0, 0.0, profile.initial_height)), **kwargs)
    else:
        robot.add_mjcf(str(asset_path), **kwargs)

    q_indices, qd_indices = map_policy_joints(robot, profile)
    if floating:
        robot.joint_q[:3] = [0.0, 0.0, profile.initial_height]
        robot.joint_q[3:7] = [0.0, 0.0, 0.0, 1.0]
    for slot, (q_index, qd_index) in enumerate(zip(q_indices, qd_indices, strict=True)):
        robot.joint_q[q_index] = profile.default_dof_pos[slot]
        robot.joint_target_q[q_index] = profile.default_dof_pos[slot]
        robot.joint_target_ke[qd_index] = profile.kp[slot]
        robot.joint_target_kd[qd_index] = profile.kd[slot]
        robot.joint_effort_limit[qd_index] = profile.torque_limits[slot]
        robot.joint_target_mode[qd_index] = int(JointTargetMode.POSITION)

    builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
    builder.add_world(robot)
    builder.default_shape_cfg.ke = profile.contact_ke
    builder.default_shape_cfg.kd = profile.contact_kd
    builder.default_shape_cfg.kf = 1.0e3
    builder.default_shape_cfg.mu = 0.75
    if ground:
        builder.add_ground_plane()
    model = builder.finalize(device=DEVICE)
    return model, q_indices, qd_indices


def reset_recurrent_policy(policy: torch.jit.ScriptModule) -> None:
    for name in ("hidden_state", "cell_state"):
        if hasattr(policy, name):
            getattr(policy, name).zero_()


def assert_cuda_tensor(name: str, tensor: torch.Tensor) -> None:
    if tensor.device.type != "cuda" or tensor.device.index != 0:
        raise RuntimeError(f"{name} must be on cuda:0, got {tensor.device}")


class VideoWriter:
    """FFmpeg encoder. Frames arrive from a CUDA ViewerGL readback."""

    def __init__(self, path: Path, width: int, height: int):
        self.path = path.resolve()
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self._writer = imageio_ffmpeg.write_frames(
            str(self.path), (width, height), fps=FPS, codec="libx264",
            pix_fmt_in="rgb24", pix_fmt_out="yuv420p", quality=7,
            macro_block_size=1, ffmpeg_log_level="warning",
        )
        self._writer.send(None)
        self.frames = 0

    def append(self, frame: wp.array) -> None:
        if not frame.device.is_cuda:
            raise RuntimeError(f"render frame must originate on CUDA, got {frame.device}")
        self._writer.send(frame.numpy().tobytes())
        self.frames += 1

    def close(self) -> None:
        self._writer.close()


@contextmanager
def raw_terminal(enabled: bool) -> Iterator[None]:
    if not enabled or not sys.stdin.isatty():
        yield
        return
    import termios
    import tty
    original = termios.tcgetattr(sys.stdin)
    try:
        tty.setcbreak(sys.stdin.fileno())
        yield
    finally:
        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, original)


def reset_requested() -> bool:
    if not sys.stdin.isatty():
        return False
    ready, _, _ = select.select([sys.stdin], [], [], 0.0)
    return bool(ready and sys.stdin.read(1).lower() == "p")


class SynRealPolicyPlayer:
    def __init__(self, profile: PolicyProfile, checkpoint: Path, command: tuple[float, float, float], viewer):
        self.profile = profile
        self.command = torch.tensor(command, device=DEVICE, dtype=torch.float32).unsqueeze(0)
        self.asset_path = resolve_asset(profile)
        self.model, q_indices, qd_indices = build_model(profile, self.asset_path)
        self.solver = synreal_solver.NewtonSolver(self.model)
        self.solver.config.nonlinear_iterations = profile.solver_iterations
        self.solver.config.linear_iterations = profile.solver_iterations
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()
        self.control = self.model.control()
        self.policy = torch.jit.load(str(checkpoint), map_location=DEVICE).eval()
        self.q_indices = torch.tensor(q_indices, dtype=torch.long, device=DEVICE)
        self.qd_indices = torch.tensor(qd_indices, dtype=torch.long, device=DEVICE)
        self.foot_names, self.foot_body_groups = self._find_foot_bodies()
        self.last_foot_contact = np.zeros(len(self.foot_names), dtype=np.int8)
        self.default = torch.tensor(profile.default_dof_pos, device=DEVICE).unsqueeze(0)
        self.action_scale = torch.tensor(profile.action_scale, device=DEVICE).unsqueeze(0)
        self.command_scale = torch.tensor(profile.commands_scale, device=DEVICE).unsqueeze(0)
        self.gravity = torch.tensor([[0.0, 0.0, -1.0]], device=DEVICE)
        self.joint_q = wp.empty(self.model.joint_coord_count, dtype=wp.float32, device=DEVICE)
        self.joint_qd = wp.empty(self.model.joint_dof_count, dtype=wp.float32, device=DEVICE)
        self.previous_action = torch.zeros((1, profile.action_dim), device=DEVICE)
        self.history = torch.zeros((max(profile.history, default=0) + 1, profile.observation_dim), device=DEVICE)
        self.viewer = viewer
        if viewer is not None:
            viewer.set_model(self.model)
            x, y, z, pitch, yaw = profile.camera
            viewer.set_camera(wp.vec3(x, y, z), pitch, yaw)
        self.reset_count = 0
        self.reset()
        self._validate_devices()
        with torch.inference_mode():
            output = self.policy(torch.zeros((1, profile.policy_input_dim), device=DEVICE))
        if tuple(output.shape) != (1, profile.action_dim):
            raise ValueError(f"policy output shape is {tuple(output.shape)}, expected (1, {profile.action_dim})")
        if not torch.isfinite(output).all():
            raise ValueError("policy validation output is not finite")
        reset_recurrent_policy(self.policy)

    def _find_foot_bodies(self) -> tuple[tuple[str, ...], tuple[set[int], ...]]:
        labels = tuple(_basename(label) for label in self.model.body_label)
        if self.profile.name == "g1":
            names = ("left", "right")
            suffixes = ("left_ankle_roll_link", "right_ankle_roll_link")
        else:
            names = ("FR", "FL", "RR", "RL")
            suffixes = tuple(f"{leg}_calf" for leg in names)
        groups = tuple(
            {index for index, label in enumerate(labels) if label == suffix}
            for suffix in suffixes
        )
        if any(not group for group in groups):
            raise ValueError(f"could not identify all foot bodies: {dict(zip(names, groups))}")
        return names, groups

    def _active_foot_contacts(self) -> np.ndarray:
        count = int(wp.to_torch(self.contacts.rigid_contact_count).item())
        active = np.zeros(len(self.foot_names), dtype=np.int8)
        if count == 0:
            return active
        shape0 = self.contacts.rigid_contact_shape0.numpy()[:count]
        shape1 = self.contacts.rigid_contact_shape1.numpy()[:count]
        point0 = self.contacts.rigid_contact_point0.numpy()[:count]
        point1 = self.contacts.rigid_contact_point1.numpy()[:count]
        normal = self.contacts.rigid_contact_normal.numpy()[:count]
        margin0 = self.contacts.rigid_contact_margin0.numpy()[:count]
        margin1 = self.contacts.rigid_contact_margin1.numpy()[:count]
        shape_body = self.model.shape_body.numpy()
        body_pose = self.state_0.body_q.numpy()

        def world_point(body: int, local: np.ndarray) -> np.ndarray:
            if body < 0:
                return local
            position = body_pose[body, :3]
            q = body_pose[body, 3:7]
            qvec, qw = q[:3], q[3]
            return position + local + 2.0 * (
                qw * np.cross(qvec, local) + np.cross(qvec, np.cross(qvec, local))
            )

        for index in range(count):
            body0 = int(shape_body[shape0[index]])
            body1 = int(shape_body[shape1[index]])
            p0 = world_point(body0, point0[index])
            p1 = world_point(body1, point1[index])
            separation = signed_contact_gap(
                p0, p1, normal[index], margin0[index], margin1[index]
            )
            if separation > 1.0e-4:
                continue
            for foot, group in enumerate(self.foot_body_groups):
                if body0 in group or body1 in group:
                    active[foot] = 1
        return active

    def _validate_devices(self) -> None:
        arrays = {
            "model.joint_q": self.model.joint_q,
            "state.body_q": self.state_0.body_q,
            "state.body_qd": self.state_0.body_qd,
            "control.joint_target_q": self.control.joint_target_q,
            "ik.joint_q": self.joint_q,
            "ik.joint_qd": self.joint_qd,
        }
        for name, array in arrays.items():
            if not array.device.is_cuda or array.device.ordinal != 0:
                raise RuntimeError(f"{name} must be on cuda:0, got {array.device}")
        for name, tensor in {
            "command": self.command,
            "previous_action": self.previous_action,
            "history": self.history,
            "policy parameter": next(self.policy.parameters()),
        }.items():
            assert_cuda_tensor(name, tensor)
        if wp.get_device().alias != DEVICE:
            raise RuntimeError(f"Warp default device must be {DEVICE}, got {wp.get_device()}")

    def reset(self) -> None:
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_0)
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_1)
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)
        wp.copy(self.control.joint_target_q, self.model.joint_target_q)
        wp.copy(self.control.joint_target_qd, self.model.joint_target_qd)
        self.previous_action.zero_()
        self.history.zero_()
        self.last_foot_contact.fill(0)
        reset_recurrent_policy(self.policy)
        self.reset_count += 1

    def observe(self) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        newton.eval_ik(self.model, self.state_0, self.joint_q, self.joint_qd)
        body_q = wp.to_torch(self.state_0.body_q)[0].unsqueeze(0)
        body_qd = wp.to_torch(self.state_0.body_qd)[0].unsqueeze(0)
        q = wp.to_torch(self.joint_q).index_select(0, self.q_indices).unsqueeze(0)
        qd = wp.to_torch(self.joint_qd).index_select(0, self.qd_indices).unsqueeze(0)
        quat = body_q[:, 3:7]
        # Newton spatial vectors are [linear, angular]; rl_sar expects body gyro.
        ang_vel_body = quat_rotate_inverse(quat, body_angular_velocity(body_qd))
        gravity_body = quat_rotate_inverse(quat, self.gravity)
        observation = torch.cat((
            ang_vel_body * self.profile.ang_vel_scale,
            gravity_body,
            self.command * self.command_scale,
            q - self.default,
            qd * self.profile.dof_vel_scale,
            self.previous_action,
        ), dim=1).clamp_(-100.0, 100.0)
        if observation.shape[1] != self.profile.observation_dim:
            raise RuntimeError(f"observation shape mismatch: {observation.shape}")
        return observation, body_q, gravity_body

    def policy_step(self) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        observation, body_q, gravity_body = self.observe()
        if self.profile.history:
            self.history = update_history(self.history, observation.squeeze(0))
            policy_input = ordered_history(self.history, self.profile.history)
        else:
            policy_input = observation
        with torch.inference_mode():
            action = self.policy(policy_input).clamp_(-100.0, 100.0)
        assert_cuda_tensor("observation", policy_input)
        assert_cuda_tensor("action", action)
        if not torch.isfinite(action).all():
            raise FloatingPointError("policy action contains NaN or Inf")
        target = self.default + self.action_scale * action
        wp.to_torch(self.control.joint_target_q).index_copy_(0, self.q_indices, target.squeeze(0))
        self.previous_action.copy_(action)
        return body_q, gravity_body, action

    def set_action(self, action: torch.Tensor) -> torch.Tensor:
        """Apply an externally supplied policy action for open-loop replay."""
        action = action.to(device=DEVICE, dtype=torch.float32).reshape(1, -1).clamp_(-100.0, 100.0)
        if action.shape[1] != self.profile.action_dim:
            raise ValueError(f"action shape mismatch: {action.shape}")
        target = self.default + self.action_scale * action
        wp.to_torch(self.control.joint_target_q).index_copy_(0, self.q_indices, target.squeeze(0))
        self.previous_action.copy_(action)
        return target

    def trajectory_sample(self, action: torch.Tensor, target: torch.Tensor | None = None) -> dict[str, np.ndarray | int]:
        """Sample the simulator-neutral state schema at the current policy tick."""
        newton.eval_ik(self.model, self.state_0, self.joint_q, self.joint_qd)
        body_q = wp.to_torch(self.state_0.body_q)[0]
        body_qd = wp.to_torch(self.state_0.body_qd)[0]
        q = wp.to_torch(self.joint_q).index_select(0, self.q_indices)
        qd = wp.to_torch(self.joint_qd).index_select(0, self.qd_indices)
        quat_xyzw = body_q[3:7]
        root_linear_body = quat_rotate_inverse(quat_xyzw, body_qd[:3])
        root_angular_body = quat_rotate_inverse(quat_xyzw, body_qd[3:])
        if target is None:
            target = self.default + self.action_scale * action
        kp = torch.tensor(self.profile.kp, device=DEVICE)
        kd = torch.tensor(self.profile.kd, device=DEVICE)
        limits = torch.tensor(self.profile.torque_limits, device=DEVICE)
        torque_command = (kp * (target.squeeze(0) - q) - kd * qd).clamp(-limits, limits)
        return {
            "root_position": body_q[:3].detach().cpu().numpy(),
            "root_quaternion_xyzw": quat_xyzw.detach().cpu().numpy(),
            "root_linear_velocity_body": root_linear_body.detach().cpu().numpy(),
            "root_angular_velocity_body": root_angular_body.detach().cpu().numpy(),
            "joint_position": q.detach().cpu().numpy(),
            "joint_velocity": qd.detach().cpu().numpy(),
            "action": action.squeeze(0).detach().cpu().numpy(),
            "joint_target": target.squeeze(0).detach().cpu().numpy(),
            "joint_torque_command": torque_command.detach().cpu().numpy(),
            "contact_count": int(wp.to_torch(self.contacts.rigid_contact_count).item()),
            "foot_contact": self.last_foot_contact.copy(),
        }

    def simulate_control_period(self) -> None:
        period_contact = np.zeros(len(self.foot_names), dtype=np.int8)
        for _ in range(DECIMATION):
            self.collision_pipeline.collide(self.state_0, self.contacts)
            period_contact |= self._active_foot_contacts()
            self.state_0.clear_forces()
            self.solver.step(self.state_0, self.state_1, self.control, self.contacts, DT)
            self.state_0, self.state_1 = self.state_1, self.state_0
        self.last_foot_contact = period_contact

    def render(self, sim_time: float, root_position: torch.Tensor) -> wp.array:
        x, y, z, pitch, yaw = self.profile.camera
        self.viewer.set_camera(
            wp.vec3(x + float(root_position[0]), y + float(root_position[1]), z),
            pitch,
            yaw,
        )
        self.viewer.begin_frame(sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.end_frame()
        frame = self.viewer.get_frame()
        if not frame.device.is_cuda or frame.device.ordinal != 0:
            raise RuntimeError(f"render output must be on cuda:0, got {frame.device}")
        return frame


def run(args: argparse.Namespace) -> dict:
    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is required; CPU fallback is intentionally disabled")
    torch.cuda.set_device(0)
    wp.set_device(DEVICE)
    profile = PROFILES[args.robot]
    checkpoint = ensure_checkpoint(profile, args.checkpoint)
    viewer = None
    if args.record or not args.headless:
        if args.headless:
            os.environ.setdefault("PYGLET_HEADLESS", "1")
        viewer = newton.viewer.ViewerGL(width=args.width, height=args.height, headless=args.headless, vsync=False)
        if not viewer.device.is_cuda or viewer.device.ordinal != 0:
            raise RuntimeError(f"ViewerGL must use cuda:0, got {viewer.device}")
    writer = VideoWriter(args.record, args.width, args.height) if args.record else None
    player = SynRealPolicyPlayer(profile, checkpoint, (args.cmd_vx, args.cmd_vy, args.cmd_yaw), viewer)
    frames = int(round(args.duration * FPS))
    replay_actions = None
    if args.replay_actions:
        with np.load(args.replay_actions, allow_pickle=False) as replay:
            replay_actions = torch.as_tensor(replay["action"], device=DEVICE, dtype=torch.float32)
        if replay_actions.shape != (frames, profile.action_dim):
            raise ValueError(
                f"replay action shape is {tuple(replay_actions.shape)}, expected {(frames, profile.action_dim)}"
            )
    heights: list[float] = []
    upright: list[float] = []
    finite = True
    trajectory: dict[str, list] = {}
    initial_xy = wp.to_torch(player.state_0.body_q)[0, :2].cpu().tolist()
    final_xyz: list[float] | None = None
    start = time.perf_counter()
    try:
        with raw_terminal(not args.headless):
            for frame_index in range(frames):
                if reset_requested():
                    player.reset()
                if replay_actions is None:
                    _, _, action = player.policy_step()
                    target = player.default + player.action_scale * action
                else:
                    action = replay_actions[frame_index].unsqueeze(0)
                    target = player.set_action(action)
                player.simulate_control_period()
                if args.trajectory:
                    sample = player.trajectory_sample(action, target)
                    for name, value in sample.items():
                        trajectory.setdefault(name, []).append(value)
                observation, body_q, gravity_body = player.observe()
                step_finite = bool(torch.isfinite(observation).all() and torch.isfinite(action).all() and torch.isfinite(body_q).all())
                finite = finite and step_finite
                xyz = body_q[0, :3].detach()
                final_xyz = xyz.cpu().tolist()
                heights.append(float(xyz[2].item()))
                upright.append(float((-gravity_body[0, 2]).item()))
                if not step_finite:
                    raise FloatingPointError(f"non-finite state at frame {frame_index}")
                if viewer is not None:
                    image = player.render((frame_index + 1) / FPS, xyz)
                    if writer is not None:
                        writer.append(image)
                if (frame_index + 1) % FPS == 0:
                    print(f"[{profile.name}] {(frame_index + 1) / FPS:.0f}/{args.duration:g}s height={heights[-1]:.3f} upright={upright[-1]:.3f}", flush=True)
    finally:
        if writer is not None:
            writer.close()
        if viewer is not None:
            viewer.close()
    torch.cuda.synchronize()
    elapsed = time.perf_counter() - start

    video = None
    if args.record:
        decoded_frames, decoded_seconds = imageio_ffmpeg.count_frames_and_secs(str(args.record))
        video = {
            "path": str(args.record.resolve()),
            "bytes": args.record.stat().st_size,
            "encoded_frames": writer.frames,
            "decoded_frames": decoded_frames,
            "decoded_seconds": decoded_seconds,
            "fps": FPS,
            "encoder_device": "cpu",
            "frame_source_device": DEVICE,
        }
        if writer.frames != frames or decoded_frames != frames or not math.isclose(decoded_seconds, args.duration, abs_tol=1.0 / FPS):
            raise RuntimeError(f"video timing validation failed: {video}")
    assert final_xyz is not None
    displacement = math.dist(initial_xy, final_xyz[:2])
    summary = {
        "robot": profile.name,
        "solver": "SynReal NewtonSolver",
        "rl_sar_commit": RL_SAR_COMMIT,
        "rl_sar_zoo_commit": RL_SAR_ZOO_COMMIT,
        "mujoco_menagerie_commit": MENAGERIE_REF if profile.asset_kind == "menagerie_mjcf" else None,
        "checkpoint": str(checkpoint),
        "checkpoint_sha256": _sha256(checkpoint),
        "asset": str(player.asset_path),
        "robot_asset_sha256": _sha256(player.asset_path),
        "command": [args.cmd_vx, args.cmd_vy, args.cmd_yaw],
        "rollout_mode": "open_loop_action_replay" if replay_actions is not None else "closed_loop_policy",
        "replay_actions": str(args.replay_actions.resolve()) if args.replay_actions else None,
        "dt": DT,
        "decimation": DECIMATION,
        "policy_hz": FPS,
        "solver_iterations": profile.solver_iterations,
        "simulated_seconds": frames / FPS,
        "frames": frames,
        "wall_seconds": elapsed,
        "realtime_factor": (frames / FPS) / elapsed,
        "observation_dim": profile.observation_dim,
        "policy_input_dim": profile.policy_input_dim,
        "action_dim": profile.action_dim,
        "joint_names_policy_order": profile.policy_joint_names,
        "devices": {
            "physics": DEVICE,
            "policy": DEVICE,
            "observation": DEVICE,
            "action": DEVICE,
            "render": DEVICE if viewer is not None else None,
            "video_encoder": "cpu" if args.record else None,
        },
        "finite": finite,
        "root_displacement_xy": displacement,
        "root_final_xyz": final_xyz,
        "height_min": min(heights),
        "height_final": heights[-1],
        "upright_min": min(upright),
        "upright_final": upright[-1],
        "fell": min(heights) < profile.fall_height or min(upright) < 0.5,
        "reset_count": player.reset_count,
        "video": video,
    }
    if args.trajectory:
        trajectory_path = args.trajectory.resolve()
        trajectory_path.parent.mkdir(parents=True, exist_ok=True)
        np.savez_compressed(
            trajectory_path,
            schema_version=np.array(1, dtype=np.int32),
            simulator=np.array("synreal"),
            robot=np.array(profile.name),
            asset_sha256=np.array(_sha256(player.asset_path)),
            time=(np.arange(frames, dtype=np.float64) + 1.0) / FPS,
            joint_names=np.asarray(profile.policy_joint_names),
            foot_names=np.asarray(player.foot_names),
            **{name: np.asarray(values) for name, values in trajectory.items()},
        )
        summary["trajectory"] = str(trajectory_path)
    summary_path = args.summary or (args.record.with_suffix(".summary.json") if args.record else Path(f"{profile.name}_summary.json"))
    summary_path = summary_path.resolve()
    summary_path.parent.mkdir(parents=True, exist_ok=True)
    summary_path.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(summary, indent=2))
    print(f"summary: {summary_path}")
    return summary


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--robot", choices=PROFILES, required=True)
    parser.add_argument("--checkpoint", type=Path, help="override checkpoint; pinned SHA256 is still required")
    parser.add_argument("--cmd-vx", type=float, default=0.5)
    parser.add_argument("--cmd-vy", type=float, default=0.0)
    parser.add_argument("--cmd-yaw", type=float, default=0.0)
    parser.add_argument("--duration", type=float, default=10.0)
    parser.add_argument("--record", type=Path)
    parser.add_argument("--summary", type=Path)
    parser.add_argument("--trajectory", type=Path, help="write policy-rate state/action trajectory as NPZ")
    parser.add_argument("--replay-actions", type=Path, help="replay the action array from another trajectory")
    parser.add_argument("--width", type=int, default=960)
    parser.add_argument("--height", type=int, default=540)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--headless", action="store_true", dest="headless", help="use headless EGL rendering")
    mode.add_argument("--visualize", action="store_false", dest="headless", help="open ViewerGL; press p to reset")
    parser.set_defaults(headless=True)
    return parser


def main() -> None:
    args = create_parser().parse_args()
    if args.duration <= 0 or args.width <= 0 or args.height <= 0:
        raise SystemExit("duration, width, and height must be positive")
    run(args)


if __name__ == "__main__":
    main()
