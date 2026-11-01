# 新版基准与 C++ host 进度

> **活动aa52ee61：joint PENALTY host。** 32组状态/14868调用/首buffer严格，八种构造五项同；
> graph128/128与双端initcheck全部通过，当前74未采。见[JOINT_PENALTY_HOST_RECOVERY.md](JOINT_PENALTY_HOST_RECOVERY.md)。
> CUDA176/f0、SDK64a不变，ready=False。下列为历史image结果。

> **历史6a7061d7：无drive固定/球关节PD/body-block。** 16组状态/6096调用/首buffer严格；
> 四种构造五项同，graph64/64、双端initcheck均通过。当前74未收集，ready=False。
> 见[UNDRIVEN_JOINT_HOST_RECOVERY.md](UNDRIVEN_JOINT_HOST_RECOVERY.md)，以下image为历史。

> **历史86916989：普通约束PD/body-block。** 24组状态/8952调用/首force buffer严格；
> 6种构造五项同、graph96/96及双端initcheck通过，当前74为70严格、固定C10仅1/4过，三项继续定位。见[PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md](PLAIN_BODY_CONSTRAINT_HOST_RECOVERY.md)。
> 以下5bd/c189等为历史检查点，CUDA176/f0、SDK64a不改，ready=False。

> **历史5bd9722e：接入driven joint/body-block，按SDK恢复drive/armature/limits→build与PD local row身份。**
> 八组17052调用/状态严格、四种构造五项同；32组合graph128/128严格、双端initcheck零错误。当前74未采，ready=False。
> 见DRIVEN_JOINT_BODY_BLOCK_RECOVERY.md；下列为历史结果。
>
> **前一c189db81：接入PD driven joint点线调度，并按两份实际SDK初始化恢复joint缓存/D4/L5/行身份。**
> 四份固定SDK原版的状态/完整7200调用全严格，两种joint constructor五项同；16组合graph64/64、双端initcheck3过。
> c189完整74为71严格、三个固定C10全过且CPU复算同，独立source真实graph自身test通过；详情见DRIVEN_JOINT_PD_HOST_RECOVERY.md。
>
> **前一04b46fb0：SO3/tet legacy接触已严格验证，新增self组合继续定位W3差异。**
> 131的legacy16、graph64/64全严格；04的self W1八组严格，W3八组状态不同，首buffer及完整owned调用同。
> constructor五项同，四组initcheck3零错误；legacy16、surface16、无contact graph32及配置246仍通过。
> 当前完整74为71严格，三个particles首次失败的固定C10全过且CPU复核同；self固定C8为full15/16、diagonal16/16。
> 独立源码入口的真实graph/test：Dzhanibekov60帧、plastic bag3帧均通过且未映射原版。ready=False，
> 证据、命令、待办见BODY_TETRAHEDRA_SELF_LEGACY_RECOVERY.md。
> 8f固定particles路径全部102次算子与84归约已实际回放核对，原固定C10失败仍保留；见PARTICLE_FIXED_PATH_RECOVERY.md。
> 下列各image结果均为对应历史，不能直接计为04验收。
>
> **历史8f4127f0：新增SO3 body/tetrahedra实际full-surface软接触。**
> 16组状态/160buffer/8824次完整owned调用全同；64项60步eager/graph逐位同。
> 构造96/29/57/634/699五项同，original/source各32条×3步initcheck均零错误。
> 无contact tet graph32/32、246配置同；74回归71严格，三particles固定C10两过一失败，CPU复核同。
> 已复现seed1的冻结目标轨迹并定位首个PCG原子累计差异；实际SDK同buffer也产生两端值，C10仍false。
> 补充63个surface view的26指针字段/11标量word语义绑定全同；不继承b945结论，旧失败仍保留。
> CUDA176/f0、参考64a未改，ready=False；见BODY_TETRAHEDRA_CONTACT_RECOVERY.md。
>
> **前一b9456031：新增SO3 body + tetrahedra（Newton/PD、W1/W3、body block开关）。**
> 按原版恢复body路径的体积上传位置及SO3→tet tangent，八组状态/buffer/ABI/coverage全部严格同，
> 32项60步eager/真实graph比较全同；原版和source各16条×3步initcheck均零错误。
> 构造五项全同：96分配/释放、29上传、57 typed、508 owned指针、573核名称时序。
> 完整74为70严格，三个particles seed与PD mixed seed3的固定首次候选C10全过、CPU复核同。
> surface/legacy graph为21/32、28/32严格，旧固定失败仍保留；CUDA176/f0与参考64a不改，ready=False。
> 限制与命令见BODY_TETRAHEDRA_HOST_RECOVERY.md；旧ff失败与oracle/holdout见SURFACE_STAGE_ISOLATION.md。
> 以下ff及更早结果都是各自image的历史，不能直接继承到b945。

