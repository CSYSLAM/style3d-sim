from __future__ import annotations

import pytest

from examples.robots import ROBOT_SPECS, get_robot_spec


@pytest.mark.parametrize(
    ("name", "action_dim", "foot_count"),
    [
        ("a1", 12, 4),
        ("go2", 12, 4),
        ("h1", 19, 2),
        ("g1", 29, 2),
    ],
)
def test_robot_specs_have_consistent_semantic_layout(
    name: str, action_dim: int, foot_count: int
) -> None:
    spec = get_robot_spec(name.upper())

    assert spec.name == name
    assert len(spec.joint_names) == action_dim
    assert len(spec.default_joint_positions) == action_dim
    assert len(spec.stiffness) == action_dim
    assert len(spec.damping) == action_dim
    assert len(spec.foot_names) == foot_count
    assert len(spec.foot_body_names) == foot_count
    assert len(set(spec.joint_names)) == action_dim


def test_robot_registry_is_stable() -> None:
    assert tuple(ROBOT_SPECS) == ("a1", "g1", "go2", "h1")


def test_unknown_robot_reports_available_names() -> None:
    with pytest.raises(ValueError, match="a1, g1, go2, h1"):
        get_robot_spec("b2")
