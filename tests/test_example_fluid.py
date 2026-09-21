"""Native fluid pressure, viscosity, material selection, and graph regressions."""

import itertools

import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")
import synreal_solver as sr  # noqa: E402
from examples import example_fluid  # noqa: E402
from newton.viewer import ViewerNull  # noqa: E402

pytestmark = pytest.mark.skipif(not wp.is_cuda_available(), reason="Native fluids require CUDA")


def density(points, masses, h, boundaries=None, volumes=None):
    samples = points if boundaries is None else np.concatenate((points, boundaries))
    sample_volumes = masses / 1000.0 if boundaries is None else np.concatenate((masses / 1000.0, volumes))
    q2 = np.sum((points[:, None] - samples[None, :]) ** 2, axis=-1) / h**2
    return (315.0 / (64.0 * np.pi * h**3) * np.maximum(1.0 - q2, 0.0) ** 3) @ sample_volumes


def scene(
    points,
    masses,
    *,
    indices=None,
    h=0.12,
    bulk=5000.0,
    viscosity=0.0,
    velocity=None,
    gravity=0.0,
    method=sr.NonlinearSolver.NEWTON,
    iterations=1,
):
    builder = newton.ModelBuilder(gravity=(0.0, 0.0, gravity))
    builder.add_particles(
        pos=points, vel=np.zeros_like(points) if velocity is None else velocity, mass=masses, radius=np.full(len(points), 0.04)
    )
    model = builder.finalize(device="cuda:0")
    sr.configure_fluid(
        model,
        np.arange(len(points), dtype=np.int32) if indices is None else indices,
        smoothing_radius=h,
        bulk_modulus=bulk,
        viscosity=viscosity,
    )
    solver = sr.NewtonSolver(model)
    solver.config.nonlinear_solver = method
    solver.config.nonlinear_iterations = iterations
    solver.config.linear_iterations = 80
    solver.config.fluid_relaxation = 1.0
    solver.config.fluid_max_step_ratio = 0.0
    return model, solver, model.state(), model.state()


@pytest.mark.parametrize("method", [sr.NonlinearSolver.NEWTON, sr.NonlinearSolver.PD_NEWTON])
@pytest.mark.parametrize("side", [2, 5])
def test_density_newton_step_matches_finite_difference_jacobian(method, side):
    # 125 dense particles exercise the uncapped fallback beyond the 64-entry gradient cache.
    points = np.asarray(list(itertools.product(np.linspace(-0.024, 0.024, side), repeat=3)), dtype=np.float32)
    masses = (np.linspace(0.35, 0.55, len(points)) * (2 / side) ** 3).astype(np.float32)
    h, bulk, dt = 0.12, 5000.0, 0.003
    base = points.astype(np.float64)
    rho = density(base, masses, h)
    assert np.all(rho > 1.0)
    # Independently differentiate the density function; the native force and H*v must use that same derivative.
    jacobian = np.empty((len(points), points.size))
    for k in range(points.size):
        plus, minus = base.copy(), base.copy()
        plus.flat[k] += 1.0e-6
        minus.flat[k] -= 1.0e-6
        jacobian[:, k] = (density(plus, masses, h) - density(minus, masses, h)) / 2.0e-6
    weights = bulk * masses / 1000.0
    rhs = -jacobian.T @ (weights * (rho - 1.0))
    matrix = np.diag(np.repeat(masses / dt**2, 3)) + jacobian.T @ (weights[:, None] * jacobian)
    expected = base + np.linalg.solve(matrix, rhs).reshape(-1, 3)
    model, solver, a, b = scene(points, masses, h=h, bulk=bulk, method=method)
    solver.step(a, b, None, None, dt)
    np.testing.assert_allclose(b.particle_q.numpy(), expected, atol=2.0e-6, rtol=1.0e-4)
    np.testing.assert_allclose(np.sum(masses[:, None] * b.particle_qd.numpy(), axis=0), 0.0, atol=2.0e-5)


