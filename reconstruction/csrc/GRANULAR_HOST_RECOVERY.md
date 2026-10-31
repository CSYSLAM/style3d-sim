# Granular host 还原进度（继续中）

本阶段检查点 image（活动 PP image 见 SELF_COLLISION_HOST_RECOVERY.md）：`36ca7d364c47eecf642bf19defdfb2cace7db544a1f5707601a1b625b9b58cba`。
前一76790908全部176个选定kernel的digest/参数/模块与本image完全相同；本次只修复host CSR构造。
CUDA digest为`f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a`。
仅build_grid切换到revisions/granular_grid_23fb797.cu，按原版mul.wide.u32恢复unsigned粒子索引；
其它7个granular入口仍从接受基础版本选择。原基础文件/证明保持原SHA，使用build_host既有revision机制。
已接入free granular、authored/dynamic/mixed bond及静态shape的Newton/PD host，未改float运算。
完整solver仍未完成，source粒子密集场景尚在验证，solver_api_ready=False。所有GPU worker严格串行。
前一474feb41完整检查点已存affine-474feb41-validated-before-granular/，详见AFFINE_HOST_RECOVERY。

## 原版静态证据

从项目内64a0be7f原版生成的五份完整x86，位于`build/reconstruction-csrc/granular-host/`：

- initialize-reference.asm：`0x127fa0..0x12a0cd`。
- accumulate-reference.asm：`0x1269c0..0x12705b`。
- commit-reference.asm：`0x127060..0x127702`。
- multiply-reference.asm：`0x127710..0x127a4e`。
- preconditioner-reference.asm：`0x127a50..0x127adf`。

以下静态数据流已与8组cached及6组追加原版实际调用对应，相关host已接入：

| 事实 | x86证据 |
| --- | --- |
| grid／contacts先于两种bonds | accumulate的126d1c后跳126ada，contacts后跳126b33，再126e00初始bond、126d30动态bond |
| 每轮清空head=-1、全粒子mat3 diagonal=0 | 126a06..126a62，slots×4和particle_count×36 |
| gran相关启动128线程 | accumulate 126a98，multiply 127760；不能沿用PCG的256 |
| 单元格宽度2*max_selected_radius，动态bond存在时再加formation_gap | initialize 128ed8..128efd，严格分步addss |
| hash slots=2*ceil_pow2(grain_state_count) | 128f15..128f48的doubling循环 |
| 粒子数及bond容量有int32上限检查 | 128e86..128ea8：grain<=0x1fffffff，其它计数<=0x7fffffff |
| authored bonds仅cohesion>0且bond_count>0时启用 | 1290f9..129111；dynamic capacity另由adhesion分支确定 |
| commit没有任意bond时提前返回 | 12707f..127091 |

Granular对象最前面保存1864B原Model；静态可见计数：748 grain、74c particle、750 slots、754 authored、758 dynamic、
75c cell_size、760 dt。View120B的11个pointer后面是count/slots/cell_size/stiffness/friction/friction_damping/dt。
不要以此伪造私有对象或把整个opaque Model当作已恢复；和fluid一样只确认kernel实际读取的命名字段。

## 实际捕获与当前结果

`granular_host_scene.py`已运行原版/source各14组三步。包含isolated/cached/>32 contact fallback布局、authored/dynamic/mixed bonds、
Newton/PD、多world、非连续粒子subset及静态平面接触。优先从小case抓真实原版。
已为8个granular入口补齐ABI（127项宽度/签名检查通过），独立hook为granular-host/cudahook.so，
hook-build.json保存命令和SHA；W view最后4B padding单独屏蔽，Model只比较上述kernel实际读取字段。
未覆盖fluid的114入口hook或affine的119入口hook，修改前C/audit源码及affine hook在hook-before-granular/。

前一76790908的175项行为（103 granular constructor+72 radius分层）全部类型/错误消息/接受结果相同；36ca7d36已完成同项复测。
14组全部自有调用完整元数据/覆盖数相同；12组状态严格逐位，fallback Newton/PD严格失败保留。
3edc2cae最初4处radius错误层次不同已按实际原版x86修正；不是只替换granular错误字符串。
原版Solver initialize的radius检查条件是shape_count或collision_particle_count，允许0/Inf但不许负数/NaN；
SelfCollision再对所选碰撞粒子要求radius finite正。72项含未选中粒子、重复/非法index与无shape/有shape，全部相同。

密集案例：64行各63邻居，全走>32 fallback。首次4份grid输入重放（grid-probe-af4580ad/）
的force/B/count、各2048 cache槽及首次tangent全逐位；4次首次链恰相同，但原版完整step自身已经不同。
更完整的step-trace-af4580ad/中，真正首次不同在launch7的head/next，4个bucket两个warp的链接顺序不同；
位置/前态/radius/IDs/world/cells及初始RHS相同，下一次contact才出现force和diagonal差异。
granular_step_replay.py对双端3轮force及15个CG tangent各自实际输入独立重放，6次force/B/cache、30次tangent全部逐位。

