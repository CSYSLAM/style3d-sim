# Fluids and Granular Materials

Create particles with a Newton builder, finalize the model, select physical particle IDs,
and configure materials before constructing `NewtonSolver`.
Material helpers do not generate particles or adjust their masses, velocities, or contact radii.

## Particle IDs and Selections

Use a nonempty, one-dimensional integer array with unique IDs in `model.particle_count` range.
Fluid and granular selections must be disjoint.
Rigid body scenes also contain affine proxy particles; exclude them from material and surface-reconstruction selections.

## Fluid: Complete Model Initialization

This creates a small fluid block. Afterwards, use the [simulation loop](simulation-loop.en.md)
to create states, contacts, and advance the scene.

```python
import numpy as np
import newton
import synreal_solver as sr

spacing = 0.04
grid = np.stack(np.meshgrid(np.arange(6), np.arange(6), np.arange(6), indexing="ij"), axis=-1)
points = grid.reshape(-1, 3).astype(np.float32) * spacing
points[:, 2] += 0.3
count = len(points)
builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
builder.add_ground_plane()
builder.add_particles(
    pos=points,
    vel=np.zeros_like(points),
    mass=np.full(count, 1000.0 * spacing**3),
    radius=np.full(count, 0.45 * spacing),
)
model = builder.finalize(device="cuda:0")
sr.configure_fluid(
    model,
    np.arange(count, dtype=np.int32),
    smoothing_radius=2.0 * spacing,
    rest_density=1000.0,
    bulk_modulus=2.0e5,
    viscosity=0.01,
)
solver = sr.NewtonSolver(model)
solver.config.nonlinear_solver = sr.NonlinearSolver.NEWTON
solver.config.nonlinear_iterations = 4
solver.config.linear_iterations = 80
```

This teaching setup omits a complete tank, boundary density calibration, and surface rendering.
`mass = density * spacing**3` estimates voxel volume; the repository's tank example calibrates volume
against the discrete kernel to improve the baseline density.

### Fluid Parameters

| Parameter | Default | Units and purpose |
| --- | --- | --- |
| `smoothing_radius` | Required | m; kernel support radius, finite and positive |
| `rest_density` | 1000 | kg/m³; target density, finite and positive |
| `bulk_modulus` | 200000 | Pa; density pressure stiffness, nonnegative |
| `viscosity` | 0 | Pa·s; dynamic viscosity, nonnegative |
| `boundary_positions` | `None` | Fixed boundary samples, shape `(N, 3)` |
| `boundary_volumes` | `None` | Positive volume per boundary sample, shape `(N,)` |

Provide boundary positions and volumes together. They are static density samples in world coordinates;
**wall collision shapes are still required**. Samples do not automatically follow moving bodies or cloth.
Fluid neighborhoods are isolated across worlds; fixed boundary samples describe shared world-coordinate geometry.

Experiment with the existing tank:

```bash
uv run python examples/example_fluid.py --resolution 16
uv run python examples/example_fluid.py --resolution 16 --viewer null --num-frames 120 --test
```

Increasing resolution increases the physical particle count and computation cost, as well as visual detail.

## Granular Materials: Contacts, Bonds, Plasticity, and Fracture

Create and finalize particles first. Replace the `configure_fluid()` section above with this fragment;
configure only one of these materials on each selected particle:

```python
sr.configure_granular(
    model,
    np.arange(count, dtype=np.int32),
    contact_stiffness=2000.0,
    friction=0.5,
    cohesion=200.0,
    bond_damping=10.0,
    yield_strain=0.03,
    break_strain=0.1,
)
solver = sr.NewtonSolver(model)
```

| Parameter | Default | Purpose |
| --- | --- | --- |
| `contact_stiffness` | 2000 N/m | Normal contact stiffness; must be positive |
| `friction` | 0.5 | Coulomb friction coefficient |
| `friction_damping` | 20 N·s/m | Low-speed friction regularization |
| `cohesion` | 200 N/m | Initial bond stiffness; 0 disables initial bonds |
| `bond_damping` | 0 N·s/m | Axial bond damping; stops after fracture |
| `yield_strain` | 0.03 | Compression yield threshold in `[0, 1)` |
| `max_compaction` | 0.4 | Maximum permanent compression in `[0, 1)` |
| `break_strain` | 0.1 | Nonnegative tensile fracture threshold |
| `bond_radius` | `None` | Initial bond search radius; default is 2.5 times the largest selected radius |
| `bond_indices` | `None` | Explicit `(N, 2)` particle ID pairs; mutually exclusive with `bond_radius` |
| `adhesion` | 0 N/m | Stiffness of newly formed contact bonds; 0 disables them |
| `bond_formation_gap` | 0 m | Allowed gap for forming contact bonds |
| `bond_formation_speed` | 1 m/s | Maximum relative speed for forming contact bonds |
| `max_dynamic_bonds` | 12 | Dynamic bond slots owned by each lower-ID particle; integer in `[1, 64]` |

Scalars must be finite and meet their nonnegative constraints. Selected particles must be active with positive mass and radius.
Explicit bonds cannot join a particle to itself, duplicate a pair, or connect different worlds.

The dedicated granular contact path exists even with `enable_self_collision=False`.
Enable the appropriate self-collision path separately for contacts with other particles or cloth.
Granular contacts with shapes still use the regular pipeline and shape/soft-contact materials.

### Reset Material History

Broken initial authored bonds do not heal. Dynamic contact bonds may reform after separation and renewed contact.
Plasticity and fracture history belong to the solver.
Recreate it to reset material history completely; restoring positions and velocities retains prior damage and plasticity.

This coarse-grained model does not include grain rotation, temperature, phase transitions,
or persistent tangential friction history. Demo parameters are not measured material calibrations.

```bash
uv run python examples/example_snow.py
uv run python examples/example_granular_beaf.py --no-cut
```

## Surface Reconstruction and Rendering

`ParticleSurface` reconstructs a triangle mesh without changing particle physics.
After creating the solver and state, use the previously retained physical particle count `count`:

```python
positions = state.particle_q[:count]
surface = sr.ParticleSurface(spacing, positions, voxel_size=spacing / 2.0)
mesh = surface.rebuild(positions)
```

`positions` must be a one-dimensional CUDA `wp.vec3` array.
Keep the particle selection and order identical between initialization and rebuilding.
Defaults are `spacing/3` for voxel size, `2*spacing` for support radius, and `0.6*spacing` for surface radius.
Smaller voxels increase mesh and memory costs. Rebuilding synchronizes and allocates dynamically;
perform it outside simulation CUDA Graphs.

Fracture-aware reconstruction uses selection-local `wp.vec2i` bond IDs, plus matching `wp.int32` broken flags.
Mesh buffers may be reused by the next rebuild; copy them when retaining history.

The fluid example already handles dynamic viewer topology:

```bash
uv run python examples/example_fluid.py --resolution 16 --build-surface --viewer gl
```

`--build-surface` requires a viewer supporting dynamic topology; this example does not support it with the RTX viewer.
