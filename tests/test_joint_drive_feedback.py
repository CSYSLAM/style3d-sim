"""Focused tests for the optional motor-effort telemetry output."""

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")

from synreal_solver.newton_solver import NewtonSolver  # noqa: E402


@wp.kernel
def _copy_feedback_sample(
    feedback: wp.array(dtype=wp.float32),
    sample_index: int,
    samples: wp.array(dtype=wp.float32),
):
    samples[sample_index] = feedback[0]


def _make_revolute_solver(
    *, nonlinear_iterations: int = 1, target_pos: float = 0.0, target_ke: float = 20.0,
    target_kd: float = 0.0, effort_limit: float = 100.0
) -> tuple[object, NewtonSolver, object, object, object]:
    """Build an isolated one-DOF drive scene for telemetry tests."""
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    inertia = wp.mat33(0.02, 0.0, 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 0.04)
    parent = builder.add_link(mass=1.0, inertia=inertia, lock_inertia=True)
    child = builder.add_link(mass=1.0, inertia=inertia, lock_inertia=True)
    joint = builder.add_joint_revolute(
        parent=parent,
        child=child,
        axis=(0.0, 0.0, 1.0),
        target_pos=target_pos,
        target_ke=target_ke,
        target_kd=target_kd,
        damping=0.0,
        actuator_mode=newton.JointTargetMode.POSITION,
    )
    builder.add_articulation([joint])
    builder.joint_effort_limit[0] = effort_limit
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)
    solver.config.constraint_alpha = 0.0
    solver.config.nonlinear_iterations = nonlinear_iterations
    solver.config.linear_iterations = 20
    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)
    control = model.control()
    wp.copy(control.joint_target_q, model.joint_target_q)
    wp.copy(control.joint_target_qd, model.joint_target_qd)
    state_in.clear_forces()
    return model, solver, state_in, state_out, control


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize(
    ("joint_kind", "expected_effort"),
    [("revolute", 0.5), ("revolute", -0.5), ("prismatic", 0.5), ("prismatic", -0.5)],
)
def test_joint_drive_feedback_reports_limited_effort(
    joint_kind: str, expected_effort: float
) -> None:
    """Both drive types expose the signed limited actuator output at the returned state."""
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    inertia = wp.mat33(0.03, 0.0, 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 0.03)
    body = builder.add_link(mass=2.0, inertia=inertia, lock_inertia=True)
    if joint_kind == "revolute":
        parent = builder.add_link(mass=2.0, inertia=inertia, lock_inertia=True)
        joint = builder.add_joint_revolute(
            parent=parent,
            child=body,
            axis=(0.0, 0.0, 1.0),
            damping=0.0,
        )
    else:
        joint = builder.add_joint_prismatic(
            parent=-1,
            child=body,
            axis=(1.0, 0.0, 0.0),
            target_pos=np.copysign(0.1, expected_effort),
            target_ke=100.0,
            target_kd=0.0,
            damping=0.0,
            actuator_mode=newton.JointTargetMode.POSITION,
        )
    builder.add_articulation([joint])
    builder.joint_effort_limit[0] = abs(expected_effort)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)
    solver.config.constraint_alpha = 0.0
    solver.config.nonlinear_iterations = 1
    solver.config.linear_iterations = 20

    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)
    control = model.control()
    if joint_kind == "revolute":
        control.joint_f.fill_(np.copysign(2.0, expected_effort))
    wp.copy(control.joint_target_q, model.joint_target_q)
    wp.copy(control.joint_target_qd, model.joint_target_qd)
    state_in.clear_forces()

    assert solver.joint_drive_effort is None
    effort = solver.enable_joint_drive_feedback()
    solver.step(state_in, state_out, control, None, 1.0e-4)
    wp.synchronize_device(model.device)

    assert effort.ptr == solver.joint_drive_effort.ptr
    assert np.allclose(effort.numpy(), [expected_effort], atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_feedback_does_not_change_trajectory() -> None:
    """Telemetry preserves the trajectory of this deterministic drive scene."""
    model_a, solver_a, state_a, out_a, control_a = _make_revolute_solver(nonlinear_iterations=4)
    _, solver_b, state_b, out_b, control_b = _make_revolute_solver(nonlinear_iterations=4)
    control_a.joint_f.fill_(0.75)
    control_b.joint_f.fill_(0.75)
    solver_b.enable_joint_drive_feedback()
    for step in range(4):
        if step == 2:
            solver_b.disable_joint_drive_feedback()
            assert solver_b.joint_drive_effort is None
        solver_a.step(state_a, out_a, control_a, None, 1.0e-4)
        solver_b.step(state_b, out_b, control_b, None, 1.0e-4)
        wp.synchronize_device(model_a.device)
        for field in ("particle_q", "particle_qd", "body_q", "body_qd"):
            assert np.array_equal(getattr(out_a, field).numpy(), getattr(out_b, field).numpy())
        state_a, out_a = out_a, state_a
        state_b, out_b = out_b, state_b


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_feedback_tracks_commands_during_cuda_graph_replay() -> None:
    """A graph retains both substeps, then reads updated command arrays on replay."""
    model, solver, state_in, state_out, control = _make_revolute_solver(target_ke=0.0, effort_limit=0.5)
    feedback = solver.enable_joint_drive_feedback()
    samples = wp.empty(2, dtype=wp.float32, device=model.device)
    commands = [wp.array([value], dtype=wp.float32, device=model.device) for value in (0.75, -1.0)]
    stream = wp.get_stream(model.device)
    with wp.ScopedCapture(stream=stream) as capture:
        for substep in range(2):
            wp.copy(control.joint_f, commands[substep], stream=stream)
            solver.step(state_in, state_out, control, None, 1.0e-4)
            wp.launch(
                _copy_feedback_sample, dim=1, inputs=[feedback, substep, samples], device=model.device, stream=stream
            )
            state_in, state_out = state_out, state_in
    graph = capture.graph
    wp.capture_launch(graph, stream=stream)
    assert np.allclose(samples.numpy(), [0.5, -0.5], atol=1.0e-6)
    for array, value in zip(commands, (-0.25, 0.125), strict=True):
        array.fill_(value)
    wp.capture_launch(graph, stream=stream)
    assert np.allclose(samples.numpy(), [-0.25, 0.125], atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("iterations", (1, 4))
def test_joint_drive_feedback_uses_completed_pose_and_velocity(iterations: int) -> None:
    """An independent one-axis observation distinguishes final-state effort from the old RHS sample."""
    model, solver, state_in, state_out, control = _make_revolute_solver(
        nonlinear_iterations=iterations, target_pos=0.8, target_kd=0.2
    )
    control.joint_f.fill_(0.3)
    control.joint_target_qd.fill_(0.1)
    effort = solver.enable_joint_drive_feedback()
    solver.step(state_in, state_out, control, None, 0.02)
    poses, twists = state_out.body_q.numpy(), state_out.body_qd.numpy()
    angles = 2.0 * np.arctan2(poses[:, 5], poses[:, 6])
    position = angles[1] - angles[0]
    velocity = twists[1, 5] - twists[0, 5]
    expected = 0.3 + 20.0 * (0.8 - position) + 0.2 * (0.1 - velocity)
    assert np.isclose(effort.numpy()[0], expected, atol=3.0e-5)
    assert abs(expected - (0.3 + 20.0 * 0.8 + 0.2 * 0.1)) > 1.0e-3
    assert not hasattr(state_out, "joint_drive_effort")

    fields = ("particle_q", "particle_qd", "body_q", "body_qd")
    snapshots = {name: getattr(state_out, name).numpy().copy() for name in fields}
    state_keys = set(vars(state_out))
    direct = solver.compute_joint_drive_effort(state_out, control)
    assert np.array_equal(direct.numpy(), effort.numpy())
    assert set(vars(state_out)) == state_keys
    for name in fields:
        assert np.array_equal(getattr(state_out, name).numpy(), snapshots[name])
    with pytest.raises(ValueError, match="alias"):
        solver.compute_joint_drive_effort(state_out, control, out=control.joint_f)
    for name in ("joint_q", "joint_qd"):
        array = getattr(state_out, name, None)
        if array is not None:
            before = array.numpy().copy()
            with pytest.raises(ValueError, match="alias"):
                solver.compute_joint_drive_effort(state_out, control, out=array)
            assert np.array_equal(array.numpy(), before)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_feedback_clears_previous_samples_even_without_nonlinear_iterations() -> None:
    model, solver, state_in, state_out, control = _make_revolute_solver(target_ke=0.0)
    feedback = solver.enable_joint_drive_feedback()
    # End-state actuator evaluation is independent of the number of internal force evaluations.
    for command, iterations, expected in ((1.0, 1, 1.0), (0.0, 1, 0.0), (1.0, 1, 1.0), (1.0, 0, 1.0)):
        control.joint_f.fill_(command)
        solver.config.nonlinear_iterations = iterations
        solver.step(state_in, state_out, control, None, 1.0e-4)
        assert np.allclose(feedback.numpy(), expected, atol=1.0e-6)
        state_in, state_out = state_out, state_in


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_feedback_wraps_angles_at_pi() -> None:
    _, solver, state_in, _, control = _make_revolute_solver(target_pos=-np.pi + 0.02)
    poses = state_in.body_q.numpy()
    angle = np.pi - 0.03
    poses[1, 3:] = [0.0, 0.0, np.sin(angle / 2.0), np.cos(angle / 2.0)]
    state_in.body_q.assign(poses)
    # Crossing the branch cut gives a 0.05 rad error, not an almost-full revolution.
    result = solver.compute_joint_drive_effort(state_in, control).numpy()[0]
    assert np.isclose(result, 20.0 * 0.05, atol=1.0e-5)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_effort_uses_anchor_velocity_and_moving_parent_axis() -> None:
    builder = newton.ModelBuilder(gravity=wp.vec3(0.0))
    inertia = wp.mat33(np.eye(3, dtype=np.float32))
    parent = builder.add_link(mass=1.0, inertia=inertia, lock_inertia=True)
    child = builder.add_link(mass=1.0, com=(0.0, 1.0, 0.0), inertia=inertia, lock_inertia=True)
    joint = builder.add_joint_prismatic(
        parent=parent, child=child, axis=(1.0, 0.0, 0.0), target_pos=0.5,
        target_ke=20.0, target_kd=2.0, actuator_mode=newton.JointTargetMode.POSITION,
    )
    builder.add_articulation([joint])
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    state, control = model.state(), model.control()
    poses = state.body_q.numpy()
    poses[child, :3] = [0.2, 0.1, 0.0]
    state.body_q.assign(poses)
    state.body_qd.assign(np.array([[1, 0, 0, 0, 0, 1], [3, 0, 0, 0, 0, 2]], dtype=np.float32))
    control.joint_target_q.fill_(0.5)
    control.joint_target_qd.fill_(0.2)
    control.joint_f.fill_(0.7)
    # The child's offset COM gives anchor velocity 5 m/s; the moving parent axis contributes 0.1 m/s.
    expected = 0.7 + 20.0 * (0.5 - 0.2) + 2.0 * (0.2 - (5.0 - 1.0 + 0.1))
    assert np.isclose(solver.compute_joint_drive_effort(state, control).numpy()[0], expected, atol=2.0e-5)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_joint_drive_effort_respects_replicated_world_control_indices() -> None:
    scene = newton.ModelBuilder(gravity=wp.vec3(0.0))
    body = scene.add_link(mass=1.0, inertia=wp.mat33(np.eye(3, dtype=np.float32)), lock_inertia=True)
    joint = scene.add_joint_revolute(parent=-1, child=body, axis=(0.0, 0.0, 1.0))
    scene.add_articulation([joint])
    scene.joint_effort_limit[0] = 0.5
    builder = newton.ModelBuilder(gravity=wp.vec3(0.0))
    builder.replicate(scene, 3)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    assert solver.synreal_model.world_count == 3
    state, control = model.state(), model.control()
    control.joint_f.assign(np.array([0.3, -0.4, 2.0], dtype=np.float32))
    assert np.allclose(solver.compute_joint_drive_effort(state, control).numpy(), [0.3, -0.4, 0.5], atol=1.0e-6)