历史af4580ad：PD8原版/3固定source outside=[]，Newton固定source0在8/16/32原版下仍有particle_q两项未过。
全部失败及源候选原样保留在dense-{mode}-fixed-af4580ad/，不能改判或用新image候选替换。
前一76790908：Newton复用同32原版、PD复用同8原版，各采3条当前image固定source，全部outside=[]，
严格状态仍均不同。source0使用当前image第一份matrix失败NPZ，另两条各采一次；所有复制记录SHA。
有效正索引的signed/unsigned地址本来相同，因此不声称索引修正数学上解释了调度顺序变化。
当前结果在validation-76790908/，grid-kernel-replay-76790908/另有8份实际grid输入48点字段数组严格相同、链全合法。

history-76790908/六组30步（plastic/break/form×Newton/PD）：180步状态和21,210次完整自有调用逐位相同。
plastic每模式3次历史缩短和2断键，break各2断键，form各12成键及12断键，来自真实history/active dump。
history-76790908-strengthened.json对后来inactive但已初始化的pair/rest/history继续核对：3612项全过，
含3040条inactive键观察；原2160项缓冲区核对和raw dump也保留。没有只凭参数配置认定分支覆盖。

官方snow-first-76790908/（resolution8/substeps1/iterations3/linear5/no-capture）三步正常，482次调用同，
但q/qd从子步1严格不同，正在定位，尚未把它写成通过。
snow-trace-76790908/是新增诊断脚本dump下标错误导致的SIGSEGV失败，不是求解器差异证据；
已按真实ABI修正并为所有dump参数加pointer类型守卫，新抓取目录snow-trace-abi-76790908/。
snow-trace-abi-76790908/已定位：grid链顺序先不同，但第一轮contact输出相同；首个算术差异是
launch9作者bond的force12word、diagonal21word，实际输入相同。snow-replay-76790908/18个contact及90个product全逐位。
snow-bond-audit-76790908/安全抓取117条作者bond完整数组，仅抓first-call，未将该大小用于动态bond调用。
全部live且非coincident，因此拆分不共享端点不会更改ID相关分支；原版PTX/当前source的force、diagonal、tangent全逐位，
且两端26粒子各312个实际累加标量都由具体float32排列精确复现，各5280个未触及标量未变；
exact-witnesses.npz保存terms/target/before/排列。局部原子证明不等于整段已经通过。

snow固定第一失败source0及其它两条各采一次：8、16、32原版时所有3步均在原版留一spread内，
但source0 q/qd的ratio_max高于原版自身留一worst ratio的额外严格观察仍失败。
32时q约0.96875比原版0.9677419369，qd同数量级；三份原source固定未换，全部失败保持原样。

validation-long-76790908/graph60/已完成：3个world/seed ×4种bond ×Newton/PD ×eager/graph，各60步，
双端共5760物理子步；48份双端轨迹及48份自身eager/graph比较，合计96项全部严格相同、finite，
mixed同时有非连续subset与实际静态软接触。
snow60为官方resolution8简化迭代的60步，9545次调用完整同，q/qd严格不同，最大3.91e-5/6.04e-4；
snow-default3使用官方缺省resolution16/6substeps/6NL/24CG，18子步22,037次调用完整同，状态严格不同。
76790908的旧74组完整回归完成：71严格通过，particles seed1/2/3的35/28/14数组严格差异保留。
36ca7d36的完整复核输出为validation-36ca7d36/，已完成；结果见下方36ca7d36更新，不把旧image结果直接算为当前通过。

csr-before-76790908/实际确认原版x86 1292b9..1292ac的单向min→max CSR：原版offset=[0,1,2,2,...]、
columns=[1,2]；旧source为[0,1,3,4,...]与columns前缀[1,0]。零cohesion的原版仍保留这2个条目，
而旧source明确拒绝。原来状态相同不能证明这个内部布局已经正确，before失败记录完整保留。
36ca7d36已按实际数组恢复：初始bond的力仍仅cohesion>0启用；排除CSR始终读取authored pair，
只在较小grain行保存较大grain列，不受端点顺序影响；移除已经确认的零cohesion+adhesion保护拒绝。
csr-after-current/的12组30步验证已完成（反向端点、world/seed1/2/3、非连续subset），
每端360步状态严格相同、finite；216项真实buffer检查及46,320次完整自有调用全部相同。
修改前完整检查点granular-76790908-before-csr-canonicalization/含393份源/构建副本、29206份结果SHA。

