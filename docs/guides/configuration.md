# 参数调优与性能

配置从 `solver.config` 修改，影响之后的直接 `step()`。
先选与任务相近的示例作为起点；不要一次同时增大刚度、dt 和模型规模。

## 常用配置

```python
import style3d_sim as s3d

solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
solver.config.nonlinear_iterations = 4
solver.config.linear_iterations = 50
solver.config.enable_collision_hessian_non_diagonal = True
```

片段使用已初始化的 solver。这是调试起点，不是所有场景都稳定或最快的预设。

| 属性 | 用途 | 调整时注意 |
| --- | --- | --- |
| `nonlinear_solver` | `NEWTON` 或 `PD_NEWTON` | 算法选择不等同于仅改变迭代数 |
| `nonlinear_iterations` | 每个 step 的非线性迭代预算 | 刚度大、接触复杂时可能需要更多 |
| `linear_iterations` | 每次非线性迭代的 PCG 预算 | 太少可能让外层迭代收效有限 |
| `enable_collision_hessian_non_diagonal` | 启用接触耦合切线 | 会改变计算与存储成本；部分接触本来就保留耦合项 |
| `enable_self_collision` | 变形体自碰撞 | 不关闭 shape 接触和专用颗粒接触 |
| `self_collision_radius` | 变形体碰撞厚度 | 结合模型尺寸与粒子半径调整 |
| `constraint_alpha` | 仿射刚性、生成关节与硬距离约束的共享无量纲惩罚 | 0 禁用这三类约束，不能当作一般加速开关 |
| `wind_velocity` | 世界坐标风速，m/s | 使用 3 分量元组 |
| `air_density` | 空气密度，kg/m³ | 0 关闭气动阻力 |
| `fluid_relaxation` | 流体 Newton 步缩放 | 范围 `(0, 1]` |
| `fluid_max_step_ratio` | 相对核半径的增量界限 | 0 禁用限制 |

完整的当前绑定属性见 [原生 Config 参考](../reference/native.md#config)。
属性表只描述已暴露接口，不承诺旧二进制实现了当前源码的所有属性。

## 刚体与关节约束模式

| 类型 | 可选项 |
| --- | --- |
| `AffineBodyRigidityModel` | `CO_ROTATED`、`ABD_ORTHOGONALITY`、`SIX_SPRINGS`、`SO3_AUGMENTED_LAGRANGIAN` |
| `JointConstraintMode` | `PENALTY`、`AUGMENTED_LAGRANGIAN` |
| `InertiaMode` | `EXPLICIT_EULER`、`IMPLICIT_EULER`、`LIE_GROUP_MIDPOINT`、`MIDPOINT_CAYLEY`、`NONE` |

`InertiaMode.NONE` 选择自由粒子惯性路径，不是停止模拟刚体。
使用 AL 时的 primal iteration 参数描述固定乘子下的迭代预算，不等同于增加所有非线性迭代。
先复用 `example_basic_shapes.py` 或关节示例的配置，再进行逐项对照实验。

## 稳定性排查顺序

1. 检查单位、质量、惯量、active 标志、网格与初始穿透。
2. 缩小场景到单个对象，使用固定步长且关闭 graph。
3. 增加 substeps，减少每个 step 的 dt。
4. 检查碰撞是否每步生成、是否传入正确 contacts。
5. 增加合理的 nonlinear/linear 迭代预算，再调整刚度与阻尼。
6. 同时观察物理误差和耗时；性能收益不能仅靠“画面没爆炸”判断。

接触阻尼过大会过度衰减反弹；过大刚度会提高系统条件数。
可压缩流体的 bulk modulus、核半径与质量标定也相互影响。

## CUDA Graph {#cuda-graph}

先确认普通循环结果正确。Graph 捕获的是 CUDA 工作及对应参数和地址，不能把 Python 状态交换理解为回放时也会执行。

以下片段使用已初始化的 pipeline、state、following、control、contacts 与 solver：

```python
import warp as wp

dt = 1.0 / 240.0

def substep(source, target):
    source.clear_forces()
    pipeline.collide(source, contacts)
    solver.step(source, target, control, contacts, dt)

# Compile kernels and establish allocations before capture.
substep(state, following)
substep(following, state)
wp.synchronize()

with wp.ScopedCapture(device=model.device) as capture:
    substep(state, following)
    substep(following, state)

for _ in range(120):
    wp.capture_launch(capture.graph)
wp.synchronize()
```

捕获两次子步后，最后结果仍回到 `state`；回放时不需要做一次额外的 Python 对象交换。
预热和捕获本身也可能推进状态，开始记录正式轨迹前要按应用要求重置，不能把它们当作零时长检查。

修改 config、dt、数组地址、模型结构或启用/禁用驱动反馈后应重建 graph。
保持 graph 引用的 model/state/contacts/feedback 缓冲区存活。
`ParticleSurface.rebuild()`、`.numpy()`、动态数组分配和首次登录等操作放在捕获外。

## 测量真实耗时

GPU 提交异步执行，用普通 CPU 计时但不等待 GPU 会低估耗时：

```python
import time
import warp as wp

wp.synchronize()
started = time.perf_counter()
for _ in range(100):
    wp.capture_launch(capture.graph)
wp.synchronize()
print(f"100 graph replays: {time.perf_counter() - started:.3f}s")
```

预热之后再测，分别统计物理、碰撞、表面重建和渲染。
每步 `.numpy()` 会同步并拷贝到 CPU，调试完成后降低采样频率。
多 GPU 场景保证模型、状态、stream 和 contacts 在一致设备上，不能把另一 GPU 的指针当成同一内存。
