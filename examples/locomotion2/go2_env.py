"""Vectorized Go2 locomotion environment powered by Synreal Solver."""

from __future__ import annotations

import argparse
import math
from pathlib import Path

import newton
import torch
import warp as wp
from tensordict import TensorDict

import synreal_solver


def _name(label: str) -> str:
    return label.rsplit("/", 1)[-1]


def _rotate_inverse(quaternion: torch.Tensor, vector: torch.Tensor) -> torch.Tensor:
    """Rotate vectors by inverse XYZW quaternions."""

    axis = -quaternion[..., :3]
    scalar = quaternion[..., 3:4]
    first_cross = torch.linalg.cross(axis, vector, dim=-1)
    return vector + 2.0 * (
        scalar * first_cross + torch.linalg.cross(axis, first_cross, dim=-1)
    )


def _relative_rpy_degrees(
    quaternion: torch.Tensor, initial_wxyz: torch.Tensor
) -> torch.Tensor:
    """Return roll, pitch, and yaw relative to the configured initial pose."""

    initial_xyzw = initial_wxyz[[1, 2, 3, 0]]
    inverse = torch.cat((-initial_xyzw[:3], initial_xyzw[3:]))
    left_xyz = inverse[:3].expand_as(quaternion[..., :3])
    left_w = inverse[3].expand_as(quaternion[..., 3])
    right_xyz = quaternion[..., :3]
    right_w = quaternion[..., 3]
    xyz = (
        left_w[..., None] * right_xyz
        + right_w[..., None] * left_xyz
        + torch.linalg.cross(left_xyz, right_xyz, dim=-1)
    )
    w = left_w * right_w - torch.sum(left_xyz * right_xyz, dim=-1)
    x, y, z = xyz.unbind(-1)
    roll = torch.atan2(2.0 * (w * x + y * z), 1.0 - 2.0 * (x.square() + y.square()))
    pitch = torch.asin(torch.clamp(2.0 * (w * y - z * x), -1.0, 1.0))
    yaw = torch.atan2(2.0 * (w * z + x * y), 1.0 - 2.0 * (y.square() + z.square()))
    return torch.rad2deg(torch.stack((roll, pitch, yaw), dim=-1))


