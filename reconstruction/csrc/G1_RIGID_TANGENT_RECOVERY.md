# G1晚期刚体接触切线：真实图内输入与600份完整输出逐位一致

固定SDK64a、活动host38b70dcd、公共Core7eb6e847、CUDA176/f0均未改。
本阶段只增加诊断和证据；默认入口、数学、配置、旧失败、固定基准及阈值不变，`solver_api_ready=False`。

## 本阶段已经确认什么

接[G1驱动切线](G1_DRIVE_TANGENT_RECOVERY.md)，选择第六子步最后NL/CG的
`evaluate_contact_tangent`，原图rank17451，geometry为4 blocks、每block256线程。
本例容量1000、105 shapes、44 bodies、176 particles、一个world。
这是向量乘积路径：参数33/34的system/preconditioner指针都为NULL，不能据此声称矩阵输出分支已验证。

两端各一次60帧正常公共Core真实graph/test，均退出0；源码没有bridge，也没有映射原版求解器。
每帧保存25个非空指针的完整before字节及输出30的完整after字节，共94692字节。
真实累加器初值已经捕获，没有用零值或q_out减dx重建原输入。
原17467节点/17466边保留，新增一个buffer和26个D2D节点，变为17493节点/17494边。
唯一拓扑次序、全部before位于目标前、after位于下一soft tangent前，均由独立CPU核对。
这些诊断节点会影响调度，不能当作旧冻结轨迹的逐位复现。

全部120份真实输入保留指针重叠关系、mod256对齐及实际geometry，使用同一组buffer轮换执行：

| 后端 | 完整输出与实际捕获after逐位相同 |
| --- | --- |
| SDK64a实际runtime | 120/120 |
| 原版PTX | 120/120 |
| 源码PTX | 120/120 |
| 原版原子操作数探针 | 120/120 |
| 源码原子操作数探针 | 120/120 |

600份完整输出全部达到既定严格标准。120次中53次确实改变输出，不能称全部120次都走了有效接触分支。
计数前缀共2017个contact线程，其中1769线程提前退出、248线程各执行24次原子操作。
两端11904个实际原子操作数的逐线程、逐目标顺序及整个每线程跨目标顺序全部相同。
每线程对同目标最多两次，正常/摩擦贡献的顺序均保留；没有把它们交换后再比较。

独立CPU直接重核保存的全部600份输出、54280800个非输出after字节及11904个原子操作数，全部通过。
原版/源码规范化PTX仍不同：各有75个静态原子site；资源分别为83/93寄存器、128/96 local bytes。
没有为消除文本或资源差异擅改生产源码或launch配置。

曾在CPU准备阶段生成逐contact隔离及标量证书计划；在600份完整输出全部严格通过后，没有启动这些额外GPU任务。
两个原始计划及后续明确的未执行说明都保留，没有删除失败，也没有改变验收标准。
replay生成器首次CPU检查因预期替换次数3而实际为2退出；旧版本/错误保留，修正后才启动GPU回放。

## 整段失败仍然存在，接下来核哪里

新诊断轨迹在旧固定C8范围内的四字段帧数：原版51/52/51/52，源码60/59/59/59，均未通过整段检查。
本次最大速度字段偏差原版1.45927、源码1.12518；没有复现旧source1的23.8513尖峰，也没有解释它。
旧八原版、三源码及报告SHA32b6e2a7…不变，局部通过不能升级为完整solver等价。

下一步转向第六子步首次NL的接触力/RHS及矩阵构造：

1. 原图rank14576的`evaluate_contact_force`：完整捕获真实before及两个非空输出32（RHS）和33（对角）。
2. 同NL的rank14587接触切线：方向29/乘积30为NULL，矩阵33/34非空，核本轮未覆盖的矩阵输出分支。

实际参数和类型已只读检查并保存为`next-rhs-force-inspection.json`；这两项尚未做GPU捕获或回放。
先核两输出的大小、alias/重叠及graph快照依赖，再捕获；不能假设两矩阵天然无重叠，不能猜原F32输入。
有严格差异才继续SDK/PTX/source实际回放、隔离和真实F32原子证据；已严格通过的路径继续下一项。

## 数据、命令和接续

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rigid-tangent/`。

- `plan.json`、`closed-packets.json`：输入与120份packet SHA、实际计数及资源属性。
- `original/`、`source/`：原图/修改后拓扑、布局、真实before/after、60帧状态、正常入口runtime及as-run worker。
- `replay/`：全部600份输出、完整after buffer和真实原子记录，不只保存通过布尔值。
- `independent-cpu-audit.py/json`：图依赖、完整原始字节、操作数、严格匹配及固定C统计重核。
- `optional-plans-as-prepared/`：未启动的额外计划；`cpu-generator-preflight-error/`：GPU回放前的CPU错误。

维护工具`g1_rigid_tangent_capture.py`、`g1_rigid_tangent_replay.py`按固定SHA模板做精确、带次数断言的派生。
实际生成的capture/replay源码全部随证据保存；旧drive工具没有修改，旧证据的输入SHA仍有效。
任务已经真实结束0：capture session54085、replay51654、独立CPU93048。
生产未改，没有因此重跑74项。Windows继续WSL2和固定Linux对照，原生Windows移植尚未完成。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rigid-tangent
.venv/bin/python "$phase/independent-cpu-audit.py"
.venv/bin/python -m reconstruction.csrc.g1_rigid_tangent_replay \
  --capture "$phase" --output build/NEW-g1-rigid-replay
.venv/bin/python -m reconstruction.csrc.g1_rigid_tangent_capture --backend original --frames 60 \
  --abi build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-graph-definition/abi.json \
  --output build/NEW-g1-rigid-original
```

重采源码端用`--backend source`及另一新目录，两端GPU任务严格串行，不覆盖已闭合记录。
