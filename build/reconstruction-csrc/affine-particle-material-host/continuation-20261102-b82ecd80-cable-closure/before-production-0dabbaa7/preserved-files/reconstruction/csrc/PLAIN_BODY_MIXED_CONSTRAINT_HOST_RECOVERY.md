# 混合普通 body 约束恢复

活动源码：`3d1b1b883a620f0028f2c4b16c2d2e490b96407a9e16e4dc75034d10baef6be1`。
固定参考为SDK64a，CUDA176/f0及数学不变，`solver_api_ready=False`。
当前image完整74为71严格，三particles固定首次输出C10均通过、CPU重算同；不继承旧image结论。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-aa52ee61-mixed-plain/`。

## 原版和修复

独立fixture `plain_body_mixed_scene.py` 使用两个有偏置COM、不同初始速度的body，反向attachment。
spring+line、spring+distance、line+distance、三者全部 × W1/W3 × Newton/PD × body-block，共32份首次SDK参考。
每种启用约束均有9次真实force，首RHS确实改变；finite/body运动均核实。原版固定不重采。

aa52的Newton/no-block基线中，spring+distance、line+distance已经严格一致；
spring+line和三者组合被constructor guard拒绝。先保存27文件与306份参考SHA，再仅开放孤立普通约束组合。

首次guard image `6a514e46`：32组状态、各primitive首force buffer、12576次完整owned调用全部严格。
八种constructor中，spring+line和spring+distance四种五项均同；其余四种的上传顺序和owned allocation identity不同。
原版分配次序是 **spring → distance → point-line**，源码原先为 spring → point-line → distance。
`actual-weight-allocation-order-resolved.json` 按实际调用的owned指针身份确定角色，没有用重复payload猜测。
失败审计、停止记录及剩余三组补采均保留；未运行该失败image的graph队列。

保存6a514e46的27文件与1188份验证文件SHA后，仅在无joint/drive/cable/fluid的plain distance+line范围重排pending upload。
权重值、CPU矩阵、执行调度、CUDA和容差均未改，形成当前3d1b1b88。
新增 `--original-capture`：逐文件SHA复制上述八种实际SDK constructor记录，只运行新source。
原始执行版编排器保存在 `constructor-harness-before-adoption.py`。

## 当前验证

- 对同32份固定SDK：全部状态逐位同，每种启用primitive的首force pre/post字节同。
- 12576次完整owned参数、geometry/shared memory与实际source coverage全同。
- 八种constructor五项全部相同，原四个失败均在同一份SDK记录下消除。

| 组合 | 分配 | 上传 | typed | owned Newton/PD |
| --- | ---: | ---: | ---: | ---: |
| spring-line | 58 | 31 | 27 | 444/423 |
| spring-distance | 59 | 30 | 29 | 447/435 |
| line-distance | 60 | 31 | 29 | 447/435 |
| all | 62 | 33 | 29 | 465/444 |

32组合60步eager/真实graph共128/128严格；双端各64轨迹×3步initcheck均0错误。
`validation-3d1b1b88/status.json`已complete且全部退出0。
本image完整74为71严格；三个particles首次严格失败的固定C10全过，CPU审计同。
两个独立源码官方入口Dzhanibekov60/plastic-bag3真实graph及自身test全过，无SDK映射。
aa52正式布料的整段C仍失败，首force证明见[OFFICIAL_CLOTH_FIRST_STEP_AA52.md](OFFICIAL_CLOTH_FIRST_STEP_AA52.md)。

## 接续

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.plain_body_mixed_graph_ab --output build/NEW-mixed-plain-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-mixed-plain-constructor --fixture reconstruction/csrc/plain_body_mixed_scene.py \
  --prefix block-all-pd-w3 --fixture-args --constraints all --worlds 3 --seed 3 --mode pd --body-block
```

如用 `--original-capture`，需放在 `--fixture-args` 前，并保持旧prefix、fixture参数与kernel清单完全相同。
输出用新目录，不覆盖旧失败。Windows按根交接使用WSL2；SDK/360个pyc继续固定在同一仓库。
检查点：`mixed-plain-before-aa52ee61/`、`mixed-weight-before-6a514e46/`，均在`build/reconstruction-checkpoints/`。
下一独立zero-drive axis fixture的v1 adapter验证失败已保留，v2原版采集中，尚未开放生产guard。
