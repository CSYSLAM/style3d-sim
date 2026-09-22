"""CPU regressions for portable Piper bag transport exports and the offline workflow command contract."""

import csv
import json
from pathlib import Path
from types import SimpleNamespace

import numpy as np
import pytest

pytest.importorskip("pxr")
newton = pytest.importorskip("newton")
from pxr import Usd, UsdGeom  # noqa: E402
from PIL import Image  # noqa: E402

from demos.piper_bag_transport import demo_piper_bag_transport as demo  # noqa: E402
from demos.piper_bag_transport import workflow  # noqa: E402
from demos.piper_bag_transport.export_simulation import (  # noqa: E402
    SimulationUSD, release_motion_metadata, sha256, simulation_phase,
)
from demos.piper_bag_transport.validate_simulation import (  # noqa: E402
    validate, validate_airborne_release, validate_apple_motion, validate_apple_unloading, validate_coordinated_swing,
    validate_placement_support,
    validate_release_timeline, validate_vertical_swing,
)
from demos.piper_bag_transport.workflow import ALL_STEPS, commands  # noqa: E402


def array(values):
    data = np.asarray(values)
    return SimpleNamespace(numpy=lambda: data)


def test_vertical_swing_checks_actual_jaws_and_wrist_orientation():
    times = np.linspace(0.0, 4.0, 241)
    bodies = np.zeros((len(times), 3, 7))
    bodies[:, :, 6] = 1.0
    bodies[:, :, 2] = 0.5
    bodies[:, 1:, 0] = np.sin(np.pi * times)[:, None] * 0.2
    sim = {"bounce_amplitude_m": 0.06, "wrist_body_index": 0, "finger_body_indices": [1, 2],
           "grip_point_local": [0.0, 0.0, 0.10], "finger_tip_local_z": 0.13,
           "swing_start_seconds": 0.0, "swing_period_seconds": 2.0, "swing_cycles": 2}
    with pytest.raises(ValueError, match="visibly swing up and down"):
        validate_vertical_swing(sim, bodies, times)
    bodies[:, 1:, 2] += np.sin(np.pi * times)[:, None] * 0.08
    report = validate_vertical_swing(sim, bodies, times)
    assert report["swing_grip_vertical_travel_m"] == pytest.approx(0.16)
    assert report["swing_grip_min_height_m"] == pytest.approx(0.39)
    # A rotated wrist reverses the local depth offset without changing the finger midpoint.
    bodies[:, 0, 3] = 1.0
    bodies[:, 0, 6] = 0.0
    rotated = validate_vertical_swing(sim, bodies, times)
    assert rotated["swing_grip_min_height_m"] == pytest.approx(0.45)
    assert validate_vertical_swing(sim, bodies[:60], times[:60]) == {}


def test_sequential_swing_rejects_overlapping_cartesian_motion():
    times = np.linspace(0.0, 8.0, 481)
    bodies = np.zeros((len(times), 3, 7))
    bodies[:, :, 6] = 1.0
    bodies[:, :, 2] = 0.5
    horizontal, vertical = times <= 3.0, times >= 4.0
    bodies[horizontal, 1:, 0] = 0.20 * np.sin(2.0 * np.pi * times[horizontal])[:, None]
    bodies[vertical, 1:, 2] += 0.08 * np.sin(np.pi * (times[vertical] - 4.0))[:, None]
    sim = {"bounce_amplitude_m": 0.08, "wrist_body_index": 0, "finger_body_indices": [1, 2],
           "grip_point_local": [0.0, 0.0, 0.10], "finger_tip_local_z": 0.13,
           "swing_start_seconds": 0.0, "swing_period_seconds": 1.0, "swing_cycles": 3,
           "horizontal_swing_start_seconds": 0.0, "horizontal_swing_end_seconds": 3.0,
           "vertical_swing_start_seconds": 4.0, "vertical_swing_end_seconds": 8.0}
    report = validate_vertical_swing(sim, bodies, times)
    assert report["horizontal_swing_travel_m"] == pytest.approx(0.4)
    assert report["swing_grip_vertical_travel_m"] == pytest.approx(0.16)
    assert report["vertical_swing_horizontal_drift_m"] == 0.0
    circular = bodies.copy()
    circular[vertical, 1:, 0] += 0.1 * np.sin(np.pi * times[vertical])[:, None]
    with pytest.raises(ValueError, match="fixed horizontal grip position"):
        validate_vertical_swing(sim, circular, times)
    circular = bodies.copy()
    circular[horizontal, 1:, 2] += 0.05 * np.sin(np.pi * times[horizontal])[:, None]
    with pytest.raises(ValueError, match="steady grip height"):
        validate_vertical_swing(sim, circular, times)


def test_vertical_swing_requires_the_cloth_handle_to_follow_the_jaws():
    times = np.linspace(0.0, 4.0, 241)
    bodies = np.zeros((len(times), 3, 7))
    bodies[:, :, 6] = 1.0
    bodies[:, :, 2] = (0.5 + 0.12 * np.sin(np.pi * times))[:, None]
    sim = {"bounce_amplitude_m": 0.12, "wrist_body_index": 0, "finger_body_indices": [1, 2],
           "grip_point_local": [0.0, 0.0, 0.10], "finger_tip_local_z": 0.13,
           "swing_start_seconds": 0.0, "swing_period_seconds": 2.0, "swing_cycles": 2,
           "grip_vertex_indices": [0, 1]}
    particles = bodies[:, 1:, :3].copy()
    particles[:, :, 2] -= 0.035
    report = validate_vertical_swing(sim, bodies, times, particles)
    assert report["handle_vertical_travel_m"] == pytest.approx(0.24)
    assert report["handle_vertical_max_jaw_separation_m"] == pytest.approx(0.005)
    with pytest.raises(ValueError, match="handle itself"):
        validate_vertical_swing(sim, bodies, times, np.broadcast_to(particles[0], particles.shape))
    detached = particles.copy()
    detached[:, :, 2] -= 0.04
    with pytest.raises(ValueError, match="remain between"):
        validate_vertical_swing(sim, bodies, times, detached)
    with pytest.raises(ValueError, match="Cloth states are required"):
        validate_vertical_swing(sim, bodies, times)


def test_jolts_require_sustained_unloading_in_solved_apple_velocities():
    times = np.arange(61) / 60
    sim = {"vertical_motion_profile": "asymmetric_jolt", "vertical_swing_start_seconds": 0.0,
           "vertical_swing_end_seconds": 1.0, "vertical_swing_cycles": 1, "vertical_swing_period_seconds": 1.0,
           "apple_body_indices": list(range(5)), "apple_masses_kg": [0.2] * 5, "gravity_m_s2": [0, 0, -9.81]}
    velocities = np.zeros((61, 5, 6))
    with pytest.raises(ValueError, match="at least 50 ms"):
        validate_apple_unloading(sim, velocities, times)
    # All apples free-fall for four frames, then rejoin a supported trajectory.
    acceleration = np.zeros((60, 5, 3))
    acceleration[20:24, :, 2] = -9.81
    velocities[1:, :, :3] = np.cumsum(acceleration / 60, axis=0)
    report = validate_apple_unloading(sim, velocities, times)["apple_unloading_cycles"][0]
    assert report["duration_seconds"] == pytest.approx(4 / 60)
    assert report["maximum_net_load_fraction"] < 1e-12
    assert report["individually_unloaded_apples"] == 5
    # A single-frame collision impulse must not be mistaken for a visible period of unloading.
    acceleration[:] = 0
    acceleration[20, :, 2] = -9.81
    velocities[1:, :, :3] = np.cumsum(acceleration / 60, axis=0)
    with pytest.raises(ValueError, match="at least 50 ms"):
        validate_apple_unloading(sim, velocities, times)


def test_vertical_jolts_require_pitch_in_the_solved_wrist_pose():
    from scipy.spatial.transform import Rotation

    times = np.arange(61) / 60
    phase = np.sin(2.0 * np.pi * times)
    bodies = np.zeros((len(times), 3, 7))
    bodies[:, :, 6] = 1.0
    bodies[:, :, 2] = (0.5 + 0.14 * phase)[:, None]
    sim = {"bounce_amplitude_m": 0.14, "wrist_body_index": 0, "finger_body_indices": [1, 2],
           "grip_point_local": [0.0, 0.0, 0.10], "finger_tip_local_z": 0.10,
           "swing_start_seconds": 0.0, "swing_period_seconds": 1.0, "swing_cycles": 1,
           "vertical_wrist_pitch_amplitude_radians": np.deg2rad(16.0)}
    with pytest.raises(ValueError, match="commanded wrist pitching"):
        validate_vertical_swing(sim, bodies, times)
    bodies[:, 0, 3:] = Rotation.from_euler("x", (np.pi / 2 + np.deg2rad(16.0) * phase)[:, None]).as_quat()
    report = validate_vertical_swing(sim, bodies, times)
    assert report["vertical_wrist_pitch_range_degrees"] == pytest.approx(32.0)


