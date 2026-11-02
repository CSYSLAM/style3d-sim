# 刚体关节 host 继续恢复：2026-10-30

参考是项目内 `64a0be7f…` 原版，不登录、不读凭据；源码 worker 断言进程中没有映射原版 `_core.so`。
本次接手依据指定 Claude JSONL 最后的工作：对称模板修改尚未验证，链条从首子步不同。
最新活动 image 为末尾的 0c44d52d；前半部分 c598b144 是已保存的历史里程碑。

## 本次恢复的行为

本批已验证 image：`c598b144cea933fb6a5956ceb61baaff380b7fb9c55b3f8826b5b6a3ea61173d`。
后续 armature 扩展已另行验证，活动 image 已变化；各批结果分别保存。
所有 CUDA 核仍来自恢复源码的 27 个模块、176 个入口，没有新增原版 PTX 或二进制依赖。

- 关节点线在 CPU 只预留完整 ELL 列模式，常量 L0 不累加刚度。每步初始化 segment、lambda、projector。
- 每次迭代执行 AL 点线力、动态 GN Hessian；迭代后总刷新投影，指定 primal 轮次才更新乘子。
- Newton 关节可与刚性/软接触、滚动/扭转摩擦组合。真实顺序来自 `example_basic_joints`：
  力为 rigid → rolling → soft → plain spring → joint spring → plain line → joint line → drive → limit → SO(3)；
  CG 切线为 SO(3) → rigid → soft → drive → limit → rolling。
- 仍拒绝关节 PD、非 AL 关节模式、armature、普通约束与接触、未捕获的普通 spring+line 混合。
  fluid/granular/cable/self-collision 等 host 尚未接入，`solver_api_ready=False`。

## 验证结果

固定当前 image，在未改动的官方 demo 上串行运行原版和源码，记录每个 solver 子步的四类状态数组：
`body_q`、`body_qd`、`particle_q`、`particle_qd`。

| demo | 帧 | 子步 | 结果 |
|---|---:|---:|---|
| example_basic_dzhanibekov | 60 | 120 | bitwise |
| example_body_spring | 60 | 240 | bitwise |
| example_distance_constraint | 60 | 240 | bitwise |
| example_body_point_line | 60 | 240 | bitwise |
| example_physical_pendulum | 60 | 120 | bitwise |
| example_joints | 60 | 1200 | bitwise |
| example_basic_joints | 60 | 240 | bitwise |

子步数已按各 `report.json` 核对。
结果目录：`build/reconstruction-csrc/joint-continuation/regression-c598b144/`，每 worker 有实际 image/example SHA。

附加 GPU 捕获：

- `example_joints/joint-lines-dumps/`：36,980 次完整 launch 参数相同，初始权重、常量矩阵、预测状态、
  segment/lambda/projector、首次力和 Hessian 的 51 个有效 dump 逐字节相同。image `344aa3ae…`（接触接入前）。
- `example_basic_joints/joint-contact-dumps/`：9,916 次完整 launch 参数相同，同样的 51 个有效 dump 相同。
  包含刚体父端的 drive/line 权重。image 为当前 `c598b144…`。
- 每组还保留一个 combine 输出缓冲区的写入前 dump；它是未初始化输出，不作为计算结果或输入验收。

## 链条停点的结论和边界

旧 image `debabaa8…` 的对称模板修改确实修复了 L4 的两项 1 ULP 差异。链条一帧 32,920 次 launch 参数
完整相同，记录数也等于 C++ `source_launch_counts` 总和。初始 rhs、inverse、逐元素 z 完全相同；
首个观察差异在 PCG numerator 原子归约：原版 967474585，源码 967474583，再跑原版为 967474573（uint32 bits）。

