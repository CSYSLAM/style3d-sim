# Cache initialization and layout recovery

> **最新8fb9d2ee：constructor捕获全部对齐；body/cloth首次contact轨迹仍未通过，完整solver未完成。**
> 4f已恢复真实self tangent lazy prepare/capture mode2；initcheck60为0，但八组7/8、graph27/32，失败保留。
> 4f typed57/57、uploads28/28、502 owned指针同；96分配与567 owned+library时序发现primitive AABB和4个init反序。
> 8f只按实际原版移动builder缓存至primitive后，数学/归约/CUDA176 f0均未改；helper24/24规范化PTX同。
> constructor96/28/57/502/567五项全部同；body/PP8严格；graph27/32，固定C8为15/16，source0失败不替换。
> initcheck3为0、246 config同；完整74仍在跑，之后核对失败contact fixture和真实graph buffer，见WORK_LOG。
> 7018完整74为70严格（3粒子seed+NN mixed seed3失败），旧失败/检查点均保留；不继承旧image通过率。
> 下方所有旧image提示为历史；solver_api_ready=False，完整替代仍未完成。

> **当前：0b7621b3；接入SO3 body+cloth/bending，实际八组验证中。**
> 按真实原版共享矩阵延后particle模板，恢复SO3→bending tangent；CUDA176/f0未改。
> 当前八组4292调用/65buffer/全状态严格，完整W1模板10项严格；graph60为28/32严格。
> 两个W3 self graph固定C8仍失败（16轨迹14过）；initcheck原版0/source29160错误，正在核对实际模板初始化。
> 085完整检查点461源/构建、1653结果SHA独立复核0差异；其body/spring八组3772调用/70buffer和graph32同。
> 085完整W1模板10项同，完整74为71严格、三固定首次source C10过、246配置同，self/surface复测严格。
> 辅助47在00f完成三seed10422项实测0失败，CUDA digest一直f0，见CURRENT_AUXILIARY47_RECOVERY.md。
> body+tet/full-surface、其它未捕获组合仍保护；完整solver未完成，solver_api_ready=False。
> 旧d3cb/929/d1a失败与正式demo尚未全部闭合；接手看AFFINE_PARTICLE_MATERIAL_RECOVERY.md和WORK_LOG末尾。
> 下方image提示均为历史。



> 下文2ff为初始化恢复的历史细节；当前结果以此处与WORK_LOG末尾为准。


当前 source image：`2ff5cff51f13b82c7e30b2733a3f53ab12af1095ce7fbd952c3f7323b0ea34b2`。
176 个源码 CUDA 入口的 digest 仍为 `f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a`。
原版仍为项目内 `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63`。
双方不登录；生产 so 不加载、链接或调用原版。完整替代尚未完成，`solver_api_ready=False`。

本轮修复的是原来被省略的实际 host 行为，未修改 CUDA 数学、归约顺序或比较阈值。
主要改动在 `native/source_solver.cpp`、`native/bvh_library.cu/.h`、`build_bvh_library.py`。

## 已按实际原版恢复

- preconditioner cache 先接收 A 的复制，再原地求逆；inverse 与 cache 同址，A 独立。
- CG scalar 容量为 `999 * groups`；每步保存 base diagonal，每个 NL 恢复。
- cache 初始化使用实际 CUDA 12.4 Thrust host dispatch，八种类型：float/int/uint/vec3/mat3/ivec2/Aabb/BlockNonZeroEntry。
  bridge 编译出的 23 个 device entry，全部与已验收源码的规范化 PTX 相同。
- 所有捕获的值字段为零；BlockNonZeroEntry 的 column 也是 0，不能初始化成 -1。
  Thrust 启动为 256 threads、2 items/thread，grid 为 `ceil(n/512)`。
- BVH rest build 和动态 refit 共用按 world 复制的 primitive boxes、nodes、visits。
  BvhBuilder 另外保留 local `leaves-1` unsigned cache，来自原版 `reserve`，不是 padding。
- PP 即使只有一个 local primitive、实际不 query，也分配 counts 与 31 slots。
  它不因此增加 active contact capacity；容量仍按真实启动参数恢复。
- 原版总是初始化 hard-contact history count，即使当前没有 body；未启用 hard contact 时每步清零。
  此前未知的 4 字节缓存已由字段地址和 rodata 确认，不能当作 self counter 或 NaN/status flag。
- 工作向量与 self candidate 的初始化先后顺序已按原版实际调用恢复。
  raw contact tangent cache 仍按原版 raw allocation 处理，没有额外初始化它的未定义尾部。

## 当前证据和限制

`build/reconstruction-csrc/self-host/validation-2ff5cff5/cupti-initializer-audit.json`：

- 同次实际原版 64 次、source 64 次初始化。
- 类型、元素数、值字段、grid/block、指针在 owned kernels 中的实际用途，64/64 匹配。
- 初始化调用顺序完全相同；`all_calls_and_order_match=True`。
- padding 未比较；所有 alloc/copy 的完整顺序、完整布局仍未验收。
- 这只核对这份实际 fixture 的初始化，不代表全部 47 个辅助库入口已完成 runtime ABI 核对。

定向九项在 `previous-failures6/`、`previous-pp-failures2/`、`no-self-control/`：
spring-w3 Newton、tet-w3 PD diagonal、无 self 控制严格相同，其余六项状态仍不同。
九项完整 owned metadata、defined buffers 均相同。不能以微小差异或单次转为逐位相同宣称修复。
更早 50effa1b 的 spring W3 固定候选对 32 次原版有真实 C 失败，旧失败保持原判。

同 image 完整回归正在运行，读取 `validation-2ff5cff5/regression/status.json`。
未标记 complete 前不能计算最终通过率；之后修改源码也不能继承旧 image 的通过结果。

