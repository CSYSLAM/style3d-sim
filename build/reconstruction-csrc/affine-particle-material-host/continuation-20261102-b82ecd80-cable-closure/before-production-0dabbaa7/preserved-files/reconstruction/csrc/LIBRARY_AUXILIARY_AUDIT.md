# 57 个库辅助入口：源码编译及 GPU 核对

2026-10-30。原库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。

57/57 辅助入口已从源码实例化，并通过三个 seed 的逐位 GPU 检查。
加上此前131个自有 CUDA 入口，原库全部 **188 个唯一入口**均有源码编译实现。
本报告对应 compiled CUDA；之前的 CUB_VALIDATION.md 是另一个阶段的 NumPy 规格验证。

## 源码和 PTX

使用已安装的 CUDA12.4 CUB/Thrust200302 头文件；保留原 sm_52、C++17、O3、NDEBUG 参数。
没有把抽取的 PTX 或旧 so 嵌入新实现。三个源码编译单元位于 `csrc/library/`：

| 文件 | 唯一目标入口 | 内容 |
| --- | ---: | --- |
| thrust_kernels.cu | 24 | 23个 fill/sequence、CUB EmptyKernel |
| cub_sort_kernels.cu | 18 | histogram、scan/exclusive sum、single tile、up/down sweep、onesweep |
| cub_reduce_kernels.cu | 15 | 6个多块、9个单块的 sum/inner product/preconditioned/AABB 归约 |

CUB头文件额外生成的 EmptyKernel 在三个单元中去重；去重后恰好57个，与原版 mangled name 集合相等。
`library_entries.py` 解析普通 `.entry`，包含旧 owned-census 工具不处理的12个非 visible/weak 入口。
没有修改已验收131入口的 census parser 或任何算术规格。

最终规范化 PTX：**45 个完全相同，12 个仅有 `.visible` 可见性差异，57 个指令体全部相同**。
可见性比较只移除入口首行的 `.visible`/`.weak`，不删除或改写任何指令。
那12个入口使用的原 TU-local functor ABI 名称在新代码中保留为普通命名 namespace；
因此符号一致，外部可见性不同，不改变运算或参数 ABI。

`reduction_functors.cuh` 恢复 Vec3InnerProduct、两种 PreconditionedResidualInnerProduct、
MergeAabbs 和 PrimitiveCentroidAabb 的具名 C++ 运算。
初版 AABB 循环/向量表达式导致外层展开不同；按旧 PTX 写成明确三分量后，指令体也完全相同。
初版头文件/PTX、差异和最终分类 JSON 均保留在证据目录。

## 验证

`library_auxiliary_ab.py` 复用原有 fixture 和 NumPy 参考运算，source 侧强制选择新编译的 kernel，
缺失直接报错，不允许退回原 PTX。对所有57个入口集合做完整相等断言。

每 seed 原版和 CUDA source 各 **1529 项**通过；三个 seed 共9174项。
额外 literal old/source CUDA reduction A/B 每 seed **1830 项**通过，三个 seed 共5490项。
这一轮合计 **14664 项**，实际 source-use 覆盖57/57。

使用新 C++ `.so` 执行层再次跑同样测试，三个 seed 也是 **14664 项全部通过**。
原版路径仍由测试驱动执行未改写的旧 PTX；source 路径经 C++ 参数打包和 CUDA launch。
异常归约双跑也只把 source 句柄交给 C++，不把原版对照替换成 source/source。

覆盖内容包括：

- 填充的全部元素类型、非初始化/普通 fill、signed/unsigned count、零长度和 tile 边界、序列溢出。
- 排序的部分 digit、相同键稳定性、值载荷、尾部、spine、lookback 标签、allocator、NULL bins 输出。
- 归约的 raw/vector/scalar/mat3/centroid iterator、32/64位 GridEvenShare、initial 和 strip-mined tile。
- 额外归约覆盖 NaN 载荷/信令 NaN、±Inf、极值/次正规数、±0 和异常 initial；输出及尾部逐位比较，
  只读数组也比较。空数组的零字节只读检查省略，空归约输出/initial 检查保留。

某些日志包含既有 compare 函数计算 max_abs_diff 的 NaN 警告；验收使用原始 uint32 比较，未放宽容差。
没有运行账号登录后的完整原版 solver/demo，不能据此宣称完整 `.so` API 或轨迹已替代。

## 命令和证据

仓库根目录运行；复跑时指定新的输出目录，保留 final 证据。

```bash
.venv/bin/python -m reconstruction.csrc.library_auxiliary_ab --group all --seed 1 \
  --output build/reconstruction-csrc/library-rerun
.venv/bin/python -m reconstruction.csrc.build_native
.venv/bin/python -m reconstruction.csrc.library_auxiliary_ab --group all --engine cpp --seed 1 \
  --output build/reconstruction-csrc/library-cpp-rerun
```

其它 seed 用2/3。库编译无需原版 so；上述 A/B 工具需要旧 PTX/旧 so hash 用于核对参考来源。
源码交付的 native 构建/运行不读取旧 so，详见 NATIVE_EXECUTION_LAYER.md。

主要证据：`build/reconstruction-csrc/library-auxiliary-audit/` 下的 `all-ptx.json`、
`all-seed1/2/3.json`、`all-cpp-seed1/2/3.json`、`summary-final.json`、`provenance-final.json`。
