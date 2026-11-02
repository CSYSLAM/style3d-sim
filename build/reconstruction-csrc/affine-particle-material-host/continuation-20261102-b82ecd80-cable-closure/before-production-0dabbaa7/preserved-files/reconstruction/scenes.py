"""Validation scenes that are not plain copies of the shipped examples.

FluidTank is examples/example_fluid.py without the rubber ducks (rigid bodies are not reconstructed yet): the same
lattice layout, Poly6 rest-volume calibration, tank planes and two-layer boundary quadrature.
"""
import itertools
import math

import numpy as np

TANK_LOWER = (0.0, -0.56, 0.0)
TANK_UPPER = (3.36, 0.56, 2.24)
REST_DENSITY = 1000.0
FRAME_DT = 1.0/60.0


def particle_layout(resolution):
    spacing = 1.12/resolution
    nx, ny, nz = resolution, 3*resolution//4, 3*resolution//2
    cells = np.stack(np.meshgrid(np.arange(nx), np.arange(ny), np.arange(nz), indexing='ij'), axis=-1)
    positions = (cells.reshape(-1, 3).astype(np.float32)+0.5)*spacing
    positions[:, 1] -= 0.5*ny*spacing
    rng = np.random.default_rng(42)
    positions += rng.uniform(-0.01*spacing, 0.01*spacing, positions.shape).astype(np.float32)
    return positions, spacing


def rest_volume(spacing):
    h = 2.0*spacing
    offsets = np.asarray(list(itertools.product(range(-2, 3), repeat=3)))*spacing
    weights = 315.0/(64.0*math.pi)*np.maximum(1.0-np.sum(offsets**2, axis=1)/h**2, 0.0)**3
    return h**3/weights.sum()


def boundary_samples(spacing):
    lower, upper = np.asarray(TANK_LOWER), np.asarray(TANK_UPPER)
    counts = np.rint((upper-lower)/spacing).astype(int)
    axes = [(np.arange(-2, n+2)+0.5)*spacing+low for n, low in zip(counts, lower, strict=True)]
    points = np.stack(np.meshgrid(*axes, indexing='ij'), axis=-1).reshape(-1, 3)
    outside = np.any((points < lower) | (points > upper), axis=1)
    return points[outside].astype(np.float32)


def _load_configure_fluid():
    # Importing the style3d_sim package loads the native _core; fluid.py itself only needs numpy and warp, so the
    # source backend loads it by path and both backends build an identical model.
    import importlib.util
    from pathlib import Path
    path = Path(__file__).resolve().parents[1]/'src/style3d_sim/fluid.py'
    spec = importlib.util.spec_from_file_location('_reconstruction_fluid_config', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.configure_fluid


configure_fluid = _load_configure_fluid()


class _NullViewer:
    def apply_forces(self, state):
        pass


class FluidTank:
    """Dam break in a closed tank; `backend` is 'native' (legacy NewtonSolver) or 'source'."""
    def __init__(self, backend, resolution=8, iterations=5, linear_iterations=20, bulk_modulus=200000.0,
                 viscosity=0.1):
        import newton
        import warp as wp
        positions, self.spacing = particle_layout(resolution)
        self.viewer = _NullViewer()
        self.sim_substeps = math.ceil(2*resolution/32)
        self.sim_dt = FRAME_DT/self.sim_substeps
        self.volume = float(rest_volume(self.spacing))
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        builder.add_particles(pos=positions, vel=np.zeros_like(positions),
                              mass=np.full(len(positions), REST_DENSITY*self.volume),
                              radius=np.full(len(positions), 0.45*self.spacing))
        wall = builder.default_shape_cfg.copy()
        wall.ke, wall.kd, wall.kf, wall.mu = 2.0e5, 20.0, 0.0, 0.0
        for axis in range(3):
            for sign, bound in ((1.0, TANK_LOWER[axis]), (-1.0, TANK_UPPER[axis])):
                normal = np.zeros(3)
                normal[axis] = sign
                position = np.zeros(3)
                position[axis] = bound
                rotation = (wp.quat_from_axis_angle(wp.vec3(1.0, 0.0, 0.0), math.pi) if axis == 2 and sign < 0
                            else wp.quat_between_vectors(wp.vec3(0.0, 0.0, 1.0), wp.vec3(*normal)))
                builder.add_shape_plane(xform=wp.transform(wp.vec3(*position), rotation), width=0.0, length=0.0,
                                        cfg=wall)
        self.model = builder.finalize(device='cuda:0')
        self.boundaries = boundary_samples(self.spacing)
        configure_fluid(self.model, np.arange(len(positions), dtype=np.int32), smoothing_radius=2.0*self.spacing,
                            bulk_modulus=bulk_modulus, viscosity=viscosity, boundary_positions=self.boundaries,
                            boundary_volumes=np.full(len(self.boundaries), self.volume))
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.solver.config.nonlinear_iterations = iterations
        self.solver.config.linear_iterations = linear_iterations
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=6*len(positions))
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        q = self.state_0.particle_q.numpy()
        if not np.isfinite(q).all():
            raise AssertionError('nonfinite fluid state')


