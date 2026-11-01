# G1接触力与矩阵分支：预检已过，实际GPU验证排队中

接已发布23ec2760的[G1刚体切线向量核对](G1_RIGID_TANGENT_RECOVERY.md)。
固定SDK64a、生产host38/Core7eb、CUDA176/f0及旧C8均不改，`solver_api_ready=False`。
上一goal轮完成刚体向量证据和交接发布，属于实际进展；本轮准备后续两输出路径，不能声称已经GPU通过。

## 已完成的CPU检查

新`g1_contact_rhs_capture.py`选第六子步首次NL，原图rank14576的contact force及rank14587的contact tangent。
前者完整捕获26个非空指针before及RHS32/对角33两个after；后者25个before及矩阵33/34两个after。
矩阵分支的方向29/乘积30均NULL，原版和源码都检查过。
两端旧实际图的ABI/geometry/尺寸一致，两个阶段都没有输出与只读输入重叠，也没有两输出相互重叠。
每帧共209800字节，计划只加一个buffer、55个D2D快照，保留全部原图节点和依赖。
预计修改后17522节点/17525边，实际拓扑必须在GPU捕获后重新核对，不把预检数字当执行结果。

新`g1_contact_rhs_replay.py`支持两个完整输出、真实before初值、同buffer三端回放和双PTX原子探针，
保留alias关系和mod256对齐，保存每份完整输出、完整非输出after及全部有效原子记录。
原版/源码force各96个静态原子site，tangent各75个；实际entry没有未被探针处理的其它原子操作形式。
矩阵路径单线程最多8个目标×9分量×2输出=144次原子写；探针独立扩为256记录/线程，stride4096。
force最大动态64。旧128容量探针及生产PTX/源码均未改，扩容只作用于新诊断PTX。
CPU预检实际退出0，全部新维护Python语法/128列检查通过；没有重跑已严格通过的向量路径或74项生产回归。

## 当前实际等待状态，先核句柄再操作

本机GPU另有world-particles项目360帧验证，确认PID2460294活跃，日志`/tmp/wp-v26-stretch-full.log`。
没有中断它，也没有并行启动本次GPU验证。
新`wait-and-capture.py`每10秒只读查询实际compute进程，空闲后仅启动一次`run-captures.py`。
已确认本机排队进程PID2467807，终端exec session **1065**。
启动时的真实/proc信息、UTC及设备进程记录见`GPU-queue-launch.json`；它是当时观察，后续以活进程/句柄为准。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-contact-rhs-matrix/`。

- `CPU-layout-preflight.json`、`plan.json`：已闭合的预检和输入SHA，预先固定两端各60帧、每阶段120份输入。
- `g1_contact_rhs_*as-run.py`：新维护工具的冻结字节，运行前逐项核SHA。
- `GPU-queue-status.json`、`GPU-wait-observations.jsonl`：本机动态状态，运行中不纳入冻结Git快照。
- `status.json`、两端日志及输出：GPU真正开始后才会出现；不能由排队文件推断任务已完成。
- `independent-cpu-audit.py`：已写好且静态检查通过，等实际捕获/回放结束再执行，不能提前称其结果通过。

先poll session1065，或核实际PID和命令、`nvidia-smi`、`GPU-queue-status.json`。
观察超时不等于任务结束，排队/捕获句柄还活着时禁止另起同一任务。
若换电脑，旧机器PID/句柄不可直接当作新机状态；先确认旧机任务真实终态，再同步新生成证据。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-contact-rhs-matrix
cat "$phase/GPU-queue-status.json"
ps -p 2467807,2460294 -o pid,ppid,etimes,stat,args
```

## 捕获结束后继续什么

两端捕获必须正常graph/test退出0，且源码public_core_abi true、bridge false、reference_solver_mapped false。
等待实际GPU空闲，再运行一次回放和独立审计：

```bash
.venv/bin/python "$phase/run-replay.py"
.venv/bin/python "$phase/independent-cpu-audit.py"
```

回放会保存全部240个两输出packet、五后端共2400份完整输出；这是计划数量，尚未执行。
先核严格结果及两端真实逐线程/目标原子操作数。严格全过继续下一阶段；有差异按实际SDK隔离和真实F32证书定位，
保留全部失败，不修改生产数学、固定八原版/三源码或阈值，不用原版代算生产路径。
独立审计还会复核完整after未写字节、实际图依赖及新诊断对旧C8的统计，但不会替换或扩充旧cohort。
整段G1/旧23.85尖峰仍未解决，完整源码替代未验收；Windows继续固定Linux对照的WSL2流程。
