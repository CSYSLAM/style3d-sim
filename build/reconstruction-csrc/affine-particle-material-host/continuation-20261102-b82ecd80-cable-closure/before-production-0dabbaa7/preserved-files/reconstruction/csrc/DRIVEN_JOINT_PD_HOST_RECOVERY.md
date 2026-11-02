# PD driven joint host 接续

本文件记录源码 image：`c189db81483ca1ca6b197cb57ebeb4411e9ecfeba2035975f51275c178dba458`。
后续5bd检查点见[DRIVEN_JOINT_BODY_BLOCK_RECOVERY.md](DRIVEN_JOINT_BODY_BLOCK_RECOVERY.md)。
当前869见[PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md](PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md)。
参考仍是项目内SDK64a。CUDA176/f0、已恢复kernel数学、SDK均未改，`solver_api_ready=False`。
本image完整74为71严格、三个particles首次失败的固定C10全过且CPU复算同，未继承04结果。
04完整结果、实际SDK的self跨模式见证和直接源码运行入口见
[BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md](BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md)。

## 实际缺口与修复

`joint_pd_scene.py`继承原有offset-COM joint fixture，只设置PD_NEWTON。
首先固定actual SDK的revolute/prismatic × W1/W3四组三步，armature=.007，drive、限位、派生速度有效。
四组均finite且body实际运动；转动每组1698次完整owned调用，移动每组1902次。
原先host直接拒绝PD约束，先只窄化此guard，仍保护plain/undriven PD及body-block+constraints。

首次源码77932a2b：转动两组状态/调用全严格，移动两组失败且出现非有限状态。
真实原版比源码各多195调用，首差直接定位到以下已恢复却没有接入host的两个kernel：

- 每nonlinear轮，在SO3 preconditioner之后、drive preconditioner之前，
  `add_joint_body_point_line_augmented_lagrangian_preconditioner`，每组三步共15次。
- 每CG轮，在SO3 tangent之后、drive tangent之前，
  `multiply_joint_body_point_line_augmented_lagrangian`，每组共180次。

按实际so签名、参数值/指针关联和已恢复kernel定义核对14/15参数及四个size_t计数，
仅补两处load及`pd && joint_line_total_`调度。没有改kernel、算术、容差、输入或首次候选。
779失败image/源码/build及非有限NPZ均保存，不把它当作通过。

补接后的d845四组固定原版的三步状态、完整7200次owned参数/geometry和source覆盖数全部严格相同。
但完整constructor五项都不同，保留失败并停止后续队列；不能仅凭状态同就声称全部还原。

随后实际SDK normal和反转proxy ownership的initialize-only诊断，消歧得出joint line模板按全局粒子ID
排序再做原F32累加；D4/L5都逐字节核实。首次point-first推导失败和探针启动缺少配套hook的失败均保留。
c189据此恢复非零D4/L5、六种typed动态缓存的位置与顺序、保留原版两次zero上传、推迟CPU权重上传，
并让PD乘法使用实际local row-count身份。CUDA数学、step中D4/L5的零权重及比较门槛不变。
四组状态及7200次调用再次全严格，prismatic constructor五项全通过：67分配事件、36上传、33 typed、
1902 owned指针用途、1935 owned/library名称时序。
16组合（joint类型、W1/W3、armature开关、供给/派生速度）× eager/graph ×60步，
共64项比较全部逐位同。original/source各32条轨迹×3步initcheck均零错误。
另revolute constructor五项也全同：64分配事件、35上传、31 typed、1698 owned指针用途、
1729 owned/library名称时序。局部与完整回归队列均complete；独立source入口Dzhanibekov60/bag3真实graph自身test也均过。

## 证据与接续

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-04b46fb0-pd-joints/`。

- `original4/`：四份首次SDK结果，含完整owned调用和provenance。
- `source4-77932a2b/`：保留的失败试验，不可重判。
- `source4-d8457a42/`：同四份原版的严格比较。
- `validation-d8457a42/`：两种关节constructor的失败；graph/initcheck未运行，FAILURE明确记录。
- `source4-c189db81/`、`validation-c189db81/`：构造恢复后的四组严格比较和本批验证。
- `original-prismatic-static-inputs/`、`original-reversed-proxy-initialize-v2/`：两份真实SDK静态模板输入。
- `resolve-line-template-order.py`及`static-line-template-order-resolved.json`：F32模板顺序的实际消歧证据。
- `build/reconstruction-checkpoints/driven-joint-pd-before-04b46fb0/`：修改前27文件与22原版文件SHA。
- `build/reconstruction-checkpoints/driven-joint-pd-trial-77932a2b/`：被拒绝试验的27文件。
- `build/reconstruction-checkpoints/joint-constructor-before-d8457a42/`：构造恢复前的27文件。

当前仍保留plain/undriven PD、body block+constraints、其它未捕获材料/接触混合guard。
后续已运行`joint_block_scene.py`和
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-c189db81-joint-block/capture-original.py`，
用于body-block=true八组原版；已据此修复host，当前进度以新增BODY_BLOCK文档为准。
先读当前validation状态，定位任何实际调用/缓冲区差异；不要为了通过删除未捕获范围保护，
也不要把新image结果用于销账04/8f或其它旧固定失败。

```bash
source scripts/reconstruction_env.sh
recon_pd=build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-04b46fb0-pd-joints

# 当前image只能跑一次这个目录名；重复验证请先给driver换新输出名。
.venv/bin/python "$recon_pd/compare-source.py"

.venv/bin/python -m reconstruction.csrc.joint_pd_graph_ab --output build/NEW-pd-joint-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-pd-prismatic-constructor --fixture reconstruction/csrc/joint_pd_scene.py \
  --prefix pd-prismatic-w3 --fixture-args --joint-kind prismatic --worlds 3 --seed 3 \
  --armature .007 --derive-velocity
```

完整替代目标未完成。Windows继续用WSL2和固定Linux参考，保持SDK/pyc与同仓快照版本。