证据：`build/reconstruction-demos-source/example_chain_heavy_ball/continuation-diagnostic-1/` 及
`build/reconstruction-csrc/joint-continuation/example_chain_heavy_ball/original-repeat/`。
随后在 c598b144 上重抓 32,920 次 launch 和初始 L4、combine、rhs、inverse、r、z，全部相同；
仅 numerator 原子归约不同。60 帧的 8 次原版/3 次源码已完成约定的分布观察：源码每字段最差
573~599/600 子步在 spread 内，ratio 最大 1.2484；原版留一法最差306~387/600，ratio 最大1.4959。
源码与原版自身首次状态分歧均为子步0。完整四前提满足，按用户已认可的混沌标准通过；
严格 bitwise 仍失败，不能称为逐位一致。证据为 joint-continuation/chain-c598b144-{capture,8originals-3sources}/。

## 诊断工具修正

旧 cudahook 的新版 PCG 三类 ABI 不完整，缺少 precondition/inverse/blocks，且静默截断到 20,000 次。
旧 scratchpad 比较器还跳过 `update_cg_direction`，按数值位数猜测指针。因此旧“参数全相同”结论需重核。
现已修复这些布局、取消截断、为未识别的自有 kernel 写 UNKNOWN；新增 `audit_cudahook.py`：

1. 按当前 `build.json` 审核钩子中 101 个实际入口的参数宽度。
2. 从 c++filt 类型区分 pointer 和整数，比较 null、所有标量、维度及调用顺序。
3. 关节/角限制/滚动/表面 View 逐字段区分指针和标量；未支持的 View 明确失败。
4. 不跳过任何已记录 kernel；但 pointer 的内容仍必须另抓 dump 核对，launch 比较不是完整等价证明。

## 命令和接手位置

```bash
# Build the source solver and diagnostic hook.
.venv/bin/python -m reconstruction.csrc.build_host
gcc -shared -fPIC -O2 -Ibuild/toolchains/cuda-12.4/include \
  reconstruction/diagnostics/cudahook.c -o build/reconstruction-csrc/bodies/cudahook.so -ldl

# A new independent output directory preserves previous failures.
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example examples/example_joints.py --frames 60 --output build/joints-new-check
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example examples/example_basic_joints.py --frames 60 --output build/basic-joints-new-check

.venv/bin/python -m reconstruction.csrc.audit_cudahook LEFT/launches.txt RIGHT/launches.txt --output audit.json

# Run serial regression with a pinned build; this command refuses an existing result directory.
.venv/bin/python -m reconstruction.csrc.joint_continuation_regression \
  --output build/reconstruction-csrc/joint-continuation/NEW-BATCH --seeds 1 2 3
```

检查点：`continuation-debabaa8-before-joint-validation/`、`joint-lines-before-contact-combination/`。
所有过程和失败追加在 `reconstruction/WORK_LOG.md`。本批74组回归完成：8组刚体严格通过；
19类粒子×3seed共34,920数组、11,160 eager/graph比较，18类×3seed严格通过；
particles的35/35/28项严格差异保留。API报告变量重名错误修正后，独立重跑692项通过，float/vector 670项通过。
完整检查点 joint-c598b144-before-armature/provenance.json 保留112份源码和1118份结果哈希。
新增 `joint_body_scene.py` 是补充场景（运动刚体父端、偏心 COM、驱动/限位、多个 world、可选 armature），
已验证无 armature 的 revolute/prismatic×3seed（world1/2/3）共6组、180子步严格一致；
armature和derive-velocity扩展另行记录。

## 后续 armature 扩展（活动 image 0c44d52d）

活动 image：`0c44d52d961c741f2a0519f04dbf7248a8ecbde9aab335b8b35ed36ae2902613`。

- 接入 evaluate_joint_armature 的 force/block/tangent 三模式，均位于相应 drive kernel 后、angular_limits 前。
  三模式都保留内部 qd 指针，不能因 block/tangent 不读取就自行传 NULL。
- Control.joint_drive_velocities 是可选输入。缺省时在 initialize_step 后，用 previous（预测前位置）和
  state_in.qd 执行 initialize_joint_coordinate_velocities；给定时复制到同一 cache。
