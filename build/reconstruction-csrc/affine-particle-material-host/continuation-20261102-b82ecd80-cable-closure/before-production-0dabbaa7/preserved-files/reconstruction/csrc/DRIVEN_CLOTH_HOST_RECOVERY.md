# 驱动关节与布料组合：688f9633

当前源码 image：`688f9633e740b7c6de174676f404f1559107281b8f3d68cdfd4a4ee58a15ffd6`。
唯一原版仍为项目内 SDK64a，CUDA176/f0、原版 so 和360个pyc不改，`solver_api_ready=False`。
本页记录局部恢复和未通过项；完整替代尚未完成。

## 恢复了什么

正式 `example_robot_cloth_trampoline.py` 使用 SIX_SPRINGS、AL关节和布料。
此前430b在构造时拒绝材料与关节并存，非SO3的step guard也拒绝此组合。

先冻结独立小夹具 `driven_cloth_scene.py`：两运动刚体、offset COM、revolute驱动与角限制，
4个布料顶点、2个三角形、1条弯曲边、固定点和仅施加于state的初始prestrain。
原版16组为 SO3/SIX × W1/W3 × Newton/PD × body-block开关，每组3步、NL3/CG5。
每种启用力均抓9次完整pre/post RHS：joint、drive、rigidity、stretch、bending都有实际变化。
`actual-material-host-schedule.json` 保存原版启动记录；没有额外spring/tet/drag/line/distance/cable/fluid/granular路径。

688f只开放这些已捕获、无contact/self/drag的组合，并增加scope标签。
数学、核函数、CPU模板和求解调度未改；其它未捕获材料/约束组合仍保护。
修改前430b的27份源/build/so及原版16全部文件SHA位于
`build/reconstruction-checkpoints/driven-cloth-before-430b5b74/`。

## 已核对与固定失败

- 同16份固定原版：9052次完整owned参数、geometry和coverage均同。12组状态与全部9次五类force缓冲区逐位同。
  四份首失败保留：SO3 W3 Newton b0、PD b0/b1，SIX W3 Newton b1。
  这四份第0轮五类force全部pre/post也相同，后续轮次开始不同。
- 四种W3/body-block构造五项全同：各106个分配/释放事件、37上传、61 typed initializer；
  SO3 Newton/PD的owned为652/640，SIX Newton/PD为595/574。
- 16组合的60步eager/真实graph共64比较，42严格。原版自身多个eager/graph轨迹也不同。
  双端各32条轨迹×3步initcheck均0错误。
- 四份三步首失败的固定C8均通过：首原版与首源码原样保留，再各固定8原版/3源码，
  所有字段、所有子步、三个源码均在既有leave-one-out范围内。不是严格逐位通过。
- **长程graph固定C8仍失败：18/32通过，14组不通过。** 保留完整worker顺序和原版/源码首轨迹，
  没有重采接受样本。CPU独立重算四份三步及32份长程的全部统计，与报告一致。
  `graph-fixed-first-outside.json`定位68个越界字段；既有C标准、容差和首失败不改。

688f自己的完整74已完成：70严格，三份particles及mixed_cloth seed3的四份首差固定C10全部通过，CPU复算一致。
独立source入口Dzhanibekov60和plastic-bag3真实graph/自身test均通过，均无SDK映射。不能继承3d或430b结果。
正式cloth_balls的旧固定失败和aa52首步分析同样保留，不因本页局部结果而销账。

## 首步诊断的证据边界

`first-step-traces-688f9633/`保存预先安排的四组original/source共八次deferred诊断。
每份最终q/v均与public首步输出核对，但八份均未复现各自冻结首步，不能称作冻结失败的完整因果重放。
Newton两个诊断首步的已观察包相同；两PD诊断的首差均为第8包precondition归约的world2 numerator，
其before输入和after.z相同，标量相差1–2ULP。

对真实捕获输入分别做了无body-block及有body-block两种PCG：

1. 实际SDK runtime、原版PTX、源码PTX使用同一批分配，每端32次，逐粒子结果全部逐位相同。
2. 两PTX记录的36个lane实际原子操作数、目标地址分组全部相同，每组12个lane。
3. 每种配置的original/source各3个目标，共12个标量目标，均由实际GPU串行F32原子加精确复现。
   无未解释目标；不推断生产实际执行次序，也不把局部证书升级为60步验收。