> **前一ff34e6a1：补齐SO3 body/full-surface/rolling、surface最多32block及单世界默认shape tile。**
> 按实际64a调用和step反汇编恢复；CUDA176/f0及参考库未改，solver_api_ready=False。
> 九capacity的351调用/162状态全同；shape布局六static/四body soft-hard组合25224调用/168状态全同。
> 正式cloth_balls全部60帧物理检查过，5214次完整owned ABI/geometry同；固定eager/graph整段C仍失败。
> ff最终队列已完成：74为71严格，三个首次粒子失败固定C10全通过；246配置同，initcheck3均零错误。
> surface/legacy graph为21/32、30/32严格，固定C8为10/16、13/16，均失败；不宣称完整solver通过。
> 正式1380接触四舍五入首差的37920贡献同，七类输出共36435个scalar有精确F32次序见证，整段C仍失败。
> 输出validation-ff34e6a1；命令/限制见新增交接与WORK_LOG末尾，不继承cc/25旧结果。
>
> **前一cc09a3c0：完整74为71严格，仅三个particles seed严格失败；rolling固定C8仍11/16。**
> rolling八组五W1全严格、三W3状态不同；rolling graph20/32，source/original initcheck3均零错误。
>
> **前一25ecf6f4：新增SO3 body/full-surface host字段与真实force顺序。**
> CUDA176/f0未改，参考项目64a未改；八组5/8严格，surface graph21/32、legacy cloth graph29/32。
> 固定C8分别11/16和13/16，均失败保留；旧8f首次source0也不替换。
> initcheck3为0、246配置同；完整74为70严格，四首次失败的固定C10中particles seed2仍失败。
> 其余三个C10通过；准确证据/命令见[AFFINE_SURFACE_HOST_RECOVERY.md](AFFINE_SURFACE_HOST_RECOVERY.md)。
> 以下所有旧image均为历史，不能据其局部通过率声称活动完整solver通过。

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

当前以用户在 2026-10-30 明确选定的项目内新版为唯一后续参考，不再调用登录或读取凭据。
**完整 so/完整 demo 的逐位替代尚未通过。不要把 kernel 覆盖、局部测试或原子波动误报成完整通过。**

最新续接：活动 image `0c44d52d961c741f2a0519f04dbf7248a8ecbde9aab335b8b35ed36ae2902613`。
新增 armature 三模式及缺省关节速度推导：18组540子步、354个缓冲区、2282次调用核对通过。
本 image 的74组回归已完成：7个60帧demo、692+670 API/属性项、8组刚体和18类粒子×3seed严格通过。
particles 的28/28/14项严格差异保留；固定各候选后，每seed10次原版的标准C检查通过。
链条8原版/3源码时1项未过，保持同3条源码轨迹并扩至16次原版后，约定的分布检查通过。
full-launch-metadata 已补齐完整symbol、3D尺寸、动态shared bytes和stream类型；旧格式缺字段不再算完整审计。
前一完整检查点为 c598b144（源码/结果 hash 已保留）。
关节点线 Newton/AL 和关节+刚性/软接触/滚动摩擦已按原版捕获接入。
7 个真实 demo 各60帧逐位一致（含 example_joints 1200子步、example_basic_joints 240子步）；
c598b144 的3seed回归已完成，严格差异保留；链条8原版/3源码按约定的分布标准通过，严格 bitwise 仍不同。
完整说明及命令见 [JOINT_HOST_RECOVERY.md](JOINT_HOST_RECOVERY.md)。
下方1ba3/e91阶段范围保留为历史；完整 solver 仍未替代。

