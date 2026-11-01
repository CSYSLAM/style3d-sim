# Native zero-drive axis joint 接续

当前生产仍为 `3d1b1b88`；参考为SDK64a，CUDA176/f0不变，`solver_api_ready=False`。
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

生产guard尚未修改。下一步只开放已捕获的纯joint point-line范围，保持plain、joint混合、材料/contact等限制。
先对同32份SDK核对所有状态、首force buffer、完整ABI，再做八种constructor、graph60和双端initcheck3。
出现差异先检查实际SDK调用和buffer，不改权重、容差或换候选。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example reconstruction/csrc/undriven_axis_joint_scene.py --frames 3 --output build/NEW-zero-drive-baseline -- \
  --constraint-mode al --joint-kind prismatic --worlds 3 --seed 3 --mode newton
```

该命令当前只验证已允许的Newton/no-block分支；PD/body-block和Penalty prismatic仍有guard。
`compare-source32.py`、`run-validation.py`是下一步脚本，当前不能提前声称已通过。
