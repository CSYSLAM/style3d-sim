# Cloth and Tetrahedral Bodies

Cloth represents a thin sheet using triangles and edges; tetrahedral bodies represent volumetric elastic objects.
Choose the model that matches the object's physical structure.

## Cloth: Register Style3D Attributes First

Generic Newton triangle surface elasticity is not directly supported by the SynReal cloth path.
Register Style3D custom attributes before adding cloth, then use its modeling helpers.
This model initialization can be used with the simulation loop:

```python
import newton
from newton.solvers import style3d
import warp as wp
import synreal_solver as sr

builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
newton.solvers.SolverStyle3D.register_custom_attributes(builder)
builder.add_ground_plane()
style3d.add_cloth_grid(
    builder,
    pos=wp.vec3(-0.5, 0.0, 1.0),
    rot=wp.quat_identity(),
    dim_x=10, dim_y=10,
    cell_x=0.1, cell_y=0.1,
    vel=wp.vec3(0.0),
    mass=0.01,
    fix_left=True,
    particle_radius=0.005,
    tri_aniso_ke=wp.vec3(1.0e2, 1.0e2, 1.0e1),
    edge_aniso_ke=wp.vec3(2.0e-4, 1.0e-4, 5.0e-5),
)
model = builder.finalize(device="cuda:0")
solver = sr.NewtonSolver(model)
```

Create two states, control, pipeline, and contacts, then follow the [simulation loop](simulation-loop.en.md).
`tri_aniso_ke` controls membrane response; `edge_aniso_ke` controls bending.
These are starting values, rather than measured parameters for a specific fabric.
`fix_left=True` anchors one side of the grid for a hanging-cloth check.

## Use a Real Cloth Mesh

Provide both world geometry and the rest metric from 2D pattern panels.
Faces sharing a 3D vertex may still have different UV coordinates at seams; preserve face-varying UV indices.
Check pattern units and triangle orientation: degenerate or flipped panels produce incorrect elastic parameters.

Existing scripts:

```bash
uv run python examples/example_cloth_hanging.py --help
uv run python examples/example_cloth_style3d.py --help
uv run python examples/example_plastic_bag.py
```

`example_cloth_style3d.py` handles asset downloading and pattern coordinates.
`example_plastic_bag.py` loads the repository's plastic-bag USD.
Follow their UV unit and index checks when adapting a garment mesh.

## Self-Collision and Shape Contacts

Ground contact needs a ground shape, pipeline contacts, and `model.soft_contact_*` parameters.
Enable `solver.config.enable_self_collision` for folding cloth if needed.
Excessive collision thickness makes a thin bag behave like a thick cushion.
Consider model scale, particle radius, shape margin, and `self_collision_radius` together.

Self-collision handling cannot recover every initially intersecting configuration.
Begin from valid geometry, reduce `dt`, then inspect material parameters and iteration counts.

## Tetrahedral Elastic Bodies

Use Newton volume-modeling helpers such as `add_soft_mesh()` to define vertices, tetrahedral indices,
mass density, and elastic parameters. Finalize on CUDA and pass the model to `NewtonSolver`.
The adapter reads `tet_indices`, `tet_poses`, `tet_activations`, and `tet_materials`.

Start with an existing tetrahedral scene:

```bash
uv run python examples/example_ball.py --help
uv run python demos/g1_jelly_drop/demo_g1_jelly_drop.py --viewer null --num-frames 120 --test
```

| Check | Reason |
| --- | --- |
| Finite, nonzero rest volume | Degenerate elements have no usable inverse rest deformation matrix |
| Consistent mesh, mass, and material units | Inconsistency changes inertia, gravity, and elasticity together |
| Reasonable initial deformation and penetration | Large distortions may exceed the available iteration budget |
| Distinguish volume mesh from rendered surface | A smooth surface does not imply sufficient volume resolution |

See [Demos and Rendering](demos.en.md) for G1 jelly parameters and validation.
The rendered jelly appearance does not calibrate its physical material.
