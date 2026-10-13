# Installation and Build

Run all commands on this page from the repository root. Prepare the Python environment,
then choose a source for the native extension.

## 1. Prepare the Tools

| Tool | Purpose | Requirement |
| --- | --- | --- |
| Git | Fetch the repository and submodules | Access to the repository and required submodules |
| Python | Run the Python API | 3.11+; `.python-version` currently selects 3.12 |
| uv | Manage `.venv` and dependencies | [Install uv](https://docs.astral.sh/uv/getting-started/installation/) |
| NVIDIA driver | Run CUDA | Compatible with the GPU and CUDA versions used by Warp and the extension |
| CMake | Configure or install the extension | 3.20+ |
| CUDA Toolkit | Compile native source | Compatible host compiler; prebuilt mode does not require `nvcc` |
| C++ compiler | Compile native source | C++20; compatible Visual Studio/MSVC on Windows |

```bash
git --version
uv --version
cmake --version
nvidia-smi
```

For source builds, also check `nvcc --version`. The CUDA version reported by `nvidia-smi`
is the maximum supported by the driver, rather than the installed Toolkit version.
On Windows, use Visual Studio **Developer PowerShell**; on Linux, use a CUDA-supported GCC/Clang toolchain.

## 2. Clone the Repository

```bash
git clone <repository-url> pysynreal-solver
cd pysynreal-solver
```

Replace `<repository-url>` with the repository's clone URL. Skip this step if you already have a working copy.

!!! note "Native submodule access"
    The current `.gitmodules` uses private LAN SSH URLs such as `git@192.168.31.9:...`.
    Initializing these submodules requires the corresponding network and SSH access.
    Public GitHub runners cannot directly reach these addresses. For external distribution,
    maintainers must provide accessible submodule URLs or matching binaries.
    Documentation CI does not initialize submodules.

## 3. Create the Python Environment

```bash
uv sync --extra examples
uv run python --version
```

The optional `examples` extra includes viewer and example dependencies.
Use `uv sync` for the base API only. See [Demos](../guides/demos.en.md) for training dependencies.

!!! important "Build procedure for the current checkout"
    `pyproject.toml` currently has no `[build-system]` declaration; uv treats the root as a virtual project.
    `uv sync` installs dependencies but does not compile or install the root project's `_core` extension.
    The steps below explicitly install it with CMake and load the Python source through `PYTHONPATH`.
    Editable builds through `uv sync` or wheels through `uv build --wheel` require a packaging backend first.

## 4A. Install a Prebuilt Extension

Choose this route if you do not need to modify native code. The binary must match your operating system,
CPU architecture, Python ABI, and runtime environment.

```bash
git submodule update --init synreal-solver-bin
```

=== "Windows PowerShell"

    ```powershell
    cmake -S . -B build/prebuilt -DSYNREAL_SOLVER_USE_PREBUILT=ON -DPython_EXECUTABLE="$PWD/.venv/Scripts/python.exe"
    cmake --install build/prebuilt --config Release --prefix "$PWD/src"
    $env:PYTHONPATH = "$PWD/src"
    ```

=== "Linux Bash"

    ```bash
    cmake -S . -B build/prebuilt -DSYNREAL_SOLVER_USE_PREBUILT=ON -DCMAKE_BUILD_TYPE=Release \
      -DPython_EXECUTABLE="$PWD/.venv/bin/python"
    cmake --install build/prebuilt --config Release --prefix "$PWD/src"
    export PYTHONPATH="$PWD/src"
    ```

The submodule's CMake configuration determines the binary location. Its current layout is:

```text
synreal-solver-bin/<system>/<config>/synreal_solver/_core<EXT_SUFFIX>
```

For example, Windows Release with CPython 3.12 commonly uses `_core.cp312-win_amd64.pyd`.
If no matching binary exists, select a Python version provided by the submodule or build from source.

## 4B. Build from Source

This route requires access to the source submodule, the CUDA Toolkit, and a C++20 compiler.

```bash
git submodule update --init --recursive synreal-solver
```

=== "Windows PowerShell"

    ```powershell
    cmake -S . -B build/native -DSYNREAL_SOLVER_USE_PREBUILT=OFF -DPython_EXECUTABLE="$PWD/.venv/Scripts/python.exe"
    cmake --build build/native --config Release --parallel
    cmake --install build/native --config Release --prefix "$PWD/src"
    $env:PYTHONPATH = "$PWD/src"
    ```

=== "Linux Bash"

    ```bash
    cmake -S . -B build/native -DSYNREAL_SOLVER_USE_PREBUILT=OFF -DCMAKE_BUILD_TYPE=Release \
      -DPython_EXECUTABLE="$PWD/.venv/bin/python"
    cmake --build build/native --config Release --parallel
    cmake --install build/native --config Release --prefix "$PWD/src"
    export PYTHONPATH="$PWD/src"
    ```

`Python_EXECUTABLE` selects the `.venv` Python ABI; the development dependencies installed by `uv sync` provide pybind11.
`--prefix .../src` installs the extension into `src/synreal_solver/`, alongside the Python package.
Keep build artifacts out of Git.

!!! tip "Use separate CMake caches"
    Use `build/prebuilt` and `build/native` for their respective modes.
    When changing Python versions or compilers, configure a new build directory to avoid stale toolchain settings.

## 5. Verify the Loaded Build

```bash
uv run python -c "import synreal_solver as sr; print(sr.__file__)"
uv run python -c "import synreal_solver._core as core; print(core.__file__)"
uv run python -c "import warp as wp; wp.init(); print(wp.is_cuda_available())"
```

The first two paths should point into this checkout's `src/synreal_solver/`; the CUDA check should print `True`.
Importing the library does not authenticate the session. Continue with [Authentication](authentication.en.md).

## 6. Update after Source Changes

- Python changes take effect directly when using the source path above.
- For C++/CUDA changes, repeat `cmake --build` and `cmake --install`.
- For dependency changes, repeat `uv sync --extra examples`.
- In a new terminal, set `PYTHONPATH` and the required login variables again.

After changing Python versions, reinstall a matching extension. A `.pyd` or `.so` built for another ABI cannot be reused.