def test_vertical_fixed_wrist_checks_motor_targets_and_parent_relative_solved_angles():
    from scipy.spatial.transform import Rotation

    times = np.arange(61) / 60
    phase = np.sin(2 * np.pi * times)
    bodies = np.zeros((len(times), 8, 7))
    bodies[:, :, 2] = (0.49 + 0.14 * phase)[:, None]
    common = Rotation.from_euler("x", (np.pi / 2 + 0.3 * phase)[:, None])
    bodies[:, :, 3:] = common.as_quat()[:, None]
    sim = {"bounce_amplitude_m": 0.14, "wrist_body_index": 5, "finger_body_indices": [6, 7],
           "grip_point_local": [0, 0, 0.1], "finger_tip_local_z": 0.1,
           "swing_start_seconds": 0.0, "swing_period_seconds": 1.0, "swing_cycles": 1,
           "arm_body_indices": list(range(6)), "vertical_fixed_joint_indices": [4, 5],
           "motion_plan_times_seconds": times, "motion_plan_joint_targets": np.zeros((len(times), 8))}
    result = validate_vertical_swing(sim, bodies, times)
    assert max(result["vertical_fixed_joint_range_degrees"].values()) < 1e-10
    changed_targets = sim["motion_plan_joint_targets"].copy()
    changed_targets[30, 4] = 0.01
    with pytest.raises(ValueError, match="motor targets must remain constant"):
        validate_vertical_swing(sim | {"motion_plan_joint_targets": changed_targets}, bodies, times)
    slipping = bodies.copy()
    slipping[:, 5, 3:] = (common * Rotation.from_euler("z", (0.1 * phase)[:, None])).as_quat()
    with pytest.raises(ValueError, match="solved relative angles"):
        validate_vertical_swing(sim, slipping, times)


def test_coordinated_swing_rejects_base_only_rotation_and_locked_wrist_pitch():
    from scipy.spatial.transform import Rotation

    times = np.linspace(0.0, 3.0, 181)
    phase = np.sin(2 * np.pi * times)
    bodies = np.zeros((len(times), 6, 7))
    base = Rotation.from_euler("z", 0.4 * phase[:, None])
    bodies[:, :, 3:] = base.as_quat()[:, None, :]
    sim = {"horizontal_motion_profile": "coordinated_cartesian", "horizontal_swing_start_seconds": 0.0,
           "horizontal_swing_end_seconds": 3.0, "arm_body_indices": list(range(6))}
    with pytest.raises(ValueError, match="Shoulder and elbow"):
        validate_coordinated_swing(sim, bodies, times)
    shoulder = base * Rotation.from_euler("y", 0.2 * phase[:, None])
    elbow = shoulder * Rotation.from_euler("y", -0.3 * phase[:, None])
    bodies[:, 1, 3:] = shoulder.as_quat()
    bodies[:, 2:5, 3:] = elbow.as_quat()[:, None, :]
    bodies[:, 5, 3:] = (base * Rotation.from_euler("y", np.pi / 2)).as_quat()
    with pytest.raises(ValueError, match="gentle wrist pitch"):
        validate_coordinated_swing(sim, bodies, times)
    bodies[:, 5, 3:] = (base * Rotation.from_euler("y", np.pi / 2 + 0.07 * phase[:, None])).as_quat()
    report = validate_coordinated_swing(sim, bodies, times)
    assert report["horizontal_shoulder_rotation_range_degrees"] == pytest.approx(np.degrees(0.2 * np.ptp(phase)))
    assert 7 < report["horizontal_wrist_pitch_range_degrees"] < 9


@pytest.fixture
def exported(tmp_path):
    source_dir = tmp_path / "source"
    source_dir.mkdir()
    texture = source_dir / "apple.png"
    Image.new("RGB", (2, 2), (180, 20, 10)).save(texture)
    root = tmp_path / "bundle"
    root.mkdir()
    points = np.array(((0, 0, 0), (0.1, 0, 0), (0, 0.1, 0)), dtype=np.float32)
    triangle = np.array(((0, 1, 2),), dtype=np.int32)
    normals = np.tile((0.0, 0.0, 1.0), (3, 1)).astype(np.float32)
    visual = SimpleNamespace(vertices=points, indices=triangle, normals=normals, uvs=None,
                             texture=None, color=(0.1, 0.1, 0.1), roughness=0.3, metallic=0.0)
    visual.uvs = points[:, :2]
    visual.texture = str(texture)
    identity = np.array((0, 0, 0, 0, 0, 0, 1), dtype=np.float32)
    visible = int(newton.ShapeFlags.VISIBLE)
    transforms = np.tile(identity, (7, 1))
    transforms[0, :3] = (0.0, -0.52, 0.0)
    transforms[5, :3] = (0, -0.2, -0.02)
    transforms[6, :3] = (0, 0.02, 0.015)
    model = SimpleNamespace(
        body_count=2, body_label=["piper/link1", "apple_0"], tri_indices=array(triangle),
        shape_body=array([-1, 0, 1, 1, -1, -1, -1]),
        shape_flags=array([visible, visible, visible, 0, visible, visible, visible]),
        shape_type=array([newton.GeoType.MESH] * 2 + [newton.GeoType.MESH, newton.GeoType.MESH,
                                                               newton.GeoType.PLANE] + [newton.GeoType.BOX] * 2),
        shape_label=["base", "link1", "apple", "apple_collider", "ground", "scene_floor", "bag_platform"],
        shape_scale=array([(1, 1, 1), (1, 1, 1), (0.65, 0.65, 0.65), (1, 1, 1), (1, 1, 1),
                           (0.9, 0.9, 0.02), (0.25, 0.21, 0.015)]),
        shape_transform=array(transforms), shape_color=array(np.ones((7, 3))),
        shape_source=[visual, visual, visual, visual, None, None, None],
    )
    example = SimpleNamespace(model=model, frame_dt=1.0 / 60, bag_particle_count=3, bag_bodies=[1],
                              state_0=SimpleNamespace(particle_q=array(points)),
                              bag_panel_points=points[:, :2], bag_panel_indices=triangle)
    path = root / "sample.usdc"
    exporter = SimulationUSD(path, example, 2)
    particles = np.stack([points + (0, 0, 0.01 * frame) for frame in range(3)]).astype(np.float32)
    bodies = np.tile(identity, (3, model.body_count, 1))
    bodies[:, 1, 0] = (0.0, 0.03, 0.06)
    for frame in range(3):
        exporter.sample(frame, particles[frame], bodies[frame])
    exporter.stage.GetRootLayer().Save()
    states = root / "sample_states.npz"
    np.savez_compressed(states, particle_q=particles, body_q=bodies, triangles=triangle,
                        time_seconds=np.arange(3, dtype=np.float64) / 60)
    metadata = {
        "source_sha256": {},
        "simulation": {"frames": 2, "samples": 3, "fps": 60, "bag_particles": 3,
                       "body_count": model.body_count, "apple_count": 1,
                       "apple_collision_vertices": collider_box().tolist()},
        "meshes": exporter.meshes,
        "timeline": [{"frame": frame, "time_seconds": frame / 60} for frame in range(3)],
        "validation": {"example_assertion_errors": [], "maximum_grip_error_m": 0.001},
        "files": {"usd": path.name, "raw_states": states.name},
        "file_sha256": {p.name: sha256(p) for p in (path, states)},
        "texture_sha256": {name: sha256(root / name) for name in exporter.textures.values()},
    }
    meta_path = root / "sample_metadata.json"
    meta_path.write_text(json.dumps(metadata), encoding="utf-8")
    return meta_path, exporter, source_dir


def test_moved_demo_resolves_repository_assets():
    assert demo.APPLE_COUNT == 5
    assert demo.APPLE_ASSET.is_file()
    assert demo.PIPER_ASSET.is_file()
    assert (demo.REPO_ROOT / "pyproject.toml").is_file()


