# 混合普通约束与实际接触恢复：38b70dcd

当前候选host：`38b70dcd9f3ca5053184eca9c6ec64cc33c137248a3e70efa729bd7ff0d92a49`。
固定SDK64a、CUDA176/f0、数学和容差未变，`solver_api_ready=False`，完整替代仍未完成。

新增独立夹具`plain_body_mixed_contact_scene.py`，保留旧单一约束与无接触mixed夹具原样。
四组合spring-line/spring-distance/line-distance/all × W1/W3 × Newton/PD × body-block开关，共32组。
两个运动offset-COM箱体、反向attachment、实际地面碰撞、非零rolling/torsion，全部state particle都是body proxies。

先采8个原版pilot，全部primitive及rigid/rolling实际改变RHS；再逐字节采用首pilot，剩余24组原版各采一次。
完整32组全部finite，所有启用的约束、rigid、rolling均确认有效，每个力记录九轮pre/post，完整owned调用日志保留。
旧eb源码spring-line/W1/Newton/no-block及all/W3/PD/body-block两条baseline确实因guard拒绝，原失败保留。

修改前保存27份当前source/build/so及原版32共2643文件SHA：
`build/reconstruction-checkpoints/mixed-plain-contact-before-eb661284/`。
只将已捕获纯SO3/AL/正alpha/penalty rigid接触条件中的“只允许一种普通约束”改为“至少一种”，
其它排除条件、力、矩阵、PCG、状态更新全部保持。full-surface/hard、joint/drive/cable/fluid/self/额外材料仍有保护。
依照旧build_command原选项编译host，不重编CUDA或改其数学。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-eb661284-mixed-plain-contact/`。

当前串行队列为`run-restoration-and-local.py`：
拒绝基线及检查点/编译 → `source32-38b70dcd`首次源码对照 → 八constructor → 完整碰撞eager/graph60 → 双端initcheck3。
首次源码32已全部结束并严格通过：18624次完整owned ABI/geometry/coverage、三步四状态字段及2448份力buffer全同。
`source32-independent-audit.json`另按实际dtype/shape/raw bytes/finite重核128字段、2448份buffer，全部同。
局部11任务已全部结束：八constructor五项全同，真实collision-inclusive graph60为128/128严格，
双端各64条eager/graph轨迹×3步initcheck均零错误。
`local-independent-audit.json`另核512个状态数组的dtype/shape/raw bytes/finite及两端sanitizer日志，全部同。
八份constructor已捕获的D2D/byte-fill序列也全同：Newton每份48copy/75fill，PD30copy/75fill；未据此推断外部pointee。

本轮匹配公共Core已构建：`source-core/a318a3ce42f6a731`，
SHA `7eb6e847ad6f100b51f2bc89db0a88744f93878077c318c91288d2f595116b53`，host38/CUDA176/f0。
正常包入口Dzhanibekov60、plastic bag3、G1真实graph60及各自--test均退出0，source_only/public_core_abi true，
无bridge、无原版求解器映射。`public-core-validation.json`保存已结束任务的不可变收据。
本轮`run-broad-validation.py`已全部结束：38自己的完整74为71项逐位同，三个particles首差保留。
逐字节保留首次源码、各10次真实原版的C10为seed1/seed3通过、seed2失败；独立CPU重算全同。
回归/C10各退出1，CPU审计退出0；失败不改判，不继承eb/141/230结果。
当前公共Core的G1完整60帧固定原版对比仍未通过，见[当前G1](CURRENT_G1_CORE_7EB6.md)。

WSL恢复与环境固定沿用根交接；新Bash先`source scripts/reconstruction_env.sh`，使用`.venv/bin/python`。
后续图核对工具为`reconstruction.csrc.plain_body_mixed_contact_graph_ab`，完整collision pipeline纳入graph，
不是固定contacts后只捕获solver。所有新增执行使用新目录，GPU任务串行。

38完整回归/C10均已结束，新机器不应重复执行输出目录已存在的阶段driver。
如需自行收集38整套回归，使用全新目录并按顺序运行下列命令；strict/C10退出1表示保存了数值差异，
先确认74项全部结束，再执行C10及CPU审计，不修改失败或扩大原版样本到通过。

```bash
source scripts/reconstruction_env.sh
validation_root=build/NEW-38-validation
.venv/bin/python -m reconstruction.csrc.joint_continuation_regression --output "$validation_root/regression74"
.venv/bin/python -m reconstruction.csrc.regression_fixed_spread \
  --validation "$validation_root" --output "$validation_root/regression-fixed-C10"
.venv/bin/python -m reconstruction.csrc.audit_regression_fixed_spread \
  --cohort "$validation_root/regression-fixed-C10" --report report.json \
  --output "$validation_root/regression-fixed-C10/cpu-audit.json"
```
