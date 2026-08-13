# synreal-solver Python 包

本仓库将 `synreal_solver` Python API 与原生 `_core` 扩展打包在一起。原生扩展支持两种来源：

- 从 `synreal-solver/` 子模块中的 C++/CUDA 源码编译；
- 从 `synreal-solver-bin/` 子模块安装预编译文件。

## 环境要求

运行环境：

- Python 3.11 或更高版本；
- `uv`；
- NVIDIA GPU，以及与扩展所用 CUDA 版本兼容的驱动。

从源码编译还需要：

- CMake 3.20 或更高版本；
- C++20 编译器；
- CUDA Toolkit；
- CUDA 支持的 host compiler。Windows 上应使用与 CUDA Toolkit 兼容的 Visual Studio/MSVC。

当前 `synreal-solver-bin` 提供 CPython 3.11 和 3.12 的 Windows/Linux Release 产物。预编译扩展必须与操作系统、CPU 架构和 Python ABI 完全匹配。例如，64 位 Windows 上的 CPython 3.12 需要：

```text
_core.cp312-win_amd64.pyd
```

## 构建模式

顶层 CMake 选项 `SYNREAL_SOLVER_USE_PREBUILT` 控制原生扩展的来源：

| 选项值 | 行为 |
| --- | --- |
| `OFF` | 从 `synreal-solver/` 编译。 |
| `ON` | 从 `synreal-solver-bin/` 安装匹配的预编译扩展。 |

未显式指定该选项时，CMake 自动选择：

- 存在 `synreal-solver/CMakeLists.txt`：使用源码模式；
- 不存在：使用预编译模式。

当两个子模块都已初始化时，可以通过该选项强制选择其中一条路径。

## 初始化子模块

源码模式：

```console
git submodule update --init --recursive synreal-solver
```

预编译模式：

```console
git submodule update --init synreal-solver-bin
```

同时初始化两个子模块：

```console
git submodule update --init --recursive
```

## 开发环境安装

`uv sync` 会创建或更新 `.venv`、同步依赖，并以 editable 模式安装当前项目。editable 安装仍会通过 scikit-build-core 执行 CMake configure、build 和 install。

使用自动选择：

```console
uv sync
```

强制从源码构建：

```console
uv sync --reinstall-package synreal-solver \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=OFF"
```

强制使用预编译扩展：

```console
uv sync --reinstall-package synreal-solver \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

PowerShell 可以写成单行：

```powershell
uv sync --reinstall-package synreal-solver --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

切换构建模式或修改 C++/CUDA 源码后，应使用 `--reinstall-package synreal-solver`，确保 `uv` 重新调用构建后端。修改 `src/synreal_solver/` 中的 Python 文件通常不需要重新安装。

验证安装位置：

```console
uv run python -c "import synreal_solver; print(synreal_solver.__file__)"
uv run python -c "import synreal_solver._core as core; print(core.__file__)"
```

## 构建 Wheel

使用自动选择：

```console
uv build --wheel
```

强制构建源码 wheel：

```console
uv build --wheel \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=OFF"
```

强制使用预编译扩展构建 wheel：

```console
uv build --wheel \
  --config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

wheel 默认生成到 `dist/`。文件名中的 Python ABI 和平台标签应与扩展一致，例如：

```text
synreal_solver-0.1.0-cp312-cp312-win_amd64.whl
```

wheel 内的包结构如下：

```text
synreal_solver/
|-- __init__.py
|-- _core.cp312-win_amd64.pyd
|-- _core.pyi
|-- newton_model_builder.py
`-- newton_solver.py
```

Linux 上的原生扩展使用对应 Python ABI 的 `.so` 文件名。

## 手动使用 CMake

通常应通过 `uv` 和 scikit-build-core 构建 Python 包。需要单独调试 CMake 时，可以使用以下流程。

### 源码模式

```console
cmake -S . -B build -DSYNREAL_SOLVER_USE_PREBUILT=OFF
cmake --build build --config Release
cmake --install build --config Release --prefix dist/install
```

该流程编译 C++/CUDA 库和 Python binding，然后将扩展安装到：

```text
dist/install/synreal_solver/
```

### 预编译模式

```console
cmake -S . -B build -DSYNREAL_SOLVER_USE_PREBUILT=ON
cmake --install build --config Release --prefix dist/install
```

预编译模式不会编译 solver。CMake 会读取所选 Python 解释器的 `EXT_SUFFIX`，只选择一个 ABI 匹配的扩展，并安装到 `synreal_solver/`。

预编译文件布局：

```text
synreal-solver-bin/
|-- Windows/Release/_core.cp311-win_amd64.pyd
|-- Windows/Release/_core.cp312-win_amd64.pyd
|-- Linux/Release/_core.cpython-311-x86_64-linux-gnu.so
`-- Linux/Release/_core.cpython-312-x86_64-linux-gnu.so
```

手动指定 Python 解释器：

```console
cmake -S . -B build \
  -DSYNREAL_SOLVER_USE_PREBUILT=ON \
  -DPython_EXECUTABLE=/path/to/python
```

使用 Ninja 等单配置生成器时，需要在 configure 阶段指定配置：

```console
cmake -S . -B build \
  -DSYNREAL_SOLVER_USE_PREBUILT=ON \
  -DCMAKE_BUILD_TYPE=Release
cmake --install build --prefix dist/install
```

当前 bin 仓库只有 `Release` 产物。使用 `--config Debug` 时，必须在 `Windows/Debug` 或 `Linux/Debug` 中提供对应文件。

## 常见问题

### 找不到匹配的扩展

CMake 配置日志会输出实际选择的完整路径。检查：

- 对应子模块是否已初始化；
- 操作系统目录是否与 `CMAKE_SYSTEM_NAME` 一致；
- Release/Debug 配置是否存在；
- 当前 Python 解释器是否有对应 ABI 的产物。

### 已有源码子模块，但希望使用 bin

源码子模块存在时默认走源码模式。显式传入：

```console
--config-setting "cmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON"
```

### 修改原生源码后没有重新编译

重新安装 editable 项目：

```console
uv sync --reinstall-package synreal-solver
```
