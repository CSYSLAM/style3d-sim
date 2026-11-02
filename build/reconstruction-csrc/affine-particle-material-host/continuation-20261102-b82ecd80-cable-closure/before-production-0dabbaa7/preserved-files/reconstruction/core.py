"""Pure-Python drop-in for the legacy native module `style3d_sim._core`.

`install()` registers this module as `style3d_sim._core`, so the unmodified Python wrapper (style3d_sim.NewtonSolver)
and every demo run on the reconstructed solver instead of the binary. The API mirrors the legacy pybind11 module
(names, enum values and defaults dumped from it): Span, Model, State, Contact, Control, Config, Solver, the enums,
login/is_logged_in/set_log_callback.

Spans are (device pointer, element count) pairs created by the wrapper from Warp arrays; the solver reads and writes
them through Warp pointer views in the same CUDA context. The step runs synchronously on the host (CPU numpy), so it
cannot be captured in a CUDA graph. Physics that is not reconstructed yet raises NotImplementedError instead of
silently differing from the binary.
"""
import enum
import sys
import types

import numpy as np

F = np.float32


class Span:
    """Non-owning (ptr, size) view of device memory; size counts elements, not bytes."""
    def __init__(self, ptr=0, size=0):
        if not ptr and size:
            raise ValueError('Span with a null address must have zero elements')
        self.ptr, self.size = int(ptr), int(size)

    def __repr__(self):
        return f'Span(ptr={self.ptr}, size={self.size})'


class NonlinearSolver(enum.IntEnum):
    NEWTON = 0
    PD_NEWTON = 1


class JointConstraintMode(enum.IntEnum):
    PENALTY = 0
    AUGMENTED_LAGRANGIAN = 1


class InertiaMode(enum.IntEnum):
    EXPLICIT_EULER = 0
    IMPLICIT_EULER = 1
    LIE_GROUP_MIDPOINT = 2
    MIDPOINT_CAYLEY = 3
    NONE = 4
    VBD_SEMI_IMPLICIT = 5


class AffineBodyRigidityModel(enum.IntEnum):
    CO_ROTATED = 0
    ABD_ORTHOGONALITY = 1
    SIX_SPRINGS = 2
    SO3_AUGMENTED_LAGRANGIAN = 3


class LogLevel(enum.IntEnum):
    INFO = 0
    ERROR = 1
    DEBUG = 2
    WARNING = 4


_CONFIG_DEFAULTS = {  # legacy _core.Config() defaults, values as stored (float32 rounded)
    'affine_body_block_preconditioner': False, 'affine_body_contact_block_preconditioner': True,
    'affine_body_rigidity_model': AffineBodyRigidityModel.SO3_AUGMENTED_LAGRANGIAN,
    'affine_body_rigidity_primal_iterations': 1, 'air_density': 1.225000023841858, 'cable_angular_beta': 0.0,
    'cable_angular_k_start': 10.0, 'cable_linear_beta': 0.0, 'cable_linear_k_start': 100.0,
    'cable_penalty_gamma': 0.9990000128746033, 'constraint_alpha': 100.0, 'enable_collision_hessian_non_diagonal': True,
    'enable_self_collision': False, 'fluid_max_step_ratio': 0.25, 'fluid_relaxation': 0.5,
    'inertia_mode': InertiaMode.MIDPOINT_CAYLEY, 'joint_constraint_mode': JointConstraintMode.AUGMENTED_LAGRANGIAN,
    'joint_constraint_primal_iterations': 1, 'linear_iterations': 50, 'nonlinear_iterations': 5,
    'nonlinear_solver': NonlinearSolver.NEWTON, 'rigid_contact_alpha': 0.949999988079071, 'rigid_contact_beta': 0.0,
    'rigid_contact_friction_epsilon': 0.0, 'rigid_contact_gamma': 0.9990000128746033, 'rigid_contact_hard': False,
    'rigid_contact_history': False, 'rigid_contact_k_start': 100.0, 'rigid_contact_sliding_tangent': False,
    'rolling_friction_velocity_epsilon': 0.10000000149011612,
    'self_collision_edge_edge_stiffness': 0.10000000149011612, 'self_collision_edge_face_stiffness': 1.0,
    'self_collision_particle_particle_stiffness': 1.0, 'self_collision_radius': 0.003000000026077032,
    'self_collision_vertex_face_stiffness': 0.5, 'wind_velocity': (0.0, 0.0, 0.0),
}

