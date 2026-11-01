# 源码替换原版SDK：当前状态

最终目标是用仓库中的恢复源码编译独立`_core`，经正常Python API运行相关demo，
不加载原版SDK、不调用原版代算，并通过与固定原版的功能及数值一致性验收。
当前尚未完成完整替换；默认后端未切换，`solver_api_ready=False`。

## 已经做到

- 已重建176个CUDA入口：自有129、辅助47（Thrust22、CUB25），已纳入固定源码/版本清单。
  这不代表原版全部host组合和完整长程仿真已经一致。
- 已能从源码编译独立host扩展及真正的公开`_core`扩展。
  现有公开入口验证能独立运行Dzhanibekov、塑料袋及G1示例，没有映射原版SDK。
  G1原示例退出0不代表其独立长程一致性通过，原速度测试存在已记录的多行lambda读取问题。
- 前一生产host38/Core7eb的74项回归中71项逐位一致。
  三项粒子严格失败的固定十原版对照中seed1/3通过、seed2未通过；71/74不是总体完成率。
- 最近颗粒＋SO3刚体的隔离候选完成四短程、构造五项、60步eager/graph16项、双端initcheck及六扩展布局验证。
  六布局状态全部逐位一致；两块中间buffer差异由真实SDK复现并定位为链表输入顺序，旧严格失败保留。
  已合入新host dec858e5，其四短程、六布局及16项60步graph本次全严格；完整74和当前constructor仍待完成。

## 仍需完成

1. 完成当前host dec858e5的完整74回归、固定失败对照及构造审计；新公开Core47的三个正常入口已过。
2. 继续解决G1及复杂布料的长程固定对照失败；G1旧速度误差约23.85的尖峰尚未完整解释。
   已有大量同输入核对及归约顺序证据，不能据此把完整轨迹失败改判为通过。
3. 解决粒子seed2的固定对照失败，补齐SDK实际支持、源码仍拒绝或尚未验证的host组合。
   未捕获的组合总量尚未封闭，不能只按74项回归的失败数计算剩余工作。
4. 全部所需范围验收后，切换默认加载至源码构建后端，完成可安装交付及新机器复现。
   Windows当前使用WSL2；原生Windows移植尚未完成。

## 本轮记录及继续位置

生产合入证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-granular-affine-production/`。
已保存改前31个构建输入/产物及SHA，原版SDK64a与360份冻结pyc保持。
首生产候选c915的新增范围检查误将自由刚体的6个DOF/6个target通道当作约束，首次worker被拒绝。
`rejected-actual-model-fields.json`实测确认全部约束/drive/bond计数为0；保留失败镜像、日志和命令。
只修此范围检查，未改求解数学；第二host已编译成功，SHA前缀`dec858e5`。
独立CPU确认与已测候选的数学文本相同，176入口清单不变、helper26匹配；这不能代替当前镜像GPU验收。
新公开Core SHA前缀`47ae9720`，路径`build/reconstruction-csrc/source-core/95f700673f9a3e0b/`，与host dec匹配。
Dzhanibekov60、plastic bag3、G1 graph60正常入口全0，未映射原版；不能代替G1独立长程对照。
验证session91260在等待外部GPU2832657执行74；constructor follower92644在其后，旧Core7eb仅对应旧host38。
下一组合发现72496排在其后：六组带authored/dynamic/mixed bonds的颗粒＋刚体，尚无实际支持结论。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.build_host
# 当前验证驱动已启动时不要重复运行，先读取其status.json及实际进程。
phase_dir=build/reconstruction-csrc/affine-particle-material-host
.venv/bin/python "$phase_dir/continuation-20261101-granular-affine-production/run-validation.py"
```

详细历史见[主交接文档](RECONSTRUCTION_HANDOFF.md)、
[颗粒刚体恢复记录](reconstruction/csrc/GRANULAR_AFFINE_HOST_RECOVERY.md)及[工作日志](reconstruction/WORK_LOG.md)。
