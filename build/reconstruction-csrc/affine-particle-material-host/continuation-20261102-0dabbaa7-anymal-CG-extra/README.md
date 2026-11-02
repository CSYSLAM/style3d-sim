# ANYmal首NL完整50轮matrix.extra生产者（2026-11-02）

接续5149d4ec。固定SDK64a、生产host0dab/Core715、CUDA176/f0、迭代数、数学及旧失败均未改。
正常源码step没有SDK映射；后续SDK/PTX调用只用于显式诊断。目标仍为源码独立替代，当前ready=False。
本轮初余17503MiB，外部worldparticle保持运行；自己的GPU任务串行，free>=4096MiB即可准入。

## 实际范围与结果

两端各从同一冻结SDK public state重新运行真实native step。该上下文独立于上一full50，不能混用其数组或history。
抓首NL的direction、六类extra生产者、matrix共8类，每类两端各50份完整输入，800输入/2400三端回放。
包含全部非空flat及view指针：JointCoordinateView120B、AngularLimitView32B、RollingContactView248B。
所有真实参数字节、指针重定位、mod256、完整before/after、readonly和保护区均保存并独立CPU核准。

| 算子 | 严格完整输入 / 100 | 备注 |
|---|---:|---|
| direction | 100 | 首轮previous numerator为NULL |
| SO3 tangent | 100 | 100次实际改变完整extra输出 |
| rigid contact tangent | 2 | 98份有原子散射差异 |
| soft off-diagonal | 100 | 实际active count296，输出均未改 |
| drive tangent | 51 | 49份有原子散射差异 |
| angular limits | 100 | 此上下文输出均未改 |
| rolling tangent | 99 | 仅1份有原子散射差异 |
| matrix + denominator | 0 | 完整Ap向量全严格，仅分母归约有差异 |

552/800严格，GPU子及根实际1保留，独立CPU实际0。
CPU核142800实际参数字节、15676800完整输出字节、641205888保护字节、0alias组。
backend失败调用数为contact193、drive117、rolling1、denominator286；不等于非严格输入数。

独立context CPU核1300个真实地址及字节连接全同：每轮direction到7个消费者，
以及SO3→contact→soft→drive→limit→rolling→matrix.arg5的6个累积连接。
100个实际首extra buffer为零，8类核owned序号每轮依次连续。
实际contact/soft/rolling active count为160/296/160；soft/limit未改输出不证明一般分支或无atomic，不能外推。

全部248份非严格输入执行496次实际原/源PTX原子追踪，545056项贡献的target/F32值/线程内序全同。
每份原始trace、真实ABI、guard、readonly独立CPU全核；matrix的instrumented完整Ap也等于捕获。
使用8个完全相同instrumented module句柄复用，未改算术、launch geometry、shared memory或生产资源参数。
实际原子记录按packet分JSON保存并带SHA索引，避免超过GitHub单文件100MiB限制。

全部892个回放差异word：contact407、drive73、rolling1、CG denominator411。
1785个不同真实目标均经GPU atom.global.add.f32逐位复现；62940返回历史word、4159200保护字节、
64260实际参数字节由独立CPU重读核准。CPU另从全部800份输入/三端结果重建覆盖全集，防止漏掉未自选的差异。
contact每目标最多8贡献、drive/rolling最多4，使用保持线程目标内先后次序的受限搜索；CG每world68项，使用固定seed合法排列。
每个标量的可达顺序不证明生产联合全局顺序，也不把原始严格失败或旧轨迹改判为通过。

## 计数、尺寸及诊断失误

contact_tangent与angular_limits入口在CG前还有预条件器/force模式，抓前50次会漏CG尾部。
本批抓前52次，再按真实owned25（首direction）至524（首apply，排除）选出全50轮。
contact call ordinal为iteration+1、limit为iteration+2，其余为iteration；800份均实际断言。
52次原始抓取中未装包的其他模式仍完整保留，不冒充本批已验证范围。

真实shared尺寸为17body/56shape/12drive/18DOF/68particle，状态为544particle/136body。
drive权重12*16字节、angle/initialized96*4；soft capacity30464，不是rigid capacity1000。
完整方案、所据源结构/固定真实span和各参数/offset/bytes见schema.py及capture/plan.json。
十份每十轮NPZ存原始完整输入；原始bin未删减，单文件均小于100MiB。

首次证书脚本生成因字符串替换次数断言失败，在写入前退出1；之后一次误启动尚不存在的脚本退出2。
prepare-folds.log保留此错误，无GPU调用。修为精确整行替换并检查生成终态后再依次运行，
prepare-folds-v2.log为真实成功准备；未修改操作数、目标、原核或容差。

## 文件、命令与接续

actual-tool-receipts.json保存实际工具终态。capture/status、operator-status-v2和GPU报告保存子worker实际退出。
capture/full-input-replays含800份三端结果、十份完整输入NPZ；atomic-operands含248份原始trace及贡献JSON；
scalar-folds-v2含1785目标的实GPU完整原始buffer及历史。所有本批GPU worker均已真实终态。

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-CG-extra"
# 以下已执行；现有输出拒绝覆盖，重跑应建新目录，不删旧失败。
.venv/bin/python -B "$phase/capture.py"
.venv/bin/python -B "$phase/prepare-replays.py"
.venv/bin/python -B "$phase/capture/run-replays.py"  # 实际1；CPU子实际0
.venv/bin/python -B "$phase/audit-context.py"
.venv/bin/python -B "$phase/trace-operands.py"
.venv/bin/python -B "$phase/audit-operands.py"
.venv/bin/python -B "$phase/prepare-folds.py"
.venv/bin/python -B "$phase/run-folds.py"
.venv/bin/python -B "$phase/audit-folds.py"
```

下一步在新上下文补齐首NL前及各NL的完整RHS/预条件器组装，并核后续非线性状态传播。
next-owned-kernels.json保留实际首26个节点：contact force8之后还有rolling9、soft10、body spring11、
joint AL12、drive load13、angular14、SO3 force15；预条件器在16..22，inverse23。
不能把单个contact RHS或contact matrix的post直接当作首residual/inverse输入。
当前extra生产者已按本批首NL50轮核准，不需要重复旧队列；后续NL及整步仍未完整验证。
若同输入真实贡献出现差异，先查固定SDK反编译或实际调用；不要为通过旧C8改数学、预算或样本。

固定so/360pyc、源码和全部证据仍在同一仓库；Windows用WSL2，先核根snapshot并恢复旧gzip证据。
本批新增大量原始小文件，根snapshot可压紧JSON格式以低于100MiB，不能删除条目或改SHA。
最终默认切换、旧G1/mixed/复杂布料及隔离候选验收仍未完成，以根CURRENT_STATUS为准。