def _load_configure_granular():
    import importlib.util
    from pathlib import Path
    path = Path(__file__).resolve().parents[1]/'src/style3d_sim/granular.py'
    spec = importlib.util.spec_from_file_location('_reconstruction_granular_config', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.configure_granular


configure_granular = _load_configure_granular()


class GranularPile:
    """Cohesive grain block thrown sideways onto a ground plane. Every granular mechanism is active: contacts with
    friction, initial bonds with damping, plastic compaction, fracture (low break strain) and adhesion bonds."""
    def __init__(self, backend, resolution=6, iterations=6, linear_iterations=24, cohesion=200.0):
        """cohesion=0 leaves the grains unbonded so that adhesion forms contact bonds (form_bonds)."""
        import newton
        spacing = 0.02
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        n = resolution
        cells = np.stack(np.meshgrid(np.arange(n), np.arange(n), np.arange(n), indexing='ij'), axis=-1)
        positions = (cells.reshape(-1, 3).astype(np.float32)+0.5)*spacing+np.array([0.0, 0.0, 0.05], np.float32)
        rng = np.random.default_rng(7)
        positions += rng.uniform(-0.05*spacing, 0.05*spacing, positions.shape).astype(np.float32)
        velocities = np.zeros_like(positions)
        velocities[:, 0] = 1.0
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        builder.add_particles(pos=positions, vel=velocities, mass=np.full(len(positions), 0.01),
                              radius=np.full(len(positions), 0.45*spacing))
        ground = builder.default_shape_cfg.copy()
        ground.ke, ground.kd, ground.kf, ground.mu = 1.0e4, 10.0, 0.0, 0.0
        builder.add_ground_plane(cfg=ground)
        self.model = builder.finalize(device='cuda:0')
        configure_granular(self.model, np.arange(len(positions), dtype=np.int32), contact_stiffness=2000.0,
                           friction=0.5, friction_damping=20.0, cohesion=cohesion, bond_damping=0.5,
                           yield_strain=0.03, max_compaction=0.4, break_strain=0.05, bond_radius=1.5*spacing,
                           adhesion=100.0, bond_formation_gap=0.1*spacing, bond_formation_speed=1.0,
                           max_dynamic_bonds=12)
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.solver.config.nonlinear_iterations = iterations
        self.solver.config.linear_iterations = linear_iterations
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=4*len(positions))
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite granular state')


class ParticlePile:
    """Free particles (no topology) with self collision, thrown onto a ground plane: exercises the particle-pair
    path of self_collision_kernel (build_particle_aabbs, query_particle_pairs, accumulate_particle_pairs)."""
    def __init__(self, backend, resolution=5, radius=0.01, self_collision_radius=0.004):
        import newton
        spacing = 0.021
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        n = resolution
        cells = np.stack(np.meshgrid(np.arange(n), np.arange(n), np.arange(n), indexing='ij'), axis=-1)
        positions = (cells.reshape(-1, 3).astype(np.float32)+0.5)*spacing+np.array([0.0, 0.0, 0.03], np.float32)
        rng = np.random.default_rng(11)
        positions += rng.uniform(-0.1*spacing, 0.1*spacing, positions.shape).astype(np.float32)
        velocities = rng.uniform(-0.3, 0.3, positions.shape).astype(np.float32)
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        builder.add_particles(pos=positions, vel=velocities, mass=np.full(len(positions), 0.005),
                              radius=np.full(len(positions), radius))
        ground = builder.default_shape_cfg.copy()
        ground.ke, ground.kd, ground.kf, ground.mu = 1.0e4, 10.0, 0.0, 0.0
        builder.add_ground_plane(cfg=ground)
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.solver.config.enable_self_collision = True
        self.solver.config.self_collision_radius = self_collision_radius
        self.solver.config.nonlinear_iterations = 5
        self.solver.config.linear_iterations = 20
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=4*len(positions))
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite particle state')


