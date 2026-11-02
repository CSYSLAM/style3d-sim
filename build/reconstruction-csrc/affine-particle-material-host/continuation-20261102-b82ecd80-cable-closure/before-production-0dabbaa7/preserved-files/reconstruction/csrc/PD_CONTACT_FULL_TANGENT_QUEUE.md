# 完整PD接触/tangent：实采与同输入核对记录

## 本批实际终态

准备检查点为49960939，本轮起始tracked clean；此前turn为progress。
外部GPU任务自行结束后，原采集session12388及流水线session81124自动接续，均已真实结束0。
唯一原版SDK64a、生产host0dab/Core715、隔离候选4f及360份冻结pyc未改，无需账号。
本批只新增诊断、原始数据及审计，没有调整求解数学、接触次序、资源属性或阈值，没有合入候选。

- 四worker均0：1SDK和3独立source，各60目标帧、每帧选定213阶段；三source均未映射原版SDK。
  八份实际图保留原276节点/275边；已审计类型化参数和跨图129指针身份模式同。
- 51120阶段、240末轮位置/公开位置对应检查通过；3600条extra链、21600相邻累加衔接、3600最终extra、
  25200方向、72000私有cache、314400接触输入稳定及1440公开接触计数检查均通过。
- 预定四帧0/31/32/59，新增/补全的132阶段每帧，共2112完整输入、6336次SDK runtime/原版PTX/source PTX全严格。
  完整输出、225699264字节原始group及221614272保护字节独立CPU复核0。
- 同四帧补余81阶段每帧，共1296输入、3888调用：1165输入全严格，131仅标量归约不同。
  包括93份CG-product分母和38份CG-precondition分子；全部逐粒子向量严格，全部只读/guard同。
  各端失败调用为SDK125、原版PTX128、源码PTX129，均原样保留，不能写成全严格。
- 这131输入实际记录每lane一个操作数，原版/源码各4716原始F32字完全同；
  393次SDK/原版PTX/source受控映射调用的14148个有效贡献字同，实际map读回14148字也完整保存并独立复核。
  262个完整三组标量目标均由真实单lane GPU原子程序联合复现，含9432步history；本子批共1048实际调用，CPU独立0。
  只证明这些目标可由相同操作数的合法F32顺序产生，不推断旧运行的实际全局调度。
- 本轮三个轨迹首差均在frame0、CG-product第三组1 ULP，rank79/43/91；
  七份完整before及完整Ap都同。已逐一连接到相同完整输入的GPU联合证书，两端完整三标量目标都有证据。
  独立bridge检查0；这三处是新诊断路径，不是旧source0/frame32的私有状态。
- 静态CPU读指针补核：46原版/源码入口、1704实际阶段ABI，读取基址均对应已捕获或NULL字段。
  NULL分支控制和索引界限没有据此证明；实际GPU回放及guard结果单独记录。

本批选定213阶段在固定四帧的3408输入中，3277严格、131有上述归约证书，共10224次未修改入口调用。
这只覆盖所选阶段/实际输入，不代表图内其它阶段、所有host组合或整段仿真已验收。
本批新原版及三源码轨迹对既有C8全部false；固定旧source0/frame32、SDK八份cohort、所有旧失败均保持。

`remaining-prepare.log`中`Prepared2112`为继承文案；实际plan/执行/独立审计都是1296输入及3888调用。
生成脚本、实际as-run及diff均保留，没有覆盖该日志。`execution-receipts.json`记录实际工具终态。
完成封存以`completion-manifest.json`为准；原`preparation-manifest.json`保留准备时的open状态作为历史。

## 接续与命令

先依根Windows交接进入WSL2及固定依赖，在固定工程路径校验快照；不要把Linux so放到原生Windows Python里运行。
本phase已结束，所有旧输出目录均不能直接重跑覆盖。可先只读查看已保存报告：

```bash
source scripts/reconstruction_env.sh
phase_root=build/reconstruction-csrc/affine-particle-material-host
tangent_phase=$phase_root/continuation-20261101-4f638b4b-pd-tangent-full
.venv/bin/python scripts/verify_reconstruction_snapshot.py
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["actual_calls"],d["strict_packets"])' \
  "$tangent_phase/full-input-replays/report.json"
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["actual_calls"],d["strict_packets"])' \
  "$tangent_phase/remaining-input-replays/report.json"
.venv/bin/python -c 'import json,sys;print(json.load(open(sys.argv[1]))["metrics"])' \
  "$tangent_phase/reduction-independent-cpu-audit.json"
```

实际GPU/CPU命令及退出码见execution-receipts；原6336调用由run-pipeline执行，补余及证书为：

```text
run-remaining-replays.py --phase <本phase> --prepare       0，session49615
run-remaining-replays.py --phase <本phase> --execute       1，session52924，131原始严格失败保留
audit-remaining-replays.py                               0，session80352
python -m reconstruction.csrc.pd_contact_reduction_replay --phase <本phase> --prepare   0
python -m reconstruction.csrc.pd_contact_reduction_replay --phase <本phase> --execute   0，session4793
audit-reduction-differences.py                           0，session91470
audit-first-difference-bridge.py                         0
```

补余脚本和131份证书脚本绑定本批冻结数据；不能把131/1165硬编码断言当新机器新采集的预期结果。
要复采先建新兄弟phase，依下方原采集命令保留新失败和原始数据，再根据实际report准备定位。
下一步优先核当前生产镜像的G1/复杂布料长程及尚未覆盖host组合；
若回到旧PD失败，须明确能否取得旧路径私有状态，不能把新局部证书拼成旧轨迹通过或继续重复相同输入补采。