_MODEL_SCALARS = {  # legacy _core.Model() scalar defaults; every other attribute defaults to an empty Span
    'body_count': 0, 'body_distance_constraint_count': 0, 'body_point_line_count': 0, 'body_spring_count': 0,
    'body_state_count': 0, 'cable_count': 0, 'collision_edge_count': 0, 'collision_particle_count': 0,
    'collision_triangle_count': 0, 'edge_count': 0, 'fluid_boundary_count': 0, 'fluid_bulk_modulus': 200000.0,
    'fluid_particle_count': 0, 'fluid_rest_density': 1000.0, 'fluid_smoothing_radius': 0.10000000149011612,
    'fluid_viscosity': 0.0, 'granular_adhesion': 0.0, 'granular_bond_count': 0, 'granular_bond_damping': 0.0,
    'granular_bond_formation_gap': 0.0, 'granular_bond_formation_speed': 1.0,
    'granular_break_strain': 0.10000000149011612, 'granular_cohesion': 200.0, 'granular_contact_stiffness': 2000.0,
    'granular_friction': 0.5, 'granular_friction_damping': 20.0, 'granular_max_compaction': 0.4000000059604645,
    'granular_max_dynamic_bonds': 12, 'granular_particle_count': 0, 'granular_yield_strain': 0.029999999329447746,
    'hinge_count': 0, 'joint_body_point_line_count': 0, 'joint_body_spring_count': 0,
    'joint_constraint_mass_scale': 1.0, 'joint_dof_count': 0, 'joint_drive_count': 0, 'joint_target_count': 0,
    'particle_count': 0, 'particle_mass_non_diagonal_count': 0, 'particle_state_count': 0, 'shape_count': 0,
    'shape_replicated_count': 0, 'soft_contact_damping': 0.0, 'soft_contact_friction': 0.0,
    'soft_contact_friction_gain': 1000.0, 'soft_contact_stiffness': 1000.0, 'spring_count': 0,
    'tetrahedron_count': 0, 'triangle_count': 0, 'world_count': 0,
}


class _SpanDefaults:
    """Unset array attributes read as empty spans (the pybind11 classes default-construct every Span field)."""
    _scalars = {}

    def __init__(self):
        for name, value in self._scalars.items():
            setattr(self, name, value)

    def __getattr__(self, name):
        if name.startswith('__'):
            raise AttributeError(name)
        return Span()


class Model(_SpanDefaults):
    _scalars = _MODEL_SCALARS


class State(_SpanDefaults):
    pass


class Control(_SpanDefaults):
    pass


class Contact(_SpanDefaults):
    _scalars = {'history_refresh': True, 'max_count': 0, 'soft_max_count': 0}


class Config:
    def __init__(self):
        for name, value in _CONFIG_DEFAULTS.items():
            setattr(self, name, value)


_logged_in = False


def login(*args, **kwargs):
    """The reconstruction needs no account; accepted for API compatibility."""
    global _logged_in
    _logged_in = True
    return True


def is_logged_in():
    return _logged_in


def set_log_callback(callback=None, *args, **kwargs):
    return None


# ---------------------------------------------------------------------------------------------------------------
# Span access

def _read(span, dtype, width=1, count=None):
    """Copy `count` (default span.size) elements of `width` scalars from device memory."""
    import warp as wp
    n = span.size if count is None else count
    if not span.ptr or n == 0:
        return np.zeros((0, width) if width > 1 else 0, dtype)
    wt = {np.float32: wp.float32, np.int32: wp.int32}[dtype]
    view = wp.array(ptr=span.ptr, dtype=wt, shape=(n*width,), device='cuda:0', copy=False)
    data = view.numpy().copy()
    return data.reshape(n, width) if width > 1 else data


def _write(span, values):
    import warp as wp
    values = np.ascontiguousarray(values, F).reshape(-1)
    view = wp.array(ptr=span.ptr, dtype=wp.float32, shape=(values.size,), device='cuda:0', copy=False)
    view.assign(values)


class _Host:
    """numpy-backed stand-in for a Warp array (the reconstructed solver only calls numpy() / len / assign)."""
    def __init__(self, data, span=None):
        self.data, self.span = data, span

    def numpy(self):
        return self.data

    def __len__(self):
        return len(self.data)

    @property
    def shape(self):
        return self.data.shape

    def assign(self, values):
        self.data = np.asarray(values, F).reshape(self.data.shape)
        if self.span is not None:
            _write(self.span, self.data)


