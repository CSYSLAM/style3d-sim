# 驱动关节、布料与接触：23012dc5

当前image：`23012dc5b44e7b4694daa318bf2fc2e3186d984664d22e3ec0dfbf4cb7a4e046`。
SDK64a固定不变，CUDA176/f0和核数学未改，`solver_api_ready=False`。
完整替代尚未完成；本页描述新增组合、实际差异和接续位置。

## 固定原版与真实作用

两份独立夹具各32组：SO3/SIX × W1/W3 × Newton/PD × body-block × surface/legacy。

- `driven_cloth_contact_scene.py`：有效soft接触。W1的surface11、legacy4；rigid容量1000但active为0。
- `driven_cloth_rigid_soft_scene.py`：另有ground刚性接触与rolling/torsion，W1有8个有效rigid接触。
  soft、rigid、rolling、joint/drive、stretch/bending及rigidity均有实际RHS变化。

旧小夹具不改，64份首次原版都保留；两个各自首pilot逐字节采用。
每种force抓完整9轮pre/post。legacy同一入口兼作preconditioner，共18次，偶数ordinal才有RHS；
其dump limit为18，surface为9。

soft夹具v1仅有候选接触，v2的legacy顶点仍未受力，均保留为无效覆盖记录。
v3缩小布料使顶点进入箱体投影后才通过有效性检查，不用于替换任何接受cohort中的失败候选。
pilot的legacy静态receipt误写limit9，实际driver用18，原receipt保留，另有纠正文件和call016证据。

## 找到并恢复的真实分支

只开放guard的首image `1d0cc836`：64组全部运行结束，27严格；48组完整调用同，
16组SIX/PD的调用不同。这是实际调度问题，不能归因于原子次序。
全部首次失败、源/build/so检查点及完整buffer保留。

SDK在PD模式中另外选择稀疏矩阵类型。固定原版step反汇编和12次native API探针共同确认：

```text
block_matrix = Newton模式 || (SIX && constraint_alpha > 0 && (rigid输入有效 || full-surface输入有效))
```

这里的rigid输入看容量和span，容量1000、active为0也会触发。
legacy soft单独存在不触发；alpha0取消；rigid/full-surface的触发不被collision diagonal开关取消。
所有探针的nonlinear_solver仍为PD，membrane GN调用都为0。
因此不能通过把PD整个改成Newton恢复此行为。

23012dc5按这个独立flag选择block template、rigidity GN、preconditioner副本、
affine-build的模板/行数和PCG的稀疏类型；membrane/spring等仍保留原PD控制。
没有修改F32数学或CUDA核。hard/self/额外材料等尚未捕获的组合仍有保护。

反汇编来自SDK64a的精确symbol范围，旧`ranges.json`的SHA再次核对。
关键位置：`fb68d`保留nonlinear flag；`fc03b/fc055 → fe490`、`102790`选择矩阵flag。
完整asm、12份原始输入、调用和配置已保留。

## 当前证据

- 同固定SDK64：**49504次完整owned参数、geometry和覆盖计数全部相同**，状态均finite。
- 38/64状态及九轮force buffer严格；全部32组W1严格，另6组W3严格。
  剩余26份严格差异原样保留，尚未全部归因，不能统一称为原子波动。
- 16种W3 constructor五项全部相同；真实graph60比较为soft 71/128、rigid-soft 74/128严格。
  所有worker均结束且状态finite，未通过项全部保留；长程固定C8为soft 37/64、rigid-soft 39/64通过。
  26份短程首次失败固定C8为10通过、16失败；独立CPU重算短26和长128份统计全部一致。
- 两组场景的original/source共四个initcheck3 worker均为零错误，覆盖256条eager/graph轨迹各三步。
- 本image完整74已结束，70严格通过；particles seed1/2/3和pd_mixed_cloth seed3首次差异均保留。
  四份固定C10为seed1/seed3/PD mixed通过、seed2失败，CPU重算四份报告完全相同；seed2仍未解决。
  两个独立source前端Dzhanibekov60/plastic bag3真实graph与test也已结束，均退出0且未映射原版。
  接触短/长固定C与正式复杂demo的A/B一致性尚未验收，不能继承688f结果。

历史688f有70/74严格、四份固定C10通过，但其无接触长程graph固定C8仍14项失败。
它的补充实际graph诊断已导出6份同输入首归约包：三端每端32次pointwise相同，
两PTX实际操作数同，36个分组目标均有真实GPU原子加精确见证；这不是完整60步验收。
旧失败及其证据保持打开，见[驱动布料恢复](DRIVEN_CLOTH_HOST_RECOVERY.md)。

## 文件和接续

