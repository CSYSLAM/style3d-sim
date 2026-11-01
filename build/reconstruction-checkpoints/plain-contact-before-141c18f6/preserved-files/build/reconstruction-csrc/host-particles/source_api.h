#pragma once
#include <array>
#include <cmath>
#include <sstream>
struct Span { std::uintptr_t ptr = 0; std::size_t size = 0; };
enum class NonlinearSolver { NEWTON = 0, PD_NEWTON = 1 };
enum class JointConstraintMode { PENALTY = 0, AUGMENTED_LAGRANGIAN = 1 };
enum class InertiaMode { EXPLICIT_EULER = 0, IMPLICIT_EULER = 1, LIE_GROUP_MIDPOINT = 2, MIDPOINT_CAYLEY = 3, NONE = 4, VBD_SEMI_IMPLICIT = 5 };
enum class AffineBodyRigidityModel { CO_ROTATED = 0, ABD_ORTHOGONALITY = 1, SIX_SPRINGS = 2, SO3_AUGMENTED_LAGRANGIAN = 3 };
enum class LogLevel { INFO = 0, ERROR = 1, DEBUG = 2, WARNING = 4 };
struct Model {
    Span affine_body_ids;
    Span affine_body_indices;
    Span body_centers_of_mass;
    std::uint32_t body_count = 0;
    std::uint32_t body_distance_constraint_count = 0;
    Span body_distance_constraint_indices;
    Span body_distance_constraint_mass_scales;
    Span body_distance_constraint_points0;
    Span body_distance_constraint_points1;
    Span body_distance_constraint_rest_lengths;
    Span body_distance_constraint_weights0;
    Span body_distance_constraint_weights1;
    Span body_inertia_tensors;
    Span body_local_transforms;
    Span body_masses;
    std::uint32_t body_point_line_count = 0;
    Span body_point_line_dampings;
    Span body_point_line_endpoints0;
    Span body_point_line_endpoints1;
    Span body_point_line_indices;
    Span body_point_line_points;
    Span body_point_line_stiffnesses;
    std::uint32_t body_spring_count = 0;
    Span body_spring_indices;
    Span body_spring_points0;
    Span body_spring_points1;
    Span body_spring_rest_lengths;
    Span body_spring_stiffnesses;
    std::uint32_t body_state_count = 0;
    Span cable_angular_bias;
    Span cable_angular_hessian;
    Span cable_body_indices;
    Span cable_child_transforms;
    std::uint32_t cable_count = 0;
    Span cable_dampings;
    Span cable_enabled;
    Span cable_parent_transforms;
    Span cable_rest_bend_twist;
    Span cable_stiffnesses;
    std::uint32_t collision_edge_count = 0;
    Span collision_edge_indices;
    std::uint32_t collision_particle_count = 0;
    Span collision_particle_indices;
    std::uint32_t collision_triangle_count = 0;
    Span collision_triangle_indices;
    Span edge_bending_cots;
    Span edge_bending_properties;
    std::uint32_t edge_count = 0;
    Span edge_indices;
    Span edge_rest_areas;
    std::uint32_t fluid_boundary_count = 0;
    Span fluid_boundary_positions;
    Span fluid_boundary_volumes;
    float fluid_bulk_modulus = 200000.0f;
    std::uint32_t fluid_particle_count = 0;
    Span fluid_particle_indices;
    float fluid_rest_density = 1000.0f;
    float fluid_smoothing_radius = 0.10000000149011612f;
    float fluid_viscosity = 0.0f;
    float granular_adhesion = 0.0f;
    std::uint32_t granular_bond_count = 0;
    float granular_bond_damping = 0.0f;
    float granular_bond_formation_gap = 0.0f;
    float granular_bond_formation_speed = 1.0f;
    Span granular_bond_indices;
    Span granular_bond_rest_lengths;
    float granular_break_strain = 0.10000000149011612f;
    float granular_cohesion = 200.0f;
    float granular_contact_stiffness = 2000.0f;
    float granular_friction = 0.5f;
    float granular_friction_damping = 20.0f;
    float granular_max_compaction = 0.4000000059604645f;
    std::uint32_t granular_max_dynamic_bonds = 12;
    std::uint32_t granular_particle_count = 0;
    Span granular_particle_indices;
    float granular_yield_strain = 0.029999999329447746f;
    Span gravity;
    std::uint32_t hinge_count = 0;
    Span hinge_indices;
    Span hinge_rest_angles;
    Span hinge_stiffnesses;
    Span joint_armature;
    std::uint32_t joint_body_point_line_count = 0;
    std::uint32_t joint_body_spring_count = 0;
    float joint_constraint_mass_scale = 1.0f;
    std::uint32_t joint_dof_count = 0;
    Span joint_drive_body_indices;
    Span joint_drive_child_origins;
    Span joint_drive_child_reference_points;
    std::uint32_t joint_drive_count = 0;
    Span joint_drive_dof_indices;
    Span joint_drive_parent_axis_points;
    Span joint_drive_parent_origins;
    Span joint_drive_parent_reference_points;
    Span joint_drive_target_indices;
    Span joint_drive_types;
    Span joint_effort_limits;
    Span joint_limit_dampings;
    Span joint_limit_lower;
    Span joint_limit_stiffnesses;
    Span joint_limit_upper;
    Span joint_passive_dampings;
    std::uint32_t joint_target_count = 0;
    Span joint_target_dampings;
    Span joint_target_modes;
    Span joint_target_stiffnesses;
    std::uint32_t particle_count = 0;
    Span particle_flags;
    Span particle_indices;
    std::uint32_t particle_mass_non_diagonal_count = 0;
    Span particle_mass_non_diagonal_indices;
    Span particle_mass_non_diagonal_values;
    Span particle_masses;
    Span particle_radii;
    Span particle_rest_positions;
    std::uint32_t particle_state_count = 0;
    Span particle_world;
    Span shape_bodies;
    Span shape_contact_dampings;
    Span shape_contact_friction_gains;
    Span shape_contact_stiffnesses;
    std::uint32_t shape_count = 0;
    Span shape_frictions;
    Span shape_margins;
    std::uint32_t shape_replicated_count = 0;
    Span shape_rolling_frictions;
    Span shape_scales;
    Span shape_torsional_frictions;
    Span shape_transforms;
    Span shape_types;
    float soft_contact_damping = 0.0f;
    float soft_contact_friction = 0.0f;
    float soft_contact_friction_gain = 1000.0f;
    float soft_contact_stiffness = 1000.0f;
    std::uint32_t spring_count = 0;
    Span spring_indices;
    Span spring_rest_lengths;
    Span spring_stiffnesses;
    std::uint32_t tetrahedron_count = 0;
    Span tetrahedron_indices;
    Span tetrahedron_inverse_dms;
    Span tetrahedron_materials;
    Span triangle_aniso_stiffnesses;
    std::uint32_t triangle_count = 0;
    Span triangle_drag_coefficients;
    Span triangle_indices;
    Span triangle_inv_dms;
    Span triangle_masses;
    Span triangle_rest_areas;
    std::uint32_t world_count = 0;
};
struct State {
    Span particle_f;
    Span particle_q;
    Span particle_qd;
};
struct Control {
    Span joint_drive_velocities;
    Span joint_f;
    Span joint_target_q;
    Span joint_target_qd;
    Span tetrahedron_activations;
};
struct Contact {
    Span count;
    bool history_refresh = true;
    Span margin0;
    Span margin1;
    Span match_index;
    std::uint32_t max_count = 0;
    Span normal;
    Span offset0;
    Span offset1;
    Span point0;
    Span point1;
    Span shape0;
    Span shape1;
    Span soft_barycentric;
    Span soft_body_pos;
    Span soft_body_vel;
    Span soft_count;
    Span soft_indices;
    std::uint32_t soft_max_count = 0;
    Span soft_normal;
    Span soft_particle;
    Span soft_particle_only_shapes;
    Span soft_shape;
};
struct Config {
    bool affine_body_block_preconditioner = false;
    bool affine_body_contact_block_preconditioner = true;
    AffineBodyRigidityModel affine_body_rigidity_model = static_cast<AffineBodyRigidityModel>(3);
    int affine_body_rigidity_primal_iterations = 1;
    float air_density = 1.225000023841858f;
    float cable_angular_beta = 0.0f;
    float cable_angular_k_start = 10.0f;
    float cable_linear_beta = 0.0f;
    float cable_linear_k_start = 100.0f;
    float cable_penalty_gamma = 0.9990000128746033f;
    float constraint_alpha = 100.0f;
    bool enable_collision_hessian_non_diagonal = true;
    bool enable_self_collision = false;
    float fluid_max_step_ratio = 0.25f;
    float fluid_relaxation = 0.5f;
    InertiaMode inertia_mode = static_cast<InertiaMode>(3);
    JointConstraintMode joint_constraint_mode = static_cast<JointConstraintMode>(1);
    int joint_constraint_primal_iterations = 1;
    int linear_iterations = 50;
    int nonlinear_iterations = 5;
    NonlinearSolver nonlinear_solver = static_cast<NonlinearSolver>(0);
    float rigid_contact_alpha = 0.949999988079071f;
    float rigid_contact_beta = 0.0f;
    float rigid_contact_friction_epsilon = 0.0f;
    float rigid_contact_gamma = 0.9990000128746033f;
    bool rigid_contact_hard = false;
    bool rigid_contact_history = false;
    float rigid_contact_k_start = 100.0f;
    bool rigid_contact_sliding_tangent = false;
    float rolling_friction_velocity_epsilon = 0.10000000149011612f;
    float self_collision_edge_edge_stiffness = 0.10000000149011612f;
    float self_collision_edge_face_stiffness = 1.0f;
    float self_collision_particle_particle_stiffness = 1.0f;
    float self_collision_radius = 0.003000000026077032f;
    float self_collision_vertex_face_stiffness = 0.5f;
    std::array<float, 3> wind_velocity = {0.0f, 0.0f, 0.0f};
};
static void bind_api(py::module_& module) {
    py::class_<Span>(module, "Span")
        .def(py::init([](std::uintptr_t ptr, std::size_t size) {
            if (!ptr && size) throw py::value_error("Span with a null address must have zero elements");
            return Span{ptr, size};
        }), py::arg("ptr") = 0, py::arg("size") = 0)
        .def_readonly("ptr", &Span::ptr).def_readonly("size", &Span::size)
        .def("__repr__", [](const Span& s) { return "Span(ptr=" + std::to_string(s.ptr) +
             ", size=" + std::to_string(s.size) + ")"; });
    py::enum_<NonlinearSolver>(module, "NonlinearSolver")
        .value("NEWTON", NonlinearSolver::NEWTON)
        .value("PD_NEWTON", NonlinearSolver::PD_NEWTON);
    py::enum_<JointConstraintMode>(module, "JointConstraintMode")
        .value("PENALTY", JointConstraintMode::PENALTY)
        .value("AUGMENTED_LAGRANGIAN", JointConstraintMode::AUGMENTED_LAGRANGIAN);
    py::enum_<InertiaMode>(module, "InertiaMode")
        .value("EXPLICIT_EULER", InertiaMode::EXPLICIT_EULER)
        .value("IMPLICIT_EULER", InertiaMode::IMPLICIT_EULER)
        .value("LIE_GROUP_MIDPOINT", InertiaMode::LIE_GROUP_MIDPOINT)
        .value("MIDPOINT_CAYLEY", InertiaMode::MIDPOINT_CAYLEY)
        .value("NONE", InertiaMode::NONE)
        .value("VBD_SEMI_IMPLICIT", InertiaMode::VBD_SEMI_IMPLICIT);
    py::enum_<AffineBodyRigidityModel>(module, "AffineBodyRigidityModel")
        .value("CO_ROTATED", AffineBodyRigidityModel::CO_ROTATED)
        .value("ABD_ORTHOGONALITY", AffineBodyRigidityModel::ABD_ORTHOGONALITY)
        .value("SIX_SPRINGS", AffineBodyRigidityModel::SIX_SPRINGS)
        .value("SO3_AUGMENTED_LAGRANGIAN", AffineBodyRigidityModel::SO3_AUGMENTED_LAGRANGIAN);
    py::enum_<LogLevel>(module, "LogLevel")
        .value("INFO", LogLevel::INFO)
        .value("ERROR", LogLevel::ERROR)
        .value("DEBUG", LogLevel::DEBUG)
        .value("WARNING", LogLevel::WARNING);
    py::class_<Model>(module, "Model").def(py::init<>())
        .def_property("affine_body_ids", [](const Model& o) { return o.affine_body_ids; },
            [](Model& o, Span value) { o.affine_body_ids = value; })
        .def_property("affine_body_indices", [](const Model& o) { return o.affine_body_indices; },
            [](Model& o, Span value) { o.affine_body_indices = value; })
        .def_property("body_centers_of_mass", [](const Model& o) { return o.body_centers_of_mass; },
            [](Model& o, Span value) { o.body_centers_of_mass = value; })
        .def_readwrite("body_count", &Model::body_count)
        .def_readwrite("body_distance_constraint_count", &Model::body_distance_constraint_count)
        .def_property("body_distance_constraint_indices", [](const Model& o) { return o.body_distance_constraint_indices; },
            [](Model& o, Span value) { o.body_distance_constraint_indices = value; })
        .def_property("body_distance_constraint_mass_scales", [](const Model& o) { return o.body_distance_constraint_mass_scales; },
            [](Model& o, Span value) { o.body_distance_constraint_mass_scales = value; })
        .def_property("body_distance_constraint_points0", [](const Model& o) { return o.body_distance_constraint_points0; },
            [](Model& o, Span value) { o.body_distance_constraint_points0 = value; })
        .def_property("body_distance_constraint_points1", [](const Model& o) { return o.body_distance_constraint_points1; },
            [](Model& o, Span value) { o.body_distance_constraint_points1 = value; })
        .def_property("body_distance_constraint_rest_lengths", [](const Model& o) { return o.body_distance_constraint_rest_lengths; },
            [](Model& o, Span value) { o.body_distance_constraint_rest_lengths = value; })
        .def_property("body_distance_constraint_weights0", [](const Model& o) { return o.body_distance_constraint_weights0; },
            [](Model& o, Span value) { o.body_distance_constraint_weights0 = value; })
        .def_property("body_distance_constraint_weights1", [](const Model& o) { return o.body_distance_constraint_weights1; },
            [](Model& o, Span value) { o.body_distance_constraint_weights1 = value; })
        .def_property("body_inertia_tensors", [](const Model& o) { return o.body_inertia_tensors; },
            [](Model& o, Span value) { o.body_inertia_tensors = value; })
        .def_property("body_local_transforms", [](const Model& o) { return o.body_local_transforms; },
            [](Model& o, Span value) { o.body_local_transforms = value; })
        .def_property("body_masses", [](const Model& o) { return o.body_masses; },
            [](Model& o, Span value) { o.body_masses = value; })
        .def_readwrite("body_point_line_count", &Model::body_point_line_count)
        .def_property("body_point_line_dampings", [](const Model& o) { return o.body_point_line_dampings; },
            [](Model& o, Span value) { o.body_point_line_dampings = value; })
        .def_property("body_point_line_endpoints0", [](const Model& o) { return o.body_point_line_endpoints0; },
            [](Model& o, Span value) { o.body_point_line_endpoints0 = value; })
        .def_property("body_point_line_endpoints1", [](const Model& o) { return o.body_point_line_endpoints1; },
            [](Model& o, Span value) { o.body_point_line_endpoints1 = value; })
        .def_property("body_point_line_indices", [](const Model& o) { return o.body_point_line_indices; },
            [](Model& o, Span value) { o.body_point_line_indices = value; })
        .def_property("body_point_line_points", [](const Model& o) { return o.body_point_line_points; },
            [](Model& o, Span value) { o.body_point_line_points = value; })
        .def_property("body_point_line_stiffnesses", [](const Model& o) { return o.body_point_line_stiffnesses; },
            [](Model& o, Span value) { o.body_point_line_stiffnesses = value; })
        .def_readwrite("body_spring_count", &Model::body_spring_count)
        .def_property("body_spring_indices", [](const Model& o) { return o.body_spring_indices; },
            [](Model& o, Span value) { o.body_spring_indices = value; })
        .def_property("body_spring_points0", [](const Model& o) { return o.body_spring_points0; },
            [](Model& o, Span value) { o.body_spring_points0 = value; })
        .def_property("body_spring_points1", [](const Model& o) { return o.body_spring_points1; },
            [](Model& o, Span value) { o.body_spring_points1 = value; })
        .def_property("body_spring_rest_lengths", [](const Model& o) { return o.body_spring_rest_lengths; },
            [](Model& o, Span value) { o.body_spring_rest_lengths = value; })
        .def_property("body_spring_stiffnesses", [](const Model& o) { return o.body_spring_stiffnesses; },
            [](Model& o, Span value) { o.body_spring_stiffnesses = value; })
        .def_readwrite("body_state_count", &Model::body_state_count)
        .def_property("cable_angular_bias", [](const Model& o) { return o.cable_angular_bias; },
            [](Model& o, Span value) { o.cable_angular_bias = value; })
        .def_property("cable_angular_hessian", [](const Model& o) { return o.cable_angular_hessian; },
            [](Model& o, Span value) { o.cable_angular_hessian = value; })
        .def_property("cable_body_indices", [](const Model& o) { return o.cable_body_indices; },
            [](Model& o, Span value) { o.cable_body_indices = value; })
        .def_property("cable_child_transforms", [](const Model& o) { return o.cable_child_transforms; },
            [](Model& o, Span value) { o.cable_child_transforms = value; })
        .def_readwrite("cable_count", &Model::cable_count)
        .def_property("cable_dampings", [](const Model& o) { return o.cable_dampings; },
            [](Model& o, Span value) { o.cable_dampings = value; })
        .def_property("cable_enabled", [](const Model& o) { return o.cable_enabled; },
            [](Model& o, Span value) { o.cable_enabled = value; })
        .def_property("cable_parent_transforms", [](const Model& o) { return o.cable_parent_transforms; },
            [](Model& o, Span value) { o.cable_parent_transforms = value; })
        .def_property("cable_rest_bend_twist", [](const Model& o) { return o.cable_rest_bend_twist; },
            [](Model& o, Span value) { o.cable_rest_bend_twist = value; })
        .def_property("cable_stiffnesses", [](const Model& o) { return o.cable_stiffnesses; },
            [](Model& o, Span value) { o.cable_stiffnesses = value; })
        .def_readwrite("collision_edge_count", &Model::collision_edge_count)
        .def_property("collision_edge_indices", [](const Model& o) { return o.collision_edge_indices; },
            [](Model& o, Span value) { o.collision_edge_indices = value; })
        .def_readwrite("collision_particle_count", &Model::collision_particle_count)
        .def_property("collision_particle_indices", [](const Model& o) { return o.collision_particle_indices; },
            [](Model& o, Span value) { o.collision_particle_indices = value; })
        .def_readwrite("collision_triangle_count", &Model::collision_triangle_count)
        .def_property("collision_triangle_indices", [](const Model& o) { return o.collision_triangle_indices; },
            [](Model& o, Span value) { o.collision_triangle_indices = value; })
        .def_property("edge_bending_cots", [](const Model& o) { return o.edge_bending_cots; },
            [](Model& o, Span value) { o.edge_bending_cots = value; })
        .def_property("edge_bending_properties", [](const Model& o) { return o.edge_bending_properties; },
            [](Model& o, Span value) { o.edge_bending_properties = value; })
        .def_readwrite("edge_count", &Model::edge_count)
        .def_property("edge_indices", [](const Model& o) { return o.edge_indices; },
            [](Model& o, Span value) { o.edge_indices = value; })
        .def_property("edge_rest_areas", [](const Model& o) { return o.edge_rest_areas; },
            [](Model& o, Span value) { o.edge_rest_areas = value; })
        .def_readwrite("fluid_boundary_count", &Model::fluid_boundary_count)
        .def_property("fluid_boundary_positions", [](const Model& o) { return o.fluid_boundary_positions; },
            [](Model& o, Span value) { o.fluid_boundary_positions = value; })
        .def_property("fluid_boundary_volumes", [](const Model& o) { return o.fluid_boundary_volumes; },
            [](Model& o, Span value) { o.fluid_boundary_volumes = value; })
        .def_readwrite("fluid_bulk_modulus", &Model::fluid_bulk_modulus)
        .def_readwrite("fluid_particle_count", &Model::fluid_particle_count)
        .def_property("fluid_particle_indices", [](const Model& o) { return o.fluid_particle_indices; },
            [](Model& o, Span value) { o.fluid_particle_indices = value; })
        .def_readwrite("fluid_rest_density", &Model::fluid_rest_density)
        .def_readwrite("fluid_smoothing_radius", &Model::fluid_smoothing_radius)
        .def_readwrite("fluid_viscosity", &Model::fluid_viscosity)
        .def_readwrite("granular_adhesion", &Model::granular_adhesion)
        .def_readwrite("granular_bond_count", &Model::granular_bond_count)
        .def_readwrite("granular_bond_damping", &Model::granular_bond_damping)
        .def_readwrite("granular_bond_formation_gap", &Model::granular_bond_formation_gap)
        .def_readwrite("granular_bond_formation_speed", &Model::granular_bond_formation_speed)
        .def_property("granular_bond_indices", [](const Model& o) { return o.granular_bond_indices; },
            [](Model& o, Span value) { o.granular_bond_indices = value; })
        .def_property("granular_bond_rest_lengths", [](const Model& o) { return o.granular_bond_rest_lengths; },
            [](Model& o, Span value) { o.granular_bond_rest_lengths = value; })
        .def_readwrite("granular_break_strain", &Model::granular_break_strain)
        .def_readwrite("granular_cohesion", &Model::granular_cohesion)
        .def_readwrite("granular_contact_stiffness", &Model::granular_contact_stiffness)
        .def_readwrite("granular_friction", &Model::granular_friction)
        .def_readwrite("granular_friction_damping", &Model::granular_friction_damping)
        .def_readwrite("granular_max_compaction", &Model::granular_max_compaction)
        .def_readwrite("granular_max_dynamic_bonds", &Model::granular_max_dynamic_bonds)
        .def_readwrite("granular_particle_count", &Model::granular_particle_count)
        .def_property("granular_particle_indices", [](const Model& o) { return o.granular_particle_indices; },
            [](Model& o, Span value) { o.granular_particle_indices = value; })
        .def_readwrite("granular_yield_strain", &Model::granular_yield_strain)
        .def_property("gravity", [](const Model& o) { return o.gravity; },
            [](Model& o, Span value) { o.gravity = value; })
        .def_readwrite("hinge_count", &Model::hinge_count)
        .def_property("hinge_indices", [](const Model& o) { return o.hinge_indices; },
            [](Model& o, Span value) { o.hinge_indices = value; })
        .def_property("hinge_rest_angles", [](const Model& o) { return o.hinge_rest_angles; },
            [](Model& o, Span value) { o.hinge_rest_angles = value; })
        .def_property("hinge_stiffnesses", [](const Model& o) { return o.hinge_stiffnesses; },
            [](Model& o, Span value) { o.hinge_stiffnesses = value; })
        .def_property("joint_armature", [](const Model& o) { return o.joint_armature; },
            [](Model& o, Span value) { o.joint_armature = value; })
        .def_readwrite("joint_body_point_line_count", &Model::joint_body_point_line_count)
        .def_readwrite("joint_body_spring_count", &Model::joint_body_spring_count)
        .def_readwrite("joint_constraint_mass_scale", &Model::joint_constraint_mass_scale)
        .def_readwrite("joint_dof_count", &Model::joint_dof_count)
        .def_property("joint_drive_body_indices", [](const Model& o) { return o.joint_drive_body_indices; },
            [](Model& o, Span value) { o.joint_drive_body_indices = value; })
        .def_property("joint_drive_child_origins", [](const Model& o) { return o.joint_drive_child_origins; },
            [](Model& o, Span value) { o.joint_drive_child_origins = value; })
        .def_property("joint_drive_child_reference_points", [](const Model& o) { return o.joint_drive_child_reference_points; },
            [](Model& o, Span value) { o.joint_drive_child_reference_points = value; })
        .def_readwrite("joint_drive_count", &Model::joint_drive_count)
        .def_property("joint_drive_dof_indices", [](const Model& o) { return o.joint_drive_dof_indices; },
            [](Model& o, Span value) { o.joint_drive_dof_indices = value; })
        .def_property("joint_drive_parent_axis_points", [](const Model& o) { return o.joint_drive_parent_axis_points; },
            [](Model& o, Span value) { o.joint_drive_parent_axis_points = value; })
        .def_property("joint_drive_parent_origins", [](const Model& o) { return o.joint_drive_parent_origins; },
            [](Model& o, Span value) { o.joint_drive_parent_origins = value; })
        .def_property("joint_drive_parent_reference_points", [](const Model& o) { return o.joint_drive_parent_reference_points; },
            [](Model& o, Span value) { o.joint_drive_parent_reference_points = value; })
        .def_property("joint_drive_target_indices", [](const Model& o) { return o.joint_drive_target_indices; },
            [](Model& o, Span value) { o.joint_drive_target_indices = value; })
        .def_property("joint_drive_types", [](const Model& o) { return o.joint_drive_types; },
            [](Model& o, Span value) { o.joint_drive_types = value; })
        .def_property("joint_effort_limits", [](const Model& o) { return o.joint_effort_limits; },
            [](Model& o, Span value) { o.joint_effort_limits = value; })
        .def_property("joint_limit_dampings", [](const Model& o) { return o.joint_limit_dampings; },
            [](Model& o, Span value) { o.joint_limit_dampings = value; })
        .def_property("joint_limit_lower", [](const Model& o) { return o.joint_limit_lower; },
            [](Model& o, Span value) { o.joint_limit_lower = value; })
        .def_property("joint_limit_stiffnesses", [](const Model& o) { return o.joint_limit_stiffnesses; },
            [](Model& o, Span value) { o.joint_limit_stiffnesses = value; })
        .def_property("joint_limit_upper", [](const Model& o) { return o.joint_limit_upper; },
            [](Model& o, Span value) { o.joint_limit_upper = value; })
        .def_property("joint_passive_dampings", [](const Model& o) { return o.joint_passive_dampings; },
            [](Model& o, Span value) { o.joint_passive_dampings = value; })
        .def_readwrite("joint_target_count", &Model::joint_target_count)
        .def_property("joint_target_dampings", [](const Model& o) { return o.joint_target_dampings; },
            [](Model& o, Span value) { o.joint_target_dampings = value; })
        .def_property("joint_target_modes", [](const Model& o) { return o.joint_target_modes; },
            [](Model& o, Span value) { o.joint_target_modes = value; })
        .def_property("joint_target_stiffnesses", [](const Model& o) { return o.joint_target_stiffnesses; },
            [](Model& o, Span value) { o.joint_target_stiffnesses = value; })
        .def_readwrite("particle_count", &Model::particle_count)
        .def_property("particle_flags", [](const Model& o) { return o.particle_flags; },
            [](Model& o, Span value) { o.particle_flags = value; })
        .def_property("particle_indices", [](const Model& o) { return o.particle_indices; },
            [](Model& o, Span value) { o.particle_indices = value; })
        .def_readwrite("particle_mass_non_diagonal_count", &Model::particle_mass_non_diagonal_count)
        .def_property("particle_mass_non_diagonal_indices", [](const Model& o) { return o.particle_mass_non_diagonal_indices; },
            [](Model& o, Span value) { o.particle_mass_non_diagonal_indices = value; })
        .def_property("particle_mass_non_diagonal_values", [](const Model& o) { return o.particle_mass_non_diagonal_values; },
            [](Model& o, Span value) { o.particle_mass_non_diagonal_values = value; })
        .def_property("particle_masses", [](const Model& o) { return o.particle_masses; },
            [](Model& o, Span value) { o.particle_masses = value; })
        .def_property("particle_radii", [](const Model& o) { return o.particle_radii; },
            [](Model& o, Span value) { o.particle_radii = value; })
        .def_property("particle_rest_positions", [](const Model& o) { return o.particle_rest_positions; },
            [](Model& o, Span value) { o.particle_rest_positions = value; })
        .def_readwrite("particle_state_count", &Model::particle_state_count)
        .def_property("particle_world", [](const Model& o) { return o.particle_world; },
            [](Model& o, Span value) { o.particle_world = value; })
        .def_property("shape_bodies", [](const Model& o) { return o.shape_bodies; },
            [](Model& o, Span value) { o.shape_bodies = value; })
        .def_property("shape_contact_dampings", [](const Model& o) { return o.shape_contact_dampings; },
            [](Model& o, Span value) { o.shape_contact_dampings = value; })
        .def_property("shape_contact_friction_gains", [](const Model& o) { return o.shape_contact_friction_gains; },
            [](Model& o, Span value) { o.shape_contact_friction_gains = value; })
        .def_property("shape_contact_stiffnesses", [](const Model& o) { return o.shape_contact_stiffnesses; },
            [](Model& o, Span value) { o.shape_contact_stiffnesses = value; })
        .def_readwrite("shape_count", &Model::shape_count)
        .def_property("shape_frictions", [](const Model& o) { return o.shape_frictions; },
            [](Model& o, Span value) { o.shape_frictions = value; })
        .def_property("shape_margins", [](const Model& o) { return o.shape_margins; },
            [](Model& o, Span value) { o.shape_margins = value; })
        .def_readwrite("shape_replicated_count", &Model::shape_replicated_count)
        .def_property("shape_rolling_frictions", [](const Model& o) { return o.shape_rolling_frictions; },
            [](Model& o, Span value) { o.shape_rolling_frictions = value; })
        .def_property("shape_scales", [](const Model& o) { return o.shape_scales; },
            [](Model& o, Span value) { o.shape_scales = value; })
        .def_property("shape_torsional_frictions", [](const Model& o) { return o.shape_torsional_frictions; },
            [](Model& o, Span value) { o.shape_torsional_frictions = value; })
        .def_property("shape_transforms", [](const Model& o) { return o.shape_transforms; },
            [](Model& o, Span value) { o.shape_transforms = value; })
        .def_property("shape_types", [](const Model& o) { return o.shape_types; },
            [](Model& o, Span value) { o.shape_types = value; })
        .def_readwrite("soft_contact_damping", &Model::soft_contact_damping)
        .def_readwrite("soft_contact_friction", &Model::soft_contact_friction)
        .def_readwrite("soft_contact_friction_gain", &Model::soft_contact_friction_gain)
        .def_readwrite("soft_contact_stiffness", &Model::soft_contact_stiffness)
        .def_readwrite("spring_count", &Model::spring_count)
        .def_property("spring_indices", [](const Model& o) { return o.spring_indices; },
            [](Model& o, Span value) { o.spring_indices = value; })
        .def_property("spring_rest_lengths", [](const Model& o) { return o.spring_rest_lengths; },
            [](Model& o, Span value) { o.spring_rest_lengths = value; })
        .def_property("spring_stiffnesses", [](const Model& o) { return o.spring_stiffnesses; },
            [](Model& o, Span value) { o.spring_stiffnesses = value; })
        .def_readwrite("tetrahedron_count", &Model::tetrahedron_count)
        .def_property("tetrahedron_indices", [](const Model& o) { return o.tetrahedron_indices; },
            [](Model& o, Span value) { o.tetrahedron_indices = value; })
        .def_property("tetrahedron_inverse_dms", [](const Model& o) { return o.tetrahedron_inverse_dms; },
            [](Model& o, Span value) { o.tetrahedron_inverse_dms = value; })
        .def_property("tetrahedron_materials", [](const Model& o) { return o.tetrahedron_materials; },
            [](Model& o, Span value) { o.tetrahedron_materials = value; })
        .def_property("triangle_aniso_stiffnesses", [](const Model& o) { return o.triangle_aniso_stiffnesses; },
            [](Model& o, Span value) { o.triangle_aniso_stiffnesses = value; })
        .def_readwrite("triangle_count", &Model::triangle_count)
        .def_property("triangle_drag_coefficients", [](const Model& o) { return o.triangle_drag_coefficients; },
            [](Model& o, Span value) { o.triangle_drag_coefficients = value; })
        .def_property("triangle_indices", [](const Model& o) { return o.triangle_indices; },
            [](Model& o, Span value) { o.triangle_indices = value; })
        .def_property("triangle_inv_dms", [](const Model& o) { return o.triangle_inv_dms; },
            [](Model& o, Span value) { o.triangle_inv_dms = value; })
        .def_property("triangle_masses", [](const Model& o) { return o.triangle_masses; },
            [](Model& o, Span value) { o.triangle_masses = value; })
        .def_property("triangle_rest_areas", [](const Model& o) { return o.triangle_rest_areas; },
            [](Model& o, Span value) { o.triangle_rest_areas = value; })
        .def_readwrite("world_count", &Model::world_count);
    py::class_<State>(module, "State").def(py::init<>())
        .def_property("particle_f", [](const State& o) { return o.particle_f; },
            [](State& o, Span value) { o.particle_f = value; })
        .def_property("particle_q", [](const State& o) { return o.particle_q; },
            [](State& o, Span value) { o.particle_q = value; })
        .def_property("particle_qd", [](const State& o) { return o.particle_qd; },
            [](State& o, Span value) { o.particle_qd = value; });
    py::class_<Control>(module, "Control").def(py::init<>())
        .def_property("joint_drive_velocities", [](const Control& o) { return o.joint_drive_velocities; },
            [](Control& o, Span value) { o.joint_drive_velocities = value; })
        .def_property("joint_f", [](const Control& o) { return o.joint_f; },
            [](Control& o, Span value) { o.joint_f = value; })
        .def_property("joint_target_q", [](const Control& o) { return o.joint_target_q; },
            [](Control& o, Span value) { o.joint_target_q = value; })
        .def_property("joint_target_qd", [](const Control& o) { return o.joint_target_qd; },
            [](Control& o, Span value) { o.joint_target_qd = value; })
        .def_property("tetrahedron_activations", [](const Control& o) { return o.tetrahedron_activations; },
            [](Control& o, Span value) { o.tetrahedron_activations = value; });
    py::class_<Contact>(module, "Contact").def(py::init<>())
        .def_property("count", [](const Contact& o) { return o.count; },
            [](Contact& o, Span value) { o.count = value; })
        .def_readwrite("history_refresh", &Contact::history_refresh)
        .def_property("margin0", [](const Contact& o) { return o.margin0; },
            [](Contact& o, Span value) { o.margin0 = value; })
        .def_property("margin1", [](const Contact& o) { return o.margin1; },
            [](Contact& o, Span value) { o.margin1 = value; })
        .def_property("match_index", [](const Contact& o) { return o.match_index; },
            [](Contact& o, Span value) { o.match_index = value; })
        .def_readwrite("max_count", &Contact::max_count)
        .def_property("normal", [](const Contact& o) { return o.normal; },
            [](Contact& o, Span value) { o.normal = value; })
        .def_property("offset0", [](const Contact& o) { return o.offset0; },
            [](Contact& o, Span value) { o.offset0 = value; })
        .def_property("offset1", [](const Contact& o) { return o.offset1; },
            [](Contact& o, Span value) { o.offset1 = value; })
        .def_property("point0", [](const Contact& o) { return o.point0; },
            [](Contact& o, Span value) { o.point0 = value; })
        .def_property("point1", [](const Contact& o) { return o.point1; },
            [](Contact& o, Span value) { o.point1 = value; })
        .def_property("shape0", [](const Contact& o) { return o.shape0; },
            [](Contact& o, Span value) { o.shape0 = value; })
        .def_property("shape1", [](const Contact& o) { return o.shape1; },
            [](Contact& o, Span value) { o.shape1 = value; })
        .def_property("soft_barycentric", [](const Contact& o) { return o.soft_barycentric; },
            [](Contact& o, Span value) { o.soft_barycentric = value; })
        .def_property("soft_body_pos", [](const Contact& o) { return o.soft_body_pos; },
            [](Contact& o, Span value) { o.soft_body_pos = value; })
        .def_property("soft_body_vel", [](const Contact& o) { return o.soft_body_vel; },
            [](Contact& o, Span value) { o.soft_body_vel = value; })
        .def_property("soft_count", [](const Contact& o) { return o.soft_count; },
            [](Contact& o, Span value) { o.soft_count = value; })
        .def_property("soft_indices", [](const Contact& o) { return o.soft_indices; },
            [](Contact& o, Span value) { o.soft_indices = value; })
        .def_readwrite("soft_max_count", &Contact::soft_max_count)
        .def_property("soft_normal", [](const Contact& o) { return o.soft_normal; },
            [](Contact& o, Span value) { o.soft_normal = value; })
        .def_property("soft_particle", [](const Contact& o) { return o.soft_particle; },
            [](Contact& o, Span value) { o.soft_particle = value; })
        .def_property("soft_particle_only_shapes", [](const Contact& o) { return o.soft_particle_only_shapes; },
            [](Contact& o, Span value) { o.soft_particle_only_shapes = value; })
        .def_property("soft_shape", [](const Contact& o) { return o.soft_shape; },
            [](Contact& o, Span value) { o.soft_shape = value; });
    py::class_<Config>(module, "Config").def(py::init<>())
        .def_readwrite("affine_body_block_preconditioner", &Config::affine_body_block_preconditioner)
        .def_readwrite("affine_body_contact_block_preconditioner", &Config::affine_body_contact_block_preconditioner)
        .def_readwrite("affine_body_rigidity_model", &Config::affine_body_rigidity_model)
        .def_readwrite("affine_body_rigidity_primal_iterations", &Config::affine_body_rigidity_primal_iterations)
        .def_property("air_density", [](const Config& o) { return o.air_density; },
            [](Config& o, float value) {
                if (!std::isfinite(value) || value < 0.0f)
                    throw py::value_error("air_density must be finite and non-negative");
                o.air_density = value;
            })
        .def_readwrite("cable_angular_beta", &Config::cable_angular_beta)
        .def_readwrite("cable_angular_k_start", &Config::cable_angular_k_start)
        .def_readwrite("cable_linear_beta", &Config::cable_linear_beta)
        .def_readwrite("cable_linear_k_start", &Config::cable_linear_k_start)
        .def_readwrite("cable_penalty_gamma", &Config::cable_penalty_gamma)
        .def_readwrite("constraint_alpha", &Config::constraint_alpha)
        .def_readwrite("enable_collision_hessian_non_diagonal", &Config::enable_collision_hessian_non_diagonal)
        .def_readwrite("enable_self_collision", &Config::enable_self_collision)
        .def_readwrite("fluid_max_step_ratio", &Config::fluid_max_step_ratio)
        .def_readwrite("fluid_relaxation", &Config::fluid_relaxation)
        .def_readwrite("inertia_mode", &Config::inertia_mode)
        .def_readwrite("joint_constraint_mode", &Config::joint_constraint_mode)
        .def_readwrite("joint_constraint_primal_iterations", &Config::joint_constraint_primal_iterations)
        .def_readwrite("linear_iterations", &Config::linear_iterations)
        .def_readwrite("nonlinear_iterations", &Config::nonlinear_iterations)
        .def_readwrite("nonlinear_solver", &Config::nonlinear_solver)
        .def_readwrite("rigid_contact_alpha", &Config::rigid_contact_alpha)
        .def_readwrite("rigid_contact_beta", &Config::rigid_contact_beta)
        .def_readwrite("rigid_contact_friction_epsilon", &Config::rigid_contact_friction_epsilon)
        .def_readwrite("rigid_contact_gamma", &Config::rigid_contact_gamma)
        .def_readwrite("rigid_contact_hard", &Config::rigid_contact_hard)
        .def_readwrite("rigid_contact_history", &Config::rigid_contact_history)
        .def_readwrite("rigid_contact_k_start", &Config::rigid_contact_k_start)
        .def_readwrite("rigid_contact_sliding_tangent", &Config::rigid_contact_sliding_tangent)
        .def_readwrite("rolling_friction_velocity_epsilon", &Config::rolling_friction_velocity_epsilon)
        .def_readwrite("self_collision_edge_edge_stiffness", &Config::self_collision_edge_edge_stiffness)
        .def_readwrite("self_collision_edge_face_stiffness", &Config::self_collision_edge_face_stiffness)
        .def_readwrite("self_collision_particle_particle_stiffness", &Config::self_collision_particle_particle_stiffness)
        .def_readwrite("self_collision_radius", &Config::self_collision_radius)
        .def_readwrite("self_collision_vertex_face_stiffness", &Config::self_collision_vertex_face_stiffness)
        .def_property("wind_velocity", [](const Config& o) {
            return py::make_tuple(o.wind_velocity[0], o.wind_velocity[1], o.wind_velocity[2]);
        }, [](Config& o, py::sequence value) {
            if (py::len(value) != 3)
                throw py::value_error("wind_velocity must contain three finite components");
            std::array<float, 3> parsed{value[0].cast<float>(), value[1].cast<float>(),
                                        value[2].cast<float>()};
            for (auto component : parsed) if (!std::isfinite(component))
                throw py::value_error("wind_velocity must contain three finite components");
            o.wind_velocity = parsed;
        });
}
