# 当前组合源码候选与 H1 正常公开 API：2026-11-02

最终目标保持为源码编译的独立 solver 完整替代固定原版 SDK。此阶段完成当前组合候选的重建和验证，
尚未完成完整替代，候选未合入生产，默认入口仍原版，`solver_api_ready=False`。

## 版本与恢复内容

| 实际产物 | SHA256 |
| --- | --- |
| 唯一原版：项目内 `_core` | `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63` |
| 未改生产 host | `d09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68` |
| 未改生产 Core | `55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5` |
| 本目录 `candidate-force-order/_source_solver.cpython-312-x86_64-linux-gnu.so` | `f07b35a4733a3196cf66bc22617bfbe1bd23a03ce16772f3df9b18e2819a3b20` |
| 本目录 `candidate-public-core/_core.cpython-312-x86_64-linux-gnu.so` | `aa3466efe4e3fbcdd65f9ba27b6edbe16857c5bd6fcd46aa0cdc83b7340c2830` |

在前阶段 ae3a5997 基线上，按旧 SDK 反汇编及实际调用证据应用三个唯一 context hunk：
允许 driven cloth+self 的已证实范围，将 self force 累积移到 joint/drive/limits 后面，
保留早期 stiffness copy/scale 的原位置和 ae 的颗粒外部接触支持。
`build-candidate.py` 正向唯一匹配、反向完整还原 ae；不是重新猜测物理。
生产 C++、CUDA176及digest、数学、容差、资源属性、旧固定失败、SDK及项目360份冻结pyc均未改。

`candidate-public-core/source_solver.cpp` 与当前候选逐字节同，原公开 wrapper 未改；
编译器 `-H` 实证 include 本地候选，公开 Core 不依赖另一个 host `.so`。
`four-source-images-elf/` 对生产/候选四份真实 ELF 逐 SHA/唯一 PyInit 检查，均只有六个 CUDA/标准系统依赖。
按 `(NEEDED)` 解析并拒绝空列表，不依赖 readelf 的语言标签。

## 已实际完成

本阶段68个GPU子任务严格串行；每个记录时间、外部应用及剩余显存，free>=4096MiB即准入，不等待外部程序退出。
另含构造四个CPU审计及其他独立CPU检查。`close-independent-cpu.json` 汇总所有实际终态，失败没有删除。

| 范围 | 实际结果 |
| --- | --- |
| 12 self/drive 短程 | 10严格；9243 owned调用参数/geometry全部同；两 W3/PD/surface 状态失败 |
| 四类构造 | 五项全同，每端107 allocations、37 uploads、61 typed initializers；复用392份冻结SDK原件 |
| 两失败短程的固定8SDK/3source | 两例均 `[false,false,false]`；首 source0原字节保留 |
| 上述两例独立 SDK 控制 | 各三次也全false；不加入固定8、不替代源码失败 |
| 六颗粒/外部接触回归 | 4严格；两个 W3 状态或中间RHS差异保留；初始model/布局及调用参数同 |
| 四 self/drive 类 initcheck | 四次actual0、zero errors |
| 正常H1固定8SDK/3source | 四个Example.step：capture＋三实际replay；C8 `[true,false,false]`，所有原测试返回0 |
| H1独立原版控制 | `[true,true,false]`，不扩展原8份基准 |
| H1完整graph | 6120节点/6119边；typed参数、geometry、顺序及270指针对应全同 |
| H1 initcheck | 两端各actual97/7 errors，已定位仿真后测试读取无效整数尾部；原错误保留 |

H1是未改 `examples/example_cloth_h1_free.py` 的真实公开API，未用A/B bridge；源码进程未映射SDK。
模型为33887粒子、46刚体、46关节、51 DOF，原默认2 substeps、10 NL、20 CG、self与drive均保持。
四帧不是默认601帧验收，第一帧只capture且不执行物理replay。
最初原版/源码一对的状态不同，粒子位置最大差约6.93mm、速度约0.785m/s；该对已固定为original0/source0。
补齐C8后source0在范围内、source1/2越界，不能用source0单次通过代替整组通过。

独立CPU报告逐帧/全部统计、全部初始状态和首样本字节均复核：
`public-h1-C8-independent-cpu.json`、`public-h1-sdk-heldout3-independent-cpu.json`。
短程与颗粒分别见 `short-fixed-C8-independent-cpu.json`、`granular-regression-independent-cpu.json`。

## H1 graph 与 initcheck 定位

