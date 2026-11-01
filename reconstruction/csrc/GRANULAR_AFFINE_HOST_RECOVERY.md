# 颗粒与SO3刚体组合：实际支持与独立候选核对

> **dec当前验收已终态：74为71严格，三粒子固定C10全过、constructor五项同。** bonds/刚体SDK六组支持已实证。
> 隔离EFE六短程全严格、三类构造五项全同、60步graph24/24及双端六initcheck零错误；待生产合入及新image回归。
> 旧G1/复杂布料失败不改、readyFalse；[当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于历史。

> **当前dec/Core47：完整74已结束，71严格；三粒子首失败C10仍待GPU。** 当前constructor及bonds支持发现依次排队。
> bonds隔离源码已据固定so构造/七处参数调用恢复并编译，26helper同；尚无本组合GPU结论，生产与readyFalse保持。
> [当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于下方历史记录，不继承旧image的C10通过项。

> **当前host dec858e5/Core47ae9720已完成三正常入口。** 四短程、六扩展布局和60步graph16项本次全严格，原版未映射。
> 74/fixedC与当前constructor继续排队，readyFalse；通用初始化decoder已以原始两批数据核准，不改旧失败。
> 下一步带bonds颗粒/刚体实际支持发现；[当前状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先，下方为历史记录。

> **生产合入进行中，尚未验收。** 新host dec858e5恢复颗粒/SO3缓存及准入，CUDA176/f0保持。
> 首guard误拒绝自由DOF已据真实字段修复；新版串行验证session91260等待外部GPU，不能继承host38的71/74。
> 匹配新版Core尚待构建，默认后端不切换、readyFalse；[当前整体状态](../../RECONSTRUCTION_CURRENT_STATUS.md)优先于下方历史记录。

> **候选2实测完成，准备生产合入。** 四短程case全严格，constructor五项全同（85/85、26/26、55/55、544/544）。
> 60步eager/graph16项全严格，双端initcheck零错误；六较大布局状态全部逐位同。
> 一组旧force/diagonal严格失败保留，但其旧源码结果由真实SDK重现；完整输入及共同链表三端180输出全严格。
> 根因是输入链表顺序变化，生产数学/排序未改。源码仍为隔离候选402a7a5c，生产38/Core7eb及整体readyFalse保持。

> **最新：首隔离候选4/4短程完整严格，constructor仍发现真实差异。** 原版typed55、候选41，分配85/83；上传26/26同。
> 第二候选恢复两块未使用候选缓存及12组颗粒typed零初始化，26个helper设备入口与已验收源码逐一同。
> 候选2 SHA402a7a5c…已编译，实际验证尚在队列，生产host38/Core7eb和readyFalse不改。
> 三个串行阶段已启动，先四组，再constructor/graph/initcheck，全部满足后才进入六组较大布局；不得重复启动。

承接34700716；生产仍host38/Core7eb、SDK64a、CUDA176/f0，完整替代未通过、readyFalse。
本轮先验证实际功能范围，避免把静态guard计数当作已证明的缺陷。

## 固定输入与已完成结果

`granular_affine_scene.py`构造单世界8普通颗粒及1个SO3刚体，刚体生成4个真实代理粒子。
颗粒启用真实邻域接触；Newton/PD×body block开关，四组每组3步。无外部接触、自碰撞、其它材料或约束。
原版四组均真实退出0，粒子与刚体状态都变化且有限；granular force只改变0..7行，代理索引实际为8..11。
完整owned调用分别386/485/383/482次，含实际颗粒grid/force/tangent及SO3力/预条件器/tangent/state。
当前生产源码四组均退出1，明确报`Granular combined with other materials or bodies has not been captured`。
这已经证明本组合是原版支持而当前源码拒绝的实际缺口，尚不能宣称已恢复。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-granular-affine-support/`。

首驱动session62982的CPU审计失败：错误期待8行state，实际Newton扩充后记录12行。
保留v1脚本、plan、log及actual_exit=1。新`independent-cpu-audit-v2.py`只修12行检查及前8行实际演化检查，
另写v2输出；全部原始8 worker数据保持，未重采GPU。v2独立CPU实际0，支持4/4、源码guard4/4。
审计明确区分普通粒子/代理，检查实际grid ids、world值、完整force前后、实际ABI/geometry元数据及所有状态。

## 正在验证的隔离源码候选

从冻结生产`source_solver.cpp`复制，仅在granular拒绝条件中去掉`has_bodies`项，所有数学与CUDA保持。
使用原编译命令和相同27项输入，仅增native header搜索路径及改源码/输出路径，编译到本阶段candidate目录。
此修改仅用于观察已有调度是否正确，不把未测试组合开放到生产。
编译session83104实际0，候选SHA：
`d9f2c328bf6f032cda86eb5b4914558029077abccf977fb26b17f636a5fdf6d6`。
生产host38/Core7eb及所有原始文件未改；独立CPU核准源码与编译命令的精确差别。

`candidate-worker.py`按完整输入/二进制SHA加载该源码image，走既有独立host bridge，不加载SDK代算。
四组候选已预先冻结，比较原始SDK状态、全部被采集buffer的完整前后字节、完整owned调用/几何/参数及coverage。
候选驱动session85554启动时等待外部GPU PID2727055；外部任务未终止。实际状态见candidate.run.status.json。
任何超时不是停止证据，应继续查询同一session或实际PID，禁止重复启动。

接下来先看四组实际结果，再按实际调度首差恢复；即使四组全严格，也还需要constructor、真实graph、initcheck及范围检查。
先保留生产版本及拒绝保护，再决定经过验证的生产准入范围；不按“去掉guard能跑”直接宣布完成。
G1/布料/粒子原固定失败不受本阶段影响，Windows继续WSL2。

```bash
source scripts/reconstruction_env.sh
# 下列任务已启动；先核session85554，勿在同目录重跑。
.venv/bin/python build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-granular-affine-support/run-candidate.py
```

## 未完阶段检查点

本次提交只固定已终态的支持发现、v1失败/v2修正、隔离源码构建及后续检查脚本。
`support-immutable-manifest.json`列出实际不可变文件；运行中的`candidate.run.status.json`及候选实际输出不在此检查点。
本机驱动85554仍在等待已确认存活的外部PID2727055，未终止也未重启；后续须继续同一session核实际结果。
其它机器的独立验证应先确认本地没有活跃任务，再使用新输出目录或独立checkout执行，不把本机PID当作远端作业。
准备好的`check-constructors.py`和`check-graphs.py`均要求候选4/4严格结果存在，尚未启动，更未通过。
完成候选采集后发布完整终态，再执行这些检查；不将本检查点升级为分支恢复或生产验收。

## 首候选实际结果与constructor真实差异

首候选驱动85554实际退出0；四source worker2756237/2756461/2756549/2756714及独立CPU2756823均实际0。
四组全部3步完整状态、全部采集before/after、完整owned参数/几何/coverage逐位同。
这是运行证据；随后构造检查发现的差异仍需恢复，不能据短程结果直接推广。

constructor驱动23708实际0，但其CPU子任务实际1，六GPU worker均0。
首CPU遇到原版实际ivec3/vec4 typed fill，通用decoder没有这两种类型，未产生有效完整报告。
`constructor-audit-v2.py`只在诊断进程扩展12/16字节类型，原脚本及旧失败保留，原始GPU数据未改。
V2实际退出1：原版/候选allocation85/83、typed55/41、upload26/26，pointer identity及library时序也不同。
`difference-details.json`直接重算14个缺失默认初始化，value字段全部零，没有source额外typed调用。
当前SDK64a的SelfCollision/Granular initialize已按实际nm地址、大小重导出，manifest固定二进制和反汇编SHA。
未将旧4c的reference_analysis/host/verified当作当前SDK证据。

## 第二隔离候选及后续执行链

候选2源码仍在阶段目录，不写生产路径：

- 无三角形时保留观测到的两块候选缓存，保持VF query关闭和既有有效capacity。
- 颗粒head/next/ids/world/cells/positions/previous/radius/counts/neighbours/cache/diagonal按原typed顺序零初始化。
- bridge enum末尾追加Index3/Vector4，旧值不变；新26个设备入口全部规范化digest匹配已验收176清单。
- 原176源码bundle、生产数学和容差不改。独立编译SHA402a7a5c323eb20642a214dd6d52a81e53c8b83253562d512e87258b46d3675e。

首candidate2生成器缺外层sys.path，在NVCC之前退出1；全部生成源和plan保存在candidate2-generation-failed-v1，无GPU启动。
修正Python导入路径后编译session24413实际0，helper26/26通过。原生成失败不删除、不当作求解器结果。

当前三个具体任务：

1. session10867：四个candidate2 source case，实际SDK参考仍用原四组，不替换原始数据。
2. session50900：跟踪前一driver PID2764084/starttime141852150；四组全严格后执行constructor2、60步graph16项和双端initcheck。
3. session71924：跟踪前一followup PID2770923/starttime141873602；上述全部通过后执行六组较大布局的双端采集。

阶段启动时外部GPU PID2761439实际占用，未终止；当前进度以本机session及实际PID为准。
`candidate2-followup/run.status.json`和`broader-layouts/run.status.json`不是完成证明；必须读实际子任务退出与报告。
初始等待者只追踪同一PID及starttime，不并行启动多个solver，也不因观察超时重开任务。

新增`granular_affine_layout_scene.py`覆盖1/2刚体、8/27普通粒子、1/3世界及颗粒子集；六组输入预先冻结。
多世界material选择会在插入body proxy后重排；新检查核实际granular/proxy/world映射及全部原始状态，不只看退出码。
CPU作者API已确认默认共享world=-1、replicate后0/1/2；该检查会初始化Warp枚举设备，但未提交solver或kernel工作。
`graph-template-preflight.py`真实生成/解析四case和无SDK映射断言，实际0，没有执行graph worker。

全部后续结果仍待实际任务，不能写成通过。完成后继续拓宽有效组合、验证真正公共Core及必要回归，最后再决定生产准入。
原G1/布料/粒子固定失败、参考版本及阈值保持，完整源码替代仍未验收。

## 候选2最终实际验证

candidate2四worker全部0、四组全严格；constructor2六GPU worker与独立CPU全部0。
五项检查全同：allocation85/85、upload26/26、typed55/55、485完整owned及544/544 owned+library时序。
这是对缓存恢复的实际验证，原候选1缺失14项的报告保持不变。

首graph2两worker因新适配器把Path写成str，在构造模型之前退出1；旧as-run/log/status及连带停止的followup/broader保留。
只修路径记录类型为Path，新V3目录重跑，不重编solver、不重采已通过constructor2。
V3 CPU预检真实检查生成代码的所有runtime paths均为存在的Path；graph16/16比较全部60步逐位同，双端initcheck零错误。
followup V3 session63949实际0，两个graph worker和双端sanitizer均实际0。

六扩展布局的12 worker均实际0，material/proxy/world映射直接核准，全部六组3步状态逐位同、owned metadata及coverage同。
五组全部buffer严格；W3/27grains/1body/block1的首次granular force和diagonal两post buffer严格不同，旧报告保留。
这组不是求解器状态失败，也没有把中间buffer失败删去或放宽。

## 两块差异的完整输入与真实SDK核准

`first-force`预先固定三SDK/三candidate2，捕获首force的全部11个View指针pointee、五个普通指针输入/输出和完整120字节View。
counts/neighbours/cache的View指针与普通参数确实别名；回放保持全部重叠和mod256，并保存完整after、真实ABI及guards。
81grain/93 native particles/256 slots，所有实际hash链均无环、覆盖81且bucket正确。
除head/next两buffer外，其它14个逻辑输入buffer逐字节相同，实际scalar字段同。

各自原始grid及统一为original0 grid的控制，各做SDK runtime/原PTX/候选编译_kernel_driver三端回放。
36真实GPU调用、180份完整输出全部严格；独立CPU重核2466720 after字节、428112只读/guard字节、
5760真实ABI字节、576嵌套/普通指针字段和509652完整输出word。共同grid只用于诊断，没有写入生产。

旧原版force+diagonal完整结果同时由original0/source0/source1再现；旧源码两buffer完整结果同时由新的真实SDK original1再现。
不同head/next的original1相对original0有force4/diagonal21个word差；原版自己也存在这种顺序变化。
统一head/next后所有五输出跨全部六输入/三端都逐位同，证明本批差异来自实际链表输入顺序。
没有F32全局原子归约或邻居排序修改；旧两项严格失败不重判，也不替换任何固定C8/C10。
first-force driver session72933真实0，六采集worker、replay2802969和独立CPU2803082均实际0。

本阶段自有GPU任务均已结束；原始失败、版本、所有输入输出与命令共同归档。
下一步保存生产38/Core7eb及27输入检查点，将已验证构造恢复和颗粒/无约束SO3刚体准入整理进生产源，
再编译公共Core并运行当前版本回归。其它contacts/self/bonds/rigidity组合不借本批结果宣布通过，完整目标继续活动。


## 生产dec858e5及当前公开Core的实际接续

当前host SHA：`dec858e551f015374453713edc46910028cae95a210b33acd6c9e9006a1c0282`。
公开Core SHA：`47ae97200081256af5f5530d180bca1f664fd31214474db4efc0216a52aec2e7`，
位置`build/reconstruction-csrc/source-core/95f700673f9a3e0b/`，27输入与当前host匹配。
新production的四短程、六扩展布局、本次全部before/after buffer及状态/owned ABI/coverage严格，
60步eager/graph对固定SDK的16项也全部逐位同；不将旧候选两buffer的历史失败删除或改判。
公开Core正常Dzhanibekov60、plastic bag3、G1 graph60实际0，source_only/public_core_abi真，无原版映射；
G1独立固定C8和旧23.85尖峰不据此改判。完整74/fixedC10及当前constructor仍待终态。

源production与已测candidate2的求解数学已逐文本核同，26helper设备入口与176/f0清单保持；
只增加准确准入保护与元数据。首guard误将自由body的6 DOF/6 target计为约束的失败完整保留，
实际native fields证实约束/drive/bond全0后仅修此检查。

当前constructor以冻结SDK三个原始capture为左端，仅新增当前source的allocation/payload/CUPTI采集。
通用initializer decoder新增ivec3/vec4，CPU重算两批原始完整审计与历史报告完全相同；旧55/41失败保持，55/55通过保持。
这只是诊断能力恢复，不替代当前constructor的实际GPU结果。

具体活跃句柄91260（74队列）和92644（constructor follower）及实际状态，见生产phase目录。
下一组合72496按constructor实际PID/starttime等待，先做六组bonds/刚体原版支持与当前guard发现；
未修改生产bonds/contact范围，也未把静态保护当作已经证明的缺陷。Windows继续WSL2。
