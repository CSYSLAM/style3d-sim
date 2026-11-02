# G1接触力与矩阵输出：240份真实输入、2400份完整输出严格通过

固定SDK64a、host38b70dcd、公共Core7eb6e847和CUDA176/f0均未改；生产数学、阈值、固定失败及默认入口不变。
`solver_api_ready=False`，完整源码替代仍未验收。

## 本次已经确认

核第六子步首次NL的两条实际调用：rank14576 `evaluate_contact_force`的RHS32/标量对角33，
rank14587 `evaluate_contact_tangent`的system33/preconditioner34。
后者方向29/乘积30为NULL；这是上一轮向量核对没有覆盖的矩阵分支。
本例一个world、105 shapes、44 bodies、176 particles、capacity1000，geometry为4×256。

两端各60帧正常公共Core真实graph/test均退出0，源码无bridge、无原版solver映射。
原图17467节点/17466边完整保留；增加一个209800字节buffer及55个D2D快照，实际17522节点/17525边。
force保存26个指针before及两个after，matrix保存25个before及两个after。
独立CPU核唯一拓扑、全部before/after范围与目标前后依赖，初值是真实捕获字节，没有猜测F32输入。
额外诊断节点可能改变原子调度，不能当作旧冻结轨迹复现。

每阶段两端共120份输入，在相同buffer、原alias关系、mod256和完整geometry上轮换调用SDK runtime/原版PTX/源码PTX，
再执行双PTX原子探针。五后端、每次两输出，总计2400份完整输出全部与实际调用after逐位相同。

| 阶段 | 真实输入 | 完整输出 | 有效调用数量（按输出） | 两端真实原子操作数 |
| --- | --- | --- | --- | --- |
| force | 120 | 1200全严格 | RHS53、对角54 | 16168 |
| matrix | 120 | 1200全严格 | system54、preconditioner54 | 36432 |

每阶段计数前缀2010线程，1757提前退出；force有250线程32次、3线程28次atomic，matrix有253线程72次。
不是全部120次都有效，也没有在本例执行理论最大双body的64/144次路径。
52600个实际操作数的逐线程、逐目标次序和整个每线程跨目标序列全部相同。
独立CPU从原始NPZ重核全部2400完整输出、107294400非输出after字节和全部52600个原子操作数，均通过。
已达到既定严格门槛，按预先计划不再启动冗余逐contact隔离或原子排列证书。

两核规范化PTX仍不同；没有为匹配文本或资源属性修改生产源码。
CPU静态来源修正、15项回归、两次CPU错误和资产查询/离线恢复见[准备记录](G1_CONTACT_RHS_MATRIX_QUEUE.md)，全部原始资料保留。

## 整段仍未通过，继续哪里

同一旧固定C8下，本轮原版四字段within为55/52/55/54，源码59/56/58/56（各60帧），两端整段仍失败。
最大速度字段误差原版1.812793254852295、源码1.3831502944231033，未复现或解释旧source1的23.8513尖峰。
固定八原版/三源码、报告SHA32b6e2a7…及所有旧失败保持不变，不把局部通过外推完整solver。

下一步核同NL的rolling force（rank14577）及rolling preconditioner（rank14592）。
两端实际ABI均为248字节RollingContactView加一个8字节输出指针，已保存只读类型/参数检查，尚未GPU捕获或回放。
先按真实view字段offset核所有内嵌指针、容量和粒子跨度，再捕获真实before/after；不要把opaque view当普通指针。
若接触/RHS贡献继续通过，再沿实际首NL向关节/drive/limit/SO3及初始化追踪，不重复本次严格闭合路径。

## 证据与命令

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-contact-rhs-matrix/`。

- `plan.json`、`closed-packets.json`：固定计划、输入与全部240份packet SHA、正常Core runtime。
- `original/`、`source/`：完整graph定义/实际快照拓扑、真实before/after、状态、as-run worker及来源。
- `replay/`：全部双输出、完整after字节、原子计数/记录及逐项结果。
- `independent-cpu-audit.py/json`、`diagnostic-trajectories.json`：原始字节重核及固定C统计。
- `GPU-wait-observations.jsonl`、`GPU-queue-status.json`：等待实际外部任务退出后启动，队列现已terminal/exit0。
- `next-rolling-inspection.json`：后续两调用实际248/8 ABI及原始参数，不是执行结果。

全部真实终态0：排队/两端capture session1065，replay47225，独立CPU18403。
原本排队PID2467807已经结束，禁止按旧排队交接重复启动本批捕获；所有原始日志和失败保留。
生产未改，不重跑74项。Windows继续WSL2；固定G1资产现可由本仓库离线恢复，trampoline原网格仍缺。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python scripts/restore_reconstruction_g1_assets.py
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-contact-rhs-matrix
.venv/bin/python "$phase/independent-cpu-audit.py"
# A new diagnostic replay must use a fresh output; do not rerun the closed run-replay.py wrapper.
.venv/bin/python -m reconstruction.csrc.g1_contact_rhs_replay --capture "$phase" --output build/NEW-g1-contact-replay
```
