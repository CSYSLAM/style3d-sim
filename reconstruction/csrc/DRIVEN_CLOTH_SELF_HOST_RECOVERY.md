# 驱动关节、布料与自碰撞：隔离候选7ca67172

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
