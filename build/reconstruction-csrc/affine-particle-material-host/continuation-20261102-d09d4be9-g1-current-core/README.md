# 当前 d09/Core55：G1固定长程与完整NL2 CG阶段

最终目标仍是独立源码替代固定SDK64a，完整替代尚未通过，default/readyFalse保持。
本阶段生产host、公开Core、CUDA176/f0、SDK、360pyc、原demo、数学、阈值及旧失败均未改。
按用户要求记录过程，完整阶段一次提交；前一完整阶段为3472074ffeb4feb73d223870e17c2c0f0b1192f2。

本批host为d09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68，
公开Core为55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5，目录9cb2fcaa1082d1df。
sole SDK64a原文件仍在项目内，不使用项目外旧SDK或另一个仓库的二进制。

详细范围及限制见[维护说明](../../../../reconstruction/csrc/CURRENT_G1_CORE_55D6.md)。

## 做了什么及实际终态

| 根命令阶段 | 实际根终态 | 子阶段结果 |
| --- | --- | --- |
| 当前Core固定八SDK/三source graph60 | session9291 / 3bad71，1 | 三source均0，无SDK映射，固定C8 false保持 |
| 独立C8统计CPU | 4ac92a，0 | 全部统计精确复现 |
| 全部越界导出 | 6fcbe6，0 | 123字段/帧，首次帧4/18/4 |
| 完整NL2预检 | da2027，0 | 两份旧实际图全部202位置核准，无GPU context |
| 双端采集/CPU/三端回放/CPU | session62083 / 1d1678，0 | 五个子阶段实际全0 |
| 原子输入冻结 | 4fb6ed，0 | 200输入，429个既有唯一目标；没有开始GPU |
| 真实贡献/隔离/证书与CPU | session29569 / 27a06a，0 | 两个子阶段实际全0 |
| 当前两端图定义CPU | ea21a0，0 | 17467节点/17466边、名称/几何/类型化参数全同 |
| 本批汇总独立CPU | 5cb7a4，0 | 当前image/固定队列/全部终态及原始统计核准 |

长程C8保持原八份SDK，预先固定三source，不新采SDK或替换失败source0。
source0四字段59/60；source1为60/55/60/56；source2为35/30/34/31；三个严格均false。
当前没有复现旧23.85速度尖峰，不能据此宣布旧问题已修复。

同一旧公共检查点只作新诊断，不恢复旧隐藏缓存，不加入任何C8数值队列。
单一第4子步NL2全部50轮、每端202真实调用，1413D2D快照/9107836字节。
1212三端回放的1512非归约输出全严格；600scalar中222严格、378失败全部保留。
400原子探针、70400实际记录、1200隔离调用、511硬件证书全过；89936硬件before值经CPU独立FTZ重算。
逐目标合法排列不证明联合全局调度或完整轨迹；14类/7812调用节点的资源属性差异仍原样保存。
所有新非阻塞诊断回放均fence H2D reset，没有修改生产同步来影响原子调度。

两个driver生成尝试在GPU前被128列门禁拒绝，修为分行后才执行。
原子prepare第一次冻结发生在模板锁接入之前，未执行GPU；旧plan/prepare以before-template-guard原字节保存。
补入实际渲染模板的SHA和严格字节校验后重新预检，实际400/1200/511调用只运行一次。
新汇总CPU脚本一行129列在执行前拆行，其后实际0；没有删除失败数据、修改采样数或预算。

## 实际命令

以下是本机实际运行命令；这些目录已完成并拒绝覆盖。接续先读status和原始日志，不重复启动。

```bash
source scripts/reconstruction_env.sh
PH=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-d09d4be9-g1-current-core
.venv/bin/python -B "$PH/run-fixed-original-C8.py"
.venv/bin/python -B "$PH/audit-current-C8.py"
.venv/bin/python -B "$PH/export-outside-frames.py"
.venv/bin/python -B "$PH/full-nl2-cg/prepare.py"
.venv/bin/python -B "$PH/full-nl2-cg/run.py"
.venv/bin/python -B "$PH/full-nl2-cg/atomic-prepare.py"
.venv/bin/python -B "$PH/full-nl2-cg/run-atomic.py"
.venv/bin/python -B "$PH/close-independent-cpu.py"
```

完整图定义对比命令保存在原调用记录；结果为`full-nl2-cg/current-graph-definition-comparison.json`。
原始worker、driver、模板、输入SHA、每个子命令和实际PID/退出码均保存在该目录。
每次自己的GPU worker串行，记录free/apps、free>=4096MiB准入，不等待或终止外部应用。
本批SDK只在明确original采集及隔离诊断进程中映射；源码正常工作进程不映射SDK、不登录。

## Windows / WSL继续

Windows仍使用WSL2/Linux Python3.12；本批不是原生Windows `.pyd`移植或WSL实机测试。
源码、处理后的Linux SDK、360pyc和已验证Linux源码ELF均随本仓库固定版本携带。
先按根交接完成WSL环境和依赖，使用新目录运行正常源码公开Core示例：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -B -m reconstruction.core_demo \
  --core-build build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/build.json \
  --report build/g1-current-wsl-report.json examples/example_robot_g1.py \
  -- --viewer null --num-frames 60 --test --solver synreal --world-count 1
.venv/bin/python -B scripts/verify_reconstruction_snapshot.py
```

上面的正常入口不会逐帧计算C8；运行退出0不能当作长程等价验收。
历史诊断plan仍固定本机绝对路径，移到其它目录时会明确拒绝，不要删SHA断言或改写旧plan来强行运行。
若需新诊断，建立新的phase，按原始SHA核对历史字节、记录旧/新路径对应，再预先固定新plan与版本。
现有已完成driver不支持直接重跑覆盖；本批没有声称验证了所有历史诊断的自动跨路径迁移。

## 接着干什么

这一批的单一NL2全部50轮已经核完；继续上游跨NL/子步的真实输入/累计力，定位G1不同响应的形成过程。
其它未覆盖host、4f/7ca与复杂布料长程仍在根状态文档；不能拿这个局部证明宣布所有demo已经一致。
新向量差异必须先核原PTX/实际ABI及SDK同输入输出；贡献相同的归约才走已有F32证书方法。
保持原始失败、版本边界、固定队列及参数，完整阶段完成后再集中提交推送。
