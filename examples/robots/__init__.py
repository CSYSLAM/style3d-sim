"""Reusable robot model specifications for Newton-based examples."""

from types import MappingProxyType

from . import a1, g1, go2, h1
from .base import (
    AssetSpec,
    ContactDefaults,
    ImportOptions,
    JointValues,
    RobotLayout,
    RobotSpec,
    build_robot as _build_robot,
)


ROBOT_SPECS = MappingProxyType(
    {
        "a1": a1.SPEC,
        "g1": g1.SPEC,
        "go2": go2.SPEC,
        "h1": h1.SPEC,
    }
)


def get_robot_spec(name: str) -> RobotSpec:
    try:
        return ROBOT_SPECS[name.lower()]
    except KeyError as error:
        choices = ", ".join(ROBOT_SPECS)
        raise ValueError(
            f"unknown robot {name!r}; expected one of: {choices}"
        ) from error


def build_robot(builder, robot: str | RobotSpec, **kwargs) -> RobotLayout:
    spec = get_robot_spec(robot) if isinstance(robot, str) else robot
    return _build_robot(builder, spec, **kwargs)


__all__ = [
    "AssetSpec",
    "ContactDefaults",
    "ImportOptions",
    "JointValues",
    "ROBOT_SPECS",
    "RobotLayout",
    "RobotSpec",
    "a1",
    "build_robot",
    "g1",
    "get_robot_spec",
    "go2",
    "h1",
]
