# G1晚期关节驱动切线：真实前后输入、实际SDK隔离与GPU原子证书

固定原版SDK64a、活动host38b70dcd、公共Core7eb6e847、CUDA176/f0均未改。
本轮只新增诊断/证据，生产数学、配置、阈值、旧失败和默认入口不变，`solver_api_ready=False`。

## 选择与实际图快照

接[G1最后矩阵核对](G1_LATE_MATRIX_RECOVERY.md)，向前核第六子步、最后NL/CG轮的
`multiply_joint_drive_tangent`（原图rank17453）。它属于G1中资源属性不同的内核：
SDK寄存器72/max threads896、源码80/768；规范化PTX也不同。不能仅因文本或资源不同就改数学。

旧正常公共Core worker只增加诊断attach/record调用，示例本身未改。
每端预先固定一次、60帧真实graph/test，两端严格串行，均实际退出0；源码无A/B bridge、无原版映像映射。
239输入SHA含203资产、生产源/库和诊断工具，当前43个drive、44个body、49个DOF、176个粒子。
每帧保存18个实际pointer字段的调用前字节及完整累加器调用后字节，共15416字节。
这次有真实before累加器，没有用受控零代替。

快照在诊断graph中插入：只新增一个设备buffer及19个D2D节点。
原17467节点/17466边全保留；新17486节点/17487边仍有唯一拓扑次序，18次before复制严格在目标前，
一次after复制严格在后续angular-limit核前。逐边、句柄、源指针、offset及完整覆盖已独立CPU核对。
这些额外节点和分配会影响原子调度，不能当作旧11条冻结轨迹的复现；生产图和源代码没有改变。

两端各60，共120份完整packet；每份drive调用实际改变183至265个累加器标量（按端范围见报告），不是无效路径。

## 实际SDK、原版PTX、独立源码的同输入回放

每份packet保留实际重叠及指针mod256对齐，在同一组buffer、真实before字节上轮换运行三端。
全部完整after buffer和累加输出保存；另记录原版/源码PTX各线程真实atomic地址、值与次序。
两端均72个静态原子site，本例43个活动lane各24次，后213个lane无操作。
全部120份输入的逐线程、逐目标序列相同；独立CPU进一步确认整个每线程跨目标序列也相同。
两端共247680个实际原子操作数保存并重核。

完整向量与各自实际捕获after逐位匹配为：

| 后端 | 匹配/120 |
| --- | --- |
| SDK64a实际runtime | 116/120 |
| 原版PTX | 116/120 |
| 源码PTX | 119/120 |
| 原版操作数探针 | 112/120 |
| 源码操作数探针 | 111/120 |

未把其余向量改判严格相同；逐项输出和差异都保留。
600份回放/探针完整输出及6715200个非输出字节由CPU直接从after原始数据重核，确认输入未被修改。
这次不像上一轮最后矩阵的unwritten检查只有运行布尔值，而是保存了可重核的完整after字节。

## 实际SDK逐drive隔离，包含零值符号

为避免只依赖PTX探针，对120份输入的43个drive逐一做三端实际调用，用+0和-0两种输出初值。
W1的drive k移为唯一local drive0，所有drive-local数组同步指向原k行，count/local改为1；
body/DOF/particle数组不改，particle-world宽度仍176，原三维geometry不变。
120×43×2×3=30960次调用全部三端逐位同，16346880个输出标量字也已从保存数据重核。

每个原线程对某个目标最多一次原子写，隔离输出还与原真实线程操作数在对应初值上的结果逐位同。
因此没有把错误的drive重排后得到的三端相同，当成原drive已验证；输入映射和零值符号也经实际SDK输出核对。
隔离任务较长时核查了真实session/PID和GPU活动，等待同一任务完成，没有因观察超时重启或并行GPU任务。

## 真实before初值上的63370份GPU标量证书

