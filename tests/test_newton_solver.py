import numpy as np
import pytest

newton = pytest.importorskip("newton")
wp = pytest.importorskip("warp")

import synreal_solver as sr  # noqa: E402
from synreal_solver.newton_model_builder import ModelBuilder  # noqa: E402
from synreal_solver.newton_solver import NewtonSolver, _scatter_affine_body_forces, _update_affine_body_poses  # noqa: E402


AFFINE_BODY_RIGIDITY_MODELS = (
    pytest.param(sr.AffineBodyRigidityModel.CO_ROTATED, id="co-rotated"),
    pytest.param(
        sr.AffineBodyRigidityModel.ABD_ORTHOGONALITY,
        id="abd-orthogonality",
    ),
    pytest.param(sr.AffineBodyRigidityModel.SIX_SPRINGS, id="six-springs"),
)

INERTIA_MODES = (
    pytest.param(sr.InertiaMode.EXPLICIT_EULER, id="explicit-euler"),
    pytest.param(sr.InertiaMode.IMPLICIT_EULER, id="implicit-euler"),
    pytest.param(
        sr.InertiaMode.LIE_GROUP_MIDPOINT,
        id="lie-group-midpoint",
    ),
    pytest.param(sr.InertiaMode.MIDPOINT_CAYLEY, id="midpoint-cayley"),
)


def _affine_frame_rigidity_error(points: np.ndarray, axis_length: float) -> float:
    affine = (points[1:] - points[0]).T / axis_length
    return float(np.linalg.norm(affine @ affine.T - np.eye(3), ord="fro"))


def _deform_affine_frame(points: np.ndarray) -> np.ndarray:
    deformation = np.array(
        (
            (1.35, 0.30, -0.10),
            (0.05, 0.75, 0.25),
            (0.15, -0.05, 1.20),
        ),
        dtype=np.float32,
    )
    deformed = points.copy()
    deformed[1:] = points[0] + (deformation @ (points[1:] - points[0]).T).T
    return deformed


def _set_particle_positions(
    state: object, positions: np.ndarray, device: object
) -> None:
    source = wp.array(positions, dtype=wp.vec3, device=device)
    wp.copy(state.particle_q, source)


def _add_tetrahedral_cube(
    builder: object,
    *,
    k_mu: float = 2.0e5,
    k_lambda: float = 2.0e5,
    k_damp: float = 2.0e3,
    tri_ke: float = 0.0,
    add_surface_mesh_edges: bool = False,
) -> None:
    builder.add_soft_grid(
        pos=wp.vec3(0.0),
        rot=wp.quat_identity(),
        vel=wp.vec3(0.0),
        dim_x=1,
        dim_y=1,
        dim_z=1,
        cell_x=0.2,
        cell_y=0.2,
        cell_z=0.2,
        density=1.0e3,
        k_mu=k_mu,
        k_lambda=k_lambda,
        k_damp=k_damp,
        tri_ke=tri_ke,
        add_surface_mesh_edges=add_surface_mesh_edges,
    )


def _add_morton_reversed_overlapping_particles(builder: object) -> np.ndarray:
    """Add one overlapping pair whose particle IDs oppose their Morton order."""
    positions = np.asarray(
        (
            (0.03, 0.02, 0.01),
            (-0.03, -0.02, -0.01),
            (-2.0, -2.0, -2.0),
            (2.0, 2.0, 2.0),
        ),
        dtype=np.float32,
    )
    for position, radius in zip(positions, (0.06, 0.06, 0.01, 0.01)):
        builder.add_particle(
            pos=position,
            vel=(0.0, 0.0, 0.0),
            mass=1.0,
            radius=radius,
        )
    return positions


def _tetrahedron_deformation_error(model: object, positions: np.ndarray) -> float:
    indices = np.asarray(model.tet_indices.numpy(), dtype=np.int64)
    inverse_dms = np.asarray(model.tet_poses.numpy(), dtype=np.float64)
    errors = []
    for tetrahedron, inverse_dm in zip(indices, inverse_dms):
        points = positions[tetrahedron]
        ds = np.column_stack(
            (points[1] - points[0], points[2] - points[0], points[3] - points[0])
        )
        errors.append(np.linalg.norm(ds @ inverse_dm - np.eye(3), ord="fro"))
    return float(np.mean(errors))


def test_model_builder_import_paths() -> None:
    from synreal_solver import ModelBuilder as package_model_builder
    from synreal_solver.newton_solver import ModelBuilder as legacy_model_builder

    assert ModelBuilder is package_model_builder is legacy_model_builder


def test_model_builder_adds_affine_body_proxy_particles() -> None:
    mass = 2.0
    inertia = np.array(
        (
            (5.0, 0.2, 0.0),
            (0.2, 6.0, 0.0),
            (0.0, 0.0, 7.0),
        ),
        dtype=np.float32,
    )
    rotation = wp.quat_from_axis_angle(wp.normalize(wp.vec3(1.0, 2.0, 3.0)), 0.4)
    builder = ModelBuilder(
        up_axis=newton.Axis.Z, gravity=0.0, affine_body_particle_radius=0.025
    )
    body = builder.add_body(
        xform=wp.transform(wp.vec3(1.0, 2.0, 3.0), rotation),
        com=wp.vec3(0.1, -0.2, 0.3),
        mass=mass,
        inertia=wp.mat33(inertia),
        lock_inertia=True,
    )
    builder.body_qd[body] = wp.spatial_vector(1.0, -2.0, 3.0, 4.0, 5.0, -6.0)

    model = builder.finalize(device="cpu")
    positions = model.particle_q.numpy()
    velocities = model.particle_qd.numpy()
    particle_indices = model.synreal_affine_body_indices.numpy()[0]
    rotation_matrix = np.asarray(wp.quat_to_matrix(rotation), dtype=np.float32).reshape(
        3, 3
    )
    world_com = np.array(
        (1.0, 2.0, 3.0), dtype=np.float32
    ) + rotation_matrix @ np.array((0.1, -0.2, 0.3), dtype=np.float32)
    second_moment = 0.5 * np.trace(inertia) * np.eye(3, dtype=np.float32) - inertia
    axis_length = np.sqrt(np.trace(second_moment) / (3.0 * mass))
    coordinate_map = np.zeros((4, 4), dtype=np.float32)
    coordinate_map[0, 0] = 1.0
    coordinate_map[1:, 0] = -1.0 / axis_length
    coordinate_map[1:, 1:] = np.eye(3, dtype=np.float32) / axis_length
    affine_mass = np.zeros((4, 4), dtype=np.float32)
    affine_mass[0, 0] = mass
    affine_mass[1:, 1:] = second_moment
    expected_mass_matrix = coordinate_map.T @ affine_mass @ coordinate_map
    expected_offsets = np.vstack(
        (
            np.zeros(3, dtype=np.float32),
            (rotation_matrix @ (axis_length * np.eye(3, dtype=np.float32))).T,
        )
    ).reshape(4, 3)
    linear_velocity = np.array((1.0, -2.0, 3.0), dtype=np.float32)
    angular_velocity = np.array((4.0, 5.0, -6.0), dtype=np.float32)

    assert model.particle_count == 4
    assert model.spring_count == 0
    assert model.synreal_affine_body_ids.numpy().tolist() == [body]
    assert np.array_equal(particle_indices, np.arange(4))
    assert np.allclose(model.particle_mass.numpy(), mass)
    assert np.allclose(model.particle_radius.numpy(), 0.025)
    assert np.allclose(positions[particle_indices], world_com + expected_offsets)
    assert np.allclose(
        velocities[particle_indices],
        linear_velocity + np.cross(angular_velocity, expected_offsets),
    )
    axis_edge_lengths = np.linalg.norm(
        positions[particle_indices[1:]] - positions[particle_indices[0]], axis=1
    )
    assert np.allclose(axis_edge_lengths, axis_length)
    actual_mass_matrix = np.diag(model.synreal_particle_mass_diagonal.numpy())
    for (first, second), value in zip(
        model.synreal_particle_mass_non_diagonal_indices.numpy(),
        model.synreal_particle_mass_non_diagonal_values.numpy(),
    ):
        actual_mass_matrix[first, second] = value
        actual_mass_matrix[second, first] = value
    assert np.allclose(actual_mass_matrix, expected_mass_matrix)
    assert np.allclose(
        np.sum(actual_mass_matrix, axis=0), (mass, 0.0, 0.0, 0.0), atol=1.0e-5
    )
    actual_kinetic_energy = 0.5 * np.einsum(
        "ic,ij,jc->",
        velocities[particle_indices],
        actual_mass_matrix,
        velocities[particle_indices],
    )
    world_inertia = rotation_matrix @ inertia @ rotation_matrix.T
    expected_kinetic_energy = (
        0.5 * mass * np.dot(linear_velocity, linear_velocity)
        + 0.5 * angular_velocity @ world_inertia @ angular_velocity
    )
    assert np.allclose(actual_kinetic_energy, expected_kinetic_energy, rtol=1.0e-5)
    actual_axis_length = float(model.synreal_affine_body_axis_lengths.numpy()[0])
    assert actual_axis_length == pytest.approx(axis_length, rel=1.0e-5)

    vector_mass_matrix = np.kron(actual_mass_matrix, np.eye(3, dtype=np.float32))
    mass_eigenvalues, mass_eigenvectors = np.linalg.eigh(vector_mass_matrix)
    inverse_sqrt_mass = (
        mass_eigenvectors * np.reciprocal(np.sqrt(mass_eigenvalues))[None, :]
    ) @ mass_eigenvectors.T
    laplacian = 4.0 * np.eye(4, dtype=np.float32) - np.ones((4, 4), dtype=np.float32)
    spring_hessian = np.kron(laplacian, np.eye(3, dtype=np.float32))

    def pull_back_affine_gradient(gradient: np.ndarray) -> np.ndarray:
        point_gradient = np.zeros((4, 3), dtype=np.float64)
        point_gradient[1:] = gradient.T / actual_axis_length
        point_gradient[0] = -np.sum(point_gradient[1:], axis=0)
        return point_gradient

    orthogonality_hessian = np.zeros((12, 12), dtype=np.float64)
    corotated_hessian = np.zeros((12, 12), dtype=np.float64)
    for column in range(12):
        point_increment = np.zeros((4, 3), dtype=np.float64)
        point_increment.reshape(-1)[column] = 1.0
        affine_increment = (
            point_increment[1:] - point_increment[0]
        ).T / actual_axis_length
        orthogonality_gradient = actual_axis_length**2 * (
            affine_increment + affine_increment.T
        )
        corotated_gradient = actual_axis_length**2 * (
            affine_increment
            + affine_increment.T
            + np.trace(affine_increment) * np.eye(3)
        )
        orthogonality_hessian[:, column] = pull_back_affine_gradient(
            orthogonality_gradient
        ).reshape(-1)
        corotated_hessian[:, column] = pull_back_affine_gradient(
            corotated_gradient
        ).reshape(-1)

    scales_and_rest_hessians = (
        (
            float(model.synreal_affine_body_rigidity_scales.numpy()[0]),
            spring_hessian,
        ),
        (
            float(model.synreal_affine_body_orthogonality_scales.numpy()[0]),
            orthogonality_hessian,
        ),
        (
            float(model.synreal_affine_body_corotated_scales.numpy()[0]),
            corotated_hessian,
        ),
    )
    for scale, rest_hessian in scales_and_rest_hessians:
        normalized_rigidity = (
            scale * inverse_sqrt_mass @ rest_hessian @ inverse_sqrt_mass
        )
        assert np.isfinite(scale) and scale > 0.0
        assert np.isclose(
            np.max(np.linalg.eigvalsh(normalized_rigidity)),
            1.0,
            rtol=1.0e-5,
        )


