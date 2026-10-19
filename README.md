<div align="center">
  <h1>Style3D Sim 2.0</h1>
  <p>CUDA-accelerated implicit simulation for particles, cloth, deformable bodies, and affine rigid bodies.</p>
  <p>
    <a href="docs/index.en.md">English Docs</a> &middot;
    <a href="docs/index.md">中文文档</a> &middot;
    <a href="#demo-showcase">Demos</a> &middot;
    <a href="#build-and-install">Build</a> &middot;
    <a href="#authentication">Login</a> &middot;
    <a href="#run-examples">Run examples</a> &middot;
    <a href="#python-api">Use the API</a>
  </p>
</div>

Style3D Sim provides a Python API and a Newton Physics adapter, so a Newton
model can use the native backend for contact handling, constraints, and nonlinear solves.
The `synreal-solver` native backend is closed source and available only to authorized
internal developers. This public repository contains the Python adapter, examples,
documentation, and integration code; it does not contain the native backend source.
The Python library and type stubs are open source under the [Apache License 2.0](LICENSE).
See [License](#license) for the separate terms covering native binaries and third-party components.

Read the [English usage documentation](docs/index.en.md) or [中文使用文档](docs/index.md)
for installation, authentication, simulation tutorials, and API references.

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
- Optional prebuilt extensions from the public `style3d-sim-bin` repository.
- Python and CMake build workflows.

## Requirements

For normal development and execution:

- Windows or Linux.
- Python 3.11 or newer.
- NVIDIA GPU, driver, and CUDA runtime compatible with the installed Warp/Newton packages.
- [`uv`](https://docs.astral.sh/uv/).

For the public prebuilt workflow, install:

- Git, to fetch the public binary submodule.

For native source development by authorized internal developers, also install:

- CMake 3.20 or newer.
- A C++20 compiler.
- CUDA Toolkit and a compatible host compiler.
- Visual Studio/MSVC on Windows.

The examples require the optional `examples` dependency group. The locomotion
examples require the larger `locomotion` dependency group.

## Clone and initialize the public components

Clone the public repository without recursively fetching the private native source:

```bash
git clone <repository-url> style3d-sim
cd style3d-sim
```

The public prebuilt extension is maintained in `style3d-sim-bin`:

```bash
git submodule update --init style3d-sim-bin
```

The `synreal-solver` submodule is closed source and requires internal access. External
users should not try to initialize it; use a matching prebuilt extension instead.

## Build and install

Use `uv` to create `.venv` and install dependencies, then CMake to install the native extension.
The current checkout has no Python build-backend declaration, so `uv sync` alone does not build `_core`.
See the [installation guide](docs/getting-started/installation.md) for complete Windows and Linux instructions.

### Install Python dependencies

```bash
uv sync --extra examples
```

### Use a prebuilt native extension

Use this mode when a matching binary is available in `style3d-sim-bin`:

```bash
cmake -S . -B build/prebuilt -DSYNREAL_SOLVER_USE_PREBUILT=ON -DCMAKE_BUILD_TYPE=Release \
  -DPython_EXECUTABLE="$PWD/.venv/bin/python"
cmake --install build/prebuilt --config Release --prefix "$PWD/src"
export PYTHONPATH="$PWD/src"
```

On PowerShell, select the Windows interpreter and set the source path:

```powershell
cmake -S . -B build/prebuilt -DSYNREAL_SOLVER_USE_PREBUILT=ON -DPython_EXECUTABLE="$PWD/.venv/Scripts/python.exe"
cmake --install build/prebuilt --config Release --prefix "$PWD/src"
$env:PYTHONPATH = "$PWD/src"
```

### Build the native solver from source (internal developers only)

This mode compiles the closed-source C++/CUDA `synreal-solver` submodule locally and
requires authorized internal access. It is unavailable to external contributors:

```bash
git submodule update --init --recursive synreal-solver
cmake -S . -B build/native -DSYNREAL_SOLVER_USE_PREBUILT=OFF -DCMAKE_BUILD_TYPE=Release \
  -DPython_EXECUTABLE="$PWD/.venv/bin/python"
cmake --build build/native --config Release --parallel
cmake --install build/native --config Release --prefix "$PWD/src"
export PYTHONPATH="$PWD/src"
```

Use source mode only when an authorized internal checkout includes `synreal-solver/`.
Both build modes install `_core` into `src/style3d_sim/` when the install prefix is `src`.
Re-run the build and install commands after native changes.
For Windows, use the interpreter and environment variable syntax shown above with `build/native` and prebuilt mode `OFF`.

### Build a wheel

Wheel builds require a Python build backend in `pyproject.toml` in addition to the existing CMake configuration.
The current checkout does not declare one; use the CMake workflow above for local development.

### Verify the installation

```bash
uv run python -c "import style3d_sim as s3d; print(s3d.__file__)"
uv run python -c "import style3d_sim._core as core; print(core.__file__)"
```

The extension filename must match the active Python version, operating system,
and architecture. For example, a 64-bit CPython 3.12 Windows installation uses
a file similar to `_core.cp312-win_amd64.pyd`.

## Authentication

Style3D Sim authentication is required before using authenticated native solver
features. `NewtonSolver` checks the current session when it is created. If the
session is not authenticated, it reads credentials from the environment or
prompts in the terminal.

### Environment variables

Set the credentials in the terminal that will run the example.

PowerShell:

```powershell
$env:STYLE3D_SIM_ACCOUNT = "your-account"
$env:STYLE3D_SIM_PASSWORD = "your-password"
```

Bash or Zsh:

```bash
export STYLE3D_SIM_ACCOUNT="your-account"
export STYLE3D_SIM_PASSWORD="your-password"
```

The variables are process-local; set them again in a new terminal session.

### Interactive login

If either credential is missing, `NewtonSolver` asks for the account and reads the password without echoing it:

```text
Style3D Sim account: your-account
Password:
```

For applications that need to authenticate explicitly, use the public API:

```python
import getpass
import style3d_sim as s3d

account = input("Style3D Sim account: ").strip()
password = getpass.getpass("Password: ")
if not s3d.login(account, password, False):
    raise RuntimeError("Style3D Sim login failed")
```

Avoid committing credentials to source files or shell scripts. Prefer a temporary
terminal environment or an external secret manager.

## Run examples

All commands below run inside the managed environment created by `uv`.

### Example assets

`s3d.get_asset("joints/ball/ball.urdf")` returns a path in the Style3D Sim asset repository.
The first call clones `https://github.com/Style3D/style3d-sim-assets.git` into
`~/.cache/style3d_sim/assets`; later calls reuse it. If a requested file is missing,
`get_asset()` attempts one fast-forward update before reporting a missing asset.
Git and network access are required. The repository root should contain the
asset groups directly, such as `joints/` and `piper/`.

For a local checkout, set `STYLE3D_SIM_ASSETS_DIR` to its root. For example, in PowerShell:

```powershell
$env:STYLE3D_SIM_ASSETS_DIR = "D:\path\to\style3d-sim-assets"
```

`s3d.get_assets()` returns the asset root. Neither function is called when the
Python package is imported.

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
import style3d_sim as s3d

builder = s3d.ModelBuilder(up_axis=newton.Axis.Z)
builder.add_ground_plane()
builder.add_particle(
    pos=(0.0, 0.0, 1.0),
    vel=(0.0, 0.0, 0.0),
    mass=1.0,
    radius=0.05,
)

model = builder.finalize(device="cuda:0")
solver = s3d.NewtonSolver(model)
```

For lower-level native use, the package also exports `Model`, `State`, `Config`,
`Solver`, and `login`. See the type stubs in `src/style3d_sim/_core.pyi` for
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

For public users, check that the matching `style3d-sim-bin` submodule is initialized
and rebuild the package:

```bash
git submodule update --init style3d-sim-bin
cmake --build build/prebuilt --config Release --parallel
cmake --install build/prebuilt --config Release --prefix src
```

Internal developers with source access can initialize `synreal-solver` and use the
native source workflow above.

If you are using prebuilt binaries, force prebuilt mode and verify that the binary matches the active Python ABI:

```bash
cmake --install build/prebuilt --config Release --prefix src
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

The Python source files (`.py`) and public type stubs (`.pyi`) under `src/style3d_sim/`
are licensed under the [Apache License 2.0](LICENSE). Preserve the applicable copyright,
license, and attribution notices when redistributing these files or modified versions.

The native `synreal-solver` implementation is closed source, and its source is available
only to authorized internal developers. The Apache-2.0 license for the Python API and
type stubs does not grant access to or license the native implementation.

Prebuilt native extensions (`.pyd` and `.so`), including copies installed alongside the
Python package, are governed by the
[Style3D Sim Binary License Agreement](style3d-sim-bin/LICENSE).
Their use requires an applicable account entitlement or written agreement;
redistribution requires prior written permission from the licensor.

Third-party code, dependencies, and assets retain their respective licenses and notices.
