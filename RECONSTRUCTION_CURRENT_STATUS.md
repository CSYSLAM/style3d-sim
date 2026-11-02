# 源码替换原版SDK：当前状态

最终目标是用仓库中的恢复源码编译独立`_core`，经正常Python API运行相关demo，
不加载原版SDK、不调用原版代算，并通过与固定原版的功能及数值一致性验收。
当前尚未完成完整替换；默认后端未切换，`solver_api_ready=False`。

当前 d09/Core55 的 G1 另固定三次真实 graph60，对照原八份 SDK，C8 仍失败，123 个字段/帧越界。
最新已补同一次受控第4子步全部5NL/250CG及apply：7620份非归约全严格，1704标量严格失败保留；
1000份实际归约输入贡献同，6000次SDK/PTX/source隔离及2633份硬件F32证书全部通过。
原子证书不证明联合调度或完整轨迹等价，当前没有改生产数学或重判旧失败。
见[同次五NL及接续host组合](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-d09d4be9-g1-fourth-five-nl/README.md)。

当前主源码/host为d09d4be9，匹配公开Core为55d626f0（`source-core/9cb2fcaa1082d1df`）。
已修复六块cable缓存typed-zero/位置及distance/point-line的weight上传顺序；176 kernel specs和CUDA digest保持。
新生产104个cable组合全部严格；新image独立74回归为71严格，三个粒子首source0的固定C10均在原版波动范围内。
严格失败原样保留，这不是74项全逐位同；旧0dab的Newton mixed C10失败也没有被重新判成通过。
当前Core的八个正常入口运行全0、无SDK映射，含用户五例各60帧；接口成功不证明其完整轨迹/物理验收通过。
旧0dab完整checkpoint已保存；过程、实际so、结果和新WSL命令见
[本批合入及验证](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-b82ecd80-cable-closure/README.md)。
以下“生产仍0dab/Core715”和b82段落为历史阶段；当前image结论以本段及WORK_LOG最新终态为准。

新增缆绳＋plain刚体约束隔离候选b82ecd80，生产仍0dab/Core715。
实际发现并修复六块缆绳缓存的晚分配/五块未初始化问题；原SDK为提前typed-zero，原构造失败保留。
24短程及10680 owned调用一致，六构造五项同，459完整CableView对核准；60步96/96严格，双端12份initcheck均零错。
合入前继续混合plain约束及penalty/reset分支，再对新生产image/Core重验，不继承本批局部结果为全solver通过。
实现、原始失败、实际so及Windows/WSL命令见
[缆绳与刚体约束恢复](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-cable-body-constraints/README.md)。

允许共享GPU，自己的worker串行，启动核剩余显存>=4096MiB，不等外部程序退出。
本批Newton mixed固定732输入/4392次fenced三端回放全部严格，独立CPU核输出/只读/参数完整字节；
运行时采样最低仍余15929MiB。39次实际缓存初始化返回ready，33次非阻塞consumer正确；不猜改生产同步。
只修mixed诊断上传屏障，旧正常轨迹和C10失败保留。数据、准确边界与命令见
[缓存返回及mixed同步复核](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-cache-return-sync/README.md)。

已确认并修复隔离检查器的pageable上传/非阻塞流竞态：同顺序同地址控制无fence6/750错误，有fence750/750严格。
原始带rotation控制另有13/750错误，也完整保留；不据此改判正常demo或旧C8/C10。
修正后的ANYmal同一次完整步覆盖35类/2608调用、5NL/250CG：5216输入/15648三端调用，3756严格。
余1460份的2071168真实贡献同，6054差异word/12885目标均经fenced GPU复现，708910历史word经独立CPU核准。
500份SO3 tangent全严格；12298个实际值连接及88个初始化完整buffer跨端相同，8个CSR输出CPU独立重算相同。
只改诊断上传屏障和同仓库证据索引，生产host/Core/SDK/数学不改；每scalar证书不证明联合全局次序或完整轨迹通过。
本批已补全同一上下文，接续回到正常demo及固定失败；旧无fence隔离回放需先复核，不用于猜改生产数学。
原始数据、控制、fenced命令和Windows接续见
[完整native step及同步修复](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-full-native-step/README.md)。

