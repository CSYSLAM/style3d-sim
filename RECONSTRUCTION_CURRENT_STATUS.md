# 源码替换SDK：当前状态

最终目标尚未完成。只在本地推进，暂不上传；默认后端仍为SDK，`solver_api_ready=False`。
GPU实际数值及完整轨迹是验收依据，正常退出0不代表与原版完全一致。

最新验收口径：用户已明确允许GPU浮点差异，要求严格核准算法、调用调度和完整demo行为。
历史逐位差异及旧失败样本继续保留。按一个demo闭环后再换下一个推进，暂停新增host组合。
ANYmal已按此口径闭环：正式示例两处前端修复落地，双端500帧及完整调度已复验，原版共有穿地缺陷仍报告。
新正式对照最坏位置差6.347mm，source上尾大于本批SDK上尾，完整统计如实保存；不宣称逐位通过或通用误差界限。
cable bend也已闭环：三SDK/两source完整默认510原测试全0，完整730节点及同输入CG数学核准，原/源位置差小于SDK自差。
bundle、cloth-particles、ball_cloth也已闭环；后两项均实际原默认100，全部原测试0，完整调度及原物理检查独立核准。
五demo状态见`reconstruction/csrc/DEMO_CLOSURE_PROGRESS.md`，五项已按新口径关闭，仍不是全部solver完成。
最新版源码已从无SDK副本离线构建普通wheel并独立安装，五个原demo直接GPU运行已验证，仅映射源码Core。
四项原测试0，ANYmal仍为同样已知ground失败1；命令见`reconstruction/csrc/INSTALLED_SOURCE_GPU_VALIDATION.md`。
UR10默认128world/100复现对照也已核准：真实SIX力/Hessian32调用全严格，共有3.437km子步跳变及完整world严格同。
原例严重Cayley病态保留；不认证物理稳定、逐位长程或位置误差上界。见`reconstruction/csrc/UR10_GPU_DEMO_DIAGNOSTICS.md`。
Dzhanibekov默认SynReal/100也已闭环，三运行四通道全部逐位同，frame38翻转，COM漂移5.77e-10m。
fluid五鸭默认32/600已闭环，三原测试0，独立全密度/漂浮/轨迹及2354节点核准，当前同输入row8调用全输出严格。
新增诊断工具只核Model真实读取字段，不宣称opaque Model全部还原；旧C8/W3/eager失败及原过渡穿透保留。
当前仅活动项颗粒牛排原默认resolution64/360/no_cut=True；自动切割另需单独验证，不改SDK环境或外部训练。
本轮接续见`reconstruction/csrc/ANYMAL_GPU_DEMO_CLOSURE.md`，最新事实优先于下方历史严格判据的阶段记录。

## 当前主版本

- host：`13d6290f`；公开Core：`1f309794`，位于`build/reconstruction-csrc/source-core/9c57b3335772646f`。
- 两镜像由主源码重新编译，与最终已验private二进制完全相同。
- 932遗留权重key碰撞已修复：统一spring/distance/line/drive次序并移除旧remap；主构建旧32组完整回归全严格。
- CUDA176入口（129 owned＋47辅助），CUDA数学digest `f0e0137a…`保持。
- 固定SDK仍为项目内`64a0be7f…`，360冻结pyc保持。源码端不加载SDK、不需要账号。

此前完成：[cable/驱动/普通约束/实际刚体接触恢复](reconstruction/csrc/CABLE_DRIVEN_PLAIN_CONTACT_HOST_RECOVERY.md)。
112压力组合/89688 owned调用、十四constructor五项、十四公开graph120、七组双端initcheck3（14 worker）均通过。
七种组合240步历史/复用/扩容完整严格，484080调用同，实际正history命中和六缓存重分配已核。
主五正常demo60＋十四canonical graph120共19 GPU worker全0；112完整数组对1011136字节独立复核严格。
30步coverage不足和近静止coverage不足均原样保留；原压力场景只延长时长即通过，原有六份前30步完全重现。
这里只改两处host范围保护，GPU数学、阈值、迭代和固定SDK不动。
此前[cable/drive/mixed plain恢复](reconstruction/csrc/CABLE_DRIVEN_MIXED_PLAIN_HOST_RECOVERY.md)保持；
原932权重key兼容回归已在a6d9修复，旧32组/12576调用与首force前后buffer已在a6d9主/private严格回归。
五个正常demo仍为粒子、ball_cloth、cable bend、bundle、ANYmal；退出0不改判旧长程或物理失败。