## 基准版本

| 项目 | 旧基准，保留历史证据 | 当前基准 |
|---|---|---|
| 仓库 | `/home/oem/code/agent/style3d-sim-bin` | `/home/oem/code/agent/style3d-sim/style3d-sim-bin` |
| Git | `ce8d7ba`，2026-10-26 | `23fb797`，2026-10-27 |
| 工作区二进制 SHA256 | `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6` | `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63` |
| 唯一 kernel 入口 | 188 = 自有131 + 辅助57 | 176 = 自有129 + 辅助47 |

两份文件都是 `Linux/Release/_core.cpython-312-x86_64-linux-gnu.so`。
旧提交是新提交的祖先，主项目对应提交 `e74e136` 的说明是
`fix(pcg): compute independent CG coefficients per world`。
新版 LFS 原始二进制 SHA 为 `3fded7227b402d76e763d772f8c85aebae0b59a01b6688e875a31807b79b9838`，
用户处理后的文件与缓存的原始新版同为7657288字节、相差15字节。版本结论来自 Git/LFS，并非修改时间。
详见 `build/reconstruction-csrc/host-particles/reference-versions.json`。

新旧入口差异：168个同名入口规范化 PTX 一致，1个 scalar affine preconditioner 入口文本不同，
7个新版 PCG 入口新增，19个旧入口移除（9自有、10库入口）。API 字段、默认值、枚举保持一致。
新 PTX：`build/reconstruction-ptx/64a0be7f7a3c03cb/`。完整清单见 `reference-revision-audit.json`。

## 当前源码与产物

- `native/source_solver.cpp`：真正的 C++ GPU host、Span/Model/State/Control/Contact/Config/enums 绑定。
- `native/api_schema.json`：直接从原版转录的219个字段与18个枚举值；包含只读 Span、uint32/signed int 区别。
- `revisions/pcg_23fb797.cu`：新增7个入口，**规范化 PTX 7/7 与当前原版完全相同**。
- `native/kernel_symbols_23fb797.json`：当前176个入口名称；构建只从恢复源码生成的 PTX 选择这些入口。
- `build_host.py`：验证既有源码 bundle 的 provenance，加入新版源码编译模块，移除19个过时入口。
  不读取/链接原版求解器。生成的本地 bundle 与历史188入口 bundle 分开保存。
- 产物：`build/reconstruction-csrc/host-particles/_source_solver.cpython-312-x86_64-linux-gnu.so`。
  `kernel_count=176`、`source_only=True`、`solver_api_ready=False`；没有 `login/is_logged_in` API。

176个源码入口名称均能解析，19个过时入口均拒绝；规范化 PTX84相同、92不同。
92个不同不能一概说成数学相同：其中大部分有旧阶段逐位/数据流验证，新增7入口严格 PTX 相同，
当前变动 affine 入口另做了新版字面 GPU A/B。旧版证据仍只按对应入口的继承关系使用。
原本 `native/_source_cuda.so` 和全部188入口阶段证据保持原样。

