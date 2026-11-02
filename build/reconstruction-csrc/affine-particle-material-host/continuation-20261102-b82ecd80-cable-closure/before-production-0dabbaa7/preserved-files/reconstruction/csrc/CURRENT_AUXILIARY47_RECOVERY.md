# Current 47 auxiliary entries

参考仍为项目内`64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63`。
实际测试source image为`00f45665e60c51be7b216ca93355137ce67b6eb4416bb9df34b93e6f375f63d9`，CUDA digest仍f0e0137a。
当前176个入口中，自有129、辅助47；本版本辅助为22 Thrust+25 CUB，不是旧版的27 CUB。

## 已完成

`build/reconstruction-csrc/self-affine-host/validation-00f45665/current-aux47-retry-seed1/2/3/`：

- 每seed原版提取PTX与当前编译host `.so` 各1377个原始bit检查，两个backend都实际调用全部47个入口，0失败。
- 每seed另720个原版PTX/source-image直接reduction检查，覆盖NaN payload、Inf、signed zero、初值与输入/输出保护，0失败。
- 三seed总10422条检查记录通过；没有把旧source extension或旧原版库当成当前image运行。
- 41个规范化PTX全同，其余6个Aabb reduction仅entry visibility不同，指令/参数全同。
- 源码测试使用真实`native_source()._KernelDriver()`，每次launch参数宽度严格对照当前manifest。
  `native_source()`的image/source SHA检查未更改；测试进程没有加载原版`_core`，没有登录。

命令：

```bash
.venv/bin/python -m reconstruction.csrc.revision_auxiliary_ab --seed 1 \
  --output build/reconstruction-csrc/NEW-current-aux47-seed1
```

另跑seed2/3。报告记录实际source/reference SHA、全部entry名、PTX/runner/冻结spec输入SHA与逐项失败。
特殊值诊断中的float误差元数据会产生NaN/Inf运算warning；判定始终是原始uint bits，不按该元数据判定。

## 发现机制与证据边界

数学输入/期望直接复用冻结的Thrust/CUB fixtures，文件未修改。仅将入口发现指向当前47个符号与64a原版PTX目录；
旧PCG bootstrap名在新版不存在，原来的bootstrap只触发提取、不作为任何测试操作数，现改为核对当前参考SHA/47入口。
不跳过失败fixture；两端coverage必须恰好等于全部47。

首轮3seed的`current-aux47-seed*/`全部保留：EmptyKernel在多个原版PTX模块重复出现，
初始inventory取最后一个模块、冻结扫描取第一个，导致harness在original discovery阶段assert。
修正为两端都保留首次模块；没有改函数体、数值期望、ABI或生产代码。

这是47入口的独立执行与ABI/数值覆盖，不等于所有SDK host路径都已恢复或全部47都在某一个demo中被调度。
真实SDK host对照另看body/self八组、完整回归和交接文档。完整solver仍未完成，solver_api_ready=False。