采用所有捕获、三端回放及双探针的输出，没有筛掉不一致标量。
每个packet/标量位置的所有不同目标共63370份（基础63360份加10份额外目标），先固定到plan。
每个目标最多4个实际操作数；保留所有值，包括符号零，并保持每线程对同目标的顺序。
本例同线程同目标仅一次，逐标量穷举合法排列，所有目标均找到匹配。

新GPU核`audit_variable_atomic_folds`对每份证书先写真实before位模式，再执行真实`atom.global.add.f32`；
63370个最终值及123860条GPU累加前值全部与独立CPU从真实操作数重算的值逐位同。
初值没有合成，所有原子操作数都来自实际运行的原版/源码PTX，实际SDK隔离结果也核对了对应单线程算术。

这些是逐标量合法次序证书，不证明所有位置同时采用某个单一全局线程/warp调度，
也没有推断旧运行的真实顺序。不能把它外推成整段G1或旧23.85尖峰已解释。

## 冻结失败与下一步

新诊断轨迹与旧11条均不逐位相同；相同固定C8原版范围下，原版四字段within为44/48/43/46，
源码为58/53/58/55（各60帧）。两端仍未通过固定整段C。
本轮最大速度字段偏差原版1.73232、源码1.32446，没有复现旧source1的23.8513。
旧八原版/三源码及报告SHA32b6e2a7…保持不变，没有扩基准或放宽门槛。

目前这120份晚期drive输入，没有发现尚未解释的单线程算术或逐标量累加差异。
下一步向前核最后一轮rigid contact tangent：它的输入x随后被覆盖，继续真实图内before/after快照，
完整捕获计数、contact记录、材料、body数据及累加器，按SDK实际隔离/三端回放/实际原子操作数协议核对。
不要重复已经闭合的最后矩阵/drive路径，也不要用q_out减dx猜回原始F32位置。

## 数据和命令

根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-drive-tangent/`。

- `plan.json`、`closed-packets.json`：预先固定两端、输入SHA和120份packet SHA。
- `original/`、`source/`：原图定义、修改后实际拓扑、快照布局、as-run worker、完整NPZ及正常入口runtime。
- `replay/`：600份输出、完整after buffer、原子记录/计数和全部差异状态。
- `isolation/`：全部30960次SDK/PTX/source调用输出及与真实线程操作数的核对。
- `certification-plan.json`、`certificates/`：全部63370目标、真实初值、值/lane顺序、GPU输出及逐项历史。
- `independent-cpu-audit.py/json`：完整原始数据重核，包含图依赖、输入字节、SDK隔离、证书及固定C统计。

成功执行的CPU审计精确源码另存`independent-cpu-audit-as-run.py`，SHA与报告一致；维护文件只拆分一条129字符断言，
`audit-script-formatting.json`确认AST相同，没有改变审计算法或重跑GPU来替换原结果。

所有任务已实际结束0：capture session25052、replay6153、isolation39324、certificates83856、CPU55629。
生产未改，没有为了这项诊断再重跑74项。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-drive-tangent
.venv/bin/python "$phase/independent-cpu-audit.py"
.venv/bin/python -m reconstruction.csrc.g1_drive_tangent_replay \
  --capture "$phase" --output build/NEW-g1-drive-replay
.venv/bin/python -m reconstruction.csrc.g1_drive_tangent_isolated \
  --capture "$phase" --output build/NEW-g1-drive-isolation
.venv/bin/python -m reconstruction.csrc.g1_drive_tangent_certificates \
  --capture "$phase" --output build/NEW-g1-drive-certificates
```

上述回放/隔离/证书使用已闭合数据。重采每端必须选新目录并严格串行：

```bash
.venv/bin/python -m reconstruction.csrc.g1_drive_tangent_capture --backend original --frames 60 \
  --abi "${phase%-drive-tangent}-graph-definition/abi.json" --output build/NEW-g1-drive-original
```

另一端使用相同参数、独立新目录及`--backend source`。Windows继续根交接的WSL2固定Linux对照流程；
旧绝对路径数据不改字节，异目录需映射旧repo前缀并核对资产缓存，没有新增原生Windows验证结论。