def test_model_builder_groups_replicated_cloth_and_affine_proxies_by_world() -> None:
    from newton.solvers import style3d

    scene = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    newton.solvers.SolverStyle3D.register_custom_attributes(scene)
    style3d.add_cloth_grid(
        scene,
        pos=wp.vec3(0.0),
        rot=wp.quat_identity(),
        dim_x=1,
        dim_y=1,
        cell_x=0.1,
        cell_y=0.1,
        vel=wp.vec3(0.0),
        mass=0.1,
    )
    body = scene.add_body(
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    scene.add_shape_box(body, hx=0.1, hy=0.1, hz=0.1)

    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    newton.solvers.SolverStyle3D.register_custom_attributes(builder)
    builder.replicate(scene, 2)
    model = builder.finalize(device="cpu")

    assert np.array_equal(model.particle_world.numpy(), np.repeat((0, 1), 8))
    assert np.array_equal(
        model.synreal_affine_body_indices.numpy(),
        ((4, 5, 6, 7), (12, 13, 14, 15)),
    )
    assert np.array_equal(
        model.tri_indices.numpy(),
        ((0, 1, 2), (1, 3, 2), (8, 9, 10), (9, 11, 10)),
    )


def test_model_builder_adds_body_point_spring() -> None:
    builder = ModelBuilder(gravity=0.0)
    inertia = wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
    body0 = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    body1 = builder.add_body(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    spring = builder.add_body_spring(
        body0,
        body1,
        point0=(0.25, 0.0, 0.0),
        point1=(-0.25, 0.0, 0.0),
        stiffness=1234.0,
    )

    model = builder.finalize(device="cpu")

    assert spring == 0
    assert np.array_equal(model.synreal_body_spring_indices.numpy(), ((0, 1),))
    assert np.allclose(model.synreal_body_spring_points0.numpy(), ((0.25, 0.0, 0.0),))
    assert np.allclose(model.synreal_body_spring_points1.numpy(), ((-0.25, 0.0, 0.0),))
    assert np.allclose(model.synreal_body_spring_stiffnesses.numpy(), (1234.0,))
    assert np.allclose(model.synreal_body_spring_rest_lengths.numpy(), (1.5,))


def test_model_builder_adds_world_anchored_body_springs() -> None:
    builder = ModelBuilder(gravity=0.0)
    with pytest.raises(ValueError, match="at least one dynamic body"):
        builder.add_body_spring(-1, -1)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    builder.add_body_spring(body, -1, point0=(0.25, 0.0, 0.0), point1=(0.0, 0.0, 0.0))
    builder.add_body_spring(-1, body, point0=(4.0, 0.0, 0.0), point1=(-0.25, 0.0, 0.0))

    model = builder.finalize(device="cpu")

    assert np.array_equal(model.synreal_body_spring_indices.numpy(), ((0, -1), (-1, 0)))
    assert np.allclose(model.synreal_body_spring_rest_lengths.numpy(), (2.25, 2.25))


def test_model_builder_adds_body_distance_constraints() -> None:
    builder = ModelBuilder(gravity=0.0)
    inertia = wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
    body0 = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    body1 = builder.add_body(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    constraint = builder.add_body_distance_constraint(
        body0,
        body1,
        point0=(0.25, 0.0, 0.0),
        point1=(-0.25, 0.0, 0.0),
    )

    model = builder.finalize(device="cpu")

    assert constraint == 0
    assert np.array_equal(
        model.synreal_body_distance_constraint_indices.numpy(), ((0, 1),)
    )
    assert np.allclose(
        model.synreal_body_distance_constraint_points0.numpy(),
        ((0.25, 0.0, 0.0),),
    )
    assert np.allclose(
        model.synreal_body_distance_constraint_points1.numpy(),
        ((-0.25, 0.0, 0.0),),
    )
    assert np.allclose(
        model.synreal_body_distance_constraint_rest_lengths.numpy(), (1.5,)
    )
    assert np.isfinite(model.synreal_body_distance_constraint_weights0.numpy()).all()
    assert np.isfinite(model.synreal_body_distance_constraint_weights1.numpy()).all()


def test_model_builder_adds_world_space_point_line() -> None:
    builder = ModelBuilder(gravity=0.0)
    body = builder.add_body(
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    builder.add_body_point_line(
        body,
        -1,
        line_endpoint0=(-2.0, 0.0, 0.0),
        line_endpoint1=(2.0, 0.0, 0.0),
        stiffness=1234.0,
        damping=56.0,
    )

    model = builder.finalize(device="cpu")

    assert np.array_equal(model.synreal_body_point_line_indices.numpy(), ((0, -1),))
    assert np.allclose(
        model.synreal_body_point_line_endpoints0.numpy(), ((-2.0, 0.0, 0.0),)
    )
    assert np.allclose(
        model.synreal_body_point_line_endpoints1.numpy(), ((2.0, 0.0, 0.0),)
    )
    assert np.allclose(model.synreal_body_point_line_stiffnesses.numpy(), (1234.0,))
    assert np.allclose(model.synreal_body_point_line_dampings.numpy(), (56.0,))


def test_affine_body_pose_reconstruction_uses_proxy_columns() -> None:
    rotation = wp.quat_from_axis_angle(wp.normalize(wp.vec3(1.0, -2.0, 0.5)), 0.7)
    builder = ModelBuilder(gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(-1.0, 2.0, 0.5), rotation),
        com=wp.vec3(0.2, 0.3, -0.1),
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    model = builder.finalize(device="cpu")
    state = model.state()
    state.body_q.zero_()

    wp.launch(
        _update_affine_body_poses,
        dim=1,
        inputs=[
            state.particle_q,
            state.particle_qd,
            model.synreal_affine_body_indices,
            model.synreal_affine_body_ids,
            wp.zeros(1, dtype=wp.int32, device="cpu"),
            model.body_com,
            model.synreal_affine_body_inertia,
            model.synreal_affine_body_axis_lengths,
            int(sr.InertiaMode.MIDPOINT_CAYLEY.value),
            1.0 / 60.0,
        ],
        outputs=[state.body_q, state.body_qd],
        device="cpu",
    )

    recovered_transform = state.body_q.numpy()[body]
    recovered_rotation = np.asarray(
        wp.quat_to_matrix(wp.quat(*recovered_transform[3:7])),
        dtype=np.float32,
    ).reshape(3, 3)
    expected_rotation = np.asarray(
        wp.quat_to_matrix(rotation), dtype=np.float32
    ).reshape(3, 3)
    assert np.allclose(recovered_transform[:3], (-1.0, 2.0, 0.5), atol=1.0e-5)
    assert np.allclose(recovered_rotation, expected_rotation, atol=1.0e-5)


@pytest.mark.parametrize(
    "device",
    (
        "cpu",
        pytest.param(
            "cuda:0",
            marks=pytest.mark.skipif(
                not wp.is_cuda_available(), reason="CUDA unavailable"
            ),
        ),
    ),
)
def test_affine_body_velocity_reconstruction_uses_mass_weighted_rigid_fit(
    device: str,
) -> None:
    rotation = wp.quat_from_axis_angle(wp.normalize(wp.vec3(1.0, -2.0, 0.5)), 0.7)
    linear_velocity = np.array((1.2, -0.4, 0.8), dtype=np.float32)
    velocity_gradient = np.array(
        ((0.3, -1.1, 0.7), (1.5, -0.2, 0.4), (-0.8, 0.6, 0.9)),
        dtype=np.float32,
    )
    inertia = np.array(
        ((5.0, 0.2, 0.0), (0.2, 6.0, 0.1), (0.0, 0.1, 7.0)),
        dtype=np.float32,
    )
    builder = ModelBuilder(gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(-1.0, 2.0, 0.5), rotation),
        com=wp.vec3(0.2, 0.3, -0.1),
        mass=2.0,
        inertia=wp.mat33(inertia),
        lock_inertia=True,
    )
    model = builder.finalize(device=device)
    state = model.state()
    state.body_qd.zero_()
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    axis_length = float(model.synreal_affine_body_axis_lengths.numpy()[0])
    particle_velocities = state.particle_qd.numpy()
    particle_velocities[proxy_indices[0]] = linear_velocity
    for column, particle in enumerate(proxy_indices[1:]):
        particle_velocities[particle] = (
            linear_velocity + axis_length * velocity_gradient[:, column]
        )
    wp.copy(
        state.particle_qd,
        wp.array(particle_velocities, dtype=wp.vec3, device=device),
    )

    wp.launch(
        _update_affine_body_poses,
        dim=1,
        inputs=[
            state.particle_q,
            state.particle_qd,
            model.synreal_affine_body_indices,
            model.synreal_affine_body_ids,
            wp.zeros(1, dtype=wp.int32, device=device),
            model.body_com,
            model.synreal_affine_body_inertia,
            model.synreal_affine_body_axis_lengths,
            int(sr.InertiaMode.NONE.value),
            1.0 / 60.0,
        ],
        outputs=[state.body_q, state.body_qd],
        device=device,
    )

    recovered_velocity = state.body_qd.numpy()[body]
    rotation_matrix = np.asarray(wp.quat_to_matrix(rotation), dtype=np.float32).reshape(
        3, 3
    )
    second_moment = 0.5 * np.trace(inertia) * np.eye(3) - inertia
    coupling = velocity_gradient @ second_moment @ rotation_matrix.T
    angular_momentum = np.array(
        (
            coupling[2, 1] - coupling[1, 2],
            coupling[0, 2] - coupling[2, 0],
            coupling[1, 0] - coupling[0, 1],
        )
    )
    expected_angular_velocity = np.linalg.solve(
        rotation_matrix @ inertia @ rotation_matrix.T,
        angular_momentum,
    )
    assert np.allclose(recovered_velocity[:3], linear_velocity, atol=2.0e-6)
    assert np.allclose(recovered_velocity[3:], expected_angular_velocity, atol=2.0e-6)


def test_affine_body_wrench_is_distributed_to_proxy_particles() -> None:
    positions = wp.array(
        ((0.0, 0.0, 0.0), (2.0, 0.0, 0.0), (0.0, 2.0, 0.0), (0.0, 0.0, 2.0)),
        dtype=wp.vec3,
        device="cpu",
    )
    particle_forces = wp.zeros(4, dtype=wp.vec3, device="cpu")
    body_forces = wp.array(
        (wp.spatial_vector(3.0, -4.0, 5.0, 6.0, 7.0, -8.0),),
        dtype=wp.spatial_vector,
        device="cpu",
    )
    body_indices = wp.array(((0, 1, 2, 3),), dtype=wp.vec4i, device="cpu")
    body_ids = wp.array((0,), dtype=wp.int32, device="cpu")

    wp.launch(
        _scatter_affine_body_forces,
        dim=1,
        inputs=[body_forces, body_indices, body_ids, positions],
        outputs=[particle_forces],
        device="cpu",
    )

    actual_forces = particle_forces.numpy()
    actual_torque = np.sum(np.cross(positions.numpy(), actual_forces), axis=0)
    assert np.allclose(np.sum(actual_forces, axis=0), (3.0, -4.0, 5.0))
    assert np.allclose(actual_torque, (6.0, 7.0, -8.0))


def test_model_builder_rejects_a_second_finalize() -> None:
    builder = ModelBuilder(gravity=0.0)
    builder.add_body(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    builder.finalize(device="cpu")

    with pytest.raises(RuntimeError, match="only be finalized once"):
        builder.finalize(device="cpu")


def test_model_builder_reorders_nonmonotonic_proxy_world_order() -> None:
    builder = ModelBuilder(gravity=0.0)
    for world in range(2):
        builder.begin_world()
        builder.add_particle(
            pos=(0.0, 0.0, float(world)), vel=(0.0, 0.0, 0.0), mass=1.0
        )
        builder.add_body(
            mass=2.0,
            inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
            lock_inertia=True,
        )
        builder.end_world()

    model = builder.finalize(device="cpu")

    assert np.array_equal(model.particle_world.numpy(), np.repeat((0, 1), 5))
    assert np.array_equal(
        model.synreal_affine_body_indices.numpy(),
        ((1, 2, 3, 4), (6, 7, 8, 9)),
    )


def test_model_builder_supports_articulated_dynamic_body() -> None:
    builder = ModelBuilder(gravity=0.0)
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
    )
    builder.add_joint_revolute(parent=-1, child=body, axis=(0.0, 0.0, 1.0))

    model = builder.finalize(device="cpu")

    assert model.joint_count == 1
    assert model.synreal_affine_body_ids.numpy().tolist() == [body]


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_bridges_tetrahedron_model_and_control() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    _add_tetrahedral_cube(
        builder,
        k_mu=1.25e5,
        k_lambda=2.5e5,
        k_damp=750.0,
        add_surface_mesh_edges=True,
    )
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert model.tet_count == 5
    assert model.tri_count > 0
    assert native.tetrahedron_count == model.tet_count
    assert native.tetrahedron_indices.ptr == model.tet_indices.ptr
    assert native.tetrahedron_indices.size == model.tet_count
    assert native.tetrahedron_inverse_dms.ptr == model.tet_poses.ptr
    assert native.tetrahedron_inverse_dms.size == model.tet_count
    assert native.tetrahedron_materials.ptr == model.tet_materials.ptr
    assert native.tetrahedron_materials.size == model.tet_count
    assert native.triangle_count == 0
    assert native.edge_count == 0
    assert native.particle_rest_positions.ptr == model.particle_q.ptr
    assert native.particle_rest_positions.size == model.particle_count
    assert native.collision_triangle_count == model.tri_count
    assert native.collision_triangle_indices.ptr == model.tri_indices.ptr
    assert native.collision_triangle_indices.size == model.tri_count
    assert native.collision_edge_count == model.edge_count
    assert native.collision_edge_count > 0
    assert native.collision_edge_indices.ptr == model.edge_indices.ptr
    assert native.collision_edge_indices.size == model.edge_count

    control = model.control()
    native_control = solver._as_synreal_control(control)
    assert native_control.tetrahedron_activations.ptr == control.tet_activations.ptr
    assert native_control.tetrahedron_activations.size == model.tet_count
    assert solver._as_synreal_control(None).tetrahedron_activations.size == 0


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_bridges_free_collision_particles() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    for index, radius in enumerate((0.02, 0.03, 0.04, np.inf)):
        builder.add_particle(
            pos=(float(index), 0.0, 0.0),
            vel=(0.0, 0.0, 0.0),
            mass=1.0,
            radius=radius,
        )

    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert model.particle_count == 4
    assert native.collision_particle_count == 3
    assert (
        native.collision_particle_indices.ptr == solver._collision_particle_indices.ptr
    )
    assert native.collision_particle_indices.size == 3
    assert np.array_equal(solver._collision_particle_indices.numpy(), (0, 1, 2))


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_excludes_constrained_and_proxy_collision_particles() -> None:
    from newton.solvers import style3d

    tetrahedron_builder = newton.ModelBuilder(
        up_axis=newton.Axis.Z, gravity=wp.vec3(0.0)
    )
    _add_tetrahedral_cube(tetrahedron_builder)
    tetrahedron_model = tetrahedron_builder.finalize(device="cuda:0")

    cloth_builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    newton.solvers.SolverStyle3D.register_custom_attributes(cloth_builder)
    style3d.add_cloth_grid(
        cloth_builder,
        pos=wp.vec3(0.0),
        rot=wp.quat_identity(),
        vel=wp.vec3(0.0),
        dim_x=1,
        dim_y=1,
        cell_x=0.2,
        cell_y=0.2,
        mass=0.1,
        particle_radius=0.02,
    )
    cloth_model = cloth_builder.finalize(device="cuda:0")

    proxy_builder = ModelBuilder(
        up_axis=newton.Axis.Z,
        gravity=wp.vec3(0.0),
        affine_body_particle_radius=0.02,
    )
    proxy_builder.add_body(
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    proxy_model = proxy_builder.finalize(device="cuda:0")

    for model in (tetrahedron_model, cloth_model, proxy_model):
        solver = NewtonSolver(model)
        assert solver.synreal_model.collision_particle_count == 0
        assert solver.synreal_model.collision_particle_indices.size == 0
        assert len(solver._collision_particle_indices) == 0


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_shares_replicated_collision_particle_indices() -> None:
    world_count = 3
    scene = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    for index, radius in enumerate((0.03, 0.0, 0.04)):
        scene.add_particle(
            pos=(float(index), 0.0, 0.0),
            vel=(0.0, 0.0, 0.0),
            mass=1.0,
            radius=radius,
        )
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    builder.replicate(
        scene,
        world_count,
        xforms=[wp.transform_identity()] * world_count,
    )

    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert native.world_count == world_count
    assert native.particle_count == 3
    assert native.particle_state_count == 3 * world_count
    assert native.collision_particle_count == 2
    assert (
        native.collision_particle_indices.ptr == solver._collision_particle_indices.ptr
    )
    assert native.collision_particle_indices.size == 2
    assert np.array_equal(
        solver._collision_particle_indices.numpy(),
        (0, 2, 3, 5, 6, 8),
    )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_rejects_generic_surface_elasticity() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    _add_tetrahedral_cube(builder, tri_ke=1.0)
    model = builder.finalize(device="cuda:0")

    with pytest.raises(NotImplementedError, match="surface elasticity"):
        NewtonSolver(model)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_tetrahedron_recovers_from_deformation() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    _add_tetrahedral_cube(builder)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)

    rest_positions = state_in.particle_q.numpy().copy()
    center = np.mean(rest_positions, axis=0)
    deformation = np.array(
        (
            (1.35, 0.15, 0.0),
            (0.0, 0.75, 0.10),
            (0.05, 0.0, 1.15),
        ),
        dtype=np.float32,
    )
    deformed_positions = center + (deformation @ (rest_positions - center).T).T
    _set_particle_positions(state_in, deformed_positions, model.device)
    state_in.particle_qd.zero_()
    initial_error = _tetrahedron_deformation_error(model, deformed_positions)
    errors = []

    for _ in range(30):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in
        wp.synchronize_device(model.device)
        positions = state_in.particle_q.numpy()
        assert np.isfinite(positions).all()
        errors.append(_tetrahedron_deformation_error(model, positions))

    assert min(errors) < 0.9 * initial_error


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("world_count", (2, 4))
def test_newton_solver_shares_replicated_tetrahedron_data(world_count: int) -> None:
    scene = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    _add_tetrahedral_cube(scene)
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    builder.replicate(
        scene,
        world_count,
        xforms=[wp.transform_identity()] * world_count,
    )
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert native.world_count == world_count
    assert native.particle_count == model.particle_count // world_count
    assert native.particle_state_count == model.particle_count
    assert native.tetrahedron_count == model.tet_count // world_count
    assert native.tetrahedron_indices.ptr == model.tet_indices.ptr
    assert native.tetrahedron_inverse_dms.ptr == model.tet_poses.ptr
    assert native.tetrahedron_materials.ptr == model.tet_materials.ptr
    assert native.triangle_count == 0
    assert native.edge_count == 0
    assert native.particle_rest_positions.ptr == model.particle_q.ptr
    assert native.particle_rest_positions.size == model.particle_count
    assert native.collision_triangle_count == model.tri_count // world_count
    assert native.collision_triangle_indices.ptr == model.tri_indices.ptr
    assert native.collision_edge_count == model.edge_count // world_count == 0

    control = model.control()
    native_control = solver._as_synreal_control(control)
    assert native_control.tetrahedron_activations.size == model.tet_count

    state_in = model.state()
    state_out = model.state()
    solver.step(state_in, state_out, control, None, 1.0 / 240.0)
    wp.synchronize_device(model.device)
    particles = state_out.particle_q.numpy().reshape(world_count, -1, 3)
    assert np.isfinite(particles).all()
    for world in range(1, world_count):
        assert np.allclose(particles[world], particles[0], atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_bridges_particle_states() -> None:
    builder = newton.ModelBuilder()
    for index in range(3):
        builder.add_particle(
            pos=(0.0, 0.0, float(index)),
            vel=(0.0, 0.0, 0.0),
            mass=1.0,
            radius=0.01,
        )

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)

    positions_before = state_in.particle_q.numpy().copy()
    solver.step(state_in, state_out, None, None, 1.0 / 60.0)

    assert not (state_out.particle_q.numpy() == positions_before).all()


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_resolves_morton_reversed_particle_pair() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    authored_positions = _add_morton_reversed_overlapping_particles(builder)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.enable_self_collision = True
    solver.config.self_collision_particle_particle_stiffness = 2.0
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15

    initial_positions = state_in.particle_q.numpy().copy()
    initial_distance = float(
        np.linalg.norm(initial_positions[0] - initial_positions[1])
    )
    initial_pair_center = np.mean(initial_positions[:2], axis=0)
    assert np.all(authored_positions[1] < authored_positions[0])
    assert initial_distance < 0.12

    state_in.clear_forces()
    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    positions = state_out.particle_q.numpy()
    velocities = state_out.particle_qd.numpy()
    final_distance = float(np.linalg.norm(positions[0] - positions[1]))
    assert np.isfinite(positions).all()
    assert final_distance > initial_distance + 1.0e-4
    assert np.allclose(np.mean(positions[:2], axis=0), initial_pair_center, atol=1.0e-6)
    assert np.allclose(np.sum(velocities[:2], axis=0), 0.0, atol=1.0e-5)
    assert np.allclose(positions[2:], initial_positions[2:], atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("world_count", (1, 3))
def test_newton_solver_free_fall_matches_symplectic_inertial_prediction(
    world_count: int,
) -> None:
    gravity = -9.81
    dt = 1.0 / 120.0
    if world_count == 1:
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=gravity)
        builder.add_particle(pos=(0.0, 0.0, 1.0), vel=(0.0, 0.0, 2.0), mass=1.0)
    else:
        scene = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=gravity)
        scene.add_particle(pos=(0.0, 0.0, 1.0), vel=(0.0, 0.0, 2.0), mass=1.0)
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=gravity)
        builder.replicate(scene, world_count)

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    state_in.clear_forces()
    solver.step(state_in, state_out, None, None, dt)
    wp.synchronize_device(model.device)

    expected_position = 1.0 + 2.0 * dt + gravity * dt * dt
    expected_velocity = 2.0 + gravity * dt
    positions = state_out.particle_q.numpy()
    velocities = state_out.particle_qd.numpy()
    assert np.allclose(positions[:, :2], 0.0, atol=1.0e-6)
    assert np.allclose(positions[:, 2], expected_position, rtol=1.0e-5, atol=1.0e-6)
    assert np.allclose(velocities[:, :2], 0.0, atol=1.0e-6)
    assert np.allclose(velocities[:, 2], expected_velocity, rtol=1.0e-5, atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_syncs_nonzero_fk_state_to_affine_proxies() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(0.02, 0.0, 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 0.04),
        lock_inertia=True,
    )
    joint = builder.add_joint_revolute(
        parent=-1,
        child=body,
        axis=(0.0, 0.0, 1.0),
        target_ke=0.0,
        target_kd=0.0,
        damping=0.0,
    )
    builder.add_articulation([joint])
    builder.joint_q[0] = 0.8
    builder.joint_qd[0] = -0.6
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)
    state = model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state)

    indices = solver._affine_body_indices.numpy()[0]
    before = state.particle_q.numpy()[indices].copy()
    solver.sync_affine_body_state(state)
    wp.synchronize_device(model.device)
    after = state.particle_q.numpy()[indices]
    velocities = state.particle_qd.numpy()[indices]
    pose = state.body_q.numpy()[body]
    twist = state.body_qd.numpy()[body]
    rotation = np.asarray(
        wp.quat_to_matrix(wp.quat(*pose[3:7])), dtype=np.float32
    ).reshape(3, 3)
    world_com = pose[:3] + rotation @ solver._affine_body_com.numpy()[0]
    lengths = np.linalg.norm(
        model.particle_q.numpy()[indices[1:]] - model.particle_q.numpy()[indices[0]],
        axis=1,
    )
    offsets = (rotation @ np.diag(lengths)).T
    expected_positions = np.vstack((world_com, world_com + offsets))
    expected_velocities = twist[:3] + np.cross(twist[3:], np.vstack((np.zeros(3), offsets)))

    assert np.max(np.abs(before - expected_positions)) > 1.0e-2
    assert np.allclose(after, expected_positions, atol=1.0e-6)
    assert np.allclose(velocities, expected_velocities, atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_affine_state_sync_supports_cuda_graph_capture() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_link(
        mass=1.0,
        inertia=wp.mat33(0.1, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.1),
        lock_inertia=True,
    )
    joint = builder.add_joint_revolute(parent=-1, child=body, axis=(0.0, 1.0, 0.0))
    builder.add_articulation([joint])
    builder.joint_q[0] = -0.7
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    state = model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state)
    stream = wp.get_stream(model.device)

    with wp.ScopedCapture(stream=stream) as capture:
        solver.sync_affine_body_state(state)

    state.particle_q.zero_()
    state.particle_qd.zero_()
    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)

    indices = solver._affine_body_indices.numpy()[0]
    points = state.particle_q.numpy()[indices]
    assert np.isfinite(points).all()
    assert np.linalg.norm(points[1] - points[0]) > 1.0e-3


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize(
    ("joint_kind", "expected_springs", "expected_lines"),
    (
        ("free", 0, 0),
        ("fixed", 3, 0),
        ("ball", 1, 0),
        ("revolute", 2, 0),
        ("prismatic", 0, 4),
        ("cylindrical", 0, 2),
    ),
)
def test_newton_solver_joint_constraint_topology_matrix(
    joint_kind: str,
    expected_springs: int,
    expected_lines: int,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    identity = wp.transform_identity()
    if joint_kind == "free":
        joint = builder.add_joint_free(child=body)
    elif joint_kind == "fixed":
        parent = builder.add_body(
            mass=2.0,
            inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
            lock_inertia=True,
        )
        joint = builder.add_joint_fixed(parent=parent, child=body, child_xform=identity)
    elif joint_kind == "ball":
        joint = builder.add_joint_ball(parent=-1, child=body, child_xform=identity)
    elif joint_kind == "revolute":
        joint = builder.add_joint_revolute(
            parent=-1, child=body, axis=(0.0, 0.0, 1.0), child_xform=identity
        )
    elif joint_kind == "prismatic":
        joint = builder.add_joint_prismatic(
            parent=-1, child=body, axis=(1.0, 0.0, 0.0), child_xform=identity
        )
    else:
        axis = builder.JointDofConfig.create_unlimited(newton.Axis.X)
        joint = builder.add_joint_d6(
            parent=-1,
            child=body,
            linear_axes=[axis],
            angular_axes=[axis],
            child_xform=identity,
        )
    builder.add_articulation([joint])

    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)

    assert solver.synreal_model.joint_body_spring_count == expected_springs
    assert solver.synreal_model.joint_body_point_line_count == expected_lines


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_rejects_invalid_joint_constraint_mode_at_step() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    builder.add_particle(pos=(0.0, 0.0, 0.0), vel=(0.0, 0.0, 0.0), mass=1.0)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    solver.config.joint_constraint_mode = sr.JointConstraintMode(99)

    with pytest.raises(ValueError, match="config.joint_constraint_mode is invalid"):
        solver.step(model.state(), model.state(), None, None, 1.0 / 60.0)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_rejects_nonzero_joint_spring_rest_length() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    joint = builder.add_joint_ball(parent=-1, child=body)
    builder.add_articulation([joint])
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    joint_spring_start = (
        solver.synreal_model.body_spring_count
        - solver.synreal_model.joint_body_spring_count
    )
    rest_lengths = solver._body_spring_rest_lengths.numpy()
    rest_lengths[joint_spring_start:] = 1.0
    solver._body_spring_rest_lengths = wp.array(
        rest_lengths, dtype=wp.float32, device=model.device
    )

    with pytest.raises(
        ValueError, match="joint-generated body springs must have zero rest length"
    ):
        solver._initialize_synreal_solver()


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize(
    "joint_kind",
    ("free", "fixed", "ball", "revolute", "prismatic", "cylindrical"),
)
def test_joint_augmented_lagrangian_supported_joint_smoke(joint_kind: str) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    identity = wp.transform_identity()
    if joint_kind == "free":
        joint = builder.add_joint_free(child=body)
    elif joint_kind == "fixed":
        parent = builder.add_link(
            mass=2.0,
            inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
            lock_inertia=True,
        )
        joint = builder.add_joint_fixed(parent=parent, child=body, child_xform=identity)
    elif joint_kind == "ball":
        joint = builder.add_joint_ball(parent=-1, child=body, child_xform=identity)
    elif joint_kind == "revolute":
        joint = builder.add_joint_revolute(
            parent=-1, child=body, axis=(0.0, 0.0, 1.0), child_xform=identity
        )
    elif joint_kind == "prismatic":
        joint = builder.add_joint_prismatic(
            parent=-1, child=body, axis=(1.0, 0.0, 0.0), child_xform=identity
        )
    else:
        axis = builder.JointDofConfig.create_unlimited(newton.Axis.X)
        joint = builder.add_joint_d6(
            parent=-1,
            child=body,
            linear_axes=[axis],
            angular_axes=[axis],
            child_xform=identity,
        )
    builder.add_articulation([joint])

    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    solver.config.joint_constraint_mode = (
        sr.JointConstraintMode.AUGMENTED_LAGRANGIAN
    )
    solver.config.nonlinear_iterations = 2
    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)

    solver.step(state_in, state_out, model.control(), None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    assert np.isfinite(state_out.particle_q.numpy()).all()
    assert np.isfinite(state_out.particle_qd.numpy()).all()
    assert np.isfinite(state_out.body_q.numpy()).all()
    assert np.isfinite(state_out.body_qd.numpy()).all()


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_joint_constraint_modes_reuse_assembled_constraints() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    parent = builder.add_body(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    child = builder.add_body(
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    revolute = builder.add_joint_revolute(
        parent=-1,
        child=parent,
        axis=(0.0, 0.0, 1.0),
        child_xform=wp.transform_identity(),
    )
    prismatic = builder.add_joint_prismatic(
        parent=parent,
        child=child,
        axis=(1.0, 0.0, 0.0),
        child_xform=wp.transform_identity(),
    )
    builder.add_articulation([revolute, prismatic])
    solver = NewtonSolver(builder.finalize(device="cuda:0"))

    def assembled_constraint_layout() -> tuple[object, ...]:
        model = solver.synreal_model
        spans = (
            model.body_spring_indices,
            model.body_spring_stiffnesses,
            model.body_spring_rest_lengths,
            model.body_point_line_indices,
            model.body_point_line_stiffnesses,
            model.body_point_line_dampings,
        )
        return (
            model.body_spring_count,
            model.joint_body_spring_count,
            model.body_point_line_count,
            model.joint_body_point_line_count,
            *((span.ptr, len(span)) for span in spans),
        )

    assembled_constraints = assembled_constraint_layout()

    assert solver.config.joint_constraint_mode == sr.JointConstraintMode.PENALTY
    assert solver.synreal_model.body_spring_count == 2
    assert solver.synreal_model.joint_body_spring_count == 2
    assert solver.synreal_model.body_point_line_count == 4
    assert solver.synreal_model.joint_body_point_line_count == 4

    solver.config.joint_constraint_mode = sr.JointConstraintMode.AUGMENTED_LAGRANGIAN

    assert (
        solver.config.joint_constraint_mode
        == sr.JointConstraintMode.AUGMENTED_LAGRANGIAN
    )
    assert assembled_constraint_layout() == assembled_constraints


def _loaded_joint_transverse_displacement(
    joint_kind: str,
    mode: sr.JointConstraintMode,
    nonlinear_iterations: int,
) -> float:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(0.02, 0.0, 0.0, 0.0, 0.04, 0.0, 0.0, 0.0, 0.03),
        lock_inertia=True,
    )
    if joint_kind == "revolute":
        joint = builder.add_joint_revolute(
            parent=-1,
            child=body,
            axis=(0.0, 1.0, 0.0),
            target_ke=0.0,
            target_kd=0.0,
            damping=0.0,
        )
    elif joint_kind == "prismatic":
        joint = builder.add_joint_prismatic(
            parent=-1,
            child=body,
            axis=(0.0, 1.0, 0.0),
            target_ke=0.0,
            target_kd=0.0,
            damping=0.0,
        )
    else:
        raise AssertionError(f"unsupported test joint: {joint_kind}")
    builder.add_articulation([joint])

    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)
    solver.config.joint_constraint_mode = mode
    solver.config.joint_constraint_alpha = 10.0
    solver.config.nonlinear_iterations = nonlinear_iterations
    solver.config.linear_iterations = 100
    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)
    state_in.body_f.fill_(wp.spatial_vector(1.0e3, 0.0, 0.0, 0.0, 0.0, 0.0))

    solver.step(state_in, state_out, model.control(), None, 0.01)
    wp.synchronize_device(model.device)
    return float(state_out.body_q.numpy()[body, 0])


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("joint_kind", ("revolute", "prismatic"))
def test_joint_augmented_lagrangian_reduces_loaded_constraint_error(
    joint_kind: str,
) -> None:
    penalty_first = _loaded_joint_transverse_displacement(
        joint_kind, sr.JointConstraintMode.PENALTY, 1
    )
    augmented_first = _loaded_joint_transverse_displacement(
        joint_kind, sr.JointConstraintMode.AUGMENTED_LAGRANGIAN, 1
    )
    penalty_converged = _loaded_joint_transverse_displacement(
        joint_kind, sr.JointConstraintMode.PENALTY, 10
    )
    augmented_converged = _loaded_joint_transverse_displacement(
        joint_kind, sr.JointConstraintMode.AUGMENTED_LAGRANGIAN, 10
    )

    # The first AL primal iteration is exactly the legacy penalty solve. Further
    # AL dual updates should remove most of the loaded transverse joint error.
    assert np.isclose(augmented_first, penalty_first, rtol=2.0e-4, atol=2.0e-7)
    assert abs(augmented_converged) < 0.2 * abs(penalty_converged)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_replicated_world_joint_constraints_keep_full_layout() -> None:
    scene = ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    body = scene.add_link(
        mass=2.0,
        inertia=wp.mat33(0.02, 0.0, 0.0, 0.0, 0.04, 0.0, 0.0, 0.0, 0.03),
        lock_inertia=True,
    )
    joint = scene.add_joint_revolute(
        parent=-1,
        child=body,
        axis=(0.0, 1.0, 0.0),
        target_ke=0.0,
        target_kd=0.0,
        damping=0.0,
    )
    scene.add_articulation([joint])
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    builder.replicate(scene, 2)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)

    assert solver.synreal_model.world_count == 1
    assert solver.synreal_model.particle_count == model.particle_count
    assert solver.synreal_model.body_spring_count == len(
        solver._body_spring_indices
    )
    assert solver.synreal_model.joint_body_spring_count == (
        solver._joint_body_spring_count
    )

    solver.config.joint_constraint_mode = (
        sr.JointConstraintMode.AUGMENTED_LAGRANGIAN
    )
    solver.config.nonlinear_iterations = 2
    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)
    solver.step(state_in, state_out, model.control(), None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    assert np.isfinite(state_out.body_q.numpy()).all()


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("armature", (0.0, 0.01))
def test_newton_solver_regularizes_active_joint_drive_inertia(armature: float) -> None:
    mass = 2.0
    inertia = np.diag((0.02, 0.03, 0.04)).astype(np.float32)
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_link(
        mass=mass,
        inertia=wp.mat33(inertia),
        lock_inertia=True,
    )
    joint = builder.add_joint_revolute(
        parent=-1,
        child=body,
        axis=(0.0, 0.0, 1.0),
        target_ke=150.0,
        target_kd=5.0,
        actuator_mode=newton.JointTargetMode.POSITION,
    )
    builder.add_articulation([joint])
    model = builder.finalize(device="cuda:0")
    authored_inertia = model.body_inertia.numpy()[body].copy()

    solver = NewtonSolver(model, joint_drive_armature=armature)

    expected_inertia = inertia + armature * np.eye(3, dtype=np.float32)
    actual_inertia = solver._affine_body_inertia.numpy()[0]
    proxy_indices = solver._affine_body_indices.numpy()[0]
    proxy_positions = model.particle_q.numpy()[proxy_indices]
    actual_axis_lengths = np.linalg.norm(
        proxy_positions[1:] - proxy_positions[0], axis=1
    )
    second_moment = 0.5 * np.trace(expected_inertia) * np.eye(3) - expected_inertia
    expected_axis_length = np.sqrt(np.trace(second_moment) / (3.0 * mass))

    assert np.array_equal(model.body_inertia.numpy()[body], authored_inertia)
    assert np.allclose(actual_inertia, expected_inertia)
    assert np.allclose(actual_axis_lengths, expected_axis_length)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_angular_joint_drive_balances_force_on_each_body() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    inertia = wp.mat33(0.02, 0.0, 0.0, 0.0, 0.04, 0.0, 0.0, 0.0, 0.03)
    parent = builder.add_link(mass=2.0, inertia=inertia, lock_inertia=True)
    child = builder.add_link(mass=2.0, inertia=inertia, lock_inertia=True)
    joint = builder.add_joint_revolute(
        parent=parent,
        child=child,
        axis=(0.0, 1.0, 0.0),
        target_pos=0.2,
        target_ke=150.0,
        target_kd=5.0,
        damping=0.0,
        actuator_mode=newton.JointTargetMode.POSITION,
    )
    builder.add_articulation([joint])
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model, joint_damping=0.0, joint_drive_armature=0.0)
    solver.config.joint_constraint_alpha = 0.0
    solver.config.nonlinear_iterations = 1
    solver.config.linear_iterations = 100

    state_in, state_out = model.state(), model.state()
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_in)
    newton.eval_fk(model, model.joint_q, model.joint_qd, state_out)
    solver.sync_affine_body_state(state_in)
    solver.sync_affine_body_state(state_out)
    wp.synchronize_device(model.device)

    # Separate the joint origins to cover the configuration where the former
    # cross-body spring representation generated a spurious resultant force.
    affine_body_ids = solver._affine_body_ids.numpy()
    affine_bodies = solver._affine_body_indices.numpy()
    parent_affine = int(np.flatnonzero(affine_body_ids == parent)[0])
    child_affine = int(np.flatnonzero(affine_body_ids == child)[0])
    child_particles = affine_bodies[child_affine]
    for state in (state_in, state_out):
        positions = state.particle_q.numpy()
        positions[child_particles] += np.array((0.01, 0.02, 0.0), dtype=np.float32)
        _set_particle_positions(state, positions, model.device)

    control = model.control()
    control.joint_f.fill_(1.0)
    wp.copy(control.joint_target_q, model.joint_target_q)
    wp.copy(control.joint_target_qd, model.joint_target_qd)
    state_in.clear_forces()
    solver.step(state_in, state_out, control, None, 1.0e-3)
    wp.synchronize_device(model.device)

    proxy_velocities = state_out.particle_qd.numpy()
    center_velocities = proxy_velocities[
        affine_bodies[[parent_affine, child_affine], 0]
    ]
    assert np.allclose(center_velocities, 0.0, atol=1.0e-6)

    angular_velocities = state_out.body_qd.numpy()[[parent, child], 3:]
    assert angular_velocities[0, 1] < 0.0
    assert angular_velocities[1, 1] > 0.0


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_regularizes_prebuilt_affine_proxy_mass() -> None:
    inertia = np.diag((0.02, 0.03, 0.04)).astype(np.float32)
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_link(
        mass=2.0,
        inertia=wp.mat33(inertia),
        lock_inertia=True,
    )
    joint = builder.add_joint_revolute(
        parent=-1,
        child=body,
        axis=(0.0, 0.0, 1.0),
        target_ke=150.0,
        target_kd=5.0,
        actuator_mode=newton.JointTargetMode.POSITION,
    )
    builder.add_articulation([joint])
    model = builder.finalize(device="cuda:0")
    authored_proxy_inertia = model.synreal_affine_body_inertia.numpy().copy()
    authored_scales = (
        model.synreal_affine_body_rigidity_scales.numpy().copy(),
        model.synreal_affine_body_axis_lengths.numpy().copy(),
        model.synreal_affine_body_orthogonality_scales.numpy().copy(),
        model.synreal_affine_body_corotated_scales.numpy().copy(),
    )
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    disturbed_positions = model.particle_q.numpy().copy()
    disturbed_positions[proxy_indices] = _deform_affine_frame(
        disturbed_positions[proxy_indices]
    )
    _set_particle_positions(model, disturbed_positions, model.device)

    solver = NewtonSolver(model, joint_drive_armature=0.01)

    expected_inertia = inertia + 0.01 * np.eye(3, dtype=np.float32)
    expected_axis_length, expected_mass_matrix, expected_spring_scale = (
        ModelBuilder._proxy_mass_matrix(
            body,
            2.0,
            expected_inertia,
            axis_length=float(authored_scales[1][0]),
        )
    )
    expected_orthogonality_scale, expected_corotated_scale = (
        ModelBuilder._alternative_rigidity_scales(
            body, expected_mass_matrix, expected_axis_length
        )
    )
    assert np.array_equal(
        model.synreal_affine_body_inertia.numpy(), authored_proxy_inertia
    )
    for authored, current in zip(
        authored_scales,
        (
            model.synreal_affine_body_rigidity_scales.numpy(),
            model.synreal_affine_body_axis_lengths.numpy(),
            model.synreal_affine_body_orthogonality_scales.numpy(),
            model.synreal_affine_body_corotated_scales.numpy(),
        ),
    ):
        assert np.array_equal(current, authored)
    assert np.allclose(solver._affine_body_inertia.numpy()[0], expected_inertia)
    assert solver._affine_body_rigidity_scales.numpy()[0] == pytest.approx(
        expected_spring_scale
    )
    assert solver._affine_body_axis_lengths.numpy()[0] == pytest.approx(
        expected_axis_length
    )
    assert solver._affine_body_orthogonality_scales.numpy()[0] == pytest.approx(
        expected_orthogonality_scale
    )
    assert solver._affine_body_corotated_scales.numpy()[0] == pytest.approx(
        expected_corotated_scale
    )
    assert (
        solver.synreal_model.affine_body_rigidity_scales.ptr
        == solver._affine_body_rigidity_scales.ptr
    )
    assert (
        solver.synreal_model.affine_body_axis_lengths.ptr
        == solver._affine_body_axis_lengths.ptr
    )
    assert (
        solver.synreal_model.affine_body_orthogonality_scales.ptr
        == solver._affine_body_orthogonality_scales.ptr
    )
    assert (
        solver.synreal_model.affine_body_corotated_scales.ptr
        == solver._affine_body_corotated_scales.ptr
    )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_advances_style3d_cloth_without_collisions() -> None:
    from newton.solvers import style3d

    builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
    newton.solvers.SolverStyle3D.register_custom_attributes(builder)
    style3d.add_cloth_grid(
        builder,
        pos=wp.vec3(0.0, 0.0, 2.0),
        rot=wp.quat_identity(),
        dim_x=4,
        dim_y=3,
        cell_x=0.1,
        cell_y=0.1,
        vel=wp.vec3(0.0),
        mass=0.1,
        fix_left=True,
        tri_aniso_ke=wp.vec3(1.0e4, 1.0e4, 1.0e3),
        edge_aniso_ke=wp.vec3(2.0e-6, 1.0e-6, 5.0e-6),
    )

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    initial_positions = state_in.particle_q.numpy().copy()

    for _ in range(4):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 120.0)
        state_in, state_out = state_out, state_in

    positions = state_in.particle_q.numpy()
    masses = model.particle_mass.numpy()
    fixed = masses <= 0.0
    free = masses > 0.0

    assert np.isfinite(positions).all()
    assert np.allclose(positions[fixed], initial_positions[fixed])
    assert np.mean(positions[free, 2] - initial_positions[free, 2]) < 0.0


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_particle_cloth_vertex_face_collision_is_bidirectional() -> None:
    from newton.solvers import style3d

    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    newton.solvers.SolverStyle3D.register_custom_attributes(builder)
    style3d.add_cloth_grid(
        builder,
        pos=wp.vec3(0.0),
        rot=wp.quat_identity(),
        vel=wp.vec3(0.0),
        dim_x=1,
        dim_y=1,
        cell_x=0.4,
        cell_y=0.4,
        mass=0.1,
        tri_aniso_ke=wp.vec3(5.0e3, 5.0e3, 1.0e3),
        edge_aniso_ke=wp.vec3(1.0e-5),
        particle_radius=0.02,
    )
    cloth_count = len(builder.particle_q)
    collision_particle = builder.add_particle(
        pos=(0.1, 0.1, 0.04),
        vel=(0.0, 0.0, 0.0),
        mass=0.1,
        radius=0.08,
    )

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.enable_self_collision = True
    solver.config.self_collision_radius = 0.02
    solver.config.self_collision_vertex_face_stiffness = 2.0
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15

    assert solver.synreal_model.collision_particle_count == 1
    assert np.array_equal(
        solver._collision_particle_indices.numpy(),
        (collision_particle,),
    )

    initial_positions = state_in.particle_q.numpy().copy()
    state_in.clear_forces()
    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    positions = state_out.particle_q.numpy()
    particle_vertical_motion = (
        positions[collision_particle, 2] - initial_positions[collision_particle, 2]
    )
    cloth_vertical_motion = (
        positions[:cloth_count, 2] - initial_positions[:cloth_count, 2]
    )
    assert np.isfinite(positions).all()
    assert particle_vertical_motion > 1.0e-5
    assert np.mean(cloth_vertical_motion) < -1.0e-6


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_supports_scoped_capture() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
    for index in range(3):
        builder.add_particle(
            pos=(0.0, 0.0, 1.0 + float(index)),
            vel=(0.0, 0.0, 0.0),
            mass=1.0,
            radius=0.01,
        )

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    stream = wp.get_stream(model.device)
    initial_positions = state_in.particle_q.numpy().copy()

    with wp.ScopedCapture(stream=stream) as capture:
        solver.step(state_in, state_out, None, None, 1.0 / 60.0)

    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)
    positions = state_out.particle_q.numpy()

    assert np.isfinite(positions).all()
    assert np.mean(positions[:, 2] - initial_positions[:, 2]) < 0.0


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_particle_self_collision_supports_capture_replay() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    _add_morton_reversed_overlapping_particles(builder)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.enable_self_collision = True
    solver.config.self_collision_particle_particle_stiffness = 2.0
    stream = wp.get_stream(model.device)
    initial_positions = state_in.particle_q.numpy().copy()
    initial_distance = float(
        np.linalg.norm(initial_positions[0] - initial_positions[1])
    )
    state_in.clear_forces()

    with wp.ScopedCapture(stream=stream) as capture:
        solver.step(state_in, state_out, None, None, 1.0 / 120.0)

    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)
    first_replay_positions = state_out.particle_q.numpy().copy()
    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)
    second_replay_positions = state_out.particle_q.numpy()

    assert np.isfinite(second_replay_positions).all()
    assert (
        np.linalg.norm(second_replay_positions[0] - second_replay_positions[1])
        > initial_distance + 1.0e-4
    )
    assert np.allclose(second_replay_positions, first_replay_positions, atol=1.0e-6)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_affine_body_rigidity_models_are_stationary_at_rest_and_restore_frames(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    builder.add_body(
        mass=2.0,
        inertia=wp.mat33(3.0, 0.0, 0.0, 0.0, 4.0, 0.0, 0.0, 0.0, 5.0),
        lock_inertia=True,
    )
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    axis_length = float(model.synreal_affine_body_axis_lengths.numpy()[0])

    rest_in = model.state()
    rest_out = model.state()
    rest_positions = rest_in.particle_q.numpy().copy()
    rest_in.clear_forces()
    solver.step(rest_in, rest_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    stationary_positions = rest_out.particle_q.numpy()
    assert np.allclose(stationary_positions, rest_positions, atol=2.0e-6)
    assert (
        _affine_frame_rigidity_error(stationary_positions[proxy_indices], axis_length)
        < 2.0e-5
    )

    deformed_in = model.state()
    deformed_out = model.state()
    positions = deformed_in.particle_q.numpy().copy()
    positions[proxy_indices] = _deform_affine_frame(positions[proxy_indices])
    initial_error = _affine_frame_rigidity_error(positions[proxy_indices], axis_length)
    _set_particle_positions(deformed_in, positions, model.device)
    deformed_in.clear_forces()
    solver.step(deformed_in, deformed_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    final_positions = deformed_out.particle_q.numpy()[proxy_indices]
    final_error = _affine_frame_rigidity_error(final_positions, axis_length)
    assert np.isfinite(final_positions).all()
    assert final_error < 0.25 * initial_error


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_affine_body_rigidity_model_can_switch_between_steps() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    builder.add_body(
        mass=2.0,
        inertia=wp.mat33(3.0, 0.0, 0.0, 0.0, 4.0, 0.0, 0.0, 0.0, 5.0),
        lock_inertia=True,
    )
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    axis_length = float(model.synreal_affine_body_axis_lengths.numpy()[0])
    rest_positions = model.particle_q.numpy().copy()
    deformed_positions = rest_positions.copy()
    deformed_positions[proxy_indices] = _deform_affine_frame(
        deformed_positions[proxy_indices]
    )
    initial_error = _affine_frame_rigidity_error(
        deformed_positions[proxy_indices], axis_length
    )
    responses = []

    for rigidity_model in (
        sr.AffineBodyRigidityModel.CO_ROTATED,
        sr.AffineBodyRigidityModel.ABD_ORTHOGONALITY,
        sr.AffineBodyRigidityModel.SIX_SPRINGS,
    ):
        state_in = model.state()
        state_out = model.state()
        _set_particle_positions(state_in, deformed_positions, model.device)
        state_in.clear_forces()
        solver.config.affine_body_rigidity_model = rigidity_model
        solver.step(state_in, state_out, None, None, 1.0 / 120.0)
        wp.synchronize_device(model.device)
        response = state_out.particle_q.numpy()[proxy_indices].copy()
        responses.append(response)
        assert _affine_frame_rigidity_error(response, axis_length) < initial_error

    for first in range(len(responses)):
        for second in range(first + 1, len(responses)):
            assert np.linalg.norm(responses[first] - responses[second]) > 1.0e-5


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_affine_body_rigidity_models_are_world_local_when_replicated(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    world_count = 3
    scene = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    scene.add_body(
        mass=2.0,
        inertia=wp.mat33(3.0, 0.0, 0.0, 0.0, 4.0, 0.0, 0.0, 0.0, 5.0),
        lock_inertia=True,
    )
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    builder.replicate(scene, world_count)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15
    proxy_indices = model.synreal_affine_body_indices.numpy()
    axis_lengths = model.synreal_affine_body_axis_lengths.numpy()
    state_in = model.state()
    state_out = model.state()
    initial_positions = state_in.particle_q.numpy().copy()
    positions = initial_positions.copy()
    deformed_world = 1
    deformed_indices = proxy_indices[deformed_world]
    positions[deformed_indices] = _deform_affine_frame(positions[deformed_indices])
    initial_error = _affine_frame_rigidity_error(
        positions[deformed_indices], float(axis_lengths[deformed_world])
    )
    _set_particle_positions(state_in, positions, model.device)
    state_in.clear_forces()

    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    final_positions = state_out.particle_q.numpy()
    assert solver.synreal_model.world_count == world_count
    assert solver.synreal_model.body_count == 1
    assert solver.synreal_model.body_state_count == world_count
    for world, indices in enumerate(proxy_indices):
        frame = final_positions[indices]
        assert np.isfinite(frame).all()
        if world == deformed_world:
            assert (
                _affine_frame_rigidity_error(frame, float(axis_lengths[deformed_world]))
                < initial_error
            )
        else:
            assert np.allclose(
                frame,
                initial_positions[indices],
                rtol=0.0,
                atol=1.0e-6,
            )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_newton_solver_updates_affine_body_pose_during_capture(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, 1.0), wp.quat_identity()),
        mass=2.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    builder.body_qd[body] = wp.spatial_vector(0.0, 0.0, 0.0, 0.0, 2.0, 0.0)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    assert (
        solver.synreal_model.particle_masses.ptr
        == model.synreal_particle_mass_diagonal.ptr
    )
    assert solver.synreal_model.particle_mass_non_diagonal_count == len(
        model.synreal_particle_mass_non_diagonal_indices
    )
    assert (
        solver.synreal_model.particle_mass_non_diagonal_indices.ptr
        == model.synreal_particle_mass_non_diagonal_indices.ptr
    )
    assert (
        solver.synreal_model.particle_mass_non_diagonal_values.ptr
        == model.synreal_particle_mass_non_diagonal_values.ptr
    )
    stream = wp.get_stream(model.device)
    initial_pose = state_in.body_q.numpy()[body].copy()
    initial_velocity = state_in.body_qd.numpy()[body].copy()
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    initial_points = state_in.particle_q.numpy()[proxy_indices].copy()

    with wp.ScopedCapture(stream=stream) as capture:
        solver.step(state_in, state_out, None, None, 1.0 / 120.0)

    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)
    pose = state_out.body_q.numpy()[body]
    velocity = state_out.body_qd.numpy()[body]
    final_points = state_out.particle_q.numpy()[proxy_indices]
    pairs = ((0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3))
    initial_lengths = np.array(
        [
            np.linalg.norm(initial_points[second] - initial_points[first])
            for first, second in pairs
        ]
    )
    final_lengths = np.array(
        [
            np.linalg.norm(final_points[second] - final_points[first])
            for first, second in pairs
        ]
    )
    initial_rotation = np.asarray(
        wp.quat_to_matrix(wp.quat(*initial_pose[3:7])), dtype=np.float32
    ).reshape(3, 3)
    final_rotation = np.asarray(
        wp.quat_to_matrix(wp.quat(*pose[3:7])), dtype=np.float32
    ).reshape(3, 3)

    assert np.isfinite(pose).all()
    assert np.linalg.norm(final_rotation - initial_rotation) > 1.0e-3
    assert np.allclose(velocity[:3], initial_velocity[:3], atol=1.0e-5)
    assert np.isclose(
        np.linalg.norm(velocity[3:]), np.linalg.norm(initial_velocity[3:]), rtol=1.0e-3
    )
    assert np.isfinite(final_points).all()
    assert np.allclose(final_lengths, initial_lengths, rtol=1.0e-3, atol=1.0e-5)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_affine_body_rigidity_models_restore_frames_during_capture(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    builder.add_body(
        mass=2.0,
        inertia=wp.mat33(3.0, 0.0, 0.0, 0.0, 4.0, 0.0, 0.0, 0.0, 5.0),
        lock_inertia=True,
    )
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    proxy_indices = model.synreal_affine_body_indices.numpy()[0]
    axis_length = float(model.synreal_affine_body_axis_lengths.numpy()[0])
    positions = state_in.particle_q.numpy().copy()
    positions[proxy_indices] = _deform_affine_frame(positions[proxy_indices])
    initial_error = _affine_frame_rigidity_error(positions[proxy_indices], axis_length)
    _set_particle_positions(state_in, positions, model.device)
    state_in.clear_forces()
    stream = wp.get_stream(model.device)

    with wp.ScopedCapture(stream=stream) as capture:
        solver.step(state_in, state_out, None, None, 1.0 / 120.0)

    wp.capture_launch(capture.graph, stream=stream)
    wp.synchronize_stream(stream)

    final_positions = state_out.particle_q.numpy()[proxy_indices]
    assert np.isfinite(final_positions).all()
    assert (
        _affine_frame_rigidity_error(final_positions, axis_length)
        < 0.25 * initial_error
    )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("inertia_mode", INERTIA_MODES)
def test_newton_solver_preserves_free_body_angular_speed(
    inertia_mode: sr.InertiaMode,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        mass=2.0,
        inertia=wp.mat33(3.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 3.0),
        lock_inertia=True,
    )
    builder.body_qd[body] = wp.spatial_vector(0.0, 0.0, 0.0, 0.0, 2.0, 0.0)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.inertia_mode = inertia_mode
    initial_speed = np.linalg.norm(state_in.body_qd.numpy()[body, 3:])

    for _ in range(120):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in

    final_velocity = state_in.body_qd.numpy()[body]
    assert np.isfinite(final_velocity).all()
    assert np.isclose(np.linalg.norm(final_velocity[3:]), initial_speed, rtol=2.0e-3)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_preserves_asymmetric_free_body_invariants() -> None:
    inertia = np.diag((1.0, 2.0, 2.5)).astype(np.float32)
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        mass=2.0,
        inertia=wp.mat33(inertia),
        lock_inertia=True,
    )
    builder.body_qd[body] = wp.spatial_vector(0.0, 0.0, 0.0, 0.01, 20.0, 0.0)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = sr.AffineBodyRigidityModel.SIX_SPRINGS
    solver.config.inertia_mode = sr.InertiaMode.MIDPOINT_CAYLEY

    def invariants(state: object) -> tuple[np.ndarray, float]:
        pose = state.body_q.numpy()[body]
        omega = state.body_qd.numpy()[body, 3:]
        rotation = np.asarray(
            wp.quat_to_matrix(wp.quat(*pose[3:7])), dtype=np.float64
        ).reshape(3, 3)
        world_inertia = rotation @ inertia @ rotation.T
        momentum = world_inertia @ omega
        energy = 0.5 * omega @ momentum
        return momentum, float(energy)

    initial_momentum, initial_energy = invariants(state_in)
    for _ in range(1200):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in

    final_momentum, final_energy = invariants(state_in)
    assert np.linalg.norm(final_momentum - initial_momentum) < (
        1.0e-3 * np.linalg.norm(initial_momentum)
    )
    assert np.isclose(final_energy, initial_energy, rtol=3.0e-3)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_affine_body_rigidity_models_preserve_fixed_body_under_spring_load(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    inertia = wp.mat33(2.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 4.0)
    fixed_body = builder.add_link(
        xform=wp.transform(wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()),
        mass=2.0,
        inertia=inertia,
        lock_inertia=True,
    )
    free_body = builder.add_link(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=2.0,
        inertia=inertia,
        lock_inertia=True,
    )
    fixed_joint = builder.add_joint_fixed(parent=-1, child=fixed_body)
    builder.add_articulation([fixed_joint])
    builder.add_body_spring(
        fixed_body,
        free_body,
        stiffness=1.0e5,
        rest_length=0.5,
    )
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    affine_body_ids = model.synreal_affine_body_ids.numpy()
    fixed_affine_body = int(np.flatnonzero(affine_body_ids == fixed_body)[0])
    fixed_proxy_indices = model.synreal_affine_body_indices.numpy()[fixed_affine_body]
    initial_proxy_positions = state_in.particle_q.numpy()[fixed_proxy_indices].copy()
    initial_fixed_pose = state_in.body_q.numpy()[fixed_body].copy()
    initial_free_position = state_in.body_q.numpy()[free_body, :3].copy()
    state_in.clear_forces()

    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    final_proxy_positions = state_out.particle_q.numpy()[fixed_proxy_indices]
    final_fixed_pose = state_out.body_q.numpy()[fixed_body]
    final_free_position = state_out.body_q.numpy()[free_body, :3]
    assert solver._fixed_affine_body_ids == [fixed_body]
    assert np.array_equal(final_proxy_positions, initial_proxy_positions)
    assert np.array_equal(final_fixed_pose, initial_fixed_pose)
    assert final_free_position[0] < initial_free_position[0] - 1.0e-6


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("rigidity_model", AFFINE_BODY_RIGIDITY_MODELS)
def test_affine_body_rigidity_models_preserve_fixed_body_during_contact(
    rigidity_model: sr.AffineBodyRigidityModel,
) -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    inertia = wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
    fixed_body = builder.add_link(
        xform=wp.transform(wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()),
        mass=2.0,
        inertia=inertia,
        lock_inertia=True,
    )
    free_body = builder.add_link(
        xform=wp.transform(wp.vec3(0.3, 0.0, 0.0), wp.quat_identity()),
        mass=2.0,
        inertia=inertia,
        lock_inertia=True,
    )
    builder.add_shape_sphere(fixed_body, radius=0.25)
    builder.add_shape_sphere(free_body, radius=0.25)
    fixed_joint = builder.add_joint_fixed(parent=-1, child=fixed_body)
    builder.add_articulation([fixed_joint])

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.affine_body_rigidity_model = rigidity_model
    collision_pipeline = newton.CollisionPipeline(model)
    contacts = collision_pipeline.contacts()
    collision_pipeline.collide(state_in, contacts)
    affine_body_ids = model.synreal_affine_body_ids.numpy()
    fixed_affine_body = int(np.flatnonzero(affine_body_ids == fixed_body)[0])
    fixed_proxy_indices = model.synreal_affine_body_indices.numpy()[fixed_affine_body]
    initial_positions = state_in.particle_q.numpy().copy()
    initial_fixed_pose = state_in.body_q.numpy()[fixed_body].copy()
    initial_free_position = state_in.body_q.numpy()[free_body, :3].copy()
    state_in.clear_forces()

    solver.step(state_in, state_out, None, contacts, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    final_positions = state_out.particle_q.numpy()
    final_fixed_pose = state_out.body_q.numpy()[fixed_body]
    final_free_position = state_out.body_q.numpy()[free_body, :3]
    assert int(contacts.rigid_contact_count.numpy()[0]) > 0
    assert np.array_equal(
        final_positions[fixed_proxy_indices],
        initial_positions[fixed_proxy_indices],
    )
    assert np.array_equal(final_fixed_pose, initial_fixed_pose)
    assert final_free_position[0] > initial_free_position[0] + 1.0e-6


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_applies_body_point_spring() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    inertia = wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0)
    body0 = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    body1 = builder.add_body(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=inertia,
        lock_inertia=True,
    )
    builder.add_body_spring(body0, body1, stiffness=1.0e4, rest_length=1.0)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    initial_distance = np.linalg.norm(
        state_in.body_q.numpy()[body1, :3] - state_in.body_q.numpy()[body0, :3]
    )

    for _ in range(4):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in

    final_poses = state_in.body_q.numpy()
    final_distance = np.linalg.norm(final_poses[body1, :3] - final_poses[body0, :3])
    assert solver.synreal_model.body_spring_count == 1
    assert (
        solver.synreal_model.body_spring_indices.ptr
        == model.synreal_body_spring_indices.ptr
    )
    assert np.isfinite(final_poses).all()
    assert final_distance < initial_distance


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_applies_world_anchored_body_spring() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(2.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    builder.add_body_spring(
        body,
        -1,
        point1=(0.0, 0.0, 0.0),
        stiffness=1.0e4,
        rest_length=1.0,
    )
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    initial_x = float(state_in.body_q.numpy()[body, 0])

    for _ in range(4):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in

    final_pose = state_in.body_q.numpy()[body]
    assert np.isfinite(final_pose).all()
    assert abs(float(final_pose[0]) - 1.0) < abs(initial_x - 1.0)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_enforces_loaded_body_distance_constraint() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(1.0, 0.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    builder.add_body_distance_constraint(
        body,
        -1,
        point1=(0.0, 0.0, 0.0),
        rest_length=1.0,
    )
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    body_force = wp.array(
        (wp.spatial_vector(500.0, 0.0, 0.0, 0.0, 0.0, 0.0),),
        dtype=wp.spatial_vector,
        device=model.device,
    )
    state_in.clear_forces()
    wp.copy(state_in.body_f, body_force)

    solver.step(state_in, state_out, None, None, 1.0 / 60.0)
    wp.synchronize_device(model.device)

    position = state_out.body_q.numpy()[body, :3]
    assert solver.synreal_model.body_distance_constraint_count == 1
    assert np.isfinite(position).all()
    assert abs(np.linalg.norm(position) - 1.0) < 2.0e-4


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_isolates_replicated_body_distance_constraints() -> None:
    world_count = 3
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    bodies = []
    for _ in range(world_count):
        builder.begin_world()
        body = builder.add_body(
            xform=wp.transform(wp.vec3(1.0, 0.0, 0.0), wp.quat_identity()),
            mass=1.0,
            inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
            lock_inertia=True,
        )
        builder.add_body_distance_constraint(
            body,
            -1,
            point1=(0.0, 0.0, 0.0),
            rest_length=1.0,
        )
        bodies.append(body)
        builder.end_world()
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    forces = wp.array(
        tuple(
            wp.spatial_vector(force, 0.0, 0.0, 0.0, 0.0, 0.0)
            for force in (250.0, 500.0, 750.0)
        ),
        dtype=wp.spatial_vector,
        device=model.device,
    )
    state_in.clear_forces()
    wp.copy(state_in.body_f, forces)

    solver.step(state_in, state_out, None, None, 1.0 / 60.0)
    wp.synchronize_device(model.device)

    positions = state_out.body_q.numpy()[bodies, :3]
    assert solver.synreal_model.world_count == world_count
    assert solver.synreal_model.body_distance_constraint_count == 1
    assert np.isfinite(positions).all()
    assert np.all(np.abs(np.linalg.norm(positions, axis=1) - 1.0) < 3.0e-4)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_preserves_distinct_world_distance_anchors() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    bodies = []
    anchors = (0.0, 2.0)
    for anchor in anchors:
        builder.begin_world()
        body = builder.add_body(
            xform=wp.transform(wp.vec3(anchor + 1.0, 0.0, 0.0), wp.quat_identity()),
            mass=1.0,
            inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
            lock_inertia=True,
        )
        builder.add_body_distance_constraint(
            body,
            -1,
            point1=(anchor, 0.0, 0.0),
            rest_length=1.0,
        )
        bodies.append(body)
        builder.end_world()
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    forces = wp.array(
        (
            wp.spatial_vector(500.0, 0.0, 0.0, 0.0, 0.0, 0.0),
            wp.spatial_vector(500.0, 0.0, 0.0, 0.0, 0.0, 0.0),
        ),
        dtype=wp.spatial_vector,
        device=model.device,
    )
    state_in.clear_forces()
    wp.copy(state_in.body_f, forces)

    solver.step(state_in, state_out, None, None, 1.0 / 60.0)
    wp.synchronize_device(model.device)

    positions = state_out.body_q.numpy()[bodies, :3]
    distances = np.abs(positions[:, 0] - np.asarray(anchors))
    assert solver.synreal_model.world_count == 1
    assert solver.synreal_model.body_distance_constraint_count == 2
    assert np.all(np.abs(distances - 1.0) < 2.0e-4)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_applies_world_space_point_line() -> None:
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 1.0, 0.0), wp.quat_identity()),
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    builder.add_body_point_line(
        body,
        -1,
        line_endpoint0=(-2.0, 0.0, 0.0),
        line_endpoint1=(2.0, 0.0, 0.0),
        stiffness=1.0e4,
        damping=10.0,
    )
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    initial_y = float(state_in.body_q.numpy()[body, 1])

    for _ in range(4):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in

    final_pose = state_in.body_q.numpy()[body]
    assert np.isfinite(final_pose).all()
    assert abs(float(final_pose[1])) < abs(initial_y)


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("world_count", (2, 4))
def test_newton_solver_shares_replicated_rigid_model_data(world_count: int) -> None:
    scene = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = scene.add_body(
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    scene.add_shape_box(body, hx=0.25, hy=0.25, hz=0.25)

    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    builder.replicate(scene, world_count)
    builder.add_ground_plane()
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert native.world_count == world_count
    assert native.particle_count == model.particle_count // world_count
    assert native.particle_state_count == model.particle_count
    assert native.body_count == model.body_count // world_count
    assert native.body_state_count == model.body_count
    assert native.shape_replicated_count == (model.shape_count - 1) // world_count
    assert native.shape_count == native.shape_replicated_count + 1

    state_in = model.state()
    state_out = model.state()
    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)
    particles = state_out.particle_q.numpy()
    particles_per_world = len(particles) // world_count
    assert np.isfinite(particles).all()
    for world in range(1, world_count):
        start = world * particles_per_world
        assert np.allclose(
            particles[:particles_per_world],
            particles[start : start + particles_per_world],
            atol=1.0e-6,
        )
    poses = state_out.body_q.numpy()
    bodies_per_world = len(poses) // world_count
    assert np.isfinite(poses).all()
    for world in range(1, world_count):
        start = world * bodies_per_world
        assert np.allclose(
            poses[:bodies_per_world],
            poses[start : start + bodies_per_world],
            atol=1.0e-6,
        )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
@pytest.mark.parametrize("world_count", (2, 4))
def test_newton_solver_shares_replicated_cloth_rigid_model_data(
    world_count: int,
) -> None:
    from newton.solvers import style3d

    scene = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    newton.solvers.SolverStyle3D.register_custom_attributes(scene)
    style3d.add_cloth_grid(
        scene,
        pos=wp.vec3(0.0),
        rot=wp.quat_identity(),
        dim_x=1,
        dim_y=1,
        cell_x=0.2,
        cell_y=0.2,
        vel=wp.vec3(0.0),
        mass=0.1,
        tri_aniso_ke=wp.vec3(2.0e3, 2.0e3, 5.0e2),
        edge_aniso_ke=wp.vec3(2.0e-5),
    )
    scene.add_spring(0, 3, ke=500.0, kd=0.0, control=0.0)
    scene.particle_q[3] = wp.vec3(0.2, 0.2, 0.05)
    body = scene.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, 1.0), wp.quat_identity()),
        mass=1.0,
        inertia=wp.mat33(1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0),
        lock_inertia=True,
    )
    scene.add_shape_box(body, hx=0.1, hy=0.1, hz=0.1)

    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    newton.solvers.SolverStyle3D.register_custom_attributes(builder)
    builder.replicate(scene, world_count)
    model = builder.finalize(device="cuda:0")
    solver = NewtonSolver(model)
    native = solver.synreal_model

    assert native.world_count == world_count
    assert native.particle_count == model.particle_count // world_count
    assert native.particle_state_count == model.particle_count
    assert native.body_count == model.body_count // world_count
    assert native.spring_count == model.spring_count // world_count
    assert native.triangle_count == model.tri_count // world_count
    assert native.edge_count == model.edge_count // world_count
    assert native.particle_rest_positions.ptr == model.particle_q.ptr
    assert native.particle_rest_positions.size == model.particle_count
    assert native.collision_triangle_count == model.tri_count // world_count
    assert native.collision_triangle_indices.ptr == model.tri_indices.ptr
    assert native.collision_edge_count == model.edge_count // world_count
    assert native.collision_edge_indices.ptr == model.edge_indices.ptr

    particles_per_world = native.particle_count
    particle_world = model.particle_world.numpy()
    assert np.array_equal(
        particle_world,
        np.repeat(np.arange(world_count), particles_per_world),
    )
    proxies = model.synreal_affine_body_indices.numpy().reshape(world_count, -1, 4)
    for world in range(world_count):
        assert np.all(
            (proxies[world] >= world * particles_per_world)
            & (proxies[world] < (world + 1) * particles_per_world)
        )

    state_in = model.state()
    state_out = model.state()
    initial_positions = state_in.particle_q.numpy().copy()
    for _ in range(2):
        state_in.clear_forces()
        solver.step(state_in, state_out, None, None, 1.0 / 240.0)
        state_in, state_out = state_out, state_in
    wp.synchronize_device(model.device)

    particles = state_in.particle_q.numpy()
    assert np.isfinite(particles).all()
    assert not np.allclose(
        particles[:4],
        initial_positions[:4],
        atol=1.0e-7,
    )
    for world in range(1, world_count):
        start = world * particles_per_world
        assert np.allclose(
            particles[:particles_per_world],
            particles[start : start + particles_per_world],
            atol=1.0e-6,
        )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_applies_affine_body_wrench() -> None:
    mass = 2.0
    inertia = np.diag((5.0, 6.0, 7.0)).astype(np.float32)
    force = np.array((3.0, -4.0, 5.0), dtype=np.float32)
    torque = np.array((6.0, 7.0, -8.0), dtype=np.float32)
    dt = 1.0e-3
    builder = ModelBuilder(up_axis=newton.Axis.Z, gravity=0.0)
    body = builder.add_body(mass=mass, inertia=wp.mat33(inertia), lock_inertia=True)
    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    body_wrench = wp.array(
        (wp.spatial_vector(*force, *torque),),
        dtype=wp.spatial_vector,
        device=model.device,
    )
    wp.copy(state_in.body_f, body_wrench)
    input_wrench = state_in.body_f.numpy().copy()

    solver.step(state_in, state_out, None, None, dt)
    wp.synchronize_device(model.device)

    body_velocity = state_out.body_qd.numpy()[body]
    assert np.array_equal(state_in.body_f.numpy(), input_wrench)
    assert np.count_nonzero(state_in.particle_f.numpy()) == 0
    assert np.allclose(body_velocity[:3], dt * force / mass, rtol=2.0e-3, atol=1.0e-6)
    assert np.allclose(
        body_velocity[3:],
        dt * np.linalg.solve(inertia, torque),
        rtol=2.0e-3,
        atol=1.0e-6,
    )


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_adds_rigid_body_proxies() -> None:
    builder = newton.ModelBuilder()
    builder.add_body(
        mass=1.0,
        inertia=wp.mat33(5.0, 0.0, 0.0, 0.0, 6.0, 0.0, 0.0, 0.0, 7.0),
        lock_inertia=True,
    )
    model = builder.finalize(device="cuda:0")

    solver = NewtonSolver(model)

    assert solver is not None
    assert model.synreal_affine_body_ids.numpy().tolist() == [0]