**本轮继续后的活动 image 为 `1ba3a112e2915616821eb8464d90bdec8fa52f4d66644bb2d33f124d77959b29`。**
下方 e91 表格是前一检查点，不能当作当前 image 的验证记录。本轮实际修复、命令和新增结果见 WORK_LOG 末尾。
构建现有27个源码 PTX 模块。`revisions/tetrahedra_23fb797.cu` 替换历史 bundle 的四面体 force 入口：
原版允许 NULL activation，且非空数组按全局四面体状态编号索引。历史源文件缺了这两条分支，旧单 world
非空测试未覆盖；历史文件/证明保持原样，活动 so 只用修正版。不可用旧 `kernels/tetrahedra.cu` 代替该入口。

当前 C++ host 已接入以下 Newton/PD_NEWTON 路径：

| 模块 | 当前范围 |
|---|---|
| 粒子、弹簧 | 模板复制、world 系数、重复弹簧、零刚度、Newton/PD 切换 |
| 静态形状软接触 | 粒子接触、平面/球体、摩擦/阻尼、独立系统/预条件块、Hessian 开关 |
| 布料拉伸 | Style3D 各向异性三角形、CPU 常量矩阵、Newton GN 与 PD 标量 ELL |
| 布料弯曲 | 余切常量矩阵、弯曲力、阻尼预条件器/矩阵外乘积、无效边跳过、拉伸/接触组合 |
| spring+cloth | 先弹簧再逐元素膜/弯曲的 CPU 累加，正/零/重复列，舍入敏感输入 |
| 四面体 | CPU 体积、弹性/阻尼、全局激活、矩阵外切线、与其它已接入模块组合 |
| 气动阻力 | 正 Cd 面压缩、前一位置法线/面积、风、预条件器/完整切线、零密度跳过 |
| 三顶点软接触 | 296字节 View、重心权重、静态平面/球体、粒子回退筛选、完整切线 |

支持三种 step overload、独立/别名状态、非默认 stream、CUDA graph。所有 device 分配与 kernel 加载在
initialize 阶段完成，step 不通过 NumPy 下载计算。全部128个 Span 字段已按原版改为值拷贝 getter。
测试通过实际编译 C++ so 和本轮未改动的项目 NewtonSolver 包装层执行。例子中的旧 `--solver reconstructed`
仍指向历史 NumPy 实现，并不自动加载本 C++ so；不许把二者的测试结果混用。

仍明确拒绝刚体/关节、fluid/granular、cable、自碰撞、部分不完整的 surface 输入等未接入分支。
完整接触目前只接受静态形状；动态 affine body 仍需后续恢复。collision_triangle/edge 元数据可用于已恢复的阻力。
完整官方 cloth/plastic_bag/ball demo 尚未验收，solver_api_ready=False。

原版 host 核对后修复的细节：

1. 复制模型中初始化重力使用隐式 world 编号；PCG 的 world 分组则会读取本地标签。
2. PCG 本地标签包括 -1，按首次出现顺序压缩编号，再给各复制模板加 group 偏移。
   连续等长分组省略 map，除数为 count/group_count。对应反汇编1070e8..107207、10b79c、12f040。
3. 原版会修改 state_in.q；非线性输出每次复制回输入位置，零次迭代则直接复制预测值。
4. 无 matrix-free tangent 时原版传 nullptr；传零数组会多一次加法，可能改变符号零，已修正。
5. 接触力先于弹簧/拉伸/弯曲力；每次非线性迭代重新复制基础对角，再累加接触标量。
6. PD 在表面接触、四面体、有效阻力/弯曲阻尼、开启的粒子接触 Hessian 下切换块预条件器；仍保留标量 ELL。
7. Newton 的 block ELL 行数总是完整 state_count，PD 的 scalar ELL 行数是每模板粒子数，不能因 nnz=0 改写。
8. 软接触 Hessian 分别修正 system/preconditioner；弯曲阻尼只加入 preconditioner，完整作用由每次 CG 的
   tangent 提供。组合场景只清空一次 tangent，不能在接触核前清掉已累加的弯曲乘积。
