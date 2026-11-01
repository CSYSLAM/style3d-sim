# CUDA 源码重建交接文档（给接手的 agent）

> **完整PD tangent队列已准备，GPU仍待空闲，尚无本批运行结论。**
> 213阶段实际ABI/八DAG及23类/46 PTX写指针检查已过；现有采集和后续流水线勿重复启动。
> 只发布不可变准备代码/CPU证据；实际PID、boot身份及WSL接续见[完整tangent队列](PD_CONTACT_FULL_TANGENT_QUEUE.md)。

> **PD接触RHS/CG接续：三处新增首差及第一步向量传播已实测核准。**
> 21600真实阶段、72次三端/18个F32原子顺序证书、后续更新36次完整同输入回放，独立CPU均过。
> 旧固定长程失败保持，主host/候选/阈值未改；下一步补CG extra/tangent及后期接触完整输入。
> 见[RHS与首CG差异](PD_CONTACT_RHS_CG_RECOVERY.md)。

> **PD多世界接触接续：实际graph与SO3计算核准，长程仍未过。**
> 两graph拓扑/已审计类型化参数及跨图指针模式同；960实际SO3输入、5760三端调用完整输出严格，独立CPU同。
> 原固定source0/frame32失败保留，主host0dab/Core715及候选4f均不改。
> 下一步向前核RHS/颗粒/接触与线性输入，见[PD graph与SO3核对](PD_CONTACT_GRAPH_SO3_RECOVERY.md)。

> **新增外部接触隔离候选4f638b4b，主源码仍0dab/Core715。** 六SDK支持、四短程严格、两短程固定C8过；四类构造五项同。
> 60步严格16/24、长C8全部三source为10/12，W3/subset/mixed/PD仍未过；六initcheck零错误，候选未合入。
> 原牛肉demo低分辨率三帧的固定C8/独立CPU通过；不能外推默认配置或长程。见[接触恢复记录](GRANULAR_AFFINE_CONTACT_HOST_RECOVERY.md)。