def test_export_preserves_base_visuals_uvs_transforms_and_every_sample(exported):
    metadata, exporter, source = exported
    report = validate(metadata)
    assert report["samples_checked"] == 3
    assert report["mesh_counts"] == {"bag": 1, "robot": 2, "apple": 1, "environment": 2}
    assert report["maximum_point_error_m"] == report["maximum_pose_error"] == 0
    assert "telemetry_rows" not in report
    stage = exporter.stage
    base = stage.GetPrimAtPath("/World/Piper/fixed_base/robot_visual_000")
    np.testing.assert_allclose(base.GetAttribute("xformOp:translate").Get(), (0, -0.52, 0))
    apple = UsdGeom.Mesh(stage.GetPrimAtPath("/World/Apples/apple_body_01/apple_visual_002"))
    np.testing.assert_allclose(np.asarray(apple.GetPointsAttr().Get())[1], (0.065, 0, 0))
    np.testing.assert_allclose(apple.GetPrim().GetAttribute("xformOp:translate").Get(), (0, 0, 0))
    assert len(exporter.textures) == 1
    pattern = UsdGeom.PrimvarsAPI(exporter.bag).GetPrimvar("film_pattern_m")
    assert pattern.GetInterpolation() == "faceVarying" and not pattern.GetTimeSamples()
    np.testing.assert_allclose(pattern.Get(), ((0, 0), (0.1, 0), (0, 0.1)))
    # Moving the original texture must not break the exported bundle.
    (source / "apple.png").rename(source / "moved.png")
    assert validate(metadata)["passed"]


@pytest.mark.parametrize("damage, message", (("points", "Apple visual points changed"),
                                             ("normals", "Apple visual normals changed"),
                                             ("faces", "Apple visual indices changed"), ("pose", "Apple local pose")))
def test_validation_rejects_apple_visuals_that_disagree_with_collision(exported, damage, message):
    path, exporter, _ = exported
    metadata = json.loads(path.read_text(encoding="utf-8"))
    apple = UsdGeom.Mesh(exporter.stage.GetPrimAtPath("/World/Apples/apple_body_01/apple_visual_002"))
    if damage == "points":
        apple.GetPointsAttr().Set(np.asarray(apple.GetPointsAttr().Get()) * 1.1)
    elif damage == "normals":
        apple.GetNormalsAttr().Set(-np.asarray(apple.GetNormalsAttr().Get()))
    elif damage == "pose":
        apple.GetPrim().GetAttribute("xformOp:translate").Set((0.0, 0.01, 0.0))
    else:
        indices = np.asarray(apple.GetFaceVertexIndicesAttr().Get()).reshape(-1, 3)
        apple.GetFaceVertexIndicesAttr().Set(indices[:, ::-1].ravel())
    exporter.stage.GetRootLayer().Save()
    metadata["file_sha256"][exporter.path.name] = sha256(exporter.path)
    path.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        validate(path)


def collider_box():
    return np.array([(x, y, z) for x in (-0.03, 0.03) for y in (-0.03, 0.03) for z in (-0.03, 0.03)])


def gravity_drop_states():
    mouth = np.array(((-0.1, -0.05, 0.3), (0.1, -0.05, 0.3), (0.1, 0.05, 0.3), (-0.1, 0.05, 0.3)))
    bag = np.concatenate((mouth, mouth - (0, 0, 0.3)))
    particles = np.stack((bag, bag, bag + (0, 0, 0.2), bag))
    initial = np.array(((-0.04, 0, 0.34), (0.04, 0, 0.34), (-0.04, 0, 0.41),
                        (0.04, 0, 0.41), (0, 0, 0.48)))
    bodies = np.zeros((4, 5, 7))
    bodies[:, :, 6] = 1
    bodies[0, :, :3] = initial
    bodies[1:, :, :3] = initial - (0, 0, 0.3)
    bodies[2, :, 2] += 0.2
    sim = dict(loading_mode="gravity_drop", apple_body_indices=list(range(5)),
               apple_collision_vertices=collider_box().tolist(),
               initial_apple_positions=initial.tolist(), mouth_vertex_indices=list(range(4)),
               loading_end_seconds=0.5, release_start_seconds=2.0, apple_cloth_contact_gap=0.0045)
    return sim, particles, bodies, np.array((0, 0.5, 1, 2))


def test_validation_checks_five_initial_falls_and_retention_from_raw_states():
    report = validate_apple_motion(*gravity_drop_states())
    assert report == {"initial_apple_count": 5, "minimum_loading_descent_m": pytest.approx(0.3),
                      "retained_apple_samples": 2}
    sim, particles, bodies, times = gravity_drop_states()
    assert validate_apple_motion(sim, particles[:1], bodies[:1], times[:1]) == {"initial_apple_count": 5}


def test_initial_drop_uses_low_mouth_plane_instead_of_high_handle_edges():
    sim, particles, bodies, times = gravity_drop_states()
    particles[0, 3, 2] = 0.6
    sim["initial_mouth_height_m"] = 0.3
    assert validate_apple_motion(sim, particles, bodies, times)["initial_apple_count"] == 5
    sim["initial_mouth_height_m"] = 0.6
    with pytest.raises(ValueError, match="low cut lip"):
        validate_apple_motion(sim, particles, bodies, times)


def test_initial_drop_detects_collision_with_film_above_the_low_mouth():
    sim, particles, bodies, times = gravity_drop_states()
    # A handle flap crosses the first apple even though its bottom is above the low lip.
    flap = np.array(((-0.07, -0.03, 0.32), (0.01, -0.03, 0.32), (-0.04, 0.05, 0.32)))
    particles = np.concatenate((particles, np.broadcast_to(flap, (4, 3, 3))), axis=1)
    with pytest.raises(ValueError, match="intersect the film"):
        validate_apple_motion(sim, particles, bodies, times, np.array(((8, 9, 10),)))
    particles[:, 8:, 2] -= 0.1
    assert validate_apple_motion(sim, particles, bodies, times, np.array(((8, 9, 10),)))["initial_apple_film_gap_m"] > 0


@pytest.mark.parametrize("damage, message", (
    ("count", "five distinct apple bodies"), ("mouth", "Missing bag mouth vertices"),
    ("below", "start above the bag mouth"), ("outside", "start over the bag opening"),
    ("overlap", "Initial apples overlap"), ("not_fallen", "Every apple must fall"),
    ("escaped", "escaped the bag before release"), ("metadata", "do not match the raw state"),
))
def test_validation_rejects_missing_falls_and_escaped_apples(damage, message):
    sim, particles, bodies, times = gravity_drop_states()
    if damage == "count":
        sim["apple_body_indices"][-1] = 0
    elif damage == "mouth":
        sim.pop("mouth_vertex_indices")
    elif damage == "below":
        bodies[0, 0, 2] -= 0.1
    elif damage == "outside":
        bodies[0, 0, 0] -= 0.1
    elif damage == "overlap":
        bodies[0, 1] = bodies[0, 0]
    elif damage == "not_fallen":
        bodies[1, 0, 2] = bodies[0, 0, 2]
    elif damage == "escaped":
        bodies[2, 0, 0] += 1.0
    if damage == "metadata":
        sim["initial_apple_positions"][0][0] += 0.01
    else:
        sim["initial_apple_positions"] = bodies[0, :, :3].tolist()
    with pytest.raises(ValueError, match=message):
        validate_apple_motion(sim, particles, bodies, times)


@pytest.mark.parametrize("damage,message", [(None, None), ("supported", "unsupported in midair"),
                                           ("retained", "No apple rolled clear"),
                                           ("stationary", "visibly translate and rotate")])
def test_airborne_release_requires_spill_and_post_impact_motion(damage, message):
    sim, particles, bodies, _ = gravity_drop_states()
    times = np.array((0.0, 1.0, 1.5, 2.0))
    sim.update(airborne_release=True, release_start_seconds=1.0, release_duration_seconds=0.4,
               duration_seconds=2.0, cloth_contact_radius=0.0015)
    particles[1] = particles[0] + (0, 0, 0.2)
    particles[2:] = particles[0]
    bodies[2, 0, :3] = (0.08, 0.0, 0.05)
    bodies[-1, 0, :3] = (0.30, 0.0, 0.05)
    bodies[-1, 0, 3:] = (np.sin(0.5), 0.0, 0.0, np.cos(0.5))
    if damage == "supported":
        particles[1, :, 2] -= 0.2
    elif damage == "retained":
        bodies[-1, 0, 0] = 0.0
    elif damage == "stationary":
        bodies[-1, 0, 3:] = (0.0, 0.0, 0.0, 1.0)
    if message is None:
        report = validate_airborne_release(sim, particles, bodies, times)
        assert report["spilled_apple_count"] == 1
        assert report["maximum_spilled_apple_ground_travel_m"] == pytest.approx(0.22)
    else:
        with pytest.raises(ValueError, match=message):
            validate_airborne_release(sim, particles, bodies, times)


