# 当前d09主线：颗粒/SO3刚体/外部接触候选ae及公开Core5688

目标仍是独立源码完整替代项目内固定SDK64a；完整替代尚未完成。
生产保持host d09d4be9 / Core55d626f0，默认原版、`solver_api_ready=False`。
本批候选没有合入生产，W3长程失败继续保留；不能因为原版控制也失败就自动改判源码通过。

## 源码和真实二进制

独立候选host：`candidate-guard-only/source_solver.cpp`，相对当前d09仅去掉一个条件中的
`contact.max_count || contact.soft_max_count`，保留SO3/self及其它限制。
反向补回后C++全文逐字节等于当前主线；没有改构造、迭代数学或CUDA176/f0。
此修改来自旧4f阶段六份真实SDK支持证据，当前版本另行验收，不继承旧4f结果。

- 候选host实际ELF：`candidate-guard-only/_source_solver.cpython-312-x86_64-linux-gnu.so`
- SHA256：`ae3a599746804de7218285712a29428138ffe78892d6e28953d77408ed8264e8`
- 公开候选Core实际ELF：`candidate-public-core/_core.cpython-312-x86_64-linux-gnu.so`
- SHA256：`5688f23b64d3de2fa01242e31777191820b069e4bdf935675e540d5a1b980417`

公开Core使用候选C++原字节和现有source_core.cpp wrapper，编译-H输出核准实际include了候选本地CPP。
只有PyInit__core，无SDK动态依赖；正常运行不加载原版、无A/B bridge、无账号登录。
源码、头文件、编译命令、include trace、真实.so及全部结果均随同一仓库携带，没有另一个二进制仓库。

## 当前已完成验证

六组合覆盖Newton/PD、W1/W3、1/2刚体、完整/子集颗粒及none/authored/dynamic/mixed bonds。
六份SDK参考沿用原冻结捕获；当前六source worker全0，初始model/actual-layout全部字节相同。
所有已审计owned参数、geometry和覆盖一致；4/6完整严格。
W3 mixed/PD状态不严格，W3 authored/body-hit/Newton只有首次soft force post_arg36 buffer不严格，状态本次严格。
二者首source0保持，固定原SDK8和新source1/2的短程C8均通过，独立CPU全部三帧/统计复现。

四类当前构造独立核五项全部通过，584份原版文件按primary SHA/bytes核准后原样复制。
仅新增12个source GPU观测和4个CPU，不重新抽取原版构造数据：

| 类别 | allocation events SDK/source | uploads | typed initializers |
| --- | --- | --- | --- |
| particle | 85/85 | 26/26 | 55/55 |
| rigid/authored | 90/90 | 29/29 | 57/57 |
| W3/body-hit/authored | 90/90 | 29/29 | 57/57 |
| W3/subset/mixed/PD | 98/98 | 31/31 | 63/63 |

上述四类当前source initcheck均实际0，全部`ERROR SUMMARY: 0 errors`。
六场景×eager/graph、每组固定八旧SDK/三当前source、全部60步均已运行，三个source worker实际0。
首source0为9/12、全部三source为8/12；独立CPU复算所有帧、四状态和两接触计数完全相同。
失败只在W3 mixed/PD和W3 authored/body-hit/Newton各自eager/graph，四组均完整保留，不合入生产。

## 长程失败的原版控制

预先固定三个独立SDK64a控制，保持六case和两mode顺序，不加进原八份参考，也不替换source0。
三个相同SDK对原固定C8只通过10/12、9/12、9/12；其失败也在上面四个W3组。
独立CPU逐帧及所有统计复现同。

PD/eager/source0最早在frame1/world2越界：原八SDK spread为0，q差1.4901161193847656e-8、qd差3.5762786865234375e-6。
实际SDK control2也出现此越界；更强的原始字节证据是源码前两帧的全部六数组与同一个control2完整前缀逐位同。
Newton/eager/source1及source2在frame55的全部六数组也匹配同一个control2的该帧，但前缀不相同。
没有拼接不同原版的字段或帧来冒称一个原版轨迹。

CPU穷举396个完整source/native轨迹对，24/36源码轨迹存在整段60步逐位原版匹配，余12条没有整段匹配。
上述证据证明C8也会拒绝实测原版输出，不能单凭拒绝而猜改源码数学；它不证明未匹配整段或所有输入等价。
原有C8、容差、失败、GPU资源属性和生产源均保持，候选仍未合入。

## 正常公开API的牛肉示例

编译候选公开Core5688后，正常newton.examples.run、原example及原test_final均不改。
固定配置为resolution12/substeps1/NL3/CG5/no-capture/3帧，只在solver实际返回后保存完整state_out。
三个正常source进程全部实际0、原`Beef checks passed`、无SDK映射、无桥接；
三条完整状态对既有固定八SDK的C8均true，独立CPU逐帧统计和原版primary SHA核准。
这项是公开API加数值验证，不只是CLI成功；不代表默认resolution64、长程或实际切割已验证。