def test_viscosity_dissipates_relative_motion_and_preserves_momentum():
    points = np.array([[-0.03, 0, 0], [0.03, 0, 0]], dtype=np.float32)
    masses = np.array([0.5, 0.8], dtype=np.float32)
    velocities = np.array([[0, 1.0, 0], [0, -0.5, 0]], dtype=np.float32)
    model, solver, a, b = scene(points, masses, bulk=0.0, viscosity=50.0, velocity=velocities)
    solver.step(a, b, None, None, 0.005)
    result = b.particle_qd.numpy()
    assert np.linalg.norm(result[0] - result[1]) < np.linalg.norm(velocities[0] - velocities[1])
    assert np.sum(masses[:, None] * result**2) < np.sum(masses[:, None] * velocities**2)
    np.testing.assert_allclose(
        np.sum(masses[:, None] * result, axis=0), np.sum(masses[:, None] * velocities, axis=0), atol=1.0e-5
    )


def test_unselected_particle_does_not_contribute_to_fluid_density():
    points = np.array([[0, 0, 0], [0.01, 0, 0]], dtype=np.float32)
    model, solver, a, b = scene(points, np.array([0.1, 100.0]), indices=np.array([0], dtype=np.int32))
    solver.step(a, b, None, None, 0.01)
    np.testing.assert_array_equal(b.particle_q.numpy(), points)


def test_fluid_pair_collision_filter_preserves_other_particle_contacts():
    points = np.array([[0, 0, 0], [0.03, 0, 0]], dtype=np.float32)
    for selection, should_move in (([0, 1], False), ([0], True)):
        model, solver, a, b = scene(points, np.ones(2), indices=np.array(selection, dtype=np.int32), bulk=0)
        solver.config.enable_self_collision = True
        solver.config.enable_collision_hessian_non_diagonal = True
        solver.step(a, b, None, None, 0.01)
        distance = np.linalg.norm(np.diff(b.particle_q.numpy(), axis=0))
        assert (distance > 0.031) == should_move


def test_native_prediction_preserves_gravity_trajectory():
    points = np.array([[1.5, 0.0, 1.5]], dtype=np.float32)
    model, solver, a, b = scene(points, np.array([0.1]), gravity=-9.81)
    for step in range(1, 4):
        solver.step(a, b, None, None, 0.005)
        expected = points.copy()
        expected[0, 2] -= 9.81 * 0.005**2 * step * (step + 1) / 2
        np.testing.assert_allclose(b.particle_q.numpy(), expected, atol=2.0e-6)
        a, b = b, a


def test_cuda_graph_matches_uncaptured_odd_substeps():
    with wp.ScopedDevice("cuda:0"):
        parser = example_fluid.Example.create_parser()
        common = ["--viewer", "null", "--device", "cuda:0", "--resolution", "8", "--substeps", "3"]
        uncaptured = example_fluid.Example(ViewerNull(), parser.parse_args([*common, "--no-capture"]))
        captured = example_fluid.Example(ViewerNull(), parser.parse_args(common))
        np.testing.assert_array_equal(captured.state_0.particle_q.numpy(), uncaptured.state_0.particle_q.numpy())
        for _ in range(3):
            uncaptured.step()
            captured.step()
        np.testing.assert_allclose(captured.state_0.particle_q.numpy(), uncaptured.state_0.particle_q.numpy(), atol=3.0e-5)
        np.testing.assert_allclose(captured.state_0.particle_qd.numpy(), uncaptured.state_0.particle_qd.numpy(), atol=0.01)
        np.testing.assert_allclose(captured.state_0.body_q.numpy(), uncaptured.state_0.body_q.numpy(), atol=3.0e-5)
        np.testing.assert_allclose(captured.state_0.body_qd.numpy(), uncaptured.state_0.body_qd.numpy(), atol=0.01)
        # Fixed graph buffers must advance the rigid poses as well as the fluid coordinates.
        assert np.all(captured.state_0.body_q.numpy()[:, 2] < captured.model.body_q.numpy()[:, 2] - 0.005)


