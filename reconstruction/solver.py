"""Incremental Newton adapter implemented entirely in inspectable Python source."""
from dataclasses import dataclass
import numpy as np
from .contact import SoftContactInputs, soft_contact_kernel
from .native_step import newton_step
from .precompute import cloth_constant_matrix, spring_constant_matrix, tetrahedron_volumes
from .selfcollision import SelfCollision
from . import fluid as fluid_kernel
from .granular import GranularState
from .numerics import F, I3, assemble, fma as _fma, bending_terms, membrane_terms, pcg, spring_terms, tetrahedron_terms


@dataclass(slots=True)
class Config:
    nonlinear_solver: int = 0          # NonlinearSolver: NEWTON = 0, PD_NEWTON = 1
    inertia_mode: int = 3              # InertiaMode: MIDPOINT_CAYLEY = 3, NONE = 4 (affine bodies)
    nonlinear_iterations: int = 5
    linear_iterations: int = 50
    enable_self_collision: bool = False
    self_collision_radius: float = 0.003
    # Legacy SolverConfig defaults (CONFIG_DEFAULTS.md).
    constraint_alpha: float = 100.0
    affine_body_rigidity_primal_iterations: int = 1
    joint_constraint_primal_iterations: int = 1
    affine_body_rigidity_model: int = 3     # CO_ROTATED 0, ABD_ORTHOGONALITY 1, SIX_SPRINGS 2, SO3_AL 3
    rigid_contact_friction_epsilon: float = 0.0
    # Augmented-Lagrangian hard rigid contacts (Config.rigid_contact_*).
    rigid_contact_hard: bool = False
    rigid_contact_history: bool = False
    rigid_contact_alpha: float = 0.949999988079071
    rigid_contact_beta: float = 0.0
    rigid_contact_gamma: float = 0.9990000128746033
    rigid_contact_k_start: float = 100.0
    rolling_friction_velocity_epsilon: float = 0.10000000149011612
    air_density: float = 1.225
    wind_velocity: tuple = (0.0, 0.0, 0.0)
    fluid_relaxation: float = 0.5
    fluid_max_step_ratio: float = 0.25


def array(value):
    return np.empty(0, dtype=F) if value is None else value.numpy().copy()


