# 当前公共Core的G1固定原版对比：38b70dcd / 7eb6e847

当前host38、公共Core7eb、CUDA176/f0，原版仍唯一SDK64a；生产源和数学没有为本次对比再修改。
完整替代未通过，`solver_api_ready=False`。

重新核对未改`example_robot_g1.py --solver synreal --world-count 1`的正常公共_core、真实graph60帧和--test。
固定采用旧八份实际SDK轨迹，逐文件SHA原样复制；不增加原版样本，也不更换旧失败。
当前新Core版本预先固定三次源码，每次运行前核对203资产、example、runner、当前build及全部source SHA。
使用原八份实际运行的`worker-as-run.py`精确字节，runtime除backend/image/reference-map三项外与旧原版完全相同。
三次源码都真实graph、--test正常退出0，public_core_abi true、bridge false、没有映射原版求解器。

固定C8仍false，独立CPU重算全部统计与报告完全一致：

| 源码 | body_q | body_qd | particle_q | particle_qd |
| --- | --- | --- | --- | --- |
| source0 | 51/60 | 51/60 | 54/60 | 51/60 |
| source1 | 58/60 | 54/60 | 58/60 | 54/60 |
| source2 | 58/60 | 57/60 | 58/60 | 58/60 |

共58个字段/帧检查越界，首次越界帧分别7、1、1（零起算）。
source1在帧31的body_qd最大误差23.851294673979282，原版LOO spread1.2091027029923032，ratio19.726442274053134，
对应flattened分量76。不能把所有差异统一称为末位浮点误差，也不能用之前首步PCG证书解释全部60帧。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-public-core/`。

- `graph60-fixed-original-C8/`：固定计划、八原版/三源码、真实runtime、每个命令及全部统计。
- `current-fixed-C8-cpu-audit.json`：独立重算全部字段逐帧LOO统计，固定C仍false。
- `current-outside-frames.json`：全部58条越界、误差/spread/ratio/分量；不删失败source。
- 首次启动仅因本Python没有`os.pidfd_open`在GPU运行前退出，完整旧目录及脚本保存为`*-startup-failed`。
  后续按本机Linux UAPI头确认pidfd syscall434；若原进程已经结束则检查真实终态，不因观察超时重复启动任务。

`run-initcheck60.py`的双端完整60帧已结束：程序graph/test正常完成，但sanitizer外层各退出99、报告8项错误。
原始报告没有抑制或改成零错误。另行只读Python来源观察器精确定位两端相同的420字节D2H源：
`model.bvh_shape_enabled`，uint32容量105，有效前缀54项（216字节），未使用尾部51项。
Newton用wp.empty分配容量，compact kernel只写有效前缀；运行结束后的通用find_nan_members盲目下载整个数组。
其调用位于viewer.close之后。前缀控制先复制216字节，无错误，再原样复制420字节，仍产生原8项报告。
两条完整60帧日志未报告device-kernel未初始化读取；这不等于证明所有可能轨迹都内存安全。
`initcheck-origin-audit.json`核对精确指针、字段、有效数量、控制区间和依赖源码；四份Newton源文件保存为as-run。
这项最终测试扫描不能解释此前的G1速度分歧，生产模型、缓冲区及NaN检查均未修改。

`sdk-heldout3/`另作预先固定三次实际SDK控制，不加进八份基准，不改源码C8。
三个完全相同SDK代码的新运行也都被此固定规则拒绝；逐字段within帧数如下，CPU独立重算相同：

| SDK控制 | body_q | body_qd | particle_q | particle_qd |
| --- | --- | --- | --- | --- |
| control0 | 60/60 | 56/60 | 60/60 | 56/60 |
| control1 | 57/60 | 56/60 | 57/60 | 57/60 |
| control2 | 59/60 | 53/60 | 59/60 | 54/60 |

因此C失败不能单独作为源码算术错误的证据。三控制最大速度字段偏差约2.10545，
尚未复现源码23.8513的尖峰；本控制研究没有证明整个源码solver等价，也没有把源码原false重判为通过。
SDK/源码所有原始轨迹与旧失败都保留；阈值和固定八份基准不变。

后续先核正常G1实际graph节点、依赖和参数/复制布局，避免把早期eager的ABI相同当作整个graph已证明。
可参考`capture_cloth_graph_parameters.py`的KernelParams布局及只读graph查询；优先在60帧结束后读静态graph，
尽量避免改变此前实际GPU执行，再核对诊断是否复现冻结轨迹。未实现的工具不得写成已验证。
上述SDK heldout已完成；下一项是实际正常graph核对，不反复补采或扩大八份基准。

所有新执行使用新目录，GPU串行；源、SDK、数学、阈值、原始cohort保持固定，Windows继续WSL2。

正常公共Core的新增诊断命令（不加入固定cohort）：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.core_graph_worker --backend source \
  --core-build build/reconstruction-csrc/source-core/a318a3ce42f6a731/build.json \
  --example examples/example_robot_g1.py --frames 60 --output build/NEW-g1-core-graph60 \
  -- --solver synreal --world-count 1
```