@pytest.mark.parametrize("capture", [False, True])
def test_ducks_can_be_picked_through_tank_and_dragged_after_capture(capture):
    from newton._src.viewer.picking import Picking

    class PickingViewer(ViewerNull):
        def set_model(self, model):
            super().set_model(model)
            self.picking = Picking(model)

        def apply_forces(self, state):
            self.picking._apply_picking_force(state)

    with wp.ScopedDevice("cuda:0"):
        args = ["--viewer", "null", "--device", "cuda:0", "--resolution", "8", "--substeps", "3"]
        if not capture:
            args.append("--no-capture")
        viewer = PickingViewer()
        example = example_fluid.Example(viewer, example_fluid.Example.create_parser().parse_args(args))
        picking = viewer.picking
        assert len(example.duck_bodies) == example.model.body_count == 5
        initial_arrays = {
            name: wp.clone(getattr(example.state_0, name)) for name in ("particle_q", "particle_qd", "body_q", "body_qd")
        }
        camera = wp.vec3(4.8, -5.2, 3.3)
        for body in example.duck_bodies:
            # Each duck starts from the same separated layout, so earlier drags cannot hide a later target.
            for name, values in initial_arrays.items():
                wp.copy(getattr(example.state_0, name), values)
            initial = example.state_0.body_q.numpy()[body, :3].copy()
            direction = wp.normalize(wp.vec3(*initial) - camera)
            picking.pick(example.state_0, camera, direction)
            assert picking.is_picking()
            assert picking.pick_body.numpy()[0] == body
            # Move the cursor ray sideways/up while preserving the normal picking depth update.
            target = picking.pick_state.numpy()[0]["picking_target_world"].copy() + np.array([0.3, 0.0, 0.35])
            picking.update(camera, wp.normalize(wp.vec3(*target) - camera))
            for _ in range(15):
                example.step()
            position = example.state_0.body_q.numpy()[body, :3]
            assert position[0] > initial[0] + 0.03
            assert position[2] > initial[2]
            assert np.isfinite(example.state_0.particle_q.numpy()).all()
            picking.release()
            example.step()
            assert not picking.is_picking()
            np.testing.assert_array_equal(example.state_0.body_f.numpy(), 0.0)
        # A missed click must not select a previously dragged duck or a tank wall.
        picking.pick(example.state_0, camera, wp.vec3(0.0, 0.0, 1.0))
        assert not picking.is_picking()
        viewer.close()


@pytest.mark.parametrize("invalid", [np.array([0, 0]), np.array([-1]), np.array([99])])
def test_fluid_selection_rejects_invalid_indices(invalid):
    builder = newton.ModelBuilder()
    builder.add_particle((0, 0, 0), (0, 0, 0), 1.0)
    model = builder.finalize(device="cuda:0")
    with pytest.raises(ValueError, match="indices"):
        sr.configure_fluid(model, invalid, smoothing_radius=0.1)


def test_fluid_cannot_share_elastic_particles():
    builder = newton.ModelBuilder()
    builder.add_particle((0, 0, 0), (0, 0, 0), 1.0)
    builder.add_particle((0.1, 0, 0), (0, 0, 0), 1.0)
    builder.add_spring(0, 1, ke=100.0, kd=0.0, control=0.0)
    model = builder.finalize(device="cuda:0")
    sr.configure_fluid(model, [0], smoothing_radius=0.1)
    with pytest.raises(ValueError, match="elastic"):
        sr.NewtonSolver(model)


def test_overlapping_worlds_do_not_share_density_neighbors():
    points = np.asarray(list(itertools.product((-0.024, 0.024), repeat=3)), dtype=np.float32)
    masses = np.full(len(points), 0.45)
    reference, solver, a, b = scene(points, masses)
    solver.step(a, b, None, None, 0.003)
    expected = b.particle_q.numpy()
    model, _, a, b = scene(np.tile(points, (2, 1)), np.tile(masses, 2))
    model.particle_world.assign(np.repeat([0, 1], len(points)).astype(np.int32))
    solver = sr.NewtonSolver(model)
    solver.config.nonlinear_solver = sr.NonlinearSolver.NEWTON
    solver.config.nonlinear_iterations = 1
    solver.config.linear_iterations = 80
    solver.config.fluid_relaxation = 1.0
    solver.config.fluid_max_step_ratio = 0.0
    solver.step(a, b, None, None, 0.003)
    np.testing.assert_allclose(b.particle_q.numpy(), np.tile(expected, (2, 1)), atol=2.0e-6)


