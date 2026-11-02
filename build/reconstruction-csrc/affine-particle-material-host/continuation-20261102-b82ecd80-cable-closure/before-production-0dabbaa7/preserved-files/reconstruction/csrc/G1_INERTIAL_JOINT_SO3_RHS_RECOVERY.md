# G1惯性、关节和SO3 RHS：实际缓存及同输入核对

固定SDK64a、host38b70dcd、公共Core7eb6e847、CUDA176/f0、旧八原版/三源码及全部固定失败保持。
生产数学、阈值、默认入口均未改；`solver_api_ready=False`，完整替代仍未通过。

## 实际图内输入和完整输出

正常G1真实graph第六子步首次NL，选择initialize_rhs14575、joint AL spring force14580和SO3 AL force14583。
W1、44 bodies、176 particles、86 joint body springs（43 joints的两锚点）；geometry均1/256、shared0。
实际ABI分别为12个参数（92字节）、15个参数（116字节）、10个参数（76字节）。
捕获全部非空指针buffer和实际累积器before/after，不合成输入或初值。
共27 D2D快照、一个63728字节buffer；原图17467节点/17466边全部保留，实际17494节点/17499边，独立CPU核同。
两端各60帧正常公共Core真实graph/test退出0；源码没有bridge、未映射SDK来代算。
诊断快照可能改变原子调度，不冒充旧冻结轨迹复现。

每条路径120份真实输入，全部120次实际改变输出。下表各项是完整输出与实际捕获after逐位相同的份数。

| 路径 | SDK runtime | 原版PTX | 源码PTX | 原版探针 | 源码探针 |
| --- | --- | --- | --- | --- | --- |
| initialize_rhs | 120/120 | 120/120 | 120/120 | 不含原子操作，未插探针 | 同左 |
| joint AL spring force | 35/120 | 28/120 | 54/120 | 28/120 | 31/120 |
| SO3 AL force | 120/120 | 120/120 | 120/120 | 120/120 | 120/120 |

共1560个完整输出、22185600个非输出after字节、2880个实际指针字段、11040个标量字节，
全部34080个实际传入ABI字节由独立CPU从NPZ及真实分配span重核。
关节和SO3分别495360/126720个双PTX真实原子操作数，同目标及跨目标整条每线程序列全部相同。
关节424个完整向量严格失败检查全部保留，没有用后续证书把严格false改为true。

## 13个实际构造缓存buffer

直接读取每端各60份packet：

- RHS：176项质量、176项ELL行计数、19×176个完整NonZeroEntry、176项mask。
- Joint：44个body proxy索引、86个body pairs、两端anchors、两端weights、86项stiffness。
- SO3：44个body proxy索引及44项rigidity weight；proxy索引与joint重复，不能说13个独立分配。

13个参数buffer每端60帧均字节恒定，跨端全部逐字节相同；ELL比较包含完整容量，不只比较active slots。
记录完整原始SHA。此前rolling的12个固定模型字段也已核同；这些结果仍不代表整个构造器所有缓存都已证明相同。
历史host141的G1 constructor flat pointer报告false原样保留，没有继承为当前host38的通过证据。

## 关节差异的SDK隔离与GPU真实F32证书

严格门槛未通过后，才冻结后续计划。逐packet逐86弹簧，保留全局spring/body/particle数组与world宽176：
count=1、joints_per_world=1、spring_count=k+1选择原spring k，只有multiplier指针偏移12*k。
实际SDK runtime、原版PTX和源码分别从正零/负零累积器执行；没有改生产数学或原版指令。

61920次调用全部逐位相同，并全部匹配真实PTX逐lane操作数预测。
完整528-word输出保存，独立CPU重核32693760个输出word及1197120个实际隔离ABI字节。
原86弹簧每线程24个目标无重复；每个标量接收2/4/6/8线程的贡献，故可枚举完整排列，保留全部真实操作数及正负零。

使用实际before初值，对捕获after和五后端所有不同输出bit建立64867份标量证书。
GPU执行真实global F32 atomic add，并记录每步返回的旧值；全部证书通过。
独立CPU验证每份证书的线程/操作数完整排列、实际初值、全部255880个GPU历史值及最终target bit，全通过。
这证明本批每个标量存在合法原子累加顺序；没有证明一个共同的全局线程/warp调度，也不推断原实际执行顺序。
不能用局部证书代替旧G1整段验收或把旧23.85尖峰判成已解释。

## 诊断工具的具体修正与原始拒绝

SO3原版有三条字面量0f00000000的原子加；原寄存器专用探针在CPU预检拒绝，GPU尚未启动。
新增ptx_atomic_literal_probe.py从固定SHA旧helper派生，只扩展F32字面量记录为原始u32 bit，保留每条原red指令原字节。
正零、负零、NaN payload三项字面量及谓词/十进制/其它寄存器三项拒绝，共6个CPU回归通过。
实际SO3的600完整输出及126720真实操作数已在GPU验证；不声称其它字面量案例已经做GPU验收。
旧helper完全不改，原CPU失败/as-run均保存。
后续隔离生成器131列的CPU拒绝及next-stage清单错误命名的CPU拒绝也保留；修正后通过，未启动错误GPU任务。

joint-normalized.diff和joint-PTX-diagnostic.json保留实际文本差异；F32算术文本也未完全相同。
PTX虚拟寄存器声明不能当作物理寄存器使用量或调度差异原因的证明。
本输入结论来自真实操作数、SDK隔离、GPU证书，不从PTX文本近似推断全域等价。

## 整段失败及下一步

本轮同旧固定C8，原版within60/56/60/57、源码55/53/55/53；两端整段仍false。
最大速度字段误差原版2.20939964056015、源码1.9027578979730606；没有复现或解释旧23.8513。
旧报告SHA32b6e2a7…、旧样本、旧失败和门槛保持，不增加cohort或更换源码候选。

下一步实际图中evaluate_joint_drive_load14581、evaluate_soft_contact_force14578、
最后joint AL state update16882、最后SO3 AL state update17459。
完整符号/类型/ABI已保存next-drive-and-AL-state-inspection.json；这只是CPU检查，没有这些路径的新GPU执行证明。
先核全部实际输入、可写输出和别名，再同输入逐项回放；对差异按既定严格/真实原子协议继续。

## 证据、实际终态和命令

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-inertial-joint-so3-rhs/`。
含全部plan/templates/as-run、360真实packet、双端完整图/60帧状态、replay完整after/参数、隔离输出/参数、GPU证书历史及独立CPU审计。

- CPU preflight6252退出1保留；字面量修正后57528退出0，6项CPU回归退出0。
- capture15273、replay88332、完整CPU87392实际退出0。
- 后续准备10095退出0；followup session17282中isolation PID2556949、certificates2557045、CPU2557258全部实际退出0。
- 全部GPU任务串行，启动前compute列表为空，没有终止外部进程、没有观察超时重启；生产不改，未重复74项。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-inertial-joint-so3-rhs
.venv/bin/python "$phase/independent-cpu-audit.py"
# Read closed followup reports; the followup auditor intentionally refuses to overwrite an existing report.
# Use a new output directory for any additional GPU replay.
.venv/bin/python -m reconstruction.csrc.g1_al_rhs_replay --capture "$phase" --output build/NEW-g1-al-rhs-replay
```

Windows继续WSL2、固定Linux SDK/Python3.12及离线G1资产；不得把这批通过升级为原生Windows或完整solver已完成。
