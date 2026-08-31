"""

Native bindings for Synreal Solver.

Array fields are represented by non-owning Span objects that refer to CUDA
device memory. The caller is responsible for keeping every referenced device
allocation alive for as long as native code may access it.
"""
from __future__ import annotations
import collections.abc
import typing
__all__: list[str] = ['AffineBodyRigidityModel', 'Config', 'Contact', 'Control', 'LogLevel', 'Model', 'Solver', 'Span', 'State', 'is_logged_in', 'login', 'set_log_callback']
class AffineBodyRigidityModel:
    """
    Members:
    
      CO_ROTATED
    
      ABD_ORTHOGONALITY
    
      SIX_SPRINGS
    """
    ABD_ORTHOGONALITY: typing.ClassVar[AffineBodyRigidityModel]  # value = <AffineBodyRigidityModel.ABD_ORTHOGONALITY: 1>
    CO_ROTATED: typing.ClassVar[AffineBodyRigidityModel]  # value = <AffineBodyRigidityModel.CO_ROTATED: 0>
    SIX_SPRINGS: typing.ClassVar[AffineBodyRigidityModel]  # value = <AffineBodyRigidityModel.SIX_SPRINGS: 2>
    __members__: typing.ClassVar[dict[str, AffineBodyRigidityModel]]  # value = {'CO_ROTATED': <AffineBodyRigidityModel.CO_ROTATED: 0>, 'ABD_ORTHOGONALITY': <AffineBodyRigidityModel.ABD_ORTHOGONALITY: 1>, 'SIX_SPRINGS': <AffineBodyRigidityModel.SIX_SPRINGS: 2>}
    @typing.overload
    def __eq__(self, other: AffineBodyRigidityModel) -> bool:
        ...
    @typing.overload
    def __eq__(self, other: typing.Any) -> bool:
        ...
    def __getstate__(self) -> int:
        ...
    def __hash__(self) -> int:
        ...
    def __index__(self) -> int:
        ...
    def __init__(self, value: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    def __int__(self) -> int:
        ...
    @typing.overload
    def __ne__(self, other: AffineBodyRigidityModel) -> bool:
        ...
    @typing.overload
    def __ne__(self, other: typing.Any) -> bool:
        ...
    def __repr__(self) -> str:
        ...
    def __setstate__(self, state: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    def __str__(self) -> str:
        ...
    @property
    def name(self) -> str:
        ...
    @property
    def value(self) -> int:
        ...
class Config:
    """
    
    Runtime configuration for a Synreal solver.
    
    Changes made through ``solver.config`` affect subsequent direct step calls.
    Previously captured CUDA graphs must be rebuilt after a configuration change.
    """
    def __init__(self) -> None:
        """
        Create the default solver configuration.
        """
    @property
    def affine_body_rigidity_model(self) -> AffineBodyRigidityModel:
        """
        Rigidity law used for affine bodies: co-rotated, original ABD orthogonality, or six springs.
        """
    @affine_body_rigidity_model.setter
    def affine_body_rigidity_model(self, arg0: AffineBodyRigidityModel) -> None:
        ...
    @property
    def affine_body_spring_alpha(self) -> float:
        """
        Maximum generalized eigenvalue of dt^2*K_rigidity*v = alpha*M*v for the selected affine-body rigidity model.
        """
    @affine_body_spring_alpha.setter
    def affine_body_spring_alpha(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def distance_constraint_alpha(self) -> float:
        """
        ADMM penalty eigenvalue for mass-normalized hard distance constraints.
        """
    @distance_constraint_alpha.setter
    def distance_constraint_alpha(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def enable_affine_body_velocity_correction(self) -> bool:
        """
        Whether the Newton Python adapter rebuilds affine-proxy linear velocities from body twists before stepping.
        """
    @enable_affine_body_velocity_correction.setter
    def enable_affine_body_velocity_correction(self, arg0: bool) -> None:
        ...
    @property
    def joint_constraint_alpha(self) -> float:
        """
        Maximum generalized eigenvalue of dt^2*K_joint*v = alpha*M*v for generated joint constraints.
        """
    @joint_constraint_alpha.setter
    def joint_constraint_alpha(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def linear_iterations(self) -> int:
        """
        PCG iterations per nonlinear iteration.
        """
    @linear_iterations.setter
    def linear_iterations(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def nonlinear_iterations(self) -> int:
        """
        Nonlinear iterations per step.
        """
    @nonlinear_iterations.setter
    def nonlinear_iterations(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
class Contact:
    """
    
    Non-owning views of Newton rigid- and soft-contact buffers consumed by the native solver.
    """
    def __init__(self) -> None:
        """
        Create an empty contact view.
        """
    @property
    def count(self) -> Span:
        """
        Device span containing the active rigid-contact count.
        """
    @count.setter
    def count(self, arg1: Span) -> None:
        ...
    @property
    def margin0(self) -> Span:
        """
        Device span containing the first shape contact margin.
        """
    @margin0.setter
    def margin0(self, arg1: Span) -> None:
        ...
    @property
    def margin1(self) -> Span:
        """
        Device span containing the second shape contact margin.
        """
    @margin1.setter
    def margin1(self, arg1: Span) -> None:
        ...
    @property
    def max_count(self) -> int:
        """
        Maximum number of rigid contacts stored in the arrays.
        """
    @max_count.setter
    def max_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def normal(self) -> Span:
        """
        Device span containing world-space normals from shape zero to shape one.
        """
    @normal.setter
    def normal(self, arg1: Span) -> None:
        ...
    @property
    def point0(self) -> Span:
        """
        Device span containing body-frame points on the first shape.
        """
    @point0.setter
    def point0(self, arg1: Span) -> None:
        ...
    @property
    def point1(self) -> Span:
        """
        Device span containing body-frame points on the second shape.
        """
    @point1.setter
    def point1(self, arg1: Span) -> None:
        ...
    @property
    def shape0(self) -> Span:
        """
        Device span containing the first shape index.
        """
    @shape0.setter
    def shape0(self, arg1: Span) -> None:
        ...
    @property
    def shape1(self) -> Span:
        """
        Device span containing the second shape index.
        """
    @shape1.setter
    def shape1(self, arg1: Span) -> None:
        ...
    @property
    def soft_body_pos(self) -> Span:
        """
        Device span containing body-local contact points on collision shapes.
        """
    @soft_body_pos.setter
    def soft_body_pos(self, arg1: Span) -> None:
        ...
    @property
    def soft_body_vel(self) -> Span:
        """
        Device span containing body-local surface velocities at soft contacts.
        """
    @soft_body_vel.setter
    def soft_body_vel(self, arg1: Span) -> None:
        ...
    @property
    def soft_count(self) -> Span:
        """
        Device span containing the active soft-contact count.
        """
    @soft_count.setter
    def soft_count(self, arg1: Span) -> None:
        ...
    @property
    def soft_max_count(self) -> int:
        """
        Maximum number of soft contacts stored in the arrays.
        """
    @soft_max_count.setter
    def soft_max_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def soft_normal(self) -> Span:
        """
        Device span containing world-space normals from shapes to particles.
        """
    @soft_normal.setter
    def soft_normal(self, arg1: Span) -> None:
        ...
    @property
    def soft_particle(self) -> Span:
        """
        Device span containing the particle index of each soft contact.
        """
    @soft_particle.setter
    def soft_particle(self, arg1: Span) -> None:
        ...
    @property
    def soft_shape(self) -> Span:
        """
        Device span containing the shape index of each soft contact.
        """
    @soft_shape.setter
    def soft_shape(self, arg1: Span) -> None:
        ...
class Control:
    """
    
    Non-owning views of Newton joint-control buffers consumed by the native solver.
    """
    def __init__(self) -> None:
        """
        Create an empty control view.
        """
    @property
    def joint_f(self) -> Span:
        """
        Device span containing generalized feedforward joint forces.
        """
    @joint_f.setter
    def joint_f(self, arg1: Span) -> None:
        ...
    @property
    def joint_target_q(self) -> Span:
        """
        Device span containing generalized joint-position targets.
        """
    @joint_target_q.setter
    def joint_target_q(self, arg1: Span) -> None:
        ...
    @property
    def joint_target_qd(self) -> Span:
        """
        Device span containing generalized joint-velocity targets.
        """
    @joint_target_qd.setter
    def joint_target_qd(self, arg1: Span) -> None:
        ...
class LogLevel:
    """
    Members:
    
      INFO
    
      ERROR
    
      DEBUG
    
      WARNING
    """
    DEBUG: typing.ClassVar[LogLevel]  # value = <LogLevel.DEBUG: 2>
    ERROR: typing.ClassVar[LogLevel]  # value = <LogLevel.ERROR: 1>
    INFO: typing.ClassVar[LogLevel]  # value = <LogLevel.INFO: 0>
    WARNING: typing.ClassVar[LogLevel]  # value = <LogLevel.WARNING: 4>
    __members__: typing.ClassVar[dict[str, LogLevel]]  # value = {'INFO': <LogLevel.INFO: 0>, 'ERROR': <LogLevel.ERROR: 1>, 'DEBUG': <LogLevel.DEBUG: 2>, 'WARNING': <LogLevel.WARNING: 4>}
    @typing.overload
    def __eq__(self, other: LogLevel) -> bool:
        ...
    @typing.overload
    def __eq__(self, other: typing.SupportsInt | typing.SupportsIndex) -> bool:
        ...
    @typing.overload
    def __eq__(self, other: typing.Any) -> bool:
        ...
    def __getstate__(self) -> int:
        ...
    def __hash__(self) -> int:
        ...
    def __index__(self) -> int:
        ...
    def __init__(self, value: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    def __int__(self) -> int:
        ...
    @typing.overload
    def __ne__(self, other: LogLevel) -> bool:
        ...
    @typing.overload
    def __ne__(self, other: typing.SupportsInt | typing.SupportsIndex) -> bool:
        ...
    @typing.overload
    def __ne__(self, other: typing.Any) -> bool:
        ...
    def __repr__(self) -> str:
        ...
    def __setstate__(self, state: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    def __str__(self) -> str:
        ...
    @property
    def name(self) -> str:
        ...
    @property
    def value(self) -> int:
        ...
class Model:
    """
    
    Simulation topology and physical parameters consumed by a Solver.
    
    All array properties are non-owning views of CUDA device memory. Their device
    allocations must remain valid while the solver uses this model.
    """
    def __init__(self) -> None:
        """
        Create an empty model with no referenced device data.
        """
    @property
    def affine_body_axis_lengths(self) -> Span:
        """
        Device span containing one reference frame-axis length per affine body.
        """
    @affine_body_axis_lengths.setter
    def affine_body_axis_lengths(self, arg1: Span) -> None:
        ...
    @property
    def affine_body_corotated_scales(self) -> Span:
        """
        Device span containing one co-rotated mass-normalization scale per affine body.
        """
    @affine_body_corotated_scales.setter
    def affine_body_corotated_scales(self, arg1: Span) -> None:
        ...
    @property
    def affine_body_ids(self) -> Span:
        """
        Device span mapping affine bodies to Newton body indices.
        """
    @affine_body_ids.setter
    def affine_body_ids(self, arg1: Span) -> None:
        ...
    @property
    def affine_body_indices(self) -> Span:
        """
        Device span containing the four particle indices of each affine body.
        """
    @affine_body_indices.setter
    def affine_body_indices(self, arg1: Span) -> None:
        ...
    @property
    def affine_body_orthogonality_scales(self) -> Span:
        """
        Device span containing one original-ABD mass-normalization scale per affine body.
        """
    @affine_body_orthogonality_scales.setter
    def affine_body_orthogonality_scales(self, arg1: Span) -> None:
        ...
    @property
    def affine_body_rigidity_scales(self) -> Span:
        """
        Device span containing one six-spring mass-normalization scale per affine body.
        """
    @affine_body_rigidity_scales.setter
    def affine_body_rigidity_scales(self, arg1: Span) -> None:
        ...
    @property
    def body_centers_of_mass(self) -> Span:
        """
        Device span containing each affine body's body-frame center of mass.
        """
    @body_centers_of_mass.setter
    def body_centers_of_mass(self, arg1: Span) -> None:
        ...
    @property
    def body_count(self) -> int:
        """
        Number of affine bodies in one static world template.
        """
    @body_count.setter
    def body_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def body_distance_constraint_count(self) -> int:
        """
        Number of augmented-Lagrangian hard distance constraints between affine bodies.
        """
    @body_distance_constraint_count.setter
    def body_distance_constraint_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def body_distance_constraint_indices(self) -> Span:
        """
        Device span containing the two affine-body indices of each hard distance constraint.
        """
    @body_distance_constraint_indices.setter
    def body_distance_constraint_indices(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_mass_scales(self) -> Span:
        """
        Device span containing one mass-normalization scale per hard distance constraint.
        """
    @body_distance_constraint_mass_scales.setter
    def body_distance_constraint_mass_scales(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_points0(self) -> Span:
        """
        Device span containing the first body-local point of each hard distance constraint.
        """
    @body_distance_constraint_points0.setter
    def body_distance_constraint_points0(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_points1(self) -> Span:
        """
        Device span containing the second body-local point of each hard distance constraint.
        """
    @body_distance_constraint_points1.setter
    def body_distance_constraint_points1(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_rest_lengths(self) -> Span:
        """
        Device span containing one rest length per hard distance constraint.
        """
    @body_distance_constraint_rest_lengths.setter
    def body_distance_constraint_rest_lengths(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_weights0(self) -> Span:
        """
        Device span containing the first affine-body interpolation weights of each hard distance constraint.
        """
    @body_distance_constraint_weights0.setter
    def body_distance_constraint_weights0(self, arg1: Span) -> None:
        ...
    @property
    def body_distance_constraint_weights1(self) -> Span:
        """
        Device span containing the second affine-body interpolation weights of each hard distance constraint.
        """
    @body_distance_constraint_weights1.setter
    def body_distance_constraint_weights1(self, arg1: Span) -> None:
        ...
    @property
    def body_inertia_tensors(self) -> Span:
        """
        Device span containing one inertia tensor per affine body.
        """
    @body_inertia_tensors.setter
    def body_inertia_tensors(self, arg1: Span) -> None:
        ...
    @property
    def body_local_transforms(self) -> Span:
        """
        Device span containing one local transform per affine body.
        """
    @body_local_transforms.setter
    def body_local_transforms(self, arg1: Span) -> None:
        ...
    @property
    def body_masses(self) -> Span:
        """
        Device span containing one mass value per affine body.
        """
    @body_masses.setter
    def body_masses(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_count(self) -> int:
        """
        Number of point-to-line-segment constraints between affine bodies.
        """
    @body_point_line_count.setter
    def body_point_line_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def body_point_line_dampings(self) -> Span:
        """
        Device span containing one damping value per point-line constraint.
        """
    @body_point_line_dampings.setter
    def body_point_line_dampings(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_endpoints0(self) -> Span:
        """
        Device span containing the first body-local line endpoint of each point-line constraint.
        """
    @body_point_line_endpoints0.setter
    def body_point_line_endpoints0(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_endpoints1(self) -> Span:
        """
        Device span containing the second body-local line endpoint of each point-line constraint.
        """
    @body_point_line_endpoints1.setter
    def body_point_line_endpoints1(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_indices(self) -> Span:
        """
        Device span containing the point-body and line-body indices of each point-line constraint.
        """
    @body_point_line_indices.setter
    def body_point_line_indices(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_points(self) -> Span:
        """
        Device span containing the constrained body-local point of each point-line constraint.
        """
    @body_point_line_points.setter
    def body_point_line_points(self, arg1: Span) -> None:
        ...
    @property
    def body_point_line_stiffnesses(self) -> Span:
        """
        Device span containing one stiffness value per point-line constraint.
        """
    @body_point_line_stiffnesses.setter
    def body_point_line_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def body_spring_count(self) -> int:
        """
        Number of point-to-point springs between affine bodies.
        """
    @body_spring_count.setter
    def body_spring_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def body_spring_indices(self) -> Span:
        """
        Device span containing the two affine-body indices of each body spring.
        """
    @body_spring_indices.setter
    def body_spring_indices(self, arg1: Span) -> None:
        ...
    @property
    def body_spring_points0(self) -> Span:
        """
        Device span containing the first body-local point of each body spring.
        """
    @body_spring_points0.setter
    def body_spring_points0(self, arg1: Span) -> None:
        ...
    @property
    def body_spring_points1(self) -> Span:
        """
        Device span containing the second body-local point of each body spring.
        """
    @body_spring_points1.setter
    def body_spring_points1(self, arg1: Span) -> None:
        ...
    @property
    def body_spring_rest_lengths(self) -> Span:
        """
        Device span containing one rest length per body spring.
        """
    @body_spring_rest_lengths.setter
    def body_spring_rest_lengths(self, arg1: Span) -> None:
        ...
    @property
    def body_spring_stiffnesses(self) -> Span:
        """
        Device span containing one stiffness value per body spring.
        """
    @body_spring_stiffnesses.setter
    def body_spring_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def body_state_count(self) -> int:
        """
        Number of affine bodies in all dynamic world states.
        """
    @body_state_count.setter
    def body_state_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def edge_bending_cots(self) -> Span:
        """
        Device span containing four rest-pose cotangents per bending edge.
        """
    @edge_bending_cots.setter
    def edge_bending_cots(self, arg1: Span) -> None:
        ...
    @property
    def edge_bending_properties(self) -> Span:
        """
        Device span containing stiffness and damping for each bending edge.
        """
    @edge_bending_properties.setter
    def edge_bending_properties(self, arg1: Span) -> None:
        ...
    @property
    def edge_count(self) -> int:
        """
        Number of Style3D bending edges in the model.
        """
    @edge_count.setter
    def edge_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def edge_indices(self) -> Span:
        """
        Device span containing one four-particle bending stencil per edge.
        """
    @edge_indices.setter
    def edge_indices(self, arg1: Span) -> None:
        ...
    @property
    def edge_rest_areas(self) -> Span:
        """
        Device span containing the summed rest area adjacent to each bending edge.
        """
    @edge_rest_areas.setter
    def edge_rest_areas(self, arg1: Span) -> None:
        ...
    @property
    def gravity(self) -> Span:
        """
        Device span containing one gravity vector per world.
        """
    @gravity.setter
    def gravity(self, arg1: Span) -> None:
        ...
    @property
    def hinge_count(self) -> int:
        """
        Number of bending hinges in the model.
        """
    @hinge_count.setter
    def hinge_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def hinge_indices(self) -> Span:
        """
        Device span containing the four particle indices of each hinge.
        """
    @hinge_indices.setter
    def hinge_indices(self, arg1: Span) -> None:
        ...
    @property
    def hinge_rest_angles(self) -> Span:
        """
        Device span containing one rest angle per hinge.
        """
    @hinge_rest_angles.setter
    def hinge_rest_angles(self, arg1: Span) -> None:
        ...
    @property
    def hinge_stiffnesses(self) -> Span:
        """
        Device span containing one bending stiffness value per hinge.
        """
    @hinge_stiffnesses.setter
    def hinge_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def joint_body_point_line_count(self) -> int:
        """
        Number of joint-generated constraints at the end of the point-line arrays.
        """
    @joint_body_point_line_count.setter
    def joint_body_point_line_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_body_spring_count(self) -> int:
        """
        Number of joint-generated springs at the end of the body spring arrays.
        """
    @joint_body_spring_count.setter
    def joint_body_spring_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_constraint_mass_scale(self) -> float:
        """
        Mass-normalization scale shared by generated joint constraints.
        """
    @joint_constraint_mass_scale.setter
    def joint_constraint_mass_scale(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_dof_count(self) -> int:
        """
        Number of generalized joint-velocity coordinates.
        """
    @joint_dof_count.setter
    def joint_dof_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_drive_body_indices(self) -> Span:
        """
        Device span containing each drive's parent and child affine-body indices.
        """
    @joint_drive_body_indices.setter
    def joint_drive_body_indices(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_child_origins(self) -> Span:
        """
        Device span containing child-frame joint origins.
        """
    @joint_drive_child_origins.setter
    def joint_drive_child_origins(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_child_reference_points(self) -> Span:
        """
        Device span containing child-frame angular reference points.
        """
    @joint_drive_child_reference_points.setter
    def joint_drive_child_reference_points(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_count(self) -> int:
        """
        Number of single-axis joint drives.
        """
    @joint_drive_count.setter
    def joint_drive_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_drive_dof_indices(self) -> Span:
        """
        Device span mapping drives to generalized force and velocity coordinates.
        """
    @joint_drive_dof_indices.setter
    def joint_drive_dof_indices(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_parent_axis_points(self) -> Span:
        """
        Device span containing parent-frame unit-axis points.
        """
    @joint_drive_parent_axis_points.setter
    def joint_drive_parent_axis_points(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_parent_origins(self) -> Span:
        """
        Device span containing parent-frame joint origins.
        """
    @joint_drive_parent_origins.setter
    def joint_drive_parent_origins(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_parent_reference_points(self) -> Span:
        """
        Device span containing parent-frame angular reference points.
        """
    @joint_drive_parent_reference_points.setter
    def joint_drive_parent_reference_points(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_target_indices(self) -> Span:
        """
        Device span mapping drives to generalized position targets.
        """
    @joint_drive_target_indices.setter
    def joint_drive_target_indices(self, arg1: Span) -> None:
        ...
    @property
    def joint_drive_types(self) -> Span:
        """
        Device span containing each joint drive type.
        """
    @joint_drive_types.setter
    def joint_drive_types(self, arg1: Span) -> None:
        ...
    @property
    def joint_target_count(self) -> int:
        """
        Number of generalized joint-position targets.
        """
    @joint_target_count.setter
    def joint_target_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def joint_target_dampings(self) -> Span:
        """
        Device span containing joint target damping values.
        """
    @joint_target_dampings.setter
    def joint_target_dampings(self, arg1: Span) -> None:
        ...
    @property
    def joint_target_stiffnesses(self) -> Span:
        """
        Device span containing joint target stiffness values.
        """
    @joint_target_stiffnesses.setter
    def joint_target_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def particle_count(self) -> int:
        """
        Number of particles in one static world template.
        """
    @particle_count.setter
    def particle_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def particle_flags(self) -> Span:
        """
        Device span containing Newton particle flags.
        """
    @particle_flags.setter
    def particle_flags(self, arg1: Span) -> None:
        ...
    @property
    def particle_indices(self) -> Span:
        """
        Device span containing the index of each particle.
        """
    @particle_indices.setter
    def particle_indices(self, arg1: Span) -> None:
        ...
    @property
    def particle_mass_non_diagonal_count(self) -> int:
        """
        Number of symmetric off-diagonal particle mass entries.
        """
    @particle_mass_non_diagonal_count.setter
    def particle_mass_non_diagonal_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def particle_mass_non_diagonal_indices(self) -> Span:
        """
        Device span containing one particle-index pair per symmetric off-diagonal mass entry.
        """
    @particle_mass_non_diagonal_indices.setter
    def particle_mass_non_diagonal_indices(self, arg1: Span) -> None:
        ...
    @property
    def particle_mass_non_diagonal_values(self) -> Span:
        """
        Device span containing symmetric off-diagonal particle mass values.
        """
    @particle_mass_non_diagonal_values.setter
    def particle_mass_non_diagonal_values(self, arg1: Span) -> None:
        ...
    @property
    def particle_masses(self) -> Span:
        """
        Device span containing diagonal entries of the particle mass matrix.
        """
    @particle_masses.setter
    def particle_masses(self, arg1: Span) -> None:
        ...
    @property
    def particle_radii(self) -> Span:
        """
        Device span containing particle collision radii.
        """
    @particle_radii.setter
    def particle_radii(self, arg1: Span) -> None:
        ...
    @property
    def particle_state_count(self) -> int:
        """
        Number of particles in all dynamic world states.
        """
    @particle_state_count.setter
    def particle_state_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def particle_world(self) -> Span:
        """
        Device span containing the world index of each particle.
        """
    @particle_world.setter
    def particle_world(self, arg1: Span) -> None:
        ...
    @property
    def shape_bodies(self) -> Span:
        """
        Device span mapping collision shapes to Newton body indices.
        """
    @shape_bodies.setter
    def shape_bodies(self, arg1: Span) -> None:
        ...
    @property
    def shape_contact_dampings(self) -> Span:
        """
        Device span containing shape contact damping values.
        """
    @shape_contact_dampings.setter
    def shape_contact_dampings(self, arg1: Span) -> None:
        ...
    @property
    def shape_contact_stiffnesses(self) -> Span:
        """
        Device span containing shape contact stiffness values.
        """
    @shape_contact_stiffnesses.setter
    def shape_contact_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def shape_count(self) -> int:
        """
        Number of collision shapes in the model.
        """
    @shape_count.setter
    def shape_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def shape_frictions(self) -> Span:
        """
        Device span containing shape Coulomb-friction coefficients.
        """
    @shape_frictions.setter
    def shape_frictions(self, arg1: Span) -> None:
        ...
    @property
    def shape_margins(self) -> Span:
        """
        Device span containing shape collision margins.
        """
    @shape_margins.setter
    def shape_margins(self, arg1: Span) -> None:
        ...
    @property
    def shape_replicated_count(self) -> int:
        """
        Number of collision shapes replicated in each world.
        """
    @shape_replicated_count.setter
    def shape_replicated_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def soft_contact_damping(self) -> float:
        """
        Particle contact damping.
        """
    @soft_contact_damping.setter
    def soft_contact_damping(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def soft_contact_friction(self) -> float:
        """
        Particle contact Coulomb-friction coefficient.
        """
    @soft_contact_friction.setter
    def soft_contact_friction(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def soft_contact_stiffness(self) -> float:
        """
        Particle contact stiffness.
        """
    @soft_contact_stiffness.setter
    def soft_contact_stiffness(self, arg0: typing.SupportsFloat | typing.SupportsIndex) -> None:
        ...
    @property
    def spring_count(self) -> int:
        """
        Number of distance springs in the model.
        """
    @spring_count.setter
    def spring_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def spring_indices(self) -> Span:
        """
        Device span containing the two particle indices of each spring.
        """
    @spring_indices.setter
    def spring_indices(self, arg1: Span) -> None:
        ...
    @property
    def spring_rest_lengths(self) -> Span:
        """
        Device span containing one rest length per spring.
        """
    @spring_rest_lengths.setter
    def spring_rest_lengths(self, arg1: Span) -> None:
        ...
    @property
    def spring_stiffnesses(self) -> Span:
        """
        Device span containing one stiffness value per spring.
        """
    @spring_stiffnesses.setter
    def spring_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def triangle_aniso_stiffnesses(self) -> Span:
        """
        Device span containing one Style3D anisotropic stiffness vector per triangle.
        """
    @triangle_aniso_stiffnesses.setter
    def triangle_aniso_stiffnesses(self, arg1: Span) -> None:
        ...
    @property
    def triangle_count(self) -> int:
        """
        Number of surface triangles in the model.
        """
    @triangle_count.setter
    def triangle_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
    @property
    def triangle_indices(self) -> Span:
        """
        Device span containing the three particle indices of each triangle.
        """
    @triangle_indices.setter
    def triangle_indices(self, arg1: Span) -> None:
        ...
    @property
    def triangle_inv_dms(self) -> Span:
        """
        Device span containing one inverse rest-shape matrix per triangle.
        """
    @triangle_inv_dms.setter
    def triangle_inv_dms(self, arg1: Span) -> None:
        ...
    @property
    def triangle_masses(self) -> Span:
        """
        Device span containing one mass value per triangle.
        """
    @triangle_masses.setter
    def triangle_masses(self, arg1: Span) -> None:
        ...
    @property
    def triangle_rest_areas(self) -> Span:
        """
        Device span containing one rest-area value per triangle.
        """
    @triangle_rest_areas.setter
    def triangle_rest_areas(self, arg1: Span) -> None:
        ...
    @property
    def world_count(self) -> int:
        """
        Number of simulation worlds in the model.
        """
    @world_count.setter
    def world_count(self, arg0: typing.SupportsInt | typing.SupportsIndex) -> None:
        ...
class Solver:
    """
    
    Time-step solver for a Synreal simulation model.
    
    Call initialize() once with a configured Model before calling step().
    """
    def __init__(self) -> None:
        """
        Create the default solver implementation.
        """
    def initialize(self, model: Model) -> None:
        """
        Initialize the solver for a model.
        
        The model's device allocations must remain valid while the solver uses them.
        Call this method before the first call to step().
        """
    @typing.overload
    def step(self, state_in: State, state_out: State, dt: typing.SupportsFloat | typing.SupportsIndex, stream: typing.Any = None) -> None:
        """
        Advance without collision contacts or joint controls.
        """
    @typing.overload
    def step(self, state_in: State, state_out: State, contact: Contact, dt: typing.SupportsFloat | typing.SupportsIndex, stream: typing.Any = None) -> None:
        """
        Advance with collision contacts but without joint controls.
        """
    @typing.overload
    def step(self, state_in: State, state_out: State, control: Control, contact: Contact, dt: typing.SupportsFloat | typing.SupportsIndex, stream: typing.Any = None) -> None:
        """
        Advance the simulation by one time step.
        
        Parameters:
        	state_in: State containing the input particle data.
        	state_out: State whose referenced device memory receives the output data.
        	control: Non-owning views of Newton's generalized joint-control buffers.
        	contact: Non-owning views of the active Newton rigid-contact buffers.
        	dt: Time-step duration.
        	stream: CUDA Stream Protocol object, integer CUDA stream handle, or None for
        		the default stream. All asynchronous work is submitted to this stream.
        
        initialize() must be called before this method. All referenced device
        allocations must remain valid until the solver work finishes.
        """
    @property
    def config(self) -> Config:
        """
        Mutable runtime solver configuration. Captured CUDA graphs must be rebuilt after changes.
        """
    @config.setter
    def config(self, arg0: Config) -> None:
        ...
class Span:
    """
    
    A non-owning view of a contiguous CUDA device-memory range.
    
    Span stores an opaque device address and an element count. It does not allocate,
    free, validate, or dereference the referenced memory.
    """
    @typing.overload
    def __init__(self) -> None:
        """
        Create an empty span with a null address and zero elements.
        """
    @typing.overload
    def __init__(self, ptr: typing.SupportsInt | typing.SupportsIndex, size: typing.SupportsInt | typing.SupportsIndex) -> None:
        """
        Create a non-owning span from a device address and an element count.
        """
    def __len__(self) -> int:
        """
        Return the number of elements in the span.
        """
    def __repr__(self) -> str:
        """
        Return an unambiguous string representation of the span.
        """
    @property
    def ptr(self) -> int:
        """
        Integer address of the first element in CUDA device memory.
        """
    @property
    def size(self) -> int:
        """
        Number of elements in the range, not its size in bytes.
        """
class State:
    """
    
    Particle positions and velocities used as solver input or output.
    
    Both properties are non-owning views of mutable CUDA device memory. Their
    device allocations must remain valid until the associated solver work finishes.
    """
    def __init__(self) -> None:
        """
        Create an empty state with no referenced device data.
        """
    @property
    def particle_f(self) -> Span:
        """
        Device span containing one external-force vector per particle.
        """
    @particle_f.setter
    def particle_f(self, arg1: Span) -> None:
        ...
    @property
    def particle_q(self) -> Span:
        """
        Device span containing one position vector per particle.
        """
    @particle_q.setter
    def particle_q(self, arg1: Span) -> None:
        ...
    @property
    def particle_qd(self) -> Span:
        """
        Device span containing one velocity vector per particle.
        """
    @particle_qd.setter
    def particle_qd(self, arg1: Span) -> None:
        ...
def is_logged_in() -> bool:
    """
    Return whether the session is authenticated.
    """
def login(name: str, password: str, force_signin: bool) -> bool:
    """
    Authenticate the SynReal client.
    """
def set_log_callback(callback: collections.abc.Callable[[str, str, int, LogLevel, str], None]) -> None:
    """
    Register a callback invoked for each native log message.
    """
