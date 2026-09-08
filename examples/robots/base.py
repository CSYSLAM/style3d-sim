"""Simulator-independent robot model specifications for Newton examples."""

from __future__ import annotations

import math
from numbers import Real
from pathlib import Path
from typing import Any, Literal
from dataclasses import dataclass
from collections.abc import Mapping, Sequence

import newton


Importer = Literal["mjcf", "urdf", "usd"]
JointValues = Real | Sequence[float] | Mapping[str, float]


def basename(label: str) -> str:
    """Return the final component of a Newton joint or body label."""

    return str(label).rsplit("/", 1)[-1]


@dataclass(frozen=True)
class AssetSpec:
    """Lazy description of an asset from Newton assets or a pinned git folder."""

    relative_path: str
    importer: Importer
    newton_package: str | None = None
    git_url: str | None = None
    git_folder: str | None = None
    git_ref: str | None = None

    def __post_init__(self) -> None:
        uses_newton = self.newton_package is not None
        uses_git = (
            self.git_url is not None
            or self.git_folder is not None
            or self.git_ref is not None
        )
        if uses_newton == uses_git:
            raise ValueError(
                "asset must define exactly one of newton_package or git source"
            )
        if uses_git and not all((self.git_url, self.git_folder, self.git_ref)):
            raise ValueError("git assets require git_url, git_folder, and git_ref")

    def resolve(self, override: str | Path | None = None) -> Path:
        if override is not None:
            path = Path(override).expanduser().resolve()
        elif self.newton_package is not None:
            path = (
                Path(newton.utils.download_asset(self.newton_package))
                / self.relative_path
            )
        else:
            from newton._src.utils.download_assets import download_git_folder

            root = download_git_folder(self.git_url, self.git_folder, ref=self.git_ref)
            path = Path(root) / self.relative_path
        if not path.is_file():
            raise FileNotFoundError(path)
        return path

    def importer_for(self, path: Path) -> Importer:
        suffix = path.suffix.lower()
        if suffix == ".xml":
            return "mjcf"
        if suffix == ".urdf":
            return "urdf"
        if suffix in {".usd", ".usda", ".usdc"}:
            return "usd"
        if path == Path(self.relative_path):
            return self.importer
        raise ValueError(f"unsupported robot asset format: {path}")


@dataclass(frozen=True)
class ContactDefaults:
    stiffness: float
    damping: float
    friction: float = 0.75
    friction_stiffness: float = 1.0e3


@dataclass(frozen=True)
class ImportOptions:
    collapse_fixed_joints: bool = True
    enable_self_collisions: bool = False
    hide_collision_shapes: bool = True
    skip_mesh_approximation: bool = False
    mesh_approximation: str | None = None
    ignore_paths: tuple[str, ...] = ()
    preserve_inertias: bool = False


@dataclass(frozen=True)
class RobotLayout:
    """Indices for one unreplicated robot, all in ``joint_names`` order."""

    name: str
    joint_names: tuple[str, ...]
    joint_indices: tuple[int, ...]
    joint_q_indices: tuple[int, ...]
    joint_qd_indices: tuple[int, ...]
    joint_target_indices: tuple[int, ...]
    root_body_index: int
    root_joint_index: int
    foot_names: tuple[str, ...]
    foot_body_indices: tuple[int, ...]

    @property
    def action_dim(self) -> int:
        return len(self.joint_names)


@dataclass(frozen=True)
class RobotSpec:
    """A robot asset and its stable, task-independent semantic layout."""

    name: str
    asset: AssetSpec
    joint_names: tuple[str, ...]
    root_body_name: str
    foot_names: tuple[str, ...]
    foot_body_names: tuple[str, ...]
    initial_base_position: tuple[float, float, float]
    initial_base_quaternion_xyzw: tuple[float, float, float, float]
    default_joint_positions: tuple[float, ...]
    stiffness: tuple[float, ...]
    damping: tuple[float, ...]
    contact: ContactDefaults
    import_options: ImportOptions = ImportOptions()
    armature: tuple[float, ...] | None = None
    effort_limits: tuple[float, ...] | None = None

    def __post_init__(self) -> None:
        size = len(self.joint_names)
        if size == 0 or len(set(self.joint_names)) != size:
            raise ValueError(f"{self.name} must define unique controlled joint names")
        for label, values in (
            ("default_joint_positions", self.default_joint_positions),
            ("stiffness", self.stiffness),
            ("damping", self.damping),
        ):
            if len(values) != size:
                raise ValueError(f"{self.name}.{label} must contain {size} values")
        for label, values in (
            ("armature", self.armature),
            ("effort_limits", self.effort_limits),
        ):
            if values is not None and len(values) != size:
                raise ValueError(f"{self.name}.{label} must contain {size} values")
        if len(self.foot_names) != len(self.foot_body_names):
            raise ValueError(
                f"{self.name} foot names and body names must have equal length"
            )

    def build(self, builder: Any, **kwargs: Any) -> RobotLayout:
        return build_robot(builder, self, **kwargs)


