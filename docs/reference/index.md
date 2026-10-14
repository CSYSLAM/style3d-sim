# API 索引与接口选择

初次使用推荐 `NewtonSolver`，它完成模型转换、状态验证、stream 传递和刚体代理处理。
仅在需要自己管理 CUDA 数组与模型视图时使用底层 `Solver`。

## 常用入口

| 接口 | 用途 | 参考 |
| --- | --- | --- |
| `ModelBuilder` | Newton builder 扩展、刚体代理和额外约束 | [Python API](python.md#modelbuilder) |
| `NewtonSolver` | 接受 Newton 模型与状态的适配求解器 | [Python API](python.md#newtonsolver) |
| `configure_fluid` | 选择粒子与配置流体材料 | [材料教程](../guides/particles.md) |
| `configure_granular` | 选择颗粒、黏结、塑性、断裂和 adhesion | [材料教程](../guides/particles.md) |
| `ParticleSurface` | 从 CUDA 粒子生成动态三角网格 | [Python API](python.md#particlesurface) |
| `log_surface_mesh` | 将动态拓扑网格写给 Newton viewer | [Python API](python.md) |
| `login` / `is_logged_in` | 原生会话认证 | [账号登录](../getting-started/authentication.md) |
| `set_log_callback` | 注册原生日志回调 | [原生 API](native.md) |
| `Model` / `State` / `Span` / `Solver` | CUDA 内存视图与底层推进 | [原生 API](native.md) |

## NewtonSolver 构造参数

| 参数 | 默认值 | 含义 |
| --- | --- | --- |
| `model` | 必填 | 在 CUDA 上分配的 Newton model |
| `joint_damping` | 100.0 | 生成 point-line 约束的法向阻尼；非负且有限 |
| `joint_attachment_distance` | 0.1 | 关节方向约束锚点间隔；正且有限 |
| `joint_line_half_length` | 10.0 | 生成导轨线段的半长；正且有限 |
| `joint_drive_armature` | 0.0 | 驱动 body 的可选各向同性惯量正则；非负且有限 |

`joint_drive_armature` 与 Newton 的 `model.joint_armature` 不是同一个参数。
前者调整 body 惯量，后者给支持的相对关节自由度增加惯量。
这些不是一般材质参数，优先保留默认值并按关节示例调整。

## step 的五个参数

```text
solver.step(state_in, state_out, control, contacts, dt)
```

| 参数 | 要求 |
| --- | --- |
| `state_in` | Newton state，数组与模型的计数、dtype、设备一致 |
| `state_out` | 独立输出 state，结构同输入 |
| `control` | 驱动关节需要 Newton control，无驱动时可为 `None` |
| `contacts` | 最新接触数据，无 shape 接触时可为 `None` |
| `dt` | 秒，有限且大于 0 |

原生 `Solver.step()` 的重载与 Newton 适配器不同，不要混用参数顺序。
完整生命周期见 [仿真循环](../guides/simulation-loop.md)。

## 底层原生 API 示例 {#native-api}

### 先理解 Span

`Span(ptr=array.ptr, size=array.size)` 保存连续 CUDA 内存地址和**元素数**，size 不是字节数。
Span 不分配、不释放内存，也不会替你维持 Warp array 的 Python 引用。
保留 indices、masses、gravity、位置和速度的所有原始数组，直到 GPU 完成对应工作。

不要传 `numpy.ndarray.ctypes.data`：它是 CPU 地址。
非连续 view、dtype 不匹配、另一设备上的指针和被释放的数组也不能交给原生求解器。
一个非零 size 必须有非空地址。

### 完整可下载示例

这个示例使用零重力、常速度、无接触的两个粒子，专门展示数组所有权与原生 step。
直接 `Solver` 不自动读环境变量；脚本在同一进程中交互登录。

```bash
uv run python docs/samples/native_particles.py
```

[下载脚本](../samples/native_particles.py)

```python
--8<-- "docs/samples/native_particles.py"
```

有接触或 joint control 时应使用相应原生 overload，并自行填好 `Contact`、`Control` 和模型相关 Span。
初学者直接用 `NewtonSolver` 可以避免这些字段映射。

## 日志回调

在创建 solver 之前注册应用自己的回调：

```python
import style3d_sim as s3d

def log_message(file_name, function_name, line, level, message):
    print(f"[{level}] {function_name}:{line} {message}")

s3d.set_log_callback(log_message)
```

回调会收到文件名、函数名、行号、级别和消息。
不要在高频回调中执行昂贵的 GPU 拷贝，或向日志输出账号密码。

## 参考页如何更新

文档构建从 `.py` 与 `_core.pyi` 静态提取公开签名、属性和 docstring。
Python 签名变更会自动反映在页面上；原生接口变更后，维护者先用匹配的扩展更新 stubs：

```bash
uv run poe stubs
```

API 参考不会加载 `_core`。原生实现新增但 `.pyi` 未更新时，网页不可能凭空知道新签名。
