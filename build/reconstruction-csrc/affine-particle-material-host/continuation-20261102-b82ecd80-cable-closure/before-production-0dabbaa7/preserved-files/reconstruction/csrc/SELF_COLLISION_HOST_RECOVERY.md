# Self-collision host 还原与验证

> **最新8fb9d2ee：constructor捕获全部对齐；body/cloth首次contact轨迹仍未通过，完整solver未完成。**
> 4f已恢复真实self tangent lazy prepare/capture mode2；initcheck60为0，但八组7/8、graph27/32，失败保留。
> 4f typed57/57、uploads28/28、502 owned指针同；96分配与567 owned+library时序发现primitive AABB和4个init反序。
> 8f只按实际原版移动builder缓存至primitive后，数学/归约/CUDA176 f0均未改；helper24/24规范化PTX同。
> constructor96/28/57/502/567五项全部同；body/PP8严格；graph27/32，固定C8为15/16，source0失败不替换。
> initcheck3为0、246 config同；完整74仍在跑，之后核对失败contact fixture和真实graph buffer，见WORK_LOG。
> 7018完整74为70严格（3粒子seed+NN mixed seed3失败），旧失败/检查点均保留；不继承旧image通过率。
> 下方所有旧image提示为历史；solver_api_ready=False，完整替代仍未完成。

> **当前：0b7621b3；接入SO3 body+cloth/bending，实际八组验证中。**
> 按真实原版共享矩阵延后particle模板，恢复SO3→bending tangent；CUDA176/f0未改。
> 当前八组4292调用/65buffer/全状态严格，完整W1模板10项严格；graph60为28/32严格。
> 两个W3 self graph固定C8仍失败（16轨迹14过）；initcheck原版0/source29160错误，正在核对实际模板初始化。
> 085完整检查点461源/构建、1653结果SHA独立复核0差异；其body/spring八组3772调用/70buffer和graph32同。
> 085完整W1模板10项同，完整74为71严格、三固定首次source C10过、246配置同，self/surface复测严格。
> 辅助47在00f完成三seed10422项实测0失败，CUDA digest一直f0，见CURRENT_AUXILIARY47_RECOVERY.md。
> body+tet/full-surface、其它未捕获组合仍保护；完整solver未完成，solver_api_ready=False。
> 旧d3cb/929/d1a失败与正式demo尚未全部闭合；接手看AFFINE_PARTICLE_MATERIAL_RECOVERY.md和WORK_LOG末尾。
> 下方image提示均为历史。



> 以下50effa1b为历史阶段。

当前源码 image：`50effa1b50881bb95b87250d9a817e402d0add2f398d380221f5839b3c33ce99`。
176 CUDA/digest `f0e0137a…` 未改，参考仍项目内 `64a0be7f…`，两端均不登录。
当前已恢复 self 与 spring/tet/drag/Style3D材料/普通soft contact的组合，以及真实drag初始化顺序。

- 材料32组：26状态严格；PP补充16组：14状态严格；全部材料+cloth+地面8组：8状态严格。
- 56组所有1296项定义buffer、26086次owned启动完整参数全部同；无self控制另385次/9buffer全同。
- 8个严格差异逐组trace，首差全部在第1组PCG numerator/denominator，全部20份相同贡献的精确排列复现两端。
- 新复合graph32项全部严格，双端合计1920物理步；当前74回归、旧self回归、固定候选分布仍在串行运行。
- 完整目标未完成，`solver_api_ready=False`；self+body/fluid/granular/full-surface组合仍拒绝。

每份source0来自第一次失败，不能因诊断trace结果不同而替换它。材料重复运行须保持原bounded dump协议：

```bash
.venv/bin/python -m reconstruction.csrc.granular_dense_distribution \
  --candidate build/reconstruction-csrc/self-host/validation-50effa1b/material32/spring-w3-newton-d0 \
  --initial-original build/reconstruction-csrc/self-host/validation-6faf653e/material-reference/spring-w3-newton-d0 \
  --original-runs 8 --launch-hook build/reconstruction-csrc/full-owned-hook-129/cudahook.so \
  --dump-spec build/reconstruction-csrc/self-host/validation-50effa1b/material32/spring-w3-newton-d0/dump.json \
  --output build/reconstruction-csrc/self-host/NEW-material-distribution
```

新增可选`--dump-spec`锁定相同first-call同步观察；默认不dump的demo路径保持不变。
结果/命令见`validation-50effa1b/`；其post-regression队列仍在执行，不把pending当通过。
此前6faf主检查点424源/构建+71384结果SHA已独立复核0 mismatch；新增正确参考又有addendum检查点。
下方各image标题均是历史证据，不直接计作当前版本通过。

