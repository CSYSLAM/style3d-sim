# 当前Newton mixed固定失败：0dabbaa7实际路径核对

当前host为`0dabbaa7`，公开Core为`7151054e`，唯一原版对照仍为项目内SDK64a。
本页没有修改生产数学、容差、固定source0或十次原版cohort。
当前74仍是69严格；Newton mixed固定C10仍false，不能用本页局部证据改成整段通过。

## 目标与实际采集

目标为seed3的`mixed_w129_duplicates`。当前source0的18份三步目标状态与历史869源码目标逐字节同，
但没有继承历史算子验收，而是重新观察当前构建。差异只在world85/particle257。

预先固定1SDK+3source，沿完整24-fixture worker顺序，在目标初始化之后启用既有deferred observer。
全部四次真实退出0；每步最后apply/velocity快照都与实际公开状态逐字节核准。

| 预定运行 | 固定original0目标 | 固定source0目标 |
| --- | --- | --- |
| SDK0 | 18/18同 | 未复现 |
| source1 | 未复现 | 18/18同 |
| source2 | 18/18同 | 未复现 |
| source3 | 18/18同 | 未复现 |

采用SDK0/source1作为复现对，原始四次采集全部保留；后两次源码不能替换固定失败source0。
生产source worker均独立运行且未映射原版。三端回放进程为诊断，明确会同时映射原版。

## 逐算子及首差证据

- 两端732份公共packet，真实SDK runtime/原版PTX/源码PTX各两次，共4392调用全部输出严格一致。
  包含250776个实际129-world归约计数字；全部标量原字节、同起点别名保持。
  CPU独立核对732份有效指针跨度，没有不同起点的部分重叠；366对标量/alias模式相同。
- 两端9轮各4种散射，共72份真实弹簧/拉伸力及Hessian packet。
  三端919512个隔离贡献标量严格同；GPU实际global F32 atomic六种排列核准417960个完整标量输出，
  其中受散射触达的标量306504个，未触达部分也保持。CPU独立复核全部报告、输入SHA和GPU结果。
- 整个buffer最早差异是调用2的spring RHS，位于world21的固定粒子；不能把它直接当成world85轨迹差异的原因。
- world85的首个已采集语义差异是调用90，即第一步第三轮弹簧力的`after.rhs`。
  在此之前检查的语义buffer均无该world差异；所有全局不同而无法映射布局的buffer数量为0。
  该world的before RHS和三个弹簧隔离贡献完全相同，六份实际GPU折叠输出也相同。
  原版整块九标量RHS精确符合顺序`(1,2,0)`，源码精确符合`(0,1,2)`；没有推断GPU实际全局调度。

此处支持保留现有算术；完整固定C10失败、G1/其它布料长程及未捕获host组合仍需继续验收。
本页未证明全部CUDA API、完整三维launch geometry或分配归属，`solver_api_ready=False`。

## 数据与命令

证据目录为：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-mixed-newton-fixed/`。

六份native目录均用SHA内容去重无损归档，每份6796个原始文件；本地raw保留。
新电脑WSL先恢复所需native，再运行CPU审计。以下命令不重采GPU、不改固定cohort：

```bash
source scripts/reconstruction_env.sh
fixed_root=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-mixed-newton-fixed
for side in legacy source
do
  .venv/bin/python scripts/unpack_reconstruction_trace.py \
    "$fixed_root/frozen-reproduced-mixed-pair/$side/native-archive.json"
done
.venv/bin/python "$fixed_root/initial-cpu-audit.py"
.venv/bin/python "$fixed_root/first-difference.py"
.venv/bin/python "$fixed_root/target-first-difference.py"
```

`audit-current-path.py`还会独立检查全部四份原始诊断；运行前也需解包`traces4/0..3/native-archive.json`。
GPU回放命令和固定计划在`replays/plan.json`及各`*.command.json`，输出必须使用新目录。
