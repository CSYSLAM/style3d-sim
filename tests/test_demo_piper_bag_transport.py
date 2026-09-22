"""Geometry and physical-motion regressions for the gusseted food bag demo."""

from types import SimpleNamespace

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
pytest.importorskip("pxr")

from demos.piper_bag_transport import demo_piper_bag_transport as demo
from demos.piper_bag_transport.piper_motion import PiperKinematics
from demos.piper_bag_transport.validate_simulation import point_triangle_distances


@pytest.fixture(autouse=True, scope="module")
def workspace_warp_cache():
    wp.config.kernel_cache_dir = str(demo.REPO_ROOT / "build" / "warp-cloth-apples")


@pytest.fixture(scope="module")
def bag():
    return demo.create_bag_mesh()


def test_developed_gusset_panels_have_welded_four_ply_heat_seals(bag):
    points, triangles, panels, panel_triangles = bag
    assert len(points) == 6007
    assert len(triangles) == 12000
    assert len(np.unique(triangles)) == len(points)
    assert len(np.unique(np.sort(triangles, axis=1), axis=0)) == len(triangles)
    directed = triangles[:, ((0, 1), (1, 2), (2, 0))].reshape(-1, 2)
    edges, inverse, counts = np.unique(np.sort(directed, axis=1), axis=0, return_inverse=True, return_counts=True)
    assert set(counts) == {1, 2, 4}
    assert np.count_nonzero(counts == 4) == 40
    winding = np.bincount(inverse, weights=np.where(directed[:, 0] < directed[:, 1], 1, -1))
    np.testing.assert_array_equal(winding[counts == 2], 0)
    seals = points[edges[counts == 4]]
    # The layered joins are the bottom and handle heat seals, not arbitrary interior mesh branches.
    assert np.all((seals[..., 2].mean(axis=1) < 0.065) | (seals[..., 2].mean(axis=1) > 0.28))
    assert len(panels) > len(points)
    developed = panels[panel_triangles]
    u, v = developed[:, 1] - developed[:, 0], developed[:, 2] - developed[:, 0]
    signed_area = u[:, 0] * v[:, 1] - u[:, 1] * v[:, 0]
    assert np.all(signed_area > 0)
    posed = points[triangles]
    areas = np.linalg.norm(np.cross(posed[:, 1] - posed[:, 0], posed[:, 2] - posed[:, 0]), axis=1)
    assert areas.min() > 1.0e-6
    # The opened pose must not inject the large membrane prestretch of a linearly expanded tube.
    for a, b in ((0, 1), (1, 2), (2, 0)):
        ratio = np.linalg.norm(posed[:, a] - posed[:, b], axis=1) / np.linalg.norm(developed[:, a] - developed[:, b], axis=1)
        assert np.max(np.abs(ratio - 1)) < 0.04
    platform_top = demo.PLATFORM_CENTER[2] + demo.PLATFORM_SIZE[2] / 2
    assert points[:, 2].min() - demo.PARTICLE_RADIUS >= platform_top
    # A sealed flat tube has a narrow bottom crease rather than a separately sewn rectangular floor.
    bottom = points[points[:, 2] < points[:, 2].min() + 0.002]
    assert np.ptp(bottom[:, 0]) < 0.006


@pytest.fixture
def apple_meshes(monkeypatch):
    # Verify the real source hull without rebaking its GPU SDF in CPU geometry tests.
    monkeypatch.setattr(newton.Mesh, "build_sdf", lambda *args, **kwargs: None)
    return demo.load_apple_meshes()


def test_original_apple_visual_is_inside_the_complete_collision_hull(apple_meshes):
    from scipy.spatial import ConvexHull

    visual, collision, _ = apple_meshes
    planes = ConvexHull(np.asarray(collision.vertices, dtype=np.float64)).equations
    maximum = -np.inf
    for start in range(0, len(visual.vertices), 256):
        vertices = np.asarray(visual.vertices[start:start + 256], dtype=np.float64)
        maximum = max(maximum, float((vertices @ planes[:, :3].T + planes[:, 3]).max()))
    assert maximum * demo.APPLE_SCALE < 1.0e-6
    assert visual.uvs is not None and visual.normals is not None
    assert demo.APPLE_SCALE == 0.58


