# ANYmal脚部几何与真实native接触核（2026-11-02）

目标仍为恢复源码Core715/host0dab替代固定项目SDK64a。本阶段不改原例子、solver、config、阈值或旧cohort。
上一阶段b2f807e3已推，310859冻结文件全核0失败；本阶段开始tracked clean。
GPU实查余20330MiB，允许外部任务，自己的worker始终串行，每个GPU诊断有free>=4096MiB准入。

## 几何及同一状态的真实一步

分别构造原/源同一诊断模型，恢复各自固定同步副本Graph500的最终state，再跑实际Newton碰撞管线。
两端各136刚体、441形状，32脚部均为真实碰撞球；可见mesh不作碰撞球解释。
静态shape参数/材质/bodyCOM全部逐位相同，各160接触shape-pair多重集同。

| 后端 | 真实球面最低点范围(m) | 原高度界限 | 结论 |
|---|---|---|---|
| SDK64a | -0.03598875至-0.03406965 | -0.006 | 32脚部真实穿透 |
| Core715 | -0.03590786至-0.03409388 | -0.006 | 32脚部真实穿透 |

独立CPU分别由shape球心/半径和接触world point/normal/margin计算，两种途径都确认穿透。
没有用body原点偏移掩盖几何穿透，也未修改原例子的高度界限。

另用同一份冻结SDK最终state作为两端起点，实际各step一次。四个public state数组初值逐位同，输出仍不同：
particle_q最大分量差0.0003427672，particle_qd0.06855344，body_q0.0001199841、body_qd0.06645292。
这是新的重初始化诊断，不声称复现原500帧求解器的私有history，所有旧失败保留。
config实测hard=False、friction_epsilon=0、NL5/linear50，dt0.005；8world、每world68粒子、shared17body/56shape。

## 完整输入与真实三端核对

两端分别从同一冻结SDK public state重新运行，抓首contact force和tangent的全部非空flat指针。
34/35真实参数先按实际metadata、类型和size核准：capacity1000、total particles544、shared body17/shape56。
每端2608个调用的标量/类型/NULL状态/geometry一致。该metadata比较仅检查指针NULL/present，
不比较跨进程地址、alias关系或指向的buffer内容；下列完整buffer/guard/实际参数检查是独立证据。

四份完整packet、12次SDK-runtime/原提取PTX/源码PTX回放中2packet严格，GPU根实际1保留。
独立CPU实际0：1072实际参数字节、287232完整输出字节、1314096保护字节、0alias组。
差异在原捕获force的RHS/scale及一次原PTX tangent的两矩阵；并非12调用全部逐位通过。

四输入再执行8次真实PTX原子追踪，33280项target/F32值/线程内序原源完全相同。
独立CPU重读raw trace、参数、保护区和readonly字节全部核准。
回放全部不同的12个word，使用实际addends及实际初值，按线程目标内先后顺序约束搜索。
24个实际可达target经真实GPU atom.global.add.f32逐位复现，144个返回历史word及guard/参数由另一CPU审计全核。
不推断生产跨线程全局顺序，不把每scalar可达排列当作联合全局轨迹的证明。

## 两次捕获的接触记录对应

首次contact force的所有非接触before buffer和RHS/scale初值逐位同；接触字段按行的顺序不同。
完整160条有效记录，每条76字节，含两shape、point0/1、offset0/1、normal、margin0/1。
跨运行完整记录多重集逐字节同，160条全部换位；按对应排列恢复后，
force5120项、tangent11520项实际贡献的target/F32值/线程内序也逐位同。
矩阵before的3字节差已出现在此前散射结果上，不能当作tangent同输入算错的证据。
原/source PTX对两份各自输入的操作数也独立核同，不仅比较捕获输出的某个误差统计。

实际32条脚部记录的中心z RHS首原子贡献约73.52677至77.48937，另一次z切向贡献为零。
它们来自真实原版PTX trace，保留contact row/shape/center particle对应。
硬接触关闭且刚度有限是实测config；本阶段尚未证明全部静力支撑平衡或长期穿透的完整成因。
可以确认这两种接触核在这些真实输入上的逐项恢复一致，不能据此关闭整个solver轨迹失败。

## 原始文件与命令

probe.py不step native，只构造模型/恢复状态/运行实际碰撞；original/source保存几何及接触原始NPZ。
common-step.py真实step一次，common-original/common-source保存同起点的输入/输出、config、launch metadata。
capture-native-contact.py保存完整before/post；native-contact下有12次三端回放、实际参数/保护区及独立CPU报告。
trace-native-operands/audit-native-operands保存实际贡献；contact-row-map保存跨捕获的完整记录映射。
scalar-folds保存24真实GPU target及历史，所有实际命令和退出另见actual-tool-receipts.json。
原probe的USD警告仅在工具输出中，structured report和raw已完整保存；之后运行的完整日志均落文件。

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-foot-contact"
# 以下为已执行命令，现有审计输出拒绝覆盖；重跑应新建阶段/输出，不删旧证据。
.venv/bin/python -B "$phase/audit.py"
.venv/bin/python -B "$phase/audit-common-state.py"
.venv/bin/python -B "$phase/native-contact/run-replays.py"
.venv/bin/python -B "$phase/audit-native-operands.py"
.venv/bin/python -B "$phase/audit-contact-row-map.py"
.venv/bin/python -B "$phase/run-folds.py"
.venv/bin/python -B "$phase/audit-folds.py"
```

Windows继续用WSL2；原机器路径前缀为/home/oem/code/agent/style3d-sim。
根snapshot先核，再运行restore_reconstruction_evidence恢复上一阶段无损gzip；固定so/360pyc仍在同一仓库。
不要重启已经终态的旧队列，也不要恢复GPU独占门禁或停止外部任务。

## 继续位置

下一步沿同一public起点，核接触后的完整RHS、首CG输入/标量、后续非线性传播，连接一步输出差异。
本批捕获不复现旧私有history，不据此将旧固定C8/C10或完整一步改判通过。
如发现同输入真实逐项差异，再查固定SDK反编译/真实调用修恢复源码；不要为通过高度门槛改刚度或阈值。
两个隔离候选、G1/Newton mixed/复杂布料长程及最终默认切换仍见根CURRENT_STATUS，目标尚未完成。


本次真实metadata中首inverse/precondition/direction/matrix/update owned号为23/24/25/32/33，首apply为524。
中间有50轮CG，不得把首update直接当作首apply输入；next-first-CG-nodes.json保存六个实际节点。
这些地址仅为历史元数据，需新捕获和重定位；shared模型数组68粒子/17body/56shape与逐world状态544粒子应分清，
依据每个核的实际索引和SDK参数核定完整size，不能把所有指针都按544粒子长度盲抓。
