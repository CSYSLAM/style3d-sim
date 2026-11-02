# 粒子落布、ball_cloth、bundle、ANYmal：当前构建实测接续

上个检查点ad06d6c4完成驱动self/body-block及正式cable bend核对，尚未实现完整so替代。
本批补测用户询问的另外四个实际demo，不把基础particles三seed回归或G1当作它们的验收。
唯一原版仍为项目内固定64a0be7f，主源码host0dab/Core715及CUDA176/f0、360冻结pyc不变。

## 范围及实际已完成

| 例子 | 本次原始文件 | 三帧预期记录子步 |
| --- | --- | --- |
| 粒子落布 | examples/example_cloth_particles.py | 30 |
| 弹性球落布 | examples/example_ball_cloth.py | 6 |
| Cable bundle | examples/cable/example_cable_bundle_hysteresis.py | 30 |
| ANYmal D | examples/example_robot_anymal_d.py | 12 |

保持场景、求解器、迭代数及默认world/segments配置；短程A/B仅统一为eager逐子步采集。
三帧不足以覆盖落布碰撞、稳态或全部物理测试，不能作为整个demo通过的结论。

已修验证入口：`reconstruction.demo_ab._parser_for`现在优先调用实际`Example.create_parser()`。
旧实现对所有cable直接用generic parser，缺少bundle构造函数读取的segments/eps_max/tau/no_dahl字段。
只调整解析器选择次序，两端使用同样真实默认参数；旧helper副本及SHA保留，求解数学不变。
已在CUDA隐藏的实际模块导入中核准bundle默认四参数和显式CLI覆盖，并重现旧parser缺字段；
同进程核准bend全部默认参数与旧helper一致，实际加载公开Core715类型但未构造或step solver，CPU工具实际退出0。
历史证据若需恢复旧helper，使用ad06d6c4的独立checkout，不为迁就新helper去改旧审计输入SHA。

ANYmal的20份资产已从固定261cd1f4缓存逐字节复制到仓库，含原LICENSE，总4317058字节。
新restore_reconstruction_anymal_assets.py已实测fresh恢复及幂等重验，全部SHA同；不覆盖不同已有资产。
另通过真正newton.utils.download_asset验证fresh及TTL过期的同一缓存选择和20文件SHA，禁止Git网络命令，CPU实际退出0。
OpenUSD CPU核准17个刚体、16个关节及16个本地已解析依赖；OmniPBR.mdl的30处未解析引用均来自Shader属性。
该材质依赖原样保留，不声明所有渲染依赖齐备，也不借CPU组合宣称Newton/GPU仿真已经通过。

USD CPU审计v1因要求所有引用都解析而实际退出1；v2只查Stage.Traverse，遗漏被实例化的材质库，实际退出1。
v3查所有实际Sdf.Layer的AttributeSpec及Shader owner，实际退出0。三版脚本/失败receipt均保留，资产未改。

## 两个已启动的串行任务

证据及原脚本目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-official-demo-four/`。

- `run-short.py`/工具session70166：四demo各原版、源码三帧，共8worker；每次启动前要求GPU空闲。
  原版固定SDK64a，源码通过当前0dab的C++ bridge运行且退出前核原版SDK未映射；整个worker逐子步保存四类状态。
- `run-normal-core.py`/工具session99307：等待同一short队列结束，再对短程源码成功的例子跑真实公开Core715入口。
  不用A/B bridge、不替换capture，保留例子原始CUDA Graph路径；未成功的短程明确skip，不当作正常入口通过。

每份实际PID、boot_id和start_ticks见`short-waiter-identity.json`及`normal-waiter-identity.json`。
准备检查点不计任何新GPU通过项；status和worker日志是持续变化的现场输出，未完成时不纳入不可变封存。
不能只看计划、等待文件或观测超时就重启旧任务。先从原工具取得终态，或核同一/proc身份是否存在。

```bash
source scripts/reconstruction_env.sh
four_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-0dabbaa7-official-demo-four
.venv/bin/python -B -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["complete"],d["completed"],d["error"])' \
  "$four_phase/short3/status.json"
.venv/bin/python -B -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["complete"],d["completed"],d["error"])' \
  "$four_phase/normal-core3/status.json"
nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader
```

## 完成后的核对与下一步

1. 分别读取八个worker实际退出、runtime镜像SHA、source kernel计数及每份原始NPZ；不要从driver退出0推断数值通过。
2. 重读实际状态，在CPU独立复算strict/finite/长度；失败保留首次结果，不选更好的一次代替source0。
3. 对已能运行的场景继续原配置至少60帧；球/粒子三帧未触碰布料，必须实际覆盖接触后的传播。
4. 对失败先区分验证入口/资产/原版自身错误、源码明确guard、同输入数值分支，回固定SDK/PTX及真实输入定位。
5. Core715的正常入口成功也只说明实际测试范围内运行，Graph结果、长程一致性及test_final另验。
6. 新GPU结果取得后再封存动态文件、刷新总快照、写实际退出及独立CPU结果，提交并推既有分支。

Windows继续WSL2，先按主交接恢复工具链和依赖，再执行ANYmal离线恢复命令；不能把旧机器PID迁到新机器。
若旧队列真实结束且需新测试，使用新的输出目录，两个脚本均拒绝覆盖已有结果。