def test_five_nonoverlapping_apples_are_staggered_above_the_open_mouth(bag, apple_meshes):
    _, collision, center = apple_meshes
    hull = (collision.vertices - center) * demo.APPLE_SCALE
    half_extents = np.ptp(hull, axis=0) * 0.5
    positions = demo.apple_positions(half_extents)
    assert positions.shape == (5, 3) and demo.APPLE_COUNT == 5
    inflated = half_extents + demo.APPLE_COLLISION_MARGIN
    assert np.ptp(positions[:, 0]) > 0.02 and np.ptp(positions[:, 1]) > 0.03
    # Horizontal staggering must not change the original release heights or vertical separation.
    initial_height = (demo.BAG_BOTTOM + demo.BAG_CELLS[2] * demo.CELL_SIZE + half_extents[2]
                      + demo.APPLE_COLLISION_MARGIN + demo.PARTICLE_RADIUS + 0.010)
    height_step = 2 * (half_extents[2] + demo.APPLE_COLLISION_MARGIN) + 0.008
    np.testing.assert_allclose(positions[:, 2], initial_height + np.arange(5) * height_step, atol=1e-7)
    # Three non-collinear dimensions distinguish a staggered release from a tilted straight column.
    assert np.linalg.matrix_rank(positions - positions.mean(axis=0), tol=1.0e-4) == 3
    for i in range(5):
        for j in range(i):
            assert np.any(np.abs(positions[i] - positions[j]) > 2 * inflated)
    assert np.all(np.abs(positions[:, :2] - demo.BAG_CENTER) + inflated[:2] < (0.046, 0.10))
    assert np.all(positions[:, 2] - inflated[2] > demo.BAG_BOTTOM + demo.BAG_CELLS[2] * demo.CELL_SIZE)
    radius = np.linalg.norm(hull, axis=1).max()
    for point in positions:
        distance = point_triangle_distances(point, bag[0][bag[1]]).min()
        assert distance > radius + demo.APPLE_COLLISION_MARGIN + demo.PARTICLE_RADIUS


def test_fixed_solver_defaults_and_invalid_overrides():
    args = demo.Example.create_parser().parse_args([])
    assert (args.substeps, args.iterations, args.linear_iterations) == (4, 4, 80)
    assert args.num_frames == demo.DEFAULT_NUM_FRAMES
    for flag, value in (("--substeps", "0"), ("--substeps", "3"), ("--iterations", "0"), ("--linear-iterations", "0")):
        with pytest.raises(ValueError):
            demo.Example(None, demo.Example.create_parser().parse_args([flag, value]))


def test_motor_plan_lifts_swings_in_separate_stages_and_places_before_release(bag):
    times, poses = demo.create_motion_plan()
    assert poses.shape == (len(times), 8)
    assert np.all(np.diff(times) > 0)
    assert times[0] == 0 and times[-1] == demo.DURATION_SECONDS
    arm = PiperKinematics(demo.PIPER_ASSET, demo.PIPER_BASE)
    crown = bag[0][demo.bag_grip_vertices(bag[0])].mean(axis=0)
    waiting = arm.fk(poses[0], demo.GRIP_POINT_LOCAL)[:3, 3]
    np.testing.assert_allclose(waiting, crown, atol=2.0e-4)
    np.testing.assert_allclose(poses[0], poses[1])
    assert poses[0, 6] > 0.0
    assert demo.GRASP_START >= demo.APPLE_LOADING_END
    for time in (demo.LIFT_START, demo.SWING_END, demo.RELEASE_START):
        row = poses[np.argmin(abs(times - time))]
        np.testing.assert_allclose(row[6:], 0.0, atol=1.0e-7)
    assert not demo.AIRBORNE_RELEASE
    assert demo.HORIZONTAL_END + 0.5 == demo.VERTICAL_START
    assert demo.VERTICAL_END == demo.PLACE_START
    assert demo.RELEASE_START == demo.PLACE_START + demo.PLACE_DURATION + demo.PLACE_SETTLE_DURATION
    release_begin = poses[np.argmin(abs(times - demo.RELEASE_START))]
    np.testing.assert_allclose(arm.fk(release_begin, demo.GRIP_POINT_LOCAL)[:3, 3], demo.PLACE_GRIP_POINT, atol=2e-4)
    np.testing.assert_allclose(poses[-1, 6:], (demo.RELEASE_OPENING, -demo.RELEASE_OPENING))
    released = arm.fk(poses[np.argmin(abs(times - demo.RELEASE_START - demo.RELEASE_DURATION))],
                      demo.GRIP_POINT_LOCAL)
    withdrawn = arm.fk(poses[-1], demo.GRIP_POINT_LOCAL)
    np.testing.assert_allclose(withdrawn[:3, 3] - released[:3, 3], demo.RETRACT_OFFSET, atol=5e-4)
    for q in poses:
        assert np.all(q >= arm.limits[:, 0] - 1.0e-7)
        assert np.all(q <= arm.limits[:, 1] + 1.0e-7)


