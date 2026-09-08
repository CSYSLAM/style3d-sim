"""CPU tests for the Go2/G1 training and deployment ABI."""

from __future__ import annotations

import sys
from pathlib import Path
from types import SimpleNamespace

import torch

_EXAMPLES = Path(__file__).parents[1] / "examples"
sys.path.insert(0, str(_EXAMPLES))

from locomotion.deployment import build_actor, deploy_config, export_actor_onnx  # noqa: E402
from locomotion.env import TERMINATION_REWARD  # noqa: E402
from locomotion.observations import ObservationHistory, actor_frame  # noqa: E402
from locomotion.policy_spec import load_policy_spec  # noqa: E402
from locomotion.rewards import locomotion_reward  # noqa: E402
from locomotion.train import (  # noqa: E402
    apply_runner_overrides,
    parse_reset_joint_curriculum,
    rsl_rl_config,
)


def test_policy_contract_dimensions_and_rate() -> None:
    expected = {"go2": (45, 12, 1), "g1": (480, 29, 5)}
    for robot, (observations, actions, history) in expected.items():
        spec = load_policy_spec(robot)
        assert spec.observation_dim == observations
        assert spec.action_dim == actions
        assert spec.history_length == history
        assert spec.policy_dt == 0.02
        assert sorted(spec.joint_ids_map) == list(range(actions))


def test_go2_fanziqi_contract() -> None:
    spec = load_policy_spec("go2")
    assert spec.policy_joint_names[:6] == (
        "FR_hip_joint", "FR_thigh_joint", "FR_calf_joint",
        "FL_hip_joint", "FL_thigh_joint", "FL_calf_joint",
    )
    assert spec.action_scale == (0.25, 0.25, 0.25) * 4
    assert spec.ang_vel_scale == 0.25
    assert spec.joint_vel_scale == 0.05


def test_go2_matches_locomotion2_training_baseline() -> None:
    spec = load_policy_spec("go2")
    assert spec.asset_source == "newton"
    assert spec.asset_name == "unitree_go2"
    assert spec.asset_relative_path == "usd/go2.usda"
    assert spec.default_joint_pos == (
        0.0, 0.8, -1.5, 0.0, 0.8, -1.5,
        0.0, 1.0, -1.5, 0.0, 1.0, -1.5,
    )
    assert spec.stiffness == (80.0,) * 12
    assert spec.damping == (2.0,) * 12
    assert spec.command_ranges == {
        "lin_vel_x": (0.5, 0.5),
        "lin_vel_y": (0.0, 0.0),
        "ang_vel_z": (0.0, 0.0),
    }
    assert spec.standing_probability == 0.0
    assert spec.action_clip == 1.0
    assert spec.joint_target_limits is not None
    assert spec.termination_roll_degrees == 35.0
    assert spec.termination_pitch_degrees == 35.0
    assert spec.fall_height == 0.12
    assert spec.fall_grace_s == 0.6
    assert spec.fall_confirm_s == 0.12
    assert spec.base_height_target == 0.28
    assert spec.base_height_sigma == 0.05
    assert spec.contact_stiffness == 15000.0
    assert spec.contact_damping == 250.0
    assert spec.solver_iterations == 30
    assert spec.linear_iterations == 10
    assert spec.randomization.policy_delay_ticks == (1, 1)
    assert spec.randomization.push_velocity == (0.0, 0.0)
    assert spec.randomization.reset_joint_position == (0.0, 0.0)
    assert TERMINATION_REWARD == -100.0
    assert spec.ppo["init_noise_std"] == 0.03
    assert spec.ppo["learning_rate"] == 3.0e-4
    assert spec.ppo["num_learning_epochs"] == 5
    assert spec.ppo["clip_param"] == 0.2


def test_reset_joint_curriculum_parser() -> None:
    assert parse_reset_joint_curriculum(
        ["0:0.0", "2000:0.01", "3000:0.015", "4000:0.02"]
    ) == ((0, 0.0), (2000, 0.01), (3000, 0.015), (4000, 0.02))


