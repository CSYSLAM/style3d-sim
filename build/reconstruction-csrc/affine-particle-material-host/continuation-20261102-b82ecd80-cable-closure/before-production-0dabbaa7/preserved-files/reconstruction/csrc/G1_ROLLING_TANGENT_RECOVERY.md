# G1晚期滚动摩擦切线：600份完整输出严格通过

固定SDK64a、host38b70dcd、公共Core7eb6e847和CUDA176/f0不变，`solver_api_ready=False`。
生产数学、默认入口、阈值、旧八原版/三源码和全部固定失败均未改变；完整源码替代仍未通过。

## 实际范围与结果

选择正常G1真实graph的最后multiply_rolling_contact_tangent，rank17455，紧接最后matrix17456。
ABI为248/8/8：RollingContactView、direction、product；geometry为4/1/1、256/1/1、shared0。
本例W1、105 shapes、44 bodies、176 particles、contact capacity1000，inverse_dt360、rolling epsilon的F32为0.1。
24个view指针字段加direction/output共26个真实bindings，全部指针重定位、alias及mod256关系保留。
view字段偏移继承上一批直接从native结构提取并由CPU C++验证的sizeof248/32字段offsetof证据。

两端各60帧正常公共Core真实graph/test退出0；源码bridge false、public_core_abi true、无原版solver映射。
每帧增加27个D2D快照、一个96276字节buffer，原17467节点/17466边全部保留。
实际图17494节点/17495边；独立CPU核唯一拓扑、完整before/after范围及前后依赖。
诊断节点可能改变原子调度，不声称复现旧冻结轨迹。

- 120份真实before/after，50次实际改变输出；全部528个direction分量在每份输入中均非零。
- 实际SDK runtime、原版PTX、源码PTX、双PTX探针共600份完整输出，全部与实际after逐位同。
- 1988个计数前缀线程中1744提前退出、244各执行9次atomic；两PTX共4392个真实操作数。
- 每线程同目标序列及跨目标整条序列全部相同；本例未执行双body的最大18次路径，不外推其它分支。
- 独立CPU直接核600个完整向量、55231200个非输出after字节、3120个实际ABI指针字段、
  6720个view标量字节及全部31680个实际传入ABI字节，均通过。

严格门槛已达到，没有再做冗余逐contact隔离或原子排列证书。
两端静态atomic site为15/27，规范化PTX仍不同；输出结论来自实际GPU及保存的完整原始字节。
额外控制流核对确认源码terminal trap的guard是view.previous==NULL，120份实际previous全部非空。
未测试或推断原版NULL-previous契约，不声称一般索引bounds/控制流证明；生产trap和PTX均未改。

## 固定模型数据与整段失败

从同120份实际packet直接比较shape_body/type/transform/scale、ke/kd/rolling/torsional、
body_ids/indices/com/inertia共12个字段。每端各字段在60帧中均保持相同字节，且两端全部相同。
可复现CPU脚本再次独立重算，并与第一次报告完整字段相等；记录120个原始packet SHA和runner SHA。
这项检查不覆盖其它质量、关节、预计算缓存，不能升级为实际G1构造器全部一致的证明。

同一旧固定C8，本轮原版within为40/59/40/60，源码48/51/49/56（body_q/qd、particle_q/qd，各60帧）。
最大速度字段误差原版1.288238525390625、源码2.047191083431244；两端整段仍false。
没有复现或解释旧23.8513尖峰；旧报告SHA32b6e2a7…、旧样本及失败保持，不扩cohort、不重判。

后续检查实际G1构造缓存、initialize_rhs中的质量/ELL和joint/SO3 AL force输入与累积。
历史G1 constructor五项报告属于旧host141c18f6，其中flat pointer一项false；不能将其继承为当前host38全通过。
当前graph定义证明也未比较所有device pointee；须读取真实输入，不能只看参数地址对应关系。

## 证据与复现

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rolling-tangent/`。

- plan/preflight、精确capture/replay templates和as-run文件、双端图、120真实packet及60帧状态。
- replay含完整输出、全部after、真实参数字节/span基址、原子记录及报告。
- independent-cpu-audit.py/json、control-form-audit.py/json及cross-backend-model-fields*.py/json。
- commands-and-terminal-status.json和phase-manifest.json记录闭合范围及文件SHA。

实际终态均0：CPU preflight session75177、capture16873、replay12520、独立CPU63230、控制流及模型字段CPU复核。
观察到外部verify_prescribed_motion.py PID2535766运行时只做CPU工作；确认进程消失及GPU compute列表为空后才回放。
没有停止外部任务，也未因观察超时重复启动任务。生产未改，没有重跑已闭合74项，Windows继续WSL2。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-rolling-tangent
.venv/bin/python "$phase/independent-cpu-audit.py"
# Existing result files are immutable; use a new directory for an additional replay.
.venv/bin/python -m reconstruction.csrc.g1_rolling_tangent_replay --capture "$phase" \
  --output build/NEW-g1-rolling-tangent-replay
```

模型字段脚本只写新文件并拒绝覆盖现有结果；接手阅读已闭合JSON或复制脚本至新的独立目录再复现。