class ReconstructedSolver:
    """Particle/spring/Style3D membrane, bending, tetrahedron and static-shape soft-contact path.

    This initial implementation uses CPU sparse assembly/PCG and copies Newton
    state arrays across the device boundary. It cannot be CUDA-graph captured.
    Unsupported physics raises instead of silently falling back to a binary.
    """
    def __init__(self, model):
        self.model = model
        self.config = Config()
        if getattr(model, 'joint_count', 0):
            raise NotImplementedError('Reconstruction does not yet support joint_count')
        # Affine bodies arrive through the _core shim (reconstruction/core.py) as extra state particles.
        self.bodies = getattr(model, 'affine_bodies', None)
        self.joint_springs = getattr(model, 'joint_springs', None)
        self.point_lines = getattr(model, 'point_lines', None)
        self.distance_constraints = getattr(model, 'distance_constraints', None)
        self.joint_drives = getattr(model, 'joint_drives', None)
        if self.joint_drives is not None:
            # Unwrapped start-of-step angles and their initialized flags persist across steps.
            self.drive_angle = np.zeros(len(self.joint_drives.pairs), F)
            self.drive_initialized = np.zeros(len(self.joint_drives.pairs), np.int32)
        if getattr(model, 'body_count', 0) and self.bodies is None:
            raise NotImplementedError('Newton bodies need the style3d_sim wrapper (reconstruction.core) for affine bodies')
        for name in ('synreal_cable_indices',):
            value = getattr(model, name, None)
            if value is not None and len(value):
                raise NotImplementedError(f'Reconstruction does not yet support {name}')
        # Triangle air drag: the host keeps the faces with a positive coefficient, in model order.
        self.drag_triangles = np.empty((0, 3), np.int32)
        if model.tri_count:
            coefficients = array(model.tri_materials)[:, 3]
            keep = coefficients > 0
            self.drag_triangles = array(model.tri_indices).astype(np.int32).reshape(-1, 3)[keep]
            self.drag_coefficients = coefficients[keep].astype(F)
        if getattr(model, 'world_count', 1) > 1:
            raise NotImplementedError('Independent per-world PCG is not yet reconstructed')
        self.mass = array(model.particle_mass)
        self.flags = array(model.particle_flags).astype(np.int32)
        self.active = (self.mass > 0) & ((array(model.particle_flags) & 1) != 0)
        self.dofs = np.flatnonzero(np.repeat(self.active, 3))
        self.springs = array(model.spring_indices).astype(np.int32).reshape(-1, 2)
        self.spring_k = array(model.spring_stiffness)
        self.spring_rest = array(model.spring_rest_length)
        self.tets = array(model.tet_indices).astype(np.int32).reshape(-1, 4)
        if len(self.tets):
            self.tet_inverse = array(model.tet_poses)
            # Legacy host formula (precompute_matrices): 1 / (first-row det * 6) in single precision.
            self.tet_volume = tetrahedron_volumes(self.tet_inverse)
            self.tet_materials = array(model.tet_materials)
        self.triangles = array(model.tri_indices).astype(np.int32).reshape(-1, 3)
        if getattr(model, 'style3d', None) is None and len(self.tets):
            if np.any(array(model.tri_materials)[:, :3] != 0):
                raise NotImplementedError('Generic surface elasticity is not reconstructed')
            self.triangles = np.empty((0, 3), dtype=np.int32)
        self.edges = np.empty((0, 4), dtype=np.int32)
        if len(self.triangles):
            style = getattr(model, 'style3d', None)
            if style is None:
                raise NotImplementedError('Only Style3D membrane attributes are reconstructed')
            self.tri_inverse = array(model.tri_poses)
            self.tri_area = array(model.tri_areas)
            self.tri_stiffness = array(style.tri_aniso_ke)
            edges = array(model.edge_indices).reshape(-1, 4)
            areas = array(style.edge_rest_area)
            valid = (edges >= 0).all(axis=1) & (areas > 0)
            self.edges = edges[valid]
            self.edge_area = areas[valid]
            self.edge_cots = array(style.edge_bending_cot)[valid]
            self.edge_properties = array(model.edge_bending_properties).reshape(-1, 2)[valid]
        # Tetrahedra and Style3D cloth (plus soft contact) follow the legacy kernel sequence exactly.
        self.native_edges = np.empty((0, 4), np.int32)
        self.cloth_constant = None
        # Springs use kernels that are not reconstructed yet, so those models keep the sparse path.
        self.fluid = self._fluid_model(model)
        indices = getattr(model, 'synreal_granular_particle_indices', None)
        self.granular = GranularState(model, self.mass) if indices is not None and len(indices) else None
        # Springs follow the legacy kernels when there are no triangles; how the host merges spring and membrane
        # entries of the same ELL slot is not verified yet, so such models keep the sparse path.
        self.native_structure = ((bool(len(self.tets)) or bool(len(self.triangles)) or self.fluid is not None
                                  or self.granular is not None or bool(len(self.springs))
                                  or self.bodies is not None)
                                 and not (len(self.springs) and len(self.triangles)))
        if self.native_structure and len(self.springs):
            self.cloth_constant = spring_constant_matrix(len(self.mass), self.springs, self.spring_k)
        if self.native_structure and len(self.triangles):
            style = model.style3d
            self.native_edges = array(model.edge_indices).astype(np.int32).reshape(-1, 4)
            self.native_edge_area = array(style.edge_rest_area)
            self.native_edge_cots = array(style.edge_bending_cot).reshape(-1, 4)
            self.native_edge_properties = array(model.edge_bending_properties).reshape(-1, 2)
            self.triangles = self.triangles.astype(np.int32)
            self.cloth_constant = cloth_constant_matrix(
                len(self.mass), self.triangles, self.tri_inverse, self.tri_area, self.tri_stiffness,
                self.native_edges, self.native_edge_cots, self.native_edge_area, self.native_edge_properties)

    def _free_particles(self):
        """NewtonSolver._build_collision_particle_indices: active, non-proxy particles with finite positive mass and
        radius that belong to no spring, triangle, edge or tetrahedron."""
        n = len(self.mass)
        constrained = np.zeros(n, bool)
        for topology in (self.springs, array(self.model.tri_indices), array(self.model.edge_indices), self.tets):
            idx = np.asarray(topology, np.int64).reshape(-1)
            constrained[idx[(idx >= 0) & (idx < n)]] = True
        flags = array(self.model.particle_flags).astype(np.int64)
        radius = array(self.model.particle_radius)
        proxy = 1 << 1  # newton.ParticleFlags.PROXY
        ok = (~constrained & ((flags & 1) != 0) & ((flags & proxy) == 0) & np.isfinite(self.mass) & (self.mass > 0)
              & np.isfinite(radius) & (radius > 0))
        return np.flatnonzero(ok).astype(np.int32)

    def _fluid_model(self, model):
        indices = getattr(model, 'synreal_fluid_particle_indices', None)
        if indices is None or not len(indices):
            return None
        boundary = array(getattr(model, 'synreal_fluid_boundary_positions', None)).reshape(-1, 3)
        return {'indices': array(indices).astype(np.int32), 'boundary_positions': boundary,
                'boundary_volumes': array(getattr(model, 'synreal_fluid_boundary_volumes', None)),
                'smoothing_radius': F(model.synreal_fluid_smoothing_radius),
                'rest_density': F(model.synreal_fluid_rest_density),
                'bulk_modulus': F(model.synreal_fluid_bulk_modulus), 'viscosity': F(model.synreal_fluid_viscosity),
                'world': array(model.particle_world).astype(np.int32)}

    def step(self, state_in, state_out, control, contacts, dt):
        if not np.isfinite(dt) or dt <= 0:
            raise ValueError('dt must be finite and positive')
        free = self._free_particles()
        if self.config.enable_self_collision and not ((self.native_structure and len(self.triangles))
                                                      or len(free)):
            raise NotImplementedError('Self-collision is reconstructed for Style3D cloth and free particles only')
        native = self.native_structure or (self.config.enable_self_collision and len(free) > 1
                                           and not (len(self.springs) and len(self.triangles)))
        if not 0 <= self.config.nonlinear_iterations <= 999 or not 1 <= self.config.linear_iterations <= 999:
            raise ValueError('Invalid Newton/PCG iteration count')
        rigid = getattr(contacts, 'rigid', None) if contacts is not None else None
        if contacts is not None and np.any(array(getattr(contacts, 'rigid_contact_count', None))) and rigid is None:
            raise NotImplementedError('Rigid contact response needs the style3d_sim wrapper (reconstruction.core)')
        rolling = rigid is not None and (np.any(getattr(self.model, 'shape_rolling', 0) != 0)
                                         or np.any(getattr(self.model, 'shape_torsional', 0) != 0))
        if rolling and getattr(self.bodies, 'inertia', None) is None:
            raise NotImplementedError('Rolling/torsional contact friction needs the body inertia tensors')
        h = F(dt)
        previous = array(state_in.particle_q)
        velocity = array(state_in.particle_qd)
        force = array(state_in.particle_f)
        gravity = array(self.model.gravity).reshape(-1, 3)
        worlds = array(self.model.particle_world)
        gravity = gravity[np.clip(worlds, 0, len(gravity)-1)]
        if self.bodies is not None:
            gravity = gravity.copy()
            gravity[self.bodies.kind == 2] = 0  # initialize_step: affine columns (kind 2) get no gravity
        # initialize_step: x_hat = fma(h*h, g, fma(v, h, x)).
        predicted = _fma(h*h, gravity, _fma(velocity, h, previous))
        predicted[~self.active] = previous[~self.active]
        start = previous
        if native:
            # The legacy kernel also backdates the previous position of inactive affine-body particles (kinematic
            # bodies) to x - h v, so that update_velocity returns their velocity instead of zero.
            from .step_kernels import initialize_step
            predicted, previous, _ = initialize_step(
                h, array(self.model.gravity).reshape(-1, 3), worlds, velocity, previous, self.mass, [],
                np.zeros(len(self.mass), F), array(self.model.particle_flags).astype(np.int32),
                None if self.bodies is None else self.bodies.kind)
        x = predicted.copy()
        if native:
            # Tetrahedra + soft contact: replay the legacy kernel sequence (see native_step.py).
            activation = array(getattr(control, 'tet_activations', None))
            self.tet_activation = activation if len(activation) else array(self.model.tet_activations)
            if not len(self.tet_activation):
                self.tet_activation = np.zeros(len(self.tets), F)
            inputs = self._contact_inputs(x, previous, contacts, h) if contacts is not None else None
            sc = None
            if self.config.enable_self_collision:
                if getattr(self, '_self_collision', None) is None:
                    # Built lazily so the configured radius applies; topology comes from the initial positions.
                    self._self_collision = SelfCollision(
                        array(self.model.particle_q), self.triangles, self.native_edges, self.mass,
                        array(self.model.particle_world).astype(np.int32), self.config.self_collision_radius,
                        free_particles=free, particle_radius=array(self.model.particle_radius))
                sc = self._self_collision
                sc.query(start)  # substep-start positions, before initialize_step writes the prediction
            self.rigid_contacts = self.rolling_contacts = None
            if rigid is not None:
                from .rigid_contact import Bodies as ContactBodies
                model = self.model
                shapes = {'body': array(model.shape_body).astype(np.int32), 'type': array(model.shape_type).astype(np.int32),
                          'position': array(model.shape_transform)[:, :3], 'scale': array(model.shape_scale),
                          'ke': array(model.shape_material_ke), 'kd': array(model.shape_material_kd),
                          'kf': array(model.shape_material_kf), 'mu': array(model.shape_material_mu)}
                if rolling:
                    shapes['rolling'] = np.asarray(model.shape_rolling, F)
                    shapes['torsional'] = np.asarray(model.shape_torsional, F)
                self.rigid_contacts = (rigid, shapes, ContactBodies(self.bodies.ids, self.bodies.indices, self.bodies.com))
                # Rolling kernels: (inertia, epsilon), launched only when some shape has rolling/torsional friction.
                self.rolling_contacts = ((np.asarray(self.bodies.inertia, F).reshape(-1, 9),
                                          F(self.config.rolling_friction_velocity_epsilon)) if rolling else None)
            self.drive_control = control if self.joint_drives is not None else None
            self.surface_contacts = self._surface_inputs(predicted, previous, contacts, h) if contacts is not None else None
            x = newton_step(self, predicted, previous, force, inputs, h, sc, self.fluid, self.granular, self.bodies)
            if self.granular is not None:
                self.granular.finish(x, previous, h)
            self._finish(state_in, state_out, x, previous, h)
            if self.joint_drives is not None:
                # update_joint_drive_angle_state runs after update_velocity on the final positions.
                from .joints import update_joint_drive_angle_state
                update_joint_drive_angle_state(self.joint_drives, x, self.drive_angle, self.drive_initialized)
            return
        # Host computes s = 1/(h*h) in float32 for the right-hand side.
        inertia_scale = F(1)/(h*h)
        # initialize_step builds the matrix inertia diagonal with a division by h*h.
        mass_diagonal = self.mass/(h*h)
        for _ in range(self.config.nonlinear_iterations):
            terms = []
            if len(self.springs):
                terms.append((self.springs, *spring_terms(x, self.springs, self.spring_k, self.spring_rest)))
            if len(self.triangles):
                terms.append((self.triangles, *membrane_terms(x, self.triangles, self.tri_inverse,
                                                            self.tri_area, self.tri_stiffness)))
            if len(self.edges):
                terms.append((self.edges, *bending_terms(x, previous, self.edges, self.edge_cots,
                                                        self.edge_area, self.edge_properties, h)))
            if len(self.tets):
                activation = array(getattr(control, 'tet_activations', None))
                if not len(activation):
                    activation = array(self.model.tet_activations)
                terms.append((self.tets, *tetrahedron_terms(x, previous, self.tets, self.tet_inverse,
                                                          self.tet_volume, self.tet_materials, activation, h)))
            if contacts is not None:
                contact_terms = self._soft_contacts(x, previous, contacts, h)
                if contact_terms is not None:
                    terms.append(contact_terms)
            internal, matrix = assemble(len(x), terms, mass_diagonal)
            # initialize_rhs: fma(m*(x_hat-x), s, f_ext); element kernels then add internal forces.
            rhs = (_fma(self.mass[:, None]*(predicted-x), inertia_scale, force) + internal).reshape(-1)
            if len(self.dofs):
                reduced = matrix[self.dofs][:, self.dofs]
                delta = pcg(reduced, rhs[self.dofs], self.config.linear_iterations)
                x.reshape(-1)[self.dofs] += delta
        self._finish(state_in, state_out, x, previous, h)

    def hard_contact_state(self, rigid):
        """Persistent HardContactView arrays (penalty 256, dual 264, anchor 272, history 280..304) sized to the
        contact capacity; reallocated (history dropped) when the capacity changes."""
        capacity = int(rigid['capacity']) if rigid is not None else 0
        state = getattr(self, '_hard_state', None)
        if state is None or len(state['penalty']) != capacity:
            state = {'penalty': np.zeros(capacity, F), 'dual': np.zeros((capacity, 3), F),
                     'anchor': np.zeros((capacity, 3), F), 'prev_penalty': np.zeros(capacity, F),
                     'prev_dual': np.zeros((capacity, 3), F), 'prev_normal': np.zeros((capacity, 3), F),
                     'prev_count': np.zeros(1, np.int32)}
            self._hard_state = state
        return state

    def _finish(self, state_in, state_out, x, previous, h):
        new_velocity = (x-previous)*(F(1)/h)
        if not np.isfinite(x).all() or not np.isfinite(new_velocity).all():
            raise FloatingPointError('Reconstruction produced a nonfinite state')
        state_out.particle_q.assign(x)
        state_out.particle_qd.assign(new_velocity)
        # The public native adapter documents mutation of both position buffers.
        state_in.particle_q.assign(x)

    def _soft_contacts(self, x, previous, contacts, dt):
        """Particle/static-shape soft contact via the kernel-exact `soft_contact_kernel`.

        The kernel's isotropic scalar and 3x3 correction are summed into one diagonal block per particle.
        """
        c = self._contact_inputs(x, previous, contacts, dt)
        if c is None:
            return None
        force, scalar, block = soft_contact_kernel(c)
        ids = np.flatnonzero((scalar != 0) | np.any(force != 0, axis=1) | np.any(block != 0, axis=(1, 2)))
        if not len(ids):
            return None
        blocks = scalar[ids, None, None]*I3+block[ids]
        return ids[:, None], force[ids][:, None, :], blocks[:, None, None, :, :]

    def _surface_inputs(self, x, previous, contacts, dt):
        """SurfaceContacts for evaluate_surface_contact_force and its tangent kernels, or None."""
        surface = getattr(contacts, 'surface', None)
        count = int(array(contacts.soft_contact_count)[0])
        if surface is None or not count:
            return None
        from .rigid_contact import Bodies as ContactBodies
        from .surface_contact import SurfaceContacts
        model = self.model
        bodies = None if self.bodies is None else ContactBodies(self.bodies.ids, self.bodies.indices, self.bodies.com)
        return SurfaceContacts(
            count, surface['indices'], surface['barycentric'], array(contacts.soft_contact_shape),
            array(contacts.soft_contact_body_pos), array(contacts.soft_contact_body_vel),
            array(contacts.soft_contact_normal), array(model.particle_radius), self.mass, self.flags,
            None if self.bodies is None else self.bodies.kind, array(model.shape_body), array(model.shape_type),
            array(model.shape_transform)[:, :3], array(model.shape_scale), array(model.shape_margin),
            array(model.shape_material_ke), array(model.shape_material_kd), array(model.shape_material_kf),
            array(model.shape_material_mu), model.soft_contact_ke, model.soft_contact_kd, model.soft_contact_kf,
            model.soft_contact_mu, bodies, x, previous, F(1)/dt, particle_only=surface['particle_only'])

    def _contact_inputs(self, x, previous, contacts, dt):
        count = int(array(contacts.soft_contact_count)[0])
        if not count:
            return None
        surface = getattr(contacts, 'surface', None)
        if surface is not None and surface['particle_only'] is None:
            # Full-surface contacts without particle-only shapes: the legacy step launches no particle soft-contact
            # kernel at all (piper trace); only shapes flagged particle-only keep the particle path.
            return None
        model = self.model
        return SoftContactInputs(
            count=count, particle=array(contacts.soft_contact_particle), shape=array(contacts.soft_contact_shape),
            body_pos=array(contacts.soft_contact_body_pos), body_vel=array(contacts.soft_contact_body_vel),
            normal=array(contacts.soft_contact_normal), radius=array(model.particle_radius), mass=self.mass,
            shape_body=array(model.shape_body), shape_type=array(model.shape_type),
            shape_position=array(model.shape_transform)[:, :3], shape_scale=array(model.shape_scale),
            shape_margin=array(model.shape_margin), shape_ke=array(model.shape_material_ke),
            shape_kd=array(model.shape_material_kd), shape_kf=array(model.shape_material_kf),
            shape_mu=array(model.shape_material_mu), ke=model.soft_contact_ke, kd=model.soft_contact_kd,
            kf=model.soft_contact_kf, mu=model.soft_contact_mu, x=x, previous=previous, inv_dt=F(1)/dt,
            particle_flags=None if self.bodies is None else self.bodies.kind,
            body_ids=None if self.bodies is None else self.bodies.ids,
            body_indices=None if self.bodies is None else self.bodies.indices,
            body_com=None if self.bodies is None else self.bodies.com,
            shape_filter=(contacts.surface['particle_only'] if getattr(contacts, 'surface', None) is not None
                          and contacts.surface['particle_only'] is not None else None))


