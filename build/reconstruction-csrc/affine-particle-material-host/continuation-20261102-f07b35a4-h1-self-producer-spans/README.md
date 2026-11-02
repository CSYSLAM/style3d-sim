# 接续中：当前 H1 自碰撞生产核、实际接触表及 tangent

本阶段已完成独立闭合，13个GPU worker及全部CPU审计终态0。目标和版本保持：固定项目SDK64a对f07/Core aa，生产仍d09/Core55，
CUDA176、默认、数学、容差及360份固定pyc不改。正常H1 C8仍true/false/false，没有合入资格或完整替换声明。

上一两阶段已集中提交本地18f021f3、4787fab1。GitHub上传第二次明确拒绝单pack超过2GiB，原始全部证据保留。
用户最新要求先在本地完成全部目标，暂不上传；已停止Git打包准备及后续重试/分批传输计划。

## 已实际完成

1. `run.py` 两GPU worker均0，只运行首capture，原正常API/示例/test不改，源码未映射SDK。
   原图不改、不增GPU分配、不执行物理replay。读真实CSR/拓扑及CUDA allocation bounds。
   `audit-static-csr.py`实际0：两端完整100635 offsets、200790 opposite、33703 mesh vertices逐字节同，
   从实际66930三角形/100634边独立重建全部CSR。真实tangent分配两端都是437046060 bytes，即7284101条60-byte记录。
   第一CG full tangent在rank102，geometry256×256。
2. `full-inputs/run.py` 两正常worker均0，capture＋一次真实graph replay，仅观察第一子步第一NL。
   选择rank75 VF、76 EE、77 EF及102 full tangent。每端50快照/105105340 bytes，
   独立CPU核100实际descriptor/210210680bytes及原图节点/边、分配边界、所有指针参数。
3. contact抓131072条前缀，counter给出完整有效长度：两端VF0→2168，EE2168→7423，EF仍7423，tangent读7423。
   已存在contact prefix及未写尾部逐字节不变，所有有效记录确实落在已抓范围；未读取或宣称抓取437MB未用尾部。
   每阶段 `frame-00.dynamic-prefix.json`保存守卫结果，错误时先保存原始npz再拒绝。
4. `audit-active-contact-inputs.py`实际0：双端7423完整60-byte contact记录multiset同，包括inactive struct字段；
   所有接触ID在实际网格粒子集合中，各阶段完整prefix逐字节连接同。
   self缓存跨端25word不同，全在33708..33838，与实际引用的33703粒子集合交集为空；实际引用的cache word全部同。
5. `full-inputs/run-replay.py` GPU及独立CPU实际0：8 packet/24三端调用/78完整输出，36严格、42 aggregate失败保留。
   原生SDK也重放不严格，不自动判源码通过。EF24输出和VF/EE计数12输出严格；本时刻EF无有效新增，不能证明有效EF分支。
   回放为接触表实际reserve完整437046060 bytes，捕获前缀恢复原字节，未抓后缀设guard；
   不允许源核因写入错误超过prefix就破坏其他allocation，完整后缀也核未写。
   全10757831400 after bytes及10584555336 readonly/guard bytes已独立CPU复核。
6. 16个原/source PTX GPU探针、22112448真实F32记录和29692 append返回行号完整核准。
   同一packet的逐query目标/操作数位值、完整60-byte追加record次序全部同；VF/EE/EF跨两端也同。
   使用1152/128 F32容量及32 append容量，原PTX全部body指令保留；未用诊断slot检查全0后无损packed保存。
7. 两套真实种子下，全部33703 VF query、100634 EE query、7423 tangent contact：共850560次原生SDK/原PTX/f07调用，
   完整RHS/Hessian/原已有接触/新追加接触/counter及guard全严格。40个原始实际query编号的PTX gate控制也全严格。
   独立CPU整数RNE/FTZ核6225792步及2747826个三端实际改变word；352924666200完整输出/guard word实GPU比较全0。
8. 另76个原生SDK/原PTX/实际f07 GPU调用覆盖既有三世界EE/EF边界/异常夹具，包含有效五点EF接触。
   四/五点tangent在grid1/7/256均严格；独立CPU逐份原始完整输出、counter及接触multiset全核，38输出对全部同。
   不再将H1本时刻零EF接触当唯一EF证据；仍不据夹具通过改判完整正常轨迹。