def test_g1_unitree_sdk_mapping() -> None:
    spec = load_policy_spec("g1")
    assert spec.joint_ids_map == (
        0, 6, 12, 1, 7, 13, 2, 8, 14, 3, 9, 15, 22, 4, 10,
        16, 23, 5, 11, 17, 24, 18, 25, 19, 26, 20, 27, 21, 28,
    )


def test_observation_history_matches_term_major_deployment_layout() -> None:
    spec = load_policy_spec("g1")
    history = ObservationHistory(1, spec, torch.device("cpu"))
    frame0 = torch.arange(spec.frame_observation_dim, dtype=torch.float32).unsqueeze(0)
    history.reset(torch.tensor([0]), frame0)
    for offset in range(1, spec.history_length):
        history.append(frame0 + 100.0 * offset)
    value = history.value()[0]
    # base_ang_vel has width 3 and is the first term: its five frames precede gravity.
    assert torch.equal(
        value[:15],
        torch.tensor(
            [0, 1, 2, 100, 101, 102, 200, 201, 202, 300, 301, 302, 400, 401, 402],
            dtype=torch.float32,
        ),
    )
    # Projected gravity immediately follows base_ang_vel history.
    assert torch.equal(value[15:18], torch.tensor([3, 4, 5], dtype=torch.float32))


def test_observation_and_actor_shapes() -> None:
    for robot in ("go2", "g1"):
        spec = load_policy_spec(robot)
        batch = 2
        zero3 = torch.zeros(batch, 3)
        default = torch.tensor(spec.default_joint_pos)
        q = default.expand(batch, -1)
        zeros = torch.zeros(batch, spec.action_dim)
        frame = actor_frame(spec, zero3, zero3, zero3, q, zeros, zeros, default)
        history = ObservationHistory(batch, spec, torch.device("cpu"))
        history.reset(torch.arange(batch), frame)
        observation = history.value()
        output = build_actor(spec)(observation)
        assert output.shape == (batch, spec.action_dim)
        if robot == "go2":
            assert output.abs().max() <= 1.0


def test_deploy_yaml_is_dimensionally_identical_to_training() -> None:
    for robot in ("go2", "g1"):
        spec = load_policy_spec(robot)
        cfg = deploy_config(spec)
        dimension = sum(
            len(term["scale"]) * term["history_length"]
            for name, term in cfg["observations"].items() if name != "use_gym_history"
        )
        assert dimension == spec.observation_dim
        assert cfg["actions"]["JointPositionAction"]["scale"] == list(spec.action_scale)
        assert cfg["joint_ids_map"] == list(spec.joint_ids_map)


def test_rsl_rl_configuration_matches_upstream_baseline() -> None:
    for robot in ("go2", "g1"):
        cfg = rsl_rl_config(robot)
        assert cfg["num_steps_per_env"] == 24
        assert cfg["policy"]["actor_hidden_dims"] == [512, 256, 128]
        assert cfg["policy"]["noise_std_type"] == "log"
        assert cfg["algorithm"]["gamma"] == 0.99
        assert cfg["algorithm"]["lam"] == 0.95
    go2 = rsl_rl_config("go2")
    assert go2["policy"]["class_name"] == "BoundedActorCritic"
    assert go2["algorithm"]["clip_param"] == 0.2
    assert go2["algorithm"]["schedule"] == "adaptive"
    assert go2["algorithm"]["desired_kl"] == 0.01
    g1 = rsl_rl_config("g1")
    assert g1["policy"]["class_name"] == "ActorCritic"
    assert g1["algorithm"]["clip_param"] == 0.2
    assert g1["algorithm"]["schedule"] == "adaptive"
    assert g1["algorithm"]["desired_kl"] == 0.01
    assert rsl_rl_config("g1")["policy"]["init_noise_std"] == 0.2


