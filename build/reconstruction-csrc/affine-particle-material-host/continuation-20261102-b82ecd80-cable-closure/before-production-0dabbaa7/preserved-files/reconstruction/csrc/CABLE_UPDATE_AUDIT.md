# 缆绳罚参数更新入口恢复

旧库SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
`kernels/cables.cu`新增完整`update_cable_penalties`，共享逻辑在cable_geometry.cuh/cable_rotation.cuh。
这次比较是literal旧PTX和源码编译入口的完整执行，不是之前仅旋转出口的内部探针。
没有登录完整solver或进行demo验收，当前核验不需要账号。

## 结果与范围

原版/源码各seed1/2/3，49类场景、每seed1693项检查，共10158项GPU检查全部逐位通过。
其中每seed49项直接比较完整penalty数组（含未写尾部），其余检查全部提供的输入数组保持不变。
source entry记录确认调用源码update入口，reference直接读取旧PTX，未使用机械CUDA包装作为答案。

每seed49次路径审计，采样静态/动态、世界边界、禁用与越界等最多13个lane，
每seed核对1636次有序写入，共147调用4908写入。写入地址、表达式、32位值和float32/float64判断零差异。
每个非空调用均检出人工输出取反错误。没有对本入口进行JIT算术重写或放宽判断计数。
表达式仅沿用既有可交换操作数和精确谓词互补表示；测试和采样路径不是任意输入的数学证明。

场景覆盖：既有9种身份/仿射/退化/不同惯性/随机frame/多世界变体，另40种边界，
包括平行、精确反向、近反向、父basis退化、弯曲截断门限、法向分母门限、大幅/NaN rest、
NaN/Inf quaternion/位置/惯性/材料/旧penalty、零/负/NaN/±Inf beta、负active、空可选输入、
零规模/零tile但零规模、部分world及输出尾部。原版怎样处理异常值，源码就怎样保留。

## 恢复内容

- 静态端使用authored world frame，动态端使用仿射锚点和平移，加上惯性加权body rotation。
  Quaternion basis保留原乘零/加零以及父/子侧不同的FMA形式，没有替换成另一个库的简化公式。
- 线性残差投影到父basis，弯曲使用clamped双法向与长度上限20，反向退化时选取父法平面内的轴。
- 平行输运包含普通分母、近反向Rodrigues和精确反向反射分支，再计算twist的atan2。
- 减rest后twist只做一次±2pi折返；四个通道按原FMA顺序增加并以authored base封顶。
  beta为零也保留FMA，不增加额外有限性过滤。
- 同文件既有prepare_cable_penalties入口的归一化PTX保持不变；旧完整源码已按原hash保存在
  cables-before-update.cu，state-initialization审计provenance指向该快照，旧证据不被新入口覆盖。

## 双精度审计支持

PathAudit新增可选opcode extension，扩展关闭时默认float32运算不变；cable_ptx_ops处理double运算、
类型转换及bit-half提取。CPU double FMA调用libm的正确舍入实现，未用近似乘加替代。
三个GPU微用例的63个uint32输出字逐位相同，包含抵消、signed zero、极小/极大double；
另5个float32用例与扩展前审计器的写入和判断完全一致。
旧audit_drive_ptx.py已按hash归档，并在受影响的历史provenance中设置verified_dependency_snapshots，
保持之前affine/rolling/surface的准确工具版本可追溯。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only cable_update --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only cable_update --seed 1
CABLE_UPDATE_AUDIT_TAG=rerun-seed1 .venv/bin/python -m reconstruction.csrc.audit_cable_update_ptx 1
.venv/bin/python -m build.reconstruction-csrc.cable-update-audit.check-double-ops
```

seed再取2/3。整批GPU：

```bash
.venv/bin/python -m build.reconstruction-csrc.cable-update-audit.run-gpu
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m build.reconstruction-csrc.cable-update-audit.run-gpu
```

证据在build/reconstruction-csrc/cable-update-audit/，含最终GPU JSON、source entries、三seed审计、
审计器快照、自检、既有prepare入口不变证明、全量census及provenance-final.json。
阶段已验证129/131，剩余prepare_cable_tangents/evaluate_cables，完整host/pybind和demo阶段继续排在内核之后。
