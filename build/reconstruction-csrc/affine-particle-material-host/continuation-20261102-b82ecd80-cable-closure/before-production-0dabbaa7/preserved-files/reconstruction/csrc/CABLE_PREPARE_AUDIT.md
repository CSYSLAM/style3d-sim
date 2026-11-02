# prepare_cable_tangents：源码及验证记录

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
对应旧 PTX 为 `_re_analysis/kernels/solver_newton/068_prepare_cable_tangents.ptx`，5542 行。

完整入口已恢复。kernel 阶段已验证 **130/131**；最后的 evaluate_cables 已有草稿，尚未验收。
这里没有调用账号登录后的完整原始 solver，也没有宣称 host、绑定或 demo 已替代。

## 源码

- `kernels/cable_spin.cuh`、`cable_spin_math.cuh`：惯性加权 double 极分解旋转导数及 float 回退。
- `kernels/cable_strain_jacobian.cuh`：有界弯曲导数，以及反向附近的分段扭转导数。
- `kernels/cable_tangent_geometry.cuh`：world frame、线性旋转导数和两端四个仿射槽的 Jacobian 装配。
- `kernels/cable_tangents.cu`：完整 prepare 入口，签名与原版一致。

原版 prepare 不读取 active mask；每个动态端固定追加四个槽，不合并重复 id。
父端位置 Jacobian 加上旋转项，子端仅有点坐标权重；平移槽的角度 Jacobian 全部为正零。
只写 count 个槽，其余槽及 guard tails 必须保持原值。
prepare 的两个 authored quaternion basis 都使用独立的 w*0/add；不能照搬 update 子端的 FMA 写法。

扭转导数按原 PTX 分三个区域：denominator<=1e-8、到 0.02 的中间区域、以及 >0.02。
中间区域显式求平行输运、归一化和 atan2 的导数。两个点积导数的乘积及求和分别舍入；
源码使用 `__fmul_rn` / `__fadd_rn` 保留该顺序，没有更改编译参数。

## 发现并修复的问题

1. float 旋转导数 map 的 0/8 分量：原版 JIT 融合为 FFMA，新代码的公共乘积复用使其变成 FADD。
   实际 sm_120 JIT cubin/SASS 已保存；按原融合点显式写 fmaf 后，旋转探针三 seed 171 项逐位通过。
2. 模板固定父端负号把 native 的 mul/add 变成 subtraction，完整位置 Jacobian 出现 ULP 差异。
   保留运行时 endpoint sign 后，完整 GPU 对比通过。
3. 最初轴对齐的近反向测试不足。补上随机整体旋转后，暴露中间扭转导数的求和结合次序和提前 FMA 错误。
   依旧 PTX 修复后，新增场景通过。早期失败 JSON、NPZ 和日志保留，不能将早期通过当作最终证据。

## GPU 结果

`cable_prepare` 最终 40 场景、每 seed 1266 检查；原版和源码各 seed1/2/3 全通过，共 **7596 检查**。
源进程日志明确记录实际执行重建的 prepare 入口，没有旧 kernel fallback。
比较整个 linear/angular/indices/count 数组、未写槽和尾部，以及所有非 NULL 只读输入。
包含三世界、任意朝向的近反向和 cap、异常惯性/仿射/四元数、重复 body/slot、空/部分 count、
active 为零或 NULL，以及未使用输入为 NULL。

内部出口探针与完整入口测试分开：spin 探针为 19 场景×3 输出×3 seed=171 比较；
strain/frame/linear-rotation 导数探针为 29 场景×2 输出×3 seed=174 比较。
探针会修改旧 PTX 的出口，只能证明被读取的子模块；完整入口比较使用未修改的旧 PTX。

## 数据流核对及准确边界

完整入口每 seed 40 调用、最多 13 个采样 lane，共 35065 次有序写入；三 seed 合计 **120 调用、105195 写入**。
写地址、表达式 DAG、有限值位模式零差异；38 个有写入调用/seed 均检测到翻转写入位的 mutant。

诊断表示处理全部局限在新审计器中：

- 原版两个 body 的 12 个 float spin 对角融合，按 JIT 证据建模；实际 GPU 参考完全不改写。
- 乘法/FMA 可交换因子、乘法负号位置、乘 ±1、显式 rn 与默认 rn 的表示统一。
- NumPy 对相同 DAG 的 NaN 符号传播与 GPU 不同，每 seed 108 次单独记录；仅 CPU 诊断对齐该符号。
  **实际 GPU 输出始终按原始 uint32 全位比较，包含 NaN 符号，没有容差。**
- 去掉重复次数后，源码所有浮点判断都存在于原版轨迹中。原版额外判断逐个记录其标签来源，
  全在 BB72_82..137 的 strain/transport/atan2 值计算区域；这些值计算大部分不参与 prepare 输出。
  源码重算 body rotation 导致重复判断数量不同；原始计数和出处仍保留，没有隐藏未解释的判断差异。

这些是具体 GPU、场景和采样路径证据，不构成全部输入或所有 GPU 的形式证明。
host 调度、分配、绑定及同 demo 的账号登录后 A/B 仍需下一阶段单独验收。

## 命令

```bash
.venv/bin/python build/reconstruction-csrc/cable-prepare-audit/run-gpu.py
CABLE_PREPARE_AUDIT_TAG=rerun-seed1 .venv/bin/python -m reconstruction.csrc.audit_cable_prepare_ptx 1
.venv/bin/python -m reconstruction.csrc.probe_cable_spin 1
.venv/bin/python -m reconstruction.csrc.probe_cable_strain_jacobian 1
.venv/bin/python -m reconstruction.csrc.dump_cable_prepare_jit
```

其它 seed 替换最后参数为 2/3；复跑审计使用新 tag，避免覆盖本次 final-seed*。
主要证据和最终 hashes 在 `build/reconstruction-csrc/cable-prepare-audit/provenance-final.json`。
