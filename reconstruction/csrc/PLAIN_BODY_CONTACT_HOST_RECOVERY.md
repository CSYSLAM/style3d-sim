# 普通刚体约束与地面接触恢复：eb661284

活动host：`eb661284fd3852610e81857ccb7cc5731f76a843abd417e8772bdd6693a4efb7`。
SDK64a、CUDA176/f0及数学未改，`solver_api_ready=False`。完整替代仍未完成。

新独立场景`plain_body_contact_scene.py`包含两个运动的offset-COM箱体、一个普通约束、实际地面接触和非零滚动/扭转摩擦。
旧plain及driven-cloth场景未改，旧G1、粒子及布料失败全部保留。
覆盖spring/point-line/distance × W1/W3 × Newton/PD × body-block开关，共24组。

六个首原版pilot中，约束每组9/9轮改变RHS，rigid/rolling为3/9或9/9轮；状态有限。
完整24组均确认所有三种力实际改变RHS，不以空调用当覆盖。首pilot被逐字节采用，剩余每组只采一次。
每组记录三步状态及三种力全部九轮pre/post RHS，完整owned调用保留。

旧141源码两个基线因保护条件拒绝，保存原失败。首次检查脚本的has/have消息匹配断言在修改生产代码之前失败，
随后采用同一份已拒绝基线，不重新挑选；详情在`source141-guard-baseline/first-check-failure.json`。
修改前27份source/build/so及24份原版共1443文件SHA保存于
`build/reconstruction-checkpoints/plain-contact-before-141c18f6/`。

仅开放已捕获的纯affine、SO3、AL配置、正alpha、单一普通约束和penalty rigid/rolling contact范围。
要求全部particle state是body proxies；joint、drive、self、cable、fluid、granular、额外材料、full-surface和hard仍保持保护。
所有力、矩阵、PCG和状态更新原实现不改；先检查新scope能否严格重现固定原版，再决定是否需要恢复其它调度。

原始证据及新结果目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-141c18f6-plain-contact/`。

- `original-pilot6/`、`original24/`：首次固定SDK及九轮真实受力证据。
- `source24-eb661284/`：24/24严格通过，13488次完整owned参数/geometry及coverage同，全部状态和九轮力buffer逐字节同。
- `source-guard-preview.cpp`、`restore-captured-guard.py`：精确修改及构建命令/检查点来源。
- `run-local-validation.py`：24组metadata/coverage全部通过后，串行运行六种constructor、真实graph60、两端initcheck3。

图验证把collision pipeline及clear/solver完整放进每个真实graph，eager和graph都先warm碰撞workspace；
24组×eager/graph，比较同端eager/graph和原/源，共96项。不是把碰撞结果固定后只捕获solver。

六种constructor、graph60和两端initcheck3正在串行执行，结果以当前`validation-eb661284/status.json`为准。
本image完整74及正常_core构建尚未执行。141的70/74严格、两项C10失败和G1未过结果仍是历史证据，
不可直接算作eb661284的完整验收。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.plain_body_contact_graph_ab \
  --frames 60 --output build/NEW-plain-contact-graph60
```

GPU任务串行；新结果使用全新目录，保存每个失败、原始输入及source SHA，不改数学或阈值来通过。