ANYmal五NL完整RHS/预条件器及outer状态已补查：222完整输入/666三端调用，181严格。
余41份的175840项真实原子贡献同，全部726差异word/1477目标由真实GPU复现，19004历史word经独立CPU核准。
298个实际值连接及4个public particle输出相同；所有状态更新、inverse、末位置/速度更新等同输入严格。
该阶段只抓CG首/末，完整五NL已由上述新捕获补齐；各批中间数据仍不能混用，整段及旧失败不改。
选择copy的独立诊断hook保留全部2608个launch和原ordinal，原hook/生产未改；两端各3098个raw文件全集精确匹配。
结果、尺寸区别及命令见
[五NL组装与状态](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-RHS-preconditioners/README.md)。

ANYmal首NL的六类matrix.extra生产者及direction/matrix已补齐50轮：800完整输入/2400三端调用，552严格。
248份非严格输入的545056项真实原子贡献同，全部892个差异word/1785目标由真实GPU复现、62940历史word经独立CPU核准。
1300个真实地址与字节连接全同，包括六算子累积到matrix.arg5；soft/limit此上下文未改输出，不外推一般分支。
原严格失败及完整轨迹失败不改；本批之后的RHS/预条件器和outer状态已由上述新上下文补查，完整CG传播仍未闭合。
范围、计数陷阱、实际终态和命令见
[完整50轮extra生产者](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-CG-extra/README.md)。

ANYmal同一public起点的首NL全部50轮CG核心已补查：430份完整输入/1290次三端调用，232份严格。
198份非严格仅世界系数归约差，所有向量/矩阵输出同输入逐位一致；原失败退出1保留。
108800对真实原子贡献相同，全部1017个差异word的2303个实际目标已由真实GPU累加排列复现，
独立CPU核156604历史word；1096个观测生产/消费字节连接全同，包含末update→首apply。
每标量可达排列不证明全局联合次序；该阶段未全回放的六类extra生产者已由上述新上下文补查，完整轨迹仍未通过。
本批2303次GPU证书在外部任务运行、余17553MiB时已完成；继续显存准入和自己的worker串行。
结果、失败搜索、命令及准确接续见
[完整50轮CG核对](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-first-CG/README.md)。

用户纠正GPU准入后，已取消“GPU必须独占”的自设条件；只检查剩余显存至少4096MiB，自己的worker始终串行。
原空等队列70166/99307/39819均由本agent停止并实际退出143，没有启动自己的GPU worker，也未停止外部任务。
粒子落布、ball_cloth、bundle、ANYmal各3/60帧原版/源码均实际退出0、状态有限，但四例完整逐位对照均未通过。
另五例通过真实公开源码Core715运行60帧，未映射SDK；正常Graph报告没有完整逐帧状态，不当作数值一致。
增加四份60帧原版重复，粒子原版自身最大位置差1.39326m；两个原版样本不能充当C8或改判源码通过。
首轮拉伸/弯曲/膜矩阵123840项实际GPU原子操作数同；215个拉伸、166个膜矩阵差异有762次GPU累加顺序证书。
另六组真实变形几何的54次未改核调用/36次追踪，743040项原版/源码实际操作数同，独立CPU核准。
足时长十个原始test_final均正常返回；其中ANYmal是假阳性：Warp提取多行lambda漏掉<0.25，
真实GPU/独立CPU核两端各136刚体均超速，不计settling通过；其余四例原/源八次原始测试正常。
这些均不代表完整轨迹验收；旧C8、当前74及生产镜像保持。
新结果、限制、命令和接续见[四demo实际结果](reconstruction/csrc/OFFICIAL_DEMO_FOUR_SHARED_GPU_RESULTS.md)。
604f的准备页及71文件清单保留为历史，不能据旧页重启已经停止的队列。

