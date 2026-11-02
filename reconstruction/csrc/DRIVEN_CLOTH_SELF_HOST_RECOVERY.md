# 驱动关节、布料与自碰撞：隔离候选7ca67172

接续新增真实ABI核对已完成，1188完整输入/3564次三端回放排队；
原始字段、命令及当前等待身份见[完整输入回放](DRIVEN_CLOTH_SELF_REPLAY.md)。

生产仍为host0dab/Core715，唯一原版SDK64a、CUDA176/f0、360份冻结pyc及默认原版入口均保持。
本批恢复了一个实际demo需要的host范围及调用位置，但两个固定短程C8失败尚未解决，候选未合入。
整体`solver_api_ready=False`，不能据下述局部证据宣布源码已经完整替换so。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-driven-cloth-self/`。

## 缺口与真实SDK支持

未改`examples/example_cloth_h1_free.py`的105行启用self collision，且有驱动关节和布料。
当前生产代码的`driven_cloth`定义排除了self，又在self/body范围检查中排除了约束；该组合实际会被拒绝。
新增小夹具`driven_cloth_self_scene.py`使用两块相距4mm的布料和一个驱动revolute关节，不依赖外部资产。
固定12组合包含SO3/SIX、W1/W3、Newton/PD、body-block、无外部/legacy/surface及diagonal-only。
SDK12组均真实运行三步并finite，生产源码12组均被同一guard拒绝，原始运行全部保留。

本场景每world为8布料粒子及8仿射代理、4三角形、10条碰撞边、2刚体和1驱动。
首轮VF和EE都有实际RHS变化；非diagonal模式的VF/EE计数均正。
EF有调用但首轮RHS无变化，不冒称覆盖了有效EF算术；没有自由PP碰撞粒子。

## 两个候选及确定的host顺序修复

首候选c243042e只去掉两处范围限制；12组都运行结束，10组状态严格，但12组的调用顺序都不一致。
CPU逐条检查发现只需将每个NL的三段self force移到joint/drive/limits之后，所有参数便与SDK完全对应。
实际SDK表面刚度scale仍位于joint之前，不能把整个self准备块一起挪走。

SDK64a反汇编保存在`SDK-step-*.asm`：SelfCollision::accumulate位于fed26，返回主流fceb4；
surface stiffness调用位于ffeca，返回joint前fc9be。实际三步调用日志同时给出对应顺序。

第二候选7ca67172仅在首候选上移动`accumulate_self_particle_pairs`，保留原stiffness copy/scale位置。
没有改变数学、阈值、真实碰撞记录次序或CUDA资源属性；C++/命令/两个so/实际diff依据均保留。

- 12组共9243次owned调用的完整已审计参数、geometry及覆盖计数均与固定原版相同。
- 10组状态和首次self缓冲全严格；两组W3/PD/surface仍严格失败，所有首个source0原样保留。
- 四类实际constructor的五项检查全同：分配/释放字节及位置、上传字节/顺序、typed初始化、
  flat指针分配身份/偏移、owned和库内核次序。每端107 allocation events、37 uploads、61 typed初始调用。
- 新源码worker均未映射原版SDK。这里是A/B桥接的独立源码host测试，正式H1 free公共Core示例尚未验收。

## 两个固定失败与首表面力定位

`short-fixed-C8`为每例固定八SDK/三source；SDK0取首次SDK，source0取7ca首次失败，逐字节复制并独立复核。
两个组合的三source均false，没有换候选、扩cohort或放宽规则。
SO3第二步particle_qd偏差约7.01，第三步最大约18.28；SIX三步最大约21.13，不能统称末位误差。

补抓的首表面力实际参数为capacity180、active66、local16/total48、local shapes2/bodies2，不能套旧12/36夹具。
25个非空指针完整容量均保存，仅在跨端语义比较时截取66条有效接触前缀；没有排序输入。
两端25个有意义输入字段、完整惯性RHS和surface前RHS都逐字节同，surface后RHS不同。

四份实际packet的逐接触SDK runtime/原版PTX/源码PTX共792调用完整输出严格；
每端8496个真实原子操作数序列同，12次aggregate回放都没有精确复现捕获after，包括SDK自身。
这证明首kernel的逐接触算术相同，不证明后续大响应已经完全解释。
扩展观察器的四条完整三步轨迹均未复现原冻结轨迹，未替换接受样本。

静态读取证明发现SurfaceView实际通过`mov(param0); add.s64(...,8)`访问，
首版checker只识别mov而退出1；v2验证两级定义唯一、无条件entry前缀支配及296字节参数界限，
只对分析文本消除别名。两端实际PTX只以F32 red写RHS、不读取RHS、无跨线程barrier，执行PTX未改。
短C8 CPU首版仅因int/JSON-string checkpoint键比较退出1，v2规范化JSON键后完整统计一致；旧报告未改。

## 接续：host数据流核对与后续PCG采集

已提交检查点`5c0a5bd4`包含上述恢复代码、失败轨迹及2541份已完成证据；273887文件快照完整校验退出0。
新的接续目录为：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-flow/`。

