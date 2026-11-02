# SO3 body、tetrahedra、legacy contact 与 self 的接续

本文件记录源码 image：`04b46fb0e53d25ed680e724eff346526d688af01bd5f07db51d6e3bd8d9a8fb3`。
后续活动c189及PD关节host修复见[DRIVEN_JOINT_PD_HOST_RECOVERY.md](DRIVEN_JOINT_PD_HOST_RECOVERY.md)。
唯一原版对照仍为项目内 SDK64a；源码不登录、不映射原版代算。CUDA176/f0 未改，
`solver_api_ready=False`。完整替代尚未完成；当前 image 的74回归为71严格，三个particles首次差异
固定C10均通过，CPU复算吻合；这不重判旧8f的固定失败。

## 已完成与当前差异

粒子固定失败的完整102次路径已逐算子核对：204个原版/源码 packet，2448次实际调用，
3240项点输出逐位同；84次归约的实际逐lane贡献同，两端结果各有真实GPU F32 atomic次序证书。
包括1280个subnormal输入，按实际global atomic的FTZ行为核实。证书不是原生产调度的还原，
8f的固定seed1 C10仍失败，不能重判。方法与命令见[固定粒子路径](PARTICLE_FIXED_PATH_RECOVERY.md)。

legacy contact 阶段 image131c9873仅开放已捕获的SO3/tet软接触guard，没有更改算术和调度。
原版真实接触数W1=2、W3=6，tet和body两侧均实际受力，PD/diagonal条件按原版调用保留。

| image131c9873 检查 | 结果 |
| --- | --- |
| legacy 16组三步 | 状态、8428次完整owned调用、152份定义buffer全严格同 |
| legacy 60步 eager/graph | 64/64比较逐位同 |
| 冻结surface原版16组、surface graph | 16/16、64/64逐位同 |
| 无contact tet graph | 32/32逐位同 |
| constructor五项 | 96分配/释放、29上传、57 typed、634 owned指针、699核名称时序全同 |
| original/source各32条×3步 initcheck | 均0错误 |

image04b46fb0进一步仅开放无external contact的SO3/tet/self组合。
fixture每world有20个实际粒子、4个body代理、一个初始形变tet；VF两路、EE、EF、PP五个通道都实际作用。
diagonal-only不写tangent cache计数，已通过真实RHS变化确认接触非空。
原版顺序self→SO3→tet、tet→self preconditioner、SO3→tet→self tangent与现有源码一致。

| image04b46fb0 检查 | 结果 |
| --- | --- |
| self 16组三步 | W1八组严格同；W3八组状态不同；完整owned参数/geometry/coverage、首buffer均同 |
| self 60步 eager/graph | full 24/32、diagonal-only 30/32严格；含原版自身eager/graph差异 |
| self constructor五项 | 全同，117个分配/释放事件 |
| original/source × 两个diagonal配置的initcheck3 | 四组均0错误 |
| legacy16、冻结surface16、无contact tet graph、配置246 | 全通过 |
| 当前完整74回归 | 71严格；三个particles首次失败均通过当前固定C10，CPU复算同 |
| 独立源码入口＋真实graph＋示例自身test | Dzhanibekov 60帧、plastic bag 3帧均通过，均未映射原版so |

W3/body-block/PD/full的第三步出现body速度最大差`6.876885890960693e-6`，
首步仅一个particle位置/速度word不同。固定8 original/3 source cohort的full为15/16通过、diagonal-only为16/16通过。
唯一失败是`w3-pd-b1`首次eager轨迹：从第三步起四数组超C；source1/2整段与实际原版严格同，
但没有替换source0。PCG同步诊断的首差仅numerator 2ULP，实际SDK同输入也产生两端；72个真实lane贡献全同，
两端六个group目标均由真实GPU atomic次序核实。但source诊断没有复现冻结source0，
不能仅凭幅度小、首buffer同或原版有波动就宣称一致。

预先固定的3个独立原版holdout完成，未加入原8份基线。其中3/48条轨迹超原C范围；
`holdout1`的W3/PD/body-block **graph** 轨迹，其全部`body_q/body_qd`与失败源码 **eager**
source0整段60步逐位相同，包含第三步起那条较大的刚体分支。两条完整粒子轨迹仅剩
`particle[39].y`和`particle[53].x`分量有差异，位置最大`2.3283064365386963e-10`，
速度最大`2.9802322387695312e-8`；所有其它粒子分量均逐位相同。
CPU复算逐项核实。它是实际SDK能产生这条刚体结果的完整见证；跨eager/graph比较不重判原eager C8。
原source0 SHA为`f9a5c8ae01abb377fba3c856ad4d4783d834dcbd534a4a77e2df68789b21a1e8`，
原版见证NPZ SHA为`00041d2b273d73eb9719dc60945fba5629843846c55a6aba1f055095cc050590`。

