# ANYmal同一上下文完整native step及检查器同步修复（2026-11-02）

接续f1e95214。固定SDK64a、生产host0dab/Core715、CUDA176/f0、数学、迭代数、容差及旧C8/C10保持。
本批正常源码step无SDK映射，未登录；SDK/PTX调用仅用于显式诊断。默认仍原版，solver_api_ready=False。
本次35类/2608次owned调用的同输入计算已按严格输出或真实F32证书核准，整段demo/长程验收仍未完成。

## 同一次实际运行的完整输入

两端各从同一冻结SDK public state重新构造并真实step一次，抓全部35类/2608调用，含7初始化、5NL及250CG。
5216完整输入/15648次三端回放，无跨批拼接。每端74076个raw dump文件集合与所有非空flat/view字段精确相等。
52份NPZ按initial及每NL每10CG分段，原始bin全部保留。pointer alias及mod256、真实ABI字节和完整guard/readonly均核。
该上下文不是旧500帧solver私有history，也不替换旧cohort或冻结source0。

先通过真实SDK/源码prefix抓取确定CSR尾值102/102/51，完整offsets为1293/1293/69个u64，未猜ids长度。
实际ids范围、完整8份inertial refresh输出经独立CPU F32/FTZ重算相同。
7个初始化节点的全部before/after有88份跨端完整buffer比较，全逐字节同。
14份初始化同输入回放全严格，含质量ELL、预测/previous/target/diag、SO3/joint初态、combined及全block模板。

同一上下文CPU核12298条实际数据值连接全部相同：初始化、每轮RHS/预条件器、全部250CG核心与六类extra、
每条r/p/delta/prevNum递推、每轮清零观测、四次joint AL递推及最后velocity/angle。
4个public particle q/qd与末native输出逐字节同；copy链接明确记录地址不同，只有字节值观测，不冒充D2D API序列证明。
每份matrix row_count等于shared68行重复8份，所有实际block ELL与本次初始化模板相同。

## 已确认并修复的检查器竞态

