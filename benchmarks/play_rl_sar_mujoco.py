#!/usr/bin/env python3
"""Play the pinned rl_sar policies in native MuJoCo and export state trajectories."""

from __future__ import annotations

import argparse
import json
import math
import sys
import time
from pathlib import Path

import imageio_ffmpeg
import mujoco
import numpy as np
import torch

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from benchmarks.play_rl_sar_synreal import (
    DECIMATION,
    DEVICE,
    DT,
    FPS,
    PROFILES,
    RL_SAR_COMMIT,
    RL_SAR_ZOO_COMMIT,
    PolicyProfile,
    _sha256,
    ensure_checkpoint,
    ordered_history,
    quat_rotate_inverse,
    reset_recurrent_policy,
    resolve_asset,
    update_history,
)


class VideoWriter:
    """CPU FFmpeg encoder for MuJoCo RGB frames."""

    def __init__(self, path: Path, width: int, height: int):
        self.path = path.resolve()
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.width = width
        self.height = height
        self._writer = imageio_ffmpeg.write_frames(
            str(self.path),
            (width, height),
            fps=FPS,
            codec="libx264",
            pix_fmt_in="rgb24",
            pix_fmt_out="yuv420p",
            quality=7,
            macro_block_size=1,
            ffmpeg_log_level="warning",
        )
        self._writer.send(None)
        self.frames = 0

    def append(self, frame: np.ndarray) -> None:
        expected_shape = (self.height, self.width, 3)
        if frame.shape != expected_shape or frame.dtype != np.uint8:
            raise ValueError(
                f"rendered frame must be uint8 {expected_shape}, got "
                f"{frame.dtype} {frame.shape}"
            )
        self._writer.send(np.ascontiguousarray(frame).tobytes())
        self.frames += 1

    def close(self) -> None:
        self._writer.close()


def resolve_mujoco_asset(profile: PolicyProfile) -> Path:
    asset = resolve_asset(profile)
    if profile.name in ("g1", "go2", "a1"):
        scene_name = "scene_29dof.xml" if profile.name == "g1" else "scene.xml"
        scene = asset.parent / scene_name
        if not scene.is_file():
            raise FileNotFoundError(scene)
        return scene
    return asset


def _joint_addresses(model: mujoco.MjModel, profile: PolicyProfile) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    qpos: list[int] = []
    qvel: list[int] = []
    actuator: list[int] = []
    for name in profile.policy_joint_names:
        joint_id = mujoco.mj_name2id(model, mujoco.mjtObj.mjOBJ_JOINT, name)
        if joint_id < 0:
            raise ValueError(f"MuJoCo asset is missing joint {name!r}")
        qpos.append(int(model.jnt_qposadr[joint_id]))
        qvel.append(int(model.jnt_dofadr[joint_id]))
        matches = np.flatnonzero(model.actuator_trnid[:, 0] == joint_id)
        if len(matches) != 1:
            raise ValueError(f"expected one actuator for {name!r}, found {len(matches)}")
        actuator.append(int(matches[0]))
    return np.asarray(qpos), np.asarray(qvel), np.asarray(actuator)


def _root_addresses(model: mujoco.MjModel) -> tuple[int, int, int]:
    free = np.flatnonzero(model.jnt_type == mujoco.mjtJoint.mjJNT_FREE)
    if len(free) != 1:
        raise ValueError(f"expected one free root joint, found {len(free)}")
    joint_id = int(free[0])
    return int(model.jnt_qposadr[joint_id]), int(model.jnt_dofadr[joint_id]), int(model.jnt_bodyid[joint_id])


def configure_direct_torque_actuators(
    model: mujoco.MjModel, actuator_indices: np.ndarray, torque_limits: tuple[float, ...]
) -> None:
    """Normalize motor/position XML actuators to the rl_sar torque-PD contract."""
    model.actuator_dyntype[actuator_indices] = mujoco.mjtDyn.mjDYN_NONE
    model.actuator_gaintype[actuator_indices] = mujoco.mjtGain.mjGAIN_FIXED
    model.actuator_biastype[actuator_indices] = mujoco.mjtBias.mjBIAS_NONE
    model.actuator_dynprm[actuator_indices] = 0.0
    model.actuator_gainprm[actuator_indices] = 0.0
    model.actuator_gainprm[actuator_indices, 0] = 1.0
    model.actuator_biasprm[actuator_indices] = 0.0
    limits = np.asarray(torque_limits, dtype=np.float64)
    model.actuator_ctrllimited[actuator_indices] = 1
    model.actuator_ctrlrange[actuator_indices, 0] = -limits
    model.actuator_ctrlrange[actuator_indices, 1] = limits