另一个此前缺少证明的 PD duplicates 首差已补齐：

- `validation-105e9ccf/pd-mixed-duplicates-first-difference.json`：真实 375 次 trace，metadata 相同。
- 首差为 launch 2 spring force 的 after.rhs；输入和之前结果均相同。
- `pd-mixed-spring-witness/report.json`：129 worlds、387 springs，正负零各 2322 scalar 的独立贡献逐位相同。
  双方各 1161 captured scalar 均由相同贡献的精确 float32 排列复现，unexplained=0。
- 这是 A/B 证明，未完成该 image 整轨迹的 C，七项严格 state 差异原样保留。

## 下一步

1. 当前回归执行期间不改生产源码或重建，GPU worker 串行。
2. 使用新增 template observer 抓取实际 D0..D4 和 particle kind 的值。
   原版有五个独立 float 模板、一个独立 int 模板，source 当前仍共享零缓存。
   已知地址不同还不够，先核对实际数据和字段，再恢复独立布局。
3. 修复后固定第一次 source 结果，重新核对 metadata/buffer/state；严格失败要真实 trace 和 A/B/C。
4. 补完新 image 的材料/self 回归、graph、官方 bag60；self 与 body/fluid/granular/full-surface 组合仍未接通。

新的独立 template observer 在 `build/reconstruction-csrc/self-host/template-observer-v2/host_trace.so`。
它比旧 observer 多抓取 initialize_step 的五个 float 模板和 particle kind，只用于诊断。
默认 `host-particles/host_trace.so` 未替换，旧轨迹/失败候选没有被新同步协议覆盖。

从仓库根目录运行，输出必须选择尚不存在的新目录：

```bash
# 用新 observer 实际读取原版和 source 的模板数据；这不是固定候选的重选。
.venv/bin/python -m reconstruction.csrc.demo_native_trace_ab \
  --observer build/reconstruction-csrc/self-host/template-observer-v2/host_trace.so \
  --example reconstruction/csrc/self_material_scene.py --frames 3 --substeps 1 \
  --output build/reconstruction-csrc/self-host/validation-2ff5cff5/template-values \
  -- --material spring --worlds 3 --seed 3 --mode newton

# 单独复核已经捕获的初始化。指定一个尚不存在的报告文件。
.venv/bin/python -m reconstruction.csrc.initialization_trace_audit \
  --original build/reconstruction-csrc/self-host/validation-2ff5cff5/cupti-initializers/original \
  --source build/reconstruction-csrc/self-host/validation-2ff5cff5/cupti-initializers/source \
  --output build/reconstruction-csrc/self-host/validation-2ff5cff5/initializer-audit-recheck.json

# 修改生产源码后重建，native_source 的源码/构建 SHA 检查不可削弱。
.venv/bin/python -m reconstruction.csrc.build_host
```

检查点依次保留 59、8da、729、047、105 image 及其失败结果。
105 检查点的 436 份源码/构建和 7017 份结果 SHA 已独立复核，零 mismatch。
详细过程、工具故障和修复均记在 `reconstruction/WORK_LOG.md` 末尾。


## d1a6bd58（2026-10-31）：当前交接与复现

当前生产so SHA：`d1a6bd58de55edd3ae826e909443401e6044deb4d9c976587d644ba9b1c5beaa`。
只改`native/source_solver.cpp`构造顺序/typed cache初始化，不改CUDA176/f0或比较阈值。

- 7ea阶段all构造确实不同：少3次typed初始化，27次上传顺序不同，30项分配顺序不同。
- d1a all构造全部相同，505次owned指针按live allocation ID+offset全部相同。
- 56材料46严格，所有defined buffers、完整owned metadata和source count相同。
- 10个严格差异的C8已全部核对，4个失败如顶部列出；失败不能改成通过。
- spring PD一个C8失败source却与真实旧原版original2整条轨迹严格同，另两source也各匹配实际原版。
  新`original_trajectory_matches.py`仅检验这一存在性事实，包含副本的文件数不能当独立运行次数。
- 同image74、旧self回归、粒子C10仍在`remaining.py`中；使用各status.json看实际状态。
- `self_fluid_ab.py`是下一步的8组实际探针；尚未GPU完成，不计self/fluid已经接入。

正在运行的队列不可重复启动：

```bash
cat build/reconstruction-csrc/self-host/validation-d1a6bd58/remaining.log
cat build/reconstruction-csrc/self-host/validation-d1a6bd58/material-cohorts8-remaining/status.json
cat build/reconstruction-csrc/self-host/validation-d1a6bd58/regression/status.json
```

CPU复核真实整轨迹匹配（输出必须新建，不覆盖既有审计）：

```bash
.venv/bin/python -m reconstruction.csrc.original_trajectory_matches \
  --cohort build/reconstruction-csrc/self-host/validation-d1a6bd58/material-cohorts8/previous-failures6-spring-w3-pd-d0/cohort \
  --search-root build/reconstruction-csrc/self-host --output build/reconstruction-csrc/NEW-actual-matches.json
```

新`material_cohort_audit --previous-results OLD --keep-going`复用同image已固定的全部source/original候选，
继续检查独立case；C失败仍保留且返回非零。默认行为仍是遇到首次C失败即停止。
不允许为了清除失败而重新挑选source1/2、修改归约或改阈值。

当前下一项：GPU队列完成后对drag PD diagonal和两个PP失败case捕获首差，按实际输入重放；
若是首次PCG numerator，用`host_pcg_sum_witness`及`pcg_same_buffer_probe`直接核对真实原版函数。
保留所有C8失败；初始化相同与局部原子解释均不能直接代替整轨迹验收。
