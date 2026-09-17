"""Independent vectorized Unitree G1 locomotion environment for SynReal."""

from __future__ import annotations

import math
import os
from pathlib import Path
from typing import Any

import newton
import newton.utils
import torch
import warp as wp
from newton import JointTargetMode

import synreal_solver

from .config import (
    ARM_JOINTS,
    CRITIC_OBSERVATION_DIM,
    CRITIC_TERM_DIMS,
    DEFAULT_JOINT_POS,
    HISTORY_LENGTH,
    JOINT_EFFORT_LIMIT,
    JOINT_KD,
    JOINT_KP,
    JOINT_NAMES,
    JOINT_VELOCITY_LIMIT,
    LEG_DEVIATION_JOINTS,
    POLICY_OBSERVATION_DIM,
    POLICY_TERM_DIMS,
    WAIST_JOINTS,
    G1EnvConfig,
)
from .contact import GeometryContactTracker
from .math_ops import TermHistory, yaw_quaternion
from .observations import critic_terms, policy_terms, root_terms
from .rewards import RewardInputs, compute_reward

DEFAULT_UNITREE_RL_LAB_ASSET = Path(
    "/home/ubuntu/trampoline_sim/assets/unitree_g1_29dof/g1_29dof_rev_1_0.usd"
)


def _basename(label: str) -> str:
    return label.rsplit("/", 1)[-1]


def resolve_g1_asset(configured_path: Path | None) -> tuple[Path, str]:
    """Resolve the exact local Unitree RL Lab asset, with a portable fallback."""

    candidates: list[tuple[Path, str]] = []
    if configured_path is not None:
        candidates.append((configured_path.expanduser(), "configured"))
    environment_path = os.environ.get("G1_ASSET_PATH")
    if environment_path:
        candidates.append((Path(environment_path).expanduser(), "G1_ASSET_PATH"))
    candidates.append((DEFAULT_UNITREE_RL_LAB_ASSET, "unitree_rl_lab"))
    for path, source in candidates:
        resolved = path.resolve()
        if resolved.is_file():
            return resolved, source
    if configured_path is not None:
        raise FileNotFoundError(configured_path)

    asset_root = newton.utils.download_asset("unitree_g1")
    fallback = asset_root / "urdf" / "g1_29dof_rev_1_0.urdf"
    if not fallback.is_file():
        raise FileNotFoundError(
            "Could not resolve the Unitree RL Lab G1 asset or Newton's G1 URDF"
        )
    return fallback, "newton_urdf_fallback"


def _map_named_indices(
    labels: list[str], names: tuple[str, ...], kind: str
) -> list[int]:
    by_name = {_basename(label): index for index, label in enumerate(labels)}
    missing = sorted(set(names) - by_name.keys())
    if missing:
        raise RuntimeError(f"G1 asset is missing {kind}: {missing}")
    result = [by_name[name] for name in names]
    if len(set(result)) != len(names):
        raise RuntimeError(f"G1 {kind} mapping is not one-to-one")
    return result


def _randomize_robot_friction(
    builder: Any,
    *,
    num_envs: int,
    shapes_per_env: int,
    friction_range: tuple[float, float],
    num_buckets: int,
    seed: int,
) -> dict[str, float]:
    if num_buckets <= 0:
        raise ValueError("friction_buckets must be positive")
    low, high = friction_range
    if low < 0.0 or high < low:
        raise ValueError("friction_range must be non-negative and ordered")
    generator = torch.Generator(device="cpu").manual_seed(seed)
    buckets = low + (high - low) * torch.rand(num_buckets, generator=generator)
    bucket_ids = torch.randint(
        num_buckets,
        (num_envs, shapes_per_env),
        generator=generator,
    )
    coefficients = buckets[bucket_ids]
    robot_shape_count = num_envs * shapes_per_env
    builder.shape_material_mu[:robot_shape_count] = coefficients.flatten().tolist()
    return {
        "minimum": float(coefficients.min()),
        "mean": float(coefficients.mean()),
        "maximum": float(coefficients.max()),
    }