第三步公开state强制回放也已完成：实际SDK和源码都没有重现冻结source0的第三步输出，
双端新trace首差又是PCG numerator。该干预没有恢复旧候选私有状态，也改变执行调度，
因此只保留为诊断，不能据此认定原因或替代旧失败。

## 文件与证据

- `build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-8f4127f0-pcg/`：
  固定粒子完整路径、原始packets、实际三backend回放、逐lane贡献及真实atomic证书。
- `.../continuation-20261031-8f4127f0-legacy/`、`.../validation-131c9873-legacy-contact/`：
  16个固定原版、构建、串行runner、上述legacy结果。
- `.../continuation-20261031-131c9873-self/`：固定self原版16组、五通道作用证明、旧helper、
  固定graph cohort及独立诊断；`.../validation-04b46fb0-self-tet/`保留首源码失败及全部局部结果。
- `build/reconstruction-checkpoints/tetrahedron-legacy-before-8f4127f0/`和
  `tetrahedron-self-before-131c9873/`：各27份源码、构建和image，附原版capture SHA。
- 代码在`reconstruction/csrc/affine_tetrahedron_{legacy_contact,self}_scene.py`及
  `native/source_solver.cpp`。旧fixture没被重写。

## 如何继续

先读本文件、`reconstruction/WORK_LOG.md`末尾及当前self目录状态。优先解释保留的W3失败，
按固定批次核对，不以新结果替换source0。同步observer的轨迹必须与旧候选独立比较，
若不复现则只能作为诊断。若点操作数不同，回实际so/反汇编；若atomic输出不同，
抓实际贡献并用真实F32 atomic验证，不改数学、不加容差。

当前image完整74回归及首次失败固定C10已完成；后续继续定位self固定失败、剩余组合及正式demo。
不要沿用旧image验收结论。
self+external contact、hard/rigid-only、drag/fluid、body constraints等未捕获混合范围仍有guard。
Windows按根交接用WSL2，不用随行Windows pyd替换Linux固定参考。
下一项实际host缺口是PD body constraints；当前已抓到原版revolute/prismatic × W1/W3四组，
含有效armature、drive、限位和派生速度，全部finite且body实际运动。新fixture为`joint_pd_scene.py`，
原版完整owned调用1698/1902次；此检查点仍未开放相应源码guard。

```bash
source scripts/reconstruction_env.sh
recon_root=build/reconstruction-csrc/affine-particle-material-host

# 每次用新输出目录；只复用固定原版，不覆盖首次结果。
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_ab --contact-kind legacy \
  --backend source --references "$recon_root/continuation-20261031-8f4127f0-legacy/original16" \
  --output "$recon_root/NEW-legacy16"

.venv/bin/python -m reconstruction.csrc.affine_graph_cohort --suite tetrahedron_self \
  --baseline "$recon_root/validation-04b46fb0-self-tet/self-graph60-d0" \
  --output "$recon_root/NEW-self-fixed-C8-d0"
# diagonal-only基线必须配 --diagonal-only，不混用两套结果。

.venv/bin/python -m reconstruction.csrc.demo_native_trace_ab \
  --example reconstruction/csrc/affine_tetrahedron_self_scene.py --frames 3 --substeps 3 \
  --observer "$recon_root/continuation-20261031-131c9873-self/self-pcg-trace/host_trace.so" \
  --output "$recon_root/NEW-self-pcg" -- --material tet --worlds 3 --seed 3 --mode pd --body-block
```

完整owned调用检查与constructor检查只覆盖各报告明确的字段，不代表所有opaque view、
library geometry、CUDA copy/clear语义都已证明。完整源码solver与正式大demo的旧固定失败仍须继续。

## 直接用源码 solver 跑例子

新增`reconstruction/source_demo.py`，校验活动源码构建provenance后装入源码模块，随后运行未改示例的
真实`__main__`。不替换capture、不改数学，不调用登录；兼容入口与A/B共用已验证的source loader。
运行前后均检查原版`_core.so`未映射，报告保留实际image、示例SHA、参数、source调用计数与退出结果。
计数是各solver实例已观察到的最大累计数，包含graph捕获，graph重放不重复计数。
这验证独立运行和示例物理检查，不等于对原版整段轨迹的A/B验收。未捕获混合范围仍会明确报错。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.source_demo --report build/NEW-source-bag.json \
  examples/example_plastic_bag.py --viewer null --num-frames 3 --test
.venv/bin/python -m reconstruction.source_demo --report build/NEW-source-dzhanibekov.json \
  examples/example_basic_dzhanibekov.py --viewer null --num-frames 60 --test
```

不传`--viewer null`可按示例默认交互方式运行。新报告不覆盖旧文件。
本轮证据在self continuation的`standalone-frontends/`，两例退出0，分别记录11530/3734次源码调用计数。

实际SDK跨模式见证的CPU核对（输出必须是新文件）：

```bash
.venv/bin/python "$recon_root/continuation-20261031-131c9873-self/self-original-holdouts3/audit-source0.py" \
  --output build/NEW-self-body-witness-audit.json
```
