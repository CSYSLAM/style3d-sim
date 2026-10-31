# Affine rigidity host 还原进度（继续中）

活动source image：`474feb416eb76ad28927a7fdc30667c2c3d8b2f6ada68cab93ed6dd18d9afb4c`。
参考仅项目内`64a0be7f…`，双方不登录。CUDA源码digest仍`a98e84b9…`，176入口数学未改。
完整solver尚未替代，`solver_api_ready=False`。

## 已恢复的调度

- SO3：原有力、预条件、切线及AL更新。新增核对alpha0：仍初始化SO3状态，
  跳过force/B/tangent/update；PD选scalar ELL，body-block选项在scalar分支不生效。
- SIX_SPRINGS：D1/L2权重是constraint_alpha，D2是0；force权重是alpha/(dt*dt)。
  Newton加已有Gauss-Newton Hessian，PD使用scalar矩阵，不调用此Hessian或matrix-free tangent。
- CO_ROTATED／ABD_ORTHOGONALITY：D1/D2均0；force、B correction、matrix-free tangent传真实enum 0／1。
  Newton和PD保留不同ELL模板；B correction在full body-block装配之前。
- 非SO3模型的full body-block仍传nonnull rotation pointer，但SO3权重是0。
  不比较该分支未初始化且未读取的rotation内存，不按猜测给它填物理值。

以上均依据真实原版调用；未更改kernel数学。其它模型与contacts、cable、joint或fluid组合尚未捕获，
当前仍明确拒绝；本阶段只新增自由刚体范围。

## 已完成与正在做

`build/reconstruction-csrc/affine-host/`下面：

| 目录 | 范围和结果 |
| --- | --- |
| original-3be3a508/ | 最初18组原版，各3步，3模型×Newton/PD×default/block/alpha0 |
| reference-complete-db4c9be1/ | 补齐32组原版，包含SO3与alpha0+block；18组严格校验输入版本后复用 |
| first-source-matrix/ | 当前474feb41的32组全部状态逐位，96子步、9,309次完整自有调用相同，hook覆盖数同 |
| validation-474feb41/matrix/ | 96组2,880子步逐位、279,270次完整调用相同；全部有限、hook覆盖同 |
| validation-474feb41/regression/ | 74组70严格通过；particles三seed及PD mixed seed3严格失败保留，固定各候选10原版C全部通过 |
| validation-474feb41/fluid-materials-full/ | 6组180步逐位，29,290次完整自有调用同 |
| validation-474feb41/bvh-compare/ | 当前真实constructor9组69份buffer、43次自有调用同 |
| validation-474feb41/fluid-default60/ | 当前默认60帧8原版/3源码观察outside=[]，严格仍不同；120,845次完整自有调用同 |

原版/源码worker全部串行，source进程检查原版_core未映射；每组保留运行image SHA及fixture SHA。
严格失败必须保留，不能改epsilon、重选候选或把旧image结果直接算给新image。

## 继续方法与命令

先检查`validation-474feb41/status.json`及`matrix/report.json`。本批已结束；总exit=1保留74组中的4个严格差异，
另存四份criterion-c.json及PD mixed同输入/原子贡献审计，不把总exit覆写成严格全通过。
该总批次的fluid154项contract、24项graph、6组材料及默认60帧当前source复核均完成。
PD mixed的36次真实力调用隔离104,490个贡献标量逐位、34,830个捕获写标量由精确排列解释；
324次PCG同输入重放405个逐元素、162个归约全部逐位。脚本和原始失败均保留。
status保存了每条精确命令。原子/混沌严格差异另按已有标准查首次差异、同输入重放、固定候选分布，
不能把调用元数据同直接称作状态同。

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.affine_rigidity_ab \
  --frames 3 --worlds 1 \
  --reference-baseline build/reconstruction-csrc/affine-host/reference-complete-db4c9be1 \
  --output build/reconstruction-csrc/affine-host/NEW-first
.venv/bin/python -m reconstruction.csrc.affine_rigidity_ab \
  --frames 30 --worlds 1 2 3 --output build/reconstruction-csrc/affine-host/NEW-matrix
.venv/bin/python -m reconstruction.csrc.joint_continuation_regression \
  --output build/reconstruction-csrc/affine-host/NEW-regression
```

不要同时运行上面多个GPU命令。只能修改reconstruction和build；不要改src、examples、依赖、原版so或登录代码。
每批继续追加WORK_LOG，变更前保存活动源码/构建/so与已有结果SHA。

## 前一fluid阶段

db4c9be1修复软接触product的32-block上限后，官方默认resolution32的60帧=120子步：
120,845次完整自有调用相同，8原版/3固定源码按既定分布观察outside=[]；严格仍不同。
85,056个grid点/36,864行的4份实际输入在source独立重放全部逐位，每份1,001,388个有效cache槽同。
这些是db4c9be1证据，当前474feb41需复核。详情见FLUID_HOST_RECOVERY及WORK_LOG。
修改前快照`build/reconstruction-checkpoints/fluid-db4c9be1-before-other-affine/provenance.json`。

## 仍未完成

其它affine模型的组合调度、joint PD/penalty、body+particle材料、granular、self-collision step、hinge等host，
以及所有官方demo覆盖和最终完整替代。BVH constructor已接入；辅助库runtime启动尚未全部可见。