> **当前主源码0dabbaa7 / Core7151054e已合入bonds/刚体恢复。** 新image的16短程、graph24、正常Core3及103/57/246合同均过。
> 当前74已终态：69严格，五项首失败固定C10为四过一未过；Newton mixed仍失败，CPU独立复核同。
> 当前三类constructor五项全同，driver真实0；不继承旧dec通过项，readyFalse/default原版保持。[当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先。

> **dec当前验收已终态：74为71严格，三粒子固定C10全过、constructor五项同。** bonds/刚体SDK六组支持已实证。
> 隔离EFE六短程全严格、三类构造五项全同、60步graph24/24及双端六initcheck零错误；待生产合入及新image回归。
> 旧G1/复杂布料失败不改、readyFalse；[当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于历史。

> **当前dec/Core47：完整74已结束，71严格；三粒子首失败C10仍待GPU。** 当前constructor及bonds支持发现依次排队。
> bonds隔离源码已据固定so构造/七处参数调用恢复并编译，26helper同；尚无本组合GPU结论，生产与readyFalse保持。
> [当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于下方历史记录，不继承旧image的C10通过项。

> **当前host dec858e5/Core47ae9720已完成三正常入口。** 四短程、六扩展布局和60步graph16项本次全严格，原版未映射。
> 74/fixedC与当前constructor继续排队，readyFalse；通用初始化decoder已以原始两批数据核准，不改旧失败。
> 下一步带bonds颗粒/刚体实际支持发现；[当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先，下方为历史记录。

> **生产合入进行中，尚未验收。** 新host dec858e5恢复颗粒/SO3缓存及准入，CUDA176/f0保持。
> 首guard误拒绝自由DOF已据真实字段修复；新版串行验证session91260等待外部GPU，不能继承host38的71/74。
> 匹配新版Core尚待构建，默认后端不切换、readyFalse；[当前整体状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于下方历史记录。

> **2026-10-31 Windows迁移入口：[当前根交接](../../RECONSTRUCTION_HANDOFF.md)。**
> 本文件下部保留历史过程，其中188入口、旧参考路径、禁止提交和仅准修改两个目录等属于旧阶段。
> 当前用户已授权整理项目、固定处理版so/pyc、建立新分支并提交到CSYSLAM/style3d-sim。
> 当前176入口、8fb9d2ee image、固定C8失败和Windows/WSL步骤，以根交接为准；完整替代仍未完成。

> **最新8fb9d2ee：constructor捕获全部对齐；body/cloth首次contact轨迹仍未通过，完整solver未完成。**
> 4f已恢复真实self tangent lazy prepare/capture mode2；initcheck60为0，但八组7/8、graph27/32，失败保留。
> 4f typed57/57、uploads28/28、502 owned指针同；96分配与567 owned+library时序发现primitive AABB和4个init反序。
> 8f只按实际原版移动builder缓存至primitive后，数学/归约/CUDA176 f0均未改；helper24/24规范化PTX同。
> constructor96/28/57/502/567五项全部同；body/PP8严格；graph27/32，固定C8为15/16，source0失败不替换。
> initcheck3为0、246 config同；完整74仍在跑，之后核对失败contact fixture和真实graph buffer，见WORK_LOG。
> 7018完整74为70严格（3粒子seed+NN mixed seed3失败），旧失败/检查点均保留；不继承旧image通过率。
> 下方所有旧image提示为历史；solver_api_ready=False，完整替代仍未完成。

> **当前：0b7621b3；接入SO3 body+cloth/bending，实际八组验证中。**
> 按真实原版共享矩阵延后particle模板，恢复SO3→bending tangent；CUDA176/f0未改。
> 当前八组4292调用/65buffer/全状态严格，完整W1模板10项严格；graph60为28/32严格。
> 两个W3 self graph固定C8仍失败（16轨迹14过）；initcheck原版0/source29160错误，正在核对实际模板初始化。
> 085完整检查点461源/构建、1653结果SHA独立复核0差异；其body/spring八组3772调用/70buffer和graph32同。
> 085完整W1模板10项同，完整74为71严格、三固定首次source C10过、246配置同，self/surface复测严格。
> 辅助47在00f完成三seed10422项实测0失败，CUDA digest一直f0，见CURRENT_AUXILIARY47_RECOVERY.md。
> body+tet/full-surface、其它未捕获组合仍保护；完整solver未完成，solver_api_ready=False。
> 旧d3cb/929/d1a失败与正式demo尚未全部闭合；接手看AFFINE_PARTICLE_MATERIAL_RECOVERY.md和WORK_LOG末尾。
> 下方image提示均为历史。



> **活动 image：50effa1b，恢复self+spring/tet/drag；56组材料组合核对中。**
> 当前SHA50effa1b50881bb95b87250d9a817e402d0add2f398d380221f5839b3c33ce99，176 CUDA/f0e0137a未改。
> 按实际调用修复drag_start→block_entries顺序，关闭self控制组385次全参数、状态和9项buffer全同。
> 官方cloth+spring/tet/drag/bend damping/free PP/soft contact复合8组，224buffer、5022次完整参数全严格。
> 另32+16组仍在核对，world3 full有极小严格状态差异，未提前验收；当前完整74回归尚未重跑。
> 6faf完整检查点已保存并核验：424源/构建、71384结果SHA；71/74严格、三粒子固定C10通过。
> 6faf bag固定三source对32原版既定分布观察通过，严格仍false；不能说每个速度子步都C内。
> body/fluid/granular/surface与self组合仍拒绝；完整目标未完成，solver_api_ready=False。
> 接手见[SELF_COLLISION_HOST_RECOVERY.md](SELF_COLLISION_HOST_RECOVERY.md)与WORK_LOG.md末尾。



> **更新：当前继续恢复 cable/hard-contact/body-block host；完整目标仍未完成。**
> Cable在225208b0的24组720子步、420个penalty快照及538项API行为全部相同；
> hard在d950ad0a的24组720子步全部相同。814c5abf完成cable+block 24组、cable/contact 30组、732个内部buffer、graph及538项contract。
> 同image74组回归：70严格通过，4组严格差异固定候选经10原版按既有原子标准通过；失败保留。
> 官方analytic 600子步8原版/3源码按既有分布标准通过，13,800次完整调用同；严格仍false。
> 正继续恢复尚未实现的fluid等host，总体目标仍未完成。
> 当前顺序、命令、证据与未完成项见[CABLE_HARD_HOST_RECOVERY.md](CABLE_HARD_HOST_RECOVERY.md)。
> 下方0c44d52d为上一完整回归检查点，不能把其结果直接计为当前image的最终回归。

> **最新进度（2026-10-30）：活动 image 为 `0c44d52d…`，新增 armature 与缺省关节速度推导。**
> 新增18组、540子步严格通过；三模式354个缓冲区、2282次调用核对通过。同一 image 的74组回归已完成。
> 前一完整检查点为 `c598b144…`，已保存源码、构建、全部结果 hash。
> 刚体、接触、普通约束、关节弹簧/drive 之外，本轮又接入关节点线 Newton/AL 和关节+接触。
> 7 个真实 demo 各60帧逐位通过，包括 example_joints 的1200子步及 example_basic_joints 的240子步。
> 详细范围、修正的诊断 ABI、原始捕获和命令见 [JOINT_HOST_RECOVERY.md](JOINT_HOST_RECOVERY.md)。
> c598b144 的3seed粒子/刚体/API回归已完成，严格差异保留；链条已按用户约定的8原版/3源码分布标准通过，
> 严格 bitwise 仍不同。0c44d52d 的粒子固定候选经每seed10次原版复核通过；链条8次原版时1项未过，
> 保留同3条源码轨迹，增至16次原版后按约定分布标准通过。原失败保留，没有改物理计算或重选源码样本。
> 最新 full-launch-metadata 还核对了完整mangled symbol、3D grid/block、动态shared bytes及stream类型；
> 旧“complete”命名的审计缺这些字段，只能作为历史局部证据。完整so仍未替代，solver_api_ready=False。
> 下方1ba3/e91及“刚体未接入”等内容是历史阶段；不要把 kernel 覆盖等同完整 solver 替代。

> **2026-10-30 用户更新，优先于下面的历史基准：按项目内新版继续，源码与参考测试均不登录。**
> 当前参考：`/home/oem/code/agent/style3d-sim/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so`，
> SHA256 `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63`，Git `23fb797`（10月27日）。
> 项目外 `4c223854`/`ce8d7ba`（10月26日）只保留历史证据。新版176入口=自有129+辅助47；新增7个PCG入口
> 已源码编译且规范化PTX7/7相同，另1个变化的affine入口重新GPU核对。新C++ so只暴露当前176个kernel。
> 8个变动入口及另一affine变体经实际新编译C++ so的三seed测试1032项通过；API/错误保护已扩展到692项。
> `native/source_solver.cpp`已接入粒子/弹簧/静态粒子软接触/布料拉伸/余切弯曲的Newton和PD路径、stream/graph。
> 已从实际原版查出并修复PD接触开关分支和全部128个Span getter的值拷贝语义；C++源码没有登录API。
> **完整so还未替代：刚体/tet/流体/颗粒/cable/自碰撞/三顶点接触/drag等host未接入；solver_api_ready=False。**
> 已抓取102次真实调用，首个差异在原子归约标量；独立重放105个逐元素输出相同，aggregate仍失败。
> 详细范围、版本差异、失败记录和接手命令先读[新版进度](NATIVE_HOST_PROGRESS.md)，再读下面历史记录。
> 本轮工作详见WORK_LOG末尾；原证明检查点均已保留。最终运行的image SHA必须与各结果.runtime.json一致，
> 不得把旧image的通过结果算作新image通过。`host_particles_ab.native_source()`会拒绝未重编译的陈旧产物。
>
> **后续继续更新：活动 image `1ba3a112e2915616821eb8464d90bdec8fa52f4d66644bb2d33f124d77959b29`。**
> spring+cloth、tet、drag、静态三顶点接触已接入，正进行同一 image 回归；上方 e91阶段范围已扩大。
> 实际发现并修复历史tet force的NULL激活遗漏和局部索引错误；活动入口由`revisions/tetrahedra_23fb797.cu`
> 替换，不能使用历史`kernels/tetrahedra.cu`的错误入口。全局/NULL三seed36用例已核对，旧代码12用例确实失败。
> 增加670项浮点/向量setter比较，修复air_density/wind_velocity校验；实际组合顺序及PD分支也按原版修复。
> 仍未全SDK替代：刚体/关节/流体/颗粒/cable/自碰撞等host未接；原子累加严格差异保留，不进入完整demo验收。
> e91的241167文件manifest已通过preserved-files快照+不动的raw trace保留，不能直接验证活动源码。

请从头到尾读完再动手。这里的规则都是踩过坑之后定下的，**不允许跳步、不允许"差不多就行"**。

> 2026-10-30最新：全部188入口已有源码编译实现：131个自有CUDA入口+57个CUB/Thrust辅助入口。
> 库57入口：45个规范化PTX相同、12个仅可见性不同，指令体57/57相同；三seed GPU验证完成。
> 新源码CUDA执行层.so已构建，188个符号均可解析；通过C++执行的库测试14664项、核心组49623项。
> 见LIBRARY_AUXILIARY_AUDIT.md、NATIVE_EXECUTION_LAYER.md。该.so只有CUDA执行/内存API，solver_api_ready=False，
> Model/State/Config/Solver绑定和Newton主机调度尚未实现，完整账号demo尚未验收。下面Cable是前一批记录。
> evaluate65场景/311调用，原版和源码三seed各12944检查全过；933调用192636次采样原子写入通过。
> 详见CABLE_EVALUATE_AUDIT.md；下面的prepare/update记录是前一批验收的证据。
> prepare40场景原版/源码三seed各1266检查全通过；120调用105195采样写入通过，诊断表示处理见报告。
> update原版/源码三seed各1693检查，49调用/seed的double/float路径审计通过，共147调用4908写入。
> update没有诊断性JIT算术重写；其它模块各自的表示调整及范围仍以对应报告为准。
> 最终全量编译131定义（45 PTX-identical/86 different），自有入口0缺失。
> 57个库模板现已完成CUDA源码实例化验证；前期NumPy记录仍与新CUDA/C++执行证据分开。
> 下一步恢复兼容_core的主机调度/Python绑定，再做登录后的同demo A/B。
> cable_rotation.cuh已恢复共享惯性加权旋转，19类场景三seed共114项内部出口探针比较通过；
> 这不是完整cable入口验证，详见CABLE_RECOVERY_NOTES.md。
> 未做账号登录完整solver/demo验收，不得把188入口/低层执行.so称为host/API/demo完全替代。过程见WORK_LOG尾部。

---

## 0. 目标是什么

把旧的二进制库 `~/code/agent/style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so`
（SHA256 `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`）完全替换为**可编译的 CUDA/C++ 源码**。

验收标准（用户原话）：**"用 so 版本和源码编译版本在同一个机器上结果一致，才能说完全替代"**。

- `reconstruction/*.py` 是之前写的 numpy 版"规格"（spec），已逐位验证过与旧 so 一致。它**只是参考答案**，不是交付物。
- 交付物是 `reconstruction/csrc/kernels/*.cu`（GPU kernel 源码），以后还要加主机端 C++ 和 Python 绑定，编译成新的 `_core.so`。

已完成阶段：**131个自有kernel和57个库模板均有编译源码和本阶段逐位验证，CUDA执行层.so已生成**。
后续是host和兼容绑定，再进行完整demo验证。

---

## 1. 硬性约束（违反任何一条都算错）

1. **只能修改 `reconstruction/` 和 `build/` 目录。** 不许改 `src/`、`examples/`、`uv.lock`、依赖、旧 so。不许 git commit，不许 git reset/clean/checkout。
2. **不许放宽比较标准。** 只接受"逐位一致"（bitwise）。不许改容差，不许改测试让它通过，不许改 numpy 规格去迁就自己的 CUDA 代码。
3. **不许修改 `reconstruction/*.py` 规格里的计算逻辑**（它们代表旧 so 的真实行为）。只允许往 `reconstruction/kernel_ab.py` 里**新增**测试用例或新增 `--only` 分组。
4. 旧 so 的账号密码只能通过环境变量 `STYLE3D_SIM_ACCOUNT` / `STYLE3D_SIM_PASSWORD` 传给进程，**绝不能写进任何文件或日志**。本阶段（kernel 对比）不需要登录，用不到。
5. 不要同时跑多个原版 so 进程（demo 对比阶段才涉及）。
6. 每完成一批，往 `reconstruction/WORK_LOG.md` 末尾追加记录（做了什么、结果、发现的坑）。

---

## 2. 环境与工具（已经搭好，直接用）

| 东西 | 位置 |
|---|---|
| 编译器（必须用这个，和旧 so 同版本 CUDA 12.4） | `build/toolchains/cuda-12.4/bin/nvcc` |
| glm 头文件（1.0.1） | `build/third_party/glm-1.0.1` |
| 旧 so 的 PTX（已解出） | `build/reconstruction-ptx/4c223854a5a55414/*.ptx` |
| 我们的 CUDA 源码 | `reconstruction/csrc/kernels/*.cu`、`common.cuh`、`types.cuh` |
| PTX 对比工具 | `reconstruction/csrc/ptx_compare.py` |
| GPU 逐位对比测试 | `reconstruction/kernel_ab.py`（加环境变量 `RECONSTRUCTION_KERNELS=csrc`） |

编译参数（已写死在 `ptx_compare.py`，不要改）：
`-ptx -arch=sm_52 -std=c++17 -O3 -DNDEBUG -diag-suppress=20012`。
**`-DNDEBUG` 必须有**，旧 so 是 Release 编译，少了它 PTX 顺序会全乱。

所有命令都在仓库根目录 `/home/oem/code/agent/style3d-sim` 下用 `.venv/bin/python` 运行。

### 2.1 常用命令

```bash
# 看原版某个 kernel 的签名和 PTX（参数显示为 P0, P1, ...）
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-legacy evaluate_contact_force

# 编译全部 .cu，逐个和原版 PTX 比较，最后一行是总进度
.venv/bin/python -m reconstruction.csrc.ptx_compare

# 只看某个 kernel，并显示差异
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff evaluate_contact_force

# GPU 逐位测试（用我们编译的 kernel 替换原版 kernel；没写的 kernel 自动用原版）
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only <分组> --seed <整数> \
    > build/reconstruction-csrc/ab_x.json 2> build/reconstruction-csrc/ab_x.err; echo exit $?
# stderr 最后一行 "csrc entries: [...]" 列出实际用了我们源码的 kernel —— 必须确认你的 kernel 在里面！
# 查看失败项：
.venv/bin/python -c "import json; r=json.load(open('build/reconstruction-csrc/ab_x.json')); \
print([(k,v.get('mismatches')) for k,v in r.items() if not v.get('bitwise_equal')])"
```

`--only` 可选分组：`pcg fluid granular particle_pairs particle_query_branches springs drag affine rigid_contact rolling_contact
soft_body_contact self_accumulate self_accumulate_branches joint_springs joint_drives joint_drive_branches joint_armature_branches joint_limit_branches point_lines surface_contact step cables hard_history affine_block
hard_constraints cable_cuda pcg_templates thrust cub_scans cub_remaining lbvh self_collision self_queries mesh_query_branches cloth`。
不加 `--only` 跑全套（很慢，阶段性回归时用）。

---

## 3. 每个 kernel 的标准流程（必须严格按顺序）

1. **找规格**：在 `reconstruction/*.py` 里搜 kernel 名字（`grep -rn "<kernel名>" reconstruction/*.py`），读懂它的 numpy 实现和文档字符串。规格里的 `fma(a,b,c)`、`fms`、"y first"、"x first" 等注释是**精确的运算顺序**，必须照做。
2. **看签名和 PTX**：`--show-legacy <名字>`。看参数类型和顺序（名字修饰 mangled name 必须完全一致，所以参数类型、顺序、命名空间、模板参数一个都不能错）。
3. **看测试怎么调用**：`grep -n "<长度前缀+名字>" reconstruction/kernel_ab.py`（例如 `25evaluate_joint_drive_load`），从 `d.launch(...)` 的参数列表确认每个参数的**含义**。**参数含义只能以测试调用为准，不要猜。**（踩过的坑：`initialize_step` 第 6 个参数是主机对角、第 17 个才是质量。）
4. **写 .cu**：放进对应模块文件（见第 6 节），用已有的公共函数（第 5 节）。每个 kernel 上方写英文注释说明物理含义和非显然的约束。行宽 ≤ 128。
5. **PTX 对比**：`ptx_compare <名字>`。
   - `PTX-IDENTICAL` → 最好，进入第 6 步。
   - `PTX-DIFFERENT` → 用 `--show-diff` 看差异。**如果差异只是**：指令先后顺序、寄存器编号、地址计算顺序、可交换运算（乘法/加法）的操作数左右互换 → 最多尝试 3 种源码写法（见第 4 节技巧），还不行就接受，进入第 6 步靠 GPU 测试判定。
   - **如果差异里有不同的运算**（多了/少了 fma、`min.f32` 变成 `setp+selp`、`cvt.sat` 没了、比较符号 `le`/`leu` 不同、常数不同、加载了不同的地址）→ 这是**实质错误**，必须改到运算一致为止。
6. **GPU 逐位测试**：跑对应 `--only` 分组（第 6 节表格），要求 `exit 0`、失败列表为空、并且 stderr 的 `csrc entries` 里**确实包含**你的 kernel。
   - 如果该 kernel 在 kernel_ab 里**没有测试**，或者测试没覆盖某个分支（例如只测了 `max_count=0`），**必须在 kernel_ab.py 里新增测试用例**，并且先用原版跑一次（不加 `RECONSTRUCTION_KERNELS`）确认原版对规格也是逐位一致，再用 csrc 跑。参考 `initialize_rhs_mass_ell` 这个用例的写法。
7. **换 2 个以上不同 seed 再跑一次**，都通过才算完成。
8. 记 WORK_LOG。

**只有同时满足（PTX 一致，或差异仅为排序且 GPU 多 seed 逐位一致），才算这个 kernel 完成。**

### 3.1 GPU 测试失败时怎么查（不要瞎改）

用"双跑探针"：同一份输入，分别用原版 PTX 和我们的 PTX 跑，直接比输出，定位到具体元素/分支。
参考脚本 `reconstruction/csrc/probe_template.py`（照着改 kernel 名和参数即可）。定位到出错的输出分量后：
- 回到规格里该分量的公式，逐个检查 fma 融合位置、运算顺序、比较方向、下标。
- 典型根因见第 4 节。改完重跑探针直到 0 mismatch，再跑正式分组。

---

## 4. 已知的坑和对应写法（非常重要，都是实测得出的）

1. **`-DNDEBUG`**：必须有（已在工具里）。
2. **fma 融合规则**：nvcc 会把 `a*b + c*d` 编译成 `fma(a, b, c*d)`——**第一个乘积被融合，第二个单独舍入**。所以规格写 `fma(y,y, x*x)` 时，源码要写成 `y*y + x*x` 的顺序……但编译器有时会重排加法操作数，导致无论怎么写都融合到另一边。这种情况**直接用显式 `fmaf(...)`** 精确表达规格（已有例子：`distance_target`、`rigidity_spring_force`、`dot_x_first`、`body_spring` 长度）。
3. **`mul; mul; sub` 陷阱**：旧 PTX 里如果是两个乘法加一个减法（不是 fma），说明融合发生在更底层（ptxas），规格会注明 "ptxas fuses the subtrahend/minuend"。我们的编译器可能在更早阶段融合了**另一个**乘积 → 结果不同。处理：按规格写显式 `fmaf`（例子：`angle_jacobian` 的 `axis_term = fma(-sc, ucc, sp*upc)`；`add_joint_drive_preconditioner` 平移父侧 `fma(lever, wa, -(a*wo))`）。
   本轮两个 drive preconditioner/tangent 入口已按原 PTX 恢复自然 mul/sub，并经数据流和 GPU 验证；
   不要照这条旧示例再次批量替换。drive load 仍需保留显式 FMA，细节见 JOINT_DRIVE_AUDIT.md。
4. **min/max**：旧 PTX 是 `min.f32/max.f32` → 用 `fminf/fmaxf`；**不要用 `glm::min/max/clamp`**（它们编译成 `setp+selp`，NaN 和 ±0 行为不同）。旧 PTX 是 `cvt.sat` → 写 `fminf(fmaxf(x, 0.0f), 1.0f)`。
5. **比较符号**：`setp.leu`（无序）对应 `!(a > b)`；`setp.le` 对应 `a <= b`。NaN 时行为不同，必须和 PTX 一致。
6. **isnan/isfinite**：`std::isnan(x)` 编译为 `abs(x) <= inf` 判断；`std::isfinite(x)` 编译为 `abs(x) >= inf` 判断。按 PTX 选。
7. **glm 复合赋值**：`v -= a*b`（glm）会逐分量读写（load/store 交错）；旧代码常是 `v = v - a*b`（全部读完再写）。看 PTX 的 load/store 顺序决定。
8. **按值 vs 按引用读结构体**：PTX 里结构体字段一次性全读 → 源码是按值拷贝；用到时才读 → 引用。
9. **`std::min/std::max` 不能在 device 上用**（编译报错），用 CUDA 的 `min/max`（整数）或三元表达式。
10. **CUB 归约**：`cub::BlockReduce<float, 256>`，共享内存变量名必须叫 `reduction_storage`（名字会进 PTX）。
11. **完全展开的循环**：PTX 没有循环而源码有 → 加 `#pragma unroll`。
12. **world 拆分**：几乎所有 kernel 开头是 `world = i / per_world; local = i % per_world; offset = (int)(world * particles_per_world)`，局部元素先读，再算 offset（见已有 kernel）。
13. **未使用的参数**：有的参数在旧 PTX 里根本没读（如 `evaluate_body_point_line_force` 的 P1、P10），签名里照样保留。

---

## 5. 已有公共函数（优先复用，不要重复写）

`common.cuh`：`thread_index()`、`guarded_ratio()`、`normalized_or_zero()`、`min_components/max_components`、
`atomic_add(vec3*)`、`atomic_add(mat3*)`。
`types.cuh`：`NonZeroEntry`、`BlockNonZeroEntry`、`Aabb`、`AffineBodyRigidityModel`、`atomic_add_block()`（块稀疏矩阵按列二分查找后原子加）。
`joints.cu`：`body_point()`（刚体上点 = 4 个代理粒子加权）、`distance_target`、`PointLineGeometry`、
`point_line_projection<XFirst>`、`segment_weights`、`add_pair_blocks`、`AngleFrame/angle_frame`、
`DrivePoints/drive_points`、`drive_load`、`DriveJacobian/drive_angle_frame/angle_jacobian`、`prismatic_axis`、`drive_tangent_scale`、`JointCoordinateView`、`armature_rows/armature_coordinate`、`AngularLimitView`。
`affine.cu`：`nearest_rotation()`（极分解）、`constitutive_gradient/tangent`、`rigidity_spring_*`。
`tetrahedra.cu`：`Deformation/deformation()`、`DampingBasis`。`cloth.cu`：`hinge_vector`、`bending_edge_valid`、`stretch_projector`。

---

## 6. 当前进度（截至交接）

当前已验证131/131自有入口（45 PTX-identical、86 different），剩余自有global为0。
另57/57库辅助入口完成源码实例化：45 PTX-identical、12仅可见性不同；全部188入口源码齐全。
低层执行.so在build/reconstruction-csrc/native/，只提供Driver，未提供原Solver API。
近期审计详见SOFT_CONTACT_AUDIT.md、HARD_STATE_AUDIT.md、HARD_EVALUATE_AUDIT.md、
RIGID_CONTACT_AUDIT.md、SURFACE_CONTACT_AUDIT.md、ROLLING_CONTACT_AUDIT.md、AFFINE_BLOCK_AUDIT.md、
CABLE_UPDATE_AUDIT.md及WORK_LOG尾部。
编译计数、采样路径核对和完整solver/demo验收是不同层次，不能互相替代。

已完成并验证的模块（对应 `--only` 分组）：
- `step.cu`（step、pcg）、`pcg.cu`（pcg、pcg_templates、step）、`lbvh.cu`（lbvh）、`self_collision.cu` 中的包围盒/refit/Hessian 对角（self_collision、lbvh），以及粒子查询（particle_pairs、particle_query_branches）、3种网格查询（self_queries、mesh_query_branches）
- `drag.cu`（drag）、`springs.cu`（springs）、`cloth.cu`（cloth）、`tetrahedra.cu`（直接调用 `run_tetrahedron*`，见下）
- `joints.cu`：关节弹簧、距离约束、刚体弹簧力和 Hessian（joint_springs）；点线约束全部（point_lines）；驱动 angle state、drive load、reset（joint_drives）；
  驱动 preconditioner/tangent、coordinate velocities（joint_drives、joint_drive_branches）；armature、angular limits（另见 joint_armature_branches、joint_limit_branches 及对应核对报告）
- `affine.cu`（affine）：SO(3) 五个、扭矩、六弹簧力/Hessian、本构三个
- `fluid.cu`、`granular.cu` 的小 kernel（fluid、granular）

四面体没有 `--only` 分组，用：
```bash
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -c "
import sys, numpy as np; sys.path.insert(0,'.')
from reconstruction import kernel_ab as k
d=k.Driver()
try:
    for f in (k.run_tetrahedron, k.run_tetrahedron_tangent, k.run_tetrahedron_preconditioner):
        print(f.__name__, f(d, np.random.default_rng(4), 4000))
finally: d.free()"
```

### 6.1 已闭环的五个关节入口

`add_joint_drive_preconditioner`、`multiply_joint_drive_tangent` 的 GPU 失败、剩余算术/检查差异已经处理；
`initialize_joint_coordinate_velocities` 已新增 CUDA，mangled name 与 120B View 布局确认。
两个分组原版和源码 seed1/2/3 全通过，PTX 数据流核对写入及浮点判断零差异。
原始 PTX 仍非文本一致，具体归类及范围见 [JOINT_DRIVE_AUDIT.md](JOINT_DRIVE_AUDIT.md)。
本轮没有修改 NumPy 公式、放宽容差、修改账号认证或做 demo 验收。

`evaluate_joint_armature` 已完成三个模式、多世界/阈值/异常值/模式优先级等测试，三个 seed 全通过。
路径数据流每 seed 19 调用写入和判断零差异；初版 DAG 相同但 JIT 融合不同会产生 GPU 错误，
修复方法是保留原 PTX 中两个乘积的产生顺序，见 ARMATURE_AUDIT.md。不得只用 DAG 取代 GPU 验收。


`evaluate_angular_limits` 新增32类场景、NULL状态指针、模式优先级和异常方向等280检查，
原版/源码三个seed全通过，35次路径审计/seed零差异。PTX数学操作计数相同，少4个重复abs及一个精确互补判断，
细节见ANGULAR_LIMIT_AUDIT.md。没有修改既有CUDA入口。

`query_particle_pairs` 已新增CUDA，三世界/容量/过滤/距离边界等82检查，原版/源码三个seed全通过。
38次路径审计/seed写入地址/整数值/浮点判断零差异，静态float操作计数完全相同；见PARTICLE_QUERY_AUDIT.md。
self_collision.cu中的overlaps可供后续查询使用。

三种网格查询已核对：self_queries、mesh_query_branches，见SELF_QUERY_AUDIT.md。
self_collision.cu新增walk_mesh_bvh、compatible_groups、segment_distance2、triangle_distance2等，
后续累加核可复用，但必须逐项核对原PTX中的融合和有限性规则。

点面/粒子累加和接触切线已新增CUDA；三seed GPU与路径审计通过，见SELF_ACCUMULATE_AUDIT.md。
测试分组self_accumulate、particle_pairs、self_accumulate_branches。
60B SelfCollisionContactTangent、finite_vector/matrix、contact_stiffness位于self_collision.cu。

EE/EF累加已恢复，edge_accumulate_branches96项和三个seed均通过，见SELF_EDGE_ACCUMULATE_AUDIT.md。
opposite_contains、contact_segment_parameters、accumulate_endpoint可供参考；原13入口PTX未变。

fluid八个入口已定义，fluid/新fluid_branches验证见FLUID_ROWS_AUDIT.md。
fluid的NeighbourIterator/Smoothing用于网格遍历和核函数；model.cuh只定义核对过的Model字段。

granular八个入口已定义，granular/新granular_branches与审计见GRANULAR_AUDIT.md。
原版虽允许部分写入顺序影响不了测试输出，本轮仍按旧PTX恢复count/force/diagonal和history/rest先后。

hard历史快照和cable penalty初始化见STATE_INITIALIZATION_AUDIT.md。
HardContactView312B现已全部字段恢复，hard四入口已闭环；详见HARD_STATE_AUDIT.md和HARD_EVALUATE_AUDIT.md。

soft两个入口已闭环，soft_contact/soft_body_contact/soft_contact_branches见SOFT_CONTACT_AUDIT.md。
contact_geometry.cuh共享body映射和sphere变换；不要去掉soft offdiag摩擦对角的显式FMA，已由旧JIT SASS确认。

### 6.2 缆绳入口已全部完成

| 模块 | kernel（PTX 行数） | 测试分组 / 规格位置 |
|---|---|---|
| 线缆 | `prepare_cable_tangents`、`evaluate_cables` | cable_prepare、cable_evaluate；完整源CUDA，已验收 |

缆绳共享rotation/world frame/strain/导数及完整update/prepare/evaluate均已恢复。
具名公式、寄存器映射、原PTX标签及命令见CABLE_RECOVERY_NOTES.md及三个CABLE_*_AUDIT.md。

结构体（View/Model）规则：字段顺序、类型、对齐必须和旧 so 完全一致（看 `.param .align 8 .b8 P0[字节数]` 和 PTX 里 `ld.param [P0+偏移]`），
字段名按 kernel_ab.py 打包函数的含义起名。结构体写进对应 .cu 或 `types.cuh`。

---

## 7. 下一阶段：host、兼容绑定和完整demo

1. 库57入口已完成，见LIBRARY_AUXILIARY_AUDIT.md；CUB/Thrust源码均为CUDA12.4的200302版本。
   完整.entry解析器为library_entries.py；owned census仍只统计131。native/build.json记录188个source符号和参数ABI。
   不要把现有_source_cuda.so直接当完整_core使用：其solver_api_ready=False，只有低层Driver。
2. 移植Span/Model/State/Control/Contact/Config/enum的字段/默认值/overload，再把SolverNewton::step等调度写成C++。
   最小无接触粒子场景先行，逐段确认initialize/cache/ELL/持久状态、stream/capture和Newton/PCG调度。
   参考reconstruction/native_step.py、solver.py、core.py和NATIVE_EXECUTION_LAYER.md；
   反汇编命令为`objdump -d -C --start-address=0xfb160 --stop-address=0x103000 <旧so>`，
   用pybind11暴露与旧`_core`相同的Python接口。
3. 基于已生成的CUDA执行层接入完整Solver，构建兼容的`_core.so`（sm_52+PTX8.4，CUDA12.4，-DNDEBUG）。
4. 用 `reconstruction/demo_ab.py` 在同一台机器上跑 examples 里的 demo：原版 so 一次、新 so 一次，比较每个子步的状态，从简单到复杂。
   布料类 demo 原版自身不可复现（GPU 原子加顺序），用 `--native-runs 5` 的统计模式 + `reconstruction/diagnostics/replay_step.py` 单步对比。

---

## 8. 每做完一个 kernel 的自检清单（逐条打勾，任何一条不满足就不算完成）

- [ ] mangled name 与原版完全一致（ptx_compare 能找到对应 legacy entry，不报 MISSING-IN-LEGACY）
- [ ] 参数含义已按 kernel_ab.py 的 launch 调用核对
- [ ] PTX-IDENTICAL；或差异仅为排序/寄存器/操作数互换（逐行看过 diff 确认没有运算差异）
- [ ] GPU 分组测试 exit 0，失败列表空，`csrc entries` 里有该 kernel
- [ ] 测试覆盖了该 kernel 的所有主要分支；没覆盖的已在 kernel_ab.py 新增用例并先验证了原版
- [ ] 至少 3 个 seed 通过
- [ ] 其它已完成分组没有被破坏（改了公共函数后，重跑所有用到它的分组）
- [ ] 代码有英文注释，行宽 ≤ 128，没有临时变量名（如 `g_`、`tmp2`）
- [ ] WORK_LOG.md 已追加

hard state两入口已闭环，见HARD_STATE_AUDIT.md；geometry位于hard_contact_geometry.cuh，三个state入口PTX提取前后不变。