def test_resume_overrides_update_policy_and_optimizer() -> None:
    policy = SimpleNamespace(
        noise_std_type="log",
        log_std=torch.nn.Parameter(torch.zeros(12)),
    )
    optimizer = torch.optim.Adam([policy.log_std], lr=1.0e-5)
    algorithm = SimpleNamespace(
        policy=policy,
        optimizer=optimizer,
        learning_rate=1.0e-5,
    )
    runner = SimpleNamespace(alg=algorithm)

    apply_runner_overrides(runner, noise_std=0.02, learning_rate=2.0e-5)

    assert torch.allclose(policy.log_std.exp(), torch.full((12,), 0.02))
    assert algorithm.learning_rate == 2.0e-5
    assert optimizer.param_groups[0]["lr"] == 2.0e-5


def test_locomotion_reward_is_scalar_per_environment() -> None:
    for robot in ("go2", "g1"):
        batch = 3
        joint_count = 12 if robot == "go2" else 29
        reward, terms = locomotion_reward(
            robot=robot,
            commands=torch.zeros(batch, 3),
            linear_velocity_body=torch.zeros(batch, 3),
            angular_velocity_body=torch.zeros(batch, 3),
            gravity_body=torch.tensor([[0.0, 0.0, -1.0]]).expand(batch, -1),
            joint_position_error=torch.zeros(batch, joint_count),
            joint_velocity=torch.zeros(batch, joint_count),
            actions=torch.zeros(batch, joint_count),
            previous_actions=torch.zeros(batch, joint_count),
            root_height=torch.full((batch,), 0.28),
            base_height_target=0.28,
            base_height_sigma=0.05,
            base_height_reward_scale=1.0,
        )
        assert reward.shape == (batch,)
        assert "foot_slide" not in terms


def test_go2_tracking_reward_is_additive_and_discourages_low_posture() -> None:
    def reward(
        *,
        root_height: float,
        gravity_z: float,
        velocity_x: float = 0.5,
        action: float = 0.0,
    ):
        batch = 2
        values, _ = locomotion_reward(
            robot="go2",
            commands=torch.tensor([[0.5, 0.0, 0.0]]).repeat(batch, 1),
            linear_velocity_body=torch.tensor([[velocity_x, 0.0, 0.0]]).repeat(batch, 1),
            angular_velocity_body=torch.zeros(batch, 3),
            gravity_body=torch.tensor([[0.0, 0.0, gravity_z]]).repeat(batch, 1),
            joint_position_error=torch.zeros(batch, 12),
            joint_velocity=torch.zeros(batch, 12),
            actions=torch.full((batch, 12), action),
            previous_actions=torch.full((batch, 12), action),
            root_height=torch.full((batch,), root_height),
            base_height_target=0.28,
            base_height_sigma=0.05,
            base_height_reward_scale=1.0,
        )
        return values

    healthy = reward(root_height=0.28, gravity_z=-1.0)
    crouched = reward(root_height=0.12, gravity_z=-1.0)
    tilted = reward(root_height=0.28, gravity_z=0.0)
    standing = reward(root_height=0.28, gravity_z=-1.0, velocity_x=0.0)
    active = reward(root_height=0.28, gravity_z=-1.0, action=1.0)

    assert torch.all(healthy > standing)
    assert torch.all(healthy > crouched)
    assert torch.all(healthy > tilted)
    assert torch.allclose(active, healthy)


def test_onnx_export_embeds_weights(monkeypatch, tmp_path: Path) -> None:
    spec = load_policy_spec("go2")
    options = {}

    def fake_export(*args, **kwargs):
        options.update(kwargs)

    monkeypatch.setattr(torch.onnx, "export", fake_export)
    export_actor_onnx(build_actor(spec), spec, tmp_path / "policy.onnx")
    assert options["opset_version"] == 17
    assert options["external_data"] is False
