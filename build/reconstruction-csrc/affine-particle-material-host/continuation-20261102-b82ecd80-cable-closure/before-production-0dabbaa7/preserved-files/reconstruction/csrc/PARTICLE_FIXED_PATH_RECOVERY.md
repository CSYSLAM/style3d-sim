# 固定particles seed1：整条算子路径核对

本页固定host image `8f4127f0f2f3b90fed919ca87f94ff3e5e38fa251b4e24992e065b2f62ac02d2`，
原版为项目内64a0be7f。CUDA仍为176入口、f0 digest。之后新image的统计结果不能直接继承本页结果。
固定source0、10原版及C10失败均保留；本轮不改生产代码、数学、容差或cohort。

## 闭合的内容

目标是`n257_w1_it1_f0`三步。旧完整worker trace的original/source目标各15/15数组分别与冻结
original0/source0逐位同，已复现失败。首次差异是step1第一次PCG numerator，随后denominator也不同。
三个文本不同入口为initialize_step、initialize_rhs、invert_block，其余七个实际入口规范化PTX同。

旧trace二进制缺少部分模板/标量，因此生成独立observer补抓所有实际参数字节及静态数组。
不覆盖旧observer或生产so。新observer的轨迹会改变；例如三入口observer只与两端冻结目标各8/15数组同。
所以回放动态数组仍取自旧固定路径，只有同一固定模型的静态数组和标量来自新抓取。
质量、flags、host diagonal与旧抓取逐项核对；迭代号、per-group、最大ELL数量等按旧实际标量交叉核对。

| 检查 | 结果 |
| --- | --- |
| 三个文本不同入口，两端各三步 | 18 packet，432次runtime/原PTX/源码调用，864份输出全同 |
| 三步全部10入口，两端各102次调用 | 204/204 packet通过，2448次普通核调用，3240次pointwise输出比较全同 |
| 84次实际归约 | 原/源码真实red操作数同；168次instrumented调用；84个GPU加法次序证书全通过 |
| 完整102次host参数 | 实际标量字节、grid/block、跨调用pointer相等/空值模式全同 |
| 原固定C10 | seed1仍失败，seed2/3通过；没有改判或补采原版 |

pointer回放保留实际别名，包括invert的blocks/inverse原地别名。所有后端使用同一组分配和stream，
按预先固定次数轮换，读取实际SDK runtime入口、原版PTX和源码编译入口，不用参考输出喂给生产执行。
旧dump没有apply之后的dx，因此额外dx输出由首次actual SDK runtime测得，再与其它后端逐位核对。
ELL最大数量实际为0，相关指针保持空/非空和别名，实际PTX分支跳过其pointee读取。

## 84个归约目标的证据

对每份固定动态输入运行原版/源码instrumented PTX，记录257个lane的真实red操作数、地址和执行次数。
每个live lane恰好一次，尾部lane不执行，目标都为该packet的实际单world counter。
原版与源码的操作数逐位同，instrumented pointwise输出也与旧固定路径同。

84次归约包含1280个subnormal操作数。global F32 atomic会将subnormal输入和结果按符号清零，
不能用普通CPU求和假装严格重放。依据为[NVIDIA PTX atomic说明](https://docs.nvidia.com/cuda/archive/12.6.0/parallel-thread-execution/index.html#parallel-synchronization-and-communication-instructions-atom)。
CPU仅用于找候选次序；每个次序再交给单lane GPU的真实global F32 atomic逐次执行，
最终counter bits及全部before-history均与证书吻合。84/84均通过，最多搜索59个CPU排列，无GPU补采样。

这证明这些冻结归约目标均可由同一批真实操作数的合法F32累计产生，且后续pointwise传播与实际SDK一致。
证书是存在性证明，不是推断原GPU实际调度顺序；没有将人为串行次序加到生产kernel。
没有把这些诊断运行加入固定10原版，也没有把C10失败改成通过。
完整solver及其它demo的验收仍需继续，不能把本页外推为所有模型、所有输入或所有opaque view均通过。

## 数据与命令

旧固定状态、102个trace packet：
`build/reconstruction-csrc/affine-particle-material-host/validation-8f4127f0-tet-contact/`。

本轮数据：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-8f4127f0-pcg/`。
其中`whole-path-fixed-replay/report.json`、`reduction-certificates.json/.npz`、
`full-102-host-argument-audit.json`保留完整结果与输入SHA；旧runner在`versions/`。
失败生成器和日志也保留；唯一性断言在GPU启动前拒绝了不够精确的替换锚点。

新输出目录、GPU严格串行：

```bash
source scripts/reconstruction_env.sh
recon_root=build/reconstruction-csrc/affine-particle-material-host
pcg_root="$recon_root/continuation-20261031-8f4127f0-pcg"

# 只抓诊断资料，不替换固定首候选。
.venv/bin/python -m reconstruction.csrc.particle_packet_capture --all-entries \
  --output "$recon_root/NEW-complete-particle-packets"

# 固定8f image的整条路径回放。活动image已更新时，使用归档checkpoint，不覆盖生产文件。
.venv/bin/python -m reconstruction.csrc.particle_pointwise_packet_replay --all-entries --trials 4 \
  --complete "$pcg_root/all-entry-packets" \
  --frozen "$recon_root/validation-8f4127f0-tet-contact/particle-full-worker-trace" \
  --source-checkpoint build/reconstruction-checkpoints/tetrahedron-legacy-before-8f4127f0 \
  --output "$recon_root/NEW-fixed-particle-replay"
```

独立checkpoint加载会校验27个归档文件及build的每项source SHA，要求与capture build完全相同。
源码入口不使用原版代算；上述同输入回放有意在诊断进程加载SDK，`diagnostic_intentionally_maps_original=True`。
已在活动131 image保持不动时独立加载归档8f，重新跑18个packet/432次调用，全部逐位同。
对应`checkpoint-loader-replay/`；加载时没有覆盖任何生产文件。
