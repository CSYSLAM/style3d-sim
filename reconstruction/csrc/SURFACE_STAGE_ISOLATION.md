# ff34 surface差异：阶段验证与隔离记录

这批记录继续检查已发布ff34的固定失败，没有修改参考64a、CUDA数学、比较门槛或旧候选。
后续正式host已经另行恢复body/tetrahedra，见[BODY_TETRAHEDRA_HOST_RECOVERY.md](BODY_TETRAHEDRA_HOST_RECOVERY.md)。
不要把下表的oracle或实验结果当作正式源码so验收，也不要把ff结果直接计入后来image。

证据根目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-ff34e6a1/`。
固定旧cohort：`validation-ff34e6a1/surface-cohort8/`，仍保存原8次、源码3次和失败报告。

## 阶段验证结果

- CPU重算固定cohort的48个source/case统计，逐字段完全复现；保存首个超C坐标和原始位模式。
- 新probe保持8场景×eager/graph×60帧完整worker，只在指定W3 Newton block/self/spring首个eager步
  开启已有full-owned-hook。避免持有scene/bound method延长其生命周期。
- `all-body-stage-audit/`核对230次完整owned调用参数/geometry和214个定义输出。
  首个抓到的输出差异在surface force，18个float32词不同。早期correct-vector探针为14词；两者观察点不同。
- 两个诊断worker都未复现冻结source0/original0，不能将其内部状态称作旧固定失败的第一处分歧。
- 完整抓取body block build、apply、SO3 tangent各自的真实输入，共每侧33个packet。
  在同一分配上轮换actual SDK runtime、original PTX、source PTX，每后端8次：
  **1584次核调用、1728个输出buffer比较全部逐位同，也全部等于抓到的实际输出。**
  空cable CSR验证为[0,0]，保留byvalue payload和指针别名，没有用不同输入作近似比较。
- CUPTI抓到真实SDK模块与三份literal PTX加载模块：整个3605304字节ELF逐字节相同，包含97个text entry。
  所以以下两类oracle的轨迹差异不能归因为它们的机器码不同。
  当前源码的若干affine/body-block机器码仍不同，但这些实际输入的局部计算已经逐位核对。

## Oracle只用于定位

每个模式预先运行一个完整worker，对同一冻结原8份NPZ计算既有指标；不是新的源码验收cohort。

| 诊断实现：host仍ff34 | 对原版0严格轨迹数/16 | 落在冻结C范围的轨迹数/16 |
| --- | --- | --- |
| 四个surface核替换为原版literal PTX | 12 | 12 |
| 全部owned核替换为原版literal PTX | 12 | 15 |
| 四个surface核替换为SDK实际kernel stub | 11 | 12 |
| 全部owned核替换为SDK实际kernel stub | 13 | 14 |

全部owned模式请求129入口，场景实际调用52个。没有用SDK的Solver来代算host。
runtime oracle明确允许加载原库，输出`oracle-*`和禁止作为source/original样本的标记；
不生成source-only证明。literal/runtime模块装载、指针布局、调用路径及原子调度等影响尚未完全隔离。
单次改善或单次失败都不是全局因果证明。

## 源码形态实验

所有实验都来自恢复源码，未采用原版PTX或原版GPU核来代算，也未覆盖活动host so或accepted CUDA bundle。

| 实验 | 局部串行分支比较 | 预先固定3源码worker对原8份的整段C |
| --- | --- | --- |
| 220-byte结构，preconditioner展开7个normal+7个friction Jacobian | 324项全严格 | 10/16，失败 |
| 恢复6个模块分组，保持每个source entry digest不变 | 所有entry digest不变 | 10/16，失败 |
| 被拒绝contact返回零结构，替代bool提前continue的假设 | 324项全严格 | 11/16，失败 |

另有零初始化record、跨grid循环保留record两个试验，各324项局部比较全严格，没有据此直接运行或验收正式so。
原preconditioner有126个静态red site，展开实验也为126；原local workspace为440B，trial该算子仍为220B。
结构返回使force的mov.u32从71/73接近到870，原版为1094；文本仍不同，接口还原仍是假设。
这些负结果和每种首候选均保留，不按哪个偶然通过来挑选实现。

6模块含176个唯一入口、205个实例：13个辅助符号跨模块重复，共29个额外实例；owned129没有重复归属。
模块试验只在轨迹中替换owned核；source BVH桥的runtime library核没有被该driver探针替换。
生成的cubin是本机GPU产物，换GPU须从源码PTX重新链接，不能作为跨GPU参考二进制。

## 独立原版holdout

另预先运行3个**未修改的原版**完整worker，无launch/memory观察器，作为独立holdout，不加入冻结8份基线。
48条holdout轨迹有12条超出保存的C范围。W3 Newton block/self/spring eager的3条全部超出；
第一条首步粒子速度最大差0.010344505310058594，而冻结8份在此步spread为0。

运行fixture/worker哈希相同，日志GPU/driver相同，10个Warp GPU module签名集合相同。
冻结时所有CPU依赖和环境变量并未完整哈希，不能据此声称所有环境因素都已排除。
这证明C8失败也会出现在未改参考程序的独立运行中；不单凭这个数字断定源码算错，也不据此重判源码通过。
holdout没有逐轨迹复现旧source0；基线128份NPZ前后SHA不变。

## 复现命令

先`source scripts/reconstruction_env.sh`。GPU任务串行，输出目录必须是新名字。
旧image实验须先使用保存的ff34检查点，不能把后来b945的host混入ff34统计。

```bash
recon_evidence=build/reconstruction-csrc/affine-particle-material-host
recon_ff="$recon_evidence/continuation-20261031-ff34e6a1"