class SpringNet:
    """Mass-spring sheet (structural, shear and bend springs, no triangles) hanging from two pinned corners and
    swinging onto the ground: exercises evaluate_spring_force / add_spring_gauss_newton_hessian and the spring
    entries of the host constant matrix."""
    def __init__(self, backend, resolution=8):
        import newton
        spacing = 0.03
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        n = resolution
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        index = {}
        for i in range(n):
            for j in range(n):
                mass = 0.0 if (j == n-1 and i in (0, n-1)) else 0.01
                index[i, j] = builder.add_particle(pos=(i*spacing, 0.0, 0.15+j*spacing), vel=(0.0, 0.2, 0.0),
                                                   mass=mass, radius=0.005)
        rng = np.random.default_rng(3)
        for (i, j), a in index.items():
            for di, dj, ke in ((1, 0, 300.0), (0, 1, 300.0), (1, 1, 100.0), (1, -1, 100.0), (2, 0, 30.0), (0, 2, 30.0)):
                b = index.get((i+di, j+dj))
                if b is not None:
                    builder.add_spring(a, b, ke=ke*float(rng.uniform(0.8, 1.2)), kd=0.0, control=0.0)
        ground = builder.default_shape_cfg.copy()
        ground.ke, ground.kd, ground.kf, ground.mu = 1.0e4, 10.0, 0.0, 0.0
        builder.add_ground_plane(cfg=ground)
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.solver.config.nonlinear_iterations = 5
        self.solver.config.linear_iterations = 30
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=4*n*n)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite spring state')


class ClothDrag:
    """examples/example_cloth_hanging.py (Style3D cloth fixed on the left) with triangle air drag and wind:
    exercises initialize_triangle_drag, evaluate_triangle_drag, add_triangle_drag_preconditioner and
    multiply_triangle_drag_tangent."""
    def __init__(self, backend, width=8, height=8, drag=1.5, wind=(3.0, 1.0, 0.0)):
        import newton
        import warp as wp
        from newton.solvers import style3d
        self.viewer = _NullViewer()
        self.sim_substeps = 2
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder()
        newton.solvers.SolverStyle3D.register_custom_attributes(builder)
        builder.add_ground_plane()
        style3d.add_cloth_grid(builder, pos=wp.vec3(0.0, 0.0, 4.0),
                               rot=wp.quat_from_axis_angle(wp.vec3(0.0, 0.0, 1.0), wp.pi*0.5),
                               vel=wp.vec3(0.0, 0.0, 0.0), dim_x=width, dim_y=height, cell_x=0.1, cell_y=0.1,
                               mass=0.1, fix_left=True, edge_kd=0.0, particle_radius=0.05,
                               tri_aniso_ke=wp.vec3(1.0e4, 1.0e4, 1.0e3), edge_aniso_ke=wp.vec3(2.0e-6, 1.0e-6, 5.0e-6))
        self.model = builder.finalize()
        self.model.soft_contact_ke = 1.0e2
        self.model.soft_contact_kd = 1.0e2
        self.model.soft_contact_mu = 1.0
        materials = self.model.tri_materials.numpy()
        materials[:, 3] = drag
        self.model.tri_materials.assign(materials)
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.solver.config.nonlinear_iterations = 5
        self.solver.config.linear_iterations = 50
        self.solver.config.wind_velocity = wind
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.contacts = self.model.collide(self.state_0)

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite cloth state')


