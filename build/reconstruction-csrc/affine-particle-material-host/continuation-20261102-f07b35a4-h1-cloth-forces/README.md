# 当前 f07/Core aa：H1 首轮布料力及自碰撞 Hessian 消费

本阶段继续固定项目 SDK64a 对当前 f07 host/Core aa，完成首NL全部实际stretch/bend primitive的原生算术验证，
以及self-Hessian diagonal消费核的完整输入三端核验。完整源码替换、H1正常固定C8仍未通过。
生产d09/Core55、CUDA176、默认入口、SDK及360固定pyc保持；候选未合入，`solver_api_ready=False`。

## 具体完成内容

8个GPU worker严格串行，全部实际退出0：正常公开H1两端capture2、三端回放1、PTX原子探针1、原生隔离4。
每个保存GPU准入时间/外部应用/free，free>=4096MiB即可运行；没有等待或停止外部程序。
正常示例不改物理/测试、不用AB bridge，源码worker不映射SDK；显式隔离诊断才分别加载三端实算。

| 真实范围 | 结果 |
| --- | --- |
| 首NL rank79 stretch、80 bend、88 self-add，全部输入 | 每端18快照/13879120 bytes，CPU核全部36 descriptor/27758240 bytes及原图节点/边 |
| 六完整输入/18三端调用 | self-add六完整输出全严格；stretch/bend的12 aggregate输出全非严格，原SDK自身也不同，保留失败 |
| 原/source PTX实际原子探针 | 7216968记录逐线程目标/顺序/F32全同，两端对应primitive也同 |
| SDK初值66930 stretch三角形 | 200790次原生SDK/原PTX/f07调用，全RHS/guard严格 |
| SDK初值100634 bend边 | 301902次三端调用，全RHS/guard严格，含无有效贡献的边 |
| 源码实际初值同样两批 | 另200790＋301902三端调用全严格，未借用SDK初值的通过结果 |
| 独立CPU原生隔离审计 | 335128实际primitive试验、1005384调用、3608484整数RNE/FTZ步骤、10825452实际目标值全部同 |

两套初始RHS确实不同，均逐项恢复实际种子，不使用零向量或放宽容差。
stretch每三角形9个原子贡献，bend有效边12个、无效边0个；实际原始PTX每端为602370和1201872记录。
每个primitive四个metadata字段复制到row0，工作count设1，保留world尺度、实际状态/材料、原262/394 blocks和256线程。
原/source内核均未改；reset后context fence，再非阻塞launch，固定backend rotation。

继续使用上一阶段已编译、冻结的 `membrane-complete-word-check.ptx`，只作诊断整数patch/gather/compare。
逐次比较完整RHS、两侧guard及独立dummy保护区，保存所有实际写入word，其他word由完整逐位零差核准。
每个case先做9组正/负控制，对首/中/末/有效数据/guard/两buffer边界及多点bit破坏完整CPU回读，独立核完整SHA。
累计102465721128个u32 word实GPU比较，未抽样或只比较稀疏目标。
独立CPU复用上一冻结审计器的整数F32加法函数，按manifest SHA取AST函数，不执行原脚本；
它不使用GPU worker的NumPy浮点加法。全部原始记录/实际输出/控制在本目录。

`h1_first_cloth_layout.py` 是新增规范布局。`captures-independent-cpu.json` 核实际ABI、物理分配边界、全部前后字节。
本批首stretch输入RHS跨端已差395 words，stretch后差44528；这是本批队列，不与上一批watch统计混用。
自碰撞VF/EE/EF的完整producer接触表仍待做；self-add消费核通过不能替代这三个生产核验证。
两步 `Example.step` 仅capture＋一次真实graph replay；没有冒称默认20NL、601帧或整步已全证。

原固定H1 8SDK/3source C8仍 `[true,false,false]`，SDK控制仍 `[true,true,false]`。
12 aggregate失败、其他正常demo/G1/ANYmal旧失败均保持；没有生产合入、资源调参、数学或阈值改动。
原子算术相同不证明联合全局调度、完整轨迹或源码整体可替换SDK。

## 本机历史命令与下一步

实际命令/真实退出均有 `*.command.json` / `*.status.json`。已完成目录和报告禁止覆盖或盲目重启。

```bash
export PYTHONDONTWRITEBYTECODE=1
cloth_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-f07b35a4-h1-cloth-forces
.venv/bin/python -B "$cloth_phase/prepare.py"
.venv/bin/python -B "$cloth_phase/run.py"
.venv/bin/python -B "$cloth_phase/audit-captures.py"
.venv/bin/python -B "$cloth_phase/run-replay.py"
.venv/bin/python -B "$cloth_phase/run-producer-operands.py"
.venv/bin/python -B "$cloth_phase/audit-producer-operands.py"
.venv/bin/python -B "$cloth_phase/prepare-cloth-native-isolation.py"
.venv/bin/python -B "$cloth_phase/run-cloth-native-isolation.py"
.venv/bin/python -B "$cloth_phase/audit-cloth-native-isolation.py"
.venv/bin/python -B "$cloth_phase/close-independent-cpu.py"
```

原生隔离预检首版在未用trace slot的sentinel表达式混用u64/i64，被NumPy转为f64，独立marker发生舍入重合。
CPU guard在任何新GPU启动前拒绝；旧配方及 `cloth-native-inputs/CPU-rejection.json` 保留。
修为纯u64后在新目录 `cloth-native-inputs-v2/` 运行，没有改原始GPU记录或生产算术。

接下来优先抓rank75/76/77的VF/EE/EF完整输入/接触切线表及实际计数，再核其真实贡献与matrix-free tangent消费。
H1实际self tangent容量很大，必须按真实分配范围核准后读取，不能套用小fixture或G1 n176尺寸。
继续aggregate硬件顺序证书、同次后续NL/CG extra/子步和正常demo验收，不重做本批已完成primitive。

## 固定so及新Windows/WSL

实际SDK及两个候选so仍在同一仓库，SHA和正常WSL Core命令沿用
[上一批完整版本及命令](../continuation-20261102-f07b35a4-h1-first-cg/README.md)。
SDK SHA64a0be7f…，host f07b35a4…，Core aa3466ef…；没有登录要求或SDK代算源码路径。
先按根 `RECONSTRUCTION_HANDOFF.md` 运行 `python3 scripts/verify_reconstruction_snapshot.py`。
现有ELF是Linux/Python3.12，Windows用WSL2；未声明真实Windows/WSL机器验收。
正常Core metadata为相对路径可迁移；本批诊断plan和旧资产缓存含绝对路径，新机器需在新目录核同字节后生成新计划，
不能删除SHA guard或改写旧证据。Newton资产ref仍固定 `261cd1f429619d8ef4f546bd788ab9dea906b5e1`。
