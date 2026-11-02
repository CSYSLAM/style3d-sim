# ANYmal五NL完整RHS/预条件器组装及outer状态（2026-11-02）

接续2bd99038。SDK64a、生产host0dab/Core715、CUDA176/f0、数学、迭代数、容差和所有旧失败保持。
本批正常源码step无SDK映射；SDK/PTX调用仅作显式诊断。源码独立替代仍未完成，ready/default未切换。
本轮起始GPU余18068MiB，证书启动余17288MiB；外部worldparticle保持，自己的GPU任务串行。

## 实际范围和严格回放

从同一冻结SDK public state分别重新构造/step一次，覆盖五次非线性迭代的全部RHS/预条件器组装、
首precondition、末CG update、apply、SO3及joint AL状态更新和最后velocity/drive angle。
每端111个实际阶段、222完整输入/666次SDK-runtime/原PTX/源码PTX回放，181/222严格。
GPU子及根实际1、独立CPU实际0；原始严格失败不改判。

同输入严格的范围包括：五轮所有inertial RHS、soft两模式、body spring、angular两模式、SO3 force、
初始化blocks、SO3/drive/rolling preconditioner、inverse、末update、apply、SO3 state、joint state、末velocity/angle。
joint AL state实际只有4次，末轮不更新；不能按5次虚造缺失输出。
force里的部分路径可能未改变输出，完整after严格也不外推未执行分支。

剩余41份非严格输入，只涉及以下散射/归约输出：

| kernel | 不同输出 | 失败backend调用数 |
|---|---|---:|
| joint AL force | RHS arg10 | 30 |
| drive load | RHS arg26 | 17 |
| first precondition | world numerator arg6 | 30 |
| rigid contact force | RHS arg32 | 9 |
| rigid contact tangent的矩阵模式 | system arg33 / preconditioner arg34 | 9 |
| rolling force | RHS arg1 | 3 |

backend调用数不是非严格输入数。独立CPU核33902实际参数字节、9192000完整输出字节、
104056896保护字节、10个inverse原址alias；所有真实flat/view指针完整重定位，mod256保留。

## 实际原子贡献、证书与传播

全部41份非严格输入执行82次实际原/源PTX追踪，175840项target/F32值/线程内序全同。
独立CPU重读实际参数、view偏移、raw trace、guard/readonly；instrumented precondition的完整z也等于原捕获。
贡献按packet分JSON保留带SHA索引，实际PTX及完整原始buffer均保存，未改算术/launch/resource参数。

726个实际回放差异word：jointAL611、drive17、precondition64、contact RHS25、contact矩阵8、rolling1。
全部1477个不同原目标由相同实测操作数的合法排列经真实GPU F32 atomic逐位复现。
独立CPU另从全部222输入/三端结果重建差异覆盖全集，核19004返回历史word、3176928保护字节、53172参数字节。
jointAL每目标实际最多8贡献，使用保持线程目标内次序的受限搜索；world归约68项按固定候选/seed搜索。
每标量可达排列不证明生产的联合全局线程次序，不据此关闭旧C8/C10或整段轨迹失败。

独立context核298个真实值连接全部相同，包含全部RHS/scale/preconditioner累积、两处copy的值观测、
inverse→首precondition、末update→apply、四次outer AL递推及最后velocity/angle。
四份public particle q/qd与末native输出逐字节相同；copy连接明确记录地址不同，不冒充同指针或D2D API证明。
每次apply后的delta确实清零。本批只抓每个CG循环首/末，不能把二者直接相连当作中间49轮已证明。

该上下文初inertial RHS跨端全同，首组装RHS差1.1444e-5、首预条件器输入相同；
首NL末delta差2.790516e-5，后续RHS已受新位置影响。五NL每轮差值保存在context-independent-cpu.json。
这不复现旧500帧私有history，与前两批first-CG/extra的独立捕获不能混用数组、目标或history。

## 选择抓取和关键尺寸

angular_limits全步260次、contact_tangent255次、soft_force10次，前两者有不同force/matrix/tangent模式。
为抓五轮组装而不重复250轮CG tangent，构建单独cudahook-selected-owned.so：
只按已完整记录的owned rank选择pre/post copy；真实kernel调用、完整launch log、所有per-key ordinal增长保持。
四条继承超长formatter只调整空白至128列，原hook源/so和生产库没有修改。

实际两端各3098个raw dump文件集合与111个所选阶段的完整字段精确相等，无漏抓/多抓。
两端2608条normalized metadata相同，新SDK与原hook的旧SDK metadata也同；metadata只核NULL/present及标量/geometry，
不替代完整buffer核对。actual source/Core hash及不映射SDK由每个真实step worker断言。

RHS mass ELL为shared68行/19slots/8字节entry，不是CG的544行/40字节block entry。
drive qd/angle/initialized为96项；feed/target q/qd是8world*18DOF共144项，模式/刚度等是shared18项。
其余shared17body/56shape/12drive/68particle、全状态544particle/136body，详见schema.py和capture/plan.json。
20固定资产离线恢复到本阶段cache并逐SHA核准，未改旧缓存。

一次原子脚本生成因docstring130列在落盘前失败，未启动GPU；缩短文字后执行，真实原始结果全部保留。
早期schema的tuple换行在首次preflight前已纠正，未启动失败GPU或生产修改。

## 命令与继续位置

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-RHS-preconditioners"
# 已执行；现有输出拒绝覆盖。重跑建新阶段/目录，保留旧失败。
.venv/bin/python -B "$phase/build-hook.py"
.venv/bin/python -B "$phase/capture.py"
.venv/bin/python -B "$phase/prepare-replays.py"
.venv/bin/python -B "$phase/capture/run-replays.py"  # 实际1，含CPU子实际0
.venv/bin/python -B "$phase/audit-context.py"
.venv/bin/python -B "$phase/trace-operands.py"
.venv/bin/python -B "$phase/audit-operands.py"
.venv/bin/python -B "$phase/prepare-folds.py"
.venv/bin/python -B "$phase/run-folds.py"
.venv/bin/python -B "$phase/audit-folds.py"
```

actual-tool-receipts记录观察到的真实终态。原始6196个bin、十份完整输入NPZ、222三端结果、原子trace及证书完整保存。
Windows继续WSL2，先核根snapshot并恢复旧无损gzip；SDK/360pyc均在同一仓库，运行Python用-B。

下一步在同一新捕获中补齐全部五NL的完整CG核心/extra链，以及初始化到最终public状态的剩余实际连接。
可在本选择hook上选择全部所需实际owned rank；必须核每个模式的call ordinal和实际raw文件全集，不能仅增dump limit。
当前五轮组装已按完整输入回放及实际贡献核准；首NL的两批完整50轮属于其他上下文，不能直接拼接到这次首/末。
后四NL尚无完整50轮局部回放证据，新捕获必须含自己的首NL，不能从中间开始推断整步传播。
整步和长程固定对照、候选4f/7ca、G1/mixed/复杂布料及默认切换仍未完成，根CURRENT_STATUS优先。
