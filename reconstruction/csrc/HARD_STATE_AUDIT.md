# 硬接触初始化与 dual 更新

参考旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
实现位于 `kernels/hard_contacts.cu` 与 `hard_contact_geometry.cuh`，包含完整312B `HardContactView`、`hard_geometry`、
`initialize_hard_contacts` 和 `update_hard_contact_duals`。
此前 `snapshot_hard_contacts` 的规范化 PTX 与本批前备份完全相同。
本批完成时主力入口 `evaluate_hard_contacts` 尚未实现；后续新增草稿须另做完整验证，不能复用本报告结论。

## 语义与修复

形状按 replicated 前缀和 shared-static 后缀映射，动态刚体使用精确 world 偏移；跨世界接触拒绝。
body id 先直接索引后线性首匹配。初始化几何无效时清零 penalty/dual/anchor；更新无效时保留原值。

旧 PTX 在 sphere 方向选择中首先用零候选或球心方向，候选未满足有序 `>=0.5` 时退回 supplied normal，
仍不满足即拒绝。之后重新归一化原始 normal，第二次检查是 x-first dot 的有序 `<0.5`。
第一版只照有限输入的 Python 捷径省略了前层验证；数据流核对发现后已从 PTX 补齐，未改 Python 公式。
depth 使用原始 pipeline point 与原始法线；sphere centre 方向只用于调整摩擦点。
offset 指针非空时，其 point+offset 覆盖 sphere 调整结果。
静态 sphere 偏移按原版乘加/乘减编译，不强制提早 FMA。

初始化：reset为假且previous_count非零时沿用当前penalty/dual；否则只有history且有效match时读历史。
历史 dual 分解后转到新 normal，保留原投影与乘减顺序。penalty缩放后按上下界钳制，
dual缩放为alpha*gamma，`!history && reset`时清零；anchor以调整点的当前世界坐标计算。
更新：按原版 `((now1-old1)-now0)+old0` 计算位移，投影切线到Coulomb圆盘，先写dual，
depth>0才递增penalty并钳到两shape平均ke。anchor只读。

## 测试与审计

`hard_constraints` 原有596项，包括48种开关/几何/世界配置；新 `hard_state_branches` 144项，
直接比较原版和选定后端完整输出的32位值，包括 count/capacity、无效shape、空/重排body表、
多世界/shared后缀、非canonical bool字节、负history count、空/越界match、复用/重置、
NaN/Inf normal/material/history/penalty/dual/anchor、负gamma与空offset。
`hard_history` 70项与 `state_initialization_branches` 204项用于快照和状态布局回归。
原版/源码各seed1/2/3四分组均通过：24组、6084项检查。每seed144次路径审计零差异，
写入9235/9300/9322；每个非空调用都检出输出取反错误。
source entry列表确认initialize/update使用源码，evaluate在本批验证中仍回退原版。
详见 `gpu-{original,source}-summary.json` 和 `dataflow-summary.json`。

原有 hard_contact_ab 的几何探针向旧 PTX 固定标签插入固定寄存器名；新增 update CUDA 后，
原测试试图向新 PTX 注入旧标签而报错。已仅修改探针的 PTX 来源，固定为原版模块；
真正 initialize/update/evaluate 的 launch 仍使用选定后端，比较逻辑完全未改。
该调整没有将 update 的实际测试退回原版。

审计每次采样17个lane，覆盖invalid头部、partial capacity边界、世界相关位置与尾部，
核对写入地址、输出表达式、32位值及浮点判断；非空调用必须检出输出取反的人为错误。
没有使用软接触报告的三处JIT投影改写；本批两入口直接比较原PTX的数据流。
向量参数展开补齐了u8步长1字节；此前f32/u32步长4保持不变，已运行u8读取自检。
GPU比较始终覆盖完整输出，而非只比较采样lane。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only hard_state_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_state_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_constraints --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_history --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only state_initialization_branches --seed 1
.venv/bin/python -m reconstruction.csrc.audit_hard_state_ptx 1
```

seed再取2/3。证据目录 `build/reconstruction-csrc/hard-state-audit/`：final-*.json、gpu-*-summary.json、
dataflow-seed*.json、census.txt、原PTX、hard-before.cu/.ptx、初次失败与修正日志。
本阶段没有进行账号登录或完整solver/demo验收；PTX文本差异与未写入口仍以census为准。

为后续evaluate共享几何，已将View/geometry移入hard_contact_geometry.cuh；三个既有state入口规范化PTX全不变。
共享前备份hard-state-verified.cu/.ptx已保留。本批完成时116定义，45identical+71different，15未写。
