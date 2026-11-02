# 当前 f07/Core aa：H1 首轮完整 CG 与装配核实证

目标仍是恢复源码编译的独立 solver 完整替代固定原版 SDK。本阶段核准首轮 CG 的非归约输出，
并核准三个装配入口在全部实际接触/三角形上的原生 SDK 算术；完整替换和 H1 固定轨迹验收尚未完成。
生产 d09/Core55、候选 f07/Core aa、CUDA176、原版 SDK64a、默认入口及360份冻结pyc均未修改。
候选未合入，`solver_api_ready=False`。无需登录；正常源码进程不映射 SDK。

## 固定版本和本阶段范围

实际候选及其构建源码继续使用同仓库的
`../continuation-20261102-ae3a5997-driven-self/candidate-force-order/` 和 `candidate-public-core/`：

| 产物 | SHA256 |
| --- | --- |
| 项目内唯一 SDK `_core` | `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63` |
| 未修改生产 host | `d09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68` |
| 未修改生产公开 Core | `55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5` |
| 当前候选 host | `f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20` |
| 当前候选公开 Core | `aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830` |

示例为未改的 `examples/example_cloth_h1_free.py`，33887粒子、46刚体、46关节、51 DOF，
保留默认2 substeps、10 NL、20 CG、自碰撞、关节drive及原 `test_final`。
本批每端只运行两次 `Example.step`：第一次 capture，第二次一次真实 graph replay。
详细核验覆盖第一物理子步的第一 NL；不冒称全部20个NL、默认601帧或固定 C8 已通过。

Newton资产固定 ref `261cd1f429619d8ef4f546bd788ab9dea906b5e1`，沿用上一阶段已核127文件的缓存；
正常示例不经 A/B bridge。源码 worker 的 SDK 映射检查保持。
后续显式 kernel 隔离诊断有意加载原生 SDK、原PTX及实际候选 host，三者分别实算，不是 SDK 给源码 demo 代算。

## 完成内容

13个 GPU worker 严格串行，全部实际退出0，另两个回放driver内CPU child退出0。
每次保存时间/显存/外部应用，free>=4096MiB即可准入；没有等待或停止外部 worldparticle 程序。

| 实际范围 | 结果与限制 |
| --- | --- |
| 首 NL 完整20CG，166 packet/498三端调用/864输出 | 624非归约输出全部严格；240标量只有2严格，238失败保留 |
| 25个装配阶段 buffer watch | 最早 RHS/diagonal 差异出现在 soft force rank66；不是完整输入算术验收 |
| 三装配入口六份完整输入，18三端调用 | 36完整aggregate输出全部非严格，原版本身同输入重放也不同；失败保留 |
| 原/源PTX真实F32原子探针 | 22006912记录全部核；每线程目标/顺序/操作数同，跨端对应记录也同 |
| soft force：全部8891实际接触 | 26673次原生SDK/原PTX/f07调用，全输出严格；CPU核21088整数F32步骤 |
| soft matrix：SDK矩阵种子，全部8891接触 | 26673次三端调用全输出严格，CPU核59310整数步骤 |
| soft matrix：源码实际矩阵种子，全部8891接触 | 另26673次三端调用全输出严格，CPU核另59310整数步骤 |
| membrane Hessian：全部66930实际三角形 | 200790次三端调用全输出及guard严格；CPU核5421330整数步骤 |

原有正常 H1 固定8 SDK/3source C8仍为 `[true,false,false]`，独立 SDK 控制仍为 `[true,true,false]`。
首次 source0、所有后续失败、两个短W3/PD失败及G1/ANYmal等旧失败均未重判。
本阶段不能证明联合全局原子调度，也没有据局部通过宣布完整轨迹等价。

### 实际输入定位

`h1_first_cg_layout.py`、`h1_pre_cg_watch_layout.py`、`h1_first_assembly_layout.py` 是新增规范布局模块。
按实际6120节点图的真实 ABI 构建，先用 Warp 声明的逻辑范围或 CUDA allocation query 核范围，再执行完整 D2D 快照。
原图6120节点/6119边保持；诊断快照会影响调度，不能替换固定 C8 原件。
首CG每端578快照/929317724 bytes，独立CPU核1156 descriptor/1858635448 bytes。
跨端578 payload只有78同；inverse前 block 缓存已63494 word不同，不能将整段原因统称为首CG标量归约。

25阶段watch在 `assembly-watch/`，完整producer输入在 `assembly-full-inputs/`，两者是不同采样队列。
watch的soft-force后差异为116/23 words，full-inputs队列为104/25，不能混用。
三完整入口每端66快照/383580120 bytes，soft保留3354813完整capacity，实际有效8891。
`producer-endpoint-inputs-independent-cpu.json` 正式核完整输入：两端有效44-byte接触记录multiset同而顺序不同；
其余所有非record只读输入/标量同。没有排序或修改生产输入。
membrane全部非输出输入同；初始对角矩阵差75 words，全部在实际三角形写入位置之外；ELL初始完整字节同。

### 原生 SDK 算术验证方式

每个实际接触/三角形的原始 metadata移到row0，工作count设1，保留其余实际输入、原launch geometry和完整输出初值。
三种 backend按固定rotation实算。每次 reset 上传完成后context fence，再向非阻塞stream launch。
soft kernel保留13105 blocks，membrane保留262 blocks，block均256。