直接复用已完成constructor的真实内存轨迹，无新增GPU调用，补核了此前opaque视图中的指针：

- 两个失败组合共144对SurfaceContactView调用全部一致，包括标量、26个指针字段的空值或目标。
  每端288个owned字段的分配ID、偏移、完整span边界已核准；3312个external字段保留原始精确地址及已知model标签。
  外部Warp分配的边界未由本observer记录，不能把相同地址外推为其内容或容量证明。
- 四类场景每端共258次D2D复制、396次byte fill，记录到的大小、目标、值、异步模式、stream及owned调用边界全同。
  每类仍有三次外部复制来源缺少语义标签，仅两端原始地址同；没有宣称覆盖所有CUDA API或所有外部输入值。

下一批固定采集两组各原版/源码一次、各三步，观察RHS、自碰撞VF/EE/EF、预条件器、全部五轮CG和非线性apply。
SO3每端621阶段/7524快照文件；SIX每端567阶段/7398文件，共计划2376阶段/29844快照文件。
full-input阶段覆盖14种真实kernel，原版/源码28份实际PTX静态写入来源审计全部通过；这是静态准备，尚非GPU实测。
同一scene中，SO3的CG行计数/矩阵为64/896字节，SIX为192/13440字节，均取自真实分配；不能套旧夹具尺寸。
SIX的block-initialize参数2实际NULL，只采集有效输出；首CG direction的previous numerator同样按实际NULL模式处理。
两次准备脚本失败、as-run源码和修复依据保留：先补self参数0的实际位置span，再正确识别block-initialize的NULL输出。
这些修复仅作用于诊断采集规格，未修改求解器。

首队列session79052在启动前复查发现审计器将dict传给要求`.files`接口的比较函数；
确认尚无GPU worker后仅停止该等待进程，原工具实际退出143。v1脚本、计划及身份均保留。
修正的v2适配器已用两组真实冻结轨迹核对，统计与既有NPZ报告完全同、旧严格失败保持；CPU预检实际0。
当前原机器队列工具session37865、PID3301837，boot/start_ticks见`linear-captures-v2/runner-identity.json`。
它先等待原scalar worker及独立CPU审计，再在设备空闲时串行启动四个worker；本检查点尚未启动GPU worker。
核原进程和status，不要重复运行已有runner：

```bash
source scripts/reconstruction_env.sh
flow_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-flow
ps -p 3301837,3272557,3280049 -o pid,etime,stat,args
cat "$flow_phase/linear-captures-v2/status.json"
```