- revolute/prismatic、提供/推导速度、armature=0/.17、3seed与world1/2/3共18组，每组30步，540子步严格通过。
- 三模式4组捕获共2282次launch参数/总数一致，354个有效缓冲区比较逐字节相同。
  缺省速度的 write-only qd 输出在初始化前不比较；输出后严格比较。
- 证据：`build/reconstruction-csrc/joint-armature/ab-30/`、`raw-3calls/`。
- 当前完整回归：`build/reconstruction-csrc/joint-armature/regression-0c44d52d/status.json`，74组已完成。
  同一image的7个官方demo、18类粒子×3seed、8组刚体、API692项与float/vector670项严格通过。
  particles的28/28/14项严格差异保留；固定这批源码候选，每seed10次原版的标准C均通过，outside=[]。

## 当前 image 的最终波动复核与诊断补强

- 链条固定3条源码轨迹对8次原版时，source0.body_qd最大ratio=1.518301，原版最差=1.495912，未通过。
  该原始失败保留在 `joint-armature/atomic-and-chain/chain-8originals-3sources/`。
- 保持同3个source NPZ逐字节不变，只增加8次原版，共16次。所有字段的两项约定分布观察均通过：
  源码每字段最少498~560/600步在spread内，原版留一法对应最少319~463/600步；
  源码最大ratio=1.363864，原版最大=1.650979。严格源码比较仍3/3失败，不能称为逐位一致。
  数据：`joint-armature/atomic-and-chain/chain-16originals-fixed3sources/`，复用的NPZ SHA也记录在status.json。
- 补齐钩子记录：完整mangled function symbol（区分PCG overload）、grid/block全部三维、动态共享内存字节、
  stream类型（null/legacy/per-thread/custom）。重新抓取原版和当前源码，链条32920次及armature2282次全部一致；
  7组链条关键数据、354个armature缓冲区仍逐字节一致。证据目录 `joint-armature/full-launch-metadata/`。
  所观察调用shared bytes均为0、stream均为custom。旧审计只记录了x维度，不能补造这些缺失字段。
- 审计器现在拒绝缺失上述元数据的旧日志，不能因原来文件名含complete而称为完整验收。
  11个正/负对照覆盖除数、NULL、rows、缺失/错序、shared、grid.y、stream和overload身份。
- demo harness新增每帧必须实际采到solver子步、禁止空NPZ通过的保护；已保存修改前版本。
- 同步过期C++注释后重编译，so SHA仍严格为0c44d52d…，未改物理运算或调度。

可复现命令（在仓库根目录；使用新的输出目录）：

```bash
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example reconstruction/csrc/joint_body_scene.py --frames 30 --output build/new-armature-check \
  -- --joint-kind prismatic --seed 2 --worlds 2 --armature .17 --derive-velocity

.venv/bin/python -m reconstruction.csrc.atomic_spread_check --scenario particles --adapter --seed 1 --runs 10 \
  --baseline build/reconstruction-csrc/joint-armature/regression-0c44d52d/particles-seed1 \
  --output build/new-fixed-particle-check

.venv/bin/python -m reconstruction.csrc.chaotic_source_runs \
  --example examples/example_chain_heavy_ball.py --frames 60 --original-runs 16 --source-runs 3 \
  --original-baseline build/reconstruction-csrc/joint-armature/atomic-and-chain/chain-8originals-3sources \
  --reuse-original-runs 8 \
  --source-baseline build/reconstruction-csrc/joint-armature/atomic-and-chain/chain-8originals-3sources \
  --output build/new-fixed-chain-check
```

下一步仍是恢复未实现host：joint PD、其它affine刚度模型/块预条件器、混合刚体材料、cable、fluid、granular、
self-collision，以及未覆盖的Model校验/API错误分支。不要覆盖原版so或把当前编译产物设为完整SDK默认替代。