class SpinningBox:
    """One free rigid box (affine body) with linear and angular velocity under gravity, no contacts: exercises the
    affine-body inertia (MIDPOINT_CAYLEY), the SO(3) augmented-Lagrangian rigidity and the body preconditioner."""
    def __init__(self, backend, count=1):
        import newton
        import warp as wp
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        for k in range(count):
            body = builder.add_body(xform=wp.transform(wp.vec3(1.0*k, 0.0, 1.0),
                                                       wp.quat_from_axis_angle(wp.vec3(1.0, 0.3, 0.2), 0.4)))
            builder.add_shape_box(body, hx=0.2, hy=0.1, hz=0.05)
            if k % 2:
                # An offset second shape makes the inertia non-principal: nonzero off-diagonal second moments.
                builder.add_shape_sphere(body, xform=wp.transform(wp.vec3(0.15, 0.08, -0.04), wp.quat_identity()),
                                         radius=0.06)
        self.model = builder.finalize(device='cuda:0')
        qd = self.model.body_qd.numpy()
        qd[:, :3] = (0.5, -0.2, 1.0)   # Newton body_qd: linear then angular (world frame)
        qd[:, 3:] = (3.0, 1.0, -2.0)
        self.model.body_qd.assign(qd)
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.body_q.numpy()).all():
            raise AssertionError('nonfinite body state')


class BodyDrop:
    """A spinning box and a sphere body dropped onto the ground plane: rigid contacts between affine bodies and a
    static plane (evaluate_contact_force / evaluate_contact_tangent, rolling contact kernels)."""
    def __init__(self, backend, count=1, rolling=True, hard=False):
        import newton
        import warp as wp
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        if not rolling:
            builder.default_shape_cfg.mu_rolling = 0.0
            builder.default_shape_cfg.mu_torsional = 0.0
        for k in range(count):
            box = builder.add_body(xform=wp.transform(wp.vec3(1.0*k, 0.0, 0.25),
                                                      wp.quat_from_axis_angle(wp.vec3(1.0, 0.3, 0.2), 0.4)))
            builder.add_shape_box(box, hx=0.2, hy=0.1, hz=0.05)
            ball = builder.add_body(xform=wp.transform(wp.vec3(1.0*k, 0.6, 0.15), wp.quat_identity()))
            builder.add_shape_sphere(ball, radius=0.08)
        builder.add_ground_plane()
        self.model = builder.finalize(device='cuda:0')
        qd = self.model.body_qd.numpy()
        qd[:, :3] = (0.5, -0.2, -0.5)
        qd[:, 3:] = (3.0, 1.0, -2.0)
        self.model.body_qd.assign(qd)
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
            if hard:
                # Augmented-Lagrangian hard rigid contacts (initialize/evaluate/update/snapshot_hard_contacts).
                self.solver.config.rigid_contact_hard = True
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.body_q.numpy()).all():
            raise AssertionError('nonfinite body state')