正常worker没有SDK代算/AB bridge。显式kernel隔离重放才分别调用原生SDK、原PTX及实际f07 KernelDriver。
reset/H2D完成后context fence，再非阻塞launch；不复用已知旧unsafe模板。
副本排序仅用于CPU多重集比较，生产输入、真实capture或固定C8均未排序/覆盖。

## 已核准的逐query方法

已记录同输入原/source PTX全部真实F32操作数与每次counter原子返回的全局行号，
将完整接触记录对应到实际query线程，再按下面的方法完成了三端逐query隔离。

- VF一个query最多31个slot，每slot三角端点36个F32原子，最后本vertex12个；trace上界至少1128。
- EE最多31×24＋24，EF最多31×36＋24；不能盲套旧128条/线程探针。
  实际统一1152，单独保留每个launch线程总count并断言不溢出；只限制诊断写，不改原red/atom。
- 追加原 `atom.add.u32(counter,1)` 返回行号的只读记录，按thread/slot关联probe真实after接触表。
  不用猜测原生SDK内部记录顺序，不从未对应的aggregate contact行恢复单query期望。
- tangent只消费7423条；各实际packet原/source PTX要同，跨端direction已继承差异，不把跨端贡献不同误判成核错误。

逐query隔离需要保持原world和地址读入语义，不能把全局编号当无关metadata：

- VF可令工作count=1，把实际vertex、counts及31 slots复制row0；world0且真实vertex ID保留。
- EE的edge编号用于 `edge>=other` 和opposite CSR，直接复制edge到row0会改变算法。
  H1单world可用如下待验证等价重定位：将实际edge字段复制edge0；counts/slots复制row0；
  CSR offsets[0:2]重定向到原edge的opposite区间，opposite数据原样保留。
  slot中原other<=原edge的项原本一定跳过，应改为0使新edge0仍跳过；原other>原edge的ID原样保留，
  这些other必不为0，其edges/CSR仍在原位置。其余邻居及局部循环顺序不变。
  已直接核原SDK PTX local edge ID的全部用途：仅edge地址、CSR地址、edge>=other；40个原query编号gate控制核准等价。
- EF也用edge编号索引CSR；有效分支已用既有三世界原生SDK/PTX/source夹具补核，实际H1首NL仍零有效新增。
- 每个query的RHS、Hessian、原已有contact prefix及counter种子用实际捕获值；contacts追加按原探针返回行号逐query对应。
  单线程原子仍有F32 rounding，继续独立整数RNE/FTZ历史和完整GPU bitwise/guard比较器控制。

当前源文件为 `reconstruction/csrc/h1_self_assembly_layout.py`，每次CPU/GPU命令及终态在本目录/`full-inputs/`。
原子记录器为 `reconstruction/csrc/self_contact_operand_trace.py`。全部记录进根WORK_LOG，完整阶段后本地集中提交。
当前局部证据不证明联合全局原子顺序、后续NL或完整轨迹；正常H1固定C8和42 aggregate失败不改判。

下一步同一次第一物理子步的全部10NL及每NL20个full tangent，补实际query/counter/方向传播，
不把首NL核准扩大成全部子步；再继续其他CG extra/组装及正常demo长程验收。

## 本机实际入口及Windows

历史入口已经有输出，禁止盲跑覆盖：

```bash
self_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-f07b35a4-h1-self-producer-spans
.venv/bin/python -B "$self_phase/run.py"
.venv/bin/python -B "$self_phase/audit-static-csr.py"
.venv/bin/python -B "$self_phase/full-inputs/run.py"
.venv/bin/python -B "$self_phase/full-inputs/audit-captures.py"
.venv/bin/python -B "$self_phase/audit-active-contact-inputs.py"
.venv/bin/python -B "$self_phase/full-inputs/run-replay.py"
.venv/bin/python -B "$self_phase/run-producer-operands.py"
.venv/bin/python -B "$self_phase/audit-producer-operands.py"
.venv/bin/python -B "$self_phase/run-native-query-isolation.py"
.venv/bin/python -B "$self_phase/audit-native-queries.py"
.venv/bin/python -B "$self_phase/run-active-ef-fixtures.py"
.venv/bin/python -B "$self_phase/audit-active-ef-fixtures.py"
.venv/bin/python -B "$self_phase/close-independent-cpu.py"
```

具体版本SHA和正常Core WSL命令沿用前两阶段README。现有so是Linux/Python3.12 ELF，Windows用WSL2。
诊断plan含本机绝对路径；新电脑须核相同字节并在新目录生成计划，不删除SHA守卫或改写本批证据。