def test_fluid_particle_transfers_contact_force_to_cloth_face():
    from test_self_collision_coupling import ContactScene

    with wp.ScopedDevice("cuda:0"):
        scene = ContactScene("particle_vertex_face", True, sr.NonlinearSolver.NEWTON)
        scene.model.fluid_particle_count = 1
        # The existing collision selection contains only the free particle, not the face's three vertices.
        scene.model.fluid_particle_indices = scene.model.collision_particle_indices
        scene.model.fluid_smoothing_radius = 0.1
        scene.model.fluid_bulk_modulus = 0.0
        scene.solver.initialize(scene.model)
        scene.solver.config.fluid_relaxation = 1.0
        scene.solver.config.fluid_max_step_ratio = 0.0
        scene.step()
        actual = scene.position_out.numpy()
        assert actual[3, 2] > scene.initial[3, 2]
        assert np.all(actual[:3, 2] < scene.initial[:3, 2])
        np.testing.assert_allclose(np.sum(scene.case.masses[:, None] * (actual - scene.initial), axis=0), 0, atol=1.0e-6)


def test_static_boundary_density_force_matches_energy_derivative():
    points = np.array([[0.04, 0.0, 0.0]], dtype=np.float32)
    masses = np.array([0.3], dtype=np.float32)
    boundary = np.array([[-0.02, 0.0, 0.0]], dtype=np.float32)
    volumes = np.array([0.003], dtype=np.float32)
    h, bulk, dt = 0.12, 5000.0, 0.003
    rho = density(points.astype(float), masses, h, boundary, volumes)
    assert rho[0] > 1
    jacobian = np.zeros(3)
    for axis in range(3):
        plus, minus = points.astype(float), points.astype(float)
        plus[0, axis] += 1.0e-6
        minus[0, axis] -= 1.0e-6
        jacobian[axis] = (
            density(plus, masses, h, boundary, volumes)[0] - density(minus, masses, h, boundary, volumes)[0]
        ) / 2.0e-6
    weight = bulk * masses[0] / 1000.0
    matrix = np.eye(3) * masses[0] / dt**2 + weight * np.outer(jacobian, jacobian)
    expected = points[0] + np.linalg.solve(matrix, -weight * (rho[0] - 1) * jacobian)
    model, _, a, b = scene(points, masses)
    sr.configure_fluid(model, [0], smoothing_radius=h, bulk_modulus=bulk, boundary_positions=boundary, boundary_volumes=volumes)
    solver = sr.NewtonSolver(model)
    solver.config.nonlinear_solver = sr.NonlinearSolver.NEWTON
    solver.config.nonlinear_iterations = 1
    solver.config.linear_iterations = 40
    solver.config.fluid_relaxation = 1
    solver.config.fluid_max_step_ratio = 0
    solver.step(a, b, None, None, dt)
    np.testing.assert_allclose(b.particle_q.numpy()[0], expected, atol=2.0e-6)
    assert b.particle_q.numpy()[0, 0] > points[0, 0]


def test_newton_step_bound_is_independent_between_worlds():
    cube = np.asarray(list(itertools.product((-1.0, 1.0), repeat=3)), dtype=np.float32)
    points = [cube * 0.015, cube * 0.028]
    masses = np.full(8, 0.5)
    expected = []
    for block in points:
        _, solver, a, b = scene(block, masses)
        solver.config.fluid_relaxation = 0.5
        solver.config.fluid_max_step_ratio = 0.005
        solver.step(a, b, None, None, 0.003)
        expected.append(b.particle_q.numpy())
    model, _, a, b = scene(np.concatenate(points), np.tile(masses, 2))
    model.particle_world.assign(np.repeat([0, 1], 8).astype(np.int32))
    solver = sr.NewtonSolver(model)
    solver.config.nonlinear_solver = sr.NonlinearSolver.NEWTON
    solver.config.nonlinear_iterations = 1
    solver.config.linear_iterations = 80
    solver.config.fluid_relaxation = 0.5
    solver.config.fluid_max_step_ratio = 0.005
    solver.step(a, b, None, None, 0.003)
    np.testing.assert_allclose(b.particle_q.numpy(), np.concatenate(expected), atol=2.0e-6)