class BodyConstraints:
    """Three free boxes under gravity held by plain (non-joint) body constraints: penalty springs to the world and
    between bodies, and point-line penalties to a world segment and a body segment (evaluate_body_spring_force,
    evaluate_body_point_line_force and their Gauss-Newton Hessians). Shape collisions are off."""
    def __init__(self, backend, pd=False, distance=False, rigidity=None):
        import newton
        import warp as wp
        import style3d_sim as s3d
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = s3d.ModelBuilder(up_axis=newton.Axis.Z, affine_body_particle_radius=0.0)
        cfg = builder.default_shape_cfg.copy()
        cfg.density = 1.0e3
        cfg.has_shape_collision = False
        cfg.has_particle_collision = False
        bodies = []
        for k, (pos, rot) in enumerate((((0.0, 0.0, 1.0), 0.0), ((0.3, 0.05, 0.9), 0.4), ((-0.2, 0.3, 1.1), -0.3))):
            q = wp.quat_from_axis_angle(wp.vec3(0.3, 1.0, 0.2), rot)
            body = builder.add_body(xform=wp.transform(wp.vec3(*pos), q))
            builder.add_shape_box(body, hx=0.05, hy=0.08, hz=0.04, cfg=cfg)
            bodies.append(body)
        a, b, c = bodies
        builder.add_body_spring(-1, a, (0.0, 0.0, 1.4), (0.0, 0.05, 0.03), stiffness=2.0e3)
        builder.add_body_spring(-1, a, (0.2, -0.1, 1.3), (0.04, -0.06, 0.0), stiffness=1.0e3, rest_length=0.25)
        builder.add_body_spring(a, b, (0.05, 0.0, 0.0), (-0.05, 0.02, 0.0), stiffness=1.5e3)
        builder.add_body_spring(b, -1, (0.0, 0.0, 0.04), (0.4, 0.1, 1.3), stiffness=8.0e2, rest_length=0.3)
        builder.add_body_point_line(c, -1, (0.0, 0.0, 0.0), (-0.6, 0.3, 1.0), (0.2, 0.3, 1.2), stiffness=3.0e3)
        builder.add_body_point_line(c, a, (0.03, -0.05, 0.0), (-0.05, 0.0, -0.1), (-0.05, 0.0, 0.1), stiffness=2.0e3)
        if distance:
            builder.add_body_distance_constraint(-1, a, (0.1, 0.0, 1.5), (0.0, 0.0, 0.04))
            builder.add_body_distance_constraint(a, b, (0.0, 0.08, 0.0), (0.0, -0.08, 0.0), rest_length=0.2)
            builder.add_body_distance_constraint(b, c, (0.05, 0.0, 0.0), (-0.05, 0.0, 0.0))
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
            if pd:
                self.solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON
                self.solver.config.inertia_mode = s3d.InertiaMode.NONE
            if rigidity is not None:
                # CO_ROTATED / ABD_ORTHOGONALITY / SIX_SPRINGS instead of the default SO(3) augmented Lagrangian.
                self.solver.config.affine_body_rigidity_model = getattr(s3d.AffineBodyRigidityModel, rigidity)
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.body_q.numpy()).all():
            raise AssertionError('nonfinite body state')


class ParticlesOnBody:
    """Free particles raining onto a box body and a sphere body that rest on the ground plane: particle soft
    contacts against shapes owned by affine bodies (evaluate_soft_contact_force with P28-P30), together with the
    rigid ground contacts and rolling friction of the bodies."""
    def __init__(self, backend, resolution=4):
        import newton
        import warp as wp
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        box = builder.add_body(xform=wp.transform(wp.vec3(0.0, 0.0, 0.06), wp.quat_identity()))
        builder.add_shape_box(box, hx=0.15, hy=0.12, hz=0.05)
        ball = builder.add_body(xform=wp.transform(wp.vec3(0.0, 0.3, 0.09), wp.quat_identity()))
        builder.add_shape_sphere(ball, radius=0.08)
        n = resolution
        spacing = 0.05
        cells = np.stack(np.meshgrid(np.arange(n), np.arange(2*n), np.arange(2), indexing='ij'), axis=-1)
        positions = (cells.reshape(-1, 3).astype(np.float32)*spacing
                     + np.array([-0.5*(n-1)*spacing, -0.08, 0.2], np.float32))
        rng = np.random.default_rng(5)
        positions += rng.uniform(-0.005, 0.005, positions.shape).astype(np.float32)
        builder.add_particles(pos=positions, vel=np.zeros_like(positions), mass=np.full(len(positions), 0.01),
                              radius=np.full(len(positions), 0.012))
        builder.add_ground_plane()
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_max=8*len(positions))
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite particle state')