此前bc81的[PD矩阵调度恢复](reconstruction/csrc/PD_MATRIX_DISPATCH_RECOVERY.md)：24严格控制、四graph、双端initcheck已验。
更早SIX/constitutive/cable等源码和证据保留。旧176e的74回归71严格/三粒子失败没有继承为新主通过率；
当前13d未重跑整套74，旧C10和长程失败保持。源码wheel和无SDK的sdist曾实际构建运行，不代表所有demo一致。

## 未完成与接续

非SO3＋布片private48为33严格/15失败，全部26016调用元数据同，范围保护尚未合入。
原生SDK/源码surface逐接触及实际原子操作数同，body block36 packet/864同输入调用也同；
这些局部证据不能替代完整联合轨迹，不能按误差小或逐word累加可达放行。

此前bc81做过[G1真实graph60诊断](reconstruction/csrc/CURRENT_G1_CORE_BC81.md)：两端原test0，
source对旧C8位置60/60、速度59/60，仍失败；新SDK控制也被旧规则拒绝。旧23.85尖峰未解释，基准不改。
H1/ANYmal/G1、自碰撞/颗粒/流体的其它旧长程或固定cohort失败均保留；H1两端601帧触发原穿地断言，不算通过。

cable＋drive＋两/三种plain无接触范围已合入；[cable完整首帧CG核对](reconstruction/csrc/CABLE_FULL_CG_CONTEXT_RECOVERY.md)
新抓四份完整首frame，920同输入packet/2760 GPU调用：全部向量严格，375 packet只差两个归约标量。
400归约上下文76800实际lane对相同，2400预定目标由1339真实GPU原子顺序证书精确复现，独立CPU复核通过。
该局部结果不关闭旧C8或长程失败，生产数学未改。
cable/drive/plain的实际rigid contact范围已合入dd62并保留。
此前[非SO3纯普通约束恢复](reconstruction/csrc/NONSO3_PLAIN_CONSTRAINT_HOST_RECOVERY.md)已合入d3f/Core18e：
96组/34056调用、24构造五项、24真实graph120、12组双端initcheck3（24 worker）全部通过，独立CPU已闭合。
主五正常demo60＋24 canonical graph120共29 GPU worker全0；192完整数组对1733376字节独立逐位复核。
只开放已证明的纯ordinary范围，CUDA数学/调用顺序不动。正在验证[非SO3关节](reconstruction/csrc/NONSO3_AXIS_JOINT_HOST_RECOVERY.md)。
非SO3关节现已合入13d/Core1f309。v1的SIX/无drive prismatic/AL/PD严重差异保留并已修复；
根据真实SDK恢复PD/AL line的块预条件器和extra product，及零alpha下joint AL物理调用门槛。
192完整控制/79938调用、24零alpha/8550调用严格，
旧SO3零alpha八组及首败/边界九组也严格；48构造五项、48真实graph120、24组双端initcheck3全通过。
主五正常60＋六预定package graph120全部0；48完整数组对433344字节独立逐位同。
主两镜像均与已验private完全同，CUDA176/f0e数学不动；旧74/C8/C10/长程失败没有重判。
继续按实际SDK恢复尚被保护拒绝的host组合，并处理完整demo差异。所有修复先保存首差、读实际调用/反汇编再修改，
维护固定SDK、首次样本及门槛。完整目标验收后才切默认/ready。Windows继续WSL2＋NVIDIA CUDA＋Python3.12。
详细进度看WORK_LOG末尾和本批恢复页；旧状态保存在`reconstruction/history`，按历史时间理解。

