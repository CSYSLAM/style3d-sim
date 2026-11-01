# 求解器源码重建交接：Windows 接续（2026-10-31）

> **活动源码6a7061d7：无drive固定/球关节的PD/body-block。**
> 16组状态/6096调用/首force buffer严格，四种构造五项同，graph64/64及双端initcheck全过；ready=False。
> 见[UNDRIVEN_JOINT_HOST_RECOVERY.md](reconstruction/csrc/UNDRIVEN_JOINT_HOST_RECOVERY.md)。

> **前一86916989：普通spring/point-line/distance的PD/body-block。**
> 24组固定原版状态/8952调用/首force buffer严格，6种构造五项同，graph96/96严格，双端initcheck零错误。
> 当前74为70严格，固定C10仅1/4过；三项继续定位，ready=False。见[PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md](reconstruction/csrc/PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md)。
> SDK64a、CUDA176/f0与360个pyc固定字节不变，Windows继续使用WSL2。
> 三项固定失败的后续证明：两份SDK逐位目标见证及布料完整804算子路径，见
> [CURRENT_FIXED_FAILURES_86916989.md](reconstruction/csrc/CURRENT_FIXED_FAILURES_86916989.md)，原C10 false保留。

> **前一5bd9722e：driven joint + body-block。**
> 八组状态/17052次完整owned参数与geometry全严格，四种constructor五项同，32组合长程graph共128/128严格，双端initcheck零错误。
> 当前完整74未采，ready=False；见[DRIVEN_JOINT_BODY_BLOCK_RECOVERY.md](reconstruction/csrc/DRIVEN_JOINT_BODY_BLOCK_RECOVERY.md)。
>
> **前一c189db81：补齐PD driven joint点线调度并按实际SDK恢复joint构造。**
> 同四份固定SDK原版，三步状态/7200次完整owned参数及geometry全部严格；两种joint constructor五项同。
> 16组合graph60共64项全严格，双端各32条×3步initcheck零错误；旧失败均保留，未放宽核对。
> c189完整74为71严格，三个固定C10全过且CPU复算同；两个独立source入口真实graph自身test均过。
> 见[DRIVEN_JOINT_PD_HOST_RECOVERY.md](reconstruction/csrc/DRIVEN_JOINT_PD_HOST_RECOVERY.md)。
>
> **前一04b46fb0：新增SO3/tet legacy软接触及无external contact的self组合。**
> legacy在131c9873的16组/64项graph全严格；当前04的self W1八组严格、W3八组状态有差异，
> 首buffer、完整owned ABI/geometry、constructor五项均同，四组initcheck3零错误。
> self固定C8为full15/16、diagonal16/16；唯一失败source0保留并继续定位。
> 当前完整74为71严格，三个particles首次失败均通过当前固定C10且CPU复算同；ready=False。
> 直接源码入口已跑通真实graph与自身test：Dzhanibekov60帧、plastic bag3帧，未映射原版so。
> 方法、原始证据和接续命令见[BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md](reconstruction/csrc/BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md)。
> 粒子旧失败完整路径204 packet及84归约的实际回放已闭合，原固定C10仍false；见
> [PARTICLE_FIXED_PATH_RECOVERY.md](reconstruction/csrc/PARTICLE_FIXED_PATH_RECOVERY.md)。
>
> **历史8f4127f0：SO3 body/tetrahedra实际full-surface软接触。**
> 16组三步状态/160份buffer/8824次完整调用全同，64项60步eager/graph比较全同，
> 构造五项全同，original/source各32条×3步initcheck均零错误，补充63次view指针语义绑定全同。
> 完整74为71严格；三个particles首候选固定C10两过一失败，已复现seed1并定位首个PCG原子归约差异。
> 当前结果、命令及限制见[BODY_TETRAHEDRA_CONTACT_RECOVERY.md](reconstruction/csrc/BODY_TETRAHEDRA_CONTACT_RECOVERY.md)。
>
> **前一源码image b9456031：按原版恢复SO3 body/tetrahedra组合。**
> 八组状态/buffer/ABI全严格，32项60步eager/graph比较全同，原版/源码initcheck3均零错误；
> 构造五项审计全同，74项为70严格、4份固定首次差异C10通过，CPU复核吻合。见
> [BODY_TETRAHEDRA_HOST_RECOVERY.md](reconstruction/csrc/BODY_TETRAHEDRA_HOST_RECOVERY.md)。
> 上一ff34的实现、原版证据和局部验证见
> [AFFINE_SURFACE_HOST_RECOVERY.md](reconstruction/csrc/AFFINE_SURFACE_HOST_RECOVERY.md)。
> 续接阶段检查、源码形态实验、独立原版holdout见
> [SURFACE_STAGE_ISOLATION.md](reconstruction/csrc/SURFACE_STAGE_ISOLATION.md)。
> 下文8fb9d2ee的结果是Git 76facc7时的冻结基线，不能算作当前image全部通过；原固定失败仍保留。