def test_validation_requires_four_nonlinear_iterations(exported):
    path, _, _ = exported
    metadata = json.loads(path.read_text(encoding="utf-8"))
    metadata["simulation"]["nonlinear_iterations"] = 8
    path.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match="requires four nonlinear iterations"):
        validate(path)


@pytest.mark.parametrize("damage", [None, "shape", "nonfinite"])
def test_recorded_body_velocities_are_finite_and_cover_every_export_sample(exported, damage):
    path, _, _ = exported
    metadata = json.loads(path.read_text(encoding="utf-8"))
    states_path = path.parent / metadata["files"]["raw_states"]
    with np.load(states_path) as archived:
        values = {name: archived[name] for name in archived.files}
    values["body_qd"] = np.zeros((*values["body_q"].shape[:2], 6), dtype=np.float32)
    if damage == "shape":
        values["body_qd"] = values["body_qd"][:-1]
    elif damage == "nonfinite":
        values["body_qd"][1, 0, 0] = np.nan
    np.savez_compressed(states_path, **values)
    metadata["file_sha256"][states_path.name] = sha256(states_path)
    path.write_text(json.dumps(metadata), encoding="utf-8")
    if damage is None:
        assert validate(path)["passed"]
    else:
        with pytest.raises(ValueError, match="recorded body velocities"):
            validate(path)


def test_environment_export_preserves_finite_floor_and_platform_height(exported):
    _, exporter, _ = exported
    for name, dimensions, center in (("scene_floor", (1.8, 1.8, 0.04), (0, -0.2, -0.02)),
                                     ("bag_platform", (0.5, 0.42, 0.03), (0, 0.02, 0.015))):
        mesh = UsdGeom.Mesh(exporter.stage.GetPrimAtPath(f"/World/Environment/{name}"))
        points = np.asarray(mesh.GetPointsAttr().Get())
        np.testing.assert_allclose(np.ptp(points, axis=0), dimensions)
        np.testing.assert_allclose(mesh.GetPrim().GetAttribute("xformOp:translate").Get(), center)
        triangles = np.asarray(mesh.GetFaceVertexIndicesAttr().Get()).reshape(-1, 3)
        a, b, c = np.moveaxis(points[triangles], 1, 0)
        assert np.all(np.sum(np.cross(b - a, c - a) * (a + b + c), axis=1) > 0)
    np.testing.assert_allclose(exporter.bag.GetDisplayColorAttr().Get(), [demo.BAG_COLOR])


@pytest.fixture
def released_export(exported):
    path, _, _ = exported
    metadata = json.loads(path.read_text(encoding="utf-8"))
    metadata["simulation"].update(release_start_seconds=1 / 60, release_duration_seconds=1 / 60,
                                  retraction_delay_seconds=0, retraction_duration_seconds=1 / 60,
                                  release_opening_m=0.035)
    for sample, phase, error in zip(metadata["timeline"], ("carry", "release", "drop"), (0.001, 0.06, 0.15)):
        sample.update(phase=phase, grip_error_m=error)
    metadata["validation"]["maximum_handle_separation_m"] = 0.15
    path.write_text(json.dumps(metadata), encoding="utf-8")
    return path


def test_validation_excludes_intentional_release_from_grip_error(released_export):
    report = validate(released_export)
    assert report["passed"]
    assert report["maximum_grip_error_m"] == 0.001
    assert report["maximum_handle_separation_m"] == 0.15


@pytest.mark.parametrize("include_pickup", (False, True))
def test_export_records_optional_pickup_and_classifies_phase_boundaries(include_pickup):
    source = SimpleNamespace(RELEASE_START=3.0, RELEASE_DURATION=0.2, RELEASE_OPENING=.035,
                             RETRACT_DELAY=0.2, RETRACT_DURATION=0.3, GRIP_POINT_LOCAL=(0, 0, .105),
                             PIPER_RETRACT_Q=(0, 1.1, -1.2, 0, .18, 1.57, .035, -.035))
    if include_pickup:
        source.GRASP_START, source.LIFT_START = 0.5, 1.0
    motion, end = release_motion_metadata(source)
    assert end == 3.5
    assert all(key not in motion for key in ("cloth_contact_friction", "finger_kp", "finger_kd"))
    if include_pickup:
        assert motion["pickup_start_seconds"] == 0.5
        assert motion["lift_start_seconds"] == 1.0
    else:
        assert "pickup_start_seconds" not in motion and "lift_start_seconds" not in motion
    times = (0.0, 0.5, 1.0, 2.999, 3.0, 3.499, 3.5)
    phases = [simulation_phase(time, motion, end) for time in times]
    expected = ["pickup", "pickup"] if include_pickup else ["carry", "carry"]
    assert phases == expected + ["carry", "carry", "release", "release", "drop"]
    if include_pickup:
        source.LIFT_START = source.GRASP_START - 0.1
        with pytest.raises(ValueError, match="Invalid pickup timing"):
            release_motion_metadata(source)
        del source.LIFT_START
        with pytest.raises(ValueError, match="Incomplete pickup configuration"):
            release_motion_metadata(source)


def test_export_records_extended_swing_and_supported_placement_phases():
    source = SimpleNamespace(RELEASE_START=6.0, RELEASE_DURATION=0.2, RELEASE_OPENING=.035,
                             RETRACT_DELAY=0.4, RETRACT_DURATION=0.6, GRIP_POINT_LOCAL=(0, 0, .105),
                             PIPER_RETRACT_Q=(0, 1.1, -1.2, 0, .18, 1.57, .035, -.035),
                             GRASP_START=0.2, LIFT_START=0.5, SWING_START=1.0, SWING_PERIOD=0.5, SWING_CYCLES=6,
                             PLACE_START=4.0, PLACE_DURATION=1.5, PLACE_SETTLE_DURATION=0.5, AIRBORNE_RELEASE=False)
    motion, end = release_motion_metadata(source)
    assert end == 7.0 and motion["arm_motion_end_seconds"] == 7.0
    assert motion["swing_cycles"] == 6 and motion["swing_period_seconds"] == 0.5
    assert motion["swing_start_seconds"] == 1.0 and motion["place_start_seconds"] == 4.0
    assert motion["place_duration_seconds"] == 1.5 and motion["place_settle_duration_seconds"] == 0.5
    times = (0, 0.5, 1, 3.999, 4, 5.5, 5.999, 6, 6.999, 7)
    phases = [simulation_phase(time, motion, end) for time in times]
    assert phases == ["pickup", "carry", "carry", "carry", "place", "place", "place", "release", "release", "placed"]
    timeline = [dict(frame=index, time_seconds=time, phase=phase, grip_error_m=0.001 if phase == "carry" else 0.2)
                for index, (time, phase) in enumerate(zip(times, phases))]
    validation = dict(maximum_grip_error_m=0.001, maximum_handle_separation_m=0.2)
    assert validate_release_timeline(motion, timeline, validation)["maximum_handle_separation_m"] == 0.2
    for field, value, message in (("swing_cycles", 5.5, "Invalid swing timing"),
                                  ("swing_cycles", 5, "Placement must start when swinging finishes"),
                                  ("place_settle_duration_seconds", -0.5, "Invalid placement timing"),
                                  ("airborne_release", True, "Placement must release the bag on the platform")):
        with pytest.raises(ValueError, match=message):
            validate_release_timeline(motion | {field: value}, timeline, validation)
    source.PLACE_SETTLE_DURATION = 0.0
    with pytest.raises(ValueError, match="Invalid placement timing"):
        release_motion_metadata(source)
    del source.PLACE_DURATION
    with pytest.raises(ValueError, match="Incomplete placement configuration"):
        release_motion_metadata(source)


