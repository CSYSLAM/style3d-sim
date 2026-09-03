"""Single-source policy ABI shared by training, sim2sim, and deployment."""

from __future__ import annotations

import hashlib
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import torch
import yaml


CONFIG_DIR = Path(__file__).resolve().parent / "configs"
OBSERVATION_TERMS = (
    "base_ang_vel",
    "projected_gravity",
    "velocity_commands",
    "joint_pos_rel",
    "joint_vel_rel",
    "last_action",
)


def _tuple(values: Any, cast: type = float) -> tuple:
    return tuple(cast(value) for value in values)


@dataclass(frozen=True)
class RandomizationSpec:
    static_friction: tuple[float, float]
    dynamic_friction: tuple[float, float]
    restitution: tuple[float, float]
    base_mass_add: tuple[float, float]
    link_mass_scale: tuple[float, float]
    base_com: tuple[float, float]
    stiffness_scale: tuple[float, float]
    damping_scale: tuple[float, float]
    motor_strength: tuple[float, float]
    joint_zero_offset: tuple[float, float]
    observation_noise: dict[str, float]
    policy_delay_ticks: tuple[int, int]
    push_interval_s: tuple[float, float]
    push_velocity: tuple[float, float]


@dataclass(frozen=True)
class PolicySpec:
    """Validated locomotion contract in policy joint order."""

    name: str
    asset_folder: str
    asset_relative_path: str
    asset_commit: str
    sdk_joint_names: tuple[str, ...]
    joint_ids_map: tuple[int, ...]
    default_joint_pos: tuple[float, ...]
    stiffness: tuple[float, ...]
    damping: tuple[float, ...]
    torque_limits: tuple[float, ...]
    velocity_limits: tuple[float, ...]
    action_scale: tuple[float, ...]
    command_ranges: dict[str, tuple[float, float]]
    ang_vel_scale: float
    joint_vel_scale: float
    history_length: int
    dt: float
    decimation: int
    episode_length_s: float
    initial_height: float
    fall_height: float
    contact_stiffness: float
    contact_damping: float
    contact_friction: float
    solver_iterations: int
    use_gym_history: bool
    randomization: RandomizationSpec
    ppo: dict[str, Any]

    @property
    def action_dim(self) -> int:
        return len(self.default_joint_pos)

    @property
    def frame_observation_dim(self) -> int:
        return 9 + 3 * self.action_dim

    @property
    def observation_dim(self) -> int:
        return self.frame_observation_dim * self.history_length

    @property
    def policy_dt(self) -> float:
        return self.dt * self.decimation

    @property
    def max_episode_length(self) -> int:
        return round(self.episode_length_s / self.policy_dt)

    @property
    def policy_joint_names(self) -> tuple[str, ...]:
        return tuple(self.sdk_joint_names[index] for index in self.joint_ids_map)

    @property
    def abi_sha256(self) -> str:
        return hashlib.sha256(self.abi_bytes()).hexdigest()

    def abi_bytes(self) -> bytes:
        return yaml.safe_dump(self.as_dict(), sort_keys=True).encode()

    def as_dict(self) -> dict[str, Any]:
        return {
            "name": self.name,
            "sdk_joint_names": list(self.sdk_joint_names),
            "joint_ids_map": list(self.joint_ids_map),
            "policy_joint_names": list(self.policy_joint_names),
            "default_joint_pos": list(self.default_joint_pos),
            "stiffness": list(self.stiffness),
            "damping": list(self.damping),
            "torque_limits": list(self.torque_limits),
            "velocity_limits": list(self.velocity_limits),
            "action_scale": list(self.action_scale),
            "command_ranges": self.command_ranges,
            "ang_vel_scale": self.ang_vel_scale,
            "joint_vel_scale": self.joint_vel_scale,
            "history_length": self.history_length,
            "use_gym_history": self.use_gym_history,
            "dt": self.dt,
            "decimation": self.decimation,
            "episode_length_s": self.episode_length_s,
            "observation_terms": list(OBSERVATION_TERMS),
        }

    def tensor(self, name: str, device: torch.device | str) -> torch.Tensor:
        return torch.tensor(getattr(self, name), device=device, dtype=torch.float32)


def _pair(data: dict[str, Any], key: str, cast: type = float) -> tuple:
    values = data[key]
    if len(values) != 2 or values[0] > values[1]:
        raise ValueError(f"{key} must be an ordered two-element range")
    return _tuple(values, cast)