soft原版、旧失败和actual contact输入：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-688f9633-driven-cloth-contact/`。

active rigid/soft原版、矩阵探针和源码结果：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-688f9633-driven-cloth-rigid-soft/`。

- `original32/`固定每组SDK；`source64-1d0cc836/`保留首个错误分支。
- `source64-23012dc5/`是修复后的首次完整比较，包含26个未通过的严格候选。
- `validation-23012dc5/`和`run-local-validation.log`保存当前局部队列。
- `matrix-selection-probes9/`及`matrix-selection-probes3-boundaries/`是12份实际SDK分支证据。
- 修改前检查点为`driven-cloth-mixed-contact-before-688f9633/`和
  `driven-cloth-contact-matrix-before-1d0cc836/`；前者固定64份SDK共10766文件SHA。

后续按顺序：对固定首候选做既定C和同输入内部诊断，处理长程graph实际差异；
跑23012dc5自己的完整回归；再逐个正式demo验收。发生metadata差异时优先回到原版调用和asm，
不要改核数学、选新候选或放宽容差。

已新增`reconstruction.csrc.build_core`：由同一份23012dc5 C++/CUDA构建真正导出`PyInit__core`的扩展，
不修改host实现，不是把`_source_solver`简单改名。成功构建位于`source-core/b8dbcb88f1f3dc6a/`，
SHA为`fb2f1e86d237b587ac5a9445eedfc5ca0238747129206dbd96f10f4ce4c99867`。
公开API字段/默认值与固定schema零差异，动态依赖不含原版SDK。
`reconstruction.core_demo`直接加载该扩展，经正常Python包及adapter运行未改示例，无A/B bridge：
Dzhanibekov60帧、plastic bag3帧真实graph与自身test均退出0，均未映射原版求解器。
这里只证明独立执行和示例自检，不等于与原版全轨迹一致。报告在`core-abi-23012dc5/`。
账号兼容接口只表达源码后端无需账号；没有账号读取、网络登录或原版代算。
首次wrapper重复include的编译失败保留于`source-core/f06a8d64e668e038/`。
默认安装入口仍未切换，完整一致性和可安装交付仍待完成；固定原版保留供A/B使用。

Windows继续使用根交接的WSL2环境。机器人G1资产已在本机缓存，但正式trampoline引用的
`assets/trampoline_v1051.obj`在当前项目未找到；必须使用原网格及固定版本验收，不能换网格宣称通过。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.driven_cloth_contact_graph_ab \
  --contact-group rigid-soft --output build/NEW-driven-contact-graph60
.venv/bin/python -m reconstruction.csrc.affine_graph_cohort --suite driven_cloth_contact \
  --contact-group rigid-soft --baseline build/NEW-driven-contact-graph60 \
  --output build/NEW-driven-contact-fixed-C8
```

输出用新目录，GPU worker串行，源码和夹具在队列运行期间保持不变。

首个短C8失败已有独立完整输入抓取器`driven_cloth_surface_capture.py`，两端抓取及同输入回放已全部结束。
实际首packet有33 contacts、12 local/36 total particles、2 shapes、2 bodies；25个指针字段大小来自原view。
`run-first-surface-diagnosis.py`两端完整pointer输入及RHS pre逐字节同，首RHS post均复现各自冻结值。
源码完整state亦复现；原版完整state未复现，不能外推成原版整段路径证明。
33个接触逐个计算三端全同，真实原子贡献及目标地址序列同；同buffer aggregate仍重现原/源1 ULP差异。
scalar84的9线程18次真实贡献，保持各线程同目标顺序的合并，经单lane真实GPU global F32 atomic，
分别精确得到原版`0xc1fbdc24`和源码`0xc1fbdc25`，history也一致。
这是该scalar的F32累计存在性证明，未推断原实际调度，也未证明跨目标完整执行顺序；原C8失败仍保留。
数据为`first-surface-diagnosis-23012dc5/`、`first-surface-ordered-atomic-certificates/`。
粒子seed2/it5完整worker trace两端各仅8/15目标数组匹配冻结值，不能解释原固定失败，需继续定位。

九轮surface力补充：隔离dynamic hook按每次有效count读取6个contact数组，避免读取未定义tail。
两端的active数均为33,33,33,36,36,36,6,6,6，全部18份输入逐接触三端输出与真实原子贡献核对相同。
两端前两轮完整输入同，之后状态/接触几何逐渐不同；见`all-surface-input-audit.json`及
`all-surface-replay-23012dc5/`。扩展观察器未复现整段冻结state，不能据此销账C8失败。
旧220字节return-contact结构在当前首packet上仍有aggregate差异，未作为生产修复采用。