def test_sequential_swing_timeline_places_only_after_both_stages():
    source = SimpleNamespace(RELEASE_START=11.0, RELEASE_DURATION=0.2, RELEASE_OPENING=.035,
                             RETRACT_DELAY=0.4, RETRACT_DURATION=0.6, GRIP_POINT_LOCAL=(0, 0, .105),
                             PIPER_RETRACT_Q=(0, 1.1, -1.2, 0, .18, 1.57, .035, -.035),
                             GRASP_START=0.2, LIFT_START=0.5, SWING_START=1.0, SWING_PERIOD=1.0, SWING_CYCLES=3,
                             HORIZONTAL_START=1.0, HORIZONTAL_END=4.0, HORIZONTAL_PERIOD=1.0, HORIZONTAL_CYCLES=3,
                             VERTICAL_START=4.5, VERTICAL_END=8.5, VERTICAL_PERIOD=2.0, VERTICAL_CYCLES=2,
                             PLACE_START=8.5, PLACE_DURATION=2.0, PLACE_SETTLE_DURATION=0.5, AIRBORNE_RELEASE=False)
    motion, end = release_motion_metadata(source)
    times = (0.0, 1.0, 4.0, 4.5, 8.49, 8.5, 10.5, 11.0, 12.0)
    timeline = [dict(frame=index, time_seconds=t, phase=simulation_phase(t, motion, end), grip_error_m=0.001)
                for index, t in enumerate(times)]
    validation = dict(maximum_grip_error_m=0.001, maximum_handle_separation_m=0.001)
    assert motion["vertical_swing_end_seconds"] == motion["place_start_seconds"] == 8.5
    validate_release_timeline(motion, timeline, validation)
    with pytest.raises(ValueError, match="finish before vertical"):
        validate_release_timeline(motion | {"vertical_swing_start_seconds": 3.5, "vertical_swing_end_seconds": 7.5},
                                  timeline, validation)
    missing = motion.copy()
    del missing["vertical_swing_cycles"]
    with pytest.raises(ValueError, match="Incomplete sequential swing"):
        validate_release_timeline(missing, timeline, validation)


def write_placement_states(path, exporter, particles, bodies, raw):
    for frame in range(len(particles)):
        exporter.sample(frame, particles[frame], bodies[frame])
    exporter.stage.GetRootLayer().Save()
    metadata = json.loads(path.read_text(encoding="utf-8"))
    raw_path = path.parent / metadata["files"]["raw_states"]
    np.savez_compressed(raw_path, **(raw | {"particle_q": particles, "body_q": bodies}))
    metadata["file_sha256"] = {entry.name: sha256(entry) for entry in (raw_path, exporter.path)}
    path.write_text(json.dumps(metadata), encoding="utf-8")


@pytest.fixture
def placed_export(exported):
    path, exporter, _ = exported
    metadata = json.loads(path.read_text(encoding="utf-8"))
    metadata["simulation"].update(release_start_seconds=1 / 60, release_duration_seconds=1 / 60,
                                  retraction_delay_seconds=0, retraction_duration_seconds=1 / 60,
                                  release_opening_m=0.035, airborne_release=False,
                                  place_start_seconds=0, place_duration_seconds=0.5 / 60,
                                  place_settle_duration_seconds=0.5 / 60, cloth_contact_radius=0.003,
                                  apple_collision_margin=0.003)
    for sample, phase, error in zip(metadata["timeline"], ("place", "release", "placed"), (0.02, 0.06, 0.15)):
        sample.update(phase=phase, grip_error_m=error)
    metadata["validation"].update(maximum_grip_error_m=0.0, maximum_handle_separation_m=0.15)
    path.write_text(json.dumps(metadata), encoding="utf-8")
    with np.load(path.parent / metadata["files"]["raw_states"]) as archive:
        raw = {key: archive[key].copy() for key in archive.files}
    particles, bodies = raw["particle_q"], raw["body_q"]
    particles[:, :, 2] = 0.033
    bodies[:, 1, 2] = 0.064
    write_placement_states(path, exporter, particles, bodies, raw)
    return path, exporter


def test_validation_confirms_platform_support_before_opening(placed_export):
    path, _ = placed_export
    report = validate(path)
    assert report["passed"] and report["maximum_grip_error_m"] == 0.0
    assert report["placement_support_frame"] == 0
    assert report["placement_bag_gap_m"] == pytest.approx(0.003, abs=1.0e-7)
    assert report["placement_lowest_apple_gap_m"] == pytest.approx(0.004, abs=1.0e-7)


def test_placement_must_stay_supported_after_withdrawal(placed_export):
    path, _ = placed_export
    metadata = json.loads(path.read_text(encoding="utf-8"))
    sim = metadata["simulation"] | {"vertical_swing_end_seconds": 0.0, "duration_seconds": 2 / 60}
    stage = Usd.Stage.Open(str(path.parent / metadata["files"]["usd"]))
    with np.load(path.parent / metadata["files"]["raw_states"]) as raw:
        particles, bodies, times = raw["particle_q"], raw["body_q"], raw["time_seconds"]
    args = (stage, sim, metadata["meshes"])
    report = validate_placement_support(*args, particles, times, bodies)
    assert report["final_placement_bag_gap_m"] == pytest.approx(0.003, abs=1e-7)
    dragged = particles.copy()
    dragged[-1, :, 1] -= 0.8
    with pytest.raises(ValueError, match="remain on the platform after withdrawal"):
        validate_placement_support(*args, dragged, times, bodies)
    lifted = particles.copy()
    lifted[-1, :, 2] += 0.1
    with pytest.raises(ValueError, match="remain supported after withdrawal"):
        validate_placement_support(*args, lifted, times, bodies)


def test_short_placement_export_does_not_claim_prerelease_support(placed_export):
    path, _ = placed_export
    metadata = json.loads(path.read_text(encoding="utf-8"))
    metadata["simulation"].update(release_start_seconds=3 / 60, place_settle_duration_seconds=2.5 / 60)
    for sample in metadata["timeline"]:
        sample["phase"] = "place"
    path.write_text(json.dumps(metadata), encoding="utf-8")
    report = validate(path)
    assert report["passed"] and "placement_support_frame" not in report


@pytest.mark.parametrize("damage, message", (
    ("bag_airborne", "Bag must touch the platform before release"),
    ("bag_outside", "Bag is outside the platform before release"),
    ("apple_airborne", "The apples must be supported by the platform before release"),
    ("apple_outside", "A placed apple is outside the platform before release"),
    ("apple_penetration", "A placed apple penetrates the platform before release"),
))
def test_validation_rejects_release_without_platform_support(placed_export, damage, message):
    path, exporter = placed_export
    metadata = json.loads(path.read_text(encoding="utf-8"))
    with np.load(path.parent / metadata["files"]["raw_states"]) as archive:
        raw = {key: archive[key].copy() for key in archive.files}
    particles, bodies = raw["particle_q"], raw["body_q"]
    if damage == "bag_airborne":
        particles[0, :, 2] += 0.1
    elif damage == "bag_outside":
        particles[0, :, 0] += 1.0
    elif damage == "apple_airborne":
        bodies[0, 1, 2] += 0.1
    elif damage == "apple_outside":
        bodies[0, 1, 0] += 1.0
    else:
        bodies[0, 1, 2] -= 0.03
    write_placement_states(path, exporter, particles, bodies, raw)
    with pytest.raises(ValueError, match=message):
        validate(path)


@pytest.mark.parametrize("damage, message", (
    ("missing_duration", "Incomplete placement parameters"),
    ("release_before_settle", "Invalid placement timing"),
    ("airborne", "Placement must release the bag on the platform"),
    ("place_phase", "Wrong release phase"),
    ("placed_phase", "Wrong release phase"),
    ("grip_maximum", "Grip error must include only carry samples"),
))
def test_validation_rejects_inconsistent_placement_metadata(placed_export, damage, message):
    path, _ = placed_export
    metadata = json.loads(path.read_text(encoding="utf-8"))
    sim = metadata["simulation"]
    if damage == "missing_duration":
        del sim["place_duration_seconds"]
    elif damage == "release_before_settle":
        sim["place_settle_duration_seconds"] = 2 / 60
    elif damage == "airborne":
        sim["airborne_release"] = True
    elif damage == "place_phase":
        metadata["timeline"][0]["phase"] = "carry"
    elif damage == "placed_phase":
        metadata["timeline"][2]["phase"] = "drop"
    else:
        metadata["validation"]["maximum_grip_error_m"] = 0.02
    path.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        validate(path)


@pytest.fixture
def pickup_export(released_export):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    metadata["simulation"].update(pickup_start_seconds=0.5 / 60, lift_start_seconds=1 / 60,
                                  release_start_seconds=2 / 60)
    for sample, phase, error in zip(metadata["timeline"], ("pickup", "carry", "release"), (0.3, 0.001, 0.15)):
        sample.update(phase=phase, grip_error_m=error)
    metadata["validation"]["maximum_handle_separation_m"] = 0.3
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    return released_export


