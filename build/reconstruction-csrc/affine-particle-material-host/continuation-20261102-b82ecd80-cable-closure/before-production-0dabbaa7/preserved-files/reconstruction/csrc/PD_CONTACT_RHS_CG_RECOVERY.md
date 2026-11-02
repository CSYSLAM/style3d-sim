# PD多世界接触：RHS到首个CG差异的实际核对

主源码仍为host `0dabbaa7` / Core `7151054e`，隔离接触候选仍为 `4f638b4b`，唯一原版为项目内SDK64a。
本批没有改生产数学、资源、容差或准入条件，完整替换仍未通过。

## 本批新增证据

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-4f638b4b-pd-rhs-cg/`。

目标仍为 `w3-b1-n2-s1-mixed-pd-b0-both-hit0`，保留原worker六案例及eager/graph完整顺序。
预定1SDK和3独立source，共四worker真实退出0；source未映射原版SDK。
每帧记录90阶段，包含RHS初始化、颗粒接触、两类bonds、刚体/软/滚动接触力、SO3力、
原地预条件器求逆、全部15轮CG的四类操作及三次位置更新。
记录实际动态bonds与邻接缓存，没有从公开位置重建私有history。
刚体/软/滚动力仅记录定位需要的部分输入，未冒称这三类已经完成同输入计算证明。

每graph增加一份324984字节staging和684个只读复制节点；原276节点/275边保持，
新增后960节点/1139边。独立CPU检查八graph完整顺序、21600份阶段packet、2880个别名group及240份末轮公开位置。
原地inverse输入/输出的实际别名和颗粒cache的重复指针均保留并逐字节校验。
10类完整输入kernel的原版/源码PTX共20入口，实际写指针均属于所声明输出。
两个实际graph的全部已审计类型化参数、ABI/geometry及跨图129个pointer identity模式也一致。
Model仅核已审计读字段，10类资源属性差异没有被证明是根因，未调整资源。

首版采集在拓扑自检中失败：相邻阶段的before/after只读复制形成合法但非唯一的拓扑顺序，尚未启动目标graph。
v2把相邻阶段的before链接到前阶段after末尾；CPU先核八份真实模板的符号DAG，再实际采集。
首版脚本、root `pd_contact_rhs_capture.py`、日志与输入SHA全部保留；实际使用的是本证据目录的 `capture-observer-v2.py`。
后续不要直接调用首版的Observer；CPU审计仍可复用其不变的select_stages。

## 新观测中最早的数值差异

以下worker编号属于本批新诊断，不是旧固定C8中的source0/source1标签：

| 源码worker | frame | 首差stage | SDK第三组分母bits | 源码bits | 随后更新stage |
| --- | --- | --- | --- | --- | --- |
| 1 | 2 | 227，NL3/CG2 | 928287972 | 928287971 | 228 |
| 2 | 0 | 239，NL3/CG3 | 912742620 | 912742619 | 240 |
| 3 | 0 | 177，NL2/CG5 | 892000091 | 892000090 | 178 |

三处都仅先差1 ULP的第三组CG分母；此前记录的数值输出相同。
首差kernel的七份完整before跨度逐字节同，完整逐粒子Ap也同。
SO3使用展平的3/3/36，而CG真实参数为world=NULL、per_group=12，共三组；不能把这两种分组混用。

### 真实SDK、操作数与GPU原子证书

三份共同输入各固定四轮SDK runtime/原版PTX/源码PTX，保持实际geometry、全部输入、指针别名和模256地址偏移。
另读取原版/源码PTX真实原子操作数，保留原red指令；每份36个lane的108个原始F32字逐位同。
受控诊断仅把coefficient世界索引改为每lane独立输出，用真实SDK runtime、原版PTX及源码PTX核对324个有效贡献字，
全部等于真实GPU的zero+operand原子结果；完整Ap仍严格同。
这项索引映射只用于诊断，不是独立source轨迹，也没有修改native实际运行配置。
保存的是实际ABI和输出；受控map数组的创建代码已固定，未额外保存map读回字节，不能冒称CPU独立读回了该数组。

对SDK/source各三组、三份输入共18个捕获标量，各找到由相同实际操作数组成的顺序，并用真实GPU F32原子累加验证。
全部目标bits及216个逐步history字复现；这只是有效顺序证书，不声称推断实际全局GPU调度。
此批共72次真实调用；独立CPU重新核51个完整Ap输出、108个操作数字、324个隔离贡献字、
216个GPU history字、实际ABI及所有保存的只读/guard跨度，实际0。

### 差异如何进入向量

紧随三处首差的更新，六份完整before输入只有分母不同；方向、product、numerator、solution及residual均同。
SDK/source捕获的两向量分别有7/22、7/23、18/22个字不同。
对两侧各自真实输入做两轮SDK runtime/原版PTX/源码PTX，共36次调用：
每次的两个完整输出均精确复现该输入侧捕获的向量，全部只读/guard保持。
独立CPU重读7776个输出字及54个ABI参数，实际0。
这证明新增路径这一步的向量差由已记录分母差传播而来，同输入下没有发现CG更新计算差异。

## 不能据此宣布通过

四份新诊断均没有完整复现旧固定source0/original0；观察器会改变原子调度，所有新轨迹仅作诊断。
它们对既有C8的归属为SDK false、worker1 false、worker2 true、worker3 false，未向原cohort添加任何样本。
旧首source0的frame32/world2/body_q[2,3]越界保持；原版诊断也越界不构成改判理由。
本批证明的是新增路径的首CG差异及紧随一步传播，没有证明旧固定失败或整段长程差异全部闭合。
G1、复杂布料和其它未覆盖host组合也未被本批验收。

## 接续步骤

先读本目录 `next-step.json`、`rhs-independent-cpu-audit.json`、
`first-CG-independent-cpu-audit.json` 及 `first-update-independent-cpu-audit.json`。
下一批补真正CG extra/tangent形成过程，以及后期接触/预条件器形成的实际完整输入，
重点覆盖原固定长程仍失败的范围，不能只凭首处归约证书外推后面所有操作均正确。
使用本批实际维度与ABI；不可直接套G1的44刚体/176粒子长度，也不可猜造动态bonds/AL缓存。
不得改排序、编译资源、数学或阈值来凑C8；本候选仍不合入生产。

```bash
source scripts/reconstruction_env.sh
phase_root=build/reconstruction-csrc/affine-particle-material-host
rhs_phase=$phase_root/continuation-20261101-4f638b4b-pd-rhs-cg
# Inspect saved reports; these commands create no CUDA context and do not overwrite the sealed phase.
.venv/bin/python -c 'import json,sys; d=json.load(open(sys.argv[1])); print(d["comparisons"])' \
  "$rhs_phase/rhs-independent-cpu-audit.json"
.venv/bin/python -c 'import json,sys; d=json.load(open(sys.argv[1])); print(d["actual_calls"])' \
  "$rhs_phase/first-CG-replay/report.json"
```

原采集命令为 `run-rhs-v2.py`，每个GPU worker先等待空闲并严格串行；四worker均已实际结束。
同输入工具为 `python -m reconstruction.csrc.pd_contact_first_cg_replay --phase <新phase> --prepare/--execute`，
后续向量工具为本目录 `replay-first-update.py --prepare/--execute/--audit`。
这些命令会创建输出，重现时需新兄弟phase及相应计划/采集输入，不能覆盖已封存目录。
Windows仍按根交接使用WSL2，默认后端及readyFalse保持。
