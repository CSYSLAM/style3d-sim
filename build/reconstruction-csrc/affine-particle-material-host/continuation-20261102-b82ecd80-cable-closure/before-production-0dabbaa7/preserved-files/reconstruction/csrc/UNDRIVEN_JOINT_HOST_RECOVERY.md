# 无drive固定/球关节：PD 与 body-block

活动源码 image：`6a7061d769946498b59c3d10b6ede7f843ff73b973e9d2ebe0cbb669725803f4`。
唯一参考仍为项目内SDK64a，CUDA176/f0不变，`solver_api_ready=False`。
本次仅开放已捕获的孤立AL spring joint分支，没有改数学、CPU模板、缓存或调度。
本image未单独收集完整74，不继承869的统计结果。
前一869的固定差异与804算子路径证明见[CURRENT_FIXED_FAILURES_86916989.md](CURRENT_FIXED_FAILURES_86916989.md)。

## 实际参考和修改

fixture `undriven_joint_scene.py` 使用两个活动offset-COM body，fixed/ball、W1/W3、Newton/PD、
body-block开关，共16组。断言无drive且确有joint spring；实际force每组都改变首次RHS，body实际运动。
固定首次参考均保留在`original16/`。

869已有Newton/no-block四组状态和完整333次调用均严格。
两种W3 constructor五项同：各56分配事件、28上传、28typed，字节/时序/指针用途均同。
保存869的27文件检查点后，仅放宽PD和body-block两处guard，并增加三项scope标签。
新范围要求无plain/line/distance/drive，也无其它材料/cable/contact；joint模式仍限定AL。
其它范围保留原guard，penalty模式尚未开放。

## 当前验证

- 同16份固定原版：全部状态逐位相同，首force pre/post RHS字节相同。
- 6,096次完整owned参数/geometry/shared memory及source覆盖数全部相同。
- 四种W3 constructor（fixed/ball × Newton/PD，block=true）五项均通过。
- 16组合 × eager/真实graph ×60步，64/64项逐位同。
- 双端各32条轨迹×3步initcheck均0错误；四种构造各56分配/28上传/28typed，Newton/PD各432/429次owned。
  `validation-6a7061d7/status.json`已complete，各阶段退出0。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-86916989-undriven-joints/`。
`source4-newton-b0-86916989/`、`constructor-before-86916989/`为修改前基线；
`source16-6a7061d7/`为固定首次源码；`validation-6a7061d7/`为构造/graph/initcheck队列。
修改前检查点：`build/reconstruction-checkpoints/undriven-before-86916989/`。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.undriven_joint_graph_ab --output build/NEW-undriven-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-undriven-constructor --fixture reconstruction/csrc/undriven_joint_scene.py \
  --prefix undriven-fixed-pd-w3 --fixture-args --joint-kind fixed --worlds 3 --seed 3 --mode pd --body-block
```

后续先捕获PENALTY模式的实际SDK调用，再决定如何恢复：新增独立`joint_penalty_scene.py`，
不改现有冻结fixture。准备fixed/ball/revolute/prismatic、W1/W3、两种mode与body-block的32份参考。
历史869 checkpoint回放与32份SDK参考已全部结束；penalty guard仍关闭，下一步按实际调用恢复。
Windows继续按根交接使用WSL2，固定SDK/pyc保持同仓库字节。