当前正式demo首差：主13d/Core1f309的cloth-particles，原版/source均真实graph60且原测试0，初始完整状态同，
60帧数值仍不同；第一帧位置max7.1049e-5、速度max0.022244，最早为布片顶点1，不能按退出0计一致。
数据见`build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-13d6290f-public-five-graph`。
首对照及独立CPU全帧审计已保存；完整24860节点/24859依赖、所有typed参数及跨节点指针别名关系同。
26份只读模型/缓存输入共2267844字节也逐位同。六个函数的编译资源属性有差异，尚未证明为原因。
独立诊断graph增加58个D2D观测节点，首次非线性迭代的拉伸力后RHS首差213 word、max3.7253e-9；
该入口的预测位置和入RHS逐位同。观测路径没有重现已冻结60帧首样本，不能据此关闭正式轨迹失败。
实际两端CUfunction隔离拉伸贡献完成：10368个有效atomic分量逐位同；scatter仍差61 word。
原/源观测和direct四份目标的327个不同word、1308标签，由673次真实GPU原子顺序证书全部精确复现。
Hessian实际两端CUfunction的93312逐三角形有效atomic分量也同；全局row-count实读核准。
四目标343 word/1372标签由687真实GPU顺序证书全复现，原trace259差异均覆盖；独立CPU全核，继续首CG。
三个已存原版60帧、同镜像/初始state/参数，三种相互组合q/qd均0/60帧逐位同，原版自身重复也有差异。
这些局部证据和重复性事实不证明全局执行顺序或关闭原60帧失败；生产数学、资源和门槛未改。
首CG及首apply同输入实际核对32次全严格，34500有效归约lane对同；四上下文12目标有8真实GPU顺序证书。
独立CPU核69000硬件history word；未声称首帧全部CG迭代或60帧通过。apply清零误标readonly的探针首败保留并已修正。
ball-cloth独立正式60已做：两端原测试0，完整state初始同，但q/qd都0/60严格帧；4238节点typed全同。
frame0 q max2.03848e-5、qd max0.00117302。首观测差异先在布片stretch，不能直接归因四面体球。
实际两端×两真实输入×三四面体核normal/isolated共24调用，38400有效分量严格，全部guard/readonly独立CPU核准。
controller末尾NumPy bool JSON错误1保留，独立CPU恢复报告，没有重跑GPU；完整ball轨迹失败不改。
详见[正式GPU诊断接续页](reconstruction/csrc/CURRENT_PUBLIC_GPU_DEMO_DIAGNOSTICS.md)。原public-five首cloth失败及其余三demo本轮未验状态不改。
不改生产数学或放宽门槛，最终目标仍未完成。

cable bend已核原60和默认完整510帧：60两端原线性挠度测试失败，默认510两端原测试均0。
完整四state全部保留，730节点typed/global aliases全同，四channel仍均0/510逐位帧；不是数值通过。
接续bundle180帧以越过原test的release＋0.4s早退条件，记录实际覆盖，不把短时长退出0当塑性已验。

bundle180现已实际覆盖释放后检验，两端7根/40segments/Dahl原断言均0，完整1977节点typed/global aliases同；
四state仍0/180严格帧，不改判数值通过。
ANYmal默认8world/500原例虽两端退出0，却首帧产生约135.8速度，最终高度约870、全部136 body超原0.25。
实际generated CUDA证明multiline速度lambda丢了<0.25而返回float，故原test是假阳性，不能算物理通过。
版本化副本已验证两处前端问题：FK后调用既有proxy sync，及把原速度判据合成一行。Native/原根example未动。
sync两端均补了约0.68m proxy初始位置，异常起飞消失；最终速度原0.070/source0.043，原ground断言仍失败32FOOT。
8次真实GPU谓词查询已确认旧式漏拦、修正式正确，不重跑/修改native状态。正在核实foot实际碰撞几何与body原点。

后续几何GPU实查确认32脚底球确实穿地，未扩张最小z原-0.03601176/source-0.03592178；并非仅body原点偏置。
SOFT和另外的显式HARD控制各两端均完整500，ground都失败32；HARD不是默认基准，亦不计数值/物理通过。
HARD v1漏prepare_contacts的构造失败保留；v2用既有API预留1000后完整执行，未改生产默认或native公式。
四份冻结最终pose另做collision-only查询，4次真实collision、求解graph0；各32 plane/sphere脚底接触实读。
接触margin实为半径0.031455，0.1 gap未被直接传作margin，不能按“半径丢失”猜测修改公式。
详见正式GPU诊断接续页，继续核接触响应及全轨迹；最终替换目标尚未完成。当前只本地，无上传/commit。
