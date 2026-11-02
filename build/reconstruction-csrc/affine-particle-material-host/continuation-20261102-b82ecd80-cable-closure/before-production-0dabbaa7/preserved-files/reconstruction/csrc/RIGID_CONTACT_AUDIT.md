# 刚体接触 force/tangent CUDA 恢复

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
源码为 `kernels/rigid_contacts.cu` 与 `rigid_contact_geometry.cuh`，两个入口均按旧mangled签名编译。
原版/源码各seed1/2/3：既有rigid_contact21项、新rigid_contact_branches227项全部通过，
12组、1488项GPU检查；source entry列表确认两个入口均使用CUDA源码。
每seed101次路径审计，地址、有序写入表达式、32位值和浮点判断零差异；非空调用均检出人为取反错误。

新用例覆盖多世界/shared形状、body表重排、capacity边界、无效shape/body、全部/独立/空输出、
两份block别名、重复索引、同一body、交换两侧、previous/velocity、原生/平滑摩擦、
NaN/Inf/负epsilon和材料、异常normal/point/position、输出完整尾部。
旧测试仍包含sphere/box/static及显式offset开关；tangent的host合约要求previous非空。

保留的PTX细节：force与tangent的sphere候选长度选择分别使用y-first与x-first；
两者的球心方向归一化都使用x-first。tangent最终法线门限是未融合的平方和，
使用两个 `__fadd_rn` 防止编译器将它重新合并成FMA。
审计只将该入口恰好两条add.rn.f32映射为默认同样round-to-nearest的add.f32，
未改变操作数、求值顺序或运行的GPU PTX。其它数学没有做诊断性JIT改写。
平滑摩擦速度分支按旧setp.gtu恢复为 `!(speed <= epsilon)`，未简单改为有序大于。

形状filter/world/body、球面逆仿射与极分解fallback、原生与平滑材料合成、
法向/摩擦不同lever、两份修正逐分量交替写入、同global粒子整项排除，均按旧版处理。
没有改Python规格、比较容差、账号认证或examples。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only rigid_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only rigid_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only rigid_contact --seed 1
.venv/bin/python -m reconstruction.csrc.audit_rigid_contact_ptx 1
```

seed再取2/3。审计既有模式采样9个lane，扩展场景11个lane；实际GPU检查完整数组。
`RIGID_CONTACT_AUDIT_TAG`隔离调试报告目录，`RIGID_CONTACT_AUDIT_STOP_FIRST=1`在首差异停止便于定位。
证据 `build/reconstruction-csrc/rigid-contact-audit/`，以final-*.json、dataflow-summary.json、
gpu-*-summary.json及provenance-final.json为准。未做登录完整solver/demo验收。
本批验证状态到119入口；随后surface4入口草稿需另做扩展验收，不能算入本批已完成。
