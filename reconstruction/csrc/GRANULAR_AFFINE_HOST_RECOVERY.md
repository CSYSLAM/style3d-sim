# 颗粒与SO3刚体组合：实际支持与独立候选核对

承接34700716；生产仍host38/Core7eb、SDK64a、CUDA176/f0，完整替代未通过、readyFalse。
本轮先验证实际功能范围，避免把静态guard计数当作已证明的缺陷。

## 固定输入与已完成结果

`granular_affine_scene.py`构造单世界8普通颗粒及1个SO3刚体，刚体生成4个真实代理粒子。
颗粒启用真实邻域接触；Newton/PD×body block开关，四组每组3步。无外部接触、自碰撞、其它材料或约束。
原版四组均真实退出0，粒子与刚体状态都变化且有限；granular force只改变0..7行，代理索引实际为8..11。
完整owned调用分别386/485/383/482次，含实际颗粒grid/force/tangent及SO3力/预条件器/tangent/state。
当前生产源码四组均退出1，明确报`Granular combined with other materials or bodies has not been captured`。
这已经证明本组合是原版支持而当前源码拒绝的实际缺口，尚不能宣称已恢复。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-granular-affine-support/`。

首驱动session62982的CPU审计失败：错误期待8行state，实际Newton扩充后记录12行。
保留v1脚本、plan、log及actual_exit=1。新`independent-cpu-audit-v2.py`只修12行检查及前8行实际演化检查，
另写v2输出；全部原始8 worker数据保持，未重采GPU。v2独立CPU实际0，支持4/4、源码guard4/4。
审计明确区分普通粒子/代理，检查实际grid ids、world值、完整force前后、实际ABI/geometry元数据及所有状态。

## 正在验证的隔离源码候选

从冻结生产`source_solver.cpp`复制，仅在granular拒绝条件中去掉`has_bodies`项，所有数学与CUDA保持。
使用原编译命令和相同27项输入，仅增native header搜索路径及改源码/输出路径，编译到本阶段candidate目录。
此修改仅用于观察已有调度是否正确，不把未测试组合开放到生产。
编译session83104实际0，候选SHA：
`d9f2c328bf6f032cda86eb5b4914558029077abccf977fb26b17f636a5fdf6d6`。
生产host38/Core7eb及所有原始文件未改；独立CPU核准源码与编译命令的精确差别。

`candidate-worker.py`按完整输入/二进制SHA加载该源码image，走既有独立host bridge，不加载SDK代算。
四组候选已预先冻结，比较原始SDK状态、全部被采集buffer的完整前后字节、完整owned调用/几何/参数及coverage。
候选驱动session85554启动时等待外部GPU PID2727055；外部任务未终止。实际状态见candidate.run.status.json。
任何超时不是停止证据，应继续查询同一session或实际PID，禁止重复启动。

接下来先看四组实际结果，再按实际调度首差恢复；即使四组全严格，也还需要constructor、真实graph、initcheck及范围检查。
先保留生产版本及拒绝保护，再决定经过验证的生产准入范围；不按“去掉guard能跑”直接宣布完成。
G1/布料/粒子原固定失败不受本阶段影响，Windows继续WSL2。

```bash
source scripts/reconstruction_env.sh
# 下列任务已启动；先核session85554，勿在同目录重跑。
.venv/bin/python build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-granular-affine-support/run-candidate.py
```

## 未完阶段检查点

本次提交只固定已终态的支持发现、v1失败/v2修正、隔离源码构建及后续检查脚本。
`support-immutable-manifest.json`列出实际不可变文件；运行中的`candidate.run.status.json`及候选实际输出不在此检查点。
本机驱动85554仍在等待已确认存活的外部PID2727055，未终止也未重启；后续须继续同一session核实际结果。
其它机器的独立验证应先确认本地没有活跃任务，再使用新输出目录或独立checkout执行，不把本机PID当作远端作业。
准备好的`check-constructors.py`和`check-graphs.py`均要求候选4/4严格结果存在，尚未启动，更未通过。
完成候选采集后发布完整终态，再执行这些检查；不将本检查点升级为分支恢复或生产验收。
