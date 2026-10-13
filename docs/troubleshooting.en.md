# Troubleshooting

## Cannot Import `_core`

Typical error: `ModuleNotFoundError: No module named 'synreal_solver._core'`.

1. Complete the CMake installation in [Installation](getting-started/installation.en.md), including steps after `uv sync`.
2. Confirm the extension is in `src/synreal_solver/` alongside the Python package.
3. Match the extension's Python ABI to `.venv`; a CPython 3.11 binary cannot run under 3.12.
4. Set `PYTHONPATH` to the repository's `src` directory in the current terminal.

```bash
uv run python -c "import sys, sysconfig; print(sys.executable); print(sysconfig.get_config_var('EXT_SUFFIX'))"
```

For Windows `DLL load failed` or missing Linux shared libraries, inspect binary runtime dependencies,
the driver, and CUDA versions. Python path changes alone may not resolve these errors.

## An Older Version Is Imported

```bash
uv run python -c "import synreal_solver as sr; print(sr.__file__)"
uv run python -c "import synreal_solver._core as core; print(core.__file__)"
```

If these point to system site-packages, use the `uv run` environment and reset the source path.
A newer wrapper paired with an older `_core` may cause missing attributes or enums; update both to matching versions.

## Submodule Initialization Fails

The current submodules use private LAN SSH repositories and require appropriate network and account access.
Check host reachability and SSH permissions.
External distribution needs accessible URLs or a binary channel supplied by maintainers.
Cloning the root repository does not grant access to native submodules.

## CMake Cannot Find pybind11, Python, or CUDA

Install development dependencies with `uv sync` and point `Python_EXECUTABLE` to `.venv`.
For source builds, check `nvcc --version`, the host compiler, and CMake.
Use a compatible developer terminal on Windows.
After toolchain changes, configure a new build directory to avoid stale cache entries.

## Login Fails or Waits for Input {#authentication}

1. Check authentication service access and account validity from the running process.
2. Set `SYNREAL_ID` and one password variable before launching the process.
3. `SYNRAL_PASSWORD` takes precedence over `SYNREAL_PASSWORD`; remove unused old variables.
4. Headless runs still request stdin when credentials are missing.
5. Check `is_logged_in()` in the simulation process; authentication in another Python process does not transfer.

Keep exception logs without sensitive data. Empty passwords or unlimited retries do not resolve authentication failures.

## “requires a Newton model allocated on a CUDA device”

```python
model = builder.finalize(device="cuda:0")
```

Confirm that `warp.is_cuda_available()` is `True`.
After CPU finalization, recreate model and state arrays on the correct device; changing configuration alone cannot move them.

## Cloth Reports Unsupported Generic Surface Elasticity

Register Style3D attributes after creating the builder, then use `style3d.add_cloth_grid()` or `add_cloth_mesh()`.
See [Cloth](guides/deformables.en.md) for the supported material path.

## State Particle Counts Do Not Match

Solver initialization may append rigid body proxy particles.
Create `model.state()`, viewers, and count-dependent buffers after the solver.
Use only physical particles for material selection and surface reconstruction.

## Penetration, Jitter, NaNs, or GPU Memory Exhaustion

| Symptom | First checks |
| --- | --- |
| Body passes through the ground | Shapes exist, contacts update each step, contacts are passed to step |
| Cloth penetration | Soft contacts, self-collision thickness, initial penetration, `dt` |
| Jelly/fluid collapse | Mass calibration, scale, material units, nonlinear budget |
| NaNs | Nonfinite inputs, degenerate mesh, nonpositive mass/radius, excessive deformation |
| Graph ignores new settings | Recapture after configuration changes |
| Slow surface reconstruction | Increase voxel size and lower rebuild frequency |
| GPU memory exhaustion | Reduce particles/environments, surface resolution, contact capacity; measure peak usage |

Reduce the scene, disable graphs and rendering, and follow [Configuration and Performance](guides/configuration.en.md).
Increasing stiffness with insufficient iterations may fail to reduce physical error.
