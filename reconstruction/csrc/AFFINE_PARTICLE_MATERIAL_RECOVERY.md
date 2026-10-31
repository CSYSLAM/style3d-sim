# Affine bodies with ordinary particle materials

当前image为8fb9d2eec1626aba196a0c6a8665f61c4131189a1452f9f900fdd213fbd6bb31，恢复BVH四工作缓存的实际创建边界，正在验证。
4f八组7/8、graph27/32、initcheck60为0；8f正按相同协议验证，不提前计通过。
CUDA176/f0未改；body+tet/full-surface、其它rigidity、约束/drive/cable/fluid混合保护保持，当前body/cloth新image尚未验收，完整solver未完成。
这是同一个native Solver内的共享矩阵，不是body-spring约束（body_spring_indices）模块。

## 下一项实际参考

`affine_particle_spring_scene.py`在既有SO3+四自由粒子场景中添加一根普通粒子弹簧，
刚度43.125，rest length为初始长度的0.8；保留一部分active PP self、ground、W1/W3、NN/PD与block开关。
`affine_particle_spring_ab.py`已捕获8组实际原版；source已放开上述窄范围，实际八组全部严格通过：3772次完整owned调用、70个defined buffer与全3步状态同。
参考目录`build/reconstruction-csrc/self-surface-host/validation-668a6e1d/body-spring-reference8/`，
`next-reference.py`已在当前完整回归退出后串行完成。
全部八组finite；实际W1/W3模板per_world为8，W3 ground展开per_world24，local ELL分别16/48。
full self PP W3=3/W1=1；普通spring两端不进入free PP查询，不能沿用无spring的PP2/6预期。
`body-spring-template-reference-w1/`另按这些实际尺寸捕获全部diag、row count与8个完整ELL通道，
并创建uploads目录保留26份真实HtoD payload。原版diag前两项43.125，其余0；L0两条free边为-43.125，
所有通道共享完整列模式，body L2为-18.000001907348633。此为原版参考，尚未证明source等价。

```bash
.venv/bin/python -m reconstruction.csrc.affine_particle_spring_ab --backend original \
  --output build/reconstruction-csrc/NEW-body-spring-reference8
```

初次协议只复制一个已初始化host diagonal与L0/scalar-template entry，其它为完整定义过的全局输出。
native per_world与local ELL条目数从实际initialize_step/combine的标量参数读取，不猜template/expanded布局。
这份捕获不代表已核对整个host模板或整个constructor分配。

## 当前恢复与验证要求

此前precompute_springs/precompute_cloth直接构建particle-only缓存；precompute_bodies另建自己的CSR/ELL。
085在body+ordinary spring时先保留spring负offdiagonal与正diagonal，再交给body统一列模式，
L0/host diagonal接收该贡献，其余质量/刚性通道保留相同列；没有改已有CUDA计算。
输出`build/reconstruction-csrc/affine-particle-material-host/validation-0853c9ac/`，实际source八组已通过。
完整W1模板的全部diag、row count、8个ELL通道共10项post buffer全严格，完整调用与全状态也同；
这不是整个constructor分配/初始化顺序验收。
同八组graph60的32项比较全部严格；当前self/surface八组复测全部严格，246配置同；完整74为71严格，仅particles seeds1/2/3分别14/21/21数组不同。
三个固定首次source C10全部通过。
085的所有GPU队列已经退出，下一阶段body/cloth原版八组与完整W1模板也已抓好；
soft_count9/27不作为唯一证据，另核对cloth与body RHS都发生实际接触增量。
原版实际SO3 tangent先于bending；接入cloth前须按此恢复顺序。
修改前668完整检查点458源/构建、1693结果SHA独立复核0差异。
body与材料混合时，应从实际原版确认普通粒子贡献如何进入host diagonal与L0及其列模式，
再精确合并；不能把两套独立矩阵构建函数依次调用、覆盖前一套缓存。
尤其要核对重复列的float32顺序、负零、模板/展开行计数、质量CSR、其余零通道、分配与上传顺序。

先用实际launch指针寻找原版HtoD模板payload，必要时抓constructor memory/typed initialization；
不确定的CPU累加顺序继续看实际64a的precompute_matrices反汇编或独立调用确认。
当前八组必须先看完整owned调用、已定义buffer与全步状态；再扩展整模板/constructor和graph/长程。
严格失败保留first source，用实际首差定位，A/B/C标准与前述阶段相同，不调整物理或比较阈值。