def build_g1_scene(config: G1EnvConfig) -> tuple[Any, dict[str, Any]]:
    """Build replicated G1 worlds without using another locomotion environment."""

    newton.use_coord_layout_targets = True
    simulation = config.simulation
    robot = newton.ModelBuilder(up_axis=newton.Axis.Z)
    robot.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
        armature=simulation.joint_armature_approximation,
        limit_ke=1.0e3,
        limit_kd=10.0,
        friction=1.0e-5,
    )
    robot.default_shape_cfg.ke = simulation.contact_stiffness
    robot.default_shape_cfg.kd = simulation.contact_damping
    robot.default_shape_cfg.kf = simulation.contact_friction_gain
    robot.default_shape_cfg.mu = simulation.ground_friction

    asset_path, asset_source = resolve_g1_asset(config.asset_path)
    import_options = {
        "floating": True,
        "collapse_fixed_joints": True,
        "enable_self_collisions": config.enable_self_collisions,
    }
    if asset_path.suffix.lower() in {".usd", ".usda", ".usdc"}:
        robot.add_usd(
            str(asset_path),
            xform=wp.transform(wp.vec3(0.0, 0.0, config.initial_base_height)),
            joint_ordering="dfs",
            hide_collision_shapes=True,
            skip_mesh_approximation=True,
            **import_options,
        )
    elif asset_path.suffix.lower() == ".urdf":
        robot.default_shape_cfg.density = 0.0
        robot.add_urdf(
            str(asset_path),
            xform=wp.transform(wp.vec3(0.0, 0.0, config.initial_base_height)),
            **import_options,
        )
    else:
        raise ValueError(f"Unsupported G1 asset type: {asset_path}")

    joint_indices = _map_named_indices(robot.joint_label, JOINT_NAMES, "joints")
    q_indices = [int(robot.joint_q_start[index]) for index in joint_indices]
    qd_indices = [int(robot.joint_qd_start[index]) for index in joint_indices]
    if len(set(q_indices)) != 29 or len(set(qd_indices)) != 29:
        raise RuntimeError("Expected 29 independent G1 joint coordinates")

    robot.joint_q[:3] = [0.0, 0.0, config.initial_base_height]
    robot.joint_q[3:7] = [0.0, 0.0, 0.0, 1.0]
    for slot, (q_index, qd_index) in enumerate(zip(q_indices, qd_indices, strict=True)):
        default = DEFAULT_JOINT_POS[slot]
        robot.joint_q[q_index] = default
        robot.joint_target_q[q_index] = default
        robot.joint_target_ke[qd_index] = JOINT_KP[slot]
        robot.joint_target_kd[qd_index] = JOINT_KD[slot]
        robot.joint_effort_limit[qd_index] = JOINT_EFFORT_LIMIT[slot]
        robot.joint_armature[qd_index] = simulation.joint_armature_approximation
        robot.joint_target_mode[qd_index] = int(JointTargetMode.POSITION)

    for shape in range(len(robot.shape_material_mu)):
        robot.shape_material_ke[shape] = simulation.contact_stiffness
        robot.shape_material_kd[shape] = simulation.contact_damping
        robot.shape_material_kf[shape] = simulation.contact_friction_gain
        robot.shape_material_mu[shape] = simulation.ground_friction
    if config.mesh_approximation:
        robot.approximate_meshes(config.mesh_approximation)

    body_indices = _map_named_indices(
        robot.body_label,
        ("pelvis", "left_ankle_roll_link", "right_ankle_roll_link"),
        "bodies",
    )
    root_body, left_foot_body, right_foot_body = body_indices
    body_names = tuple(_basename(label) for label in robot.body_label)
    undesired_body_indices = tuple(
        index for index, name in enumerate(body_names) if "ankle" not in name
    )

    builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
    builder.default_shape_cfg.ke = simulation.contact_stiffness
    builder.default_shape_cfg.kd = simulation.contact_damping
    builder.default_shape_cfg.kf = simulation.contact_friction_gain
    builder.default_shape_cfg.mu = simulation.ground_friction
    builder.replicate(robot, config.num_envs)
    friction_summary = _randomize_robot_friction(
        builder,
        num_envs=config.num_envs,
        shapes_per_env=len(robot.shape_material_mu),
        friction_range=config.randomization.friction_range,
        num_buckets=config.randomization.friction_buckets,
        seed=config.seed,
    )
    ground_config = newton.ModelBuilder.ShapeConfig(
        ke=simulation.contact_stiffness,
        kd=simulation.contact_damping,
        kf=simulation.contact_friction_gain,
        mu=simulation.ground_friction,
    )
    builder.add_ground_plane(cfg=ground_config)
    return builder, {
        "asset_path": asset_path,
        "asset_source": asset_source,
        "q_indices": tuple(q_indices),
        "qd_indices": tuple(qd_indices),
        "root_body": root_body,
        "foot_bodies": (left_foot_body, right_foot_body),
        "undesired_bodies": undesired_body_indices,
        "bodies_per_env": len(robot.body_label),
        "q_per_env": len(robot.joint_q),
        "qd_per_env": len(robot.joint_qd),
        "targets_per_env": len(robot.joint_target_q),
        "friction_summary": friction_summary,
    }