首次完整回放为3718/5216严格。3份SO3 tangent的部分输出变零，原PTX和源码PTX均偶发，不能归因恢复数学。
输入分别是packet876(NL1/CG33)、1826(NL3/CG24)、2306(NL4/CG20)，均worker0。
检查器的pageable cuMemcpyHtoD_v2之后立即在nonblocking stream1 launch，没有等上传DMA完成。
[NVIDIA同步说明](https://docs.nvidia.com/cuda/cuda-driver-api/api-sync-behavior.html)明确H2D函数返回不保证该DMA已完成。

实际相同输入A/B控制：保留35个module、真实参数/geometry/alias，比较仅增加上传后的cuCtxSynchronize。

| 控制 | 无fence严格 / 750 | 有fence严格 / 750 | 边界 |
|---|---:|---:|---|
| upload-sync-control | 737 | 750 | 原per-packet rotation使条件间backend顺序也不同 |
| upload-sync-control-balanced | 744 | 750 | 每对相同repeat%3顺序，移除了rotation混杂 |

两次控制各4500实际调用，GPU/根实际1、独立CPU0。每次750对GPU pointer地址完全相同；
平衡控制每对backend顺序也逐项核同。独立脚本重读原始失败，确认全部输入相同。
136个body的544个proxy目标唯一、初输出全零，不存在可解释成片丢失输出的跨线程原子碰撞。
13与6次无fence错误分开保留，两个fenced750组均全部逐位严格，不能混用两批统计。

三个canonical诊断helper各只补一条上传完成屏障：pd_contact_full_replay、g1_contact_rhs_replay、
particle_reduction_certificates.launch。新本批trace和serial fold也显式fence。
改前文件完整保存在before-upload-fence-*，旧as-run、旧回放及原失败均未改写。
这不修改任何CUDA核、launch/shared/resource参数或生产求解数学。

生产Driver.upload虽也使用pageable H2D，但solver precompute尾1117、材料/粒子路径267及BVH342已有synchronize；
没有据诊断问题猜改生产库。库SHA和build provenance保持。
旧诊断渲染器的TEMPLATE_SHA可能固定旧canonical版本：不要绕过SHA断言或再用无fence检查器判数学错误；
应保留原as-run，生成版本化、加fence并锁定新SHA的副本。正常demo/C8失败没有因此改判。

## 修正同步后的完整回放与原子证据

capture-synchronized使用完全相同的5216原输入，只在每次reset后等上传完成，15648实际调用、3756严格。
500份SO3 tangent全部严格，所有非归约核心向量、状态/位置/速度更新及初始化严格；剩余1460份为散射/标量归约。
GPU/根实际1、独立CPU0；808216真实参数字节、119291520输出字节、3376632336保护字节、10个inverse别名全核。
不能把3756与旧3718直接作生产改进分数：原子散射本身也会换顺序，原失败均保留。

全部1460份非严格输入执行2920次fenced真实原/源PTX追踪，2071168项target/F32贡献及线程内序全同。
独立CPU重读实际trace、ABI/view offset、guard/readonly；instrumented完整P.z/M.Ap也等于原捕获。
剩余6054个回放差异word的12885个不同真实目标，均由相同实测操作数的合法排列经GPU逐位复现。
独立CPU从全部5216输入/三端结果重建差异覆盖全集，核708910返回历史word及全部实际参数/保护区。
每scalar可达排列不证明生产联合全局线程顺序，更不把本次public跨端差异或旧长程失败改判通过。

## 同一仓库的证据清单

根snapshot原352131项已近100MiB。新evidence_file_manifests只为新增大批实际文件提供同仓库已冻结manifest索引，
不删除原条目、SDK、360pyc或旧gzip。descriptor冻结manifest的bytes/SHA/file_count，manifest本身还必须在primary文件表。
全量verifier继续核每份实际文件、LFS指针/ELF/PE、源码构建来源及旧gzip；重复覆盖和越界路径拒绝。
--reference-only仍只核SDK，不依赖全部诊断证据可用。
10组实际CLI正/负控制覆盖旧flat兼容、indexed有效、member缺失/损坏、manifest hash/count错误、未primary冻结、
重复路径、越界及reference-only独立性，均过。只在临时目录使用fixture，未加载fixture ELF/pyc或替换真实snapshot。

## 真实命令、错误与接续

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-full-native-step"
# 已执行，输出拒绝覆盖。重跑须新建目录，旧unsafe结果只作历史，不用其判数学错误。
.venv/bin/python -B "$phase/discover-csr.py"
.venv/bin/python -B "$phase/capture.py"
.venv/bin/python -B "$phase/prepare-replays.py"
.venv/bin/python -B "$phase/audit-full-context.py"
.venv/bin/python -B "$phase/audit-upload-controls.py"
.venv/bin/python -B "$phase/capture-synchronized/run-replays.py"  # 实际1，CPU子0
.venv/bin/python -B "$phase/trace-operands-synchronized.py"
.venv/bin/python -B "$phase/audit-operands-synchronized.py"
.venv/bin/python -B "$phase/prepare-folds-synchronized.py"
.venv/bin/python -B "$phase/run-folds-synchronized.py"
.venv/bin/python -B "$phase/audit-folds-synchronized.py"
.venv/bin/python -B "$phase/audit-initial-caches.py"
python3 -B scripts/verify_reconstruction_snapshot.py
```

装包脚本生成3次158列失败、fold生成一次132列失败及一次误启动未生成脚本，均未调用GPU，实际工具记录保留。
分行/缩短文案后才执行。prepare-folds-synchronized.log是误启动日志，v2.log是真实成功准备，未改数学或目标。
actual-tool-receipts保存观察到的真实终态。自己的GPU worker均已结束，未停止用户外部GPU任务。
Windows继续WSL2，先核根snapshot并恢复旧无损gzip；source/SDK/pyc及全部原始证据均在同一分支。

下一步回到未通过的正常demo及固定C8/C10，优先核当前Newton mixed、G1/复杂布料及4f/7ca候选；
所有隔离回放必须先保证上传完成，复核旧记录中的异常零区域，不能把checker竞态当作需要修改生产数学的证据。
本批ANYmal同一完整步的局部计算已核准，不需重复本队列；其他host组合、完整轨迹和默认替换仍未完成。
