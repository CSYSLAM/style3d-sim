# 源码 native CUDA 执行层

2026-10-30。已编译：
`build/reconstruction-csrc/native/_source_cuda.cpython-312-x86_64-linux-gnu.so`。

这是包含188个恢复内核的 **CUDA 执行/内存层**，尚不是完整的 `style3d_sim._core`。
模块明确设置 `source_only=True`、`solver_api_ready=False`。
Model、State、Config、Solver 和 Newton 主机调度还未移植，官方安装及 demo 没有切换到此模块。

## 组成

- `native/source_cuda.cpp`：pybind11/C++ 设备内存、上下文、模块、参数 ABI 和 launch。
- `build_native.py`：只编译恢复的22个自有 `.cu` 和3个库 `.cu`，生成 source PTX bundle 并构建扩展。
- `native_cuda.py`：既有 GPU fixture 的 Python adapter，核对调用方入口 digest 和编译镜像。
- `native_backend_ab.py`：保留原版 PTX 参考路径，同时把源码句柄的 launch 交给 C++。

构建不读取或链接原版求解器；bundle 内是本次新源码编译的 PTX。
188个唯一 kernel 符号来自25个模块；库 EmptyKernel 重复实例只有规范化内容相同时才能合并。
build.json 保存编译命令、每个入口的 ABI 参数字节数/源 digest、源码/头文件 hashes 和产物 hash。
`ldd` 中只有 CUDA driver 和普通 C++/系统库，没有原版 Style3D solver 库。

## 运行契约

Driver 借用调用方当前上下文；若当前为空则 retain 主设备 primary context，销毁时 release 该引用。
每次操作 push/pop 所需上下文，保持调用方上下文；借用的上下文需比 Driver 活得久。
不把 Warp/CUDA-runtime 的 primary-context 指针放进另建私有 context 执行。

设备分配由 Driver 管理，支持上传/下载、显式释放、同步及延迟加载 source 模块。
launch 只接受 bundle 内已解析的句柄，逐参数检查个数和精确字节大小，不能装入任意旧 PTX 作为 fallback。
参数由稳定的 C++ 字节缓冲打包，CUDA launch 返回后这些临时参数才释放。
底层 C++ launch 支持指定 stream；当前 fixture adapter 使用默认 stream。

后续 Solver.initialize 应预分配 scratch、预加载将用的模块；避免在 CUDA capture 内延迟加载/同步分配。
高层 host 需要直接接入 CUDA spans 和 stream，不应通过 NumPy 下载整个 step 来冒充 GPU host 还原。

## 验证结果

最终 rebuilt `.so`：

- 全188个 source kernel 能解析，设备数据往返、越界读取拒绝、参数数目/结构大小拒绝、零 grid 拒绝及
  EmptyKernel 实际执行通过。
- 57个库入口经 C++执行，seed1/2/3 的 base1529×原版/source 和额外1830项异常归约全部通过，合计14664项。
- 核心 step、PCG、cable update/prepare/evaluate、hard-state/hard-evaluate 七组每 seed16541项，
  三 seed合计 **49623项通过**，实际经 C++执行28个不同自有入口。
  step/PCG 使用既有逐位规格；cable/hard 是完整旧 PTX 与 C++ source 双跑。
  函数解析覆盖188个，不能把它表述为188个都已通过C++的所有输入/调度路径。

paired driver 对整个原版模块 hash 做识别，原版句柄仍由原 CUDA 测试 driver 执行。
未匹配 bundle 的插桩旧 probe 会被拒绝；因此选择未插桩的 hard-state/evaluate 检查312B View ABI，
而没有放宽 source digest 检查。没有修改冻结的 NumPy 规格或比较容差。

## 复现

项目根目录：

```bash
.venv/bin/python -m reconstruction.csrc.build_native
.venv/bin/python -m reconstruction.csrc.native_backend_ab --seed 1 --output rerun
.venv/bin/python -m reconstruction.csrc.library_auxiliary_ab --group all --engine cpp --seed 1 \
  --output build/reconstruction-csrc/library-cpp-rerun
```

其它 seed用2/3。构建只需要现有 CUDA12.4 toolchain、glm1.0.1、pybind11和 Python开发头，
不安装依赖、不修改 src/ 或官方 `.so`。当前输出是 Linux CPython3.12 扩展。

## 下一步具体任务

1. 恢复 pybind 的 Span/Model/State/Control/Contact/Config/enum 的字段、默认值和 overload。
   `reconstruction/core.py` 有已转录 API/默认值，`src/style3d_sim/newton_solver.py` 是调用方；不要改冻结规格。
2. 对旧 host 反汇编及原版调用 trace 恢复 initialize 的 cache/ELL/precompute、持久状态和容量管理。
   从最小无接触粒子场景开始，实现真正使用本执行层的 C++ Solver.initialize/step。
3. 以 native_step.py 的已核对序列作为参考，逐段接入 Newton/PCG、材料、接触、self collision、cable等。
   仍需反汇编/原版验证实际分支及 stream/capture 行为，不能仅把 NumPy调度改写后当作原版证明。
4. 完成兼容 `_core` API 后再用独立 launcher 选择新 backend，运行同 demo：原版账号登录一次、新so一次。
   原版需重复运行以识别自身原子加波动，结合既有单步 replay；此阶段尚未开始。

证据：`build/reconstruction-csrc/native/build.json`、`validation-summary.json`、`provenance-final.json`。
最终seed1是base-abi/seed1.json加hard-abi/seed1.json；seed2/3是native/seed2.json和native/seed3.json。
native/seed1.json是保留的早期部分检查，不计入最终统计。库C++证据日志为cpp-final-seed*.log。
