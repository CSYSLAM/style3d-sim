# G1 正式示例源码验收：23012dc5

固定SDK为项目内64a0be7f，源码host为23012dc5，CUDA176/f0未改，`solver_api_ready=False`。
本页不声明完整替代已经完成。

使用未修改的`examples/example_robot_g1.py --solver synreal --world-count 1`，先跑3帧、18子步。
实际使用SynReal native solver，源码worker确认不映射原版求解器；正常例程入口的真实graph另需验收。

首次原版/源码都正常结束、状态finite，四状态字段均自首子步strict不同。
原始`original0.npz`和`source.npz`逐字节采用为固定C8的original0/source0，没有重新挑选。
补充owned审计的46908次调用完整参数、geometry和source覆盖全部相同。

固定8原版/3源码全部结束：source0和source1四字段18子步全部在既定LOO范围内；
source2的body_q、particle_q为16/18，ratio_max分别1.036665311691615、1.0366345110262525，
两速度字段18/18。因此整批C8仍失败，不因为比值接近1而放宽门槛。
独立CPU按逐数组逐记录步重算，全部统计一致。

数据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-688f9633-driven-cloth-rigid-soft/`。

- `official-g1-first3/`：固定首次A/B及运行日志。
- `official-g1-owned3/`：完整owned调用审计。
- `official-g1-fixed-C8/`：原8/源3轨迹、采用清单与锁定SHA。
- `official-g1-fixed-C8-cpu-audit.json`：独立CPU复核。
- `official-g1-asset-manifest.json`：实际缓存203文件、293932151字节的逐文件SHA。
- `official-g1-constructor3/`：已结束，分配、上传、typed initializer、owned/library时序四项同，raw pointer一项false。
- `official-g1-shape-types3/`：对该指针差异的补充实际数据抓取。

缓存标识为`newton-assets_unitree_g1_110bd790_261cd1f4`；新机器必须核对同版资产，不能换网格后沿用结果。
G1资产存在不表示trampoline网格存在，后者仍缺`assets/trampoline_v1051.obj`。

构造审计的raw pointer差异共9360行，全部指向两进程地址不同的`model.shape_types[105]`，没有owned allocation身份或offset差异。
实际分配64事件、上传35、typed initializer31、owned/library时序46939项均同。
独立补抓四个实际参数位置（rigid force/tangent、soft force/hessian）的105个int32，两端内容逐字节同。
原始audit的false保留；新证据解释该外部地址差异，未把整个opaque view、所有copy/clear或全部输入宣称为相同。

下一步：定位固定source2首次越界子步，先核对首步内部缓冲区与rigid/joint/SO3/PCG实际输入。
观察器必须核对是否复现原轨迹；发现真实调度或输入差异就回查固定SDK调用/反汇编。
修复前保存当前源、build和原始失败。
不补采到通过、不改数学、不放宽比较范围、不使用原版中间结果代算源码轨迹。

在仓库根目录，每个新Bash先加载环境；新结果使用全新输出目录，GPU任务串行：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example examples/example_robot_g1.py --frames 3 --output build/NEW-g1-first3 \
  -- --solver synreal --world-count 1
```

该命令strict失败会退出1。检查保存报告以区分数值差异和worker异常，不能据退出码重跑替换首次候选。
