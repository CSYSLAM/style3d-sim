"""CPU tests for the Go2/G1 training and deployment ABI."""

from __future__ import annotations

import sys
from pathlib import Path

import torch

_EXAMPLES = Path(__file__).parents[1] / "examples"
sys.path.insert(0, str(_EXAMPLES))

from locomotion.deployment import build_actor, deploy_config, export_actor_onnx  # noqa: E402
from locomotion.observations import ObservationHistory, actor_frame  # noqa: E402
from locomotion.policy_spec import load_policy_spec  # noqa: E402
from locomotion.rewards import locomotion_reward  # noqa: E402
from locomotion.train import rsl_rl_config  # noqa: E402


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
    assert spec.action_scale == (0.125, 0.25, 0.25) * 4
    assert spec.ang_vel_scale == 0.25
    assert spec.joint_vel_scale == 0.05


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
        assert build_actor(spec)(observation).shape == (batch, spec.action_dim)


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
        assert cfg["algorithm"]["clip_param"] == 0.2
        assert cfg["algorithm"]["gamma"] == 0.99
        assert cfg["algorithm"]["lam"] == 0.95
        assert cfg["algorithm"]["desired_kl"] == 0.01
    assert rsl_rl_config("g1")["policy"]["init_noise_std"] == 0.2


def test_foot_slide_reward_is_scalar_per_environment() -> None:
    for robot, foot_count in (("go2", 4), ("g1", 2)):
        batch = 3
        joint_count = 12 if robot == "go2" else 29
        foot_speed_xy = torch.ones(batch, foot_count, 2)
        contact = torch.zeros(batch, foot_count, dtype=torch.bool)
        contact[:, 0] = True
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
            foot_height=torch.full((batch, foot_count), 0.035),
            foot_speed_xy=foot_speed_xy,
            contact=contact,
        )
        assert reward.shape == (batch,)
        assert terms["foot_slide"].shape == (batch,)
        assert torch.equal(terms["foot_slide"], torch.full((batch,), 2.0))


def test_onnx_export_embeds_weights(monkeypatch, tmp_path: Path) -> None:
    spec = load_policy_spec("go2")
    options = {}

    def fake_export(*args, **kwargs):
        options.update(kwargs)

    monkeypatch.setattr(torch.onnx, "export", fake_export)
    export_actor_onnx(build_actor(spec), spec, tmp_path / "policy.onnx")
    assert options["opset_version"] == 17
    assert options["external_data"] is False
