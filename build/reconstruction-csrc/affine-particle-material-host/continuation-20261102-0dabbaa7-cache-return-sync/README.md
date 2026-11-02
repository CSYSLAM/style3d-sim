# 缓存返回契约与 Newton mixed 固定输入同步复核

本批自己的 GPU worker 串行，允许其他程序运行。启动要求剩余显存至少4096MiB，记录进程与显存，
不把其他程序存在当成排队条件，不改变 launch 大小、求解预算或物理参数。
本次 mixed 单 worker 的采样最低剩余显存15929MiB，原始采样在 `mixed-worker-status.json`；
这是两秒间隔采样，不宣称捕获瞬时显存峰值。GPU worker 实际退出0，随后独立 CPU 审计实际退出0。

## 已完成及未证明的范围

- 当前编译 host 仍为0dabbaa7，Core7151054e，唯一 SDK 对照64a0be7f，360份 pyc 保持原字节。
- 实测实际编译库39次缓存初始化：11种零值类型及int的正负1，数量各1、129、128871。
  返回后立即查询 legacy stream 均为0；33个零值案例直接在非阻塞流检查全 payload/guard，均正确。
  六个整数填充值案例只检查返回 query 和完整下载，没有非阻塞 consumer。
  独立 pending 负控制 query 为600，证明查询确能观察未完成工作。
- CPU 独立重算39份完整 payload：22704176字节，另19968 guard字节和936 consumer参数字节全部核准。
  consumer错误标志未保存为原始数组，不能声称CPU重放了CUDA query或独立读取了原始错误标志。
- 当前生产 `source_cache_initialize` 使用固定CUDA12.4/CCCL200302的同步 `thrust::cuda::par`，
  沿 `parallel_for` → `synchronize_optional` → `cub::SyncStream` → `cudaStreamSynchronize`。
  原始源码/头文件SHA在 `report.json`；没有必要凭猜测给生产缓存增加同步。
- 对既有 Newton mixed 失败复现对，沿用全部732份固定输入、原标量、别名和两次/端预算，
  新fenced检查器4392次 SDK runtime/原版PTX/源码PTX调用，732/732完整输出严格相同。
- CPU 独立从冻结 capture 重建全部分配内输入、原标量及真实重定位参数，再核所有实际输出和只读字节：
  参数291132字节、输出28811376字节、分配内只读85948128字节、129-world计数250776word。
  18份同起点别名packet保持，没有不同起点的部分重叠。
  501552输出字节为apply dx的SDK首回放衍生目标，明确区别于原始capture的after目标。
- 本批没有分配外guard，也没有补采完整三维geometry；不据此宣称所有CUDA API/host组合已证明。
  旧无fence回放、原始cohort和source0失败全部保留。生产数学、image、默认后端及readyFalse不变。

## 诊断修复

`before-mixed-pointwise.py` 保留本批开始时的canonical检查器。
canonical `reconstruction/csrc/mixed_pointwise_packet_replay.py` 只增加注释和上传完成 `cuCtxSynchronize`。
本批 `mixed-replay.py` 是独立版本，另记录全部实际参数、分配内原始before/after和输出；
版本、固定输入位置与预算在 `mixed-replay-plan.json`，调用命令和实际退出在 `mixed-worker-*.json`。
旧计划若固定旧canonical SHA，应使用保留的as-run版本；不能改旧SHA来冒充原运行。

## 复核命令与接续

在仓库根目录运行，先校验固定快照，再恢复环境。Windows仍用WSL2/Linux Python3.12。
以下CPU审计不需要GPU或账号：

```bash
export PYTHONDONTWRITEBYTECODE=1
python3 -B scripts/verify_reconstruction_snapshot.py
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-cache-return-sync
.venv/bin/python -B "$phase/audit-cache.py"
.venv/bin/python -B "$phase/audit-mixed.py"
```

新机器先按根交接解包本批复现对的两份 `native-archive.json`；审计内历史绝对路径在读取时映射到新ROOT，
不能修改原始JSON/输入SHA。`mixed-replay.py` 新GPU运行必须另设输出目录，并先核剩余显存>=4096MiB：

```bash
fixed=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-mixed-newton-fixed
.venv/bin/python -B "$phase/mixed-replay.py" \
  --complete "$fixed/frozen-reproduced-mixed-pair" --frozen "$fixed/frozen-reproduced-mixed-pair" \
  --trials 2 --output build/windows-check/mixed-fixed-fenced
```

GPU三端诊断会明确映射固定SDK；生产源码运行仍不加载SDK、不登录。
`probe.py`、`run-mixed-replay.py` 是一次性原运行脚本，现有输出存在时会拒绝覆盖。

下一步回到正常demo/固定失败的首次分歧与未捕获host组合。Newton mixed现有首差仍支持原子累加次序解释，
本批不能把固定C10改判通过。G1/复杂布料、候选4f/7ca和正常长程验收仍待完成；
不改容差、不替换失败样本、不以局部证书宣称完整solver已替代。
