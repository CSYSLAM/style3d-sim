# ANYmal：真实Graph/eager、FK代理同步与首预测器（2026-11-02）

最终目标仍是源码Core715/host0dab独立替代固定SDK64a；本阶段没有改so、生产数学、阈值或原例子。
用户允许共享GPU后持续按free>=4096MiB准入，所有自己的worker串行，外部任务不停止。

## 已实测

- 原例子默认8世界，追加原/源各500帧eager，2000子步全状态，工具67210实际0。
  另追加一次原版真实Graph500，同工具实际0；原版和源码仍飞高约870m、最大速度约38.45。
  原/源eager第一子步公开速度约135.951，零基子步14已有刚体超过10m；不是Graph独有。
- 两个原版Graph的最终particle_q最大分量差1.26847，原/源首Graph差1.04221；不是C8、不能据此宣布接受。
  两端eager完整2000子步仍不逐位，body_q最大分量差0.851257；保留所有首样本。
- 实查适配器sync_affine_body_state文档明确要求eval_fk后调用；原例子eval_fk移动body_q后没有同步代理。
  在副本中只加这次已有API调用，并将原lambda的<0.25合到同一行防止Warp漏读，其他原始字节保持。
  original example的SHA与旧cohort不改，synced-variant.json固定两版本及变化，副本尚未合入。
- 副本两端真实公开Graph500，根工具4777实际0、两个子worker都实际1：原高度断言真实失败。
  但原版/源码速度最大0.0573148/0.0767422，均低于原0.25，最低body z为-0.0337908/-0.0337073。
  两端均32脚部高度低于原-0.006；未改阈值，不把副本算完整物理验收，也不以原版同样失败掩盖源码失败。
- 四个首预测器观测工具84159实际0：原/源、原例子/同步副本，各真实一帧，只有观察及eager capture替换。
  在真正native step之前，Python _predict_affine_body_velocities的实际全部输入和输出两端逐位同。
  原例子中心z预测速度范围135.999939到136.000015；副本全为0。
  原版so实际吃到伪速度，不能把这个发射现象算作恢复源码内核独有错误。
- 两次独立CPU审计9a7f9b/b84ab4均实际0，重读真实状态、镜像SHA、预测器原始参数、实际输出及失败结果。
  没有将代码阅读或修改副本当作实际GPU通过，没有调用原版替源码代算。

## 原始文件与命令

run.py/status.json/independent-cpu.json保存三次500帧及统计；run-synced.py和synced-tests保存副本两次失败。
run-first-predictors.py及first-predictors保存四个真实预测器输入/输出，synced-independent-cpu.json独立复核。
原始命令均另存.command.json；脚本输出存在即拒绝覆盖，重跑应另建阶段，不能删除或替换冻结样本。

```bash
cd /home/oem/code/agent/style3d-sim
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host
phase="$phase/continuation-20261102-0dabbaa7-anymal-graph-eager"
# 历史实际命令；现有结果不能覆盖。
.venv/bin/python -B "$phase/run.py"
.venv/bin/python -B "$phase/audit.py"
.venv/bin/python -B "$phase/run-synced.py"
.venv/bin/python -B "$phase/run-first-predictors.py"
.venv/bin/python -B "$phase/audit-synced.py"
```

Windows使用WSL2，固定SDK/360pyc在同一个仓库；先核根snapshot，再恢复其无损压缩证据和固定ANYmal资产。
历史证据含原机器绝对路径，原样审计使用/home/oem/code/agent/style3d-sim，或只在新审计副本映射路径。
上一阶段27e1156d3已推并核远端精确同HEAD；其manifest里的四份根文档是该提交时版本，
副本及SHA映射保存在prior-27e1156d3-documents和historical-document-map.json。
后续根状态/日志更新不能拿来冒充该历史文档版本，不改写旧manifest迁就新内容。

## 继续工作

先核同步副本的32个脚部接触：原版真实contact、shape几何/代理、地面高度与首接触输入，区分原版基线行为与恢复误差。
保持原高度/速度界限，两端一致地跑同一夹具；不调迭代预算、容差、物理参数或恢复数学来制造通过。
四个正式demo的完整轨迹仍不同，74项69严格、旧固定C8/C10及两个隔离候选长程失败保持。
本阶段只解决发射的初始化来源和假测试，仍未完成整个源码替换目标，默认未切换、solver_api_ready=False。
