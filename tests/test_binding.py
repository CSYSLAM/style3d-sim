import pytest

import synreal_solver as sr


def test_span_exposes_pointer_and_element_count() -> None:
    span = sr.Span(ptr=0x1234, size=7)

    assert span.ptr == 0x1234
    assert span.size == 7
    assert len(span) == 7
    assert repr(span) == "Span(ptr=4660, size=7)"


def test_model_count_fields() -> None:
    model = sr.Model()
    model.particle_count = 2
    model.particle_state_count = 20
    model.spring_count = 3
    model.triangle_count = 4
    model.tetrahedron_count = 5
    model.collision_particle_count = 8
    model.collision_triangle_count = 6
    model.collision_edge_count = 7
    model.hinge_count = 5
    model.body_count = 6
    model.body_state_count = 60
    model.particle_mass_non_diagonal_count = 7
    model.body_spring_count = 8
    model.body_distance_constraint_count = 9
    model.shape_replicated_count = 10

    assert model.particle_count == 2
    assert model.particle_state_count == 20
    assert model.spring_count == 3
    assert model.triangle_count == 4
    assert model.tetrahedron_count == 5
    assert model.collision_particle_count == 8
    assert model.collision_triangle_count == 6
    assert model.collision_edge_count == 7
    assert model.hinge_count == 5
    assert model.body_count == 6
    assert model.body_state_count == 60
    assert model.particle_mass_non_diagonal_count == 7
    assert model.body_spring_count == 8
    assert model.body_distance_constraint_count == 9
    assert model.shape_replicated_count == 10


def test_model_fields_round_trip_raw_spans_without_reading_memory() -> None:
    model = sr.Model()
    fields = [
        "particle_indices",
        "particle_masses",
        "particle_mass_non_diagonal_indices",
        "particle_mass_non_diagonal_values",
        "particle_flags",
        "particle_world",
        "particle_rest_positions",
        "collision_particle_indices",
        "gravity",
        "spring_indices",
        "spring_stiffnesses",
        "spring_rest_lengths",
        "triangle_indices",
        "triangle_rest_areas",
        "triangle_inv_dms",
        "triangle_masses",
        "triangle_aniso_stiffnesses",
        "tetrahedron_indices",
        "tetrahedron_inverse_dms",
        "tetrahedron_materials",
        "edge_indices",
        "edge_bending_properties",
        "edge_rest_areas",
        "edge_bending_cots",
        "collision_triangle_indices",
        "collision_edge_indices",
        "hinge_indices",
        "hinge_rest_angles",
        "hinge_stiffnesses",
        "body_masses",
        "body_local_transforms",
        "body_inertia_tensors",
        "affine_body_indices",
        "affine_body_axis_lengths",
        "affine_body_orthogonality_scales",
        "affine_body_corotated_scales",
        "body_spring_indices",
        "body_spring_points0",
        "body_spring_points1",
        "body_spring_stiffnesses",
        "body_spring_rest_lengths",
        "body_distance_constraint_indices",
        "body_distance_constraint_points0",
        "body_distance_constraint_points1",
        "body_distance_constraint_weights0",
        "body_distance_constraint_weights1",
        "body_distance_constraint_mass_scales",
        "body_distance_constraint_rest_lengths",
    ]

    # These deliberately invalid addresses are safe because the binding must only
    # pass device pointers through, never dereference them on the host.
    for index, field in enumerate(fields):
        expected = sr.Span(ptr=0x1000 + index * 0x100, size=index + 1)
        setattr(model, field, expected)
        actual = getattr(model, field)

        assert actual.ptr == expected.ptr
        assert actual.size == expected.size