def test_validation_excludes_pickup_from_carry_grip_error(pickup_export):
    report = validate(pickup_export)
    assert report["passed"]
    assert report["maximum_grip_error_m"] == 0.001
    assert report["maximum_handle_separation_m"] == 0.3
    metadata = json.loads(pickup_export.read_text(encoding="utf-8"))
    metadata["validation"]["maximum_grip_error_m"] = 0.3
    pickup_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match="Grip error must include only carry samples"):
        validate(pickup_export)


def test_export_records_initial_gravity_loading_before_pickup():
    source = SimpleNamespace(RELEASE_START=8.0, RELEASE_DURATION=0.2, RELEASE_OPENING=.035,
                             RETRACT_DELAY=0.3, RETRACT_DURATION=1.0, GRIP_POINT_LOCAL=(0, 0, .105),
                             PIPER_RETRACT_Q=(0, 1.1, -1.2, 0, .18, 1.57, .035, -.035),
                             APPLE_LOADING_START=0.0, APPLE_LOADING_END=0.5,
                             GRASP_START=0.8, LIFT_START=1.0, AIRBORNE_RELEASE=False, DURATION_SECONDS=11.0)
    motion, end = release_motion_metadata(source)
    assert motion["loading_mode"] == "gravity_drop" and motion["loading_end_seconds"] == 0.5
    assert "apple_loading_events" not in motion
    assert motion["duration_seconds"] == 11.0
    times = (0, 0.499, 0.5, 0.8, 1, 7.999, 8, 9.3)
    phases = [simulation_phase(t, motion, end) for t in times]
    assert phases == ["loading", "loading", "pickup", "pickup", "carry", "carry", "release", "drop"]
    timeline = [dict(frame=i, time_seconds=t, phase=phase, grip_error_m=0.01 if phase == "carry" else 0.3)
                for i, (t, phase) in enumerate(zip(times, phases))]
    validation = dict(maximum_grip_error_m=0.01, maximum_handle_separation_m=0.3)
    assert validate_release_timeline(motion, timeline, validation)["maximum_handle_separation_m"] == 0.3
    for field, value, message in (("loading_end_seconds", 0.9, "Invalid apple loading timing"),
                                  ("loading_start_seconds", 0.1, "Invalid apple loading timing"),
                                  ("loading_mode", "robot_pickup", "Apples must fall")):
        with pytest.raises(ValueError, match=message):
            validate_release_timeline(motion | {field: value}, timeline, validation)
    del source.APPLE_LOADING_END
    with pytest.raises(ValueError, match="Incomplete apple loading configuration"):
        release_motion_metadata(source)


def test_airborne_drop_starts_when_jaws_finish_opening(released_export):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    sim = metadata["simulation"]
    sim.update(airborne_release=True, retraction_duration_seconds=3 / 60, arm_motion_end_seconds=4 / 60)
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    assert validate(released_export)["passed"]
    metadata["timeline"][2]["phase"] = "release"
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match="Wrong release phase"):
        validate(released_export)


@pytest.mark.parametrize("damage, message", (
    ("missing_pickup", "Incomplete pickup parameters"),
    ("missing_lift", "Incomplete pickup parameters"),
    ("negative_pickup", "Invalid pickup timing"),
    ("nonfinite_lift", "Invalid pickup timing"),
    ("reversed", "Invalid pickup timing"),
    ("lift_at_release", "Invalid pickup timing"),
    ("pickup_phase", "Wrong release phase"),
    ("lift_phase", "Wrong release phase"),
))
def test_validation_rejects_invalid_pickup_metadata(pickup_export, damage, message):
    metadata = json.loads(pickup_export.read_text(encoding="utf-8"))
    simulation = metadata["simulation"]
    if damage == "missing_pickup":
        del simulation["pickup_start_seconds"]
    elif damage == "missing_lift":
        del simulation["lift_start_seconds"]
    elif damage == "negative_pickup":
        simulation["pickup_start_seconds"] = -1.0
    elif damage == "nonfinite_lift":
        simulation["lift_start_seconds"] = float("inf")
    elif damage == "reversed":
        simulation["pickup_start_seconds"] = 1.5 / 60
    elif damage == "lift_at_release":
        simulation["lift_start_seconds"] = simulation["release_start_seconds"]
    elif damage == "pickup_phase":
        metadata["timeline"][0]["phase"] = "carry"
    else:
        metadata["timeline"][1]["phase"] = "pickup"
    pickup_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        validate(pickup_export)


@pytest.mark.parametrize("damage", ("phase", "carry_maximum", "handle_maximum", "incomplete_parameters"))
def test_validation_rejects_inconsistent_release_metadata(released_export, damage):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    if damage == "phase":
        metadata["timeline"][1]["phase"] = "carry"
    elif damage == "carry_maximum":
        metadata["validation"]["maximum_grip_error_m"] = 0.15
    elif damage == "handle_maximum":
        metadata["validation"]["maximum_handle_separation_m"] = 0.001
    else:
        del metadata["simulation"]["retraction_duration_seconds"]
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError):
        validate(released_export)


@pytest.mark.parametrize("damage", ("sweep_timing", "incomplete_sweep", "finger_targets"))
def test_validation_rejects_inconsistent_release_sweep_or_targets(released_export, damage):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    simulation = metadata["simulation"]
    simulation.update(release_sweep_start_seconds=0, release_sweep_duration_seconds=1 / 60,
                      release_sweep_yaw_radians=-0.5,
                      release_joint_targets=[-0.5, 1.1, -1.2, 0, 0.18, 1.57, 0.035, -0.035])
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    assert validate(released_export)["passed"]
    if damage == "sweep_timing":
        simulation["release_sweep_duration_seconds"] = 0.5 / 60
    elif damage == "incomplete_sweep":
        del simulation["release_sweep_yaw_radians"]
    else:
        simulation["release_joint_targets"][-1] = 0.035
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError):
        validate(released_export)


@pytest.mark.parametrize("continuing_motion", ("sweep", "lower", "clear", "unhook"))
def test_release_phase_includes_motion_after_fingers_open(released_export, continuing_motion):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    simulation = metadata["simulation"]
    simulation.update(release_sweep_start_seconds=0, release_sweep_duration_seconds=1 / 60,
                      release_sweep_yaw_radians=-0.5)
    if continuing_motion == "sweep":
        simulation["release_sweep_duration_seconds"] = 3 / 60
    else:
        simulation.update({f"{continuing_motion}_start_seconds": 1 / 60,
                           f"{continuing_motion}_duration_seconds": 2 / 60,
                           f"{continuing_motion}_joint_targets": [-0.5, 1.1, -1.2, 0, 0.18, 1.57, 0.035, -0.035]})
    # The jaws and retraction finish at frame 2, but the remaining arm motion continues until frame 3.
    metadata["timeline"][2]["phase"] = "release"
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    assert validate(released_export)["passed"]
    metadata["timeline"][2]["phase"] = "drop"
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match="Wrong release phase"):
        validate(released_export)


@pytest.mark.parametrize("include_unhook", (False, True))
def test_export_records_optional_release_stages_without_requiring_sweep_constants(released_export, include_unhook):
    targets = (-0.5, 1.1, -1.2, 0, 0.18, 1.57, 0.035, -0.035)
    source = SimpleNamespace(RELEASE_START=1 / 60, RELEASE_DURATION=1 / 60, RELEASE_OPENING=.035,
                             RETRACT_DELAY=0, RETRACT_DURATION=1 / 60, PIPER_RETRACT_Q=targets,
                             GRIP_POINT_LOCAL=(0, 0, .105), TOSS_START=0, TOSS_DURATION=1 / 60,
                             PIPER_TOSS_Q=targets, LOWER_START=0, LOWER_DURATION=1 / 60, PIPER_LOWER_Q=targets,
                             CLEAR_START=2 / 60, CLEAR_DURATION=1 / 60, PIPER_CLEAR_Q=targets,
                             APPLE_FRICTION=.2, FLOOR_FRICTION=.3, GRIPPER_FRICTION=1.2, FLOOR_ROLLING_FRICTION=.03,
                             CLOTH_CONTACT_FRICTION=.6, PIPER_FINGER_KP=6000., PIPER_FINGER_KD=20.,
                             FLOOR_CONTACT_STIFFNESS=3e3, FLOOR_CONTACT_DAMPING=3., FLOOR_TORSIONAL_FRICTION=.005)
    if include_unhook:
        source.UNHOOK_START = 3 / 60
        source.UNHOOK_DURATION = 1 / 60
        source.PIPER_UNHOOK_Q = targets
    motion, end = release_motion_metadata(source)
    assert end == (4 if include_unhook else 3) / 60
    if include_unhook:
        assert motion["unhook_start_seconds"] == source.UNHOOK_START
        assert motion["unhook_duration_seconds"] == source.UNHOOK_DURATION
        assert motion["unhook_joint_targets"] == list(targets)
    else:
        assert "unhook_start_seconds" not in motion
    assert "release_sweep_start_seconds" not in motion
    assert motion["grip_point_local"] == [0, 0, .105]
    assert motion["apple_friction"] == .2 and motion["floor_friction"] == .3 and motion["gripper_friction"] == 1.2
    assert motion["floor_rolling_friction"] == .03
    assert motion["floor_contact_stiffness"] == 3e3 and motion["floor_contact_damping"] == 3.
    assert motion["floor_torsional_friction"] == .005
    assert motion["cloth_contact_friction"] == .6 and motion["finger_kp"] == 6000. and motion["finger_kd"] == 20.
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    metadata["simulation"].update(motion)
    metadata["timeline"][2]["phase"] = "release"
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    assert validate(released_export)["passed"]
    metadata["simulation"]["toss_duration_seconds"] = 2 / 60
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match="Toss must finish before release"):
        validate(released_export)


