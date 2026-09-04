"""Batched SynReal flat-ground locomotion environment for Go2 and G1."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import torch

from .math_utils import projected_gravity, quat_rotate_inverse
from .observations import ObservationHistory, actor_frame
from .policy_spec import PolicySpec, load_policy_spec
from .randomization import EpisodeRandomization, uniform
from .rewards import locomotion_reward, terminated


RL_SAR_ZOO_COMMIT = "7dd30bdc7806898950b354260655d5a7f0ce844e"
RL_SAR_ZOO_URL = "https://github.com/fan-ziqi/rl_sar_zoo.git"


def _basename(label: str) -> str:
    return label.rsplit("/", 1)[-1]


def resolve_asset(spec: PolicySpec, override: Path | None = None) -> Path:
    if override is not None:
        path = override.expanduser().resolve()
    else:
        from newton._src.utils.download_assets import download_git_folder

        root = download_git_folder(
            RL_SAR_ZOO_URL,
            spec.asset_folder,
            ref=spec.asset_commit,
        )
        path = root / spec.asset_relative_path
    if not path.is_file():
        raise FileNotFoundError(path)
    return path


class SynRealLocomotionEnv:
    """CUDA VecEnv with a deployment-exact actor ABI.

    This environment deliberately keeps actor observations simulator-neutral.
    Contact-derived terms are used by rewards only. Domain randomization can be
    disabled for deterministic smoke validation.
    """

    def __init__(
        self,
        robot: str = "go2",
        *,
        num_envs: int = 2048,
        device: str = "cuda:0",
        asset: Path | None = None,
        seed: int = 42,
        randomize: bool = True,
        auto_reset: bool = True,
        viewer: Any | None = None,
        use_cuda_graph: bool = True,
    ) -> None:
        if num_envs <= 0:
            raise ValueError("num_envs must be positive")
        if not torch.cuda.is_available():
            raise RuntimeError("SynRealLocomotionEnv requires CUDA")

        import newton
        import warp as wp

        import synreal_solver

        self.newton = newton
        self.wp = wp
        self.synreal_solver = synreal_solver
        self.spec = load_policy_spec(robot)
        self.num_envs = num_envs
        self.num_actions = self.spec.action_dim
        self.num_obs = self.spec.observation_dim
        self.num_privileged_obs = self.num_obs
        self.max_episode_length = self.spec.max_episode_length
        self.auto_reset = auto_reset
        self.randomize = randomize
        self.viewer = viewer
        self.use_cuda_graph = use_cuda_graph
        self.sim_time = 0.0
        self.device = torch.device(device)
        torch.cuda.set_device(self.device)
        self.wp_device = wp.get_device(device)
        self.stream = wp.get_stream(self.wp_device)
        self.generator = torch.Generator(device=self.device).manual_seed(seed)
        self.asset_path = resolve_asset(self.spec, asset)

        builder, layout = self._build_model(num_envs)
        self.model = builder.finalize(device=self.wp_device)
        self.model.set_gravity((0.0, 0.0, -9.81))
        if self.viewer is not None:
            self.viewer.set_model(self.model)
            self.viewer.set_world_offsets((2.5, 2.5, 0.0))
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.model)
        self.solver = synreal_solver.NewtonSolver(self.model)
        self.solver.config.joint_constraint_mode = synreal_solver.JointConstraintMode.AUGMENTED_LAGRANGIAN
        self.solver.config.affine_body_rigidity_model = synreal_solver.AffineBodyRigidityModel.SIX_SPRINGS
        self.solver.config.inertia_mode = synreal_solver.InertiaMode.NONE
        self.solver.config.joint_constraint_alpha = 2e2
        self.solver.config.nonlinear_iterations = 30
        self.solver.config.linear_iterations = 10
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        newton.eval_fk(self.model, self.model.joint_q, self.model.joint_qd, self.state_0)
        self.state_1.assign(self.state_0)
        self.solver.sync_affine_body_state(self.state_0)
        self.solver.sync_affine_body_state(self.state_1)

        self.q_per_env = len(self.state_0.joint_q) // num_envs
        self.qd_per_env = len(self.state_0.joint_qd) // num_envs
        self.body_per_env = len(self.state_0.body_q) // num_envs
        self.target_per_env = len(self.control.joint_target_q) // num_envs
        expected = (
            (self.q_per_env, len(self.state_0.joint_q)),
            (self.qd_per_env, len(self.state_0.joint_qd)),
            (self.body_per_env, len(self.state_0.body_q)),
            (self.target_per_env, len(self.control.joint_target_q)),
        )
        if any(per_env * num_envs != total for per_env, total in expected):
            raise RuntimeError("replicated model arrays are not world-major")

        self.policy_q = torch.tensor(layout["q"], dtype=torch.long, device=self.device)
        self.policy_qd = torch.tensor(layout["qd"], dtype=torch.long, device=self.device)
        # Joint position targets are indexed by DoF, unlike joint_q which has
        # seven free-root coordinates.  For revolute joints target index == qd.
        self.policy_targets = torch.tensor(layout["qd"], dtype=torch.long, device=self.device)
        self.root_body = int(layout["root_body"])
        self.foot_bodies = torch.tensor(layout["foot_bodies"], dtype=torch.long, device=self.device)
        self._bind_views()

        self.initial_joint_q = self.joint_q_0.clone()
        self.initial_joint_qd = self.joint_qd_0.clone()
        self.initial_body_q = self.body_q_0.clone()
        self.initial_body_qd = self.body_qd_0.clone()
        self.default_joint_pos = self.spec.tensor("default_joint_pos", self.device)
        self.action_scale = self.spec.tensor("action_scale", self.device)
        self.base_stiffness = self.spec.tensor("stiffness", self.device)
        self.base_damping = self.spec.tensor("damping", self.device)
        self.base_effort = self.spec.tensor("torque_limits", self.device)
        self.default_targets = self.control_targets.clone()
        self.desired_targets = torch.zeros(
            (num_envs, self.num_actions), device=self.device
        )

        initial_feet = self.body_q_0[:, self.foot_bodies, 2]
        self.contact_height = initial_feet.min(dim=0).values + 0.015
        self.commands = torch.zeros((num_envs, 3), device=self.device)
        self.actions = torch.zeros((num_envs, self.num_actions), device=self.device)
        self.previous_actions = torch.zeros_like(self.actions)
        max_delay = self.spec.randomization.policy_delay_ticks[1]
        self.action_queue = torch.zeros(
            (num_envs, max_delay + 1, self.num_actions), device=self.device
        )
        self.history = ObservationHistory(num_envs, self.spec, self.device)
        self.episode_length_buf = torch.zeros(num_envs, dtype=torch.long, device=self.device)
        self.episode_return = torch.zeros(num_envs, device=self.device)
        self.reset_buf = torch.zeros(num_envs, dtype=torch.bool, device=self.device)
        self.timeout_buf = torch.zeros_like(self.reset_buf)
        self.random = EpisodeRandomization.create(
            self.spec, num_envs, self.device, self.generator, randomize
        )
        self._bind_capture_arrays()
        self.simulation_graph = None
        self.extras: dict[str, Any] = {}
        self.reset()
        if self.use_cuda_graph:
            self.capture_simulation_graph()

    def _build_model(self, num_envs: int) -> tuple[Any, dict[str, Any]]:
        newton = self.newton
        spec = self.spec
        robot = newton.ModelBuilder(up_axis=newton.Axis.Z)
        robot.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
            limit_ke=1.0e3,
            limit_kd=10.0,
            friction=1.0e-5,
        )
        robot.default_shape_cfg.ke = spec.contact_stiffness
        robot.default_shape_cfg.kd = spec.contact_damping
        robot.default_shape_cfg.kf = 1.0e3
        robot.default_shape_cfg.mu = spec.contact_friction
        robot.add_mjcf(
            str(self.asset_path),
            floating=True,
            collapse_fixed_joints=True,
            enable_self_collisions=False,
        )
        joint_by_name = {
            _basename(label): index for index, label in enumerate(robot.joint_label)
        }
        missing = sorted(set(spec.policy_joint_names) - set(joint_by_name))
        if missing:
            raise ValueError(f"asset is missing policy joints: {missing}")
        q_indices: list[int] = []
        qd_indices: list[int] = []
        for slot, name in enumerate(spec.policy_joint_names):
            joint = joint_by_name[name]
            q_index = int(robot.joint_q_start[joint])
            qd_index = int(robot.joint_qd_start[joint])
            q_indices.append(q_index)
            qd_indices.append(qd_index)
            robot.joint_q[q_index] = spec.default_joint_pos[slot]
            robot.joint_target_q[q_index] = spec.default_joint_pos[slot]
            robot.joint_target_ke[qd_index] = spec.stiffness[slot]
            robot.joint_target_kd[qd_index] = spec.damping[slot]
            robot.joint_effort_limit[qd_index] = spec.torque_limits[slot]
            robot.joint_target_mode[qd_index] = int(newton.JointTargetMode.POSITION)
        robot.joint_q[:3] = [0.0, 0.0, spec.initial_height]
        robot.joint_q[3:7] = [0.0, 0.0, 0.0, 1.0]

        body_labels = tuple(_basename(label) for label in robot.body_label)
        if spec.name == "go2":
            candidates = tuple(f"{leg}_calf" for leg in ("FR", "FL", "RR", "RL"))
        else:
            candidates = ("left_ankle_roll_link", "right_ankle_roll_link")
        foot_bodies = []
        for name in candidates:
            matches = [index for index, label in enumerate(body_labels) if label == name]
            if len(matches) != 1:
                raise ValueError(f"expected one foot body {name!r}, found {matches}")
            foot_bodies.append(matches[0])

        if num_envs == 1:
            builder = robot
        else:
            builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
            builder.default_shape_cfg.ke = spec.contact_stiffness
            builder.default_shape_cfg.kd = spec.contact_damping
            builder.default_shape_cfg.kf = 1.0e3
            builder.default_shape_cfg.mu = spec.contact_friction
            builder.replicate(robot, num_envs)
        builder.add_ground_plane()
        return builder, {
            "q": q_indices,
            "qd": qd_indices,
            "root_body": 0,
            "foot_bodies": foot_bodies,
        }

    def _bind_views(self) -> None:
        wp = self.wp

        def view(array: Any, rows: int) -> torch.Tensor:
            return wp.to_torch(array).view(self.num_envs, rows, -1).squeeze(-1)

        self.joint_q_0 = wp.to_torch(self.state_0.joint_q).view(self.num_envs, self.q_per_env)
        self.joint_q_1 = wp.to_torch(self.state_1.joint_q).view(self.num_envs, self.q_per_env)
        self.joint_qd_0 = wp.to_torch(self.state_0.joint_qd).view(self.num_envs, self.qd_per_env)
        self.joint_qd_1 = wp.to_torch(self.state_1.joint_qd).view(self.num_envs, self.qd_per_env)
        self.body_q_0 = view(self.state_0.body_q, self.body_per_env)
        self.body_q_1 = view(self.state_1.body_q, self.body_per_env)
        self.body_qd_0 = view(self.state_0.body_qd, self.body_per_env)
        self.body_qd_1 = view(self.state_1.body_qd, self.body_per_env)
        self.control_targets = wp.to_torch(self.control.joint_target_q).view(
            self.num_envs, self.target_per_env
        )
        self.model_stiffness = wp.to_torch(self.model.joint_target_ke).view(
            self.num_envs, self.qd_per_env
        )
        self.model_damping = wp.to_torch(self.model.joint_target_kd).view(
            self.num_envs, self.qd_per_env
        )
        self.model_effort = wp.to_torch(self.model.joint_effort_limit).view(
            self.num_envs, self.qd_per_env
        )

    def _bind_capture_arrays(self) -> None:
        wp = self.wp
        self._desired_targets_wp = wp.from_torch(self.desired_targets)
        self._base_stiffness_wp = wp.from_torch(self.base_stiffness)
        self._base_damping_wp = wp.from_torch(self.base_damping)
        self._base_effort_wp = wp.from_torch(self.base_effort)
        self._stiffness_scale_wp = wp.from_torch(self.random.stiffness_scale)
        self._damping_scale_wp = wp.from_torch(self.random.damping_scale)
        self._motor_strength_wp = wp.from_torch(self.random.motor_strength)
        self._policy_q_wp = wp.from_torch(self.policy_q)
        self._policy_qd_wp = wp.from_torch(self.policy_qd)
        self._policy_targets_wp = wp.from_torch(self.policy_targets)

    def _state(self) -> tuple[torch.Tensor, ...]:
        root_q = self.body_q_0[:, self.root_body]
        root_qd = self.body_qd_0[:, self.root_body]
        quaternion = torch.nn.functional.normalize(root_q[:, 3:7], dim=-1)
        linear_body = quat_rotate_inverse(quaternion, root_qd[:, :3])
        angular_body = quat_rotate_inverse(quaternion, root_qd[:, 3:])
        gravity_body = projected_gravity(quaternion)
        q = self.joint_q_0.index_select(1, self.policy_q)
        qd = self.joint_qd_0.index_select(1, self.policy_qd)
        return root_q, linear_body, angular_body, gravity_body, q, qd

    def _frame(self, corrupt: bool = True) -> torch.Tensor:
        _, _, angular, gravity, q, qd = self._state()
        noise = self.spec.randomization.observation_noise if corrupt and self.randomize else None
        return actor_frame(
            self.spec,
            angular,
            gravity,
            self.commands,
            q,
            qd,
            self.actions,
            self.default_joint_pos + self.random.joint_zero_offset,
            noise=noise,
            generator=self.generator,
        )

    def get_observations(self) -> tuple[torch.Tensor, dict[str, Any]]:
        observation = self.history.value()
        return observation, {"observations": {"critic": observation}}

    def get_privileged_observations(self) -> torch.Tensor:
        return self.history.value()

    def _sample_commands(self, env_ids: torch.Tensor) -> None:
        for index, key in enumerate(("lin_vel_x", "lin_vel_y", "ang_vel_z")):
            self.commands[env_ids, index] = uniform(
                (len(env_ids),), self.spec.command_ranges[key], self.device, self.generator
            )
        standing = torch.rand((len(env_ids),), device=self.device, generator=self.generator) < 0.1
        self.commands[env_ids[standing]] = 0.0

    @torch.no_grad()
    def reset(self, env_ids: torch.Tensor | None = None) -> torch.Tensor:
        if env_ids is None:
            env_ids = torch.arange(self.num_envs, device=self.device)
        env_ids = env_ids.to(device=self.device, dtype=torch.long)
        if not len(env_ids):
            return self.history.value()
        self.joint_q_0[env_ids] = self.initial_joint_q[env_ids]
        self.joint_q_1[env_ids] = self.initial_joint_q[env_ids]
        self.joint_qd_0[env_ids] = self.initial_joint_qd[env_ids]
        self.joint_qd_1[env_ids] = self.initial_joint_qd[env_ids]
        self.body_q_0[env_ids] = self.initial_body_q[env_ids]
        self.body_q_1[env_ids] = self.initial_body_q[env_ids]
        self.body_qd_0[env_ids] = self.initial_body_qd[env_ids]
        self.body_qd_1[env_ids] = self.initial_body_qd[env_ids]
        if self.randomize:
            root = self.joint_q_0[env_ids, :3]
            root[:, :2] += uniform((len(env_ids), 2), (-0.05, 0.05), self.device, self.generator)
            q = self.joint_q_0[env_ids].index_select(1, self.policy_q)
            q += uniform(q.shape, (-0.02, 0.02), self.device, self.generator)
            self.joint_q_0[env_ids[:, None], self.policy_q] = q
            self.joint_q_1[env_ids] = self.joint_q_0[env_ids]
        self.control_targets[env_ids] = self.default_targets[env_ids]
        self.desired_targets[env_ids] = self.default_joint_pos
        self.actions[env_ids] = 0.0
        self.previous_actions[env_ids] = 0.0
        self.action_queue[env_ids] = 0.0
        self.episode_length_buf[env_ids] = 0
        self.episode_return[env_ids] = 0.0
        self.reset_buf[env_ids] = False
        self.timeout_buf[env_ids] = False
        self._sample_commands(env_ids)
        self._apply_randomization(env_ids)

        torch.cuda.current_stream(self.device).synchronize()
        with self.wp.ScopedStream(self.stream):
            self.newton.eval_fk(
                self.model, self.state_0.joint_q, self.state_0.joint_qd, self.state_0
            )
            self.newton.eval_fk(
                self.model, self.state_1.joint_q, self.state_1.joint_qd, self.state_1
            )
            self.solver.sync_affine_body_state(self.state_0)
            self.solver.sync_affine_body_state(self.state_1)
        self.wp.synchronize_stream(self.stream)
        frame = self._frame(corrupt=False)
        self.history.reset(env_ids, frame)
        return self.history.value()

    def _apply_randomization(self, env_ids: torch.Tensor) -> None:
        if self.randomize:
            shape = (len(env_ids), self.num_actions)
            self.random.stiffness_scale[env_ids] = uniform(
                shape, self.spec.randomization.stiffness_scale, self.device, self.generator
            )
            self.random.damping_scale[env_ids] = uniform(
                shape, self.spec.randomization.damping_scale, self.device, self.generator
            )
            self.random.motor_strength[env_ids] = uniform(
                shape, self.spec.randomization.motor_strength, self.device, self.generator
            )
            self.random.joint_zero_offset[env_ids] = uniform(
                shape, self.spec.randomization.joint_zero_offset, self.device, self.generator
            )
            self.random.delay_ticks[env_ids] = torch.randint(
                self.spec.randomization.policy_delay_ticks[0],
                self.spec.randomization.policy_delay_ticks[1] + 1,
                (len(env_ids),), device=self.device, generator=self.generator,
            )
            # Newton exposes body_mass on some versions, but changing mass after
            # solver construction can leave cached affine inertia inconsistent.
            # Keep it fixed until the adapter provides an explicit mass/inertia
            # refresh API; the requested ranges remain in PolicySpec for that gate.
        self.model_stiffness[env_ids[:, None], self.policy_qd] = (
            self.base_stiffness * self.random.stiffness_scale[env_ids]
        )
        self.model_damping[env_ids[:, None], self.policy_qd] = (
            self.base_damping * self.random.damping_scale[env_ids]
        )
        self.model_effort[env_ids[:, None], self.policy_qd] = (
            self.base_effort * self.random.motor_strength[env_ids]
        )
        self.random.resample_push(self.spec, env_ids, self.generator)

    def _delayed_action(self, actions: torch.Tensor) -> torch.Tensor:
        self.action_queue[:, 1:] = self.action_queue[:, :-1].clone()
        self.action_queue[:, 0] = actions
        rows = torch.arange(self.num_envs, device=self.device)
        return self.action_queue[rows, self.random.delay_ticks]

    def _push_due_envs(self) -> None:
        if not self.randomize:
            return
        due = self.episode_length_buf >= self.random.next_push_step
        if not torch.any(due):
            return
        env_ids = torch.nonzero(due, as_tuple=False).squeeze(-1)
        velocity = uniform(
            (len(env_ids), 2), self.spec.randomization.push_velocity, self.device, self.generator
        )
        self.body_qd_0[env_ids, self.root_body, :2] += velocity
        self.random.resample_push(self.spec, env_ids, self.generator)
        self.random.next_push_step[env_ids] += self.episode_length_buf[env_ids]

    def _launch_limited_joint_targets(self) -> None:
        from .simulation_kernels import update_limited_joint_targets

        self.wp.launch(
            update_limited_joint_targets,
            dim=self.num_envs * self.num_actions,
            inputs=[
                self.state_0.joint_q,
                self.state_0.joint_qd,
                self._desired_targets_wp,
                self._base_stiffness_wp,
                self._base_damping_wp,
                self._base_effort_wp,
                self._stiffness_scale_wp,
                self._damping_scale_wp,
                self._motor_strength_wp,
                self._policy_q_wp,
                self._policy_qd_wp,
                self._policy_targets_wp,
                self.num_actions,
                self.q_per_env,
                self.qd_per_env,
                self.target_per_env,
            ],
            outputs=[self.control.joint_target_q],
            device=self.wp_device,
            stream=self.stream,
        )

    def _simulate_uncaptured(self, *, keep_state_buffers: bool = False) -> None:
        for substep in range(self.spec.decimation):
            # The current SynReal/Newton adapter does not consume Newton's
            # joint_effort_limit. Convert the desired position target into an
            # equivalent target whose ideal-PD torque is explicitly clipped.
            self._launch_limited_joint_targets()
            self.newton.eval_ik(
                self.model, self.state_0, self.state_0.joint_q, self.state_0.joint_qd
            )
            self.collision_pipeline.collide(self.state_0, self.contacts)
            self.state_0.clear_forces()
            self.solver.step(
                self.state_0,
                self.state_1,
                self.control,
                self.contacts,
                self.spec.dt,
            )
            is_last_odd_substep = (
                keep_state_buffers
                and self.spec.decimation % 2 == 1
                and substep == self.spec.decimation - 1
            )
            if is_last_odd_substep:
                self.state_0.assign(self.state_1)
            else:
                self.state_0, self.state_1 = self.state_1, self.state_0
        self._bind_views()

    def capture_simulation_graph(self) -> None:
        """Capture one policy interval after solver configuration changes."""
        self.wp.synchronize_stream(self.stream)
        self.simulation_graph = None
        torch.cuda.current_stream(self.device).synchronize()
        with self.wp.ScopedStream(self.stream):
            with self.wp.ScopedCapture(stream=self.stream) as capture:
                self._simulate_uncaptured(keep_state_buffers=True)
        self.simulation_graph = capture.graph

    def _simulate(self) -> None:
        if self.simulation_graph is None:
            self._simulate_uncaptured()
        else:
            self.wp.capture_launch(self.simulation_graph, stream=self.stream)

    @torch.no_grad()
    def step(
        self, actions: torch.Tensor
    ) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor, dict[str, Any]]:
        if actions.shape != (self.num_envs, self.num_actions):
            raise ValueError(f"expected actions {(self.num_envs, self.num_actions)}, got {actions.shape}")
        actions = actions.to(self.device).clamp(-100.0, 100.0)
        delayed = self._delayed_action(actions)
        self.previous_actions.copy_(self.actions)
        self.actions.copy_(actions)
        target = (
            self.default_joint_pos
            + self.random.joint_zero_offset
            + self.action_scale * delayed
        )
        self.desired_targets.copy_(target)
        self._push_due_envs()
        torch.cuda.current_stream(self.device).synchronize()
        with self.wp.ScopedStream(self.stream):
            self._simulate()
            self.newton.eval_ik(
                self.model, self.state_0, self.state_0.joint_q, self.state_0.joint_qd
            )
        self.wp.synchronize_stream(self.stream)
        self.sim_time += self.spec.policy_dt
        self.render()
        self.episode_length_buf += 1

        root, linear, angular, gravity, q, qd = self._state()
        foot_q = self.body_q_0.index_select(1, self.foot_bodies)
        foot_qd = self.body_qd_0.index_select(1, self.foot_bodies)
        foot_height = foot_q[:, :, 2] - self.contact_height
        contact = foot_q[:, :, 2] <= self.contact_height
        reward, terms = locomotion_reward(
            robot=self.spec.name,
            commands=self.commands,
            linear_velocity_body=linear,
            angular_velocity_body=angular,
            gravity_body=gravity,
            joint_position_error=q - self.default_joint_pos,
            joint_velocity=qd,
            actions=self.actions,
            previous_actions=self.previous_actions,
            foot_height=foot_height,
            foot_speed_xy=foot_qd[:, :, :2],
            contact=contact,
        )
        finite = (
            torch.isfinite(root).all(-1)
            & torch.isfinite(q).all(-1)
            & torch.isfinite(qd).all(-1)
        )
        self.reset_buf = terminated(root[:, 2], gravity, self.spec.fall_height, finite)
        self.timeout_buf = self.episode_length_buf >= self.max_episode_length
        done = self.reset_buf | self.timeout_buf
        # A diverging world can remain finite for one step while producing an
        # enormous penalty. Do not let that terminal sample poison PPO returns.
        reward = torch.nan_to_num(reward, nan=-100.0, posinf=100.0, neginf=-100.0)
        reward = reward.clamp(-100.0, 100.0)
        reward = torch.where(self.reset_buf, -100.0, reward)
        self.episode_return += reward
        self.extras = {
            "time_outs": self.timeout_buf.clone(),
            "observations": {"critic": self.history.value()},
            "reward_terms": {name: value.mean() for name, value in terms.items()},
        }
        if torch.any(done):
            self.extras["episode"] = {
                "return": self.episode_return[done].mean(),
                "length": self.episode_length_buf[done].float().mean(),
            }
        frame = self._frame(corrupt=True)
        observation = self.history.append(frame)
        if self.auto_reset and torch.any(done):
            env_ids = torch.nonzero(done, as_tuple=False).squeeze(-1)
            self.reset(env_ids)
            observation = self.history.value()
        return observation, reward, done, self.extras

    def render(self) -> None:
        if self.viewer is None or not self.viewer.is_running():
            return
        self.viewer.begin_frame(self.sim_time)
        self.viewer.log_state(self.state_0)
        self.viewer.end_frame()

    def close(self) -> None:
        if self.viewer is not None:
            self.viewer.close()