普通spring核对后才扩到cloth/bending；body+full-surface还缺完整view/body字段与调度，不能直接去掉所有保护。
全目标仍未完成，solver_api_ready=False；各image自己的回归与历史失败见WORK_LOG与当前HANDOFF。

## Body/cloth当前阶段

参考：085目录body-cloth-reference8/，全部finite，实际per_world12/ELL36；W3总36共享模板。
三个contacts case的soft_count为9/27，另独立核对cloth与body RHS两侧均有实际增量，审计JSON保留。
body-cloth-template-reference-w1/按实际尺寸读取全diag/row count和8个ELL通道，保留真实HtoD。

0b7621b3将cloth/bending scalar模板也延后至body统一列模式与L0/host diagonal；
实际原版SO3 tangent在bending之前，已按真实调用调整，原SO3→self→surface保持。
当前source八组在validation-0b7621b3/body-cloth8/，全部严格：4292次完整owned调用、65个defined buffer、全部3步状态同。
完整W1的diag、row counts、8个ELL通道共10项post数组与全状态/完整调用也严格；不等于全constructor顺序验收。
graph60共32项比较28严格；两个W3 self case跨backend的graph不同，其余各自eager/graph也有两项不同。
全部eager跨backend严格。原版PD自身eager/graph不同，source NN自身不同，不能因此直接归为ND或接受。
graph-cohort8.py保留source0，追加source1/2各一次和7原版，重复完整8case×eager/graph worker上下文，
按执行模式分别核对全部16条轨迹的每个数组/每步primary-C，当前正在运行，未改原strict报告。
085完整修改前检查点461源/构建、1653结果SHA独立复核0差异；CUDA f0未改。

后续必须核对完整W1模板、真实graph60和新image回归，再跑正式coupled demos；
不把此前spring-only或particle-only结果计为body/cloth通过。body+full-surface仍未接。

### 0b graph诊断续记（未验收）

固定完整worker C8的16轨迹仅14通过；失败仍为W3 NN self与W3 PD self+spring graph。
三source每个失败case轨迹同，NN粒子0/60步C通过、body2/60；PD粒子q47/60、qd51/60、body60/60。
不以原版自身eager/graph差异改判，不扩大样本追通过。

capture_cloth_graph_definition.py记录16个真实graph；图0/4/8规范化节点类型/名称/几何/copy-memset尺寸相同，
kernel参数/地址别名尚未完整核对。initcheck原版0错误，source29160错误，首批是block模板复制中的未初始化数据。
目前不能将未定义padding等同数值错误根因；正在实际CUPTI捕获constructor类型初始化，production与CUDA未改。
日志路径：validation-0b7621b3/graph-initcheck-{original,source}.log。

### 7018 constructor恢复（验证中）

当前image7018afb478ff6fd8932aca5b5d06e00e55909ca4cb3b84e39403ef9edc21a9f1。
9a的block typed init已让source initcheck为0，但graph仍28/32；原版PTX临时替换全部owned也不改变失败graph。
NN真实graph内D2D快照未改变其固定轨迹，首差为node43 numerator group2（3d2a9296/3d2a9295）；
12相同dot贡献的精确float32排列均可复现，same-buffer64每backend的z均同。PD快照有observer效应，不冒称首差闭合。

7018恢复实际constructor独立D0..D5、local/global row、L3..L6与真实上传顺序，D1/D2/L1/L2初值按实际CSR已有质量贡献。
恢复affine/SO3 typed缓存及enabled/cable CSR在矩阵前的实际位置。scalar ELL zero fill host实例的24/24 device PTX同已验收入口。
源CUDA176/f0不改，未改原子顺序/容差；当前八组/constructor/graph60/initcheck/完整74队列运行中，不预先计支持。

复现本轮队列（会创建新image目录，已存在时故意拒绝覆盖）：
`.venv/bin/python build/reconstruction-csrc/affine-constructor-validation-queue.py`
结果：build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/。

7018当前实测：body-cloth8为7/8严格，失败是W3 NN block+diagonal+soft+self+spring，仅状态不同；
所有4292 owned ABI/计数/defined buffer检查保持。constructor typed init57/57、HtoD28/28 bytes/order，
95 alloc/free序列前缀同，502 owned launch全部flat指针allocation identity/offset同。
详见cloth-w3-constructor-audit.json，末尾source提前分配156240B self tangent是明确剩余差异。