class Pendulum:
    """A two-link chain of box bodies on revolute joints (the first to the world), swinging under gravity, with a ball
    joint variant: joint body springs and point-lines in augmented-Lagrangian form."""
    def __init__(self, backend, links=2, joint='revolute', drive=False, limits=False, armature=0.0, pd=False):
        import newton
        import warp as wp
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        parent = -1
        joints = []
        for k in range(links):
            body = builder.add_link(xform=wp.transform(wp.vec3(0.0, 0.2*(k+1), 1.0), wp.quat_identity()))
            builder.add_shape_box(body, hx=0.02, hy=0.1, hz=0.02)
            parent_xform = wp.transform(wp.vec3(0.0, 0.0, 1.0) if parent < 0 else wp.vec3(0.0, 0.1, 0.0),
                                        wp.quat_identity())
            child_xform = wp.transform(wp.vec3(0.0, -0.1, 0.0), wp.quat_identity())
            if joint == 'prismatic':
                # Second link slides along its own length on a driven prismatic joint (type 0 drive branch).
                gains = dict(target_pos=0.05, target_ke=5.0, target_kd=0.5, damping=0.02) if drive else {}
                joints.append(builder.add_joint_prismatic(parent, body, parent_xform=parent_xform,
                                                          child_xform=child_xform, axis=wp.vec3(0.0, 1.0, 0.0),
                                                          **gains) if k else
                              builder.add_joint_revolute(parent, body, parent_xform=parent_xform,
                                                         child_xform=child_xform, axis=wp.vec3(1.0, 0.0, 0.0)))
            elif joint == 'revolute':
                # Optional position drive with damping (evaluate_joint_drive_load and its tangent kernels).
                gains = dict(target_pos=0.8*(-1)**k, target_ke=2.0, target_kd=0.2, damping=0.01) if drive else {}
                if armature:
                    gains['armature'] = armature
                if limits:
                    # Stops reached during the swing (evaluate_angular_limits in all three modes).
                    gains.update(limit_lower=-0.4, limit_upper=0.3, limit_ke=50.0, limit_kd=1.0)
                joints.append(builder.add_joint_revolute(parent, body, parent_xform=parent_xform,
                                                         child_xform=child_xform, axis=wp.vec3(1.0, 0.0, 0.0),
                                                         **gains))
            else:
                joints.append(builder.add_joint_ball(parent, body, parent_xform=parent_xform, child_xform=child_xform))
            parent = body
        builder.add_articulation(joints)
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
            if pd:
                # Target-demo settings: projective-dynamics Newton without an inertia model.
                self.solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON
                self.solver.config.inertia_mode = s3d.InertiaMode.NONE
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.body_q.numpy()).all():
            raise AssertionError('nonfinite body state')


class ClothOnBox:
    """A free Style3D cloth falling onto a box body resting on the ground, with Newton's full-surface rigid-soft
    contacts (edge/face soft contacts, evaluate_surface_contact_force and its tangent kernels) and optionally the
    target-demo solver settings (PD_NEWTON, no inertia model)."""
    def __init__(self, backend, size=6, full_surface=True, pd=False, edge_kd=0.0):
        import newton
        import warp as wp
        from newton.solvers import style3d
        self.viewer = _NullViewer()
        self.sim_substeps = 4
        self.sim_dt = FRAME_DT/self.sim_substeps
        builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
        newton.solvers.SolverStyle3D.register_custom_attributes(builder)
        box = builder.add_body(xform=wp.transform(wp.vec3(0.0, 0.0, 0.1), wp.quat_identity()))
        builder.add_shape_box(box, hx=0.15, hy=0.15, hz=0.1)
        builder.add_ground_plane()
        style3d.add_cloth_grid(builder, pos=wp.vec3(-0.25, -0.25, 0.3), rot=wp.quat_identity(),
                               vel=wp.vec3(0.0, 0.0, 0.0), dim_x=size, dim_y=size, cell_x=0.5/size, cell_y=0.5/size,
                               mass=0.05, fix_left=False, edge_kd=edge_kd, particle_radius=0.01,
                               tri_aniso_ke=wp.vec3(1.0e3, 1.0e3, 1.0e2), edge_aniso_ke=wp.vec3(2.0e-6, 1.0e-6, 5.0e-6))
        self.model = builder.finalize(device='cuda:0')
        if backend == 'native':
            import style3d_sim as s3d
            self.solver = s3d.NewtonSolver(self.model)
            self.solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
            if pd:
                self.solver.config.nonlinear_solver = s3d.NonlinearSolver.PD_NEWTON
                self.solver.config.inertia_mode = s3d.InertiaMode.NONE
        else:
            from .solver import ReconstructedSolver
            self.solver = ReconstructedSolver(self.model)
        self.state_0 = self.model.state()
        self.state_1 = self.model.state()
        self.control = self.model.control()
        self.collision_pipeline = newton.CollisionPipeline(self.model, soft_contact_margin=0.006,
                                                           enable_rigid_soft_full_surface_contact=full_surface)
        self.contacts = self.collision_pipeline.contacts()

    def test_final(self):
        if not np.isfinite(self.state_0.particle_q.numpy()).all():
            raise AssertionError('nonfinite particle state')
