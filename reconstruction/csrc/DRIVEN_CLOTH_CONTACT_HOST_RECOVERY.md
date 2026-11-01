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
  所有worker均结束且状态finite，未通过项全部保留；长程固定C尚未采集。
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