## 已恢复与实际证据

`native/source_solver.cpp` 的 `SelfParticlePairs` / `precompute_self_particle_pairs` / `begin_self_particle_pairs` /
`accumulate_self_particle_pairs` / `multiply_self_particle_pairs` 接入已有源码 kernel，不改计算公式：

- local 粒子 BVH 叶数大于 1 才启用 PP；pre-prediction 位置先 refit/query，再 initialize_step。
- 每粒子 31 个候选槽，query 使用实际 particle_world 和当前已验证的零 group。
- 初始PP孤立分支以惯性scalar diagonal为stiffness；当前组合在soft force后复制本轮scalar diagonal。
  每轮清Hessian，full模式才清counter，固定base不因contact增量覆盖。
- full contact 记录 60 字节，完整 tangent 最多 256 blocks；diagonal 模式使用 Hessian diagonal tangent。
- PP 使 PD 也使用 block matrix 和独立 preconditioner，add Hessian 在 inverse 之前。
- 缓冲区预分配以支持 graph；没有证明原版 allocator/helper runtime 序列完全一致。

原版 x86 精确函数范围与 symbol size 保存在：
`build/reconstruction-csrc/self-host/exact-symbol-ranges-64a0be7f/`。
八组原版三步捕获：`self-host/pp-reference-36ca7d36/`（目录名是捕获时旧 source，并非原版版本号）。
9f1a607d 对照：`self-host/source-first-9f1a607d/`。

八组全部逐位且 finite：Newton/PD × full/diagonal、far、单粒子、empty、3 worlds。
完整 owned launch symbol/grid/block/shared/stream/标量/nullness 全同，source count 与 hook 日志计数一致。
首轮已定义的 query counts/slots、world/groups、stiffness、force、Hessian、counter、有效 contact records、
preconditioner 和 tangent product 全同；未比较未初始化的 slots/contact 尾部。
全 47 个 library entry 的实际 runtime 调用仍未全部观测，不能称整个 so 完全一致。

## 复现命令

```bash
.venv/bin/python -m reconstruction.csrc.self_particle_ab \
  --references build/reconstruction-csrc/self-host/pp-reference-36ca7d36 \
  --output build/reconstruction-csrc/self-host/NEW-source
```

只用新输出目录。原始 fixture 已由 runtime SHA 锁定，不修改后覆盖旧报告。
下一步：多 seed/world、长轨迹、graph、数量与开关边界，再恢复 mesh host / 组合。
当前新 image 尚未完成全模块回归，不能继承旧 image 的通过结果。

## 仍未验收的历史差异

36ca7d36 的 74 组回归中 70 严格通过，四个严格失败均保留；其中三组固定候选通过 C10，
particles seed2 的固定候选即使扩到 40 原版，仍有 `n257_w1_it1_f0/2/out.particle_qd` 未过 C。
实际独立 trace 的首差在 PCG atomic denominator；相同 257 份贡献可按两个 float32 累加排列精确复现两端。
这解释已捕获的首差，不等于整段 C 通过；不得改阈值、替换候选或宣布全量验收。
完整记录见 WORK_LOG.md 末尾及 GRANULAR_HOST_RECOVERY.md的 36ca7d36 更新。

## 5e23dc5a 的参数校验修正

9f 的 38 组扩展有 31 组严格；6 组暴露原版拒绝非法 factor、source 却接受的问题；n2115 PD 有严格浮点差异。
新增 246 项 probe 证实 radius 无条件有限正数、四种 stiffness 有限非负、radius 错误优先。
5e 按原版错误类型/文字与 x86 恢复校验，`contract-after-5e23dc5a/` 全部一致。
新 image 有效参数长轨迹、graph、全模块回归正在 `validation-5e23dc5a/` 串行运行。

9f 的 `graph60-9f1a607d/` 80 项比较全部严格，双端 4800 物理子步。
n2115 PD 的 source0 固定后追加 source1/2 各一次，八原版分布检查无 outside；严格仍 false/true/false。
独立实际 trace 首差为 launch4 precondition_and_reduce 的 numerator；z/r/initial 相同。
2115 份贡献的两种精确 float32 排列复现两端，见 `n2115-pd-first-sum-witness-actual/`。
不据此更改生产求和顺序，不把本场景的分布通过替代其它历史未验收项。

