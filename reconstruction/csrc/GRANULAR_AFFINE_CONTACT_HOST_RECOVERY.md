# 颗粒、SO3刚体与外部接触：当前隔离候选

主源码仍为host`0dabbaa7`/公开Core`7151054e`，完整替换未通过，默认原版、readyFalse保持。
唯一原版对照为项目内SDK64a。以下候选尚未合入主源码。

接续实际graph与SO3状态已核：960真实输入/5760次SDK runtime、原版PTX及源码PTX调用完整输出严格；
独立CPU重读通过。旧固定长程失败不改，下一步向前核RHS/接触/颗粒与线性输入，
详见[PD graph与SO3核对](PD_CONTACT_GRAPH_SO3_RECOVERY.md)。
再接续实采21600份RHS/CG阶段，三条新路径的同输入首分母差及其向量传播已以SDK和F32证书核准，
仍未改判旧长程失败，见[RHS与首CG差异](PD_CONTACT_RHS_CG_RECOVERY.md)。

## 已完成的实际检查

六组实际SDK/当前source发现：SDK六组均正常三步，当前source六组均在外部接触guard拒绝。
覆盖Newton/PD、1/3世界、1/2刚体、完整/子集颗粒及none/authored/dynamic/mixed bonds。
其中一组实际有24条颗粒与刚体的soft contact；不是只验证有容量而没有有效接触。

隔离候选SHA：`4f638b4b9141e6ad6e2aabfb6533f8ed23bdfedbf7c1508063ea96bdb7e09326`。
仅删除granular/SO3 guard中的两个外部接触容量条件；构造、全部迭代数学、CUDA176/f0及其它限制保持。
独立CPU反向撤销该条件后源码完整相同；正确PyInit、无SDK ELF依赖均核准。

- 六短程全部实际退出0，四组状态/所有采集buffer/完整owned参数及geometry严格一致。
  两组三世界严格失败保留；它们的初始soft contact记录内容逐字节相同，但记录排列不同。
  CPU仅用排序检查集合，没有排序或改写真实碰撞输入，也没有修改生产算法。
- 两份首失败固定为source0，原版首份也保留，预先固定SDK8/source3：两个短程C8均通过。
  独立CPU逐帧重新计算，所有统计和结论一致；没有更换首样本、增添cohort或容差。
- 三类constructor五项全部同：particle85/85分配、26/26上传、55/55 typed；
  rigid/authored90/90、29/29、57/57；多世界grain/body90/90、29/29、57/57。
  后续直接检查长程失败的PD/mixed/W3类，也五项全同：98/98、31/31、63/63、692 owned及759/759时序。
  共四类实际SDK/source构造检查，没有继承其它模型的构造结果。
- 两端六组60步真实eager/graph均正常且有限；严格比较16/24，失败全部保留。
  SDK/source各三类initcheck共六任务全0，均`ERROR SUMMARY: 0 errors`。
- 固定首份60步轨迹，预先固定SDK8/source3，保留完整worker案例/模式顺序。
  六场景×两模式共12组，source0为11/12在范围内，全部三source为10/12。
  未通过的只有W3/subset/mixed/PD场景：eager新增source越界；graph首source0也越界。
  CPU独立重算全部60帧、四类状态和两类接触计数，完整复现失败；不是只检查展示checkpoint。

## 当前未闭合问题与下一步

不能把C8短程通过或constructor同，当成长程整体通过；当前候选不具备生产合入资格。
失败场景标签为`w3-b1-n2-s1-mixed-pd-b0-both-hit0`。

- 固定source0的graph最早越界为frame32、world2、`body_q[2,3]`：误差约4.8340e-6，SDK spread约4.4400e-6。
- 新source1的graph最早越界为frame25，world2的速度；不能与source0的内部路径混作一份记录。
- eager的首source0通过，但source1在frame42速度越界，source2在frame55越界。
- 失败组合的实际constructor五项已同；接续要核实际graph执行的共同输入、接触记录顺序及PD/bonds中间量。
  不预设只是累加顺序，不改变数学/阈值，不把其它成功运行替换成source0，不扩既有cohort。

现有真实`example_granular_beaf.py`以resolution12/substeps1/iterations3/linear5/no-capture跑三帧：
SDK及候选均正常，632次完整owned参数与geometry同，body状态严格同；粒子有约1e-13位置/1e-11速度差。
两份首样本保留后固定SDK8/source3全部完成，该三帧配置的C8通过，独立CPU逐帧重算同。
这只证明该短程配置，不代表默认分辨率、长程切割或其它未测配置已经验收；初始严格失败仍保留。

## 证据与接续命令

根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-granular-affine-contacts/`。

先读`graph-fixed-C8-cpu-audit.json`定位每份source的首次越界，再读相应`cohorts/<label>-g0或g1/`原始NPZ。
GPU所有命令、镜像SHA和输入计划均在对应目录；已完成目录不应覆盖重跑。

```bash
source scripts/reconstruction_env.sh
contact_root=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-granular-affine-contacts
.venv/bin/python "$contact_root/audit-fixed-spread.py"
.venv/bin/python "$contact_root/audit-graph-fixed-spread.py"
.venv/bin/python "$contact_root/audit-initial-contact-order.py"
```

保留的诊断失败：v1将rigid force arg33标量对角按mat3读，导致SDK启动报错；
不读buffer的原版控制正常，v2改为每粒子4字节后六SDK正常。
首graph脚本在生成后的嵌套目录解析loader路径失败，尚未产生轨迹；v2修路径后正常。
这些旧文件、实际退出码及修订记录完整保留，不能当成SDK不支持或内核错误。
