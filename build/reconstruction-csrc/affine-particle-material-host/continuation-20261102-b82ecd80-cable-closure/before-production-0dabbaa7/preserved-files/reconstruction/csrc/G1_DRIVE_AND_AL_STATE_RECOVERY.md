# G1驱动力、软接触过滤与关节/SO3状态更新

SDK64a、host38b70dcd、公共Core7eb6e847、CUDA176/f0及旧八原版/三源码固定不动。
生产数学、阈值和默认入口未改，`solver_api_ready=False`，完整替代仍未通过。

## 实际捕获的五条路径

| 阶段 | 实际rank | 输出参数 | geometry | 覆盖 |
| --- | --- | --- | --- | --- |
| evaluate_joint_drive_load | 14581 | angle3、initialized4、force26 | 1/256 | 43个已初始化revolute drive |
| evaluate_soft_contact_force | 14578 | force36、diagonal37 | 73/256 | 代理粒子过滤，不含有效接触力算术 |
| update_joint_body_spring_augmented_lagrangian_state | 16882 | multiplier7 | 1/256 | 86条body springs |
| update_affine_body_so3_augmented_lagrangian_state，true | 15149 | rotation2、multiplier3 | 1/256 | 44 bodies、实际更新乘子 |
| 同一SO3 state，false | 17459 | rotation2、multiplier3 | 1/256 | 44 bodies、乘子原字节保持 |

两端各60帧正常公共Core真实graph/test退出0；源码bridge false、未映射原版solver代算。
600份真实packet，完整before/after及全部非空输入均捕获；79个D2D节点、一个881868字节buffer。
原17467节点/17466边完整保留，实际17546节点/17555边；独立CPU核拓扑、范围和前后依赖。
诊断节点可能改变原子调度，不声称复现旧冻结轨迹。

共4800个完整输出，源码PTX的全部1200个输出都与实际after逐位同。
关节及两种SO3状态共1800份三后端输出全严格，drive angle/initialized共1200份五后端输出全严格。
drive force各120份的严格数为SDK runtime118、原版PTX119、源码120、原版probe116、源码probe116。
11个完整向量严格失败检查保留，不用后续证书改成true；全部合计4789/4800严格。

独立CPU从原始NPZ直接核510606720个非输出after字节、8280个实际指针字段、28080个标量字节，
全部94320个实际传入ABI字节及完整span/alias/mod256关系均通过，不只相信运行时布尔值。
41个固定缓存参数buffer每端60帧均恒定、跨端全部字节同；含重复body映射，不代表41个独立分配或整个构造器证明。

## Drive原子差异的完整后续验证

247632个双PTX真实原子操作数的逐线程/逐目标及跨目标整条序列全同。
5160条drive输入中5159条实际执行24个atomic，另一条没有atomic；不把空调用算为有效算术覆盖。
所有drive type及initialized均为1，本轮没有覆盖第一次初始化angle/flag的分支。

严格门槛未过后才固定后续计划。逐drive将drive-local数组偏移k，count/local设1；
保留全body/particle数组、49项DOF及target数组和world宽176、实际angle/flag/velocity。
SDK runtime、原版PTX和源码分别从正/负零force执行，共30960次调用全部逐位同，且匹配真实逐lane操作数预测。
独立CPU重核16346880个完整输出word及1341600个实际隔离ABI字节。

使用真实before初值，覆盖捕获after和五后端全部不同force bit，共63367份GPU真实global F32 atomic证书全过。
完整保留真实操作数、线程排列及正负零；独立CPU核全部123830个GPU历史值和最终bit，全过。
这是每个标量的合法排列证据，不证明一个共同全局线程/warp调度，不推断原执行顺序，也不替代旧整段C8。

## Soft no-op的实际原因

原版9544、源码9464，共19008条有效计数前缀记录，particle索引均在0..175，mass全部为正，particle_kind全部非零。
原版实际PTX明确读取parameter9的kind，非零即跳到终止ret；完整guard及index scale片段保存于独立CPU报告。
两探针在全部120份输入上均记录0个atomic，五后端的两个完整输出共1200份全部与before/after原字节同。
因此本批只验证过滤路径；没有宣称有效soft-contact力、对角或可选矩阵算术已在这条G1路径覆盖。
本例shape_filter及system/preconditioner指针为空，其原始ABI及潜在写来源均保留，不会将NULL当作设备buffer复制。

## 诊断错误与修正范围

首轮回放session73313实际退出1：新增线程数量变量lanes被旧逐线程记录列表覆盖，第二份packet报TypeError。
所有旧plan/template/as-run/log/partial replay均保存在replay-variable-v1-error，不删除或冒充通过。
仅将数量变量改为trace_lanes，四处精确模板替换；新旧固定输入SHA仅root replay工具和replay-template两项变化。
600份原始采集全部SHA不动，没有重复采集；CPU预检及replay-revision审计通过后，90754完整回放退出0。
后续准备器重复创建模板的CPU拒绝保存在followup-template-v1-refusal；修正后才启动隔离/证书，生产数学从未改动。

## 旧尖峰及下一步

本轮新增诊断同旧固定C8，原版within57/59/57/58、源码31/50/31/48，两端整段仍false。
body_qd最大误差原版0.9105834364891052、源码1.8645520210266113；未复现或解释旧23.8513。
旧八原版/三源码、SHA32b6e2a7…、全部失败和阈值不变，不扩cohort、不替换源码候选。

新增CPU检查直接验证旧11份轨迹SHA，精确定位原source1的frame31/body12/component4（flat76）：
误差23.851294673979282、原版LOO spread1.2091027029923032、ratio19.726442274053134，原失败保持。
保存第28..33帧邻域及第30/31帧全44个body的仿射矩阵谱；source1/body12在frame31帧末condition1.00176069、det1.00352287。
这是保存的帧末状态，不排除帧内其它状态；未恢复当时的内部乘子/drive angle，也没有解释整个尖峰。

下一步以这些冻结的公共particle positions为共同输入，对SDK/PTX/source做SO3初始化核对，尤其source1 frame30/31。
随后继续对准尖峰前的预测/PCG输入；不得把从公共状态重启当作已经恢复旧内部缓存或原子调度。
这项冻结输入GPU测试尚未执行，当前只有frozen-spike-context.json的CPU输入检查，不记为通过。

## 证据、终态、复现

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-drive-and-AL-state/`。
包含全部输入、完整图/after/真实ABI、隔离、GPU证书历史、两个拒绝、源码/模板、命令及实际终态。

- 初CPU preflight44808、修正后31949、capture69204、完整replay90754、独立CPU50025均实际退出0。
- 旧replay73313退出1完整保留；后续准备97771退出0，session29272三步全部退出0。
- 隔离PID2578865、证书2578968、独立CPU2579034实际结束；filter/domain和冻结尖峰CPU检查退出0。
- 外部PID2564287曾实际运行18/57秒，期间只做CPU；其消失且compute列表为空后才采集，没有终止外部进程或观察超时重启。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-drive-and-AL-state
.venv/bin/python "$phase/independent-cpu-audit.py"
# Closed followup reports intentionally refuse overwriting; use a new output for additional GPU work.
.venv/bin/python -m reconstruction.csrc.g1_drive_state_replay --capture "$phase" --output build/NEW-g1-drive-state
```

生产未改，没有重复74项回归；Windows继续WSL2、固定Linux SDK/CPython3.12及离线G1资产。完整源码替代仍未验收。
