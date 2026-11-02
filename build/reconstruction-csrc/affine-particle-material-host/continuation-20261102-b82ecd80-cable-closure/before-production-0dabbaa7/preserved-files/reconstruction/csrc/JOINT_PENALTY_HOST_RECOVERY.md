# Joint PENALTY host 恢复

活动源码 image：`aa52ee61a8fe9bad2032859095f8ec591e3cd80141f76af3fd521f67c3f6419a`。
参考仍为项目内SDK64a；CUDA176/f0与全部kernel数学不变，`solver_api_ready=False`。
本image完整74已结束：71严格，三组particles首候选严格不同；固定C10为seed1过、seed2/3失败，CPU重算同。
前一AL固定/球关节结果见[UNDRIVEN_JOINT_HOST_RECOVERY.md](UNDRIVEN_JOINT_HOST_RECOVERY.md)。

## 实际原版和源码改动

独立fixture `joint_penalty_scene.py` 组合已有冻结driven/undriven场景，在构造后设置native mode=0。
fixed/ball/revolute/prismatic × W1/W3 × Newton/PD × body-block，共32份首次原版。
每份均finite、body运动，9次general force实际改变首次RHS；原版固定不重采。

实际SDK记录表明：

- general spring/point-line force传include_joints=true，joint force alpha仍为5759999。
- start的D4和combine的L5权重均为config.alpha=100，包括该channel为零的joint类型。
- 不执行joint AL init/force/update及AL line preconditioner/tangent。
- prismatic Newton执行general point-line GN Hessian；PD不执行。
  pure joint spring Newton不执行general spring GN Hessian。
- drive velocity/load/tangent、armature、limits与angle state仍按实际记录保留。

保存6a的27文件与226份原版记录SHA后，仅按这些记录恢复host切换：joint_al控制AL调度，
general force启用joint，D4/L5使用模式对应权重，Newton选general line Hessian。
仅开放无plain、其它材料、cable或contact的已捕获joint范围；其它组合保留保护。
构造、CPU模板和CUDA函数没有改动。

首次编辑生成器在写入前被校验拒绝；当时shell未set-e，随后重编译了未变的旧源，未用于GPU验收。
失败说明及日志保留。新生成器具名校验每处匹配、检查128列，并用set-e执行。

## 当前验证

- 同32份固定原版：全部状态逐位同，首force pre/post RHS字节同。
- 14,868次完整owned参数、geometry/shared memory与source覆盖数全同。
- 八种W3 constructor五项均同。
  fixed/ball各56分配/28上传/28typed；revolute64/35/31；prismatic67/36/33。
- 32组合 × eager/真实graph ×60步，共128/128项严格同。
- 双端各64条轨迹×3步initcheck均0错误，`validation-aa52ee61/status.json`已complete且全退出0。

`after-local.py`已经结束。完整74为71严格；固定C10为seed1通过，seed2/3失败；CPU审计复现报告。
两个独立源码官方入口真实graph及自身test通过，没有原版映射。
正式cloth_balls使用历史固定8份原版，两mode各3份source均通过finite/物理检查，但固定C两mode均失败。
逐步CPU重算定位eager source0首子步particle1381.y；当前继续实际内部缓冲区诊断。
各自首次source保留，不能用新image或新cohort重判旧失败。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-6a7061d7-penalty-joints/`。
`actual-penalty-host-schedule.json`保存实际调度/完整首参数；`original32/`、`source32-aa52ee61/`为固定首批。
检查点：`build/reconstruction-checkpoints/penalty-joint-before-6a7061d7/`。
该目录还保存了历史869 checkpoint的732公共packet/2196次三端回放，通过时活动6a未改动。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.joint_penalty_graph_ab --output build/NEW-penalty-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-penalty-constructor --fixture reconstruction/csrc/joint_penalty_scene.py \
  --prefix penalty-prismatic-pd-w3 --fixture-args --joint-kind prismatic --worlds 3 --seed 3 --mode pd --body-block
```

输出使用新目录。Windows继续按根交接使用WSL2；固定SDK/pyc保持同仓库字节。
mixed plain约束32份原版脚本已准备，尚未GPU运行或改guard；先继续正式布料的固定失败诊断。