def _joint_values(
    value: JointValues, names: tuple[str, ...], label: str
) -> tuple[float, ...]:
    if isinstance(value, Mapping):
        missing = set(names) - set(value)
        unknown = set(value) - set(names)
        if missing or unknown:
            raise ValueError(
                f"{label} keys do not match controlled joints; "
                f"missing={sorted(missing)}, unknown={sorted(unknown)}"
            )
        values = tuple(float(value[name]) for name in names)
    elif isinstance(value, Real):
        values = (float(value),) * len(names)
    else:
        values = tuple(float(item) for item in value)
        if len(values) != len(names):
            raise ValueError(
                f"{label} must contain {len(names)} values, got {len(values)}"
            )
    if not all(math.isfinite(item) for item in values):
        raise ValueError(f"{label} values must be finite")
    return values


def _unique_named_index(labels: Sequence[str], name: str, kind: str) -> int:
    matches = [index for index, label in enumerate(labels) if basename(label) == name]
    if len(matches) != 1:
        raise ValueError(f"expected one {kind} named {name!r}, found indices {matches}")
    return matches[0]


def _configure_import_defaults(
    builder: Any, spec: RobotSpec, contact: ContactDefaults
) -> None:
    builder.default_joint_cfg = newton.ModelBuilder.JointDofConfig(
        limit_ke=1.0e3,
        limit_kd=10.0,
        friction=1.0e-5,
    )
    builder.default_shape_cfg.ke = contact.stiffness
    builder.default_shape_cfg.kd = contact.damping
    builder.default_shape_cfg.kf = contact.friction_stiffness
    builder.default_shape_cfg.mu = contact.friction
    if spec.import_options.preserve_inertias:
        builder.default_shape_cfg.density = 0.0


def _import_asset(
    builder: Any,
    spec: RobotSpec,
    path: Path,
    *,
    floating: bool,
    collapse_fixed_joints: bool,
) -> None:
    options = spec.import_options
    common = {
        "floating": floating,
        "collapse_fixed_joints": collapse_fixed_joints,
        "enable_self_collisions": options.enable_self_collisions,
    }
    importer = spec.asset.importer_for(path)
    if importer == "mjcf":
        builder.add_mjcf(str(path), **common)
    elif importer == "urdf":
        builder.add_urdf(str(path), **common)
    else:
        builder.add_usd(
            str(path),
            **common,
            hide_collision_shapes=options.hide_collision_shapes,
            skip_mesh_approximation=options.skip_mesh_approximation,
            ignore_paths=list(options.ignore_paths),
        )
    if options.mesh_approximation is not None:
        builder.approximate_meshes(options.mesh_approximation)