class MuJoCoPolicyPlayer:
    def __init__(self, profile: PolicyProfile, checkpoint: Path, command: tuple[float, float, float]):
        self.profile = profile
        self.asset_path = resolve_mujoco_asset(profile)
        self.model = mujoco.MjModel.from_xml_path(str(self.asset_path))
        self.model.opt.timestep = DT
        # The Go2 demo scene adds stairs; SynReal's benchmark imports only the robot
        # and a plane, so disable all extra world geoms in this flat-ground comparison.
        if profile.name == "go2":
            for geom_id in range(self.model.ngeom):
                if self.model.geom_bodyid[geom_id] != 0:
                    continue
                name = mujoco.mj_id2name(self.model, mujoco.mjtObj.mjOBJ_GEOM, geom_id)
                if name != "floor":
                    self.model.geom_contype[geom_id] = 0
                    self.model.geom_conaffinity[geom_id] = 0
                    self.model.geom_rgba[geom_id, 3] = 0.0
        self.data = mujoco.MjData(self.model)
        self.q_indices, self.qd_indices, self.actuator_indices = _joint_addresses(self.model, profile)
        self.root_q_index, self.root_qd_index, self.root_body_id = _root_addresses(self.model)
        self.foot_names, self.foot_body_groups = self._find_foot_bodies()
        self.last_foot_contact = np.zeros(len(self.foot_names), dtype=np.int8)
        configure_direct_torque_actuators(self.model, self.actuator_indices, profile.torque_limits)
        self.default_np = np.asarray(profile.default_dof_pos, dtype=np.float64)
        self.scale_np = np.asarray(profile.action_scale, dtype=np.float64)
        self.kp_np = np.asarray(profile.kp, dtype=np.float64)
        self.kd_np = np.asarray(profile.kd, dtype=np.float64)
        self.limits_np = np.asarray(profile.torque_limits, dtype=np.float64)
        self.default = torch.tensor(profile.default_dof_pos, device=DEVICE).unsqueeze(0)
        self.action_scale = torch.tensor(profile.action_scale, device=DEVICE).unsqueeze(0)
        self.command = torch.tensor(command, device=DEVICE, dtype=torch.float32).unsqueeze(0)
        self.command_scale = torch.tensor(profile.commands_scale, device=DEVICE).unsqueeze(0)
        self.gravity = torch.tensor([[0.0, 0.0, -1.0]], device=DEVICE)
        self.previous_action = torch.zeros((1, profile.action_dim), device=DEVICE)
        self.history = torch.zeros((max(profile.history, default=0) + 1, profile.observation_dim), device=DEVICE)
        self.policy = torch.jit.load(str(checkpoint), map_location=DEVICE).eval()
        self.reset()
        with torch.inference_mode():
            output = self.policy(torch.zeros((1, profile.policy_input_dim), device=DEVICE))
        if tuple(output.shape) != (1, profile.action_dim) or not torch.isfinite(output).all():
            raise ValueError(f"invalid policy output: shape={tuple(output.shape)}")
        reset_recurrent_policy(self.policy)

    def _find_foot_bodies(self) -> tuple[tuple[str, ...], tuple[set[int], ...]]:
        if self.profile.name == "g1":
            names = ("left", "right")
            body_names = (
                ("left_ankle_pitch_link", "left_ankle_roll_link"),
                ("right_ankle_pitch_link", "right_ankle_roll_link"),
            )
        elif self.profile.name == "go2":
            names = ("FR", "FL", "RR", "RL")
            body_names = tuple((f"{leg}_calf", f"{leg}_foot") for leg in names)
        else:
            names = ("FR", "FL", "RR", "RL")
            body_names = tuple((f"{leg}_calf",) for leg in names)
        body_groups = tuple(
            {
                body
                for name in group
                if (body := mujoco.mj_name2id(self.model, mujoco.mjtObj.mjOBJ_BODY, name)) >= 0
            }
            for group in body_names
        )
        if any(not group for group in body_groups):
            raise ValueError(f"could not identify all foot bodies: {dict(zip(names, body_groups))}")
        return names, body_groups

    def _active_foot_contacts(self) -> np.ndarray:
        active = np.zeros(len(self.foot_names), dtype=np.int8)
        for index in range(self.data.ncon):
            contact = self.data.contact[index]
            if contact.dist > 1.0e-4:
                continue
            body0 = int(self.model.geom_bodyid[contact.geom[0]])
            body1 = int(self.model.geom_bodyid[contact.geom[1]])
            if body0 != 0 and body1 != 0:
                continue
            for foot, group in enumerate(self.foot_body_groups):
                if body0 in group or body1 in group:
                    active[foot] = 1
        return active

    def reset(self) -> None:
        mujoco.mj_resetData(self.model, self.data)
        q0 = self.root_q_index
        self.data.qpos[q0 : q0 + 3] = (0.0, 0.0, self.profile.initial_height)
        self.data.qpos[q0 + 3 : q0 + 7] = (1.0, 0.0, 0.0, 0.0)
        self.data.qpos[self.q_indices] = self.default_np
        self.data.qvel[:] = 0.0
        self.data.ctrl[:] = 0.0
        mujoco.mj_forward(self.model, self.data)
        self.previous_action.zero_()
        self.history.zero_()
        self.last_foot_contact.fill(0)
        reset_recurrent_policy(self.policy)

    def state_tensors(self) -> tuple[torch.Tensor, ...]:
        q0, v0 = self.root_q_index, self.root_qd_index
        quat_wxyz = self.data.qpos[q0 + 3 : q0 + 7]
        quat_xyzw = torch.tensor(
            [[quat_wxyz[1], quat_wxyz[2], quat_wxyz[3], quat_wxyz[0]]],
            device=DEVICE,
            dtype=torch.float32,
        )
        del v0
        velocity_local = np.zeros(6, dtype=np.float64)
        mujoco.mj_objectVelocity(
            self.model, self.data, mujoco.mjtObj.mjOBJ_BODY, self.root_body_id, velocity_local, 1
        )
        # mj_objectVelocity uses [angular, linear] spatial-vector ordering.
        angular_body = torch.as_tensor(velocity_local[:3].copy(), device=DEVICE, dtype=torch.float32).unsqueeze(0)
        linear_body = torch.as_tensor(velocity_local[3:].copy(), device=DEVICE, dtype=torch.float32).unsqueeze(0)
        q = torch.as_tensor(self.data.qpos[self.q_indices].copy(), device=DEVICE, dtype=torch.float32).unsqueeze(0)
        qd = torch.as_tensor(self.data.qvel[self.qd_indices].copy(), device=DEVICE, dtype=torch.float32).unsqueeze(0)
        return quat_xyzw, linear_body, angular_body, q, qd

    def policy_step(self) -> tuple[torch.Tensor, torch.Tensor]:
        quat, _, angular_body, q, qd = self.state_tensors()
        gravity_body = quat_rotate_inverse(quat, self.gravity)
        observation = torch.cat(
            (
                angular_body * self.profile.ang_vel_scale,
                gravity_body,
                self.command * self.command_scale,
                q - self.default,
                qd * self.profile.dof_vel_scale,
                self.previous_action,
            ),
            dim=1,
        ).clamp_(-100.0, 100.0)
        if self.profile.history:
            self.history = update_history(self.history, observation.squeeze(0))
            policy_input = ordered_history(self.history, self.profile.history)
        else:
            policy_input = observation
        with torch.inference_mode():
            action = self.policy(policy_input).clamp_(-100.0, 100.0)
        if not torch.isfinite(action).all():
            raise FloatingPointError("policy action contains NaN or Inf")
        target = self.default + self.action_scale * action
        self.previous_action.copy_(action)
        return action, target

    def simulate_control_period(self, target: torch.Tensor) -> np.ndarray:
        target_np = target.squeeze(0).detach().cpu().numpy().astype(np.float64, copy=False)
        torque = np.zeros(self.profile.action_dim, dtype=np.float64)
        period_contact = np.zeros(len(self.foot_names), dtype=np.int8)
        for _ in range(DECIMATION):
            q = self.data.qpos[self.q_indices]
            qd = self.data.qvel[self.qd_indices]
            torque = np.clip(self.kp_np * (target_np - q) - self.kd_np * qd, -self.limits_np, self.limits_np)
            self.data.ctrl[self.actuator_indices] = torque
            mujoco.mj_step(self.model, self.data)
            period_contact |= self._active_foot_contacts()
        self.last_foot_contact = period_contact
        return torque

    def trajectory_sample(self, action: torch.Tensor, target: torch.Tensor, torque: np.ndarray) -> dict[str, np.ndarray | int]:
        quat, linear_body, angular_body, q, qd = self.state_tensors()
        q0 = self.root_q_index
        target_np = target.squeeze(0).detach().cpu().numpy().astype(np.float64, copy=False)
        torque_command = np.clip(
            self.kp_np * (target_np - self.data.qpos[self.q_indices])
            - self.kd_np * self.data.qvel[self.qd_indices],
            -self.limits_np,
            self.limits_np,
        )
        return {
            "root_position": self.data.qpos[q0 : q0 + 3].copy(),
            "root_quaternion_xyzw": quat.squeeze(0).cpu().numpy(),
            "root_linear_velocity_body": linear_body.squeeze(0).cpu().numpy(),
            "root_angular_velocity_body": angular_body.squeeze(0).cpu().numpy(),
            "joint_position": q.squeeze(0).cpu().numpy(),
            "joint_velocity": qd.squeeze(0).cpu().numpy(),
            "action": action.squeeze(0).detach().cpu().numpy(),
            "joint_target": target.squeeze(0).detach().cpu().numpy(),
            "joint_torque_command": torque_command,
            "joint_torque_applied_last_substep": torque.copy(),
            "contact_count": int(self.data.ncon),
            "foot_contact": self.last_foot_contact.copy(),
        }

    def render(self, renderer: mujoco.Renderer, camera: mujoco.MjvCamera) -> np.ndarray:
        root_position = self.data.qpos[self.root_q_index : self.root_q_index + 3]
        x, y, z, pitch, yaw = self.profile.camera
        camera.lookat[:] = root_position
        camera.lookat[2] = max(float(root_position[2]) * 0.65, 0.2)
        camera.distance = math.sqrt(x * x + y * y + (z - camera.lookat[2]) ** 2)
        camera.elevation = pitch
        camera.azimuth = yaw
        renderer.update_scene(self.data, camera=camera)
        return renderer.render()