def test_motor_targets_coordinate_horizontal_joints_before_straight_vertical_jolts():
    from scipy.signal import find_peaks

    times, poses = demo.create_motion_plan()
    sample_times = np.arange(round((demo.SWING_END - demo.SWING_START) * 240) + 1) / 240 + demo.SWING_START
    with wp.ScopedDevice("cpu"):
        indices_np = np.arange(8, dtype=np.int32) * 2 + 1
        indices = wp.array(indices_np, dtype=wp.int32)
        waypoint_times = wp.array(times, dtype=wp.float32)
        waypoint_q = wp.array(poses, dtype=wp.float32)
        samples = []
        for t in sample_times:
            time = wp.array([t], dtype=wp.float32)
            targets = wp.full(20, 123.0, dtype=wp.float32)
            wp.launch(demo.drive_piper, dim=1, inputs=[time, 0.01, indices, waypoint_times, waypoint_q], outputs=[targets])
            actual = targets.numpy()
            np.testing.assert_array_equal(actual[np.setdiff1d(np.arange(20), indices_np)], 123.0)
            np.testing.assert_allclose(time.numpy(), t + 0.01, atol=2.0e-6)
            samples.append(actual[indices_np])
        samples = np.array(samples)
        assert np.ptp(samples[:, 0]) > 0.8
        np.testing.assert_allclose(samples[:, 6:], 0.0, atol=1.0e-7)
    arm = PiperKinematics(demo.PIPER_ASSET, demo.PIPER_BASE)
    assert np.all(samples >= arm.limits[:, 0] - 1e-6)
    assert np.all(samples <= arm.limits[:, 1] + 1e-6)
    points = np.array([arm.fk(q, demo.GRIP_POINT_LOCAL)[:3, 3] for q in samples])
    horizontal = (sample_times >= demo.HORIZONTAL_START) & (sample_times <= demo.HORIZONTAL_END)
    vertical = (sample_times >= demo.VERTICAL_START) & (sample_times <= demo.VERTICAL_END)
    stationary = (sample_times >= demo.HORIZONTAL_END) & (sample_times <= demo.VERTICAL_START)
    # FK verifies the Cartesian paths, including intermediate poses between authored IK samples.
    assert 0.008 < np.ptp(points[horizontal, 2]) < 0.010
    assert np.ptp(points[horizontal, 0]) > 0.35
    assert 0.011 < np.ptp(points[horizontal, 1]) < 0.013
    # Shoulder, elbow, and all wrist axes participate rather than carrying a rigid arm on the base joint alone.
    assert np.all(np.ptp(samples[horizontal, :6], axis=0) > (0.75, 0.14, 0.28, 0.18, 0.25, 0.18))
    extension = np.array([arm.fk(q, demo.GRIP_POINT_LOCAL)[:3, 2] for q in samples[horizontal]])
    pitch_degrees = np.rad2deg(np.arcsin(extension[:, 2]))
    assert 7.9 < np.ptp(pitch_degrees) < 8.1
    # Smooth entry and exit attenuate the outer lobes without removing a complete cycle.
    assert len(find_peaks(samples[horizontal, 0], prominence=0.15)[0]) == demo.HORIZONTAL_CYCLES
    assert len(find_peaks(-samples[horizontal, 0], prominence=0.15)[0]) == demo.HORIZONTAL_CYCLES
    assert np.max(np.ptp(points[vertical, :2], axis=0)) < 0.001
    assert 0.279 < np.ptp(points[vertical, 2]) < 0.281
    assert points[vertical, 2].min() > 0.349
    assert points[vertical, 2].max() < 0.631
    vertical_extension = np.array([arm.fk(q, demo.GRIP_POINT_LOCAL)[:3, 2] for q in samples[vertical]])
    vertical_pitch = np.rad2deg(np.arcsin(vertical_extension[:, 2]))
    assert 38.0 < np.ptp(vertical_pitch) < 41.0
    # Natural world pitch comes from shoulder/elbow motion while both terminal joint commands remain fixed.
    np.testing.assert_allclose(np.ptp(samples[vertical][:, demo.VERTICAL_FIXED_JOINTS], axis=0), 0.0, atol=1e-7)
    assert np.all(np.ptp(samples[vertical][:, demo.VERTICAL_ACTIVE_JOINTS], axis=0) > 0.2)
    assert len(find_peaks(points[vertical, 2], prominence=0.05)[0]) == demo.VERTICAL_CYCLES
    assert len(find_peaks(-points[vertical, 2], prominence=0.05)[0]) == demo.VERTICAL_CYCLES
    assert np.max(np.ptp(points[stationary], axis=0)) < 1e-5
    sample_dt = sample_times[1] - sample_times[0]
    vertical_acceleration = np.gradient(np.gradient(points[:, 2], sample_dt), sample_dt)
    for cycle in range(demo.VERTICAL_CYCLES):
        start = demo.VERTICAL_START + cycle * demo.VERTICAL_PERIOD
        falling = ((sample_times >= start + demo.VERTICAL_RISE_DURATION)
                   & (sample_times <= start + demo.VERTICAL_RISE_DURATION + demo.VERTICAL_DROP_DURATION))
        # Faster-than-gravity handle motion is the cause of unloading; large displacement alone is insufficient.
        assert vertical_acceleration[falling].min() < -25.0
        assert np.count_nonzero(vertical_acceleration[falling] < -9.81) * sample_dt >= 0.075
    for mask in (horizontal, vertical):
        for endpoint in (points[mask][:2], points[mask][-2:]):
            assert np.linalg.norm(endpoint[1] - endpoint[0]) / sample_dt < 0.02


