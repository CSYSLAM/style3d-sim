# G1 正式示例源码验收：23012dc5

本页为23012dc5冻结结果。后续copy顺序恢复及独立验证见[G1_COPY_ORDER_RECOVERY.md](G1_COPY_ORDER_RECOVERY.md)；
当前eb661284的新1000份实际指针跨度核对见[G1_PCG_POINTER_SPANS.md](G1_PCG_POINTER_SPANS.md)，不追认本页旧轨迹通过。

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

首步诊断已结束：观察了1283个算子，metadata同；它没有复现冻结original0或source2的状态，不能替代原失败。
首软接触有效148记录，完整记录multiset逐字节同而次序不同；全部是kind1/2代理粒子，两个实际kernel的RHS均未变化。
因此未将该contact次序差异认定为轨迹分歧原因，也未解读capacity之外的未定义尾部。
首个观察到的输出差异为`000007` PCG numerator：inverse/r/初值及逐粒子z同。
三端同buffer各32次的z全同；原runtime自身能产生两端目标值。真实176 lane原子操作数同，
两目标各有单lane真实GPU global F32 atomic和history精确见证；不推断原实际执行顺序。

进一步对两端首步全部PCG调用逐份回放：1000份输入、三端3000项逐粒子结果全部相同。
这仍是独立诊断输入上的核对；原设备指针alias完整布局未证明，归约标量的逐位结果也不全部同。
原固定G1 C8继续false，不能据首步归约证书宣布子步12/15已经闭合。
命令和原始输入见`official-g1-first-step-trace/`、`official-g1-first-pcg-packet/`、
`official-g1-first-pcg-replay/`、`official-g1-first-pcg-certificate/`、`official-g1-pcg-path-replay/`。
两份trace各12234原始文件已lossless归档，WSL用`scripts/unpack_reconstruction_trace.py`读取各端`actual-archive.json`还原。

独立真正_core入口也已运行未改G1真实graph60帧并通过`--test`，没有A/B bridge或原版求解器映射；
报告`official-g1-source-core-graph60.json`。这证明独立执行及示例自检，不能代替同帧A/B轨迹验收。

正常_core ABI的原/源真实graph60帧固定C8也已采完并独立CPU复核；11个worker都通过例程`--test`，
但整批C8 false。source0的位置60/60、速度54/60；source1四字段分别46/51/44/50帧，
source2分别59/53/59/55帧在原版范围内（顺序body_q/body_qd/particle_q/particle_qd）。
最高ratio为source1的body_qd 2.0800101608856862，不能统称为边界误差或自检通过即一致。
`official-g1-public-core-graph60/`保存首次原版/源码逐帧状态和实际runner；
`official-g1-public-core-graph60-fixed-C8/`逐字节采用它们，再固定采7原版/2源码，未更换候选或补采到通过。
`official-g1-public-core-fixed-C8-cpu-audit.json`及`official-g1-public-core-fixed-outside-frames.json`保存独立重算和失败帧。
源码实际扩展为fb2f1e86（host23012dc5），无A/B bridge，源码进程不映射原版；固定SDK仍64a0be7f。
此正常graph批次与旧3帧eager C8是不同协议，两份失败都保留，后续需各自定位。

在仓库根目录，每个新Bash先加载环境；新结果使用全新输出目录，GPU任务串行：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example examples/example_robot_g1.py --frames 3 --output build/NEW-g1-first3 \
  -- --solver synreal --world-count 1
```

该命令strict失败会退出1。检查保存报告以区分数值差异和worker异常，不能据退出码重跑替换首次候选。