def test_config_exposes_runtime_options() -> None:
    config = sr.Config()

    nonlinear_solvers = (
        sr.NonlinearSolver.NEWTON,
        sr.NonlinearSolver.PD_NEWTON,
    )
    assert config.nonlinear_solver == sr.NonlinearSolver.PD_NEWTON
    assert tuple(solver.value for solver in nonlinear_solvers) == (0, 1)
    for solver in nonlinear_solvers:
        config.nonlinear_solver = solver
        assert config.nonlinear_solver == solver

    assert config.distance_constraint_alpha == pytest.approx(100.0)
    config.distance_constraint_alpha = 25.0
    assert config.distance_constraint_alpha == pytest.approx(25.0)

    assert not hasattr(config, "enable_affine_body_velocity_correction")
    assert not hasattr(config, "rigid_body_integrator")
    assert not hasattr(sr, "RigidBodyIntegrator")

    assert config.enable_self_collision is False
    config.enable_self_collision = True
    assert config.enable_self_collision is True

    collision_options = {
        "self_collision_radius": 0.012,
        "self_collision_vertex_face_stiffness": 0.75,
        "self_collision_edge_edge_stiffness": 0.25,
        "self_collision_edge_face_stiffness": 1.5,
        "self_collision_particle_particle_stiffness": 2.0,
    }
    for name, expected in collision_options.items():
        setattr(config, name, expected)
        assert getattr(config, name) == pytest.approx(expected)

    rigidity_models = (
        sr.AffineBodyRigidityModel.CO_ROTATED,
        sr.AffineBodyRigidityModel.ABD_ORTHOGONALITY,
        sr.AffineBodyRigidityModel.SIX_SPRINGS,
    )
    assert config.affine_body_rigidity_model == rigidity_models[-1]
    assert {model.name for model in rigidity_models} == {
        "CO_ROTATED",
        "ABD_ORTHOGONALITY",
        "SIX_SPRINGS",
    }
    assert len({model.value for model in rigidity_models}) == len(rigidity_models)
    for model in rigidity_models:
        config.affine_body_rigidity_model = model
        assert config.affine_body_rigidity_model == model

    inertia_modes = (
        sr.InertiaMode.EXPLICIT_EULER,
        sr.InertiaMode.IMPLICIT_EULER,
        sr.InertiaMode.LIE_GROUP_MIDPOINT,
        sr.InertiaMode.MIDPOINT_CAYLEY,
        sr.InertiaMode.NONE,
    )
    assert config.inertia_mode == sr.InertiaMode.MIDPOINT_CAYLEY
    assert {mode.name for mode in inertia_modes} == {
        "EXPLICIT_EULER",
        "IMPLICIT_EULER",
        "LIE_GROUP_MIDPOINT",
        "MIDPOINT_CAYLEY",
        "NONE",
    }
    assert tuple(mode.value for mode in inertia_modes) == (
        0,
        1,
        2,
        3,
        4,
    )
    assert len({mode.value for mode in inertia_modes}) == len(inertia_modes)
    for mode in inertia_modes:
        config.inertia_mode = mode
        assert config.inertia_mode == mode

    joint_constraint_modes = (
        sr.JointConstraintMode.PENALTY,
        sr.JointConstraintMode.AUGMENTED_LAGRANGIAN,
    )
    assert config.joint_constraint_mode == sr.JointConstraintMode.PENALTY
    assert {mode.name for mode in joint_constraint_modes} == {
        "PENALTY",
        "AUGMENTED_LAGRANGIAN",
    }
    assert tuple(mode.value for mode in joint_constraint_modes) == (0, 1)
    for mode in joint_constraint_modes:
        config.joint_constraint_mode = mode
        assert config.joint_constraint_mode == mode

    assert config.joint_constraint_primal_iterations == 4
    config.joint_constraint_primal_iterations = 7
    assert config.joint_constraint_primal_iterations == 7


def test_model_fields_require_span() -> None:
    model = sr.Model()

    with pytest.raises(TypeError):
        model.particle_masses = [1.0, 2.0]


def test_control_tetrahedron_activations_round_trip_raw_span() -> None:
    control = sr.Control()
    expected = sr.Span(ptr=0xBEEF, size=3)

    control.tetrahedron_activations = expected

    assert control.tetrahedron_activations.ptr == expected.ptr
    assert control.tetrahedron_activations.size == expected.size