ANYmal追加500帧eager及原版Graph重复均实测，异常双端都有，不是Graph独有。
首Python预测器在native step之前已因eval_fk后未同步代理而产生约136的伪速度；四真实观测双端逐位同。
诊断副本仅调用已有sync_affine_body_state及合并测试lambda，首伪速度归零；500帧两端速度均达原界限。
但两端同有32脚部高度失败，原界限未改，副本未合入。结果与接续见
[ANYmal初始化定位](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-graph-eager/README.md)。

ANYmal脚部进一步实测：两端球面均实穿透约3.4至3.6cm，静态几何/材质逐位同，未调整高度阈值。
同一冻结状态的真实一步仍不同；首次接触前只有160条完整接触记录的排列不同，集合完全同。
完整force/tangent四输入/12三端调用2严格；33280真实原子贡献同，跨两运行按接触对应的16640贡献也同。
回放剩余12个word由24次真实GPU、144个历史word全复现，保存每线程目标内顺序，不推断全局次序。
完整一步/长程失败不改，继续位置是接触后RHS/CG完整传播；
[真实脚部与接触核](build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-anymal-foot-contact/README.md)。

当前正式cable bend stiffness的Newton/PD各60帧均独立运行，但固定8原版/3源码逐步C8两mode全false。
另六份held-out原版也全false，不能单靠该失败判源码错误；记录和后续首CG核对见
[cable bend实测](reconstruction/csrc/OFFICIAL_CABLE_BEND_0DABBAA7.md)。

新增驱动布料/self隔离候选7ca67172：实际SDK12组合支持、生产12 guard拒绝；据SDK恢复两处范围条件及self force位置。
候选9243调用参数/geometry全部同，10短程严格、两W3/PD/surface固定C8均三source false；四类constructor五项全同。
首表面力25输入/RHS同，792三端逐接触输出严格、每端8496真实操作数同；后续大响应尚未完整解释，候选未合入。
首次非隔离593证据仍不计隔离验收；隔离重跑已产出593份GPU结果并通过独立CPU，旧根工具退出码unknown保留。
源码、原始数据、编排失误记录及WSL接续见[驱动布料自碰撞](reconstruction/csrc/DRIVEN_CLOTH_SELF_HOST_RECOVERY.md)。
接续CPU已核两个失败组合144对surface视图，以及四类场景每端258次设备复制/396次byte fill，记录范围内全同。
后续四worker已结束：2376阶段/29844快照及独立CPU过；1188份完整输入的3564次三端调用全部严格。
新轨迹仍有大响应差异且未复现旧冻结轨迹，两个旧C8均false。首scale792隔离调用同、155份GPU标量证书过。
contact记录集合相同但16个行位置不同；scale差异落在代理上，首VF/EE/EF Hessian同，不认作大响应根因。
三个刚体块算子的198实际输入/594回放全部逐位同，独立CPU通过；首CG前RHS已差，完整轨迹仍失败。
当前结果及继续点见
[驱动self结果](reconstruction/csrc/DRIVEN_CLOTH_SELF_RESULTS_20261101.md)。

完整PD tangent本批已结束：51120阶段实采/CPU核准，固定四帧2112输入的6336次三端调用全严格。
其余1296输入/3888调用为1165严格、131份仅CG标量归约差异，逐粒子完整向量全同；
131份原始操作数原版/源码逐位同，1048次诊断调用给出262份完整三组标量GPU证书，独立CPU全过。
三条新轨迹首差均已连接到相同完整输入和两端GPU证书，不能外推为旧source0/frame32长程通过。
本批新原版/三源码轨迹对旧C8均false，旧失败、生产数学和候选未合入状态保持。
原始数据、命令和下一步见[完整PD阶段核对](reconstruction/csrc/PD_CONTACT_FULL_TANGENT_QUEUE.md)。

