# 86916989：固定回归差异与实际原版核对

本页对应源码 image `8691698973a5ef5109a5300a72d319c918d9a159c20a9b0b76a0ddb1563c2eea`。
参考仍为项目内 SDK64a，CUDA176/f0不变。本阶段没有修改生产代码、数学、阈值或固定统计样本。
普通约束恢复见[PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md](PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md)。

## 固定回归结论

完整74项为70严格。四份首次差异输出分别按固定10份原版核对，结果如下；CPU审计重算一致。

| 目标 | 固定C10 | 后续诊断 |
| --- | --- | --- |
| particles seed1，n257/it5 | 失败 | 独立SDK诊断0精确重现目标全部15份状态数组、三步 |
| particles seed2，n257/it1 | 失败 | 独立SDK诊断2、5分别精确重现目标全部15份状态数组、三步 |
| particles seed3 | 通过 | 保留首次source0与10份原版 |
| mixed_cloth seed3，w129 duplicates | 失败 | 两端冻结目标复现；完整804份算子路径已核对 |

SDK见证来自事先固定的每目标8次独立诊断。全部运行保留，未加入或重算原C10，也未替换source0。
这些证据按各自目标计；粒子目标见证不代表整份多场景worker都逐位相同。
两个独立源码官方入口的真实graph与自身test通过：Dzhanibekov60、plastic bag3，无原版映射。
完整solver仍未验收，`solver_api_ready=False`。

## 布料目标如何复现

同步全路径采集使source目标只有7/18数组相同；该运行保留，没有假称复现。
独立SDK8次诊断中，128/129个world分别有完整三步的逐字节见证，唯独world85没有。
world85的三个重复三角形对应线程255、256、257，跨实际256线程block的边界。
这用于定位，不把按world的见证拼成一份完整SDK轨迹。

新建独立deferred observer：在同一stream按顺序DtoD存入64MiB暂存区，三步结束后才DtoH与写文件，
不再每份snapshot同步主机。旧observer、生产so、fixture、完整worker顺序都保留。
每步最后的apply/velocity快照均与实际公共状态逐字节核对，证明采集没有读取复用后的错误数据。
固定一次原版、三次源码诊断中，源码第2、3次都精确重现冻结source0目标全部18数组、三步。
原版同步首份采集也精确重现original0全部18数组。

`frozen-reproduced-mixed-pair/`采用上述实际记录，并保存逐文件SHA与来源，不重写原始记录字节。

## 沿冻结路径逐算子验证

两端各402份算子，共804份：

- 4种散射算子 ×9个非线性迭代 ×两端，共72份实际packet。
  包含弹簧力、拉伸力、膜Hessian、弹簧Hessian。
  分别取各自冻结路径的动态输入，隔离逐元素贡献；实际SDK runtime、原版PTX、源码PTX三端逐位同。
  919,512个贡献标量检查通过。全部306,504个实际累加标量均由GPU真实global F32 atomic、
  六种三项排列逐项验证通过，未用CPU普通求和替代硬件验证。
- 其它732份packet，用记录的全部标量、输入和真实指针别名，在同一分配/stream轮换三端回放。
  共4,392次调用全部逐位同，包含250,776个实际129-world归约计数字，没有跳过counter输出。
  inverse保留原地别名，非零ELL实际数据完整回放；apply额外dx由首次实际SDK测得并继续逐端核对。
- 两端366个公共调用的标量字节、grid/block及跨调用指针相等/空值模式全部同。
  这不是分配归属、全部CUDA API或未记录library geometry的完整审计。

这给出了该固定路径的算子与合法F32累加次序证据；次序证书不推断原GPU实际执行顺序。
固定C10仍保持三项失败，不将本页外推到所有模型或正式大demo。
无需为这些已验证算子修改数学或容差。余下host组合和正式demo继续验收。

## 数据、命令与后续

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-86916989-fixed-failures/`。

`sdk-diagnostics8/`是独立SDK见证；`first-trace-pairs/`保留同步采集；`deferred-trace4/`保存全部延后采集。
`mixed-frozen-all9-atomic-proof/`、`mixed-frozen-pointwise-replay/`为完整路径证明。
`stretch-ptx-audit/`保存实际PTX文字差异；只针对本次输入证明，不宣称所有文字差异普遍无影响。
修改下一host范围前已保存27文件检查点与44份固定回归数组SHA：
`build/reconstruction-checkpoints/undriven-before-86916989/`。

```bash
source scripts/reconstruction_env.sh
fixed_root=build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-86916989-fixed-failures

# CPU-only：重算公共调用的标量/geometry/指针相等模式。
.venv/bin/python "$fixed_root/audit-host-arguments.py" --output build/NEW-mixed-host-audit.json

# GPU：历史869的全部公共packet，允许活动image继续更新。
.venv/bin/python -m reconstruction.csrc.mixed_pointwise_packet_replay \
  --complete "$fixed_root/frozen-reproduced-mixed-pair" \
  --frozen "$fixed_root/frozen-reproduced-mixed-pair" --trials 2 \
  --source-checkpoint build/reconstruction-checkpoints/undriven-before-86916989 \
  --output build/NEW-mixed-pointwise-replay

# GPU：一份实际冻结路径的四种散射算子与真实三项原子排列。
# 此命令使用活动source的CUDA入口；核对输出中的image与CUDA digest。
.venv/bin/python -m reconstruction.csrc.mixed_atomic_runtime_audit \
  --directory "$fixed_root/frozen-reproduced-mixed-pair" \
  --sum-ptx "$fixed_root/gpu-three-fold/fold.ptx" --side source --offset 0 \
  --output build/NEW-mixed-atomic-proof
```

输出一律新目录。Windows继续使用根交接的WSL2环境，保留固定SDK/pyc。
下一模块为无drive的fixed/ball joint PD/body-block：原版16份和已有Newton/no-block四组均已抓取，
四组状态/参数严格，两个constructor五项相同。先按实际原版顺序开放窄分支，再验证其余12组与长程graph。