## 真实终态与命令

- 候选build93465/02e465实际0，a67083反向delta/ELF CPU0。
- 六source短程66408/a09a56根1，六子worker全0；根1为两项严格失败，不伪改成0。
- 四构造95129/de9db1根0，12GPU和4CPU全0。
- 两项短C8 17084/9cb83d根0，bf4b49独立CPU0。
- 长C8 95810/b980e4根1，三子worker全0；c035e0独立CPU0，仍8/12。
- 原版控制90816/351d64根0，11c578独立CPU0；5ed450全部literal匹配CPU0。
- source initcheck84617/33e84c根0，四任务全0。
- public Core build12282/c93655根0，牛肉26862/218f58根0，bea572独立CPU0。
- 0a8971最终汇总CPU0，完整当前版本、初始输入、584原件、所有终态及失败核准。
- 47301c/4b6512的真实Core/host ELF检查及b0f7da的四image ELF CPU均0，实际六个CUDA/标准系统依赖、唯一PyInit核准。

1d0614和7a44f3仅为生成阶段128列门禁失败，发生在错误脚本写入/执行前；修分行后AST/128列通过才运行。
实际graph生成模板也在GPU前冻结，worker执行前必须逐字节等于该模板，不绕过SHA守卫。
补查ELF发现旧英文标签解析在本机中文readelf环境返回空依赖列表；旧脚本/报告以before-locale-fix原样保存。
新解析直接读取(NEEDED)并拒绝空列表；另对main host/Core和candidate host/Core四个实际ELF逐SHA/唯一PyInit/六依赖核准。
原空列表不计有效独立性证明；没有为此重跑或更换GPU数据、修改源码数学或重判轨迹。
自己的GPU worker严格串行，每次记录free/apps，free>=4096MiB准入；未停止或等外部worldparticle退出。

以下为实际阶段命令；目录已完成并拒绝覆盖，接续先读status和原始日志：

```bash
source scripts/reconstruction_env.sh
PH=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-d09d4be9-granular-contacts
.venv/bin/python -B "$PH/build-candidate.py"
.venv/bin/python -B "$PH/audit-candidate-cpu.py"
.venv/bin/python -B "$PH/capture-candidate.py"
.venv/bin/python -B "$PH/check-candidate-constructors.py"
.venv/bin/python -B "$PH/fixed-spread.py"
.venv/bin/python -B "$PH/audit-fixed-spread.py"
.venv/bin/python -B "$PH/graph-fixed-spread.py"
.venv/bin/python -B "$PH/audit-graph-fixed-spread.py"
.venv/bin/python -B "$PH/sdk-heldout3.py"
.venv/bin/python -B "$PH/audit-sdk-heldout3.py"
.venv/bin/python -B "$PH/check-literal-native-states.py"
.venv/bin/python -B "$PH/source-initcheck.py"
.venv/bin/python -B "$PH/build-candidate-core.py"
.venv/bin/python -B "$PH/public-beef-fixed-C8.py"
.venv/bin/python -B "$PH/audit-public-beef.py"
.venv/bin/python -B "$PH/close-independent-cpu.py"
.venv/bin/python -B "$PH/audit-public-core-elf.py"
.venv/bin/python -B "$PH/audit-four-source-images.py"
```

## Windows / WSL复用及接续

Windows仍用WSL2/Linux Python3.12，不是原生Windows `.pyd`移植，也没有本机WSL实测声明。
根交接完成环境后，可从本仓库当前固定版本直接用公开候选运行已验证的相同配置：

```bash
source scripts/reconstruction_env.sh
PH=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-d09d4be9-granular-contacts
.venv/bin/python -B -m reconstruction.core_demo \
  --core-build "$PH/candidate-public-core/build.json" \
  --report build/beef-candidate-wsl.json examples/example_granular_beaf.py \
  -- --viewer null --num-frames 3 --test --resolution 12 --substeps 1 \
  --iterations 3 --linear-iterations 5 --no-capture
```

此单次正常入口不自动计算C8；数值证据是上面冻结的三source/八SDK结果。
正常Core metadata用仓库相对路径验SHA；旧诊断plan仍固定本机绝对路径，换目录需创建新phase并记录路径映射。
后续主线源码变化会使旧候选的baseline SHA守卫拒绝，使用对应冻结commit或完整重建新profile，不删除断言。

下一步继续这四项W3长程的实际RHS/CG/贡献，特别保留当前source0的版本和首次越界位置。
另一个独立候选可在当前基线上接续7ca的self/drive范围及SDK实证调用顺序，并重验当前image。
原版自控也失败不授权修改容差或改判旧结果；候选、主线、正常API与桥接诊断的版本分开记录。
完整阶段集中提交一次，过程持续追加WORK_LOG，最终solver目标仍活动。