本文件是当前交接入口，优先于旧交接中的阶段性说明。
仓库：<https://github.com/CSYSLAM/style3d-sim>。
分支：`reconstruction/windows-handoff-20261031`，从本机项目 `e74e136` 建立。

## 1. 目标与当前结论

目标：根据实际原生库及逆向分析，恢复可编译的 CUDA/C++ solver，最终用同一 demo、同一输入，
对照固定原版和源码编译版，核对每个子步状态、调用和内部缓冲区。
源码求解器自身不登录，也不加载原版 `_core.so` 来代算。

**完整替代尚未完成，不能宣称“全部一致”。** 当前 `solver_api_ready=False`。
当前176个CUDA入口已重建并纳入版本清单，host组合场景和正式demo仍需继续验收。
Git 76facc7的交接只迁移冻结基线；后续25/cc/ff新增host字段和按原版恢复调度，CUDA数学和比较标准未改。

**前一86916989检查点**：三类普通约束24组状态/首buffer/8952次完整调用全严格；
六种constructor五项同，graph96/96、双端initcheck3均通过。完整74为70严格，固定C10仅1/4过，另三份source0保持失败。

**前一5bd9722e检查点**：joint/body-block八组已严格、四种构造五项同，graph128/128与双端initcheck已通过；
5bd未单独收集完整74，不能继承c189结果。

**前一c189db81**：PD关节四组已严格，两种构造五项同，graph64/64、双端initcheck3均通过；
完整74为71严格，其三个固定C10全过且CPU复算同。

**前一04b46fb0检查点**：self固定full C8的W3/PD/body-block首候选仍失败，diagonal16/16通过。
完整74为71严格，其三个particles首次失败的当前固定C10均通过、CPU复算同；局部结果与直接源码运行命令
以顶部新增文档为准。新增`reconstruction.source_demo`可运行未改示例的真实入口，不需A/B worker或原版so代算。
CUDA176/f0及参考64a始终不改，不把任何历史image结果直接计为当前验收。

**历史8f4127f0检查点**：body+tet+full-surface软接触16组与64项60步比较全部逐位同，构造五项同，initcheck零错误。
无contact tet graph为32/32，246配置同；完整74为71严格，三个particles固定C10为seed2/3过、seed1失败。
seed1目标轨迹已逐字节复现，首个PCG差异由同输入实际SDK回放和精确F32次序见证解释，C10仍保留false。
不能继承b945的统计结论；后续legacy与self工作见顶部新增文档，不直接删除未捕获guard。

**前一b945检查点**：body+tet新增八组状态/buffer/ABI严格相同，eager/graph60步32项全同，
完整构造五项审计全同；完整74项70严格，另四份固定首次输出的C10通过且CPU重算同。
surface/legacy cloth graph仍有严格差异，未收集b945自己的surface/cloth C8或正式大demo 3/8 cohort。
不得继承ff34的统计结论，也不能用新结果销账旧固定失败。
body/tet full-surface软接触在8f4127f0局部核对；legacy在131严格，self在04继续定位，hard等范围仍有guard。
详细命令与当前结果以顶部最新链接为准；下文第4至7节保留历史过程。

此前ff34：旧W3固定失败保留；新增body/full-surface/rolling、32block上限、单世界默认shape tile均按
实际原版调用/反汇编恢复。正式cloth_balls可完成60帧物理检查、5214次调用参数与geometry同，
但固定整段C仍失败；ff最终队列与剩余差异见新增交接，不能宣称完整替代。

此前ff检查点：74项回归为71项逐位一致，另外三个粒子首候选固定C10通过；246配置检查相同，
surface与正式大demo的initcheck3均零错误。surface/旧cloth固定C8分别10/16、13/16，仍未通过。
正式大demo原版8次样本保持不变；两种模式的新源码各3次物理检查通过，固定整段C仍失败。
原始NPZ、失败报告、实际调用抓取和源码构建检查点均已纳入本分支，不需从另一台电脑找临时目录。

