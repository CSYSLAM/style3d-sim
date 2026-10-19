# Models, States, and Simulation Loop

This page explains the structure of [First Simulation](../getting-started/first-simulation.en.md)
and the order for adapting an existing Newton project.

## Object Responsibilities

| Object | When to create it | Owned data |
| --- | --- | --- |
| `s3d.ModelBuilder` or `newton.ModelBuilder` | While defining the scene | Scene definitions before GPU allocation |
| Newton `model` | After `builder.finalize()` | Masses, topology, shapes, joints, and material arrays |
| `s3d.NewtonSolver` | After final model configuration | Native model views, solver caches, constraints, material history |
| `state` / `following` | After the solver | Mutable positions, velocities, and external forces |
| `control` | After the solver | Joint position/velocity targets and generalized forces |
| `CollisionPipeline` / `contacts` | After the solver | Collision detection and current contact data |

`s3d.ModelBuilder` extends Newton's builder with rigid body proxies and extra constraints.
A regular `newton.ModelBuilder` also works, but solver initialization may append or reorder rigid body proxy particles.
Create states, contacts, viewers, and buffers depending on particle counts **after** the solver.

## Recommended Initialization Order

1. Create the builder, register required Style3D attributes, and add particles, bodies, shapes, and joints.
2. Allocate the model with `finalize(device="cuda:0")`.
3. Set contact parameters and call material helpers such as `configure_fluid()` or `configure_granular()`.
4. Create `NewtonSolver(model)` and set `solver.config`.
5. Create two states, control, collision pipeline, and contacts.
6. Set initial conditions and perform required FK; call `sync_affine_body_state()` after editing body states.
7. Start stepping. For CUDA Graphs, follow the [performance guide](configuration.en.md#cuda-graph).

Adding objects to the builder after `finalize()` does not update an existing model.
`s3d.ModelBuilder` can only be finalized once; create another builder for another scene.

## Substep Order

Append this code after the initialization in the first example, using its `frame_dt`, `substeps`, and states:

```python
dt = frame_dt / substeps
for _ in range(substeps):
    state.clear_forces()
    # Apply new external forces here, after clearing the previous step's forces.
    pipeline.collide(state, contacts)
    solver.step(state, following, control, contacts, dt)
    state, following = following, state
```

- Write external forces after clearing them so they affect this step.
- Generate contacts from the current state before passing them to `step()`.
- After swapping, `state` holds the current result for logging and rendering.
- Without joint drives, `control` may be `None`; without shape contacts, `contacts` may be `None`.
- Driven joints require `model.control()` even when you are not applying external forces.

!!! warning "The input state is not necessarily a historical snapshot"
    Native stepping may update both input and output particle position buffers.
    To retain the previous positions, copy them before stepping.
    `.numpy().copy()` creates an independent CPU snapshot but introduces synchronization and transfer overhead.

## Units, Axis, and Timestep

Use consistent SI units: meters for positions and radii, kilograms for mass, seconds for time, and m/s for velocity.
`up_axis=newton.Axis.Z` selects Z up, with default gravity of `-9.81` along that axis.
`frame_dt=1/60` and four substeps mean `dt=1/240` for each physical step.

`dt` must be finite and positive. Begin with a small scene, fixed timestep, and ordinary Python loop,
then add parallel environments and graphs after checking the physical results.

## Add a Viewer

Reuse the initialized `model`, `state`, `following`, `solver`, `control`, `pipeline`, and `contacts`:

```python
from newton.viewer import ViewerGL

viewer = ViewerGL()
viewer.set_model(model)
sim_time = 0.0
try:
    while viewer.is_running():
        if viewer.should_step():
            for _ in range(substeps):
                state.clear_forces()
                viewer.apply_forces(state)
                pipeline.collide(state, contacts)
                solver.step(state, following, control, contacts, dt)
                state, following = following, state
            sim_time += frame_dt
        viewer.begin_frame(sim_time)
        viewer.log_state(state)
        viewer.end_frame()
finally:
    viewer.close()
```

The viewer requires a graphical environment. Use a headless program first on a remote server.
For third-party viewer API differences across versions, consult the existing examples.

## Reset or Edit Body Poses

After calling `newton.eval_fk()` or writing directly to `state.body_q` / `state.body_qd`, synchronize affine proxies:

```python
newton.eval_fk(model, model.joint_q, model.joint_qd, state)
solver.sync_affine_body_state(state)
```

Synchronize after a reset, FK, or external edit. Calling this on every ordinary substep discards the newly solved proxy state.
Granular plasticity and fracture history are owned by the solver; restoring positions and velocities does not clear them.
Recreate the solver for a full material reset.

## Migrate an Existing Newton Project

Replace the solver with `s3d.NewtonSolver(model)` and retain Newton's state, control, and collision flow.
Ensure the model is on CUDA. Convert generic triangle elasticity to Style3D as explained in [Cloth](deformables.en.md).
Set Style3D Sim iteration budgets through `solver.config`; constructor parameters from other solvers do not transfer directly.

For topology changes, material array replacement, or a different shape count, prefer recreating the model and solver.
`notify_model_changed()` provides an adapter notification entry point,
but does not guarantee arbitrary topology updates in place.
