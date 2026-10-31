# Cable、硬接触和完整刚体块：恢复与验证

基准仍为项目内 `64a0be7f…` / `23fb797`，不登录、不读凭据、不修改原版。
只修改 reconstruction/ 和 build/。所有 original worker 严格串行。
总体目标尚未完成；这些结果不能代表整个 so/全部 demo 已经替代。

## 目前实现和证据

| 构建 | 本批结果 | 证据目录（相对 build/reconstruction-csrc/） |
|---|---|---|
| 225208b0 | Cable Newton/PD：24组、720子步状态逐位一致；420组penalty快照一致 | cable-host/matrix-225208b0/ |
| 225208b0 | Lazy配置校验和copy/reset尺寸、错误优先顺序：538项全部相同 | cable-host/contract-225208b0/ |
| d950ad0a | Hard contact Newton/PD：24组、720子步状态逐位一致 | hard-host/matrix-first/ |
| 93d378aa | 完整body-block 24组720子步及CUDA Graph 8项逐位通过 | hard-host/block-first-source/、block-matrix-93d378aa/ |

表中每项只适用于其记录的实际image。最终回归必须使用同一最终image，不能挪用历史构建的通过项。
完整SHA、fixture SHA、命令和原始输出在各worker的runtime.json及日志中。

当前活动image为`814c5abf4e235428172d7730daf29888145282e754d1855db196487c78ae3fbc`。
其cable+普通接触582次、cable+hard+block696次调用与3步状态一致；
hard内部Newton/PD各366份buffer及612/609次调用一致。
本image又完成cable+block 24组720子步/420个penalty快照、cable+contact 30组900子步严格比较，
包含no-contact-block和运行中扩容至5000。graph 8项和contract 538项在同一image再次通过。

74组既有回归：70组严格通过；particles三seed各7项、mixed_cloth seed3共11项严格差异保留，
固定本批source NPZ不重选，每组用10原版通过既有标准C。混合布料实际输入下的独立力/Hessian贡献
与原版逐位一致，累加输出均有具体float32排列解释；这不等于严格全轨迹相同。
汇总：`build/reconstruction-csrc/cable-host/final-814c5abf/validation-summary.json`。
最终本批检查点：`build/reconstruction-checkpoints/cable-hard-814c5abf-validated/provenance.json`，
保存191份源码/构建，10795份结果hash。

## 恢复的行为

- Cable beta全0时penalty指针为NULL，不执行prepare/update；启用ramp时每step先prepare(false,true)，
  每轮prepare tangents，apply后update（包括最后一轮）。copy/reset仍会prepare，即使beta全0。
- Cable copy/reset先检查gamma、ramp/seed，再检查尺寸；无cable模型也执行配置校验。
  输出尺寸必须等于state count；空mask表示全部；非空mask必须恰好匹配。
- Hard initialize在惯性刷新和initialize_step之前；每轮force、B、CG tangent分别调用同一个evaluate。
  update_duals在apply后、SO3 update前；snapshot在velocity前，即使history=false也执行。
- Hard历史六数组扩容保留旧元素、清零新尾；previous_count首次0，之后扩容不会重置。
  history需要碰撞match index；history_refresh=false时复用上次query的slot状态。
- Body-block的enabled初始全1；两个body共享任意proxy粒子则两个都禁用完整块。
  cable邻接表按原始cable序号，pair同body只添加一次。此行为来自实际原版initialize反汇编。
- Body-block在逐粒子SO3/cable预条件器之前build，组装中自行加入这些项。
  hard cross cache可和output同址；每轮CG先3×3 apply，再12×12 apply，然后reduce(precomputed=true)。

CUDA数学实现仍为已接受的176入口/27模块，digest a98e84b9…；本批恢复的是C++ host。

## 官方 analytic cable 的差异：已定位第一处，尚未验收整个demo

`examples/cable/example_cable_bend_twist_analytic.py` 默认336个proxy粒子。
230次首帧launch元数据一致；缓存、初始力、预条件结果、direction、矩阵乘积逐元素相同。
首次不同是PCG原子求和标量，原版连续3次也有变化。

`cable-host/pcg-d950ad0a/first-pcg-comparison.json`保留3原版+1源码的逐缓冲区对照。
`exact-permutations/`使用完全相同的336个贡献值，找到具体float32求和排列，
逐位重现所有原版和源码的numerator/denominator值，没有增容差或修改生产计算。
这些排列不是对先前GPU真实调度顺序的断言，也不是完整轨迹已通过的结论。
814c5abf上已经完成60帧600子步的8原版/3源码观察，outside=[]；严格3条source均为false。
另捕获60帧13,800次完整launch全部同，首PCG16份有效buffer同。原版自身7次重复也均不逐位同。
统计不是逐步ratio均<=1；对照的是既有的原版留一法最差观察。全部原始数据保留在final-814c5abf/。

## 复现命令

在仓库根目录使用.venv；输出用新目录以保留失败。

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.cable_host_matrix --output build/reconstruction-csrc/cable-host/NEW-matrix
.venv/bin/python -m reconstruction.csrc.cable_contract_ab --output build/reconstruction-csrc/cable-host/NEW-contract
.venv/bin/python -m reconstruction.csrc.hard_host_matrix --output build/reconstruction-csrc/hard-host/NEW-hard
.venv/bin/python -m reconstruction.csrc.hard_host_matrix --body-block \
  --output build/reconstruction-csrc/hard-host/NEW-block
.venv/bin/python -m reconstruction.csrc.cable_host_matrix --body-block \
  --output build/reconstruction-csrc/cable-host/NEW-block
```

完整launch核对使用`audit_cudahook.py LEFT/launches.txt RIGHT/launches.txt --source-counts SOURCE/capture.launches.json`。
完整mangled symbol、3D grid/block、shared bytes和stream类型必须存在；比较参数不等于比较pointee数据。

## 当前未完成项

1. 本批cable/hard/block的上述验证已完成；后续仍要覆盖更多官方cable demo和未捕获配置组合。
2. 接fluid/granular/self-collision及其它affine rigidity分支；先抓原版再改C++，不凭名字猜实参。
3. 后续新image仍需相应回归，不能挪用814c5abf的通过项。
4. 仍未接通fluid/granular/self-collision等host、其它affine rigidity分支、部分混合拓扑/PD约束。
5. 最后逐个跑文档中的相关官方demo；源码worker必须无原版_core映射。

源码/证据检查点：`build/reconstruction-checkpoints/cable-225208b0-before-hard/`、
`hard-d950ad0a-before-block/`。以前0c44d52d完整回归检查点保持原样，详见JOINT_HOST_RECOVERY.md。