def test_handle_feedback_updates_motor_waypoints_without_changing_cloth(bag):
    points = bag[0].copy()
    times, poses = demo.create_motion_plan()
    points[:, :2] += (0.002, 0.003)
    points[:, 2] -= 0.008
    with wp.ScopedDevice("cpu"):
        example = object.__new__(demo.Example)
        example.bag_particle_count = len(points)
        example.grip_vertices = demo.bag_grip_vertices(bag[0])
        example.state_0 = SimpleNamespace(particle_q=wp.array(points, dtype=wp.vec3))
        example.plan_times, example.plan_q = times, poses.copy()
        example.waypoint_q = wp.array(poses, dtype=wp.float32)
        before = example.state_0.particle_q.numpy().copy()
        example.update_handle_approach(refine_grasp=True)
        np.testing.assert_array_equal(example.state_0.particle_q.numpy(), before)
        changed = np.flatnonzero(np.any(poses != example.plan_q, axis=1))
        np.testing.assert_allclose(times[changed], [demo.GRASP_START, demo.GRASP_START + demo.GRASP_DURATION, demo.LIFT_START])
        arm = PiperKinematics(demo.PIPER_ASSET, demo.PIPER_BASE)
        crown = points[example.grip_vertices].mean(axis=0)
        for row in changed:
            np.testing.assert_allclose(arm.fk(example.plan_q[row], demo.GRIP_POINT_LOCAL)[:3, 3], crown, atol=2.0e-4)


