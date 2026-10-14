# 粒子流体与颗粒材料

先在 Newton builder 中创建粒子；finalize 后选择物理粒子 ID；配置材料后再创建 `NewtonSolver`。
材料函数不会自动生成粒子，也不会替你调整粒子质量、速度或接触半径。

## 粒子 ID 与选择范围

用非空的一维整数数组指定粒子，ID 必须唯一且落在 `model.particle_count` 范围内。
流体与颗粒选择不能重叠。含刚体的场景还有仿射代理粒子，它们不是物理水滴或颗粒。
不要把 solver 追加的代理 ID 放进材质选择或表面重建选择。

## 流体：完整模型初始化

下面初始化一小块流体；之后沿用 [仿真循环](simulation-loop.md) 创建 state 和接触并推进。

```python
import numpy as np
import newton
import style3d_sim as s3d

spacing = 0.04
grid = np.stack(np.meshgrid(np.arange(6), np.arange(6), np.arange(6), indexing="ij"), axis=-1)
points = grid.reshape(-1, 3).astype(np.float32) * spacing
points[:, 2] += 0.3
count = len(points)
builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
builder.add_ground_plane()
builder.add_particles(
    pos=points,
    vel=np.zeros_like(points),
    mass=np.full(count, 1000.0 * spacing**3),
    radius=np.full(count, 0.45 * spacing),
)
model = builder.finalize(device="cuda:0")
s3d.configure_fluid(
    model,
    np.arange(count, dtype=np.int32),
    smoothing_radius=2.0 * spacing,
    rest_density=1000.0,
    bulk_modulus=2.0e5,
    viscosity=0.01,
)
solver = s3d.NewtonSolver(model)
solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
solver.config.nonlinear_iterations = 4
solver.config.linear_iterations = 80
```

这是教学初始化，不包含完整水箱、边界密度标定或表面渲染。
`mass = density * spacing**3` 是体素体积估计；项目的水箱示例使用离散核校准体积以改善密度基线。

### 流体参数

| 参数 | 默认值 | 单位与作用 |
| --- | --- | --- |
| `smoothing_radius` | 必填 | m，邻域核的支持半径，必须正且有限 |
| `rest_density` | 1000 | kg/m³，目标密度，必须正且有限 |
| `bulk_modulus` | 200000 | Pa，密度压力刚度，非负 |
| `viscosity` | 0 | Pa·s，动力黏度，非负 |
| `boundary_positions` | `None` | 固定边界采样位置，形状 `(N, 3)` |
| `boundary_volumes` | `None` | 每个边界采样点的体积，形状 `(N,)`，必须正 |

边界位置与体积必须同时提供。它们只是世界坐标下的静态密度采样，**不会代替墙体碰撞 shape**，
也不会自动跟随移动刚体或布料。
多 world 的流体邻域隔离；固定边界采样表示共享的世界坐标几何。

从已有水箱例子开始试验：

```bash
uv run python examples/example_fluid.py --resolution 16
uv run python examples/example_fluid.py --resolution 16 --viewer null --num-frames 120 --test
```

提高 resolution 会增加粒子数量和计算量，不只是提高渲染分辨率。

## 颗粒：由接触到黏结、塑性与断裂

同样先创建粒子并 finalize。下面片段替换上面流体初始化中 `configure_fluid()` 那一段，
不要对同一粒子同时配置两种材料：

```python
s3d.configure_granular(
    model,
    np.arange(count, dtype=np.int32),
    contact_stiffness=2000.0,
    friction=0.5,
    cohesion=200.0,
    bond_damping=10.0,
    yield_strain=0.03,
    break_strain=0.1,
)
solver = s3d.NewtonSolver(model)
```

| 参数 | 默认值 | 作用 |
| --- | --- | --- |
| `contact_stiffness` | 2000 N/m | 颗粒法向接触刚度，必须大于 0 |
| `friction` | 0.5 | Coulomb 摩擦系数 |
| `friction_damping` | 20 N·s/m | 低速摩擦正则化 |
| `cohesion` | 200 N/m | 初始黏结刚度；0 禁用初始黏结 |
| `bond_damping` | 0 N·s/m | 沿黏结轴方向的阻尼，断裂后停止作用 |
| `yield_strain` | 0.03 | 压缩屈服阈值，范围 `[0, 1)` |
| `max_compaction` | 0.4 | 永久压缩上限，范围 `[0, 1)` |
| `break_strain` | 0.1 | 拉伸断裂阈值，非负 |
| `bond_radius` | `None` | 初始黏结搜索半径，缺省为最大所选半径的 2.5 倍 |
| `bond_indices` | `None` | 显式 `(N, 2)` 粒子 ID 对；不能和 `bond_radius` 同时设置 |
| `adhesion` | 0 N/m | 新接触形成黏结的刚度，0 禁用 |
| `bond_formation_gap` | 0 m | 接触形成黏结允许的间隙 |
| `bond_formation_speed` | 1 m/s | 允许形成接触黏结的最大相对速度 |
| `max_dynamic_bonds` | 12 | 每个较小 ID 颗粒拥有的动态黏结槽，整数 `[1, 64]` |

所有标量需有限且满足非负条件；质量、半径必须为正，所选颗粒必须 active。
显式黏结不能连接相同粒子、重复粒子对或跨 world 的粒子。

颗粒之间的专用接触路径即使 `enable_self_collision=False` 也存在。
若要与其他粒子/布料进行自碰撞，再单独启用相应自碰撞路径。
颗粒与 shape 的接触仍由常规碰撞流水线与 shape/soft-contact 材料控制。

### 重置历史

初始 authored 黏结断裂后不会愈合；动态接触黏结可以在分离后再次接触时重建。
塑性与断裂历史属于 solver，不属于单纯的位置数组。
要完全重置材质历史，重建 solver；只恢复位置与速度会保留原来的断裂与塑性状态。

这是一种粗粒度模型，不含颗粒旋转、温度、相变或持久切向摩擦历史。
不要把演示材料参数当作物理标定结果。

```bash
uv run python examples/example_snow.py
uv run python examples/example_granular_beaf.py --no-cut
```

## 表面重建与渲染

`ParticleSurface` 将粒子位置重建为三角网格，不改变粒子物理。
创建 solver 与 state 后，下面代码使用之前保留的物理粒子数量 `count`：

```python
positions = state.particle_q[:count]
surface = s3d.ParticleSurface(spacing, positions, voxel_size=spacing / 2.0)
mesh = surface.rebuild(positions)
```

`positions` 必须是一维 CUDA `wp.vec3` 数组，重建时的粒子选择及排列必须与初始化一致。
默认体素尺寸为 `spacing/3`，支持半径为 `2*spacing`，表面半径为 `0.6*spacing`。
减小 voxel 会增加网格与显存开销。重建存在同步和动态分配，不能放进仿真 CUDA Graph。

带断裂的重建使用选择内部的 `wp.vec2i` 黏结 ID，而不是全模型 ID；还需配套 `wp.int32` broken 标记。
网格缓冲区可能被下一次重建复用，留存历史时应复制。

现有流体例子已处理动态拓扑 viewer：

```bash
uv run python examples/example_fluid.py --resolution 16 --build-surface --viewer gl
```

`--build-surface` 需要支持动态拓扑的 viewer；该示例不支持将它与 RTX viewer 组合。
