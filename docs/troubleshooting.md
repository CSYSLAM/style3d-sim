# 常见问题

## 无法导入 `_core`

典型错误：`ModuleNotFoundError: No module named 'style3d_sim._core'`。

1. 完成 [安装](getting-started/installation.md) 的 CMake 安装，而不只是 `uv sync`。
2. 确认扩展安装在 `src/style3d_sim/`，与 Python package 在一起。
3. 检查扩展 Python ABI 是否匹配 `.venv`；不能用 CPython 3.11 的文件运行在 3.12 上。
4. 当前终端设置 `PYTHONPATH` 指向仓库 `src`。

```bash
uv run python -c "import sys, sysconfig; print(sys.executable); print(sysconfig.get_config_var('EXT_SUFFIX'))"
```

若错误是 Windows `DLL load failed` 或 Linux 缺少共享库，检查二进制运行时依赖、驱动和 CUDA 版本，
不要把导入问题一律当成 Python 路径错误。

## 导入了旧版本

```bash
uv run python -c "import style3d_sim as s3d; print(s3d.__file__)"
uv run python -c "import style3d_sim._core as core; print(core.__file__)"
```

如果指向系统 site-packages，使用 `uv run` 的环境并重新设置源码路径。
Python wrapper 已更新但 `_core` 仍是旧构建时，也可能出现缺少属性或枚举的错误；更新两个组件的匹配版本。

## 子模块初始化失败

当前子模块地址是内网 SSH 仓库，访问它需要相应网络与账号权限。
先确认能访问主机并拥有 SSH 权限；外部发布需要维护者提供公开地址或二进制渠道。
克隆根仓库成功不意味着有原生子模块权限。

## CMake 找不到 pybind11 / Python / CUDA

`uv sync` 安装 dev 依赖后，将 `Python_EXECUTABLE` 指向 `.venv` 的 Python。
源码模式确认 `nvcc --version`、host compiler 和 CMake 可用，Windows 使用兼容的开发者终端。
更改工具链后用新 build 目录重新 configure，避免旧缓存。

## 登录失败或一直等待输入 {#authentication}

1. 检查当前运行进程能够访问认证服务，账号与密码有效。
2. 确认 `STYLE3D_SIM_ACCOUNT` 和 `STYLE3D_SIM_PASSWORD` 在启动进程前设置。
3. 检查变量名是否拼写正确，以及当前进程是否继承了这两个变量。
4. headless 不等于无交互认证；缺少凭据时仍会请求 stdin。
5. 用同一进程内的 `is_logged_in()` 检查状态，不要依赖另一个 Python 进程的登录。

认证失败不应通过空密码或无限重试掩盖；保留不含敏感信息的异常日志排查。

## “requires a Newton model allocated on a CUDA device”

```python
model = builder.finalize(device="cuda:0")
```

先确认 `warp.is_cuda_available()` 为 `True`。
使用 CPU finalize 后不能只把 config 改成 CUDA；模型和状态数组需要在正确设备上重新创建。

## 布料提示不支持 generic surface elasticity

普通 Newton 三角弹性不是 SynReal 的布料材料入口。
创建 builder 后先注册 Style3D 属性，再用 `style3d.add_cloth_grid()` 或 `add_cloth_mesh()`。
参见 [布料教程](guides/deformables.md)。

## state 粒子计数不匹配

solver 初始化可能追加刚体代理粒子。将 `model.state()`、viewer 和依赖粒子计数的 buffer 创建移到 solver 之后。
材质选择与表面重建只用实际物理粒子，不包括代理。

## 穿透、抖动、NaN 或显存不足

| 现象 | 优先检查 |
| --- | --- |
| 刚体穿过地面 | 是否存在 shape、每步是否更新 contacts、是否传给 step |
| 布料穿透 | soft contact、自碰撞厚度、初始穿透和 dt |
| 果冻/流体塌陷 | 质量标定、尺度、材料单位与非线性迭代预算 |
| NaN | 非有限输入、退化网格、非正质量/半径、过大变形 |
| 切换配置后 graph 不变 | 修改配置后重新捕获 graph |
| 表面重建很慢 | 增大 voxel、降低重建频率，避免每物理子步重建 |
| 显存不足 | 降低粒子/环境数、表面分辨率和接触 capacity；测量实际峰值 |

先缩小场景、关闭 graph 和渲染；参见 [参数与性能](guides/configuration.md) 的顺序。
没有足够迭代预算时，单纯提高刚度未必减少物理误差。