def test_fingers_remain_closed_while_lowering_then_open_at_the_platform():
    times, poses = demo.create_motion_plan()
    arm = PiperKinematics(demo.PIPER_ASSET, demo.PIPER_BASE)
    with wp.ScopedDevice("cpu"):
        indices = wp.array(np.arange(8), dtype=wp.int32)
        waypoint_times, waypoint_q = wp.array(times, dtype=wp.float32), wp.array(poses, dtype=wp.float32)
        targets = []
        for time in (demo.PLACE_START + demo.PLACE_DURATION, demo.RELEASE_START - 0.01,
                     demo.RELEASE_START + demo.RELEASE_DURATION + 0.01):
            result = wp.zeros(8)
            wp.launch(demo.drive_piper, dim=1,
                      inputs=[wp.array([time], dtype=wp.float32), 0.01, indices, waypoint_times, waypoint_q],
                      outputs=[result])
            targets.append(result.numpy())
    np.testing.assert_allclose(targets[0][6:], 0.0)
    np.testing.assert_allclose(targets[1][6:], 0.0)
    np.testing.assert_allclose(targets[2][6:], (demo.RELEASE_OPENING, -demo.RELEASE_OPENING), atol=1e-6)
    points = np.array([arm.fk(q, demo.GRIP_POINT_LOCAL)[:3, 3] for q in targets])
    np.testing.assert_allclose(points, np.tile(demo.PLACE_GRIP_POINT, (3, 1)), atol=2e-4)


def test_open_jaws_extract_along_fingers_before_lowering_and_withdrawing():
    times, poses = demo.create_motion_plan()
    arm = PiperKinematics(demo.PIPER_ASSET, demo.PIPER_BASE)
    start = demo.RELEASE_START + demo.RETRACT_DELAY
    center_end = start + demo.RETRACT_CENTER_DURATION
    unhook_end = center_end + demo.RETRACT_UNHOOK_DURATION
    sample_times = np.linspace(start, demo.RETRACT_END, round(demo.RETRACT_DURATION * 240) + 1)
    with wp.ScopedDevice("cpu"):
        indices = wp.array(np.arange(8), dtype=wp.int32)
        waypoint_times, waypoint_q = wp.array(times, dtype=wp.float32), wp.array(poses, dtype=wp.float32)
        samples = []
        for time in sample_times:
            target = wp.zeros(8)
            wp.launch(demo.drive_piper, dim=1,
                      inputs=[wp.array([time], dtype=wp.float32), 0.01, indices, waypoint_times, waypoint_q],
                      outputs=[target])
            samples.append(target.numpy().copy())
    samples = np.asarray(samples)
    np.testing.assert_allclose(samples[:, 6], demo.RELEASE_OPENING, atol=1e-7)
    np.testing.assert_allclose(samples[:, 7], -demo.RELEASE_OPENING, atol=1e-7)
    assert np.all(samples >= arm.limits[:, 0] - 1e-6)
    assert np.all(samples <= arm.limits[:, 1] + 1e-6)
    points = np.array([arm.fk(q, demo.GRIP_POINT_LOCAL)[:3, 3] for q in samples])
    origin = np.asarray(demo.PLACE_GRIP_POINT)
    np.testing.assert_allclose(points[np.argmin(abs(sample_times - center_end))],
                               origin + demo.RETRACT_CENTER_OFFSET, atol=2e-4)
    np.testing.assert_allclose(points[np.argmin(abs(sample_times - unhook_end))],
                               origin + demo.RETRACT_UNHOOK_OFFSET, atol=2e-4)
    np.testing.assert_allclose(points[-1], origin + demo.RETRACT_OFFSET, atol=2e-4)
    assert points[:, 2].max() <= origin[2] + demo.RETRACT_UNHOOK_OFFSET[2] + 1e-4
    center_points = points[sample_times <= center_end]
    np.testing.assert_allclose(center_points[:, 1:], np.tile(origin[1:], (len(center_points), 1)), atol=2e-4)
    assert np.min(np.diff(center_points[:, 0])) > -1e-5
    np.testing.assert_allclose(points[sample_times >= center_end, 0],
                               origin[0] + demo.RETRACT_CENTER_OFFSET[0], atol=2e-4)
    assert np.max(np.diff(points[:, 1])) < 1e-5
    extract = (sample_times >= center_end) & (sample_times <= unhook_end)
    assert np.min(np.diff(points[extract, 2])) > -1e-5
    extension = arm.fk(samples[0], demo.GRIP_POINT_LOCAL)[:3, 2]
    extraction = np.asarray(demo.RETRACT_UNHOOK_OFFSET) - demo.RETRACT_CENTER_OFFSET
    # The earlier downward path stayed at constant finger depth and could carry a folded handle on the shoulder.
    assert np.dot(extraction, extension) < -0.11
    assert np.max(np.diff(points[sample_times >= unhook_end, 2])) < 1e-5


