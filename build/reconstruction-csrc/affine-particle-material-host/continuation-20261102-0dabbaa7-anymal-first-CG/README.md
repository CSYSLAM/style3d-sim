# ANYmal同一public起点：首轮与完整50轮CG核对（2026-11-02）

本阶段接续a5313d00，目标仍为源码独立替代固定项目SDK。生产host0dab/Core715、SDK64a、
数学、迭代数、阈值、旧失败及默认入口均未修改，`solver_api_ready=False`。
源码实际step无SDK映射；三端回放中的SDK调用仅为显式诊断对照。

用户指出GPU可共享是正确的。本阶段继续按剩余显存至少4096MiB准入，自己的GPU任务串行。
最近2303次真实原子证书启动时余17553MiB，外部worldparticle程序仍在运行；没有等待它退出或停止它。

## 本阶段证据

原/源均使用上一脚部阶段的common-step.py，恢复同一冻结SDK public state后各运行一次native step。
这不恢复旧500帧solver私有history，也不声称复现旧冻结轨迹。每次新增捕获均是独立上下文，不能混用数组。
20份固定ANYmal资产由asset-restore.json记录，逐份校验SHA；独立asset-cache避免改旧冻结缓存。

实际PCG来自revisions/pcg_23fb797.cu覆盖：8world、每world68粒子、全状态544粒子、17共享body。
标量是8个float，不能按3个CUDA block抓长度。ELL为544行/19 slots，entry40字节。
inverse参数0/3原址alias保留；direction首轮previous numerator为NULL，其余49轮指向真实上一片32字节。

| 批次 | 完整输入 / 三端调用 | 严格packet | 独立核准范围 |
|---|---:|---:|---|
| capture首CG及首apply | 16 / 48 | 8 | 全部inverse、direction、update、apply严格 |
| full50首NL核心及5次SO3 RHS/inverse/apply | 430 / 1290 | 232 | 所有向量/矩阵输出同输入逐位一致 |

三端指SDK-runtime、原提取PTX、源码PTX。full50的198个非严格packet仅世界系数归约不同；
原严格失败和GPU退出1原样保留，没有把证书改写成严格通过。
full50独立CPU读取28460实际参数字节、10986240完整输出字节、152537112保护字节及10个inverse别名。
完整原始4456个bin、两份worker NPZ、430份回放结果均保留。

首批8份原子packet的16次实际追踪给出35456对相同贡献；58个差异word的122个真实GPU目标与3952历史word全核。
full50另有200份PCG packet、400次实际追踪，108800对target/F32操作数及线程内序全同。
独立CPU另核实际参数、guard、readonly及instrumented完整z/Ap等于原捕获向量。
每核544个active thread各一次原子，224个padding thread无写，world为tid//68。

full50/scalar-folds-v2覆盖全部1017个回放差异word的2303个不同真实目标，
均由相同实测操作数的合法排列经GPU atom.global.add.f32逐位复现。
独立CPU再从全部430份原始packet和三端结果重建覆盖全集，并核156604个真实返回历史word、
5969376保护字节和82908实际参数字节。每个标量可达排列不证明生产全局联合线程顺序或整段轨迹一致。

## 传播链与仍未证明的范围

首批18个观测连接中14个相同；contact force后还有其他RHS写入，contact矩阵后还有预条件器处理。
不能省略它们，也不能把首update直接接首apply：两者之间实际还有49轮CG。

full50/context-independent-cpu.json独立核1096个字节值连接全部相同，包括最后SO3 RHS→初残差、
逐轮z/num/p/Ap/den/r/delta/previous numerator及第49轮update.delta→首apply.delta。
初delta和50片num/den均为零。该次上下文delta跨端最大分量差从第0轮3.49246e-10到第49轮0.0003192377；
首批捕获的首apply差0.0002454068属于另一次运行，不能混用。

matrix.extra的完整输入虽已抓取，其六类上游尚未全部在本阶段逐项回放。
本批没有证明整个RHS组装、全部extra生产、后续NL或完整一步的联合因果，不能关闭旧C8/C10及轨迹失败。

## 搜索失败与实际终态

V1准备在packet14/precond call003/world3失败：10000个随机排列未碰到固定目标998498792。
fold-search-v1-failure.json保存相同68个正操作数及全部原目标；独立诊断的大小/warp分组合法排列已覆盖所有目标。
V2只增加这些候选顺序，不改操作数、目标、原核、容差或生产调度。V1脚本和失败文件保留，V1未运行GPU。

V2准备的旧工具handle41112跨压缩后无法再查询，不能补造其退出码。
完整plan/inputs的SHA已被后续实际GPU及独立CPU全核；2303目标证书与覆盖结论来自这些真实终态。
第一次首批证书生成器因132列在落盘前失败，未运行GPU；修短文本后再执行，未改数学。

actual-tool-receipts.json记录实际观察终态。capture/full50的GPU回放根均为1，独立CPU均为0；
所有捕获、操作数追踪、原子证书及其独立审计均已完成，当前没有本阶段live GPU worker。
原子追踪报告中的aggregate_scalar_folds_certified=False是当时的范围声明，不回写历史报告；
后完成的scalar-folds-v2/GPU-report.json与independent-cpu.json才是本批完整标量证书。

## 命令与接续

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-first-CG"
# 已执行的脚本拒绝覆盖旧输出；重跑须新建阶段/输出目录，不删除失败证据。
.venv/bin/python -B "$phase/capture-full50.py"
.venv/bin/python -B "$phase/prepare-full50-replays.py"
.venv/bin/python -B "$phase/full50/run-replays.py"  # 实际1；含CPU审计实际0
.venv/bin/python -B "$phase/audit-full50-context.py"
.venv/bin/python -B "$phase/trace-full50-operands.py"
.venv/bin/python -B "$phase/audit-full50-operands.py"
.venv/bin/python -B "$phase/prepare-full50-folds-v2.py"
.venv/bin/python -B "$phase/run-full50-folds-v2.py"
.venv/bin/python -B "$phase/audit-full50-folds-v2.py"
```

下一步在新上下文补齐每轮matrix.extra生产者，按真实调用顺序为SO3 tangent、rigid contact tangent、
soft off-diagonal、drive tangent、angular limits、rolling tangent，再连接到matrix.arg5。
view中指针须按真实offsetof重定位；尺寸按shared17body/56shape/12drive/18DOF及544状态核准。
soft capacity30464，不能误用rigid capacity1000；实际active count和分支也须记录，不能用无操作路径外推一般一致。
同输入若有真实逐项差异，再查固定SDK反编译或实际调用修恢复源码，不调整生产阈值。

新电脑仍用Windows上的WSL2。先核根snapshot，再restore_reconstruction_evidence恢复旧无损gzip。
固定so与360份pyc继续保存在同一仓库；不得为导入测试覆盖它们，使用-B。
最终仍须完成所需host组合和demo的固定对照，再切换默认入口；根CURRENT_STATUS是完整未完成范围。