`public-h1-graph/`保留首次只读观测；通用旧checker遇到16个alloc/free节点而拒绝，没有据不完整schema判通过。
`public-h1-graph-with-alloc/`保存第二次只读观测、完整原始graph及typed allocation sidecar。
每端5458 kernel、518 memset、128 copy、8 allocation、8 free；没有添加GPU分配或改graph节点。
拓扑、有效参数及指针身份同，但没有宣称设备pointee或相对分配偏移内容相同。
2246个节点的编译资源属性不同，原样记录，未为通过而调资源；也不能据此直接判定轨迹根因。

外部24种入口包含Warp自身的三个CUB2.8.2扫描入口，属于共同外部依赖，未冒充恢复的SDK核。
类型来自实际生成签名、installed ctypes及[官方2.8.2声明](https://github.com/NVIDIA/cccl/tree/v2.8.2)。
完整源归档及SHA保留，`cub282-layout.cu` 实编译/实际运行核union、iterator及TileState布局。
对全部实际节点断言InputValue为immediate模式，才比较其活动int字段；类型填充和empty object字节不作有效参数。
旧同名多模块、1D-only和缺少reducer类型的四份CPU配方/部分制品均保留在before-*，没有放松语义字段比较。

H1两端7个initcheck报错由两次独立只读观察定位：
`public-h1-d2h396*/`保存原日志、实际numpy调用栈/数组名/指针/返回字节。
真实位置是 `newton.examples.run`仿真结束、viewer.close之后的`find_nan_members(example.model)`，
读取`bvh_shape_enabled`的99个uint32，实际启用仅50项，未使用尾部未初始化。
这些uint32的NaN检查为false；观察器没有增加GPU读取或写回仿真，因此这次host读不是此前轨迹分歧的原因。
`h1-inactive-tail-independent-cpu.json`核所有7次错误都在同一调用内；actual97仍保留，不改原测试或依赖库。

## 接下来做什么

1. 保持当前f07/Core aa、固定H1 source0和SDK8，先核同一次真实首native子步的构造缓存及完整输入。
   从Python预测器/接触输入到RHS、自碰撞、预条件器、首CG逐项抓实际前后字节。
   H1 n33887，不能直接套G1 n176或小夹具n16的span尺寸；graph同不等于buffer同。
2. 同输入非归约输出若不同，回原SDK/PTX/源码三端隔离；原子项必须核真实F32操作数及硬件顺序证书。
   每次诊断reset上传后先完成context同步，再向非阻塞流launch，避免复用已证实有竞态的旧checker。
3. 两个当前W3/PD/surface短程和颗粒W3长程继续保留失败；不能因SDK控制也失败就自动改判源码。
   H1完整默认时长、G1以及用户其他长程demo仍是最终目标，不能停在短程API成功。
4. 验收后才考虑合入、重编匹配生产Core、完整当前回归及默认切换；本阶段没有生产合入资格声明。

## 新Windows电脑 / WSL2命令

当前产物是Linux/Python3.12 ELF，使用WSL2；未做本机真实Windows/WSL验收或原生Windows移植。
先按根交接文档创建Python3.12环境并安装CUDA运行库/项目固定依赖，不覆盖固定SDK或360份pyc。

```bash
git switch reconstruction/windows-handoff-20261031
source scripts/reconstruction_env.sh
export PYTHONDONTWRITEBYTECODE=1
.venv/bin/python -B scripts/verify_reconstruction_snapshot.py
recovery_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-ae3a5997-driven-self
.venv/bin/python -B -m reconstruction.core_demo \
  --core-build "$recovery_phase/candidate-public-core/build.json" \
  --report build/h1-f07-local-01.json \
  examples/example_cloth_h1_free.py -- --viewer null --num-frames 4 --test
```

正常Core metadata使用仓库相对路径，换checkout目录时仍逐SHA检查；report选择未存在的新文件名。
示例资产需Newton固定ref `261cd1f429619d8ef4f546bd788ab9dea906b5e1`，本机已核缓存文件，
新电脑由同版本Newton取得同revision；资产manifest中的旧绝对缓存路径不能照搬。
本目录诊断worker使用本机冻结资产manifest及历史绝对plan，不承诺跨目录直接执行。
新诊断应在新目录解析同revision资产、核实际字节并生成新计划，不删除旧SHA guard或覆盖本批目录。
本批没有登录、下载SDK或由SDK给源码进程代算。

本机实际命令为各`*.command.json`及脚本入口；`status.json`记录全部真实child退出值。
已完成driver的输出目录均禁止覆盖，核状态/进程后再决定是否需要新诊断，不能直接重启历史队列。
