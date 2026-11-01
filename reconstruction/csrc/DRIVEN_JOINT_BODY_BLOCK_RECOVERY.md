# Driven joint 与 body-block 预条件器

历史5bd源码 image（当前869的普通约束工作见[PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md](PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md)）：`5bd9722e616a8191e4e490376fcef7576b492ea9886143641b0d166010f27eeb`。
唯一参考仍为项目内SDK64a；CUDA176/f0与kernel数学未改，`solver_api_ready=False`。
本image尚未收集完整74，不继承前一c189的统计结论。
前一c189已完成71/74严格、三个固定C10通过、CPU复算同及两个独立源码入口的真实graph自身test。
详情见[DRIVEN_JOINT_PD_HOST_RECOVERY.md](DRIVEN_JOINT_PD_HOST_RECOVERY.md)。

## 实际原版与恢复

固定revolute/prismatic × W1/W3 × Newton/PD八组三步，body-block=true，armature=.007，派生速度开启。
原版全部finite且body实际运动，owned调用数分别为revolute Newton/PD的2076/2073，
prismatic Newton/PD的2100/2277。原版第一批与所有失败都保留。

同一实际log的指针关联确认：PD affine-build的row count与RHS local、matrix一致；
Newton affine-build与matrix global一致、与RHS local不同。源码以前始终传global，需要按PD选择local。
原版的preconditioner顺序为PD point-line（若有）→drive→armature/limits→affine build→SO3 particle。
源码此前把build放在drive之前，因此仅移除guard不能恢复正确结果。

修改前保存c189的27文件及43份原版证据SHA。按实际顺序移动build/SO3-block段，保留其在cable之前，
无joint的旧分支相对调用不变；PD build改用local row-count。
仅开放无plain/distance/cable/fluid/external-contact的driven joint body-block分支，其它范围仍保护。

## 当前验证

- 同八份固定SDK原版：全部状态、17052次完整owned参数/geometry、source覆盖数严格相同。
- 四种W3 constructor（两种joint × 两种mode）五项全部同。
  revolute各64分配事件、35上传、31 typed；prismatic各67分配、36上传、33 typed。
  各自2076/2073/2100/2277次owned指针用途和owned/library名称时序均同。
- 32组合（joint、W1/W3、mode、armature、供给/派生速度）× eager/graph ×60步及双backend
  initcheck3全部结束：128/128项逐位同，双端各64条×3步均0错误。
  原始状态、owned覆盖计数、完整graph报告及sanitizer日志保留在同一目录。

完整solver目标未完成。构造审计不代表全部opaque view、library geometry或CUDA copy/clear语义都已证明。
旧self/其它image固定失败不被新结果重判。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-c189db81-joint-block/`。
`original8/`保存首次SDK，`source8-5bd9722e/`保存首次源码，
`validation-5bd9722e/`保存构造/graph/initcheck及串行driver。
修改前检查点在`build/reconstruction-checkpoints/driven-joint-block-before-c189db81/`。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.joint_block_graph_ab --output build/NEW-joint-block-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-joint-block-constructor --fixture reconstruction/csrc/joint_block_scene.py \
  --prefix block-prismatic-pd-w3 --fixture-args --joint-kind prismatic --worlds 3 --seed 3 \
  --armature .007 --derive-velocity --mode pd
```

输出须是新目录。Windows继续按根交接用WSL2；不得用Windows pyd替换固定Linux参考。