def build_robot(
    builder: Any,
    robot: RobotSpec,
    *,
    asset_path: str | Path | None = None,
    floating: bool = True,
    collapse_fixed_joints: bool | None = None,
    base_position: Sequence[float] | None = None,
    base_quaternion_xyzw: Sequence[float] | None = None,
    joint_positions: JointValues | None = None,
    stiffness: JointValues | None = None,
    damping: JointValues | None = None,
    armature: JointValues | None = None,
    effort_limits: JointValues | None = None,
    contact: ContactDefaults | None = None,
    configure_actuators: bool = True,
) -> RobotLayout:
    """Populate a prepared Newton builder with one robot and return its layout.

    Solver-specific builder registration must happen before this function is
    called. For example, MuJoCo callers first invoke
    ``SolverMuJoCo.register_custom_attributes(builder)``.
    """

    # Keep position targets aligned with joint_q. This is Newton's future
    # default and avoids an offset ambiguity for free and ball joints.
    newton.use_coord_layout_targets = True
    contact = contact or robot.contact
    collapse = (
        robot.import_options.collapse_fixed_joints
        if collapse_fixed_joints is None
        else collapse_fixed_joints
    )
    path = robot.asset.resolve(asset_path)
    _configure_import_defaults(builder, robot, contact)
    _import_asset(
        builder, robot, path, floating=floating, collapse_fixed_joints=collapse
    )

    joint_indices = tuple(
        _unique_named_index(builder.joint_label, name, "joint")
        for name in robot.joint_names
    )
    q_indices = tuple(int(builder.joint_q_start[index]) for index in joint_indices)
    qd_indices = tuple(int(builder.joint_qd_start[index]) for index in joint_indices)
    if len(set(q_indices)) != len(q_indices) or len(set(qd_indices)) != len(qd_indices):
        raise ValueError(f"{robot.name} controlled joint mapping is not one-to-one")

    if len(builder.joint_target_q) == builder.joint_coord_count:
        target_indices = q_indices
    elif len(builder.joint_target_q) == builder.joint_dof_count:
        target_indices = qd_indices
    else:
        raise ValueError("unsupported joint target layout")

    root_body = _unique_named_index(builder.body_label, robot.root_body_name, "body")
    root_joints = [
        index
        for index, child in enumerate(builder.joint_child)
        if int(child) == root_body
        and int(builder.joint_type[index]) == int(newton.JointType.FREE)
    ]
    if floating and len(root_joints) != 1:
        raise ValueError(
            f"expected one free joint for root body {robot.root_body_name!r}"
        )
    root_joint = root_joints[0] if root_joints else -1

    position = tuple(
        robot.initial_base_position if base_position is None else base_position
    )
    quaternion = tuple(
        robot.initial_base_quaternion_xyzw
        if base_quaternion_xyzw is None
        else base_quaternion_xyzw
    )
    if len(position) != 3 or len(quaternion) != 4:
        raise ValueError("base position and XYZW quaternion must have 3 and 4 values")
    quaternion_norm = math.sqrt(sum(float(value) ** 2 for value in quaternion))
    if not math.isfinite(quaternion_norm) or quaternion_norm <= 1.0e-12:
        raise ValueError("base quaternion must be finite and nonzero")
    if root_joint >= 0:
        root_q = int(builder.joint_q_start[root_joint])
        builder.joint_q[root_q : root_q + 3] = [float(value) for value in position]
        builder.joint_q[root_q + 3 : root_q + 7] = [
            float(value) / quaternion_norm for value in quaternion
        ]

    positions = _joint_values(
        robot.default_joint_positions if joint_positions is None else joint_positions,
        robot.joint_names,
        "joint_positions",
    )
    for q_index, target_index, value in zip(
        q_indices, target_indices, positions, strict=True
    ):
        builder.joint_q[q_index] = value
        builder.joint_target_q[target_index] = value

    if configure_actuators:
        gains = _joint_values(
            robot.stiffness if stiffness is None else stiffness,
            robot.joint_names,
            "stiffness",
        )
        dampers = _joint_values(
            robot.damping if damping is None else damping,
            robot.joint_names,
            "damping",
        )
        if any(value < 0.0 for value in gains + dampers):
            raise ValueError("stiffness and damping must be non-negative")
        armatures = None
        if armature is not None or robot.armature is not None:
            armatures = _joint_values(
                armature if armature is not None else robot.armature,
                robot.joint_names,
                "armature",
            )
        efforts = None
        if effort_limits is not None or robot.effort_limits is not None:
            efforts = _joint_values(
                effort_limits if effort_limits is not None else robot.effort_limits,
                robot.joint_names,
                "effort_limits",
            )
        for slot, qd_index in enumerate(qd_indices):
            builder.joint_target_ke[qd_index] = gains[slot]
            builder.joint_target_kd[qd_index] = dampers[slot]
            builder.joint_target_mode[qd_index] = int(newton.JointTargetMode.POSITION)
            if armatures is not None:
                builder.joint_armature[qd_index] = armatures[slot]
            if efforts is not None:
                builder.joint_effort_limit[qd_index] = efforts[slot]

    foot_body_indices = tuple(
        _unique_named_index(builder.body_label, name, "foot body")
        for name in robot.foot_body_names
    )
    return RobotLayout(
        name=robot.name,
        joint_names=robot.joint_names,
        joint_indices=joint_indices,
        joint_q_indices=q_indices,
        joint_qd_indices=qd_indices,
        joint_target_indices=target_indices,
        root_body_index=root_body,
        root_joint_index=root_joint,
        foot_names=robot.foot_names,
        foot_body_indices=foot_body_indices,
    )