9. 原版 CPU 先累积弹簧，再逐三角形/边加入。不能把单独求和的 cloth/spring 矩阵最后相加；敏感输入已证明不同。
10. 当前实际调用顺序：力为 drag、surface、legacy soft、spring、membrane、tet、bending；Newton GN 为 membrane、
    spring；预条件器修正为 legacy soft、tet、bending、surface、drag；乘积为 tet、bending、surface、legacy soft、drag。
11. 即使其它材料使 PD 采用块求解，关闭 legacy collision Hessian 时也不加其块修正或非对角乘积。
    表面接触的完整切线仍保留；切勿把“块求解”和“legacy Hessian 启用”当作同一个条件。
12. Config.air_density 的有限非负校验、wind_velocity 的三项有限序列校验已按原版补齐；670项浮点/序列校验通过。

## 原子累加场景的验收标准（用户 2026-10-30 认可）

只因 GPU 浮点原子累加次序不同而严格比较失败的数组，必须同时满足：
A. 逐元素：相同捕获输入下，所有非原子的逐元素输出逐位相同；
B. 归约：每个不同的原子归约结果，都能由相同逐线程贡献的某个 float32 求和次序精确复现；
C. 整段：每个失败的状态数组在每个记录步上，源码与原版 K>=5 次平均值的偏差不超过原版自身留一法波动。
其它任何差异仍按严格逐位处理；本标准不适用于非原子差异。

已按本标准判定：自由粒子 990 数组组（`atomic_spread_check.py`，原版每 seed 5 次）三个 seed 严格失败 28/14/2 个，
全部在原版自身重复中也变化，源码偏差/原版波动最大 0.80，A、B 已有证据 —— **按此标准通过**。
结果见 `build/reconstruction-csrc/host-particles/atomic-spread-seed{1,2,3}/criterion-c.json`。

## 验证与尚存失败

- `host_api_ab.py`：692项字段/边界/Span 值语义/错误保护检查通过。新增值语义检查先在原版确认；
  曾找到旧生成绑定的内部引用错误并修复，并非仅凭字段默认值宣称 API 相同。
- `revision_kernel_ab.py`：7个新增 PCG + 两种 affine 入口，三 seed 每次114+230=344项，合计1032项通过。
  当前 source 侧通过实际新编译 C++ so 执行，核对 kernel digest，记录9个实际使用入口；无旧 PTX fallback。
  PCG 定向用例的每个系数 bin 只有一个写入者，用于严格验证逐线程数学、ABI、边界和输出尾部。
- `host_particles_ab.py --adapter`：37个直接场景，加未修改官方 NewtonSolver 包装层的最小粒子 demo，
  eager/graph 各30帧（各60个 substep）。每 seed990组原版/source数组与360组 eager/graph自检。
  **当前三个 seed 严格失败28/28/21组，涵盖257粒子和4097粒子 many_blocks 场景。** 所有 worker 正常退出，
  controller 保留非零退出，不放宽容差。最新结果看 comparison-seedN.json。
- 原版与原版本身重复也有差异，某次为28组257粒子数组。新版使用每粒子的 red.global.add.f32，
  原子累加次序不固定。这个事实不能把 source/原版失败自动改判为通过。
- `native/host_trace.cpp` 是仅供测试的 LD_PRELOAD 观察器，不链接进交付 so。同步抓取真实 GPU kernel
  输入/输出，包含 world map、分组除数、num/den、M/r/z/p/Ap/x。曾修复 RTLD_LOCAL 下 runtime 符号解析，
  最初观察器的异常不属于求解器验收结果。
- 257粒子失败场景捕获102次原版/source调用，launch名称/grid/block一致。首个差异在第4号调用
  precondition_and_reduce 的 after.numerator；该调用所有输入和逐元素 z 都逐位相同。
  原版自身重复捕获也首先在PCG原子归约标量出现差异（最新一次是denominator，早期是numerator）。
  见 trace-*-first-difference.json。
