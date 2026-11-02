# 正式cable bend：当前0dab实测及未通过项

目标仍是独立源码solver替换原版SDK。唯一对照为项目内固定64a0be7f，源码host为0dabbaa7/Core715。
本页不继承旧814c5abf的analytic cable结论，也不把8次原版的有限采样解释为所有可能原版轨迹。

## 本次实际跑了什么

未改`examples/cable/example_cable_bend_stiffness.py`、材料及两种默认solver profile。
Newton与PD各60帧、600子步，3条cable、48刚体、192代理粒子；两个后端均以相同eager方式逐子步记录。
每mode固定8原版、3源码，首次original0/source0沿用最初实际输出，没有重选候选或替换数据。
源码worker校验实际0dab镜像、source kernel调用非空，结束前确认未映射原版SDK；全部worker退出0。

| 首次源码对首次原版 | particle_q最大差 | particle_qd最大差 | 三份源码逐子步固定C8 |
| --- | --- | --- | --- |
| Newton | 4.232674837112427e-5 | 0.0005006790161132812 | false/false/false |
| PD | 4.7069042921066284e-5 | 0.0005006790161132812 | false/false/false |

全部六条源码都不逐位一致。Newton source0的四个数组从substep0即越过固定C8；
首次逐位差本身很小：particle_q约7.1e-15、particle_qd约3.64e-12，不能据大小直接销账。
独立CPU实际退出0，重算24数组、全部600子步的leave-one-out spread，核23443200个finite F32值及输入SHA。

60帧没有跑完例子的8秒加载/稳态测试；本次也没有把eager结果写作真实CUDA Graph或全部cable例子通过。
完整替代仍未验收，默认原版及`solver_api_ready=False`不变。

## 固定C8的原版自测控制

在原8样本保持不变的前提下，事先固定每mode再收集3条真正的原版SDK轨迹。
六个原版worker均实际退出0；将它们仅作为held-out候选，用相同spread_report及逐子步门槛比较。
六条原版同样全部越过固定C8，独立CPU实际退出0，逐份核固定SDK64a、实际参数及全部600步统计。

这说明本例的固定C8失败本身不足以判定源码算错；它也不能证明源码完整等价。
六条源码的严格/C8失败继续保留，不扩样本、不改阈值、不以held-out原版替换基准。
后续按真实同输入核算和GPU浮点操作数证书区分计算错误与原版自身不确定性。

## 证据、命令及继续点

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-official-cable-bend/`。

- `status.json`：首次四worker退出记录；`synreal/`和`pd/`保留首次NPZ、runtime、source调用计数。
- `cohort8/`：固定22条完整轨迹及原始逐子步报告，首次两条按路径复用，无覆盖。
- `cohort8/independent-cpu.json`：六条源码的24数组独立CPU核对。
- `native-controls/`：六条held-out原版轨迹、原始报告及独立CPU审计。
- `first-CG/`：当前Newton首CG真实上下文、完整输入回放及GPU证书；是新诊断轨迹，不替换原source0。

```bash
source scripts/reconstruction_env.sh
cable_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-official-cable-bend
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["all_modes_C8_passed"],d["rows"])' \
  "$cable_phase/cohort8/independent-cpu.json"
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["original_control_runs_outside_fixed_C8"])' \
  "$cable_phase/native-controls/independent-cpu.json"
```

原运行脚本均拒绝覆盖已存在目录，完成的脚本不要原地重跑。
`first-CG`两端各470 owned调用metadata同，首inverse/RHS/z/direction/矩阵乘向量及分母均同。
首差是numerator的1.8189894035458565e-12，已按真实生产消费字段连接到首update的delta差7.105427357601002e-14。
十份完整输入的30次SDK runtime/PTX/source回放中，8份全严格，另外2份只差numerator归约标量；
全部向量、514实际ABI字节、178248保护字节及2别名组核准，GPU/根退出1明确保留为数值严格失败，CPU审计退出0。
原版/源码instrumented PTX实际产生的192个加数逐位同，两端捕获标量有2份真实GPU原子累加证书，
384历史word经独立CPU核准。证书不推断生产的真实线程全局次序；该诊断的原版/源码均未复现冻结首子步或十子步。

下一步补首轮后续CG完整路径和整个worker传播，并继续其余正式demo/未捕获host组合。
当前matrix capture没有完整保存ELL entries，不能据partial输入冒称完整matrix replay已通过。
若输入已不同，向前抓真实力或constructor；若同输入输出不同，回固定SDK/PTX核分支和FMA。
所有原始失败及数据保留，Windows继续WSL2流程；不要移用旧机器PID。
