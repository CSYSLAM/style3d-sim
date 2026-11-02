# 四个正式demo：共享GPU实测与粒子首差核对（2026-11-01/02）

最终目标仍是独立源码编译的公开 `_core` 替代固定SDK。当前生产host0dab/Core715保持，默认未切换，
`solver_api_ready=False`。本页记录已实测范围，不把核操作数一致、正常退出或原版自身波动当成整体验收。
固定原版为项目内SDK64a；另一个项目外旧版不作为本批对照。SDK和360冻结pyc随同一仓库固定。

## GPU准入及旧队列

用户指出另一个程序约占12GB后，确认先前独占门禁是agent自设的过度保守条件，没有实测OOM依据。
更正时实际总24455MiB、用5036MiB、余18907MiB；新worker启动前要求free>=4096MiB，记录同卡进程。
自己的worker始终串行，允许外部任务；没有中断用户任务，也没有改launch、物理、迭代或阈值。
本批结论明确来自共享GPU，不能追溯改判历史隔离门禁失败。

原空等70166/99307/39819逐一核PID、boot、start_ticks和argv后停止，三个原工具实际终态均143。
停止前没有自己的GPU worker，旧status.completeFalse是历史，不是live。不得按604f准备页重新启动这些队列。
604f的71文件preparation清单及结果页原样保留；本批实际数据全部放在下述新目录。

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261101-0dabbaa7-official-demo-four"
run="$phase/shared-GPU-v2"
```

## 已完成的真实运行

四例默认场景各3帧及60帧，原版/源码每worker实际0，全部记录状态有限。A/B采用既有eager子步记录器；
不能将它与正常Graph入口混为一谈。每个配置的首源码保留，原版后续重复没有替换失败样本。
粒子指 `example_cloth_particles.py`，ANYmal为 `example_robot_anymal_d.py`，bundle为
`examples/cable/example_cable_bundle_hysteresis.py`。

以下q是particle_q、qd是particle_qd，报告原始分量最大差。布料/自由粒子位置单位为米；
刚体还含仿射代理的方向轴分量，不能将ANYmal/bundle的整张数组统一作长度解释。严格一栏指完整逐位。

| demo | 3帧子步 | 3帧q最大差 | 60帧子步 | 60帧q最大差 | 60帧qd最大差 | 原版两次60帧q差 | 严格 |
|---|---:|---:|---:|---:|---:|---:|---|
| cloth-particles | 30 | 0.000770926476 | 600 | 1.38706548 | 6.57066095 | 1.39326006 | false |
| ball-cloth | 6 | 1.01327896e-05 | 120 | 0.00399875641 | 0.552220315 | 0.0043656826 | false |
| cable-bundle | 30 | 3.59534624e-12 | 600 | 0.0501202345 | 9.50745773 | 0.0790201724 | false |
| anymal | 12 | 1.98547214e-05 | 240 | 0.00670026988 | 0.104497017 | 0.00604395077 | false |

bundle第一严格差子步1，其他三例为0。bundle/ANYmal还完整保存body_q/body_qd，不能只看本表粒子位置。
原版重复每例目前只有两份，不是C8、没有统计接受结论。粒子自身1.39326m表明长程差不能直接认定源码bug；
也不能据此宣称源码通过。当前74项69严格、五失败及固定C10结果均不变。

另通过真正公开源码Core715、原例子Graph路径运行四例各3/60帧，以及cable bend60帧，实际全部0，
没有映射SDK、不使用A/B bridge。`normal-core60` 的status只含四例，cable-bend实际退出在单独receipt中。
正常Graph本批只有最终执行记录及计数，没有逐帧原始状态；不能声称Graph数值一致或用计数推断所有replay。
`completed60-independent-cpu.json`用另一套NumPy实现核五正常入口、四原版重复及第一轮三核的完整before差异。

## 粒子首阶段、完整输入与真实操作数

`particles-first` 是一份部分buffer上下文：每端74dump，十生产消费链接/端核准。
该上下文首拉伸RHS差3.7252903e-9，随后弯曲RHS3.8146973e-6、inverse前矩阵4.0。
首CG与首apply隔12次CG，首apply与公开子步状态又隔20次非线性迭代，不建立省略中间阶段的错误因果链接。
它没有复现原冻结失败轨迹，不能当作原运行的私有内部历史。

`particles-full-inputs` 是另一份独立完整捕获：8625粒子、1152三角形、1776边，ELL每行12。
九算子的全部非空flat指针被捕获，18完整packet/54真实SDK-runtime、原PTX、源码PTX调用中9packet严格。
其余差在散射力、膜Hessian和CG标量；inverse/direction/update/apply同输入完整输出逐位。
54调用核1218实际参数字节、36018048输出字节、37446576保护字节及2alias组，独立CPU实际0。
GPU回放根退出1明确保留，不因后续解释而改成0。

三个核使用原提取PTX和源码PTX进行真实GPU追踪，未更改生产数学：

| 核 | 同输入实际原子操作数/端 | 验证 |
|---|---:|---|
| evaluate_stretch_force | 10368 | target、F32值、线程内序逐位同 |
| evaluate_bending_force | 20160 | target、F32值、线程内序逐位同 |
| membrane Gauss-Newton Hessian | 93312 | target、F32值、线程内序逐位同 |

原始trace/count/实际参数/保护区均由独立CPU重读，总123840项。不推断跨线程实际全局执行顺序。
完整捕获的弯曲before RHS已有216字节差，其他六before同；本次post RHS最大差1.4901161e-8。
这与上面的另一部分捕获不同，不能混用数值。

第一拉伸六before全同，215个post RHS word不同且初值均+0。
逐word使用真实相同addends找两端可达F32排列，430次真实GPU atom.global.add.f32精确复现两端及2556个历史word。
第一膜Hessian八before全同，diag164/ELL2个word不同；保留非零初值，332次真实GPU精确复现两端及1952个历史word。
每word最多六项且来自不同线程，排列不违背线程内序；保留原值、没有调阈值或修改生产累加顺序。
这762次证书说明这些具体差异由浮点累加顺序可达，不代表已经证明长程所有差异的成因。

## 变形几何下补查三个核

从本批原版和源码60帧轨迹分别取零基子步9/299/599位置，共六组真实变形几何。
只替换x，弯曲previous换同轨迹前一public子步；材料、拓扑、初始累加器和实际ABI保持完整首捕获。
这些是共同输入的诊断夹具，不声称重现当时求解器的私有history、矩阵或某次迭代。

18packet分别调用真正SDK-runtime、原PTX、源码PTX，共54次未改核调用；再36次真实PTX原子追踪。
全部743040项target、F32值和线程内序同；CPU独立核原始trace、完整组保护区、参数及各端聚合输出。
未改核聚合输出仍有散射顺序差，保持记录。真实末期几何扩大了测试覆盖，不替代完整轨迹门禁。

## 足时长原始最终测试及ANYmal假阳性

`functional-worker.py`保留真实公开API及Graph，不改capture/step、原例子最终断言或阈值，
只观察test_final进入/返回，并在finally保存最终完整state及实际SDK映射。十个worker实际0、十次测试均返回。

| demo | 帧数 | 原版test_final返回 | 源码test_final返回 | 验收解释 |
|---|---:|---|---|---|
| 粒子落布 | 100 | 是 | 是 | 原始测试正常；不等于逐位轨迹通过 |
| ball_cloth | 100 | 是 | 是 | 原始测试正常；不等于逐位轨迹通过 |
| cable bundle | 180 | 是 | 是 | 已跨过release2s+0.4s，未走提前return |
| cable bend | 510 | 是 | 是 | 原著ramp2s+hold6s+30帧，原始断言正常 |
| ANYmal | 500 | 是 | 是 | 两端均假阳性，settling仍失败 |

独立CPU重读ANYmal最终body_qd发现原版最大38.4399414、源码38.4887695，均在第三线速度分量，
最低z分别870.15460/870.32275m，显然不能称为机器人稳定落地。
原例子多行lambda第二行是`<0.25`，Warp1.16提取却只得到`max(abs(qd))`。
保留该轮真实生成的CUDA：返回float，随后被转为bool，正速度被当作通过。

在同一保存的最终state上，原helper+原lambda均假通过；具名wp.func表达原有界限则均抛ValueError。
真实GPU直接按原阈值检查，每端136刚体全部失败；独立CPU重读272个failure标记完全相同。
报告在`functional-tests/anymal-predicate/`，没有修改原例子、求解器或0.25界限。
因此只能记另四例八次原始测试正常，不能把ANYmal正常退出算物理验收。
该异常也存在于固定原版，不能无证据修改源码数学以追求一个原版自己未达到的静止结果。
随后追加的Graph/eager与首预测器实测已定位FK代理未同步；仅诊断副本补同步后不再飞高，但双端脚部高度仍失败。
详细数据与后续入口见根CURRENT_STATUS链接的ANYmal阶段，原始失败和本页冻结数值均保持。

## 命令与新电脑接续

下列输出目录已有证据，脚本有拒绝覆盖保护；在新checkout或新命名阶段重跑，禁止删除旧数据后冒充同一cohort。
Windows继续用WSL2/Linux和NVIDIA CUDA；原生Windows尚未移植。先按根交接安装依赖、核完整snapshot，
恢复固定ANYmal资产，再运行以下检查。不要恢复独占GPU条件，也不要杀其他任务。
变形追踪report.json为147365458字节，超过GitHub单文件限制，仓库保存9753946字节的无损gzip。
快照固定压缩/原始SHA，验证器直接流式核解压payload；下列恢复命令验证已有文件或原子新建，拒绝覆盖不同结果。
历史审计内部含原机器绝对路径；要原样复核，WSL目录使用`/home/oem/code/agent/style3d-sim`，
或在新的审计副本中显式映射前缀，原冻结JSON、hash和文件不改写。

```bash
python3 scripts/verify_reconstruction_snapshot.py
python3 scripts/restore_reconstruction_evidence.py
.venv/bin/python -B scripts/restore_reconstruction_anymal_assets.py --help
# 以下为已执行的历史审计命令；已有输出时会拒绝覆盖。
# 要重跑，另建阶段/审计副本并指定新的OUTPUT，不能删除冻结结果。
.venv/bin/python -B "$run/audit-completed60.py"
.venv/bin/python -B "$run/audit-particle-operands.py"
.venv/bin/python -B "$run/audit-stretch-folds.py"
.venv/bin/python -B "$run/audit-hessian-folds.py"
.venv/bin/python -B "$run/audit-deformed-inputs.py"
.venv/bin/python -B "$run/audit-functional.py"
.venv/bin/python -B "$run/verify-anymal-predicate.py"
# 真实正常源码入口，输出报告必须是新路径；此命令示例验证粒子自身test_final。
.venv/bin/python -B -m reconstruction.core_demo \
  --core-build build/reconstruction-csrc/source-core/5037032b98b9d614/build.json \
  --report /tmp/source-particles-functional-new.json examples/example_cloth_particles.py \
  -- --viewer null --num-frames 100 --test
```

所有生产镜像与旧失败保持；不要把“正常退出”“相同操作数”“可达浮点排列”“固定cohort接受”“逐位相等”互换。
继续位置优先为ANYmal实际Graph/eager异常及真实接触/CG完整链条，完整轨迹门禁仍需完成。
有新差异时查固定SDK实际调用/反编译和同输入，不以改容差、线程块、迭代预算或删除失败样本解决。
G1、Newton mixed、复杂布料及两个隔离候选的长程失败仍在根CURRENT_STATUS，不能因本批核对而关闭。

两处as-run脚本各有超128列：normal-core.py:25为157列、trace-deformed-inputs.py:177为147列。
生成器是先落盘再做列宽断言，断言实际退出1；随后GPU执行成功并固定了源码SHA。
为保存实测provenance保留这两行，并登记格式例外；后续生成脚本改为先验证再写文件。
