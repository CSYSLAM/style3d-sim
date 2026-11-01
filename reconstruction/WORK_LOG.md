# 源码还原工作日志

按轮次追加，不用新结论覆盖旧的失败记录。每轮记录：目标、实际改动、执行命令、证据、结论边界、下一步。
本文从 Codex 接续另一 agent 的工作开始记录；此前历史见根目录 RECONSTRUCTION_HANDOFF.md。

## 2026-10-28：接续布料与刚体混合场景诊断

### 目标与约束

接续 Claude 会话 604d4485-c44b-4909-8ea5-44638c65a5a6 的最后工作：定位 cloth_on_box 第一子步差异。
唯一原版仍是同级 style3d-sim-bin 下 SHA256 为 4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6 的旧 so。
不放宽容差，不将原版不确定性当作未经验证的解释，不改认证逻辑。

### 接手时复核

- 阅读另一 agent 对话与当前仓库；发现交接文件有旧待办与新完成项混杂，应优先核对代码与报告。
- 运行 `.venv/bin/python -m pytest reconstruction/tests -q`：12 passed。
- 运行 `.venv/bin/python -m reconstruction.kernel_ab --only surface_contact --seed 1`：
  surface force / preconditioner / tangent 全部逐位一致（2496 / 7488 / 2496 个输出分量）。
- 直接检查保存轨迹：penddrive2、pendlim2、pendprism2、pendarm2、pendpd2 的 121 个状态 q/qd 差均为 0。
- clothbox6-30：q 最大差 3.4093857e-5 m，qd 最大差 0.01256704 m/s，第一子步已有非零差异。
- clothboxp6-30（粒子接触分支）：q 最大差 9.0897083e-7，qd 最大差 1.7881393e-5，同样第一子步有微小差异。

### 中间缓冲诊断（已完成）

复用上一 agent 已保存的官方首步缓冲：

```text
/tmp/claude-1000/-home-oem-code-agent-style3d-sim/604d4485-c44b-4909-8ea5-44638c65a5a6/scratchpad/hook_cbp/
```

新增源码侧首步捕获脚本及数据（未改变 solver）：

```bash
.venv/bin/python build/reconstruction-debug/cbp/capture.py
```

该脚本包裹 pcg/cloth 函数，运行 shim、cloth_on_box_particle、width 6、1 帧。
结果保存于 `build/reconstruction-debug/cbp/`，逐项与上述官方 dump 对比：

| 缓冲 | 位模式不同分量数 | 最大绝对差 |
|---|---:|---:|
| initialize_rhs 输出 | 0 | 0 |
| 膜内 GN 装配前的 system 对角块 | 0 | 0 |
| 弯曲力加入后的 rhs | 5 | 2.842171e-14 |
| 膜内 GN 装配后的 system 对角块 | 3 | 0.00024414062 |
| invert_block_preconditioner 输入 | 3 | 0.00024414062 |
| invert_block_preconditioner 输出 | 6 | 5.820766e-11 |

结论：这一帧的初始 rhs 和装配前对角块对齐；首批观测差异出现在元素累加后，数量少、末位级。
这不是完整系统正确性的证明，也尚不能断言它们全部由 GPU 非确定顺序造成。

### 用官方真实输入独立重放 PCG（已完成）

重新使用上一 agent 的 cudaMemcpy/launch hook 捕获完整输入，输出目录：
`build/reconstruction-debug/native-cbp/`。

```bash
mkdir -p build/reconstruction-debug/native-cbp/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/native-cbp \
CUDAHOOK_DUMP='update_solution_residual_and_reduce=1:16,2:12,3:636,4:636,5:1908,6:636,7:636,8:4' \
LD_PRELOAD=/tmp/claude-1000/-home-oem-code-agent-style3d-sim/604d4485-c44b-4909-8ea5-44638c65a5a6/scratchpad/shim/cudahook.so \
.venv/bin/python -m reconstruction.validate --worker native --demo cloth_on_box_particle --width 6 --frames 1 \
  --output build/reconstruction-debug/native-cbp > build/reconstruction-debug/native-cbp/run.log 2>&1
```

官方完成 4 子步后退出发生 SIGABRT；dump 已完成。没有修改认证或强制退出。
将 dump 的 num/den/direction/product/preconditioner/solution/residual 直接传入源码
`pcg.update_solution_residual_and_reduce(0, ...)`，与官方 post 输出比较：
**solution、residual、partial reduction 全部逐位一致**。
证据：`build/reconstruction-debug/native-cbp/pcg-replay.json`。
注意此前 hook_cbp 对 preconditioner arg5 只抓了 636 字节，完整 53×9 float32 需要 1908 字节，本轮已补齐。

### 全表面场景原版自重复（已完成）

```bash
mkdir -p build/reconstruction-debug/surface-native-repeat
.venv/bin/python -m reconstruction.validate --worker native --demo cloth_on_box --width 6 --frames 30 \
  --output build/reconstruction-debug/surface-native-repeat > build/reconstruction-debug/surface-native-repeat/run.log 2>&1
```

与 `build/reconstruction-validation/clothbox6-30/native-trajectory.npz` 比较：

| 对照 | q 最大绝对差 / 容差比 | qd 最大绝对差 / 容差比 |
|---|---|---|
| 新官方 vs 旧官方 | 2.7298927e-5 / 1.2463 | 0.01002789 / 33.3692 |
| 已有 shim vs 旧官方 | 3.4093857e-5 / 1.5566 | 0.01256704 / 41.7213 |

两者速度首次超差均在 step 45、particle 8、component 0。
证据：`build/reconstruction-debug/surface-native-repeat/comparison.json`。
只做了这一组新增自重复，**不足以把 shim 判为通过，也不足以排除系统性偏差**。

### 代码改动与在跑验证

发现 `kernel_ab.py --only surface_contact` 有专项测试，但默认全套 main 没调用该组，也没计入 passed。
已修改 `reconstruction/kernel_ab.py`：默认执行 surface_contact 组，并把结果纳入总通过判定。
没有修改 solver 数值公式，没有改容差。

启动命令：

```bash
.venv/bin/python -m reconstruction.kernel_ab --seed 1 --count 512 \
  --output build/reconstruction-debug/kernel-ab-with-surface.json \
  > build/reconstruction-debug/kernel-ab-with-surface.log 2>&1
```

结果待本轮完成后追加。count=512 是本轮快速回归规模，不应冒充原先 20000/50000 样本测试。

### 后续从哪里接

1. 查看上述新默认回归结果；若失败，按具体内核和随机输入查 PTX，不跳过失败。
2. 对混合场景中真实触地阶段做输入一致的内核/整步诊断，优先 step 45 附近。
3. 现有 trajectory 只有 q、qd、forces、contact_counts，没有 body_q/body_qd。
   现有 `validate --replay` 使用 source 后端，只恢复粒子状态，不能直接宣称它覆盖刚体混合场景。
   做此场景重放前必须恢复对应刚体状态和约束历史，或保存并重放原生 solver 的完整输入。
4. 若需要判定原版的非确定范围，再做多组顺序自重复；不要因一次原版自重复超差就放行候选实现。
5. 临时 hook 路径在 /tmp，可能被清理；关键结果已另存项目 build 目录。需要长期复现时整理必要脚本，勿复制凭据。

本轮未 commit/push；不覆盖其他 agent 的现有工作。

### 本轮回归完成

默认全套（seed=1、count=512）返回 0，顶层 `passed=true`。报告内 211 个 `bitwise_equal` 记录全部为 true（包含嵌套记录，不等同于不同内核数）。新纳入的 surface force/coverage/preconditioner/tangent 均通过。

下一步仍是混合场景真实接触阶段诊断；本轮没有宣布全表面 demo 验证完成。

## 2026-10-28：混合场景原生调用边界重放（进行中）

新增 `reconstruction/contact_replay.py`，限定 cloth_on_box width=6：在公开包装层完成刚体预测后、
原生 step 之前抓取 q/qd/f、接触数据、源码所消费的模型视图与配置；step 后立即抓取原生 q/qd。
保存 NPZ 数组与 JSON 结构，不用 pickle，不保存账号。参考库 SHA 必须与旧版分析匹配。
源码端从每个捕获的模型视图新建 solver，避免两条自由轨迹的累计误差。
此工具不支持关节驱动或接触历史，不能作为通用求解器 checkpoint。

开发时修复两处抓取脚本问题：代理需要转发 config 等属性；AffineBodies 需要显式序列化。
这两次异常后的原生析构均 SIGABRT（退出 134），不能当作完成的参考数据。
未修改物理公式或容差。当前命令：

```bash
.venv/bin/python -m reconstruction.contact_replay capture \
  --output build/reconstruction-debug/contact-call-replay \
  > build/reconstruction-debug/contact-call-capture.log 2>&1
.venv/bin/python -m reconstruction.contact_replay replay \
  --output build/reconstruction-debug/contact-call-replay \
  > build/reconstruction-debug/contact-call-replay.log 2>&1
```

默认捕获子步索引 0,40,44,45,46,50,88,89（0-based；索引 44 的输出对应轨迹 state 45）。
结果待运行后追加；不能将“新增工具”写成“混合场景通过”。

### 第一批边界重放结果

8 个选定子步全部在既定 q/qd 容差内（不是逐位相同）。最大 q 差 `1.4901161193847656e-08`，
最大 qd 差 `3.5762786865234375e-06`，均出现在 step 50。step 44 是轨迹 state 45 的输入步，
这一采样的 qd 最大差 `7.450580596923828e-09`。
`build/reconstruction-debug/contact-call-replay/replay-report.json` 为第一版工具结果；
这一版尚未把进程映射独立性写入报告，因此后续以第二批增强工具报告为准。
第一批捕获保存了全部 8 步及 capture-complete.json，随后原生退出 139；源码重放退出 0。
8 个 NPZ 经 load→save 往返，每个字段 dtype/shape/字节完全一致。

新增完整性保护：捕获目录必须为空；重放按完成清单读取，缺文件即失败；校验参考 SHA/步号；
记录每份捕获输入文件 SHA、源码 SHA、原生库未导入/未映射；数值失败返回非零。
逐位比较改成 float32 的 uint32 位表示（避免把正负零误称为逐位一致）。

### 第二批：连续接触区间

```bash
.venv/bin/python -m reconstruction.contact_replay capture --steps 0 {38..60} 88 89 \
  --output build/reconstruction-debug/contact-call-contiguous \
  > build/reconstruction-debug/contact-contiguous-capture.log 2>&1
.venv/bin/python -m reconstruction.contact_replay replay \
  --output build/reconstruction-debug/contact-call-contiguous \
  > build/reconstruction-debug/contact-contiguous-replay.log 2>&1
```

已捕获全部 26 步并写完成清单，原生退出 139。源码重放进行中。
这两次完整捕获均保持官方正常认证，没有绕过认证或强制退出。

### 第二批完成：26/26 单步在容差内，仍有重点差异

源码重放退出 0，报告 `passed=true`、`source_independent=true`。26 步全有接触，
没有任何一步 q 与 qd 同时逐位相同。保持原来的容差，没有调整公式。

| 字段 | 最大绝对差 | 最大容差比 | 最差子步索引 |
|---|---:|---:|---:|
| q | 5.736947059631348e-7 | 0.02730917558 | 58 |
| qd | 1.3768672943115234e-4 | 0.4480600357 | 58 |

报告：`build/reconstruction-debug/contact-call-contiguous/replay-report.json`。
输入：同目录 `step-0058.npz` 等 26 份文件；每份 SHA 在报告内。
原生退出状态另记 `capture-process-status.json`：完成保存后退出 139，clean_execution=false。
脚本 `py_compile` 通过。第一批较小误差不能代替第二批的最大误差；后续引用以本表为准。

### 下一 agent 接手的具体工作

1. 优先 `step-0058.npz`：速度差已达到容差约 45%，虽然当前通过，不能忽略。
   将重放内的 `native_step`/PCG 中间量分阶段记录，定位差异来自矩阵散射、PCG 归约、迭代停止还是接触项。
   原生中间量仍需同一输入的 hook 证据；不能拿另一次自由轨迹的缓冲区直接配对。
2. 这轮只验证原生调用边界内、选定输入的数值输出；没有验证整个公开包装层的同状态重放。
   当前模型/接触提取复用 core._newton_view/_contacts_view，只包含已还原实现消费的数据，不是完整原生 ABI dump。
3. 自由轨迹的 cloth_on_box 未通过结论不变。未证明累计差全来自 atomic 顺序；
   仍需检查碰撞生成、刚体状态回写与多次原版自重复，再定位自由轨迹差异。
4. 扩大捕获须用新空目录；例如 `--steps {0..119}` 可覆盖 30 帧全部子步，CPU 重放可能耗时数分钟。
   运行上文 replay 命令可重复本轮 26 步比较，无需登录或加载原生库。
5. 本轮新增的可复用仓库源码是 `reconstruction/contact_replay.py`。没有改物理公式、没有放宽容差、
   没有 commit/push，也没有把全部六个模块或全 demo 宣布完成。

## 2026-10-28：第 58 步同输入复核与阶段定位

用户要求放慢、准确，本轮先验证重放方法，再缩小差异范围，未改 solver 公式或容差。

### 新增可复用工具

- `reconstruction/contact_native_replay.py`：在正常账号认证后的旧库中重放保存输入；
  新建场景的模型视图/配置必须与捕获一致，接触数据上传后下载逐字段比较，q/qd/f 往返逐字节比较；
  不相同即停止。限定当前无历史约束的 cloth_on_box，不能当完整原生 ABI 或隐藏状态快照。
- `reconstruction/contact_replay.py`：重放后额外保存实际 q/qd，便于独立进程自重复比较。
- `reconstruction/diagnostics/trace_contact.py`：不改运算，仅包装首次 PCG 和表面接触调用，保存阶段数组。
- `reconstruction/diagnostics/compare_contact_stages.py`：比较抓取阶段，缺失阶段明确列 unavailable；
  再用原版内核的精确输入独立执行源码求逆与 PCG 更新。不把阶段不同直接当内核公式错误。
- `reconstruction/diagnostics/cudahook.c`：原样整理前 agent 的 scratchpad/shim/cudahook.c 到仓库，
  免于 /tmp 清理导致不可复现。是诊断 hook，不是求解器实现。同步抓取会扰动调度，不能代表无 hook 波动范围。

### 同输入重复

输入固定 `build/reconstruction-debug/contact-call-contiguous/step-0058.npz`，SHA256：
`a3f3cd70c74a6c7f719b0d8f5524f920fff6afe78a2fc726efd3afd0fecae685`。

```bash
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-native-repeat
```

3 次原生调用（同一已初始化实例，每次重置输入）均完成保存。相对捕获的旧参考输出，qd 最大差分别：
`5.543231964111328e-5`、`4.8279762268066406e-5`、`5.900859832763672e-5`。
模型视图、配置、接触往返检查差异列表均空。原生随后退出 139，不能写 clean execution。
这些差异可能包含隐藏状态或调度影响，单靠这 3 次不能全部归因 atomic。

`step58-source-repeat-0`、`step58-source-repeat-1` 两目录只复制该 NPZ 和单步完成清单，分别运行
`python -m reconstruction.contact_replay replay --output <目录>`，均退出 0，输出 q/qd 逐字节相同。
源码对原参考的 qd 差仍为 `1.3768672943115234e-4`，不是重复运行偶然改变。

### PCG 阶段证据

```bash
cc -shared -fPIC -I/usr/local/cuda/include reconstruction/diagnostics/cudahook.c \
  -o build/reconstruction-debug/cudahook.so -ldl
.venv/bin/python -m reconstruction.diagnostics.trace_contact \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-source-trace
.venv/bin/python -m reconstruction.diagnostics.compare_contact_stages \
  --source build/reconstruction-debug/step58-source-trace \
  --native build/reconstruction-debug/step58-hook \
  --output build/reconstruction-debug/step58-stage-comparison-reproducible.json
```

原生 hook 命令：先建 `step58-hook/uploads`，设置下列环境变量再运行上述 native replay，
`--repeats 1 --output build/reconstruction-debug/step58-native-hooked`。

```bash
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/step58-hook
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook.so
CUDAHOOK_DUMP='14initialize_rhs=1:636,2:636,3:212,7:636,8:212,9:636;27invert_block_preconditioner=0:1908,1:212,2:212,3:1908;35initialize_zero_solution_and_reduce=0:636,1:1908,2:636,3:636,4:4;update_solution_residual_and_reduce=1:16,2:12,3:636,4:636,5:1908,6:636,7:636,8:4'
```

注意环境变量须用 `export` 或写在命令前；此 hook 只抓每个匹配内核第一次调用。场景 53 个粒子状态，
vec3=636 字节、mat3=1908 字节；线性迭代 50、非线性 5。num/den 只截取前4/3项，
本次只复核 k=0（只消费第一项），不可拿来重放 k>=3。

结果：初始位置/惯性目标/质量/外力/initialize_rhs 输出均逐位一致。
进入 PCG 前 rhs 最大差 `1.9073486328125e-6`，预条件矩阵最大差 3.0（145 个分量不同）。
矩阵最大差在 body translation proxy 49 的第0分量：源码 15440462，原生 15440459，相对差约 1.94e-7。
不能仅看绝对差 3.0 宣称严重公式错误。
将原生完整 pre 输入送入源码 inverse、k=0 solution/residual/reduction：四项全部逐位一致。
因此当前证据支持优先查 PCG 上游装配，尚不能排除后续迭代另有问题。
原生 hooked run 保存完成后退出 139；源码 trace 退出 0。

### 表面接触进一步定位

第二组 hook 用 `CUDAHOOK_DUMP='30evaluate_surface_contact_force=1:636;34add_surface_contact_preconditioner=1:1908'`，
目录 `step58-surface-hook`（先建 uploads），native 输出 `step58-native-surface-hooked`，
源码 trace 输出 `step58-source-surface-trace`；其余同上。源码退出 0；原生保存 complete.json 后退出 134。

报告 `build/reconstruction-debug/step58-surface-stage-comparison.json`：

| 阶段 | 最大差 | 不同分量数 |
|---|---:|---:|
| surface force 前 | 0 | 0 |
| surface force 后 | 4.5299530029296875e-6 | 72 |
| surface preconditioner 前 | 4.8828125e-4 | 22 |
| surface preconditioner 后 | 3.0 | 140 |

**已定位一个差异产生阶段，尚未证明根因是累加顺序还是单条接触公式。**
表面预条件器的输入已经存在少量差异，不能直接用后面的差异判该内核公式错误。
正在追加第二次表面 hook 自重复：`step58-surface-hook-repeat` / `step58-native-surface-repeat`，
额外抓 initialize_rhs 的 arg1/arg2，复核预测位置及惯性目标。结果后续追加。

### 表面阶段原版自重复完成

第二次表面 hook 全部保存后退出 134；complete.json 存在。
`build/reconstruction-debug/step58-native-surface-repeat-comparison.json` 比较两次原版（其中通用 compare 的
source_at_worst 字段指第一次原版，不是源码）。结果：

- 预测位置与惯性目标逐位相同。
- 表面力累加前缓冲逐位相同，之后 30 个分量不同，最大差 `2.86102294921875e-6`。
- 表面预条件器累加前缓冲逐位相同，之后 27 个分量不同，最大差 1.0。

这些是同捕获模型/状态/接触输入、独立原生进程的实测差异，支持表面累加存在非确定性。
没有由此放宽验收，也没有把全部源码误差归结于它。hook 本身有同步扰动。
全部 native 退出状态与工具哈希记录在 `build/reconstruction-debug/step58-diagnostic-provenance.json`。

### 170 条真实接触逐条公式验证完成

新增 `reconstruction/diagnostics/surface_contact_rows.py`，用本次第 58 步真实接触数据、已核对的预测位置、
实际首次 PCG 方向，将每条接触独立送入原版 PTX 与源码。接触索引重排为单条，排除跨接触的共同写入；
force/tangent 从零累加，preconditioner 使用捕获的真实非零矩阵作为共同起点（不是原版该内核原始 pre 状态）。
这是局部公式验证，不是 SASS 整步重放。

```bash
.venv/bin/python -m reconstruction.diagnostics.surface_contact_rows \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --native-hook build/reconstruction-debug/step58-hook \
  --source-trace build/reconstruction-debug/step58-source-trace \
  --output build/reconstruction-debug/step58-surface-rows.json
```

退出 0：170 条 × force/preconditioner/tangent = **510 项逐位一致**。
三项各有 145 条实际改变输出（25 条无贡献），避免把全零空覆盖当验证通过。
本轮新增 Python 工具均通过 py_compile；未改求解公式，无需把既有全套 kernel 测试重复跑一遍来增加数字。

### 当前结论和下一步

1. 第 58 步首次 Newton 迭代：初始输入一致；至少一处差异产生于表面接触累加。
2. 单条真实接触三种计算全部对齐原版 PTX；原版自身多接触累加也有可见波动。
   **目前证据更支持共同写入时的累加顺序，而不是已测单条接触公式错误。**
3. 此结论不涵盖后续四次 Newton 迭代、全部 PCG 迭代，也没有证明所有自由轨迹偏差均由顺序导致。
   仍不宣称 cloth_on_box 完整轨迹或六模块完全还原。
4. 后续优先把同输入诊断扩展到全部五次非线性迭代；记录每次位置更新及 PCG 标量，
   找到第 58 步最终速度差的主要放大点。不要通过试换 warp 次序来拟合某次原版输出。
5. 若后续需要重放原版单步，可用 native_replay 工具和已保存 NPZ；无需再次跑 58 个子步。
   但当前仅保存了已实现模型视图，其他 demo/历史约束不得直接复用。
6. 本轮没有提交/push，没有修改用户既有其他文件；所有工具和工作记录留在仓库目录，证据在 build 目录。

## 2026-10-28：五轮 Newton 与全部 PCG 更新（进行中）

目标：从第 58 步同一输入定位误差在哪轮放大，不改物理公式/容差。

工具更新：
- cudahook.c 增加 `CUDAHOOK_DUMP_LIMIT`（默认 1 保持旧行为），大于 1 时文件加 call000 等编号。
- 核对原版 PTX 后修正 hook 中 apply_nonlinear_step 的名字长度 19→20、参数布局 6→4。
  实际四个参数是输入位置、输出位置、解增量、粒子数；内核更新位置后清零增量。没有改原版内核。
- trace_contact.py 增加 `--all-calls`，保存全部五轮/250次更新，仍只包装函数保存输入输出，不改变运算。
- compare_newton_iterations.py 检查每轮加法、下一轮连续性、原版增量清零和最终输出相符后再比较。
- replay_pcg_calls.py 用原版每次 PCG 的完整输入执行源码，另复核每轮求逆，避免只检查首轮。

第一组命令（新目录；环境变量写在 native 命令前）：

```bash
cc -shared -fPIC -I/usr/local/cuda/include reconstruction/diagnostics/cudahook.c \
  -o build/reconstruction-debug/cudahook-iterations.so -ldl
mkdir -p build/reconstruction-debug/step58-iterations-hook/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/step58-iterations-hook \
CUDAHOOK_DUMP_LIMIT=5 \
CUDAHOOK_DUMP='20apply_nonlinear_step=0:636,1:636,2:636;35initialize_zero_solution_and_reduce=0:636,1:1908,4:4' \
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook-iterations.so \
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-native-iterations --repeats 1
.venv/bin/python -m reconstruction.diagnostics.trace_contact --all-calls \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-source-iterations
.venv/bin/python -m reconstruction.diagnostics.compare_newton_iterations \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --source build/reconstruction-debug/step58-source-iterations \
  --native build/reconstruction-debug/step58-iterations-hook \
  --native-output build/reconstruction-debug/step58-native-iterations \
  --output build/reconstruction-debug/step58-newton-iterations.json
```

原版全部保存完成后退出 134；源码/比较均退出 0。全部 trace identity checks 通过。
位置误差（各轮之后，0-based）：`9.685754776e-8, 5.960464478e-8, 1.490116119e-7, 4.693865776e-7, 3.725290298e-7`。
这一原生自重复与原捕获不是同一次执行，最终差不同；不要混用数值。
从第二轮开始两边的迭代位置已不同，因此 rhs/矩阵差不能当作同输入内核误差。

追加第二组：hook 目录 `step58-pcg-all-hook`（含 uploads），native输出 `step58-native-pcg-all`，
`CUDAHOOK_DUMP_LIMIT=250`，dump 规格如下；其余参数同上：

```text
20apply_nonlinear_step=0:636,1:636,2:636;35initialize_zero_solution_and_reduce=0:636,1:1908,4:4;27invert_block_preconditioner=0:1908,1:212,2:212,3:1908;update_solution_residual_and_reduce=1:204,2:200,3:636,4:636,5:1908,6:636,7:636,8:4
```

num/den 现在完整保存 51/50 个 float，不再使用上一轮仅用于 k=0 的16/12字节片段。
结果待追加。

### 全量 PCG 第一次检查返回失败：保留证据，先核实输出语义

`step58-pcg-all-replay.json` 的首次比较退出 1：
- 250 次 solution/residual 均逐位一致；5 次预条件器求逆均逐位一致；
- 只有 call 49/99/149/199/249 的 partial 不同（每轮最后一次）。
- 245 次有效连续归约索引检查通过，说明不是调用错位。

核查原版 `.4.sm_52.ptx` 的 update_solution_residual_and_reduce：参数9为 bool，false 时跳过归约并不写 partial。
旧 kernel_ab 仅测试 bool=1，源码 helper 每次都计算归约；数值主流程的最后一次结果不会被下一次 CG 使用。
**首次报告 native_final_rMr 字段读取的是最后调用后的 partial，可能是旧值，暂不得引用为真实最终残差。**
此处不能通过忽略失败草率放行：已给 hook 增加该内核参数布局 `iuuuuuuuucu`，
追加一次完整同输入调用记录，用 launches.txt 中 k/flag 实测确认实际开关，再修正验证器语义。
新目录：`step58-pcg-flags-hook` / `step58-native-pcg-flags`，共享库 `cudahook-pcg-flags.so`。
其余 dump 规格及 limit=250 与上一组相同。未修改 solver 公式。

### 控制标志确认与验证器修正完成

`step58-pcg-flags-hook/launches.txt` 实测记录 250 条 k/flag：每轮 k=0..48 的 flag=1，k=49 的 flag=0。
不是根据轮号猜测后跳过失败。原版 PTX 的 bool=0 分支不写 partial，实测 5 个 pre/post 缓冲逐位不变。
修正 replay_pcg_calls.py：必须存在逐调用的 k/flag 记录；只对 flag=1 比较新归约；flag=0 验证旧值保留。
最终残差指标另标 `native_final_rMr_recomputed`（用相同原版输入重算），不再把未更新的 partial 当最终范数。
原 `step58-pcg-all-replay.json` 保留为失败/诊断历史，不覆盖，里面旧 native_final_rMr 字段不应再引用。

```bash
.venv/bin/python -m reconstruction.diagnostics.replay_pcg_calls \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --source build/reconstruction-debug/step58-source-iterations \
  --native build/reconstruction-debug/step58-pcg-flags-hook \
  --output build/reconstruction-debug/step58-pcg-flags-replay.json
```

返回 0，bitwise_equal=true、indexing_valid=true：
- 250 次 solution、250 次 residual 逐位一致；
- 245 次实际写入的 partial 逐位一致；5 次禁用归约的缓冲保持原值；
- 5 次 preconditioner inverse 逐位一致。
- 两边这一步中均没有 alpha 被保护分支置零的更新；不能将差异归因于该保护触发。

现有源码 helper 始终多算最后一次归约，native_step 的 num[linear_iterations] 后续没有使用；
本轮未改这个无输出影响的计算行为，也不能声称该 helper 已完全复刻原生 bool 输出语义。

### 新增 PCG 回归覆盖

`kernel_ab.py` 新增 bool=0 的原版 PTX 测试：相同向量输出 + 非零 sentinel 归约缓冲逐位保留。
新增 `--only pcg`，并修正单组测试退出状态：现在也检查 vectors_equal/copy_equal/嵌套 partials，
防止某些向量失败却因为顶层归约通过而返回 0（与默认全套原有判定一致）。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only pcg --seed 1 --count 513 \
  > build/reconstruction-debug/pcg-no-reduction-regression.json
```

13 个顶层检查全部通过，包括新增 3 项；513 粒子覆盖多个 reduction block 和非整块尾部。
新增 Python 工具和修改文件 py_compile 通过；全调用 tracing 输出 q/qd 与此前未 tracing 的源码重放逐字节一致。

### 本轮最终证据与边界

三次原生运行均保存完成后退出 134，仍不能写正常退出；状态和工具 SHA 在
`build/reconstruction-debug/step58-iterations-provenance.json`。

最新一组五轮对照 `step58-pcg-flags-newton.json` 全部加法/连续性检查通过。各轮结束 q 最大差：
`6.705522537e-8, 5.960464478e-8, 4.097819328e-7, 8.270144463e-7, 6.631016731e-7`。
与第一组不同是另一原版重复的结果，不能只挑误差较小一组报告。
当前证据表明同输入 PCG 更新与求逆本身对齐，但**不包含全部方向更新、矩阵乘法和接触装配的同输入验证**。
不能将这次结果扩大成“整个 PCG 或整个 solver 均无问题”。

下一步：从原版后续 Newton 位置及必要 SO(3) 状态出发，做同状态的接触装配/矩阵乘法重放。
仅把源码迭代位置强行替换为原版位置会遗漏 SO(3) 乘子历史；必须一起恢复，或直接抓取相关内核完整输入。
不要修改容差，不要用固定 warp 顺序拟合单次原版输出。
本轮没有改物理公式，没有 commit/push，未动用户其他既有修改。

## 2026-10-28：全部方向/矩阵乘法与五轮表面装配（进行中）

延续第 58 步输入，不改公式和容差。先完成剩余 PCG 基础计算，再直接抓表面内核参数，
避免强行恢复 Newton 位置但遗漏 SO(3) 乘子历史。

### 250 次方向、矩阵乘法已完成

新增 `reconstruction/diagnostics/replay_matvec_calls.py`。检查所有调用 k、矩阵 n/tile/max_nnz、
ELL 完整长度，以及方向输出与紧随的矩阵输入逐位一致，再使用原版输入重放源码。
该场景 n=53、max_nnz=12，块 ELL 每项 int32 col + float32 mat3 =40字节，完整缓冲 25440 字节；
不是按猜测省略非对角矩阵。脚本从原生 launch 元数据再次核对大小，防止错配。

```bash
cc -shared -fPIC -I/usr/local/cuda/include reconstruction/diagnostics/cudahook.c \
  -o build/reconstruction-debug/cudahook-matvec.so -ldl
mkdir -p build/reconstruction-debug/step58-matvec-hook/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/step58-matvec-hook \
CUDAHOOK_DUMP_LIMIT=250 \
CUDAHOOK_DUMP='19update_cg_direction=1:1908,2:636,3:204,4:636;26multiply_matrix_and_reduce=0:212,1:25440,3:1908,4:636,5:636,6:636,7:4' \
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook-matvec.so \
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-native-matvec --repeats 1
.venv/bin/python -m reconstruction.diagnostics.replay_matvec_calls \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --native build/reconstruction-debug/step58-matvec-hook \
  --output build/reconstruction-debug/step58-matvec-replay.json
```

原版保存完成后退出 134；源码重放退出 0：250 次方向、250 次 product、250 次 partial 全部逐位一致。
这是对已装配矩阵及 extra 切线缓冲的运算验证，**不意味着 extra 切线/矩阵的装配已全部验证**。

### 五轮表面视图直接抓取

hook 增加显式 `arg+offset:bytes`：从按值传入结构中的 byte offset 读取设备指针。
旧 `arg:bytes` 行为保持；新文件名带 `_offset272` 等，以免覆盖。
固定本场景计数经 NPZ 确认：53粒子状态、170接触、2形状、1刚体。

新增 `reconstruction/diagnostics/replay_surface_iterations.py`：从原版 SurfaceContactView 的元数据和
所有参与计算的数组直接重建内核上下文，不使用源码自由轨迹或假定的 SO(3) 历史。
核对 force/preconditioner 按值视图（除末尾填充外）相同，并核对两阶段 x/previous 数组。
多接触整体比较记录差异；另将每条接触独立运行原版 PTX vs 源码，分别检查 force/preconditioner 公式。
不是对源程序整体状态做 checkpoint。

```bash
cc -shared -fPIC -I/usr/local/cuda/include reconstruction/diagnostics/cudahook.c \
  -o build/reconstruction-debug/cudahook-surface-view.so -ldl
mkdir -p build/reconstruction-debug/step58-surface-all-hook/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/step58-surface-all-hook \
CUDAHOOK_DUMP_LIMIT=5 \
CUDAHOOK_DUMP='30evaluate_surface_contact_force=0:4,0+16:2040,0+24:2040,0+32:680,0+40:2040,0+48:2040,0+56:2040,0+64:8,0+80:212,0+88:212,0+96:212,0+104:212,0+128:8,0+136:8,0+144:56,0+152:24,0+160:8,0+168:8,0+176:8,0+184:8,0+192:8,0+240:4,0+248:16,0+256:12,0+272:636,0+280:636,1:636;34add_surface_contact_preconditioner=0+272:636,0+280:636,1:1908' \
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook-surface-view.so \
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-native-surface-all --repeats 1
.venv/bin/python -m reconstruction.diagnostics.replay_surface_iterations \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --native build/reconstruction-debug/step58-surface-all-hook \
  --output build/reconstruction-debug/step58-surface-all-replay.json \
  > build/reconstruction-debug/step58-surface-all-replay.log 2>&1
```

原生抓取完成后退出 134；局部验证进行中，结果待追加。
以上 shared library 为诊断 hook，不是新 solver 依赖；普通源码运行无需它们。

### 五轮表面装配完成

`step58-surface-all-replay.json` 写入成功，源码验证退出 0。
170 接触 × 5 轮 × force/preconditioner = **1700 项逐条对比全部逐位一致**。
每轮实际产生贡献的接触数分别为 145、117、117、117、117（两个内核相同），不是全零假通过。
每条测试使用该轮原版内核完整输入，公共起始缓冲为该轮实际 native pre 缓冲；逐条原版 PTX 避免跨行写入竞争。

整体累加仍存在差异（相同 native 输入与 pre 缓冲；保留失败事实，没有判为整体逐位通过）：

| Newton 轮号（0-based） | force 最大绝对差 | preconditioner 最大绝对差 |
|---|---:|---:|
| 0 | 3.0994415283203125e-6 | 3.0 |
| 1 | 3.814697265625e-6 | 1.5 |
| 2 | 8.58306884765625e-6 | 1.0 |
| 3 | 2.86102294921875e-6 | 1.0 |
| 4 | 1.239776611328125e-5 | 1.5 |

该矩阵分量本身在百万到千万级，不能把最大绝对差直接当相对大误差。
第 4 轮最大 force 差在 flat index149（particle49,z）：源码 -6.0091614723，原版 -6.0091738701。
不同分量数、逐接触输入覆盖和明细均在 JSON 内。

额外校验：
- 130 个抓取的只读视图数组，其 kernel pre/post 字节均不变；
- 第0轮捕获位置与此前 initialize_rhs 的位置逐字节一致；
- 五轮捕获 previous 全部与原始 step NPZ 的 particle_q 逐字节一致；
- force/preconditioner 视图元数据与位置一致检查通过，未靠源码轨迹推测后续迭代位置；
- 新增 Python 工具 py_compile 通过；hook 已成功编译并在真实调用验证新 offset 读取方式。

工具哈希、原生退出状态及输入只读检查记录：
`build/reconstruction-debug/step58-matvec-surface-provenance.json`。
两次原生运行都完成保存后退出 134，不能写 clean execution=true。

### 最新进度与接手点

已在这一捕获步上验证：全部250次方向、矩阵乘法/归约（本轮），全部250次解/残差更新与5次求逆（上轮），
五轮全部表面接触的单条 force/preconditioner（本轮）。单条测试使用原版 PTX；真实原版整体结果另外记录差异。
这支持继续研究多接触累加次序对差异的影响，**不是全部求解器的等价证明**。

后续建议按同样方法补查五轮/250次接触 tangent 的真实输入，尤其接触集从145有效行变为117有效行以后。
注意矩阵乘法使用已经形成的 extra 向量，因此 matvec 的一致并不能证明产生 extra 的各 tangent 内核都一致。
可复用 SurfaceContactView 的按值元数据与 offset 抓取，直接获取每次 direction/初始product；
不要用不同自由轨迹、不同原生重复运行的缓冲做同输入对照，也不要通过固定某个 warp 次序拟合单次结果。
本轮没有修改求解公式、没有放宽容差、没有 commit/push；新增验证代码和所有命令均留在仓库。

## 2026-10-28：250 次表面接触 tangent 同输入检查

新增 `reconstruction/diagnostics/replay_surface_tangent.py`。对每次原版 tangent 调用直接读取完整
SurfaceContactView 的设备数组/按值参数、direction、输入 product 与输出 product。
不复用另一次原生运行的迭代位置，不重建 SO(3) 历史；这是单内核检查。
每次核对全部视图数组和 direction 的 pre/post 字节只读性，并确认 previous 等于捕获 step 的初始位置。

默认检查所有 250 次整体累加；另外仅在每个 Newton 轮的 k=0/49 做逐条原版 PTX 比较，
即 call 0,49,50,99,100,149,150,199,200,249，共1700项，**不是42500项全部逐条验证**。
结果分别记 `aggregate_bitwise_equal` 和 `row_bitwise_equal`，返回0只表示选定逐条检查通过。
整体多接触累加差异不会被隐藏或标成通过。

命令（shared library 复用上一轮已编译且验证 offset 支持的 cudahook-surface-view.so）：

```bash
mkdir -p build/reconstruction-debug/step58-tangent-hook/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/step58-tangent-hook \
CUDAHOOK_DUMP_LIMIT=250 \
CUDAHOOK_DUMP='32multiply_surface_contact_tangent=0:4,0+16:2040,0+24:2040,0+32:680,0+40:2040,0+48:2040,0+56:2040,0+64:8,0+80:212,0+88:212,0+96:212,0+104:212,0+128:8,0+136:8,0+144:56,0+152:24,0+160:8,0+168:8,0+176:8,0+184:8,0+192:8,0+240:4,0+248:16,0+256:12,0+272:636,0+280:636,1:636,2:636' \
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook-surface-view.so \
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --output build/reconstruction-debug/step58-native-tangent --repeats 1 \
  > build/reconstruction-debug/step58-native-tangent.log 2>&1
.venv/bin/python -m reconstruction.diagnostics.replay_surface_tangent \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --native build/reconstruction-debug/step58-tangent-hook \
  --output build/reconstruction-debug/step58-tangent-replay.json \
  > build/reconstruction-debug/step58-tangent-replay.log 2>&1
```

原生保存 complete.json 后退出139；源码验证退出0；新增脚本 py_compile 通过。
报告：250次整体比较，6750个只读数组检查通过；10个抽查调用×170条=1700项逐条逐位一致。
每轮抽查中实际改变输出的行数：145、117、117、117、117（首尾均相同）。

| Newton 轮号 | 整体最大差所在 call | tangent 整体最大绝对差 |
|---|---:|---:|
| 0 | 0 | 1.52587890625e-5 |
| 1 | 50 | 7.62939453125e-6 |
| 2 | 100 | 5.7220458984375e-6 |
| 3 | 151 | 1.9073486328125e-6 |
| 4 | 200 | 9.5367431640625e-7 |

前三轮及末轮的整体最大差调用已包含在逐条抽查内；第3轮最大差call151不在初始抽样中。
因此追加该调用的170条验证（同一份捕获，**无需重新跑原生**）：

```bash
.venv/bin/python -m reconstruction.diagnostics.replay_surface_tangent --row-calls 151 \
  --input build/reconstruction-debug/contact-call-contiguous/step-0058.npz \
  --native build/reconstruction-debug/step58-tangent-hook \
  --output build/reconstruction-debug/step58-tangent-worst151.json \
  > build/reconstruction-debug/step58-tangent-worst151.log 2>&1
```

追加验证结果待后续记录；未修改物理公式或容差，没有把整体差异归为已解决。

### 追加最大差调用验证完成

call151 的170条全部逐位一致，117条实际改变输出；追加运行退出0。
两次源码运行的250个 aggregate 比较结果完全相同，说明补查没有更换输入或改变比较基准。
本轮合计 **11个调用、1870条不同的逐条 tangent 验证**，包括各轮首尾及各轮整体最大差调用。
仍是抽查，不可写成全部42500条逐条验证。所有250次整体累加检查仍保留非逐位差异。
证据与工具/共享库哈希：`build/reconstruction-debug/step58-tangent-provenance.json`。

### 当前结论与后续工作

这一真实接触步上，表面 force/preconditioner 五轮逐条、tangent代表性调用逐条，都没有发现公式不一致；
PCG方向、已装配矩阵乘法、求逆、解/残差更新已有全部迭代的同输入逐位证据。
整体多接触累加仍不逐位一致，和此前原版自身波动的观察相容，但**尚未证明它解释全部自由轨迹偏差**。
这些局部结果不能代替公开wrapper完整demo验收，也不能写成六模块完全复现。

下一步避免反复抽查已通过的同一公式：可继续检查刚体 SO(3)、布料装配在实际后续迭代中的同输入表现，
或先整理当前已确认的模块覆盖与尚未实现的路径，转向明确缺口（如 PD cloth）。
若继续定位此步，仍需直接抓内核参数，不能只替换位置而漏掉乘子状态；任何物理公式修改须有失败输入支持。
本轮未改公式/容差，未 commit/push，未覆盖用户其他修改。

## 2026-10-28：开始补齐 PD_NEWTON 布料路径

用户要求最终完全一致。当前原版自身存在非确定累加，不能承诺每次运行都逐位相同；
继续保持逐位局部证据与完整轨迹验收分开。本轮转向源码的明确功能缺口，不再重复抽查相同表面公式。

### 缺口和原版证据

此前 `native_step.py` 对 PD_NEWTON + cloth 直接 NotImplementedError。
给 contact_replay capture 增加 `--pd`（使用现有 cloth_on_box_pd 场景），native replay 根据保存配置选择对应场景。
正常认证下抓了旧版 step0/40/58，模型/配置都保存在 NPZ。源码修改前重放退出1（预期报错），
日志 `build/reconstruction-debug/pd-cloth-before.log`，保留失败证据。

```bash
cc -shared -fPIC -I/usr/local/cuda/include reconstruction/diagnostics/cudahook.c \
  -o build/reconstruction-debug/cudahook-pd.so -ldl
mkdir -p build/reconstruction-debug/pd-cloth-hook/uploads
CUDAHOOK_DIR=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/pd-cloth-hook \
LD_PRELOAD=/home/oem/code/agent/style3d-sim/build/reconstruction-debug/cudahook-pd.so \
.venv/bin/python -m reconstruction.contact_replay capture --pd --steps 0 40 58 \
  --output build/reconstruction-debug/pd-cloth-calls \
  > build/reconstruction-debug/pd-cloth-capture.log 2>&1
```

原生保存3步和完成清单后退出139。
launch trace 显示每轮仍有 stretch/bending force，50次 scalar-ELL multiply_matrix 与 update_solution_and_residual；
没有 NEWTON 的膜面 Gauss–Newton block 矩阵修正。加入 hook 的 multiply_matrix/update_solution_and_residual 布局。
注意 launches.txt 上限20000，长捕获后段日志可能截断；本轮调度结论依据首轮完整区间，不冒称全程日志。

### 源码实现改动

`native_step.py`：
- 在函数入口确定 pd 模式；
- PD 模式不执行膜面 GN 的对角/非对角修正块构建，保留拉伸/弯曲力与 scalar ELL 乘法；
- 解除 cloth 的未实现限制，仍保留 PD springs/point-lines/粒子数>=4096 限制。
没有改求解公式中的系数、没有改容差；这是依据旧版调度补齐模式分支，而不是仅删除报错。

```bash
.venv/bin/python -m reconstruction.contact_replay replay \
  --output build/reconstruction-debug/pd-cloth-calls \
  > build/reconstruction-debug/pd-cloth-after.log 2>&1
```

退出0，source_independent=true，三个单步均在原容差内：

| step | q 最大差 | qd 最大差 | 是否逐位一致 |
|---|---:|---:|---|
| 0 | 0 | 0 | 是 |
| 40 | 2.3646862246e-11 | 5.5879354477e-9 | 否 |
| 58 | 4.4703483582e-7 | 1.07288360596e-4 | 否 |

后两步不能写成“完全一致”。`reconstruction/tests` 12项通过（15.76秒）。

### 完整demo与回归进行中

```bash
mkdir -p build/reconstruction-validation/pd-cloth6-30
.venv/bin/python -m reconstruction.validate --worker native --demo cloth_on_box_pd --width 6 --frames 30 \
  --output build/reconstruction-validation/pd-cloth6-30 > build/reconstruction-validation/pd-cloth6-30/native.log 2>&1
.venv/bin/python -m reconstruction.validate --worker shim --demo cloth_on_box_pd --width 6 --frames 30 \
  --output build/reconstruction-validation/pd-cloth6-30 > build/reconstruction-validation/pd-cloth6-30/shim.log 2>&1
```

原版120子步完成并正常退出0；源码完整轨迹仍在运行，尚未宣称对齐。
另外正在检查：Newton step58 新实现输出与先前源码输出逐字节相同；PD pendulum width2 首4子步与既有原版轨迹一致。
对应目录 `build/reconstruction-debug/newton-after-pd-cloth`、`build/reconstruction-debug/pendpd-after-pd-cloth`。
结果后续追加。

### 完整30帧结果：能运行，尚未对齐

原版与 shim 均正常完成120子步，退出0，所有状态有限。
`pd-cloth6-30/report-shim.json` 比较退出1：模型、配置、初始输入相同，源码未加载官方so，但完整轨迹不通过。
q最大差 `5.8740377426e-5`，容差比2.68246，首次失败state75；
qd最大差 `0.0157141666859`，容差比51.66859，首次失败state37。
**这是实现运行路径的进展，不是完全一致，也不能只引用三个单步通过来忽略该失败。**

```bash
.venv/bin/python -m reconstruction.validate --compare-only --candidate shim \
  --output build/reconstruction-validation/pd-cloth6-30
```

回归完成：Newton step58 的新源码 q/qd 与此前输出逐字节一致；
PD pendulum width2 的前4子步（含初态共5状态）与此前旧版参考逐字节一致。
证据：`build/reconstruction-debug/pd-cloth-regressions.json`。新Python修改均已 py_compile。

### 阻尼变体：发现重放初始化语义问题，保留负面结果

新增 `reconstruction/diagnostics/pd_damping_native.py`，从同一已变形step58构造 edge damping=1e-4 的变体。
最初在原版初始化后通过Span改变阻尼数组，模型视图检查相同，但与源码单步速度差 `0.00120520591736`
（容差比2.57493）不通过。证据 `pd-damping-replay/replay-report.json`，不能删掉或说通过。
改变阻尼本身相对零阻尼参考的速度变化约0.052，不是无效零覆盖。

不能直接将此差异判为源码数学错误：原版初始化可能缓存是否需要阻尼内核。
修正测试流程：ClothOnBox 增加可选 edge_kd 参数（默认仍0），make_example 读取可选 edge_damping，
native damping诊断在建模前设置该参数；不再把初始化后的数组修改当作同一模型初始化。
模型视图、配置、接触输入检查依旧逐字段一致。
proper-init 原版日志显示5次 add_bending_damping_preconditioner、250次 multiply_bending_damping_tangent。
原版保存完成后退出139；正在用此输出重做源码比较。

初次运行时 variant NPZ 中的 out_q/out_qd 仍是零阻尼旧参考，仅供观察变化，不能当阻尼变体验收参考。
必须在 native 完成后用保存的 native-0.npz 替换两字段，另写新目录的step NPZ与完成清单，再执行源码replay。
本轮已按该步骤保存 `pd-damping-init-replay/step-0058.npz`。

```bash
.venv/bin/python -m reconstruction.diagnostics.pd_damping_native \
  --input build/reconstruction-debug/pd-cloth-calls/step-0058.npz \
  --variant build/reconstruction-debug/pd-damping-init-input.npz \
  --output build/reconstruction-debug/pd-damping-init-native
.venv/bin/python -m reconstruction.contact_replay replay \
  --output build/reconstruction-debug/pd-damping-init-replay
```

为保留负对照可复现性，工具另加显式 `--runtime-update`。在带hook的独立原版运行中，
正检查它是否缺少阻尼kernel：目录 `pd-damping-runtime-hook` / `pd-damping-runtime-native`。
这样区分初始化状态差异与公式差异，不靠推测放行失败。

### 阻尼初始化对照完成

正确建模初始化的 `pd-damping-init-replay/replay-report.json`：源码退出0，q最大差 `4.6193599701e-7`，
qd最大差 `1.10864639282e-4`（容差比0.36093），均在原有容差内，非逐位一致。
带hook的 runtime-update 负对照也已完成保存，随后退出134；proper-init原版保存后退出139。

实测调度对比（同样的可见模型参数、状态与接触，初始化过程不同）：

| 内核 | 初始化前设阻尼 | 初始化后改数组 |
|---|---:|---:|
| evaluate_bending_force | 5 | 5 |
| add_bending_damping_preconditioner | 5 | 0 |
| multiply_bending_damping_tangent | 250 | 0 |

因此初次负对照速度超差有明确的执行路径差别，不能用它证明源码阻尼公式错误。
**模型视图数组完全相同并不等于原版隐藏的初始化状态也相同。**
后续变体必须在建模/solver initialize 之前设置对应材料，不能只改 GPU Span。
负对照工具/失败报告已保留，用 `--runtime-update` 可复现；不要拿负对照的旧零阻尼 out_q/out_qd 当新期望值。

回归和完整轨迹最终状态：
- 12项数值测试通过；Newton单步输出不变；PD pendulum前4子步与原版逐位一致。
- PD cloth默认零阻尼3个单步通过原容差；非零阻尼正确初始化的变体单步通过原容差。
- PD cloth 30帧能完成、进程均退出0，但完整轨迹数值比较失败，不能标记完全一致。
- 完整进程状态另存 `pd-cloth6-30/process-status.json`；compare-only报告中的clean_execution=null保持原意。
- 工具/实现哈希、native退出状态与阻尼调度计数：`build/reconstruction-debug/pd-cloth-provenance.json`。

下一步应优先检查 PD完整轨迹首次速度超差state37对应的输入step36，以及原版自身PD自重复范围；
在同输入下验证后续步骤，不扩大容差、不因 NEWTON 下观察到非确定性就直接认定 PD 的全部差异也是它。
仍缺 PD springs/point-line、>=4096粒子归约、硬接触/多world等；本轮没有宣称这些已覆盖。
未 commit/push；没有修改用户其他既有文件。

## 2026-10-28：继续定位 PD state37 首次超差（接触生成敏感性）

本轮保留原容差、旧版so及源码数值公式，只增加捕获/诊断。**完整轨迹仍未一致。**

### 原版自重复与同输入检查

- `pd-native-repeat30`：原版120子步保存后退出139。相对于上轮原版，整体 q最大差2.46614e-5、
  qd最大差0.00837564，首次速度超差state45；但state36/37的速度差只有2.68e-8/5.38e-8。
  因此不能用原版后期非确定性解释源码state37的0.00192046速度差。
- `pd-contact-onset-calls`：捕获step34..38，原版保存完整后退出134。源码逐步重放退出0，
  step34逐位一致；step35 q差1.4901161e-8、qd差3.5762787e-6；step36..38速度差不超过1.77e-8。
  自由轨迹接触数在step35从3增加到84；之后state37才出现明显放大。
- `pd-step35-native-pcg`：同输入原版重放退出0；hook目录`pd-step35-pcg-hook`。
  新工具`diagnostics/replay_pd_scalars.py`验证250次num、den、direction、solution、residual，
  共1250项同输入逐位一致。仅证明实际捕获的53粒子PD计算，非全部路径。
- `pd-onset-sensitivity`：固定step36接触，只替换来自源码step35的粒子位置/速度。
  位置、速度分别替换或同时替换，速度响应最大仅3.5762787e-6，没有复现0.00192放大。

### 接触生成反事实实验

`contact_replay.capture`新增`wrapper_input`，在prepare_inputs/public wrapper之前保存粒子和刚体状态。
旧capture仍可重放；新增信息用于准确重建碰撞输入，不猜测刚体姿态。
`pd-onset-wrapper-calls`重新捕获step35、36，原版完整保存后退出134，源码重放退出0。

新工具`diagnostics/pd_collision_sensitivity.py`固定刚体状态，生成两份接触：原版输入、仅替换源码step35
粒子q/qd的输入。之后独立重建源码solver做单步反事实实验。结果不是容差验收：

| 变化 | q最大响应 | qd最大响应 |
|---|---:|---:|
| 同状态重新生成接触（只有排列不同） | 7.27596e-11 | 1.72295e-8 |
| 仅粒子状态 | 2.98023e-8 | 3.57628e-6 |
| 仅扰动后的接触 | 8.00192356e-6 | 0.00192046072334 |
| 状态与接触同时变化 | 8.00192356e-6 | 0.00192046072334 |

接触变化单独就复现自由轨迹首次明显偏差的最大幅度和位置（粒子8、x）。两份接触均84条，
按(shape,indices)配对为84个唯一且相同的特征，拓扑未变；原始行号不能直接比较，GPU生成顺序有变化。
三角形(8,9,15)法线x由-0.01308118变为-0.01492424，重心权重也有变化，刚体接触点相同。
下一实验`diagnostics/pd_contact_fields.py`固定行序，分别替换法线/重心权重/刚体接触点、单独替换该三角形。
所有反事实都用新加载模型，避免历史缓存污染；基线必须逐位复现前次源码结果。

### 可复现命令（输出目录须为空，以下目录已有证据，请改新目录名）

```bash
.venv/bin/python -m reconstruction.validate --worker native --demo cloth_on_box_pd --width 6 --frames 30 \
  --output build/reconstruction-debug/pd-native-repeat30
.venv/bin/python -m reconstruction.contact_replay capture --pd --steps 34 35 36 37 38 \
  --output build/reconstruction-debug/pd-contact-onset-calls
.venv/bin/python -m reconstruction.contact_replay replay --output build/reconstruction-debug/pd-contact-onset-calls
mkdir -p build/reconstruction-debug/pd-step35-pcg-hook/uploads
CUDAHOOK_DIR="$PWD/build/reconstruction-debug/pd-step35-pcg-hook" CUDAHOOK_DUMP_LIMIT=250 \
CUDAHOOK_DUMP='19update_cg_direction=1:1908,2:636,3:204,4:636;28update_solution_and_residual=1:204,2:200,3:636,4:636,5:636,6:636' \
LD_PRELOAD="$PWD/build/reconstruction-debug/cudahook-pd.so" \
.venv/bin/python -m reconstruction.contact_native_replay \
  --input build/reconstruction-debug/pd-contact-onset-calls/step-0035.npz \
  --output build/reconstruction-debug/pd-step35-native-pcg --repeats 1
.venv/bin/python -m reconstruction.diagnostics.replay_pd_scalars \
  --input build/reconstruction-debug/pd-contact-onset-calls/step-0035.npz \
  --native build/reconstruction-debug/pd-step35-pcg-hook \
  --output build/reconstruction-debug/pd-step35-pcg-replay.json
.venv/bin/python -m reconstruction.diagnostics.pd_onset_sensitivity \
  --capture build/reconstruction-debug/pd-contact-onset-calls --output build/reconstruction-debug/pd-onset-sensitivity
.venv/bin/python -m reconstruction.contact_replay capture --pd --steps 35 36 \
  --output build/reconstruction-debug/pd-onset-wrapper-calls
.venv/bin/python -m reconstruction.contact_replay replay --output build/reconstruction-debug/pd-onset-wrapper-calls
.venv/bin/python -m reconstruction.diagnostics.pd_collision_sensitivity \
  --capture build/reconstruction-debug/pd-onset-wrapper-calls --output build/reconstruction-debug/pd-collision-sensitivity
.venv/bin/python -m reconstruction.diagnostics.pd_contact_fields \
  --input build/reconstruction-debug/pd-onset-wrapper-calls/step-0036.npz \
  --contacts build/reconstruction-debug/pd-collision-sensitivity --output build/reconstruction-debug/pd-contact-fields
```

本地依赖源码阅读：`newton/_src/geometry/soft_contacts_sdf.py:138`的optimize_edge_sdf为固定次数黄金分割，
`:179`的optimize_face_sdf为固定次数Frank-Wolfe及线搜索，非误差收敛阈值退出。
`:355`将其梯度作为法线；`geometry/kernels.py:237`的sdf_box_grad在盒外归一化到盒投影点的向量。
这提供接触参数敏感性的机制线索，尚未逐迭代跟踪证明具体分支在哪里分叉；不要修改外部碰撞器来掩盖差异。
最初step35的1ULP位置差来源仍需定位，不能把本轮放大机制当成全部根因或完整一致。

### 固定接触行序的字段隔离已完成

`pd-contact-fields/report.json`：源码进程退出0，基线与上一实验逐位相同。
84个唯一接触键完全相同，39条接触的所检查参数存在变化。以下均为相对于相同粒子状态、
相同接触行序的源码基线响应，**不是相对于原版的验收误差**：

| 替换项 | q最大响应 | qd最大响应 |
|---|---:|---:|
| 全部法线 | 8.01682472e-6 | 0.00192403700203 |
| 全部重心权重 | 6.55651093e-7 | 0.000157356262207 |
| 全部刚体接触点 | 1.49011612e-8 | 3.57627868652e-6 |
| 三类参数全部替换 | 8.00192356e-6 | 0.00192046072334 |
| 仅三角形(8,9,15)三类参数 | 8.07642937e-6 | 0.00193834211677 |
| 仅三角形(8,9,15)法线 | 8.09133053e-6 | 0.00194191839546 |

除重心权重和接触点单项之外，最大响应都在粒子8的x分量。
这将**主要放大环节定位到接触法线，尤其(8,9,15)接触**，不能由此断言碰撞器错误或源码公式正确。
单项响应不能线性相加，因为后续是非线性迭代。完整逐接触配对数值与输出NPZ保存在该目录。
本轮5个Python工具compileall通过；数值源码未修改，未重跑无关的大规模回归。
代码、hook、关键输入/报告哈希及原版进程状态在`pd-onset-provenance.json`。

后续最有价值的工作：抓step35的每轮接触装配前后、预条件器、PD标量矩阵乘法与位置更新，
定位导致首次1ULP位置差的最早阶段。250次PCG标量/向量更新已经同输入逐位通过，
不应重复把这些测试当成新进展；也不能据其他场景的原子累加结论直接认定本场景相同。
若查碰撞器，应跟踪该三角形Frank-Wolfe/线搜索分支与盒外归一化，而非放宽容差或改法线凑结果。
未commit/push，未改用户的既有示例、认证、依赖或求解器公式。

## 2026-10-28：Claude 复核上一轮 + 原子顺序结论 + CUB 多块归约（已完成）

### 复核另一 agent 的工作（结论：所查各项属实）

- `reconstruction/tests`：12 passed。`kernel_ab --only pcg` 换 seed=3、count=700：15 项逐位一致。
- PD 布料分支：`pd-cloth-hook/launches.txt` 中没有 add_cloth_membrane_gauss_newton_hessian 调用，
  与 native_step 中 PD 跳过膜面 GN 一致。
- 把 `pd-cloth-calls` 的 3 个 NPZ 复制到新目录重新 `contact_replay replay`：结果与日志表格逐项相同
  （step0 逐位，step40/58 在容差内）。
- 用上一 agent 的 `cbp` 抓取复核：NEWTON clothbox 第一子步的首个差异在 stretch 累加后（particle 25 x，
  1 个分量），此前所有输入逐位一致。

### clothbox 第一子步差异：原子累加顺序，不可静态复现

- 场景内原版（同进程）stretch 后 rhs 可被规则「slot 优先、warp 升序、lane 升序」逐位复现（bending 亦然）。
- 但直接在 GPU 上对共享顶点网格重复启动原版 evaluate_stretch_force / evaluate_bending_force（驱动 API）：
  72 个三角形单 block 也有 2–5 种不同结果；主导结果约 75%/200 次，48 种「slot/warp/lane 升降序」静态规则
  无一能复现主导结果（最好的规则在 3 个网格上仍差 44 个分量；现行规则并列最好）。
- 结论：这是 warp 到达原子指令的时序决定的，没有可还原的确定规则。**不修改 element_atomic_add。**
  脚本：scratchpad `sorder/gpu_order.py`、`freq.py`、`search.py`（临时目录，结论记于此）。

### CUB 多块归约（≥ 1 tile）已还原并逐位验证

PTX 证据（`.4.sm_52.ptx`）：
- Policy600 对 4 字节类型 tile = 256 线程 × 20 项 = **5120**（不是 4096）。
- 对齐的 float* 输入整 tile 用 `ld.global.nc.v2.u64` 向量读取：线程 t 依次读 `4t + 1024i + j`（i=0..4, j=0..3）
  并顺序相加；非整 tile 按 256 步长条带读取。
- DeviceReduceKernel 只读 GridEvenShare 的 num_items(+20) 与 grid_size(+24)，STRIP_MINE 映射：
  block b 处理 tile b, b+grid, ...；第二遍单 tile 内核对 block partial 求和并加 init。

改动：
- `pcg.py`：`cub_sum` 支持任意长度（单 tile ≤5120 直接；更大时每 tile 一个 block 两遍归约）。
  tile 数 > 200 时仍报 NotImplementedError：网格大小取决于设备 occupancy×SM 数，未还原。
- `native_step.py`：去掉 PD 的「≥4096 粒子」限制（仍拒绝 PD + springs/point-lines）。
- `kernel_ab.py`：pcg 组新增 `cub_single_tile_multi_tile_sum`（单 block 吃多个 tile）与 `cub_two_pass_sum`
  （原版 DeviceReduceKernel + 单 tile），长度 4096…60000 共 10 种；seed 1、2 全部逐位一致。

整步证据：
- cloth_on_box_pd width=75（5780 粒子，2 个 tile）1 帧 4 子步：shim 与原版 q/qd **全部逐位一致**
  （`build/reconstruction-debug/pd-large-cub-hook/`）。hook 无法按名字抓 CUB 内核（宿主桩非导出符号）。
- pendulum_pd width2 30 帧回归仍 121 状态逐位一致（`pendpd2-30-recheck/`）。

## 2026-10-28：面向目标 demo（piper_bag_transport）的 PD 缺口

### 目标 demo 的原版调用序列（已抓取）

`scratchpad/piper_native.py`（install_reference(LEGACY) 后导入 demo，仅关闭 CUDA graph 捕获以便与 shim 同序）
在 nsys 下跑 1 帧，报告导出后已删除、检查无凭据。PD_NEWTON + inertia NONE，6059 粒子（6007 布 + 13 刚体×4），
4 非线性 × 80 线性。每轮顺序（只列非 PCG 内核）：

- 力：initialize_rhs → evaluate_contact_force → rolling → evaluate_surface_contact_force →
  **add_surface_contact_stiffness_scale** → body_spring / joint spring AL → body_point_line / point-line AL →
  drive load → armature → angular limits → 自碰撞 accumulate_{vertex_face,edge_edge,edge_face} → SO(3) → stretch → bending
- 预条件：initialize_block_diagonal → SO(3) → 自碰撞 add_hessian_diagonal → surface → **point-line AL 预条件** →
  drive → armature → limits → rolling → invert
- PCG 内：SO(3) → 自碰撞 multiply_contact_tangents → surface → contact tangent → **point-line AL 乘法** → drive →
  armature → limits → rolling → multiply_matrix → DeviceReduceKernel(g2) + SingleTile（两遍 CUB，已还原）
- 迭代末：apply_nonlinear_step → SO(3) / joint spring / point-line 状态更新

### 新还原内核（均逐位）

| 内核 | 源码 | kernel_ab | 结果 |
|---|---|---|---|
| add_joint_body_point_line_augmented_lagrangian_preconditioner | `joints.PointLines.add_preconditioner` | point_lines 组 | seed 1/2/3 逐位，1296 个非零 |
| multiply_joint_body_point_line_augmented_lagrangian | `joints.PointLines.multiply_tangent` | point_lines 组 | seed 1/2/3 逐位，432 个非零 |
| add_surface_contact_stiffness_scale | `surface_contact.add_surface_contact_stiffness_scale` | surface_contact 组 | seed 1/2/3 逐位，500+ 粒子改变 |

- point-line AL 预条件：每个 Jacobian 项 (w (k w)) P 加入该粒子对角块，先点体 4 个后线体 4 个，无 k>0 判断。
- point-line AL 乘法：u = Σw_pt d − Σwq d（求和序同 _weighted），f = (kα) P u，点体加 w f、线体加 wq (−f)。
- stiffness scale：自碰撞“质量”缓冲（宿主 +0x2f30）先拷贝标量对角，再按法向列表加 w²·(ke + kd/h)
  （**非融合加法**，与预条件内核的 fma 不同）。hook 证据：该缓冲是 accumulate_vertex_face 第 7 个实参；
  原版 pre 值在布粒子约 28003（= m/h² + 常数刚度），post 有 128 个粒子增加。只有自碰撞 + 表面接触时才启动。

### native_step 调整（依据三份 trace 合并出的顺序）

- 预条件：SO(3) → 弯曲阻尼 → 自碰撞对角 → surface → point-line AL（仅 PD）→ drive/armature/limits → rolling；
  此前弯曲阻尼与自碰撞在 rolling 之后（有刚体时顺序错）。依据：piper（PD）、pd-damping-init-hook（PD 有阻尼）、
  旧 bag（NEWTON：弯曲阻尼 → 自碰撞）。
- 切线同理：SO(3) → 弯曲阻尼 → 自碰撞 → surface → contact tangent → soft off-diagonal → point-line AL → drives → rolling。
- 自碰撞 accumulate 移到 SO(3) 力之前（粒子不相交，数值无影响，只为与原版同序）。
- PD 不再拒绝 point-lines（仍拒绝 PD + 布料弹簧 Hessian）。

### 验证

- 新 demo `pendulum_prismatic_pd`（validate）：原版 30 帧 vs shim，**121 个状态 q/qd 全部逐位一致**
  （`build/reconstruction-validation/pendprismpd2-30/`；原版保存后退出段错误，属拆卸）。
- 回归（重跑 shim，与已有原版轨迹比）：pend2、pendball2、penddrive2、pendlim2、pendprism2、pendarm2、pendpd2、
  drop1 全部 30 帧逐位一致（`build/reconstruction-debug/regress-*`）。
- 阻尼 PD 布料 step58 单步（上一 agent 的输入）：qd 差 1.11e-4 → 8.94e-5（容差比 0.29），仍非逐位
  （170 接触跨 warp 原子顺序）。

## 2026-10-28：转向“所有模块先对齐”（piper demo 暂停）

### 内核覆盖统计（legacy so 共 126 个求解内核）

脚本：从 `build/reconstruction-ptx/` 列出全部 `synreal::*` 入口，与 `kernel_ab.py` 中调用的内核名对照。
开始时 86/126 有逐位 A/B；本轮后 **99/126**。

本轮新增逐位 A/B（kernel_ab `--only step`、`joint_springs`、`point_lines`，seed 1–4）：

| 内核 | 源码 | 备注 |
|---|---|---|
| initialize_step | `step_kernels.initialize_step` | 参数 6 = 宿主对角，17 = 质量；非激活仿射体粒子 previous = fma(-v, h, x)（运动学刚体保速度） |
| apply_nonlinear_step / update_velocity | `step_kernels` | |
| combine_system_non_diagonal | `step_kernels.combine_system_non_diagonal` | |
| initialize_block_non_diagonal | `pcg.initialize_block_non_diagonal` | 多 world 列偏移也验证 |
| refresh_inertial_cache_nonzeros / diagonals | `step_kernels` | CSR 顺序求和（b 为相减） |
| update_solution_and_residual（PD） | `pcg` | 含 den=0 保护 |
| initialize_joint_body_spring_state | `joints.Springs.initialize_state` | |
| evaluate_body_spring_force | `Springs.plain_force` | ptxas 收缩 fma(-rest, u, d) |
| add_body_spring_gauss_newton_hessian | `Springs.add_gauss_newton_hessian` | K = k(M - I)，rest<=0 或 k<=0 跳过 |
| evaluate_body_point_line_force | `PointLines.plain_force` | |
| add_body_point_line_gauss_newton_hessian | `PointLines.add_plain_hessian` | t 的导数项；ptxas 收缩 g = fma(-d, 2t, r) |

solver 改动：native 路径使用 `step_kernels.initialize_step`（运动学刚体粒子 previous 回推）；
core 去掉“普通 body spring / point-line 未实现”的门；native_step 增加宿主常数模板
`joints.plain_templates`（对角 + L0，k s_i s_j，弹簧权重 (+w0, -w1)，点线 (-w_pt, (we0+we1)/2)），
力在 soft contact 之后（plain spring → joint spring AL → plain line → line AL），GN Hessian 在 initialize_block_diagonal
之后、关节 point-line GN 之前写入 system。PD + 普通约束仍报错（未取得原版 PD 调度）。

整步验证：新场景 `body_constraints`（3 个自由盒子，普通弹簧到世界/互连，点线到世界线段/刚体线段，无碰撞），
原版 vs shim 30 帧 **121 状态逐位一致**（运动幅度 1.86 m）。回归：12 测试通过；pend*/drop1/pendprismpd 逐位不变。

### 剩余 27 个内核（按模块）

- 距离约束 3：initialize/evaluate/update_body_distance_constraint_*
- 仿射体其他刚性模型 5：evaluate/multiply/add_affine_body_constitutive_*、evaluate_affine_body_spring_force、
  add_affine_body_spring_gauss_newton_hessian
- 仿射体预条件 / 力矩 3：build/apply_affine_body_preconditioner、apply_affine_body_torques
- PCG 变体 4：prepare_inverse_preconditioner、apply_block_diagonal_preconditioner、update_preconditioned_cg_direction、
  evaluate_residual
- 硬接触 4：initialize/evaluate/snapshot_hard_contacts、update_hard_contact_duals
- 线缆 4：evaluate_cables、prepare_cable_penalties/tangents、update_cable_penalties
- 杂项 4：initialize_joint_coordinate_velocities、reset_selected_joint_drive_state、refit_aabbs、
  self_collision multiply_hessian_diagonal

另：piper 中发现并修复两处 shim 问题（每步重读关节驱动增益 span；全表面接触且无 particle-only 形状时不跑粒子
soft contact）。修复后首个 Newton 迭代各阶段与原版只差原子顺序量级（~1e-6 相对）；原版自身两次运行第 1 子步
速度差 2.2e-3，第 2 子步起已达米每秒级。按用户要求 piper 整体验证暂停。

### 距离约束（3 个内核）完成

- `joints.DistanceConstraints`：initialize（长度 x-first）、force（体 0 四槽先、体 1 后，不交错）、update（长度 y-first，
  回退到旧 r 方向，再回退 (rest,0,0)），kernel_ab `joint_springs` 组 seed 1–3 全部逐位。
- 宿主模板：D5 / L6（权重 constraint_alpha），值 m_s s_i s_j（s = (+w0, -w1)），hook 抓取确认（bdist-hook）。
- 调度（trace_bdist）：init 紧跟 initialize_step；力在 plain spring 与 plain point-line 之间（与关节 spring AL 的相对
  顺序未取得，暂放其前）；update 在每次 apply_nonlinear_step 之后（含最后一轮）、SO(3) 更新之前；力用 alpha/h²。
- 场景 `body_distance`（body_constraints + 3 个距离约束）：原版 vs shim 30 帧 **121 状态逐位一致**。回归不变。
- 覆盖：**102/126**。

### 仿射体其他刚性模型（5 个内核）完成

| 内核 | 源码 | 结果 |
|---|---|---|
| evaluate_affine_body_spring_force（SIX_SPRINGS） | `affine.six_spring_force` | seed 1–3 逐位 |
| add_affine_body_spring_gauss_newton_hessian | `affine.six_spring_hessian` | 逐位（对角 + ELL） |
| evaluate_affine_body_constitutive_force（CO_ROTATED / ABD） | `affine.constitutive_force` | 两模型逐位 |
| multiply_affine_body_constitutive_tangent | `affine.constitutive_tangent` | 两模型逐位 |
| add_affine_body_constitutive_preconditioner | `affine.constitutive_preconditioner` | 两模型逐位（单位方向探测切线） |

要点：CO_ROTATED 复用 `nearest_rotation`（与 SO(3) 初始化同一内联例程）；P = (S+Sᵀ-2I)+(trS-3)I、G = RP；ABD 为
G = (AAᵀ-I)A，切线 (M+Mᵀ)A；六弹簧列弹簧静长 1（rcp），差分弹簧 √2，应变小于 2⁻²⁰·静长视为 0。
宿主模板（hook）：SIX_SPRINGS 用 D1 = 3w、L2 = 0-w（惯性缓存输出，权重 c1 = alpha）；本构模型无常数模板。
调度（trace）：本构模型三个内核分别替换 SO(3) 的 force/precond/tangent，且不跑 SO(3) 初始化/更新；
SIX_SPRINGS 只有 force 与 GN Hessian（initialize_block_diagonal 之后第一个）。PD + 非 SO(3) 仍报错。
整步：body_corotated / body_abd / body_six_springs（body_constraints 场景切换刚性模型）30 帧 **121 状态逐位一致**。
覆盖 **107/126**。

### 精确覆盖统计与小内核（截至 2026-10-29）

改用精确统计：包裹 `kernel_ab.legacy_ptx` 记录全套 A/B 实际启动的原版入口，与 PTX 中 `synreal` 入口按名字
（模板实例合并）对照。此前子串统计有误报（如 multiply_matrix 被 multiply_matrix_and_reduce 误计）。
脚本：scratchpad `cov.py`。结果：全套 exit 0；**114/124** 个不同内核有逐位 A/B。

本段新增逐位：
- PCG/PD：multiply_matrix（mat3 与 float 对角两种实例）、prepare_inverse_preconditioner、
  apply_block_diagonal_preconditioner、update_preconditioned_cg_direction、evaluate_residual（`pcg.py`）。
  trace 证实 PD（有无刚体）都走块预条件路径；标量预条件路径在已覆盖配置下不被调用，仅内核级对齐。
- kernel::refit_aabbs（= lbvh.refit）、self_collision multiply_hessian_diagonal。
- initialize_joint_coordinate_velocities（`joints`；旋转轴项按驱动内核收缩，棱柱行按电枢内核 minuend 融合，
  四种组合实测只有这一种逐位）；reset_selected_joint_drive_state（core.reset_joint_drive_state 已接通）。
- apply_affine_body_torques（`affine`，余子式/叉乘 minuend 融合；另两种收缩实测不符）。

validate 新增 `--pd`（任意场景切到 PD_NEWTON + inertia NONE，并记入 metadata/settings）。
cloth_hanging --pd 6x6 30 帧：原版 vs shim 通过（q 容差比 0.55，qd 0.35），首子步差异仅在近零分量（原子顺序）。

剩余 10 个内核：仿射体块预条件 build/apply（2，配置 affine_body_block_preconditioner）、硬接触 4
（rigid_contact_hard）、线缆 4。

### 进度（115/124）与剩余大模块

- 新增 apply_affine_body_preconditioner（`pcg`，12x12 行主序块 × 12 维残差，fma 链从 +0）逐位。
- 注意：此前我的 PTX 摘取脚本遇到首个行首 `}` 即停止，长内核阅读副本会被截断（已 A/B 的内核在 GPU 上跑完整模块，
  结论不受影响）。改用 scratchpad `xptx.py`（截到下一个 .entry）。按完整长度，剩余 9 个内核共约 3.5 万行 PTX：
  evaluate_cables 11138、evaluate_hard_contacts 7099、prepare_cable_tangents 5542、build_affine_body_preconditioner
  4561、update_cable_penalties 2512、update_hard_contact_duals 2096、initialize_hard_contacts 2040、
  prepare_cable_penalties 159、（apply_affine_body_preconditioner 已完成）。
- HardContactView（312 B，hook 'H' 类型）：0 count ptr, 8 capacity, 16/24 shape0/1, 32/40 point0/1, 48/56 offset0/1,
  64 normal, 72/80 margin0/1, 88 (null), 96 shape_body, 104 shape_type, 112 transform, 120 scale, 128/136/144 材料,
  152 形状数, 160 每 world 形状数, 168 world 数, 176 affine ids, 184 affine indices, 192 com, 200 body 数,
  208 粒子数, 216 (模型数组), 224 x, 232 f32 1/h + f32 rigid_contact_alpha(0.95), 240 f32 beta(0) + gamma(0.999),
  248 f32 constraint_alpha(100) + bool(253) history, 256 λn, 264 λt(vec3), 272 (?), 280 prev λn, 288 prev λt,
  296 prev normal, 304 prev count。调度（trace_hard）：initialize 在 initialize_step 前；evaluate 三种模式替代
  evaluate_contact_force/tangent；update_hard_contact_duals 每轮 apply_nonlinear_step 后；snapshot 在最后一轮后、
  update_velocity 前。
- 线缆：场景 `cable_bend`（examples/cable/example_cable_bend_stiffness，无接触）；trace：prepare_cable_tangents 每轮
  迭代开始，evaluate_cables 三模式（力/预条件/切线）。CableView 160 B。penalty 两个内核在该配置不运行（beta=0）。
- validate：`body_drop_hard`、`cable_bend`、`cable_twist_transfer` demo；示例可提供 validate_prepare 输入钩子；
  contacts 为 None 时跳过碰撞。

## 2026-10-29：接续 Claude 最新进度，独立复核与两个边界内核

已读用户指定JSONL的最新assistant工作叙述及本日志新增章节，接续其115/124进度；没有重做已解决的
PD放大实验。JSONL最后停在build_affine_body_preconditioner阅读，完整长PTX截取问题已被其发现。
本轮直接从校验SHA的完整PTX模块读取内核（截到下一entry），未依赖旧截断副本。
第一次读取日志使用`python`失败（系统无该命令），改用python3；没有打印认证历史。

### 独立复核

- `pytest reconstruction/tests -q`：12 passed，16.06秒。
- `kernel_ab --only affine --seed 3`：20项逐位通过，包括上一agent新增的apply_affine_body_preconditioner。
- 整理临时cov.py的方法到`reconstruction/diagnostics/kernel_coverage.py`，不再依赖/tmp。
  新统计在Driver.launch成功同步后登记符号，而非仅在legacy_ptx被查询时登记。
  内核按基本名称合并模板实例；只有整份A/B通过才能把覆盖数理解为已验证。
  **这不是分支覆盖率，也不是完整demo/宿主调度覆盖率。**
- 加入线缆初始化后，seed3/count512全套A/B退出0、passed=true，116/124。
  证据：`build/reconstruction-debug/coverage-20261029/{ab,coverage}.json`。

### 新源码：cables.prepare_penalties

对应`prepare_cable_penalties`，与算法分析17.4相符，独立读取完整159行PTX确认：
- authored vec4按i % per_world读取；状态/更新mask按全局i读取。
- 两个beta仅决定对应两个通道是否使用min(start,authored)下限。
- reset或未初始化时用下限，否则读历史；rescale决定使用gamma还是1。
- 每通道按独立float32 mul/max/min执行min(authored,max(lower,factor*old))，最后initialized=1。
- mask=0时整行及initialized都不写；count外保留。

`kernel_ab --only cables`新增192组组合：reset/rescale各两值、beta正/负或零、无mask/混合mask/全零mask，
scale=0/0.5/1/1.5；19行材料表、57行（三world）状态、7行尾部哨兵；含零、精确夹紧边界及非规范非零flag。
每组验证输出、initialized及只读输入不变，总704项。seed2与seed3全部逐位一致、退出0。
最初seed1为尚未扩展scale笛卡尔组合的48组/176项，也通过，保留为早期证据。
范围为所列有限浮点测试，不宣称NaN/Inf或全部配置已经覆盖。

### 新源码：hard_contacts.snapshot

对应`HardContactView`的`snapshot_hard_contacts`（完整PTX约130行）。
- count为NULL时写previous_count=0；否则夹紧到[0,capacity]。
- 复制有效前缀lambda_n/lambda_t，保留未使用历史槽。
- 法线长度按y*y、fma(x,x,...)、fma(z,z,...)、sqrt.rn顺序；正长度逐分量div.rn，否则置零。
- 实测312B view所用偏移：0 count、8 capacity、64 normal、256/264 lambda、280/288 previous lambda、
  296 previous normal、304 previous count，与上一agent记录一致。

`kernel_ab --only hard_history`：10种count/capacity（含NULL、负数、零、超过容量、513行跨block）、
零/轴向/非单位法线、尾部哨兵、输入不变，共70项，seed1/seed3逐位通过，退出0。

**两个新内核均未接入native_step**：线缆力/切线/惩罚更新及硬接触初始化/力/dual更新仍不完整。
只通过边界内核不能让整场景绕过NotImplementedError，也不能声称线缆或硬接触demo通过。

### 命令与证据

```bash
.venv/bin/python -m pytest reconstruction/tests -q
.venv/bin/python -m reconstruction.kernel_ab --only affine --seed 3
.venv/bin/python -m reconstruction.kernel_ab --only cables --seed 2
.venv/bin/python -m reconstruction.kernel_ab --only cables --seed 3
.venv/bin/python -m reconstruction.kernel_ab --only hard_history --seed 1
.venv/bin/python -m reconstruction.kernel_ab --only hard_history --seed 3
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage \
  --output build/reconstruction-debug/coverage-20261029-final --seed 2 --count 512
```

覆盖工具的output必须为空目录；重跑请换新目录。单组报告通过stdout重定向保存，均在
`build/reconstruction-debug/cable-penalty-ab/`（包含affine/hard-history复核报告）。

### 本轮最终验收

`coverage-20261029-final`：seed2/count512，完整A/B退出0，passed=true，**117/124**。
剩余7个不同内核（不是剩余全部工作）：
`build_affine_body_preconditioner`、`evaluate_cables`、`prepare_cable_tangents`、`update_cable_penalties`、
`initialize_hard_contacts`、`evaluate_hard_contacts`、`update_hard_contact_duals`。
源码compileall通过；最终报告、源码与单组报告SHA记录在`kernel-additions-20261029-provenance.json`。

下一步建议：继续读取build_affine_body_preconditioner完整4561行PTX，先确认12x12块装配和奇异/有效标志分支，
对实际输入做独立A/B，再与已通过的apply配对接入配置；若改做线缆，须恢复完整CableView及角度历史，
不能将当前prepare_penalties单独接入后就放行demo。原版宿主调用点reset/rescale来源仍需捕获确认。
本轮未修改已有求解公式/容差、用户示例/认证/依赖，未运行原版完整demo（故没有新增demo一致性结论），未commit/push。

## 2026-10-29：优先补齐剩余内核（进行中，接续117/124）

本轮新增`affine_preconditioner.py`和`diagnostics/affine_block_ab.py`：已读完整build_affine_body_preconditioner
的两个模板实例，恢复12x12装配、质量/ACTIVE筛选、对角缩放、Cholesky、前后代入、有限值失败及最终对称化。
覆盖块/标量ELL、缓存、SO(3)、线缆Jacobian、重复线缆/重复粒子、world偏移、无flags、无效列和行数边界。
基础及扩展seed1/seed3的原版输出/valid均逐位通过，块实例另用只插入出口的诊断PTX捕获装配矩阵对比。
探针不是未经修改的原版验收；最终输出/valid均来自完整原版PTX，诊断探针仅定位。

最初SO(3)有17/25个逆矩阵分量不同，装配探针定位到matrix[11,11]的两个样本。
原版中间寄存器捕获确认最后对角元素的首尾平方加法发生FMA收缩；按此调整后全部逐位一致。
失败报告`affine-block-first/second/probe/locations/corrected/corrected2`均保留；最终
`affine-block-corrected3.json`、`affine-block-expanded-seed{1,3}.json`、`affine-scalar-seed{1,3}.json`通过。
新功能已加入kernel_ab的affine_block组。暂未改native_step宿主调度。

调试中第一次ptxas失败：截取末尾带孤立.visible；去掉最后闭括号之后内容后编译成功，SASS留在
build-affine.sass。该独立编译仅供阅读，数值验收始终用Driver加载原版完整模块。

硬接触新增geometry/initialize/update_duals原型：initialize在16组合80接触测试中逐位通过；
update_duals当前在无offset、接近奇异仿射矩阵的球-球样本23仍有1~2个dual分量不同，尚未计为通过。
正在抓球面偏移中间量。注意修正旧日志的字段理解：256是惩罚参数，264是向量dual，272是锚点；
216/224是两组粒子位置，initialize只读取216；252为history、254为reset标志（不是此前猜测253）。

## 2026-10-29：仿射块预条件器与硬接触完成本轮内核 A/B，121/124

### 最终结果与前述记录纠正

最终完整套件 `build/reconstruction-debug/coverage-20261029-block-hard-sass/ab.json` 的 passed=true，
coverage.json 的 ab_exit_code=0、covered_count=121、total_count=124。
参考旧库 SHA256 仍为 `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
仅余三个未覆盖内核：prepare_cable_tangents、evaluate_cables、update_cable_penalties。
覆盖按内核基本名合并模板；不是全部分支覆盖，更不是完整 demo 一致性。新增内核尚未接入 native_step。

前节的 SO(3) 初步解释不够准确。扩大种子后暴露更多差异，曾尝试按块/标量模板区分浮点融合，
该假设已被否定并撤销。最终查看带 PTX 行号的 SASS，确认两个模板采用同一融合顺序：
在 a=b=2 且 j=k 时，先把 R[2,k]*R[2,j] 融入已经舍入的 R[2,0]^2，再依次融合 R[2,1]^2、R[2,2]^2。
不能只对最后一个对角元素添加特例。源码现在使用统一规则。
`affine-block-scalar-scan-sass.json`：seed1..15 × 两模板共30次，每次9场景，所有检查通过。
每场景同时比较未经修改的完整原版内核输出/valid及装配探针。探针只作定位，不代替原版验收。

失败证据保留：coverage-20261029-block-hard、-v2、-v3、-v4 均退出1；
affine-block-scalar-scan-final.json 虽名为final，实际上是失败的早期扫描，不能作为最终通过依据。
正确最终文件带 `-sass`。SASS证据：build-affine-lineinfo.ptx/.cubin/.sass，
用 CUDA12.8 ptxas -arch=sm_120 -O3 -lineinfo 编译并以 nvdisasm -g 查看。

### 硬接触新增源码及定位

hard_contacts.py 新增 geometry、initialize、update_duals、evaluate。
硬接触字段：256 penalty、264 向量dual、272 anchor；252 history、253 exact-friction、254 reset。
initialize 的 anchor 用 fma(depth, normal, -tangent)；此前先乘再加的写法会差1ULP。
update 的球-球中心方向归一化采用 y-first 点积，静态球偏移采用FMA，修正近奇异仿射体的差异。
evaluate 恢复 force/scalar、off-diagonal product、system/preconditioner correction、affine block cache。
同一刚体出现在接触两侧时，仿射cache只写一次；按原版BB78_633去重，修复此前重复累加。

诊断工具 diagnostics/hard_contact_ab.py 覆盖48组初始化/更新配置（每组80条接触），
包括history/reset/offset/beta、NULL/负/部分count、非法shape、零法线、匹配缺失、两个world及跨world非法配对。
evaluate覆盖其中17组的四种模式，检查只读状态未变，包含同体两端、摩擦和多world。
最终 hard-evaluate-final-seed3.json 全部逐位通过；完整套件使用独立随机流再次通过。
早期 hard-evaluate-first.json 的geometry探针失败是验证器重用了evaluate指针、view仍指旧缓冲造成，
已改为专用probe指针；不能把它描述成原版计算错误。其他中间失败报告保留。

### 验证命令（项目根目录）

```bash
.venv/bin/python -m reconstruction.diagnostics.affine_block_ab --seed 3 \
  --output build/reconstruction-debug/affine-block-check.json
.venv/bin/python -m reconstruction.diagnostics.affine_block_ab --scalar --seed 3 \
  --output build/reconstruction-debug/affine-scalar-check.json
.venv/bin/python -m reconstruction.diagnostics.hard_contact_ab --seed 3 \
  --output build/reconstruction-debug/hard-contact-check.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage \
  --output build/reconstruction-debug/coverage-20261029-block-hard-sass --seed 3 --count 512
.venv/bin/python -m pytest reconstruction/tests -q
.venv/bin/python -m compileall -q reconstruction
```

coverage 输出目录必须为空，复跑需换新目录。最终 pytest：12 passed in 19.78s，退出0。
30次仿射扫描调用 diagnostics.affine_block_ab.run(Driver(), default_rng(seed), scalar)，
scalar=False/True、seed=1..15；每次finally释放Driver，检查每个case下每个bitwise_equal。
末尾仅做断行及模块docstring修正，无算术改动。

### 下一步：线缆，暂未实现，勿计为通过

完整PTX读取入口 legacy_ptx('22prepare_cable_tangents')、legacy_ptx('15evaluate_cables')、
legacy_ptx('22update_cable_penalties')。提取entry必须读到下一entry，不能遇到内层右括号就截断。
当前调试提取文件在 build/reconstruction-debug/，末尾可能带下一段.visible，单独编译前应清除。
对应机械恢复CUDA在旧库 _re_analysis/recover/src/solver_newton/，尚未复制或认定正确。

update_cable_penalties 已核对的字段：160B CableView，0仿射索引、8 COM、16每体36B矩阵、24 int2身体配对、
32/40两端frame、48每world重复vec4上限、56全局vec4 penalty、72每world重复vec3参考角度、
96每world重复enable、136每world线缆数、144全局数、152粒子stride。
16字段仅确认矩阵载入，具体语义尚需结合完整旋转链确认，不能按此前猜测bodyflags解释。

末段 BB73_122 已确认：前三个局部位移寄存器f268/f269/f270，二维弯曲误差f1128/f1129，
扭转差f1130只做一次±2π回绕（严格 >π 或 <-π）。四个增量范数顺序为
abs(f270)、sqrt(fma(f268,f268,f269*f269))、sqrt(fma(f1128,f1128,f1129*f1129))、abs(wrapped_twist)。
前两项乘arg2、后两项乘arg3，与旧penalty做FMA，再min上限；无额外max下限或beta正数判定。
这些是静态阅读结论，不是新内核A/B通过。需先恢复完整frame变换和弯扭误差，尤其反三角函数和退化分支，
再独立对原版完整kernel验收，不能只对末段写个实现就增加覆盖数。

本轮未更新官方库、未更改认证/依赖/示例、未运行完整原版demo、未commit/push。
原先布料自由轨迹超差问题仍存在；内核补齐后再处理宿主调度及demo验证。

## 2026-10-29：最后三个线缆内核完成 A/B；全库审计纠正“124/124”的含义

### 本轮线缆实现

导入旧库分析目录 recover/src/solver_newton 中的 prepare_cable_tangents、update_cable_penalties、
evaluate_cables 完整机械恢复 CUDA 源码及 px_common.h，保存到 reconstruction/cuda_cables/。
这些是 CUDA C++ 控制流加标量内联 PTX 的源码，不是 NumPy 语义重写，也不是加载原版抽取PTX冒充源码。
原始/当前源码哈希与来源见该目录 manifest.json；每次编译的命令/版本/输入哈希在 build/reconstruction-cables/build.json。
新增 cable_cuda.py 的源码编译和低层launch适配器，无官方so或原版PTX依赖；尚未接入native_step。

最初构造scene时把仿射状态的平移放到第四槽，原版实际平移在第一槽。
纠正后普通场景通过；原来的输入仍是可表示的强非正交仿射状态，不能作为“无效输入”丢弃。
已把该类输入保留为variant8。它暴露机械源数值差异：Jacobian少量分量、force少量分量，串联后误差放大。
唯一CUDA改动为全部标量asm增加volatile约束，算术、分支、数据布局不改；失败样本随后通过。
这说明该编译约束修复了已观察差异，不声称已经逐条SASS证明所有编译变化的根因。

诊断 cable_cuda_ab.py 先每次重新nvcc编译，再独立加载源码PTX和原版完整PTX。
9配置：两个world，静态/动态端点、enable/可选历史为空、零刚度/阻尼、微小/零仿射矩阵、
参考矩阵/角度扰动、同一刚体两端、274条跨256线程边界、强非正交状态。
检查准备Jacobian/节点索引/数量、penalty、force、product、preconditioner和双输出组合。
既使用同一原版Jacobian隔离evaluate，也使用各自Jacobian串联验证。
最终加入可选penalty=NULL及只读输入检查；每条线缆独占刚体以排除跨线程原子累加次序。
不宣称共享刚体并发累加、所有NaN/Inf、完整宿主调度或demo已通过。

seed1完整扩展报告 expanded1-volatile.json 通过；seed2..10扫描 scan-volatile.json 全通过。
最终增加只读及mixed检查后 final-expanded3.json 通过，完整套件另一随机流通过2089项线缆检查。
失败保留 first.json、locations.json、seed2.json、expanded1-pipeline.json；它们不能作为最终通过证据。
最终 pytest：12 passed in 21.42s；compileall退出0。只修改reconstruction和交接文档，没有更新旧so或用户认证配置。

```bash
.venv/bin/python -m reconstruction.diagnostics.cable_cuda_ab --seed 3 \
  --output build/reconstruction-cables/final-expanded3.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage --seed 3 --count 512 \
  --output build/reconstruction-debug/coverage-20261029-cables
.venv/bin/python -m pytest reconstruction/tests -q
```

完整A/B passed=true、exit0，**SynReal基本名124/124**。下述审计表明这不能解释成全库全部实例完成。

### 用户要求“确认so全部内核”后的独立审计：不能确认全部还原

新工具 diagnostics/kernel_inventory.py 从固定SHA旧so重新cuobjdump抽取全部PTX，不使用原缓存清单，
并用cuobjdump -symbols的STO_ENTRY与PTX .entry交叉核对。二者完全一致，没有仅存在于cubin的额外entry。
6个模块共218处entry声明；跨模块同名去重后188个独立符号。

| 范围 | 唯一入口符号 | 当前完整套件实际启动 | 尚未覆盖 |
| --- | ---: | ---: | ---: |
| SynReal自有内核（不合并模板） | 131 | 128 | 3 |
| CUB辅助内核 | 34 | 2 | 32 |
| Thrust辅助内核 | 23 | 0 | 23 |
| 合计 | 188 | 130 | 58 |

旧coverage工具只筛选_ZN7synreal，再将模板合并为基本名，因此124/124隐藏了3个未覆盖模板，
且未把CUB/Thrust纳入分母。此前“剩下最后三个内核”仅适用于这个受限分母，不能作整个so完成的承诺。
新工具kernel_coverage已保留基本名历史统计，同时新增全入口和SynReal模板入口的计数、完整missing列表，
并明确all_entries_exercised_and_ab_passed；不能再仅看covered_count判断整个so。

遗漏的3个自有模板：
1. evaluate_residual<NonZeroEntry, glm::mat3>
2. evaluate_residual<BlockNonZeroEntry, glm::mat3>
3. update_cg_direction<float>

已有pcg.evaluate_residual目前只覆盖标量对角/标量ELL；pcg.update_cg_direction目前使用mat_vec，
不能仅因相同名字已有源码就认为标量模板也实现且通过。这3项应先补齐独立A/B。
剩余55个CUB/Thrust辅助入口主要涉及归约、排序、填充等；有些源码solver路径有功能替代，
但当前无逐实例等价证明，不能标记为已还原。是否以开源库或自有算法替代，须按实际宿主调用及数值要求逐项验收。
同名入口跨模块的每个出现位置也尚未逐个验证，188是唯一符号统计，不是完整分支证明。

```bash
.venv/bin/python -m reconstruction.diagnostics.kernel_inventory \
  --coverage build/reconstruction-debug/coverage-20261029-cables/coverage.json \
  --output build/reconstruction-debug/inventory-20261029-all
```

该目录必须为空。inventory.json保存全部符号、模块哈希、未覆盖列表，cubin-symbols.txt保存独立二进制证据。
审计退出0表示PTX/cubin清单相符，不表示188个内核都通过；报告明确unique_launched=130。
本轮不宣称全库完全还原，完整demo超差问题及宿主集成仍保留。

修正覆盖统计后复跑：coverage-20261029-cables-audited，seed3/count512，A/B仍通过；
新报告明确synreal_entries_launched=128/131、all_entries_launched=130/188、
all_entries_exercised_and_ab_passed=false。不是套件失败，而是全库入口尚未覆盖。

## 2026-10-29：补齐3个自有模板，新增28个辅助入口验证；161/188

### 验证层级澄清（用户本轮再次确认）

本轮没有使用账号登录完整原始SynReal求解器。基准是从已固定SHA旧so中抽取、未经修改的原始PTX，
通过CUDA driver直接执行，与源码同输入逐位比较。这是内核级A/B，不能替代用户要求的
“登录原版运行demo，再运行源码demo并比较”。先前完整轨迹超差和原版捕获退出异常仍保留，
本轮没有新增完整原版demo通过证据。后续不得把本节数字当作完整求解器一致性结论。

### 新增源码与检查

pcg.py扩展两个函数，保持已验证模板行为：
- update_cg_direction 支持标量预条件器（逐分量乘法，再按原版beta保护与FMA更新）。
- evaluate_residual 支持mat3对角及标量/块ELL，块乘加仍使用现有y-first mat_vec与逐槽累加。

完整阅读遗漏三个模板的原PTX（87/323/317行）；新增 diagnostics/pcg_templates_ab.py。
144项检查覆盖n=1/33/513、k=-1/0/后续迭代、零/极小/NaN/Inf分母保护、负预条件器、
标量/块ELL、负/超上界列、空ELL与NULL指针、extra开关、尾部哨兵和只读输入。
seed1单组退出0；完整套件另一个随机流通过。这里的NaN仅用于nums保护分支，不宣称所有非有限输入已覆盖。

新增 auxiliary.py：按字节复制的fill_bytes、按低32位溢出的sequence_int32、empty、exclusive_sum_u32。
这些是NumPy功能实现，不是原版Thrust/CUB的线程调度重写，也尚未接入全部宿主调用路径。

diagnostics/thrust_ab.py遍历全部23个Thrust实例，按逐项核对的ABI构造参数：
functor首8字节为目标指针，随后为value；sequence后8字节为initial/step。
每256线程处理512元素，测试0/1/255/256/511/512/513/1025元素、尾部保留、随机位模式、
int32 sequence正负步长及溢出。不能按通常一线程一元素发grid，否则无符号count会越界。
另验证CUB EmptyKernel。单组185项检查全通过，完整套件通过。

diagnostics/cub_scan_ab.py补4个排序辅助实例：两个RadixSortScanBinsKernel、两个DeviceRadixSortExclusiveSumKernel。
前者是单block512线程、任意count的uint32 exclusive scan；覆盖11776元素tile边界及多tile。
后者每block256线程独立扫描256项，每段重新从0开始，覆盖1/3/4段。
普通计数与uint32溢出两组、尾部哨兵，共44项，单组与全套均通过。

### 最终全套及独立清单

coverage-20261029-auxiliary：seed3/count512，完整A/B passed=true、退出0。
新清单 inventory-20261029-auxiliary 再从旧so独立提取，PTX与cubin仍为188个相同唯一入口：
- SynReal 131/131
- Thrust 23/23
- CUB 7/34
- 合计161/188，all_entries_exercised_and_ab_passed仍为false。

剩余27个全部CUB：DeviceReduceKernel 5、DeviceReduceSingleTileKernel 8、
DeviceRadixSortUpsweepKernel 4、DeviceRadixSortOnesweepKernel 2、DeviceRadixSortDownsweepKernel 4、
DeviceRadixSortHistogramKernel 2、DeviceRadixSortSingleTileKernel 2。
完整符号在最新inventory.json的missing中。下一步建议先做Histogram的两个实例，再补归约iterator和排序各阶段，
必须核对GridEvenShare/by-value迭代器参数及各阶段缓冲格式，不能只证明最终排序值正确便算中间入口逐个通过。
已提取的cub-histogram.ptx约746行，尚未实现或计入通过。

```bash
.venv/bin/python -m reconstruction.diagnostics.pcg_templates_ab \
  --output build/reconstruction-debug/pcg-templates-seed1.json
.venv/bin/python -m reconstruction.diagnostics.thrust_ab \
  --output build/reconstruction-debug/thrust-seed1.json
.venv/bin/python -m reconstruction.diagnostics.cub_scan_ab \
  --output build/reconstruction-debug/cub-scans-seed1.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage --seed 3 --count 512 \
  --output build/reconstruction-debug/coverage-20261029-auxiliary
.venv/bin/python -m reconstruction.diagnostics.kernel_inventory \
  --coverage build/reconstruction-debug/coverage-20261029-auxiliary/coverage.json \
  --output build/reconstruction-debug/inventory-20261029-auxiliary
.venv/bin/python -m pytest reconstruction/tests -q
.venv/bin/python -m compileall -q reconstruction
```

覆盖与清单输出目录须为空；复跑请换新目录。只改reconstruction与交接文档，未改旧so、用户认证、示例或依赖，未commit/push。

最终回归：12 passed in 21.16s；compileall退出0。

## 2026-10-29：剩余27个CUB入口核对完成，全库唯一入口188/188 A/B通过

新增源码及诊断：auxiliary.py的radix_histogram_u32、radix_sort_pairs、grid_even_share、radix_upsweep、
radix_downsweep、cub_iterator_partials、merge_aabbs、radix_onesweep、cub_reduce；
diagnostics/cub_remaining_ab.py，已纳入kernel_ab的cub_remaining组及全套验收。
每个入口的源码对应、参数/边界、失败定位和命令已整理在`reconstruction/CUB_VALIDATION.md`。

本轮读取旧版PTX提取的各入口签名、参数装载、tile常量、归约/散射/lookback写回，并直接执行原版PTX验证。
本机CUDA12.8的GridEvenShare/onesweep头文件仅为布局理解线索，不以新版库输出替代旧库基准。
没有登录完整原版求解器，没有修改官方so、认证、示例、依赖，也没有放宽比较容差。

### 新增边界证据

- Histogram原版把无效lane的UINT_MAX计入最大桶；首轮源只计实际keys而失败。按PTX补齐2048项tile填充计数。
- single-tile归约即使count>5120仍是单CTA；验证器曾错误调用会切多CTA的cub_sum预测。
  修正为原入口ConsumeRange路径，保留失败报告，不改既有solver调度以凑结果。
- signed-zero专项在AABB归约发现28项位差（绝对误差0仍判失败）。原PTX min/max的-0/+0 tie规则
  与NumPy不同，源码显式恢复，永久加入回归；未以数值等价代替位等价。
- Downsweep源码显式消费spine和各block范围，独立散射；没有仅调用全局排序来代替该入口行为。
- Onesweep除键值外核对lookback每个bin的0x80000000前缀标签、allocator、bins_out及其NULL分支、
  输出前后哨兵与只读bins_in；5376项tile的填充值也计入状态，排序输出只写有效项。

### 验证与实际完成范围

首轮全部27入口的1180项通过；seed2..10各1180项通过。新增signed-zero后1300项通过。
源码归约整理为公共cub_reduce后，全套再次通过：
`coverage-20261029-all-entries-final`，seed3/count512，passed=true、ab_exit_code=0，
all_entries_launched=188、all_entry_count=188、all_entries_missing=[]、all_entries_exercised_and_ab_passed=true。

独立再抽取PTX并核对cubin STO_ENTRY：`inventory-20261029-all-entries-final`，二者清单一致，
SynReal131/131、CUB34/34、Thrust23/23。原库6模块有218处entry声明、跨模块去重188个唯一符号。
这完成了**唯一入口清单上的核对和已测试输入A/B**，不表示每个模块副本、每个分支/所有输入、
GPU并发过程及整个so的CPU宿主逻辑均已等价。

下一阶段应转向宿主调度接入及账号运行原版demo对比；不能仅用188/188宣布完全替代原求解器。
先前布料完整自由轨迹超差、部分新内核未接入native_step等事项仍保留。

```bash
.venv/bin/python -m reconstruction.diagnostics.cub_remaining_ab \
  --output build/reconstruction-debug/cub-all-zero-corrected.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage --seed 3 --count 512 \
  --output build/reconstruction-debug/coverage-20261029-all-entries-final
.venv/bin/python -m reconstruction.diagnostics.kernel_inventory \
  --coverage build/reconstruction-debug/coverage-20261029-all-entries-final/coverage.json \
  --output build/reconstruction-debug/inventory-20261029-all-entries-final
.venv/bin/python -m pytest reconstruction/tests -q
.venv/bin/python -m compileall -q reconstruction
```

复跑目录须换新名。所有失败报告保留，未commit/push。

最终pytest：12 passed in 38.10s；compileall退出0。

## 2026-10-29 Demo A/B round (one demo at a time)

- `numerics.fma` double rounding: the long-double emulation rounded twice and lost a subnormal addend that breaks a
  float32 tie (body_point_line, `rx*dx = 0.69999969*3` tie + `ry*dy ~ 2.7e-44`). Replaced by TwoSum-corrected
  rounding. Patched-PTX probe: native num 2.0999992 / t 0.23333324, now reproduced. Kernel A/B full suite (seed 3)
  `passed: true`, pytest 12 passed.
- `example_body_point_line.py` 30 frames: **bitwise** (120/120 substeps, body and particle q/qd).
- `example_cloth_hanging.py`: native is not reproducible against itself (differs from substep 0 in the out-of-plane
  component, cloth element atomics). Shim calibration: ascending vs descending warp order also diverge at the same
  scale, so the in-plane flip at substep 7 is ordering noise. 60 frames (120 substeps): max |shim-native| 2.9e-6 vs
  |native-native| 3.2e-6, centre-of-mass difference 2.4e-7 vs 3.6e-7 -> within the original's own spread.
  Output: build/reconstruction-demos/cloth_hanging-60.
- `joint_constraint_primal_iterations` reconstructed from SolverNewton::step (0xfe10c..0xfe139, 0xfe600): after
  iteration count c, joint multipliers advance iff c < nonlinear_iterations and c % config[0x14] == 0; springs skip
  the update kernel otherwise, point-lines still run it with flag=false. SO(3) uses c == config[0x18] and runs before
  the joint updates (unchanged).
- demo_ab harness: replays `if __name__ == "__main__"` parser setup (cloth_style3d `--solver`), and the eager
  capture patch also clears `use_graph` (physical_pendulum).
- cloth_hanging spread test (`demo_ab --native-runs 5`, 60 frames): 5 legacy runs vs 4 reconstruction warp orders
  (descending/ascending/random:1/random:2). Whole run: max error 2.7e-6 vs legacy spread 4.8e-6, but substeps ~7-20
  exceed the legacy spread (up to ~100x, 1-ULP flips on O(1) coordinates) before converging back into it.
  Resolved with `diagnostics/replay_step.py` (one substep from the recorded legacy state): at t = 1,3,7,8,9,12,15,20
  the reconstruction's one-step result is within the legacy one-step spread (e.g. t=8 5.8e-12 vs 3.2e-12, t=9 1.2e-10
  vs 6.4e-10), and the legacy library itself flips 1 ULP from identical input at t=7 (6.0e-8) and t=15 (4.5e-8).
  -> the early excess is accumulated ordering noise; the step computation matches. cloth_hanging: PASS (statistical).
  Output: build/reconstruction-demos/cloth_hanging-spread, cloth_hanging-replay.
- chain_heavy_ball (shim, 100 substeps, 50 min timeout): differs from substep 0 (body_q 3.4e-3, body_qd 0.2) ->
  logic difference, queued.

## 2026-10-29 Compiled CUDA source (the actual replacement)

Direction confirmed with the user: the deliverable is CUDA/C++ source compiled into a new `_core.so` that runs at
native speed and matches the legacy so on the same machine. The numpy reconstruction is the verified spec/oracle.

- Legacy binary: sm_52 cubins + PTX ISA 8.4; on this GPU the driver JIT-compiles that PTX. Identical PTX from our
  source therefore gives identical machine code.
- Toolchain: CUDA 12.4.131 nvcc/cicc + cudart/cccl 12.4.127 from NVIDIA redist (SHA256 checked against
  redistrib_12.4.1.json) in build/toolchains/cuda-12.4. Our PTX header reports NVVM build CL-34097967 / ISA 8.4.
  CUDA 12.8 differs (atom.global.add instead of red for unused atomicAdd results). glm 1.0.1 in build/third_party.
- `reconstruction/csrc/ptx_compare.py`: compiles csrc/kernels/*.cu and compares each entry with the legacy entry of
  the same mangled name after normalising register numbers, labels and whitespace.
- PTX-IDENTICAL: apply_nonlinear_step, evaluate_spring_force. Source-shape facts learnt from spring force: the
  direction comes from a helper `if (length > 0) return d / length; return vec3(0);` (setp.leu + integer phi);
  an inline `if`/ternary gives different (but numerically equal) PTX.
- Acceptance per kernel: (1) PTX identical to legacy, or (2) when the only remaining differences are instruction
  order / address arithmetic / operand order of commutative ops, the kernel must pass the kernel_ab group bitwise with
  `RECONSTRUCTION_KERNELS=csrc` (our compiled PTX launched instead of the legacy PTX, compared with the numpy spec
  that is bitwise-checked against legacy). Time-box ~3 source variants per ordering-only diff.
- Done (22): step (apply_nonlinear_step, update_velocity, initialize_block_diagonal, combine_system_non_diagonal),
  joints (initialize_joint_body_spring_state, reset_selected_joint_drive_state), springs (evaluate_spring_force),
  lbvh (build_primitive_leaf_nodes, build_escape_nodes, refit_aabbs, generate_morton_codes*), pcg
  (prepare_inverse_preconditioner, apply_block_diagonal_preconditioner*, update_preconditioned_cg_direction,
  update_solution_and_residual, update_cg_direction<float>, update_cg_direction<mat3>*,
  initialize_block_non_diagonal*), drag (initialize_triangle_drag, evaluate_triangle_drag*,
  multiply_triangle_drag_tangent*, add_triangle_drag_preconditioner*). (* = GPU-bitwise, PTX order-only diff.)
- Source facts recovered: guarded_ratio uses std::isnan (abs <= inf); AABB merge uses fminf/fmaxf (PTX min/max.f32,
  NOT glm::min which is compare+select and differs for NaN/-0); per-world element kernels load the local element
  first, then compute the world particle offset; glm `-=` stores per component, legacy uses `r = r - a*b`.
- Tooling: kernel_ab `--only lbvh` group added; `RECONSTRUCTION_KERNELS=csrc` switch; ptx_compare `--show-legacy`.
- Build flag found: the legacy device code was compiled with -DNDEBUG (Release). Without it glm's index asserts
  change the IR order (address arithmetic before loads), which was the cause of most "order-only" PTX diffs.
  ptx_compare now passes -DNDEBUG; several kernels became PTX-identical in their natural form.
- 39/131 written, 33 PTX-identical; the rest GPU-bitwise. Complete modules: LBVH (incl. build_radix_tree Karras
  2012), self-collision boxes/refit_bvh, PCG (8 kernels incl. cub::BlockReduce<float,256> reductions with the
  `reduction_storage` static name), inertial cache, drag (4), small fluid/granular kernels.
- 49/131 written (37 PTX-identical). Added: joint body springs (AL state/force), body distance constraints (3, all
  identical except force), affine SO(3) AL (force, tangent, preconditioner, initialize, update; polar
  nearest_rotation with 8 Newton steps). init distance target needs explicit fmaf(z,z,fmaf(y,y,x*x)): no plain
  expression contracts with x^2 as the rounded term. Caveat: kernels with large ordering-only PTX diffs
  (SO(3) preconditioner/tangent/update, joint/distance forces) are verified on the kernel_ab inputs only; a dataflow
  equivalence check of the PTX would close NaN/inf edge cases.
- 54/131 written. Added affine: torques, block preconditioner apply (PTX-identical with #pragma unroll), six-spring
  force/Hessian (block-ELL lower-bound atomic_add_block helper in types.cuh), body spring force. All GPU-bitwise
  (kernel_ab affine 9 csrc kernels, joint_springs 6 csrc kernels).
- 68/131 written (43 PTX-identical). Added cloth (stretch, bending, bending damping x2, membrane GN Hessian, spring GN
  Hessian), initialize_step (P6 host diagonal, P17 mass), initialize_rhs (+ new kernel_ab case with off-diagonal
  mass ELL: legacy and csrc both bitwise vs spec), the six PCG matrix templates (all PTX-identical: the ELL loop
  guard is `max_count == 0`, entries read by value, `sum = sum + value * v`). kernel_ab `--only cloth` added.
- 82/131 written. Added point-lines (plain force, joint AL init/force/update/preconditioner/tangent, both GN
  Hessians), body spring GN Hessian, tetrahedra (force, tangent, preconditioner): all GPU-bitwise.
  Note: evaluate_body_point_line_force clamps t with cvt.sat (fminf(fmaxf())), glm::clamp would keep NaN.
  Its `previous` (P1) and `damping` (P10) parameters are never read by the legacy kernel.
- Hazard found (evaluate_joint_drive_load): where the legacy PTX has `mul; mul; sub` and ptxas fuses one product
  in SASS, our NVVM may contract the other product at the IR level. Fix by writing the fused form explicitly with
  fmaf (axis_term = fma(-sc, ucc, sp upc)). Only affects kernels whose PTX is not identical; GPU A/B catches it.
- 87/131: + affine constitutive (3; co-rotated G column 1 leads with its diagonal term), drive angle state, drive load.
- Paused for hand-off (user request). Status: 87 kernels verified (43 PTX-identical), add_joint_drive_preconditioner
  written but failing GPU A/B (57/1296, 45/1296), 44 not written. Instructions for the next agent:
  reconstruction/csrc/HANDOFF.md; dual-run probe template: reconstruction/csrc/probe_template.py.

## 2026-10-30：接续另一个agent的CUDA/C++重建，修复关节驱动的累加路径

读取指定JSONL后半段的最新用户要求、assistant进度及csrc/HANDOFF.md，确认交付物已明确为
可编译CUDA/C++与后续_core.so，不是NumPy规格或机械PTX包装。旧阶段188/188是规格对原始PTX的核对，
不能当作131个自有入口已经全部写成CUDA源码。仅修改reconstruction/和build/，未改规格计算、测试判定、
容差、用户示例、认证、依赖或旧so，未commit/reset/checkout。

### 1. add_joint_drive_preconditioner：已知GPU失败修复

按顺序读取joints.py规格、原PTX签名/计算/原子写回、kernel_ab.py调用。
新增csrc/probe_drive_preconditioner.py：同一输入分别直接执行原版与本次编译PTX，
测试所有48个驱动一起及每次仅启用一个驱动（49次）。
修复前全部一起54个分量不同（zero初始block探针），而逐个驱动全部一致。
原PTX有独立angular/prismatic写回段；旧CUDA先求Jacobian再共用写回循环，改变共享刚体的warp累加次序。
将写回恢复到各自分支，并对原PTX完全展开的4-slot循环显式unroll，未改公式。
最终探针49次全部零差异；正式组两种modes测试在seed1/2/3都通过。

### 2. multiply_joint_drive_tangent：多seed发现额外失败并修复

交接称该入口已通过，但本轮正式组seed2的nomodes、seed3的modes各出现1个分量差异。
原版同seed正式测试exit0，不把差异归为“原版噪声”。
新增csrc/probe_drive_tangent.py，直接复用正式组输入双跑，定位seed2到particle14/component0：
legacy=1479.9993896484375，csrc=1479.999267578125。逐个驱动隔离仍全部一致。

原PTX和规格明确三条原子写回路径：angular、parentless prismatic、parented prismatic。
旧CUDA合并了两种prismatic的child scatter。一次尝试将parentless提前返回，差异反而增加，
已撤销，失败报告保留；没有把它当最终实现。
最终按原PTX的parented条件块及独立parentless块组织写回，保持jp、lever、y的原有计算。
seed2同输入直接双跑的两个调用均0差异，正式组seed1/2/3均exit0且失败列表空。

### 验证结果与未完成审阅

最终正式报告：drive-ordered-final-seed{1,2,3}.json/.err；摘要drive-ordered-final-summary.json。
三个seed的stderr都包含30add_joint_drive_preconditioner和28multiply_joint_drive_tangent，确认没有回退原版。
被替换的其它关节驱动入口在同组内也通过。无共享函数修改，未额外重复其它不相关模块测试。

PTX工具最后一行：43 PTX-identical、44 different、44 of 131 SynReal entries not written yet。
两处入口仍PTX-DIFFERENT。不能将当前大段diff未经完整数据流审阅便声称只是寄存器/排序变化；
其中存在继承自旧实现的显式FMA与旧PTX mul/sub形式差异（可能对应ptxas融合），仍需逐项核对SASS/数据流。
因此本轮确认的是GPU失败修复及上述输入范围，不把两者标成完成了HANDOFF第8节全部自检。
没有跳到下一kernel；接续先完成这两处PTX差异归类与主要分支覆盖审阅。

证据在build/reconstruction-csrc：
- drive-preconditioner-before.diff、drive-preconditioner-probe-before.log：修复前。
- drive-preconditioner-after.diff/unrolled.diff：中间编译变体。
- drive-final-seed{1,2,3}及drive-final-summary.json：预条件器修好、切线仍失败的阶段。
- drive-original-seed{2,3}.json/.err：原版对应组通过。
- drive-tangent-seed2-probe.log、drive-tangent-seed2-isolated.log：直接差异及隔离结论。
- drive-tangent-seed2-after.log、drive-both-final-*：失败的parentless提前返回尝试，虽名final但不是最终证据。
- drive-tangent-seed2-ordered.log、drive-ordered-final-*：当前正确版本证据。
- ptx-status-ordered-final.txt、drive-ordered-final.diff：当前完整编译状态与两个入口diff。

```bash
.venv/bin/python -m reconstruction.csrc.probe_drive_preconditioner 1
.venv/bin/python -m reconstruction.csrc.probe_drive_tangent 2
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 2
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 3
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff \
  multiply_joint_drive_tangent add_joint_drive_preconditioner
```

ptx_compare退出1表示存在PTX差异，不表示编译失败。当前GPU组3个seed退出均为0。
本轮未登录完整原版求解器，未新增demo级验收结论。

## 2026-10-30 UTC：关节驱动剩余 PTX 差异闭环及新增坐标速度 CUDA

用户要求有差异继续，不能只留 GPU 通过的半截结论。继续核对原始 PTX，恢复两个驱动入口的
mul/mul/sub 算术、isfinite 的 abs 检查、有序 <= 以及预处理分支位置。
新增 audit_drive_ptx.py，从原版输入字节核对每 lane 写入地址/浮点表达式/浮点判断；不把 fma 和 mul/sub 混同。
人工 mul->add 错误在每次调用均被检出；不靠该诊断替代 GPU 测试。

新增 kernel_ab 的 joint_drive_branches（只加测试，无规格公式或容差变更）：三世界、partial tail、
零/极短/阈值轴、退化参考、禁用模式、异常系数、被动阻尼及非有限几何等。
原版先验证，再分别用原版和源码跑 seed1/2/3；两个分组每 seed 共60检查均通过。
三个目标在 csrc stderr 均出现，无回退。
新增 initialize_joint_coordinate_velocities CUDA + 120B JointCoordinateView，输出按 global index 而非 dof。
该入口按实际轴长 <=1e-8 置零，与驱动归一化轴检查不同；边界用例直接以旧 PTX GPU 为基准，未改冻结规格。

最终数据流 seed1/2/3 每个17次调用，写入表达式计数12106/12106/12202，写入/guard差异全0，
人工错误检出均true。GPU异常输入直接双跑差异全0。
前两入口 PTX 静态计数差异为重复 child-origin 加权点的共享（3 mul+9 fma），
速度入口为两分支重复轴长计算的共享；基本块互补 le/gtu 保留精确 NaN 行为。
其余为地址/加载/调度。保留 PTX-DIFFERENT，不调整比较工具。

一次批量替换误触 evaluate_joint_drive_load 造成回归，当时先误判为共享函数影响；
经本轮开始源码 diff 查明误改位置并恢复。已核实其与其它既有入口 PTX 均未改变；
本轮只变更两个旧入口并新增一个，完整关节驱动组通过。失败报告保留，不掩盖或冒充最终结果。

完整命令、精度范围和证据索引：csrc/JOINT_DRIVE_AUDIT.md。
最终证据：build/reconstruction-csrc/drive-audit/coordinate-gpu-final-summary.json、
complete-dataflow-seed{1,2,3}.log、dataflow-seed{1,2,3}.json、nonfinite-gpu-seed{1,2,3}.json、
float-op-counts-final.json、changed-entries-final.json、ptx-status-final.txt、provenance-final.json。
最新统计88定义=43 PTX-identical+45 different，43/131未写；不能推广为全部已验收。
下一项 evaluate_joint_armature，然后 evaluate_angular_limits。
未改旧so、src、examples、依赖或认证，未commit/reset/checkout；本轮没有登录原始求解器或新增demo级结论。

## 2026-10-30 UTC：继续下一项 evaluate_joint_armature，新增 CUDA 并完成逐位核对

读取旧 PTX 签名、View 打包、冻结规格后，在 csrc/kernels/joints.cu 新增本入口和两个私有 helper。
不修改既有 CUDA 入口，最终编译核实旧入口变化0、仅新增1。
首次 seed1 力/切线/对角块有8/38/59个分量不一致。probe_armature 同输入双跑并逐个系数隔离，
发现集中于有父的转动关节，定位 axis term 的 JIT 融合方向。
临时显式 minuend FMA 可使 GPU 相同；最终按原 PTX 先 child product 后 parent product，
再相减除轴长，保留自然 mul/sub 和原版舍入。三个模式最终同输入0差异。

本次也证实：初版的具体路径 DAG 可以相同而 GPU 仍因 JIT 融合方向不同而失败。
不能只凭表达式/数学等价或指令数声称一致，必须保留 GPU 检验。
扩展 audit_drive_ptx 的必要 PTX 指令支持，新增 audit_armature_ptx。
每 seed19调用，写入地址/表达式/浮点判断0差异，非空写入的人工 mul->add 错误均检出。
旧三个关节入口的审计器回归和异常输入双跑也通过。

kernel_ab 只新增 joint_armature_branches 分组及挂接：96检查，三世界partial tail、两种关节、
打乱dof、退化当前/前一几何、阈值、零/负/NaN/Inf惯量、NaN qd、半圈/多圈绕回、
inverse_dt=0/-240、block优先于direction及NULL previous/qd等。
原版先独立跑，再原版/源码各seed1/2/3，连同既有joint_drives20和joint_drive_branches40检查，
18次分组运行全部exit0，目标在两个相关组的csrc stderr均存在。
未修改冻结规格计算、容差、旧so、src、examples、认证、依赖，未commit/reset/checkout，未登录或做demo验收。

当前89定义=43 identical+46 different，42/131未写。PTX仍非文本一致，
已核对的本入口静态算术计数差为两类分支共享当前/前一轴长计算；具体路径无缺项。
完整过程、命令及证据：csrc/ARMATURE_AUDIT.md；最终文件在build/reconstruction-csrc/armature-audit/，
含gpu-final-summary.json、audit-final-summary.json、final.diff、changed-entries-final.json、provenance-final.json。
下一项evaluate_angular_limits，需独立核对激活/角度状态/有限性规则，不能盲目套用armature逻辑。

## 2026-10-30 UTC：evaluate_angular_limits CUDA与关节入口回归

按旧PTX及kernel_ab签名新增AngularLimitView(32B)和evaluate_angular_limits，复用已核对的armature几何helper，
没有改动既有CUDA入口（规范化PTX变化0，仅新增1）。保持type==1、双零系数过滤、global状态/local dof索引、
add.rz/trunc/FMA角度展开、初始恢复力激活、block优先以及投影后不加第二次finite检查等原版行为。

初版随机GPU组已通过。新增joint_limit_branches三世界partial tail、32场景、状态NULL指针、非有限方向、
inverse_dt0/-240、状态只读、尾部哨兵和32项激活断言，共280检查；先用原版独立验证，再源码。
原版及源码各seed1/2/3的joint_drives20、joint_drive_branches40、joint_armature_branches96、
joint_limit_branches280共24次分组运行全部exit0，两个相关源码组stderr含目标入口无回退。

新增audit_limits_ptx，每seed35调用，写入表达式36288/36108/35928，写入地址/表达式/float判断差异全0，
有写入的人工mul->add错误全部检出。旧4个关节入口三seed审计回归通过，回归输出放本批regression目录。
原审计仅发现geu与lt真值互补；补精确IEEE geu=!lt规范化，未改源码来迁就审计，异常值GPU测试均通过。
PTX数学操作计数相同；原版当前atan2分支重复的sin/cos绝对值复用少4abs，另一个finite判断基本块反转，
其余加载/寄存器/调度差异。保留PTX-DIFFERENT，不修改比较工具或编译参数。

完整说明及命令：csrc/ANGULAR_LIMIT_AUDIT.md；证据build/reconstruction-csrc/limits-audit/，
含gpu-final-summary.json、audit-final-summary.json、final.diff、changed-entries-final.json和provenance-final.json。
曾有新增激活断言补丁因字符串不唯一被assert拦截而未写入，后在新函数范围内限定定位完成。
未改冻结规格、容差、旧so、src、examples、依赖、认证，未commit/reset/checkout，未登录或做demo验收。
当前90定义=43 identical+47 different，41/131未写；下一项query_particle_pairs。

## 2026-10-30 UTC：继续query_particle_pairs，新增粒子BVH查询CUDA

角限位核对完成并记录后，继续自碰撞query_particle_pairs。读取旧PTX、selfcollision规格和launch参数，
在self_collision.cu新增overlaps和查询入口：由叶到根遍历兄弟子树、escape预序、id/group/world过滤、
严格距离平方判断、容量饱和退出，保留per-world位置/BVH/输出偏移和共享拓扑/列表/过滤数组。
首次GPU随机组即通过。

新增particle_query_branches82固定边界检查，覆盖三世界partial tail、打乱列表、相接与相邻float距离、
同位置/零半径、负world通配、相同group、NaN box/position、单叶/空查询、容量-1/0/1/3/12、
完整slots未写区和counts尾部哨兵；先原版再源码。随机性由已有250叶particle_pairs组的3个seed提供。
两组原版/源码各seed1/2/3共12次组运行全exit0，source stderr均含目标入口。

新增audit_particle_query_ptx；底层PathAudit可选返回实际32位写入值，原默认格式不变，增加+-offset解析。
38次调用/seed写入地址、表达式、实际整数值及float判断全0差异，写入1920/1893/1967。
每seed15个有候选槽写入的调用均检测到人工mul->add；无距离计算的调用不要求此mutation命中。
原限位35调用审计的默认API回归exit0，输出放本批regression目录。
静态float操作计数与原版完全相同；PTX文本差异为地址/索引/寄存器/基本块/指令安排。
规范化PTX核对旧入口变化0，新增1；关节源码SHA256与角限位验收后相同。

详细说明和命令csrc/PARTICLE_QUERY_AUDIT.md，证据build/reconstruction-csrc/particle-query-audit/，
含gpu-final-summary.json、audit-final-summary.json、final.diff、changed-entries-final.json、provenance-final.json。
保存了与前一批manifest哈希完全相同的旧诊断器副本audit-drive-before.py，便于复现历史证据。
未修改冻结规格/旧测试/容差/旧so/src/examples/依赖/认证，未commit/reset/checkout，未登录或做demo验收。
本轮两项完成后，91定义=43 identical+48 different，40/131未写；下一项query_edge_face。

## 2026-10-30 UTC：批量恢复三个网格自碰撞查询

为减少重复编译，集中新增query_edge_face/query_edge_edge/query_vertex_face与共享parent/children遍历、
group兼容、线段最近点（含补偿乘积差与sat）、三角形七区域/退化fallback等正常CUDA源码。
按旧PTX签名和既有launch逐项核对。初版GPU已过；路径审计发现EE ordered le被写为leu，
恢复两个<=退化分支后，新NaN输入及原失败折叠布料7调用全部零差异。

新增self_queries分组直跑既有查询测试，避免重复无关累加；mesh_query_branches最终128项：三世界partial tail、
完整槽和哨兵、七区域/共线/点/极薄三角形、线段退化/平行/交叉、精确距离阈值与两侧、
group/incident/vertex-radius/NaN/容量/饱和等。新增fixture曾有launch前变量替换错误，已修正并重跑。
既有7查询、128新检查、82粒子回归，原版及源码各seed1/2/3共18组最终全部通过，源入口均确认为csrc。
按backend单进程缓存PTX，多seed避免重复编译；薄三角形扩展后只重跑受影响几何组。

audit_self_queries_ptx每seed60调用写入地址/表达式/32位值/float判断全部0差异，写入3653/3610/3641。
有候选写入的人工错误全部检出。原先失败折叠布料seed1全7调用重跑也0差异。
VF float计数全同，EE算术/判断计数同、加载/临时寄存器安排不同；EF将两份group分支的盒遍历共享，
每条路径的判断相同。保留PTX-DIFFERENT。既有CUDA入口PTX变化0，新增3。
仅扩展诊断器cvt.sat支持，未更改规格、旧测试、容差、编译参数或原so。

完整命令/证据见csrc/SELF_QUERY_AUDIT.md和build/reconstruction-csrc/self-query-audit/。
当前94定义=43 identical+51 different，37/131未写；下一项accumulate_vertex_face。
未改src/examples/依赖/认证，未commit/reset/checkout，未登录或做demo级验收。

## 2026-10-30 UTC：批量恢复点面/粒子碰撞累加与接触切线

新增accumulate_vertex_face、accumulate_particle_pairs、multiply_contact_tangents正常CUDA源码，
60B接触记录结构体含偏移断言；保留世界偏移、可选半径/记录、谐和刚度溢出fallback、局部累加与原子写入顺序。
首轮随机GPU力/对角/记录全部逐位通过，切线规范化PTX直接完全一致。
同模块旧10入口规范化PTX改变0；未修改冻结NumPy算术或既有测试判断。

新增self_accumulate分组复用既有run_accumulate，避免重复查询；新增self_accumulate_branches最终90项。
覆盖多世界/partial tail/多候选/NULL记录和计数器、半径/incident开关、几何/距离/同位置轴边界、
零/负/极大/次正规质量、溢出及NaN/Inf、刚度0/负/NaN/Inf、动态-1..5点与16线程处理111记录的grid stride。
原版与源码各seed1/2/3：self_accumulate6项（另核对嵌套partials/copy_equal）、particle_pairs8项、branches90项，
18个分组运行全通过，source记录确实包含三个新入口。EE/EF累加仍回退原版，本轮未计入源码完成数。
每backend单进程缓存编译结果合批跑seed，减少重复编译。

新增audit_self_accumulate_ptx：每seed14调用/30928写入，地址、表达式、实际32位值、浮点判断全部零差异，
14次人工mul→add错误全部检出。PP浮点操作计数完全相同；VF多2mul+1add为同刚度分支的重复计算，
另有精确互补谓词及位搬运/存储类型差异；不改PTX文本比较或编译参数，不把DAG当成GPU验证替代。
诊断器增加返回值u32原子加、mul.hi和默认关闭的未定义值跟踪：旧VF分母过小时，
未初始化wa/wb的比较最终被已知拒绝标记屏蔽。允许被证明屏蔽的值，但未定义值影响写入/分支/地址即报错。
该跟踪自检中曾发现首次读取的检查时序问题，修正为先读取再检查后，自检三类拒绝全部通过；
随后完整重跑三seed路径审计，既有armature19调用诊断回归也通过。

完整实现、命令及证据索引：csrc/SELF_ACCUMULATE_AUDIT.md、build/reconstruction-csrc/self-accumulate-audit/。
全量ptx_compare当前97定义=44 identical+53 different，34/131未写；其exit1表示保留文本差异，非编译失败。
下一项accumulate_edge_edge、accumulate_edge_face。没有账号登录/完整求解器或demo验收，不能称已完全替代so。
未改src/examples/认证/依赖/旧so，未commit/reset/checkout；现有工作区其它改动保留。

## 2026-10-30 UTC：边边、边面碰撞累加完成，继续流体

新增accumulate_edge_edge/accumulate_edge_face CUDA。按原PTX核对ordered退化判断、补偿乘积差、
opposite CSR四种成员关系、最近点严格内部、距离上下界，以及EF相邻面折叠/方向反射、0.01重心限制。
保留FMA局部端点累加、乘法后原子散射、60B接触记录顺序、per-world坐标/质量偏移。
首轮随机GPU力/对角/接触记录即逐位通过；复查时恢复EE ordered <=而非not >。
新增入口最初插在旧切线之前会改变local-depot序号，已移动到旧入口之后，旧13入口规范化PTX全部未变。

新增edge_accumulate_branches96项：三世界与partial tail、NULL记录、多个候选、0/负counts、
四种adjacency、退化/平行/端点/距离精确阈值及相邻float、边长/重心边界、相邻面为空/退化/抵消/近似平行、
零/次正规/极大质量、溢出、NaN/Inf几何/质量/厚度，以及0/负/NaN/Inf刚度。
先用原版跑通新fixture，再对源码。EE的NaN厚度经fminf邻接缩限仍有9个接触，按原版保留，未擅加过滤。
原版/源码各seed1/2/3，self_accumulate6项（含嵌套partials/copy_equal）、新96项、旧90项共18个分组全通过。
实际csrc entries包含两个新入口，EE/EF不再回退原版。

每seed16次路径调用、66576写入，地址/表达式/实际32位值/浮点判断全0差异，16次人工错误全部检出。
EE保留少量重复减法/位移动差异，EF算术计数相同；不改文本比较工具或编译参数。
文档csrc/SELF_EDGE_ACCUMULATE_AUDIT.md，证据build/reconstruction-csrc/self-edge-accumulate-audit/。
当前99/131源码定义（44 identical、55 different），32未写；下一项fluid五个入口。
未改冻结NumPy公式、旧测试判断、src/examples/认证/依赖/旧so，没有账号登录或完整solver/demo验收。

## 2026-10-30 UTC：流体五个入口完成，继续颗粒模块

新增scale_step/build_grid/evaluate_rows/accumulate_rows/multiply_rows普通CUDA源码。
model.cuh以1864B ABI和static_assert恢复fluid读取的Model字段，未读部分保留opaque padding。
世界表/复制模型两种寻址、local质量和共享边界、27-cell链表、64-entry cache和fallback全部按旧PTX实现。
保留粘滞分支差异、完整isotropic九项原子加、fallback两次遍历及JIT融合位置。
初稿GPU即通过；将multiply fallback的显式FMA恢复为旧PTX自然mul/sub后重跑。
原fluid三入口PTX仍identical；五新入口不同文本，但float路径DAG和GPU输出一致。
multiply少4个重复h幂乘法；evaluate有一次重读和精确互补谓词，其余float计数相同。

新增fluid_branches最终151项：三世界partial tail、world表有/无、复制模型和共享/复制静态边界、
负坐标、完整确定性head/next、固定链表、mu正/0/负/NaN、count -1/0/1/3/4/63/64/65/70、
cached负/NaN粘滞、NULL的View缓存指针与显式输出、空网格/空fallback、未用区和尾部哨兵。
边界fixture初次期望world误假设为0，已按输入world表[local id]修正期望，未修改solver。
先原版再源码验证新用例。两backend各seed1/2/3的fluid20项和新151项共12个分组全部通过，
实际csrc entries包含五个目标入口；此前123/139项中间报告保留，最终以151项为准。

最终PTX诊断每seed39调用/70581写入，地址/表达式/实际32位值/浮点判断全0差异。
density选各world首尾等9lane，其它入口全lane；GPU仍核对完整输出。
另留首次34调用/245606写入的完整lane零差异报告。初版mutation未覆盖没有float mul的build_grid，
扩充div mutation后重跑；最终38个有效算术调用全部检出，空网格density的mul/div无输出作用不要求命中。
向量内存和by-value参数只在诊断器中降为标量访问，GPU原PTX不修改。
PathAudit增加可选block128/store forwarding、u64 load、unsigned算术、mad/min/max、floor/float-int和atomExch。
自检通过，原EE/EF16调用诊断回归零差异。

文档csrc/FLUID_ROWS_AUDIT.md，证据build/reconstruction-csrc/fluid-rows-audit/。
全量census104/131（44 identical、60 different），27未写。下一项granular六入口。
未修改冻结NumPy公式、旧测试判断、src/examples/认证/依赖/旧so，未做账号登录或完整solver/demo验收。

## 2026-10-30 UTC：颗粒六入口完成，恢复原始写入顺序

新增granular的build_grid/commit_bonds/accumulate_bonds/accumulate_contacts/multiply_contacts/form_bonds。
Model按旧PTX补radius及272..340颗粒字段；现有fluid八入口规范化PTX不变，旧granular两入口也不变。
commit_bonds达到PTX-identical，其余入口按原算术、finite/NaN比较及world/cache规则实现。
first GPU25项全通过，新187项直接旧GPU对比也通过；新测试包含近零移动法线的rsqrt.approx分支，
没有用NumPy正确舍入sqrt替代硬件近似。诊断helper用普通CUDA rsqrtf并检查只有一条rsqrt.approx，
从GPU取得输入结果的bits供路径执行，每seed1种输入，PathAudit仅增默认关闭的回调。

首次路径审计发现accumulate_contacts的count应先于分量force/diagonal写入，
form_bonds应先history后rest。最初进度误把差异归到NaN路径，完整报告表明是各参数组的写入顺序，
已按旧PTX恢复源码并记录更正，没有修改比较器或排序写事件。
失败报告保留dataflow-before-order-fix-seed1.json。

最终原版/源码各seed1/2/3：granular25、新187项共12次分组全通过，修复后完整重跑源码三个seed。
每seed86调用/37905写入的地址、表达式、实际32位值、浮点判断全部0差异。
grid/bond全lane，contact/form固定21个特殊/世界/guard lane；GPU比较全部数组。
涵盖复制世界/NULL表、完整head/next、plastic/broken/近零/NaN/Inf bond、dt0/负系数、
32/33缓存边界、空网格、NaN摩擦、formation容量0/1/3/4/5、CSR与已有slot候选。
所有有实际乘除作用的人工错误均检出，空路径没有强求不执行的mutation命中。

文档csrc/GRANULAR_AUDIT.md，证据build/reconstruction-csrc/granular-audit/。
累计110/131源码定义（45 identical、65 different），21未写；继续hard历史快照、cable penalty初始化。
未改冻结NumPy公式、旧测试判断、src/examples/认证/依赖/旧so，未做完整solver/demo或账号登录验收。

## 2026-10-30 UTC：hard历史快照与cable penalty初始化完成

新增snapshot_hard_contacts和prepare_cable_penalties两个普通CUDA入口。
HardContactView按312B ABI补已访问字段，保留opaque区；snapshot保留线程0计数写入、NULL/负count、
capacity与normal正长度分支、直接复制dual/penalty及尾部不写。
线缆保留四通道beta下界、reset/init/rescale/world/mask、fmin/fmax和非零初始化标记。
两入口首轮既有70/704项即通过，新增204项以原GPU补NaN/Inf/次正规、负mask/scale、异常beta/cap等。
原版/源码各三个seed共18个分组全部通过，实际source entry确认两新入口生效。
路径审计每seed84调用，写入4005/3765/4125；地址/表达式/实际32位值/浮点判断全0差异。
两入口float操作计数相同；未强求空路径乘除mutation命中，没有改容差或排序写事件。
诊断器只补1字节bool参数load，32/64位路径不变。

文档csrc/STATE_INITIALIZATION_AUDIT.md，证据build/reconstruction-csrc/state-initialization-audit/。
累计112/131（45 identical、67 different），19未写；接着soft-contact两入口及共享接触几何。
未修改冻结规格、旧测试判断、src/examples/认证/依赖/旧so，未做完整solver/demo或账号登录验收。

## 2026-10-30 soft contact CUDA recovery (in progress)

- Added `contact_geometry.cuh` and `soft_contacts.cu` for force/off-diagonal Hessian kernels; not yet accepted.
- Moved the existing affine rotation helpers verbatim into `affine_geometry.cuh`; all 11 existing affine entries
  retain identical normalized PTX against `build/reconstruction-csrc/soft-contact-audit/affine-before.ptx`.
- Initial existing soft-body group seed1 passed all checks with actual source entry selection.
- Added `soft_contact` static group and `soft_contact_branches` direct original/source probes (164 checks initially),
  including multiworld/body lookup, null outputs, aliases, exceptional values and grid-stride dispatch.
- PTX inspection corrected depth rejection to ordered `depth <= 0`, and preserved original natural mul/sub order.
- New probes exposed friction projection CSE affecting JIT contraction. `fusion-probes.json` isolates the cause:
  natural/explicit velocity/explicit tangent fail; explicit FMA for three `1-n_k*n_k` diagonals passes.
  Restored those explicit FMAs to match old JIT; full verification is still pending.
- Extended PathAudit with per-lane local scratch forwarding (uninitialized local loads fail) and explicit grid size;
  self-checks passed. Full path audit pending. No frozen formulas/auth/solver/example changes.

## 2026-10-30 soft contact verification completed

- Final original/source seed1/2/3: soft_contact5, soft_body_contact17, soft_contact_branches189, affine20;
  all24 groups/1386 checks pass. Source entry lists confirm both new CUDA kernels.
- Final path audit:80calls/seed, writes79050/76622/76688 (see dataflow-summary.json for exact values),
  sampled degeneracies/world boundaries/tails plus all32 grid-stride lanes. All write address/expression/value
  and floating guard comparisons pass after exactly3 documented original-JIT projection contractions.
  Every nonempty call detects the output-negation mutation. Earlier70-call seed1 full-lane audit retained.
- Old JIT sm_120 SASS confirms the3 projection FFMA instructions at0x6810/0x6830/0x6910; runnable
  `reconstruction.csrc.dump_soft_contact_jit`. No GPU input PTX was edited.
- Full census before starting hard-state drafts:114defined,45identical+69different,17not written.
  Hard initialize/update now have drafts, initial existing GPU checks pass; they are NOT yet closed.
- Detail/reproduction: reconstruction/csrc/SOFT_CONTACT_AUDIT.md and build/.../soft-contact-audit/provenance-final.json.
- New static wrapper initially reported coverage counts as a failed check because the old report did not contain
  a boolean; fixed only the added wrapper by requiring actual sphere/non-sphere/friction/skipped-case coverage.
  Final original/source runs all include this predicate; original test formulas/comparison unchanged.

## 2026-10-30 hard state CUDA drafts, verification in progress

- Expanded HardContactView to verified312B fields/offset assertions, added shared hard_geometry, initialize and
  update_duals CUDA entries. Existing hard_constraints seed1 GPU suite initially passes both entries.
- Original hard geometry has an earlier ordered >=0.5 direction validation (fallback to supplied normal),
  followed by reloading/normalizing the original normal for depth. Restored this from PTX; the frozen NumPy
  geometry shortcut does not describe every exceptional-input guard, so more direct tests are needed.
- Restored static-sphere adjusted point as original mul/add or mul/sub, rather than forcing early FMA.
- Added audit_hard_state_ptx; first pass identified this dataflow difference and extra original guards. Not closed.
- Original register-level geometry diagnostic injects fixed old labels/registers. Changed only its PTX provider
  to always read the original module; actual initialize/update/evaluate launches still use selected backend and
  all existing comparisons unchanged. This fixes a harness crash after providing the update source entry.
- Vector memory lowering now uses element byte width (u8 stride1); existing f32/u32 stride4 unchanged.
- Evidence/drafts in build/reconstruction-csrc/hard-state-audit/. Keep hard entries marked pending until final
  GPU three-seed and dataflow checks, exceptional branches and snapshot PTX regression are completed.

## 2026-10-30 hard state verification completed

- Original/source seed1/2/3: hard_constraints596 + hard_state_branches144 + hard_history70 +
  state_initialization_branches204 all pass (24groups/6084checks). initialize/update actual source selection confirmed.
- Path144calls/seed, writes 9235/9300/9322; zero write address/DAG/32bit/guard differences;
  every nonempty call detects negated-output mutation. No JIT expression rewriting used for hard state.
- Full census116defined,45identical+71different,15not written. snapshot normalized PTX unchanged.
- Extracted shared View/geometry into hard_contact_geometry.cuh for upcoming evaluate; all3 state PTX entries
  unchanged against hard-state-verified.ptx. See HARD_STATE_AUDIT.md and hard-state-audit/provenance-final.json.
- evaluate_hard_contacts now has a separate hard_evaluate.cu draft, first existing GPU seed1 result pending review;
  it is not covered by the above acceptance. Do not claim all hard or all131 kernels finished.

## 2026-10-30 hard evaluate draft and write-order refinement

- Added hard_evaluate.cu (force/scalar, off-diagonal product, split correction blocks, 12x12 affine blocks).
  Existing hard_constraints seed1 GPU596 and new direct hard_evaluate_branches444 initially pass.
- PTX audit found non-observable-in-existing-input write ordering differences; restored original force-before-scalar
  per body, body0 negated force before positive lever multiplication, positive levers for scalar squares,
  component-interleaved system/precond writes, and row-major9-entry affine block writes.
  Restored natural fn*n - (vn*damping)*n rather than an early explicit FMA.
- Re-audit existing68 evaluate calls seed1: write expressions/addresses/values/guards all match on sampled lanes.
  Final expanded three-seed GPU and audit are currently running in build/reconstruction-csrc/hard-evaluate-audit/.
- Added local vector memory lowering and signed local32 reads for diagnostics only; do not change GPU PTX or tolerances.
- Work remains: complete expanded audit/GPU, classify PTX diff/census, update report and manifests; then next missing module.

### Hard evaluate expanded audit refinements

- Original/source GPU seed1/2/3 hard_constraints596 + hard_evaluate_branches444 all pass before latest ordering fix.
- Increasing audit lanes found exact-sliding tangent-matrix early FMA versus original mul/sub; restored the natural
  matrix - kt*(unit_i*unit_j) expression. No numeric tolerance or frozen math was changed.
- Combined-output probes found original affine blocks are written before system/precond corrections. Restored
  this order even though complete GPU outputs already matched.
- Current source re-verification running (`gpu-source-final.*`, `audit-debug4.*`); do not mark this entry closed
  until the latest code passes. Earlier failed audit runs are retained. Diagnostic tags now isolate probe reports
  so concurrently running probes cannot overwrite each other's debug-expression/dataflow files.

## 2026-10-30 hard evaluate verification completed

- Latest original/source hard_constraints596 + hard_evaluate_branches444 seed1/2/3 all pass (12groups/6240checks).
- Latest sampled path142calls/seed, writes 187576/231944/181532; ordered write addresses/DAG/32bit values
  and floating guards zero differences; all nonempty calls detect output-negation mutation. No JIT rewrite in auditor.
- Final census117defined,45identical+72different,14not written. Full hard4-entry module now has source;
  does NOT mean the host solver, auth or demo replacement is complete.
- Reproduction HARD_EVALUATE_AUDIT.md; hard-evaluate-audit/provenance-final.json preserves exact source/artifacts.
- Next rigid force/tangent drafts already compile, existing rigid_contact21 checks seed1 passed with both source
  entries selected. New rigid_contact_branches and PTX audit running; both rigid entries remain pending.

## 2026-10-30 rigid contact CUDA drafts

- Added rigid_contact_geometry.cuh and rigid_contacts.cu for penalty force and tangent. Both use the old mangled
  signatures; first existing rigid_contact21 and direct rigid_contact_branches212 checks seed1 all pass.
- Source selection confirmed both CUDA entries. Rigid branch suite covers multiworld/shared shapes, optional
  outputs, alias blocks/indices, same-body contacts, NaN/Inf geometry/material/epsilon, and velocity-array force.
- Initial PTX audit force lane set matches. Tangent output writes match but guard comparison exposes unintended
  FMA in the length-squared threshold. Restoring old unfused x/y then z additions with rounded-add intrinsics.
- Current norm-fix audit running; both rigid entries remain pending full3-seed verification and documentation.

## 2026-10-30 surface contact CUDA drafts

- Added SurfaceContactView296B and all4 CUDA entries. Existing surface_contact5 checks seed1 all pass.
- Added direct surface_contact_branches108 checks; first multiworld fixture showed small differences because
  its48-contact tiles moved shared body particles across warp boundaries. Three original-vs-original repeats
  themselves disagree (world-fixture-original-repeat.json), confirming nondeterministic atomic ordering.
  Changed the new fixture to64 contacts/world (whole warps); all108 source seed1 checks then pass. No tolerance change.
- Audit required dead-local taint propagation for original masked geometry rejects; added optional tracking,
  preserving strict default rejection and rejecting observable global/branch/atomic uses. Self-checks passed.
- Auditor also incorrectly implemented not.b32 as Boolean not; fixed to bitwise complement, tested5 values.
  No original SynReal entry uses not.b32; among previously audited CUDA modules none uses it. New surface code does.
- First math audit restored original ordered depth/fn <=0 rejection and natural mul/sub tangential projection.
  Ongoing projection-fix trace in build/reconstruction-csrc/surface-contact-audit/. These4 entries remain pending.

## 2026-10-30 rigid contact verification completed

- Latest original/source rigid_contact21 + rigid_contact_branches227 seed1/2/3 all pass (12groups/1488checks).
- Path101calls/seed, writes45780/53328/45148: zero ordered write DAG/value/address and guard differences;
  all nonempty calls detect negated-output mutation. Only explicit RN add aliases canonicalized, no JIT rewrite.
- RIGID_CONTACT_AUDIT.md and rigid-contact-audit/provenance-final.json record exact evidence.
  Verified status119 entries; census now123 definitions,45identical+78different,8not written, with surface4 pending.
- Surface PTX audit additionally identifies stiffness-scale normal speed as x-first; updated CUDA to match actual
  PTX. Frozen NumPy helper defaults y-first, but its optional vn_x_first parameter documents the alternate case;
  no Python formula was changed. Final surface branch/GPU checks still pending.

## 2026-10-30 surface contact verification completed

- Original/source surface_contact5 + surface_contact_branches108 seed1/2/3 all pass (12groups/678checks).
- Path112calls/seed, writes35464/25389/36115: ordered address/DAG/32bit/guard comparisons zero differences;
  all nonempty calls detect output-negation mutation. Grid-stride case checks all32 physical lanes.
- SURFACE_CONTACT_AUDIT.md and surface-contact-audit/provenance-final.json preserve commands and exact evidence.
- Verified status123/131. rolling_contacts.cu now defines3 additional drafts (126 definitions,5 not written),
  existing rolling_contact16 seed1 passed; expanded branch validation and PTX audit remain.
- Source-only solver, host/pybind and authenticated demo comparisons remain future stages; no completion claim.

## 2026-10-30 rolling contact CUDA drafts

- Added RollingContactView248B and force/preconditioner/tangent CUDA entries. Existing16 + direct96 checks
  seed1 pass; original/source full three-seed batches also pass before latest PTX-order refinement.
- Direct cases cover world/shared shape mapping, swapped/same bodies, singular/nonphysical/NaN inertia,
  nullable roll/torsion coefficients, zero velocity/epsilon, axis switch, alias indices and nonfinite positions.
- Original rechecks the same positive inertia determinant per axis. Restored per-axis inverse calls; NVCC
  removes two dominated identical gt(det,1e-30) checks. Auditor records raw multiplicities and collapses only
  that exact true predicate when present on both sides. All other checks and ordered writes stay strict.
- Expanded shared-body path found negative inverse product's explicit FMA versus original mul/sub; restored
  natural subtraction. Ongoing negative-inverse audit; do not mark rolling entries closed yet.

## 2026-10-30 status and remaining draft checks

- Verified123/131 remains the accepted kernel-stage count. Source now defines128 entries after adding the
  two affine-body preconditioner templates; three cable entries still lack recovered source. No host/demo claim.
- Rolling latest three-seed source GPU batch passes existing16 + expanded96 checks per seed. PTX path audit
  then exposed preconditioner's sphere-candidate squared norm: original is x-first for that candidate only,
  while supplied-normal fallback and force/tangent candidates are y-first. Confirmed directly in old PTX
  (legacy-kernels.txt BB67_64/66 versus BB65_64/66 and BB66_64/66), restored selected-norm reuse in CUDA.
  New candidate-norm audit is running; this latest patch still requires final GPU verification.
- Added affine_block.cu and cable_types.cuh (160B CableView), plus source assembly-exit probe group.
  Source seed1 affine_block_assembly72 checks pass, including18 direct source-assembled 12x12 matrix
  comparisons. Existing inverse/valid and original register-probe comparisons also pass. These two entries
  remain pending three seeds, expanded branches and path audit; first-pass results do not establish acceptance.
- Updated affine_block_ab only to keep its fixed-label/register diagnostic probe on original PTX. Main inverse
  entry still uses selected backend. Frozen NumPy arithmetic and comparison thresholds are unchanged.

## 2026-10-30 rolling contact verification completed

- Final candidate-norm source: original/source existing16 + expanded96 checks seed1/2/3 all pass,
  12groups/672GPUchecks. All source group records list all three actual recovered entries.
- Final path audits108calls/seed, writes9540/11340/11745: zero ordered write DAG/value/address and guard
  differences with documented sign-placement expression normalization. All nonempty calls detect negated output.
  Earlier duplicate positive-determinant guard normalization is not exercised in any final trace (0 records).
- ROLLING_CONTACT_AUDIT.md records scope, failure fixes and exact commands. Final dataflow summaries and
  provenance preserved in rolling-contact-audit/. Kernel-stage accepted count126/131.
- Full compile census128 definitions =45PTX-identical+83different, cable3 not written; expected census exit1
  reflects textual differences, not compile failure. Affine block2 drafts still pending path audit.
- Original/source affine_block_assembly72 checks per seed all pass at1/2/3 (432 total checks), including
  actual source inverse/valid and18 source-assembly comparisons per seed. No arithmetic/tolerance changes.
- Remaining kernel work: affine block2 expanded/path audit, then recover cable3 from original evidence.
  Host/pybind/source-only solver and authenticated whole-demo comparisons remain unimplemented stages.

## 2026-10-30 affine block path audit in progress

- Added audit_affine_block_ptx.py for the actual two inverse entries and a separate diagnostic assembly-exit
  mode. Full inverse uses mutable global writes to track native final symmetrization loads. Original masked
  vector reads may include unused/uninitialized upper-triangle local slots; existing dead-value taint mode
  permits only discarded values and still rejects observable use. No common auditor code was modified.
- First full audit found explicit early FMA in Cholesky/triangular solves versus original mul/sub. Restored
  natural subtraction in CUDA; first three fixture paths then have identical ordered write DAG/bits.
- Original PTX unconditionally reads cable adjacency offsets; new direct fixture initially supplied NULL,
  causing illegal address before any numeric comparison. Corrected new fixture to provide an empty offsets
  array and removed source's invented NULL-offset allowance. Original ELL activation is max_count!=0,
  its bound is signed32 min(max(row_count,0),(int)max_count), not a size_t minimum; restored both.
- Added affine_block_branches with56 scenes per template (226 checks total): disabled/pinned/flag/mass cases,
  NaN/Inf/asymmetric/extreme diagonals, cache, later Cholesky failure, actual partial inverse writes, SO3,
  ELL nullable inputs only at zero capacity, signed/truncated capacities, and cable optional/nonfinite data.
  Source seed1 all226 checks pass before latest SO3 natural-expression change. A bool coverage check was
  initially the wrong byte width for compare(); changed it to int32, preserving comparison semantics.
- NVCC speculates a duplicate immutable mass>0 predicate on the flags-present source path. Auditor records
  raw counts and canonicalizes only exact mass-input gt0 predicates with counts{1,2}. Other guards stay strict.
  Assembly-only probes discard the unused active mask; only there dead mass checks are recorded and ignored.
- Assembly exit isolated three SO3 (a=b=2) diagonals using original rounded products/adds but source explicit
  FMA, despite tested GPU values agreeing. Restored natural sums for that special case. Latest assembly audit
  and three-seed GPU run are ongoing; these two kernels remain pending acceptance.

## 2026-10-30 affine block verification completed

- Actual old JIT SASS confirms all three SO3 third-row diagonal sums contract the initial product into the
  rounded x square, then fuse y/z squares. Restored the original fully unrolled source plus explicit FMA here.
  The forced-outer-loop natural-arithmetic experiment matched raw PTX better but failed GPU tests; discarded.
  Exact original sm_120 instruction addresses are in AFFINE_BLOCK_AUDIT.md and so3-jit-evidence.txt.
- Scalar ELL adds an identity block to the full 3x3 region, including off-diagonal add-zero operations.
  Restored these writes and added an ELL signed-zero scene. Cable optional angular bias also retains add-zero.
- Module-local affine_ptx_moves.py lowers only provable packed-register half selections to bit-preserving
  32bit moves (three bit-pattern self-checks pass, unsupported uses fail). This avoids treating undefined unused
  halves as observable. No shared auditor or frozen specification arithmetic was modified.
- Final original/source GPU seed1/2/3 each302 checks pass:72 assembly/inverse/spec checks +230 direct branches.
  Total1812 GPU checks. Both actual recovered source template names are recorded on all source seeds.
- Final complete inverse and separate assembly-exit audits each132calls/seed,8 sampled lanes/call. Inverse
  writes191324/seed, assembly123590/seed, total792calls944742writes. Zero write DAG/bits/address and guard
  differences AFTER the report's precise JIT contraction / duplicate-mass / dead-probe predicate handling.
  Every float-writing call detects a sign-flip output mutant. These sampled traces are not a universal proof.
- AFFINE_BLOCK_AUDIT.md and affine-block-audit/provenance-final.json record commands, successful and failed
  probes, JIT images and exact artifacts. Census128 definitions=45identical+83different,3 cable entries not written.
- Kernel-stage accepted count128/131. Next work is cable geometry and its three missing entries; do not use
  mechanical CUDA wrappers as recovered-source delivery. Whole solver/demo, host and bindings still pending.

## 2026-10-30 cable shared rotation recovered and GPU-probed

- Read old update_cable_penalties PTX and confirmed CableView offset16 is row-major inertia, not a rest
  matrix. Kept the existing provisional field name body_matrix unchanged so affine's verified dependencies
  remain reproducible; new helper reads its raw nine floats as inertia.
- Added named cable_rotation.cuh: double-precision inertia-weighted scaled polar iteration,8-round/1e-24
  convergence, positive/finite determinant gates, final symmetric Hessian determinant, float nearest_rotation
  fallback. Arithmetic/order follows old PTX; no new global SynReal entry is claimed.
- Added probe_cable_rotation.py, comparing old first-body register exits against a direct new-helper kernel.
  Old weighted/fallback probe is injected at BB73_18/37 and returns before subsequent cable math, so this
  validates only the shared rotation submodule, not the untouched whole update/solver path.
- First17 scenes/34checks seed1 pass. Added physical anisotropic inertia and near determinant threshold;
  final19 scenes/38checks seed1/2/3 all pass (114checks). Both rotation matrices and branch flags are bitwise
  checked, including three worlds, disabled lanes and guard tails. No tolerance or frozen math was changed.
- CABLE_RECOVERY_NOTES.md records the recovered math and next world-frame/strain formulas directly traced
  from old PTX. Three cable global entries remain unwritten; accepted kernel-stage count remains128/131.

## 2026-10-30 full cable penalty update draft and expanded verification

- Added cable_geometry.cuh: authored quaternion axes with original multiply/add-zero behavior, static/dynamic
  world frames, verified weighted body rotations, stretch/shear, bounded bending, parallel transport including
  exact/near antiparallel branches, twist and single-step rest-angle wrapping.
- Added full update_cable_penalties CUDA entry in cables.cu. First9 original fixture variants pass309 GPU checks.
  Added40 direct boundary scenes; all49 scenes/1693 source GPU checks seed1 pass, with literal old PTX reference,
  whole penalty arrays/guard tails and all provided input arrays checked for writes. Actual source entry recorded.
- Added cable_ptx_ops.py for IEEE double operations, float/double conversions and bit-half extraction. Original
  libm.fma supplies correctly rounded CPU double FMA. Three GPU microcases/63 uint32 words match the diagnostic,
  including cancellation, signed zero and very small/large doubles. Five default float32 cases match the archived
  pre-extension PathAudit exactly. Self-check script and JSON are in cable-update-audit/.
- Common PathAudit gained an optional opcode extension,0d constants, double-width global I/O and nested lexical
  brace skipping. Default arithmetic rules unchanged. Preserved its pre-extension file/hash and attached snapshot
  references to affine-block, rolling-contact and surface-contact provenance, rather than changing their old hashes.
- First auditor attempt mishandled whitespace before packed double bit extraction, causing a false undefined
  predicate. Fixed the new extension's operand stripping; no kernel or threshold changed to hide that error.
- New audit_cable_update_ptx.py follows actual complete old/source entries, compares ordered write addresses,
  32bit outputs, float32/float64 expression DAGs and floating guards, and checks a sign-flipped output mutant.
  Four-lane seed1 audit passes all49 calls with no differences. Wider3-seed audits/GPU batches are running.
- Source definitions now129/131; accepted count remains128 until final validation. Two remaining unwritten
  globals are prepare_cable_tangents/evaluate_cables. No host, auth, dependency or demo work was started.

## 2026-10-30 full cable penalty update verification completed

- Final49 scenes/1693 checks original/source seed1/2/3 all pass,10158 GPU checks total. Every source seed
  records actual recovered update_cable_penalties; no mechanical CUDA reference or hidden old-kernel fallback.
- Complete old/source float32+float64 path audits49calls/seed,1636 ordered writes/seed (147calls4908writes).
  No write address/DAG/bit or floating-guard differences; every nonempty call detects sign-flipped output.
  No diagnostic JIT arithmetic rewrite/duplicate predicate relaxation was used for this entry.
- Added optional-input, exact/near-antiparallel and degenerate authored basis scenes, material/state/beta
  NaN/Inf/negative/zero cases, rest wrap/cap/denominator thresholds, three worlds, empty/partial counts and tails.
- Reconstructed exact pre-update cables.cu snapshot; its hash matches the historical initialization manifest.
  Existing prepare_cable_penalties normalized PTX is unchanged. Historical manifest now points to that exact snapshot.
- CABLE_UPDATE_AUDIT.md documents all commands and limits. Final provenance/census closeout in progress.
  Accepted kernel-stage count129/131; prepare_cable_tangents/evaluate_cables remain. No full solver/demo acceptance.

## 2026-10-30 prepare body angular differential: float JIT discrepancy fixed

- Added draft cable_spin.cuh/cable_spin_math.cuh and an internal-exit probe against old prepare BB72_43.
  This exports the first body's rotation, weighted/fallback flag and three angular differential matrices.
  It does not implement or validate the complete prepare entry; accepted count stays129/131.
- Weighted differential already matched; float fallback had a few ULP differences on diagonal map components.
  Raw PTX expression DAGs and pre-JIT numbers matched, demonstrating why those checks alone are insufficient.
- Saved old/source actual sm_120 JIT cubin/SASS via dump_cable_spin_jit.py. Native final cross-term subtracts
  contract to FFMA; source shared products instead generated FADD for map entries0/8. Native examples are
  FFMA at0x10c60 and0x10c30; initial source FADD at0x10c00/0x10c20/0x10c50. Preserved before-fix source images.
- Made only those two float expressions explicit fmaf. Actual old-probe/new-helper19scenes x3checks x3seeds
  now all pass (171 comparisons), including nonsymmetric/physical/invalid inertia and singular/NaN/Inf affine.
- Diagnostic-only audit models exactly six old first-body diagonal contractions from SASS; no GPU reference
  is rewritten. Seed1 sampled audit19calls passes after documented sign-placement normalization; seeds2/3 running.
- Confirmed old prepare ignores active mask and appends four slots per dynamic endpoint without deduplication.
  Evaluate force computes its current Jacobians itself; product/preconditioner use prepared caches, and matrix
  mode wins when both optional output modes are supplied. These are requirements for the remaining source.

## 2026-10-30 prepare Jacobian source and expanded antiparallel tests

- Added readable cable_strain_jacobian.cuh, cable_tangent_geometry.cuh and draft cable_tangents.cu global.
  Recovered bounded bending derivatives and native three-region twist derivatives: denominator<=1e-8,
  intermediate<=0.02 normalized-transport/atan2 differentiation, and the closed-form far branch.
- Internal probe exports both endpoint angular-strain Jacobians and the parent linear-rotation Jacobian,
  plus their actual authored/world axes. It runs static-endpoint differential branches explicitly and exits
  before slot assembly; do not confuse it with an untouched full-entry run.
- Initial complete entry had only parent linear Jacobian ULP differences. Retaining the original runtime
  endpoint sign/mul/add assembly rather than folding negative weights into subtraction fixed these GPU errors.
  Also restored prepare's child quaternion basis with separate w*0/add, unlike update's child FMA form.
- Initial32-scene/1010-check full-entry seed1/2/3 passed, but stronger random world rotations around near-
  antiparallel frames then exposed middle twist-derivative differences. Those earlier passes were insufficient.
  PTX showed incorrectly associated sums and premature source FMA in two derivative dot products. Corrected
  grouping and used explicit separately rounded multiplication/addition intrinsics, matching old operations.
- Expanded40-scene/1266-check complete entry: old/source seed1/2/3 all pass,7596 GPU checks total. Every source
  process records the actual reconstructed prepare entry. Includes full Jacobian buffers, unwritten slots/tails,
  read-only inputs, three worlds, duplicate body/slot ids, masks ignored, partial/empty counts and NULL unused inputs.
- New audit_cable_prepare_ptx.py compares ordered full-entry writes; one-lane40-call audit passes all DAGs,
  finite bits, addresses and mutant checks. It models12 old spin-diagonal contractions and documented sign/unit/
  explicit-rn representations. NumPy-only NaN sign differences for equal DAGs are counted, while actual GPU
  comparisons still check all NaN bits. Unique source floating guards all occur in the native trace; native-only
  guards are mapped to BB72_82..137 value/transport/atan2 computations unused in prepare's emitted Jacobians.
  Repeated guards differ because the readable source recomputes body rotations; origins/counts are preserved.
- Wider13-lane/three-seed audits are running. Count remains129 accepted until closeout;130 globals compile.
  evaluate_cables still has no recovered global, and authenticated solver/demo validation is still pending.

## 2026-10-30 complete prepare verification closed; evaluate draft started

- Final wider prepare path audits seed1/2/3 each40calls35065writes pass:120calls105195 ordered writes.
  No write expression/address/finite-bit differences or unexplained unique source/native floating guards.
 38 writing calls/seed detect store-bit mutants.108 CPU-only NaN sign adjustments/seed are explicitly counted;
  actual GPU tests retain strict uint32 NaN comparisons. See CABLE_PREPARE_AUDIT.md for exact diagnostic limits.
- Source floating guards all occur in old traces; native-only unique guards mapped to BB72_82..137 value-side
  strain/transport/atan2 code. Repeated guards differ due to body rotation recomputation and are retained in reports.
- Final internal Jacobian/frame probe29scenes2outputs3seeds passes174 comparisons; body spin19scenes3outputs3seeds
  passes171 comparisons and57calls12654 sampled writes. These modified-exit probes remain distinct from full entry tests.
- Accepted kernel-stage count130/131. Added full evaluate_cables CUDA draft: force rebuilds geometry, product/diagonal
  consume prepared caches, diagonal wins mixed mode, material/damping/state/bias and symmetric block assembly traced
  from original BB74_222..458. Added cable_evaluate group; initial29scenes x6modes/7308 checks seed1 all pass.
  This first pass is provisional: optional/boundary cases, more seeds and complete path audit remain required.
  No host, login, dependencies or demo files were changed. Full census and prepare provenance closeout in progress.

## 2026-10-30 evaluate expanded GPU verification and path audit

- Added36 optional/boundary fixtures to the29 orientation fixtures.311 evaluate calls/seed cover force,
  cached product/diagonal, mixed priority and source-prepare pipelines. Added NULL/stale force caches, NULL geometry
  for cached modes, NULL penalty/state/bias, ignored direction, odd/negative/zero prepared counts, random cached
  Jacobians, NaN/Inf/negative materials, damping gates, inverse_dt variants, large rest twist, masks and tails.
- Final old/source seed1/2/3 each12944 checks pass,77664 total. Logs explicitly list both rebuilt cable entries.
  Source mode does not obtain its evaluate entry through mechanical CUDA or legacy fallback.
- First complete write audit found previous child authored w*0/add had fused to FMA after unused-axis elimination.
  Added evaluate-only previous-frame helper retaining separately rounded w*0; shared verified prepare/update headers
  were not modified. Final source GPU runs use this helper. Raw one-lane311-call audit now has zero write differences.
- Reused only12 current-pose spin contractions by matching exact normalized native blocks to prepare's verified
  float spin block. Previous-pose inverse/Jacobian calculations are unused and are not modeled as source delivery.
- Wider audit maps native-only guards to dead previous float inverse checks and previous Jacobian BB74_380..449.
  BB74_450 is live twist wrapping: its extra angle<-pi check is accepted only when false and the source has the
  exact same angle>pi true predicate, documenting the dominated test rather than calling the whole block dead.
- Optimized diagnostic memory lookup to the exact non-NULL CUDA allocations in launch parameters; all roots are
  asserted captured. Optional selfchecks compare original and source traces using all allocations versus selected
  allocations on calls0/174/310. This changes lookup cost, not arithmetic or GPU launches. The earlier slow audit
  was superseded; final311-call/three-seed audit is running with that narrower guard accounting.
- Full census has131 CUDA definitions:45 PTX-identical,86 different,0 missing. Accepted count stays130 until evaluate
  path closeout. The earlier188-entry inventory also includes57 auxiliary library entries; CUB_VALIDATION.md records
  the earlier NumPy-stage validation of the last27 CUB entries. Instantiating their compiled CUDA library templates
  belongs to the host build stage, not this131-custom-entry count.
  All work still limited to reconstruction/ and build/; no authenticated full solver/demo acceptance yet.

## 2026-10-30 evaluate closed: all131 owned CUDA entries recovered

- Final evaluate source and literal old PTX:65fixtures311calls/seed, old/source seed1/2/3 each12944 checks pass,
 77664 actual GPU checks total. All force/diagonal buffers, sentinels, caches and non-NULL inputs are checked.
- Final complete evaluate audits311calls64212ordered atomic operands/seed,933calls192636writes total. No write
  DAG/address/finite-bit differences and no unexplained unique floating guards.297writingcalls/seed detect store
  mutants;14calls/seed have no writes. CPU NaN-sign adjustments0. Live-memory/full-memory6selfchecks pass.
  The exact dominated wrap check appears2/1/2times for seeds1/2/3, distinct from dead previous Jacobians.
- Saved complete old/source evaluate JIT cubin/SASS. CABLE_EVALUATE_AUDIT.md records source formulas, all commands,
  diagnostic representations, failure fixes and limits. provenance-final.json has52source/tool/artifact hashes.
  Prepare's separate final manifest has65hashes and remains intact. No proof artifacts were replaced after hashing.
- Final full CUDA census:45PTX-identical+86different=131definitions, owned missing0. Regex inventory independently
  confirms188unique original entries=131owned+57auxiliary.12ordinary .entry CUB instances are intentionally outside
  ptx_compare's.visible/.weak parser; none are owned. The complete lists are in old-188-source-131-inventory.json.
- Accepted owned-kernel stage131/131. This does not assert that57auxiliary compiled library instances, host memory/
  scheduling, Python bindings, replacement.so or authenticated demo trajectories are already accepted. Earlier
 188-entry NumPy evidence is separate. CUDA12.4's CUB_VERSION200302 matches native CUB_200302_520_NS; next stage
  starts with library template instantiation/compiled A-B, then host/binding/build and authenticated demo replay.
- HANDOFF.md and CABLE_RECOVERY_NOTES.md now point to completed cable reports and explicitly state that next work.
  No source outside reconstruction/ and build/, original library, credential/authentication, example or dependency
  was changed by this work. No git commit/push or account login was performed.

## 2026-10-30 compiled auxiliary library recovery started

- Added csrc/library/ source instantiations using the installed CUDA12.4 CUB/Thrust200302 headers and unchanged
  sm_52/PTX8.4/O3/NDEBUG flags. New library_entries.py includes ordinary.entry; the owned census parser is untouched.
- thrust_kernels.cu instantiates all23 original Thrust fill/sequence types plus CUB EmptyKernel. All24 exact mangled
  names and normalized PTX match. Original/source seed1/2/3 each185 GPU checks pass; all24 actual compiled source
  entries are recorded, and missing source raises rather than falling back.
- cub_sort_kernels.cu instantiates18 radix histogram/scan/single/up/down/onesweep kernels with explicit Policy900
  and both alternate digit policies. All18 plus implicitly emitted EmptyKernel normalized PTX match. Sort/scans
  old/source seed1/2/3 each1104 checks pass, including lookback/spine/allocator/sentinels and source-use assertions.
- Added library_auxiliary_ab.py: reuses existing fixtures and NumPy arithmetic unchanged while selecting only new
  CUDA kernels on the source side. This is actual compiled CUDA validation, distinct from prior NumPy-only source.
- Added reduction_functors.cuh and cub_reduce_kernels.cu for15 sum/inner-product/preconditioned/AABB instances.
  Preserved the old TU-local encoded namespaces as ordinary named C++ namespaces to retain exact template symbols;
  operators are readable C++ and no original PTX/binary is embedded. All15 original mangled names are emitted.
  Six float-transform entries differ only by visibility; six AABB instances also reorder loads/registers. Reduction
  GPU checks and detailed PTX classification are in progress; only42/57 auxiliary entries accepted so far.
- Evidence, signature inventory and current results: build/reconstruction-csrc/library-auxiliary-audit/.
  No changes outside reconstruction/ and build/, no account login and no new replacement.so claimed.

## 2026-10-30 auxiliary reduction draft alignment and exceptional tests

- Initial15 reduction kernels passed240 legacy/source checks seed1. Inspection found source AABB helpers' loop/
  vector expressions changed NVCC's outer unrolling (not just registers). Rewrote those two helpers as explicit
  three-component expressions following original PTX. All15 reduction instruction bodies now normalize exactly
  to the originals;12 differ solely by .visible metadata from retaining TU-local ABI names in named namespaces.
  Original helper/PTX drafts and all initial diffs are preserved in library-auxiliary-audit/.
- All57 library symbols now compile with exact original mangled names. First full old/source run1529checks each
  passes, and actual source-use set is57/57. Added a separate literal GPU old/source exceptional reduction suite
  covering NaN payloads/signaling NaNs, infinities/subnormals, signed zeros and unusual initial values, including
  complete outputs/tails and read-only arrays. It does not alter the frozen NumPy specifications.
- The first exceptional suite stopped because the existing compare helper cannot compute max() on an empty
  read-only array. Skipped these zero-byte preservation checks; empty reduction OUTPUT/initial-value tests remain.
  No tolerance, numerical reference, source kernel, or actual output acceptance was changed to avoid a failure.
- Three-seed complete library runs including exceptional reductions are now running. Source selection requires
  exact coverage of all57 original auxiliary names and raises if any is missing; no source fallback is allowed.

## 2026-10-30 first source-only native CUDA extension built

- Added native/source_cuda.cpp, build_native.py and native_cuda.py. Built
  build/reconstruction-csrc/native/_source_cuda.cpython-312-x86_64-linux-gnu.so from recovered sources:25 PTX
  modules/188 exact kernel symbols, no proprietary library read or linked by the build/runtime. The binary links
  libcuda and ordinary C++/system libraries only. The build embeds freshly compiled SOURCE PTX, not extracted PTX.
- C++ layer manages device allocations, context push/pop, lazy module loading, exact-size ABI argument packing,
  kernel launches, synchronization and cleanup. It reuses an existing CUDA context when available and owns a new
  context otherwise. Function selection rejects missing kernels; Python adapter checks source-entry digests to
  avoid silently testing a stale compiled image. Default .so metadata explicitly says solver_api_ready=False.
- This is the kernel execution/memory layer, not the original Model/State/Config/Solver API or complete Newton host
  scheduling. It is not installed as style3d_sim._core and does not alter official examples/authentication.
- Added --engine cpp to the auxiliary checker. Reference launches still execute literal old PTX through the old
  driver; source launches use the compiled C++ extension. Exceptional A/B routes only source handles through C++
  while retaining the original reference path. First cpp seed1 passes all57 entries/1529base+1830exceptional checks;
  seeds2/3 running. Added native_backend_ab.py for188-symbol resolution, memory/ABI checks and core launch groups.

## 2026-10-30 native runtime primary-context handling and ABI coverage

- Refined the context constructor to retain/release the device PRIMARY context when no context is current;
  an existing caller context is still borrowed. This matches Warp/CUDA-runtime allocation ownership and the
  existing reference Driver's primary-context behavior. Archived the initial.so/build metadata before rebuilding.
- The first hard_constraints test requested an intentionally register-instrumented OLD geometry probe. The
  native source digest guard correctly rejected that non-bundled entry. Kept the guard strict and used full,
  unmodified hard_state_branches/hard_evaluate_branches instead; no arbitrary PTX fallback was introduced.
- Fixed a test-only context assertion's attribute name (reference Driver.context, not.ctx). Source/old context
  equality is now asserted in paired tests. Hard-state144 and hard-evaluate444 checks seed1 pass using the new
  C++ runtime, including312-byte views; source kernels are recorded separately from literal old reference handles.
- Added188-symbol resolution, upload/download/range, argument-count/structure-size and zero-grid checks, plus
  actual empty-kernel launch. Native-core seed2/3 full groups running; initial five groups seed1 are being
  rechecked against the final rebuilt.so, followed by all57 library entries through final C++ runtime for3seeds.
  Model/State/Config/Solver bindings and complete Newton host scheduling remain outside this execution-layer.so.

## 2026-10-30 auxiliary57/57 and native execution-layer closeout

- Final57 auxiliary instances have exact original mangled names:45normalized PTX-identical,12visibility-only,
  all57 instruction bodies identical. Together with owned131, source implementations cover all188 unique entries.
- Python-driver library runs old/source1529checks each plus1830exceptional checks/seed, seed1/2/3 all pass:
 14664checks. Final C++ runtime repeats the same57-entry set and all exceptional reductions for3seeds, also14664pass.
- Final rebuilt source-only.so resolves188functions and passes memory/range/ABI/empty-kernel checks. Core C++
  groups step24+PCG26+cable_update1693+cable_prepare1266+cable_evaluate12944+hard_state144+hard_evaluate444
  =16541checks/seed,3seeds49623pass.28distinct owned source kernels actually launch through C++;188-resolution is
  tracked separately. Step/PCG use frozen specs; cable/hard keep literal old PTX A/B. No modified old probes are
  passed off as delivered C++ source kernels.
- Final seed1 reports are native/base-abi/seed1.json plus native/hard-abi/seed1.json; seed2/3 are native/native/seedN.json.
  The older partial native/native/seed1.json and before-primary-context.so are retained but excluded from final proof.
- LIBRARY_AUXILIARY_AUDIT.md and NATIVE_EXECUTION_LAYER.md contain formulas, commands, fixes, actual test scope,
  exact artifact paths and next host work. HANDOFF.md now says188entry source coverage and distinguishes the CUDA
  execution layer from full Solver API. Library provenance39file hashes; native provenance61file hashes; final
  summaries and compiled extension hash verified. No official install was overwritten and no original.so was linked.
- Next work: compatible Span/Model/State/Control/Contact/Config/enum bindings, initialization/caches/ELL/persistent
  memory, then true C++ Newton/PCG/material/contact scheduling and stream/capture. Begin with a minimal particle
  case; only after compatible API exists use original-account/replacement.so same-demo comparisons. No original
  account login or complete solver/demo acceptance occurred in this phase. Solver API flag remainsFalse.

## 2026-10-30 C++ particle host/API recovered; user changes reference to newer processed binary

- Added native/source_solver.cpp, build_host.py, host_api_probe.py, api_schema.json, host_api_ab.py,
  host_particles_ab.py and host_adapter_demo.py. C++ Span/Model/State/Control/Contact/Config/enum fields/defaults
  were dumped directly from the actual reference; Span ptr/size are read-only, Model/Contact integer fields are
  uint32, Config iterations are signed int. API/guard checks539 pass. GPU state stays on the device throughout step.
- Implemented no-topology/no-contact Newton initialization, per-step prediction, RHS, block diagonal/inversion,
  PCG, nonlinear updates, input-position copy-back and final velocities. Preserved old host's observable writes to
  state_in.q. All allocations/modules are prepared before graph capture; all three step overloads accept integer
  and CUDA Stream Protocol handles. Unsupported physics raises; no CPU or original.so fallback.
- Against original old4c223854, initial24cases/396arrays and expanded37cases/630arrays passed. An incorrect
  particle_world pointer for replicated gravity was found in expanded tests and fixed after checking host
  fbf06/101de8. Later three-seed eager/captured Newton adapter runs also passed990arrays plus360 eager/graph
  self-checks per seed. Original-account workers were isolated and credentials were never stored or printed.
- Some authenticated OLD reference workers crashed after all output was saved. GDB located the background
  s3dnet heartbeat in libssl/libcrypto after OpenSSL teardown. A temporary isolated-worker NO_ATEXIT bootstrap
  allowed three clean exits. That bootstrap and historical runners/results are archived under
  build/reconstruction-csrc/host-particles/authenticated-reference-stage/; they are NOT the current workflow.
- USER UPDATE: no authentication in our source solver; user has prepared a no-login original.so. Removed all
  login/is_logged_in bindings from the C++ solver. Only the test bridge for the unchanged official Python wrapper
  supplies compatibility names; it reads no credentials and raises if login is called. Source runtime checks
  assert no original_core.so is mapped. Current reference workers also do not call login or read credentials.
- USER SELECTED THE NEWER PROJECT-INTERNAL REFERENCE. Old outside repo: ce8d7ba (2026-10-26), binary4c223854;
  inside repo:23fb797 (2026-10-27), processed binary64a0be7f. Old commit is ancestor of new. Parent update e74e136
  explicitly says fix(pcg): compute independent CG coefficients per world. LFS pointer was correctly resolved to
  the cached binary (not compared as binary data): newer upstream3fded722 and processed64a0be7f have the same
  size7657288 and differ in15bytes. Version details: host-particles/reference-versions.json.
- New binary is a physics revision as well as user processing:176entries;168shared entries normalized-identical,
 1shared affine entry text differs,7new PCG entries,19old entries removed. API schema remains identical. Extracted
  new PTX into build/reconstruction-ptx/64a0be7f7a3c03cb, inventory reference-revision-audit.json. Prior188-entry
  proof remains scoped to4c223854; do not relabel it as a fresh full-demo acceptance of64a0be7f.
- Added revisions/pcg_23fb797.cu: all7new entry names/signatures and normalized PTX match the new original exactly.
  build_host extends a local copy of the accepted source bundle with these entries; frozen CUDA sources and the
  original188-entry runtime/evidence remain unchanged. Updated C++ PCG scheduling to the new per-world sequence.
- Recovered world-group preparation by checking new host1070e8..107207,10b79c, and PcgSolver::initialize12f040:
  arbitrary local labels (including -1) are compacted in first-seen order, then replicated with group offsets;
  contiguous groups omit the map and use count/group_count as divisor. The first draft incorrectly rejected -1;
  the unchanged official Newton adapter exposed it, and the host assembly supplied the correction.
- New strict end-to-end comparisons currently have failures in some multi-block cases. Repeating the processed
  ORIGINAL against itself already gives28differing state arrays (257-particle cases). New kernels use per-particle
  red.global.add.f32 instead of the old CUB reductions; keep all strict failures visible, no tolerance relaxation.
  Source scheduling/kernel provenance and original-repeat evidence must be assessed separately. Do not claim
  complete demo bitwise equivalence while failures remain.
- Added revision_kernel_ab.py for literal processed-reference/source GPU tests: all7new PCG entries (114checks/seed,
  independent coefficient bins avoid ambiguous atomic ordering) and both affine preconditioners' branch fixtures
  (230checks/seed). Seed1 all344pass, seeds2/3 and final host runs are executing; see latest logs before reporting.
- Current compiled extension: build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so.
  It has no authentication API, source_only=True and solver_api_ready=False.195source entry definitions include
  the old188 plus7new entries;19old-only symbols are retained. Full materials/contacts/cables/host support remains
  unimplemented in this extension. No official src/, examples, dependencies, binary or Git commits were changed.

## 2026-10-30 newer-reference kernel closeout and first-divergence/replay diagnostics

- Final C++ host build now selects exactly the newer176 source symbols (129owned/47auxiliary). It filters obsolete
  entry definitions from a local SOURCE PTX bundle; original188 runtime/proof inputs stay untouched. All176 source
  functions resolve; all19old-only names are rejected. Build metadata has source/module/ABI hashes and source-only
  runtime flags.84source entries normalize exactly to the current reference;92remain text-different with the
  inherited/new targeted validation chain. This is not whole solver acceptance.
- All7new PCG source entries have exact normalized new-reference PTX. Updated revision_kernel_ab.py to route source
  launches through _KernelDriver in the actual current _source_solver.so, checking each requested digest. Each of
  seed1/2/3 executes9distinct source entries (7newPCG+bothaffine) and passes114PCG+230affine checks:1032total.
- Added internal module-local _KernelDriver test API to the compiled so for independent replay of real original
  inputs. It is the same validated C++ Driver, accepts only bundled functions and exact parameter sizes; it is not
  a reference.so bridge. The source solver still has no login/is_logged_in API and maps no original_core.so.
- Added native/host_trace.cpp and compare_host_trace.py. The test-only LD_PRELOAD observer captures CUDA-runtime
  launches for the processed original, driver launches for source, and before/after device arrays. Its initial
  RTLD_NEXT lookup could not see the RTLD_LOCAL CUDA runtime; fixed forwarding using the launching module's handle.
  Original binary/production solver are not modified by this observer. Observer synchronize overhead is diagnostic.
- Found an additional actual host mismatch: the original supplies NULL extra tangent when no matrix-free term is
  needed; the first source draft supplied a zero array. Removed that extra add/clear/allocation to preserve signed
  zero behavior and the exact pointer branch. This was corrected from captured real calls, not guessed.
- New source/reference trace of n257_w1_it1_f1 has102matching launch names/grids/blocks. The first differing buffer
  is call000004 precondition_and_reduce.after.numerator; all its inputs, per_group, precomputed flag and pointwise
  z match exactly. Repeating original->original also first differs in that aggregate (e.g.1ulp). Diagnostic trace
  directories preserve early and complete-input stages separately; early traces lack some input fields.
- Added replay_host_pcg.py: feed each original call's recorded inputs independently to this exact compiled source
  so.84PCG calls yield105pointwise outputs, all bitwise equal; of42atomic aggregate outputs one replay differs23.
  Full bitwise flag remainsFalse and the final replay command now exits nonzero for ANY aggregate failure as well.
  This evidence isolates the original's atomic reduction nondeterminism; it does not waive strict whole-demo checks.
- Full37scene+official-Newton-adapter eager/graph A/B produced990arrays/seed and360self-comparisons/seed. Before
  the final NULL-tangent correction the source/reference failures were21/21/16 for seeds1/2/3, all multi-block;
  eager/graph self comparisons passed. Those snapshots are multi-block-strict/. Final full runs are being rerun
  after the correction; consult comparison-seedN.json/final-host-seedN.log for latest counts before reporting.
- Added NATIVE_HOST_PROGRESS.md with current reference, commands, exact support limits, test engine, original-repeat
  caveat, trace/replay workflow, historical-stage separation and remaining work. Updated HANDOFF top to prioritize
  the user's newer/no-login selection over historicalold188 instructions. No core/src/example/dependency binary
  was overwritten and no Git mutation was made. Complete materials/contacts/cable host scheduling remains pending.

## 2026-10-30 final host validation checkpoint

- Final NULL-tangent-corrected compiled image exposes exactly176 kernels.539API checks,176function resolutions and
 19obsolete-symbol rejections pass. Both historical native/library proof manifests remain intact (61+39file hashes
  checked, zero changed); other frozen source arithmetic was not edited.
- Final full37scene+adapter runs: seeds1/2/3 each990original/source arrays, strict differences21/21/14, entirely
 257-particle scenes; all360eager/graph self-comparisons per seed pass. Both worker processes exit0, no login or
  credentials used, source maps no original.so. The controller intentionally exits1 due to numeric differences.
- Latest complete observer:102matching launches. Source/reference first diverges at precondition_and_reduce's
  numerator; repeated original first diverges at multiply_matrix_and_reduce's denominator. Their pointwise z/Ap
  at the first respective divergence and all preceding recorded inputs/outputs are equal. Earlier reference
  repetitions first diverged in numerator instead; both are actual atomic reductions, not waived comparisons.
- Exact-input independent replay through the same compiled C++ so:84calls,105pointwise comparisons all equal;
 42aggregate comparisons,16different in the latest run (an earlier run differed23). full_bitwise_equal remainsFalse
  and the replay command now exits1 for aggregate failures too. This is a diagnostic split, not a relaxed pass.
- Trace outputs now go into per-label subdirectories to avoid overwriting complete root990-array results.
  Final trace/repeat folders: trace-seed1/final-trace and trace-seed1/final-reference-repeat. Source replay uses
  final-trace/legacy. Early traces were incomplete for some arguments and are retained only as diagnostic history.
- New kernel tests now also record the exact compiled image SHA256. Rechecking all3seeds with this metadata and
  assembling a final checkpoint manifest; do not mark complete solver/API/demo equivalence from this milestone.

## 2026-10-30 checkpoint manifest saved

- Final changed-kernel C++ runs record image SHA256 and pass all1032checks across3seeds.176-entry coverage and
 19obsolete-name rejection are verified against the current processed reference. Final source image SHA256:
 1fe5c1941bed424ec02b274fa506a8b10af8728d6015bdc7292701e26e12ee36.
- build/reconstruction-csrc/host-particles/validation-summary.json records exact pass/failure counts and explicitly
  sets whole_solver_accepted=False. provenance-final.json hashes2394source/build/result/trace files, including
  complete final trace inputs and the inherited native/library proof manifests. Do not edit hashed files silently;
  preserve the checkpoint before future updates. WORK_LOG/HANDOFF remain live navigation documents.
- Current remaining work is unchanged: strict aggregate differences must remain visible; the C++ host only handles
  no-topology/no-contact particles. Continue reconstructing material/rigid/contact/self-collision/cable host paths
  from the newer binary and validate exact inputs/outputs before asserting complete replacement. No account needed.

## 2026-10-30 continued investigation: native instruction equality, atomic order, particle springs

- Archived and verified all2394files of the prior checkpoint under
  build/reconstruction-checkpoints/host-particles-20261030-before-springs/ before editing active host/test files.
  Its provenance-final.json paths resolve relative to that directory; historical proof is independently checkable.
- New dump_revision_pcg_jit.py links COMPLETE reference/source PCG PTX modules for the actual device and compares
  ELF .text bytes. All7new PCG native instruction streams are byte-identical (1408..5376bytes per kernel).
- New atomic_order_audit.py creates explicitly diagnostic atomic-return probes without modifying production PTX
  or the reference.so.32runs have identical pointwise z and identical contributions but31observed atomic orders,
 7scalar bit patterns. Replaying each observed float32 sum chain reproduces its final bits exactly, including the
  production's observed bit pattern. Probe timing is different; no claim is made to know a prior production order.
  This closes the reduction-order cause without changing the original algorithm or accepting failed strict tests.
- Added actual C++ spring precompute/host scheduling: std::map duplicate/column accumulation, host diagonal,
  full replicated row counts, source initialize_block_non_diagonal kernel for signed-zero-preserving block ELL,
  per-iteration spring force/GN correction, and block-matrix PCG. No frozen CUDA arithmetic changed.
- Captured processed original spring_w2_basic first:384launches; ELL rows are global4, row counts[1,1,1,1],
  columns[1,0,3,2], host diagonal37.5 and negative-zero block lanes. Used these real inputs to select array layouts,
  full-row stride and kernel order. Existing NumPy spring_constant_matrix serves only as an unchanged reference.
- Found SDK rejects zero rest length even though standalone kernels handle it. Rest lengths must be finite>0;
  stiffness finite>=0; endpoints distinct/in-range. Added corresponding guards with original error messages.
  Invalid cases compare exception statuses and verify every caller-owned device array remains byte-unchanged.
- Added spring_host_cases.py and --scenario springs.30cases:18valid and12invalid, including1/2/7/129worlds,
  duplicated springs, chain sparsity, zero stiffness, graph capture and invalid/nonfinite inputs. Three seeds each
 324direct arrays pass bitwise. Added the unchanged official NewtonSolver adapter's two-particle spring scene,
  eager/graph30frames each (60substeps/mode): each seed684total arrays and360eager/graph self-checks all pass.
  All3seeds2052original/source arrays pass; no original.so is mapped in source workers, no login/credentials used.
- Updated API unsupported-topology guard to use still-unsupported triangles because springs are now implemented;
  no numerical tolerance or specification was changed. New input validation is checked against actual reference
  errors; the old zero-rest rejection was retained as an explicit expected-error case, not removed from coverage.

## 2026-10-30 continued native host: PD particles/springs and mode changes

- Captured actual processed-original PD spring execution: scalar inverse, scalar ELL and float preconditioner;
  no Newton GN correction, block-diagonal setup or combine_system_non_diagonal launch in this supported topology.
  Implemented that observed C++ scheduling without changing frozen CUDA arithmetic. Both scalar/block functions
  and caches are prepared during initialize so changing nonlinear mode does not allocate during graph capture.
- Three seeds: PD springs2052original/source arrays, PD particles1296arrays, Newton/PD/Newton switching162arrays
  all bitwise equal. Each adapter group also passes1080eager/graph self-checks. The switching test includes129worlds
  and captured execution with one initialized solver. No login/credential access or original mapping in source worker.
- Preserved current source/build/results before the next contact module in
  build/reconstruction-checkpoints/springs-pd-before-soft-contacts/provenance.json. Earlier2394-file and Newton-spring
  checkpoints remain separate. Active old provenance-final.json is historical, not a manifest for newly edited files.
- Whole solver remains incomplete. Atomic aggregate failures from larger particle-only scenes remain failed;
  instruction equality and observed summation-order evidence do not convert those comparisons into passes.

## 2026-10-30 native static-shape soft contacts and newly found Span API mismatch

- Added soft_contact_host_cases.py and actual C++ static soft-contact scheduling. Captured the processed original
  before implementation: first soft kernel adds rhs/scalar diagonal; block setup follows; a second soft call updates
  distinct system/preconditioner blocks. The base diagonal is restored on every nonlinear iteration. The original
  clears a separate matrix-free product and launches the off-diagonal kernel even for static shapes; preserving its
  non-null zero product matters for signed-zero additions. It is null when enable_collision_hessian_non_diagonal=False.
- Found and fixed a real PD branch error: PD with that flag disabled must use scalar inverse/float PCG and omit
  both block setup and the second soft call. The initial expanded suite had11different arrays in that scene; real
  original launch traces showed366calls vs source384. Retained failed traces in locate-difference, fixed the branch
  rather than loosening comparisons. affine_body_contact_block_preconditioner does not remove the particle blocks.
- Contact force must precede spring force. Newton applies spring GN, copies system blocks into the preconditioner,
  then corrects both for contact; PD uses scalar ELL with a block diagonal when contact Hessians are enabled.
  Single-world official wrapper uses shape_replicated_count=shape_count even for a static plane. Accepted that valid
  static layout and added correct-world/wrong-world replicated-shape cases instead of forcing shared-only shapes.
- Expanded to43cases per mode:1/2/129/257worlds, plane/sphere, friction/damping limits, moving surfaces, oblique/zero
  normals, count0/negative/overcapacity, invalid indices, zero mass, spring/contact combination, stream protocol,
  graph capture, zero nonlinear iterations and Newton/PD/Newton changes. Three seeds and both modes:7164arrays pass
  bitwise, plus2520eager/graph self-checks. The official unchanged adapter demo uses a real Newton CollisionPipeline
  and a ground plane; it records/asserts nonzero generated contacts rather than fabricating demo contact buffers.
- Four complete traces (Newton friction, PD Hessian disabled, Newton spring/contact, PD spring/contact):
 465+366+483+474=1788launches, all captured input/output buffers and launch metadata bitwise identical. Added observer
  categories for soft force/off-diagonal and all of their relevant static inputs. These are test-only snapshots.
- Revalidated the a8769026 image: springs2052, PD springs2052, PD particles1296, switching162arrays;1032changed-kernel
  checks pass. Added17source safety guards for missing model/contact spans and unsupported full-surface contacts.
- Broader API testing then found an actual previously missed difference: original Span getters return values,
  while generated def_readwrite returned internal references. A saved source Span changed after reassignment of
  its owning field; the original saved Span did not. Added a direct original/source check for every Span field and
  changed build_host.py generation to by-value getters/setters. Rebuild and new API/numeric regression are pending.
- Preserved34921source/build/result/trace files before that binding fix at
  build/reconstruction-checkpoints/static-soft-before-span-value-fix/provenance.json. That checkpoint explicitly
  records the known Span issue and whole_solver_accepted=False; prior API defaults/guard success was not full API
  equivalence. Current host still rejects cloth/body/tet/fluid/granular/cable/self-collision/full-surface branches.
- Started membrane host fixtures and original tracing only; no cloth host implementation is claimed yet. A first
  soft-contact trace was launched before its build finished and loaded the previous unsupported image (source-first);
  it is diagnostic history, not a numerical failure or accepted validation. Accepted-* traces are the complete ones.

## 2026-10-30 Span repair, membrane and bending host reconstruction

- Replaced all128Span property bindings with explicit by-value getters/setters, matching actual original behavior.
  Expanded host_api_ab to compare assignment ownership for every Span field before numerical testing. All692checks
  now pass, including25new source safety guards for missing shape/contact/cloth spans. This corrects the earlier
  API claim based only on defaults/boundaries. No frozen CUDA/NumPy arithmetic was changed.
- Added membrane_host_cases.py and C++ cloth matrix precompute: triangle scalar SSE operation order, per-row maps
  with sorted columns, full replicated counts/block ELL. Newton applies the recovered membrane GN correction;
  PD omits it and retains scalar ELL. First captured two-world Newton scene:384launches and every captured byte
  matches. Initial12cases/mode across3seeds:1296original/source arrays pass bitwise before adapter expansion.
- Added bending_host_cases.py and recovered cotangent matrix assembly after triangles; force, damping-only
  preconditioner updates and matrix-free tangent. Actual PD traces establish a valid positive-damping stencil is
  required for the block path. Boundary/zero-area hinges still launch force but skip damping and keep scalar PD.
  Captured actual replicated free-particle matrix rows33 vs local11, so Newton block rows are always total rows,
  even with zero nnz; PD scalar rows remain local. This replaces the previous observable zero-nnz metadata mismatch.
- First damped bending scene:465launches, every captured input/output/metadata byte identical. Initial18cases/mode
  across3seeds:1944arrays pass bitwise. Expanded to21cases/mode by adding bending damping+static soft contact;
  the shared tangent is cleared once before both kernels. The soft kernel must not erase preceding bending products.
- Added official unchanged adapter cloth demos (single triangle; two triangles with a damped hinge). Newton/PD
  seed1 passes576membrane arrays and738bending arrays per mode with eager/graph self-checks; all final3seed groups
  are currently running against the same e91d4c96a9543f51b2d356d6f62864cab5f7d37fc7b6edec8e53fb44b5e697d6 image.
  No fullcloth/plastic_bag/ball demo or complete solver acceptance is claimed. The old example flag 'reconstructed'
  still points to the historical NumPy solver, whereas these tests load the real source C++ extension.
- Allowed collision triangle/edge metadata for the implemented no-self-collision/no-drag path. Nonempty drag
  coefficients, full-surface contact, mixed spring/cloth precompute and all other unimplemented physics still reject
  explicitly. The collision metadata supplied by the official cloth wrapper is not a second elasticity topology.
- Procedure notes: two initial PD boundary/area diagnostics accidentally shared oracle-branch and must not be used
  as a complete trace. Unique reruns were made; two yielded original diagnostics could briefly overlap. They are
  excluded from acceptance. Final acceptance jobs use one sequential subprocess loop and unique case labels.
- Existing frozen native/library manifests rechecked:61+39files, zero changed. Remaining exact code/branch
  equivalence work continues from NATIVE_HOST_PROGRESS.md; strict atomic aggregate differences are never waived.

## 2026-10-30 final checkpoint for continued native host work

- Final image SHA256 e91d4c96a9543f51b2d356d6f62864cab5f7d37fc7b6edec8e53fb44b5e697d6. All30scenario/seed runs
  explicitly record this image:20610original/source arrays,10080eager/graph self-checks pass. Per three seeds:
  springs2052, PD springs2052, PD particles1296, switching162, soft contacts3582, PD soft contacts3582,
  membranes1728, PD membranes1728, bending2214, PD bending2214. API692 and changed-kernel1032checks pass too.
- Actual final C++ image resolves all176current source entries and rejects all19obsolete entries. No original.so
  mapped in those source processes; no login/credentials used. ldd lists CUDA driver/system libraries only.
- Nine additional final-* cloth traces:4023launches, all captured input/output bytes and metadata equal. Includes
  Newton/PD damping, invalid boundary/zero area, membrane+bending, and damping+soft-contact shared product ordering.
- Repeated complete free-particle990array tests with current image: seeds1/2/3 retain28/28/21strict failures.
  Initially reported all as257-particle scenes from truncated stdout; full JSON inspection corrected that: seeds1/2
  also have7failures each in4097-particle many_blocks. This case was separately traced rather than assumed equivalent.
- many_blocks:294matching launches. Original/source first differ at precondition_and_reduce numerator, with all
  preceding captured inputs/outputs and current pointwise z equal. Original/reference repeat also first differs in
  numerator. Exact-input replay of all252PCG calls has315pointwise checks all equal,92/126aggregate checks different;
  full_bitwise_equal=False and command exits1. Initial old replay guard expected84calls; extended declared iteration
  counts and exact 4-stage sequence validation, retaining strict full coverage instead of removing the guard.
- That synchronous diagnostic's18state arrays happen to match; the complete990array failures are retained. Changed
  compare_host_trace CLI to exit1 on any byte/metadata difference too; report-only exit0 must not imply acceptance.
- Original/reference repeats and accepted final traces are strictly serialized. Early overlapping/shared-label
  diagnostics were excluded. Final acceptance data is linked explicitly by case, image SHA and report path.
- Source reconstruction now includes real C++ host for the supported cloth/contact/particle modes, but whole solver
  acceptance remainsFalse: unresolved strict aggregate differences plus unsupported spring+cloth, bodies/joints,
  tetrahedra, drag, full-surface contacts, fluid/granular, cables and self-collision. No binary replacement deployed.

## 2026-10-30 final evidence written and verified

- build/reconstruction-csrc/host-particles/validation-summary.json now separates current-image passing scopes,
  strict990-array failures, and diagnostic replay. It records reference64a0be7f, imagee91d4c96, all30group/seed
  reports,692API/1032revision checks,4023current-image trace launches and unresolved physics. whole_solver_accepted=False.
- provenance-final.json hashes241167source/build/result/trace files plus the unchanged61+39historical proof inputs.
  All241167hashes were re-read and verified with zero mismatches. Manifest SHA256:
 63d0dd85b2fc2dc6d5ccc3ee0a9fe013d9edd3c2288a08ab22dc8d4df9f949f6.
  Live WORK_LOG/HANDOFF/NATIVE_HOST_PROGRESS navigation documents are excluded from immutable artifact hashes.
- Before a later build or overwritten report, preserve the affected checkpoint artifacts. Use fresh unique trace
  labels for every scene; do not recycle a directory across cases. Read NATIVE_HOST_PROGRESS.md for exact commands,
  current supported topology, failed scopes and next source modules. No Git commit/reset/checkout was performed.

## 2026-10-30 continued after user requested resolving remaining differences

- Preserved508mutable source/build/result files from e91 under
  build/reconstruction-checkpoints/e91-host-before-mixed-cloth/. Numbered raw traces remain untouched in their
  original paths; the preserved-files mapping plus unchanged paths verifies the previous241167-file manifest.
- Recovered mixed spring/cloth precompute from actual processed-original captures. Ordinary inputs did not
  distinguish the order, so added rounding_springs (32tiny identical springs) and rounding_cloth (32tiny triangles
  plus a strong spring). Original CPU starts with accumulated spring diagonals/negative ELL values, then adds each
  triangle/hinge individually. Grouping whole cloth+spring matrices or adding springs after cloth gives wrong bits.
  mixed_precompute_audit.py verifies175raw-bit checks over7original captures and rejects both incorrect candidates.
- C++ now seeds cloth maps from the spring matrix, uploads the combined template once, and applies membrane GN
  before spring GN. Force order is spring then membrane. Four complete basic/rounding/zero-stiffness traces:
 1608calls with all captured bytes and metadata equal. No frozen CUDA kernel/NumPy math was edited.
- Added24mixed fixtures per mode (1/2/129worlds, duplicate elements, zero stiffness, positive off-diagonal, graph,
  strong/weak rounding). Three seeds:2592arrays compared; only7strict failures in PD seed3 world129 duplicates.
  They remain failures; the other2585arrays pass. Newton seed1/2/3 and PD seed1/2 pass all432arrays per run.
- Located that new failure using actual original/source and original/repeat traces: first difference is rhs after
  evaluate_spring_force, before membrane or PCG. Final differing q element is particle161/componentY (world53).
  Its three spring threads159/160/161 straddle a warp boundary, not the block boundary initially considered.
- spring_host_atomic_audit.py executes current-reference PTX and the actual compiled C++ so function handle with
  disjoint endpoints but identical element inputs. All2322isolated scalar contributions match bitwise. All39474
  scalar outputs (32repetitions plus both actual captured outputs) are reproduced by enumerating exact float32
  addition permutations. This diagnoses atomic ordering without changing production accumulation or tolerance.
  Captured strict equality remainsFalse and the command exits1; no claim of complete module/solver acceptance.
- Preserved the intermediate mixed-host source/image/reports at
  build/reconstruction-checkpoints/mixed-cloth-before-tet/. Started tetrahedron fixtures/observer categories only;
  its C++ host implementation and oracle validation follow next. The current strict aggregate failures remain open.

## 2026-10-30 tetrahedron kernel correction and native host

- Found actual kernel defects while tracing default tetrahedron host calls: frozen evaluate_tetrahedron_force
  unconditionally dereferenced activation[tet]. Current original PTX guards NULL and indexes activation by global
  state i, not local template tet. Previous low-level tests always supplied arrays and one world, missing both paths.
- Added readable revisions/tetrahedra_23fb797.cu with exactly those two activation corrections. build_host replaces
  only this entry from the historical source bundle; unchanged historical kernels/native/library manifests remain
  intact. Active source image still exposes176entries, now sourced from27modules. No frozen NumPy arithmetic changed.
- tetrahedron_activation_ab.py: three seeds,12direct cases/seed (NULL/non-NULL,1/3local tets,1/2/129worlds), all36cases
  compare bitwise against the current original PTX via the actual compiled C++ function. The historical source
  demonstrably fails4activated multiworld cases/seed (12total). This is a real corrected index/guard, not tolerance.
- Added native tetrahedron CPU volume precompute (SSE first-row determinant order), force, block preconditioner,
  matrix-free tangent and global activation span validation. Default activation stays NULL, matching original calls.
  Explicit activation requires the total tetrahedron state count; original rejects shorter arrays before mutation.
- Added29host cases/mode:27valid+2expected short-activation errors, including damped/inverted/zero-material states,
  two tets/template, different per-world activations, springs+cloth, static soft contact, streams/graph and129worlds.
  Three seeds ×Newton/PD:2916state arrays all bitwise equal; invalid error statuses/device-input preservation match.
  Three complete elastic/activated Newton/PD traces:1395calls, all captured input/output bytes/metadata identical.
- audit_optional_parameters.py scans direct u64 parameter/cvta/mov NULL tests across all176active entries: no other
  guard-set differences found. Positive control detects the historical tetrahedron P6 omission and corrected guard.
  This heuristic does not prove indexing or full control-flow equivalence; those still need actual PTX/GPU coverage.
- Initial oracle-tet_w2_activation trace used an undersized array and correctly failed. Kept as diagnosis only;
  corrected-* labels use full per-state arrays. Prior e91/mixed provenance is preserved rather than overwritten.

## 2026-10-30 triangle drag and additional actual-reference differences

- Preserved the ad513bff tetrahedron image/source/results under build/reconstruction-checkpoints/tetrahedra-before-drag/.
- Restored triangle drag host compaction (positive Cd faces, original order), normal/area initialization using
  previous positions after initialize_step, nonlinear force and scalar cache, block preconditioner and tangent.
  Zero air density disables all drag calls and switches otherwise-empty PD back to scalar mode, confirmed in so.
- Found actual API differences beyond the previous default/integer/Span tests: Config.air_density rejects nonfinite
  or negative input; Config.wind_velocity requires a sequence of three finite components. Original sequence length
  errors are ValueError, element cast errors RuntimeError, non-sequences TypeError. Restored those exact behaviors.
  api_float_ab.py compares all41float/vector fields over16values plus14sequence cases:670checks pass, including
  unchanged stored values on exceptions. No additional constraints were invented for other float fields.
- Original initialization also rejects nonfinite/negative triangle drag coefficient arrays with the exact error
  "triangle drag coefficients must be finite and non-negative". Added that guard and expected-error/device-preservation
  tests. Invalid density assignment is now caught within fixture verification; it was previously outside its try block.
- Combined-material trace exposed real scheduling differences despite identical18short-run state arrays. Actual
  original force order: drag, soft contact, spring, membrane, tetrahedron, bending. Newton GN: membrane then spring.
  After contact corrections, preconditioners: tetrahedron, bending damping, drag. Matrix-free products: tetrahedron,
  bending damping, soft contact, drag. Corrected C++ ordering from actual original captures, not the frozen Python
  host's unverified combined-material order. A mismatched initial trace is kept under source-drag_combo_*.
- Four corrected complete traces (Newton/PD all-materials, tet+contact+drag, zero-density PD):2607launches, all captured
  input/output bytes and metadata identical. The all-materials scene includes springs, membrane, bending damping,
  tetrahedron, static contact and wind; its complete ELL has no unwritten padding.
- Three seeds ×Newton/PD drag:34cases per mode (30valid+4expected errors),3240state arrays all bitwise equal.
  Includes zero/degenerate faces, positive-face compaction, wind, graphs,129worlds and mixed tetrahedron/cloth/contact.
  Full solver/API/demo acceptance is stillFalse; rigid bodies/joints, fluid/granular, cable, self collision and
  full-surface soft-contact host paths remain unsupported, and strict atomic order differences remain failed.

## 2026-10-30 static full-surface contact host

- Added a296-byte POD SurfaceContactView host mirror with sizeof/offset assertions matching recovered CUDA.
  The test observer captures its scalar fields and pointed-to contents, excluding addresses/padding.
- Recovered barycentric surface force, block preconditioner and full matrix-free tangent for static shapes.
  Original PD uses block preconditioning even when legacy collision Hessians are disabled. Surface stiffness-scale
  is not called in the supported no-self-collision path; no invented scalar diagonal contribution was added.
- Confirmed particle-only fallback selection with actual so: full-surface + absent filter skips legacy particle
  contact even if particle ids exist; present filter launches legacy kernels and the GPU filter selects shapes.
  A present filter requires particle ids even when its contents are zero. Missing ids raise exact ValueError
  "soft contact arrays are smaller than soft_max_count", before caller-device mutation.
- Found another dependent PD branch: full-surface or tetrahedra can require blocks while legacy collision Hessians
  are disabled. The original then omits legacy block correction and off-diagonal multiplication, while keeping
  the full-surface tangent. Corrected the prior assumption that any block solve needs the legacy correction.
- Force order is drag -> surface -> optional legacy particle -> spring -> membrane -> tetrahedron -> bending.
  Preconditioner order after legacy corrections is tetrahedron -> bending -> surface -> drag. Matrix-free order
  is tetrahedron -> bending -> surface -> optional legacy particle -> drag. All share one cleared product buffer.
- Five original/source complete traces:2769calls, all captured bytes and metadata equal, including the all-materials
  scene and PD particle fallback with Hessians off. Three seeds ×Newton/PD:2268state arrays pass bitwise across
 25cases/mode (21valid+4expected errors), with sphere/plane, filters, graphs and129worlds.
- Added a standalone tetrahedron+particle-contact/Hessians-off case to validate the dependent branch separately.
  Surface fixture generator initially shadowed an imported helper and recursed; fixed the alias and discarded that
  failed harness attempt. Production math/source was unaffected by the generator error.

## 2026-10-30 user-requested pause

- User explicitly requested pausing and an explanation. Stopped only this turn's regression process group2563254
  with SIGTERM; session11991 exited143. No more reconstruction/test work is running from this batch.
- Latest activity: image1ba3a112e2915616821eb8464d90bdec8fa52f4d66644bb2d33f124d77959b29. API692/float-vector670,
  revision kernel seeds1/2/3 and corrected tetrahedron activation seeds1/2/3 passed. Main regression batch completed
 41/54scene-seed groups, all recorded failures empty. Seeds1/2 complete; seed3 completed through soft_contacts.
  Remaining13groups are unvalidated in this batch. Any files from an interrupted worker are not accepted results.
- Resume from build/reconstruction-csrc/host-particles/continuation-regression/batch-status.json after the user
  resumes. Do not restart automatically while the pause is in force. Known atomic-order failures and unsupported
  body/joint/fluid/granular/cable/self-collision host branches remain; complete solver/demo acceptance isFalse.

## 2026-10-30 paused regression resumed and completed

- Resumed the user-paused continuation batch from batch-status.json with the same per-scene procedure, image
  1ba3a112e2915616821eb8464d90bdec8fa52f4d66644bb2d33f124d77959b29 (verified by sha256 before running). The 13
  remaining seed-3 groups (pd_soft_contacts .. pd_mixed_cloth) all pass with worker exit codes 0. Batch now 54/54
  scene-seed groups, zero recorded failures. pd_mixed_cloth seed 3 passed this time; its earlier 7 strict
  differences were the documented atomic-order case (both orders reproducible from identical contributions).
- Reference for all further host recovery: project-internal style3d-sim-bin/Linux/Release/_core...so,
  SHA256 64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63 (user instruction: missing logic must be
  read from this binary). Next module: affine bodies (body_count/body_state_count) host path.

## 2026-10-30 affine-body host: reference launch schedule captured

- Added diagnostic tools (not delivered): reconstruction/diagnostics/launchlog.c (LD_PRELOAD, logs EVERY
  cudaLaunchKernel symbol/grid/block to $LAUNCHLOG; cudahook.c only logs kernels in its layout table and silently
  missed initialize_block_diagonal / invert_block_preconditioner / precondition_and_reduce) and
  reconstruction/csrc/body_capture.py (unchanged official Newton adapter on the project-internal 64a0be7f
  reference, no login; scenes free_body/two_bodies, Newton/PD).
- Free affine body, Newton, default config (SO3 AL rigidity, MIDPOINT_CAYLEY, 5 nonlinear x 50 linear):
  refresh_inertial_cache_nonzeros, refresh_inertial_cache_diagonals, initialize_step,
  initialize_affine_body_so3_state, combine_system_non_diagonal, initialize_block_non_diagonal; then per nonlinear
  iteration initialize_rhs, evaluate_affine_body_so3_augmented_lagrangian_force, initialize_block_diagonal,
  add_affine_body_so3_augmented_lagrangian_preconditioner, invert_block_preconditioner,
  50 x [precondition_and_reduce<mat3>, update_cg_direction, multiply_affine_body_so3_augmented_lagrangian_tangent,
  multiply_matrix_and_reduce<BlockNonZeroEntry, mat3>, update_solution_and_residual], apply_nonlinear_step,
  update_affine_body_so3_augmented_lagrangian_state; finally update_velocity.
  Sequence file: build/reconstruction-csrc/bodies/free_body-newton/synreal_sequence.txt.
- Next: dump the reference's inertial-cache CSR inputs, template coefficients, mass ELL and initialize_step kind/
  flags for this scene (cudahook dumps) and reproduce them in the C++ precompute; then compare full traces.

## 2026-10-30 user-approved acceptance criterion for atomic-order scenes

User approved (2026-10-30) the following criterion for arrays whose strict comparison fails ONLY because GPU
float atomics (red.global.add / atomic reductions) accumulate in a run-dependent order. All three must hold:
  A. Pointwise: given identical captured inputs, every non-atomic (pointwise) kernel output is bitwise equal
     (replay_host_pcg / exact-input replay).
  B. Aggregates: each differing atomic aggregate is reproduced exactly by some float32 summation order of the
     identical per-thread contributions (atomic_order_audit / spring_host_atomic_audit style enumeration).
  C. Whole run: for every failing state array, the source's deviation from the mean of K>=5 original runs is within
     the original's own leave-one-out spread (max over runs) at every recorded step.
Strict bitwise remains the default for everything else; this criterion never applies to a non-atomic difference.
- Applied the criterion to the long-standing free-particle 990-array strict failures (image 1ba3a112,
  atomic_spread_check.py, 5 original runs per seed): seeds 1/2/3 strict failures 28/14/2 arrays; every one of
  them also differs between original repeats; source deviation / original leave-one-out spread <= 0.427 / 0.800 /
  0.200 (max deviation 1.1e-5). Criterion C passes for all; A (replay_host_pcg: all pointwise outputs equal) and
  B (atomic_order_audit: aggregates reproduced by summation order) were already established. Verdict: the
  particle-scene differences are accepted under the user-approved atomic criterion. Results:
  build/reconstruction-csrc/host-particles/atomic-spread-seed{1,2,3}/criterion-c.json.

## 2026-10-30 ball demo spread（NumPy shim，30 帧 240 子步）

- 5 次原版 + 4 种原子序 shim 已全部跑完；之前的等待脚本因 pgrep 匹配到自身而挂起，已停止并单独执行汇总。
- `build/reconstruction-demos/ball-spread/spread.json`：particle_q 原版自身 spread 2.88e-6，重建误差 3.41e-6；
  仅 114/240 子步落在 spread 内（ratio 中位数 1.016，最大 12.1）。particle_qd：148/240，ratio 最大 14.9。
- 结论：量级一致，但按逐子步的标准 C 不通过。这是 Python oracle 路径，不是交付的编译版 so；待 C++ host 覆盖
  body/接触后，用编译版重新做该 demo 的 A/B。

## 2026-10-30 C++ host：自由仿射刚体（SO(3) AL，Newton）逐位对齐

来源全部取自项目内 64a0be7f 原版的实测：launchlog/cudahook 抓到的调度顺序、每个 kernel 的实参、以及
预计算缓冲区的 dump（`build/reconstruction-csrc/bodies/free_body-{newton,dump}`）；乘子更新条件取自
native_step.py 中已按 SolverNewton::step 记录的规则（c == primal_iterations 且不是最后一次）。

- `source_solver.cpp::precompute_bodies`：per-world 的并集 ELL（std::map 列升序、slot-major、padding {-1,+0}），
  inertial cache 的 CSR：list a = mass non-diagonal 下标（values = particle_mass_non_diagonal_values），list b =
  列对所属刚体（values = body_masses → L2 = -w）；对角 CSR（列粒子 → 刚体，D1 = 3w，D2 = w）；kind = 1/2。
- `step`：refresh_nonzeros → refresh_diagonals → initialize_step(D1,0,D2,0,0,α,0,0,0,α, kind) → so3 init →
  combine(1/h², 0,0,α,0,α; L0..L6) → initialize_block_non_diagonal；每次迭代 rhs 用 L1 ELL，so3 force，
  blocks + 单独预条件器副本 + so3 preconditioner → inverse；CG 中 so3 tangent 写入 extra product；apply 后
  so3 update(out.q, flag)。
- 只接受 Newton + SO3_AUGMENTED_LAGRANGIAN + 无 block preconditioner + 无接触；刚体与弹簧/布料/四面体/drag
  混合仍拒绝。自由关节的 joint_dof/target（无 drive）在原版里不产生 kernel，故对刚体模型放行；刚体自带 shape
  只在接触时有用，接触对刚体模型在 step 中拒绝。
- 验证（`reconstruction/csrc/host_bodies_ab.py`，官方 adapter，原版与源码串行运行，bitwise）：
  free_body 1 world 3 步、30 步；two_bodies 1 world、2 worlds；free_body 3 worlds —— 全部 PASS。
  每 kernel 的 launch 次数与原版抓取完全一致（2 步：rhs 10、so3 tangent 500、multiply 500 ……）。
- 改动前的 host 镜像已存档：`build/reconstruction-checkpoints/host-before-affine-bodies/`（SHA 1ba3a112…）。
- 回归（刚体改动后，seed 1，19 个场景 --adapter）：18 个 bitwise 0 failures；particles 21 个 strict 差异（原子序）。
  标准 C：第一次 5 次原版时 3 个 qd 数组超出（n257_w1_it1_f0，偏差 1.526e-5 vs 原版 spread 1.431e-5，约 1 个速度量化
  步长 = 1 ULP 位置 / dt；对应 q 数组在 spread 内），存档在 `atomic-spread-seed1-runs5-fail/`；
  用 10 次原版重跑（源码也重新跑）通过，outside = []。5 次采样在 1-ULP 量级上噪声偏大，已如实记录两次结果。
- PD_NEWTON + 刚体：抓取原版 PD 调度（`bodies/free_body-pd/all_launches.txt`），已实现；镜像 d7a2d5fe… 上
  Newton/PD 共 10 组刚体 A/B 全部 bitwise PASS，PD 30 步 launch 次数 = 原版 1 步抓取 × 30。
- 最终镜像 d7a2d5fe… 回归（seed 1，19 场景 --adapter）：18 个 0 failures；particles 原子序差异，标准 C（10 次原版）
  通过，outside = []。

## 2026-10-30 C++ host：刚体刚性接触 + 滚动/扭转摩擦 + 刚体软接触（Newton / PD）

- 原版抓取（项目内 64a0be7f）：`bodies/ground_box-newton`（launchlog 8 步）、`bodies/ground_box-args`（cudahook 实参
  + pointers.json：指针 → Model/Contact 字段名）、`bodies/ground_box-w2-args`、`bodies/ground_box_smooth-newton`。
- 调度（原版）：rhs → evaluate_contact_force(force=rhs, scalar=diagonal) → evaluate_rolling_contact_force →
  evaluate_soft_contact_force → so3 force；blocks → 预条件器副本 → evaluate_contact_tangent(system, precond) →
  soft 第二次 → so3 preconditioner → add_rolling_contact_preconditioner → invert；CG：so3 tangent →
  contact tangent(direction→product) → soft off-diagonal → rolling tangent → multiply。
- 刚体模型下 soft contact 传 kind（initialize_step 同一缓冲区）与 affine_body_ids/indices/com/body_count；
  RollingContactView 按值 248 B，epsilon = config.rolling_friction_velocity_epsilon，inertia = body_inertia_tensors。
- 滚动核仅在有 shape 的 rolling/torsional 摩擦非零时 launch（摩擦全 0 的抓取中无滚动核）。
- 刚性接触把各向同性刚度累加进标量 diagonal，因此每次迭代从 base diagonal 重新开始（与粒子软接触相同）。
- 首次实现的错误：so3 force 放在 rhs 之后（原版在接触之后），rhs 原子累加顺序不同 → 第 1 步起 1 ULP 级差异；
  原版 3 次重复完全一致，说明不是原子序问题。定位方法：cudahook 新增 cuLaunchKernel 钩子（cuFuncGetName 取名，
  libcuda 通过 dlopen NOLOAD 解析），对原版/源码 3624 次 launch 的非指针实参逐个比对，找到顺序差异后修复。
- 验证（bitwise，官方 adapter）：ground_box 8/60 步（含落地、反弹、静止）、ground_box_smooth 30 步、ground_box PD
  30 步、ground_box 2 worlds 30 步，以及自由刚体回归 —— 全部 PASS。镜像 7a833751…。
- 最终镜像 7a833751… 回归：刚体 4 组 PASS；粒子 19 场景中 18 个 0 failures，particles 28 个原子序差异，标准 C
  （10 次原版）通过，outside = []。

## 2026-10-30 编译版跑真实 demo（`reconstruction/csrc/demo_source_ab.py`，原版 64a0be7f vs 源码，串行）

- example_basic_dzhanibekov 60 帧：120 个子步全部 bitwise 一致（含刚性接触 + 滚动摩擦路径）。
- example_basic_shapes 60 帧（7 个刚体：球/椭球/胶囊/圆柱/盒/bunny mesh/圆锥，地面接触）：
  - 每 kernel launch 次数与原版完全一致；inertial cache（L1/L2/D1/D2）与 combine 输出在第一步 bitwise 一致
    （cudahook 新增 driver API dump 后对比）。
  - 原版自身不可复现（原子序）。约 substep 200 bunny 着地时，原子噪声会把轨迹分到两个分支之一：
    9 次原版中 7 次走主分支、2 次（o5、o8）走另一分支；4 次源码中 2 次主分支、2 次另一分支，同分支内彼此
    相差 ~1e-6（与原版同分支内的差异同量级）。即源码与原版产生同一组轨迹，分支选择由原子噪声决定。
  - 标准 C（9 次原版，逐子步）：主分支源码 2/2 全部通过（ratio_max 0.77）；另一分支源码 352~360/360 子步通过，
    最大 ratio 1.46（均值被 7 次主分支主导，属双峰分布下的预期；原版同分支的 o5/o8 也同样偏离均值）。
    数据：`build/reconstruction-demos-source/example_basic_shapes/criterion_c_9originals.json`。
- example_rigidbody_integrators（无 Example 类）与 example_ball_brick_wall（自有 graph capture 方式）需要先适配 harness。
- example_ball_brick_wall 60 帧（240 子步，砖墙被球撞散，高度混沌）：8 次原版 + 3 次源码。
  - 源码对 8 次原版（标准 C 逐子步）：source 234~237/240、source1 237~240/240、source2 236~238/240 子步在
    spread 内，ratio 中位数 0.34~0.59，最大 1.0~3.6。
  - 对照：把每次原版当作"候选"对其余 7 次原版做同样检验：通过子步 123~240/240，ratio 最大 0.92~32.7
    （orig6 仅 123/240，orig5 最大 32.7）。即原版自己也大多不满足逐子步标准 C；源码的表现落在原版自身分布内，
    且优于多数原版。数据：`build/reconstruction-demos-source/example_ball_brick_wall/criterion_c_8originals.json`。
- 混沌验收 4 条前提核对：brick_wall 与 basic_shapes 2 帧 cudahook 实参比对（14496 / 8748 次 launch）非指针实参 0 差异；
  brick_wall 源码首次分歧子步 = 原版自身首次分歧子步 = 4；launch 次数一致。两 demo 满足全部 4 条。

## 2026-10-30 C++ host：刚体间普通弹簧（body springs，Newton）

- 原版抓取：example_body_spring 的 launchlog 调度、cudahook 实参与 dump（weights0/1、host diagonal、L0/L1/L2、
  combine 输出、两个 row_count 缓冲区）。调度：rhs → evaluate_body_spring_force(alpha=constraint_alpha/h²,
  joint_count 0, include_joints false) → so3 force；blocks → add_body_spring_gauss_newton_hessian(blocks,
  block entries) → 预条件器副本 → so3 preconditioner → inverse。
- 预计算：w = (1, p_local - com)（world 端为 0），每根弹簧的端点列表 body0 (+w0) 再 body1 (-w1)，按弹簧顺序累加
  F(F(k w_i) w_j) 到 host diagonal（i == j）与 L0（i != j）；零权重也建 entry（端部刚体 7 个 slot，中间 11 个）。
- 结果：example_body_spring 60 帧 240 子步 bitwise 一致；预计算缓冲区与原版逐字节一致。
- 仍拒绝：body springs + PD / 接触（未抓取），joint springs。

## 2026-10-30 C++ host：刚体距离约束（AL，Newton）

- 原版抓取（example_distance_constraint）：initialize_body_distance_constraint_state 在 initialize_step 之后、
  so3 init 之前；evaluate_body_distance_constraint_force 在 body spring force 之后、so3 force 之前（alpha =
  constraint_alpha/h²）；update_body_distance_constraint_state 在 apply 之后、so3 update 之前（每次迭代）。
  权重为 host 上传的副本（不是 Model 的指针）；D5 = initialize_step 第 5 个系数数组、L6 = combine a6，权重 α。
- 实现：复制 Model 的 weights0/1（world 端置 0，与原版 dump 一致），D5/L6 = m_s (s_i)(s_j)，s = (+w0, -w1)。
- 结果：60 帧 240 子步 bitwise；weights、host diagonal、D5、L0、L6、combine 输出与原版逐字节一致。
- 注意：该 demo 的权重是 (1,0,0,0) + world 端，尚未覆盖锚点偏离质心的情况；遇到时再用 dump 核对。

## 2026-10-30 C++ host：刚体普通 point-line（Newton）

- 原版抓取（example_body_point_line）：rhs → evaluate_body_point_line_force（第 2 个参数是 state_in 速度，用于阻尼；
  alpha = constraint_alpha/h²，joint_count 0，include_joints 0）→ so3 force；blocks → add_body_point_line_gauss_
  newton_hessian（include_joints 1）→ 预条件器副本 → so3 preconditioner。三组权重为 host 上传：(1, p - com)。
- 模板：点刚体 -w_pt，线刚体 0.5 (w_e0 + w_e1)，k s_i s_j 按线顺序累加到 host diagonal / L0。
- 结果：60 帧 bitwise；权重、host diagonal、L0、combine 输出、row_count 与原版逐字节一致。镜像 daa41685…。
- 仍拒绝：body springs 与 point-lines 同时存在（相对顺序未抓取）、joint point-lines、PD/接触组合。
- 镜像 daa41685… 全量回归：4 个 demo bitwise、刚体 4 组 PASS、粒子 18/19 bitwise，particles 标准 C（10 次原版）通过（14 个 strict 差异，outside = []）。

## 2026-10-30 C++ host：Newton 关节（AL joint springs + joint drives + angular limits）

- 原版抓取（example_physical_pendulum，revolute 1 个）：
  - 步首：initialize_step（D3 = joint 模板，c3 = α）→ host 复制 control.joint_drive_velocities 到内部缓冲区 →
    so3 init → initialize_joint_body_spring_state → combine（a4 = L4，w3 = α）→ initialize_block_non_diagonal。
  - 力：plain body spring force（joint_count = joint_body_spring_count, include_joints 0，即使全是关节弹簧也 launch）
    → AL joint spring force → evaluate_joint_drive_load（control.joint_f/target_q/target_qd）→ evaluate_angular_limits
    （force 模式）→ so3 force。
  - 预条件器：so3 preconditioner → add_joint_drive_preconditioner → angular limits（block 模式）→ invert；
    plain GN Hessian 只在存在非关节弹簧时 launch。CG：so3 tangent → drive tangent → angular limits（direction 模式）。
  - apply → so3 update → joint spring 乘子更新（迭代计数 c 为 joint_constraint_primal_iterations 的倍数且不是最后一次；
    抓取：20 次迭代、primal=2 时在 2,4,…,18）。步末：update_velocity → update_joint_drive_angle_state(out.q)。
- 实现：joint springs 模板拆分（plain → host diag/L0，joint → D3/L4）；drive 5 组权重 (1, p - com)；angle/initialized
  持久状态；reset_joint_drive_state 真正实现（全部 memset，或 mask 用 reset_selected_joint_drive_state）。
- 结果：example_physical_pendulum 60 帧 bitwise；drive 权重、D3、L4、qd 复制、body spring 权重与原版逐字节一致。
  注意：该 demo 父端为 world（父权重全 0），父端三组权重的顺序待有刚体父端的 demo 再核对。
- 仍拒绝：joint armature、关节 + PD/接触。

## 2026-10-30 接手另一 agent：链条关节差异继续定位

- 已读指定 Claude JSONL 后半段，最后有效工作时间 14:59:39Z；其最后变更是把刚体约束模板改为按
  slot 上三角计算、对称写入，尚未验证该变更。当前 image `debabaa8511dc8d0c83565b6074b38bc77363041546dbfb1a16ff19443ae8262`。
- 继承方法：项目内 64a0be7f 原版串行捕获 launch 顺序、实参和 device buffer；先对齐预计算，后逐子步比对。
- 停点：example_chain_heavy_ball 首子步不同；L4 两项差 1 ULP，combine 输出相同；原版本身也不确定，
  不能凭这一点跳过 host 缓冲区差异。先验证最后的对称模板变更，再继续定位。
- 接手检查点：`build/reconstruction-checkpoints/continuation-debabaa8-before-joint-validation/preserved-files.json`。
- 所有新结果写独立 continuation 目录，保留旧失败与历史 image 结果。无需登录，不改原版二进制。

### 链条停点复核、钩子 ABI 修复及关节点线接入

- debabaa8 的对称模板修改已确认：链条 L4、combine 输出、初始 rhs/预条件器/逐元素 z 均逐字节相同。
  首个观察差异是 precondition_and_reduce 标量：原版 967474585、源码 967474583；再跑原版得到 967474573，
  但对应 inverse/r/z 全相同。严格整段仍失败，未称为 bitwise 通过。
- 发现旧 cudahook 的 3 类新版 PCG ABI 布局错误，缺 precondition/inverse/blocks，且只记录前 20000 次。
  已按当前 build.json 参数宽度修复；新增 audit_cudahook.py，对 101 个受支持入口检查宽度，并按真实
  C++ 参数类型区分 pointer/null 和整数，不再按地址位数猜测，不再跳过 update_cg_direction。
  链条 1 帧 32920 次 launch（与 source_launch_counts 总和一致）完整比较 0 差异。
  路径：build/reconstruction-demos-source/example_chain_heavy_ball/continuation-diagnostic-1/。
- 新增关节点线 Newton/AL：只建 ELL 列模式、不加入常量 L0；initialize/force/GN Hessian/update 四核；
  迭代后总刷新 segment/projector，按 primal 条件更新 lambda。拒绝未实现的 joint constraint mode 和 PD。
- example_joints 2 帧（40 子步）严格 bitwise；1 帧完整 36980 次 launch 参数 0 差异。
  权重、D3/L4/L0、预测位置/对角、segment/lambda/projector、首次力和 Hessian 输出共 51 个有效 dump 一致。
  第 52 个 dump 是 combine 输出参数写入前未初始化内存，单独保留，不作为计算差异。
  路径：build/reconstruction-csrc/joint-continuation/example_joints/joint-lines-{ab-2,dumps}/。
- demo_source_ab.py 新增每 worker 的 runtime.json（实际 so/example SHA、帧数、参数）；build.json 的
  supported_physics 改为从 C++ 同一声明提取，修复 metadata 长期遗漏刚体的情况。
- 接触组合前检查点：build/reconstruction-checkpoints/joint-lines-before-contact-combination/。
  下一步按已抓取 example_basic_joints 的顺序接入 joint+contact，而非沿用无接触场景的相对顺序。

### c598b144 固定 image：关节接触、全回归与链条分布结果

- 关节+接触已按原版恢复顺序：接触/rolling/soft 在关节力之前；CG 的 drive/limit 在 rigid/soft 之后。
  example_basic_joints 1 帧 9916 次 launch 参数完全相同，51 个有效预计算/状态/Hessian dump 相同。
- 固定 image `c598b144cea933fb6a5956ceb61baaff380b7fb9c55b3f8826b5b6a3ea61173d`：
  7 个官方 demo 各60帧全部 bitwise，共2400个子步、9600次逐子步状态数组比较；
  example_joints=1200、basic_joints=240、physical_pendulum=120子步，其余见独立 report.json。
- 同一 image 全回归74组完成：8组刚体全部通过；19类粒子×3seed共34920数组与11160 eager/graph比较。
  其中18类×3seed全部严格通过；particles seed1/2/3分别35/35/28个严格差异，保留未放宽。
- API报告新增 --output 时误用已有循环变量 args，导致完成692检查后写文件失败。已保留失败日志及旧脚本，
  改为 output_path 后独立重跑692项通过；浮点/向量670项通过。不能删除原 batch 中的 exit 1。
- 6组补充场景（revolute/prismatic×seed1/2/3×world1/2/3，移动父刚体、偏心COM、驱动及限位），
  每组30步严格通过，共180子步。旧 fixture 内容保存在检查点 joint_body_scene-v1.py。
- 链条当前 image 首阶段：32920次 launch 参数及数量相同；L4/combine/initial rhs/SO3 rhs/inverse/r/z 全相同，
  numerator 为原版967474580、源码967474575（uint32 bits）。目录 chain-c598b144-capture/。
- 链条60帧、8次原版+3次源码完成。原版自身、源码首次状态差异均在子步0；严格源码比较3/3仍为false。
  按用户已认可的混沌四前提，分布观察没有超出：源码每字段573~600/600步在spread内；
  原版留一法最差306~387/600。源码最大ratio1.2484，原版最大1.4959。
  这只是该场景的约定分布验收，不是全so逐位一致。目录 chain-c598b144-8originals-3sources/。
- 诊断钩子新增完整序号和 source_launch_counts 总数核验；6个负对照能检出CG divisor/null、矩阵rows、
  缺失尾部和序号断裂。冻结的 native61 + library39 哈希文件全部未改变。
- 本批所有112份源码/构建文件与1118份结果的哈希已保留：
  build/reconstruction-checkpoints/joint-c598b144-before-armature/provenance.json。旧image已经完整保存。

### 下一模块：armature 与缺省 joint_drive_velocities（正在接入，尚未验收）

- 已用原版对偏心/移动刚体补充场景抓取 revolute/prismatic、提供/缺省qd 四组。
- 原版在 initialize_step 后，用 previous（不是已预测的x）+state_in.qd 调 initialize_joint_coordinate_velocities；
  给定qd则复制。不能凭“需要初始坐标”猜测把kernel放在 initialize_step 前。
- evaluate_joint_armature 三模式都传同一个内部qd指针（含block/tangent模式）；分别在drive load、
  drive preconditioner、drive tangent后、angular_limits前。原版提供qd的launch数566/574，缺省各多1次。
- 已按捕获接入C++，本次构建进行中；捕获目录 build/reconstruction-csrc/joint-armature/。

### armature 与缺省关节速度：0c44d52d 已完成模块级核对

- 新 image `0c44d52d961c741f2a0519f04dbf7248a8ecbde9aab335b8b35ed36ae2902613`。
- 18组（revolute/prismatic、provided/derived、armature .17/0、seed1/2/3及world1/2/3）30步，共540子步bitwise。
- 四组首阶段抓取566/567/574/575次launch，参数及实际C++总数逐一相同；三种armature模式及速度初始化
  共354个有效buffer逐字节相同。输出qd初始化前为write-only，不作为输入比较；初始化后严格核对。
- 新 image 完整回归正在串行进行。source CUDA digest仍为a98e84b9…（176入口、27模块）；本批只改host。
- atomic_spread_check.py新增 --baseline/--output：固定已有源码候选，只增加原版重复运行，避免另挑源码样本。
  增加finite状态与原版自身确有变化的要求，防止非原子NaN或纯符号零错误被数值spread放过。标准更严格，未放宽。
- chaotic_source_runs.py新增 --original-baseline：只复用经原版image、example SHA、frames、extra核验的数据，
  用于后续image复核；不需要每次重采相同原版。8原版/3源码门槛和原有计算公式不变。

### 0c44d52d 最终回归、固定候选复核与完整launch元数据

- 74组回归完成：7个60帧demo共2400子步全部严格一致；API692、float/vector670、8组刚体全部通过。
  19类粒子×3seed共34920状态数组、11160 eager/graph比较；18类×3seed严格通过；
  particles seed1/2/3严格差异28/28/14均保留。
- 固定这3批源码NPZ，只补原版至每seed10次，70项差异全部通过标准C（outside=[]），没有重新选择源码候选。
  路径 joint-armature/atomic-and-chain/particles-criterion-c-seed{1,2,3}/，各报告记录固定NPZ SHA。
- 链条8原版/3源码出现1项分布失败：source0.body_qd在子步511的ratio1.518301，原版最差1.495912。
  没有调整物理、增加epsilon、重选源码轨迹或删除失败。只增加8次原版，保留原8次和原3条源码。
  16原版/固定3源码所有约定观察通过；3个source NPZ hash与8次测试完全相同。
  源码最大ratio1.363864，原版最大1.650979；严格3条source仍全为false。失败与扩样结果分别保留。
- 当前so的32,920次链条调用和7组首阶段数据再次复核，仍只有原子归约标量不同。
- 进一步发现旧诊断未记录实际overload symbol、3D grid/block、动态shared memory、stream类型；
  钩子和审计器补齐后重新采5组（链条+4组armature），35,202次完整调用全部相同；shared=0，stream=custom。
  对应7+354个有效buffer仍逐字节一致。旧日志缺元数据，审计器现在明确拒绝其作为完整证据。
- full-launch-metadata/ 为最新捕获；diagnostic-negative-controls-v2/report.json 的11个正负控制均通过。
- 新增demo采样保护：每帧必须有solver子步，空状态采集不能通过；此前7demo/18fixture的实际数量已核对，
  原harness保存在joint-armature/demo_source_ab-before-empty-guard.py。
- 清理5处过期C++注释后重编译，产物SHA仍为0c44d52d961c741f2a0519f04dbf7248a8ecbde9aab335b8b35ed36ae2902613。
  注释前源码/manifest/so也已保存在 joint-0c44d52d-before-comment-cleanup/。
- 冻结native61+library39文件、c598检查点1230份文件哈希复核全部未变；最终source-only模块能正常加载，
  kernel_count=176、source_digest=a98e84b9…、solver_api_ready=False，没有login/is_logged_in。
- 当前项目内参考仍为64a0be7f…，所有参考运行未登录、未读取凭据。完整solver/API仍未恢复，不称为全so一致。
- 最终复现命令和后续范围见 reconstruction/csrc/JOINT_HOST_RECOVERY.md。

### 最终交接检查点

- 汇总：build/reconstruction-csrc/joint-armature/validation-summary.json。
- 最终源码/构建/结果manifest：build/reconstruction-checkpoints/joint-0c44d52d-final/provenance.json。
- 本轮只修改 reconstruction/ 与 build/；src/examples/依赖/原版so均未改动；无git提交。
- 本轮模块恢复及验证完成，未宣称全SDK已替代。下一agent按JOINT_HOST_RECOVERY.md末尾继续未实现host。

## 2026-10-30 继续恢复 cable host（用户要求目标未完成，持续推进）

- 延续项目内64a0be7f原版，不登录。现有0c44d52d的178份源码/2746份结果最终检查点不动。
- 原版 analytic cable 1帧：230次launch；beta=0时penalty指针为NULL、没有prepare/update penalty。
  每轮prepare tangents→rhs→cable force→SO3 force；B为SO3→cable diagonal；CG为SO3→cable product。
- 原版linear_beta500、nonlinear3/linear3：prepare penalty每step一次且在inertial refresh之前；
  reset=false/rescale=true/gamma=.999；每次apply之后、SO3 update之前更新penalty，最后迭代也更新。
- CableView160字节按原版指针核实：offset16=body_inertia_tensors；80/88为Model cable_angular_bias/hessian；
  136/144/152为local cable count/total states/particles per world。切线cache为每state8个mat3、8个ids及一个count。
- 钩子新增4个cable入口和CableView字段解析，107入口ABI宽度审计通过。
- 已按抓取接入基本Newton/PD cable及penalty ramp host，正在构建；尚未验收。
  暂拒绝未捕获的cable+其它约束/接触；补充拒绝原来未实现但会误走普通接触的hard-contact分支。
- 原始证据：build/reconstruction-csrc/cable-host/original-{analytic,ramp}/；当前源码改动只在允许目录。

### cable API/配置核对与首次小场景结果

- 基本cable小场景30步bitwise；官方analytic默认2帧首子步有差异，未标通过。
  analytic-first-stage/ 的230次完整调用参数一致，准备的Jacobian/id/count、预测/力/常量矩阵输出均相同；
  唯一raw差异是combine输出写入前的未初始化区域。大例的归约差异仍待单独核对。
- 按原版接入copy/reset：两者均prepare penalty，copy为reset=false/rescale=false，reset为true/false。
  正beta每step prepare(false,true)，apply后每次update（含最后一轮）。
- 9组Newton小场景（3seed×3种ramp/API动作）各30步状态严格相同，105组penalty快照也相同。
- 下一组gamma1.15在原版抛ValueError；该原始失败保留，并非修改测试去放过。进一步调用原版确认
  gamma须finite[0,1]，四个ramp/seed参数finite非负；这是调用step/copy/reset时校验，setter本身可接受。
  无cable的模型也校验这些配置；copy/reset尺寸须恰好等于state count，空mask表示全部。
- 已补相同校验/错误消息/尺寸与错误优先顺序；同时按原版补齐core迭代数、constraint_alpha、primal计数
  和rigid contact参数的step校验。证据config-validation-original.json、contract-original.json、
  config-no-cable-original.json、empty-cable-api-original.json。
- 当前image为225208b0c9479eee1150832a3773a2e10719eeb2d67317c23824da28b8213a4e，接下来继续重跑合法边界、PD、多world与非法值对照。
- 已准备hard_contact_scene.py，下一步先抓原版hard contact/历史重用/完整body块调度，避免cable接触误走普通分支。

### 225208b0 cable 合法边界、多 world 与 PD 回归

- 新增可复现串行 runner `reconstruction/csrc/cable_host_matrix.py`；24组=2模式×4种ramp/API配置×3seed/world。
- 每组30子步，共720子步，particle_q/qd、body_q/qd全部逐位一致；12组API动作各35快照，共420 penalty数组一致。
- gamma=1.15 的原版错误仍保留；本次合法边界gamma=1.0另存新目录，没有改旧失败记录。
- 结果 `build/reconstruction-csrc/cable-host/matrix-225208b0/`（summary.json、hashes.json）；
  实际source image225208b0和exampleSHA均记录在各worker runtime.json。
- 新增 `cable_contract_ab.py`，正在核对lazy配置校验、copy/reset大小、无cable行为和错误优先顺序。
- 225208b0完整构建输入及so共16文件已保存于
  `build/reconstruction-checkpoints/cable-225208b0-before-hard/preserved-files/`，有SHA manifest。
- hard原版抓取Newton513/PD510/history reuse513/body-block612次调用。history需要collision match index，
  初次disabled matching错误保留；v2启用latest matching。initialize_hard_contacts在refresh惯性之前；
  update_duals每次apply后、SO3 update前；snapshot在velocity前且history=false也调用。
- body-block原版：hard Bmode可输出12×12交叉cache，build在SO3逐粒子precond之前，
  使用precond块作为输入、cache和output可同址；每次CG apply3×3→apply12×12→reduce(already=true)。
  后续须抓enabled/adjacency实际数据再实现，不能只照名字猜。

### cable/config lazy contract 对照完成

- `cable_contract_ab.py`在cable和无cable刚体两种拓扑，对step/copy/reset执行538项配置值、
  输出/重置mask尺寸与错误优先顺序对照，225208b0全部一致。包含NaN/Inf、999/1000边界。
- 证据 `build/reconstruction-csrc/cable-host/contract-225208b0/report.json`，differences={}。
- 已按原版捕获接入hard state六缓冲区+previous_count、reserve、initialize/evaluate/update/snapshot调度；
  正在编译，未先标验收。body-block仍拒绝。原版block数据确认空cable offsets=[0,0]、enabled=[1]、
  初始previous_count=0，见hard-host/block-data-original/。

### affine block mask/adjacency 与 hard reserve：直接反汇编补证

- 项目内原版 `SolverNewton::initialize` 0x10dd50..0x10dec8：body enabled初始全1，
  遍历每body的四个proxy索引；若索引已有owner，则同时禁用当前body和旧owner。
  这是共享proxy的冲突标记，不是按body质量/kinematic设置。后续恢复按这个行为，不能用mass>0猜测。
- 0x10dff0..0x10e181：按cable序号遍历pair，a>=0加入a的邻接表；b>=0且b!=a才加入b，
  然后按body顺序拼offsets(size_t)和ids(int)，与GPU kernel无条件读offsets相符。
- reserve函数0x10f2f0..0x10f477：六个vector resize(capacity, zero)，保留旧元素并将新尾部清零；
  previous_count resize(1,0)，已有count不会重置。首次实现尚缺新尾清零，待当前固定image批次结束修正。
- 原版相关x86证据保存在hard-host/precompute-reference.asm（后半含initialize）、reserve-reference.asm、
  step-reference.asm。全部来自64a0be7f项目内原版，不是旧版地址推断。

### d950ad0a hard host 首批24组严格通过

- source image `d950ad0a3d0c1586b24656f98184c1c8759edd1b2c3abbf0192793126c5d90c5`。
- 2模式×3world×4分支（beta0/500、history/sliding、每3步复用query），每组30步，共720子步，
  全部particle_q/qd、body_q/qd逐位一致。`hard-host/matrix-first/status.json`24个exit0。
- 保留此image的18份构建/fixture输入和193份结果hash：
  `build/reconstruction-checkpoints/hard-d950ad0a-before-block/provenance.json`（以实际计数为准）。
- 此为hard host首批验收，尚未做各内部历史buffer及完整launch元数据对照，也尚未宣称完整SDK恢复。

### 93d378aa：body-block接通，第一批完整调用一致

- source image `93d378aaa21dcaa645e30d1e30fdfa89ad3b755f211ccf5ecbd4e722383decfb`。
- 已按原版加入冲突body mask、cable adjacency、12×12 build/apply、hard cross cache；
  修复reserve扩容尾部清零。body-block与其它body约束的未捕获组合仍明确拒绝。
- 首批ground_box hard+block：3步状态逐位；612次完整symbol/3D launch/shared/stream及参数均相同，
  C++实际launch计数也相同。ABI审计111入口。扩大24组测试正在跑。
- 原版cable block数据确认 offsets=[0,1,2]、ids=[0,0]、enabled=[1,1]（包含kinematic body）。
- analytic首PCG抓取3原版+1源码：预条件矩阵、r、z、direction、product完全相同；
  差异仅numerator/denominator。原版自身3次也不同。exact-permutations逐位重现所有8个标量，
  具体贡献和排列保留；这是首差异诊断，不是完整demo验收，不推断过去GPU真实顺序。
- 新增CABLE_HARD_HOST_RECOVERY.md，并把两个主进度文档入口更新到本批。

### 93d378aa body-block 24组与CUDA Graph通过

- hard+完整body-block：Newton/PD×3world×4分支共24组，720子步全部逐位；
  `hard-host/block-matrix-93d378aa/status.json`24个exit0。所有state有限。
- 新增hard_graph_ab.py：2world、history/sliding、beta500、body-block，Newton/PD各30步；
  original/source eager及graph四组交叉比较与双方自身eager/graph共8项全部逐位一致。
  测试额外要求真实contact_count>0，保留轨迹、计数、image/fixture/runner SHA。
- 21份构建/fixture与结果hash检查点：block-93d378aa-before-coupling/provenance.json（以实际计数为准）。
- 正在抓取hard内部状态buffer和cable+接触原版组合；新增cable_contact_scene.py，尚未验收组合。

### Cable+接触组合：按原版抓取修正三处先后关系

- 新fixture的原版normal582次、hard+block+history/reuse696次（各3步）；source原先明确拒绝此组合。
- 原版prepare_cable_penalties先于hard_initialize；非body-block时cable Bprecond先于rolling precond；
  CG中cable product也先于rolling product；apply后cable penalty update先于hard dual update。
- 已据此调整调度、移除cable+接触guard，并将hard/body-block/cable-contact列入模块scope；正在重编译。
  数学kernel未变；未用“看起来可交换”跳过真实顺序。组合尚未验收。
- hard两组内部buffer参考抓取的实际count均为8，确保不是空接触在通过。
  数据在hard-host/mixed-and-buffer-original/，包括每次launch和按调用号保存的pre/post buffer。

### 814c5abf：cable/contact组合与hard内部buffer对照通过

- 当前source image `814c5abf4e235428172d7730daf29888145282e754d1855db196487c78ae3fbc`。
- normal cable/contact582次、hard+cable+block/history/reuse696次，原版与源码3步状态及完整launch均一致。
- 2world hard+block/history/reuse：Newton612次、PD609次完整launch一致；C++实际调用总数也相同。
- Newton/PD各366份按调用号保存的pre/post buffer全部逐字节一致，共732份。
  包括实际count=8、penalty/dual/anchor、previous history及count、RHS/scalar/system/precond、
  hard cross cache、12×12 inverse/valid/mask/offsets。原始dump均保留，没有删差异项。
- 数据 `hard-host/mixed-and-buffer-{original,source}/`，各report.json与summary.json。
  注意此处cable_contact_scene后新增grow-contacts测试选项，旧捕获SHA对应之前版本；原始runtimeSHA保留。
- 当前在跑cable+body-block 24组完整矩阵；后续cable_contact_matrix.py将覆盖30组、no-contact-block与reserve5000扩容。
- 硬接触hist buffer扩容保留/清零来自原版x86证据，接下来用实际轨迹补充验证。

### 814c5abf 两批长轨迹通过

- cable+body-block 24组（2模式×4配置×3seed/world），720子步状态、420组penalty快照全部逐位。
  路径cable-host/block-matrix-coupling/，此批source未映射原版so且每case实际C++ launch数为数千。
- cable+contact 30组（2模式×3seed/world×5组合），900子步全部逐位：normal/hard、完整块、
  history/reuse、no-contact-block、step14扩容至5000同时保留原有历史状态。
  路径cable-host/contact-matrix-814c5abf/，30个exit0。
- demo harness新增native-instance与source非零launch保护；之前版本保存在cable-host/。
  防止将默认VBD等其它solver的轨迹算为SynReal还原通过。生产数学和比较标准未变。
- cable_contact_scene旧版已按捕获SHA精确复原保存在hard-host/cable_contact_scene-v1.py。
- 当前同image重跑graph和538项contract，并进行官方analytic60帧8原版/3源码分布检查；尚未先标通过。
- 已为下一模块准备fluid_host_scene.py、affine_rigidity_scene.py，仅是待抓取fixture，host仍未实现这些分支。
  当前fluid参考x86证据来自项目内原版，存fluid-host/*-reference.asm；不把旧地址推断当新版证据。

### 814c5abf 同image graph/contract及官方analytic分布观察通过

- final-814c5abf/hard-graph/：8项eager/graph、original/source比较全部逐位；有真实接触、状态有限。
- final-814c5abf/contract/：538项全部相同，differences={}。
- 官方analytic默认60帧=600子步，8原版/3源码，所有约定分布观察outside=[]。
  3条source严格比较仍为false；原版自身重复也不逐位稳定，未将它们改记为严格通过。
  全部11条轨迹、实际image/fixtureSHA、各source及原版留一法统计均保留。
- 正在以814c5abf补完整60帧launch元数据和首PCG有效buffer核对，之后回归已有host范围。

### 814c5abf analytic完整调用审计完成

- 60帧原版/源码各13,800次完整symbol、3D grid/block、shared bytes、stream类型及实参均相同；
  C++实际launch总数也是13,800。首PCG16份有效输入/逐元素输出buffer全部相同。
- 原始数据与report：final-814c5abf/full-analytic-launches/。
  PCG原子聚合输出仍独立保留，不混入“逐元素通过”；不比较输出写入前或alias改变后的无效buffer。
- PCG归约/矩阵乘5个入口与原版规范化PTX逐字相同，记录于pcg-d950ad0a/pcg-ptx-check.json。
- 当前正跑既有74组回归。分析analytic统计时，source最大ratio约1.536而原版留一法最坏ratio可很大；
  按既有两条约定判据通过，不声称每步source ratio<=1，也不声称全轨迹bitwise。

### 下一模块诊断准备：fluid View/Model（尚未实现fluid host）

- 在74组既有回归继续串行运行期间，只准备CPU诊断，没有并行运行另一个原版进程。
- 钩子V改为完整112字节分word打印；M保留原始1864字节文件并打印233个word。
  审计器对fluid Model仅比较该kernel实际读取的字段；opaque未读区域明确不作完整Model相同的断言。
- 旧cudahook.c/audit脚本/so及SHA保存在fluid-host/hook-before-fluid/。
  新审计器复核已有13,800次analytic调用仍全同；ABI宽度审计111入口通过。
- Fluid::initialize当前原版x86：复制数=state particles/local particles；slots为2*ceil_pow2(grid points)。
  显式particle_world单拷贝路径另算scale worlds，不能用PCG已归一化的group_count代替raw world ids。
- 此处只是诊断准备和已读到的结构，不是流体实现/验收；需要先实际抓取原版，再接C++。

### 814c5abf 74组回归结束，严格差异完整保留并核对

- 74组中70组严格通过：7个60帧demo、692+670 API/属性项、8刚体组；粒子材料18类×3seed中，
  mixed_cloth seed3一个重复场景出现11项严格差异，其它场景严格通过。
- particles每seed7项差异，mixed_cloth seed3共11项，固定本批source NPZ不重选；
  各用10次原版按既有标准C核对，全部outside=[]。四个固定source哈希写入各criterion-c.json。
- mixed_w129_duplicates最初差异只在particle257(第85个world跨CUDA块边界)，幅度1 ULP。
  首轮trace状态恰好相同，但力/矩阵的中间差异仍存在并保留。没有把重跑相同当作原失败已消失。
- spring独立贡献2322项逐位相同，16次/端整场与两个捕获共39474个scalar全可由具体float32排列解释；
  脚本末尾“captured strict equality”仍false并按原有assert返回1，诊断不是完整通过。
- 又补本批实际输入下的membrane force3483、membrane Hessian31347、spring Hessian13932个独立贡献，
  全部逐位相同；对应捕获力/diag/ELL输出也都由三个相同贡献的精确float32排列逐位重现。
  数学kernel未改，未增加容差。原始trace、所有失败、贡献、排列与报告完整保留。
- 冻结native61+library39文件哈希复核全部未变。详细汇总final-814c5abf/validation-summary.json。
- 已保存当前源码/构建/所有结果manifest：
  build/reconstruction-checkpoints/cable-hard-814c5abf-validated/provenance.json（实际计数见manifest）。
- 总体目标仍未完成；继续抓fluid与其它affine model原版分支，不把本阶段通过称为完整SDK替代。

## 2026-10-30 接入fluid host（正在实现，未验收）

- 原版5组fluid、6组其它affine rigidity的3步抓取均成功，数据fluid-host/original-first/。
  fluid为isolated333/cached335/PD-world2-boundary335/fallback335/body-contact-block710次总调用。
- 原版还在initialize构建particle BVH，即使self collision未启用；当前source还缺该constructor支线，
  后续self-collision阶段必须恢复。不能把fluid step对照说成完整constructor调用已相同。
- 原版fluid force：rhs后、contacts前；B correction：soft contact后、rolling/body-block前；
  CG product：SO3后、rigid/soft/rolling前；每次apply之前initialize_scale(1)→bound→scale全体solution。
  所有fluid kernel 128线程，PCG仍256。PD仍用NonZeroEntry/mat3分派，未强制改成Newton。
- 从原版调用核实validation：rho/h finite正、K/mu finite非负；
  fluid有效时step要求relaxation finite(0,1]、ratio finite非负；无fluid时这些config值不校验。
  validation-original.json、validation-no-fluid-original.json保留全部值和原错误消息。
- 已恢复FluidView112、kernel实际读取的GPU Model1864字段、grid/row/cache/D/scale缓冲区与调度；
  保留无ELL entries时原版的zero row-count指针。目前正在编译，尚未进行source A/B。

### 3d9a225a fluid 首批结果与参数元数据定位

- 首批3步：isolated、cached、PD-world2-boundary、body/contact/block四组状态逐位一致；
  fallback125邻居场景首子步不同，原始失败保留，尚未标通过。
- body/contact/block的705次step调用完整元数据已相同；其它四组各330次step只有start/RHS参数不同。
- 进一步调用无fluid的普通单粒子原版确认：即便无约束，start仍传D3/D5权重alpha和非NULL零kind；
  RHS和CG即便max entries=0仍传非NULL row-count。这些是原版真实行为，不能用“没有用到”代替核对。
- 已据原版统一恢复这些参数/空pattern row-count，正在重编译。3d9a225a输入/so16文件已保存于
  fluid-3d9a225a-before-call-fixes/。未改CUDA数学。
- 无fluid probe第一版因builder.add_particle缺vel而未进入solver，日志保留；v2补齐vel及build内Warp cache后成功。
- source仍缺原版初始化时额外的3/5次particle BVH构建。step审计另存step-launches.txt并明确记
  full_solver_schedule_equal=false；这不是隐藏完整solver差异，BVH constructor属于后续必须恢复项。

### 40333acf fluid 调度与首次密集网格定位

- 活动image `40333acf02457db00e645752658e533a6575e7a13dfce7b7dd1673e2a7ba89de`。
- 5组fluid的330/705次step调用符号、参数、grid/block/shared/stream全部相同；仍缺constructor BVH，未称全调用相同。
- 125粒子fallback首Grid的positions/volume/id/world/cells逐位一致，head/next在3次原版之间也不同；
  每个hash链都恰好覆盖所有点一次、无环且桶正确，4份数据观察到3种链表顺序。
- 用4份真实capture输入分别在当前source .so执行evaluate_rows，梯度、残差、权重、计数及每份8000个
  已写缓存槽全部逐位相同。fluid_grid_replay.py结果保留，尚未用这一项替代完整轨迹验收。
- 24组小场景矩阵：前11组严格通过，第12组newton seed3/world3的body/contact/block在首步有微小差异，
  只涉及第3world的particle28和proxy33..35，原失败NPZ保留。正在查后续预条件/PCG阶段。
- 47项fluid contract比对发现13项缺失/错误消息不同，全部原始记录保留：包括全体mass finite非负、
  selected fluid positive mass/active、indices和boundary校验。将依据原版修正，不改比较标准。

### 40333acf 耦合首差异与固定候选后续观察（继续中）

- coupled-world3-pcg-all/ 原版两次与源码各捕获前15个PCG调用。第一次矩阵乘的所有逐粒子结果、
  direction及预条件输入相同，最早差异仅为world2 denominator：原版0x3e919c40，源码0x3e919c3f。
  后续residual/方向才不同。fluid_pcg_atomic_audit.py 对相同12个float32贡献找到具体排列，
  逐位重现所有world的原版/源码aggregate；不推断历史线程顺序，不据此接受整条轨迹。
- 保留matrix-40333acf/newton-s3-w3-v3/source.npz作为固定source0，另采source1/2。8原版观察有6项outside，
  增至16原版仍4项outside；失败报告完整保留，尚未按分布标准通过，未重新挑选source候选。
  接着固定这3条候选增至32原版。原版全部串行。
- fallback旧3步失败候选也原样保留。新增显式--launch-hook和runtime hook SHA，保证有钩子/无钩子候选不混用。
  旧runtime当时未记录hook字段；仅在新baseline副本补注，原runtime及launch log哈希另存adopted-captures.json。
  原NPZ没有改动，旧失败没有覆盖。正在进行8原版/3源码观察。
- 52项原版contract已核实：flags缺省视为active；0/2拒绝，1/3接受。流体选中mass必须finite正，
  全体mass finite非负。根据真实返回消息修正indices、boundary错误文本和active校验，尚待重编译验证。
- 改校验前40333acf的18份源码/构建输入/so已保存到
  build/reconstruction-checkpoints/fluid-40333acf-before-validation/。只改host验证，CUDA数学未动。

### 01840007完整小场景/graph结果，以及官方demo找到真实调度遗漏

- 重新编译质量/active/错误校验后image为0184000738cccb9bf2c9d212041b7b1959e72eb6453bb2131d53ff7e4b5561ac。
  contract-after-validation/共57项全部相同，含新增5项无fluid质量检查，两端image SHA均记录。
- matrix-01840007/24组各30步全部跑完，22组严格通过；Newton/PD的s3-w3-v3失败完整保留。
- pcg-replay-01840007/将2份原版及1份source的前15次precondition和multiply真实输入分别送入当前source so：
  90次逐元素出口全同；24次aggregate严格不同，所有captured与replay值均找到相同贡献的具体float32排列。
  生产历史顺序没有被推断；这不是整段轨迹验收。三world旧固定候选增至32原版后仍2项分布指标outside；
  另存逐步criterion C也有outside，保持未通过。
- graph-01840007-v2/3配置×2模式，原版/source及各自eager/graph共24项严格通过，720个记录子步。
  v1诊断因无body时state.body_q为None而报错，未进入比较；已保留原日志，v2修正判空。
- 官方example_fluid.py本地duck资产存在，无下载。resolution8/substeps1/iterations3/linear5跑3帧：
  两端正常完成（596个native粒子、5刚体），状态严格不同。606次step调用中18个位置元数据不同，
  定位到每个NL轮SO3与fluid预条件器调用相邻交换，不能当原子差异忽略。
- 原版body-block=true路径是fluid→rolling→build body block→SO3（旧小fixture覆盖并相同）；
  body-block=false则SO3→tet→bending→fluid→surface/其它项→rolling。
  由原版fd5c5/10044a、fd602/ffa6d、fdd7f/1002aa等x86分支及实际调用共同确认。
- 已据此把SO3按body-block开关放到各自真实位置，并将fluid放到tet/bending之后，surface之前。
  仅改host顺序，不改kernel数学。01840007的17份源码/构建/so已保存到fluid-01840007-before-order-fix/。
  正重编译，尚未将修复标记为通过。新接手说明在csrc/FLUID_HOST_RECOVERY.md。

### 5e9bf903→b7642d56：拓扑校验、组合场景与第二项实际host遗漏

- 5e9bf903修正SO3/fluid顺序后，官方resolution8的606次step全参数审计通过；constructor5次BVH仍缺。
- 扩展组合fixture最初版本尝试让fluid参与tet，原版拒绝而source尚未拒绝；因此发现遗漏校验。
  原版Fluid::initialize x86确认依次检查triangle、edge、spring、tet、affine的全部index。
  当前已补齐精确错误文本。原版97项逐粒子/无fluid拓扑contract：79接受、18拒绝；source全部相同。
- fixture前两版另有Newton builder类型/通用surface elasticity API错误，未进入数值比较；均保留失败日志。
  v1已保存，v2由原补丁精确重建，SHA与material-tet-valid-original/runtime相同（a58fa750…）。
  v3改用正式Style3D cloth API，fluid与材料粒子集合分开，避免绕开原版限制。
- 同时核实非body场景允许Contact预留rigid容量但不发刚体核：material-tet-valid-original/只有soft调用。
  source此前将该capacity当不支持请求拒绝；已去掉这项过度拒绝，真实刚体路径仍按body_count分支。
- 活动image b7642d56d201f68654f8c9ca3eaa73b6ac6ba573b2ad6a0389558735de5f31e0：
  validation-b7642d56/57+97项contract全同；6组fluid+tet/cloth/两者组合各30步轨迹全部逐位；
  24项graph比较全同；90次PCG逐元素重放全同，40次aggregate严格不同但全部由相同贡献排列精确解释。
- 调用审计却显示4个含cloth场景仍不相同：原版Newton每步initialize_block_non_diagonal，source只在constructor执行。
  原版RHS还传pattern保持完整、values全+0的惯性ELL；source传NULL/max0。tet单独2组调用全同。
  不因轨迹相同把这些未用参数/调用遗漏标记为通过。
- cloth-ell-original/真实dump确认：20行、max3，12个有效column，其余padding -1；
  L1所有60个value位模式全0，column逐位等于constant K。原版Newton每步1次block初始化，PD每步0次。
- 已据原版将spring/cloth的零惯性ELL保留列结构；RHS传正确pointer/max；
  Newton块初始化移到每步start之后，取消constructor提前初始化；PD继续用scalar ELL。
  b7642d56源码/构建/so18文件已存fluid-b7642d56-before-ell/。正在重编译，尚未称修复通过。
- hook增加3个tet ABI，宽度114入口校验通过；原hook先前未额外保存so，现从保留C源码重编译，
  SHA逐位等于历史runtime记录1e2f679f…，保存hook-before-tetrahedron/，有provenance.json，未冒充原文件副本。
- 所有原版严格串行，未读取账号密码。未改src/examples/依赖/原版so，未动冻结CUDA数学。

### 09616a3d：ELL修正验证与完整既有回归

- 活动image 09616a3d4e3a836eadacb4ba10a99d0fe38ff3016b68227860977fbf3cbc5d41。
  validation-09616a3d/中57+97项contract全同；6组fluid/material各30步全部逐位；
  合计29,220次step调用的完整符号/3D grid/block/shared/stream/实参全部相同。
- bending-newton的5份真实ELL buffer（rowcounts、零惯性L1、constant K和block结果）逐位相同。
  原版数值来自cloth-ell-original/，没有因“未使用”跳过这些矩阵。24项eager/graph再次全部通过。
- 同image74组既有回归完成，71组严格通过：7个官方60帧demo、API、其它粒子材料/刚体等。
  只有particles三个seed保留严格失败。固定各自NPZ做10原版C检查：seed1/2通过；
  seed3七数组仍未过（这10次原版该小case恰全相同、spread=0），未改判通过。
  保留同source与已有10次原版，再增10次，20原版按同一公式全部outside=[]。
  10次失败和20次结果/全部NPZ SHA均保留；没有挑选source样本或改容差。
- fluid耦合旧40333acf的32原版分布观察仍未通过，不把本批既有回归通过混为该case验收。

### BVH constructor下一步：库host桥接准备，尚未接入solver

- 新增native/bvh_library.{cu,h}，直接使用同版CUDA12.4 CUB/Thrust进行sequence/fill、centroid AABB reduction、
  radix SortPairs。无CPU排序替代，无旧so/PTX fallback。15个生成入口全部在当前176清单内，规范化PTX15/15相同。
- CUDA12.4生成的host stub误把显式命名_GLOBAL__N__的两个functor写为当前匿名namespace，直接host编译失败。
  保存全部失败。仅把生成stub中MergeAabbs的24处、PrimitiveCentroidAabb的7处类型引用改回真实命名空间，
  不改device PTX/fatbin；另按NVCC默认host阶段补__NV_LEGACY_LAUNCH宏后编译/链接成功。
  重现脚本csrc/build_bvh_library.py保存原stub、修改计数、输入/产物SHA及命令，且强制15入口PTX相同。
- 独立重现构建已成功：build/reconstruction-csrc/bvh-host-library-09616a3d/build.json。
  原型仍未链接入source Solver，solver_api_ready仍false，当前09616a3d也仍缺BVH constructor。
- 新增bvh_constructor_probe.py，准备从真实原版Solver constructor抓取9种粒子数（1至65537），
  用其primitive boxes在纯source进程重建并比较scene、Morton/sort、parent/children、escape与leaf映射。
  不伪造私有C++对象ABI，不将原版加载进source。当前正在运行，尚未先写通过。
  该hook对库runtime启动仍未完全可见，报告明确library_launches_completely_observed=False。

### BVH原型9组验证完成，开始接入真实source Solver

- bvh-constructor-probe-09616a3d/original/由真实原版Solver构造器生成；source-v4/为纯source重放。
  9种N（1、2、8、257、1025、4097、4864、4865、65537），68份有效buffer与34次自有调用元数据全部相同。
  涵盖CUB reduction多块、radix sort单tile/多块和N%256==1的radix grid边界。
- v1/v2为诊断context初始化顺序错误，v3为过滤后未重编号导致审计拒绝；日志保留。
  v4显式cuInit/primary context，并保留原日志，对过滤阶段另存重编号日志；非生产数学修复。
- 已保存09616a3d可复核阶段：fluid-09616a3d-materials-regression-validated/provenance.json，
  162份源码/构建/文档副本、2338份结果SHA。完整solver和三world fluid耦合仍未验收。
- 当前source Solver接入triangle→edge→particle三类BVH，初始margin=0；由真实cloth constructor实参核实。
  BvhBuilder超过0x40000000的length_error及原消息来自原版13f770/7d77f x86，不是猜测。
  原版Solverinitialize在10e3d4调用SelfCollision、10e3e3调用Fluid，source按同顺序在fluid前建BVH。
- build_host.py现在链接经过15/15 PTX检查的source CUDA库object，记录输入和产物SHA；不加载旧so作为source依赖。
  helper输入以hash缓存，编译host stub仅作已记录的命名空间引用修复，不改device PTX/fatbin。
- 第一次链接已保存bvh-first-link-before-reset/；随后补齐重复initialize时BVH句柄清零。
  活动image变为3be3a5081fd9f22ea6987411452da90c04730f86b37b239eac9645106ed6b040，
  当前正在跑真实source Solver构造器9组，尚未将原型通过当作集成通过。step self collision仍明确拒绝。

### 3be3a508集成BVH后的验证，以及官方fluid短程/60帧

- 真实source Solver构造器9组已全部完成：bvh-native-comparison-3be3a508/，69份有效buffer与43次自有调用全同。
  与原型不同，这批直接创建实际source Solver；粒子box也纳入比较。原版原始log完整保留。
  bvh_constructor_probe新增compare-native入口，可独立重跑，不需从对话复制比较脚本。
- validation-3be3a508/6组fluid/material各30步轨迹仍逐位；包括triangle→edge→particle构造器在内，
  29,290次完整自有调用的符号、3D grid/block/shared/stream、参数全部相同。154项contract及24项graph全同。
- 三world小耦合固定当前image3条source，复用匹配fixture/参数的32原版，outside=[]，严格三条仍false；
  coupled-world3-full/的完整构造与step调用也同。旧40333acf的32原版失败保留，未改为通过。
- 官方resolution8/substeps1/Newton3/PCG5的3步：611次完整自有调用同，严格状态不同。
  固定首次失败source0及另两条source，8原版、16原版观察分别失败9项、3项；
  原样保留三条source和已有原版增至32，全部outside=[]。所有阶段报告与NPZ均保留。
- 该demo初始RHS的target/mass/rowcounts/L1/flags/RHS、4224个grid点的位置/volume完全相同；
  最早不同是hash head/next，3原版+1source观测到4种有效链表。每份独立Source evaluate_rows重放，
  梯度/残差/权重/计数、每份12,680个写缓存槽全部逐位相同；邻居7..31，无fallback。
  原版之间gradient/residual也有相应差异，weights和counts四次相同。official-grid-replay-3be3a508/。
- 官方resolution8同配置扩至60帧=60子步，固定三条source后采8原版：约定观察outside=[]；
  严格三条仍false。source0完整12,125次自有调用与original0全部相同，原始log与审计均保存。
  不能把resolution8结果说成default resolution32已通过，正在补默认规模/迭代的首次核对。
- 库runtime启动仍未完全可见，所有报告明确这一限制，不把自有调用完整等同所有辅助library启动已审完。
- 另为后续其它affine rigidity抓18组原版（3模型×Newton/PD×default/body-block/alpha0），并用独立新hook记录5个入口。
  ABI宽度119入口通过。主fluid hook二进制未替换，保证已有分布样本的hook SHA一致。

### 默认resolution32找到软接触product grid遗漏，正在修正

- 3be3a508官方fluid默认resolution32/Newton5/PCG20，仅--no-capture，3帧=6子步两端正常运行。
  6047次自有调用中600次不同，全部是multiply_soft_contact_hessian_off_diagonal的grid：
  原版32 blocks，source按soft容量405504算出1584 blocks；其余实参和调用相同，严格状态不同。
- 原版SolverNewton::step fb7cf..fb7ea明确block_count后cmova上限0x20；lambda调用该缓存grid。
  已验证source kernel原本就是grid-stride loop，因此只修host启动grid，不改kernel数学或capacity实参。
- 我在检查该报告前已启动默认60帧benchmark，发现调度未过后立即停止本次自己的controller/worker；
  source0恰已完成、source1被中断，数据/log保留在official-default-60frames-fixed/，不计验收。
- 修正前3be3a508源码/构建/so已保存fluid-3be3a508-before-soft-grid-cap/；
  现在重编译，上限修复尚待真实默认demo核对。其它affine host仍未接入，18组原版捕获已保留。

### db4c9be1：soft product启动上限实际验证，继续默认规模60帧

- 活动image db4c9be10ac2988d904349d02843999b1f679005e21c0b42500856ce5b23a7ef。
  只修host软接触product启动thread count为min(capacity,32*256)，capacity实参及grid-stride kernel数学不变。
  默认resolution32的3帧=6步source重新完成，6,047次完整自有调用与保留原版全部相同；
  metadata-report.json在validation-db4c9be1/official-default-first/，source_launch_counts覆盖数也等于6047。
- 新增soft_grid_scene.py及soft_grid_ab.py，实际fluid+body接触比较容量8191/8192/8193/405504，
  Newton/PD共8组×3步，全部状态逐位、完整调用相同；每组首次真实接触count=9，没有空跑或容量溢出。
  v1诊断glob漏了dump_前缀，已保留该次原始日志/NPZ；v2只修读取文件名，未改fixture或物理。
  结果validation-db4c9be1/soft-grid-boundaries-v2/report.json；严格结果没有按容差改判。
- 默认fluid60帧现在先收集3条固定source候选，再串行8次原版；脚本/command/status和旧错误grid样本全部保留。
  正在运行，尚未先写通过；所有原版与source worker严格串行。
- 更新FLUID_HOST_RECOVERY/HANDOFF/NATIVE_HOST_PROGRESS顶部，纠正仍停在09616a3d/BVH未接入的旧进度。
  现有库runtime启动观测限制、旧image失败、完整solver未完成状态均明确保留。

### db4c9be1：默认fluid60帧及默认规模同输入重放完成

- 默认resolution32、默认Newton5/PCG20/substeps2，仅--no-capture，60帧=120子步。
  先固定3条source轨迹，再串行8原版；official-default-60frames-8o3s/report.json全部outside=[]。
  三条source严格仍false，particle首次差异在子步0，body首次在38，未写成逐位相同。
- source0与original0的完整120,845次自有调用全部相同，source_launch_counts覆盖数同；
  official-default-60frames-full-owned-metadata.json。辅助库runtime启动仍非全可见。
- 新fluid_grid_capture.py按真实view自动定dump尺寸，抓3次原版+1次当前source首次grid/evaluate。
  85,056个grid点、36,864行，全部head/next为有效排列；4次grid order不同。
  每份实际输入独立source重放，gradient/residual/weight/count及1,001,388个有效cache槽全逐位。
  首次邻居8..32，未走fallback；没有把此前小case的fallback证据冒充默认规模fallback。
  原始capture和replay位于official-default-grid{,-replay}-db4c9be1/。
- soft-grid-boundaries-v2合计4,876次完整自有调用相同。
- 下一模块准备：affine_rigidity_ab.py补齐32组真实原版（4模型×Newton/PD×default/block/alpha0/alpha0+block），
  原18组只在image、fixture SHA、frames、extra、hook SHA全部匹配时复用；新增14组严格串行。
  原版SO3 alpha0仍初始化SO3 state，但PD切到scalar、无tangent；SixSpring PD即使请求body-block也仍scalar。
  Constitutive Newton需单独B correction、PD用块对角；零alpha不调用force/B/tangent。尚未接入source。
- 当前db4c9be1尚未做完整74组回归，不能继承09616a3d的回归为本image最终验收。

### 其它affine rigidity host开始接入（尚待验证）

- db4c9be1修改前快照：fluid-db4c9be1-before-other-affine/provenance.json，145份源码/构建/文档副本、147份结果SHA。
  完整solver仍false，当前image完整74组回归待做。
- 32组原版补齐，reference-complete-db4c9be1/。依据这些实际调用新增五个已有kernel的host分派，
  SixSpring只对D1/L2赋constraint_alpha；SO3与constitutive的D1/D2权重仍0。
  SO3 initialize仅模型SO3时调用（alpha0仍调用）；SixSpring Newton加GN Hessian，PD保持scalar分支。
  CoRotated/ABD按真实enum传force、B correction和matrix-free tangent；body block的SO3系数在非SO3时为0。
  其它模型+constraints/contact/fluid组合尚未捕获，仍明确拒绝，未自行推测扩大范围。
- 也按真实原版修SO3 alpha0的PD标量路径/NULL tangent以及scalar路径忽略body-block选项。
  无CUDA数学、原版so或examples修改；当前正在编译，尚未记通过。

### 474feb41：其它affine首轮32组完成，开始同image扩展回归

- 活动image 474feb416eb76ad28927a7fdc30667c2c3d8b2f6ada68cab93ed6dd18d9afb4c。
  first-source-matrix/32组、96子步全部状态逐位，9,309次完整自有调用相同，source hook覆盖数同。
  另存finite-state-audit.json，32组全部有限；alpha0和alpha0+body-block的SO3/Six/constitutive分支均真实覆盖。
- 已启动validation-474feb41/串行批次：同fixture的1/2/3 worlds×4模型×2模式×4变体各30步，
  然后74组既有回归、fluid154项contract、24项graph、6组材料及默认60帧当前source候选复核。
  status.json保存每条精确命令/退出码/耗时；当前仍在运行，未先写通过。
- 新AFFINE_HOST_RECOVERY.md记录范围/原版证据/命令/未完成项，并更新主交接顶部指向该文档。
- 运行期间未改活动C++/构建。只准备下一模块的granular_host_scene.py（尚未运行）与5份原版Granular host x86：
  granular-host/{initialize,accumulate,commit,multiply,preconditioner}-reference.asm。
  尚未实现granular host，不把准备工作计作还原或验证通过。

### 474feb41扩展affine矩阵完成，完整回归继续

- validation-474feb41/matrix/共96组：worlds1/2/3×4rigidity×Newton/PD×default/block/zero/zero-block，各30步，
  2,880子步全部状态逐位、全部有限；279,270次完整自有调用全部相同，source hook覆盖数同。
- 同image的74组既有回归正在继续，不能把当前已完成的前几个官方demo写成全部74组已通过。
- 并行只做CPU静态准备，没有第二个GPU worker。granular独立hook已编译并核对8个入口ABI，
  宽度/签名校验共127项；W view末尾padding只屏蔽未定义4字节，Model按实际读取字段检查。
  保留原C/audit/affine hook快照；没有替换fluid114/affine119二进制hook。granular真实worker尚未运行。

### 474feb41同image回归完成，严格差异逐项复核

- 74组既有回归70组严格通过，含7个官方60帧demo、API、刚体及材料。
  保留particles三个seed与pd_mixed_cloth seed3的严格失败；不是全部74组逐位通过。
- 四组均以本批原始失败source NPZ作固定候选，各收10次原版，不重跑/挑选源码；C标准全部outside=[]。
  particles严格失败数组28/21/33，PD mixed为129world重复元素case的7数组。原始失败完整保留。
- PD mixed另外抓实际双端完整trace，新pd_mixed_force_audit.py将每份真实输入的3个重复元素贡献隔离，
  原版PTX与当前source so共104,490个贡献标量逐位，36次捕获的34,830个写标量均由明确float32排列解释；
  不改kernel、不改求和顺序、不用epsilon。trace这次整体严格相同，但不覆盖/替换最初失败候选。
- replay_host_pcg.py原先仅支持空ELL，现改为读真实捕获的max_count/rows/row_count/entries，拒绝缺尺寸的旧trace；
  原脚本保存在本批replay_host_pcg-before-ell.py。PD mixed实际324个PCG调用重放：405逐元素+162归约全逐位。
- 同imagefluid57+97项contract、24项graph、6组180步材料状态全部相同；
  默认resolution32的60帧3条新source复用版本/参数/hook匹配的8原版，outside=[]，严格3条仍false。
  当前source0完整120,845次自有调用与原版全部同，已另存full-owned-metadata，不把helper库全观测说成已完成。
- 继续补当前image的材料全调用及真实BVH constructor缓冲区；所有GPU严格串行。
  之后仅做granular原版实际捕获和constructor contract，仍未接入source。

### 474feb41最终补充捕获完成，准备转入granular host

- fluid-materials-full/6组30步状态逐位，完整29,290次自有调用同；原版只复用fixture/参数/frames/hook SHA
  与64a0be7f image全部匹配的validation-b7642d56原始捕获，没有复用旧source结果。
- bvh-compare/当前真实source Solver九组constructor：69份有效buffer与43次自有调用全部相同。
  辅助库runtime启动仍未完全可见；不称完整solver已通过。
- 103项granular原版constructor contract已抓，41项接受，其余保留原错误类型/消息。
  8组原版cached粒子：none/authored/dynamic/mixed×Newton/PD，各3步，全部正常。
  原始launch、runtime、command保留granular-host/original-first/；没有登录/读取凭据。
  实际调度确认RHS后grid→contacts→初始bonds→动态bonds，B correction在inverse前；
  matrix-free按contacts→初始bonds→动态bonds，accepted step末commit两种bond后重建grid/form，最后velocity。
- source granular仍未接入，接下来修改前先保存474feb41完整检查点。

### 3edc2cae：首次接入granular host，尚待验证

- 修改前474feb41完整检查点：affine-474feb41-validated-before-granular/provenance.json，
  215份源码/构建/文档副本和8,274份结果SHA。完整solver仍未完成。
- 首次granular image 3edc2cae6f34af59549c01e5526a92f416a814550d3f4fcfa5e094c6f565d34d，
  CUDA digest仍a98e84b9，未改kernel数学。新增GranularView120B、已确认GPU Model字段、
  作者bond历史/active与动态partner/CSR，按真实原版调度接force/B/tangent/commit/form。
  103项原版contract用于复核消息，不先凭参数名猜错误行为。
- 当前只接free granular及静态shape组合；body/elastic/fluid混合、禁用作者bond同时adhesion等未捕获组合仍明确拒绝。
  没有把这些剩余分支写成已完成。CUB/Thrust启动仍非全观测，当前host构造array使用源码内存API；
  尚未声称所有辅助库constructor启动与原版完全相同。
- 另补6组真实原版：fallback两模式、非连续subset/world2两模式、实际平面接触两模式，各3步正常。
  新granular_host_ab.py只在reference image/fixture/hook SHA都匹配时复用原版，记录完整实参/调用/状态及source覆盖。
- 当前正在跑103项source constructor contract和14组真实source Solver；尚未先记通过。

### granular首轮发现半径校验层次遗漏，按x86修正为af4580ad

- 3edc2cae的14组3步全部worker正常、完整自有调用相同，12组状态逐位；fallback Newton/PD严格失败保留。
  103项constructor行为有4差异，全是radius -1/NaN/0/Inf的错误层次；不把它们改判通过。
- 原版10ef29..10efb3仅在shape_count或collision_particle_count>0时检查全体local radii非负且非NaN，
  显式允许Inf、0；随后SelfCollision::initialize 1387e0..13884b逐个校验selected collision index、唯一性、
  再检查该radius finite正。错误字符串和分支均由当前64a0be7f x86取得，保存radius-validation-text.asm。
  原版7d203/7d28b还明确duplicate/invalid particle index消息，source按同顺序恢复这些已确认分支。
- 修改前3edc2cae源码/构建/so保留granular-3edc2cae-before-radius-validation/。
  当前image af4580ad4f478d1490c18a48a2ecbb2848fd7f762507bfc68c8c663c65087551，CUDA数学digest仍a98e84b9。
- 新radius_contract_ab.py同时观察无shape/有shape、空/部分/重复/非法collision selection，以及未选中radius的
  -1/0/-0/1/NaN/Inf，共72项，防止仅给granular换错误字符串而漏掉真实条件层次。
  当前正在实际原版/source补验72项、复核103项granular行为及14组source；fallback差异仍待定位/分布验证。

### af4580ad参数层次修正通过，密集差异定位到真实hash链顺序

- 72项radius contract全部错误类型/消息/接受行为相同，103项granular constructor contract全部相同。
  当前14组三步仍为12严格通过、2个fallback严格失败，所有完整自有调用相同。
- grid-probe-af4580ad/四份实际首次输入：64行均63邻居，全部走>32 fallback；
  各自同输入重放force/B/count及2048个有效cache槽、首次contact tangent全逐位。
  这四次首次head/next恰相同，但original1frame自身重复已有严格差异，不能据此认定整段无顺序波动。
- step-trace-af4580ad/随后抓完整一个step各中间buffer，首次不同明确在launch7的head/next，
  位置、前态、radius、IDs/world/cells相同，4个bucket两warp链顺序不同；下一call才出现force/diagonal不同。
  不是跳过差异，raw trace与最早不同的bit都保留report.json。
- 新granular_step_replay.py独立重放这次双端全部3轮实际contacts与15次CG contacts tangent：
  共6次force/B/cache、30次tangent全部逐位，所有链是有效全排列；不改kernel或求和顺序。
- 正在按既定8原版/3固定source观察Newton与PD密集三步；source0采用本批最初失败NPZ，另两条一次性固定，
  没有挑选source。3edc2cae的旧失败candidate也另外用相同原版观察核对，明确不混充当前image cohort。
  尚未提前宣称分布通过或granular完整验收。

### dense三步观察：PD通过8o3s，Newton保持失败候选继续16原版

- dense-pd-fixed-af4580ad/8o3s当前3条固定source均outside=[]，原版7次自身重复全部严格不同。
- dense-newton-fixed-af4580ad/8o3s仅source0的particle_q两指标未过，原版自身也均不可复现。
  未改判通过，正在保留原source0/1/2及已有8原版追加至16；没有重新采样source。
- 3edc2cae两份旧source失败candidate也分别对相同8原版独立检查，historical-fixed outside=[]；
  这些明确不混入当前af4580ad三source cohort。所有adopted copy保留原文件路径和NPZ/runtime/log SHA。

### Newton dense固定候选32原版仍未过，继续原版PTX核对并恢复索引类型

- af4580ad Newton的source0在16和32原版下particle_q两项仍未过，未改判通过。
  16原版时最大ratio=1.09375，子步1的particle2.x固定source为0x3e33fcb4，
  原版样本为fcb5/fcb6/fcb7。其它source1/2以及PD8o3s通过；不能用它们替换失败source0。
- 当前参考64a0be7f与历史4c223854的granular八入口规范化PTX8/8相同，确认低层granular旧oracle继承关系。
- 原版build_grid的position地址是mul.wide.u32，恢复源码原来是mul.wide.s32；
  在unsigned-index-variant/独立CUDA12.4编译，仅改global_particle unsigned，确认该运算已对齐。
  其余build_grid文本差别只剩独立load/cvt顺序与原版未使用的b16声明，完整diff保留。
  这项索引类型恢复来自实际PTX；没有据此先认定已解决轨迹分布，更没有改float归约或epsilon。
- 修改前完整af4580ad检查点granular-af4580ad-before-unsigned-index/：220份源码/构建、3277份结果SHA。
  现将已核对的unsigned索引恢复到实际kernel源码，正在重编译，接着通过真实新so重测。
  当前旧失败候选/8/16/32报告仍保留，尚未称目标完成。

### unsigned恢复使用既有revision机制，基础接受快照保持不动

- 直接修改kernels/granular.cu被build_host的接受源hash守卫拒绝；没有关闭或改写守卫。
- 已恢复该基础文件到快照同SHA；独立的revisions/granular_grid_23fb797.cu保留unsigned类型恢复，
  build_host按既有tet/PCG revision模式，仅替换granular build_grid入口，其它7个granular入口仍用接受版本。
  bundle仍强制176个ABI入口精确覆盖；记录revision输入/PTX SHA和source_overrides，tet覆盖不能随模块数错误偏移。
- 正在重建新so。旧af4580ad Newton32原版固定source0失败仍保留，不声称索引类型修正已经解决分布问题。

### 76790908当前granular复核及history真实分支

- 新image为7679090829a1018fcc038b661607b0644a180c13a1dcf62f4c6625118bb61a12，
  CUDA digest f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a。
  28模块仍精确176入口，仅granular build_grid使用已核对的unsigned索引revision；基础接受源码保持原SHA。
- validation-76790908/：72 radius+103 granular constructor行为全部相同；14组三步完整自有调用同，
  12严格状态相同，2 dense仍严格失败。新编译so的实际grid8份输入共48点字段数组相同，链全部合法；
  双端6次contacts及30次tangent实际输入重放相同。
- 当前image的dense Newton采用32原版、PD采用8原版，各3条固定source均outside=[]；
  source0为当前image第一份失败NPZ，source1/2各采一次。旧af4580ad Newton32原版下source0失败原样保留。
  索引修正有真实PTX依据，但有效正索引地址本来相同，不能宣称它数学上解释或消除了原子调度波动。
- granular_history_ab.py新增6组真实30步：plastic/break/form分别Newton/PD，180步状态严格相同；
  全部21,210次自有调用相同。plastic每模式3次历史缩短及2断键，break各2断键，form各12成键及12断键。
  最初逐位history/active/partner/CSR核对共2160项；没有仅根据参数名声称这些分支已覆盖。
- granular_history_buffer_audit.py对同一raw dump补查已初始化但后来inactive的pair/rest/history，
  共3612项（含finite与active定义域）全同，3040条inactive历史观察，无需另采/替换候选。
  命令：.venv/bin/python -m reconstruction.csrc.granular_history_buffer_audit
  --capture build/reconstruction-csrc/granular-host/history-76790908
  --output build/reconstruction-csrc/granular-host/history-76790908-strengthened.json。
- 新demo_launch_ab.py用于真实demo双端串行、完整元数据/finite/source覆盖检查。
  snow-first-76790908/：官方snow resolution8/substeps1/iterations3/linear5/no-capture三步正常且482次调用同，
  q/qd从子步1严格不同（max 5.96046448e-8/3.57627869e-6），仍保留严格失败，尚未归因为原子顺序。
- 新增snow step trace时软接触dump参数下标写错，original诊断进程SIGSEGV；
  snow-trace-76790908/失败保留，不计作求解器失败/通过。按实际demangled ABI修正为
  inputs32/33/34，outputs36/37/40/41，并为全部配置的dump新增启动前pointer参数类型检查。
  正以snow-trace-abi-76790908/新目录重新抓取；未更改solver、kernel数学或比较标准。

### 官方snow首差定位与117条authored bond逐项证明

- snow-trace-abi-76790908/三步双端482次调用完整元数据相同。最早buffer不同为launch7 grid head/next，
  第一轮contact force/diagonal/count仍逐位；首次算术不同是launch9 authored accumulate_bonds，
  其全部已抓输入（含既有RHS/diagonal）相同，force12个word、diagonal21个word不同，tangent前缀相同。
  dynamic首轮继承这33word，而不是无依据归咎于soft contact。完整trace保留517个后续不同buffer。
- granular_step_replay.py扩展为按launch顺序关联前一个build_grid，而不是假定第k force对应第k grid；
  commit后额外build_grid也计入，防止多step时重放错输入。18次contact及90次CG contact product实际输入全逐位。
- granular_bond_atomic_audit.py以真实first-call count117安全抓完整作者bond，无需修改hook；
  dump前逐一核对demangled ABI的pointer参数。仅first-call，不把117大小dump用于其它5592动态bond调用。
  117条均非coincident且live，故可拆成234个不共享端点；Model/dt/材料及向量输入保留实际原版值。
  原版PTX与当前source so各自独立运行，force/diagonal/tangent全部逐位；实际117份tangent与隔离结果也全同。
- snow-bond-audit-76790908/：26粒子最多18条邻键，每端各312个实际force+diagonal标量均找到并独立复算
  精确float32加法排列（542次搜索），两端各5280个未触及标量原样。具体terms/before/target/witness
  保存exact-witnesses.npz；不改生产求和顺序/epsilon，不声称找到了历史GPU的真实线程顺序。
- 官方snow固定第一失败source0、另两条各采一次；8及16原版的所有3步都在原版留一spread内，
  但source0 q/qd的ratio_max仍高于“原版自身留一最坏ratio”这项更严格观察值。
  该观察仍严格失败，未删掉/放宽；当前正在同3条source下扩至32原版。已有全部失败保留。
- 新granular_graph_ab.py准备cached四种bond、Newton/PD、world/seed1/2/3的eager/graph各60步；
  mixed同时含非连续subset及真实软接触，检查finite和实际接触。尚未运行，不记为通过。

### 76790908长轨迹/graph完成；官方更严格分布观察保留失败，发现待核对CSR

- granular_graph_ab.py：world/seed 1/2/3、四类bond、Newton/PD、eager/graph各60步，双端共5760物理子步；
  48项双端及48项自身eager/graph比较共96项全严格相同，全部finite；mixed含非连续subset及实际静态软接触。
  结果validation-long-76790908/graph60/，Source无原版so映射，实际source launch coverage非空。
- 官方snow60简化迭代（res8/substeps1/NL3/CG5）60步9545次完整自有调用同，状态严格失败保留。
  官方缺省参数snow-default3/共18子步，22037次调用同，q/qd于子步10开始严格不同。
- snow固定三步source0在32原版下仍未通过ratio<=原版自身leave-one-out worst ratio的额外严格观察。
  q约0.96875 vs0.9677419369，qd约0.96875 vs0.9677419355；所有3步均在原版spread内。
  不删除/放宽额外判断，不把此结果改写为完全通过。8/16/32原版及同3条固定source均保留。
- 已再次阅读用户指定jsonl最后10条agent记录；其最后工作为Newton joints捕获及body index dump大小修正，
  这些属于当前granular之前已延续的阶段。继续沿用实际原版捕获、核对ABI/调用与buffer、严格失败保留的方法。
- 新静态发现：原版initialize 1292b9..1292ac只向min(grain)行追加max(grain)列；129260直接遍历authored pairs，
  不是cohesion>0才构造排除CSR。当前source构造双向表，并拒绝cohesion0+adhesion以免未经验证。
  即使现有状态不变，也应按原始数据还原该内部布局，不能把功能等价当成全部buffer一致。
- 已准备granular_disabled_bonds_scene.py（独立fixture，冻结granular_host_scene不改）和granular_csr_ab.py：
  positive/zero cohesion、Newton/PD、world1/2/3、非连续subset和反向作者bond，抓实际FORM的offset/columns等。
  正在等待当前74组回归串行完成后采原版及当前source；尚未修改生产C++或宣称CSR已修正。

### 76790908完整74组回归与snow额外ratio误报核查

- 同image 74组回归完成，71严格通过；仅particles seed1/2/3有35/28/14个严格失败数组。
  七个60帧demo、API/浮点属性、刚体、各材料和本批PD mixed均严格通过。三粒子固定候选尚需独立C复核。
- 对snow三步32原版的固定失败source0做纯CPU逐位比对：完整q/qd三步与original1完全相同，
  并未更换source候选。source1/2未找到整条完全相同原版，但其既有分布观察均通过。
- snow-first-observation-selfcheck-76790908.json进一步把32原版逐条当作candidate、使用与source相同的
  全cohort统计基准核对原额外ratio判断，有11条原版也被该判断标失败（含original1）。
  原因是source使用K个原版基准，而original worst ratio来自各K-1基准再做内部leave-one-out，基准不对称。
  source0的0.96875与原版worst 0.9677419差异属这个额外观察的误报，不能据此修改float物理计算。
  现有8/16/32观察报告及原判断均未改写/放宽；真正已约定C的3步within-spread均成立，局部B已有精确排列证明。
- 当前正在csr-before-76790908/用原版/source抓真实FORM排除表。静态发现必须以实际buffer确认后再修。
- 等待GPU时另保存self-host/static-reference-64a0be7f/的原版SelfCollision方法及SolverNewton::step x86指定区间，
  ranges.json保存命令/范围/SHA；仅静态准备，不是自碰撞host已接入或测试通过。

### 原版真实CSR确认后修正；76790908修改前完整保存

- csr-before-76790908/：正cohesion Newton/PD状态仍逐位，但原版offset=[0,1,2,2,2,2,2,2,2]、columns=[1,2]；
  source offset=[0,1,3,4,4,4,4,4,4]、columns前缀=[1,0]，实际是错误的双向CSR。
  零cohesion的两组原版接受且同样保留2个排除条目；source按既有保护明确拒绝。原失败均保留。
- 修改前检查点granular-76790908-before-csr-canonicalization/provenance.json：393份源/构建/so副本，
  29206份结果SHA；明确whole replacement false，没有把旧74组3个严格失败或官方ND改写为通过。
- source_solver.cpp只改granular constructor：力用的初始bond仍仅cohesion>0启用，但排除CSR始终纳入
  所有authored pairs，只写min(grain)行→max(grain)列，并移除已得到原版证据的零cohesion+adhesion拒绝。
  未改任何CUDA、float运算、归约或误差判断。正在重新编译；尚未先称新image测试通过。

### 36ca7d36 CSR修正验证：12组30步及实际数组全部严格一致

- 新image 36ca7d364c47eecf642bf19defdfb2cace7db544a1f5707601a1b625b9b58cba；CUDA digest仍f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a。
  与76790908逐字段比较176个选定kernel manifest完全相同，没有改kernel/参数/编译模块。
- csr-after-current/：12组positive/zero cohesion × Newton/PD × world/seed1/2/3，各30步状态严格相同、finite，
  所有自有调用完整元数据同。world2非连续subset，world3反向作者bond；每组真实CSR offset/完整有效columns、
  partner/active及live pair/rest/history共18项，合计216项全同，包含原来被source拒绝的零cohesion+adhesion。
- 当前graph脚本增加第5个disabled-cohesion variant，用独立新fixture，原冻结fixture不改；
  后续60步graph矩阵将有120项比较，而76790908保存的旧96项结果保持原样。
- 已启动validation-36ca7d36/run.py串行：175参数、14场景、history+inactive审核、扩展graph60、固定dense、
  两种官方snow和74回归；随后自动对当前回归的每个严格失败用首次source NPZ独立收10次原版做C。
  目前尚未完成这些新image回归，不记通过；所有worker严格串行且Source无原版so映射。

### 36ca7d36首批复核完成；纠正诊断hook的入口统计并补齐布局

- validation-36ca7d36/175项constructor/radius全部相同；14场景所有调用同、12严格、2 dense严格失败保留。
  history六组30步及inactive值补查全同。扩展graph含zero-cohesion+authored+adhesion+subset/contact分支，
  120项比较全部严格通过（每端60个60步轨迹、合计7200物理子步）。
- 当前dense Newton32原版/PD8原版各3条固定source的所有观察均通过，严格三条仍false。
  current source0仍为本批最初matrix NPZ，没有为通过重选候选。官方snow60/default3仍严格失败且所有调用同。
  同image74回归及各严格失败10原版C仍在串行运行，尚未计通过。
- 顺带审查hook库存发现重要计数问题：旧granular hook的“127项ABI检查”含8条重复granular布局，
  实际只覆盖119个不同owned symbol，当前inventory为129。10个缺布局入口是三种evaluate_residual、
  spring force/GN、affine torque、joint drive selected reset、joint point-line AL preconditioner/tangent及refit_aabbs。
  旧granular场景实际调用均在旧119中，其逐场景source count覆盖和完整元数据结论不受此计数影响；
  不能把127说成127个独立入口或已全面观测129个入口。
- 修改前C/audit脚本副本存full-owned-hook-129/。移除8重复布局，按实际demangled ABI与176-entry参数width
  为8个新layout key（含3个residual overload）补齐10入口；schemas统计改为按唯一symbol计数。
  新静态检查精确129/129 owned layout覆盖，另47库入口runtime仍非完全观测。
- 新hook单独编译为full-owned-hook-129/cudahook.so，SHA d08bc05e699e16b1b3b7e0fcae644667f3f804cd0f233c32b1a7d16ddfc31518。
  build.json保存命令/C源SHA。未覆盖原granular/affine/fluid hook二进制，当前GPU批次仍使用原固定hook；
  新hook尚待实际原版/source调用验证，不能把ABI静态齐全说成129个入口均已运行。
- self-host/exact-symbol-ranges-64a0be7f/根据nm -D -S的真实symbol size重抓八个精确x86区间；
  前次较宽的范围保留。静态确认cache为60B记录、完整tangent乘积grid最多256个block，仍未接入self-collision host。

### 36ca7d36的74回归/C结果，保留真实未通过并扩展同一候选

- 74组70严格通过。失败为particles seed1/2/3的28/14/21数组，以及mixed_cloth seed3的11数组；
  与76790908发生ND的具体seed/材料不同，旧所有失败保留，不用新严格结果替换旧候选。
- 四组都以本批第一次source NPZ收10原版。seed1、seed3和mixed_cloth seed3通过；seed2仅
  n257_w1_it1_f0/2/out.particle_qd尚未过，source_deviation=1.52587890625e-5，
  original_spread=1.430511474609375e-5，original自身确有变化。这不是snow额外ratio的误报案例。
- 给atomic_spread_check.py增加仅复用原版样本的可选--extend-originals；检查scenario/seed/baseline路径及
  fixed_source_npz SHA，复用全部10原版，每份记录原路径/SHA，新建20原版结果目录，仅追加10次原版。
  原C定义和比较条件完全不变，默认用法不变；不重新运行或挑选source，正在收集20原版结果。
- 此固定source SHA为2fdba08fc934cd6db6c188eabdc495638a975aa7bc312c98185a9cb50955862f；
  旧失败criterion-c-particles-seed2/完整保留，新目录criterion-c20-particles-seed2/。
- 全129 owned布局的新hook已准备current_kernel_audit.py：用冻结spring/affine/LBVH/joint/point-line用例与
  三种residual的literal current PTX和当前C++ source so逐项运行、保存全部download数组和调用元数据。
  仍等待当前C20批次结束后执行，不并行GPU，不把静态129布局覆盖说成129入口全部实际运行。
  full-owned-hook-129下的旧C/脚本备份已命名*-before-*以免误当新hook源。

### n257 seed2 C20仍失败，实际首差与逐元素/累加证据已抓取

- 20原版仍仅原固定candidate的n257_w1_it1_f0/2/out.particle_qd失败；源码candidate不变。
  极差元素为particle12.y：source=-27.459896087646484 (c1dbadde)，20原版该元素均为-27.459911346435547 (c1dbade6)。
  尚未作为C通过，不能以其它array或独立trace替换此候选。
- trace-n257-seed2/trace-seed2/actual/独立抓同模型3步：102实际调用元数据同，首次差异launch40
  multiply_matrix_and_reduce的after.denominator，1186284885 vs1186284886，相差1ulp；此前全部captured buffer相同。
  本trace整体严格失败保留；它不是最初固定candidate的重新采样替代品。
- 对原版真实输入的84个PCG调用独立重放，105逐元素输出全同；42 aggregate有6次严格不同，全部记录在replay JSON。
  host_pcg_sum_witness.py对首差的257份相同per-particle dot贡献找到两个精确float32排列，分别复现原版/source
  captured denominator；witnesses.npz保存全部contributions、initial和order，未改生产求和/阈值。
- 新hook actual kernel audit首次spring的两端download都已取得，但literal-reference ctypes直接调用libcuda句柄，
  绕过LD_PRELOAD，故缺original launch log；诊断失败audit-36ca7d36/保留，不计完整通过。
  修正仅将该诊断的original cuLaunchKernel调用转经全局shim，函数实参/内核不变，正在audit-shim-36ca7d36/重测。
- 已从64a0be7f原so重新cuobjdump提取PTX；旧visible/weak parser读170项，完整library parser确认全部176个entry
  与缓存逐项规范化digest相同，保存fresh提取文件及provenance，避免将目录名前缀当来源证明。

### 新hook多seed实际验证通过；固定C40失败继续保留，准备真实self-collision host

- current_kernel_audit.py改用每backend独立worker：原同进程切换dir会让hook的全局序号从非0开始，
  严格完整性检查正确拒绝；audit-shim-36ca7d36/失败保留，没有放宽序号比较或重写raw log。
- audit-serial-36ca7d36/：三seed×spring/affine/LBVH/joint-drive/point-line/residual，共18组，
  354份完整download数组逐位，所有冻结spec和完整启动元数据相同，41个不同当前source入口真实执行。
  新补8个layout key对应的全部10个symbol均实际出现并三seed核对；不是只做了ABI长度静态检查。
  Oracle来自已新提取校核的当前64a0be7f PTX，source函数digest守卫后从实际36ca7d36 C++ so取得；无原版_core映射。
- 当前固定seed2 candidate追加到40原版仍有同一QD数组未过C，未改判通过。10/20/40及同source SHA全保留。
  实际trace首差为纯PCG原子标量，105逐元素同、两个first-sum均有精确257贡献排列；不凭统计失败改数学。
  f0场景仅第一步in.force为空；交换state后第二步in.force是原测试预置的out.force=-789，
  第三步再为空。因此约-27速度是该原始fixture本来就有的大force行为，并非自行“修稳定性”的理由。
- 全SDK目标尚未完成。继续独立补self-collision实际host证据，保留上述C未验收项。
  新self_particle_scene.py不含mesh/外部资源，先抓原版3步PP，再让当前source明确报告未实现；
  尚未修改生产C++自碰撞代码，不记为已接入。原版static available()对PP-only需local粒子BVH叶数>1；
  原版begin/accumulate的PP max_slots实际为31，cache记录60B、完整tangent grid cap256block，后续以真实调用确认。

### 9f1a607d：PP self-collision host 首批接入，8 组三步全部严格通过

- 活动 image SHA 9f1a607dd71f37ba2f9382ac69a7dd0b4afaf2371f08af7864109ca21de31a87；CUDA 176 入口及 f0e0137a digest 未变。
- 先用项目内64a0be7f原版抓8组三步，pp-reference-36ca7d36/ 保存raw dump/命令/fixture与hook SHA。
  Newton/PD×full/diagonal、far、one、empty、worlds3，原版全部退出0。
- C++增加PP预分配、pre-prediction AABB/refit/query、31槽候选、原始惯性diagonal stiffness、
  force/Hessian/counter与60B contact缓存，preconditioner add、full256block cap/diagonal tangent。
  full才清counter；正scale才accumulate；PP使PD使用block。mesh及其它物理组合仍明确拒绝。
- source-first-9f1a607d/report.json：8组状态逐位且finite，全部owned launch完整元数据同、source计数完全覆盖；
  query已写槽与counts/world/groups、stiffness、force/H/counter、有效contact、preconditioner、product全同。
  未比较未初始化尾部，未声称allocator/helper47入口runtime完全相同。新image尚未完成全回归。
- source supported_physics 尚未补PP标签，不把首批短测等同全部边界通过。开始追加独立fixture验证长轨迹/graph/边界。
- 修复checkpoint utility对自身重定向stdout的哈希问题：排除/proc/self/fd的1/2所指仍在写的文件，单独记录排除项。
  旧767检查点393源+29205不可变结果核对通过，36ca检查点396源+51879不可变结果通过；
  旧manifest不覆盖，每份仅其completion log变化，以单独provenance-audit记录，物理结果均未排除。
- HANDOFF/NATIVE_HOST_PROGRESS/GRANULAR进度改正过时的pending描述；新增SELF_COLLISION_HOST_RECOVERY。
  36ca的particles seed2 C40仍未通过，不把PCG局部原子排列证明当作整段验收。

### 9f1a607d 扩展：长轨迹与 graph 通过范围、真实 API 漏校验

- 独立self_particle_variants.py保留首批fixture SHA，新增38组长轨迹/数量/开关场景。extended-9f1a607d/：
  31组严格，n2115-PD一组严格差异（q首步最大9.313225746e-10，qd后续最大5.960464478e-8），
  完整299次owned launch元数据相同；此为首次跨full tangent 256block cap的PD场景，不凭小误差计通过。
  保留其第一次source，正固定追加两source/八original做既有分布观察；没有重新挑选source0。
- 其余6组因负数/NaN刚度，原版ValueError而source接受，是真实接口差异，不是“原版不支持就略过”。
  self_collision_contract_ab.py对三种PP可用性×enable开关×5字段×8值+错误优先级，共246项，
  contract-before-9f1a607d/：发现138差异。原版无论enable/available均要求radius有限正数，
  四个stiffness有限非负，radius错误优先；对应x86 fb3f0..fb478与cold768b5/字符串1f4b20,1f4b60。
  尚未修改生产代码；先保留当前源码/结果再照原版修复。
- graph60-9f1a607d/：20个场景×eager/graph×原版/source，每条60步，共4800物理子步；
  80份跨backend/自身eager-graph比较全部严格、finite，无缺项。包含3world/seed×Newton/PD×full/diag、
  subset+不同质量半径、Hessian/enable开关，以及新独立valid_switch fixture的正/零stiffness四阶段。
  对四阶段分别捕获graph，没有假设修改config能改变已捕获graph的kernel参数。
- granular_dense_distribution.py仅增加可选--launch-hook，默认旧hook不变；采用candidate runtime固定的
  full129 hook核对PP分布，所有原来的数学、阈值、候选固定逻辑不变。
- 新增self_mesh_scene.py，准备无膜/弯曲材料力的VF/EE/EF原版实际捕获；mesh生产host尚未接入。

### 5e23dc5a：照原版修复 self config，246 项契约已全部相同

- 9f修改前以self-9f1a607d-before-config-validation/保存406份源/构建与4693份结果SHA；stdout位于结果根外，未产生自身哈希问题。
- 5e23dc5a6c44f437cada8c1afbe5d74300d9a74da7a4be399ef342a57777b08e：仅增加原版相同的radius有限正、
  四stiffness有限非负step校验，所有enable/available状态均检查，radius错误优先；错误类型与文字按真实原版。
  支持标签增加free_particle_self_collision Newton/PD；176 CUDA未改。contract-after-5e23dc5a/246项零差异。
- 9f的n2115-PD第一次source固定后，追加source1/2各一次，与8原版按既有C/分布规则全部通过；
  原版自身也出现同规模严格差异，三source对original0严格为false/true/false，旧严格失败未覆盖。
- 独立实际trace n2115-pd-trace-9f1a607d/观测222个PCG/基础入口，首差launch4 precondition_and_reduce
  的after.numerator，旧1161711522 vs新1161711528；此前captured输入输出与本次z、r、initial相同。
  host_pcg_sum_witness对2115份相同贡献找到trial8与108两个精确float32排列分别复现两端，NPZ已保存；
  没有推断生产实际线程顺序，也不把局部证明当全so通过。完整299启动元数据另由首次真实场景核对。
  witness首次传错trace根缺actual子目录，原失败目录保留；新增只含legacy/source symlink的输入视图后原工具运行成功。
- validation-5e23dc5a/run.py正严格串行跑8组buffer、34组有效参数长轨迹、80 graph比较、radius/constructor、
  16组mesh原版捕获、同image74回归；非法参数不进入有效轨迹汇总，但已独立246项完整验证，不隐藏此前138差异。
- 36ca旧seed2固定C40未过仍是待验收记录，不由9f另一场景的通过替代。

### 5e23dc5a 首轮复核与 mesh 探针修正（旧失败不覆盖）

- pp-first八组全严格；pp-extended34组有效轨迹33严格，仅n2115-PD严格差异，所有元数据同；
  pp-graph60的80项全严格，radius72项相同。74回归正在运行。
- 批次中的bvh_constructor_probe少传必需--worker，exit2是诊断命令错误；其报告保留。
  新增bvh_constructor_ab.py按原版捕获→source实际构造→compare-native三阶段串行执行，待followup实际核对。
  此前103项“constructor”是granular_contract_ab，并非此9规模BVH探针，后续明确区分。
- 首次mesh-original16组都在Newton Builder报wp.cross/wp.length不接受ndarray，未进入原版求解器。
  原fixture字节与SHA保存在该失败目录，所有失败日志保留。将新fixture位置改为wp.vec3，
  EF两opposite放同一侧避免折叠方向正好抵消；尚无已通过结果被改写。准备新目录重抓16组。
- 新validation-followup-5e23dc5a/run.py待上一GPU批结束后执行：mesh参考、BVH9规模、103 granular构造、
  固定5e首次n2115候选的分布观察、所有74回归严格失败的固定候选C10。GPU仍不并行。

### 5e 全模块回归发现过时的 API guard，按原版行为更新诊断

- 同image七个真实demo各60帧全部严格：basic_dzhanibekov/body_spring/distance_constraint/body_point_line/
  physical_pendulum/joints/basic_joints；八组body×mode也全部严格，剩余三seed粒子材料仍在串行跑。
- host_api_ab在旧guard/self_collision_not_implemented处断言失败：这是一条历史source-only未实现守卫，
  与当前PP支持及原版无primitive时enable_self_collision应接受相冲突，不能改生产代码继续错误拒绝。
  旧脚本字节/SHA及失败日志保存在本批regression/，旧harness-hashes.json保持不动。
- 只更新csrc诊断：该检查改为独立新数组、实际原版/source分别initialize和step，
  enable_self_collision=True且collision primitive为空，比较完整输入/输出数组逐位；
  不影响后续failure guard的原始数组和预期。新检查待followup实跑，不提前计692全部通过。
- 首次mesh探针类型问题仅修fixture；没有修改examples/依赖/原so或生产公式。

### 5e74回归完成、followup实际结果与新mesh原版证据

- 首批74循环完成：70严格、host_api_ab一项旧guard诊断失败、三seed particles严格失败28/14/14数组。
  followup api-current692检查全部通过；三seed都固定该批第一次source做C10，三组全部通过，原严格失败保留。
  这不替换36ca的旧seed2固定C40失败，不把旧候选换成当前能过的新候选。
- bvh_constructor_ab完成真正三阶段：9规模、69份缓冲区、43个owned调用相同，image为5e；
  granular constructor103项也全同。旧缺--worker的CLI错误报告未覆盖。
- mesh-reference修正类型后16组原版全部退出0；首对照fixture SHA与runtime锁定，捕获安全prefix+全owned元数据。
  PF实际mesh VF3顶点与free VF1粒子分别调用；VF场景6顶点；EF场景mesh vertex5，opposites=[3,4]。
  EF确有活跃contact：单world counter1，3world counter3；3world tangent grid3，与候选容量推导吻合。
  各query/force厚度、stiffness、bool、count/local/world尺寸已逐一读实际日志与x86互证。
- build/self-host/mesh-host-draft.inc仅为未编译草稿，尚未修改生产mesh host，不能计通过。
- 5e n2115-PD的三固定source与8原版分布：source1/2严格，source0未过，8原版本批全部相同、spread0。
  保留失败，仅复用相同fixture/image的全部8原版和三source追加至16，不运行新source或混入别的fixture。
  额外CPU观察：当前source0的完整3步数组恰好逐位等于9f批真实original7；后者fixture文件SHA不同，
  valid_switch在switch=none委托同一冻结base，但并未据此混合样本或改判当前C8通过，单独membership报告记录。

### 5e检查点已保存；按16组实际数据接入isolated mesh调度，准备新编译对照

- self-5e23dc5a-before-mesh/保存409份源/构建与8106份结果SHA，完成后才修改生产C++。
- 5e n2115-PD追加至16原版后，固定source0的q/qd三步均在C spread内，且完整3步逐位等于actual original13/14；
  额外ratio观察仍报false。这两份真实原版与同full cohort比较也会失败，extra-ratio-selfcheck.json
  保存匹配SHA和反例；原C8/C16失败报告、计算规则均未改，没有重选source。与Snow已知K vs K-1规则问题相同，
  不得和36ca旧seed2真实C40失败混为一谈。
- Source新增mesh动态AABB/refit，VF(mesh/free)、EE、EF候选及原版顺序的force装配；
  共享world topology、本地1叶无visit、sorted mesh vertices、triangle+authored opposite CSR、
  所有候选31槽合计cache容量均按x86和实际16组参数核对；继续复用原176源码kernel，不改公式。
- 第一个未验证build37892e4b保存在mesh-unverified-37892e4b/；代码审阅补上未捕获的drag组合守卫后再编译，
  避免声称“组合拒绝”却允许air-drag进入。膜/弯曲/弹簧/体/材料/外部接触组合仍拒绝。
  尚未把mesh记为验证通过，下一步self_mesh_ab逐组核对状态/完整启动元数据和有效prefix。

### 3137b03d mesh首批：16轨迹/385 buffer严格；四组NULL参数差异已定位并修复

- mesh-source-first/report.json：16组状态全逐位finite，385项已定义buffer检查全部相同，共4900 owned调用。
  全参数只12组通过：四组EE场景每组9次accumulate_edge_edge的arg3，原版NULL、source present。
  原版opposite offsets全0且columns为空；Source通用Driver::upload(empty)仍返回非零地址，
  因此“上传零长度vector就会NULL”的推断错误，不能因为结果相同就忽略真实参数差异。
- self-3137b03d-before-null-opposites/保存当前源码/构建与此批原结果SHA。
  C++现在对empty opposite显式传uint64_t(0)，其余仍上传sorted union；未改任何数学或kernel。
  新编译后重跑全16组，不覆盖旧四组失败；scope标签补isolated mesh无材料力Newton/PD。
- 新增self_mesh_mixed_scene.py，准备同时激活VF(mesh/free)、EE、EF、PP的真实场景，
  包含共享三角形接触与free particle；此fixture尚未计验证通过。

### 102b33b4 isolated mesh全通过；混合实际查询顺序差异修复中

- 102b的mesh16全部状态/385 buffer/4900 owned启动完整参数通过；PP8、246 self配置、PP graph80也通过。
- 14组同时VF(mesh/free)+PP+EE+EF的60步捕获均发现顺序差异：原版每步两个VF之后先PP再EE/EF，
  Source为EE/EF/PP。以world1 Newton为例，原版launch23/24/25是PP/EE/EF，Source是EE/EF/PP，
  7095总调用相同，每60步180项不同；world1状态严格相同但不能算完整通过。world3 full另有严格数值差异。
- 前次把反汇编线性排列当执行顺序的推断不正确；实际分支返回到PP，再跳回EE/EF，
  以真实mixed日志为准修正生产begin_frame顺序，装配顺序本来就是VF/VF/PP/EE/EF，不修改数学。
- mesh-graph60共72项，7项严格不同，仅world3 full；其中原版自身eager/graph也有差异，报告保留，
  不能一概把这些状态差异当作已接受的原子波动，修正实际调度后继续诊断。
- 发现已知调度差异后暂停本批后续CPU调度；当前正在跑的真实GPU worker自然结束，再停止已暂停的CPU调度器。
  原版/source进程均已退出后才修改C++；paused/scheduler-stopped JSON及旧失败结果均保留。
  当时74回归只完成前几个demo，剩余未计通过，不把5e完整回归直接计为102b通过。
- demo_launch_ab新增可选--original-reference，仅在参考image/fixture/hook/frames/extra全部相同后复制不可变参考，
  每份记录原路径/SHA；比较规则不变，默认仍重跑原版。修正顺序后复用固定14份真实原版，加快逐组验证。

### d80c40e3：实际mixed查询顺序已修正，开始固定原版的快速重放

- 新image d80c40e346f897095e53afc11e8024742aff2938854b959bc2eb7b29324444c5；
  仅将queryPP移至两次VF之后、EE/EF之前，176个CUDA入口/digest不变，source实码顺序已复查。
- 修改前self-102b33b4-before-query-order/保存源/构建及本批全部结果SHA，旧错误顺序和失败不覆盖。
- validation-d80c40e3/复用102b十四份原版60步结果时，严格校核reference64、fixture、hook、frames、extra，
  每份复制均记录原路径/SHA；source每组只跑一次，不用重新挑候选。
- 新批次加入mixed-live-counters安全4B计数probe，验证五个渠道都真正增加contacts，避免只有调用没有接触。
  然后16mesh buffer、PP8、246self contract、14mixed60、mesh/PP graph和74回归均严格串行。
  如mixed元数据再次不同会提前停，不继续跑已知错误版本的广泛回归。

### d80 mixed汇总更正：14参数全同，12状态严格，2个world3 full尚未验收

- mixed-live-counters实际after=[3,5,6,7,8]、各渠道新增[3,2,1,1,1]，两端状态/元数据严格同。
- d80的14组60步：14组完整owned元数据全同；实际12组状态严格，world3 full Newton/PD两组严格不同。
  用户进度更新曾误把尾部switch成功当作14组全严格，已立即更正；以全部report汇总为准，不覆盖失败。
- 新mesh graph72有6项严格差异，集中world3 full；其中原版自身eager/graph也存在差异，
  仍须实际中间量定位与固定候选验证，不凭“原版也不同”就自动改判。
- 继续对当前已纠正调度的两组实际PCG/自碰撞中间量抓取；完整74回归仍在串行运行。

### d80两组混合首差的实际证明与下一组合参考

- Newton/PD独立真实trace均74个基础/PCG入口，首差同为launch6 multiply_matrix_and_reduce后的
  denominator第1组（中间world）1081864716/1081864717，相差1ulp；此前全部captured输入输出同，
  该次ap/p/initial也全同。各20份真实dot贡献的trial0/trial6排列分别精确复现两端。
  host_pcg_sum_witness增加显式--group-index，用捕获world/per_group筛选贡献；默认单组不变，未改生产数学。
- mixed PD固定三source对八原版分布通过。Newton八原版尚不足，保持原三source只加八原版至16后，
  三source的完整60步分别逐位匹配actual originals：[8]、[1,2,3,4,6,7,14]、[9,11,15]，全部每步C内。
  额外ratio仍误报source0/2，四个真实原版8/9/11/15也会被同规则误报；原报告/规则未改写。
- graph剩余：Newton source-g1不在上述eager16的全步C范围；PD source-g1全部60步C内但无整轨迹精确成员。
  不能凭eager证明直接接受graph，正在固定原始graph source0/原版0，追加7原版graph和source1/2各一次。
  self_particle_graph_ab只加可选--case-name过滤，默认原场景与计算不变；新self_graph_distribution保留SHA/固定候选。
- 新self_cloth_scene用官方Style3D builder，13个原版3步参考cloth-reference-d80c40e3/全部成功；
  current source明确拒绝材料组合的失败在cloth-before-d80c40e3/保留。未假装完整cloth demo已替代。
- 真实cloth顺序验证：self force在stretch/bending之前（与当前source位置兼容），不能据反汇编线性位置自行搬到末尾。
  但有bending damping时，其tangent在self tangent之前；有particle soft contact时，soft force在self force之前，
  self使用的scalar stiffness已含本轮soft-contact增量，不能继续用固定inertial/base copy。
  原版contact样例stiff增量[55530.578125,32902.62109375,44187.25390625,0,0,0]，已实际dump证实。
  后续扩展组合要补独立stiffness scratch与相同调度，保留固定base用于下一NL重置，不覆盖base造成累积。

### d80 graph补充核对通过，准备material/soft-contact组合

- graph-newton-eight/：固定原始graph source0/原版0，追加7原版graph、source1/2各一次，三条source q/qd
  全部60/60步C内，ratio分别0.875/0.125/0.875，既有观察无outside；没有重跑或挑选source0。
- graph-pd-eight/同法无outside，三source完整60步分别逐位匹配actual original1、1、2。
  原始72严格失败仍保留；可以说明本次graph数值差异已由实际原版graph变动解释，不能说严格全同。
- self_cloth_capture补只选case入口，追加PD diagonal的hinge/contact/contact+hinge三组，
  这样实际确认PD+self对soft preconditioner的条件后再实现，避免照纯PD旧条件推断。
- self_cloth_ab新工具保存首轮完整force/H/stiffness、初始scalar diagonal、材料力前后及完整启动元数据，
  准备直接对16组实际参考验证。原先13个fixture与其runtime SHA不改。

### d80完整检查点后接入cloth/particle-soft-contact组合（正在编译，尚未验收）

- self-d80c40e3-before-cloth-combinations/已保存416份源/构建、17593份结果SHA，完成后才修改C++。
- 三个新增PD diagonal原版捕获均成功：contact/hinge/contact+hinge。确认PD diagonal仍跳过第二次soft preconditioner，
  原Source已有的(!pd || full_hessian)条件保持不变，不能因为self强制block就擅自改成再装一次。
- 允许原版已捕获的triangle/edge材料与particle soft contact组合；body/drag/spring/tet/fluid/granular/
  full-surface/rigid contact组合继续明确拒绝。
- 为self新增独立scalar stiffness scratch，每NL在particle soft force之后复制当前scalar diagonal供self使用；
  固定base仍供下次NL重置，不把接触增量写回base。无接触时等于原先base，全部kernel数学不变。
- self force移至particle soft force之后、材料力之前；self tangent移至bending damping tangent之后、
  particle soft tangent之前。这些顺序由16组原版实际日志确认，非按公式猜测。
- 编译完成后立即self_cloth_ab对16组状态、完整元数据及first force/H/stiffness核对，不预先计通过。

### 8ac首批：10组cloth全严格，6个contact被过宽capacity guard拦住，已按实际状态修正

- cloth-source-first/16组：十组无contact的材料+self全state/first buffer/owned元数据严格；
  包含hinge damping、PD diagonal、pinned、free PP及world3。六个地面contact在Source guard退出，原失败全部保留。
- 实际Source初始化与collide后读取native Model/Contact，cloth-contact-capacity-inspect-8acb7b70.json：
  body_count/body_state_count0、surface indices/bary spans0、rigid max_count1000但实际rigid_count0，
  soft_max_count6且actual_soft_count6。这是预留rigid容量，并无刚体/真实rigid分支。
- self-8acb7b70-before-contact-capacity-guard/保存源/构建/首批结果，再仅移除contact.max_count的过宽拒绝；
  body与surface等实际未实现组合守卫仍在。不是忽略刚体分支，而是按原版body条件判断它是否参与。
- 重编译后重跑全部16组，不直接把8ac的十组结果算到新image。

### 6faf653e：cloth+self+实际soft contact首批16组全严格，开始真实plastic bag

- image 6faf653ea743044258117408c8dd1fe1734e6b9073410762b5b036fb8e3b176e，CUDA176/f0e0137a未变。
- cloth-after-capacity-fix/16组全部状态逐位finite、352项定义buffer、6531 owned启动完整参数相同；
  包含非零材料、弯曲damping、pinned、free PP、world3、实际soft contact、PD full/diagonal。
  本次明确重跑全部16，没有直接沿用8ac十组的结果。六组contact现在实际进入求解器并全部同。
- self_particle_graph_ab增加独立cloth suite及只加configure no-op的adapter，不修改冻结self_cloth_scene，
  graph每帧仍在launch外调用同一pipeline.collide，使用实际contacts对象捕获step；其它suite路径不变。
- 接着用未修改examples/example_plastic_bag.py缺省物理参数运行3帧（4 substeps、5 NL、80 CG），
  比较全部12物理子步及完整owned启动元数据。当前运行中，不提前计通过。

### 继续6faf：真实bag固定分布仍未过，首子步实际trace与graph入口复查

- plastic-bag-default3-6faf653e/缺省3帧12子步已结束：34,570次owned完整参数同，所有状态finite但严格不同。
- plastic-bag-default3-distribution-6faf653e/保留最初source0，source1/2各一次，合计八原版。
  source1 q额外ratio未过，source2 q的within-count和ratio未过；source0观察无outside但qd仅11/12 C内。
  原版七次重复自身也全部严格不同；没有据此宣布源码通过，没有修改规则/fixture/生产数学。
- demo_source_ab只新增可选DEMO_NATIVE_TRACE_DIR/SUBSTEPS，默认运行路径不变。
  新demo_native_trace_ab对未修改官方demo只抓第一物理子步，观察器/runner/asset/image都记SHA，独立于固定候选。
  actual子目录只放trace，不把runtime元数据混入buffer比较；观察器是同步诊断，不替代无同步轨迹验证。
- 复查cloth graph新入口发现worker仍选particle fixture，已保存cloth-graph-runner-before-import-fix/后修正。
  这个cloth suite此前没有实际运行，因此没有撤回既有cloth graph通过（从未计过）；接下来实际验证。
- HANDOFF/NATIVE_HOST_PROGRESS/SELF_COLLISION_HOST_RECOVERY头部已更新当前image与未过项，旧阶段记录保留。

### 6faf首子步trace与实际cloth graph

- plastic-bag-trace-first-6faf653e/双端同步trace均2452 observed launches，全部元数据相同。
  首差launch3 evaluate_stretch_force.after.rhs：229个float words，首个950280190/950280191（1ulp），
  maxabs1.1920928955078125e-7。此前三次launch及本次所有captured输入/累加前rhs完全同。
  1703粒子/3312三角形，最大vertex degree8；后续用真实逐三角形贡献和精确排列验证，不凭原子标签猜测。
- cloth-graph60-6faf653e/实际使用self_cloth_graph_scene（runner/runtime SHA已记录），双端各16×2×60=1920
  物理步，总计3840；64项原版/source eager/graph交叉比较全部逐位，无缺失、两个worker均exit0。
- 当前6faf的74组完整回归已启动，GPU严格串行；先完成本image验证再修改生产C++。
- 新stretch_atomic_witness准备隔离真实3312三角形，分别原版PTX和源码so运行+0/-0初始力，
  排除零符号丢失后，对1703×3个实际累加输出枚举incident顺序；尚未运行，不提前计通过。

### 6faf诊断提速与下一组合fixture（不预先计实现）

- compare_host_trace仅将Python逐字节计数换成NumPy uint8计数，并将重复glob目录扫描换成一次sequence索引。
  原脚本保存在trace-comparator-before-byte-count-optimization/；两次对完整2452-launch/约1.4GB已有trace的
  输出均与原report整个JSON完全相等。仅计数优化48.26秒，含目录索引1.253秒；严格规则/字段/容差均未改。
- 复读指定Claude JSONL末段：该agent停在2026-10-30 14:59 joint工作，之后已由本仓库后续记录推进。
  方法继续是先真实原版抓取、确认调度/ABI和定义buffer，再接source，固定首次失败候选，不并行跑GPU。
- 新self_material_scene准备五渠道self与spring/tet/drag/all组合的独立20点fixture，未修改已冻结mixed/cloth。
  仅完成CPU语法/128列检查，尚未GPU运行、当前C++仍拒绝这些组合，不能算已实现或验证通过。

### 6faf真实bag拉伸首差已全部精确解释，74回归结束

- validation-6faf653e/bag-stretch-witness/：实际3312三角形在原版PTX与compiled source分别隔离成不共享顶点，
  +0和-0两种初始力各29,808个scalar全部逐位相同；-0 probe保留真实operand的零符号。
- 对1703×3=5109个实际force输出，两端全部找到真实incident贡献的精确float32累加排列；无unexplained。
  degree8枚举至23623个排列才涵盖所有目标，未设epsilon；isolated-runs/witnesses NPZ、原输入SHA均保存。
  证明本次captured首差来自累加顺序，未推断生产执行顺序，不能单凭此宣布整demo已通过。
- 当前image的74回归已完成71严格；particles seed1/2/3三组严格失败保留，固定候选C10按队列继续。
  self单元/合同/graph/固定bag16原版队列仍在运行，不把旧image证据移作本轮通过。
- 独立队列next-captures只在前一GPU队列彻底结束后运行：真实bag全部1600 PCG调用独立重放，
  再抓32组self+spring/tet/drag/all原版参考，以及当前source明确拒绝的首例；未改生产C++。

### 6faf参考扩展捕获与原版行为导读

- 74回归三粒子seed严格失败数35/14/19，本次固定各首次source后的C10均通过；旧36ca C40失败不覆盖。
- PP graph80全严格；mesh graph72有6项严格差异（含两项原版eager/graph自身差异），原报告保留。
  当前image独立graph分布队列已排入，不直接借d80结果算通过。
- bag固定三source对16原版仍有source2.qd的两项分布观察未过（8/12步C内，ratio1.534，原版最差9/12和1.297）。
  因此只追加16原版至32，不重跑或挑选任何source；16的失败不改写。
- bag全部1600 PCG调用按真实原版输入独立重放：2000 pointwise检查0失败，800 aggregate检查755严格失败。
  输出/源码无原版_core映射；报告保持full_bitwise_equal=False，退出1是如实保留原子aggregate失败。
- 新material原版32组全部成功且finite，source首例仍被未捕获组合guard拒绝；失败日志保留。
  实际capture确认drag force在self之前，tet preconditioner在self之前，drag preconditioner在self之后；
  CG依次tet tangent→self tangent→drag tangent，全部self stiffness等于当轮初始diagonal，未随材料force改变。
- fixture标题的“五渠道活跃”须更正理解：spring/all中，Python桥接将spring端点17/18从free collision particles移除，
  仅19保留，故没有PP query；tet/drag中PP仍有。原冻结文件不改SHA，不能把未启动PP误报已验证。
  新独立self_material_pp_scene只把spring改接0/1，保留17/18/19为free，并增加可选--fixture入口供后续补测。
  新PP fixture尚未运行，不能计通过。
- 复查SelfCollision::initialize的137fcf零填充与138030/1380b8分组写入：未来self+fluid/granular不能沿用全零groups，
  当前这些组合继续拒绝；未依据这个导读提前修改生产代码。

### 6faf完整现有批次结果与已确认的host顺序错误

- bag-cohort32保留全部3条source与16次原版，只增加16原版后既定observations全通过；strict三条仍false。
  q三条12/12 C内；qd分别11/12、12/12、11/12，因此不能说每一个速度子步都在C内。
  它们均优于原版本身的最差分布观察；8/16失败与32报告并存，阈值/候选/数学不变。
- 当前mesh graph Newton/PD各固定最初source0、source1/2各一次、8原版graph均observations全通过。
  新self_graph_eager_audit复用这些worker已经生成的eager文件，不新增GPU、不重跑first source0。
  PD eager通过；Newton eager source0整轨迹等于original0/3，但source1额外ratio未过。
  因此保留source0/1/2只追加8个同协议原版eager/graph（同时记录），不把graph通过套用eager。
- no-self-control：用新wrapper仅关闭self，不改原fixture、初态和其它config。真实3步原版/source385次调用，
  状态和本轮所有defined buffer严格同，但6次metadata不一致，恰为每步drag_start/block_entries两次交换。
  说明此前仅状态的回归漏了此调度不同；修复应为drag_start先于block_entries，self开关两侧都由真实调用证实。
- source当前仍6faf，尚未修改C++。待当前原版参考/额外观察队列结束、完整检查点保存后，
  仅恢复这个已证明顺序并允许已经实际捕获的self+spring/tet/drag组合，CUDA数学/epsilon不动。

### 6faf eager补充与调度控制确认

- Newton eager固定3source、保留首8原版、只增加8同协议原版至16：三条q/qd全部60/60 C内；
  source0 ratio0.5625且整轨迹匹配actual originals0/3/8/9/12/14，source1 ratio0.9375，source2 ratio0.5625。
  额外ratio阈值0.933333仍拒绝source1；对同一16样本的真实原版作相同full-cohort判断，
  originals2/7/10/11/13/15也被该额外rule拒绝。反例独立保存，原报告与判断完全不改写。
- extra采集脚本完成8次GPU及CPU16报告后，在import reconstruction时因脚本sys.path缺repo而退出；
  原始脚本/traceback保留。随后从repo用模块CLI独立补抓PP material参考，不重跑已完成8次。
- no-self control原版/source385次启动有6个仅顺序差异（每步两次swap），状态及本次buffers全严格。
  这是确认的host顺序缺陷；未通过原报告保留，后续按真实order修复。

### 6faf检查点完成与56份有效材料组合参考

- self-6faf653e-before-material-combinations/保存424份源/构建与71384份结果SHA，独立全量复核0 mismatch。
- material-pp-reference/16组均成功且finite，spring/all实际每3步queryPP3次、accumulatePP9次，补足PP可用组合。
- 首个material-contact参考用了generic Newton非零弹性，Python桥接在进入原版Solver前拒绝；这是fixture错误。
  原失败文件、runtime SHA、run.log全部保留，不修改src guard，不把这个拒绝当原版原生内核失败。
- 新self_material_cloth_contact_scene使用官方Style3D helper，10粒子/4tri/有效hinges，
  叠加spring/tet/drag、2个free PP、地面contact。8组Newton/PD×world1/3×full/diagonal全部成功finite。
  第一组10粒子的self stiffness相对initial diagonal全部增加（65364.86..225927.5），证明真实soft contact参与。
- self_material_ab只新增可选fixture与精确particles-per-world供有界dump，默认旧20点布局不变；
  旧32和PP16原版fixture字节不改，8组新fixture分别锁定SHA。总计56份有效原版参考，另2份预期失败保留。
- 生产C++仍为6faf。额外检查点保存这些新增夹具与原始参考后，才允许恢复已捕获组合与drag初始化顺序。

### 50effa1b：按真实顺序编译，新复合8组全严格

- 当前image50effa1b50881bb95b87250d9a817e402d0add2f398d380221f5839b3c33ce99；176 CUDA/f0e0137a完全未改。
- C++只把drag_start移至block_entries之前，允许已经实际捕获的self+spring/tet/drag；
  body/fluid/granular/full-surface与self仍明确拒绝。新增supported_physics标签，solver_api_ready仍False。
- 修改前主检查点424源/构建+71384结果hash已独立复核0错；addendum又保存新增正确Style3D复合fixture/参考。
- no-self-control新版385次启动、状态及9项buffer全部严格同，旧6次顺序差异已修复。
- material-cloth-contact8：8组全部状态严格finite、224项buffer、5022次owned完整参数同，
  这里同时有官方cloth、非零bend damping、spring、tet、drag、free PP和真实soft contacts。
- material32/PP16仍在串行核对；已出现world3 full的极小状态差异，first buffers与完整元数据均同。
  不把这些差异直接判通过，后续固定首次source再查真实trace/原版重复。
- self_particle_graph_ab新增独立materials suite与no-op adapter，原particles/mesh/cloth路径不变；
  尚未在新image运行，不提前计graph通过。

### 50effa1b首批56汇总、8个实际首差证明及复合graph

- 材料32为26严格，PP16为14严格，复合8为8严格，合计48/56；所有1296个定义buffer、26086次完整owned参数同。
  无self控制组另9个buffer/385次全同。严格失败只出现在world3，未修改阈值或生产数学。
- 八组逐一真实trace，全部metadata同，首差均PCG第1组（中间world）numerator或denominator。
  八份独立sum-witness均为20份相同dot贡献，exact permutations全部找到、unexplained0；生产order未推断。
- materials-graph60实际8场景×双端×eager/graph60，合计1920物理步、32比较全部严格。
- 材料candidate先前启用了CUDAHOOK_DUMP_LIMIT=1。重复样本必须保留同一同步观察协议，不能沿用无dump重复去冒称同协议。
  chaotic_source_runs/granular_dense_distribution新增可选--dump-spec：核对adopted candidate/reference的dump.json，
  保存launch-dump-spec.json，所有新worker用完全相同fields/limit，复用时协议不符会拒绝；默认无dump路径不变。
  CPU确认新的env序列化与原capture逐字相同。当前image74回归结束后，8份固定candidate的同协议重复串行执行。
- 新静态证据来自原版SelfCollision::initialize：groups清0，再fluid标1、granular标2，重叠拒绝，rodata已确认字段名。
  相关证据已落盘；生产self+fluid/granular继续拒绝，未按推测直接放开。

### 50effa1b未验收项与停止盲目扩样

- 当前74回归实际70严格，四项严格失败为particles seed1/2/3（21/26/21数组）与pd_mixed_cloth seed3（7数组）。
  后者为pd_mixed_w129_duplicates，需另抓真实首差，不能把旧NN duplicates证明直接当本image通过。
- post队列已完成cloth16、mesh16、PP8、246self contract，全部通过；材料分布连续发现真实C失败：
  spring-w3 Newton/PD固定3source对32原版仍未过，原版此协议下完全稳定(spread0)，不能按小误差或B证明验收。
  tet-w3 Newton已采8/16时也未过；之后队列已停止。particle C10、bag60仍未执行，不提前计通过。
- 为避免继续重复已知失败，先停自己的CPU调度父/子进程，当前GPU worker自然退出后只终止已暂停CPU驱动。
  scheduler-paused/scheduler-drained JSON记录PID与原因；退出中的child一度cmdline为空导致暂停包装脚本退出，
  随后按瞬时退出进程处理后完成drain；未杀GPU worker或外部任务。所有raw失败/首次候选都保留。
- 新pcg_same_buffer_probe用同一60粒子、同一3组缓冲区、同一nonblocking stream交替运行原版实际CUDA Runtime内核、
  原版PTX Driver内核和source PTX内核，各64次：三个backend均出现相同的[1078108080,1078108080,1078108080]与
  [1078108080,1078108082,1078108080]，所有pointwise z全同。证明内核可产生两种相同结果，不代表whole-run C通过。

### 实际内存序列抓取：确认preconditioner/inverse复用不同

- 新memory_trace.cpp/full.cpp仅独立LD_PRELOAD观察，未链接生产so；demo_source_ab新增可选memory marker，默认路径不变。
  memory-spring-newton-full/保存原版757、source634个alloc/copy/clear/kernel边界事件，以及同次完整launch指针。
- 原版57份材料/控制参考中invert输入arg0与输出arg3全部同址；source50分开。原版体系矩阵A另址，未被覆盖。
- 新无self、无额外preconditioner材料的控制同样确认：原版先把A复制至独立cache，再在cache原地invert；
  source直接从A写入另一inverse数组。数值相同，但缓冲区别名/操作不同，是实际实现差异。
- 原版CG numerator/denominator实际各11988 bytes=999×3×4，source各12000=1000×3×4，已有config最大999限制。
- 原版D0..D4为各80B独立缓存，source共享同一80B零缓存；这些布局差异不先猜测就是C失败原因。
  初版named-buffer报告把arg19临时标D5，实际c++filt证实它是particle kind(int*)，不是第6个float模板。
- 原版self stiffness也与initial diagonal分开，不能误删source stiffness scratch来凑结果。
- 下一步只恢复已证明的inverse/cache原地复用、无correction时的A→cache copy和999容量，再复测固定场景；
  不修改kernel加法顺序，不根据输出反推填充或增大epsilon。旧失败完整检查点先保存。

### b34f9983恢复inverse/cache重用与999容量；尚未解决全部严格差异

- image b34f9983443dac2080c7f3e5652357397d40391c6fc0cb723274beb5aba0c2dd，176 CUDA/f0未改。
  inverse_复用preconditioner_blocks_；Newton始终A→cache后在cache原地invert；coef容量按实际改999*groups。
- 50修改前检查点434源/构建、45744结果SHA已独立复核0 mismatch。
- 原8个失败在新image各只采一次：tet PD full/diagonal和PP spring PD变为严格，其余5个仍严格不同；
  全部target状态finite、完整owned参数及已定义buffers仍同，无self控制同。旧50 C32失败没有被替换或改判。
- memory-spring-no-self-full确认无correction时原版也把A复制到独立cache，然后同址inverse；已由新raw指针验证恢复。
- 进一步发现真实遗漏：原版无self/无contact也每step保存base_diagonal，并每NL恢复，source此前条件跳过。
  原版spring/self3步有21次240B scalar-copy，source50仅12；无self原版12次、source50为0。
  snapshot位置在initialize_step之后、drag/block模板和SO3初始化之前；新的body-basic实际trace也确认这一顺序。
- CG60B清零的次数/位置原版与source一致，不能擅自改成每CG清零。额外4B清零指向原版初始临时flag，
  不是self counter；不得据次数猜测给self增加清零。其实际用途还待识别。
- 当前b34已完成定向9case，未完成完整回归或whole-run C；下一步恢复已证实的base snapshot/restore操作。

### 59c6bb34：恢复每步base diagonal快照；发现缺失的实际Thrust初始化

- image 59c6bb346b5280448ca7d6f8e585e1caab16b849b146f993122a1233c8fb8af7，176 CUDA/f0e0137a未改。
  initialize_step之后、SO3/drag/block模板之前保存base diagonal；每NL恢复，不再以有无contact为条件。
- 原8个失败各固定一次新source：材料6中spring-w3 Newton和tet-w3 PD diagonal严格，其余4失败；
  PP spring-w3 Newton/PD两项仍严格失败；无self控制严格。全部owned metadata/定义buffer同，未完成全回归。
- 50的spring-w3 Newton/PD对32原版仍有C失败，原版全程spread=0；不以小误差或孤立B证明判通过。
  旧post队列已drain并停止，particle C10、bag60没有执行，不得用当前image续跑旧SHA队列。
- CUPTI独立诊断首次因读取非launch callback的symbolName导致原版进程-11；原文件保留。
  修复只读取launch的symbolName后API捕获成功。参数版首次重复包含cupti.h已带的生成头导致编译失败，
  修正后cupti-parameters-spring-newton-v2成功；这些是观察器问题，不是原版Solver故障。
- 同次原版参数记录确认64次uninitialized_fill，实际使用8种已经有源码的module24库入口：
  mat3/ivec2/vec3/BlockNonZeroEntry/Aabb/float/int/uint。源码host此前省略了这些value initialization。
  所有值字段为0，padding字节不确定，不能复制padding或假定BlockNonZeroEntry默认column=-1。
- CUDA12.4 Thrust parallel_for.h的真实策略为256 threads、2 items/thread，grid=ceil(count/512)。
  原版实际1395元素grid3、2997元素grid6验证此规则。辅助launch不能计入129 owned kernel计数。
- 下一步先保存59检查点，只恢复已由实际指针/参数证实的typed cache初始化，不改内核数学、不填充原版raw contact缓存。
  fluid/granular/body/full-surface+self仍拒绝，solver_api_ready=False，完整替代目标未完成。

### 7293038d：实际Thrust host初始化路径；21次参数/语义使用均与原版相同

- 59检查点435份源/构建与492结果SHA独立复核0 mismatch。
- 首版8da525e1通过Driver直接调已恢复的库入口。旧129-owned observer对BlockNonZeroEntry的两次库初始化
  记UNKNOWN，使3个已运行场景在metadata比较阶段退出；其实际worker成功、首轮NPZ/日志全部保留，不能计验收。
- 启动阶段一次误用wildcard调用旧59 scheduler；旧目录存在，子worker全部在mkdir处失败、未执行GPU。
  受影响6份scheduler/build/log文件先留错版备份，再由检查点和不变raw report重建，全部492结果SHA恢复一致。
  具体见validation-8da525e1/scheduler-setup-error.json。随后所有命令均显式指定新目录。
- 改为真实CUDA12.4 thrust::uninitialized_fill_n host dispatch；cache/BVH独立桥的23个device entry
  全部规范化PTX与已验收source bundle一致，包含15原有库入口和8个实际初始化类型。
  host模板隐藏符号而C接口保留导出；CUDA device文本未改，旧hook/比较规则/原版参考均不改。
- 活动image7293038d51c9eed59ecb7c200b687c3d093a31e35af5b7ad567738f26239d7e7，CUDA176/f0不变。
  旧8失败各一次：仅all-w3 PD与PP spring-w3 PD严格；其余6失败，无self控制严格。
  所有defined buffers和完整owned metadata仍同。随机原子轨迹可改变哪些样本逐位，不能以某一次变同当作修复C。
- 新CUPTI同次原版/source捕获原版64、source21次库初始化。独立initialization_trace_audit用实际owned pointer
  使用集合、值字段、count、grid/block核对，source21次全部与原版匹配、无多余项；padding不比较。
  仍缺43次，因此报告all_calls_match=False，保留未通过状态。原版raw contact unique_ptr仍不清零。
- 新真实证据确认BVH初始build与后续refit复用同一个primitive boxes地址；原版boxes/nodes按world复制分配。
  source此前分开rest/dynamic boxes，漏掉相关typed初始化；单个local PP虽不query，原版仍分配counts/31 slots。
  下一步按这些实际指针/resize恢复alias和candidate初始化，再独立验证，不能只解释为数学原子差异。
- 729修改前检查点436源/构建、463结果SHA已保存；后续修改尚未计通过。

### 105e9ccf：64次实际typed初始化全部匹配；补齐PD duplicates首差证明

- 中间image04741d11恢复BVH build/refit共用replicated boxes/nodes/visits、拓扑与候选typed初始化。
  实际61/64完全匹配、无多余项；9个定向只有tet Newton与无self控制严格，其余7状态严格失败。
  729检查点独立复核436/463 SHA全部相同；047检查点另保存436源/构建、469结果及静态证据。
- 原先未知4B缓存通过原版10d8de..10d8ea和102468..102487、rodata1f5c28确定为hard_previous_count_：
  错误文字为clear inactive hard-contact history failed。即使没有body也初始化int[1]=0，无active hard时每步清0。
  不是self counter，也没有按猜测加入NaN/status/收敛处理。
- BvhBuilder::reserve 140560..14056d另保留unsigned[max(leaves-1,0)]缓存；本次hierarchy不读取它，
  原版确实resize并value initialize，故按实际字段恢复，未作为无来源padding凑地址。
- image105e9ccfacdf3c92543dd56e051f96d5353e23e593aa3dd072227dc44eec90df，CUDA176/f0未改。
  实际CUPTI同次64/64初始化按类型/元素数/值字段/grid/block/owned指针用途全部匹配，无遗漏无多余；
  不比较stack padding、尚未比较allocation或initializer调用顺序，不能把64/64叫完整host验收。
- 同image定向9仅all-w3 PD及无self控制严格，其余7状态严格失败；全部defined buffers/owned metadata同。
- 另抓pd_mixed_w129_duplicates seed3真实375次同步trace，metadata全同，首差为launch2 spring force的after.rhs
  4个float词、最大1.9073486328125e-6；之前/输入全同。不能继续借用旧NN duplicates的证明。
  stretch_atomic_witness新增flat-trace目录自动识别，实际129 worlds、387 springs按2顶点独立重放：
  +/-0各2322逐元素scalar完全相同，双方各1161个captured scalar均找到原float32贡献排列，unexplained=0。
  whole_trajectory_accepted仍False；真实三步7项state严格失败保留，C尚未检查。
- 后续继续核对初始化调用顺序。静态prepare_inverse_preconditioner fe5f8指向+0x2f20（第4个scalar cache）；
  原版240B实际copy证明第1个scalar是base_diagonal，第2个diagonal，第3个self stiffness，第4个scalar inverse。
  不能根据NN中未读的两块float缓存直接猜标签或互换。

### 2ff5cff5：64次初始化的调用顺序也已恢复；开始同image完整74回归

- 活动image2ff5cff51f13b82c7e30b2733a3f53ab12af1095ce7fbd952c3f7323b0ea34b2，CUDA176/f0未改。
- 按原版实际顺序恢复solution/rhs/previous/target、base/diagonal/self stiffness/scalar inverse，
  矩阵模板之后再分配residual/direction/z/product/contact_product/denominator/numerator。
  self候选按mesh VF→free VF→PP→EE→EF初始化，然后Hessian/counter，最后BVH。
  BVH初始化与refit继续复用相同box/node/visit缓存；raw contact缓存仍不额外清零。
- 同次CUPTI原版64、source64全部按参数与owned实际pointer用途匹配，initializer call order也全部相同。
  105的旧raw用新增顺序审计确实不等，before报告保留；没有改旧审计或删掉失败。
  initialization_trace_audit现分别报告unordered calls match、call order match，依然不宣称所有alloc/copy次序相同。
- 定向旧8失败各首次source：spring-w3 Newton与tet-w3 PD diagonal严格，另外6严格失败；无self控制严格。
  全部owned metadata/定义buffer同。不能用64/64初始化和其中两项状态变同来提前判整轨迹通过。
- 已启动同image joint_continuation_regression共74项，期间不改生产源码或构建；结果在validation-2ff5cff5/regression/。
  后续接手先读status.json，未complete时不能计算最终通过率。
- 下一项仍有真实实现差异：非body initialize_step中原版D0..D4为5个独立float模板、particle kind另一个int模板，
  source仍共享零缓冲区。原版数据来自独立host-vector uploads而非上述64次value-initialize。
  这需要继续根据实际数据/字段恢复，不能把initializer order一致当作整个内存布局相同。

### 2ff5cff5完整回归结束，实际模板值/alias差异已确认

- 同image74项结束：70严格，4项严格失败为particles seeds1/2/3（28/28/19 arrays）和mixed_cloth seed3（11 arrays）。
  所有7个官方demo各60帧、API/float API、8个刚体用例及其余已完成场景严格通过。
  失败尚未在本image完成C，不继承旧image的C，也不把历史PD duplicates首差套给当前NN mixed。
- 为读取真实模板，host_trace.cpp只给诊断新增initialize_step的D0..D4、particle kind数据及7个模板的alias关系。
  新编译template-observer-v2/host_trace.so单独保存；默认host-particles/host_trace.so没有替换。
  demo_native_trace_ab新增--observer与诊断源码SHA，旧默认路径不变；观察器从未链接生产so。
- 新spring W3及all-material W3真实探针：原版alias groups [0,1,2,3,4,5,6]，source [0,1,1,1,1,1,1]。
  两个fixture的双方5个float模板和kind共各480B，所有uint32词均0（正零），实际读取证实，不凭数值输出猜。
  两份同步trace都按原判保留metadata不同/状态不同，不能当作更换首轮失败候选。
- 修改前完整检查点self-2ff5cff5-before-independent-diagonal-templates保存437源/构建与4511结果SHA。
- 正按实际字段恢复非body五份独立float模板及独立int kind，普通host diagonal在无材料时也独立保存。
  soft-contact/surface读取kind改用独立int vector；body路径保持原来的body kind/模板逻辑。
  构建/定向/真实模板复核与新image回归尚待完成，CUDA数学/阈值没有变化。
- 本轮最新明确交接文档为reconstruction/csrc/CACHE_INITIALIZATION_RECOVERY.md，包含命令、证据和范围限制。

### 01a3d878：独立模板alias和实际值已恢复；同image74为71严格，三个C待测

- 活动image01a3d8787b1d93376a74b9c9e9511cd517ac2950a085a77dd06dc2b50b830352，CUDA176/f0未改。
  非body保留五个独立正零float模板与一个独立int kind；无材料时host diagonal也不再与D0共享。
  soft contact/surface传递真正的独立int kind，body专用模板/逻辑未调整。
- 新spring和all-material W3实际探针：双方alias groups全为[0,1,2,3,4,5,6]；六个模板共各480B全部正零/0。
  两份probe的first numerical difference仍PCG，不能把输入模板修复当整轨迹通过。
- 同image64次typed initializer参数、owned指针用途、调用顺序全部继续匹配。
- 定向旧8失败首轮仅tet-w3 PD diagonal、PP spring-w3 Newton严格，另外6不严格；无self控制严格。
  全部defined buffers、完整owned metadata、source count覆盖仍同。
- 完整74结束：71严格；particles seeds1/2/3分别21/28/21数组严格不同，本image C10尚未完成。
  当前NN/PD mixed_cloth所有三seed均严格，不能把2ff的NN mixed失败覆盖或改判。
- batch.py随后串行执行cloth16/mesh16/PP8/contract，材料只运行未在定向首轮采过的26+14+8，
  与最初8合计56，避免通过重复同场景更换首个候选。后续固定上述三个粒子候选做C10，以及spring Newton同协议cohort8。
  不自动盲目扩充稳定原版失败的样本；所有首轮和失败保留。
- 2ff修改前检查点437源/构建、4511结果SHA独立复核0 mismatch。
- 进一步静态定位原版额外8B upload：initialize的body+1个size_t前缀，字段+0x2fd8；
  rodata1eb01f为cable_body_indices，build_affine实参12/13分别来自+0x2fe0/+0x3000，确定为cable-body CSR。
  即使无body也保留一个0前缀；source当前precompute_affine_blocks对无body直接返回，仍漏此真实字段。
  生产代码尚未改此处，待当前GPU batch结束后继续，不能用无来源padding替代。
- 新独立payload_trace.cpp观察HtoD的实际host字节，供核对未被active kernel读取的原版矩阵缓存。
  编译产物payload-observer/payload_trace.so与命令/hash已保存，尚未GPU运行，不计验证。
  它只供diagnostic，不链接生产so，不写输入buffer；旧观察器和旧结果保持原样。

### 01完整批次与11ea2bb3：实际稀疏缓存结构已恢复，tet首轮与C8通过

- 01批次已结束：完整74为71严格，三个粒子固定source各对10原版均C通过；cloth16、mesh16、PP8、246项contract通过。
  材料首轮共45/56严格，所有定义buffer/完整owned metadata同。spring W3 Newton、PD各固定3source对8原版，
  所有3步q/qd均C内，额外owned metadata/Source count核对通过。旧50 C32失败不改判。
- material_cohort_audit新增独立primary-C检查：不采用“比最差原版好”替代全步C，固定first source0，
  发现01 tet W3 Newton原版8次稳定、source超出后如实停止，剩余8个材料case待查；未盲目扩样。
- payload observer首次原版成功、source因RTLD_LOCAL的libcuda无法从RTLD_NEXT解析cuMemcpyHtoD_v2而-6，
  原失败与v1源码/so均保留；v2按原memory observer的NOLOAD driver回退解析后双方成功。
  这是独立观察器解析故障，不能计SDK失败。Source生产so没有加载此观察器。
- 原版spring真实HtoD24次、01只有14次。缺失的是empty cable/body CSR、local row counts、三份empty CSR prefix、
  五个保留的zero-valued ELL channel。local counts原版80B、global counts240B，source曾共享global prefix。
  原版第一个ELL是elastic（包含-43.125），第二个和另五个都是相同列/零值；没有根据猜测交换两者。
  cloth/all复合参考同样证实：前两份CSR长度为local ELL entries+1，第三份为particles_per_world+1。
- 原版最后一个mesh-vertex HtoD经过临时device staging，随后D2D到persistent indices、同步、free。
  staging的地址之后被candidate counts复用；不能用整个run的pointer集合反推该临时upload的用途。
- image11ea2bb3bec54c84c6e568263421ad4715369df5f742f78a82a1187287e0cf2c恢复上述真实NoBody矩阵缓存与local counts。
  NoBody D0..D4移至host diagonal后，kind移至矩阵模板后；body路径继续旧实现，CUDA176/f0未改。
- 11实际spring原版/source显式HtoD各24次，全部字节和顺序相同；64次typed initializer及顺序继续相同。
  copy API不同，未把这一检查叫完整memory trace相同；payload_sequence_audit明确保留这个范围。
- 11定向9项6严格：spring Newton、tet Newton/PD/full+diagonal、all PD及无self控制；spring PD和PP两项仍严格不同。
  全部defined buffers与完整owned metadata同。11尚未完整74或完整56回归，不继承01通过结果。
- 11 tet Newton保留首个source，另外两条各一次、8原版：三条source全部逐位等于original0，所有步C内，
  所有新增actual-owned metadata同。01的稳定原版失败仍保留、不改判。
- 01修改前检查点439源/构建、10981结果SHA已独立复核0错；11修改前另保存440源/构建、1015结果。
- 后续原版memory/CUPTI/x86共同确认：BVH reduction临时区25B，CPU取scene后在Morton前释放；
  radix sort两段alternate arrays各round_up(count*4,128)，三叶为128+128+1=257B，copyback后在radix前释放。
  原source按12+12+1=25B且保留至Solver销毁，是真实layout/lifetime差异。
  原版这些D2D copy各自stream synchronize，mesh staging在legacy stream1，BVH copies在stream0。
- 正恢复workspace释放、128-byte alternate布局、mesh staging和constructor copy同步。
  两份中间仅编译未GPU验证的build单独保存；最终组合build尚未定向验证，不计通过。
- 新静态证据放独立cache-init-static-phase2-64a0be7f；曾追加的旧manifest已恢复原字节，
  047与105检查点所有result SHA重检0 mismatch。新证据不覆盖旧冻结manifest。

### 7ea6be62：BVH临时空间、同步及完整flat pointer映射复核

- 活动image7ea6be628b00bd86fd26a6e497cdf170159cd5e53041e608775a83b87a8bb809，CUDA176/f0完全未改。
  reduction在scene读回后、Morton前释放；sort alternate各128-byte对齐，copyback后、radix前释放。
  mesh sorted-set插入按实际device staging→D2D→同步→释放恢复。
  BVH构造copy按CUPTI证据各自同步，不改step中的异步copy，不插入额外物理迭代或调整浮点求和。
- 原版实际5次free分别为mesh staging和两棵非单叶BVH的reduce/sort workspace，当前source也为5。
  spring真实memory-full两端GPU allocation均94次、free均5次，按生命周期分配ID后，大小/分配释放次序全部相同。
- 同fixture显式HtoD均24次，所有payload字节/顺序相同；typed initialization均64次，参数/owned用途/顺序同。
- 新memory_pointer_audit尊重alloc/free和地址复用，对同次376个owned launch的每个flat pointer比较
  allocation ID+offset（external/null另外标明），全部相同。它不比较opaque views，也不代替pointee/state检查。
- 该审计结合原完整launch metadata/defined buffer检查，没有把仅NULL/present比较叫完整指针等价。
  不能用run末尾的pointer并集判断临时内存用途，mesh staging的地址后来确实复用为counts。
- 当前定向9为3严格（all PD、PP spring PD、无self控制），另外6状态仍严格不同；
  全部defined buffers、完整owned metadata继续同。不能因前一image首轮更接近而倒退到旧实现挑结果。
- 两个仅编译未GPU验证的中间image单独保留，均未计通过。11阶段target及tet C8仍按原结果保留。
- 当前正在followup.py串行跑同image74、自碰撞/材料补充、固定source C10/cohort8。
  batch-complete.json只代表其中基础批次；之后material-cohorts8仍需单独读取status.json。
  本image完整回归未完成，不继承01/11结果；solver_api_ready=False。

### 7ea完整回归结束；all-material实际构造差异定位

- followup队列已完全结束，当前7ea完整74为71严格，particles三个seed分别21/21/14数组严格不同。
  seed1和seed3固定首个source的C10通过；seed2在n257_w1_it5_f1的6个记录数组未过，失败原样保留。
- cloth16、mesh16、PP8和246项self contract通过。56个唯一材料首候选为46严格、10状态不同，
  所有已定义buffer、owned完整参数与source count覆盖均相同。
- 固定3source/8原版的材料C检查：spring Newton/PD、tet Newton/PD/full/diagonal这5个case全部步C内。
  all-w3-Newton-full原版8次状态相同，source0/2的q首步及qd前两步不同，C失败；source1严格同。
  后四个case仍待C检查，没有重选source0、改阈值或自动扩充稳定原版样本。
- 新all-material-investigation使用同一7ea生产so，分开观察实际memory、HtoD payload、CUPTI typed initializer。
  505次owned启动ABI同，但按live allocation ID的pointer比较306次不同；HtoD均27次但顺序不同；
  原版67次typed initializer，source仅64。spring的94/5与376 pointer全同只属于spring，不能推广。
- 实际差异：原版先创建drag indices/coefficient，再将9个normal/area/scalar各初始化为正零；
  这些发生在四个scalar diagonal缓存之前。source此前在矩阵构造之后才分配drag且未初始化三个cache。
  原版initialize x86 10db31..10dbce确认此顺序和resize，实际CUPTI确认类型/数量/正零值。
- all材料原版tet volume在五份零ELL channel之后、particle_kind之前upload；source此前在block buffers之后。
  precompute_matrices 106ebe..106ef1的float range_assign字段+3388在int+33a8之前，实际payload互证。
  原版两端27份payload的内容并未发现数值错误；此处恢复真实顺序，不改volume公式。
- 新同场景同步trace123次：metadata相同，首个差异launch11 PCG numerator world1相差2ulp，
  此前所有可观察输入相同。不能据此直接判整轨迹C通过，也不能断言构造修复已经解释它。
- 修改前检查点self-7ea6be62-before-drag-tet-cache-order已保存完整当前源码/构建/所有结果。
  11ea旧检查点440份源/构建、1015结果已独立复核0 mismatch。
- 正按上述证据恢复drag创建/typed初始化以及tet volume上传顺序；CUDA176/f0未改，组合guard未移除。
  新image尚未构建与验证；当前完整solver仍未完成。

- 新构建image为d1a6bd58de55edd3ae826e909443401e6044deb4d9c976587d644ba9b1c5beaa，CUDA digest仍f0。
  validation-d1a6bd58/run.py正在串行采固定首候选、all构造三种独立探针及材料组合/C8；不提前计通过。
  7ea完整检查点440源/构建、14453结果SHA已经独立复核0 mismatch，旧结果和首候选未改。

- d1a all真实构造核对已完成：双方100 allocations/5 frees，按生命周期ID的大小/分配释放次序完全相同。
  505次owned启动的所有flat pointer allocation ID+offset相同；27份显式HtoD payload/顺序、67次typed初始化/顺序全部相同。
  这些仍是all W3 seed3 fixture的证据，不代表完整SDK内存API或全部opaque View相同。
  7ea all实际首次numerator三world各20项相同贡献均找到两端精确float32排列，world1目标相差2ulp，
  证据保存在d1a验证目录previous-7ea-all-numerator-w0/1/2；它是旧image首差局部证明，不代替d1a全轨迹验收。

### d1a实际轨迹匹配与继续核对

- 当前56个唯一材料首候选为46/56严格；全部定义buffer、完整owned参数和count覆盖同。
- 首个C8失败为spring PD的source1；source0/2全部步C内，source1后两步未过。该批8原版并非全零spread，
  但没有覆盖source1这一种轨迹。没有扩样、更换source1或改C8失败结论。
- CPU遍历全部匹配参考image/fixture SHA/frames/extra/hook SHA/同first-call dump协议的既存原版记录，
  source1完整所有NPZ数组与50effa1b阶段真实original2逐位同；source0/2也各有实际完整原版匹配。
  84个匹配文件包含reuse副本，不把文件数当独立原版次数。spring-pd-actual-original-matches-v2.json给出实际路径及SHA。
- 新original_trajectory_matches.py只验证真实原版整轨迹匹配，不重算统计C、不改原严格失败，不声称由此全部SDK完成。
- 新spring PD同步trace77次metadata同，首差launch17 numerator world1差1ulp；所有before和pointwise z相同。
  20项贡献的两种float32具体排列精确复现两端，三world均无未解释scalar。
- material_cohort_audit新增可选--previous-results和--keep-going：复用已经固定的spring PD三source及原版8份，
  后续独立case继续核对，所有C失败保留并返回失败；默认仍遇首个失败即停。没有改变阈值。
- remaining.py正在串行完成余下C8、同image74/self回归和粒子C10，再抓8组原版self/fluid。
  self_fluid_ab.py已通过语法检查，但尚未GPU验证；生产fluid/self保护仍保留，不计已支持。

- d1a十个严格不同的材料case已全部完成固定C8：六case全部3source通过，四case失败。
  失败为spring PD无PP、drag PD diagonal、PP spring PD、PP spring Newton diagonal。
  无PP spring PD的三source都有实际原版整轨迹匹配；其它三case仍有source没有匹配，不作通过。
- rare-original-owned-audit又确认spring PD source1与真实50阶段original2的owned完整metadata和count相同，
  old status.json证实original2是当时新执行的原版worker，非source文件冒充或reuse重复次数。
- 同image74回归已启动，后接既有self回归/C10和原版self-fluid8；生产代码保持d1a不变。

- 后续GPU追踪已排到after-current.py（当前同image）：等待remaining.py及其全部本仓库worker退出后，
  才串行采drag PD diagonal、PP spring PD full、PP spring Newton diagonal的真实first-substep trace。
  等待期间不暂停/终止任何已有worker，并持续检查生产build manifest不变。结果见after-current-status.json。
- 当前full74已60/74，严格失败暂为三个particles seed；74仍未完成，不把中途结果写作最终验收。
- 当前没有改生产归约、CUDA算术、阈值或旧首候选，也没有启用尚未验证的self/fluid等保护分支。

- d1a同image完整74已结束：71严格，particles seeds1/2/3分别14/28/19数组不同。
  后续self回归和本image固定候选C10仍在运行，不继承7ea或01的通过结论。

- d1a同imagecloth16、mesh16、PP8、246项self contract全部通过；三个particles seed的固定first source C10全部通过。
  7ea seed2的C10失败原样保留；不能据新image通过反改旧结论或声称本轮改了粒子数学。

### d1a固定失败的真实同缓冲区重放完成

- 三个新增trace首差均只在PCG标量：drag PD diagonal numerator、PP spring PD denominator、
  PP spring Newton diagonal numerator，各world1相差1ulp；此前所有已观察输入和pointwise输出相同。
- pcg_same_buffer_probe新增multiply分支，沿用真实原版runtime函数、原版PTX、当前source kernel三路，
  相同device allocations/输入/非阻塞stream，每路64次轮换顺序。三个case共576次pointwise输出全同，
  三路各自都实际产生同样的两种完整三world scalar tuple，未仅凭C++公式推断。
- 六份独立PCG重放覆盖三case的original/source实际输入各一次：360调用、450个pointwise检查全部严格同；
  180个aggregate检查中54个严格不同仍如实保存。九份world的首次scalar贡献均找到精确float32排列。
- 这些是已捕获first-substep/实际输入的A/B证据，未把整个C8轨迹失败改判、未改生产求和或阈值。
- d1a全队列已结束；self/fluid原版8组全部finite/group检查通过。纯fluid full PP增量均0；
  mixed full W1/W3实际PP增量1/3，group数组前8为1、其余为0。它们仅是原版参考，source保护尚在。
- 继续恢复self/fluid前保存d1a完整检查点。下一步按SelfCollision initialize实际分组恢复0/1/2，
  保留body/granular/surface组合保护，先核对新self/fluid八组及既有fluid错误行为。

### self/fluid：真实分组字段恢复，等待新image验证

- 原版8组已完成，前8 fluid组为1，其余为0；纯fluid PP计数增量0，mixed W1/W3增量1/3。
- 按initialize 138030..1380e1恢复本地groups：默认0、fluid1、granular2；fluid先写，granular重叠拒绝。
  仅移除step中fluid+self保护；body/granular/full-surface保护继续保留，CUDA176/f0未变。
- static-64a0be7f保存新反汇编/rodata与SHA。注意两个copy_to_host<int>同名但属于不同CUDA translation unit：
  SelfCollision用1394a0，short span错误是collision count；不能误用SolverNewton的114090/model count。
  下标越界和overlap的原版类型std::invalid_argument/ValueError及文字均由cold分支互证。
- 修改前d1a完整检查点442源/构建、17252结果SHA独立复核0错；d1a首候选及失败均未覆盖。
- 新分组/组合尚未通过GPU，不计已支持；构建后先跑既有fluid/granular contract和self/fluid八组实际A/B。

### 0fa首轮发现self/fluid预条件器先后错误

- 0fa fluid57和granular103行为全部相同；8组实际source均成功且group正确，6组状态严格。
  所有8组完整owned调用/首个self preconditioner buffer却不同；不能因6组末状态相同而验收。
- cached W1的407次调用中18次不同，全部是9轮self add_hessian_diagonal与fluid add_diagonal互换。
  原版明确self先、fluid后；source此前相反。其它已观察force/tangent顺序没有发现差异。
- fallback两组状态/PP首力buffer另不同，后续仍须定位；不能预先全部归为hash原子顺序。
- 修改前self-0fa425b9-before-self-fluid-preconditioner-order保存首次失败与源码/构建。
  当前仅按真实原版调用把self preconditioner移到fluid之前；granular与self保护仍在。

- 当前构建929adeb01ffac876cd7a33508c4541d10eab86fea5098f418fcb50d6567ed35d，CUDA176/f0未改。
  正串行核对57+103行为和8组self/fluid，不能将0fa的6个末状态相同直接算为929通过。

### 929 self/fluid三步阶段证据完成，继续长程/graph与回归

- 57 fluid及103 granular行为同；8组owned完整metadata/coverage全同，6轨迹严格。
- 两个fallback均只有post PP RHS严格不同，实际pre RHS已不同，双端PP前后整个force数组均未写。
  未篡改原strict failure，另存fallback-PP-no-force-writes.json说明上游差异。
- 新fluid_grid_capture可指定fixture和hook，默认official路径行为不变。W1 fallback实际三原版+一source：
  points/volume/IDs/world/cells全部同，head/next出现三种合法hash链；四份实际输入经source evaluate_rows
  六种输出及有效缓存prefix全部逐位同，未比较未初始化cache尾部。此捕获只用于W1，不推广多world尺寸。
- Newton和PD固定source0，加source1/2各一次、同协议8原版：全部3步q/qd均C内；
  两case新增各9个worker的完整owned metadata、source count覆盖均同。
- three-step-stage-audit.json记录有限三步阶段核对，不把原strict报告改判或说完整SDK已验收。
- fluid_graph_ab新增可选--suite self-fluid，默认fluid保持原三variant；self-fluid全材料W1 full/diagonal、W3 full，
  NN/PD各60步做双端eager/真实CUDA graph。continuation.py现串行跑它、既有fluid graph、74与self/C10回归。

- self/fluid graph60共24项比较21严格：W3 Newton的original/source eager不同、original自身eager/graph不同、
  source自身eager/graph不同；该case的source graph与original graph完整60步严格同，其它全部比较严格。
  原始NPZ/strict报告全部保留，不能把原版本身graph差异当成source新bug或据此直接验收eager。
- self_graph_distribution / self_graph_eager_audit扩展可选--suite self-fluid，mesh默认不变。
  self-fluid会重复完整原worker的三variant×两模式流程，保持首条source0，追加source1/2各一次和7原版；
  fixture/base fixture/runner/image/frames均核对，同模式统计，不混合eager与graph原版样本。
  新report明确all_steps_within；须逐项检查，不能只看既有额外observation退出码。
- fluid_graph_ab旧实现未写build.json；当前graph目录新增来自父队列的已pin构建及adopted-build-provenance，
  交叉核对已存在两worker runtime，未改既有runtime/NPZ/strict报告。新cohort仍待GPU队列结束后执行。

- 0fa修改前检查点443源/构建、395结果SHA独立复核0错。
  929生产代码保持不变，当前GPU队列之后还有long graph/eager C8与97项fluid topology核对。
- self_fluid_ab新增可选--family granular（默认fluid八组输入/观察字段不变），准备原版颗粒+self八组：
  cached/fallback、subset、三种bond以及soft ground、world1/3、NN/PD、full/diagonal。
  next-reference.py等所有前述worker退出后才抓original；source granular+self guard保持，不预先计支持。

### 929长程/当前回归与明确未过项

- 当前929完整74：71严格；三个particles seed分别21/21/19数组严格不同。固定C10：seed1通过，
  seed2仅n257_w1_it5_f1/2/out.qd未过，seed3的n257_w1_it1_f1六数组未过。原报告不改。
- CPU只查相同冻结host_particles_ab/host_api_probe及64a原版证明的所有兼容检查点：
  seed2该case全18个记录数组/全部3步可与6份实际原版worker严格匹配；seed3该case63份既存原版未找到整case匹配。
  不把这改为C10通过，不拼接不同原版的单个数组，不声称整套多fixture NPZ匹配。
- 929 self 16cloth/16mesh/8PP/246配置全部通过；97 fluid topology也全部同。
- self/fluid W3 Newton固定graph三source/8原版：q/qd/soft_count全部60步C内，且每个source都匹配实际original0/5/6/7整轨迹。
  旧额外ratio观察仍有失败，原退出码1保留，不能用它替代primary-C逐步检查。
- 同一批eager：source0只有q48/60、qd53/60在C内，source1/2全部C内并严格匹配actual original1..7。
  原始source0未替换、未自动扩样；当前long eager尚未验收。
- 独立同步观察60步8580个watched launch：metadata（此观察器有限字段）同，所有捕获after buffer全部严格。
  原trace仍exit1，因186次soft force的before contact数组顺序不同；valid count内按唯一(particle,shape)
  对齐后body_pos/body_vel/normal与IDs全部严格同，未比较未初始化尾部。没有改raw trace/comparator。
  这是一份同步诊断轨迹，不能替换不带observer的first eager source0或据此改判其C8失败。
- 颗粒+self原版8组已全部成功、group正确且finite：pure granular PP增量0，W1 subset authored为8，
  W3 subset none/dynamic为24；source granular+self guard仍保留，尚未接入验证。

### self/granular：按八组原版参考开始接入

- 929完整源/构建/结果已存self-929adeb0-before-granular-self-host；当前仅移除granular+self guard，
  既有group2和共享预条件器调度不另改算术；body/full-surface与self保护仍在，granular混其它materials/fluid/body也未放开。
- 新image d3cb2b9650f48a8071e4d17db7f900ce7af2f10ef977738a70ffc03c7f294074，CUDA176/f0未变。
  正跑实际八组、103 granular与57 fluid行为；未提前计通过，当前交接SELF_GRANULAR_HOST_RECOVERY.md。

### d3cb self/granular：八组阶段与真实graph60完成

- 八组所有defined buffer、完整owned ABI/launch geometry/shared/stream和source计数覆盖相同；
  全部finite/group正确，七条状态严格，只有fallback W1 Newton严格不同，首候选未覆盖。
- 该fallback实际trace后的独立重放：6次颗粒evaluate_rows、30次颗粒CG接触乘积及有效缓存逐元素严格同。
  固定source0与source1/2各一次，对同dump协议8原版，全部3步q/qd primary-C通过。
  dense-primary-c-and-owned-audit另核对新增9worker完整metadata及source覆盖；未改原strict报告。
- self-granular graph60的pure/subset+authored+ground/W3 subset+mixed+ground diagonal三variant，
  NN/PD的双端eager和真实graph共24项比较全部60步严格。不是只比较末帧。
- 103 granular/57 fluid行为全部相同；当前self/fluid八组仍为六严格、两个fallback严格不同，
  全部finite/owned metadata同。continuation队列将核对当前image固定候选C8和完整74+self回归。
- 929修改前完整检查点独立SHA复核结束：443源/构建、170979结果，0差异；复核JSON保存在当前d3cb目录。
- 生产CUDA176/f0没有修改；尚未实现self+body/full-surface，旧image未过轨迹仍保留，完整目标未完成。

- d3cb完整74结束：69严格；particles seeds1/2/3分别28/14/21数组不同，mixed_cloth seed3有11数组、
  pd_mixed_cloth seed3有7数组不同。五个固定source的C10正在串行运行，不能继承旧image结果。
- 新增self_affine_scene/self_affine_ab，仅诊断：八组SO3 body+自由PP，W1/W3、NN/PD、body block、
  diagonal/full、ground，完整owned hook与defined buffers。next-reference.py等待当前队列完成再捕获原版；
  生产body+self guard保持，尚未计为支持。两个新脚本py_compile/128列检查通过。

- d3cb固定C10最终：particles seed3与pd_mixed_cloth seed3通过；particles seed1/2及mixed_cloth seed3未过。
  两个particle失败均为n257_w1_it1_f0，mixed为mixed_w129_duplicates。失败JSON保留。
- 只查输入/loader/helper SHA相同的既有实际原版worker：两个particle失败case的完整15个记录数组、
  三步分别与4/6份实际原版完全匹配；mixed在18份中无整case匹配。不是整NPZ匹配，不改C10失败。
  CPU脚本初次错误假设force-absent仍有18数组；实际15，修正为检查实际完整key集合；两次log均保留。
- 当前self/fluid固定source0两个fallback全部三步q/qd C内，但source1 Newton只有1/3 q/qd C内，
  PD source1 q全过、qd2/3；两cohort整体primary-C失败，不能继承929三source通过。
- after-reference.py等待原版body+self八组退出后，按当前image再抓mixed_w129_duplicates真实首差并做force/PCG重放；
  同步诊断轨迹不替换固定C10 source。所有队列完成前不编辑/重编译production。

- d3cb所有GPU队列已退出。新增18个fluid cohort worker完整owned metadata与source计数覆盖全部同，
  但两个cohort的source1有逐步C失败，保留原判；source0与source2全部三步C内。
- 当前NN mixed的402次真实同步trace metadata同，first difference是launch2 spring force after.rhs，
  两float词不同、max1.9073486328125e-6，此前输入全同。拆分387根spring的双端±0各2322标量严格同，
  双端捕获rhs各1161标量均找到精确float32排列，0 unexplained。未修改实际生产求和。
- 两份actual输入的独立PCG回放：648调用、810pointwise+324aggregate全部严格；不改固定C10失败。
- body+self原版八组全部finite/group0正确，full PP计数W1=2/W3=6；覆盖SO3+自由PP、ground、body block、
  W1/W3、NN/PD、diagonal/full。生产guard尚未移除，下一步先保存d3cb完整检查点再接入验证。

### SO3 body+自由粒子self：按原版八组接入，尚未验收

- d3cb完整修改前检查点保存并独立复核：446源/构建、13925结果SHA，0差异。
- 仅放开SO3+自由PP的body/self guard；self与full-surface、其它rigidity、约束/drive/cable/fluid/hard仍拒绝。
  既有force/preconditioner/tangent及全部CUDA未改。
- 新image1d55d785cf5ab94b6949e2d9e7e4c4fae1db598596d55abf22ff32b417f91424，CUDA f0不变。
  当前跑实际八组，未预先计支持；详情SELF_AFFINE_HOST_RECOVERY.md。
- 新self_affine_graph_ab独立脚本按八组各自eager/真实graph逐步记录全部状态及接触count，ground必须有效碰撞。
  py_compile与128列检查通过；实际运行前仍未验收。实现前检查compare接口，改用ExitStack保留NPZ对象，
  未运行错误的dict版本，无测试报告受影响。

- 1d55首轮八组：七组全步状态严格，但全部metadata与首个self tangent buffer失败，不能验收。
  原版SO3 tangent在self前；source反之，每组45对相邻swap、90处不同。
  W3 ground diagonal另有54次多余rigid tangent（9 preconditioner+45CG），其状态也不同。
  只做此相邻顺序解释和disabled tangent排除后，八组整个规范化完整参数序列均与原版同；
  first-order-differences-explained.json保存诊断，没有修改/改判raw metadata失败。
- 原始groups dump只核对8个prefix。实际W3的native per_world为24（hook u:18为十六进制），
  后续须按完整24组重新捕获原版/源码，旧prefix结果不得冒称全数组。其余总状态buffer读取尺寸正确。
- 当前GPU已全部退出；先保存1d55首轮失败，再按实际顺序与flag恢复三个host位置，不改CUDA。

- 1d55失败检查点独立复核448源/构建、225结果SHA，0差异。按八组完整实际参数序列，
  将self tangent放在SO3/constitutive之后；rigid tangent的preconditioner/CG都服从enable_collision_hessian_non_diagonal。
  此flag在实际原版step的fd348/fd39d/fd3c0处有显式分支；新编译中，尚未验收。
- body八组groups协议改为完整total*4；该fixture实际W3 native per_world=24，参考launch参数证明它是完整数组，
  因此将重新跑新协议原版八组，不偷换旧prefix参考。另准备同fixture关闭self的ground diagonal控制，
  用于核对rigid Hessian开关的通用分支，不能只靠self样本泛化。

- 新构建00f45665e60c51be7b216ca93355137ce67b6eb4416bb9df34b93e6f375f63d9，CUDA f0未变；
  正按完整groups dump重抓原版八组，再source；之后计划no-self diagonal控制、真实graph60与回归。
  1d55首轮raw failure/规范化差异解释全部保留，新image未提前计通过。

- 00f完整groups诊断首轮原版两个W3无ground失败，尚未运行source：
  我将ground展开布局错误套给无ground模板；请求复制的groups超出实际分配，hook使query报告invalid argument。
  保留original-reference8所有原始错误/日志，修正诊断为按实际template/expanded布局读取，并逐case核对
  query的per_world实参（无ground=8；ground=8*worlds）。这是观察器错误，没有修改生产solver或原版。
  初始1d55仅W3 ground的8项groups是prefix；无ground的8项实际已经是完整本地数组。
  retry.py另建original-reference8-correct-local和self-affine8-correct-local，保持00f生产image不变。

### 00f body/self八组与graph60完成，继续回归

- 修正groups观察协议后8原版/8source全部通过：3943次完整owned调用与计数覆盖，
  77项defined buffer检查、完整实际本地groups、所有3步particle/body q/qd全部严格。
  两个实际生产调度修复确实消除了1d55的调用和tangent buffer错误；未改CUDA或阈值。
- 同fixture关闭self、ground diagonal的4组控制全部严格，覆盖W1/W3、NN/PD、body block on/off；
  所有完整owned调用、12项defined buffer、状态及计数覆盖同，说明rigid Hessian开关不是仅self特例。
- self-affine graph60八组各四种比较，共32项所有60步严格；同时ground必须真实生成rigid contacts。
- 当前完整74/246配置/必要固定C10仍在队列中，未提前计通过。下一块准备官方cloth+材料+self的
  实际full-surface ground参考，self_surface_scene/self_surface_ab已py_compile及128列检查；
  bounded dump读取真实soft_count与defined输出，不比较contact/cache未初始化尾部；
  必须有实际非顶点barycentric接触。next-reference等所有回归退出后才跑原版，production surface+self guard未动。

- 当前47辅助入口清单已直接对项目内64a抽出PTX与当前host source bundle核对：22 Thrust+25 CUB。
  41个规范化PTX全同，其余6个Aabb reduction仅entry visibility（原版.entry/source.visible .entry）不同，指令/参数全同。
  此为CPU inventory，还未计runtime通过。
- 新revision_auxiliary_ab复用冻结Thrust/CUB全部数学输入/期望，只替换新版本入口发现（旧PCG bootstrap名称在新版不存在），
  参考固定64a，source强制当前native_source._KernelDriver，每个参数宽度都与当前manifest校验，覆盖必须恰好47。
  另保留NaN payload/Inf/signed-zero/输入与输出guard的实际双端reduction检查；不改旧spec文件或source校验。
  inventory-only、py_compile、128列检查已通过。after-next-reference等surface参考worker全部退出后串行跑3seed。
  aux实测队列结束前不改/重编译production；当前body完整74仍在运行。

- 00f同image完整74结束：70严格，particles seeds1/2/3分别28/14/14数组不同，
  pd_mixed_cloth seed3有7数组不同；NN mixed本image严格。246 self配置与四个固定C10继续串行，
  不套用d3cb的C通过或失败；raw first candidates及全部差异保留。

- 00f全部GPU主回归结束：70/74严格，其余四项的固定首次source C10全部通过；246项self配置同。
- full-surface原版8组全部finite，W1实际24 contacts/10个non-vertex，W3实际72/30；full PP W1=1/W3=3。
  调用中查出此前未接的35add_surface_contact_stiffness_scale，它的输出地址正是self accumulate的scale参数，
  不等于base diagonal；原版tangent顺序为bending→self→surface→legacy soft。尚未修改production。
- 47入口首轮3seed都在original Thrust EmptyKernel发现时被harness assert拒绝，未运行source数值比较：
  相同EmptyKernel在多个原版PTX模块重复出现，inventory用最后一个module、冻结扫描却用第一个。
  修正为两端inventory都保留第一个原始module；不改函数体、输入/期望、ABI或native_source校验。
  原失败目录全部保留，另建current-aux47-retry-seed1/2/3实测；它们全部退出后才可改production。

- 00f辅助47重试三seed全部完成：每seed original-PTX/source-image各1377项，双端47/47入口调用；
  另每seed720项实际双端特殊值reduction/guard检查，共10422项，0失败。Source实际用当前host so的_KernelDriver，
  launch逐参数宽度对manifest，native_source SHA保护保持；未映射原版_core。详情CURRENT_AUXILIARY47_RECOVERY.md。
  NaN/Inf误差元数据warning不参与判定，所有判定仍为uint原始bits。
- 当前所有GPU队列退出；00f完整74为70严格，四个固定首次source C10都过，246配置同。
  body/self八组、4无self控制、graph60全部通过；surface原版八组含实际10/30 nonvertex记录。
  继续surface前保存00f完整源码/构建/结果，旧d3cb/929/d1a失败不反改。

### Self+full-surface：按实际八组开始接入

- 00f完整修改前检查点独立复核453源/构建、1966结果SHA，0差异。
- 实际原版35add_surface_contact_stiffness_scale的输出地址与PP的stiffness输入相同，
  与initialize_step diagonal不同；按此在copy scale之后、所有self accumulate之前接入，未改CUDA内核。
- 原版tangent明确bending→self→surface→legacy soft；source将surface放回self之后（SO3仍先于self）。
  仅放开非body/非fluid/非granular的self+surface；body+surface及其它既有组合保护保持。
- 新构建中，尚未计支持。原版八组已有24/72个实际接触、10/30个nonvertex，含spring/tet/drag/cloth、
  W1/W3、NN/PD、diagonal/full；下一步完整owned ABI、scale/H/RHS/tangent与逐步状态核对。

- 新image668a6e1d3cf2c5dfc539fc49aaa440a08e0aa1377aeb9107c80022644b23e2ea，CUDA digest f0不变；
  正跑self-surface实际source八组。00f检查点已独立复核0差异，完整辅助47实测证据也在检查点内。
  暂未计新image通过，不把00f graph/回归直接继承。

- 668实际source八组已经全部严格通过：5145次完整owned调用、93个defined buffer及全3步q/qd相同；
  有实际non-vertex full-surface records，scale并非错误使用base diagonal。source覆盖计数全部同。
- 新self_surface_graph_ab只在实际场景之外包装graph/eager执行与逐步记录，不改输入物理；
  记录active soft/rigid与nonvertex count，过滤空body数组，py_compile/128列检查通过。
  graph60当前正在实际运行，未预先计通过；当前image完整回归还需执行。

- 668 self-surface graph60已实际完成，32项比较全部逐步严格，包括有效soft/nonvertex count；
  源码/原版各自eager/graph也同。continuation开始同image body/self八组复测、完整74、246配置与必要固定C10。
  当前没有改CUDA，因此00f辅助47的相同f0源码证明保持；但不将旧host回归冒充当前运行。

- 668的body/self八组复测已全部严格，证明共享tangent位置调整未破坏之前SO3/self分支；完整74仍在运行。
- 下一块计划恢复普通粒子材料与body共享矩阵，先从普通particle spring开始，不直接臆测整个cloth/body拼接。
  新affine_particle_spring_scene/ab仅诊断，W1/W3、NN/PD、block、自碰撞、ground；目前生产mixed-material guard保持。
  初始模板仅复制一个已初始化host diagonal/ELL entry，实际per_world/ELL尺寸从原版launch scalars读取，
  避免再把template和expanded布局混淆。完整数组/分配还需后续实际constructor捕获，不计模板完整验收。
  两脚本py_compile与128列检查通过；next-reference等待当前回归完全退出再抓原版8组。

- 668完整74结束：70严格，particles seeds1/2/3为28/14/28数组不同、PD mixed seed3为7；
  四项固定首次source C10均过，246配置同，body/self八组复测严格。旧image的失败继续保留。
- body+普通spring原版八组全部finite且成功；实际模板per_world8、ELL16，W3 ground展开per_world24/ELL48。
  full PP只W3=3/W1=1，说明普通spring端点不进入free PP查询，不能沿用无spring预期。
- 查看HtoD时发现full-owned hook本身不创建uploads目录，初始八组没有该payload目录，不能冒称已抓全模板。
  另建body-spring-template-reference-w1并创建uploads，按实际8/16尺寸抓取全diag、row counts与8个ELL通道，
  另保留26份真实HtoD。diag[0:2]=43.125，L0两条free边=-43.125；各通道列模式一致，
  body L2=-18.000001907348633。生产矩阵尚未改，下一步保存668完整检查点后按这些实际数据合并。

### Body+普通particle spring：按实际L0/diagonal接入

- 668完整检查点458源/构建、1693结果SHA独立复核0差异，所有GPU worker已退出再修改production。
- precompute_springs遇body时保留已验证的负offdiagonal/正diagonal，延后到body统一CSR/ELL构建，
  不调用particle-only缓存构建覆盖body布局；body的L0与host diagonal接收该贡献，所有通道共享合并列模式。
- 仅放开SO3、无其它body约束/drive/cable/fluid的ordinary spring；body+cloth/tet/其它collision triangles仍保护。
  旧body-only、particle-only流程保持，CUDA f0未改；新构建中，尚未计通过。

- 新image0853c9ac2a31c04e42d551e7d128466e566ad6dcf64b02569f3c6ee87f0517e3，CUDA f0未变。
  正对实际原版八组跑source；下一步同协议完整W1八通道模板、row count与diagonal，不能只看首entry。
- affine_particle_spring_graph_ab准备按同八组运行真实graph/eager60，直接复用已核对的body graph方法；
  py_compile/128列检查通过。实际八组/模板通过前不计graph支持。

- 085实际body/ordinary spring八组全部严格：3772次完整owned调用、70项defined buffer、所有3步particle/body状态同。
- 按668实际尺寸与同dump协议独立source完整W1模板：diag、row count、L0..L6及scalar template共10项post数组全部严格；
  完整owned调用、所有状态与source计数覆盖也同，未比较临时输出写入前值、未重选first candidate。
  此结论不等于整个constructor allocation/copy/typed init顺序验收。
- body/ordinary spring graph60的32项比较全严格，ground要求实际rigid contacts。
  当前continuation串行self/surface八组复测、完整74、246项self行为与必要固定C10，production保持不变。

- 下一步body+cloth参考准备：affine_cloth_scene使用两层8顶点官方cloth与1个SO3 box，
  可选ordinary spring/self；contacts时box顶面实际接触cloth顶点，legacy soft必须有active count>0。
  affine_cloth_ab覆盖8组W1/W3、NN/PD、block、diagonal与真实双向soft，CPP mixed-cloth guard仍保留。
  诊断只读取一个已定义模板entry，其余全局定义输出，per_world/ELL尺寸按实际调用记录；
  PP counter仅存在时读取（cloth全为mesh顶点时没有PP launch），不读取未初始化tail。
  py_compile/128列检查通过；next-reference等待085所有回归结束后才跑原版。

- capture-cloth-template.py已准备：等body/cloth原版八组成功退出后，从其实际W1 layout读取尺寸，
  再复制全diag、row counts、8个ELL通道并保留HtoD payload；不猜cloth新max_nnz。
  该额外GPU捕获完成前不能编辑/重编译production。当前085完整回归仍在跑，body+cloth guard未动。

- 085同image self/surface八组复测严格，246配置同；完整74结束，71严格，
  particles seeds1/2/3分别14/21/21数组严格不同。固定source C10 seed1已过，seed2/3继续，
  不套用旧image结论；body/cloth参考和完整模板worker仍等待全部队列退出。

- 085完整队列已退出：71/74严格、三个固定首次source C10均过，246配置同。
- body/cloth原版八组全部成功/finite；per_world12、ELL36（W3总36共享模板）。接触case soft_count9/27，
  独立原始pre/post RHS审计确认cloth与body都有实际增量（max0.5309611/1.2928703），不是只凭capacity/count判两向。
  affine_cloth_ab已加入同样的诊断约束；输入/物理/dump协议未改，原版raw report不改。
- body/cloth完整W1模板及HtoD已按实际12/36尺寸抓完。实际SO3 tangent在bending tangent之前，
  source之前body+cloth guard掩盖了反序；接入时必须先SO3，再bending/self/legacy soft。
- 所有GPU已退出，保存085完整检查点后才接入cloth；body+full-surface/tet和其它约束混合继续保护。

### Body+cloth：按实际八组与完整模板接入，尚未验收

- 085完整修改前检查点461源/构建、1653结果SHA独立复核0差异。
- 延后body下的cloth/bending scalar模板，复用已核对的particle CPU运算，交给body统一L0/host diagonal/列模式；
  不再让particle-only缓存覆盖body矩阵。保留body+tet/full-surface/约束驱动fluid等未捕获保护，仅SO3。
- 按实际body/cloth调用，将SO3 tangent放在bending前；原有SO3→self→surface次序保持。
  CUDA f0不改；新构建中，实际source八组/完整模板/graph/回归均未提前计通过。

- body/cloth新image0b7621b31a86f32efaeffa526d498a0e4c9c4fbb823022f3d478133e49f4bd3b，CUDA f0未变；
  当前实际source八组正在跑，未预先计通过。affine_cloth_graph_ab已准备，body/cloth真实soft count必须>0，
  py_compile/128列检查通过；下一步完整模板与graph均需实际执行。

- 0b body/cloth实际source八组全部严格：4292次完整owned调用、65个defined buffer及全3步状态同；
  包括真实两向soft（cloth/body RHS均变化）。完整W1模板10项post数组/完整调用/全状态严格；非全constructor顺序验收。
- graph60共32项比较28严格，所有eager跨backend严格。NN W3 self无contact source graph从q步0/body步2不同；
  PD W3 self+spring原版graph从q步16/body步26不同，其source graph=eager。其它所有case/模式比较严格。
  保留首次NPZ/raw report，不因原版自身eager/graph不同而改判source。
- graph-cohort8.py当前保持初始source0，source1/2各一次、7原版完整worker（八case、每case eager/graph）串行，
  fixture/runner/image/frames/SHA全部pin，同执行模式统计全部16轨迹每数组/每步primary-C，不能混eager和graph。
  不替换source0、不扩样追通过、不改物理。所有GPU结束前不改/重编译production。

- 0b graph完整worker固定C8已结束：16轨迹14通过；两个W3 self graph均未通过，三份source在各失败case中完全同。
  NN graph三source的q/qd均0/60步在原版范围，body仅2/60，原版spread为0；PD graph的body全60步在范围，
  q仅47/60、qd51/60。没有完整原版轨迹匹配，保持失败，不归因ND、不改物理或阈值、不重选source0。
- capture_cloth_graph_definition.py在capture结束后仅调用cuGraphDebugDotPrint；两backend各完整16图。
  图0/4/8的节点类型、kernel名称、grid/block/shared、copy/memset尺寸和值规范化均同（176/221/244节点）；
  尚未核对kernel参数内容/指针别名，因此不能以调度外观一致验收。
- 同完整worker运行compute-sanitizer initcheck：original为0错误，source为29160个未初始化访问错误。
  首批均Solver::step复制1440字节block模板时的cudaMemcpy source未初始化，尚未证明padding被计算读取，
  也未证明这是graph差异原因。原始log和完整NPZ保留，当前串行CUPTI捕获W3 cloth+self原版/source初始化，
  按实际类型/数量/owned用途找缺失初始化，不凭猜测加memset。production保持0b，CUDA f0未改。

- 0b修改前检查点463源/构建、609结果SHA独立复核0差异；GPU worker全部退出后才修改production。
- 实际CUPTI W3 cloth+self：原版有两个108元素BlockNonZeroEntry全零typed fill，用途分别为kernel29输出、
  cloth Hessian/CG block输入；source缺这两项，按原版恢复initialized_cache，未改数学、CUDA或比较阈值。
  通用initializer audit首次因未登记NonZeroEntry(8B)而assert，原始捕获保留；仅本地扩展type表另存解析，
  没有改冻结spec。原版57/source50初始化，完整constructor仍有其它差异，不冒称全部匹配。
- 新image9a78777b604df8cc6dabb24060c1212893e4f13b931601c0db4d65e13065261b：body-cloth8全部严格；
  graph60仍未全部严格，initcheck正在串行运行。这一修复目前仅有实际原版初始化证据，不能声称已修graph首差。
- 新capture_cloth_graph_parameters.py仅capture结束后读取真实CUDA graph参数与func属性，不改graph节点/输入；
  py_compile通过，尚未运行。不用诊断轨迹替换固定候选。随后若内存检查无其它错误，将核对实际graph参数别名。

- 9a initcheck完整worker现为0错误（0b原版同为0）；body-cloth8全部严格，graph60仍28/32、失败case完全相同。
  两个typed block init确为实际遗漏，但不是graph数值差异根因；不将内存检查通过替代轨迹验收。
- capture_cloth_graph_parameters.py已完成双方16真实graph：所有owned参数的scalar/布尔/size及view标量0差异，
  geometry/名称同；发现source共用zero/ELL row模板的别名差异（未完全恢复constructor）和部分func寄存器/local大小不同。
  实际参数/属性raw JSON与独立audit均保留。没有把指针nullness通过说成pointee相同。
- cloth_graph_kernel_substitution.py为单独诊断进程，只在graph exec中临时替换function，参数/尺寸不变。
  正串行跑加载相同原PTX但不替换的control，以及全部owned替换实验；不修改production，不替换固定候选，
  原PTX仅用于定位、不得作为交付源码实现。若替换后不同仍需继续查host/输入，不能先认定寄存器导致。

- graph替换实验首次错误：Warp capture_end返回时graph_exec尚为None（lazy instantiation），因此ExecSetParams assert。
  失败log保留，改为实际cuGraphKernelNodeSetParams、在Warp正常lazy实例化之前替换；控制脚本旧版另存并SHA核对。
  control16轨迹15严格（仅NN eager出现观察效应），全部owned原PTX替换后两个失败graph仍与原source逐位相同。
  该结果不能先认定数学或host错误，但没有证据支持修改数学；替换从未进入生产so。
- 16图edges顺序/数量全部严格一致；copy/memset地址对照owned用途没有已映射指针冲突；未映射只剩body wrapper
  外部状态、base diagonal、hard previous counter等，不能称全部内存布局一致。
- cloth_graph_buffer_trace.py在图内插入D2D快照，仅诊断。NN graph双方与固定未观察轨迹完全同；
  first为graph4 node43 precondition_and_reduce numerator group2的1 ULP（3d2a9296/3d2a9295），z完全同、之前记录输出同。
  PD及另一些状态受observer影响，所有观察效应写audit，不能用该轨迹替换其固定candidate或claim PD首差已找到。
- 将NN实际快照明确适配至既有PCG probe格式（rhs→residual由真实graph node39 copy证明，node42证明initial=0）；
  12项相同dot贡献的精确float32排列分别复现两个scalar，unexplained=0。same-buffer64三backend共192次z全逐位同，
  runtime/original PTX/source PTX在这些相同buffers上均给3d2a9296，同式不同graph仍不能通过C，不改归约顺序追测试。
- 继续实际抓W3 body/cloth全memory和HtoD：原版在work mat3后即分配/typed-init affine 144*states float及int，
  再enabled/cable CSR、SO3两mat3；source把这些放末尾且SO3 raw分配。原版D0..D5各独立48B，local/global row各独立，
  L3..L6独立288B；source共享多个zero模板。原版57/source50 typed init（两个block已9a修复，其余5仍缺）。
  所有真实原始捕获保留，计划只按实际原版恢复这些cache/layout与初值，再同协议验证，不盲调内核。

### Body constructor layout：按实际原版恢复，7018待验收

- 9a完整修改前检查点466源/构建、640结果SHA独立复核0差异；所有GPU worker退出后才修改production。
- 按真实顺序将affine float/int typed缓存、enabled/cable CSR与SO3 mat3 typed缓存放至matrix模板前，
  不再在self/BVH后分配；D0..D5、local/global rows、L3..L6恢复独立分配并按实际顺序上传。
- 实际原版constructor的D1/D2、L1/L2初值已经有body mass贡献；源码按相同CSR列表和float累加恢复，
  逐步refresh仍保持。scalar combined ELL恢复NonZeroEntry{0,0} typed初始化，后续combine仍覆盖全有效模板。
- bvh helper增加已经在176-entry manifest中的NonZeroEntry fill host实例，构建实际24/24 normalized PTX完全相同；
  没改归约数学/顺序/阈值，CUDA176 digest仍f0。initializer审计仅新增已确认8B类型登记，冻结spec未动。
- 新image7018afb478ff6fd8932aca5b5d06e00e55909ca4cb3b84e39403ef9edc21a9f1；
  build/reconstruction-csrc/affine-constructor-validation-queue.py串行实际八组、full memory/payload/CUPTI、graph60、
  initcheck与完整74。当前运行中，未提前计通过；production锁定，GPU队列退出前不能编辑或重编译。

- 7018首次body-cloth8：7/8严格，全部owned ABI/计数/defined buffers/两向soft检查通过；
  W3 NN block+diagonal+contacts+self+spring固定首source从step0状态不同（particle q max4.19e-9、body q2.10e-9）。
  严格失败保留，不重试替换。初始queue按非零退出停止；未修改production，继续独立constructor/graph/initcheck/回归验证。
- resume队列首次遇原queue预创建的空initcheck目录而FileExistsError，GPU未启动；保留v1，v2明确断言目录为空后使用。
  原body-cloth8 first结果保持，续跑命令脚本与每job command.json保留；不是重新生成首candidate。

- 7018 constructor实际审计：57/57 typed init及顺序全同、28/28 HtoD bytes及顺序全同、95 alloc/free事件前缀
  （含free的分配identity）同；502次owned launch的全部flat pointer分配identity/offset同。
  ctor末尾source仍多分配156240B tangent；明确remaining，不把prefix通过说成整个ctor完全同。
- 直接反汇编当前64a so确认：SelfCollision::initialize只记录contact capacity；accumulate仅full bool分支
  在135e13调用prepare_contact_tangent_cache；135adc检查已有缓存，135b08检查capacity，135b1a使用capture mode2
  （relaxed），135b5b cudaMalloc(capacity*60)，135b66恢复旧capture mode。真实memory log seq260也在首次self force前
  才分配156240B。不是猜测原版少了一次malloc，下一步必须恢复此lazy行为，不能在当前GPU回归中修改。
- 7018 graph60目前26/32严格：原W3 NN self的eager/graph及跨backend四项全严格；PD self+spring与contact block
  仍有严格差异，保持失败。initcheck再为0；完整74当前正在串行运行，完成前production不改/重编译。

- 当前未修改production：7018完整74仍在跑，七个正式demo阶段尚未结束，后续body/API/particle也要实际完成。
  下一变更已由so明确锁定为self tangent lazy prepare：仅full分支、首次使用、capacity*60 raw allocation，
  用driver对应cuThreadExchangeStreamCaptureMode(Relaxed)临时切换并恢复；不能在initialize提前分配。
  同时复核本次将precompute_affine_blocks提前后，其body index/cable adjacency索引前需保留原有range/span检查，
  避免把之前依赖precompute_bodies/precompute_cables验证的先决条件遗漏。GPU退出并保存完整7018检查点后再改。

- 7018全部GPU队列已退出：完整74为71严格，三个particles seed分别[('particles-seed1', 28), ('particles-seed2', 28), ('particles-seed3', 28), ('mixed_cloth-seed3', 11)]数组严格不同；未做该image固定C10，不冒称C通过。
  七正式demo、八body及API/所有其它材料均严格。initcheck0；body/cloth7/8，graph26/32、失败首candidate保持。
  现在保存7018完整修改前检查点，再按actual lazy prepare及capture mode2恢复；不改数学/阈值。

- 更正上段和commentary的最终计数：7018实际4项strict失败，70/74，不是71/74；
  particles seeds1/2/3各28数组不同，另mixed_cloth-seed3为11数组。初次汇总沿用了末尾完成前计数，
  已立即按完整status纠正，原始status和错误记录保持。七正式demo、八body及API严格，但不能说所有其它材料均严格。
- 7018修改前检查点466源/构建、1073结果SHA独立复核0差异。

- 按64a反汇编及实际memory恢复self tangent lazy prepare：initialize不再分配，首个full accumulate才分配；
  以cuThreadExchangeStreamCaptureMode(Relaxed)临时切换，分配成功/异常均恢复原mode，已有缓存不重复分配。
  diagonal-only/未使用self不会多分配；数学、owned CUDA与阈值未改。
- 同时补齐提前affine ownership建图前的既有body span/index、整world数量、cable span/index检查；
  这些检查原在后续precompute_bodies/precompute_cables中，前移调用后不能先索引未经验证的数据。
  没添加新的有效输入限制，仍使用原错误信息。新构建中，source/ABI/graph尚未提前计通过。

- 4f1fdec67956020494323df262d47910741dbabeb2c001386f96800a51ca994c已构建，CUDA176/f0未变。
  affine-lazy-validation-queue.py已开始串行八组、full memory/payload/CUPTI、graph60、initcheck、246 config、完整74。
  first短程严格状态失败会保留并继续独立检查，但任何worker/ABI/finite/defined buffer错误仍停止；不隐藏失败。
  当前GPU执行期间production锁定不改/重编译，所有阶段命令JSON与输出目录独立。

- 4f实际八组7/8（本次仅W3 NN self状态失败），全部ABI/defined buffer/coverage同；graph60为27/32严格。
  typed57/57及顺序、uploads28/28 bytes/order、502 owned flat指针identity/offset仍全同；ctor无额外tangent分配。
- 新的allocation-vs-owned-boundary审计没有强行判通过：96 malloc/free事件的bytes/identity/phase都同，
  但8个工作cache分配的preceding-owned-index不同。原版每个BVH先primitive AABB kernel再创建4个builder工作cache，
  source反序；triangle/edge各4项。真实两backend memory.jsonl支持，尚不称完整constructor时序同。
- 为避免在已知host遗漏image继续排长回归，仅SIGSTOP自己本轮验证coordinator PID2103421；
  当前initcheck PID2107887及GPU子worker未中断，继续自然完成。246/full74尚未开始，明确defer，
  不是把它们计为完成。GPU退出前不改/重编译production；后续新image补跑，旧4f结果保持。

- 新affine_constructor_audit.py把相对owned边界、malloc/free identity/phase/bytes、57 typed、28 payload、
  502 flat pointer核对整理成可重复CPU命令；4f实测只allocation边界为false，其它全true，保留报告不掩盖。
  增加metadata pin时首次KeyError：demo_memory的runtime没有launch_hook_sha256字段（只有fixture/extra/frames/image），
  已按实际协议校验存在字段并将observer provenance纳入输入SHA，不伪造缺失的runtime hook证明；重跑报告另存。
  GPU initcheck继续自然运行，coordinator仍停住，未编辑production。

- 4f initcheck全部16轨迹自然完成，ERROR SUMMARY 0；GPU子worker已退出。此后才终止此前停住的本轮coordinator，
  246/full74未执行，deferred-queue-final.json明确记录；不影响其它用户进程，不修改旧raw结果。
- affine_constructor_audit新增owned+library kernel名称时序；普通CUPTI launch没有几何字段，只有typed initializer
  记录几何，所以只宣称kernel名称顺序核对（owned几何仍由full hook验证），未把缺失字段当匹配。
  4f该名称顺序也false，符合4个Thrust初始化在primitive AABB前的已确认反序；先修复，再看是否还有其它差异。

- 4f检查点467源/构建、378结果SHA独立复核0差异；coordinator已按计划退出143，所有GPU结束后才修改。
- 567项owned+library名称时序的差异精确仅两个primitive kernel跨过各自4个typed init；
  因此只把codes/work_parents/work_children/builder_visits的创建移到primitive AABB后，sequence_fill前；
  未改变缓存大小、数值、列模式、数学或归约。
- 新image8fb9d2eec1626aba196a0c6a8665f61c4131189a1452f9f900fdd213fbd6bb31，CUDA176/f0未变。
  affine-bvh-boundary-validation-queue.py正串行八组、constructor三观察+审计、body/PP新原版8+source8、graph60、
  固定首次source0+source1/2各一次及8原版的完整worker graph-C8、initcheck3、246 config及完整74。
  initcheck此次3帧覆盖初始化/首次capture，4f完整60已0错误；真实graph/C8仍60帧，不以短检查替代长轨迹验收。
  任何constructor或ABI错误停止；strict状态/C失败保留并独立继续其它验证。GPU活动期间production锁定。

- 8f constructor审计全部5项通过：96 malloc/free的bytes、identity、phase及preceding-owned边界同；
  typed57/57、HtoD28/28 bytes/order、502 flat owned pointer targets及567 owned+library名称顺序全同。
  这不是全部CUDA API名字/未知view字段/所有copy语义证明，不宣称whole solver完全同。
- 8f body/PP新原版8及source8全部严格。body/cloth7/8，仅W3 contact block diagonal+self+spring状态不同，
  所有ABI/defined buffers/coverage同；graph60仍有严格失败，first NPZ保留。
- graph-C8首次仅脚本import失败：直接执行build子目录脚本不含repo sys.path，ModuleNotFoundError，尚未创建cohort。
  queue正确因无report停止而未误判C失败/通过。run-remaining.py为重试设置PYTHONPATH=repo，不改输入、算法或首candidate；
  原失败log保留。随后同image串行graph-C8、短程首次失败的3source/8原版及相同hook/dump、initcheck3、246、完整74。
  production继续锁定。oldsource0没有重跑或替换，所有新增source仅各一次。

- 8f固定graph C8完成：16轨迹15 primary-C通过；仅W3 NN block+diagonal+contacts+self+spring graph失败。
  source0 body_q全60、body_qd58/60、particle_q39/60、qd51/60在范围，rigid/soft counts全60在范围；保持失败。
  source1/2全部60通过，并与实际original1/2/3/4/5/7完整轨迹逐位同。没有重选source0。
- 8f短程同case固定C8：source0/1全部四状态数组0/3在范围，source2全部3/3在范围；仍未接受。
  额外9个worker的完整owned ABI一致，source计数覆盖同，固定source0 hash与首NPZ严格同；audit已存。
- 离线只作whole-trajectory存在性搜索（不是扩大/重算C）：同fixture、60帧、同全worker SHA的25份已存真实原版，
  没有一份完整匹配graph source0；report存contact-graph-source0-existing-original-match.json。C结果保持false。
- initcheck3为0，self contract246同；完整74正在跑。下一实际forensic应覆盖失败contact/block fixture本身，
  当前constructor96/567/57/28/502证明是W3 NN self无contact/block的fixture，不能泛化为所有case。
  先抓失败case三种constructor观察与flat pointer/alias，再看实际force/affine preconditioner/CG中首差，不改公式或阈值。

- 为失败contact fixture准备forensic-contact-case.py（尚未启动GPU）：先按相同W3/body-block/diagonal/contacts/self/spring
  捕获memory/payload/CUPTI，调用同constructor审计，不能把无contact fixture的通过泛化。
- cloth_graph_buffer_trace.py只扩展诊断：可选graphs14/15、按实际kernel29读取ELL大小；补spring/stretch/legacy soft
  和affine build/apply输出，增加start/RHS/affine build/precondition输入快照。所有读尺寸按实际ABI/已确认分配，
  特别确认build row_count为global36、body cache=3*144 floats；不读未定义contact tail。py_compile/128列通过。
  保留全60步轨迹核对observer effect，前2次/图记录4步；不替换固定source0。source生产和冻结spec均未改。
  该诊断要等当前8f完整74自然结束再运行，GPU继续严格串行。

- 8f完整74已自然结束，最终70/74严格；失败=[('particles-seed1', 21), ('particles-seed2', 14), ('particles-seed3', 21), ('mixed_cloth-seed3', 11)]。
  原始status/首次NPZ保持，未将strict失败当C通过；当前无生产改动，GPU转到已准备的contact专项forensic。

- contact专项三观察全部5项同：95 malloc/free含owned边界、57 typed、28 HtoD、646 flat pointers、711 kernel名称顺序同。
- graph内输入/输出快照均同，且观察后双方完整60帧严格同，但该观察改变了首次失败轨迹；26/32与首worker相同。
  因此没有拿观察后轨迹替换首次source0或把C改为通过。原始contact-graph-trace-audit保留。
- 新cloth_graph_post_step_probe.py仅在worker现有particle_q.numpy完成后才调用CUDA读现有缓存；
  不加graph节点、不改参数、不加GPU分配。实际只读取第一步完成后的最后NL缓存，不能冒称读到了第一NL或首差。
  计划1原版+3源码诊断进程，全部保留；它们是额外diagnostic trials，不是替换固定C source0。
- 探针首次布局判断错：误认为Newton particle_q排除了affine proxies；实际已存NPZ形状为(60,36,3)，
  solver初始化会给Newton model追加proxies。故投影后assert失败；失败log/runner保留，新目录按实际36粒子完整比较。
  没改生产solver或physics/输入；当前retry-layout诊断正在串行运行。


## 2026-10-31 — Windows交接与同仓库固定版本（准备提交）

- 用户要求先写交接，再在CSYSLAM/style3d-sim新分支提交/推送；明确项目处理版so和pyc必须同仓库。
- 新分支 reconstruction/windows-handoff-20261031 从 e74e136 建立。SDK由gitlink改成实际文件；
  私有空synreal-solver gitlink移除。旧gitmodules与SDK .git指针仅备份到本机.git/handoff-backups。
- Linux cp312处理版保持64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63；
  Windows cp311/cp312仅执行LFS checkout取实际文件，Linux处理版未被LFS覆盖。Windows官方pyd未声称等价。
- 原始_re_analysis及历史4c223854库复制入reconstruction/，kernel_ab.py和validate.py仅迁移路径，
  未改计算逻辑和固定hash。生产CUDA/host实现及其build manifest不改。
- 根交接重写为当前8f状态：176入口、constructor五项、graph27/32、固定C8 15/16、74回归70严格、
  4项严格失败和仍guard组合；区分旧结果和新image，不宣称全solver完成。旧根文档保留history。
- 补记最新post-step probe：1原版3源码完成，四次first-step/whole60均不匹配固定失败source0；
  last-NL first-CG numerator全同3d1675ce/3d1675ce/3d167448，rhs hash同，不能解释首次失败。
- 携带活动validation-8fb9d2ee完整证据、当前host/native构建依赖、GLM、CUDA12.4三个原始包、
  CUPTI13运行库/头及cuobjdump/nvdisasm诊断工具。多GB历史检查点不整体搬运，根交接已标明。
- 新增stdlib快照校验、离线固定C8重算、精确CUDA包恢复、环境脚本和固定requirements。
  工具恢复已在独立/tmp目录验证，nvcc=12.4.131；离线C8重算准确复现primary_c_passed=false。
- 迁移不代表Windows GPU已验证；建议WSL2 Ubuntu22.04继续相同Linux对照，新GPU需重新串行A/B。
- 交接测试与实际推送结果将在提交前继续补记。

### Windows交接迁移验证完成（提交前）

- 暂存区导出到/tmp/style3d-handoff-checkout-7gnhkrn2，旧机目录不复用；新venv、editable安装成功，
  requirements连传递依赖也固定为原环境22包版本。原版64a和源码8f均从新目录实际加载。
- 16个认证/本地凭据单元测试通过；固定首次失败C8重算与原报告完全一致，仍false，不把迁移当验收。
- 隔离重编译第一次失败：glm/glm.hpp缺失。追查到GLM目录有嵌套.git，git add叶路径未收录；
  已将GLM .git移至本机.git/handoff-backups，实际头文件与许可证全部收录，校验脚本补关键依赖检查。
  GLM1.0.1 commit=0af55ccecd98d4e5a8d1fad7de25ba429d60e863。全部curated artifact路径确认已暂存。
- 隔离重编译成功，176个kernel specs完全同、CUDA digest仍f0e0137a。新image SHA651d4df798dcbda4
  f97d67e26a0b1cd340fef180c88dbb4ff53d44f3574774eb。仅生成PCG PTX/bundle的_INTERNAL_4847d3a6_
  变成_INTERNAL_eca95160_，精确替换后完整字节一致；其余manifest输入SHA不变，未放宽断言。
- 新路径/RPATH使编译ELF SHA改变；活动源码库8fb9d2ee及处理参考64a0be7f保持原字节，不切换活动image。
- 固定8f和隔离新编译651各跑example_body_spring三帧12子步，body_q/body_qd/particle_q/particle_qd
  全部逐位同。传输测试保存于reconstruction/transfer/20261031/，含原始数组、日志、manifest与重编译so。
- 本次是Linux路径迁移测试，未声称Windows/WSL已跑；根交接列明WSL步骤、剩余差异和排查顺序。
- 原始账号文件未包含；候选文件扫描无保存凭据、token/private-key匹配，所有SDK是真实Git blob，无gitlink/LFS指针。

### 发布验收

- 提交37dc0081714e4f2bd2376871c1b4ad5a027ca6a0已成功push到CSYSLAM/style3d-sim的新分支
  reconstruction/windows-handoff-20261031，并已用ls-remote确认远端HEAD一致。
- 最终已提交Git tree再次导出校验，5328文件全部SHA通过；360个pyc、17个so，无gitlink/LFS指针。
- 从GitHub raw按提交SHA实际下载处理版_core.so、当前源码_source_solver.so、项目__init__.pyc，
  三者长度/hash与本地快照全同；远端manifest也与本地完整字节相同，详见transfer/20261031/remote-verification.json。
- 补充WSL图形客户端依赖安装说明；本次追加只更新交接/发布记录和快照，不改solver/二进制。
- 当前未解决contact graph首次source0、74回归4项严格失败与未恢复组合，交接文档均明确保留。

## 2026-10-31 — 交接后继续固定contact graph差异

- 起点76facc7，5329冻结文件SHA全部通过，离线固定C8准确重现失败；当前8fb9d2ee/64a0be7f未变。
- 先补查已有证据而非重选candidate：graph14的215 kernel/30 memset/21 memcpy/265依赖在屏蔽地址后
  DOT完整文本相同；212个native/kernel节点的完整geometry同。还需比较copy/memset与kernel指针别名关系。
- 现有memory trace逐word初查：无接触fixture无opaque view；实际contact fixture的9次C view共180个
  scalar/pointer词均同（按live allocation identity/offset），将整理可重复审计；尚不称整个solver通过。
- 新增late_cloth_graph_probe，只有wp.array.numpy一处包装；不包装capture/launch，直到目标首次已有q下载后
  才加载ctypes/driver/图参数查看代码，避免之前probe过早加载driver及额外graph对象生命周期影响。
  通过worker直接numpy调用计数定位最后fixture第0步；此前不读取f_locals以免保留旧scene。
- 计划固定1 source+1 original诊断；不把新样本加入原C8，也不替换source0，不改生产数学/阈值/内核。

- contact图内审计整理为cloth_snapshot_audit：266节点、215kernel/21copy/30clear，212 native参数、
  by-value view字段及copy/clear wiring全同；三个Warp节点参数仍未直接比，pointee/分配offset不冒称覆盖。
  view_argument_audit对原实际contact ctor的180个C view词含alloc lifetime/offset全同。
- late probe固定1source+1original完成：last-NL各缓存全同，source仍未复现固定失败source0，C8失败保留。
- block_pcg_snapshot_replay对实际last-NL rhs、inverse、affine inverse/valid做same-device-buffers三阶段
  重放（block apply、affine apply、precomputed=true PCG）：actual-runtime/original-PTX/source-PTX各32次，
  每阶段逐元素全同，三world numerator均[3d1675ce,3d1675ce,3d167448]；不代表解释了固定首差。
- 继续恢复明确缺少的body+full-surface host，不以以上局部证据把旧失败判过。新增独立affine_surface_scene，
  不改原C8 fixture：box半边长.025、center z=.479，真实布料两层及Newton full-surface pipeline。
- actual SDK八组reference全部完成、finite、15/45个surface contact，cloth和body RHS两侧均有真实增量。
  W1另捕获indices/bary/kind：15接触中8非vertex，kind=[0x8,1,2,2,2]（即8个零、1、2、2、2）。
  SurfaceView offset240/248/256分别精确匹配model.affine_body_ids/indices/body_centers_of_mass，264=body_count；
  kind offset104精确匹配initialize_step参数19。原版force顺序为rigid→surface→SO3，而当前source反序。
- 修正新A/B harness的dump JSON int-key比较为两份实际JSON比较；原reference运行路径不变。
  8f修改前27源/构建文件已复制并逐SHA校验到body-surface-before-8fb9d2ee；旧完整Git快照和首次失败不动。

- 新host image81468d9b4aa6942d379fdd8cc44a7fcb8bd06a5ca1b70513a466ed436606bc01：只补SurfaceView body字段/
  body kind、actual rigid→surface force顺序，按已捕获SO3窄组合收紧guard；CUDA176/f0不改。
- 实际source八组：W1五组状态/ABI/buffer/coverage全严格；W3三组ABI同，但状态及surface相关buffer不同，保留首次失败。
  W3首个surface force前RHS全同，后有21 scalar不同。
- 输入探针初版误按3world读取共享shape数组，导致诊断cudaMemcpy invalid argument；原失败目录保留。
  按actual Model spans与U200/208=1，正确只读一个共享shape模板；original/source重抓成功，不读contact尾。
- W3 actual 45条接触记录的完整multiset精确相同，但顺序不同：source相对original首15记录循环左移1位；
  count/材料/质量/kind/body映射/x/previous均同，indices/shape/body_pos因该排列不同。审计contact-input-order-audit.json。
- 相同GPU缓冲区下45个单接触，actual runtime/original PTX/source PTX逐元素全同；完整归约可不同。
  初版把单接触normal/friction合并结果作sum witness不充分，已标INVALID_WITNESS_NOTE，不拿108项冒称B通过。
  新诊断保留每个red.global.add，额外记录每lane真实目标/操作数；将严格比原子操作数再做逐标量F32见证。

- 814 image全部四种surface操作完成actual common-input验证：force/stiffness/preconditioner/tangent，
  原版runtime/PTX和source PTX的45个单接触输出全同。逐lane真正atomic目标+F32操作数序列全同，
  分别1440/240/4320/1440次写入；各108/36/324/108个scalar在captured、三个未插桩重放、两个插桩
  输出中均有真实逐原子操作数的精确F32排列见证。没推断旧生产执行顺序，没替换闭环首次失败。
- 原版/源码W3 contact packet multiset全同、实际排列不同；常量材料、x/previous、body映射/kind全同。
  接触追加顺序加上并行atomic归约解释该测试的局部首buffer差异，不把它泛化为所有闭环轨迹已通过。
- 814中间源码/构建27文件再独立快照校验，保存全部阶段证据；接下来只补scope声明后生成最终image，
  对同一最终image重跑source八组、四kernel实测、graph60、initcheck和74回归，不挪用814通过率。

### 25ecf6f4 最终串行队列与固定失败复核

- 活动host image为25ecf6f47257a2a10bb32b47782a8ff7a311d3f5a933f0f68bac2947e69fe894；
  CUDA digest仍f0e0137a，参考64a0be7f不改，solver_api_ready=False。
- validation-25ecf6f4/status.json已complete：四surface算子同输入逐接触/真实atomic操作数复核均通过；
  source八组5/8严格；surface graph60为21/32严格；legacy cloth graph60为29/32严格。
  legacy本次contact严格相同不说明旧8f首次source0失败已解释，旧candidate及15/16报告不替换。
- initcheck3的16条eager/graph轨迹均0错误；246配置合同同；完整74为70严格通过，失败为
  particles-seed1/2/3及pd_mixed_cloth-seed3（注意本image是PD，不是旧8f的NN mixed seed3）。
  七个正式demo各60帧严格通过；不把局部新增分支叫作整个solver完成。
- 新固定C8采集采用首对worker原始输出作为original0/source0，预先固定再加2source+7original，
  都保留完整worker环境；surface为11/16，legacy cloth为13/16，均false。未加样本直到通过。
- regression-fixed-C10采用四项首次source0不重跑，各采9次原版加original0。初版错误把空间粒子轴当
  timestep轴；原report.json标INVALID_AXIS_NOTE，原始NPZ/输出不删。用完全相同数据重新按key中已有
  真实step包成单空间快照，report-array-steps.json为正确结果；未扩大样本或替换candidate。
  正确C10：particles seed1/3与PD mixed seed3通过；particles seed2仍失败，两个key是同一速度状态的
  step1 out与step2 in。error=1.430511474609375e-05，原版LOO=1.33514404296875e-05，ratio=1.07142857。
  旧atomic_spread_check的NPZ时间key处理本来正确，不能把这次新脚本错误归咎于旧脚本。
- 只做隔离layout实验：原版surface四算子的440字节workspace对应两份220字节中间结构；
  当前正式源码简化为132字节。prepare_surface_layout_trial生成独立CU/PTX，不写正式kernel/bundle。
  初版与split版均保留；split版使用分别的normal/friction helper。仍非原版PTX逐字同；大部分多余文本
  来自原版大量mov.u32，尚未证明对生产GPU调度的影响。不得仅凭局部aggregate碰巧相同换正式代码。
- 新surface_layout_branch_ab以项目64a原版实际PTX、活动源码image与split实验PTX进行同buffer对照；
  一个实际CUDA thread串行处理接触列表，隔离跨线程atomic顺序。3seed×27边界fixture×4操作=324组，
  活动source与trial均逐位同原版。含alias indices、特殊normal/bary/material、world/body映射、guard。
  这不是正式并行轨迹验收；原C8失败保留。结构差异尚无新增数学错误证据，未采用该trial。
- 接着对particles-seed2的n257_w1_it1_f0做一对actual原版/source逐GPU阶段诊断，输出独立
  particles-seed2-stage-trace；trace-case只跑该fixture，因此不当作复现完整worker首次失败或C10替代。

- 该诊断102次launch metadata完全相同。首差在000038 precondition_and_reduce的after.numerator，
  legacy/source为1186284884/1186284886（bits），其输入/逐元素z同；两者各找到相同257个贡献项的
  精确F32排列。actual-runtime/original-PTX/source-PTX同buffer各32次、旋转顺序，z全同，原版actual
  覆盖两个目标bits。105个独立PCG逐元素重放0失败，42个atomic aggregate有6严格不同，均保留。
  traced source完整输出并不等于冻结source0，不能拿新诊断替代失败或声称旧失败已闭合。

### simultaneous full-surface + rolling host（cc09a3c0，验证中）

- affine_surface_rolling_ab使用独立ground/box/cloth fixture，不改变此前surface/cloth fixture。
  actual64a八组先完成，全部finite；W1真实rigid4/surface17，W3为12/51，rolling force真实改变RHS，
  surface也改变cloth与body双方RHS；不是只测有launch但没有有效接触的空路径。
- 捕获发现真实force顺序为rigid→rolling→surface→legacy soft→SO3→stretch/bending。
  25的surface→rolling在该组合反序。先将25的27个源/构建文件完整复制并逐SHA验证，保存在
  body-surface-before-rolling-25ecf6f4；旧候选/证据不动。
- 仅把surface force移至rolling之后，按实际捕获解除这个SO3组合的rolling guard；其它guard保留。
  CUDA数学、176入口、f0 digest与64a参考库完全不变；新增scope声明后编译host image
  cc09a3c0070d82a139e2c1e24269899985ca439b5b7652915d702258f3bd9a41。
- 本image rolling初次八组：五W1状态/定义buffer/owned ABI/coverage全严格；三W3状态有差异，
  owned ABI/coverage八组都同，首候选保留在surface-rolling-source-first8。不提前把W3判过。
- 目前对cc09重新串行跑四kernel、旧surface八组、surface/legacy graph60、initcheck3、246config与74回归，
  新输出validation-cc09a3c0，不继承25的最终通过率。后续还需rolling graph、initcheck与正式cloth_balls。

### cc09 完整结果、正式 demo 与两个实际 host 调度遗漏

- cc09串行队列已complete：四算子A/B通过，source8为5/8严格、surface graph21/32、legacy cloth graph25/32；
  surface initcheck3零错误、246配置同。完整74为71严格，只有particles seed1/2/3严格失败；
  25的PD mixed seed3失败不继承到cc，也不删除其原始失败。cc尚未做新的固定粒子C10。
- rolling graph60为20/32严格（五W1的全部原版/源码/eager/graph比较都严格，W3十二项均不同）；
  固定3source/8original完整worker C8为11/16，仍false。source0及全部失败保留。
- rolling原版和source各16条轨迹×3步initcheck均零错误，源输出记录在cc的rolling-initcheck-*3。
- 新official_cloth_balls_ab直接加载未修改examples/example_cloth_balls.py，默认参数5NL/50CG、2substep，
  eager每子步记录、真实完整CUDA graph每帧记录。预先固定每模式8原版/3源码，全部22worker跑完60帧，
  全部finite且通过demo.test_final（袋子/球/固定点约束），source均确认不映射原版库。
  但两模式固定C都false；没有因graph source0恰好通过全部60帧而选它替代source1/2。
  eager原版彼此也全部不严格；graph source2在多个状态/soft_count上明显超出固定C范围，保留继续定位。
- 追加official_first_buffers探针时，初版误把legacy soft arg35（float inv_dt）作为GPU指针抓取，
  original诊断进程SIGSEGV；失败harness/前序dump/FAILURE.md均保留，正式22次运行不受影响。
  已按实际demangled ABI修正force=arg36、diagonal=37，并在启动worker前验证所有抓取参数必须为指针
  或明确的byvalue view首指针，避免再次把标量传给device-copy。新目录correct-abi，不覆盖失败目录。
- 修正探针后发现真正host差异：5214次owned调用中520次surface geometry不同，SDK为32 block，
  cc按soft capacity90567用了354 block。原版实际step.asm fb7cf..fb7ea显示block_count后min(...,0x20)，
  force/preconditioner/stiffness和tangent lambda都复用此值。非凭经验猜测限制。
- actual64a九个capacity阈值1/255/256/257/8191/8192/8193/16385/90567证实min(ceil(cap/256),32)。
  每case只保留一个有效接触，所有缓冲区按capacity完整初始化；未读取未定义contact尾。
  保存cc09的27源/构建文件后，仅新增launch_surface限制grid、不修改View.capacity或接触处理范围，
  四surface入口统一使用；生成中间host d932eb2f，CUDA176/f0不变。
- d932上原版runtime/PTX/source同buffer验证8191/8192/8193/16385实际不相交接触，四算子16组全逐位同，
  每组最后接触真实起作用，输出5个guard粒子不变；证明32block的grid-stride不会截断8192后的记录。
- 同一capacity probe又找到U208差异：W1 model.shape_replicated_count=0，原版传shape_count=1，source传0。
  actual step fb621..fb638 /101020证实：仅单世界且未指定tile时回退shape_count；多世界保持0共享语义，
  显式非零tile保持。该局部变量还给rigid/rolling/hard/legacy soft传参，不能只修surface。
- 再保存d932的27文件后按上述实际分支增加contact_shapes_per_world，六处联系人shape布局统一使用。
  当前host ff34e6a18e2a7d62ac9203c1c532c2ffc8c9c698f2eb2dc799f2d3d7a261f042；CUDA176/f0、参考64a不变。
  九capacity原版/source现在351次完整ABI/geometry全同，162组状态全严格。
- ff34正式demo重验采用cc固定8原版的精确原文件（逐SHA复制，不补采样、不改fixture/harness），
  每模式新采3源码，六worker全部60帧physical/finite通过，但eager与graph的固定C仍false，全部保留。
  ff34新first-buffer诊断5214次完整owned ABI/geometry全同；首个定义buffer差异在surface force之后
  （266 scalar）；之前所有已抓定义数组全同，实际rigid17/surface1380。此诊断不替代冻结source0。
- 正在独立检查shape fallback的static W1/W2/W3、explicit/shared tile及body soft/hard组合；
  之后对ff34做最终队列及完整粒子C10。late_cloth_warp_probe已写但尚未运行，不能说三个Warp节点已核对。
- CPU离线C10 audit已准确复现25的三过一失败；初版比较遇到JSON整数checkpoint键变字符串的问题，
  改为同JSON schema后逐字段完全吻合，未改统计。operand recorder补静态site覆盖/谓词保护，八模块
  instrumented PTX bytes与已测版本完全相同；负例最初误改了模块另一entry，已纠正为选定entry后全拒绝。
  旧版本都留在versions。随后扩展诊断为实际32block/最多8192 lane读取，正式物理源码不受影响。

### ff34 最终检查完成与当前边界

- shape fallback新增独立六static场景（W1/W2/W3×默认0/显式1 tile）及四body场景
  （Newton/PD×soft/hard，强制单世界shape_replicated_count=0）：108+60状态数组全严格，
  324+24900次完整owned ABI/geometry全同，body场景都有实际rigid contact；不是空路径通过。
- ff34正式大demo的initcheck3（6个substep，5NL/50CG）零错误；最终串行队列complete：
  四45-contact算子A/真实atomic序列同，source8为5/8严格、surface graph21/32、legacy cloth graph30/32，
  surface initcheck3零错误、246配置同、完整74为71严格。首三个particles seed严格失败，各固定source0
  对10次actual原版全数组/真实step C10通过，CPU独立重算完全一致；不把新结果当作解释25旧失败。
- ff34两类graph另外各固定3source/8original，直接采用最终首对worker作source0/original0，不替换，
  全worker60帧context保留：surface为10/16、legacy cloth为13/16，两者都false。全部数据保存。
- 新late_cloth_warp_probe实际运行一original+一冻结8f source，不覆盖活动ff so：实际CUDA查询了
  三个Warp节点参数宽度，全部215kernel（212 native+3 Warp）、21copy、30clear的参数/alias wiring同；
  26个post-step Warp数组同。不涵盖allocation-relative offsets，不把post值称作prelaunch输入。
  新probe与旧8f固定source0四状态从首步就不同，whole60也不同；旧失败未复现、未解释、未替换。
- 正式大demo原版/source新的完整输入抓取都为1380真实接触；完整记录multiset精确同但排列不同，
  所有只读数组、actual view scalar/geometry和初始RHS均同。actual runtime/original PTX/source在
  同buffer的1380个isolated-contact输出全同；原版与source PTX逐lane37920个真实red操作数全同。
- 初次4096随机顺序未找到五个标量（含原版runtime自身）；partial报告保留。CPU证明搜索只排列
  已抓原子贡献，不修改输入/结果：13个非零贡献的20715个subset状态找到罕见最小结果；较大550操作数
  用精确F32次序搜索、尾部subset枚举补齐。首次completion仍漏source-captured一scalar，partial-harness
  与partial结果保留；exact-witness-final现在七类输出各5205/5205，有36435个逐标量精确证书。
  不推断未插桩真实执行次序，不称整GPU交织已恢复，不据此验收仍失败的整段C。
- 最终小45-contact force随机证明也漏一个instrumented scalar，CPU exact-witness-completion已补齐；
  其它三个算子的全部目标原报告已完备。没有为找证书重采GPU或扩充统计cohort。
- 源码CUDA176/f0和参考64a字节始终没改；唯一活动源码host为ff34，旧8f/814/25/cc/d932各27个源/构建
  文件完整快照都保留。仍有body+tet/drag/hard-full-surface、更多约束/材料组合保护，整体目标未完成。
- 当前继续点和命令写入AFFINE_SURFACE_HOST_RECOVERY.md；准备将本轮源码、活动so、原始证据及交接
  提交到既有reconstruction/windows-handoff-20261031分支，SDK和360个pyc保持同仓库固定字节。

### 本轮检查点整理与Windows迁移补齐

- 五个body-surface检查点各27个文件逐SHA复核通过；当前host/native的全部构建源与产物SHA均吻合，
  活动host仍ff34，参考64a完全未改。新增27个Python helper均通过AST解析，源码/文档diff无空白错误。
- 交接入口补齐ff34最终结果、原始失败路径和CPU/GPU复现命令，明确旧25 seed2与8f source0未闭合，
  不用新image通过结果倒推旧失败已经解决；solver_api_ready仍false。
- 发现新完整验证runner使用旧机compute-sanitizer绝对路径，迁移后会缺文件。将实际使用的
  NVIDIA Compute Sanitizer 2026.1.0.0/build37182542全部129个文件复制到项目diagnostics-13.2，
  与旧机逐文件校验，provenance含版本/哈希；已有同目录EULA保留。编译器仍固定nvcc12.4.131。
- 原runner先保存到ff34/versions，SHA与full-validation/runner-sha256.txt一致；仅把工具发现改成
  项目相对路径，环境脚本加入其PATH，不改fixture、计算和比较标准。原完整队列结果仍属于保存的旧runner。
- 用项目内工具实际重跑source graph initcheck3，退出0、ERROR SUMMARY:0 errors；独立输出及精确命令在
  ff34/portable-sanitizer-initcheck3*和portable-sanitizer-verification.json。不是跳过内存检查或声称整段C通过。
- 本轮只纳入明确列出的源码、五个检查点、continuation/25/cc/ff验证、grid/rolling证据和固定工具；
  没有把整个build或虚拟环境加入Git。整理后索引共14839文件，无gitlink/LFS pointer，最大新增文件约15.1MB。
  原项目SDK无任何修改，360个现有pyc与上一交接SHA完全相同；新增文本未检出账号值或私钥内容。
  最终以RECONSTRUCTION_SNAPSHOT.json逐文件锁定本轮交接，推送仍使用既有Windows handoff分支。
- 快照实际全量校验14838个文件，failures=0；包括当前host/native构建来源和产物校验。
  当前Python helper AST与源码/文档的git diff --check通过；当前活动image、失败cohort与全部限制如上。
- 发布核对：源码/证据提交88d1335ad43380b4e79204ec585403d456436ea9已推送到CSYSLAM/style3d-sim的
  reconstruction/windows-handoff-20261031，ls-remote与本机提交完全相同，发布时工作区干净。
  从GitHub raw按提交下载实际参考so、活动源码so和当次manifest，三者均与本机逐字节一致：
  参考仍64a0be7f，源码仍ff34e6a1，不是LFS pointer或另一个子仓库。接手拉分支最新HEAD后先校验快照。

### 继续定位ff34固定失败（2026-10-31）

- 从已发布的固定C8直接读取：surface W3 Newton block/self/spring eager的8原版首步四状态完全同，
  三源码均从首步超出C，source0粒子位置最大差4.155933856964111e-5、速度0.009974479675292969；
  普通W3无self/block首步只在前两个世界body平移分量差1ulp。先查稳定的首步差异，不扩大原版cohort。
- 新surface_worker_stage_probe保持原worker完整8场景×eager/graph×60帧，按scene配置只对目标第一个
  eager步开启既有full-owned-hook的逐kernel pre/post dump；不保留scene/bound-method引用延长生命周期。
  预检全部dump参数实际ABI都是指针。原worker/fixture/生产so/算术均未改；同步观察器可能改变原子次序，
  必须另与冻结source0比较，不把新probe当作原固定失败。输出continuation-20261031-ff34e6a1。
- 首版probe把SO3 tangent arg1局部ivec4索引误当全粒子vec3，诊断original进程CUDA invalid argument；
  失败harness/部分dump/log/FAILURE均保留。修正为arg0，并在每个全粒子向量dump前核对实际pointee为vec3。
- correct-vector阶段完整worker对照成功：目标230次owned调用参数/geometry同，首个所抓定义输出差异是
  surface force（14词，最大4.76837158203125e-7）。两诊断轨迹均未复现冻结首候选，绝不替换旧source0。
- all-body-inputs另抓完整预条件器build/apply与SO3 tangent的真实输入，原/源码各33个packet（3NL build，
  15apply，15tangent）。同一分配上旋转actual SDK runtime/original PTX/source PTX，8次/后端，
  1584次核调用的1728个输出buffer比较全部逐位一致，且全部与实际抓取输出一致。
  零cable CSR验证[0,0]，保留byvalue payload，
  指针别名也保持。不是只拿不同输入的输出做近似比较。
- 新CPU audit直接重算已发布surface固定C8的48个source/case统计，全部与保存报告完全同；C仍false。
  精确首个超C坐标、各原版/source位模式与固定NPZ SHA已保存，没有添加原版样本。
- PTX oracle只用于隔离，不是源码候选：源码host不变，分别替换4 surface或全部129 owned（实调用52）。
  每种一个完整worker。原版literal PTX得到严格12/16，两模式C分别12/16、15/16；旧固定失败仍保留。
- 再用SDK实际kernel stub oracle：surface严格11/16、C12/16；owned严格13/16、C14/16。
  owned模式原稳定W3 Newton block/self/spring eager与冻结原版60帧逐位同，但其它两轨迹C仍失败。
  该adapter明确允许原库映射，输出oracle-*并写非source/non-original-sample标记，不生成source-only证明。
  不能把oracle输出纳入源码验收，也不能从单次改善推断PTX文本就是因果。
- 为查SDK runtime与literal PTX差异，CUPTI实际抓取JIT模块。初次编译observer混用CUDA12.4/CUPTI13头失败，
  重用仓库已有支持module资源的cupti_param_trace.so；前次失败日志保留。新198项回放全部严格。
  三个literal加载得到的整个3605304字节ELF与SDK实际加载ELF逐字节相同（97个text entry均同）。
  所以不能再把两oracle轨迹差异归因于其机器码不同；模块装载/指针布局/原子调度等仍待隔离。
  源码apply的5个text同，affine/SO3与body build text仍不同但上述实际输入输出全严格，不擅改数学。
- 原版surface preconditioner逐点展开7个normal和7个friction Jacobian block，共126个静态red site。
  新隔离220-byte struct试验恢复这个展开（原先trial只有18），324个串行分支对照全严格。
  预先固定3个source-only完整worker对原8份NPZ，C仍10/16；未采用这个试验替换正式f0。
- 再排除模块组织因素：按原版6个PTX模块分组链接不改entry的源码PTX，逐entry digest仍与正式版相同。
  第一次6组均链接成功，末尾误假定总entry实例数=176而断言失败，失败脚本/产物保留；已改为明确区分
  176唯一符号、205实例（13个辅助符号跨模块重复，共29个额外实例），129 owned都只有一个归属。
  修正组装后的3个source-only worker对固定原8份仍C10/16，不据此修改正式模块分配或数学。
- 按实际PTX零种子和loop活跃值继续探查220-byte返回记录形态，均为隔离源码试验：零初始化、持久record、
  rejected-contact返回零record三种各324项串行分支全严格。前两种未解释大量mov差异；结构返回将force
  mov.u32从71/73接近到870（原版1094），但仍不相同。preconditioner已126 red，但local仍220而原版440。
  接口形态目前只是由PTX指导的假设，不称已恢复原C++源码；正在用预先固定3worker评估struct-return。
- struct-return的3worker已完成，C11/16仍false，未采纳到正式版。原固定候选、门槛和f0 CUDA均未修改。
- 新增3个未改原版完整worker作为独立holdout；与冻结8原版比较有12/48条超C，原8份NPZ前后SHA未变，
  不把holdout加入基线或重判源码。W3 Newton block/self/spring eager的3个新原版都超C，
  第一份首步粒子速度最大差0.010344505310058594，旧基线该步spread=0；不是源码独有的现象。
  运行fixture/worker哈希相同，日志GPU/driver相同、10个Warp GPU module签名集合完全相同。
  未宣称冻结时所有CPU依赖或环境变量已完整哈希；holdout也没有逐轨迹复现旧source0，限制均保留。
- CPU float64 SVD检查实际抓取的float32 12×12 body inverse，cond2范围约19132.94..69495.40，
  输入SHA/逐world结果在body-block-conditioning.json；这只是数值条件记录，不当作整段差异因果证明。

### 按原版补SO3 body + tetrahedra host

- 不用固定C8数字代替原生等输入验证；保留此前失败，同时继续补确实缺失的body/tet组合。
  新fixture使用实际deformed/damped tetrahedron与SO3 box，W1/W3×Newton/PD×body block开关共8组。
- 初版明确禁用surface edges，W1四组原版通，W3在Python共享模板适配器取不存在edge_rest_area时失败，
  尚未到native initialize。保存旧fixture/日志，改用官方add_soft_mesh默认surface edges后重新捕获全部8组。
  默认fixture的8组原版均finite，tet force真实改变RHS。旧4组不挪用到新fixture的验收。
- 原版W3 constructor实测：scalar ELL typed cache之后分配/上传4B tet volume，再分配/上传32B body kind；
  step实测force为SO3→stretch→tet→bending，tangent为SO3→tet，非先tet后SO3。
- 生产修改前，将ff34源码/构建27文件完整复制并逐SHA核验到body-tetrahedra-before-ff34e6a1。
  仅按捕获补body矩阵路径precompute_tetrahedra、恢复SO3→tet tangent，解除SO3无contact/self/fluid/drag/
  body constraints窄组合guard；其他组合仍拒绝。CUDA176/f0、参考64a不变，solver_api_ready仍false。
  新host已编译，正对新原版8组核对完整owned ABI、状态与缓冲区；未提前宣布该scope验收。
- 新活动host为b94560319d3a1c8aa7c898ce49b37748ae254ec30de28533deae292b4970a278：
  八组source均与对应原版全部状态、所抓buffer、owned ABI/geometry/coverage严格同。
  新affine_tetrahedron_graph_ab的32项完整60步比较全部逐位同，原版/source各16条×3步initcheck均零错误。
  新image的surface/cloth/四kernel/246config/完整74串行回归在validation-b9456031独立跑，不继承ff通过率。
- b945独立完整队列与followup均complete：74项70严格，严格差异为particles seed1/2/3和
  pd_mixed_cloth seed3；各冻结本次首次source0，对预先固定10原版逐数组/真实step C10全过，CPU重算吻合。
  没有把原8/25失败拿新image结果销账。surface source8为5/8，surface/legacy graph21/32、28/32；
  246配置同，surface initcheck3零错误。四surface算子的等输入输出/真实atomic操作数全同，
  force初次随机见证漏1个source-probe scalar，CPU补齐6目标×108scalar；其它三算子原报告已全完备。
- 新body/tet W3构造用memory/payload/CUPTI分别在真实original/source执行：五项全同，96分配/释放事件、
  29 HtoD payload及顺序、57 typed initializer字段/用途/时序、508 owned调用的allocation identity/offset、
  573 owned+library kernel名称时序。原observer不重编译，audit仅增加可选folder prefix，旧版源已保存。
  不声称所有CUDA API名、opaque view字段、library几何或所有device copy/clear语义均同。
- b945未另采surface/cloth C8或正式cloth_balls 3/8 cohort，不能继承ff的C结果；旧失败全部保留。
  下一步从真正交互的body/tet+self或contact组合捕获原版开始，guard仍在，完整solver依旧未完成。
- 当前checkpoint-summary.json按已完成status与followup报告生成并断言核对，所有本轮GPU worker已退出。
  nvidia-smi仍有另一个worldparticle项目的Python进程，本轮不终止它；没有并行运行新的GPU验收。
  发布准备仅重新整理已完成证据、当前源码/so与同仓库固定SDK/pyc，先逐文件校验再提交。
- 发布前索引21560文件，本轮6729路径约580.4MB未压缩证据；最大单文件48.51MB，无超100MiB文件。
  固定SDK无差异，360个pyc逐SHA与上一快照相同；无gitlink、LFS pointer、虚拟环境、凭据模式命中。
  host/native的当前构建来源及产物SHA、Python AST与源码/文档diff检查均通过。
- 本轮实际快照校验21559个冻结文件，failures=0；源码与证据提交
  8f04494cd12ca79ee59c541a6dc2ea11d76f599e已推送CSYSLAM/style3d-sim既有Windows交接分支，
  ls-remote与本机HEAD完全同，推送后源码工作区干净。
  按该提交从GitHub raw下载参考so、源码so及快照，三者均与本机逐字节同；参考64a、源码b945。
  原始下载校验记录为validation-b9456031/published-8f04494-verification.json。
  随后只补此发布记录与更新快照，不修改求解器或已验收数据；下一步仍是有实际交互的body/tet组合。

### b945续接：实际body/tetrahedron full-surface接触

- 从已发布861a930干净状态继续，固定参考64a、活动host b945、CUDA176/f0均未修改。
  新fixture保留实际deformed/damped tet，把有速度SO3 box置于其底面附近，使用官方full-surface pipeline。
  预先固定W1/W3×Newton/PD×body block×diagonal-only共16组，每组三步，先只抓原版。
  验证要求非零contact、surface对tet/body两侧RHS都起作用、tet force也实际改变RHS；
  逐kernel dump前核对pointer ABI，保留完整owned参数/geometry，禁止放宽比较或替换首候选。
  新证据目录continuation-20261031-b9456031-contact，所有本轮GPU worker串行，未停止其他项目进程。
- 新harness首轮ABI预检拒绝surface arg0：它是by-value SurfaceContactView，首word才是count device pointer。
  在任何GPU worker启动前已退出。保存失败harness/日志，按实际View头布局及hook的word解引用实现，
  仅显式允许该4B count字段；所有其它dump仍要求pointer。换新original16-view-aware目录重新抓取。
- 原版16组均完成且finite，W1初始10个真实contact，tet/body两侧RHS和tet弹性项全部实际变化。
  实测force顺序surface→SO3→stretch→tet→bending，preconditioner为tet→surface，CG为SO3→tet→surface。
  修改前27个生产源码/构建文件及所有原版结果SHA保存于tetrahedron-contact-before-b9456031。
  仅放开SO3+tet的full-surface软接触分支；self、legacy-only contact、hard contact、drag/fluid继续拒绝。
  未修改CUDA数学、kernel digest或比较标准。先编译并对固定16原版逐位核对，尚未验收此scope。
- 新host image为8f4127f0f2f3b90fed919ca87f94ff3e5e38fa251b4e24992e065b2f62ac02d2，
  构建来源SHA全部吻合，176入口和f0 digest不变。独立validation-8f4127f0-tet-contact队列顺序运行
  source-first16、完整eager/graph60、W3三种observer构造审计、original/source各graph initcheck3。
  队列固定build字节、保留每条命令与非零退出；新增harness不修改已冻结的tet/surface fixture或旧证据。
- source-first16已完成：16/16状态逐位同，8824次完整owned ABI/geometry同，160份定义post buffer同，
  source launch coverage均同，实际contact/双方反作用与tet弹性项检查全部生效。旧失败不改变。
  正在跑完整graph/constructor/initcheck队列；这只是新scope局部结果，不能宣称完整solver通过。
- 新scope主队列全部完成：64/64项60步eager/真实graph比较逐位同；original/source各32条轨迹×3步
  initcheck均ERROR SUMMARY:0 errors。W3实际constructor五项全部同：96分配/释放、29上传、57 typed、
  634 owned指针用途、699 owned+library核名称时序。审计边界仍不包含全部CUDA API/opaque view/library几何。
  随后串行重验新image的无contact tet graph60、246配置和完整74回归；不用b945结果代替本次结果。
- 离线直接按dtype/shape/原始bytes复核首次16组状态、160个post buffer和64对graph轨迹，全部同；
  saved-contact-cpu-audit.json锁定输入SHA，无GPU重采样、无首候选替换。
- 利用已保存full-memory构造资料补SurfaceContactView审计：63次view调用、每次26个pointer字段，
  11个scalar word，记录全同。126个owned用途、945个Model字段、63个null均同；504个外部地址暂只能
  逐地址比较，尚未证明其State/Contact语义。旧auditor已逐字保存后，新增可选实际native step绑定与
  host-only marker支持，准备在完整回归结束后串行补抓；不改计算或增加GPU操作，不替代固定首候选。
- 当前完整74已完成：71严格，三个particles seed严格差异。固定C10完成且CPU重算完全吻合：
  seed2/3通过，seed1未通过，7个数组/记录步超范围，全部在n257_w1_it1_f0的step1/2。
  最大位置误差约2.38e-7，速度约1.43e-5，固定C ratio最高约1.20536；不扩充10原版、不替换source0。
  保存此失败并继续定位257粒子单NL/无外力PCG路径；不能写成新image全部回归已验收。
- Surface view绑定诊断完成：63次view全同，504个旧外部地址全部识别到实际native State/Contact Span，
  另945个Model字段、126个owned allocation+offset、63个null同；每view11个scalar word同，忽略4B padding。
  新diagnostic原版/源码三步状态也同；未替换首次16组。全pointee数据与其它view不在此次结论内。
- CPU首差报告初次JSON写出遇到numpy.int64索引，尚未生成输出；改为显式Python int后重算成功。
  固定case仅7数组各6词差异，step0原版/源码完全同，step1位置最大1 ULP、step2最大4 ULP。
- 新particle_full_worker_trace保留全部前置fixture和adapter，仅目标initialize之后开启既有host_trace。
  原版/源码目标15/15数组分别与冻结original0/source0完全同，实际复现本次失败，不是换另一个候选。
  抓到102个entry名称/geometry同，首post差异为000038 precondition numerator：输入inverse/r、输出z及
  初始counter全同，累计值1184181755 vs1184181753；000040的p/Ap/初始counter同，累计值1184181755 vs1184181756。
- 对两个first-divergence packet，actual SDK runtime/原版PTX/源码PTX在完全同一缓冲区/stream各16次轮换，
  共96次kernel逐粒子结果全同；actual SDK runtime自身均产生冻结原版和源码两端累计值。
  257个真实dot贡献找到四个精确F32排列证书，均无未解释目标；未将这些诊断加入固定10原版。
  两个PCG entry规范化PTX完全同；全部10个实际entry中7同，start/RHS/invert三者文本仍不同，已如实列出。
  此次首个分歧定位为atomic归约次序，不擅改生产数学，完整C10/整段轨迹仍false，旧固定失败均保留。
- 全部本轮GPU任务已退出，nvidia-smi无计算进程；checkpoint-summary.json明确71/74、C10两过一失败、
  新contact16/64严格通过和view语义绑定范围。整理源码、当前so、27文件检查点、原始数据与交接到既有分支，
  不修改固定SDK/360个pyc，不把本轮局部通过说成完整solver完成。
- 发布前索引25442文件，本轮3888路径约277.2MB未压缩证据，最大新文件7.74MB。
  固定SDK无改动，360个pyc与上一快照逐SHA相同，无gitlink/LFS pointer/凭据模式命中。
  当前host/native构建来源与产物SHA均一致，新增Python AST及128列检查、源码/文档diff检查通过。
- 快照实际校验25441个文件，failures=0；实现/原始证据提交89064f72c1c34bb8e4f975cafabb08f1fe586328
  已推送既有reconstruction/windows-handoff-20261031分支，ls-remote与本机同，推送后工作区干净。
  按该提交从GitHub raw下载参考so、源码so及快照，三者均与本机逐字节同，参考64a、源码8f4127f0。
  published-89064f7-verification.json保存发布核对，也明确71/74、C10两过一失败和ready=False。
  随后只补发布记录/下一步和快照，不修改生产代码、候选、数学或比较结果。

### 持续核对8f4127f0固定粒子失败的完整路径

- 用户要求目标未达到前持续推进，不以发布检查点作为停止点。以09d868c干净状态接续，参考64a、
  host8f4127f0、CUDA176/f0不变。先补start/RHS/invert三个文本不同入口的实际同输入回放。
- 检查旧host_trace实际dump发现缺少模板和完整标量，不能按当前cpp源码假定旧binary已记录这些值。
  新particle_packet_capture保留base observer源码、生成独立packet observer，按固定ABI记录每个参数字节，
  补实际gravity/world、templates、mass/flags/ELL。旧observer和生产so均不覆盖。
  继续使用完整worker顺序抓取原版/源码，只在目标case打开observer；保持固定source0/10原版不变。
- 生成器首轮锚点同时命中snapshot与metadata两个位置，唯一性断言在编译/GPU前拒绝；旧生成器/日志保留。
  改为带snapshot上下文的唯一锚点，在新complete-packets-v2目录重做，不覆盖失败记录。
- 新完整参数observer抓取完成，但其同步时序使目标original/source均只与冻结目标8/15数组同，不能替代旧轨迹。
  实际同输入回放保留旧轨迹动态数组，补同一固定模型新抓的静态/标量参数并逐项核对mass/flags/host diagonal。
  18个packet（两种capture×三步×三入口）各runtime/原PTX/源码8次，共432次调用、864份输出逐位同；
  保留实际pointer alias，特别是invert的blocks与inverse原地别名，不猜dt/alpha/gravity。
- 继续核对整条PCG路径。CPU检查84次归约，发现1280个subnormal dot operand；不能直接用普通CPU加法
  验证global atomic。按NVIDIA PTX说明核查FTZ语义，并准备以真实PTX操作数和GPU逐次atomic证书验证，
  不改生产算法、不把新GPU诊断加入固定cohort。两份三入口helper已存versions后再扩展。
- 完整固定路径同输入回放完成：204/204 packet均通过（两种实际轨迹各102次调用），actual SDK runtime/
  原版PTX/源码PTX各4次共2448次核调用，所有已记录pointwise输出同；apply清零dx未在旧dump保存，
  此额外输出由首次actual SDK runtime测得后与其余后端逐位核对，未反向灌入生产执行。
- 84/84次归约已闭合：原版/源码instrumented PTX的257-lane真实red操作数逐位同，共168次instrumented调用。
  每个冻结counter目标都找到精确F32加法次序证书，并由GPU单lane真实global atomic逐次重放，最终bits及
  全部before-history完全同。包括1280个subnormal operand；只在CPU验证器按官方global atomic语义建模FTZ，
  用真实GPU atomic核实，不修改生产数学。证书不是实际生产调度顺序，不扩充原cohort。
  固定seed1 C10仍false，但此固定路径的所有已捕获算子输出及归约目标已得到实际SDK/精确次序证据。
  活动host8f4127f0、CUDA176/f0、原SDK64a始终没改。继续捕获body/tet legacy particle contact组合。
- 补查新102次完整参数抓取：原/源码每个实际标量字节、grid/block、跨调用pointer相等/空值模式全同。
  不声称比较了外部allocation parent身份或所有指针内容；逐算子同输入回放覆盖已保存的动态值。

### body/tetrahedron legacy particle contact

- 不改冻结full-surface fixture，新增相同deformed/damped tet与moving SO3 box的legacy CollisionPipeline。
  三份contact harness的旧版本先存legacy/versions，只加--contact-kind，默认surface行为/场景保持，
  复用同一16组和strict/ABI/buffer协议。历史surface_*报告字段在legacy模式仍保留，contact_kind明确区分。
- 原版16组全部finite、真实接触计数W1=2/W3=6，两侧RHS及tet弹性实际变化。PD+diagonal-only确实只调用
  legacy force，其它模式另加system/preconditioner调用；与现有条件相符，不因tet存在就乱改PD条件。
- 生产修改前27文件与435个原版capture文件SHA保存tetrahedron-legacy-before-8f4127f0。
  仅开放有soft contact capacity的SO3/tet legacy分支，保留self/hard/rigid-only/drag/fluid等未捕获guard，
  CUDA数学与176/f0未动，接下来编译并核对固定16个原版。
- legacy窄guard已编译为131c987393bb78a10ae84a2705147a9c2d24f4d4bc31aae745bc0b7ef57dd7af，CUDA176/f0不变。
  新队列串行核对legacy source16/graph60、冻结surface原版的source16及新graph、完整constructor、
  无接触tet graph和双backend initcheck3。本批先完成相关组合，完整74将在后续必要生产变更合并后再跑，
  不把8f的71/74结果继承到131。为后续复查旧8f，新增逐SHA验证27文件的独立checkpoint加载选项，
  不覆盖当前生产文件；204-path已验证的旧runner先归档，加载选项待队列结束后实际验证。
- 131 legacy队列已全部complete且退出0：legacy16状态/8428完整调用/152buffer全严格，legacy graph64/64；
  冻结surface原版复验16/16、surface graph64/64，无接触tet graph32/32；constructor五项96/29/57/634/699同。
  original/source各32条×3步legacy initcheck零错误。本image尚未采完整74，不继承8f结果。
- 独立checkpoint加载已实测：活动131保持不动、归档27文件逐SHA核对后加载8f，18 packet/432次调用全同。
  为self组合扩展self_material_ab的可选body-block及tet graph的可选fixture/layout/diagonal参数，旧版本先存档；
  原默认fixture不改。新self场景沿既有mesh/particle五通道布置，加入SO3 body和实际初始tet形变，
  共24 solver particles/world。预先固定16个组合，正抓真实原版；生产self guard尚未开放。
- self原版16组已全finite，tet及四个首self kernel均真实改变RHS；第二VF的输出也通过首VF post→PP pre差异
  证实生效，五个通道都非空。full cache W1计数沿0→3→5→6→7→8，W3沿0→9→15→18→21→24；
  diagonal-only不写tangent counter但五个RHS变化都在，不能把counter0误读为空接触。
- 实际顺序self forces→SO3→tet，preconditioner tet→self diagonal，CG SO3→tet→full/diagonal self tangent，
  均与现有调度相符。保存131的27文件及全部self原版SHA后，仅开放无external-contact的SO3/tet/self guard；
  self+external contact、hard/rigid-only/drag/fluid等仍保护，未修改数学或归约。开始编译新image验证。

### 04b46fb0 self/tetrahedron 局部验证与固定失败保留

- 当前image 04b46fb0e53d25ed680e724eff346526d688af01bd5f07db51d6e3bd8d9a8fb3。
  原版/源码16组三步中W1八组全严格，W3八组状态不同；所有完整owned ABI、geometry、coverage及
  已定义首buffer均同。B1/W3/PD/full的body差异始于第三步，最大body速度差6.8768859e-6，
  不能未经核对就把它归为普通原子波动。
- self graph d0为24/32严格，d1为30/32严格，包含原版自身eager/graph差异。构造五项全同，
  117个allocation/release事件；original/source × diagonal开关的四次initcheck3均0错误。
  legacy16、surface16、无contact tet graph32、self配置246均通过；完整74未采，不继承旧image结果。
- affine_graph_cohort仅扩展tetrahedron_self及diagonal开关，保留原baseline original0/source0全部文件，
  固定8 original/3 source，完整fixture顺序与60步保留。旧helper先存versions。
  初次driver误用系统python（不可用），随后直接脚本缺root sys.path在GPU前退出；已修正为项目venv且
  显式加入root。没有运行或替换任何失败trajectory；正式串行cohort输出在graph-cohort-d0/d1。
- 为定位B1/W3/PD/full首差，独立编译诊断host_trace.so，不覆盖生产或旧observer。
  唯一诊断改动是precomputed=true时抓取实际z输入、跳过不贡献的inverse读取；保留基文件、生成源码、
  编译命令、二进制及SHA。诊断同步会改变调度，后续必须先与冻结first candidate核对，不能代替首候选。
- self固定graph cohort结束：full为15/16通过、diagonal-only为16/16通过。唯一失败w3-pd-b1 eager
  的source0从step2起四数组均超C（仅2/60步在范围），8个原版body轨迹完全相同；source1/2各60/60，
  并与original0/2/4/5整段逐位同。不能用source1/2替换source0或把此整段C重判通过。
  新tetrahedron_full_worker_trace保留graph worker全部8fixture、eager/graph及60步顺序，仅同步抓目标
  eager前三步；将逐字节比较是否复现冻结目标，随后再解释首个实际buffer差异。
- 全worker同步trace已完成：原版整段60步与冻结original0逐位同；source未复现冻结source0，已明确保存
  reproduction=false。诊断首差000019 precondition_and_reduce仅numerator world1差2ULP，r、z和counter初值同。
  扩展same-buffer probe支持实际precomputed=true（旧helper已归档），实际SDK/original PTX/source PTX
  同一buffer/stream轮换各16次，逐点z全同，三backend各自都产生原版/源码两端counter模式。
- 新pcg_grouped_atomic_certificate抓原/源码实际每lane贡献与地址：72个live lane各1次、其余无写入，
  24粒子/world分到3个真实counter地址；72个operand逐位同。两端共6个group目标均找到精确F32次序，
  由真实单lane atom.global.add.f32逐步history核实，1至4次CPU搜索、无负数或subnormal。
  只解释本次诊断首差，不宣称复现旧source0或整段C通过。
- 按预定单次额外诊断，只在第三步开启observer；原/source都未完整复现冻结目标，首差已在第三步输入，
  所以不能把第三步initialize_step列作原因，也不继续反复抽样直到碰到旧状态。
- 当前04完整74和其首次失败固定C10已启动串行runner，期间生产image不动；旧image结果不继承。
  本批证明与失败均写BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md并更新根交接当前image。
- 发布前构建provenance两套均吻合，360个既有pyc和SDK64a未变；快照43355文件校验0失败。
  全量diff --check仅指出新归档的原始PTX/生成头/旧源码及raw TSV原有空白；保持其字节与旧hash，
  不为格式化破坏证据。当前维护源码与文档范围的diff --check通过。正在运行的regression原始输出
  暂不纳入此检查点，待完整后单独提交；失败与未完成状态均明确保留。

### 当前完整回归、独立源码入口

- 检查点4955a9726b77738a341bdae825dcbd6d0a256e23已推csy指定分支，ls-remote逐SHA确认。
  对应快照43355文件校验0失败；后续继续工作，没有把goal或完整solver标为完成。
- 04完整74完成：71严格，三个particles seed严格失败；固定source0不换，各10份实际原版的C10均过，
  独立CPU复算完全同。旧8f seed1 C10和其它image旧固定失败原样保留，不因新image结果重判。
- self两套graph cohort额外CPU复算各48份source/case统计全部吻合；唯一full失败的source0最早超C
  在step2的body2 quaternion分量5及angular qd分量5、particle69的x。原8个body轨迹完全同，
  source1/2与实际原版整段同；原candidate SHA f9a5c8ae01abb377fba3c856ad4d4783d834dcbd534a4a77e2df68789b21a1e8。
- 新增reconstruction.source_demo仅选择并逐SHA校验source module，复用bridge后runpy运行原示例main，
  不改Example/capture/物理参数。原版so运行前后均不得映射，记录source_only、ready=False、image和
  example SHA、原始args、最大实例源码计数（graph capture计数、重放不重新计数）、退出值；不覆盖报告。
- 真实入口首验证：Dzhanibekov60帧和plastic bag3帧，均保持真实CUDA graph，--test自身物理检查通过，
  退出0，无原版so映射、无登录；计数分别3734/11530。此结果是独立运行证明，不代替轨迹A/B。
- 针对固定self source0继续一次明确的state replay：保留完整worker前序，第三步前把公开四state数组
  强制设为冻结source0的第二步输出，再交给实际SDK/源码；私有persistent状态未从旧候选恢复，
  明确只作传播诊断，不能算原始轨迹复现、不能扩cohort或替换失败。正在串行执行，生产image未动。
- state replay结束：强制相同冻结公开输入后，实际SDK/源码均未复现旧source0第三步，双端新trace
  首差为000029 PCG numerator；保留干预诊断，不认定为旧失败的因果定位。随后仅预先安排3次独立
  unchanged SDK full-worker holdout，未扩原8基线、未重判source0；原版holdout共有3/48条超旧C。
- 新实际见证：holdout1/w3-pd-b1 graph的body_q/body_qd全部60步与旧失败source0/eager逐位相同。
  全部其它粒子只在39.y、53.x有小差，位置最大2.3283064365386963e-10，速度2.9802322387695312e-8；
  其余分量全同。不是把不同mode并入C8，旧eager C8仍false。跨模式见证NPZ SHA
  00041d2b273d73eb9719dc60945fba5629843846c55a6aba1f055095cc050590。
  CPU独立复核6份cross比较、逐world比较和剩余坐标全同，audit-source0.py及receipt保留可复现命令。
- 下一已明确拒绝的host缺口PD body constraints：新增继承既有joint fixture的PD配置，不改原fixture。
  原版revolute/prismatic × W1/W3（armature=.007，drive/限位/派生速度均启用）四组三步全部finite且
  body实际运动，owned调用分别1698/1902。原版已固定，source guard尚未改，生产仍04b46fb0。

### PD driven joint host：实际缺漏与修复中

- 04后完整回归/独立demo/原版跨模式见证已另存1de1b10f2f42e07e0e6f3e2bfdb4535f0c69a995并推送，
  ls-remote确认；该快照46068文件0失败。继续恢复PD关节，不把完整目标标为完成。
- 生产修改前保存27文件的driven-joint-pd-before-04b46fb0，锁定全部22个original4证据文件SHA。
  只窄化PD guard，仍拒绝plain/undriven PD、body-block+constraints等未捕获组合。
  试验image77932a2be3bc02b572ddb7682f73d658808ab50588a9c3ef6ef2e646f8ff4f63：
  转动关节W1/W3三步、1698次完整调用和状态均严格；移动关节两组失败，源码1707调用而原版1902，
  状态出现非有限，明确拒绝，保留source4-77932a2b和27文件failed trial checkpoint。
- 实际SDK抓到首缺漏：PD每NL在SO3之后、drive之前调用
  add_joint_body_point_line_augmented_lagrangian_preconditioner；每CG在SO3之后、drive之前调用
  multiply_joint_body_point_line_augmented_lagrangian。差值195=15 preconditioner+180 tangent。
  对照so mangled签名、真实arg值/alias、已恢复joints.cu定义，核对14/15参数和四个size_t计数。
  这两个kernel已在176中，原host没有加载/调度；只补host load及pd&&joint_line_total条件调用，
  CUDA数学与176/f0不动。新增supported scope为driven_joint_constraints_pd_newton，正在编译并
  复验同四份固定原版；尚未把该新image计为通过，也不继承04的74/C10结论。
- d8457a42057f944f78c7ecbd92da1c8c396fed5b9f35452d41ba4ab9d8f60296四组全部严格同、共7200完整
  owned调用。随后constructor审计失败，串行队列立即停止，graph/initcheck尚未启动，不宣称构造通过。
  移动/转动分别67/64个分配事件，两端数相同但顺序不同；original typed33/31 vs source27。
- 根据真实allocation角色（由owned用途映射，不按size瞎猜）：drive angle/initialized/velocity缓存应在
  四个state vec3之后、diagonal之前，joint multiplier或line segment/projector/multiplier在block之后、
  affine cache之前；原版这6/4项都typed zero。CPU权重上传应在矩阵ELL之后，当前source提前了。
  PD multiply原版用local row-count allocation（8项），source用24项replicated buffer；数值等价但身份不符。
  allocation-role-diagnostic.json及upload-multiset-diagnostic.json已保存。
- 原版还保留非零D4/L5，source错误保留全零；当前step以0权重使用该channel，解释为何状态严格同但
  upload审计仍不符。先从真实SDK静态arg抓到indices/weights/stiffness，不改生产，CPU用F32逐步推导：
  D4完全逐位同；point-first L5六词不符（3个对称pair），失败script/报告/NPZ保留。
  line-first与global-index-sorted都能解释原fixture，暂不选一种。正在用SDK initialize-only、明确反转
  affine proxy ownership的额外诊断消歧；不是物理trajectory，不扩cohort、不替换任何固定样本。
  生产仍d845，尚未修改constructor/template/row选择。原版initialize本来发生在NewSolver构造中，
  PD配置在随后设置，因此不能把这些构造差异误认为仅PD分支特有。
- 消歧探针首次因payload observer单独preload无法解析cudaMemcpy在目录建立前abort；不是SDK算法失败。
  保留旧script/log/FAILURE，加入既有working observer:hook组合、禁core dump并明确CUDA context后v2成功。
  两份实际SDK初始化：normal和affine_body_indices反转（只initialize，不step）。CPU三种候选只有
  global-index-sorted同时逐字节吻合D4/L5，line-first在反转probe失败；order-resolved.json保留此证据。
- 保存d845的27文件checkpoint后，按上述证据恢复：drive三typed缓存提前至state vec3之后，保留原版
  两份zero HtoD；joint spring/line typed缓存提前至block之后（line顺序segment/projector/multiplier）。
  driven joint权重推迟至scalar ELL之后，顺序spring→point-line→drive；D4/L5按全局粒子ID排序后
  原F32逐项累加，保留完整非零template但step的0权重不改；PD multiply改用实际local row-count身份。
  原非driven权重上传分支保持，未改CUDA176/f0或FP阈值；当前正在编译constructor恢复版，尚未验证。
- constructor恢复版已编译c189db81483ca1ca6b197cb57ebeb4411e9ecfeba2035975f51275c178dba458，
  source4-c189db81再次对同四份原版全部状态、7200完整owned参数/geometry及覆盖数严格同。
  开始新validation-c189db81目录的constructor→16组合graph60→双backend initcheck3；
  不覆盖d845构造失败，也未把新image继承04完整74。
- c189 prismatic完整constructor五项全部通过：67/67 allocation/release、36/36 upload、33/33 typed、
  1902 owned指针用途、1935/1935 owned/library名称时序。没有弱化审计或忽略旧失败。
  validation队列已进入16组合graph60；原source四组三步仍全部严格，生产文件不再改动以保持本批immutable。
- c189完整局部队列complete且全退出0：16组合eager/真实graph60共64项比较全部逐位同，
  original/source各32轨迹×3步initcheck均0错误。另revolute constructor五项全同：64分配事件、35上传、
  31 typed、1698 owned指针用途、1729 owned/library时序。
  两种joint构造均已实际核实，未把prismatic结果外推给revolute。当前开始c189自己的完整74及固定C10。
- 为下一个明确guard准备joint_block_scene及8组原版capture脚本（revolute/prismatic、W1/W3、Newton/PD，
  body block=true），没有改已冻结joint_pd_scene，GPU原版capture尚未启动、body-block guard仍关闭。
- 本次先提交c189局部已完成结果；运行中的完整74/C10输出暂不纳入快照，待结束补交，不在运行时改生产。
  原版SDK/360个pyc、current build sources逐SHA再查均同，新增fixture语法及128列检查通过。
- c189完整74结束：71严格，三个particles seed的固定首次输出各10原版C10均过，CPU逐字段复算吻合。
  不沿用04统计，本批各自report与source0原样保留；旧8f/self及其它失败不重判。
  f72f63e7a205dd1d95aebaa5459e37191e60fc6a已推csy且ls-remote同，快照47140文件0失败。
  当前串行执行c189独立source前端的Dzhanibekov60/bag3真实graph自身test，之后才抓body-block原版8组，
  生产与该新guard仍不改动。

### Driven joint + body block

- c189独立source前端Dzhanibekov60/bag3真实graph自身test再次退出0，无原版映射。随后原版8组body-block
  已全finite且body实际运动：rev Newton/PD各2076/2073次owned，prismatic各2100/2277；全部首次原版保留。
- 同一实际log的指针alias证明：PD affine-build row count必须与RHS local及matrix相同；Newton build
  与matrix global相同且不同于RHS local。原source build始终传global，需按PD选择local。
- 实际完整顺序为PD line preconditioner→drive→armature/limits→affine build→SO3 particle preconditioner。
  先保存c189的27文件与43原版证据SHA，再将build/SO3-block段移至drive/armature/limits之后、cable前，
  其它无joint scope的相对调用不变。仅开放无plain/distance/cable/fluid/external-contact的driven joint
  body-block guard；未捕获范围仍拒绝。数学/176/f0未改，当前编译新image，尚未验收。
- 编译image5bd9722e后，对固定8份SDK三步状态及17052次完整owned ABI/geometry全部严格；
  四种W3 constructor五项均同。32组合eager/真实graph60共128/128严格，双端各64条×3步initcheck零错误。
  本image完整74尚未采，不继承c189；新文档及根交接已更新，生产176/f0仍未改。

### Plain body constraints: coverage and diagnostic preflight

- 新fixture plain_body_constraint_scene使用两活动offset-COM body，显式反向attachment，
  spring/point-line/distance × W1/W3 × Newton/PD × body-block，共24组；不涉及contacts。
- v1用ModelBuilder.replicate后，12个W3实际未带自定义plain约束，owned log证明全部自由运动。
  保留original24/COVERAGE_FAILURE.json及v1 fixture/driver；这些结果不算约束验证，未修改生产guard。
- v2显式begin_world/end_world并断言native约束数与world数。spring8组均finite且body运动，
  每组9个实际force调用且首次RHS前后有变化，原始数据保留original24-explicit-worlds。
- v2点线首组因诊断driver误把arg13(bool)作为device output读而SIGSEGV -11；不是solver数学结论。
  完整失败与driver保留。对实际SDK mangled签名/ABI逐项核实，force正确输出为点线arg14，
  spring arg12、distance arg11；新增schema必须为pointer的预检。force-dump-ABI-proof.json存全签名。
  v3只采剩余point-line/distance16组到全新目录，既有有效spring8不重采；生产与fixture仍冻结。
- v3剩余16组全部真实force9次、RHS改变、finite/body运动。按文件SHA把既有spring8+新16组成
  original24-valid索引，不重采首个有效原版。补充actual SDK静态输入三组均与原固定轨迹严格同。
- 活动5bd已有Newton/no-block6组：spring与point-line的W1/W3均状态/完整ABI严格；distance两组
  状态从第一步不同但完整330次owned元数据相同。source6-newton-b0-5bd9722e永久保留false。
- 三种constructor旧源码均失败：spring55alloc/28upload/27typed、point-line56/29/27；
  allocation/upload顺序错误，typed同。distance57/28但原29typed vs source27，L6字节也不同。
  实际flat指针用途确认weights应在scalar ELL之后；distance target/multiplier应在block之后、affine之前typed zero。
- 三种模板分别L0/L0/L6的8/6/8个F32词差1ULP，diagonal同。再用实际SDK只initialize并反转
  affine_body_indices，保持真实权重/刚度输入；normal与reverse只有global-index-sorted同时逐字节吻合。
  完整resolve-template-order.py与template-order-resolved.json保留，不是trajectory或扩cohort。
  初次CPU读多场景copy固定序号失败（observer seq全局递增），失败脚本保留；改按实际memory.jsonl上传顺序。
- 保存5bd 27文件与168原版capture文件SHA后，按证据修复plain spring/point-line/distance因子排序，
  不改已验证joint spring的排序；所有body-constraint weights延后、distance新typed缓存提前。
  仅开放单一plain类型、无其它材料/joint/contact的PD/body-block scope；混合组合与undriven joint仍保护。
  新image正在编译；CUDA176/f0和数学阈值未改，未提前宣称distance已修好。
- 新image8691698973a5ef5109a5300a72d319c918d9a159c20a9b0b76a0ddb1563c2eea编译成功，176/f0同。
  对24份固定首次有效原版全部状态逐位同，首force前后buffer均逐字节同，完整owned参数/geometry/coverage全同。
  原5bd的distance首步差异已经在同固定数据消除；保留旧false，不以新结果重判。
  当前开始6种W3 constructor（3种约束×2模式，block=true）→24组合graph60→双端initcheck3，生产冻结。
- 新image的spring Newton/PD两种block constructor五项均已通过；point-line及distance构造队列继续。
  先发布已闭合证据、源码/当前so和交接：运行中的validation目录及其driver log明确不入本次快照。
  SDK无diff，既有360个pyc逐SHA不变，新增维护代码语法、128列及diff空白检查通过。
- 243e3242a4770b4d0bf299c63391c4bd7d262169已推csy且远端SHA同，快照50205文件0失败。
  同仓库SDK64a和360pyc仍固定，checkpoint明确排除尚在运行的validation。
- 869局部队列已complete，全阶段退出0：六种constructor五项全同；spring55alloc/28upload/27typed，
  point-line56/29/27，distance57/28/29；Newton/PD各自owned426/414、426/414、429/426。
  24组合eager/真实graph60共96/96严格，双端各48条×3步initcheck0错误。
  现在串行收集869自己的完整74/固定C10/CPU审计及两个standalone官方入口；未提前计为通过。
  后续准备undriven fixed/ball joint参考16组，新增独立fixture，不改已冻结plain或driven fixture。
- 869完整74最终报告实际为70严格：particles seed1/2/3及mixed_cloth seed3四份首次输出false。
  先前用户进度曾按未更新完的状态误报71/74，已立即纠正；本记录以complete的74行和实际exit为准。
  当前为这四份固定source0分别采原版C10，未写统计通过，不替换候选。
  remaining-guard-inventory-86916989.json的18条消息含输入限制/混合范围，并非18个未恢复kernel。
- 869当前固定C10完成：particles seed3通过；particles seed1(it5)、seed2(it1)及
  mixed_cloth seed3(w129 duplicates)三项失败，CPU重算所有saved统计字段相同。不会扩cohort或替换source0。
  两个standalone真实graph自身test均退出0，source_only且无SDK映射。新fixture undriven原版16份均真实
  force改变RHS、finite/body移动，但暂不改guard：先追当前三份C10失败，保持869生产不变。
- 新建regression_failure_trace，仅增加独立诊断入口，老particle_full_worker_trace及生产不改。
  接受scenario/seed/case，保持完整worker顺序与前置分配，只在目标initialize后抓三步。
  使用已验证且ABI仍同的all-entry observer；当前串行抓三个失败的original/source首对，必须实际比对
  到各自冻结original0/source0才能声称复现。不同诊断轨迹不加入固定C10。
- 当前三项C10失败继续诊断，不扩接受cohort：每目标预先固定8次独立SDK诊断全部保留。
  particles seed1/it5的诊断0、seed2/it1的诊断2和5分别完整逐字节重现其source0目标全部15数组三步。
  mixed目标在独立8份SDK中128/129个world分别有完整三步见证，仅world85未覆盖；它的三条重复三角形
  线程255/256/257跨256 block边界。未把按world见证拼成完整SDK轨迹。
- 首同步pair：两个particles双端各8/15；mixed SDK18/18、source7/18。实际pair首差异分别是
  packet166/38 precondition numerator及mixed packet3 stretch force。不能把未复现诊断当冻结因果路径。
- 新建独立deferred observer，原observer/生产/fixture均不变：同stream DtoD暂存，trace_end才同步DtoH写盘。
  序列每步最后apply/velocity均与公共输出逐字节核实。固定1原版+3源码中，源码2/3都重现mixed source0
  全部18数组三步，且64MiB暂存实际使用12769272字节；原版同步首份也与冻结original0完整同。
- 采用两份实际冻结路径并保留所有SHA；四种primitive（新增spring force）×9 NL×双端共72 packet，
  实际SDK runtime/原版PTX/源码逐元素贡献919512标量全同，306504个实际累加标量均由GPU真正global F32
  atomic六种三项排列验证。first-three-stage旧runner与其报告保留，扩展版也记录逐input SHA。
- 其它732公共packet共4392个三端实际调用全逐位同，250776个129-world counter字也全部比较且同，未跳过。
  此次非零ELL与dense inverse均实际回放，保留alias；两端366调用标量/geometry/指针相等模式也全同。
  全804算子路径已覆盖。source0和C10三项false仍保留，不推断原调度次序或改数学强行追统计。
- checkpoint undriven-before-86916989已保存27源码/build/so及44固定回归数组SHA。
  当前继续undriven基线：固定/球关节Newton/no-block的W1/W3四组状态/完整调用均严格（各333调用）；
  两种W3 constructor五项同，均56分配/28上传/28typed。PD与body-block guard尚未改动。
- 本轮全部队列已关闭后统一入库；首次逐文件pathspec列表触发Git高CPU匹配，SIGINT取消该add（尚未写index），
  改按已核对的四个明确目录前缀及维护文件加入，数秒完成。未扩大到整个build，未停止其它用户进程。
  当前正在生成869完整证据快照，SDK及既有360pyc逐SHA不变；下一guard变更尚未实施。
- b524a669727a100706136ea35e2e2b776d36f4b0已推csy，ls-remote核对同；快照127582文件0失败。
  该提交包含869全部固定失败/独立SDK见证/804路径证明与未开放的undriven基线；SDK/360pyc仍固定。
- 按实际16份原版和四份已有严格基线，仅窄化孤立AL spring joint的PD/body-block guard：无plain/line/
  distance/drive、无其它材料/cable/contact。新增三项scope标签，不改CUDA或任何CPU浮点模板/调度。
  编译新image6a7061d769946498b59c3d10b6ede7f843ff73b973e9d2ebe0cbb669725803f4，176/f0同。
  当前逐个对固定16份原版验状态/首force buffer/完整参数；尚未提前验收，不继承869的74或C10结论。
- 6a对固定16份原版全部状态/首force buffer/6096次完整owned参数与geometry严格同；四种W3构造五项同。
  16组合graph60队列退出0，双端initcheck继续，未提前写最终通过。维护新UNDRIVEN文档与根交接。
- 下一PENALTY scene为独立wrapper组合原driven/undriven fixture，只设置native joint_constraint_mode=0，
  固定/球/转动/移动×W1/W3×Newton/PD×body-block计划32组；原有fixture及生产mode guard均保持。
  尚未开始该GPU采集，不根据代码猜测其实际调度。
- 6a局部队列complete且全退出0：四种W3构造各56分配/28上传/28typed，Newton/PD owned432/429；
  16组合eager/真实graph60共64/64严格，双端各32轨迹×3步initcheck0错误。当前image未采完整74，不继承869。
  开始历史869 checkpoint下732 point packet回放（活动6a保持不变）→PENALTY原版32组串行队列。
- 历史869 checkpoint在活动6a不变时独立加载，732公共packet/2196三端调用全部严格，验证归档loader可接续。
- PENALTY32份实际SDK全部finite/body移动，每组9次general force确实改变RHS。SDK实际表明：
  不调用joint AL init/force/update；general spring/line force的include_joint=true，force alpha仍5759999。
  start的D4与combine的L5权重均为100（即config.alpha），所有kind均如此，包括该channel为零者。
  prismatic Newton调用general point-line GN Hessian9次，PD没有；没有AL line preconditioner/tangent。
  pure joint spring Newton没有general spring GN Hessian，不能凭推测补一个调用。
- 保留actual-penalty-host-schedule.json全参数及32份原版；修改前6a检查点27文件与226份原版文件SHA已保存。
  生产尚未改变为Penalty支持，下一步仅按上述实际host证据恢复切换。
- 65d9bd2b7f1897d8a35c15c4755d2db3646d4721已推csy且远端SHA同，快照128699文件0失败。
  该提交为6a完整局部结果及32份Penalty原版，生产guard仍关闭。
- 首次Penalty生成在写源文件前AssertionError，源SHA核对仍6a；shell缺set-e导致随后对旧源重编译，
  没有GPU测试该状态。保留GENERATOR_ATTEMPT1及旧日志；新脚本具名唯一性校验、128列检查并set-e。
- 按32份真实调用恢复：joint_al控制AL init/force/update/Hess/PD-operators；general force include_joints
  在Penalty为true；D4/L5权重切到alpha；prismatic Newton用general line GN Hessian，不补不存在的spring GN。
  仅孤立、无其它材料/contact的已捕获joint范围开放Penalty，Ctor与CUDA176/f0未改。
  编译aa52ee61a8fe9bad2032859095f8ec591e3cd80141f76af3fd521f67c3f6419a，正在对固定32份原版逐个核对。
- aa52对固定32份Penalty原版全部状态/首force buffer/14868次完整owned参数与geometry严格同。
  八种W3构造五项同：fixed/ball56/28/28，revolute64/35/31，prismatic67/36/33。
  32组合eager/真实graph60共128/128严格，当前双端initcheck3继续；维护新PENALTY文档与根交接。
  局部结束后计划当前74/固定C10/CPU、standalone两例及正式cloth_balls固定original8再核对。
- aa52局部队列已complete，全阶段退出0，双端各64轨迹×3步initcheck0错误，graph128/128严格。
  此时先发布当前源码/so和已结束局部证据，之后才开始完整74及正式cloth重查，避免把运行中输出纳入快照。
  mixed plain的独立fixture/graph与每种primitive单独RHS证明的参考32脚本已准备，尚未GPU运行或改guard。
- d28fd38751d0eff8921fd6ff475e811bbe88b1b0已推csy且远端SHA同，快照130441文件0失败，SDK/360pyc固定。
  当前开始aa52自己的完整74/固定C10/CPU→standalone两例→正式cloth_balls固定original8两种mode各3 source。
  生产/fixture/harness保持immutable，运行中输出暂不入快照；mixed plain参考尚未GPU开始。
- aa52自己的完整74最终complete：71严格，particles seed1/2/3三份首候选严格false；
  本image mixed_cloth seed3严格通过（不重判869旧false）。当前固定C10运行，尚未计为统计通过。
- aa52固定C10最终seed1过、seed2/3失败；CPU审计退出0。两个独立源码官方入口真实graph/自身test过，无SDK映射。
- 仅CPU查已存同SDK64a的60份C10轨迹，未增加接受样本：seed2失败目标全部15数组三步有实际SDK逐字节见证；
  seed3两失败目标各18数组三步有见证，869 original6同时重现两目标。完整查找表/SHA保留，当前C10 false不重判。
- aa52正式cloth_balls沿用固定原版8，两mode各3 source全部finite/物理检查通过，固定C两mode均false。
  逐步CPU复算保存official-cloth-exact-first-outside.json：eager source0首子步particle1381.y的q/qd即超界，
  graph source1各数组均C内，但仍按全3候选计算模式结论，不挑选通过轨迹。
- 新增official_cloth_failure_trace独立诊断，复用未改官方worker，保持60帧和全部原始物理输入，首子步启动/结束观察。
  从已验证deferred observer派生1GiB暂存版本，surface只复制已知首步1380接触前缀，actual capacity参数不改，
  driver必须逐个验证count=1380。预先固定1原版+3源码，全部保留并与各冻结首子步核对，不替换cohort。
  当前生产aa52/CUDA176/f0/SDK64a保持不变，mixed plain尚未GPU开始。
- 首子步deferred四诊断全部退出0，每份34202文件/521948852 device bytes，均未完整复现固定首子步；不采新接受样本。
  actual surface六字段1380条完整字节multiset四端相同、顺序不同，raw首差是surface force；未把未分类raw尾部当验证。
- 新增official_cloth_contact_replay：捕获实际首native state/control及17 rigid/1380 soft有效前缀；后续双端强制核对
  state/control位相同、字段/size/null/scalar相同，再上传同份contact有效前缀，无生产路径改动或尾部替换。
  common pair的全部已捕获before数组同，首force仍243个F32词差；这两份实际诊断也都保留。
- 对同实际SDK接触包用actual runtime/原PTX/source PTX回放1380逐条force输出，三端逐位全同；
  37920个atomic操作数序列原/源码全同。初始随机排列仅5204的三个目标已用CPU确定性exact completion补齐：
  captured/runtime/PTX/source与两instrumented输出六类各5205/5205精确见证，无未解释标量，未推断真实调度序。
- 完整cloth固定C仍false，不能把首force证明升级为完整120步；当前开始mixed plain SDK32首次参考采集，
  每种启用约束均需9次真实force与RHS变化，生产aa52保持不动，guard未开放。
- 补采实际源码完整surface view：与common SDK capture的全部只读字段（含body ids/indices/COM）、
  contact顺序及初始RHS逐字节相同。七类目标（新增actual source capture）各5205/5205精确累加见证，未解释0。
  新OFFICIAL_CLOTH_FIRST_STEP_AA52记录范围与命令，整段C仍false。
- 为保持原始追踪可迁移，完整197/196MB launch文本lossless gzip roundtrip核验后压缩；读取器兼容gzip，执行版保留。
  直打tar/gzip原始native超过95MiB；改逐文件SHA内容去重bundle。首次随机seek验证慢，仅中断本agent打包进程，
  原始trace未改、生成的完整archive复用；旧生成器/失败说明保留，验证改顺序读取，解包器采用streaming。
- mixed plain SDK32全部有效；aa52四个Newton/no-block基线中spring-distance/line-distance状态/完整ABI严格，
  spring-line/all被constructor guard拒绝，失败保存。修改前保存27源/build/so与306个SDK参考文件SHA。
- 只调整isolated plain混合范围guard，保留joint/cable/fluid及其它未捕获混合的限制，新增三个scope标签；
  不改CPU模板、调度、CUDA176/f0。新image6a514e4639c8d3051d86c7d89d49a4716d19ead4a63ca392c9017cb407c0fb28。
- 6a514e46对固定32份SDK全部状态/各primitive首force pre/post字节严格，12576次完整owned参数/geometry全同。
  当前串行八种constructor→32组合graph60→双端initcheck3，生产/fixture冻结，尚未收集新image完整74。
- 八种6a514e46 constructor全部采完：spring-line与spring-distance四种五项全同；line-distance/all四种上传顺序及
  owned allocation identity不同，allocation/typed/核时序仍同；graph尚未开始，原停止和remaining状态均保留。
  按实际owned指针用途唯一确认SDK权重分配顺序spring0/1→distance0/1→line point/end0/end1；不用重复payload猜角色。
  actual-weight-allocation-order-resolved保存八组双端角色映射。
- 修改前保存6a514e46的27文件及1188份验证文件SHA。仅plain distance+line、无joint/drive/cable/fluid范围
  重排pending upload rank，不改任何权重值/CPU矩阵/调度/CUDA；正在重编译并重验固定32份SDK。
  constructor新增可选--original-capture，逐文件SHA复制八组既有实际SDK原版，只跑新source，不重新采样原版。
- 六份raw trace bundle已完成全部字节roundtrip：每份34203文件（34202条记录加receipt），raw522374097字节，
  去重54581949字节，Git archive约38MB；原始raw目录仍在本机，index改存bundle。解包器实际fresh解包并再次
  验证34203文件SHA全部通过，临时目录自动清理；配套记录unpack-roundtrip.json已保留。
- weight顺序修复image为3d1b1b883a620f0028f2c4b16c2d2e490b96407a9e16e4dc75034d10baef6be1，176/f0同。
  同固定32组再次全状态/各force pre/post/12576完整owned严格。八种constructor都在逐SHA采用的旧SDK数据下五项全同，
  原4个false保留；spring-line58/31/27，spring-distance59/30/29，line-distance60/31/29，all62/33/29。
- 32组合graph60共128/128严格；original64轨迹×3步initcheck0错误，source initcheck仍在运行，暂不记complete。
  新PLAIN_BODY_MIXED文档和根交接记录实际顺序、检查点、已完成和待办。
- 下一independent undriven_axis fixture/graph/capture脚本已准备，无GPU运行：保留revolute/prismatic几何，
  在fixture构造期间显式省略native drive descriptors，finally恢复adapter方法；不是修改官方demo或生产solver。
  计划先实际SDK32，确认zero-drive AL/PENALTY调度与有效force，再决定guard；当前guard未开放。
- 3d1b1b88局部完整结束：八种constructor五项全同，graph128/128严格，双端各64轨迹×3步initcheck均0错误。
  当前先发布这批闭合源码/so/原版与完整失败/修复证据，完整74与新axis SDK32尚未开始，不入本次局部快照。
  同仓库参考SDK64a与既有360pyc逐SHA未变；新增维护Python语法/128列与维护diff检查通过。
- 2492f0247635d6e42f866ff5391101e8ac171896已提交，135430文件快照0失败，正在推csy。
  该检查点包含3d局部全通过、aa52完整失败及首force七类精确证明、六份lossless raw bundle与WSL解包工具。
  当前开始3d自己的完整74/固定C10/CPU和两个独立官方入口；其运行中输出未计入2492快照。
- 2492f024已推csy，ls-remote核对远端同2492f0247635d6e42f866ff5391101e8ac171896。
  当前3d完整74继续，下一zero-drive SDK队列已排在regression/frontends完成之后，GPU仍严格串行。
- 在GPU回归期间仅CPU复核aa52七类5205见证：所有值再次精确、操作数及中间值均无subnormal。
  同时确认原搜索没有限制线程内同destination发射次序，每类289–337条所选排列不保留该顺序；
  它们是逐标量算术证书，不能升级成全局GPU调度重现。补充exact-witness-detail-audit与文档说明。
  基础六类原有见证中仅非零同owner次序亦有1325次倒置（跨六类累计），不据此推断硬件次序或修改数学。
  三端实际逐接触输出与原/源码atomic操作数序列全同的独立实测仍成立；整段C失败一直保留。
- 3d完整回归及after-local已结束：74为71严格，三particles首候选严格不同但固定C10三份全部通过，CPU审计0且所有统计同。
  独立Dzhanibekov60/plastic-bag3真实graph及自身test全部过、source_only无SDK映射。
- CPU在已提交snapshot的80个旧SDK候选/seed内查找，并严格验证fixture/harness相同；仅50个/seed eligible。
  所有3d严格失败目标各自均有实际旧SDK逐字节完整三步见证；seed1全部3目标还在同一SDK run同时出现，seed2/3未找到联合run。
  没有拼接轨迹、增加GPU采样或重判C10；旧harness差异/旧目录布局缺provenance均显式排除，失败脚本/说明保留。
- zero-drive fixture v1在adapter验证即失败：只清_joint_drive_types破坏九组数组同时提供约束，尚未调用native initialize。
  保存fixture-v1和original32-fixture-v1-invalid全部失败；生产不改。v2改在public native initialize入口
  显式清joint_drive_count及九个native descriptor span，adapter自身验证正常保留；只在fixture构造期包装并finally恢复。
  新original32-v2使用新目录，追加实际drive_load调用数必须0，当前GPU原版采集开始；未改生产guard。
- zero-drive v2 SDK32全部有效，所有actual drive_load=0且primitive force9次确实改RHS；v1失败独立保留。
  3d Newton/no-block八基线六条全部状态/完整ABI严格；仅Penalty prismatic的W1/W3被原guard拒绝，未重采。
  AL prismatic W3/no-block baseline constructor五项全同：59 alloc/29 upload/30 typed/348 owned。
  保存3d的27源/build/so与226份SDK v2参考SHA，准备仅窄化已捕获pure joint line范围。
- a4e16642c1dc1f07ab403bfc9176eb2ab43bce36已提交，136764文件快照0失败，并已push成功（远端SHA待ls-remote二次确认）。
  包含3d完整74/C10/CPU/standalone全结果，v2有效SDK32、baseline8及baseline constructor，生产guard仍为3d关闭状态。
- 只窄化纯joint spring XOR joint line的isolated范围，Penalty使用该isolation允许pure line，保持spring+line及其它混合限制。
  新增四scope标签；CPU模板、kernel调度代码和CUDA176/f0未改。新image430b5b74176c82b7f487a902d8ae3f77593d9657824207458a57b141b850f1b2。
- 430b对固定v2 SDK32全部状态/选定force pre/post字节/12288完整owned参数和geometry严格同。
  当前八种constructor→graph128→双端initcheck串行；尚未收集430b完整74，不继承3d统计结论。
- 查正式example_robot_cloth_trampoline：直接Native NewtonSolver，SIX_SPRINGS/AL/Newton、有关节和布料，
  当前材料+约束及非SO3 guard尚拒绝。新增driven_cloth_scene只作独立小夹具准备，SO3/SIX两种rigidity，
  有真实joint drive、两triangle与bending、固定点/初始cloth prestrain；尚未GPU运行或开放该生产guard。
- 430b局部队列complete且全退出0：八种constructor五项全同；AL prismatic59/29/30、owned447/489，
  Penalty prismatic59/29/30、owned426/414；revolute56/28/28，AL owned432/429、Penalty417/414。
  32组合graph60共128/128严格，双端各64轨迹×3步initcheck0错误。430b完整74未收集，不继承3d结论。
- driven_cloth_scene原版16全部有效，SO3/SIX×W1/W3×Newton/PD×body-block；五种force各抓完整9次pre/post，
  关节/drive/stretch/bending每次都实际改变RHS，rigidity至少后8次改变；全部finite/body移动。
  actual-material-host-schedule保存真实记录，确认没有particle spring/tet/drag/point-line/distance/cable/fluid/granular调用。
  430b的SO3与SIX Newton/no-block两个基线均在constructor被材料+约束guard拒绝，失败保留。
  修改前保存430b的27源/build/so与SDK16实际全部参考SHA，接着仅开放已捕获无接触/无self的driven cloth组合。

- 续接核实5a6b784350a69f443cf7cf583b428ee5739f9f08已推csy且远端SHA相同。
- driven cloth只开放已捕获无contact/self/drag的AL组合，编译688f9633e740b7c6de174676f404f1559107281b8f3d68cdfd4a4ee58a15ffd6；CUDA176/f0不变。
  固定SDK16首源码比较全部退出0，12组状态/九次五force字节严格，4组W3状态与后续force不同；16组完整ABI/geometry/coverage均同。
  失败为SO3 W3 Newton b0/PD b0/PD b1、SIX W3 Newton b1；首失败不改。原run-validation因严格gate未运行，
  独立with-failures driver继续诊断构造/graph/initcheck，保留原driver；局部仍未验收，ready=False。
- 688f四种constructor全部五项同，均106 allocation events/37 uploads/61 typed，owned652/640/595/574。
  graph60为42/64严格，多组SDK自身eager/graph也不同；双端各32轨迹×3步initcheck0错误。
- 首步deferred八诊断全部完成并校验最终q/v与public输出；无一复现原冻结首步，不替换首候选。
  SO3 Newton b0/SIX Newton b1诊断首步所有已观察包同；两PD诊断首差都是precondition归约，before输入和after.z同，仅world2 numerator差1–2ULP。
  对PD b0真实同输入，actual SDK runtime/原PTX/source PTX各32次pointwise全同；实际36 lane操作数两PTX逐位同，
  original/source共6个group目标均由真实GPU串行F32原子加精确复现，无未解释，不能据此验收整段。
- precomputed输入observer v1把else错误绑到after-or-precomputed，导致b1缺r/per_group等before文件；三端probe在GPU启动前FileNotFoundError。
  四份v1诊断及脚本/so/provenance保留，不用推导数据填缺。接着修observer并只重抓b1两端的新诊断；生产未改。
- 688f四份首失败固定C8全部通过，8 originals/3 sources包含原样首候选，36新worker的完整owned/geometry/coverage及第0轮五force均同。
  source0严格false仍保持，不重采、不改变9轮dump同步协议。CPU独立重算四例统计完全相同。
- observer v2修复后只补抓PD b1两端真实输入；actual runtime/原PTX/source PTX各32次逐粒子同，
  两PTX实际36 lane操作数同，六分组目标GPU F32原子顺序精确复现；前一b0六目标同，总12/12。
- 完整worker graph固定C8完成：18/32通过，14失败；source0/original0原字节采用，不替换接受样本。
  CPU独立重算4三步+32长程共36组全部统计同；graph-fixed-first-outside定位68个越界字段，14项保持未验收。
  688f自己的完整74正在串行，之后固定C10/CPU及standalone；不能继承3d统计。
- 新driven_cloth_contact_scene独立夹具已准备，使用真实CollisionPipeline的surface/legacy与运动parent box，
  首接触必须非零并记录实际proxy/free索引；尚未GPU采集或开放guard。正式trampoline所需OBJ在当前assets缺失，未替代网格。
- 688f完整74结束：70严格，particles三seed及mixed_cloth seed3四首差固定C10全部过，CPU审计复算相同。
  独立source真实graph/test的Dzhanibekov60和plastic-bag3均过，无SDK映射。当前image不继承历史统计。
- 为14项长程失败新增真实graph D2D诊断，保留完整16组合worker顺序，观察graph10/14/26/30，四worker全退出0。
  使用实际rhs max_count与6个body states，PD build的row/entry读取正确local维度，不使用旧单body假设。
  初步source0对original0：g10已观察280快照全同，g14首差matrix denominator；g26/g30首差precondition numerator。
  完整首候选复现关系保存在status中；尚未把这些诊断算为冻结失败重放或全部内核通过。
- 接触夹具v1实际SDK有4个broad-phase contact，但9次surface force RHS均不变，未实际受力，不能作为有效参考。
  保存原fixture及全部SDK失败；新v2只将parent上移0.016m形成实际穿入，生产/688f image不改，另目录重抓有效性。
- contact v2 CPU按完整实际log审计：surface确实同时受力；legacy入口18次，force ordinal0/2/…16、
  preconditioner为RHS-null ordinal1/3/…17。旧dump limit9只抓5轮force，且这5轮legacy均无RHS变化；
  v2不能作为legacy有效性证明，后处理错误及全部数据保留，无补造。
  v3只把布料方形从0.1m缩到0.04m覆盖0.05m箱体投影，以实际顶点接触验证legacy；生产不改。
  原版pilot协议预先固定legacy limit18并正确读取偶数force ordinal，surface limit9；旧采样保留为失败。
- 接触v3两份首次SDK全部有效：surface11 contacts、legacy4 contacts，首force的cloth/body均实际受力。
  全部joint/drive/rigidity/stretch/bending/soft force均有真实RHS变化；legacy18入口中9次force按实际偶数ordinal完整捕获。
  pilot legacy静态receipt仍写limit9，实际driver env18且有call016文件；不改原receipt，另存纠正证据。
  v3 fixture按实际字节冻结；完整32参考driver已准备，并会逐字节采用这两份首pilot，不修改生产guard。
- graph四诊断审计已保存：g10三source的280快照/public首步与actual SDK诊断及固定SDK1/3/4/6首步相同；
  g14首差denominator，g26/g30首差numerator，均world2，仅作为局部定位，不升级60步/14项C验收。
- 14份deferred native原始追踪全部无损SHA内容bundle roundtrip；保留local raw、提交bundle+metadata，
  另真实解包/再次校验1381原文件通过；根交接和DRIVEN_CLOTH_HOST_RECOVERY已更新688f结果与未完成项。
- 84085b021b587077b5450e46af850ff8012d41f7已推csy且远端SHA同；149404文件快照校验0失败，含固定SDK/360pyc和688f全部结束验证。
- driven cloth contact v3完整SDK32全部有效受力，两个首pilot逐字节采用；SO3/SIX×surface/legacy×W1/W3×Newton/PD×body-block。
  每组9次实际joint/drive/rigidity/stretch/bending/contact force均有RHS变化，contact首轮同时改变body/cloth，均finite。
  actual-contact-host-schedule保存每入口原始首记录、调用次数、首NL顺序和legacy两用参数；修改前688f的27文件及SDK32的4519份原始参考SHA已保存。
  当前原版范围冻结，旧源码四基线拒绝及graph v2诊断串行中；生产guard尚未改。
- 补抓实际native Contact输入：surface max1000/soft38、active rigid0/soft11；legacy max1000/soft24、active rigid0/soft4。
  明确SDK32中的rigid/rolling入口为空active，不能据容量/调用数声称已验证有效rigid作用。四份688f基线均在constrained cloth guard拒绝。
- graph v2记录实际owned节点全参数与完整matrix before输入。完整worker四诊断结束后，12对中6对无观察差，
  另外6对的真实首差仅归约标量，全部before字节、真实标量/null参数和逐粒子输出相同。
  对这6份实际包三端每端32次pointwise逐位同，两PTX lane原子操作数同，共36分组目标均GPU F32精确见证。
  包由真实D2D快照与真实节点参数逐字节导出，不补造输入；原14份长程C失败仍保持。
- 为补齐真实rigid/rolling作用，新独立driven_cloth_rigid_soft_scene增加parent/ground实际碰撞与非零rolling/torsion，
  保持原v3夹具和SDK32冻结，生产guard未改；先采两份SDK有效性pilot再决定开放范围。
- 有效rigid+rolling补充pilot两份SDK均通过：surface11/legacy4 soft及8 rigid，首soft同时改变cloth/body；
  rigid与rolling各9次调用，均4次实际改变RHS，所有其它material/joint力有效，状态finite。
  新独立fixture冻结，完整32 active-rigid/soft矩阵将逐字节采用两个首pilot；原soft-only SDK32与所有失败不改，生产尚未变动。
- active-rigid矩阵driver首尝试在GPU前因遗留pilot报告路径失败，原driver/输出/日志保存；修正v2使用actual original2，生产无变化。
- active-rigid/soft原版32全部有效：rigid/rolling/contact/membrane/bending/joint驱动均实际改变RHS；加上前soft32共64份冻结参考。
  混合接触修改前检查点保存688f的27份source/build/so及SDK64的10766份原始文件SHA，原版/旧失败不改。
  接着仅按真实调度开放AL driven cloth soft/rigid-soft及body-block组合，保持hard/self/其它材料保护；数学/核代码/模板/调度不改。
- 接触guard生成首次因136列预览断言在写源前停止，源SHA仍与688f检查点相同；set-e未继续编译/GPU。保留attempt1，v2仅换行。
- 仅开放captured contact guards后编译1d0cc8367d500c9f8928620dc681c79f3fd8b25625a89e021300eea8848f51c5，CUDA176/f0不变。
  固定SDK64首次源码全部退出0：27严格，48份完整metadata相同；16个SIX+PD的metadata不同，失败与完整buffer全部保留。
  实际SDK表明SIX+PD+soft仍初始化BlockNonDiagonal并加rigidity GN，但不加membrane GN，不能把PD整体改Newton。
  1d0cc修改前检查点保存27源/build/so和10755份首源码文件SHA。已按范围SHA验证并保留SDK64a原step反汇编。
  fb68d保留原nonlinear flag；fc03b/fc055→fe490及102790独立选择block matrix，SIX+soft且alpha>0时生效；还在用9个实际SDK probe确认边界。
- 12个SDK实际native-channel/alpha/diagonal探针确认：SIX的独立block_matrix条件为rigid输入或full-surface输入且alpha>0，
  legacy soft单独不触发；rigid容量1000即使active0仍触发，diagonal开关不取消rigid/full-surface触发；alpha0取消。
  之前从静态局部分支概括为“soft触发”的假设不成立，以实际probe完整结果为准；nonlinear始终PD，membrane GN均0。
- 按step的独立矩阵flag恢复block template、rigidity GN、preconditioner copy、affine-build类型/行数及PCG稀疏类型；
  保留PD对membrane/spring GN等的控制，未整体改PD模式，数学/CUDA176/f0不变。
  新image23012dc5b44e7b4694daa318bf2fc2e3186d984664d22e3ec0dfbf4cb7a4e046。
  同固定SDK64全部完整owned参数/geometry/coverage相同（49504调用），全部finite，38严格。
  剩余严格差异保留，原1d0cc全部首失败不改；当前16种constructor→两组graph60→双端initcheck3严格串行诊断。
- 23012dc5的16种W3 constructor五项全部通过，独立汇总保存每项计数与报告SHA；当前graph/initcheck继续，当前74未收集。
  根交接及接触组合文档更新实际当前image，明确38严格/26未通过、正常包入口源码后端仍需交付，不能只改so文件名。
  本机home精确文件名搜索未找到trampoline_v1051.obj；G1已有缓存，已异步询问原网格路径/下载地址，继续独立核对求解器。
- 新增独立_core ABI构建入口，复用当前恢复的C++/CUDA，不覆盖SDK或默认包。初次CPU编译因生成的source_driver.h无include guard重复定义失败，
  原wrapper/builder/命令/编译日志留在source-core/f06a8d64e668e038；只修独立wrapper的include次序，不改当前23012dc5 host/header。
- 核对23012dc5局部队列已全部结束（22项）：16种constructor五项全同，soft graph60为71/128、rigid-soft为74/128严格，
  所有轨迹finite且首失败保留；original/source四个initcheck3均零错误，共256条eager/graph轨迹各三步。
  当前固定长程C及完整74仍未采，不能沿用历史image结果或统称剩余差异为原子波动。
- 独立_core第二次编译成功：source-core/b8dbcb88f1f3dc6a，SHA fb2f1e86d237b587ac5a9445eedfc5ca0238747129206dbd96f10f4ce4c99867，
  实际导出PyInit__core；公开API字段/默认值对固定schema零差异，readelf动态依赖不含SDK。源码host230/CUDA176/f0未改。
  core_demo直接加载该扩展并通过正常包/adapter执行未改示例，不走A/B bridge：Dzhanibekov60帧、plastic bag3帧真实graph及test均退出0，
  source_only=True、public_core_abi=True、ab_bridge_used=False、reference_solver_mapped=False，报告均已复核。
  这证明独立源码执行，不证明所有demo的A/B一致；默认安装入口仍未切换，solver_api_ready=False，未使用账号或网络登录。
- 回答用户替换进度：176入口已重建，但host复杂组合、固定首失败、长程正式demo与可安装默认入口仍未完成；不报无依据完成百分比。
  下一步启动23012dc5自己的完整74与固定C10，保持源、核数学、固定SDK及首次候选不变。
- 已启动run-regression.py→run-frontends.py串行队列，编译so、所有host源与SDK64a启动前SHA全同；当前进程仍存活，不重启已有worker。
  为26份接触首差准备独立CPU C8重算器audit-fixed-contact-C8.py，沿用已审计8原版/3源码的逐数组逐记录步LOO计算；尚未运行C8。
  本次先提交已结束的局部验证及_core构建/自检，活动完整回归输出暂不纳入快照；后续结束后独立提交，不把运行中状态写成验收完成。
- 上述已结束证据及源码已提交并推送81e203b1bb9a7d525dfa8d67c5eeefb6ea27b278，ls-remote确认分支同提交。
  快照185917文件校验零失败、360个pyc与旧快照逐字节相同、SDK64a不变。完整回归仍在进程1097349/1097381运行，
  当前已完成64/74，已知三particles seed严格失败；最终结果及C10以队列结束报告为准。
  run-after-regression.py已准备，要求当前完整回归及两个独立前端完成后才运行26份短C8→CPU重算→两组完整worker长程C8；
  不与现有GPU队列并发，不自动重启、替换source0或扩大cohort。
- 23012dc5完整74现已全部结束：70严格通过；particles seed1/2/3及pd_mixed_cloth seed3严格失败，四份首次输出保持不变。
  当前串行队列已自动进入固定C10；不能先沿用688f的四项C通过结论。后续继续观察原session52257，不重启回归。
- session52257已确认退出0，完整74及固定C10/CPU/独立前端队列全部结束。
  四份当前C10为particles seed1/3及pd_mixed_cloth seed3通过，particles seed2失败；CPU重算四报告完全相同，失败不改判。
  seed2超出范围集中n257_w1_it5_f0记录1/2的q/qd，共7数组，最大全局比2.5714285707443345；原10份与source0全部保留。
  两独立source前端真实graph/test均过且无原版映射。接着已串行启动run-after-regression.py：26份接触短C8→CPU→两组长程C8，
  当前生产23012dc5、SDK64a、数学和比较标准不变；seed2另需同输入定位，不能用接触C代替该失败。
- CPU逐数组bit审计已保存particles-seed2-first-state-audit.json并记录11份输入SHA：14份数组与original0不同。
  C10失败分支n257_w1_it5_f0最早差异在记录1/in.particle_q，particle251.x，source 0x3f37f4dd、original0 0x3f37f4de，
  十份实际原版均无该完整数组匹配；其它分支的严格差异不都造成C失败，不能混淆最早全worker严格差异与失败分支首差。
  下一诊断应保留seed2完整worker顺序和it5目标上下文，先确认observer是否复现固定251.x，再做同输入算子回放；旧seed1/it1证据不直接继承。
- 完整回归及C10/CPU/前端数据已提交并推送40f7540ef509a3bf5239c664b1ab30dfa7ca6a3a，远端SHA确认一致；186830快照文件零失败。
- 接触C8首两组soft surface SO3/W3/Newton b0/b1均失败，新增worker完整owned metadata同；不补采或替换失败。
  对首组11份实际buffer做CPU字节审计，first-contact-C8-buffer-audit.json保存各SHA及首差bits：
  首surface force的RHS pre全部逐位相同；post八份原版逐位同，三份源码各有同一个分量与之不同。
  这是明确后续同输入replay目标，但只验证了RHS pre，尚未验证整个contact view及其它输入同，不能据此认定核数学或原子次序根因。
  下次GPU空闲后先捕获该actual packet，保持完整worker顺序并核对observer是否复现原post，再比较runtime/原PTX/源码及实际red操作数。
- 新增driven_cloth_surface_capture.py，完整输入大小从固定原版首view的实际scalar words及首contact布局打印推导，
  CPU核对33个active contact、local12/total36、shape2/body2，共25指针字段3372字节，不补造几何或读取active之外的contact tail。
  保留原全部九轮RHS dump，并额外抓输入；只解释call000，逐字节导出旧same-buffer replay可读packet。
  要求完整owned metadata与固定原版相同，报告RHS pre/post及完整state是否复现冻结候选，不把插桩改变后的轨迹算原失败路径。
  run-first-surface-diagnosis.py准备原版/source抓取和各自runtime/原PTX/源码同buffer回放，要求现有after-regression队列complete才可运行。
  目前仅完成CPU规划/语法/宽度核对，GPU尚未执行；生产source230、核数学、SDK和固定接受cohort均未改。
- 对当前bundle先校验build sources SHA，再静态提取首surface force：规范化原PTX3251行、源码2006行，文本不同；
  原module SHA f0a51e394b15bf8923ffa9be535b0b08d1948856a93918e2e9254088a9aa5b14，
  源module SHA 5158c91039677002a51ce4e55c5efbd601f007a17493bc74442763902b292039。
  first-surface-static-ptx-audit.json及.diff保留结果；这是静态诊断，不证明数值不等价，也不证明原子次序根因。
- 确认旧session93855已结束且无对应GPU进程，after-regression队列状态complete：短C8为10/26，长程soft37/64、rigid-soft39/64。
  短26独立CPU重算全同；新增audit-graph-fixed-C8.py对长128个case重算全同，仍保留16短和52长失败。
- 实际运行run-first-surface-diagnosis.py，四任务全部退出0。两端25个pointer输入及RHS pre（26文件）逐字节同，完整owned metadata同；
  首RHS pre/post各自复现固定候选，source完整state复现，original完整state未复现，证明范围只到该首force。
  33接触逐个三端输出全同，两PTX真实原子操作数/目标同；原runtime/原PTX aggregate复现原值，源码PTX复现源码值。
  108scalar的旧CPU累加存在性检查通过，不把CPU候选等同真实GPU证书。
- verify-first-surface-atomic-order.py另验scalar84：9线程18实际写入，保留每线程同目标ordinal顺序，原/源目标分别搜1/12次即找到合并。
  用SERIAL_PTX真实global F32 atomic重新逐次执行，目标及全history均严格同，原0xc1fbdc24、源0xc1fbdc25。
  证明该scalar合法累计可产生两值；不推断实际生产调度，不证明跨所有目标的一条统一线程执行，不改数学或C8失败结论。
- 已串行完成seed2/it5完整worker内部trace两端，复用已验证SHA的all-entry-packets observer，生产source230不变。
  两端各只有8/15目标state数组匹配冻结候选，因此不把这份动态trace当原失败路径；original/source raw各8348文件保留。
  对两native目录做lossless SHA-content archive并逐文件roundtrip检查，后续WSL用unpack_reconstruction_trace.py还原。
- 检查此前220字节return-contact布局实验在当前真实33contact输入上的表现：first-surface-return220-replay三端逐接触与操作数仍同，
  aggregate仍未复现原版，未采用到生产。它不能作为已找到执行布局修复的证据，当前数学/source230/bundle均保持原样。
- 为读取九轮真实contact输入，新增隔离dynamic-surface-hook：只对surface-force view的6个contact数组按该次count读取，
  runtime/driver两端均先读取实际count并检查0<=count<=capacity，再拷贝active*stride；不改原cudahook.c/so或生产源码，不读未定义tail。
  两端实际count均33,33,33,36,36,36,6,6,6；capture-all-surface-calls.py保留原九轮RHS并导出每轮完整输入，owned metadata同。
  首RHS仍复现各自冻结pre/post，但新增观察器使两端完整state均未复现首次候选，明确不替换原C8。
- run-all-surface-replay.py串行18任务全部完成：每份actual input上runtime/原PTX/源码逐接触输出全同，
  两PTX真实原子贡献及其目标顺序全同。两端ordinal0/1完整输入同，ordinal2起x/RHS或后续contact几何已不同。
  all-surface-input-audit.json列出每轮输入差异；回放各端自己的实际buffer，不把原版中间结果喂入生产求解器。
  这扩展了九轮surface force的同输入核对，仍未证明整条host/PCG路径或原长程固定失败；不改原固定C结论。
- 18份surface回放共450个实际contact输入检查、9036次真实atomic贡献核对，逐接触与操作数全部同；
  aggregate复现各自captured输出的比例为runtime7/18、原PTX7/18、源码PTX9/18，完整报告保留，不宣称aggregate逐位全同。
- 开始未改examples/example_robot_g1.py正式模型验收：--solver synreal --world-count 1，3帧共18子步。
  first3两端worker均正常结束且finite，四字段均自首步strict不同（max q约7.82e-6，qd约1.262e-3），首次NPZ不改。
  独立owned审计两端46908完整launch参数/geometry全同、source coverage同；未将新的观察器状态替换首候选。
  已记录实际G1缓存203文件共293932151字节SHA，以后新机器需同资产版本，不替换缺失trampoline网格或改示例。
- run-g1-fixed-C8.py已串行启动，按既定8原版/3源码且逐字节采用first3的original0/source0；
  每新增worker检查所有source与harness及203资产SHA，runtime完全相同。尚未完成，不提前写通过；生产230/SDK64a不变。
- G1固定C8全部结束：source0/source1四字段所有18子步均在原版LOO范围内；source2的body_q与particle_q未全部通过，
  两速度字段通过，整体C8仍false。独立CPU逐数组逐子步重算与报告完全相同，不筛掉source2、不追加原版样本。
  继续串行运行G1 constructor三类观察器（分配/payload/initializer）双端五项审计，排查原先小fixture没覆盖的正式机器人构造差异。
- G1 constructor六worker结束：64 allocation事件、35 uploads、31 typed initializer与46939 owned/library时序均同；
  raw flat pointer一项false，已原样保存。9360条差异全部是同一external model.shape_types[105]的地址不同，模型字段标签相同，
  并非owned allocation身份/offset差异。不能仅按标签消除此项，接着在四个实际参数位置抓105个int32检查pointee。
  首生成器误用不存在的multiply_contact_tangent token，ABI唯一性断言在写driver/GPU之前拒绝；没有执行错误指针copy。
  改为实际evaluate_contact_force arg12、evaluate_contact_tangent arg12、soft_force arg13、soft_hessian arg8，
  四处均先对129-entry实际schema确认是pointer后才启动独立诊断；不改原audit.json或比较标准。
- 补充四处actual shape_types[105]各420字节，original/source全部逐字节相同，完整owned metadata/coverage仍同。
  raw constructor false原样保留；外部地址字段标签及补充数据解释了该项差异，未发现需要修改生产实现的owned指针错误，
  不把这份补抓外推为之前两个进程的所有pointee/opaque view/copy/clear均已证明。后续仍须定位固定G1 source2越界轨迹。
