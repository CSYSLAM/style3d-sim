<div align="center">
  <h1>SynReal Solver</h1>
  <p>CUDA-accelerated implicit simulation for particles, cloth, deformable bodies, and affine rigid bodies.</p>
  <p>
    <a href="#demo-showcase">Demos</a> &middot;
    <a href="#build-and-install">Build</a> &middot;
    <a href="#authentication">Login</a> &middot;
    <a href="#run-examples">Run examples</a> &middot;
    <a href="#python-api">Use the API</a>
  </p>
</div>

SynReal Solver provides a Python API and a Newton Physics adapter, so a Newton
model can use SynReal for contact handling, constraints, and nonlinear solves.

## Demo Showcase

<table>
  <tr>
    <td width="50%" align="center" valign="top">
      <img src="docs/images/g1_jelly_drop_demo.png" alt="G1 humanoid interacting with deformable jelly blocks" width="100%" />
      <p><strong>G1 Jelly Drop</strong><br />Humanoid interaction with deformable FEM blocks.</p>
      <p><a href="demos/g1_jelly_drop/demo_g1_jelly_drop.py">View demo code</a></p>
    </td>
    <td width="50%" align="center" valign="top">
      <img src="docs/images/piper_scene_demo.png" alt="Piper robot arm transporting a deformable bag of apples" width="100%" />
      <p><strong>Piper Bag Transport</strong><br />Robotic manipulation of a deformable bag.</p>
      <p><a href="demos/piper_bag_transport/demo_piper_bag_transport.py">View demo code</a></p>
    </td>
  </tr>
</table>

## Features

- CUDA-native implicit integration and block-PCG linear solves.
- Particle, tetrahedral, cloth, and affine rigid-body support.
- Contact, friction, joint, spring, and drive constraints.
- Newton Physics solver integration through `NewtonSolver`.
- Optional prebuilt extensions for supported Python and platform ABIs.
- Python and CMake build workflows.

## Requirements

For normal development and execution:

- Windows or Linux.
- Python 3.11 or newer.
- NVIDIA GPU, driver, and CUDA runtime compatible with the installed Warp/Newton packages.
- [`uv`](https://docs.astral.sh/uv/).

For a native source build, also install:

- CMake 3.20 or newer.
- A C++20 compiler.
- CUDA Toolkit and a compatible host compiler.
- Visual Studio/MSVC on Windows.

The examples require the optional `examples` dependency group. The locomotion
examples require the larger `locomotion` dependency group.

## Clone and initialize submodules

Clone the repository with its submodules:

```bash
git clone --recurse-submodules <repository-url>
cd pysynreal-solver
```

If the repository was cloned without submodules, initialize the required one explicitly:

```bash
# Native source build
git submodule update --init --recursive synreal-solver

# Prebuilt extension build
git submodule update --init synreal-solver-bin

# Initialize both
git submodule update --init --recursive
```

## Build and install

The recommended workflow uses `uv`. It creates `.venv`, resolves dependencies,
builds the native extension, and installs the package in editable mode.

### Automatic build selection

With the appropriate submodule initialized, let CMake select the available build mode:

```bash
uv sync --extra examples
```

### Use a prebuilt native extension

Use this mode when a matching binary is available in `synreal-solver-bin`:

```bash
uv sync --extra examples \
  --reinstall-package synreal-solver \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

On PowerShell, the same command can be written on one line:

```powershell
uv sync --extra examples --reinstall-package synreal-solver --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

### Build the native solver from source

This mode compiles the C++/CUDA submodule locally:

```bash
uv sync --extra examples \
  --reinstall-package synreal-solver \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=OFF"
```

Use the source mode whenever you change code in `synreal-solver/`. Re-run the
command after changing native code so the editable installation is rebuilt.

### Build a wheel

Build a distributable wheel into `dist/`:

```bash
uv build --wheel
```

To select a build mode explicitly:

```bash
# Build the native solver from source
uv build --wheel \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=OFF"

# Package a matching prebuilt extension
uv build --wheel \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

### Verify the installation

```bash
uv run python -c "import synreal_solver; print(synreal_solver.__file__)"
uv run python -c "import synreal_solver._core as core; print(core.__file__)"
```

The extension filename must match the active Python version, operating system,
and architecture. For example, a 64-bit CPython 3.12 Windows installation uses
a file similar to `_core.cp312-win_amd64.pyd`.

## Authentication

SynReal authentication is required before using authenticated native solver
features. `NewtonSolver` checks the current session when it is created. If the
session is not authenticated, it reads credentials from the environment or
prompts in the terminal.

### Environment variables

Set the credentials in the terminal that will run the example.

PowerShell:

```powershell
$env:SYNREAL_ID = "your-account"
$env:SYNREAL_PASSWORD = "your-password"
```

Bash or Zsh:

```bash
export SYNREAL_ID="your-account"
export SYNREAL_PASSWORD="your-password"
```

`SYNRAL_PASSWORD` is also accepted for compatibility with existing environments.
The variables are process-local; set them again in a new terminal session.

### Interactive login

If either credential is missing, `NewtonSolver` asks for the account and reads the password without echoing it:

```text
SynReal account: your-account
Password:
```

For applications that need to authenticate explicitly, use the public API:

```python
import getpass
import synreal_solver

account = input("SynReal account: ").strip()
password = getpass.getpass("Password: ")
if not synreal_solver.login(account, password, False):
    raise RuntimeError("SynReal login failed")
```

Avoid committing credentials to source files or shell scripts. Prefer a temporary
terminal environment or an external secret manager.

## Run examples

All commands below run inside the managed environment created by `uv`.

### Basic Newton scene

The basic-shapes example demonstrates the Newton adapter with SynReal:

```bash
uv run python examples/example_basic_shapes.py --solver synreal
```

### Particle and material examples

```bash
uv run python examples/example_particles.py
uv run python examples/example_fluid.py
uv run python examples/example_snow.py
uv run python examples/example_granular_beaf.py
```

The fluid example supports a headless regression run:

```bash
uv run python examples/example_fluid.py --viewer null --num-frames 180 --test
```

### Joint and rigid-body example

```bash
uv run python examples/example_rrabd_joints.py --login
```

Use `--viewer null --test` for a non-interactive run:

```bash
uv run python examples/example_rrabd_joints.py --login --viewer null --test --num-frames 300
```

### Locomotion examples

Install the optional dependencies first:

```bash
uv sync --extra locomotion
uv run --extra locomotion python -m examples.locomotion.validate --robot all
```

Training commands validate by default. Add `--run` to start training:

```bash
uv run --extra locomotion python -m examples.locomotion.train \
  --robot go2 --num-envs 2048 --run
```

## Python API

The Newton adapter uses a Newton model and state while the native SynReal solver owns the numerical solve:

```python
import newton
import synreal_solver

builder = synreal_solver.ModelBuilder(up_axis=newton.Axis.Z)
builder.add_ground_plane()
builder.add_particle(
    pos=(0.0, 0.0, 1.0),
    vel=(0.0, 0.0, 0.0),
    mass=1.0,
    radius=0.05,
)

model = builder.finalize(device="cuda:0")
solver = synreal_solver.NewtonSolver(model)
```

For lower-level native use, the package also exports `Model`, `State`, `Config`,
`Solver`, and `login`. See the type stubs in `src/synreal_solver/_core.pyi` for
the complete public native API.

## Tests and checks

Run the full Python test suite with:

```bash
uv run pytest -q
```

Many tests require a CUDA-capable device. Run the lightweight collection check on any machine:

```bash
uv run pytest --collect-only -q
```

Run the formatter and linter check with:

```bash
uv run ruff check src tests examples
```

## Troubleshooting

### The native extension cannot be found

Check that the matching submodule is initialized and rebuild the package:

```bash
git submodule update --init --recursive
uv sync --reinstall-package synreal-solver
```

If you are using prebuilt binaries, force prebuilt mode and verify that the binary matches the active Python ABI:

```bash
uv sync --reinstall-package synreal-solver \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

### CUDA or compiler errors during a source build

Confirm that `nvcc`, CMake, and the host compiler are on `PATH`, and that the
CUDA Toolkit supports the installed NVIDIA driver. On Windows, use a Visual
Studio toolchain supported by the installed CUDA version.

### Authentication fails

Confirm the account and password, check that both environment variables are set
in the current terminal, and retry with an interactive login. A failed `login()`
call returns `False`; `NewtonSolver` raises `RuntimeError` when automatic
authentication fails.

## License

See the repository and submodule license files for the applicable terms.
Third-party dependencies retain their respective licenses.
