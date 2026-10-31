# CUB 内核核对记录（2026-10-29）

当前旧库全部 **188 个唯一内核入口**均已在完整套件中执行，A/B 通过；CUB 为34/34。
此页记录最后27个CUB入口。它不是完整求解器或账号运行demo一致性的验收。

参考库SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
参考执行端始终是该库抽取的未经修改PTX；源码端采用`auxiliary.py`及既有`pcg.py`的NumPy运算。
本机CUDA头文件仅用于理解CUB模板布局，参数偏移、运算规则最终以旧版PTX及实测为准。

| 原入口系列 | 本轮补齐实例 | 源码入口 | 验证重点 |
| --- | ---: | --- | --- |
| DeviceRadixSortHistogramKernel | 2 | radix_histogram_u32 | 2048项tile填充、部分bit、多block、累加与溢出 |
| DeviceRadixSortSingleTileKernel | 2 | radix_sort_pairs | 4864项容量、稳定性、相同键、值载荷、部分bit |
| DeviceRadixSortUpsweepKernel | 4 | radix_upsweep | 6/7位策略、GridEvenShare范围、bin-major/block-minor计数 |
| DeviceRadixSortDownsweepKernel | 4 | radix_downsweep | 显式消费spine偏移、逐share散射、输入和spine不变 |
| DeviceRadixSortOnesweepKernel | 2 | radix_onesweep | 键值、lookback标签/前缀、allocator计数器、bins输出与NULL |
| DeviceReduceSingleTileKernel | 8 | cub_reduce | 指针/transform iterator、initial、空输入、归约顺序 |
| DeviceReduceKernel | 5 | cub_reduce | strip-mine多tile、每block partial、32/64位GridEvenShare |

## 修正依据与失败证据

1. `cub-histogram-seed1.json` 首轮失败：原版将不足2048项tile的无效位置作为UINT_MAX参与直方图。
   尾部填充增加最大digit桶；它不改变有效键的起始偏移。根据PTX的无效lane装载和计数写回修正，
   没有忽略该输出或放宽比较。
2. `cub-reductions-first.json` 两项失败是验证器把超过5120项的single-tile入口误用完整DeviceReduce调度预测。
   原版被测入口仍是单CTA；预测端改为该入口的ConsumeRange，而不是重新划分block。未改既有求解器公式。
3. `cub-reduce-zero.json` 发现28项signed-zero差异，绝对误差虽为0，仍判失败。
   原PTX使用min.f32/max.f32，零相等时min保留-0、max保留+0；NumPy默认fmin/fmax的tie行为不同。
   `merge_aabbs`显式恢复该规则，新增永久signed-zero测试，修正后全部通过。

`cub-all-first.json`：首轮1180项通过；seed2..10另有9轮，每轮1180项通过，见`cub-all-seed-scan.json`。
修正signed-zero并并入后，组内1300项通过；最终`cub_reduce`调用整理后，全套再次通过。

## 最终证据与复跑

项目根目录执行，输出目录需另取新名，避免覆盖证据：

```bash
.venv/bin/python -m reconstruction.diagnostics.cub_remaining_ab --seed 3 \
  --output build/reconstruction-debug/cub-remaining-recheck.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage --seed 3 --count 512 \
  --output build/reconstruction-debug/coverage-recheck
.venv/bin/python -m reconstruction.diagnostics.kernel_inventory \
  --coverage build/reconstruction-debug/coverage-recheck/coverage.json \
  --output build/reconstruction-debug/inventory-recheck
.venv/bin/python -m pytest reconstruction/tests -q
```

最终报告：`build/reconstruction-debug/coverage-20261029-all-entries-final/{ab,coverage}.json`。
独立核对：`build/reconstruction-debug/inventory-20261029-all-entries-final/inventory.json`。
从旧so重新提取的PTX入口与cubin STO_ENTRY一致：6模块、218处声明、188个唯一符号；missing为空。

## 结论边界及后续

- 比较使用逐位相等，没有新增容差或把失败结果排除在验收外。
- 排序检查中间计数/偏移/状态及哨兵，不只比较最后键序。归约保持浮点累加树与读取顺序。
- NumPy串行onesweep实现比较的是完成后的可观察缓冲，不重现GPU并发调度；目前契约要求allocator从0开始。
- 大于2^32的数据集、所有NaN载荷/溢出组合、未对齐指针、同名入口在每个模块中的副本，未逐一穷尽验证。
  不能把有限用例通过描述成对全部输入/并发分支的数学证明。
- 本轮未登录完整原版求解器。新增辅助入口尚未全部接入`native_step`；完整demo轨迹仍需
  按用户要求用账号运行原版，再运行源码，逐个比较。原先完整轨迹的超差结论未被撤销。