class Go2Env:
    def __init__(
        self,
        num_envs,
        env_cfg,
        obs_cfg,
        reward_cfg,
        command_cfg,
        show_viewer=False,
        enable_viewer_forces=False,
        auto_reset=True,
    ):
        if num_envs <= 0:
            raise ValueError("num_envs must be positive")
        if not torch.cuda.is_available():
            raise RuntimeError("Synreal Solver locomotion requires a CUDA device")

        wp.init()
        self.num_envs = int(num_envs)
        self.num_actions = int(env_cfg["num_actions"])
        self.num_commands = int(command_cfg["num_commands"])
        self.cfg = env_cfg
        self.env_cfg = env_cfg
        self.obs_cfg = obs_cfg
        self.reward_cfg = reward_cfg
        self.command_cfg = command_cfg
        self.auto_reset = bool(auto_reset)
        self.device = torch.device("cuda:0")
        self.wp_device = wp.get_device(str(self.device))
        self.stream = wp.get_stream(self.wp_device)
        torch.cuda.set_device(self.device)

        self.simulate_action_latency = bool(
            env_cfg.get("simulate_action_latency", True)
        )
        self.dt = 0.02
        self.sim_substeps = 4
        self.sim_dt = self.dt / self.sim_substeps
        self.sim_time = 0.0
        self.max_episode_length = math.ceil(env_cfg["episode_length_s"] / self.dt)
        self.obs_scales = dict(obs_cfg["obs_scales"])
        self.reward_scales = {
            name: scale * self.dt for name, scale in reward_cfg["reward_scales"].items()
        }

        self.viewer = newton.viewer.ViewerGL(vsync=True) if show_viewer else None
        self.enable_viewer_forces = bool(enable_viewer_forces)
        if self.enable_viewer_forces and self.viewer is None:
            raise ValueError("enable_viewer_forces requires show_viewer=True")
        robot, joint_layout = self._create_robot()
        world = synreal_solver.ModelBuilder(up_axis=newton.Axis.Z)
        if self.num_envs == 1:
            world = robot
        else:
            world.replicate(robot, self.num_envs)
        world.default_shape_cfg.ke = 2.0e3
        world.default_shape_cfg.kd = 1.0e2
        world.default_shape_cfg.mu = 0.75
        world.add_ground_plane()

        self.model = world.finalize(device=self.wp_device)
        self.model.set_gravity((0.0, 0.0, -9.81))
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.model)

        self.solver = synreal_solver.NewtonSolver(self.model)
        self.solver.config.joint_constraint_mode = (
            synreal_solver.JointConstraintMode.AUGMENTED_LAGRANGIAN
        )
        self.solver.config.affine_body_rigidity_model = (
            synreal_solver.AffineBodyRigidityModel.CO_ROTATED
        )
        self.solver.config.inertia_mode = synreal_solver.InertiaMode.MIDPOINT_CAYLEY
        self.solver.config.joint_constraint_alpha = 2.0e2
        self.solver.config.nonlinear_iterations = int(
            env_cfg.get("solver_iterations", 10)
        )
        self.solver.config.linear_iterations = int(env_cfg.get("linear_iterations", 10))
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()

        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        newton.eval_fk(
            self.model, self.model.joint_q, self.model.joint_qd, self.state_0
        )
        self.state_1.assign(self.state_0)
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)
        wp.synchronize_device(self.wp_device)

        self.q_per_env = len(self.state_0.joint_q) // self.num_envs
        self.qd_per_env = len(self.state_0.joint_qd) // self.num_envs
        self.body_per_env = len(self.state_0.body_q) // self.num_envs
        self.target_per_env = len(self.control.joint_target_q) // self.num_envs
        self.motor_q = torch.tensor(
            joint_layout["q"], dtype=torch.long, device=self.device
        )
        self.motor_qd = torch.tensor(
            joint_layout["qd"], dtype=torch.long, device=self.device
        )
        self._bind_state_tensors()
        self._initial = {
            "joint_q": self.joint_q.clone(),
            "joint_qd": self.joint_qd.clone(),
            "body_q": self.body_q.clone(),
            "body_qd": self.body_qd.clone(),
        }

        self.default_dof_pos = torch.tensor(
            [env_cfg["default_joint_angles"][name] for name in env_cfg["joint_names"]],
            dtype=torch.float32,
            device=self.device,
        )
        self.init_base_pos = torch.tensor(
            env_cfg["base_init_pos"], dtype=torch.float32, device=self.device
        )
        self.init_base_quat = torch.tensor(
            env_cfg["base_init_quat"], dtype=torch.float32, device=self.device
        )
        self.global_gravity = torch.tensor([0.0, 0.0, -1.0], device=self.device)
        initial_xyzw = self.init_base_quat[[1, 2, 3, 0]].unsqueeze(0)
        self.init_projected_gravity = _rotate_inverse(
            initial_xyzw, self.global_gravity.unsqueeze(0)
        ).squeeze(0)

        self.commands = torch.empty(
            (self.num_envs, self.num_commands), device=self.device
        )
        self.commands_scale = torch.tensor(
            [
                self.obs_scales["lin_vel"],
                self.obs_scales["lin_vel"],
                self.obs_scales["ang_vel"],
            ],
            device=self.device,
        )
        ranges = (
            command_cfg["lin_vel_x_range"],
            command_cfg["lin_vel_y_range"],
            command_cfg["ang_vel_range"],
        )
        self.command_lower = torch.tensor(
            [value[0] for value in ranges], device=self.device
        )
        self.command_upper = torch.tensor(
            [value[1] for value in ranges], device=self.device
        )
        self.actions = torch.zeros(
            (self.num_envs, self.num_actions), device=self.device
        )
        self.last_actions = torch.zeros_like(self.actions)
        self.last_dof_vel = torch.zeros_like(self.actions)
        self.base_pos = torch.empty((self.num_envs, 3), device=self.device)
        self.base_quat = torch.empty((self.num_envs, 4), device=self.device)
        self.base_euler = torch.empty((self.num_envs, 3), device=self.device)
        self.base_lin_vel = torch.empty((self.num_envs, 3), device=self.device)
        self.base_ang_vel = torch.empty((self.num_envs, 3), device=self.device)
        self.projected_gravity = torch.empty((self.num_envs, 3), device=self.device)
        self.dof_pos = torch.empty_like(self.actions)
        self.dof_vel = torch.empty_like(self.actions)
        self.rew_buf = torch.zeros(self.num_envs, device=self.device)
        self.reset_buf = torch.ones(self.num_envs, dtype=torch.bool, device=self.device)
        self.episode_length_buf = torch.zeros(
            self.num_envs, dtype=torch.long, device=self.device
        )
        self.episode_sums = {
            name: torch.zeros(self.num_envs, device=self.device)
            for name in self.reward_scales
        }
        self.reward_functions = {
            name: getattr(self, f"_reward_{name}") for name in self.reward_scales
        }
        self.extras = {}
        self.simulation_graph = None

        if self.viewer is not None:
            self.viewer.set_model(self.model)
            if self.num_envs > 1:
                self.viewer.set_world_offsets((1.5, 1.5, 0.0))
        self.reset()
        self.capture_simulation_graph()

    def _create_robot(self):
        asset_override = self.env_cfg.get("asset_path")
        if asset_override:
            asset_path = Path(asset_override).expanduser().resolve()
        else:
            asset_path = (
                Path(newton.utils.download_asset("unitree_go2")) / "usd" / "go2.usda"
            )
        if not asset_path.is_file():
            raise FileNotFoundError(asset_path)

        robot = synreal_solver.ModelBuilder(up_axis=newton.Axis.Z)
        robot.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
            armature=0.01,
            limit_ke=1.0e3,
            limit_kd=10.0,
            friction=1.0e-5,
        )
        robot.default_shape_cfg.ke = 2.0e3
        robot.default_shape_cfg.kd = 1.0e2
        robot.default_shape_cfg.kf = 1.0e3
        robot.default_shape_cfg.mu = 0.75
        robot.add_usd(
            str(asset_path),
            floating=True,
            collapse_fixed_joints=True,
            enable_self_collisions=False,
            hide_collision_shapes=True,
        )

        joints = {_name(label): index for index, label in enumerate(robot.joint_label)}
        missing = [name for name in self.env_cfg["joint_names"] if name not in joints]
        if missing:
            raise ValueError(f"Go2 asset is missing joints: {missing}")

        q_indices = []
        qd_indices = []
        for name in self.env_cfg["joint_names"]:
            joint = joints[name]
            q_index = int(robot.joint_q_start[joint])
            qd_index = int(robot.joint_qd_start[joint])
            position = float(self.env_cfg["default_joint_angles"][name])
            q_indices.append(q_index)
            qd_indices.append(qd_index)
            robot.joint_q[q_index] = position
            robot.joint_target_q[q_index] = position
            robot.joint_target_ke[qd_index] = float(self.env_cfg["kp"])
            robot.joint_target_kd[qd_index] = float(self.env_cfg["kd"])
            robot.joint_target_mode[qd_index] = int(newton.JointTargetMode.POSITION)

        base_wxyz = self.env_cfg["base_init_quat"]
        robot.joint_q[:3] = self.env_cfg["base_init_pos"]
        robot.joint_q[3:7] = [base_wxyz[1], base_wxyz[2], base_wxyz[3], base_wxyz[0]]
        return robot, {"q": q_indices, "qd": qd_indices}

    def _bind_state_tensors(self):
        self.joint_q = wp.to_torch(self.state_0.joint_q).view(
            self.num_envs, self.q_per_env
        )
        self.joint_qd = wp.to_torch(self.state_0.joint_qd).view(
            self.num_envs, self.qd_per_env
        )
        self.next_joint_q = wp.to_torch(self.state_1.joint_q).view(
            self.num_envs, self.q_per_env
        )
        self.next_joint_qd = wp.to_torch(self.state_1.joint_qd).view(
            self.num_envs, self.qd_per_env
        )
        self.body_q = wp.to_torch(self.state_0.body_q).view(
            self.num_envs, self.body_per_env, 7
        )
        self.body_qd = wp.to_torch(self.state_0.body_qd).view(
            self.num_envs, self.body_per_env, 6
        )
        self.next_body_q = wp.to_torch(self.state_1.body_q).view(
            self.num_envs, self.body_per_env, 7
        )
        self.next_body_qd = wp.to_torch(self.state_1.body_qd).view(
            self.num_envs, self.body_per_env, 6
        )
        self.control_targets = wp.to_torch(self.control.joint_target_q).view(
            self.num_envs, self.target_per_env
        )

    def _resample_commands(self, mask):
        count = self.num_envs if mask is None else int(mask.sum().item())
        if count == 0:
            return
        sampled = self.command_lower + (
            self.command_upper - self.command_lower
        ) * torch.rand((count, self.num_commands), device=self.device)
        if mask is None:
            self.commands.copy_(sampled)
        else:
            self.commands[mask] = sampled

    def _simulate_uncaptured(self, *, keep_state_buffers=False):
        for substep in range(self.sim_substeps):
            newton.eval_ik(
                self.model, self.state_0, self.state_0.joint_q, self.state_0.joint_qd
            )
            self.collision_pipeline.collide(self.state_0, self.contacts)
            self.state_0.clear_forces()
            if self.enable_viewer_forces:
                self.viewer.apply_forces(self.state_0)
            self.solver.step(
                self.state_0, self.state_1, self.control, self.contacts, self.sim_dt
            )
            is_last_odd_substep = (
                keep_state_buffers
                and self.sim_substeps % 2 == 1
                and substep == self.sim_substeps - 1
            )
            if is_last_odd_substep:
                self.state_0.assign(self.state_1)
            else:
                self.state_0, self.state_1 = self.state_1, self.state_0
        newton.eval_ik(
            self.model, self.state_0, self.state_0.joint_q, self.state_0.joint_qd
        )

    def capture_simulation_graph(self):
        """Capture one complete 50 Hz simulation interval."""

        wp.synchronize_stream(self.stream)
        torch.cuda.current_stream(self.device).synchronize()
        self.simulation_graph = None
        with (
            wp.ScopedStream(self.stream),
            wp.ScopedCapture(stream=self.stream) as capture,
        ):
            self._simulate_uncaptured(keep_state_buffers=True)
        self.simulation_graph = capture.graph

    def _simulate(self):
        torch.cuda.current_stream(self.device).synchronize()
        with wp.ScopedStream(self.stream):
            if self.simulation_graph is None:
                self._simulate_uncaptured()
            else:
                wp.capture_launch(self.simulation_graph, stream=self.stream)
        wp.synchronize_stream(self.stream)
        self._bind_state_tensors()

    def _read_state(self):
        root_pose = self.body_q[:, 0]
        root_velocity = self.body_qd[:, 0]
        quaternion = torch.nn.functional.normalize(root_pose[:, 3:7], dim=-1)
        self.base_pos.copy_(root_pose[:, :3])
        self.base_quat.copy_(quaternion)
        self.base_euler.copy_(_relative_rpy_degrees(quaternion, self.init_base_quat))
        self.base_lin_vel.copy_(_rotate_inverse(quaternion, root_velocity[:, :3]))
        self.base_ang_vel.copy_(_rotate_inverse(quaternion, root_velocity[:, 3:]))
        gravity = self.global_gravity.expand_as(self.base_pos)
        self.projected_gravity.copy_(_rotate_inverse(quaternion, gravity))
        self.dof_pos.copy_(self.joint_q.index_select(1, self.motor_q))
        self.dof_vel.copy_(self.joint_qd.index_select(1, self.motor_qd))

    @torch.no_grad()
    def step(self, actions):
        if actions.shape != (self.num_envs, self.num_actions):
            raise ValueError(
                f"expected actions {(self.num_envs, self.num_actions)}, got {tuple(actions.shape)}"
            )
        self.actions.copy_(
            actions.to(self.device).clamp(
                -self.env_cfg["clip_actions"], self.env_cfg["clip_actions"]
            )
        )
        executed = self.last_actions if self.simulate_action_latency else self.actions
        targets = self.default_dof_pos + float(self.env_cfg["action_scale"]) * executed
        self.control_targets[:, self.motor_qd] = targets
        self._simulate()
        self.sim_time += self.dt
        self.episode_length_buf += 1
        self._read_state()

        self.rew_buf.zero_()
        for name, reward_function in self.reward_functions.items():
            contribution = reward_function() * self.reward_scales[name]
            self.rew_buf.add_(contribution)
            self.episode_sums[name].add_(contribution)

        interval = max(1, int(self.env_cfg["resampling_time_s"] / self.dt))
        self._resample_commands(self.episode_length_buf.remainder(interval) == 0)
        timed_out = self.episode_length_buf > self.max_episode_length
        invalid = ~torch.isfinite(self.body_q).all(dim=(1, 2))
        self.reset_buf.copy_(timed_out)
        self.reset_buf.logical_or_(
            torch.abs(self.base_euler[:, 1])
            > self.env_cfg["termination_if_pitch_greater_than"]
        )
        self.reset_buf.logical_or_(
            torch.abs(self.base_euler[:, 0])
            > self.env_cfg["termination_if_roll_greater_than"]
        )
        self.reset_buf.logical_or_(invalid)
        done = self.reset_buf.clone()
        self.extras["time_outs"] = timed_out.float()
        if self.auto_reset:
            self._reset_idx(done)
        self._update_observation()
        self.last_actions.copy_(self.actions)
        self.last_dof_vel.copy_(self.dof_vel)
        self.render()
        return self.get_observations(), self.rew_buf, done, self.extras

    def get_observations(self):
        return TensorDict({"policy": self.obs_buf}, batch_size=[self.num_envs])

    def _reset_idx(self, mask=None):
        if mask is None:
            mask = torch.ones(self.num_envs, dtype=torch.bool, device=self.device)
        if not bool(torch.any(mask)):
            self.extras["episode"] = {}
            return

        for current, alternate, initial in (
            (self.joint_q, self.next_joint_q, self._initial["joint_q"]),
            (self.joint_qd, self.next_joint_qd, self._initial["joint_qd"]),
            (self.body_q, self.next_body_q, self._initial["body_q"]),
            (self.body_qd, self.next_body_qd, self._initial["body_qd"]),
        ):
            current[mask] = initial[mask]
            alternate[mask] = initial[mask]

        torch.cuda.synchronize(self.device)
        newton.eval_fk(
            self.model, self.state_0.joint_q, self.state_0.joint_qd, self.state_0
        )
        newton.eval_fk(
            self.model, self.state_1.joint_q, self.state_1.joint_qd, self.state_1
        )
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)
        wp.synchronize_device(self.wp_device)
        self._bind_state_tensors()
        self._read_state()

        self.actions[mask] = 0.0
        self.last_actions[mask] = 0.0
        self.last_dof_vel[mask] = 0.0
        self.episode_length_buf[mask] = 0
        self.reset_buf[mask] = True
        self.extras["episode"] = {}
        count = int(mask.sum().item())
        for name, total in self.episode_sums.items():
            self.extras["episode"][f"rew_{name}"] = (
                total[mask].sum() / count / self.env_cfg["episode_length_s"]
            )
            total[mask] = 0.0
        self._resample_commands(mask)

    def _update_observation(self):
        self.obs_buf = torch.cat(
            (
                self.base_ang_vel * self.obs_scales["ang_vel"],
                self.projected_gravity,
                self.commands * self.commands_scale,
                (self.dof_pos - self.default_dof_pos) * self.obs_scales["dof_pos"],
                self.dof_vel * self.obs_scales["dof_vel"],
                self.actions,
            ),
            dim=-1,
        )

    def reset(self):
        self._reset_idx()
        self._update_observation()
        return self.get_observations()

    def render(self):
        if self.viewer is None or not self.viewer.is_running():
            return
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.end_frame()

    def is_running(self):
        return self.viewer is None or self.viewer.is_running()

    def close(self):
        if self.viewer is not None:
            self.viewer.close()
            self.viewer = None

    def _reward_tracking_lin_vel(self):
        error = torch.sum(
            (self.commands[:, :2] - self.base_lin_vel[:, :2]).square(), dim=1
        )
        return torch.exp(-error / self.reward_cfg["tracking_sigma"])

    def _reward_tracking_ang_vel(self):
        error = (self.commands[:, 2] - self.base_ang_vel[:, 2]).square()
        return torch.exp(-error / self.reward_cfg["tracking_sigma"])

    def _reward_lin_vel_z(self):
        return self.base_lin_vel[:, 2].square()

    def _reward_action_rate(self):
        return torch.sum((self.last_actions - self.actions).square(), dim=1)

    def _reward_similar_to_default(self):
        return torch.sum(torch.abs(self.dof_pos - self.default_dof_pos), dim=1)

    def _reward_base_height(self):
        return (self.base_pos[:, 2] - self.reward_cfg["base_height_target"]).square()


