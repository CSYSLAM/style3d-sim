# 模型、状态与仿真循环

本页解释 [第一个仿真](../getting-started/first-simulation.md) 的结构，并给出迁移现有 Newton 项目的顺序。

## 对象的职责

| 对象 | 创建时机 | 保管的数据 |
| --- | --- | --- |
| `s3d.ModelBuilder` 或 `newton.ModelBuilder` | 创建场景时 | 尚未分配到 GPU 的场景定义 |
| Newton `model` | `builder.finalize()` 后 | 质量、拓扑、形状、关节、材质等模型数组 |
| `s3d.NewtonSolver` | 模型最终配置完成后 | 原生模型视图、求解器缓存、约束与材质历史 |
| `state` / `following` | 创建 solver 后 | 位置、速度、外力等可变数组 |
| `control` | 创建 solver 后 | 关节目标、速度目标、广义外力 |
| `CollisionPipeline` / `contacts` | 创建 solver 后 | 碰撞检测和本次接触数据 |

`s3d.ModelBuilder` 继承 Newton builder，增加刚体代理和额外约束。
普通 `newton.ModelBuilder` 也能用于适配器，但 solver 可能在初始化时追加或重排刚体代理粒子。
因此建议统一在创建 solver **之后**创建状态、接触、viewer 和依赖粒子计数的缓冲区。

## 推荐初始化顺序

1. 创建 builder；添加粒子、刚体、形状、关节，注册需要的 Style3D 属性。
2. `finalize(device="cuda:0")` 分配模型。
3. 设置接触参数；调用 `configure_fluid()` / `configure_granular()` 等材质函数。
4. 创建 `NewtonSolver(model)` 并配置 `solver.config`。
5. 创建两个 state、control、collision pipeline 和 contacts。
6. 设置初始状态、执行必要的 FK；若修改刚体状态，调用 `sync_affine_body_state()`。
7. 开始推进；需要 CUDA Graph 时先按 [性能教程](configuration.md#cuda-graph) 做准备。

不要在 `finalize()` 之后继续向同一个 builder 加对象，再假定原模型会更新。
`s3d.ModelBuilder` 是一次性的，再次 finalize 会抛出异常；另一个场景需要新的 builder。

## 每个子步的顺序

下面代码接在第一份示例的初始化之后；`frame_dt`、`substeps`、`state` 等使用同样定义：

```python
dt = frame_dt / substeps
for _ in range(substeps):
    state.clear_forces()
    # Apply new external forces here, after clearing the previous step's forces.
    pipeline.collide(state, contacts)
    solver.step(state, following, control, contacts, dt)
    state, following = following, state
```

- 清理后再写外力；不要写完外力再清理，否则该步不会受到它影响。
- 先基于当前 state 检测碰撞，再把结果传给 `step()`。
- 交换对象后，`state` 才是当前结果。记录与渲染都读取它。
- 没有关节驱动时可以传 `control=None`；没有 shape 接触时可以传 `contacts=None`。
- 存在驱动关节时提供 `model.control()`，不要因为没写外力就省略 control。

!!! warning "输入不一定是历史快照"
    原生推进可能同时更新输入与输出的粒子位置缓冲区。
    若要保留上一步位置，应在 step 前复制，而不是在 step 后读取 `state_in` 并认为它还是旧值。
    `.numpy().copy()` 能产生独立 CPU 快照，但也会引入同步和传输。

## 单位、轴与步长

建议统一使用 SI：位置和半径为米，质量为 kg，时间为秒，速度为 m/s。
`up_axis=newton.Axis.Z` 表示 Z 轴向上，默认重力沿该轴为 `-9.81`。
`frame_dt=1/60` 与 4 个子步意味着物理步长 `dt=1/240`，不是每个子步再推进 `1/60`。

`dt` 必须是有限正数。先从少量对象、固定 dt 和普通 Python 循环开始，确认物理结果后再加并行环境与 graph。

## 加入 viewer

沿用已经初始化的 `model`、`state`、`following`、`solver`、`control`、`pipeline`、`contacts`：

```python
from newton.viewer import ViewerGL

viewer = ViewerGL()
viewer.set_model(model)
sim_time = 0.0
try:
    while viewer.is_running():
        if viewer.should_step():
            for _ in range(substeps):
                state.clear_forces()
                viewer.apply_forces(state)
                pipeline.collide(state, contacts)
                solver.step(state, following, control, contacts, dt)
                state, following = following, state
            sim_time += frame_dt
        viewer.begin_frame(sim_time)
        viewer.log_state(state)
        viewer.end_frame()
finally:
    viewer.close()
```

viewer 需要图形环境；远程服务器先用 headless 程序。对第三方 viewer 的不同版本接口，以现有示例为准。

## 重置或直接改变刚体姿态

如果外部程序调用 `newton.eval_fk()`，或者直接写 `state.body_q` / `state.body_qd`，需同步到仿射代理：

```python
newton.eval_fk(model, model.joint_q, model.joint_qd, state)
solver.sync_affine_body_state(state)
```

同步应在重置、FK 或外部编辑之后执行，不要每个正常子步都执行，否则会丢弃刚求出的代理状态。
颗粒塑性和断裂历史保存在 solver 内部；恢复位置与速度不会清空这些历史，需要重建 solver。

## 迁移现有 Newton 项目

先将 solver 替换为 `s3d.NewtonSolver(model)`，保留 Newton 的 state、control 与碰撞流程。
检查模型在 CUDA 上；如果场景使用普通三角形弹性，按 [布料教程](deformables.md) 改为 Style3D。
不要照搬其他 solver 的 iterations 参数到构造函数：SynReal 的迭代数在 `solver.config` 上设置。

对拓扑、材质数组替换或 shape 数目变化，优先重新创建模型与 solver。
`notify_model_changed()` 是适配层的模型变更通知入口，不代表任意拓扑变化都能安全地就地更新。