```bash
.venv/bin/python -m reconstruction.csrc.self_collision_contract_ab \
  --output build/reconstruction-csrc/self-host/NEW-contract
.venv/bin/python -m reconstruction.csrc.self_particle_extended_ab --valid-only \
  --fixture reconstruction/csrc/self_particle_valid_switch_scene.py \
  --output build/reconstruction-csrc/self-host/NEW-extended
.venv/bin/python -m reconstruction.csrc.self_particle_graph_ab --frames 60 \
  --output build/reconstruction-csrc/self-host/NEW-graph
```

`--valid-only` 仅将负/NaN factor 从有效轨迹排除；这些拒绝行为必须由独立246项契约全部核对，
不能为了让轨迹报告通过而忽略它们。首次138项失败保留。

## Mesh host 静态导读（已接入isolated分支，组合尚未恢复）

先用 `self_mesh_capture.py` 的修正版在新目录抓原版16组三步：particle-face、vertex-face、
edge-edge、edge-face，各Newton/PD、三world、diagonal变体。首次失败是Builder要求wp.vec3，
已留fixture原字节；不是原版solver崩溃。新EF opposite放同侧以避免折叠方向抵消导致零活跃接触。

精确x86导读（仍须与实际dump互证）：

- initialize的138278..138488：三角形顶点放有序set，并建立每条无向边的opposite有序set。
- 138518..138730：将collision edge的z/w放入mesh vertex set；将有效x/y加入该edge的opposite set，
  CSR取triangle邻接与authored opposite的并集。不能直接照旧numpy的仅authored opposite假设。
- begin_frame：按tri/edge/particle顺序build AABB+refit，再query VF(mesh)、VF(free particle)、PP、EE、EF。
  原先按反汇编线性排列推断PP最后，已由真实mixed捕获证明不正确；d80修正了分支执行顺序。
- VF query的mesh路径radius数组为空、skip_incident=true；free particle路径用radii且skip_incident=false。
- accumulate：清Hessian/full清counter，依次VF(mesh)、VF(particle)、PP、EE、EF；各stiffness分别>0才装配。
- 完整contact容量来自启用几何的各31槽候选缓冲区总和；grid至多256 blocks，不只PP的31*n。
- 共享world topology与每world refit nodes必须区分；local=1的BVH无visit buffer。

精确范围补充在 `self-host/static-mesh-plan-64a0be7f/`，原版SHA已守卫。
在当前GPU批次结束并保存5e检查点前，不修改生产C++ host。

## 5e 完整检查点与 3137 mesh 试运行

5e 已完成：246 self配置契约、692 API/guard、670属性、72 radius、103 granular构造、
BVH9规模69buffer/43 owned调用、PP八组首轮buffer、80 graph比较。74回归中，三seed粒子严格差异保留，
固定各自第一次源码候选后C10全部通过；其余真实demo/body/材料严格。
旧self-only失败guard与新支持相冲突，旧脚本/失败日志留存，新API检查与实际原版空primitive行为核对通过。

5e n2115-PD C8原版本批spread0而源码source0不同；只扩原版至16、保持三份source不变后，
source0三步C内且完全逐位匹配actual original13/14。额外ratio也误报这两份实际原版，
`n2115-pd-cohort16-5e23dc5a/extra-ratio-selfcheck.json` 保留反例，原报告/规则不覆盖。
36ca旧固定候选真实C40未过仍单独列为历史待验收，不能替换候选。

修改前 `self-5e23dc5a-before-mesh/` 保存409份源/构建、8106份结果SHA。
mesh原版16组均实际成功并有活跃VF/EE/EF，见 `validation-followup-5e23dc5a/mesh-reference/`。
3137的source首次结果在 `mesh-source-first/`，必须完成后读取report，不预先认定通过。

```bash
.venv/bin/python -m reconstruction.csrc.self_mesh_ab \
  --references build/reconstruction-csrc/self-host/validation-followup-5e23dc5a/mesh-reference \
  --output build/reconstruction-csrc/self-host/NEW-mesh-source
```

当前mesh数据只抓已定义prefix：query第一行、前两次force的全force/Hessian与counter、
有效contact第一条、preconditioner和tangent product，不代表完整候选槽或完整cache均被逐字节核对。
未初始化尾部不作比较，另47库入口runtime仍非完全观测。

## d80c40e3 当前验收范围

输出总目录：`build/reconstruction-csrc/self-host/validation-d80c40e3/`。

