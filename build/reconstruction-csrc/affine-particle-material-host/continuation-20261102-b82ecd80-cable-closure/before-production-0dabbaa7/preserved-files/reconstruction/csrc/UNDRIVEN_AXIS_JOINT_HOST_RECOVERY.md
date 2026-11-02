# Native zero-drive axis joint 接续

当前生产为 `430b5b74`；参考为SDK64a，CUDA176/f0不变，`solver_api_ready=False`。
本文件记录原生API输入的zero-drive组合，独立fixture不是未修改的官方demo。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-3d1b1b88-undriven-axis/`。

## 参考与已确认基线

`undriven_axis_joint_scene.py` 保留已有revolute/prismatic几何，在调用原生initialize之前设置
`joint_drive_count=0`并清空九个native drive descriptor Span。适配器本身的数组校验保留。
包装只在本fixture构造期间生效，finally恢复原方法；两个backend得到相同native输入。

v1只清一个适配器数组，触发“All joint drive arrays must be provided together”，未进入native initialize。
失败夹具、原始日志与`original32-fixture-v1-invalid/`均保留，不作为有效原版。
有效v2位于`original32-v2/`，其fixture/graph执行版本另有`v2-as-captured`副本。

矩阵：AL/PENALTY × revolute/prismatic × W1/W3 × Newton/PD × body-block，共32份固定首次原版。
全部finite/body运动、drive_load实际调用数0，primitive force每组9次并实际改变RHS。

- 3d Newton/no-block八基线中六条状态、完整owned参数/geometry严格一致。
- Penalty prismatic的W1/W3被现有guard拒绝，失败保留；不把它们算成数值不一致。
- AL prismatic W3/no-block constructor五项全部相同：59分配/29上传/30 typed/348 owned。
- 修改前检查点`build/reconstruction-checkpoints/undriven-axis-before-3d1b1b88/`：
  27个source/build/so文件和226份有效SDK参考文件的SHA。

生产仅开放纯joint spring XOR joint line的已捕获isolation，保持joint spring+line及其它未捕获混合限制。
Penalty沿用该isolation允许pure line；CPU模板、kernel调度代码和CUDA未改。
430b对同32份SDK：状态/首force buffer严格，12288次完整owned参数/geometry严格。
八种constructor五项全同；32组合graph60共128/128严格，双端各64轨迹×3步initcheck均0错误。
当前image完整74未收集；下一步进入正式机器人布料所需的材料+driven body组合。
出现差异先检查实际SDK调用和buffer，不改权重、容差或换候选。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example reconstruction/csrc/undriven_axis_joint_scene.py --frames 3 --output build/NEW-zero-drive-baseline -- \
  --constraint-mode al --joint-kind prismatic --worlds 3 --seed 3 --mode newton
```

`compare-source32.py`及`run-validation.py`局部全部结束且退出0，以当前image的status.json为准。
3d旧baseline guard拒绝记录及旧失败均保留，不以新结果重判。