class SynRealG1LocomotionEnv:
    """RSL-RL vector environment for Unitree G1 velocity tracking."""

    num_actions = 29
    num_obs = POLICY_OBSERVATION_DIM
    num_privileged_obs = CRITIC_OBSERVATION_DIM

    def __init__(
        self,
        config: G1EnvConfig | None = None,
        *,
        viewer: Any | None = None,
    ) -> None:
        self.cfg = config or G1EnvConfig()
        if self.cfg.num_envs <= 0:
            raise ValueError("num_envs must be positive")
        if not torch.cuda.is_available():
            raise RuntimeError("SynRealG1LocomotionEnv requires CUDA")
        if self.cfg.simulation.decimation <= 0:
            raise ValueError("simulation decimation must be positive")

        self.num_envs = self.cfg.num_envs
        self.device = torch.device(self.cfg.device)
        torch.cuda.set_device(self.device)
        self.wp_device = wp.get_device(self.cfg.device)
        if not self.wp_device.is_cuda:
            raise RuntimeError("SynRealG1LocomotionEnv requires a CUDA Warp device")
        self.stream = wp.get_stream(self.wp_device)
        self.generator = torch.Generator(device=self.device).manual_seed(self.cfg.seed)
        self.step_dt = self.cfg.simulation.policy_dt
        self.physics_dt = self.cfg.simulation.dt
        self.max_episode_length = round(
            self.cfg.simulation.episode_length_s / self.step_dt
        )
        self.sim_time = 0.0
        self.common_step_counter = 0
        self.viewer = viewer

        builder, layout = build_g1_scene(self.cfg)
        self.asset_path = layout["asset_path"]
        self.asset_source = layout["asset_source"]
        self.model = builder.finalize(device=self.wp_device)
        self.friction_summary = layout["friction_summary"]
        self.model.set_gravity((0.0, 0.0, self.cfg.simulation.gravity))
        self.solver = synreal_solver.NewtonSolver(
            self.model,
            joint_drive_armature=self.cfg.simulation.joint_armature_approximation,
        )
        self.solver.config.joint_constraint_mode = (
            synreal_solver.JointConstraintMode.AUGMENTED_LAGRANGIAN
        )
        self.solver.config.affine_body_rigidity_model = (
            synreal_solver.AffineBodyRigidityModel.SIX_SPRINGS
        )
        self.solver.config.inertia_mode = synreal_solver.InertiaMode.MIDPOINT_CAYLEY
        self.solver.config.nonlinear_solver = synreal_solver.NonlinearSolver.NEWTON
        self.solver.config.constraint_alpha = self.cfg.simulation.constraint_alpha
        self.solver.config.joint_constraint_primal_iterations = (
            self.cfg.simulation.joint_constraint_primal_iterations
        )
        self.solver.config.nonlinear_iterations = (
            self.cfg.simulation.nonlinear_iterations
        )
        self.solver.config.linear_iterations = self.cfg.simulation.linear_iterations

        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        wp.copy(self.control.joint_target_q, self.model.joint_target_q)
        wp.copy(self.control.joint_target_qd, self.model.joint_target_qd)
        wp.copy(self.control.joint_f, self.model.joint_f)
        newton.eval_fk(
            self.model,
            self.state_0.joint_q,
            self.state_0.joint_qd,
            self.state_0,
        )
        self.state_1.assign(self.state_0)
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)

        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()
        self.q_per_env = layout["q_per_env"]
        self.qd_per_env = layout["qd_per_env"]
        self.targets_per_env = layout["targets_per_env"]
        self.bodies_per_env = layout["bodies_per_env"]
        expected_sizes = (
            (len(self.state_0.joint_q), self.q_per_env, "joint_q"),
            (len(self.state_0.joint_qd), self.qd_per_env, "joint_qd"),
            (len(self.state_0.body_q), self.bodies_per_env, "body_q"),
            (len(self.control.joint_target_q), self.targets_per_env, "targets"),
        )
        for total, per_env, name in expected_sizes:
            if total != self.num_envs * per_env:
                raise RuntimeError(f"Replicated {name} is not world-contiguous")

        self.q_indices = torch.tensor(
            layout["q_indices"], dtype=torch.long, device=self.device
        )
        self.qd_indices = torch.tensor(
            layout["qd_indices"], dtype=torch.long, device=self.device
        )
        self.target_indices = self.q_indices
        self.root_body = int(layout["root_body"])
        self.foot_bodies = torch.tensor(
            layout["foot_bodies"], dtype=torch.long, device=self.device
        )
        self.arm_indices = torch.tensor(
            ARM_JOINTS, dtype=torch.long, device=self.device
        )
        self.waist_indices = torch.tensor(
            WAIST_JOINTS, dtype=torch.long, device=self.device
        )
        self.leg_deviation_indices = torch.tensor(
            LEG_DEVIATION_JOINTS, dtype=torch.long, device=self.device
        )
        self._bind_torch_views()

        self.initial_joint_q = self.joint_q_0.clone()
        self.initial_joint_qd = self.joint_qd_0.clone()
        self.default_control_targets = self.control_targets.clone()
        self.default_joint_position = torch.tensor(
            DEFAULT_JOINT_POS, dtype=torch.float32, device=self.device
        ).expand(self.num_envs, -1)
        self.kp = torch.tensor(JOINT_KP, device=self.device).expand(self.num_envs, -1)
        self.kd = torch.tensor(JOINT_KD, device=self.device).expand(self.num_envs, -1)
        self.effort_limit = torch.tensor(JOINT_EFFORT_LIMIT, device=self.device).expand(
            self.num_envs, -1
        )
        self.velocity_limit = torch.tensor(
            JOINT_VELOCITY_LIMIT, device=self.device
        ).expand(self.num_envs, -1)
        joint_lower = (
            wp.to_torch(self.model.joint_limit_lower)
            .view(self.num_envs, self.qd_per_env)
            .index_select(1, self.qd_indices)
        )
        joint_upper = (
            wp.to_torch(self.model.joint_limit_upper)
            .view(self.num_envs, self.qd_per_env)
            .index_select(1, self.qd_indices)
        )
        midpoint = 0.5 * (joint_lower + joint_upper)
        half_range = 0.45 * (joint_upper - joint_lower)
        self.soft_joint_lower = midpoint - half_range
        self.soft_joint_upper = midpoint + half_range

        contact_cfg = self.cfg.contacts
        self.contact_tracker = GeometryContactTracker(
            self.model,
            self.contacts,
            num_envs=self.num_envs,
            bodies_per_env=self.bodies_per_env,
            foot_body_indices=layout["foot_bodies"],
            undesired_body_indices=layout["undesired_bodies"],
            debounce_substeps=contact_cfg.debounce_substeps,
            history_substeps=contact_cfg.history_substeps,
            maximum_separation=contact_cfg.maximum_separation,
            dt=self.physics_dt,
            device=self.wp_device,
            stream=self.stream,
        )

        self.actions = torch.zeros(
            (self.num_envs, self.num_actions), device=self.device
        )
        self.previous_actions = torch.zeros_like(self.actions)
        self.previous_joint_velocity = torch.zeros_like(self.actions)
        self.commands = torch.zeros((self.num_envs, 3), device=self.device)
        self.command_steps = torch.zeros(
            self.num_envs, dtype=torch.long, device=self.device
        )
        command_cfg = self.cfg.commands
        self.command_ranges = {
            "x": list(command_cfg.initial_lin_vel_x),
            "y": list(command_cfg.initial_lin_vel_y),
            "yaw": list(command_cfg.initial_ang_vel_z),
        }
        self.episode_length_buf = torch.zeros(
            self.num_envs, dtype=torch.long, device=self.device
        )
        self.episode_return = torch.zeros(self.num_envs, device=self.device)
        self.episode_track_reward = torch.zeros(self.num_envs, device=self.device)
        self.reset_buf = torch.zeros(
            self.num_envs, dtype=torch.bool, device=self.device
        )
        self.timeout_buf = torch.zeros_like(self.reset_buf)
        self.policy_history = TermHistory(
            self.num_envs,
            POLICY_TERM_DIMS,
            HISTORY_LENGTH,
            device=self.device,
        )
        self.critic_history = TermHistory(
            self.num_envs,
            CRITIC_TERM_DIMS,
            HISTORY_LENGTH,
            device=self.device,
        )
        self._actor_observation = torch.zeros(
            (self.num_envs, self.num_obs), device=self.device
        )
        self._critic_observation = torch.zeros(
            (self.num_envs, self.num_privileged_obs), device=self.device
        )
        self.extras: dict[str, Any] = {}
        self.simulation_graph = None

        if self.viewer is not None:
            self.viewer.set_model(self.model)
            if self.num_envs > 1:
                self.viewer.set_world_offsets((2.5, 2.5, 0.0))
            self.viewer.set_camera(pos=wp.vec3(3.2, -4.2, 2.2), pitch=-10.0, yaw=52.0)

        self.reset()
        if self.cfg.use_cuda_graph:
            self.capture_simulation_graph()
            self.reset()

    def _bind_torch_views(self) -> None:
        def body_view(array: Any) -> torch.Tensor:
            return wp.to_torch(array).view(self.num_envs, self.bodies_per_env, -1)

        self.joint_q_0 = wp.to_torch(self.state_0.joint_q).view(
            self.num_envs, self.q_per_env
        )
        self.joint_q_1 = wp.to_torch(self.state_1.joint_q).view(
            self.num_envs, self.q_per_env
        )
        self.joint_qd_0 = wp.to_torch(self.state_0.joint_qd).view(
            self.num_envs, self.qd_per_env
        )
        self.joint_qd_1 = wp.to_torch(self.state_1.joint_qd).view(
            self.num_envs, self.qd_per_env
        )
        self.body_q_0 = body_view(self.state_0.body_q)
        self.body_q_1 = body_view(self.state_1.body_q)
        self.body_qd_0 = body_view(self.state_0.body_qd)
        self.body_qd_1 = body_view(self.state_1.body_qd)
        self.control_targets = wp.to_torch(self.control.joint_target_q).view(
            self.num_envs, self.targets_per_env
        )

    def _current_state(self) -> dict[str, torch.Tensor]:
        root_pose = self.body_q_0[:, self.root_body]
        root_velocity_world = self.body_qd_0[:, self.root_body]
        root_quaternion = torch.nn.functional.normalize(root_pose[:, 3:7], dim=-1)
        linear_velocity, angular_velocity, projected_gravity = root_terms(
            root_quaternion, root_velocity_world
        )
        return {
            "root_position": root_pose[:, :3],
            "root_quaternion": root_quaternion,
            "root_velocity_world": root_velocity_world,
            "linear_velocity": linear_velocity,
            "angular_velocity": angular_velocity,
            "projected_gravity": projected_gravity,
            "joint_position": self.joint_q_0.index_select(1, self.q_indices),
            "joint_velocity": self.joint_qd_0.index_select(1, self.qd_indices),
            "foot_position": self.body_q_0.index_select(1, self.foot_bodies)[..., :3],
            "foot_velocity": self.body_qd_0.index_select(1, self.foot_bodies)[..., :3],
        }

    def _observation_terms(
        self, state: dict[str, torch.Tensor]
    ) -> tuple[tuple[torch.Tensor, ...], tuple[torch.Tensor, ...]]:
        policy = policy_terms(
            state["angular_velocity"],
            state["projected_gravity"],
            self.commands,
            state["joint_position"],
            self.default_joint_position,
            state["joint_velocity"],
            self.actions,
            self.cfg.observation_noise,
            self.generator,
        )
        critic = critic_terms(
            state["linear_velocity"],
            state["angular_velocity"],
            state["projected_gravity"],
            self.commands,
            state["joint_position"],
            self.default_joint_position,
            state["joint_velocity"],
            self.actions,
        )
        return policy, critic

    def _update_observations(self, reset_ids: torch.Tensor | None = None) -> None:
        policy, critic = self._observation_terms(self._current_state())
        self._actor_observation = self.policy_history.update(policy, reset_ids)
        self._critic_observation = self.critic_history.update(critic, reset_ids)
        if self._actor_observation.shape[1] != self.num_obs:
            raise RuntimeError("Policy observation ABI changed unexpectedly")
        if self._critic_observation.shape[1] != self.num_privileged_obs:
            raise RuntimeError("Critic observation ABI changed unexpectedly")

    def get_observations(self) -> tuple[torch.Tensor, dict[str, Any]]:
        return self._actor_observation, {
            "observations": {"critic": self._critic_observation}
        }

    def get_privileged_observations(self) -> torch.Tensor:
        return self._critic_observation

    def _uniform(self, count: int, low: float, high: float) -> torch.Tensor:
        return low + (high - low) * torch.rand(
            count, device=self.device, generator=self.generator
        )

    def _resample_commands(self, env_ids: torch.Tensor) -> None:
        count = env_ids.numel()
        if count == 0:
            return
        for column, key in enumerate(("x", "y", "yaw")):
            low, high = self.command_ranges[key]
            self.commands[env_ids, column] = self._uniform(count, low, high)
        standing = (
            torch.rand(count, device=self.device, generator=self.generator)
            <= self.cfg.commands.standing_fraction
        )
        if torch.any(standing):
            self.commands[env_ids[standing]] = 0.0
        self.command_steps[env_ids] = 0

    def _sync_kinematics(self) -> None:
        torch.cuda.current_stream(self.device).synchronize()
        with wp.ScopedStream(self.stream):
            for state in (self.state_0, self.state_1):
                newton.eval_fk(self.model, state.joint_q, state.joint_qd, state)
                self.solver.sync_affine_body_state(state)
        wp.synchronize_stream(self.stream)

    @torch.no_grad()
    def _reset_state(self, env_ids: torch.Tensor) -> None:
        if env_ids.numel() == 0:
            return
        env_ids = env_ids.to(device=self.device, dtype=torch.long)
        count = env_ids.numel()
        reset_q = self.initial_joint_q[env_ids].clone()
        reset_qd = self.initial_joint_qd[env_ids].clone()
        reset_q[:, 0] += self._uniform(count, -0.5, 0.5)
        reset_q[:, 1] += self._uniform(count, -0.5, 0.5)
        reset_q[:, 3:7] = yaw_quaternion(self._uniform(count, -math.pi, math.pi))
        reset_q[:, self.q_indices] = self.default_joint_position[env_ids]
        reset_qd.zero_()
        reset_qd[:, self.qd_indices] = self._uniform(count * 29, -1.0, 1.0).view(
            count, 29
        )
        self.joint_q_0[env_ids] = reset_q
        self.joint_q_1[env_ids] = reset_q
        self.joint_qd_0[env_ids] = reset_qd
        self.joint_qd_1[env_ids] = reset_qd
        self.control_targets[env_ids] = self.default_control_targets[env_ids]
        self.actions[env_ids] = 0.0
        self.previous_actions[env_ids] = 0.0
        self.previous_joint_velocity[env_ids] = reset_qd.index_select(
            1, self.qd_indices
        )
        self.episode_length_buf[env_ids] = 0
        self.episode_return[env_ids] = 0.0
        self.episode_track_reward[env_ids] = 0.0
        self.reset_buf[env_ids] = False
        self.timeout_buf[env_ids] = False
        self.contact_tracker.reset(env_ids)
        self._resample_commands(env_ids)
        self._sync_kinematics()

    @torch.no_grad()
    def reset(self, env_ids: torch.Tensor | None = None) -> torch.Tensor:
        if env_ids is None:
            env_ids = torch.arange(self.num_envs, device=self.device)
        env_ids = env_ids.to(device=self.device, dtype=torch.long)
        self._reset_state(env_ids)
        policy, critic = self._observation_terms(self._current_state())
        self._actor_observation = self.policy_history.fill(policy, env_ids)
        self._critic_observation = self.critic_history.fill(critic, env_ids)
        return self._actor_observation

    def _simulate_uncaptured(self) -> None:
        for _ in range(self.cfg.simulation.decimation):
            self.state_0.clear_forces()
            self.collision_pipeline.collide(self.state_0, self.contacts)
            self.contact_tracker.update(self.state_0.body_q)
            self.solver.step(
                self.state_0,
                self.state_1,
                self.control,
                self.contacts,
                self.physics_dt,
            )
            self.state_0, self.state_1 = self.state_1, self.state_0

    def capture_simulation_graph(self) -> None:
        """Capture one 50 Hz policy interval on the SynReal CUDA stream."""

        if self.cfg.simulation.decimation % 2 != 0:
            raise RuntimeError("CUDA graph capture currently requires even decimation")
        self.simulation_graph = None
        torch.cuda.current_stream(self.device).synchronize()
        wp.synchronize_stream(self.stream)
        with (
            wp.ScopedStream(self.stream),
            wp.ScopedCapture(stream=self.stream) as capture,
        ):
            self._simulate_uncaptured()
        self.simulation_graph = capture.graph

    def _simulate(self) -> None:
        if self.simulation_graph is None:
            self._simulate_uncaptured()
        else:
            wp.capture_launch(self.simulation_graph, stream=self.stream)

    def _update_curriculum(self, done: torch.Tensor) -> None:
        if self.common_step_counter % self.max_episode_length != 0:
            return
        if not torch.any(done):
            return
        mean_rate = (
            self.episode_track_reward[done].mean()
            / self.cfg.simulation.episode_length_s
        )
        if float(mean_rate) <= self.cfg.commands.curriculum_success_rate:
            return
        increment = self.cfg.commands.curriculum_increment
        limits = {
            "x": self.cfg.commands.limit_lin_vel_x,
            "y": self.cfg.commands.limit_lin_vel_y,
        }
        for key in ("x", "y"):
            low, high = self.command_ranges[key]
            limit_low, limit_high = limits[key]
            self.command_ranges[key] = [
                max(limit_low, low - increment),
                min(limit_high, high + increment),
            ]

    def _update_commands(self, done_ids: torch.Tensor) -> None:
        self.command_steps += 1
        if self.cfg.auto_reset:
            self.command_steps[done_ids] = 0
        interval = round(self.cfg.commands.resampling_time_s / self.step_dt)
        due = torch.nonzero(self.command_steps >= interval, as_tuple=False).squeeze(-1)
        self._resample_commands(due)

    def _apply_periodic_push(self) -> None:
        interval = round(5.0 / self.step_dt)
        if self.common_step_counter == 0 or self.common_step_counter % interval != 0:
            return
        root_velocity = self.joint_qd_0[:, :6]
        root_velocity[:, 0] = self._uniform(self.num_envs, -0.5, 0.5)
        root_velocity[:, 1] = self._uniform(self.num_envs, -0.5, 0.5)
        self.joint_qd_1[:, :6] = root_velocity
        self._sync_kinematics()

    @torch.no_grad()
    def step(
        self, actions: torch.Tensor
    ) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor, dict[str, Any]]:
        if actions.shape != (self.num_envs, self.num_actions):
            raise ValueError(
                f"expected actions {(self.num_envs, self.num_actions)}, "
                f"got {tuple(actions.shape)}"
            )
        actions = actions.to(device=self.device, dtype=torch.float32)
        if not torch.isfinite(actions).all():
            actions = torch.nan_to_num(actions, nan=0.0, posinf=10.0, neginf=-10.0)
        self.previous_actions.copy_(self.actions)
        self.actions.copy_(actions)
        targets = self.default_joint_position + self.cfg.action_scale * self.actions
        self.control_targets.copy_(self.default_control_targets)
        self.control_targets[:, self.target_indices] = targets

        torch.cuda.current_stream(self.device).synchronize()
        with wp.ScopedStream(self.stream):
            self._simulate()
            newton.eval_ik(
                self.model,
                self.state_0,
                self.state_0.joint_q,
                self.state_0.joint_qd,
            )
        wp.synchronize_stream(self.stream)
        self.sim_time += self.step_dt
        self.common_step_counter += 1
        self.episode_length_buf += 1

        state = self._current_state()
        finite = (
            torch.isfinite(self.joint_q_0).all(dim=-1)
            & torch.isfinite(self.joint_qd_0).all(dim=-1)
            & torch.isfinite(self.body_q_0).all(dim=(1, 2))
            & torch.isfinite(self.body_qd_0).all(dim=(1, 2))
        )
        tilt = torch.acos((-state["projected_gravity"][:, 2]).clamp(-1.0, 1.0))
        self.reset_buf = (state["root_position"][:, 2] < 0.2) | (tilt > 0.8) | ~finite
        self.timeout_buf = self.episode_length_buf >= self.max_episode_length
        done = self.reset_buf | self.timeout_buf
        estimated_torque = torch.clamp(
            self.kp * (targets - state["joint_position"])
            - self.kd * state["joint_velocity"],
            min=-self.effort_limit,
            max=self.effort_limit,
        )
        reward, reward_terms = compute_reward(
            RewardInputs(
                commands=self.commands,
                root_position=state["root_position"],
                root_quaternion=state["root_quaternion"],
                root_linear_velocity_world=state["root_velocity_world"][:, :3],
                root_linear_velocity_body=state["linear_velocity"],
                root_angular_velocity_body=state["angular_velocity"],
                projected_gravity=state["projected_gravity"],
                joint_position=state["joint_position"],
                default_joint_position=self.default_joint_position,
                joint_velocity=state["joint_velocity"],
                previous_joint_velocity=self.previous_joint_velocity,
                actions=self.actions,
                previous_actions=self.previous_actions,
                estimated_torque=estimated_torque,
                soft_joint_lower=self.soft_joint_lower,
                soft_joint_upper=self.soft_joint_upper,
                foot_position_world=state["foot_position"],
                foot_linear_velocity_world=state["foot_velocity"],
                foot_contact=self.contact_tracker.foot_contact,
                recent_foot_contact=self.contact_tracker.recent_foot_contact,
                recent_undesired_contact=(
                    self.contact_tracker.recent_undesired_contact
                ),
                episode_steps=self.episode_length_buf,
                terminated=self.reset_buf,
            ),
            self.cfg.rewards,
            self.step_dt,
            self.arm_indices,
            self.waist_indices,
            self.leg_deviation_indices,
        )
        reward = torch.nan_to_num(reward, nan=-10.0, posinf=10.0, neginf=-10.0)
        self.previous_joint_velocity.copy_(state["joint_velocity"])
        self.episode_return += reward
        self.episode_track_reward += reward_terms["track_lin_vel_xy"]

        self._update_curriculum(done)
        done_ids = torch.nonzero(done, as_tuple=False).squeeze(-1)
        extras: dict[str, Any] = {
            "time_outs": self.timeout_buf.clone(),
            "terminated": self.reset_buf.clone(),
            "observations": {},
            "reward_terms": {
                name: value.mean() for name, value in reward_terms.items()
            },
            "metrics": {
                "geometry_contact/left": (
                    self.contact_tracker.foot_contact[:, 0].float().mean()
                ),
                "geometry_contact/right": (
                    self.contact_tracker.foot_contact[:, 1].float().mean()
                ),
                "geometry_contact/undesired_bodies": (
                    self.contact_tracker.recent_undesired_contact.float()
                    .sum(dim=-1)
                    .mean()
                ),
                "contact_overflow": self.contact_tracker.overflow.float(),
                "joint_velocity_limit_fraction": (
                    (state["joint_velocity"].abs() > self.velocity_limit).float().mean()
                ),
            },
        }
        if done_ids.numel() > 0:
            extras["episode"] = {
                "return": self.episode_return[done_ids].mean(),
                "length": self.episode_length_buf[done_ids].float().mean(),
                "track_lin_vel_rate": (
                    self.episode_track_reward[done_ids].mean()
                    / self.cfg.simulation.episode_length_s
                ),
            }
        if self.cfg.auto_reset and done_ids.numel() > 0:
            self._reset_state(done_ids)
        self._update_commands(done_ids)
        self._apply_periodic_push()
        self._update_observations(done_ids if self.cfg.auto_reset else None)
        extras["observations"] = {"critic": self._critic_observation}
        self.extras = extras
        self.render()
        return self._actor_observation, reward, done, extras

    @torch.no_grad()
    def set_command(self, x: float, y: float, yaw: float) -> None:
        """Set a deterministic command for evaluation."""

        self.commands[:, 0] = x
        self.commands[:, 1] = y
        self.commands[:, 2] = yaw
        self.command_steps.zero_()

    def render(self) -> None:
        if self.viewer is None or not self.viewer.is_running():
            return
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.log_contacts(self.contacts, self.state_0)
        self.viewer.end_frame()

    def close(self) -> None:
        if self.viewer is not None:
            self.viewer.close()