有body-block的补充观察器v1错误跳过了部分before字段，probe在GPU启动前因缺文件失败。
v1全部源码/so/四份诊断/失败日志保留。v2在原before分支内补抓真实z，另存两份新诊断，未补造输入。
`pcg_grouped_atomic_certificate.py`现支持precomputed开关，实际inverse或真实before.z分别作为输入。

补充真实graph诊断：完整16组合worker顺序保留，四worker观察graph10/14/26/30；
使用实际6个body states及PD local row维度。g10三份source的280快照及public首步与实际SDK诊断相同，
该首步还逐位匹配固定SDK1/3/4/6；不能称为完整60步复现。其它图的首个观察差异均为world2的
PCG numerator/denominator，见`graph-first-step-trace-audit.json`。未据此销账14份长程C失败。

## 接着怎么干

1. 当前688f完整74/C10/CPU/独立入口已结束；保留这次各阶段终态，后续改image后重新验收。
2. 14份长程C失败保持打开。以`graph-fixed-first-outside.json`为入口，按冻结worker顺序和实际graph节点
   定位最早分歧；新诊断必须核对是否复现首候选。核算同输入的真实SDK调用、pointwise结果和实际原子操作数，
   不凭“原子波动”四个字跳过未核对路径，也不改核数学来迎合有限样本。
3. 同时恢复正式机器人demo所需的joint+cloth+SIX真实接触。
   新独立`driven_cloth_contact_scene.py`用实际CollisionPipeline产生接触，原夹具不改。
   必须先证明contact有效且cloth和body RHS都受力，冻结原版，再看实际host调度和保护分支；
   v3小夹具的surface11 contacts和legacy4 contacts均已真实受力；前两版未受力记录保留，
   完整32组原版矩阵尚未采集，此接触范围尚未开放。不要直接删guard或把新夹具通过率算作旧14项已通过。
4. 正式trampoline的OBJ和G1资产也要固定版本后再运行；当前仓库assets没有`trampoline_v1051.obj`。
   不用临时替代网格声称未改demo通过。

## 证据和命令

主目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-430b5b74-driven-cloth/`。
`original16/`、`source16-688f9633/`、`validation-688f9633/`、`fixed-C8-688f9633/`保存首次与局部验证。
`after-fixed-C8/graph60-fixed-C8/`保存完整首worker及固定长程C8，`pcg-diagnosis-688f9633/`和
`after-fixed-C8/`分别保存两种PCG实际三端回放与证书。每个driver/command/build及失败均随证据保留。

在WSL2/Linux运行，输出必须是新目录，GPU worker严格串行：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.driven_cloth_graph_ab --output build/NEW-driven-cloth-graph60
.venv/bin/python -m reconstruction.csrc.affine_graph_cohort --suite driven_cloth \
  --baseline build/NEW-driven-cloth-graph60 --output build/NEW-driven-cloth-fixed-C8
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-driven-cloth-constructor --fixture reconstruction/csrc/driven_cloth_scene.py \
  --prefix driven-cloth-six-springs-newton-w3 --fixture-args \
  --rigidity six-springs --worlds 3 --seed 3 --mode newton --body-block
```

局部主driver硬性要求全部16严格通过，所以在首轮12/16后未运行。
`run-validation-with-failures.py`明确保留12/16结论并继续诊断构造/graph/initcheck；不把放行诊断当作放宽验收。
Windows仍使用根交接的WSL2方法和固定Linux SDK，不能用随行Windows pyd代替当前对照。

14份deferred native追踪使用逐文件SHA内容去重的无损bundle提交，保留全部原始文件字节。
本机raw目录保留；新电脑需要读取原始包时，先运行：

```bash
python3 scripts/unpack_reconstruction_trace.py \
  build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-430b5b74-driven-cloth/\
pcg-input-traces-v2-688f9633/so3-w3-pd-b1/source/native-archive.json
```

每份bundle均完整roundtrip；另一次真实fresh extraction及existing verify均核对1381个原始文件。