class _Namespace:
    pass


def _ensure_supported(model):
    unsupported = ('cable_count', 'hinge_count')
    for name in unsupported:
        if getattr(model, name, 0):
            raise NotImplementedError(f'Reconstruction does not yet support Model.{name} > 0')
    if getattr(model, 'world_count', 1) > 1:
        raise NotImplementedError('Independent per-world PCG is not yet reconstructed')
    if model.particle_state_count != model.particle_count:
        raise NotImplementedError('Particle states beyond particle_count (affine bodies) are not reconstructed')


def _newton_view(model):
    """The synreal::Model spans exposed under the Newton attribute names the reconstruction uses."""
    m = _Namespace()
    n = model.particle_count
    m.body_count = m.joint_count = 0
    m.world_count = max(int(model.world_count), 1)
    m.particle_count = n
    m.particle_q = _Host(_read(model.particle_rest_positions, F, 3, model.particle_state_count))
    m.particle_mass = _Host(_read(model.particle_masses, F, 1, n))
    m.particle_flags = _Host(_read(model.particle_flags, np.int32, 1, n))
    m.particle_world = _Host(_read(model.particle_world, np.int32, 1, n))
    m.particle_radius = _Host(_read(model.particle_radii, F, 1, n))
    m.gravity = _Host(_read(model.gravity, F, 3, m.world_count))
    m.spring_indices = _Host(_read(model.spring_indices, np.int32, 2, model.spring_count))
    m.spring_stiffness = _Host(_read(model.spring_stiffnesses, F, 1, model.spring_count))
    m.spring_rest_length = _Host(_read(model.spring_rest_lengths, F, 1, model.spring_count))
    t = model.triangle_count
    m.tri_count = t
    m.tri_indices = _Host(_read(model.triangle_indices, np.int32, 3, t))
    m.tri_poses = _Host(_read(model.triangle_inv_dms, F, 4, t).reshape(-1, 2, 2))
    m.tri_areas = _Host(_read(model.triangle_rest_areas, F, 1, t))
    materials = np.zeros((t, 5), F)
    if model.triangle_drag_coefficients.size:
        materials[:, 3] = _read(model.triangle_drag_coefficients, F, 1, t)
    m.tri_materials = _Host(materials)
    e = model.edge_count
    m.edge_indices = _Host(_read(model.edge_indices, np.int32, 4, e))
    m.edge_bending_properties = _Host(_read(model.edge_bending_properties, F, 2, e))
    m.style3d = None
    if model.triangle_aniso_stiffnesses.size or model.edge_rest_areas.size:
        m.style3d = _Namespace()
        m.style3d.tri_aniso_ke = _Host(_read(model.triangle_aniso_stiffnesses, F, 3, t))
        m.style3d.edge_rest_area = _Host(_read(model.edge_rest_areas, F, 1, e))
        m.style3d.edge_bending_cot = _Host(_read(model.edge_bending_cots, F, 4, e))
    k = model.tetrahedron_count
    m.tet_indices = _Host(_read(model.tetrahedron_indices, np.int32, 4, k))
    m.tet_poses = _Host(_read(model.tetrahedron_inverse_dms, F, 9, k).reshape(-1, 3, 3))
    m.tet_materials = _Host(_read(model.tetrahedron_materials, F, 3, k))
    m.tet_activations = _Host(np.zeros(k, F))
    s = model.shape_count
    m.shape_count = s
    m.shape_body = _Host(_read(model.shape_bodies, np.int32, 1, s))
    m.shape_type = _Host(_read(model.shape_types, np.int32, 1, s))
    m.shape_transform = _Host(_read(model.shape_transforms, F, 7, s))
    m.shape_scale = _Host(_read(model.shape_scales, F, 3, s))
    m.shape_margin = _Host(_read(model.shape_margins, F, 1, s))
    m.shape_material_ke = _Host(_read(model.shape_contact_stiffnesses, F, 1, s))
    m.shape_material_kd = _Host(_read(model.shape_contact_dampings, F, 1, s))
    m.shape_material_kf = _Host(_read(model.shape_contact_friction_gains, F, 1, s))
    m.shape_material_mu = _Host(_read(model.shape_frictions, F, 1, s))
    m.shape_rolling = _read(model.shape_rolling_frictions, F, 1, s) if model.shape_rolling_frictions.size else np.zeros(s, F)
    m.shape_torsional = (_read(model.shape_torsional_frictions, F, 1, s) if model.shape_torsional_frictions.size
                         else np.zeros(s, F))
    m.soft_contact_ke, m.soft_contact_kd = F(model.soft_contact_stiffness), F(model.soft_contact_damping)
    m.soft_contact_kf, m.soft_contact_mu = F(model.soft_contact_friction_gain), F(model.soft_contact_friction)
    if model.body_count:
        from .affine import AffineBodies
        pairs = _read(model.particle_mass_non_diagonal_indices, np.int32, 2, model.particle_mass_non_diagonal_count)
        values = _read(model.particle_mass_non_diagonal_values, F, 1, model.particle_mass_non_diagonal_count)
        m.affine_bodies = AffineBodies(_read(model.affine_body_indices, np.int32, 4, model.body_count),
                                       _read(model.body_masses, F, 1, model.body_count), n, pairs, values)
        m.affine_bodies.ids = _read(model.affine_body_ids, np.int32, 1, model.body_count)
        m.affine_bodies.com = _read(model.body_centers_of_mass, F, 3, model.body_count)
        m.joint_drives = None
        k = model.joint_drive_count
        if k:
            from .joints import Drives
            dofs = model.joint_dof_count
            opt = lambda span, dt: _read(span, dt, 1, span.size) if span.size else None
            m.joint_drives = Drives(_read(model.joint_drive_body_indices, np.int32, 2, k),
                                    _read(model.joint_drive_types, np.int32, 1, k),
                                    _read(model.joint_drive_parent_origins, F, 3, k),
                                    _read(model.joint_drive_parent_axis_points, F, 3, k),
                                    _read(model.joint_drive_parent_reference_points, F, 3, k),
                                    _read(model.joint_drive_child_origins, F, 3, k),
                                    _read(model.joint_drive_child_reference_points, F, 3, k),
                                    _read(model.joint_drive_dof_indices, np.int32, 1, k),
                                    _read(model.joint_drive_target_indices, np.int32, 1, k),
                                    m.affine_bodies.indices, m.affine_bodies.com)
            m.joint_drives.ke = _read(model.joint_target_stiffnesses, F, 1, dofs)
            m.joint_drives.kd = _read(model.joint_target_dampings, F, 1, dofs)
            m.joint_drives.effort = _read(model.joint_effort_limits, F, 1, dofs)
            m.joint_drives.modes = opt(model.joint_target_modes, np.int32)
            m.joint_drives.damping = opt(model.joint_passive_dampings, F)
            armature = opt(model.joint_armature, F)
            m.joint_drives.armature = armature if armature is not None and np.any(armature > 0) else None
            # AngularLimitView: per-dof stops and their gains (evaluate_angular_limits).
            m.joint_drives.limits = None
            if model.joint_limit_stiffnesses.size or model.joint_limit_dampings.size:
                m.joint_drives.limits = (_read(model.joint_limit_lower, F, 1, dofs),
                                         _read(model.joint_limit_upper, F, 1, dofs),
                                         _read(model.joint_limit_stiffnesses, F, 1, dofs),
                                         _read(model.joint_limit_dampings, F, 1, dofs))
        m.distance_constraints = None
        c = model.body_distance_constraint_count
        if c:
            from .joints import DistanceConstraints
            m.distance_constraints = DistanceConstraints(
                _read(model.body_distance_constraint_indices, np.int32, 2, c),
                _read(model.body_distance_constraint_points0, F, 3, c),
                _read(model.body_distance_constraint_points1, F, 3, c),
                _read(model.body_distance_constraint_weights0, F, 4, c),
                _read(model.body_distance_constraint_weights1, F, 4, c),
                _read(model.body_distance_constraint_rest_lengths, F, 1, c),
                _read(model.body_distance_constraint_mass_scales, F, 1, c), m.affine_bodies.indices)
        m.point_lines = None
        c = model.body_point_line_count
        if c:
            from .joints import PointLines
            m.point_lines = PointLines(_read(model.body_point_line_indices, np.int32, 2, c),
                                       _read(model.body_point_line_points, F, 3, c),
                                       _read(model.body_point_line_endpoints0, F, 3, c),
                                       _read(model.body_point_line_endpoints1, F, 3, c),
                                       _read(model.body_point_line_stiffnesses, F, 1, c),
                                       model.joint_body_point_line_count, m.affine_bodies.indices,
                                       m.affine_bodies.com)
        s = model.body_spring_count
        m.joint_springs = None
        if s:
            from .joints import Springs
            m.joint_springs = Springs(_read(model.body_spring_indices, np.int32, 2, s),
                                      _read(model.body_spring_points0, F, 3, s),
                                      _read(model.body_spring_points1, F, 3, s),
                                      _read(model.body_spring_stiffnesses, F, 1, s),
                                      _read(model.body_spring_rest_lengths, F, 1, s), model.joint_body_spring_count,
                                      m.affine_bodies.indices, m.affine_bodies.com)
        # Body-frame inertia tensors (RollingContactView +200), used by the rolling/torsional friction kernels.
        m.affine_bodies.inertia = (_read(model.body_inertia_tensors, F, 9, model.body_count)
                                   if model.body_inertia_tensors.size else None)
    elif model.particle_mass_non_diagonal_count:
        raise NotImplementedError('Off-diagonal particle masses outside affine bodies')
    if model.fluid_particle_count:
        m.synreal_fluid_particle_indices = _Host(_read(model.fluid_particle_indices, np.int32, 1,
                                                       model.fluid_particle_count))
        m.synreal_fluid_boundary_positions = _Host(_read(model.fluid_boundary_positions, F, 3,
                                                         model.fluid_boundary_count))
        m.synreal_fluid_boundary_volumes = _Host(_read(model.fluid_boundary_volumes, F, 1,
                                                       model.fluid_boundary_count))
        for name in ('smoothing_radius', 'rest_density', 'bulk_modulus', 'viscosity'):
            setattr(m, 'synreal_fluid_'+name, getattr(model, 'fluid_'+name))
    if model.granular_particle_count:
        m.synreal_granular_particle_indices = _Host(_read(model.granular_particle_indices, np.int32, 1,
                                                          model.granular_particle_count))
        m.synreal_granular_bond_indices = _Host(_read(model.granular_bond_indices, np.int32, 2,
                                                      model.granular_bond_count))
        m.synreal_granular_bond_rest_lengths = _Host(_read(model.granular_bond_rest_lengths, F, 1,
                                                           model.granular_bond_count))
        for name in ('contact_stiffness', 'friction', 'friction_damping', 'cohesion', 'bond_damping',
                     'yield_strain', 'max_compaction', 'break_strain', 'adhesion', 'bond_formation_gap',
                     'bond_formation_speed', 'max_dynamic_bonds'):
            setattr(m, 'synreal_granular_'+name, getattr(model, 'granular_'+name))
    return m


