# aa52 正式布料首步诊断

本记录只对应源码 `aa52ee61` 和固定 SDK64a。完整 cloth_balls 的固定 C **仍失败**。
源码已进入后续 mixed-plain 范围时，本记录继续作为历史证据，不能当新 image 的完整验收。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-aa52ee61-official-first-step/`。
接受队列和逐步 CPU 复算在前一阶段的 `validation-aa52ee61/official-cloth-fixed-original8/`
及 `official-cloth-exact-first-outside.json`，没有扩充固定原版8或替换源码候选。

## 已确认

- 正式例子两种执行模式各3源码、60帧，全部 finite/物理检查通过，固定 C 两种模式均失败。
  eager source0 首子步 particle1381.y 的 q/qd 即超界。
- 独立 deferred 诊断预先固定1原版+3源码。每份34202条记录文件及1份receipt、521948852 device bytes。
  四份均未完整重现固定首子步，不能作为冻结失败的整条因果路径。
- 首 surface force 的六字段1380条完整接触记录 multiset 四份逐字节同，只有顺序不同。
  此前已捕获的数组相同；raw 首差是该 force 的输出。raw 未分类尾部不参与验收。
- 新 `official_cloth_contact_replay` 捕获实际首 native state/control、17 rigid/1380 soft 有效输入前缀。
  双端先逐字节验证 state/control 和所有字段 size/null/scalar，再上传同一份 contact 有效前缀。
  不修改生产、原版库、物理参数或接受队列。
- common pair 的已捕获 before 数组相同，surface force 后243个 F32 词不同。
  另用完整 view 抓取验证实际双端 force 的全部只读输入，包括 body ids/indices/COM，相同且顺序也相同。
- 同一实际接触包，actual SDK runtime、原版 PTX、源码 PTX：1380条逐条 force 输出逐位同。
  原/源码37,920个实际 atomic 操作数序列同。
- 捕获原版、runtime/PTX/source 回放、两 instrumented 输出及捕获源码，共七类目标，
  每类5205/5205标量都有精确 F32 累加排列见证，未解释标量为0。
  见 `common-force-both-paths-exact-sums.json`；不推断实际 GPU 执行顺序。
- 补充 `exact-witness-detail-audit.json` 逐项重算七类见证：操作数和中间值均无亚正规数。
  原排列搜索没有施加线程内发射顺序；每类有289–337个标量的所选排列不保留该顺序。
  因此这些是逐标量算术见证，不是全局GPU调度证书；逐接触三端输出/操作数相同的实测结论不变。

这些结果确认本次首 force 的逐接触数学一致和输出的合法累加次序，**不证明后续120子步全部一致**。
固定 source0 和失败报告保持原样；需要继续覆盖后续实际算子路径，不能直接修改容差、排序或求和数学。

## 接续命令

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-aa52ee61-official-first-step

# 原始追踪以逐文件 SHA256 去重存档，所有字节保留；每份解包后有34203个原始文件（含receipt）。
for tag in original0 source0 source1 source2 original-common0 source-common0; do
  python3 scripts/unpack_reconstruction_trace.py "$phase/$tag/native-archive.json"
done

# CPU重核已有精确见证；输出必须用新文件名。
.venv/bin/python -m reconstruction.csrc.surface_sum_witness_completion \
  --replay "$phase/common-force-three-backends" --capture "$phase/common-force-capture" \
  --source-capture "$phase/source-common-force-capture" \
  --resume "$phase/common-force-both-paths-exact-sums.json" --output build/NEW-cloth-force-certificates.json
```

超过100MiB的完整 launch 文本以 `.txt.gz` 无损保存；回放读取器同时支持两种格式。
`compressed-launch-log-storage.json` 保留压缩前后 SHA256、字节数和 roundtrip 验证。
原始执行版回放器保存在 `surface-common-input-replay-as-run.py`，只为兼容压缩文本扩展读取方式，数学未改。
普通 gzip 体积超限、第二版验证随机 seek 过慢的打包尝试均留有说明和脚本，原始数据未删除或重采。

当前只观察首个 native 子步；若继续增加 body/rolling 或其它未记录算子，必须按实际 ABI 补齐缓冲区。
继承 observer 的 legacy-soft raw 快照包含容量尾部，不能把它当有效接触数据；公共输入回放只读取有效前缀。
