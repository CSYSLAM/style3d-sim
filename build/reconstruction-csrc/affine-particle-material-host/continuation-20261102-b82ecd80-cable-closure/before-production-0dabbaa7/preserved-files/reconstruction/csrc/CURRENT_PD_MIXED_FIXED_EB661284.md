# 当前固定PD布料失败的实际路径核对：eb661284

固定SDK64a、host eb661284、CUDA176/f0不变；生产数学、容差、库、首次输出和C10样本均未改。
当前74仍是70项逐位同，三个particles固定C10过，`pd_mixed_cloth-seed3`固定C10仍false。
本页不是完整solver验收，也不把旧869的非PD布料证据直接当作当前PD结果。

目标是`pd_mixed_w129_duplicates`，完整worker顺序和前置分配保持，每端三步18份目标状态数组。
诊断原版与源码不重新加入固定cohort。每种观察器预先固定1次原版、3次源码，所有运行均保留。

| 观察器 | 原版目标复现 | 三次源码目标复现 | 说明 |
| --- | --- | --- | --- |
| 已验证deferred observer | 18/18 | 11/18、18/18、18/18 | 还缺三个float入口的raw参数 |
| 增加raw及调用前输出copy | 18/18 | 11/18、11/18、11/18 | 未复现源码目标，不能用于替换失败路径 |
| 只增加三个入口的host raw参数 | 18/18 | 18/18、18/18、11/18 | 设备copy序列保持原deferred版本 |

采用第三种的原版0、源码1，所有文件字节不变，保存采用清单与逐文件SHA。
每次deferred采集的九个apply、三个velocity最后快照均与实际公开状态逐字节核对，
确认不是在三步结束后读到复用buffer的新值。

完整观察到每端375算子，分别为357个公共入口及18个spring/stretch散射入口。
实际PD使用float precondition、scalar ELL，不能直接用旧glm PCG回放。
新`pd_mixed_pointwise_packet_replay.py`保留既有已验证方法，仅换成实际float入口与对应已捕获输入。
prepare的mass/flags从同一捕获的initialize_step取值，并检查实际指针完全相等；所有标量使用raw原字节。

714份公共packet各三端两次，共4284次实际调用，全部输出严格同。
包含250776个实际129-world归约计数字；没有跳过counter、放宽容差或用原版中间结果代算源码轨迹。
原地alias按实际地址保留；独立区间检查确认714份都没有不同起点的部分重叠，因此本范围等址分组完整。
apply额外dx副作用由同输入实际SDK运行测得，再逐端核对；它不是在冻结观察器中额外捕获的输出。

两端九轮共36份实际spring/stretch输入，三端隔离贡献全部同，104490个隔离标量检查通过。
真实GPU对每个目标执行全部六种三项global F32 atomic排列，41796个完整RHS标量都有精确见证，
其中实际受力触达标量34830个；未触达部分也核对保持不变。
这不是对实际全局跨分量warp执行顺序的恢复。

采用raw-only原版0/源码1时，首个语义payload差异是`000002` spring的after.rhs：
标量772（world85/particle257/y）及959（world106/particle319/z），均相差1 ULP。
对应的before.x/indices/stiffness/rest/RHS逐字节同；两端目标都在同一组实际GPU fold结果中。
旧deferred源码2的首差是另一分量383，虽然公开18份状态同样复现冻结目标，内部原子轨迹仍可不同；
不把两份内部记录混作同一条路径。`first-spring-divergence.json`明确采用版本。

独立CPU审计重算12次诊断的目标复现、采用SHA、714份参数/指针区间、4284调用、全部250776计数字，
并逐位检查36份GPU fold结果，均与保存报告相同。完整geometry只记录x维，全部CUDA API和分配归属未在本页证明。
固定C10的false原样保留，`solver_api_ready=False`；这批证据支持保留现有算术，而不是升级为全solver通过。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-eb661284-pd-mixed-fixed/`。

- `deferred-trace4/`、`complete-trace4/`、`raw-only-trace4/`：全部12份诊断及失败，含预先固定计划。
- `frozen-reproduced-pd-pair/`：固定两份实际路径、采用清单及build。
- `pointwise-replay/`、`force-audits18/`：全部回放与GPU原子见证。
- `independent-frozen-path-audit.json`、`first-spring-divergence.json`：独立重算与首差。
- `complete-observer/`、`raw-only-observer/`：独立观察器源码、so、编译命令与来源。

每个native目录lossless归档，raw原件保留；WSL用`scripts/unpack_reconstruction_trace.py`读取`native-archive.json`恢复。
仓库根目录运行；输出必须是新目录，GPU串行：

```bash
source scripts/reconstruction_env.sh
fixed_root=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-eb661284-pd-mixed-fixed
.venv/bin/python -m reconstruction.csrc.pd_mixed_pointwise_packet_replay \
  --complete "$fixed_root/frozen-reproduced-pd-pair" --frozen "$fixed_root/frozen-reproduced-pd-pair" \
  --trials 2 --output build/NEW-pd-frozen-pointwise
.venv/bin/python -m reconstruction.csrc.mixed_atomic_runtime_audit \
  --directory "$fixed_root/frozen-reproduced-pd-pair" --side source --offset 0 --force-only \
  --sum-ptx build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-86916989-fixed-failures/gpu-three-fold/fold.ptx \
  --output build/NEW-pd-first-force
```

九轮offset为0、41、82、125、166、207、250、291、332。完整18任务命令保存在`force-audits18/`。
继续恢复尚缺host组合与正式demo；G1长程固定失败仍须独立定位。