def _contacts_view(contact):
    if contact is None:
        return None
    c = _Namespace()
    count = int(_read(contact.soft_count, np.int32, 1, 1)[0]) if contact.soft_count.size else 0
    c.soft_contact_count = _Host(np.array([count], np.int32))
    c.soft_contact_particle = _Host(_read(contact.soft_particle, np.int32, 1, count))
    c.soft_contact_shape = _Host(_read(contact.soft_shape, np.int32, 1, count))
    c.soft_contact_body_pos = _Host(_read(contact.soft_body_pos, F, 3, count))
    c.soft_contact_body_vel = _Host(_read(contact.soft_body_vel, F, 3, count))
    c.soft_contact_normal = _Host(_read(contact.soft_normal, F, 3, count))
    rigid = int(_read(contact.count, np.int32, 1, 1)[0]) if contact.count.size else 0
    c.rigid_contact_count = _Host(np.array([rigid], np.int32))
    c.rigid = None
    if rigid:
        optional = lambda span, width: _read(span, F, width, rigid) if span.size else None
        c.rigid = {'count': rigid, 'shape0': _read(contact.shape0, np.int32, 1, rigid),
                   'shape1': _read(contact.shape1, np.int32, 1, rigid), 'point0': _read(contact.point0, F, 3, rigid),
                   'point1': _read(contact.point1, F, 3, rigid), 'offset0': optional(contact.offset0, 3),
                   'offset1': optional(contact.offset1, 3), 'normal': _read(contact.normal, F, 3, rigid),
                   'margin0': _read(contact.margin0, F, 1, rigid), 'margin1': _read(contact.margin1, F, 1, rigid),
                   # HardContactView capacity (+8) and the history match of each contact (Contact.match_index).
                   'capacity': int(contact.shape0.size),
                   'match': _read(contact.match_index, np.int32, 1, rigid) if contact.match_index.size else None}
    c.surface = None
    if contact.soft_indices.size and count:
        # Full-surface soft contacts: vertex/edge/face triples with barycentric weights (SurfaceContactView); shapes
        # flagged in soft_particle_only_shapes stay with the particle kernel.
        flags = contact.soft_particle_only_shapes
        c.surface = {'indices': _read(contact.soft_indices, np.int32, 3, count),
                     'barycentric': _read(contact.soft_barycentric, F, 3, count),
                     'particle_only': _read(flags, np.int32, 1, flags.size) if flags.size else None}
    return c


