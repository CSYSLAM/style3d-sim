# evaluate_joint_armature CUDA 核对

2026-10-30 UTC。旧 so SHA256：
`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
源码为 `kernels/joints.cu` 中的 `evaluate_joint_armature`，含 `armature_rows`、`armature_coordinate` 私有辅助函数。
本轮只新增这个 CUDA 入口，既有入口的规范化 PTX 均未改变。

## 结果及范围

- 原有 `joint_drives`（20 检查）、`joint_drive_branches`（40 检查）和新增
  `joint_armature_branches`（96 检查），原版及源码分别 seed 1/2/3 全部 exit 0。
- `joint_drives`、`joint_armature_branches` 的源码 stderr 均含 `23evaluate_joint_armature`，确认没有回退。
- 三种模式均核对：力、切线、对角块。覆盖的 GPU 输出为逐位一致，没有放宽容差。
- 数据流每 seed 19 次原版调用，写入地址、写入表达式和浮点判断零差异。
  有实际写入的每次调用均能检出人为 `mul -> add` 错误；零时间步 force 不写入，其 mutation 结果不用于验收。
- 扩展诊断器后，前一批三个关节入口的原版/源码数据流及异常输入 GPU 双跑也全部回归通过。
- 保留 PTX-DIFFERENT 文本状态；本轮没有账号登录、完整求解器或 demo 验收，不能推广为所有浮点输入已证明一致。

当前定义数 89/131：43 个 PTX-identical、46 个 different、42 个未写。定义数不等于全部完成严格验收的数量。

## 运算与 ABI

按 `kernel_ab.py` 的 launch 核对参数：
`JointCoordinateView(120B), armature, positions, previous, qd, inverse_dt, direction, force, block`。
惯量系数按 `view.dofs[local_joint]` 读取，初始关节速度按全局 `qd[i]` 读取。
正惯量才继续，Inf 不额外拦截；缩放保持 `(a * inverse_dt) * inverse_dt` 两次乘法。

- 对角块优先于 direction，child/parent 按 slot 交错累加。
- 切线投影同样按 child/parent 交错，向量写回则先全部 child、再 parent。
- 力模式按当前/前一状态坐标计算位移差；只有 type==1 绕回角度，保持 `add.rz + trunc + mul/sub`。
- 平移关节实际轴长 `<= 1e-8` 跳过；退化角 frame 跳过。
- 切线/对角模式不会读取 previous/qd，测试中这两个参数为 NULL。
- 不把限制角度 kernel 的激活/有限性规则混入本入口；下一项需独立核对。

## 首次失败与修复依据

初版 seed1 的力/切线/对角块分别有 8/38/59 个分量不同。
同输入双跑及逐个惯量系数隔离后，错误集中在有父刚体的转动关节；平移侧没有隔离失败。
定位到转动 axis term 的两个乘积在旧 PTX 中的产生顺序：先 child product，再 parent product，随后相减。
旧 JIT 在这里融合 minuend（parent product），与阻尼驱动入口不同。

一个临时显式 `fmaf(sp, upc, -(sc*ucc))` 版本 GPU 全部匹配，但会改变 PTX 运算形式。
最终源码按原版顺序声明 `child_term = sc*ucc`、`parent_term = sp*upc`，再相减除以轴长，
同时保留原来的 PTX 运算及 GPU 舍入结果。没有修改其它入口的 angle Jacobian。

重要证据：**初版的具体路径表达式 DAG 也能相同，但实际 GPU 仍不同**，因为 DAG 不包含未显式舍入
mul/sub 在 JIT 中的融合上下文。必须同时跑 GPU；不能只凭表达式相同或 PTX 指令数量下结论。

最终静态 float opcode 比原版少 `6 sub + 2 mul + 4 fma + 2 sqrt`：当前/前一状态的轴向量与轴长
在转动/平移的互斥分支间分别共享，实际写入路径的表达式不缺项。
原子写回数保持 96，浮点比较/rounding/libdevice 相关操作核对见数据流与完整 diff。
其余文本差异为指令/加载/寄存器调度及父侧存在性判断的整数表示。

## 新增边界测试

`joint_armature_branches` 使用三世界，最后一世界只激活部分 joint，刚体彼此独立，以免跨 warp 原子噪声。
每类场景均有平移/转动两种 joint，dof 顺序打乱，世界坐标与 qd 不同。
场景包括 parent/world、零/极短/阈值/相邻浮点轴长、平行父参考/零子参考、仅 previous 退化、
零/负/NaN/Inf 惯量、NaN qd、半圈和多圈绕回。

运行 force/tangent/block/block_priority 及 inverse_dt=0、-240，比较两套 GPU 的完整输出和尾部哨兵。
三模式也在原有共享刚体的随机组上对冻结 NumPy 规格验证。新增边界直接以旧 PTX GPU 为参照，未修改规格公式。

## 命令

从仓库根目录运行，seed 同样取 2、3：

```bash
.venv/bin/python -m reconstruction.kernel_ab --only joint_armature_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_armature_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drive_branches --seed 1

env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_armature_ptx 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.probe_armature 1
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff evaluate_joint_armature
```

诊断器增加了本入口需要的 min/max/rcp/add.rz、截断、select、整数余数/移位/bit 操作支持。
未支持的指令继续报错，没有放宽浮点比较或把 FMA 当成 mul/sub。

## 证据索引

目录 `build/reconstruction-csrc/armature-audit/`：

- `gpu-final-summary.json`、`final-*.json/.err`：18 次最终 GPU 分组运行。
- `audit-final-summary.json`、`armature-final-seed*.log`、`dataflow-seed*.json`：最终路径数据流及 mutation 检查。
- `drive-regression-final-seed*.log`、`drive-regression-*.json`：前一批回归证据副本。
- `legacy.txt`、`first.ptx`、`ordered.ptx`、`final.ptx`、`final.diff`、`float-op-counts-final.json`：PTX 依据。
- `first-seed1.*`、`probe-first-seed1.log`：初版 GPU 失败及隔离。
- `probe-minuend-seed1.log`：临时显式 FMA 版本通过；`joints-explicit.cu` 保留对应源码。
- `probe-ordered-seed1.log`：最终自然乘减顺序通过。
- `dataflow-first-seed1.log`：诊断器首次遇到未支持的 xor.b16，已补支持。
- `changed-entries-final.json`：既有入口变化 0，新增入口 1。
- `ptx-status-final.txt`、`provenance-final.json`：进度及最终文件 SHA256。

注意：`probe-seed1.json` 会被探针重跑覆盖；阶段性的 `.log` 保留各版结果。
下一项 `evaluate_angular_limits`；应独立核对其 type==1 过滤、双零系数、角度状态和激活 torque 规则。