# CPU-only：重算固定失败，保存精确超C坐标，不扩充原8份。
.venv/bin/python -m reconstruction.csrc.audit_fixed_surface_cohort \
  --cohort "$recon_evidence/validation-ff34e6a1/surface-cohort8" \
  --output "$recon_evidence/NEW-fixed-C8-audit.json"

# CPU-only：核对已抓到的实际SDK与literal PTX完整ELF。
.venv/bin/python -m reconstruction.csrc.audit_runtime_jit_images \
  --capture "$recon_ff/body-stage-jit-replay-prebuilt/jit" \
  --output "$recon_evidence/NEW-jit-image-audit.json"

# 已有packet同输入回放；新host的结果须使用自己的source哈希单独记录。
.venv/bin/python -m reconstruction.csrc.surface_body_stage_replay \
  --original "$recon_ff/all-body-inputs-original" --source "$recon_ff/all-body-inputs-source" \
  --output "$recon_evidence/NEW-body-stage-replay"
```

`surface_worker_stage_probe`须由父进程设置full-owned-hook的LD_PRELOAD与CUDAHOOK_DIR；
现存correct-vector/all-body-inputs运行命令、fixture、harness SHA和完整worker数组均保留。
`surface_oracle_worker --runtime`显式借用SDK实际核；它永远不是源码接受命令。
`surface_layout_cohort_trial`预先固定3份source-only worker，不读取或调用原版求解器。

失败探针、旧版harness和编译失败记录都保留在根目录及各子目录的FAILURE/版本文件中。
首次SO3 tangent抓错arg1已修为arg0并加入vec3 pointee校验；不要重用旧版失败探针。
初次CUPTI observer混用12.4/13.2头编译失败；有效运行使用已随仓库携带的cupti_param_trace.so。

下一步：继续按实际原版补确实缺少的host分支；surface局部证明和原版holdout不能代替完整solver验收。
如果继续细化surface代码形态，先从原版PTX确定record生成、零结果返回和local workspace的数据流，
再检查同输入全部实际atomic操作数。所有当前失败保留，solver_api_ready仍为false。
