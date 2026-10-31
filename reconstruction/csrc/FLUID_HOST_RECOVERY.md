# Fluid host 还原进度（2026-10-30，继续中）

完整 solver 替代尚未完成。当前活动image：
`474feb416eb76ad28927a7fdc30667c2c3d8b2f6ada68cab93ed6dd18d9afb4c`。
最新刚体刚度工作见[AFFINE_HOST_RECOVERY.md](AFFINE_HOST_RECOVERY.md)。下述默认流体阶段是db4c9be1的证据。
唯一参考仍为项目内 `64a0be7f…` / `23fb797`，双方均不登录。
CUDA数学未改，176入口/27模块digest仍为 `a98e84b9…`；当前只恢复host调度与校验。

前一完整材料/既有回归检查点为 `validation-09616a3d/`：57+97项contract全同；6组fluid/material共180步逐位，
29,220次step调用完整元数据相同，5份ELL有效buffer逐位；24项graph比较全部逐位。
同image74组既有回归71严格通过；3个particles seed严格失败均保留，固定候选经10/10/20原版按C标准通过。
seed3最初10原版时7数组失败，保留全部数据增至20才通过；未重选source，未改epsilon。
原版Newton每步的block ELL初始化、RHS零惯性ELL和无body时允许rigid容量均按真实调用修复。

BVH库桥接已在3be3a508接入真实source Solver：15入口PTX全部等于已验证source。
9种constructor（1至65537粒子）的69份有效缓冲区和43次自有调用元数据全部相同，
见bvh-native-comparison-3be3a508/。库runtime启动尚未完全观测，step self collision仍未接入。
3be3a508又完成180步材料组合、29,290次完整自有调用、154项contract及24项graph，全部相同。

3be3a508的三world耦合：固定3条source与32原版观察outside=[]；旧40333acf失败仍保留。
官方fluid resolution8的3步固定候选在8/16原版时失败，保留同候选扩至32原版后outside=[]；
60步固定3条source与8原版观察outside=[]，完整12,125次自有调用相同。严格状态均仍有差异。
真实hash链顺序在原版自身重复时也不同，4份原版/source输入独立重放evaluate_rows全出口逐位相同。

默认resolution32的3帧=6步在3be3a508发现600次soft product启动grid不同。
原版x86 fb7cf..fb7ea明确32-block上限，source kernel已是grid-stride，只修host上限。
db4c9be1重新核对6,047次短程、120,845次60帧完整自有调用全部相同；
默认60帧8原版/3固定source按既定观察outside=[]，严格仍false。
85,056点/36,864行的4份实际grid输入独立重放全出口及每份1,001,388有效cache槽逐位同。
当前474feb41正在复核默认长程与既有回归，不能继承旧image结果为本image最终验收。
因发现grid差异而停止的旧60帧数据保留，不作验收。各image证据不可混用。

## 当前实现

- FluidView112字节：10个pointer、4个int、4个float。
- GPU Model1864字节与Python公开Model是不同ABI；只按原版填充已确认实际读取的字段。
  hook保存完整raw Model，但只审计kernel读取的字段，不声称opaque区域已全部还原。
- 网格容量为 `2*ceil_pow2((NF+NB)*copies)`；每行64个缓存槽，超出后进入fallback遍历。
- 调度：RHS → fluid grid/evaluate/accumulate → contacts/materials；B correction在soft contact之后；
  每轮CG中SO3 tangent → fluid multiply → contacts；apply前initialize/bound/scale全体solution。
  fluid kernel128线程，PCG256线程，PD保留原本NonZeroEntry分派。
- 校验：全体mass finite非负；fluid所选mass finite正、flags bit0有效，缺省flags视为active；
  indices范围/重复、boundary有限性与正体积，错误消息均按原版。
  只有NF>0才检查fluid relaxation和maximum step ratio。

## 证据和未通过项

下列为历史与当前证据，路径均在 `build/reconstruction-csrc/fluid-host/`；每份runtime标记各自image：