@pytest.mark.parametrize("damage, message", (
    ("before_release", "Unhooking must start after release"),
    ("before_clear_end", "Unhooking must start after clearing finishes"),
    ("incomplete", "Incomplete unhook parameters"),
))
def test_validation_rejects_invalid_unhook_sequence(released_export, damage, message):
    metadata = json.loads(released_export.read_text(encoding="utf-8"))
    simulation = metadata["simulation"]
    targets = [-0.5, 1.1, -1.2, 0, 0.18, 1.57, 0.035, -0.035]
    simulation.update(clear_start_seconds=1 / 60, clear_duration_seconds=1 / 60, clear_joint_targets=targets,
                      unhook_start_seconds=2 / 60, unhook_duration_seconds=1 / 60, unhook_joint_targets=targets)
    metadata["timeline"][2]["phase"] = "release"
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    assert validate(released_export)["passed"]
    if damage == "before_release":
        simulation["unhook_start_seconds"] = 0.0
    elif damage == "before_clear_end":
        simulation["unhook_start_seconds"] = 1.5 / 60
    else:
        del simulation["unhook_duration_seconds"]
    released_export.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        validate(released_export)


@pytest.mark.parametrize("damage", ("texture", "usd", "physics", "middle_sample", "topology", "source", "film_uv",
                                     "platform_dimensions", "platform_pose", "missing_platform"))
def test_validation_rejects_incomplete_or_changed_exports(exported, damage):
    path, exporter, _ = exported
    meta = json.loads(path.read_text(encoding="utf-8"))
    if damage == "texture":
        target = next(iter(meta["texture_sha256"]))
        (path.parent / target).write_bytes(b"changed")
    elif damage == "usd":
        # USD holds a memory-mapped crate on Windows; edit through USD rather than truncating an open file.
        exporter.stage.SetMetadata("comment", "Modified after export")
        exporter.stage.GetRootLayer().Save()
    elif damage == "physics":
        meta["validation"]["example_assertion_errors"] = [{"frame": 1, "error": "grip lost"}]
    elif damage == "source":
        meta["source_sha256"] = {"demos/piper_bag_transport/demo_piper_bag_transport.py": "stale"}
    elif damage.startswith("platform_") or damage == "missing_platform":
        mesh = UsdGeom.Mesh(exporter.stage.GetPrimAtPath("/World/Environment/bag_platform"))
        if damage == "platform_dimensions":
            mesh.GetPointsAttr().Set(np.asarray(mesh.GetPointsAttr().Get()) * 2)
        elif damage == "platform_pose":
            mesh.GetPrim().GetAttribute("xformOp:translate").Set((0, 0, 0))
        else:
            exporter.stage.RemovePrim(mesh.GetPath())
            meta["meshes"] = [entry for entry in meta["meshes"] if entry["kind"] != "environment"
                              or entry["path"].endswith("/scene_floor")]
        exporter.stage.GetRootLayer().Save()
        meta["file_sha256"][exporter.path.name] = sha256(exporter.path)
    else:
        mesh = exporter.bag
        if damage == "middle_sample":
            mesh.GetPointsAttr().ClearAtTime(1)
        elif damage == "film_uv":
            uv = UsdGeom.PrimvarsAPI(mesh).GetPrimvar("film_pattern_m")
            uv.Set(np.asarray(uv.Get()) * 2.0)
        else:
            mesh.GetFaceVertexIndicesAttr().Set([0, 2, 1])
        exporter.stage.GetRootLayer().Save()
        meta["file_sha256"][exporter.path.name] = sha256(exporter.path)
    path.write_text(json.dumps(meta), encoding="utf-8")
    with pytest.raises(ValueError):
        validate(path)


def save_telemetry_fixture(path, rows, sidecar):
    metadata = json.loads(path.read_text(encoding="utf-8"))
    csv_path = path.parent / "motor_telemetry.csv"
    json_path = csv_path.with_suffix(".json")
    with csv_path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    json_path.write_text(json.dumps(sidecar), encoding="utf-8")
    metadata["files"].update(motor_telemetry=csv_path.name, motor_telemetry_metadata=json_path.name)
    metadata["file_sha256"].update({item.name: sha256(item) for item in (csv_path, json_path)})
    metadata["physics_parameters"] = {"substeps": 4}
    metadata["simulation"]["substep_seconds"] = 1 / 240
    path.write_text(json.dumps(metadata), encoding="utf-8")


@pytest.fixture
def telemetry_export(exported):
    path, _, _ = exported
    joints = [{"name": f"joint{index}", "type": "revolute" if index <= 6 else "prismatic",
               "position_unit": "rad" if index <= 6 else "m", "effort_unit": "Nm" if index <= 6 else "N"}
              for index in range(1, 9)]
    rows = []
    for frame in range(3):
        for index, joint in enumerate(joints):
            rows.append({"frame": frame, "time_s": frame / 60, "joint_name": joint["name"],
                         "joint_type": joint["type"], "position_unit": joint["position_unit"],
                         "effort_unit": joint["effort_unit"], "target_time_s": max(0, frame / 60 - 1 / 240),
                         "target_position": index / 10, "target_velocity": 0, "feedforward_effort": 0,
                         "feedback_effort": 2 if frame else "", "feedback_effort_mean": 1 if frame else "",
                         "feedback_effort_min": -1 if frame else "", "feedback_effort_max": 3 if frame else "",
                         "feedback_valid": int(frame > 0)})
    sidecar = {"schema_version": 1, "csv": "motor_telemetry.csv", "fps": 60, "complete": True,
               "physics_substeps_per_frame": 4, "frame_count": 3, "rows_per_frame": 8, "joints": joints}
    save_telemetry_fixture(path, rows, sidecar)
    return path, rows, sidecar


def test_validation_checks_every_motor_sample_against_export_timing(telemetry_export):
    path, _, _ = telemetry_export
    report = validate(path)
    assert report["passed"] and report["telemetry_rows"] == 24 and report["telemetry_frames"] == 3


@pytest.mark.parametrize("row_index, field, value, message", (
    (8, "frame", 3, "Unexpected motor telemetry frame or joint"),
    (8, "frame", "1.5", "Invalid motor telemetry frame index"),
    (8, "time_s", 2 / 60, "Wrong motor telemetry sample time"),
    (8, "time_s", "nan", "Nonfinite motor telemetry time_s"),
    (8, "target_time_s", "nan", "Nonfinite motor telemetry target_time_s"),
    (8, "target_position", "inf", "Nonfinite motor telemetry target_position"),
    (8, "target_velocity", "-inf", "Nonfinite motor telemetry target_velocity"),
    (8, "feedforward_effort", "nan", "Nonfinite motor telemetry feedforward_effort"),
    (8, "joint_name", "joint9", "Unexpected motor telemetry frame or joint"),
    (8, "joint_name", "joint2", "Duplicate motor telemetry frame/joint sample"),
    (8, "joint_type", "prismatic", "Wrong motor telemetry CSV units"),
    (8, "effort_unit", "N", "Wrong motor telemetry CSV units"),
    (0, "feedback_effort", 0, "Initial motor telemetry feedback must be unavailable"),
    (0, "feedback_valid", 1, "Initial motor telemetry feedback must be unavailable"),
    (8, "feedback_valid", 0, "Missing valid motor telemetry feedback"),
    (8, "feedback_effort", "", "Invalid motor telemetry feedback"),
    (8, "feedback_effort", "nan", "Nonfinite motor telemetry feedback"),
    (8, "feedback_effort", 4, "outside substep extrema"),
    (8, "feedback_effort_mean", -2, "outside substep extrema"),
    (8, "feedback_effort_min", 4, "outside substep extrema"),
    (8, "feedback_effort_max", 0, "outside substep extrema"),
))
def test_validation_rejects_invalid_recorded_motor_samples(telemetry_export, row_index, field, value, message):
    path, rows, sidecar = telemetry_export
    rows[row_index][field] = value
    # Refresh hashes so these regressions test the independent data checks rather than hash rejection.
    save_telemetry_fixture(path, rows, sidecar)
    with pytest.raises(ValueError, match=message):
        validate(path)