- `replay_host_pcg.py`：把原版捕获的每次输入独立送入当前编译 so，84次 PCG 调用的105个逐元素输出全同；
  最新一次42个原子归约输出仍有16个不同（早期一次23个），full_bitwise_equal=False。
  **此诊断不能标记全 kernel/全 so 通过。**
  当前程序也会因严格 aggregate 失败非零退出，所有失败保存到 JSON。
- `soft_contacts` / `pd_soft_contacts`：每组43直接场景加真实地面碰撞 adapter demo，每 seed1194数组。
  三 seed 共7164数组与2520eager/graph自检通过；包含257worlds跨 block 接触。四个完整接触 trace 合计
 1788次调用，所有捕获数据/metadata 相同。修复 Span 后同一最终 image 的全部分组已回归通过，见下表。
- `membranes` / `pd_membranes`、`bending` / `pd_bending`：直接场景已完成三 seed 数值核对；官方 adapter
  增加单三角形、双三角形有阻尼布料 demo，eager/graph 各30帧。结果和 `.runtime.json` 同时记录 image SHA。
- 完整 native JIT 与原子次序调查在 `build/reconstruction-csrc/pcg-order-investigation/`：7个新 PCG 入口
  完整 PTX module 分别 JIT 后的 `.text` 机器指令逐字节相同，实际 runtime attributes 也一致。32次诊断性
  atomic-return 探针发现31种累加顺序和7个结果位模式，各次按记录顺序重放均精确复现。探针改变时序，
  不代表已观测到旧 production 那一次的具体顺序；此原因证据不把严格失败改判为通过。

历史 e91 image：`e91d4c96a9543f51b2d356d6f62864cab5f7d37fc7b6edec8e53fb44b5e697d6`。
以下是前一检查点的分组数；本轮更新后的回归记录在 `continuation-regression/`，每份 runtime 各自记录 image SHA：

| 分组 | 原版/源码数组逐位通过数（三 seed） |
|---|---:|
| springs / pd_springs | 2052 / 2052 |
| pd_particles / switching | 1296 / 162 |
| soft_contacts / pd_soft_contacts | 3582 / 3582 |
| membranes / pd_membranes | 1728 / 1728 |
| bending / pd_bending | 2214 / 2214 |
| 合计 | 20610 |

另有10080项 eager/graph 自比较通过；API692项和新版内核1032项同样基于此 image。
完整粒子组的大归约测试单独保留严格失败，不能从上表推出完整 so 已通过。
最终检查点看 `build/reconstruction-csrc/host-particles/validation-summary.json` 和 `provenance-final.json`。

历史 e91 的9个 `final-*` 布料完整 trace：4023次调用，metadata/全部捕获数据逐位相同。
含PD阻尼开关、边界/零面积、膜+弯曲、弯曲阻尼+接触组合。接触历史1788次 trace 对应旧检查点 a8769026，
与本轮 e91d4c96 的完整数值回归分开记录。

4097粒子最新诊断：`trace-seed1/final-manyblocks` 捕获294次调用，首差在第4号 precondition 的 numerator；
此前所有捕获数据以及该次 z 均相同。`final-manyblocks-original-repeat` 的原版自身重复也首先在该处出现差异。
对原版每次 PCG 输入独立重放252调用：315逐元素输出全部相同，126归约输出中92个不同；命令严格退出1。
同步观察的18个最终状态数组碰巧相同，**不能覆盖根目录完整990数组测试的失败**。
`compare_host_trace.py` 现也会在任一字节/metadata不同后退出1，避免命令返回0被误当作数值通过。

## 命令

所有命令从 `/home/oem/code/agent/style3d-sim` 运行；不设置账号密码。

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.host_api_ab
.venv/bin/python -m reconstruction.csrc.api_float_ab
.venv/bin/python -m reconstruction.csrc.audit_optional_parameters
.venv/bin/python -m reconstruction.csrc.revision_kernel_ab --seed 1
.venv/bin/python -m reconstruction.csrc.revision_kernel_ab --seed 2
.venv/bin/python -m reconstruction.csrc.revision_kernel_ab --seed 3

