import importlib.util
import math
import argparse
from pathlib import Path
import sys

import pytest


MODULE_PATH = Path(__file__).parents[1] / "benchmarks" / "play_rl_sar_synreal.py"
SPEC = importlib.util.spec_from_file_location("play_rl_sar_synreal", MODULE_PATH)
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)
StraightLineCommandTracker = MODULE.StraightLineCommandTracker

COMPARISON_MODULE_PATH = (
    Path(__file__).parents[1] / "benchmarks" / "record_rl_sar_comparison.py"
)
COMPARISON_SPEC = importlib.util.spec_from_file_location(
    "record_rl_sar_comparison", COMPARISON_MODULE_PATH
)
assert COMPARISON_SPEC is not None and COMPARISON_SPEC.loader is not None
COMPARISON_MODULE = importlib.util.module_from_spec(COMPARISON_SPEC)
sys.modules[COMPARISON_SPEC.name] = COMPARISON_MODULE
COMPARISON_SPEC.loader.exec_module(COMPARISON_MODULE)


def test_a1_uses_the_pinned_rl_sar_zoo_urdf() -> None:
    profile = MODULE.PROFILES["a1"]

    assert profile.asset_kind == "zoo_urdf"
    assert profile.asset_folder == "a1_description"
    assert profile.asset_relative_path == "urdf/a1_description.urdf"


def test_straight_line_tracker_corrects_heading_and_cross_track_error() -> None:
    tracker = StraightLineCommandTracker((0.5, 0.0, 0.0))
    tracker.reset((0.0, 0.0), 0.0)

    command = tracker.update((1.0, -0.1), math.radians(-10.0), 0.02)

    assert command[1] > 0.0
    assert command[2] > 0.0
    assert tracker.cross_track_error == pytest.approx(-0.1)
    assert tracker.heading_error == pytest.approx(math.radians(10.0))


def test_straight_line_tracker_integral_removes_constant_heading_bias() -> None:
    tracker = StraightLineCommandTracker((0.5, 0.0, 0.0))
    tracker.reset((0.0, 0.0), 0.0)

    first = tracker.update((0.0, 0.0), -0.05, 0.02)
    for _ in range(100):
        final = tracker.update((0.0, 0.0), -0.05, 0.02)

    assert final[2] > first[2]
    tracker.reset((0.0, 0.0), 0.0)
    assert tracker.heading_error_integral == 0.0


def test_straight_line_tracker_preserves_nonzero_yaw_rate_command() -> None:
    nominal = (0.5, -0.1, 0.25)
    tracker = StraightLineCommandTracker(nominal)
    tracker.reset((0.0, 0.0), 0.0)

    assert tracker.update((2.0, 3.0), 1.0, 0.02) == nominal
    assert tracker.heading_error == 0.0
    assert tracker.cross_track_error == 0.0


def test_straight_line_tracker_limits_correction_by_nominal_speed() -> None:
    tracker = StraightLineCommandTracker(
        (0.01, 0.0, 0.0), cross_track_kp=10.0, cross_track_speed_limit=0.5
    )
    tracker.reset((0.0, 0.0), 0.0)

    command = tracker.update((0.0, 1.0), 0.0, 0.02)

    assert command[1] == pytest.approx(-0.01)


def test_comparison_disables_synreal_straight_line_hold(
    monkeypatch: pytest.MonkeyPatch, tmp_path: Path
) -> None:
    commands: list[list[str]] = []

    def record_command(command, **_kwargs) -> None:
        commands.append(command)

    monkeypatch.setattr(COMPARISON_MODULE.subprocess, "run", record_command)
    args = argparse.Namespace(
        robot="a1",
        cmd_vx=0.5,
        cmd_vy=0.0,
        cmd_yaw=0.0,
        duration=1.0,
        width=320,
        height=240,
        checkpoint=None,
    )

    COMPARISON_MODULE._run_player(
        "synreal", "play_rl_sar_synreal.py", args, tmp_path
    )

    assert "--no-straight-line-hold" in commands[0]