def _preview_configs():
    joint_names = (
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
    )
    default_joint_angles = {
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
    }
    env_cfg = {
        "num_actions": 12,
        "joint_names": joint_names,
        "default_joint_angles": default_joint_angles,
        "kp": 80.0,
        "kd": 2.0,
        "termination_if_roll_greater_than": 35.0,
        "termination_if_pitch_greater_than": 35.0,
        "base_init_pos": [0.0, 0.0, 0.42],
        "base_init_quat": [1.0, 0.0, 0.0, 0.0],
        "episode_length_s": 20.0,
        "resampling_time_s": 4.0,
        "action_scale": 0.25,
        "simulate_action_latency": True,
        "clip_actions": 100.0,
    }
    obs_cfg = {
        "obs_scales": {
            "lin_vel": 2.0,
            "ang_vel": 0.25,
            "dof_pos": 1.0,
            "dof_vel": 0.05,
        }
    }
    reward_cfg = {"reward_scales": {}}
    command_cfg = {
        "num_commands": 3,
        "lin_vel_x_range": [0.0, 0.0],
        "lin_vel_y_range": [0.0, 0.0],
        "ang_vel_range": [0.0, 0.0],
    }
    return env_cfg, obs_cfg, reward_cfg, command_cfg


def main():
    parser = argparse.ArgumentParser(description="Preview the Synreal Go2 scene.")
    parser.add_argument("--asset", type=Path, help="Optional path to a Go2 USD asset")
    args = parser.parse_args()

    configs = list(_preview_configs())
    if args.asset is not None:
        configs[0]["asset_path"] = str(args.asset)
    env = Go2Env(
        1,
        *configs,
        show_viewer=True,
        enable_viewer_forces=True,
        auto_reset=False,
    )
    env.viewer.set_camera(pos=wp.vec3(2.0, -2.0, 1.3), pitch=-12.0, yaw=135.0)
    actions = torch.zeros((1, env.num_actions), device=env.device)
    try:
        env.render()
        while env.is_running():
            if env.viewer.should_step():
                env.step(actions)
            else:
                env.render()
    except KeyboardInterrupt:
        pass
    finally:
        env.close()


if __name__ == "__main__":
    main()
