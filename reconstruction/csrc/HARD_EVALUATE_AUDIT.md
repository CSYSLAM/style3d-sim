# 硬接触主计算 CUDA 恢复

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
源码 `kernels/hard_evaluate.cu`，复用 `hard_contact_geometry.cuh` 的已验证312B View和几何。
入口 `evaluate_hard_contacts` 输出 force/scalar、非对角乘积、12x12仿射块和两份对角修正块。
最终原版/源码各seed1/2/3通过：12组、6240项检查，actual source entry确认。
每seed142次路径审计零差异，写入187576/231944/181532，非空调用的输出取反错误全部检出。
详见 `gpu-*-summary.json` / `dataflow-summary.json`。

原有 `hard_constraints` 596项覆盖 force/product/blocks/affine、48种状态开关、跨世界和偏移配置；
新增 `hard_evaluate_branches` 444项为未改动的原版PTX与源码直接全数组32位比较，包含：
所有输出同时开启、各输出独立开启、全关、两份block别名、重复仿射索引、同body两端、
exact_friction开关、零penalty/mu、count/capacity边界、重排body表、shared形状、
NaN/Inf normal/material/history、异常gap和force/scalar/product/blocks/affine完整尾部。

## 从原PTX恢复的细节

- 相对位移为 `((now1-old1)-now0)+old0`；摩擦锥投影与 exact sliding 切线按原先次序计算。
- normal force 保留 `fn*n - (vn*damping)*n` 的原mul/sub，不能无依据提早改变融合层次。
- body0先对force取负，再乘正lever；scalar平方项也用正lever，而非事后消除两个负号。
- 每个body先完整写force，再写scalar；完整输出顺序为force/scalar、product、affine blocks、
  最后system/precond修正。两份修正逐分量交替写入，仿射块按完整3x3行顺序写入。
- exact sliding 投影保留 `base - kt*(unit_i*unit_j)`，让旧式mul/sub交给JIT融合。
  单测最初通过，但扩大至lane32后数据流发现提早显式FMA；已按原PTX恢复自然表达式。
- 同一global粒子id整项排除；仿射块先累加所有与目标body粒子匹配的权重，body重复时只处理一次。

这些修改均来自原PTX或直接原版调用，没有放宽容差、修改Python规格或改写运行的原版PTX。
初次444项GPU已通过后仍继续恢复写入先后，相关失败/修正日志保留在证据目录。

## 复现

```bash
.venv/bin/python -m reconstruction.kernel_ab --only hard_evaluate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_evaluate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_constraints --seed 1
.venv/bin/python -m reconstruction.csrc.audit_hard_evaluate_ptx 1
```

seed再取2/3。原有模式每call核对9个lane，扩展场景核对11个lane，包含无效头部、capacity边界和尾部；
每call比较有序写入地址、表达式、32位值和所有浮点判断，非空调用须检出人为输出取反错误。
本批没有诊断性JIT表达式改写。GPU比较覆盖完整输出，审计只对所列lane的实际路径成立。
`HARD_EVALUATE_AUDIT_TAG`可隔离调试输出目录，`HARD_EVALUATE_AUDIT_STOP_FIRST=1`用于在首差异停下，
均不修改核函数或比较标准。

证据在 `build/reconstruction-csrc/hard-evaluate-audit/`：最终GPU JSON、原PTX、路径报告、
初次失败与order修正日志、census及provenance。旧kernel提取执行无需账号登录；
没有做完整solver或demo替代验收。其它14个入口与host/pybind阶段仍需继续恢复。

本批最终census：117定义（45 identical、72 different），14未写。后续rigid草稿另行验证。