图60为26/32严格，W3 NN self的四项比较全严格；PD self+spring和contact block保留strict失败。
initcheck0，完整74仍在跑。下一步先等GPU退出、保存7018完整检查点，再恢复原版lazy tangent prepare：
原版135e13仅full分支调用135ac0，临时capture mode2，malloc(capacity*60)，恢复mode。
反汇编self-{initialize,accumulate,prepare-tangent}-original.asm和memory seq260支持，不能猜或改归约追通过。

审计命令（输出必须用新文件名，保护既有结果）：

```bash
.venv/bin/python -m reconstruction.csrc.initialization_trace_audit \
  --original build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/cloth-w3-initializers/original \
  --source build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/cloth-w3-initializers/source \
  --source-domain 2 --output build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/new-init-audit.json
.venv/bin/python -m reconstruction.csrc.memory_pointer_audit \
  --capture build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/cloth-w3-full-memory \
  --output build/reconstruction-csrc/affine-particle-material-host/validation-7018afb4/new-pointer-audit.json
```

### 4f1fdec6 lazy prepare（当前验证中）

image4f1fdec67956020494323df262d47910741dbabeb2c001386f96800a51ca994c，CUDA176/f0不变。
7018完整74最终70严格：particles seeds1/2/3各28数组、mixed_cloth-seed3有11数组不同；此前71计数已纠正。
7018检查点466源/构建、1073结果SHA独立核对0差异。

4f按135ac0/135e13实际原版将self tangent分配从constructor移到首个full accumulate，并临时切换/恢复capture mode2。
原版false/full切换、重复调用只分配一次的条件保持；恢复早期affine ownership访问前的原有span/index检查。
没有修改数学、归约顺序、阈值。build/reconstruction-csrc/affine-lazy-validation-queue.py正在串行执行
八组、constructor三种观察、graph60、initcheck、246 config和完整74；当前不提前计通过，不重选first candidate。


### 下一步：精确分配边界审计

`affine_constructor_audit.py`不仅比较分配清单，还记录分配发生在第几个owned kernel之后。
4f只有这项失败：每个BVH的codes/work parents/work children/builder visits比原版提前一个primitive kernel。
该image的initcheck继续自然完成，后续246和完整74已defer到修复后的image，不能计当前通过。

```bash
.venv/bin/python -m reconstruction.csrc.affine_constructor_audit \
  --capture build/reconstruction-csrc/affine-particle-material-host/validation-4f1fdec6 \
  --output build/reconstruction-csrc/affine-particle-material-host/validation-4f1fdec6/new-constructor-audit.json
```

预期当前返回1并列出allocation边界失败；不改审计来追通过。GPU全部退出并保留完整检查点后，
把这四个cache的创建移到primitive launch后、source_bvh_sequence_fill前，再构建新image并运行相同审计。


### 8fb9d2ee（当前）

仅移动实际已确认的4个builder cache至primitive AABB之后，所有数值与CUDA176/f0未改。
4f完整修改前检查点467源/构建、378结果SHA独立核对0差异。
运行队列：`.venv/bin/python build/reconstruction-csrc/affine-bvh-boundary-validation-queue.py`。
该image正在验证constructor完整捕获、body/PP、graph60固定三source/8原版完整上下文、initcheck3、246 config、完整74。
同一image期间不改源码或重编译；首次source0不替换。当前未完成，不把旧image结果继承为通过。


8f当前结果：constructor全部5项同（96 allocation events、28 payload、57 typed init、502 owned flat pointers、567 kernel名称时序）；
body/PP8严格，body/cloth7/8、graph27/32。固定graph C8为15/16通过，只有最后W3 contact+block+diagonal+self+spring graph失败：
source0 body_q60、body_qd58、particle_q39、qd51步在原版范围，source1/2全60并与六次实际原版全轨迹逐位同。
source0不替换，C不重算追通过。同case短程固定C8 source0/1四状态均0/3、source2均3/3；9新增worker完整owned ABI/计数同。
同fixture的25份已存真实原版全轨迹离线存在性搜索无source0匹配，未扩大C样本。

initcheck3为0、self config246同，完整74运行中。失败case的后续脚本已准备但要等GPU退出：
`.venv/bin/python build/reconstruction-csrc/affine-particle-material-host/validation-8fb9d2ee/forensic-contact-case.py`。
先核对失败case自己的三观察及flat pointer/alias；再取graphs14/15首次4步的实际force/affine block/PCG输入输出，
完整60帧保留以判断observer是否改变原轨迹。不得用观察后的轨迹替换首次失败。