## 2. 固定版本：实际二进制在同一个仓库

`style3d-sim-bin/` 已从子模块变为本仓库普通目录。
Linux `.so`、Windows `.pyd` 均为实际Git文件，不是gitlink或LFS指针。
项目现有 `.pyc` 同样保留提交；不包含 `.venv` 或账号配置文件。

| 文件 | SHA256及用途 |
| --- | --- |
| `style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so` | `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63`；当前唯一原版对照，用户处理版，无需登录 |
| `build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so` | `6a7061d769946498b59c3d10b6ede7f843ff73b973e9d2ebe0cbb669725803f4`；当前源码host image；869/5bd/c189等历史检查点保留 |
| `style3d-sim-bin/Linux/Release/_core.cpython-311-x86_64-linux-gnu.so` | `d6ad63fcd3d46e12382fa6f8a220a461efe1bd33a2a1102786607f0e1c441331`；现有SDK随行，未用作当前对照 |
| `style3d-sim-bin/Windows/Release/_core.cp312-win_amd64.pyd` | `4ffb334893d2f2431dc00ae11ca626755157d7b7cfc99d08889dd413898b8b18`；官方Windows文件，未证明与处理版Linux等价 |
| `style3d-sim-bin/Windows/Release/_core.cp311-win_amd64.pyd` | `dcbf828f726ebba3241671332c7339264859f9f0a0ca9c40f725ad87cd4bd7f3`；同上 |
| `reconstruction/references/legacy-4c223854/_core.cpython-312-x86_64-linux-gnu.so` | `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`；旧内核测试需要的历史原版，不用于当前host验收 |

SDK原子仓库版本：`23fb797e642ebefd3540fc64c6e18d31920eee94`。
其中 `git_commit.txt` 的 `58bbc788…` 是它携带的solver源版本标记，不是SDK仓库提交。
当前CUDA入口：**176 = 自有129 + 辅助47（Thrust22 + CUB25）**。
CUDA digest：`f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a`。
旧文档的188/131/57、27个CUB等属于不同历史清单，不能用作当前计数。

`RECONSTRUCTION_SNAPSHOT.json` 固定交接文件长度和SHA256，也覆盖 `.pyc`。
`.gitattributes` 保留精确字节，避免Windows自动换行破坏源码hash。
不要拉上游SDK、运行 `git lfs pull` 或重做二进制补丁覆盖处理版。
有意修改源码并重编译后image会改变，要保存独立检查点与新验证记录，保留这次Git快照。

## 3. Windows新电脑：用WSL2继续本轮Linux验证

固定对照是Linux ELF/CPython3.12，不能在Windows Python里加载。
建议WSL2 Ubuntu22.04 x86_64；随行Windows `.pyd` 没有被证明是同样处理版，
源码构建脚本及 `/proc/self/maps` 检查目前也针对Linux。原生Windows移植尚未完成。

PowerShell，首次安装WSL时以管理员运行；已有安装不必重装：

```powershell
wsl --install -d Ubuntu-22.04
wsl --update
wsl -l -v
```

