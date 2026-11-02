# 关节驱动 CUDA 差异核对记录

2026-10-30 UTC。原版库 SHA256：
`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
只验证原版库中提取的 PTX 与 CUDA 12.4 编译源码；本轮没有账号登录、完整求解器或 demo 验收。

## 本轮结果

| 内核 | CUDA / 原版 GPU | PTX 数据流核对 | 原始 PTX 文本 |
|---|---|---|---|
| `add_joint_drive_preconditioner` | seed 1/2/3 逐位通过 | 写入地址、浮点表达式、浮点判断一致 | 不完全相同 |
| `multiply_joint_drive_tangent` | seed 1/2/3 逐位通过 | 写入地址、浮点表达式、浮点判断一致 | 不完全相同 |
| `initialize_joint_coordinate_velocities`（新增） | seed 1/2/3 逐位通过 | 写入地址、浮点表达式、浮点判断一致 | 不完全相同 |

这三个入口在已覆盖主要路径上完成了源码/GPU/数据流核对。不能把此结论扩展到全部内核、全部浮点输入或 demo。
当前定义了 88/131 个 SynReal CUDA 入口：43 个 PTX-identical，45 个 different，43 个未写。
这些是编译工具的定义统计，其余 different 条目需要各自的审阅证据。

## 两处旧差异具体如何处理

上轮只修复了 divergent atomic 的写回路径，仍有未经归类的 PTX 差异。本轮继续处理：

1. 角 Jacobian 的 axis term、平移预条件器父侧 row，恢复原 PTX 中的 `mul; mul; sub` 表达式。
   本轮编译器在这两个入口保留了该运算序列，GPU JIT 后仍与原版逐位相同。
   不能将同一替换应用到驱动力入口：其指令上下文不同，实际 GPU 测试会失败，故它保留原先显式 FMA。
2. 恢复原版预处理轴归一化、阻尼系数、角度 frame 的检查次序与 `isfinite` 检查。
   `isfinite` 保留原版的 `abs.f32 + setp.geu`；归一化轴与平移父侧长度保留 ordered `<=`。
3. 保留上轮恢复的分支写回路径：转动/平移分开，平移切线的有父/无父路径分开。

最终预条件器和切线的 float opcode 静态计数分别都只少 `3 mul + 9 fma`：
原版在 angular/prismatic 两条互斥路径分别求一次 child origin，源码共享该四粒子加权点计算。
这不是删除一个加权项；每条实际写入路径的完整表达式 DAG 一致。
其它差异为加载/地址/寄存器/基本块调度，以及这个纯计算的共享。

新增速度入口的静态计数差为 `3 sub + 1 mul + 2 fma + 1 sqrt`：源码共享两类关节的轴长计算，
原版在两条互斥路径分别计算。两版对应写入表达式及浮点判断一致。
其 `le` 与 `gtu` 是基本块反转下的精确互补（NaN 时也满足 `gtu = !le`），不是将 `le` 改成 `leu`。

仍保留 PTX-DIFFERENT 标记；没有修改 ptx_compare 的文本比较标准或编译参数。

## 新增速度入口

`kernels/joints.cu` 新增 `JointCoordinateView`（120 字节，含 offset/size 静态断言）和
`initialize_joint_coordinate_velocities`。按原版计算 child/parent 交错的 `J v`，退化时写零，超出 count 不写入。
`dofs` 字段保留在 ABI 中，但原版速度入口并不通过该字段寻址输出，源码也按全局 joint index 写回。

注意原版两类入口的区别：

- 驱动阻尼的平移分支先检查归一化轴范数。
- 初始化关节速度的平移分支按实际轴长 `<= 1e-8` 返回零。

现有冻结 NumPy helper 对极短轴及非有限几何不完全描述速度入口的这些边界；未修改规格。
新测试对这些情况直接比较原版 GPU 与源码 GPU，原版先独立运行确认测试能通过。

## 验证内容与命令

`kernel_ab.py` 仅新增 `joint_drive_branches` 分组、用例及全套测试入口挂接。
它包含三世界（第三世界不足一整批）、每关节独立刚体、16 类场景的两种关节类型：
parent/world、零轴、1e-10 轴、1e-8 阈值及相邻浮点值、平行父参考、零子参考、禁用/负模式、
负/NaN/Inf 系数、被动阻尼、仅被动阻尼等；新增速度入口还核对尾部哨兵和非有限轴/参考/速度。

最终两个分组原版和源码均 seed 1/2/3 exit 0：每 seed 20 + 40 检查。
源码 stderr 确认三个目标入口确实来自 csrc，未回退。

```bash
# 先独立验证原版测试，再切到编译源码；均从仓库根目录执行。
.venv/bin/python -m reconstruction.kernel_ab --only joint_drive_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drive_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 1
# 上述 seed 同样执行 2 和 3。

# 必须清除 RECONSTRUCTION_KERNELS，避免“原版”也被替换为源码。
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_drive_ptx 1
# 同样执行 2 和 3。
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff \
  add_joint_drive_preconditioner multiply_joint_drive_tangent initialize_joint_coordinate_velocities
```

## 数据流诊断的作用和限制

`audit_drive_ptx.py` 捕获原版测试实际输入字节，沿每个 lane 的具体 PTX 路径构造表达式 DAG。
核对 store/atomic 的地址、表达式和浮点比较（包括结果）。仅规范化寄存器移动、加/乘可交换操作数、
FMA 的两个乘数，以及 `gtu = !le` 的精确互补。不会把 `mul/sub` 当作 `fma`，不会代数重排浮点表达式，
未支持的指令报错。每次调用都用 `mul -> add` 人工错误验证诊断器能检出差异。

每 seed 共 17 次调用；seed 1/2 各核对 12106 个写入表达式，seed 3 为 12202，写入及 guard 差异均为零。
另对两个驱动入口做了非有限几何/方向的同输入 GPU 双跑，全部零差异。
CPU 路径诊断不模拟 warp 原子顺序或 JIT 指令融合，必须与 GPU 测试一同使用；它不是完整 PTX 形式化证明。

## 证据与失败尝试

证据目录：`build/reconstruction-csrc/drive-audit/`。

- `coordinate-gpu-final-summary.json`、`coordinate-final-*.json/.err`：最终完整 3-seed GPU 结果。
- `complete-dataflow-seed{1,2,3}.log`、`dataflow-seed{1,2,3}.json`：最终数据流与人工错误检出结果。
- `nonfinite-gpu-seed{1,2,3}.json`：驱动入口直接 GPU 异常输入对比。
- `*-final.diff`、`float-op-counts-final.json`、`ptx-status-final.txt`：完整 PTX 差异与计数。
- `changed-entries-final.json`：相对本轮开始的源码，只有前述两个既有入口发生 PTX 变化，新增一个速度入口。
- `provenance-final.json`：源码、诊断器、测试和最终证据 SHA256。

`gpu-summary.json`、`isolated-helper-seed1.*` 是中间失败结果，不是最终版本。
失败原因是批量替换误触 `evaluate_joint_drive_load` 的 axis term；当时先误判为共享 helper 的影响，
后经源码 diff 确认真实原因并恢复。最终该入口 PTX 与本轮开始完全相同，整组回归通过。
`coordinate-dataflow-seed1.log` 是尚未处理基本块互补判断表示的中间诊断，已由最终报告替代。

下一项是 `evaluate_joint_armature`，再是 `evaluate_angular_limits`；不得把未写的 43 个入口标成已还原。