# 每个分组都换 seed 1/2/3；worker 按原版 -> 源码串行，无登录。
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario springs --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario pd_springs --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario soft_contacts --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario pd_soft_contacts --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario membranes --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario pd_membranes --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario bending --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario pd_bending --adapter --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario mixed_cloth --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario tetrahedra --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario drag --seed 1
.venv/bin/python -m reconstruction.csrc.host_particles_ab --scenario surface --seed 1
.venv/bin/python -m reconstruction.csrc.tetrahedron_activation_ab --seed 1
.venv/bin/python -m reconstruction.csrc.mixed_precompute_audit

# 当前保留严格失败；不要因为非零就删除/放宽检查。
.venv/bin/python -m reconstruction.csrc.host_particles_ab --adapter --seed 1

# 构建仅用于诊断的 observer。
c++ -std=c++17 -O2 -shared -fPIC -Ibuild/toolchains/cuda-12.4/include \
  reconstruction/csrc/native/host_trace.cpp -l:libcuda.so.1 -ldl \
  -o build/reconstruction-csrc/host-particles/host_trace.so

.venv/bin/python -m reconstruction.csrc.host_particles_ab --seed 1 \
  --trace-case n257_w1_it1_f1 --trace-label complete-inputs

.venv/bin/python -m reconstruction.csrc.replay_host_pcg \
  build/reconstruction-csrc/host-particles/trace-seed1/complete-inputs/legacy \
  --output build/reconstruction-csrc/host-particles/source-replay-seed1.json

# 4097粒子case有3次非线性迭代，覆盖数必须明确指定；默认参数仍覆盖旧84调用场景。
.venv/bin/python -m reconstruction.csrc.replay_host_pcg \
  build/reconstruction-csrc/host-particles/trace-seed1/final-manyblocks/legacy \
  --nonlinear-iterations 3 \
  --output build/reconstruction-csrc/host-particles/source-replay-manyblocks-final.json
