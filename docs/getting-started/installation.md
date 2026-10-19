# 安装与构建

公开用户请安装匹配的预编译扩展。`synreal-solver` 原生后端是闭源的，源码构建仅限获授权的内部开发人员。

## 1. 准备工具

| 工具 | 用途 | 要求 |
| --- | --- | --- |
| Git | 下载公开仓库与二进制子模块 | 能访问公开仓库和 `style3d-sim-bin` |
| Python | 执行 Python API | 项目要求 3.11+；`.python-version` 当前选择 3.12 |
| uv | 管理 `.venv` 和依赖 | [安装说明](https://docs.astral.sh/uv/getting-started/installation/) |
| NVIDIA 驱动 | 运行 CUDA | 与 GPU、Warp 和扩展使用的 CUDA 版本兼容 |
| CMake | 配置或安装原生扩展 | 3.20+ |
| CUDA Toolkit | 仅供内部源码开发 | 只有获授权的 `synreal-solver` 开发需要 |
| C++ 编译器 | 仅供内部源码开发 | 只有获授权的原生开发需要 |

```bash
git --version
uv --version
cmake --version
nvidia-smi
```

获授权的内部源码构建还需要检查 `nvcc --version`。`nvidia-smi` 显示的 CUDA 版本是驱动支持上限，不是本机 Toolkit 版本。
内部 Windows 构建建议从 Visual Studio 的 **Developer PowerShell** 启动；内部 Linux 构建使用 CUDA 支持的 GCC/Clang。

## 2. 下载仓库

```bash
git clone <repository-url> style3d-sim
cd style3d-sim
```

将 `<repository-url>` 替换为仓库 Clone 地址。已经有工作副本时无需重复 clone。

!!! note "公开组件与闭源组件"
    `style3d-sim-bin` 是外部用户使用的公开预编译扩展仓库。
    `synreal-solver` 是闭源原生后端，仅向获授权的内部开发人员开放。
    克隆公开根仓库不会自动获得源码权限。文档 CI 不初始化任何子模块。

## 3. 创建 Python 环境

```bash
uv sync --extra examples
uv run python --version
```

`examples` 是可选依赖 extra，包含 viewer 和示例需要的依赖。
只使用基础 API 时可以用 `uv sync`。训练相关依赖见 [示例](../guides/demos.md)。

!!! important "当前 checkout 的构建方式"
    当前 `pyproject.toml` 没有 `[build-system]` 声明，uv 将根项目视为 virtual project。
    因而 `uv sync` 安装依赖，但不会自动编译或安装根项目的 `_core`。
    下文使用 CMake 显式安装扩展和 `PYTHONPATH` 加载 Python 源码。
    只有在维护者补齐打包后端后，才能改为依赖 `uv sync` 的 editable 构建或 `uv build --wheel`。

## 4A. 使用预编译扩展（公开用户流程）

不需要修改原生代码时使用此路径。二进制必须匹配操作系统、CPU 架构、Python ABI 和运行环境。

```bash
git submodule update --init style3d-sim-bin
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

预编译安装路径由子模块 CMake 决定，当前为：

```text
style3d-sim-bin/<system>/<config>/style3d_sim/_core<EXT_SUFFIX>
```

例如 Windows、Release、CPython 3.12 的扩展通常为 `_core.cp312-win_amd64.pyd`。
如果不存在匹配的二进制，请换用公开子模块提供的 Python 版本或联系内部发布负责人。外部用户不能从 `synreal-solver` 源码构建。

## 4B. 从源代码编译（仅限获授权的内部开发人员）

这条路径需要闭源 `synreal-solver` 子模块权限、CUDA Toolkit 和 C++20 编译器，外部贡献者无法使用。

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

`Python_EXECUTABLE` 保证扩展使用 `.venv` 的 Python ABI；`uv sync` 的 dev 依赖提供 pybind11。
`--prefix .../src` 使 CMake 将扩展装到 `src/style3d_sim/`，与 Python 包文件放在一起。
这些构建产物不应提交到 Git。

!!! tip "不要复用不同模式的 CMake 缓存"
    预编译与源码模式分别使用 `build/prebuilt`、`build/native`。
    切换 Python 版本或编译器时使用新的 build 目录，避免旧缓存指向错误工具链。

## 5. 验证加载的是本次构建

```bash
uv run python -c "import style3d_sim as s3d; print(s3d.__file__)"
uv run python -c "import style3d_sim._core as core; print(core.__file__)"
uv run python -c "import warp as wp; wp.init(); print(wp.is_cuda_available())"
```

前两个路径应指向当前仓库的 `src/style3d_sim/`，CUDA 检查应打印 `True`。
仅能导入库不代表完成账号认证，下一步是 [登录](authentication.md)。

## 6. 修改源码后的更新

- Python 文件：使用上述源码路径时直接生效，无需重新编译扩展。
- 公开用户通过新的 `style3d-sim-bin` 版本获取原生更新。
- 获授权的内部开发人员修改 C++/CUDA 后，可以重新执行 `cmake --build` 和 `cmake --install`。
- 新建终端：重新设置 `PYTHONPATH` 和需要的登录环境变量。

如果换了 Python 版本，要使用匹配版本重新安装扩展，不能直接复制另一个 ABI 的 `.pyd` 或 `.so`。
