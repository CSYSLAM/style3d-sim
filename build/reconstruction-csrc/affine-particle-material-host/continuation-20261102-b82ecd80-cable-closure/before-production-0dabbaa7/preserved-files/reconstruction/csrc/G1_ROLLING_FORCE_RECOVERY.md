# G1滚动摩擦力/预条件矩阵：1200份完整输出严格通过

固定SDK64a、host38b70dcd、公共Core7eb6e847、CUDA176/f0及旧C8不变；生产数学、默认入口和阈值未改。
`solver_api_ready=False`，完整源码替代仍未验收。

## 已实际核对的两条路径

选择第六子步首次NL的rolling force（rank14577）和rolling preconditioner（rank14592）。
实际ABI是248字节RollingContactView加一个8字节输出指针；一个world、1000 capacity、105 shapes、44 bodies、176 particles。
逆时间步360、rolling epsilon的原始F32为0.1；与rigid contact的epsilon字段区分，不改成零。

从当前native源码直接提取RollingView，用CPU C++编译逐字段offsetof，32个字段及sizeof248全核准。
24个view指针逐项绑定，额外一个输出；真实标量word保留原字节。
维护工具从已验证contact捕获/回放的固定SHA模板做带锚点/次数断言的派生，完整as-run源码全部保存。

两端各60帧正常公共Core真实graph/test均退出0；源码无bridge、无原版solver映射。
新增一个196776字节buffer、52个D2D快照，原17467节点/17466边完整保留，实际17519节点/17522边。
独立CPU核唯一拓扑、完整before/after范围及目标前后依赖；真实输出初值已捕获，不合成输入。
诊断节点可能改变原子调度，不能当作旧冻结轨迹复现。

| 阶段 | 真实输入 | 五后端完整输出 | 有效调用 | 两端实际原子操作数 |
| --- | --- | --- | --- | --- |
| rolling force | 120 | 600全部逐位同 | 53 | 4428 |
| rolling preconditioner | 120 | 600全部逐位同 | 53 | 13284 |

五后端是实际SDK runtime、原版PTX、独立源码PTX及双PTX原子探针，使用同一组buffer和真实before值。
两阶段各2007个计数前缀线程，其中1761提前退出、246实际贡献；force每线程9次atomic，preconditioner每线程27次。
本例没有执行双body最大18/54次路径，不能把空调用计为有效，也不能外推所有world/epsilon分支。

17712个真实操作数的逐线程/逐目标顺序及跨目标整条每线程序列全部相同。
独立CPU重核全部1200完整向量、107928000个非输出after字节，均通过。
本次额外保存实际传入的248/8参数字节和设备span基址，CPU直接重核6000个指针字段及13440个view标量字节，
确认每个内嵌指针的重定位、原alias/mod256关系和全部标量原字节；不是只信运行时断言。
既定严格门槛全部达到，未再启动冗余逐contact隔离或原子排列证书。

## PTX寻址及文本差异的具体检查

原版/源码PTX会通过寄存器读取参数区，旧分析器仅支持直接参数名，因此第一次CPU预检拒绝。
新ptx_store_origins_param.py只接受唯一、非谓词的formal-parameter mov，并核其在entry前缀或与对应load同一basic block。
把参数区地址只在分析文本中还原为parameter+offset，核完整load范围；没有修改任何GPU执行PTX。
214条实际参数读取的解释记录、两次CPU预检拒绝及8个正/负回归都保留；旧typed分析器不改字节。
四份实际entry的global写基址只有输出parameter1；这不证明任意索引范围或任意控制流。

force静态atomic site原版15/源码27，preconditioner两端9；两核规范化PTX仍不同。
源码还多出终止trap块。初版control inventory因未包含trap而拒绝，原错误保留。
逐指令核两个进入trap的guard都为view.previous（offset232）等于NULL；完整240份原始参数均非空，分支条件均为false。
trap位于全部parameter load之后，前一块以ret结束；本批参数寻址证明没有跨越这些终止路径。
没有测试或推断原版NULL-previous契约，也没有删除生产trap来凑文本一致；实际完整输出仍以严格结果为准。

## 整段未通过和下一步

同一旧固定C8下，新增原版within为60/57/60/57，源码59/59/59/60（各60帧），两端整段仍失败。
最大速度字段误差原版1.346693217754364、源码0.8993732891976833；没有复现或解释旧23.8513尖峰。
八原版/三源码、旧失败及报告SHA32b6e2a7…不变，不扩cohort、不放宽门槛。

这个rolling模块还有multiply_rolling_contact_tangent，实际最后调用rank17455，ABI为248/8/8（view、direction、product）。
两端只读参数/类型已保存，尚未在G1这条晚期路径做GPU捕获/回放；下一步先补齐它，再核RHS的joint/SO3 AL force。
后两条实际rank14580/14583及initialize_rhs、soft force的完整参数/类型也已保存，不当作执行结果。

## 证据和命令

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rolling/`。

- `rolling-view-abi.*`：直接提取native struct的C++程序、编译命令、实际sizeof/32字段offset和日志。
- `plan.json`、`CPU-layout-preflight.json`：固定输入SHA、248字节解释和完整参数读取/写来源分析。
- `original/`、`source/`：完整图、真实before/after、60帧状态、runtime和as-run worker。
- `replay/`：1200完整输出、全部after、真实参数字节、设备span基址及实际原子记录。
- `independent-cpu-audit.py/json`、`control-form-audit.py/json`：独立原始数据及终止分支重核。
- `cpu-*-error/`：所有CPU拒绝及旧代码；`preflight-before-replay-parameter-recording/`：增加参数证据前的原预检。
- `next-rolling-tangent-inspection.json`、`next-RHS-inspection.json`：后续未执行路径的原始检查。

全部实际终态0：capture session99117、replay81787、独立CPU14067。
生产未改，没有重跑74项；Windows继续WSL2及固定G1资产离线恢复。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rolling
.venv/bin/python "$phase/independent-cpu-audit.py"
# Use a new output directory for a new diagnostic; never overwrite closed logs or results.
.venv/bin/python -m reconstruction.csrc.g1_rolling_replay --capture "$phase" --output build/NEW-g1-rolling-replay
```
