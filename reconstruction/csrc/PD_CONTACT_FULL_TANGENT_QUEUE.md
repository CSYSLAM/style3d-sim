# 完整PD接触/tangent：准备完成，GPU验证排队

主host仍为0dab/Core715，接触候选仍为4f，原版仍为项目内SDK64a；旧固定失败、阈值及readyFalse均保持。
本阶段尚未验收，不能把下述准备工作写成GPU一致性已通过。

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