| 路径 | 结果 |
| --- | --- |
| contract-after-validation/ | 01840007的57项参数/错误行为全部相同，含两端image SHA |
| matrix-01840007/ | 24组×30步，22组严格通过；Newton/PD的s3-w3-v3严格失败，NPZ保留 |
| graph-01840007-v2/ | 3配置×2模式，原版/source及各自eager/graph共24项比较逐位通过，720个记录子步 |
| source-call-fixed/ | 40333acf的5组fluid step元数据330/705次全部相同；fallback状态严格失败保留 |
| fallback-grid-probe/ | 3次原版与1次source的grid全有效；head/next顺序在原版自身重复时也不同 |
| fallback-grid-replay-40333acf/ | 4份真实输入经source evaluate_rows，逐元素出口及每份8000个写入缓存槽全同 |
| fallback-distribution-40333acf-8o3s/ | 固定旧失败source0，8原版/3源码观察outside=[]；strict三条仍false |
| coupled-world3-pcg-all/ | 前15次PCG捕获；首差异在第一次denominator的world2原子归约值 |
| pcg-replay-01840007/ | 90次真实输入重放，逐元素全部相同；24个aggregate严格不同，均找到具体float32排列 |
| coupled-distribution-40333acf-{8,16,32}o3s/ | 同3条固定source候选均未通过全部分布指标，不能标记耦合验收通过 |
| original-first/ | 原版5组fluid及6组其它affine模型捕获；后6组尚未接入source host |

01840007三world首个差异：36个逐粒子乘积相同，world2的12个贡献和，原版为 `0x3e919c40`，
source为 `0x3e919c3f`；能用相同贡献的具体排列逐位重现。之后residual/方向才不同。
这不能单独证明整段轨迹通过。32原版观察时source1的body_q/particle_q最大ratio仍超原版最坏值。
另存criterion-c-per-substep.json也仍有outside，不能用其它聚合方式掩盖。未加epsilon、未重选source候选。

## 必须继续

1. db4c9be1已核对soft product容量8191/8192/8193/405504，Newton/PD共8组全部状态和4,876次调用相同。
2. 当前474feb41复核官方examples/example_fluid.py默认resolution32的60帧；db4c9be1此阶段已完成。
   使用--no-capture记录每个子步；小场景graph验证不能替代此默认规模验证。
3. BVH constructor自有调用已接入；辅助库runtime启动尚未完全观测，不能虚报全覆盖。
4. 完成当前image既有粒子/材料/刚体回归；不能将09616a3d或3be3a508通过计给新image。
5. 其它affine model、joint PD、混合particle materials/body、granular和self collision等host仍未完成。
   solver_api_ready=False正确，不能提前改为true。

## 命令

在仓库根用.venv/bin/python；全部原版worker严格串行。输出必须使用新目录。

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.fluid_contract_ab --output build/reconstruction-csrc/fluid-host/NEW-contract
.venv/bin/python -m reconstruction.csrc.fluid_host_matrix --keep-going --output build/reconstruction-csrc/fluid-host/NEW-matrix
.venv/bin/python -m reconstruction.csrc.fluid_graph_ab --output build/reconstruction-csrc/fluid-host/NEW-graph
.venv/bin/python -m reconstruction.csrc.fluid_pcg_replay \
  --captures build/reconstruction-csrc/fluid-host/coupled-world3-pcg-all \
  --output build/reconstruction-csrc/fluid-host/NEW-pcg-replay
.venv/bin/python -m reconstruction.csrc.fluid_grid_replay \
  --captures build/reconstruction-csrc/fluid-host/fallback-grid-probe \
  --output build/reconstruction-csrc/fluid-host/NEW-grid-replay
```

chaotic_source_runs.py支持额外例子参数和显式--launch-hook；reuse检查hook SHA，禁止有/无钩子混用。
历史runtime缺hook字段的，只在新baseline副本补注，原runtime/launch log/NPZ SHA另存adopted-captures.json。
graph第一版因无body场景字段为None而失败，未进入数值比较；日志保留，v2判空修复后全部通过。
其它命令、来源和失败继续追加reconstruction/WORK_LOG.md。