@pytest.mark.skipif(not wp.is_cuda_available(), reason="NewtonSolver requires CUDA")
def test_newton_solver_global_particle_collides_with_local_world_particle() -> None:
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z, gravity=wp.vec3(0.0))
    builder.add_particle(
        pos=(0.03, 0.0, 0.0),
        vel=(0.0, 0.0, 0.0),
        mass=1.0,
        radius=0.06,
    )
    builder.begin_world()
    builder.add_particle(
        pos=(-0.03, 0.0, 0.0),
        vel=(0.0, 0.0, 0.0),
        mass=1.0,
        radius=0.06,
    )
    builder.end_world()

    model = builder.finalize(device="cuda:0")
    state_in = model.state()
    state_out = model.state()
    solver = NewtonSolver(model)
    solver.config.enable_self_collision = True
    solver.config.self_collision_particle_particle_stiffness = 2.0
    solver.config.nonlinear_iterations = 15
    solver.config.linear_iterations = 15

    assert np.array_equal(model.particle_world.numpy(), (-1, 0))
    assert np.array_equal(solver._collision_particle_indices.numpy(), (0, 1))
    initial_positions = state_in.particle_q.numpy().copy()
    initial_distance = float(np.linalg.norm(initial_positions[0] - initial_positions[1]))
    initial_center = np.mean(initial_positions, axis=0)

    state_in.clear_forces()
    solver.step(state_in, state_out, None, None, 1.0 / 120.0)
    wp.synchronize_device(model.device)

    positions = state_out.particle_q.numpy()
    final_distance = float(np.linalg.norm(positions[0] - positions[1]))
    assert np.isfinite(positions).all()
    assert final_distance > initial_distance + 1.0e-4
    assert np.allclose(np.mean(positions, axis=0), initial_center, atol=1.0e-6)