当前构建已推进到host `0dabbaa7` / Core `7151054e`（`source-core/5037032b98b9d614`）。
已合入验证后的bonds/刚体构造及准入；16短程、24项graph、三个正常Core入口及103/57/246合同已过。
完整74已结束：69项严格一致，particles seed1/2/3、mixed_cloth seed3、pd_mixed_cloth seed3共五项严格失败。
固定当前source0的十次原版对照已输出五项：三个particles与PD mixed在原版波动范围内，Newton mixed仍越界。
独立CPU复核实际0，五项结论均复现；当前三类constructor五项全同、driver实际0。
严格失败记录全部保留，不继承旧dec的通过项。
当前Newton mixed已重新采集0dab的冻结失败路径：732公共packet/4392三端回放及72散射packet均核准。
world85首差定位到调用90弹簧RHS，真实GPU相同操作数的两种顺序精确复现两端；固定C10仍false。
详见[当前mixed固定路径](reconstruction/csrc/CURRENT_MIXED_FIXED_0DABBAA7.md)。
外部接触组合隔离候选`4f638b4b`已编译：六SDK支持、当前生产六guard拒绝，候选四短程严格、两短程固定C8过。
四类constructor五项全同、六initcheck零错误；60步严格16/24，长程固定C8三source为10/12。
W3/subset/mixed/PD的eager/graph仍未通过全部长程门禁，候选未合入。
见[外部接触恢复记录](reconstruction/csrc/GRANULAR_AFFINE_CONTACT_HOST_RECOVERY.md)。
候选已独立跑现有牛肉demo低分辨率三帧，固定C8/独立CPU过；该短程配置不代表默认/长程验收。
接续PD失败组合：两个实际graph的拓扑/已审计参数及跨graph指针模式同；
960真实SO3输入/5760次三端调用完整输出严格，独立CPU重读及240份公开位置对应检查通过。
新观测先出现位置输入差，再出现rotation差；旧固定长程失败不改。
见[PD graph与SO3核对](reconstruction/csrc/PD_CONTACT_GRAPH_SO3_RECOVERY.md)，下一步向前核RHS/接触/颗粒与线性输入。
接续已实采21600份RHS/CG阶段，三条新诊断首差均为同输入CG分母第三组1 ULP；
72次真实SDK/PTX/source与18份GPU F32顺序证书核准，后续两向量36次同输入回放也全严格。
旧固定长程失败不改，下一步补CG extra/tangent及后期接触完整输入；
见[RHS与首CG差异](reconstruction/csrc/PD_CONTACT_RHS_CG_RECOVERY.md)。

## 已经做到

- 已重建176个CUDA入口：自有129、辅助47（Thrust22、CUB25），已纳入固定源码/版本清单。
  这不代表原版全部host组合和完整长程仿真已经一致。
- 已能从源码编译独立host扩展及真正的公开`_core`扩展。
  现有公开入口验证能独立运行Dzhanibekov、塑料袋及G1示例，没有映射原版SDK。
  G1原示例退出0不代表其独立长程一致性通过，原速度测试存在已记录的多行lambda读取问题。
- 当前0dab的74项回归为69项严格一致；这不是总体完成率，也没有涵盖全部长程及材料/约束组合。
  严格相等和固定原版重复运行的波动检查分开记录，不能将后者写成逐位一致。
- 历史dec阶段：颗粒＋SO3刚体的隔离候选完成四短程、构造五项、60步eager/graph16项、双端initcheck及六扩展布局验证。
  六布局状态全部逐位一致；两块中间buffer差异由真实SDK复现并定位为链表输入顺序，旧严格失败保留。
  已合入新host dec858e5，其四短程、六布局及16项60步graph本次全严格；当前74已完成71严格，三个粒子固定C10全过，constructor五项全同。

