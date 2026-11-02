# 滚动摩擦三个 CUDA 入口恢复

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
`kernels/rolling_contacts.cu` 恢复248B RollingContactView及force、preconditioner、tangent三个入口。
原版/源码各seed1/2/3，既有rolling_contact16和扩展rolling_contact_branches96均通过：共12组672项GPU检查。
source entry记录确认三个入口实际使用源码；GPU比较完整输出，不放宽容差。

每seed108次采样路径审计通过，写入数分别9540、11340、11745。
比较有序写入地址、计算表达式及32位值，也比较浮点判断；所有非空调用都检出人工输出取反错误。
既有用例采样9个lane，扩展用例采样11个lane；这些测试及采样审计不能证明任意输入均一致。
路径详细记录、失败草稿和最终原版/源码GPU结果保存在 `build/reconstruction-csrc/rolling-contact-audit/`。

## 恢复和修正

- 从局部惯性构造J，再算世界惯性、余子式逆矩阵和三个方向的Jacobian；分别散射滚动/扭转阻力、
  预条件块和切线乘积。保持四项展开区之后写余数的原子累加顺序。
- 按旧PTX在每个方向重算/检查惯性逆矩阵，保留自然mul/sub和原有限值判断。
  负侧逆矩阵应用原先错误地用了提前FMA，GPU用例虽通过，路径表达式仍不同，已恢复原mul/sub。
- 球心差的归一化都是y-first，但preconditioner检查球心方向候选法向量时为x-first；
  force/tangent候选与全部入口的输入法向量fallback为y-first。最终判断复用所选候选/fallback的平方和。
  原PTX证据在legacy-kernels.txt的BB67_64/66、BB65_64/66和BB66_64/66。
- 诊断器将单目负号穿过浮点乘法表示为相同表达式，并消除双重负号。有限路径上RN乘法符号位置
  保持精确位值（含signed zero）；仍独立比较数值、地址、写入顺序和判断，不重写FMA或减法。
  这是表达式表示归一化，不能声称原始PTX文本完全一致。
- 草稿曾出现原版3次相同det>1e-30检查、编译版1次的优化差异；审计器只允许该同一真谓词折叠，
  并记录原始计数。最终三seed的duplicate_guard_count_records均为0，未触发该折叠。

扩展用例覆盖多世界/shared形状、body映射及顺序、同body、奇异/非物理/非有限惯性、
可空滚动/扭转系数、零速度/epsilon、基向量轴切换、重复粒子索引与非有限位置。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only rolling_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only rolling_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only rolling_contact --seed 1
.venv/bin/python -m reconstruction.csrc.audit_rolling_contact_ptx 1
```

seed再取2/3。原版/源码整批GPU命令为：

```bash
.venv/bin/python -m build.reconstruction-csrc.rolling-contact-audit.run-gpu
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m build.reconstruction-csrc.rolling-contact-audit.run-gpu
```

此批已验证入口由123增到126。全量编译128定义（45 PTX-identical、83 different），
affine block2仍待路径核对，cable3未写。未登录完整solver或做demo验收，host/pybind也未完成。
