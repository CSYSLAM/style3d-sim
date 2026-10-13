# 布料与四面体软体

两种模型不要混淆：布料以三角形面和边定义薄片；四面体软体以体单元定义有体积的弹性对象。

## 布料：先注册 Style3D 属性

普通 Newton 三角形表面弹性不能直接当作 SynReal 的布料路径。
在添加布料之前注册 Style3D 自定义属性，并使用 Style3D 建模函数。
下面是可用于仿真循环的模型初始化部分：

```python
import newton
from newton.solvers import style3d
import warp as wp
import synreal_solver as sr

builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
newton.solvers.SolverStyle3D.register_custom_attributes(builder)
builder.add_ground_plane()
style3d.add_cloth_grid(
    builder,
    pos=wp.vec3(-0.5, 0.0, 1.0),
    rot=wp.quat_identity(),
    dim_x=10, dim_y=10,
    cell_x=0.1, cell_y=0.1,
    vel=wp.vec3(0.0),
    mass=0.01,
    fix_left=True,
    particle_radius=0.005,
    tri_aniso_ke=wp.vec3(1.0e2, 1.0e2, 1.0e1),
    edge_aniso_ke=wp.vec3(2.0e-4, 1.0e-4, 5.0e-5),
)
model = builder.finalize(device="cuda:0")
solver = sr.NewtonSolver(model)
```

然后创建两个 state、control、pipeline、contacts，按 [仿真循环](simulation-loop.md) 推进。
`tri_aniso_ke` 调整膜内响应，`edge_aniso_ke` 调整弯曲响应；这组值只是起步示例，不是特定织物的实测参数。
`fix_left=True` 固定网格的一侧，适合先检查悬挂形态。

## 使用真实布料网格

需要同时提供世界几何与二维版片的静止度量。
多个面共享三维顶点时，二维版片 UV 仍可能在缝线处不同；不要丢弃 face-varying UV 索引。
检查版片单位和三角形方向，退化或翻转版片会产生错误的弹性参数。

现成脚本：

```bash
uv run python examples/example_cloth_hanging.py --help
uv run python examples/example_cloth_style3d.py --help
uv run python examples/example_plastic_bag.py
```

`example_cloth_style3d.py` 包含资产下载和版片坐标处理；`example_plastic_bag.py` 读取仓库中的塑料袋 USD。
下载的服装、UV 单位与索引检查都在对应示例中，不应只复制几何顶点就省略版片信息。

## 自碰撞与 shape 碰撞

布料落地需要地面 shape、pipeline 接触和 `model.soft_contact_*` 参数。
布料折叠时可以启用 `solver.config.enable_self_collision`，但过大的碰撞厚度会让薄袋像厚垫子。
设置厚度时先检查模型尺度、粒子半径、shape margin 与 `self_collision_radius`。

自碰撞几何处理不能保证任意初始穿透都能恢复。
应从有效初始形态出发，减少 dt，再检查材料和迭代数。

## 四面体弹性体

使用 Newton 的 `add_soft_mesh()` 等体建模入口定义顶点、四面体索引、质量密度与弹性参数，
再在 CUDA 上 finalize，并交给 `NewtonSolver`。
适配器读取 Newton 的 `tet_indices`、`tet_poses`、`tet_activations` 和 `tet_materials`。

初学者先运行已有四面体场景：

```bash
uv run python examples/example_ball.py --help
uv run python demos/g1_jelly_drop/demo_g1_jelly_drop.py --viewer null --num-frames 120 --test
```

| 要检查的事项 | 原因 |
| --- | --- |
| 四面体有有限且非零的静止体积 | 退化单元没有可用的逆静止形变矩阵 |
| 网格、质量和材料单位一致 | 不一致会同时改变惯性、重力与弹性 |
| 初始位置没有严重形变或穿透 | 过大变形可能无法在有限迭代内恢复 |
| 体单元与渲染表面分开理解 | 表面光滑不意味着体网格分辨率足够 |

G1 demo 的 jelly 参数和验证方法见 [示例与渲染](demos.md)。
不要把“果冻外观”的渲染材质当作物理材料标定。