def test_finger_gain_ramp_preserves_existing_motor_parameters():
    with wp.ScopedDevice("cpu"):
        indices = wp.array([6, 7], dtype=wp.int32)
        for t, blend in ((0.0, 0.0), (demo.APPLE_LOADING_END, 0.0),
                         (demo.APPLE_LOADING_END + demo.PIPER_BAG_GAIN_RAMP / 2, 0.5),
                         (demo.APPLE_LOADING_END + demo.PIPER_BAG_GAIN_RAMP, 1.0)):
            ke, kd = wp.full(8, demo.PIPER_ARM_KP), wp.full(8, demo.PIPER_ARM_KD)
            wp.launch(demo.drive_finger_gains, dim=2, inputs=[wp.array([t], dtype=wp.float32), indices], outputs=[ke, kd])
            np.testing.assert_allclose(ke.numpy()[:6], demo.PIPER_ARM_KP)
            np.testing.assert_allclose(kd.numpy()[:6], demo.PIPER_ARM_KD)
            np.testing.assert_allclose(
                ke.numpy()[6:], demo.PIPER_FINGER_KP + blend * (demo.PIPER_BAG_FINGER_KP - demo.PIPER_FINGER_KP), rtol=1.0e-6)
            np.testing.assert_allclose(
                kd.numpy()[6:], demo.PIPER_FINGER_KD + blend * (demo.PIPER_BAG_FINGER_KD - demo.PIPER_FINGER_KD), rtol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="SynReal requires CUDA")
def test_full_five_apple_loading_sequential_swings_and_supported_release():
    wp.config.kernel_cache_dir = str(demo.REPO_ROOT / "build" / "warp-cloth-apples")
    with wp.ScopedDevice("cuda:0"):
        example = demo.Example(newton.viewer.ViewerNull(), demo.Example.create_parser().parse_args(["--viewer", "null"]))
        assert example.solver.config.nonlinear_iterations == 4
        assert not any("rack" in label for label in example.model.shape_label)
        assert example.model.body_count == example.robot_body_count + 5
        assert np.all(example.model.particle_mass.numpy() > 0)
        np.testing.assert_allclose(example.model.body_mass.numpy()[example.bag_bodies], demo.APPLE_MASS, rtol=1.0e-5)
        assert example.bag_bending["nonmanifold_edge_count"] == 40
        assert example.bag_bending["represented_face_sides"] == 3 * len(example.model.tri_indices)
        example.test_final()
        initial = example.state_0.body_q.numpy()[example.bag_bodies, :3].copy()
        seen_loading = seen_horizontal = seen_vertical = seen_supported_release = False
        vertical_handle_positions = []
        for frame in range(demo.DEFAULT_NUM_FRAMES):
            example.step()
            if frame % 15 == 0 or frame == demo.DEFAULT_NUM_FRAMES - 1:
                example.test_final()
            t = example.sim_time
            if demo.APPLE_LOADING_END <= t < demo.APPLE_LOADING_END + example.frame_dt:
                apples = example.state_0.body_q.numpy()[example.bag_bodies, :3]
                assert np.all(initial[:, 2] - apples[:, 2] > 0.015)
                seen_loading = True
            if demo.HORIZONTAL_START <= t < demo.HORIZONTAL_END:
                seen_horizontal = True
            if demo.VERTICAL_START <= t < demo.VERTICAL_END:
                seen_vertical = True
                cloth = example.state_0.particle_q.numpy()[:example.bag_particle_count]
                vertical_handle_positions.append(cloth[example.grip_vertices].mean(axis=0))
            if demo.RELEASE_START - 0.1 <= t < demo.RELEASE_START:
                cloth = example.state_0.particle_q.numpy()[:example.bag_particle_count]
                assert cloth[:, 2].min() <= 0.04
                seen_supported_release = True
        assert seen_loading and seen_horizontal and seen_vertical and seen_supported_release
        # Measure the deformable handle itself so an arm-only motion cannot satisfy this regression.
        handle_travel = np.ptp(np.asarray(vertical_handle_positions), axis=0)
        assert handle_travel[2] >= 0.25
        assert np.linalg.norm(handle_travel[:2]) < 0.02