Snow三步额外ratio误报另有CPU证据：snow-first-observation-selfcheck-76790908.json。
固定source0完整q/qd三步与original1逐位相同；使用同一完整cohort基准，11条原版也会被旧额外ratio规则误报。
这条额外规则的两边基准不对称（K vs K-1内部leave-one-out）；未修改旧判断或失败报告，不能据此改float算法。
接下来先验证并还原此CSR细节，再继续更大官方示例、self-collision等剩余host。
来源kernel：`kernels/granular.cu`、`kernels/model.cuh`及unsigned索引revision；冻结基础数学不改。

先确认没有其它GPU批次，再开始：

```bash
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --worker original --tag capture --example reconstruction/csrc/granular_host_scene.py \
  --frames 3 --output build/reconstruction-csrc/granular-host/NEW-original -- --bonds mixed
```

该命令需要先创建新的output目录。要记录内核完整参数，还须使用已经补齐ABI的独立LD_PRELOAD hook。
body/elastic/fluid混合仍未捕获且source明确拒绝；零cohesion+authored bonds+adhesion已由12组新image用例验证；不能说整个granular API已完全替代。
source当前constructor通过内存API构造数组；辅助CUB/Thrust runtime启动尚非全观测，没有声称完整辅助库host序列相同。
此阶段结果不能作为整个solver已完全替代的证明。


## 复现命令

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.radius_contract_ab --output build/reconstruction-csrc/granular-host/NEW-radius
.venv/bin/python -m reconstruction.csrc.granular_contract_ab --output build/reconstruction-csrc/granular-host/NEW-contract
.venv/bin/python -m reconstruction.csrc.granular_host_ab \
  --references build/reconstruction-csrc/granular-host/original-first \
               build/reconstruction-csrc/granular-host/original-extra \
  --output build/reconstruction-csrc/granular-host/NEW-matrix
.venv/bin/python -m reconstruction.csrc.granular_step_trace \
  --output build/reconstruction-csrc/granular-host/NEW-step-trace
.venv/bin/python -m reconstruction.csrc.granular_step_replay \
  --trace build/reconstruction-csrc/granular-host/step-trace-af4580ad \
  --output build/reconstruction-csrc/granular-host/NEW-step-replay
```

输出使用新目录，不覆盖原严格失败和旧候选。修改前的3edc2cae快照是granular-3edc2cae-before-radius-validation/。
最新命令、完整版本及仍未通过项目继续追加WORK_LOG。


## 36ca7d36 当前复核与诊断入口覆盖

`validation-36ca7d36/`已完成175项参数行为、14组三步（12严格、2 dense严格失败）、
六组30步history及inactive补查。新增disabled-cohesion/adhesion/subset/contact图执行分支，
`graph60/`现为120项比较全严格通过，双端7200物理子步；current dense固定3source分别对32/8原版全部观察通过，
严格仍false。74组回归已完成：70严格通过，4项严格失败；三项固定候选通过C10，particles seed2固定候选C40仍有一项未过。
官方snow60/default3严格失败及完整调用相同的事实保留。

另查明旧hook的127项检查含8个重复granular key，实为119个不同owned symbol，不能称127个独立入口。
新`build/reconstruction-csrc/full-owned-hook-129/cudahook.so`按实际ABI补齐10个缺失symbol（8新key，含3个residual），
静态布局覆盖精确129/129。旧granular hook二进制未改，原全部场景runtime SHA不变；现有颗粒场景的实际调用
均在旧覆盖内，逐场景launch count覆盖检查仍成立。另47库入口runtime仍未全部观测。
新hook的实际多seed测试准备使用`current_kernel_audit.py`，只读取当前64a0be7f PTX和当前36ca7d36的源码bundle，
source函数经digest守卫后从实际compiled C++ .so取得，冻结fixtures/spec不改，不导入原版_core。
已完成audit-serial-36ca7d36/：三seed共18组，354份数组逐位、调用元数据相同；实际执行41个不同入口，
包括新补的全部10个symbol。不能记为129个入口都已运行。

```bash
.venv/bin/python -m reconstruction.csrc.granular_csr_ab --frames 30 \
  --output build/reconstruction-csrc/granular-host/NEW-csr
.venv/bin/python -m reconstruction.csrc.granular_graph_ab --frames 60 \
  --output build/reconstruction-csrc/granular-host/NEW-graph
LD_PRELOAD=$PWD/build/reconstruction-csrc/full-owned-hook-129/cudahook.so \
  .venv/bin/python -m reconstruction.csrc.current_kernel_audit \
  --output build/reconstruction-csrc/full-owned-hook-129/NEW-audit
```

必须等前一个GPU批次结束再执行下一命令；所有输出使用新目录。source image实际摘要必须匹配本批build.json。
