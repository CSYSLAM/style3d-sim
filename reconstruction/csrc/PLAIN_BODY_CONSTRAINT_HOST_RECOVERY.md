# 普通刚体约束：模板、PD 与 body-block

活动源码 image：`8691698973a5ef5109a5300a72d319c918d9a159c20a9b0b76a0ddb1563c2eea`。
唯一参考仍为项目内 SDK64a；CUDA176/f0、数学阈值与固定原版不变，`solver_api_ready=False`。
完整替代仍未完成；本 image 的完整74回归尚未收集，不继承前一版本的结论。

## 实际证据和修复

fixture `plain_body_constraint_scene.py` 包含两活动 offset-COM body，反向 attachment，
spring/point-line/distance × W1/W3 × Newton/PD × body-block，共24组。无碰撞和其它材料。
初版 `replicate()` 没复制自定义 plain 约束，W3实际自由运动；已保存覆盖失败并改用显式 world。
采集点线时曾把 bool 参数当成输出指针而崩溃，失败脚本与数据保留；按实际 SDK ABI 修正并加 pointer 预检。
这两次诊断失败均不算求解器验收。

固定有效原版为显式 world 的首次 spring8 和修正诊断后的 point-line/distance16；
每组9次实际约束 force 调用，首次 RHS 前后确实改变，状态 finite 且 body 运动。
原版首次数据不因源码失败重采。索引 `original24-valid/report.json` 包含168份文件的SHA。

前一5bd源码的 Newton/no-block：spring/point-line四组严格，distance两组从首步不同。
三种 constructor 均失败：weights上传提前；distance还缺两次 typed zero 初始化。
原版 L0/L0/L6 与源码各8/6/8个 F32 词差1ULP，diagonal相同。

额外 SDK initialize-only 探针反转 `affine_body_indices`，保持真实 force 输入不变。
三种约束均只有按全局粒子编号排序的因子次序能同时逐字节匹配 normal/reverse 的 diagonal 和矩阵。
探针无 simulation step，不扩统计 cohort，不替换旧失败。

保存5bd的27文件检查点后，恢复如下 host 行为：

- plain spring、全部 point-line、distance 的模板因子排序；已验证的 joint spring 排序保持。
- body-constraint weights 在 scalar ELL 初始化后上传，顺序 spring、line、drive、distance。
- distance target/multiplier 在 block 缓存之后、affine 缓存之前分配，并用 typed vec3 zero 初始化。
- 只开放单一 plain 类型且无其它 joint/material/contact 的 PD/body-block 组合。
  其它组合仍需实际 SDK 捕获后恢复。

## 当前验证与接续

- 同24份固定原版：全部状态逐位相同，首 force 的 pre/post RHS 字节相同。
- 8,952次完整 owned 参数、geometry、shared memory、source覆盖数全部相同。
- 六种 W3 constructor（3种约束 × 两种模式，block=true）、24组合 graph60 和双端 initcheck3正在串行运行。
  查看 `validation-86916989/status.json`，不得把尚未结束的项目写为通过。
- 局部完成后执行本阶段 `run-regression.py` 收集当前 image 的完整74、固定首次失败C10及CPU审计，
  再执行 `run-frontends.py` 验证未改官方示例的真实入口/graph/test。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-5bd9722e-plain-constraints/`。
`constructor-before-5bd9722e/`、`source6-newton-b0-5bd9722e/` 和所有失败保持原样。
`template-order-resolved.json` 记录实际 SDK 双输入探针的逐字节证明。
修改前检查点：`build/reconstruction-checkpoints/plain-body-before-5bd9722e/`。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.plain_body_constraint_graph_ab --output build/NEW-plain-graph60
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output build/NEW-plain-constructor --fixture reconstruction/csrc/plain_body_constraint_scene.py \
  --prefix plain-distance-pd-w3 --fixture-args --constraint distance --worlds 3 --seed 3 --mode pd --body-block
```

输出用新目录，保留旧 source0、参考和失败。Windows 用根交接的 WSL2 环境继续；固定Linux参考不换成Windows pyd。
