# 第一个仿真

目标：在 CUDA 上模拟一个下落粒子并与地面接触。
这个程序无需窗口、外部模型或纹理，适合先确认库安装与登录正常。

## 1. 检查环境

先完成 [安装](installation.md) 和 [登录](authentication.md)。确认 `_core` 指向本次构建，
`warp.is_cuda_available()` 为 `True`。以下命令均在仓库根目录执行。

## 2. 运行完整程序

仓库已经提供 [first_simulation.py](../samples/first_simulation.py)，直接运行：

```bash
uv run python docs/samples/first_simulation.py
```

未设置凭据时会先询问账号和密码。成功后程序每 30 帧打印一次位置，最后显示：

```text
Simulation completed: 120 frames
```

第一次启动可能需要编译 Warp kernels，后续启动会使用缓存。
位置的具体数值受配置和版本影响，不应将每一位小数当成跨版本的验收标准。

## 3. 完整代码

```python
--8<-- "docs/samples/first_simulation.py"
```

## 4. 每一步做了什么

| 步骤 | 目的 |
| --- | --- |
| `wp.init()` | 初始化 Warp 并检测设备 |
| `s3d.ModelBuilder()` | 准备场景对象与碰撞材料 |
| `add_particle()` | 创建位置、速度、质量和接触半径 |
| `finalize(device="cuda:0")` | 将模型数据分配到指定 GPU |
| `s3d.NewtonSolver(model)` | 认证并初始化 SynReal 适配器 |
| 两个 `model.state()` | 分别提供输入与输出缓冲区 |
| `CollisionPipeline` | 根据当前状态生成粒子与形状的接触 |
| `step()` | 使用这些接触推进一个子步 |
| 交换两个状态 | 让刚求出的输出成为下一步输入 |

仿真帧率是 60 Hz，每帧 4 个子步；传给 `step()` 的 `dt` 为 `1/240` 秒。
CPU 循环每执行一个子步就重新检测碰撞，地面形状才会参与当前状态的接触。

## 5. 想看到窗口？

先用现成的刚体场景体验实时 viewer：

```bash
uv run python examples/example_basic_shapes.py --solver synreal --device cuda:0
```

这类示例需要 `examples` extra 和图形环境，部分资产首次使用会下载。
无显示环境时，继续使用本页的脚本或示例支持的 `--viewer null`。

## 6. 下一步

尝试修改粒子初始高度、半径和子步数，观察落地行为。
然后阅读 [仿真循环](../guides/simulation-loop.md)，学习添加 viewer、施加外力和重置状态。