@pytest.mark.parametrize("field, value, message", (
    ("schema_version", 2, "Wrong motor telemetry schema"),
    ("csv", "another.csv", "Wrong motor telemetry schema"),
    ("complete", False, "recording is incomplete"),
    ("fps", 30, "sample counts or frame rate disagree"),
    ("frame_count", 2, "sample counts or frame rate disagree"),
    ("rows_per_frame", 7, "sample counts or frame rate disagree"),
    ("physics_substeps_per_frame", 8, "substep count disagrees"),
))
def test_validation_rejects_inconsistent_motor_sidecar(telemetry_export, field, value, message):
    path, rows, sidecar = telemetry_export
    sidecar[field] = value
    save_telemetry_fixture(path, rows, sidecar)
    with pytest.raises(ValueError, match=message):
        validate(path)


@pytest.mark.parametrize("damage, message", (
    ("missing_row", "Wrong motor telemetry row count"),
    ("extra_row", "Wrong motor telemetry row count"),
    ("missing_column", "Wrong motor telemetry CSV columns"),
    ("missing_channel", "Wrong motor telemetry channel manifest"),
    ("channel_units", "Wrong motor telemetry channel units"),
    ("substep_duration", "substep duration disagrees"),
    ("missing_sidecar", "Missing motor telemetry metadata"),
    ("changed_csv", "File changed since export"),
))
def test_validation_rejects_incomplete_motor_exports(telemetry_export, damage, message):
    path, rows, sidecar = telemetry_export
    if damage == "missing_row":
        rows.pop()
    elif damage == "extra_row":
        rows.append(dict(rows[-1]))
    elif damage == "missing_column":
        for row in rows:
            row.pop("target_time_s")
    elif damage == "missing_channel":
        sidecar["joints"].pop()
    elif damage == "channel_units":
        sidecar["joints"][0]["effort_unit"] = "N"
    save_telemetry_fixture(path, rows, sidecar)
    metadata = json.loads(path.read_text(encoding="utf-8"))
    if damage == "substep_duration":
        metadata["simulation"]["substep_seconds"] = 1 / 120
    elif damage == "missing_sidecar":
        metadata["files"].pop("motor_telemetry_metadata")
    elif damage == "changed_csv":
        with (path.parent / "motor_telemetry.csv").open("a", encoding="utf-8") as output:
            output.write("corrupt\n")
    path.write_text(json.dumps(metadata), encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        validate(path)


def workflow_args(tmp_path, **overrides):
    config = tmp_path / "render_config.json"
    config.write_text(json.dumps({"usd": "outputs/simulation.usdc", "project": "outputs/piper_bag_transport.blend",
                                  "frame_start": 0, "frame_end": None, "video_fps": 60}), encoding="utf-8")
    defaults = dict(config=config, output_dir=None, steps=["all"], num_frames=12, blender=Path("blender"),
                    physics_args=[], draft=False, overwrite=False, device=None)
    return SimpleNamespace(**(defaults | overrides))


def test_workflow_all_uses_matching_ranges_and_overwrites_stale_frames(tmp_path):
    result = commands(workflow_args(tmp_path, physics_args=["--substeps", "8"]))
    assert tuple(step for step, _ in result) == ALL_STEPS
    assert ALL_STEPS.index("validate") < ALL_STEPS.index("telemetry") < ALL_STEPS.index("build")
    assert ALL_STEPS[-1] == "verify"
    plan = dict(result)
    assert plan["export"][-2:] == ["--substeps", "8"]
    assert plan["encode"][plan["encode"].index("--end") + 1] == "12"
    assert plan["encode"][plan["encode"].index("--crf") + 1] == "16"
    assert "--overwrite" in plan["render"]
    assert "--preview" not in plan["render"]


def test_workflow_telemetry_uses_relocated_csv_without_blender_or_export_metadata(tmp_path, monkeypatch):
    root = tmp_path / "telemetry_only"
    args = workflow_args(tmp_path, steps=["telemetry"], output_dir=root, blender=None, num_frames=None)

    def unexpected_blender_lookup(_):
        pytest.fail("Motor telemetry plotting must not require Blender")

    monkeypatch.setattr(workflow, "find_blender", unexpected_blender_lookup)
    result = commands(args)
    assert len(result) == 1 and result[0][0] == "telemetry"
    command = result[0][1]
    assert command[2:] == [str(workflow.DIRECTORY / "plot_motor_telemetry.py"),
                           "--csv", str(root / "motor_telemetry.csv"), "--output-dir", str(root), "--fps", "60"]
    assert not root.exists()


@pytest.mark.parametrize("draft", (False, True))
def test_workflow_verifies_the_video_encoded_in_the_same_output_directory(tmp_path, monkeypatch, draft):
    root = tmp_path / "relocated_run"
    args = workflow_args(tmp_path, steps=["encode", "verify"], output_dir=root, blender=None, draft=draft)

    def unexpected_blender_lookup(_):
        pytest.fail("Encoding and common-run verification must not require Blender")

    monkeypatch.setattr(workflow, "find_blender", unexpected_blender_lookup)
    plan = dict(commands(args))
    video = "piper_bag_transport_preview.mp4" if draft else "piper_bag_transport.mp4"
    assert plan["encode"][plan["encode"].index("--output") + 1] == video
    assert plan["encode"][plan["encode"].index("--output-dir") + 1] == str(root)
    assert plan["verify"][2:] == [str(workflow.DIRECTORY / "verify_run.py"),
                                  "--output-dir", str(root), "--scene-video", video]


def test_workflow_draft_resume_reads_existing_export_and_keeps_final_frames(tmp_path):
    root = tmp_path / "relocated"
    root.mkdir()
    (root / "simulation_metadata.json").write_text('{"simulation": {"frames": 600}}', encoding="utf-8")
    args = workflow_args(tmp_path, steps=["render", "encode"], output_dir=root, draft=True)
    plan = dict(commands(args))
    assert "--overwrite" not in plan["render"]
    assert str(root / "draft_frames") in plan["render"]
    assert "piper_bag_transport_preview.mp4" in plan["encode"]
    assert plan["encode"][plan["encode"].index("--end") + 1] == "600"


def test_workflow_rejects_frame_range_outside_cache(tmp_path):
    args = workflow_args(tmp_path)
    cfg = json.loads(args.config.read_text(encoding="utf-8"))
    cfg["frame_end"] = 600
    args.config.write_text(json.dumps(cfg), encoding="utf-8")
    with pytest.raises(ValueError, match="outside"):
        commands(args)


def test_workflow_default_export_uses_demo_duration_without_loading_demo(tmp_path):
    args = workflow_args(tmp_path, steps=["export"], num_frames=None)
    command = dict(commands(args))["export"]
    assert "--num-frames" not in command


def test_workflow_reads_new_export_duration_before_later_steps(tmp_path, monkeypatch):
    args = workflow_args(tmp_path)
    root = tmp_path / "generated"
    root.mkdir()
    metadata = root / "simulation_metadata.json"
    metadata.write_text('{"simulation": {"frames": 720}}', encoding="utf-8")
    executed = []

    def run(command, check):
        assert check
        executed.append(command)
        if str(workflow.DIRECTORY / "export_simulation.py") in command:
            assert "--num-frames" not in command
            metadata.write_text('{"simulation": {"frames": 2400}}', encoding="utf-8")

    monkeypatch.setattr(workflow.subprocess, "run", run)
    monkeypatch.setattr(workflow.sys, "argv", ["workflow.py", "--steps", "export", "render", "encode",
                                               "--config", str(args.config), "--output-dir", str(root),
                                               "--blender", "blender"])
    workflow.main()
    assert len(executed) == 3 and "--overwrite" in executed[1]
    assert executed[2][executed[2].index("--end") + 1] == "2400"
