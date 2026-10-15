# API Overview

Start with `NewtonSolver`, which handles model conversion, state validation, streams, and rigid body proxies.
Use native `Solver` when you need to manage CUDA arrays and model views yourself.

## Common Entry Points

| API | Purpose | Reference |
| --- | --- | --- |
| `ModelBuilder` | Newton builder extensions, rigid body proxies, extra constraints | [Python API](python.en.md#modelbuilder) |
| `NewtonSolver` | Solver adapter for Newton models and states | [Python API](python.en.md#newtonsolver) |
| `get_assets` / `get_asset` | Fetch and locate example assets | [Python API](python.en.md#get_assets) |
| `configure_fluid` | Particle selection and fluid materials | [Materials](../guides/particles.en.md) |
| `configure_granular` | Granular contacts, bonds, plasticity, fracture, adhesion | [Materials](../guides/particles.en.md) |
| `ParticleSurface` | Dynamic triangle meshes from CUDA particles | [Python API](python.en.md#particlesurface) |
| `log_surface_mesh` | Send dynamic topology to a Newton viewer | [Python API](python.en.md) |
| `login` / `is_logged_in` | Native session authentication | [Authentication](../getting-started/authentication.en.md) |
| `set_log_callback` | Register native logging callbacks | [Native API](native.en.md) |
| `Model` / `State` / `Span` / `Solver` | CUDA memory views and native stepping | [Native API](native.en.md) |

## NewtonSolver Constructor Parameters

| Parameter | Default | Meaning |
| --- | --- | --- |
| `model` | Required | Newton model allocated on CUDA |
| `joint_damping` | 100.0 | Normal damping for generated point-line constraints; finite and nonnegative |
| `joint_attachment_distance` | 0.1 | Anchor spacing for joint direction constraints; finite and positive |
| `joint_line_half_length` | 10.0 | Half-length of generated guide segments; finite and positive |
| `joint_drive_armature` | 0.0 | Optional isotropic inertia regularization for driven bodies; finite and nonnegative |

`joint_drive_armature` adjusts body inertia; Newton's `model.joint_armature` adds inertia to supported relative joint DOFs.
They are separate parameters. Retain defaults initially and use joint examples when tuning them.

## The Five step Arguments

```text
solver.step(state_in, state_out, control, contacts, dt)
```

| Argument | Requirement |
| --- | --- |
| `state_in` | Newton state with model-compatible counts, dtypes, and device |
| `state_out` | Separate output state with the same structure |
| `control` | Newton control for driven joints; may be `None` without drives |
| `contacts` | Latest contacts; may be `None` without shape contacts |
| `dt` | Seconds; finite and positive |

Native `Solver.step()` overloads have different signatures; follow the argument order for the chosen interface.
See [Simulation Loop](../guides/simulation-loop.en.md) for the complete lifecycle.

## Native API Example {#native-api}

### Understand Span First

`Span(ptr=array.ptr, size=array.size)` stores a contiguous CUDA address and an **element count**.
The size is not measured in bytes. Span neither allocates nor frees memory, and does not keep Warp arrays alive.
Retain all original arrays for indices, masses, gravity, positions, and velocities until their GPU work completes.

`numpy.ndarray.ctypes.data` is a CPU address and cannot be passed as CUDA memory.
Noncontiguous views, mismatched dtypes, pointers on another device, and freed arrays are also invalid.
A nonzero size requires a non-null address.

### Complete Downloadable Example

This example uses two particles with zero gravity, constant velocities, and no contacts
to demonstrate ownership and native stepping.
Native `Solver` does not automatically read environment credentials; the script authenticates interactively in the same process.

```bash
uv run python docs/samples/native_particles.py
```

[Download the script](../samples/native_particles.py)

```python
--8<-- "docs/samples/native_particles.py"
```

For contacts or joint controls, choose the relevant native overload and populate `Contact`, `Control`, and model Spans yourself.
Beginners can use `NewtonSolver` to handle those mappings.

## Logging Callbacks

Register an application callback before creating the solver:

```python
import style3d_sim as s3d

def log_message(file_name, function_name, line, level, message):
    print(f"[{level}] {function_name}:{line} {message}")

s3d.set_log_callback(log_message)
```

Callbacks receive the file name, function name, line number, level, and message.
Avoid expensive GPU copies in frequent callbacks and exclude credentials from logs.

## How References Stay Updated

Documentation builds statically extract public signatures, properties, and docstrings from `.py` and `_core.pyi`.
Python signature changes appear automatically. After a native interface change,
maintainers update stubs using the matching extension:

```bash
uv run poe stubs
```

The reference generator does not load `_core`. New native interfaces appear only after the stubs are updated.