## 仍需完成

1. 当前d09仍须相关正常demo的完整轨迹验收；本次71/74及三个粒子固定C10不能外推全部范围。
   旧0dab Newton mixed固定失败保持，新image本次mixed短程严格通过不能改判旧source0。
2. 继续解决G1及复杂布料的长程固定对照失败；G1旧速度误差约23.85的尖峰尚未完整解释。
   已有大量同输入核对及归约顺序证据，不能据此把完整轨迹失败改判为通过。
3. 继续颗粒/刚体加外部接触隔离候选的PD多世界长程首差；其余未验证host组合仍需逐一实测。
   粒子seed2在旧host38的固定失败保留；当前0dab应按本构建的实际固定结果记录，不能相互继承。
   未捕获的组合总量尚未封闭，不能只按74项回归的失败数计算剩余工作。
4. 全部所需范围验收后，切换默认加载至源码构建后端，完成可安装交付及新机器复现。
   Windows当前使用WSL2；原生Windows移植尚未完成。

## 本轮记录及继续位置

当前生产合入证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-granular-affine-bonds-production/`。
`validation-0dabbaa7-v2/status.json`记录主验证，`constructors-0dabbaa7/status.json`记录三类构造；
两个生产验证driver分别是session68428与29879，均已真实结束0；该生产队列已结束，新诊断队列见顶部。
固定原版为项目内SDK64a，源码独立运行且无原版映射；原版及360份冻结pyc保持。
当前74严格失败五项，固定source0未替换。Newton mixed固定C10仍false，不宣布整体验收。

以下为上一生产dec的历史记录，不能用作0dab当前镜像的验收结果。

生产合入证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-granular-affine-production/`。
已保存改前31个构建输入/产物及SHA，原版SDK64a与360份冻结pyc保持。
首生产候选c915的新增范围检查误将自由刚体的6个DOF/6个target通道当作约束，首次worker被拒绝。
`rejected-actual-model-fields.json`实测确认全部约束/drive/bond计数为0；保留失败镜像、日志和命令。
只修此范围检查，未改求解数学；第二host已编译成功，SHA前缀`dec858e5`。
独立CPU确认与已测候选的数学文本相同，176入口清单不变、helper26匹配；这不能代替当前镜像GPU验收。
新公开Core SHA前缀`47ae9720`，路径`build/reconstruction-csrc/source-core/95f700673f9a3e0b/`，与host dec匹配。
Dzhanibekov60、plastic bag3、G1 graph60正常入口全0，未映射原版；不能代替G1独立长程对照。
验证session91260实际结束：74为71严格，particles seed1/2/3严格失败，但三个原首候选均通过固定C10、独立CPU复核同。
当前constructor92644五项全同、真实终态0；旧Core7eb仅对应旧host38，没有继承旧38通过项。
六组带authored/dynamic/mixed bonds的颗粒＋刚体已实测：SDK六组正常，当前生产均被guard拒绝。
据so恢复的隔离候选EFE已通过六短程全buffer/状态/ABI、三类constructor五项、24项60步eager/graph及双端共六initcheck。
这是隔离候选的实际GPU结果；随后已保存31文件检查点并合入0dab/Core715，正在对新image单独验收。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.build_host
# 当前验证驱动已启动时不要重复运行，先读取其status.json及实际进程。
phase_dir=build/reconstruction-csrc/affine-particle-material-host
.venv/bin/python "$phase_dir/continuation-20261101-granular-affine-bonds-production/run-validation-v2.py"
```

详细历史见[主交接文档](RECONSTRUCTION_HANDOFF.md)、
[颗粒刚体恢复记录](reconstruction/csrc/GRANULAR_AFFINE_HOST_RECOVERY.md)及[工作日志](reconstruction/WORK_LOG.md)。