class Solver:
    """Same lifecycle as the native solver: Solver(); config edits; initialize(model); step(...)."""
    def __init__(self):
        self.config = Config()
        self._model = None
        self._impl = None

    def initialize(self, model):
        _ensure_supported(model)
        self._model = model
        self._impl = None

    def reserve_rigid_contact_capacity(self, capacity):
        return None

    def reset_joint_drive_state(self, stream=None, mask=None):
        # Clears the persistent joint-angle branch (drive_initialized); with a mask only the selected drives
        # (reset_selected_joint_drive_state), otherwise all of them.
        impl = self._impl
        if impl is None or getattr(impl, 'drive_initialized', None) is None:
            return None
        if mask is None or not getattr(mask, 'size', 0):
            impl.drive_initialized[:] = 0
        else:
            from .joints import reset_selected_joint_drive_state
            reset_selected_joint_drive_state(_read(mask, np.int32, 1, len(impl.drive_initialized)),
                                             impl.drive_initialized)
        return None

    def reset_cable_penalty_state(self, stream=None, mask=None):
        return None

    def copy_cable_penalties(self, output, stream=None):
        raise NotImplementedError('Cables are not reconstructed')

    def _solver(self):
        if self._impl is None:
            from .solver import ReconstructedSolver
            self._impl = ReconstructedSolver(_newton_view(self._model))
        cfg, impl = self.config, self._impl.config
        impl.nonlinear_iterations = int(cfg.nonlinear_iterations)
        impl.linear_iterations = int(cfg.linear_iterations)
        impl.enable_self_collision = bool(cfg.enable_self_collision)
        impl.self_collision_radius = float(cfg.self_collision_radius)
        impl.fluid_relaxation, impl.fluid_max_step_ratio = float(cfg.fluid_relaxation), float(cfg.fluid_max_step_ratio)
        impl.air_density, impl.wind_velocity = float(cfg.air_density), tuple(cfg.wind_velocity)
        impl.constraint_alpha = float(cfg.constraint_alpha)
        impl.rigid_contact_friction_epsilon = float(cfg.rigid_contact_friction_epsilon)
        impl.rolling_friction_velocity_epsilon = float(cfg.rolling_friction_velocity_epsilon)
        joints = self._model.joint_body_spring_count or self._model.joint_body_point_line_count
        impl.joint_constraint_primal_iterations = int(cfg.joint_constraint_primal_iterations)
        if impl.joint_constraint_primal_iterations < 1:
            raise ValueError('joint_constraint_primal_iterations must be >= 1')
        if joints and cfg.joint_constraint_mode != JointConstraintMode.AUGMENTED_LAGRANGIAN:
            raise NotImplementedError('Penalty-mode joint constraints are not reconstructed')
        impl.rigid_contact_hard = bool(cfg.rigid_contact_hard)
        impl.rigid_contact_history = bool(cfg.rigid_contact_history)
        for name in ('rigid_contact_alpha', 'rigid_contact_beta', 'rigid_contact_gamma', 'rigid_contact_k_start'):
            setattr(impl, name, float(getattr(cfg, name)))
        if not cfg.enable_collision_hessian_non_diagonal:
            raise NotImplementedError('enable_collision_hessian_non_diagonal=False is not reconstructed')
        impl.affine_body_rigidity_primal_iterations = int(cfg.affine_body_rigidity_primal_iterations)
        inertia_ok = cfg.inertia_mode in (InertiaMode.MIDPOINT_CAYLEY, InertiaMode.NONE)
        if self._model.body_count and (not inertia_ok or cfg.affine_body_block_preconditioner):
            raise NotImplementedError('Only MIDPOINT_CAYLEY/NONE inertia and the block-diagonal preconditioner are '
                                      'reconstructed for affine bodies')
        impl.affine_body_rigidity_model = int(cfg.affine_body_rigidity_model)
        impl.nonlinear_solver, impl.inertia_mode = int(cfg.nonlinear_solver), int(cfg.inertia_mode)
        return self._impl

    def step(self, state_in, state_out, *args, stream=None):
        """step(state_in, state_out, [control], [contact], dt, stream=None) like the native overloads."""
        import warp as wp
        control = contact = dt = None
        for value in args:
            if isinstance(value, Control):
                control = value
            elif isinstance(value, Contact):
                contact = value
            elif dt is None:
                dt = float(value)
            else:
                stream = value  # work is synchronous here; the stream only orders the caller's own launches
        if dt is None:
            raise TypeError('step() requires dt')
        wp.synchronize_device('cuda:0')
        impl = self._solver()
        n = self._model.particle_state_count
        sin, sout = _Namespace(), _Namespace()
        sin.particle_q = _Host(_read(state_in.particle_q, F, 3, n), state_in.particle_q)
        sin.particle_qd = _Host(_read(state_in.particle_qd, F, 3, n), state_in.particle_qd)
        sin.particle_f = _Host(_read(state_in.particle_f, F, 3, n) if state_in.particle_f.size else np.zeros((n, 3), F))
        sout.particle_q = _Host(np.zeros((n, 3), F), state_out.particle_q)
        sout.particle_qd = _Host(np.zeros((n, 3), F), state_out.particle_qd)
        drives = self._model.joint_drive_count
        if not drives and control is not None and control.joint_f.size and np.any(_read(control.joint_f, F, 1)):
            raise NotImplementedError('Generalized joint forces (Control.joint_f) without joint drives')
        ctrl = None
        if drives:
            # Drive inputs: pre-prediction drive velocities (copied by the host after initialize_step), feed-forward
            # forces and targets per dof / target.
            ctrl = _Namespace()
            dofs, targets = self._model.joint_dof_count, self._model.joint_target_count
            zeros = lambda count: np.zeros(count, F)
            read = lambda span, count: _read(span, F, 1, count) if (control is not None and span.size) else zeros(count)
            if control is None or not control.joint_drive_velocities.size:
                raise NotImplementedError('Joint drives without Control.joint_drive_velocities')
            ctrl.drive_qd = read(control.joint_drive_velocities, drives)
            ctrl.joint_f = read(control.joint_f, dofs)
            ctrl.target_q = read(control.joint_target_q, targets)
            ctrl.target_qd = read(control.joint_target_qd, dofs)
            # The model spans alias live device arrays that the legacy kernels read at every launch; scenes may
            # retune drive gains between steps (e.g. the piper gripper ramps joint_target_ke/kd per substep).
            jd = impl.joint_drives
            m = self._model
            jd.ke = _read(m.joint_target_stiffnesses, F, 1, dofs)
            jd.kd = _read(m.joint_target_dampings, F, 1, dofs)
            jd.effort = _read(m.joint_effort_limits, F, 1, dofs)
            if m.joint_target_modes.size:
                jd.modes = _read(m.joint_target_modes, np.int32, 1, m.joint_target_modes.size)
        if control is not None and control.tetrahedron_activations.size:
            ctrl = ctrl or _Namespace()
            ctrl.tet_activations = _Host(_read(control.tetrahedron_activations, F, 1, self._model.tetrahedron_count))
        impl.step(sin, sout, ctrl, _contacts_view(contact), dt)
        wp.synchronize_device('cuda:0')


def module():
    """A module object with the legacy `_core` names."""
    mod = types.ModuleType('style3d_sim._core')
    mod.__doc__ = __doc__
    for name in ('Span', 'Model', 'State', 'Control', 'Contact', 'Config', 'Solver', 'NonlinearSolver',
                 'JointConstraintMode', 'InertiaMode', 'AffineBodyRigidityModel', 'LogLevel', 'login',
                 'is_logged_in', 'set_log_callback'):
        setattr(mod, name, globals()[name])
    mod.__file__ = __file__
    mod.RECONSTRUCTED = True
    return mod


def install():
    """Register the reconstruction as style3d_sim._core (call before importing style3d_sim)."""
    sys.modules['style3d_sim._core'] = module()
