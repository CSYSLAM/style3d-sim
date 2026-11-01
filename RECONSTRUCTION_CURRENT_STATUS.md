# 源码替换原版SDK：当前状态

最终目标是用仓库中的恢复源码编译独立`_core`，经正常Python API运行相关demo，
不加载原版SDK、不调用原版代算，并通过与固定原版的功能及数值一致性验收。
当前尚未完成完整替换；默认后端未切换，`solver_api_ready=False`。

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

## 已经做到

- 已重建176个CUDA入口：自有129、辅助47（Thrust22、CUB25），已纳入固定源码/版本清单。
  这不代表原版全部host组合和完整长程仿真已经一致。
- 已能从源码编译独立host扩展及真正的公开`_core`扩展。
  现有公开入口验证能独立运行Dzhanibekov、塑料袋及G1示例，没有映射原版SDK。
  G1原示例退出0不代表其独立长程一致性通过，原速度测试存在已记录的多行lambda读取问题。
- 当前0dab的74项回归为69项严格一致；这不是总体完成率，也没有涵盖全部长程及材料/约束组合。
  严格相等和固定原版重复运行的波动检查分开记录，不能将后者写成逐位一致。
- 最近颗粒＋SO3刚体的隔离候选完成四短程、构造五项、60步eager/graph16项、双端initcheck及六扩展布局验证。
  六布局状态全部逐位一致；两块中间buffer差异由真实SDK复现并定位为链表输入顺序，旧严格失败保留。
  已合入新host dec858e5，其四短程、六布局及16项60步graph本次全严格；当前74已完成71严格，三个粒子固定C10全过，constructor五项全同。

## 仍需完成

1. 当前0dab的Newton mixed仍须完整轨迹验收；首差已有实际GPU累加顺序证据，不能据此将固定失败改判。
   五项C10及其独立CPU复核已完成，三类constructor五项全同。
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
两个driver分别是session68428与29879，均已真实结束0；没有活动验证队列，勿重跑已封闭输出目录。
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
