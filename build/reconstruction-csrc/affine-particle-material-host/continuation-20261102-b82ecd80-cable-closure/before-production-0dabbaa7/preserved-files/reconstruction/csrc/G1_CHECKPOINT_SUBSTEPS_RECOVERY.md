# G1共同起点的六子步与首次drive初始化

承接097542a9；SDK64a、host38/Core7eb、CUDA176/f0、依赖、旧C8及生产数学不变。
完整替代尚未通过，`solver_api_ready=False`。原G1速度helper截断问题保留，独立状态比较继续使用。

## 本轮要确认的路径

上轮旧source1 frame30公共起点下，SDK也出现约-23的同分量响应；旧尖峰隐含原因仍未证明。
本轮固定八SDK/三源码，同一共同起点、两state buffer和原有flag reset，不改变目标或增益。
记录六子步中每步第一个drive load，以及末尾velocity和angle update，共18个真实调用。
每步原始rank分别为start+14、start+2895、start+2896，其中start=17+2910*substep。
drive首次初始化此前未在旧最后子步采样中覆盖；必须直接保存实际initialized=0分支的完整输入/输出。

维护工具：`g1_checkpoint_substeps.py`、`g1_checkpoint_substeps_replay.py`。
每worker实际一个209304字节快照buffer、300个copy节点；速度/角度相邻调用的快照依赖串联。
独立CPU确认原17467节点/17466边完整保留，实际17767节点/17802边、唯一拓扑次序及所有快照范围正确。
11次共3300快照、2302344字节、198份真实before/after；源码均正常公共Core、bridge=false且未映射SDK代算。

SDK runtime、原版PTX、源码KernelDriver共594实际回放，1188份完整输出全部逐位同。
包括11次首次drive load、473条initialized=0→1的实际驱动；后续55次drive及66次angle update均已initialized=1。
本批没有覆盖angle update自身initialized=0分支，不将drive load首次分支外推到另一核。
完整force已严格通过，按原先严格优先协议不追加冗余原子隔离或证书。
独立CPU从保存字节重核10395000完整after字节、9422424非输出/guard字节、8712指针字段、
85536实际传参字节、15840标量字节和243144完整输出word，全过。

## 两组响应和最早已记录的输入差异

八SDK/三源码的新受控单帧诊断C全部三源码通过；独立CPU重算同，旧C8及失败不改。
与首SDK的整状态逐位比较仍保留原结果，这不是原冻结隐含状态的恢复。
SDK的body12 component4最终为-23.050947/0.891364/0.891956/0.890190/0.888816/0.893590/-22.906078/-23.043186；
源码为-23.108030/-22.989517/-23.157228。精确值及四字段统计保存在独立CPU报告。

实际body12代理粒子索引为48..51。八SDK第4子步末最大代理速度分成约0.64..0.66与13.82..13.85两组；
后续第6子步对应约22.93..23.07与0.88..0.89。源码第4子步约0.64..0.66、第6子步约23.01..23.18。
这是明显响应分支的定位，前三子步已有末位差异；不称第4子步才首次产生任何数值差异。
第4子步首次drive前，SDK body12预测位置全组范围仅7.462408393621445e-05，子步末速度响应已明显分开。
substep-input-spread.json只描述实际输入，不是新容差、样本选择或新的验收协议。

第一次drive（rank31）之前，全部11次的前26个指针输入内容已逐字节核同。
八SDK的force before也逐位同；三源码各有相同11个分量不同，最大4.76837158203125e-07，均为非零数值差异。
精确flat/particle/component、F32 bit和值保存在first-force-context.json；差异在particles60..67，而非body12的48..51。
驱动三端在各自相同输入下仍全部严格通过，下一步应追rank31之前的累计力形成过程。
这项小差异尚未定位到具体核/原子顺序，也没有证明它就是后来大响应的原因。

优先在同一共同起点保存first initialize_rhs(rank25)、contact26、rolling27、joint AL30的实际before/after。
先核first RHS及joint AL边界，再按实际首差决定是否扩展中间接触；所有直接回放必须用共同输入和完整输出。
特别核joint AL的初始零乘子分支，不沿用旧最后子步非零乘子的证据；遇到严格差异再做真实操作数/隔离/证书。

## 当前终态和证据入口

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-checkpoint-substeps/`。
CPU预检session29012实际退出0，参数ABI、三个核两端潜在写来源、旧图18处选择已核准，未创建GPU context。
驱动exec session31954已实际退出0，11个worker全部实际退出0，独立公共状态CPU审计实际0。
trace CPU PID2653999、GPU replay2654431、replay独立CPU2654516均实际0；全部任务已结束，不再重启旧队列。
对外部PID2630247/2646250/2648023/2651917共221次实际占用查询保存，空闲后才运行，未中断它们，其退出码未知。
原版/源码各worker的实际退出码、runtime映射证明及原始数据分别保存。所有诊断图都可能改变原子执行顺序。
这不是旧内部缓存/inactive buffer/原子顺序的精确继续，不替换旧C8、阈值或失败候选。

## 静态host覆盖索引

等待GPU期间，从当前编译所用source_solver.cpp逐字节核准出处，记录20处重建范围保护分支。
host-guard-inventory.json包含实际行号、上下文、源/host SHA；保护均未删除。
这是静态索引，没有证明条件可达或SDK支持，不能当作20个已验证缺陷，也不能换算剩余工时。
后续恢复功能组合仍须先调用固定SDK核实，再按已有协议补host调度和验证。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python scripts/verify_reconstruction_snapshot.py
```

关闭报告拒绝覆盖；新GPU采集/CPU审计请固定新输出目录。维护工具及as-run模板、命令、原始NPZ、终态均随仓库保存。
生产未改，没有无故重复74项回归；G1旧长程、复杂布料、粒子seed2和host未捕获组合仍未验收。