```

当前 trace 的状态、日志和比较结果写入对应 --trace-label 子目录，保留根目录完整990数组结果。
早期版本曾覆盖根目录子集，历史文件仍保留；不要把18数组子集当作完整测试。
raw trace 子目录按 --trace-label 区分，不能混用尚未抓全参数的早期 trace。
不同 case 必须使用不同 label。`pd_bending/.../oracle-branch` 曾混用两个 case，已弃作诊断，不能用于验收。
有效边界/零面积记录使用 `oracle-boundary-unique` / `oracle-area-unique`，最终验收应使用新的独立 label。

## 检查点

- `build/reconstruction-checkpoints/host-particles-20261030-before-springs/`：2394文件，最初粒子 host。
- `build/reconstruction-checkpoints/springs-pd-before-soft-contacts/`：97文件，Newton/PD 弹簧和切换结果。
- `build/reconstruction-checkpoints/static-soft-before-span-value-fix/`：34921文件，软接触完整数值/trace；
  image a8769026，明确记录已发现的 Span getter 语义错误，**并非完整 API 验收**。
- 修改前已复制各文件并记录 hash；旧 proof 从检查点根路径验证，不能用其 hash 声称当前新 image 通过。
- 当前 `host-particles/provenance-final.json`：241167文件均重新核验，零 hash 差异；manifest 自身 SHA256 为
  `63d0dd85b2fc2dc6d5ccc3ee0a9fe013d9edd3c2288a08ab22dc8d4df9f949f6`。它保存来源，不表示所有历史失败都通过。
 具体通过/失败范围以对应检查点的 summary 为准，whole_solver_accepted=False。本轮改变前已保存所有会改写的源码、
 build根文件及分组报告；原始 trace 路径不动。验证旧 manifest 时用对应 preserved-files 覆盖记录恢复旧版本。
- 本轮依次保留 `e91-host-before-mixed-cloth`、`mixed-cloth-before-tet`、`tetrahedra-before-drag`、`drag-before-surface`。
  旧 `host-particles/validation-summary.json`/`provenance-final.json` 尚为 e91，不能用于活动 image；最终新 summary 另记。

## 后续工作

继续验证固定输入下各 kernel 的确定性输出、原子贡献和主机分支。保持原版算法，不为消除测试波动偷偷
改归约方式或容差。spring+cloth/tet/drag/静态三顶点接触已接入；后续接刚体/关节、流体/颗粒、cable、自碰撞，
继续补足未覆盖的参数/组合，再做完整官方 demo 的同场景比较。
只完成函数解析、内核层检查或无接触粒子场景，均不得把 solver_api_ready 改成 True。

历史账号基准的临时 OpenSSL NO_ATEXIT bootstrap 已从当前源码移除，只存于历史证据目录。
其原理参考[OpenSSL 官方文档](https://docs.openssl.org/3.0/man3/OPENSSL_init_crypto/)，它不属于当前免登录流程。

## 自由仿射刚体（SO(3) AL）— Newton 与 PD_NEWTON（2026-10-30）

- 实现：`source_solver.cpp::precompute_bodies` + `step` 中的刚体分支；全部调度/实参/预计算缓冲区取自项目内
  64a0be7f 原版的 launchlog/cudahook 抓取（`build/reconstruction-csrc/bodies/`）。
- PD 与 Newton 的唯一差别（原版抓取）：PD 不调用 initialize_block_non_diagonal，CG 用
  multiply_matrix_and_reduce<NonZeroEntry, mat3>（combine 输出的标量 ELL × 块对角）。
- 验证：`reconstruction/csrc/host_bodies_ab.py`（官方 adapter、原版/源码串行、bitwise）。镜像 d7a2d5fe…：
  free_body 3 步 / 30 步，two_bodies 1 world / 2 worlds，free_body 3 worlds，Newton 与 PD 共 10 组全部 PASS；
  每 kernel launch 次数与原版抓取一致。
- 仍拒绝：刚体 + 弹簧/布料/四面体/drag、刚体接触、关节 drive/弹簧/point-line/距离约束、hinge、cable、
  SIX_SPRINGS/CO_ROTATED/ABD 刚度模型、affine_body_block_preconditioner。

## 刚体刚性接触 / 滚动摩擦 / 刚体软接触（2026-10-30，镜像 7a833751…）

- Newton 与 PD 均 bitwise 通过：ground_box 60 步（落地、反弹、静止）、摩擦为 0 变体、PD、2 worlds。
- 诊断工具：`reconstruction/diagnostics/cudahook.c` 现在同时记录 cuLaunchKernel（编译版），可对原版与源码的每次
  launch 实参逐个比对；`body_capture.py` 输出 pointers.json（指针 → 字段名）。
- 回归：粒子 19 场景 18 个 bitwise，particles 按标准 C（10 次原版）通过。

## 混沌场景的验收（用户 2026-10-30 同意，前提是保证准确性）

只有在原版自身不可复现（原子序）且轨迹对微小扰动高度敏感时才可使用，且必须同时满足：
1. 每个 kernel 的 launch 次数与原版完全一致；
2. 对原版与源码做 cudahook 逐次 launch 实参比对，所有非指针实参（标量、尺寸、null 与否、顺序）一致；
3. 在原版自身多次运行第一次出现分歧之前，源码与原版逐位一致（不允许更早的差异）；
4. 分歧之后：源码每次运行都落在原版自身的分布内——把每次原版当作候选与其余原版做同样的逐子步检验，
   源码的通过子步数与最大 ratio 不差于原版自身的表现（原版至少 8 次，源码至少 3 次）。
任何一条不满足，按 bug 处理，回到原版 so 找对应逻辑。