soft三批直接回读全部输出，保存每条接触的完整实际输出SHA及无损seed-relative实际值编码。
CPU以独立的整数RNE/FTZ加法逐步复原历史，再重建所有未变及改变word并核三端SHA。
不是只验非零项，也不是原子操作数同就预先当原生SDK输出同。

membrane每次完整输出约37.8MB。诊断GPU比较器比较所有u32输出word及两侧guard，包含ELL整数列索引；
另保存每个实际写入位置的三端原始实际值，以种子加这些实际值无损确定完整输出。
运行前10组完整CPU readback控制：正例、两buffer首/中/末/边界/有效数据及guard单bit破坏、多点同时破坏。
CPU独立重建控制的完整SHA，核GPU mismatch数及首索引。没有清零ELL或忽略整数列。
总计1898415035910个完整输出/guard word实际GPU比较；三端16263990个实际写入值及5421330整数历史全部CPU核。
诊断CUDA helper只作整数patch/gather/compare，未参与生产算术。

## 证据、命令和接续

`close-independent-cpu.json` 汇总已终态worker、所有依赖SHA、未修改版本、280809次严格原生隔离调用及5561038整数步骤。
`completion-manifest.json` 冻结本目录全部脚本、原始状态/失败/输出；根snapshot索引会逐份核，文件均在同一仓库。
实际worker命令见各 `*.command.json`，实际child退出见对应 `*.status.json`。
已完成目录禁止覆盖或盲目重启。CPU闭合初次错用metadata键 `extension` 退出1，旧配方和receipt保留；
按真实Core目录/SHA修正，未重跑GPU。较早block-init参数2误读的CPU guard失败也原样保留。

本机历史执行入口如下，均从仓库根执行，输出已存在，不应重跑覆盖：

```bash
export PYTHONDONTWRITEBYTECODE=1
h1_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-f07b35a4-h1-first-cg
.venv/bin/python -B "$h1_phase/run.py"
.venv/bin/python -B "$h1_phase/run-replay.py"
.venv/bin/python -B "$h1_phase/assembly-watch/run.py"
.venv/bin/python -B "$h1_phase/assembly-full-inputs/run.py"
.venv/bin/python -B "$h1_phase/assembly-full-inputs/run-replay.py"
.venv/bin/python -B "$h1_phase/run-producer-operands.py"
.venv/bin/python -B "$h1_phase/run-soft-force-isolation.py"
.venv/bin/python -B "$h1_phase/run-soft-matrix-isolation.py"
.venv/bin/python -B "$h1_phase/run-soft-matrix-source-isolation.py"
.venv/bin/python -B "$h1_phase/prepare-membrane-isolation.py"
.venv/bin/python -B "$h1_phase/run-membrane-native-isolation.py"
```

独立CPU入口：`audit-captures.py`、`audit-assembly-watch.py`、`assembly-full-inputs/audit-captures.py`、
`audit-producer-operands.py`、`audit-producer-endpoint-inputs.py`、`audit-native-contact-isolation.py --folder ...`、
`audit-membrane-native-isolation.py`、`close-independent-cpu.py`。报告目标同样拒绝覆盖。

下一步按当前 f07/Core aa、同一次完整输入继续：

1. 对本批保留的aggregate及首CG标量差异，继续真实原子F32硬件顺序证书；每word可复现不等于联合全局调度证明。
2. 补首NL其余真实装配生产者，尤其rank75/76/77自碰撞Hessian/RHS、79/80 stretch/bend及rigid/drive组合。
   watch已有定位，但不能冒充完整输入和算术验证；H1尺寸必须按真实ABI，不能套G1 n176。
3. 沿同一上下文补后续NL/CG extra/子步，定位固定H1及其余正常demo失败；不跨队列拼装成完整步证明。
4. 只有完成正常demo/固定队列验收后才合入候选、重建匹配公开Core、全回归并切换默认。

## Windows / WSL2

现有so是Linux/Python3.12 ELF，新电脑用WSL2。没有真实新Windows/WSL机器验收或原生Windows移植声明。
先遵循根 `RECONSTRUCTION_HANDOFF.md`，运行 `python3 scripts/verify_reconstruction_snapshot.py`。
源码Core正常入口使用相对metadata；报告选新文件名，保留Newton同revision资产。

```bash
source scripts/reconstruction_env.sh
export PYTHONDONTWRITEBYTECODE=1
h1_candidate=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-ae3a5997-driven-self
.venv/bin/python -B -m reconstruction.core_demo \
  --core-build "$h1_candidate/candidate-public-core/build.json" \
  --report build/h1-f07-local-new-01.json \
  examples/example_cloth_h1_free.py -- --viewer null --num-frames 4 --test
```

此命令仅正常API运行；四帧CLI0不等于固定C8或全时长数值通过。
本批诊断plan/packet路径及资产缓存manifest含本机绝对路径，新机器应在新目录按同版本资产/镜像生成新计划，
先核字节及新路径再运行；不要删除SHA断言或改写本批证据。项目内处理版SDK和pyc仍在同仓库固定版本。