## 以下为准备检查点49960939的历史记录

主host仍为0dab/Core715，接触候选仍为4f，原版仍为项目内SDK64a；旧固定失败、阈值及readyFalse均保持。
准备时尚无GPU结果；以下进程/排队描述仅为当时记录，本批当前终态见上方。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-4f638b4b-pd-tangent-full/`。

## 已实际完成

- `pd_contact_tangent_schema.py`根据实际ABI补全刚体、软、滚动接触force/matrix/tangent及预条件器的全部非空指针跨度。
  保留原90阶段，扩至每帧213阶段，包含15轮CG的全部7段extra形成。
  使用本场景3刚体、36粒子、6形状、rigid容量1000、soft容量72；CG每组12，不使用G1的44/176/105长度。
- 八份实际模板的CPU签名/大小及符号DAG检查通过。每graph增加4047216字节staging和2823只读复制，
  新3099节点/3524边，保留原276节点/275边，沿用已验证的相邻快照串联方法。
  容量数据完整保存；仅在跨运行语义比较时排除未使用槽位，不改变实际接触顺序。
- `static-proof.json`：23种kernel、46份原版/source PTX的写指针均位于实际nullable模式输出的合并集合。
- `atomic-access-proof.json`：其中20份新原子入口仅用F32 red写输出，未从输出指针加载数值，无跨线程barrier。
  这是静态CPU证据，不是索引范围证明或GPU结果。

## 正在运行的队列

本机采集driver为PID3118261，工具session12388；`capture-driver-receipt.json`保存观察时的host、boot_id及start_ticks。
创建本交接时，外部GPU进程3104143仍真实运行，采集driver在等待空闲，没有中断该外部任务。
这些PID只是原机器的记录；新Windows/WSL不能据相同PID数字判断任务仍在运行。

已另启动`run-pipeline.py`，工具session81124，自动接续现有采集，绝不重启或替换它：

1. 原完整案例/模式顺序下预定1SDK及3独立source，各保存目标60帧。
2. CPU核实际graph、51120份阶段、公开末轮q和extra/方向/私有缓存的逐段衔接。
3. 依采集前计划固定frames0/31/32/59，对新增或补全的每帧132个阶段实例准备2112份完整输入。
4. 再次等待GPU空闲，串行执行6336次SDK runtime/原版PTX/source PTX调用，并独立读回审计。

完整输入回放若不严格，会保留每项原始差异并标记需要原子证书或数学定位；流水线结束不代表solver整体通过。
后续必须读实际退出码、`full-input-replays/report.json`和CPU报告，不以进程启动、有限值或计划文件判通过。

```bash
source scripts/reconstruction_env.sh
phase_root=build/reconstruction-csrc/affine-particle-material-host
tangent_phase=$phase_root/continuation-20261101-4f638b4b-pd-tangent-full
pgrep -af 'pd-tangent-full/(run-tangent|run-pipeline).py'
nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader
.venv/bin/python -c 'import json,sys; d=json.load(open(sys.argv[1])); print(d["complete"],d["running"],d["completed"])' \
  "$tangent_phase/pipeline-status.json"
```

运行状态和日志会继续变化，准备检查点只发布不可变脚本、计划、CPU证明和进程身份记录；
GPU原始数据完成后应另行封存并提交。若运行文件不存在，先核原机器进程，不能据缺少git内状态文件重跑旧输出目录。

## 接续判断

先确认现有driver/worker/流水线的实际进程及终态。只有缺少原进程并核清已完成输出后，才修复或续接未完成部分。
遇到同输入完整输出差异，按原协议核真实操作数、实际SDK隔离调用及GPU F32顺序证书；
不能改排序、资源、数学或容差来凑结果，也不能把新观测路径替换旧source0/frame32失败。
即使本批局部回放通过，G1/复杂布料及未覆盖host组合仍需完成，默认后端保持原版。

在新机器重现需新兄弟phase，复制不可变采集/CPU审计脚本并运行`run-tangent.py`；
它会创建新的`tangent-captures`。之后执行`compare-graphs.py`、`run-audit.py`、`audit-flow.py`，再运行：

```bash
new_tangent_phase=$phase_root/continuation-tangent-repeat-$(date +%Y%m%d-%H%M%S)
mkdir "$new_tangent_phase"
cp "$tangent_phase/CPU-preflight.json" "$new_tangent_phase/CPU-preflight.json"
for script in capture-observer.py tangent-worker.py run-tangent.py compare-graphs.py model-normalizer.py \
  audit-as-run.py run-audit.py audit-flow.py audit-replays.py; do
  cp "$tangent_phase/$script" "$new_tangent_phase/"
done
.venv/bin/python "$new_tangent_phase/run-tangent.py"
.venv/bin/python "$new_tangent_phase/compare-graphs.py"
.venv/bin/python "$new_tangent_phase/run-audit.py"
.venv/bin/python "$new_tangent_phase/audit-flow.py"
.venv/bin/python -m reconstruction.csrc.pd_contact_full_replay --phase "$new_tangent_phase" --prepare
.venv/bin/python -m reconstruction.csrc.pd_contact_full_replay --phase "$new_tangent_phase" --execute
.venv/bin/python "$new_tangent_phase/audit-replays.py"
```

`run-pipeline.py`仅用于接续所记录原机器的现有driver，不能直接作为新机器启动命令。
依根交接使用WSL2及固定Python/CUDA依赖；Windows原生移植未完成。