def _validate(spec: PolicySpec) -> None:
    size = spec.action_dim
    vector_fields = (
        "joint_ids_map",
        "stiffness",
        "damping",
        "torque_limits",
        "velocity_limits",
        "action_scale",
    )
    for field in vector_fields:
        if len(getattr(spec, field)) != size:
            raise ValueError(f"{spec.name}.{field} must contain {size} values")
    if len(spec.sdk_joint_names) != size:
        raise ValueError(f"{spec.name}.sdk_joint_names must contain {size} values")
    if sorted(spec.joint_ids_map) != list(range(size)):
        raise ValueError(f"{spec.name}.joint_ids_map must be a permutation")
    if len(set(spec.sdk_joint_names)) != size:
        raise ValueError(f"{spec.name} contains duplicate SDK joint names")
    if spec.dt <= 0 or spec.decimation <= 0 or spec.history_length <= 0:
        raise ValueError("dt, decimation, and history_length must be positive")
    if abs(spec.policy_dt - 0.02) > 1.0e-9:
        raise ValueError(f"{spec.name} deployment ABI must run at 50 Hz")
    if set(spec.command_ranges) != {"lin_vel_x", "lin_vel_y", "ang_vel_z"}:
        raise ValueError("command_ranges must define vx, vy, and yaw")
    for field in ("stiffness", "damping", "torque_limits", "velocity_limits", "action_scale"):
        if any(value <= 0 for value in getattr(spec, field)):
            raise ValueError(f"{spec.name}.{field} values must be positive")


def load_policy_spec(robot: str | Path) -> PolicySpec:
    """Load ``go2``/``g1`` or an explicit YAML policy contract."""

    path = Path(robot)
    if not path.suffix:
        path = CONFIG_DIR / f"{path.name}.yaml"
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    randomization = data["randomization"]
    spec = PolicySpec(
        name=str(data["name"]),
        asset_folder=str(data["asset"]["folder"]),
        asset_relative_path=str(data["asset"]["relative_path"]),
        asset_commit=str(data["asset"]["commit"]),
        sdk_joint_names=_tuple(data["sdk_joint_names"], str),
        joint_ids_map=_tuple(data["joint_ids_map"], int),
        default_joint_pos=_tuple(data["default_joint_pos"]),
        stiffness=_tuple(data["stiffness"]),
        damping=_tuple(data["damping"]),
        torque_limits=_tuple(data["torque_limits"]),
        velocity_limits=_tuple(data["velocity_limits"]),
        action_scale=_tuple(data["action_scale"]),
        command_ranges={key: _tuple(value) for key, value in data["command_ranges"].items()},
        ang_vel_scale=float(data["observations"]["ang_vel_scale"]),
        joint_vel_scale=float(data["observations"]["joint_vel_scale"]),
        history_length=int(data["observations"]["history_length"]),
        dt=float(data["simulation"]["dt"]),
        decimation=int(data["simulation"]["decimation"]),
        episode_length_s=float(data["simulation"]["episode_length_s"]),
        initial_height=float(data["simulation"]["initial_height"]),
        fall_height=float(data["simulation"]["fall_height"]),
        contact_stiffness=float(data["simulation"]["contact_stiffness"]),
        contact_damping=float(data["simulation"]["contact_damping"]),
        contact_friction=float(data["simulation"]["contact_friction"]),
        solver_iterations=int(data["simulation"]["solver_iterations"]),
        use_gym_history=bool(data["observations"].get("use_gym_history", False)),
        randomization=RandomizationSpec(
            static_friction=_pair(randomization, "static_friction"),
            dynamic_friction=_pair(randomization, "dynamic_friction"),
            restitution=_pair(randomization, "restitution"),
            base_mass_add=_pair(randomization, "base_mass_add"),
            link_mass_scale=_pair(randomization, "link_mass_scale"),
            base_com=_pair(randomization, "base_com"),
            stiffness_scale=_pair(randomization, "stiffness_scale"),
            damping_scale=_pair(randomization, "damping_scale"),
            motor_strength=_pair(randomization, "motor_strength"),
            joint_zero_offset=_pair(randomization, "joint_zero_offset"),
            observation_noise={key: float(value) for key, value in randomization["observation_noise"].items()},
            policy_delay_ticks=_pair(randomization, "policy_delay_ticks", int),
            push_interval_s=_pair(randomization, "push_interval_s"),
            push_velocity=_pair(randomization, "push_velocity"),
        ),
        ppo=dict(data["ppo"]),
    )
    _validate(spec)
    return spec