确认Ubuntu的VERSION=2。Windows安装支持该显卡的NVIDIA驱动；WSL使用其提供的CUDA driver，
不要在WSL内安装Linux显卡驱动。
依据：[Microsoft WSL安装](https://learn.microsoft.com/en-us/windows/wsl/install)、
[NVIDIA CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/)。

以下全部在 **WSL Bash** 执行，仓库放在Linux home中：

```bash
sudo apt-get update
sudo apt-get install -y git build-essential python3 curl ca-certificates pkg-config \
  libgl1 libegl1 libxrandr2 libxinerama1 libxcursor1 libxi6
mkdir -p ~/code/agent
cd ~/code/agent
git clone --branch reconstruction/windows-handoff-20261031 --single-branch \
  https://github.com/CSYSLAM/style3d-sim.git
cd style3d-sim
export PYTHONDONTWRITEBYTECODE=1
python3 scripts/verify_reconstruction_snapshot.py
```

**先校验再安装/运行**，应为 `failures=0`。不需要 `--recurse-submodules` 或Git LFS。
私有 `synreal-solver` 源仓库未携带，也不需要它：我们恢复的源码在 `reconstruction/csrc/`。

安装uv（已有则跳过），重建环境：

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source "$HOME/.local/bin/env"
uv python install 3.12.13
uv venv --python 3.12.13 .venv
uv pip install --python .venv/bin/python -r requirements-reconstruction.txt
uv pip install --python .venv/bin/python --no-deps -e . \
  -Ccmake.define.SYNREAL_SOLVER_USE_PREBUILT=ON
.venv/bin/python scripts/restore_reconstruction_toolchain.py
source scripts/reconstruction_env.sh
nvidia-smi
.venv/bin/python -c 'import warp as wp; wp.init(); print(wp.get_device("cuda:0"))'
```

Python包安装需要网络；CUDA12.4编译器从本分支三个NVIDIA原始压缩包恢复，按原始redistribution JSON校验SHA。
不需要自动安装Torch、cuDNN、Open3D。精确Python包版本在 `requirements-reconstruction.txt`，
不要用完整examples/locomotion同步替代。editable安装使用scikit-build构建隔离，安装仓库固定原版二进制。

每个新Bash都要 `source scripts/reconstruction_env.sh`：配置nvcc12.4、运行库、WSL driver链接路径、
打包的CUPTI13诊断运行库，并设置 `PYTHONDONTWRITEBYTECODE=1` 保留提交的pyc。
本轮也携带实际用过的Compute Sanitizer（2026.1.0.0/build37182542）；完整验证队列直接使用项目内工具，
不用旧机器的 `/usr/local/cuda-13.2`。先运行 `compute-sanitizer --version` 核对环境。
CUDA12.4依然编译sm_52 PTX，由显卡驱动JIT；不要改成sm_120或用CUDA13编译旧目标。

检查来源和标记：

```bash
.venv/bin/python -c 'from reconstruction.csrc.host_particles_ab import native_source; m=native_source(); print(m.__file__, m.source_only, m.solver_api_ready)'
.venv/bin/python -c 'from reconstruction.csrc.host_api_probe import load_reference; m=load_reference(); print(m.__file__, m.is_logged_in())'
.venv/bin/python scripts/audit_handoff_cohort.py
```

第一条应为source_only=True、solver_api_ready=False；第二条处理版为True，不用输入账号。
第三条离线重算固定首次失败的C8，预期 `saved_report_reproduced=true`、**`primary_c_passed=false`**。
退出0只说明交接的原始数组重算吻合，不表示solver通过。
没有NVIDIA GPU仍可做文件校验和离线C8，不能做GPU验收。

## 4. 已经做了哪些：以8fb9d2ee image为准

已接入粒子/弹簧、布料/弯曲、tet、drag、静态surface、刚体/接触、关节、cable、fluid、granular、
自碰撞等host分支；不同组合仍有保护条件。详细范围看当前 `build.json.supported_physics` 和
`source_solver.cpp` 检查，不能把支持某个分支说成所有组合都通过。

最近恢复：共享D/L矩阵；SO3→bending→self→surface顺序；D0..D5/L0..L6和local/global row独立构造；
初始质量项、affine/SO3缓存顺序；typed字段清零；self tangent按需准备及capture mode2恢复；
primitive AABB之后再初始化四个BVH builder workspace。这些修复没有改176个CUDA入口或归约数学。

当前证据根目录 `build/reconstruction-csrc/affine-particle-material-host/validation-8fb9d2ee/` 已整体提交。

| 检查 | 当前结果/报告 |
| --- | --- |
| 无实际接触W3 constructor | 分配释放96/上传28/typed initializer57/owned指针502/kernel时序567，五项全同；`constructor-audit.json` |
| 实际接触block/spring constructor | 95/28/57/646/711，五项全同；`contact-case-constructor/audit.json` |
| body+particle pair | 原版8组、源码8组严格通过；`body-pp8/report.json` |
| body+cloth8组 | 7/8严格通过；末组状态失败，owned ABI/buffer/coverage通过；`body-cloth8/report.json` |
| eager/graph各60步 | 27/32严格比较通过；`body-cloth-graph60/report.json` |
| 固定3源码/8原版完整worker C8 | 16条轨迹15条通过，末组graph固定source0失败、未替换；`body-cloth-graph-cohort8/report.json` |
| 当前完整74组 | 70组严格通过；particles seed1/2/3及mixed_cloth seed3失败；`regression/status.json` |
| 正式demo | 上述回归中的7个demo各60帧严格通过，不是所有demo通过 |
| self contract | 246项同；`self-contract246/` |
| 当前initcheck | 16条轨迹各3步0错误；`graph-initcheck-source3/`；不能称当前做了60步initcheck |

constructor五项同只覆盖实际捕获项，不代表所有CUDA API、opaque view字段、非initializer库调用geometry、
全部copy/clear语义都核对过。当前74组的4项失败还没有当前image的固定C10，不能继承旧image的通过结论。
image hash必须与结果 `runtime.json`/`build.json` 一致。

当前严格通过的7个正式demo：`example_basic_dzhanibekov`、`example_body_spring`、
`example_distance_constraint`、`example_body_point_line`、`example_physical_pendulum`、
`example_joints`、`example_basic_joints`，每个60帧。其余demo不能从这7个的结论外推。

## 5. 当前问题与最近排查

失败fixture：`w3-newton-b1-d1-c1-s1-p1-1`，最后的1是graph。
b1=body block，d1=diagonal-only，c1=实际接触，s1=self，p1=spring。

固定完整worker source0按8次真实原版LOO spread比较：body_q60/60、body_qd58/60、
particle_q39/60、particle_qd51/60步在范围内；rigid/soft count均60/60。
source1/source2通过并与多条真实原版完整轨迹逐位相同，但不能替换source0。
`body-cloth-graph-cohort8/source0/source-w3-newton-b1-d1-c1-s1-p1-1.npz` 是必须保留的首次失败。

已经做过的排查：

- 短3步固定C8：source0/source1四种状态均0/3、source2均3/3，9个新增worker的owned ABI/coverage仍同。
  见 `short-cohort8/`、`short-cohort8-owned-and-primary-audit.json`。
- 对既有25条同fixture真实原版的存在性匹配，没找到完整source0匹配；没有将它们加入C8改变门槛。
- contact graph同步dump的中间buffer可以相同且整条轨迹同，但观察器改变了执行轨迹；
  见 `contact-graph-trace-audit.json`，不能推翻原失败。
- 最新 `cloth_graph_post_step_probe.py` 只在已有state.numpy完成后读现有缓存，
  不新增GPU分配、不加graph node、不改参数。1原版+3源码已完成，数据在
  `post-step-probe-retry-layout/{original0,source0,source1,source2}/`。
- 这四次都未复现固定失败source0的第一步或完整60步。最后NL中first-CG numerator bits同为
  `0x3d1675ce,0x3d1675ce,0x3d167448`，rhs也相同。读的是**last nonlinear iteration**，
  不是最早分歧时刻，因此根因仍未找到；见 `fixed-first-step-comparison.json`。
- 初次probe错误去掉affine proxy particles导致shape断言失败，改为实际 `(36,3)` 后重跑。
  失败与成功记录都保留，没有替换固定候选。

早期无接触NN graph曾定位CG group2 numerator一ULP差异，并找到真实12项贡献的F32排列见证。
那是不同fixture/image，不能直接解释当前contact graph。旧实验和失败都写在WORK_LOG中。

## 6. 继续做什么、怎么做

1. 校验快照、离线重算固定C8；先不要升级库或全量重编译覆盖活动image。
2. 从 `affine_cloth_scene.py`、`affine_cloth_graph_ab.py` 的完整worker/capture上下文，
   继续查contact graph首次不同输出。保持前置fixture顺序、分配身份、stream和capture顺序。
3. 补查constructor未覆盖的opaque view字段、copy/clear、非initializer library geometry。
   不确定就看实际so反汇编、调用参数与缓存，不能猜常量。
4. 用post-step的rhs/inverse/body indices/flags等做同输入重放，但先证明重放关联到原失败路径。
   插桩若改变第一步，只算诊断样本，不能代替首次失败。
5. 有真实证据再修host，重编译成新image，独立输出目录，以同一固定协议复验。
   当前74回归4项严格失败也需在新image闭合。
6. 再恢复被guard拒绝的组合：body+tet/full-surface，material+constrained/fluid body，
   cable与约束、非SO3部分材料组合等。`SourceSurfaceView` 的body字段/kind仍要看实际原版，不能删guard硬跑。
7. 之后逐个正式demo验收；`example_cloth_balls.py` 还需要body+full-surface，不能说已经支持。
8. 全部通过后才改默认加载路径、做drop-in `_core.so`、设置 `solver_api_ready=True`。

标准保持：A同输入逐位；B真实F32原子贡献的精确加法顺序见证；C至少5次实际原版，
按逐数组逐记录步的原版LOO spread（当前主线固定8原版/3源码）。
先做strict；C通过也要保留strict=false，不能写成逐位通过。
不能放宽容差、改数学/归约顺序、筛选成功source0或不断加原版把失败挤成通过。
GPU worker串行；活动GPU测试期间不编译/改生产源码。保留来源hash检查。
每一批往 `reconstruction/WORK_LOG.md` 记image、命令、通过/失败、观察器影响和下一步。

## 7. 命令：新输出目录，保留旧证据

仓库根目录执行，每个新Bash先 `source scripts/reconstruction_env.sh`。
输出目录每次换新名字。重编译会改变本次快照文件的hash，应先保存这次Git提交。

```bash
# 有意修改host之后才重编译；不要先重建accepted native bundle。
.venv/bin/python -m reconstruction.csrc.build_host

# 无GPU重算已保存固定C8。
.venv/bin/python scripts/audit_handoff_cohort.py

# body/cloth及实际owned ABI、buffer：先原版后源码，串行。
.venv/bin/python -m reconstruction.csrc.affine_cloth_ab --backend original --frames 3 \
  --output build/windows-check/body-cloth-original
.venv/bin/python -m reconstruction.csrc.affine_cloth_ab --backend source --frames 3 \
  --references build/windows-check/body-cloth-original --output build/windows-check/body-cloth-source

# 完整worker eager/graph60步；目前可能非零退出，保留报告。
.venv/bin/python -m reconstruction.csrc.affine_cloth_graph_ab --frames 60 \
  --output build/windows-check/body-cloth-graph60

# 正式demo源码A/B。直接执行example默认仍可能是原版/其他solver，不代表源码验收。
.venv/bin/python -m reconstruction.csrc.demo_source_ab \
  --example examples/example_body_spring.py --frames 60 --output build/windows-check/body-spring

# 完整74回归耗时较长，当前已知4组strict失败不是安装失败。
.venv/bin/python -m reconstruction.csrc.joint_continuation_regression \
  --output build/windows-check/regression

# 最新probe只用于诊断，不替换固定失败候选。
mkdir -p build/windows-check/probe-source
.venv/bin/python -m reconstruction.csrc.cloth_graph_post_step_probe --backend source \
  --frames 60 --output build/windows-check/probe-source
```

换机器后记录新GPU/驱动/WSL信息，在同一新机器串行跑原版和源码。
旧结果能验证搬运文件未变，不能直接证明新GPU逐位一致。

## 8. 问题处理

| 现象 | 处理 |
| --- | --- |
| `.so` 只有100多字节/LFS指针 | 拉错分支或旧子模块；本分支是真实Git文件，先校验，不重新下上游库 |
| Windows Python加载失败 | 进入WSL Linux Python3.12；Windows `.pyd` 不是本轮对照替代物 |
| GL/GLX/X11库缺失 | 安装上面列出的libgl1/libegl1及X11客户端库；图形窗口还需可用的WSLg，先用null viewer检查 |
| `libcuda.so.1` / nvidia-smi不可用 | 检查Windows驱动、WSL2、wsl update、`/usr/lib/wsl/lib`，不装Linux驱动 |
| `libcudart.so.12` / `libcupti.so.13` 缺失 | 恢复toolchain、source环境脚本；查打包lib目录，不改so内容 |
| nvcc/CUB头缺失 | 运行恢复脚本，必须nvcc12.4.131和对应CCCL，不换系统CUDA13 |
| compute-sanitizer找不到 | 校验快照并source环境；工具在 `build/toolchains/diagnostics-13.2/compute-sanitizer/` |
| 链接找不到libcuda | source环境，检查 `LIBRARY_PATH=/usr/lib/wsl/lib:...` |
| `Rebuild source image` / `Accepted ... changed` | 核对Git和manifest；有意改host就重编译并记新image，不能删断言 |
| 旧JSON的 `/home/oem/...` 不存在 | 保留原始来源字节，读取时映射旧repo前缀到新ROOT；离线C8脚本已用相对路径 |
| 历史dump脚本找不到绝对nvdisasm路径 | 历史 `dump_*_jit.py` 仍有旧机路径；工具发现改为 `build/toolchains/diagnostics-13.2/bin/nvdisasm`，记harness变化、不改算术 |
| pyc校验变化 | 快照保留原字节；先设PYTHONDONTWRITEBYTECODE=1，不要compileall覆盖快照 |
| USD缺失 | plastic_bag.usd已提交，也可用 `scripts/generate_plastic_bag_asset.py`；其他大型资产按需获取 |
| 提示未捕获组合 | 按原版恢复缺少host，不删guard、不退回原版代算后声称源码通过 |
| 插桩后同、无插桩不同 | 记录观察效应，继续查首次分歧，不能替换失败 |

## 9. 文件导航与携带范围

- 主实现 `reconstruction/csrc/native/source_solver.cpp`；API schema、CUDA driver、surface/BVH桥在同目录。
- 内核源码在 `csrc/kernels/`、`library/`、`revisions/`。新版tet/granular/PCG以build manifest和revision为准。
- 当前主线文档在 `reconstruction/csrc/`：`AFFINE_PARTICLE_MATERIAL_RECOVERY.md`、
  `CACHE_INITIALIZATION_RECOVERY.md`、`SELF_COLLISION_HOST_RECOVERY.md`、`AFFINE_SURFACE_HOST_RECOVERY.md`、
  `SURFACE_STAGE_ISOLATION.md`、`BODY_TETRAHEDRA_HOST_RECOVERY.md`、`NATIVE_HOST_PROGRESS.md`。
- `reconstruction/WORK_LOG.md` 是过程总账，从末尾读；`csrc/HANDOFF.md` 下部包含过时阶段。
- 原始 `_re_analysis` 已搬入 `reconstruction/reference_analysis/`，含ALGORITHM_ANALYSIS_ZH、host/cuda反汇编、
  恢复草稿及测试；对应历史原版，不能代替当前176入口对照。`reconstruction/recovered/` 保留之前整理材料。
- 新/旧PTX在 `build/reconstruction-ptx/64a0be7f7a3c03cb/`、`4c223854a5a55414/`。
- 当前host/native二进制、生成头、accepted bundle、BVH object/proof、观察器、GLM1.0.1头、
  CUDA12.4原始编译包及CUPTI13诊断工具均在本仓库，不需并列SDK仓库。
- 8f冻结基线及本轮continuation、25/cc/ff验证目录整体保存，包括失败/重试、first source0、
  3/8 worker数组、C10及原始日志；五个body-surface源码/构建检查点也已随行。
  历史多GB build/checkpoint未全搬入；WORK_LOG中的旧路径不能当成本次随行的已验证证据。
- 旧根交接/部署说明在 `reconstruction/history/`，旧版本、登录、子模块命令不适用本分支。

下一位agent起始动作：读顶部PD joint最新文档、校验快照，先查c189完整回归状态，再抓joint body-block八组原版；
旧self W3及历史source0失败保留，按各自image证据继续核对，不能用新结果重判；
有差异就查实际so和捕获数据，保持计算与验收标准，分批修改、串行验证、每批记账。

## 10. 本次迁移已经怎样验证

在独立 `/tmp/style3d-handoff-checkout-7gnhkrn2` 从Git暂存区导出干净文件，重建Python环境、
恢复CUDA12.4编译器，验证原版/源码加载；16项凭据相关单元测试通过。
固定首次失败C8离线重算与保存报告精确一致，仍保留 `primary_c_passed=false`。

独立重编译最初发现GLM仍是嵌套Git仓库，主仓库未收录头文件；已移除其仓库嵌套并实际提交头文件，
再次编译通过。GLM1.0.1原提交 `0af55ccecd98d4e5a8d1fad7de25ba429d60e863`。
重新编译后的176个kernel specs（含digest/参数）全部不变。
生成的PCG PTX及bundle只有 `_INTERNAL_4847d3a6_` → `_INTERNAL_eca95160_` 标识变化，
精确替换后完整字节相同；其余build输入SHA不变。ELF还包含新的构建路径/RPATH，因此新编译image SHA为
`651d4df798dcbda4f97d67e26a0b1cd340fef180c88dbb4ff53d44f3574774eb`，不作为当前活动image切换。

固定8f产物和独立重编译产物分别跑 `example_body_spring`，各3帧12子步，四种状态全部逐位相同。
报告、日志、原始状态、两份build manifest及独立重编译产物保存在 `reconstruction/transfer/20261031/`。
这是Linux本机的路径迁移/构建自检，没有在Windows/WSL上实际测试，不能替代新机器上的完整一致性验收。