worker结束后会自动运行`audit-linear-flow-v2.py`，检查文件覆盖、未写区域、同一轨迹CG向量的生产/消费关系及公开位置。
新轨迹只用于定位，必须报告其是否复现冻结失败，不能取代原C8样本。下一步依据实际apply增量和CG差异定位大响应，
对出现差异的完整同输入packet调用SDK/PTX/source核对；本检查点没有新增轨迹通过或归因结论。
Windows继续使用主交接的WSL2环境；这些PID仅适用于原机器。新机器须新建证据目录并生成自己的计划，
不要直接执行旧runner；`--fresh-machine`仅跳过原机器等待依赖，不会修复历史绝对路径或替代新机器验收。

## GPU标量证书与当前等待

首次593次单lane GPU标量/历史调用全部完成，独立CPU核593结果、13788 history words、2304来源标量及保护字节。
每线程同一目标上的normal/friction先后保持；不推断不同目标之间存在一个全局联合顺序。
一次CPU联合顺序试探16份均存在拓扑环，未作为通过证据，原输出保留。

首次593调用启动前，外部GPU任务已占设备，编排误把非空查询结果直接放行。
`surface-scalar-isolation-notice.json`明确记此失误；首批原始结果仍保存，但`isolated_gate_satisfied=False`，不用于隔离验收。
未中断外部任务。相同预定输入的隔离重跑已由脚本内部等待GPU空闲后才创建context。

本检查点待续：GPU工具session67261，原机器Python PID3272557；boot_id/start_ticks见
`surface-scalar-certificates-isolated/waiter-identity.json`，实际命令/进程再核见`isolated-waiter-receipt.json`。
先核真实进程与`GPU-waits.json`，不要重复启动。
CPU接续器session2752/PID3280049会等同一进程结束后运行独立审计；它不能取得非子GPU进程的退出码，
根线程仍需从原工具session67261取得实际终态，不能把report.complete自动当作退出0。
Windows/其它机器上的同数字PID无效，`run-isolated-followup.py`仅适用原机器现有任务。

## 接续命令及边界

依根交接在WSL2使用固定Python/CUDA环境，先只读查当前结果：

```bash
source scripts/reconstruction_env.sh
phase_root=build/reconstruction-csrc/affine-particle-material-host
self_phase=$phase_root/continuation-20261101-0dabbaa7-driven-cloth-self
pgrep -af 'driven-cloth-self/(certify-surface-scalars-isolated|run-isolated-followup).py'
nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader
.venv/bin/python -c 'import json,sys;print(json.load(open(sys.argv[1]))["complete"])' \
  "$self_phase/surface-scalar-certificates-isolated/report.json"
```

等待期间report可能尚不存在；应核同一进程，不能据缺文件重启。原目录/原失败不可覆盖。
隔离GPU593调用实际结束后，CPU审计命令为：

```bash
.venv/bin/python "$self_phase/audit-surface-scalar-certificates.py" \
  --certificates "$self_phase/surface-scalar-certificates-isolated"
```

新机器复核相同冻结算术输入，应另建兄弟目录，复制四份完整replay数据和隔离脚本；不迁移原PID接续器：

```bash
new_self_phase=$phase_root/driven-self-scalar-repeat-$(date +%Y%m%d-%H%M%S)
mkdir "$new_self_phase"
cp -a "$self_phase/first-surface-replays" "$new_self_phase/"
cp "$self_phase/certify-surface-scalars-isolated.py" "$new_self_phase/"
.venv/bin/python "$new_self_phase/certify-surface-scalars-isolated.py"
.venv/bin/python "$self_phase/audit-surface-scalar-certificates.py" \
  --certificates "$new_self_phase/surface-scalar-certificates-isolated"
```

这只复核冻结输入的算术，不是新机器完整demo验收。重跑独立scene/C8需要新phase并固定新计划，保留实际失败。
下一步先取得隔离实测终态，再沿这两个固定失败的真实后续输入定位大响应形成；
不能把首kernel证书写成整段通过。正常H1 free、长程graph、initcheck及生产合入后的完整回归均尚未执行。
