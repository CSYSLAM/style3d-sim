# PD多世界接触：实际graph与SO3状态核对

生产仍为host `0dabbaa7` / Core `7151054e`；接触隔离候选为 `4f638b4b`，未合入。
固定原版为项目内SDK64a，原失败source0及原版八份cohort不变，完整替换未通过。

## 本批实际结果

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-4f638b4b-pd-contact-graph/`。

先按原worker的六案例、eager/graph顺序跑预定1原版及3源码，保存轨迹后只查询目标的两个graph。
每graph为276节点/275边；三对均核准552节点的类型、geometry、实际参数ABI及已审计类型化参数，
沿两个graph共用alias map的129个pointer identity模式也同。Model只核逐kernel已审计读字段，
不宣称opaque Model全部字节或设备pointee相同。10种函数存在资源属性差异，尚无其导致原失败的证据，未调整资源。
第一版因生成脚本有两处case循环而断言失败，尚未执行GPU；修订版四worker实际0，旧脚本与日志保留。

随后另预定1原版及3源码，仅在目标graph中加入SO3前后D2D快照，不改变原节点、依赖及参数。
每graph增加1份3648字节staging、24复制节点及32条边，完整拓扑独立复核，原276节点/275边均保留。
这会干扰原子调度，新增运行只作为诊断，不替换固定首失败或增加原cohort。

此场景真实SO3参数是count=3、bodies_per_world=3、particles_per_world=36，即native的展平布局。
不能按Newton模型的三世界标签推断local count=1或stride=12；快照按真实ABI和模型实际大小核准：
位置432字节、索引48字节、rotation及multiplier各108字节。
每帧采集rank8初始化、rank94/180/266三轮更新，advance依次true/false/false。
共四worker×60帧×四阶段=960真实packet，包含全部before输入、原始私有rotation/multiplier及完整after。
初始化前尚未定义的history字节保留，但不作为跨运行语义状态比较。

两次重复分别调用原版runtime stub、固定原版PTX及候选源码PTX，总5760次真实调用：
所有rotation/multiplier完整输出逐位同，全部只读输入及两端guard保持，false分支multiplier不变。
独立CPU直接重读960份输入和全部5760次输出buffer，再核240份末轮位置与公开状态逐字节同，实际0。
源码采集worker均未映射原版SDK；只有明确的三端同输入诊断回放进程加载SDK。

## 仍然失败的范围

上述只证明实际捕获输入上的SO3计算，不能宣布完整60帧轨迹通过。
新graph查询诊断和新SO3诊断均未逐位复现原固定source0/original0，全部保留。
仅观察对既有固定C8的归属，不重判旧失败：graph查询四份为false/false/true/true，
SO3快照四份为false/false/true/false；每组首份为新增SDK诊断，它也有越界。
这不构成扩大SDK波动范围或免除旧source0失败的理由。

新增SO3诊断中，source1/2最早的位置输入差在frame4/update-1的particle[28,2]，
之后frame4/update-2才出现rotation输出差。source3最早的位置输入差为frame7/update-1的particle[24,2]。
这些是新观测路径的先后关系；同输入5760次回放严格，接下来应向前检查RHS/接触/颗粒及线性求解输入，
不能拿这些frame与原固定source0的frame32越界混作同一条内部轨迹。

## 接续工作与命令

原固定失败仍为 `w3-b1-n2-s1-mixed-pd-b0-both-hit0` 的graph source0：
frame32/world2/body_q[2,3]首次越出既有C8；原始路径见上一份[接触恢复记录](GRANULAR_AFFINE_CONTACT_HOST_RECOVERY.md)。
先读本批 `next-step.json`，以及 `so3-independent-cpu-audit.json`、`so3-observed-differences.json`。
下一批按真实graph捕获RHS形成与接触输入，保留dynamic bonds/AL实际私有缓存，不能用公开位置猜造。
需要真实F32原子操作数时沿既有SDK/PTX/source隔离与GPU fold证书做，不排序真实输入或调资源来凑结果。
刚体接触常量实际是capacity1000、local_shapes6、shapes_per_world6、worlds1、body_count3、particles36；
force arg33是每粒子4字节的标量对角，不能再次误读为mat3。
也不能只核刚体接触：新观测最早位置差位于普通颗粒，相关granular/soft/CG阶段需要实际证据。

```bash
source scripts/reconstruction_env.sh
# Existing diagnostic output directories are sealed; use a new sibling phase for a fresh GPU run.
phase_root=build/reconstruction-csrc/affine-particle-material-host
pd_phase=$phase_root/continuation-20261101-4f638b4b-pd-contact-graph
# Read these saved reports first. They do not import or launch the original solver.
.venv/bin/python -c 'import json,sys; d=json.load(open(sys.argv[1])); print(d["actual_calls_independently_checked"])' \
  "$pd_phase/so3-independent-cpu-audit.json"
```

可复用源码为 `affine_so3_graph_capture.py` 和 `affine_so3_graph_replay.py`。
新兄弟phase复制本批 `so3-worker.py`、`run-so3.py` 后可按相同预定顺序重新采集：
driver会逐worker等待GPU空闲；原版/源码串行。之后对新phase执行：

```bash
new_pd_phase=$phase_root/continuation-so3-repeat-$(date +%Y%m%d-%H%M%S)
mkdir "$new_pd_phase"
cp "$pd_phase/so3-worker.py" "$pd_phase/run-so3.py" "$new_pd_phase/"
.venv/bin/python "$new_pd_phase/run-so3.py"
.venv/bin/python -m reconstruction.csrc.affine_so3_graph_replay --phase "$new_pd_phase" --prepare
.venv/bin/python -m reconstruction.csrc.affine_so3_graph_replay --phase "$new_pd_phase" --execute
```

Windows仍按根交接使用WSL2，原生Windows未完成；本批不切默认后端、不设置readyTrue，也未改生产数学。
