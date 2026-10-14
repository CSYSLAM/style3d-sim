# Configuration and Performance

Modify `solver.config` to affect subsequent direct `step()` calls.
Begin with an example resembling your task; change stiffness, timestep, and scene size one at a time.

## Common Settings

```python
import style3d_sim as s3d

solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
solver.config.nonlinear_iterations = 4
solver.config.linear_iterations = 50
solver.config.enable_collision_hessian_non_diagonal = True
```

This fragment uses an initialized solver. It is a debugging starting point;
each scene still needs stability and performance checks.

| Property | Purpose | Tuning considerations |
| --- | --- | --- |
| `nonlinear_solver` | `NEWTON` or `PD_NEWTON` | Algorithm choice changes more than iteration counts |
| `nonlinear_iterations` | Nonlinear budget per step | Stiff materials and complex contacts may require more |
| `linear_iterations` | PCG budget per nonlinear iteration | Too few can limit outer-iteration progress |
| `enable_collision_hessian_non_diagonal` | Coupled contact tangents | Changes cost; some contacts always retain coupling |
| `enable_self_collision` | Deformable self-collision | Shape and dedicated granular contacts remain enabled |
| `self_collision_radius` | Deformable collision thickness | Consider model scale and particle radius |
| `constraint_alpha` | Shared penalty for affine rigidity, generated joints, and hard distances | 0 disables all three |
| `wind_velocity` | World-coordinate wind, m/s | Use a three-component tuple |
| `air_density` | Air density, kg/m³ | 0 disables aerodynamic drag |
| `fluid_relaxation` | Fluid Newton step scaling | Range `(0, 1]` |
| `fluid_max_step_ratio` | Increment bound relative to kernel radius | 0 disables the limit |

See [Native Config](../reference/native.en.md#config) for all current binding properties.
An older binary may expose fewer properties than the current source.

## Rigid Body and Joint Modes

| Type | Options |
| --- | --- |
| `AffineBodyRigidityModel` | `CO_ROTATED`, `ABD_ORTHOGONALITY`, `SIX_SPRINGS`, `SO3_AUGMENTED_LAGRANGIAN` |
| `JointConstraintMode` | `PENALTY`, `AUGMENTED_LAGRANGIAN` |
| `InertiaMode` | `EXPLICIT_EULER`, `IMPLICIT_EULER`, `LIE_GROUP_MIDPOINT`, `MIDPOINT_CAYLEY`, `NONE` |

`InertiaMode.NONE` selects the free-particle inertia path; rigid bodies still simulate.
AL primal iteration parameters control iterations with fixed multipliers rather than increasing every nonlinear iteration.
Reuse a basic-shapes or joint example configuration, then compare settings individually.

## Stability Checklist

1. Check units, masses, inertia, active flags, mesh quality, and initial penetration.
2. Reduce to a single object, use a fixed timestep, and disable graphs.
3. Increase substeps to reduce each step's `dt`.
4. Confirm contacts are updated and passed to the solver each step.
5. Increase reasonable nonlinear/linear budgets, then adjust stiffness and damping.
6. Measure physical error alongside runtime; a visually intact scene alone is insufficient to judge accuracy.

Excessive contact damping suppresses bounce; high stiffness increases the system's condition number.
Fluid bulk modulus, kernel radius, and mass calibration also interact.

## CUDA Graph {#cuda-graph}

Verify the ordinary loop first. A graph captures CUDA work, parameters, and addresses;
Python object swaps during capture do not run again on replay.

This fragment uses an initialized pipeline, states, control, contacts, and solver:

```python
import warp as wp

dt = 1.0 / 240.0

def substep(source, target):
    source.clear_forces()
    pipeline.collide(source, contacts)
    solver.step(source, target, control, contacts, dt)

# Compile kernels and establish allocations before capture.
substep(state, following)
substep(following, state)
wp.synchronize()

with wp.ScopedCapture(device=model.device) as capture:
    substep(state, following)
    substep(following, state)

for _ in range(120):
    wp.capture_launch(capture.graph)
wp.synchronize()
```

Capturing two substeps returns the result to `state`, so replay needs no extra Python swap.
Warmup and capture may themselves advance states. Reset as needed before recording the official trajectory.

Recapture after changing configuration, `dt`, array addresses, model structure, or drive-feedback settings.
Keep all model/state/contact/feedback buffers referenced by the graph alive.
Perform `ParticleSurface.rebuild()`, `.numpy()`, dynamic allocations, and initial login outside capture.

## Measure Actual Runtime

GPU submission is asynchronous; CPU timing without GPU synchronization underestimates runtime:

```python
import time
import warp as wp

wp.synchronize()
started = time.perf_counter()
for _ in range(100):
    wp.capture_launch(capture.graph)
wp.synchronize()
print(f"100 graph replays: {time.perf_counter() - started:.3f}s")
```

Measure after warmup and track physics, collision detection, surface reconstruction, and rendering separately.
`.numpy()` synchronizes and copies to the CPU; reduce sampling frequency after debugging.
On multiple GPUs, keep model, state, stream, and contacts on the same device.
Pointers from another GPU cannot be treated as local memory.