- `mesh16/`：16组三步、385个定义buffer检查、4900 owned调用完整参数全部相同。
- `pp8/`、`self-contract/`、`pp-graph60/`全部通过。
- `mixed-live-counters/`：五渠道累计[3,5,6,7,8]，新增[3,2,1,1,1]相同，状态/元数据同。
- 14组mixed60全部完整元数据相同；12状态严格，world3 full Newton/PD仍严格不同，不提前验收。
- mesh graph72中6项严格不同，集中world3 full；包含原版自身eager/graph差异。
- 74回归71严格；三seed particles严格差异28/14/26，固定各第一次source后C10均通过。

两组mixed诊断在 `mixed-diagnostics-d80c40e3/`，实际PCG trace与固定source0+source1/2一次、八原版分布
正在串行执行。诊断trace不替换首次失败候选。仍未恢复材料/外部接触/刚体等与self collision的组合。

```bash
.venv/bin/python -m reconstruction.csrc.self_particle_trace_ab --scene mixed --mode newton --frames 1 \
  --output build/reconstruction-csrc/self-host/NEW-mixed-trace
.venv/bin/python -m reconstruction.csrc.self_particle_graph_ab --suite mesh --frames 60 \
  --output build/reconstruction-csrc/self-host/NEW-mixed-graph
```

102b阶段查询顺序错误的失败与截断回归保留；102b只有partial74，不继承5e/d80完整回归结论。
所有source worker均通过compiled source so并检查未映射原版_core，双端均不登录。

## d80混合/graph差异已定位；8ac组合验证中

- 两种mixed实际trace首差均launch6的第1组PCG denominator，1ulp；ap/p/initial完全相同，
  20份dot贡献trial0/trial6两个精确float32排列复现两端。
- PD八原版分布通过；Newton固定3source不变扩至16原版后，全60步C内且三条都匹配实际原版整轨迹。
  原额外ratio失败与原版本身误报反例均保留，没有改规则或替换候选。
- `graph-newton-eight/`和`graph-pd-eight/`均固定最初graph source0，只追加source1/2各一次和7原版graph，
  三source各60/60步C内，既有观察无outside，原严格比较仍有失败记录。
- d80修改前检查点416源/构建+17593结果SHA，路径`self-d80c40e3-before-cloth-combinations/`。

8ac已按16组实际cloth参考接入材料+粒子软接触：独立self stiffness scratch每NL在soft force之后复制，
原base供下一轮重置；self force在material force之前、self tangent在bending damping之后。
PD diagonal跳过第二次soft preconditioner的原行为不改。full-surface/body/drag/spring/tet/fluid/granular/rigid组合仍拒绝。
`cloth-source-first/` 首批尚在运行，不能提前计通过。

```bash
.venv/bin/python -m reconstruction.csrc.self_cloth_ab \
  --references build/reconstruction-csrc/self-host/cloth-reference-d80c40e3 \
    build/reconstruction-csrc/self-host/cloth-reference-extra-d80c40e3 \
  --output build/reconstruction-csrc/self-host/NEW-cloth-source
```

## 6faf真实塑料袋首差的实际证明

`validation-6faf653e/bag-stretch-witness/`：第一轮stretch的所有输入及before.rhs全同，after.rhs有229个words不同。
3312三角形隔离后，两个zero-sign的各29808个scalar在原版PTX和source so中全部相同。
真实1703×3个rhs输出，两端所有5109个分别由同一组贡献的float32排列精确复现，无未解释项。
这证明该首差来自相同贡献的加法排列；不代表整段轨迹分布已经通过，固定八原版的失败继续保留。

```bash
.venv/bin/python -m reconstruction.csrc.stretch_atomic_witness \
  --trace build/reconstruction-csrc/self-host/plastic-bag-trace-first-6faf653e \
  --output build/reconstruction-csrc/self-host/NEW-stretch-witness
```

`cloth-graph60-6faf653e/`实际16场景、双端各eager/graph60步，64项比较全部严格。
当前74回归71严格，三粒子seed的严格失败固定原候选按C10继续复核；最终计数以本image报告为准。

## 下一分支的静态证据：self与fluid/granular

`validation-50effa1b/static-fluid-granular-groups/`保存同一64a0原版的x86与rodata。
SelfCollision::initialize先零填充全部local粒子groups，再把fluid选中索引标1、granular标2，禁止两种选择交叠。
因此不能直接解除self+fluid/granular守卫而继续上传全零groups；目前生产代码仍拒绝这些组合。
应先实际抓query的groups/counts/slots，含subset、free非材料粒子、world1/3、Newton/PD及full/diagonal，
并核对force/preconditioner/tangent的真实顺序和本轮scalar stiffness，再恢复对应host。