def run(args: argparse.Namespace) -> dict:
    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is required for policy inference")
    torch.cuda.set_device(0)
    profile = PROFILES[args.robot]
    checkpoint = ensure_checkpoint(profile, args.checkpoint)
    player = MuJoCoPolicyPlayer(profile, checkpoint, (args.cmd_vx, args.cmd_vy, args.cmd_yaw))
    renderer = None
    writer = None
    if args.record:
        player.model.vis.global_.offwidth = max(
            int(player.model.vis.global_.offwidth), args.width
        )
        player.model.vis.global_.offheight = max(
            int(player.model.vis.global_.offheight), args.height
        )
        renderer = mujoco.Renderer(player.model, height=args.height, width=args.width)
        writer = VideoWriter(args.record, args.width, args.height)
    camera = mujoco.MjvCamera()
    camera.type = mujoco.mjtCamera.mjCAMERA_FREE
    frames = int(round(args.duration * FPS))
    trajectory: dict[str, list] = {}
    start = time.perf_counter()
    try:
        for frame_index in range(frames):
            action, target = player.policy_step()
            torque = player.simulate_control_period(target)
            sample = player.trajectory_sample(action, target, torque)
            for name, value in sample.items():
                trajectory.setdefault(name, []).append(value)
            if not all(np.isfinite(np.asarray(value)).all() for value in sample.values()):
                raise FloatingPointError(f"non-finite state at frame {frame_index}")
            if renderer is not None and writer is not None:
                writer.append(player.render(renderer, camera))
            if (frame_index + 1) % FPS == 0:
                xyz = sample["root_position"]
                print(f"[{profile.name}/mujoco] {(frame_index + 1) / FPS:.0f}/{args.duration:g}s height={xyz[2]:.3f}", flush=True)
    finally:
        if writer is not None:
            writer.close()
        if renderer is not None:
            renderer.close()
    torch.cuda.synchronize()
    elapsed = time.perf_counter() - start

    output = args.trajectory.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    arrays = {name: np.asarray(values) for name, values in trajectory.items()}
    np.savez_compressed(
        output,
        schema_version=np.array(1, dtype=np.int32),
        simulator=np.array("mujoco"),
        robot=np.array(profile.name),
        asset_sha256=np.array(_sha256(resolve_asset(profile))),
        time=(np.arange(frames, dtype=np.float64) + 1.0) / FPS,
        joint_names=np.asarray(profile.policy_joint_names),
        foot_names=np.asarray(player.foot_names),
        **arrays,
    )
    heights = arrays["root_position"][:, 2]
    quat = arrays["root_quaternion_xyzw"]
    upright = 1.0 - 2.0 * (quat[:, 0] ** 2 + quat[:, 1] ** 2)
    displacement = float(np.linalg.norm(arrays["root_position"][-1, :2] - arrays["root_position"][0, :2]))
    video = None
    if args.record:
        assert writer is not None
        decoded_frames, decoded_seconds = imageio_ffmpeg.count_frames_and_secs(
            str(args.record)
        )
        video = {
            "path": str(args.record.resolve()),
            "bytes": args.record.stat().st_size,
            "encoded_frames": writer.frames,
            "decoded_frames": decoded_frames,
            "decoded_seconds": decoded_seconds,
            "fps": FPS,
            "width": args.width,
            "height": args.height,
            "render_device": "cpu_opengl",
            "encoder_device": "cpu",
        }
        if (
            writer.frames != frames
            or decoded_frames != frames
            or not math.isclose(
                decoded_seconds, args.duration, abs_tol=1.0 / FPS
            )
        ):
            raise RuntimeError(f"video timing validation failed: {video}")
    summary = {
        "robot": profile.name,
        "solver": f"native MuJoCo {mujoco.__version__}",
        "asset": str(player.asset_path),
        "robot_asset_sha256": _sha256(resolve_asset(profile)),
        "checkpoint": str(checkpoint),
        "checkpoint_sha256": _sha256(checkpoint),
        "rl_sar_commit": RL_SAR_COMMIT,
        "rl_sar_zoo_commit": RL_SAR_ZOO_COMMIT,
        "command": [args.cmd_vx, args.cmd_vy, args.cmd_yaw],
        "dt": DT,
        "decimation": DECIMATION,
        "policy_hz": FPS,
        "simulated_seconds": frames / FPS,
        "frames": frames,
        "wall_seconds": elapsed,
        "realtime_factor": (frames / FPS) / elapsed,
        "devices": {"physics": "cpu", "policy": DEVICE, "state_transfer": "cpu_to_cuda_each_policy_tick"},
        "trajectory": str(output),
        "root_displacement_xy": displacement,
        "height_min": float(heights.min()),
        "height_final": float(heights[-1]),
        "upright_min": float(upright.min()),
        "upright_final": float(upright[-1]),
        "fell": bool(heights.min() < profile.fall_height or upright.min() < 0.5),
        "finite": True,
        "video": video,
        "control_contract": "torque-clipped PD recomputed at 200 Hz; target updated at 50 Hz",
    }
    summary_path = args.summary or output.with_suffix(".summary.json")
    summary_path = summary_path.resolve()
    summary_path.parent.mkdir(parents=True, exist_ok=True)
    summary_path.write_text(json.dumps(summary, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(summary, indent=2))
    return summary


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--robot", choices=PROFILES, required=True)
    parser.add_argument("--checkpoint", type=Path)
    parser.add_argument("--cmd-vx", type=float, default=0.5)
    parser.add_argument("--cmd-vy", type=float, default=0.0)
    parser.add_argument("--cmd-yaw", type=float, default=0.0)
    parser.add_argument("--duration", type=float, default=10.0)
    parser.add_argument("--trajectory", type=Path, required=True)
    parser.add_argument("--summary", type=Path)
    parser.add_argument("--record", type=Path)
    parser.add_argument("--width", type=int, default=960)
    parser.add_argument("--height", type=int, default=544)
    return parser


def main() -> None:
    args = create_parser().parse_args()
    if args.duration <= 0 or args.width <= 0 or args.height <= 0:
        raise SystemExit("duration, width, and height must be positive")
    run(args)


if __name__ == "__main__":
    main()
