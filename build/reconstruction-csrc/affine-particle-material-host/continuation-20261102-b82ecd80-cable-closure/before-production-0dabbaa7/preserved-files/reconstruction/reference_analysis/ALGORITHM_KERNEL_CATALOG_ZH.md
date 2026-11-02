# 全部 131 个自研 CUDA kernel：算法职责、完整签名与证据入口

配套主文：[算法流程、公式与原理](ALGORITHM_ANALYSIS_ZH.md)。生成日期：2026-10-27。

范围由 `kernels.json` 与 `recover/src` 逐项交叉核对，不包含 75 个第三方/支持 entry。模板特化分别计数。

**本表的“职责”不是全部分支已还原的声明。** 每个入口都保留原始 PTX 和机械 C++ 链接；寄存器数据流可辅助阅读，具体指令语义以原始 PTX 为准。签名中的类型、const、模板参数均取现有元数据，没有擅自为未知实参命名。

## 模块与章节索引

| 模块 | 自研数 | 主文关联 |
|---|---:|---|
| [solver_newton](#solver_newton) | 83 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s3) |
| [pcg_solver](#pcg_solver) | 12 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s6) |
| [fluid](#fluid) | 8 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s15) |
| [granular](#granular) | 8 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s16) |
| [self_collision](#self_collision) | 15 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s14) |
| [lbvh_builder](#lbvh_builder) | 5 | [原理章节](ALGORITHM_ANALYSIS_ZH.md#s14) |

计数复核：83 + 12 + 8 + 8 + 15 + 5 = 131。

## 元数据阅读方法

- PTX 行数、SASS 指令数和寄存器数量是既有提取元数据，适合描述规模，不能直接替代耗时。
- `atomic` 统计同时可能包含 add/min/exchange 等不同指令；不能全部解释成力的 atomicAdd。
- 同名模板的 float/mat3 可能描述预条件或对角类型，而不只是输入向量的标量精度。
- `ByVal` 机械声明只保留尺寸，不表示已经恢复其字段契约。
- 所有接口的 guard、分支、输出覆盖范围和容量限制，最终以对应 PTX 为准。

<a id="solver_newton"></a>
## solver_newton

### 001. add_affine_body_constitutive_preconditioner

仿射体其他本构模型的预条件。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/001_add_affine_body_constitutive_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_affine_body_constitutive_preconditioner.cu)。
- 规模：PTX 937 行；SASS 916 条；寄存器 91；元数据 atomic 计数 9。
- 细节与边界：CO_ROTATED/正交性等分支需逐一恢复；不能套用 SO3 AL 公式。

完整符号签名：

```cpp
synreal::kernel::add_affine_body_constitutive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 002. add_affine_body_so3_augmented_lagrangian_preconditioner

SO(3) AL 的预条件贡献。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/002_add_affine_body_so3_augmented_lagrangian_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_affine_body_so3_augmented_lagrangian_preconditioner.cu)。
- 规模：PTX 392 行；SASS 404 条；寄存器 32；元数据 atomic 计数 27。
- 细节与边界：需与共旋对称投影切线一致。

完整符号签名：

```cpp
synreal::kernel::add_affine_body_so3_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 003. add_affine_body_spring_gauss_newton_hessian

仿射体内部弹簧型刚性项的GN 装配。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/003_add_affine_body_spring_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_affine_body_spring_gauss_newton_hessian.cu)。
- 规模：PTX 1008 行；SASS 1256 条；寄存器 32；元数据 atomic 计数 135。
- 细节与边界：与 body-to-body 的点连接弹簧区分；精确六弹簧系数需查对应分支。

完整符号签名：

```cpp
synreal::kernel::add_affine_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 004. add_bending_damping_preconditioner

四点弯曲阻尼的预条件块积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s9)。
- 实现入口：[原始 PTX](kernels/solver_newton/004_add_bending_damping_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_bending_damping_preconditioner.cu)。
- 规模：PTX 309 行；SASS 588 条；寄存器 35；元数据 atomic 计数 36。
- 细节与边界：冻结方向下包含 w_i w_j n nᵀ；不等于各向同性阻尼。

完整符号签名：

```cpp
synreal::kernel::add_bending_damping_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 005. add_body_point_line_gauss_newton_hessian

按对应约束装配局部矩阵项；完整块、相对基准的增量以及缩放方式需要按该入口的分支分别确认。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/005_add_body_point_line_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_body_point_line_gauss_newton_hessian.cu)。
- 规模：PTX 962 行；SASS 1280 条；寄存器 61；元数据 atomic 计数 45。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::add_body_point_line_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, unsigned long, bool, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 006. add_body_spring_gauss_newton_hessian

按对应约束装配局部矩阵项；完整块、相对基准的增量以及缩放方式需要按该入口的分支分别确认。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/006_add_body_spring_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_body_spring_gauss_newton_hessian.cu)。
- 规模：PTX 1637 行；SASS 1976 条；寄存器 62；元数据 atomic 计数 261。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::add_body_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 007. add_cloth_membrane_gauss_newton_hessian

三角形经纬伸长与剪切的稳定化矩阵增量装配。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s8)。
- 实现入口：[原始 PTX](kernels/solver_newton/007_add_cloth_membrane_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_cloth_membrane_gauss_newton_hessian.cu)。
- 规模：PTX 988 行；SASS 1180 条；寄存器 77；元数据 atomic 计数 54。
- 细节与边界：累加 ΔH=Ĥ−B。长度项保留截断后的非负横向刚度，剪切项使用梯度外积；B 的 u/v 系数分别含 ku+ks、kv+ks。详见主文 8.5。

完整符号签名：

```cpp
synreal::kernel::add_cloth_membrane_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```


### 008. add_joint_body_point_line_augmented_lagrangian_preconditioner

预条件块积累，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/008_add_joint_body_point_line_augmented_lagrangian_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_joint_body_point_line_augmented_lagrangian_preconditioner.cu)。
- 规模：PTX 465 行；SASS 452 条；寄存器 40；元数据 atomic 计数 72。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 009. add_joint_body_point_line_gauss_newton_hessian

按对应约束装配局部矩阵项；完整块、相对基准的增量以及缩放方式需要按该入口的分支分别确认。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/009_add_joint_body_point_line_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_joint_body_point_line_gauss_newton_hessian.cu)。
- 规模：PTX 1572 行；SASS 1804 条；寄存器 60；元数据 atomic 计数 261。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::add_joint_body_point_line_gauss_newton_hessian(glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 010. add_joint_drive_preconditioner

预条件块积累，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/010_add_joint_drive_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_joint_drive_preconditioner.cu)。
- 规模：PTX 1188 行；SASS 1344 条；寄存器 67；元数据 atomic 计数 144。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::add_joint_drive_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 011. add_rolling_contact_preconditioner

接触模块的预条件块积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/011_add_rolling_contact_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_rolling_contact_preconditioner.cu)。
- 规模：PTX 3945 行；SASS 3272 条；寄存器 134；元数据 atomic 计数 9。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::add_rolling_contact_preconditioner(synreal::kernel::RollingContactView, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 012. add_spring_gauss_newton_hessian

距离弹簧的稳定化矩阵增量装配。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s7)。
- 实现入口：[原始 PTX](kernels/solver_newton/012_add_spring_gauss_newton_hessian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_spring_gauss_newton_hessian.cu)。
- 规模：PTX 375 行；SASS 580 条；寄存器 28；元数据 atomic 计数 54。
- 细节与边界：k>0、L>0 时累加 ΔK=k(Q−I)，两端对角块取 +ΔK、非对角块取 −ΔK；Q 的精确分段定义见主文 7.2。

完整符号签名：

```cpp
synreal::kernel::add_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
```


### 013. add_surface_contact_preconditioner

接触模块的预条件块积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/013_add_surface_contact_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_surface_contact_preconditioner.cu)。
- 规模：PTX 3850 行；SASS 3156 条；寄存器 116；元数据 atomic 计数 126。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::add_surface_contact_preconditioner(synreal::kernel::SurfaceContactView, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 014. add_surface_contact_stiffness_scale

接触模块的刚度缩放。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/014_add_surface_contact_stiffness_scale.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_surface_contact_stiffness_scale.cu)。
- 规模：PTX 3277 行；SASS 2836 条；寄存器 116；元数据 atomic 计数 7。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::add_surface_contact_stiffness_scale(synreal::kernel::SurfaceContactView, float*);
```

### 015. add_tetrahedron_preconditioner

四面体的预条件块积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s10)。
- 实现入口：[原始 PTX](kernels/solver_newton/015_add_tetrahedron_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_tetrahedron_preconditioner.cu)。
- 规模：PTX 767 行；SASS 676 条；寄存器 64；元数据 atomic 计数 36。
- 细节与边界：需与 μF+K(J−J*+a)cof(F) 及应变阻尼配套；稳定化分支待核对。

完整符号签名：

```cpp
synreal::kernel::add_tetrahedron_preconditioner(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 016. add_triangle_drag_preconditioner

向三角形三个顶点加阻力预条件对角块。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s18)。
- 实现入口：[原始 PTX](kernels/solver_newton/016_add_triangle_drag_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__add_triangle_drag_preconditioner.cu)。
- 规模：PTX 149 行；SASS 248 条；寄存器 21；元数据 atomic 计数 27。
- 细节与边界：每个顶点加 w n nᵀ。

完整符号签名：

```cpp
synreal::kernel::add_triangle_drag_preconditioner(glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 017. apply_affine_body_preconditioner

应用 affine-body 级预条件块。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/017_apply_affine_body_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__apply_affine_body_preconditioner.cu)。
- 规模：PTX 409 行；SASS 500 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：与独立粒子 3×3 block Jacobi 区分；完整 body 块布局待追。

完整符号签名：

```cpp
synreal::kernel::apply_affine_body_preconditioner(glm::vec<4, int, (glm::qualifier)0> const*, float const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 018. apply_affine_body_torques

将外加扭矩映射到仿射坐标。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/018_apply_affine_body_torques.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__apply_affine_body_torques.cu)。
- 规模：PTX 339 行；SASS 428 条；寄存器 40；元数据 atomic 计数 12。
- 细节与边界：映射依赖当前 body 方向/坐标，不能简单加到平移力。

完整符号签名：

```cpp
synreal::kernel::apply_affine_body_torques(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 019. apply_block_diagonal_preconditioner

块逆预条件矩阵乘残差。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/019_apply_block_diagonal_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__apply_block_diagonal_preconditioner.cu)。
- 规模：PTX 64 行；SASS 48 条；寄存器 19；元数据 atomic 计数 0。
- 细节与边界：z_i=P_i r_i。

完整符号签名：

```cpp
synreal::kernel::apply_block_diagonal_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 020. apply_nonlinear_step

并入 Newton 增量并清零增量缓冲。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s3)。
- 实现入口：[原始 PTX](kernels/solver_newton/020_apply_nonlinear_step.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__apply_nonlinear_step.cu)。
- 规模：PTX 55 行；SASS 36 条；寄存器 13；元数据 atomic 计数 0。
- 细节与边界：out=in+delta；delta=0；此 kernel 本身无能量回溯。

完整符号签名：

```cpp
synreal::kernel::apply_nonlinear_step(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 021. combine_system_non_diagonal

合并已对齐稀疏结构中的多组数值项。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/021_combine_system_non_diagonal.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__combine_system_non_diagonal.cu)。
- 规模：PTX 87 行；SASS 36 条；寄存器 18；元数据 atomic 计数 0。
- 细节与边界：e0+s0(e1+s1 e2+…+s5 e6)；列号复制自 e0。

完整符号签名：

```cpp
synreal::kernel::combine_system_non_diagonal(float, float, float, float, float, float, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry const*, synreal::NonZeroEntry*, unsigned long);
```

### 022. evaluate_affine_body_constitutive_force

仿射体其他本构模型的力。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/022_evaluate_affine_body_constitutive_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_affine_body_constitutive_force.cu)。
- 规模：PTX 607 行；SASS 772 条；寄存器 46；元数据 atomic 计数 12。
- 细节与边界：CO_ROTATED/正交性等分支需逐一恢复；不能套用 SO3 AL 公式。

完整符号签名：

```cpp
synreal::kernel::evaluate_affine_body_constitutive_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 023. evaluate_affine_body_so3_augmented_lagrangian_force

SO(3) AL 固定局部状态下的仿射刚性力。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/023_evaluate_affine_body_so3_augmented_lagrangian_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_affine_body_so3_augmented_lagrangian_force.cu)。
- 规模：PTX 241 行；SASS 332 条；寄存器 32；元数据 atomic 计数 12。
- 细节与边界：−κ R sym(Rᵀ(A−R+U))；平移分量不受此刚性项作用。

完整符号签名：

```cpp
synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 024. evaluate_affine_body_spring_force

仿射体内部弹簧型刚性项的力。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/024_evaluate_affine_body_spring_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_affine_body_spring_force.cu)。
- 规模：PTX 300 行；SASS 648 条；寄存器 42；元数据 atomic 计数 12。
- 细节与边界：与 body-to-body 的点连接弹簧区分；精确六弹簧系数需查对应分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_affine_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 025. evaluate_angular_limits

角度上下限与阻尼响应。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/025_evaluate_angular_limits.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_angular_limits.cu)。
- 规模：PTX 1458 行；SASS 1836 条；寄存器 98；元数据 atomic 计数 96。
- 细节与边界：单边激活；不能当作恒开启的双边弹簧。

完整符号签名：

```cpp
synreal::kernel::evaluate_angular_limits(synreal::kernel::JointCoordinateView, synreal::kernel::AngularLimitView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 026. evaluate_bending_force

静止余切四点模板的弯曲力与方向投影阻尼。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s9)。
- 实现入口：[原始 PTX](kernels/solver_newton/026_evaluate_bending_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_bending_force.cu)。
- 规模：PTX 294 行；SASS 512 条；寄存器 40；元数据 atomic 计数 12。
- 细节与边界：q=Σw_i x_i；弹性力 −3k/A·w_i q。

完整符号签名：

```cpp
synreal::kernel::evaluate_bending_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 027. evaluate_body_distance_constraint_force

力/负载评估，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/027_evaluate_body_distance_constraint_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_body_distance_constraint_force.cu)。
- 规模：PTX 338 行；SASS 440 条；寄存器 32；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::evaluate_body_distance_constraint_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 028. evaluate_body_point_line_force

力/负载评估，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/028_evaluate_body_point_line_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_body_point_line_force.cu)。
- 规模：PTX 397 行；SASS 564 条；寄存器 48；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::evaluate_body_point_line_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 029. evaluate_body_spring_force

力/负载评估，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/029_evaluate_body_spring_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_body_spring_force.cu)。
- 规模：PTX 394 行；SASS 608 条；寄存器 40；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::evaluate_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 030. evaluate_cables

Cosserat 线缆伸长/剪切/弯曲/扭转及历史响应。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s17)。
- 实现入口：[原始 PTX](kernels/solver_newton/030_evaluate_cables.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_cables.cu)。
- 规模：PTX 11138 行；SASS 10628 条；寄存器 252；元数据 atomic 计数 12。
- 细节与边界：大型多分支 kernel；离散应变、全部模式与 Dahl 更新未完整解析。

完整符号签名：

```cpp
synreal::kernel::evaluate_cables(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 031. evaluate_contact_force

接触模块的力与局部响应评估。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/031_evaluate_contact_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_contact_force.cu)。
- 规模：PTX 2741 行；SASS 2632 条；寄存器 71；元数据 atomic 计数 96。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*);
```

### 032. evaluate_contact_tangent

接触模块的切线/耦合作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/032_evaluate_contact_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_contact_tangent.cu)。
- 规模：PTX 4648 行；SASS 4024 条；寄存器 77；元数据 atomic 计数 75。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_contact_tangent(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 033. evaluate_hard_contacts

硬法向 AL 接触和位移 Coulomb 摩擦评估。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/033_evaluate_hard_contacts.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_hard_contacts.cu)。
- 规模：PTX 7099 行；SASS 6064 条；寄存器 80；元数据 atomic 计数 211。
- 细节与边界：含众多状态/模式分支；本文提供框架而非全部标量系数。

完整符号签名：

```cpp
synreal::kernel::evaluate_hard_contacts(synreal::kernel::HardContactView, glm::vec<3, float, (glm::qualifier)0>*, float*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, float*);
```

### 034. evaluate_joint_armature

施加关节反射惯量相关项。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/034_evaluate_joint_armature.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_joint_armature.cu)。
- 规模：PTX 1578 行；SASS 2000 条；寄存器 102；元数据 atomic 计数 96。
- 细节与边界：属于惯性贡献；解释形式 JᵀM_armature J。

完整符号签名：

```cpp
synreal::kernel::evaluate_joint_armature(synreal::kernel::JointCoordinateView, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 035. evaluate_joint_body_point_line_augmented_lagrangian_force

力/负载评估，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/035_evaluate_joint_body_point_line_augmented_lagrangian_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_joint_body_point_line_augmented_lagrangian_force.cu)。
- 规模：PTX 449 行；SASS 540 条；寄存器 48；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 036. evaluate_joint_body_spring_augmented_lagrangian_force

力/负载评估，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/036_evaluate_joint_body_spring_augmented_lagrangian_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_joint_body_spring_augmented_lagrangian_force.cu)。
- 规模：PTX 332 行；SASS 436 条；寄存器 32；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 037. evaluate_joint_drive_load

由目标、速度与驱动配置形成广义负载。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/037_evaluate_joint_drive_load.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_joint_drive_load.cu)。
- 规模：PTX 1584 行；SASS 1808 条；寄存器 103；元数据 atomic 计数 60。
- 细节与边界：各 target mode、饱和与角度规则需分支核对。

完整符号签名：

```cpp
synreal::kernel::evaluate_joint_drive_load(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float const*, int const*, float const*, float const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, float);
```

### 038. evaluate_rolling_contact_force

接触模块的力与局部响应评估。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/038_evaluate_rolling_contact_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_rolling_contact_force.cu)。
- 规模：PTX 4019 行；SASS 3332 条；寄存器 135；元数据 atomic 计数 15。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_rolling_contact_force(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0>*);
```

### 039. evaluate_soft_contact_force

接触模块的力与局部响应评估。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/039_evaluate_soft_contact_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_soft_contact_force.cu)。
- 规模：PTX 1804 行；SASS 1836 条；寄存器 60；元数据 atomic 计数 63。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_soft_contact_force(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, int const*, unsigned long, unsigned long, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, float, float, float, float, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, float*, int const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 040. evaluate_spring_force

两点距离弹簧力。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s7)。
- 实现入口：[原始 PTX](kernels/solver_newton/040_evaluate_spring_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_spring_force.cu)。
- 规模：PTX 140 行；SASS 352 条；寄存器 23；元数据 atomic 计数 6。
- 细节与边界：f_a=k(l−L)n，f_b=−f_a；长度退化采用零归一化方向。

完整符号签名：

```cpp
synreal::kernel::evaluate_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 041. evaluate_stretch_force

三角形经向/纬向伸长与归一化夹角剪切力。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s8)。
- 实现入口：[原始 PTX](kernels/solver_newton/041_evaluate_stretch_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_stretch_force.cu)。
- 规模：PTX 307 行；SASS 636 条；寄存器 45；元数据 atomic 计数 9。
- 细节与边界：残差为 |a|−1、|b|−1、归一化 a·b；剪切分母内加约 1e−12。

完整符号签名：

```cpp
synreal::kernel::evaluate_stretch_force(glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::mat<2, 2, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 042. evaluate_surface_contact_force

接触模块的力与局部响应评估。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/042_evaluate_surface_contact_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_surface_contact_force.cu)。
- 规模：PTX 3436 行；SASS 2984 条；寄存器 120；元数据 atomic 计数 42。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::evaluate_surface_contact_force(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0>*);
```

### 043. evaluate_tetrahedron_force

四面体体积弹性、可选激活及应变变化阻尼。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s10)。
- 实现入口：[原始 PTX](kernels/solver_newton/043_evaluate_tetrahedron_force.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_tetrahedron_force.cu)。
- 规模：PTX 673 行；SASS 720 条；寄存器 56；元数据 atomic 计数 12。
- 细节与边界：P=μF+(μ+λ)(J−J*+a)cof(F)；另有 C=FᵀF 的历史差。

完整符号签名：

```cpp
synreal::kernel::evaluate_tetrahedron_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 044. evaluate_triangle_drag

三角形法向平方速度空气阻力及切线权重。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s18)。
- 实现入口：[原始 PTX](kernels/solver_newton/044_evaluate_triangle_drag.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__evaluate_triangle_drag.cu)。
- 规模：PTX 192 行；SASS 400 条；寄存器 32；元数据 atomic 计数 9。
- 细节与边界：总力 −ρ Cd A u|u|n/2，均分三顶点。

完整符号签名：

```cpp
synreal::kernel::evaluate_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>, float, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long);
```

### 045. initialize_affine_body_so3_state

初始化 SO(3) 局部旋转/状态。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/045_initialize_affine_body_so3_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_affine_body_so3_state.cu)。
- 规模：PTX 399 行；SASS 644 条；寄存器 29；元数据 atomic 计数 0。
- 细节与边界：包含归一化和退化分支；不能仅凭名称断言为 SVD。

完整符号签名：

```cpp
synreal::kernel::initialize_affine_body_so3_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 046. initialize_block_diagonal

以逐行标量初始化 3×3 对角块，可选复制第二输出。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/046_initialize_block_diagonal.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_block_diagonal.cu)。
- 规模：PTX 63 行；SASS 44 条；寄存器 12；元数据 atomic 计数 0。
- 细节与边界：D_i=a_i I₃。

完整符号签名：

```cpp
synreal::kernel::initialize_block_diagonal(float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long);
```

### 047. initialize_block_non_diagonal

将标量稀疏条目扩为 3×3 对角块并处理批索引。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/047_initialize_block_non_diagonal.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_block_non_diagonal.cu)。
- 规模：PTX 103 行；SASS 356 条；寄存器 21；元数据 atomic 计数 0。
- 细节与边界：val ↦ val I₃；总输出上界为 group×max_nnz；只写行内有效槽，其他槽保持原值；列号增加世界/分块偏移。

完整符号签名：

```cpp
synreal::kernel::initialize_block_non_diagonal(synreal::NonZeroEntry const*, int const*, unsigned long, unsigned long, synreal::BlockNonZeroEntry*, unsigned long);
```

### 048. initialize_body_distance_constraint_state

状态初始化，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/048_initialize_body_distance_constraint_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_body_distance_constraint_state.cu)。
- 规模：PTX 248 行；SASS 440 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::initialize_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 049. initialize_hard_contacts

准备硬接触状态及可选历史匹配。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/049_initialize_hard_contacts.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_hard_contacts.cu)。
- 规模：PTX 2040 行；SASS 2072 条；寄存器 60；元数据 atomic 计数 0。
- 细节与边界：Contact.match_index、容量与状态数组需合法配套。

完整符号签名：

```cpp
synreal::kernel::initialize_hard_contacts(synreal::kernel::HardContactView);
```

### 050. initialize_joint_body_point_line_state

状态初始化，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/050_initialize_joint_body_point_line_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_joint_body_point_line_state.cu)。
- 规模：PTX 382 行；SASS 560 条；寄存器 40；元数据 atomic 计数 0。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::initialize_joint_body_point_line_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 051. initialize_joint_body_spring_state

初始化/清零关节弹簧相关状态。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/051_initialize_joint_body_spring_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_joint_body_spring_state.cu)。
- 规模：PTX 34 行；SASS 28 条；寄存器 9；元数据 atomic 计数 0。
- 细节与边界：可读实现为三分量零写入。

完整符号签名：

```cpp
synreal::kernel::initialize_joint_body_spring_state(glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 052. initialize_joint_coordinate_velocities

建立关节广义速度坐标。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/052_initialize_joint_coordinate_velocities.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_joint_coordinate_velocities.cu)。
- 规模：PTX 714 行；SASS 1064 条；寄存器 74；元数据 atomic 计数 0。
- 细节与边界：需要角/线性坐标映射，不能以节点速度直接代替。

完整符号签名：

```cpp
synreal::kernel::initialize_joint_coordinate_velocities(synreal::kernel::JointCoordinateView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*);
```

### 053. initialize_rhs

质量与稀疏项作用于两组向量之差，再按标量缩放并加 base。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s4)。
- 实现入口：[原始 PTX](kernels/solver_newton/053_initialize_rhs.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_rhs.cu)。
- 规模：PTX 383 行；SASS 420 条；寄存器 31；元数据 atomic 计数 0。
- 细节与边界：b=s[(diag(m)+A)(u−v)]+base；step 调用点确认 s=1/h²；max_nnz=0 时不访问稀疏数组。

完整符号签名：

```cpp
synreal::kernel::initialize_rhs(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, synreal::NonZeroEntry const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 054. initialize_step

建立活动状态、预测位置与惯性/系统对角系数。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s3)。
- 实现入口：[原始 PTX](kernels/solver_newton/054_initialize_step.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_step.cu)。
- 规模：PTX 274 行；SASS 472 条；寄存器 30；元数据 atomic 计数 0。
- 细节与边界：自由粒子活动分支出现 x+h v+h²g；固定、运动学与 ABD 分支不能混同。

完整符号签名：

```cpp
synreal::kernel::initialize_step(float, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float const*, float const*, float, float const*, float, float const*, float, float const*, float, float const*, float, float const*, int const*, int const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long);
```

### 055. initialize_triangle_drag

准备空气阻力使用的三角形方向与面积数据。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s18)。
- 实现入口：[原始 PTX](kernels/solver_newton/055_initialize_triangle_drag.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__initialize_triangle_drag.cu)。
- 规模：PTX 129 行；SASS 356 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：几何准备与之后阻力切线冻结几何相联系。

完整符号签名：

```cpp
synreal::kernel::initialize_triangle_drag(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long, unsigned long);
```

### 056. invert_block_preconditioner

对称化 3×3 块、求逆并在退化时回退。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/056_invert_block_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__invert_block_preconditioner.cu)。
- 规模：PTX 188 行；SASS 304 条；寄存器 22；元数据 atomic 计数 0。
- 细节与边界：回退是正对角倒数，不是一般矩阵 Moore–Penrose 伪逆。

完整符号签名：

```cpp
synreal::kernel::invert_block_preconditioner(glm::mat<3, 3, float, (glm::qualifier)0> const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 057. multiply_affine_body_constitutive_tangent

仿射体其他本构模型的切线作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/057_multiply_affine_body_constitutive_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_affine_body_constitutive_tangent.cu)。
- 规模：PTX 641 行；SASS 784 条；寄存器 46；元数据 atomic 计数 12。
- 细节与边界：CO_ROTATED/正交性等分支需逐一恢复；不能套用 SO3 AL 公式。

完整符号签名：

```cpp
synreal::kernel::multiply_affine_body_constitutive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, synreal::AffineBodyRigidityModel, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 058. multiply_affine_body_so3_augmented_lagrangian_tangent

SO(3) 刚性项冻结旋转后的切线作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/058_multiply_affine_body_so3_augmented_lagrangian_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_affine_body_so3_augmented_lagrangian_tangent.cu)。
- 规模：PTX 200 行；SASS 300 条；寄存器 32；元数据 atomic 计数 9。
- 细节与边界：δA ↦ κ R sym(RᵀδA)。

完整符号签名：

```cpp
synreal::kernel::multiply_affine_body_so3_augmented_lagrangian_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 059. multiply_bending_damping_tangent

四点弯曲阻尼的切线向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s9)。
- 实现入口：[原始 PTX](kernels/solver_newton/059_multiply_bending_damping_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_bending_damping_tangent.cu)。
- 规模：PTX 277 行；SASS 616 条；寄存器 38；元数据 atomic 计数 12。
- 细节与边界：冻结方向下包含 w_i w_j n nᵀ；不等于各向同性阻尼。

完整符号签名：

```cpp
synreal::kernel::multiply_bending_damping_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 060. multiply_joint_body_point_line_augmented_lagrangian

局部切线作用，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/060_multiply_joint_body_point_line_augmented_lagrangian.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_joint_body_point_line_augmented_lagrangian.cu)。
- 规模：PTX 344 行；SASS 448 条；寄存器 40；元数据 atomic 计数 24。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::multiply_joint_body_point_line_augmented_lagrangian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 061. multiply_joint_drive_tangent

局部切线作用，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/061_multiply_joint_drive_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_joint_drive_tangent.cu)。
- 规模：PTX 1086 行；SASS 1496 条；寄存器 78；元数据 atomic 计数 72。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::multiply_joint_drive_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, int const*, int const*, float const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 062. multiply_rolling_contact_tangent

接触模块的切线/耦合作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/062_multiply_rolling_contact_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_rolling_contact_tangent.cu)。
- 规模：PTX 4219 行；SASS 3484 条；寄存器 135；元数据 atomic 计数 15。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::multiply_rolling_contact_tangent(synreal::kernel::RollingContactView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

### 063. multiply_soft_contact_hessian_off_diagonal

接触模块的切线/耦合作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/063_multiply_soft_contact_hessian_off_diagonal.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_soft_contact_hessian_off_diagonal.cu)。
- 规模：PTX 1845 行；SASS 1776 条；寄存器 90；元数据 atomic 计数 30。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::multiply_soft_contact_hessian_off_diagonal(int const*, unsigned long, int const*, int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, int const*, synreal::Transform const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, int const*, float const*, float const*, float const*, unsigned long, unsigned long, unsigned long, int const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, unsigned long, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float, unsigned long, float, float, unsigned long, int const*, unsigned long, float const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*);
```

### 064. multiply_surface_contact_tangent

接触模块的切线/耦合作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/064_multiply_surface_contact_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_surface_contact_tangent.cu)。
- 规模：PTX 3826 行；SASS 3280 条；寄存器 116；元数据 atomic 计数 42。
- 细节与边界：按 soft/surface/rolling/普通接触区分；不能用单一罚弹簧覆盖全部分支。

完整符号签名：

```cpp
synreal::kernel::multiply_surface_contact_tangent(synreal::kernel::SurfaceContactView, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

### 065. multiply_tetrahedron_tangent

四面体的切线向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s10)。
- 实现入口：[原始 PTX](kernels/solver_newton/065_multiply_tetrahedron_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_tetrahedron_tangent.cu)。
- 规模：PTX 618 行；SASS 616 条；寄存器 56；元数据 atomic 计数 12。
- 细节与边界：需与 μF+K(J−J*+a)cof(F) 及应变阻尼配套；稳定化分支待核对。

完整符号签名：

```cpp
synreal::kernel::multiply_tetrahedron_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 066. multiply_triangle_drag_tangent

三角形阻力切线作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s18)。
- 实现入口：[原始 PTX](kernels/solver_newton/066_multiply_triangle_drag_tangent.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__multiply_triangle_drag_tangent.cu)。
- 规模：PTX 129 行；SASS 260 条；寄存器 27；元数据 atomic 计数 9。
- 细节与边界：冻结几何的 n nᵀ 三点耦合算子。

完整符号签名：

```cpp
synreal::kernel::multiply_triangle_drag_tangent(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 067. prepare_cable_penalties

初始化/延续线缆四通道罚参数并施加衰减与夹紧。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s17)。
- 实现入口：[原始 PTX](kernels/solver_newton/067_prepare_cable_penalties.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__prepare_cable_penalties.cu)。
- 规模：PTX 159 行；SASS 200 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：k_new=min(k_authored,max(k_floor,γ_eff k_old))。

完整符号签名：

```cpp
synreal::kernel::prepare_cable_penalties(glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0>*, int*, unsigned long, unsigned long, float, float, float, float, float, bool, bool, int const*);
```

### 068. prepare_cable_tangents

准备线缆几何/旋转切线缓存。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s17)。
- 实现入口：[原始 PTX](kernels/solver_newton/068_prepare_cable_tangents.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__prepare_cable_tangents.cu)。
- 规模：PTX 5542 行；SASS 5368 条；寄存器 252；元数据 atomic 计数 0。
- 细节与边界：旋转参数化、退化和常量表需结合原 PTX。

完整符号签名：

```cpp
synreal::kernel::prepare_cable_tangents(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*);
```

### 069. prepare_inverse_preconditioner

为活动自由度准备标量逆预条件。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/069_prepare_inverse_preconditioner.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__prepare_inverse_preconditioner.cu)。
- 规模：PTX 86 行；SASS 212 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：scale>0、mask 最低位有效且系数正时取倒数，否则零。

完整符号签名：

```cpp
synreal::kernel::prepare_inverse_preconditioner(float const*, float const*, int const*, float*, unsigned long, unsigned long);
```

### 070. refresh_inertial_cache_diagonals

由关联行/值刷新惯性相关对角缓存。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s4)。
- 实现入口：[原始 PTX](kernels/solver_newton/070_refresh_inertial_cache_diagonals.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__refresh_inertial_cache_diagonals.cu)。
- 规模：PTX 121 行；SASS 236 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：非空 CSR 行计算 sum 并写 sum、3·sum；空行不写入，保留两个输出原值；缓存物理归属仍需实参追踪。

完整符号签名：

```cpp
synreal::kernel::refresh_inertial_cache_diagonals(float const*, unsigned long const*, int const*, float*, float*, unsigned long);
```

### 071. refresh_inertial_cache_nonzeros

刷新已有非零条目的数值。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s4)。
- 实现入口：[原始 PTX](kernels/solver_newton/071_refresh_inertial_cache_nonzeros.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__refresh_inertial_cache_nonzeros.cu)。
- 规模：PTX 203 行；SASS 452 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：两组关联求和存在符号差；分别判断各自 CSR 行是否为空，空行对应输出保持原值；列号不变。

完整符号签名：

```cpp
synreal::kernel::refresh_inertial_cache_nonzeros(float const*, unsigned long const*, int const*, float const*, unsigned long const*, int const*, synreal::NonZeroEntry*, synreal::NonZeroEntry*, unsigned long);
```

### 072. reset_selected_joint_drive_state

按掩码清零选中的驱动历史。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/072_reset_selected_joint_drive_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__reset_selected_joint_drive_state.cu)。
- 规模：PTX 40 行；SASS 24 条；寄存器 8；元数据 atomic 计数 0。
- 细节与边界：状态重置，不是物理力计算。

完整符号签名：

```cpp
synreal::kernel::reset_selected_joint_drive_state(int const*, int*, unsigned long);
```

### 073. snapshot_hard_contacts

保存硬接触快照供历史相关逻辑使用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/073_snapshot_hard_contacts.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__snapshot_hard_contacts.cu)。
- 规模：PTX 109 行；SASS 192 条；寄存器 18；元数据 atomic 计数 0。
- 细节与边界：不能仅从函数地址推导它在每个 step 中的精确执行位置。

完整符号签名：

```cpp
synreal::kernel::snapshot_hard_contacts(synreal::kernel::HardContactView);
```

### 074. update_affine_body_so3_augmented_lagrangian_state

刷新 SO(3) 局部旋转及相关 AL 状态。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s11)。
- 实现入口：[原始 PTX](kernels/solver_newton/074_update_affine_body_so3_augmented_lagrangian_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_affine_body_so3_augmented_lagrangian_state.cu)。
- 规模：PTX 506 行；SASS 720 条；寄存器 39；元数据 atomic 计数 0。
- 细节与边界：存在叉积、方向调整及对称投影；完整 U 累计/缩放语义未定。

完整符号签名：

```cpp
synreal::kernel::update_affine_body_so3_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long);
```

### 075. update_body_distance_constraint_state

对偶/历史状态更新，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/075_update_body_distance_constraint_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_body_distance_constraint_state.cu)。
- 规模：PTX 280 行；SASS 476 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::update_body_distance_constraint_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long);
```

### 076. update_cable_penalties

按非线性状态更新线缆罚参数。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s17)。
- 实现入口：[原始 PTX](kernels/solver_newton/076_update_cable_penalties.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_cable_penalties.cu)。
- 规模：PTX 2512 行；SASS 3444 条；寄存器 116；元数据 atomic 计数 0。
- 细节与边界：linear/angular beta 分支的完整残差度量待追。

完整符号签名：

```cpp
synreal::kernel::update_cable_penalties(synreal::kernel::CableView, glm::vec<3, float, (glm::qualifier)0> const*, float, float);
```

### 077. update_hard_contact_duals

更新硬接触对偶/摩擦状态。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s13)。
- 实现入口：[原始 PTX](kernels/solver_newton/077_update_hard_contact_duals.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_hard_contact_duals.cu)。
- 规模：PTX 2096 行；SASS 2188 条；寄存器 61；元数据 atomic 计数 0。
- 细节与边界：投影、历史和罚参数缩放需精确数据契约。

完整符号签名：

```cpp
synreal::kernel::update_hard_contact_duals(synreal::kernel::HardContactView);
```

### 078. update_joint_body_point_line_augmented_lagrangian_state

对偶/历史状态更新，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/078_update_joint_body_point_line_augmented_lagrangian_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_joint_body_point_line_augmented_lagrangian_state.cu)。
- 规模：PTX 483 行；SASS 676 条；寄存器 46；元数据 atomic 计数 0。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::update_joint_body_point_line_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, bool, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 079. update_joint_body_spring_augmented_lagrangian_state

对偶/历史状态更新，对象由函数名中的 spring/point_line/distance/drive 区分。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/079_update_joint_body_spring_augmented_lagrangian_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_joint_body_spring_augmented_lagrangian_state.cu)。
- 规模：PTX 214 行；SASS 332 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：AL 与 penalty 路径的状态、缩放和投影不同；body 点需映射到仿射自由度。

完整符号签名：

```cpp
synreal::kernel::update_joint_body_spring_augmented_lagrangian_state(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long);
```

### 080. update_joint_drive_angle_state

更新角驱动历史状态。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s12)。
- 实现入口：[原始 PTX](kernels/solver_newton/080_update_joint_drive_angle_state.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_joint_drive_angle_state.cu)。
- 规模：PTX 482 行；SASS 804 条；寄存器 47；元数据 atomic 计数 0。
- 细节与边界：精确连续角/重置分支尚未完整归一化。

完整符号签名：

```cpp
synreal::kernel::update_joint_drive_angle_state(glm::vec<3, float, (glm::qualifier)0> const*, float*, int*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, unsigned long, unsigned long, unsigned long);
```

### 081. update_velocity

两组坐标差乘标量得到速度。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s3)。
- 实现入口：[原始 PTX](kernels/solver_newton/081_update_velocity.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__update_velocity.cu)。
- 规模：PTX 56 行；SASS 36 条；寄存器 13；元数据 atomic 计数 0。
- 细节与边界：v=(b−a)s；不替代所有 ABD 模式的完整速度恢复。

完整符号签名：

```cpp
synreal::kernel::update_velocity(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 082. build_affine_body_preconditioner&lt;BlockNonZeroEntry&gt;

按稀疏标量/块条目构建 affine-body 级预条件。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/083_build_affine_body_preconditioner<BlockNonZeroEntry>.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__build_affine_body_preconditioner_synreal__BlockNonZeroEntry_.cu)。
- 规模：PTX 4561 行；SASS 4120 条；寄存器 158；元数据 atomic 计数 0。
- 细节与边界：包含 body 内耦合；完整块布局、求逆和接触交叉项待进一步追踪。

完整符号签名：

```cpp
void synreal::kernel::build_affine_body_preconditioner<synreal::BlockNonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::BlockNonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long);
```

### 083. build_affine_body_preconditioner&lt;NonZeroEntry&gt;

按稀疏标量/块条目构建 affine-body 级预条件。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/solver_newton/084_build_affine_body_preconditioner<NonZeroEntry>.ptx)；[机械还原 CUDA](recover/src/solver_newton/synreal__kernel__build_affine_body_preconditioner_synreal__NonZeroEntry_.cu)。
- 规模：PTX 4211 行；SASS 4008 条；寄存器 158；元数据 atomic 计数 0。
- 细节与边界：包含 body 内耦合；完整块布局、求逆和接触交叉项待进一步追踪。

完整符号签名：

```cpp
void synreal::kernel::build_affine_body_preconditioner<synreal::NonZeroEntry>(glm::vec<4, int, (glm::qualifier)0> const*, float const*, float const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int const*, synreal::NonZeroEntry const*, unsigned long, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, synreal::kernel::CableView, unsigned long const*, int const*, float, int const*, float const*, float*, int*, unsigned long, unsigned long, unsigned long);
```

<a id="pcg_solver"></a>
## pcg_solver

### 084. update_preconditioned_cg_direction

从传入方向基向量递推 CG 搜索方向。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/001_update_preconditioned_cg_direction.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__update_preconditioned_cg_direction.cu)。
- 规模：PTX 83 行；SASS 116 条；寄存器 16；元数据 atomic 计数 0。
- 细节与边界：p=input+βp；是否已经预条件由调用点决定。

完整符号签名：

```cpp
synreal::kernel::update_preconditioned_cg_direction(int, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 085. update_solution_and_residual

更新线性解与残差。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/002_update_solution_and_residual.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__update_solution_and_residual.cu)。
- 规模：PTX 97 行；SASS 124 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：α=num[k]/den[k]；小分母/NaN 保护须对照 PTX。

完整符号签名：

```cpp
synreal::kernel::update_solution_and_residual(int, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 086. evaluate_residual&lt;BlockNonZeroEntry, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

由当前解计算线性系统残差。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/007_evaluate_residual<BlockNonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__evaluate_residual_synreal__BlockNonZeroEntry__glm__mat_3__3__float__.cu)。
- 规模：PTX 316 行；SASS 412 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：r=b−Az；模板决定稀疏标量/块布局和对角类型。

完整符号签名：

```cpp
void synreal::kernel::evaluate_residual<synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 087. evaluate_residual&lt;NonZeroEntry, float&gt;

由当前解计算线性系统残差。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/008_evaluate_residual<NonZeroEntry__float>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__evaluate_residual_synreal__NonZeroEntry__float_.cu)。
- 规模：PTX 308 行；SASS 356 条；寄存器 29；元数据 atomic 计数 0。
- 细节与边界：r=b−Az；模板决定稀疏标量/块布局和对角类型。

完整符号签名：

```cpp
void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, float>(int const*, synreal::NonZeroEntry const*, unsigned long, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 088. evaluate_residual&lt;NonZeroEntry, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

由当前解计算线性系统残差。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/009_evaluate_residual<NonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__evaluate_residual_synreal__NonZeroEntry__glm__mat_3__3__float__.cu)。
- 规模：PTX 322 行；SASS 376 条；寄存器 29；元数据 atomic 计数 0。
- 细节与边界：r=b−Az；模板决定稀疏标量/块布局和对角类型。

完整符号签名：

```cpp
void synreal::kernel::evaluate_residual<synreal::NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::NonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 089. initialize_zero_solution_and_reduce&lt;256u, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

复制输入向量、清零另一向量并归约二次型。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/010_initialize_zero_solution_and_reduce<256u__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__initialize_zero_solution_and_reduce_256u__glm__mat_3__3__float__.cu)。
- 规模：PTX 149 行；SASS 88 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：输入ᵀP输入；解/残差的实际输出身份以调用点为准。

完整符号签名：

```cpp
void synreal::kernel::initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long);
```

### 090. multiply_matrix&lt;NonZeroEntry, float&gt;

对 ELL/块 ELL 系统作矩阵向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/011_multiply_matrix<NonZeroEntry__float>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__multiply_matrix_synreal__NonZeroEntry__float_.cu)。
- 规模：PTX 297 行；SASS 352 条；寄存器 29；元数据 atomic 计数 0。
- 细节与边界：按 entries[e*tile+row] 读取，列号加世界/块基址。

完整符号签名：

```cpp
void synreal::kernel::multiply_matrix<synreal::NonZeroEntry, float>(int const*, synreal::NonZeroEntry const*, unsigned long, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 091. multiply_matrix&lt;NonZeroEntry, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

对 ELL/块 ELL 系统作矩阵向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/012_multiply_matrix<NonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__multiply_matrix_synreal__NonZeroEntry__glm__mat_3__3__float__.cu)。
- 规模：PTX 311 行；SASS 368 条；寄存器 29；元数据 atomic 计数 0。
- 细节与边界：按 entries[e*tile+row] 读取，列号加世界/块基址。

完整符号签名：

```cpp
void synreal::kernel::multiply_matrix<synreal::NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::NonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long);
```

### 092. multiply_matrix_and_reduce&lt;256u, BlockNonZeroEntry, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

融合块稀疏矩阵乘法和内积部分和。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/013_multiply_matrix_and_reduce<256u__BlockNonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/ernel__multiply_matrix_and_reduce_256u__synreal__BlockNonZeroEntry__glm__mat_3__3__float__.cu)。
- 规模：PTX 383 行；SASS 436 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：同时生成 Ap 与 pᵀAp；实参角色不能凭参数排列猜。

完整符号签名：

```cpp
void synreal::kernel::multiply_matrix_and_reduce<256u, synreal::BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >(int const*, synreal::BlockNonZeroEntry const*, unsigned long, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, unsigned long, unsigned long);
```

### 093. update_cg_direction&lt;float&gt;

预条件残差后递推 PCG 搜索方向。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/014_update_cg_direction<float>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__update_cg_direction_float_.cu)。
- 规模：PTX 86 行；SASS 116 条；寄存器 16；元数据 atomic 计数 0。
- 细节与边界：w=P r，p=w+βp；P 是 float 或 mat3 特化。

完整符号签名：

```cpp
void synreal::kernel::update_cg_direction<float>(int, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 094. update_cg_direction&lt;glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

预条件残差后递推 PCG 搜索方向。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/015_update_cg_direction<glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__update_cg_direction_glm__mat_3__3__float__.cu)。
- 规模：PTX 100 行；SASS 136 条；寄存器 19；元数据 atomic 计数 0。
- 细节与边界：w=P r，p=w+βp；P 是 float 或 mat3 特化。

完整符号签名：

```cpp
void synreal::kernel::update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >(int, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 095. update_solution_residual_and_reduce&lt;256u, glm::mat&lt;3, 3, float, (glm::qualifier)0&gt; &gt;

融合 α 更新和可选预条件残差二次型归约。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s6)。
- 实现入口：[原始 PTX](kernels/pcg_solver/016_update_solution_residual_and_reduce<256u__glm::mat<3__3__float___glm::qualifier_0>_>.ptx)；[机械还原 CUDA](recover/src/pcg_solver/synreal__kernel__update_solution_residual_and_reduce_256u__glm__mat_3__3__float__.cu)。
- 规模：PTX 204 行；SASS 188 条；寄存器 23；元数据 atomic 计数 0。
- 细节与边界：z+=αp，r−=αAp，ρ=rᵀPr。

完整符号签名：

```cpp
void synreal::kernel::update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(int, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, bool, unsigned long);
```

<a id="fluid"></a>
## fluid

### 096. accumulate_rows

按流体约束行累积力与预条件块及附加邻居项。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/001_accumulate_rows.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__accumulate_rows.cu)。
- 规模：PTX 612 行；SASS 620 条；寄存器 54；元数据 atomic 计数 84。
- 细节与边界：密度结构 −Jᵀkc 与 diag(JᵀkJ)，另累积冻结系数黏性配对力和 νI₃；邻居数≥65 时重新查询。

完整符号签名：

```cpp
synreal::fluid_kernel::accumulate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 097. add_diagonal

把流体已累积的对角项加到系统/预条件缓存。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/002_add_diagonal.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__add_diagonal.cu)。
- 规模：PTX 69 行；SASS 48 条；寄存器 11；元数据 atomic 计数 0。
- 细节与边界：该辅助入口本身不代表完整模块 Hessian 装配。

完整符号签名：

```cpp
synreal::fluid_kernel::add_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int);
```

### 098. bound_scale

以流体粒子增量长度约束世界级步长。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/003_bound_scale.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__bound_scale.cu)。
- 规模：PTX 72 行；SASS 160 条；寄存器 12；元数据 atomic 计数 1。
- 细节与边界：对非负 float 的整数位模式执行 atomic min；主机初始世界尺度为 1，位移上界 d_max=ratio×h_f。

完整符号签名：

```cpp
synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float, float, float*);
```

### 099. build_grid

构造流体/边界空间哈希网格。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/004_build_grid.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__build_grid.cu)。
- 规模：PTX 172 行；SASS 232 条；寄存器 22；元数据 atomic 计数 1。
- 细节与边界：按世界/格子组织邻居；atomic exchange、signed sentinel 与 floor 必须保留。

完整符号签名：

```cpp
synreal::fluid_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*, int, int);
```

### 100. evaluate_rows

流体邻居查询、密度残差与 Jacobian 行缓存。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/005_evaluate_rows.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__evaluate_rows.cu)。
- 规模：PTX 406 行；SASS 440 条；寄存器 52；元数据 atomic 计数 0。
- 细节与边界：poly6 核；c=max(ΣV W−1,0)，过密时 k=K V_i；vec4.xyz=−V_j∇W，w 为单侧黏性配对系数；最多缓存 64 项但保留实际计数。

完整符号签名：

```cpp
synreal::fluid_kernel::evaluate_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, float*, float*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*);
```

### 101. initialize_scale

初始化世界级流体步长缩放数组。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/006_initialize_scale.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__initialize_scale.cu)。
- 规模：PTX 32 行；SASS 16 条；寄存器 4；元数据 atomic 计数 0。
- 细节与边界：out[i]=给定初始值；Fluid::limit_step 的主机实参为 1.0。

完整符号签名：

```cpp
synreal::fluid_kernel::initialize_scale(float*, float, int);
```

### 102. multiply_rows

流体行式耦合切线乘法。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/007_multiply_rows.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__multiply_rows.cu)。
- 规模：PTX 823 行；SASS 868 条；寄存器 50；元数据 atomic 计数 18。
- 细节与边界：主结构 Jᵀk(Jp)，另有 ν_ij(p_i−p_j) 的配对 Laplacian；与力入口使用同一缓存/重新查询规则。

完整符号签名：

```cpp
synreal::fluid_kernel::multiply_rows(synreal::fluid_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

### 103. scale_step

根据世界索引缩放求解增量。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s15)。
- 实现入口：[原始 PTX](kernels/fluid/008_scale_step.ptx)；[机械还原 CUDA](recover/src/fluid/synreal__fluid_kernel__scale_step.cu)。
- 规模：PTX 71 行；SASS 52 条；寄存器 10；元数据 atomic 计数 0。
- 细节与边界：Δx_i *= scale[world(i)]；有复制世界与 particle_world 分支。

完整符号签名：

```cpp
synreal::fluid_kernel::scale_step(synreal::Model, glm::vec<3, float, (glm::qualifier)0>*, float const*, int);
```

<a id="granular"></a>
## granular

### 104. accumulate_bonds

颗粒键弹塑性力、阻尼与稳定切线装配。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/001_accumulate_bonds.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__accumulate_bonds.cu)。
- 规模：PTX 286 行；SASS 340 条；寄存器 30；元数据 atomic 计数 24。
- 细节与边界：有效长度分段夹紧；横向刚度取伸长正部；两点散射。

完整符号签名：

```cpp
synreal::granular_kernel::accumulate_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, int const*, int, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*);
```

### 105. accumulate_contacts

颗粒接触的局部力与切线积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/002_accumulate_contacts.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__accumulate_contacts.cu)。
- 规模：PTX 490 行；SASS 496 条；寄存器 60；元数据 atomic 计数 0。
- 细节与边界：接触与黏结分开处理；完整摩擦/截断分支尚未逐式归一化。

完整符号签名：

```cpp
synreal::granular_kernel::accumulate_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, int*, int*, glm::vec<4, float, (glm::qualifier)0>*);
```

### 106. add_diagonal

把颗粒已累积的对角项加到系统/预条件缓存。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/003_add_diagonal.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__add_diagonal.cu)。
- 规模：PTX 69 行；SASS 48 条；寄存器 11；元数据 atomic 计数 0。
- 细节与边界：该辅助入口本身不代表完整模块 Hessian 装配。

完整符号签名：

```cpp
synreal::granular_kernel::add_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int);
```

### 107. build_grid

构造颗粒空间哈希网格。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/004_build_grid.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__build_grid.cu)。
- 规模：PTX 149 行；SASS 212 条；寄存器 22；元数据 atomic 计数 1。
- 细节与边界：按世界/格子组织邻居；atomic exchange、signed sentinel 与 floor 必须保留。

完整符号签名：

```cpp
synreal::granular_kernel::build_grid(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, int*, int*, glm::vec<3, int, (glm::qualifier)0>*, int*, int*);
```

### 108. commit_bonds

提交颗粒键断裂与长度历史更新。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/005_commit_bonds.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__commit_bonds.cu)。
- 规模：PTX 97 行；SASS 80 条；寄存器 17；元数据 atomic 计数 0。
- 细节与边界：原 PTX：l>Lh(1+b) 断开；否则 max(L0(1−c),min(Lh,l+y L0))。L0 为只读原始长度，Lh 为可写历史长度；默认 y=0.03、c=0.4、b=0.1。

完整符号签名：

```cpp
synreal::granular_kernel::commit_bonds(synreal::Model, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float*, int*, int);
```

### 109. form_bonds

按空间邻居和形成条件建立动态黏结。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/006_form_bonds.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__form_bonds.cu)。
- 规模：PTX 742 行；SASS 660 条；寄存器 48；元数据 atomic 计数 0。
- 细节与边界：gap、speed、容量、重复键及候选选择；完整分支未归一化。

完整符号签名：

```cpp
synreal::granular_kernel::form_bonds(synreal::Model, synreal::granular_kernel::View, int const*, int const*, int*, glm::vec<2, int, (glm::qualifier)0>*, float*, float*, int*);
```

### 110. multiply_bonds

活动颗粒键的二点矩阵作用。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/007_multiply_bonds.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__multiply_bonds.cu)。
- 规模：PTX 98 行；SASS 80 条；寄存器 28；元数据 atomic 计数 6。
- 细节与边界：z=B(p_a−p_b)，两端分别加 z 与 −z。

完整符号签名：

```cpp
synreal::granular_kernel::multiply_bonds(glm::vec<2, int, (glm::qualifier)0> const*, int const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, int, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

### 111. multiply_contacts

颗粒接触的局部切线向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s16)。
- 实现入口：[原始 PTX](kernels/granular/008_multiply_contacts.ptx)；[机械还原 CUDA](recover/src/granular/synreal__granular_kernel__multiply_contacts.cu)。
- 规模：PTX 638 行；SASS 652 条；寄存器 48；元数据 atomic 计数 0。
- 细节与边界：接触与黏结分开处理；完整摩擦/截断分支尚未逐式归一化。

完整符号签名：

```cpp
synreal::granular_kernel::multiply_contacts(synreal::granular_kernel::View, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

<a id="self_collision"></a>
## self_collision

### 112. accumulate_edge_edge

edge_edge 的接触响应及局部线性化积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/001_accumulate_edge_edge.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__accumulate_edge_edge.cu)。
- 规模：PTX 870 行；SASS 868 条；寄存器 81；元数据 atomic 计数 49。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::accumulate_edge_edge(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, int const*, int const*, int const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int);
```

### 113. accumulate_edge_face

edge_face 的接触响应及局部线性化积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/002_accumulate_edge_face.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__accumulate_edge_face.cu)。
- 规模：PTX 1037 行；SASS 1160 条；寄存器 95；元数据 atomic 计数 61。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::accumulate_edge_face(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, int const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, int const*, float const*, float, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int);
```

### 114. accumulate_particle_pairs

particle_pairs 的接触响应及局部线性化积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/003_accumulate_particle_pairs.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__accumulate_particle_pairs.cu)。
- 规模：PTX 447 行；SASS 552 条；寄存器 48；元数据 atomic 计数 25。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::accumulate_particle_pairs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, int const*, int const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int);
```

### 115. accumulate_vertex_face

vertex_face 的接触响应及局部线性化积累。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/004_accumulate_vertex_face.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__accumulate_vertex_face.cu)。
- 规模：PTX 762 行；SASS 788 条；寄存器 65；元数据 atomic 计数 49。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::accumulate_vertex_face(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, int const*, float const*, float, float, bool, float, glm::vec<3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, synreal::SelfCollisionContactTangent*, unsigned int*, unsigned long, unsigned long, unsigned long, int);
```

### 116. add_hessian_diagonal

累加自碰撞 Hessian 对角块到目标。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/005_add_hessian_diagonal.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__add_hessian_diagonal.cu)。
- 规模：PTX 71 行；SASS 48 条；寄存器 23；元数据 atomic 计数 0。
- 细节与边界：逐 mat3 的九分量相加。

完整符号签名：

```cpp
synreal::self_collision_kernel::add_hessian_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long);
```

### 117. build_edge_aabbs

为碰撞边建立增厚包围盒。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/006_build_edge_aabbs.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__build_edge_aabbs.cu)。
- 规模：PTX 99 行；SASS 216 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：使用 ivec4 的 .z/.w 端点；最后三个参数依次为总盒数 n、每世界拓扑数 tile、每世界坐标步幅 stride。

完整符号签名：

```cpp
synreal::self_collision_kernel::build_edge_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, synreal::Aabb*, float, unsigned long, unsigned long, unsigned long);
```

### 118. build_particle_aabbs

建立自由粒子的半径包围盒。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/007_build_particle_aabbs.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__build_particle_aabbs.cu)。
- 规模：PTX 90 行；SASS 216 条；寄存器 20；元数据 atomic 计数 0。
- 细节与边界：AABB=x±r；最后三个参数依次为 n、tile、stride；模板粒子编号与半径共享，坐标按世界偏移。

完整符号签名：

```cpp
synreal::self_collision_kernel::build_particle_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, synreal::Aabb*, unsigned long, unsigned long, unsigned long);
```

### 119. build_triangle_aabbs

为碰撞三角形建立增厚包围盒。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/008_build_triangle_aabbs.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__build_triangle_aabbs.cu)。
- 规模：PTX 112 行；SASS 236 条；寄存器 22；元数据 atomic 计数 0。
- 细节与边界：逐坐标 min/max 加减厚度；精确索引/世界布局见签名和 PTX。

完整符号签名：

```cpp
synreal::self_collision_kernel::build_triangle_aabbs(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, synreal::Aabb*, float, unsigned long, unsigned long, unsigned long);
```

### 120. multiply_contact_tangents

对自碰撞局部接触切线执行矩阵向量乘。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/009_multiply_contact_tangents.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__multiply_contact_tangents.cu)。
- 规模：PTX 323 行；SASS 260 条；寄存器 32；元数据 atomic 计数 21。
- 细节与边界：与对角块和 query/accumulate 数据配套。

完整符号签名：

```cpp
synreal::self_collision_kernel::multiply_contact_tangents(synreal::SelfCollisionContactTangent const*, unsigned int const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*);
```

### 121. multiply_hessian_diagonal

作用自碰撞 Hessian 对角块。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/010_multiply_hessian_diagonal.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__multiply_hessian_diagonal.cu)。
- 规模：PTX 70 行；SASS 56 条；寄存器 23；元数据 atomic 计数 0。
- 细节与边界：out_i += H_i p_i；保留并累加已有输出。

完整符号签名：

```cpp
synreal::self_collision_kernel::multiply_hessian_diagonal(glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long);
```

### 122. query_edge_edge

edge_edge 的候选/精确几何查询。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/011_query_edge_edge.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__query_edge_edge.cu)。
- 规模：PTX 467 行；SASS 548 条；寄存器 55；元数据 atomic 计数 0。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::query_edge_edge(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, int*, int*, unsigned long, unsigned long, unsigned long, int);
```

### 123. query_edge_face

edge_face 的候选/精确几何查询。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/012_query_edge_face.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__query_edge_face.cu)。
- 规模：PTX 441 行；SASS 432 条；寄存器 32；元数据 atomic 计数 0。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::query_edge_face(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, int*, int*, unsigned long, unsigned long, unsigned long, unsigned long, int);
```

### 124. query_particle_pairs

particle_pairs 的候选/精确几何查询。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/013_query_particle_pairs.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__query_particle_pairs.cu)。
- 规模：PTX 428 行；SASS 448 条；寄存器 37；元数据 atomic 计数 0。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::query_particle_pairs(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, int const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, int const*, int const*, int*, int*, unsigned long, unsigned long, unsigned long, int);
```

### 125. query_vertex_face

vertex_face 的候选/精确几何查询。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/014_query_vertex_face.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__query_vertex_face.cu)。
- 规模：PTX 641 行；SASS 684 条；寄存器 53；元数据 atomic 计数 0。
- 细节与边界：最近点、共拓扑排除、退化、容量及世界索引须保持；edge_face 还涉及解缠语义。

完整符号签名：

```cpp
synreal::self_collision_kernel::query_vertex_face(glm::vec<3, float, (glm::qualifier)0> const*, int const*, float const*, glm::vec<3, int, (glm::qualifier)0> const*, int const*, synreal::Aabb const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, int const*, float, float, bool, int*, int*, unsigned long, unsigned long, unsigned long, unsigned long, int);
```

### 126. refit_bvh

对当前自碰撞几何刷新 BVH 盒子。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/self_collision/015_refit_bvh.ptx)；[机械还原 CUDA](recover/src/self_collision/synreal__self_collision_kernel__refit_bvh.cu)。
- 规模：PTX 156 行；SASS 308 条；寄存器 30；元数据 atomic 计数 1。
- 细节与边界：刷新和重建不是同一操作。

完整符号签名：

```cpp
synreal::self_collision_kernel::refit_bvh(synreal::Aabb const*, int const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int*, synreal::Aabb*, unsigned long, unsigned long);
```

<a id="lbvh_builder"></a>
## lbvh_builder

### 127. build_escape_nodes

生成无需显式递归栈的后继/逃逸节点。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/lbvh_builder/001_build_escape_nodes.ptx)；[机械还原 CUDA](recover/src/lbvh_builder/synreal__kernel__build_escape_nodes.cu)。
- 规模：PTX 59 行；SASS 24 条；寄存器 8；元数据 atomic 计数 0。
- 细节与边界：沿父链跳过右子，寻找右兄弟；无后继为 −1。

完整符号签名：

```cpp
synreal::kernel::build_escape_nodes(int*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int);
```

### 128. build_primitive_leaf_nodes

建立 primitive ID 到叶子数组槽的映射。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/lbvh_builder/002_build_primitive_leaf_nodes.ptx)；[机械还原 CUDA](recover/src/lbvh_builder/synreal__kernel__build_primitive_leaf_nodes.cu)。
- 规模：PTX 37 行；SASS 16 条；寄存器 7；元数据 atomic 计数 0。
- 细节与边界：leaf[prim_id_i]=i+N−1；不等于堆孩子编号规则。

完整符号签名：

```cpp
synreal::kernel::build_primitive_leaf_nodes(int*, int const*, unsigned int);
```

### 129. build_radix_tree

根据排序 Morton 码公共前缀构造基数树。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/lbvh_builder/003_build_radix_tree.ptx)；[机械还原 CUDA](recover/src/lbvh_builder/synreal__kernel__build_radix_tree.cu)。
- 规模：PTX 277 行；SASS 156 条；寄存器 18；元数据 atomic 计数 0。
- 细节与边界：clz(m_i xor m_j)，同码与边界分支需保留。

完整符号签名：

```cpp
synreal::kernel::build_radix_tree(int*, glm::vec<2, int, (glm::qualifier)0>*, unsigned int const*, unsigned int);
```

### 130. generate_morton_codes

AABB 中心归一化、十位轴量化与 Morton 交错。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/lbvh_builder/004_generate_morton_codes.ptx)；[机械还原 CUDA](recover/src/lbvh_builder/synreal__kernel__generate_morton_codes.cu)。
- 规模：PTX 128 行；SASS 168 条；寄存器 18；元数据 atomic 计数 0。
- 细节与边界：每轴乘 1024；限制到 [0,1)；退化轴有回退。

完整符号签名：

```cpp
synreal::kernel::generate_morton_codes(unsigned int*, synreal::Aabb const*, synreal::Aabb, unsigned int);
```

### 131. refit_aabbs

从子节点回传包围盒并集。

- 原理与公式：[主文对应章节](ALGORITHM_ANALYSIS_ZH.md#s14)。
- 实现入口：[原始 PTX](kernels/lbvh_builder/005_refit_aabbs.ptx)；[机械还原 CUDA](recover/src/lbvh_builder/synreal__kernel__refit_aabbs.cu)。
- 规模：PTX 120 行；SASS 92 条；寄存器 24；元数据 atomic 计数 1。
- 细节与边界：同步/原子语义应以原 PTX 为准。

完整符号签名：

```cpp
synreal::kernel::refit_aabbs(synreal::Aabb*, synreal::Aabb const*, int const*, int const*, glm::vec<2, int, (glm::qualifier)0> const*, unsigned int*, unsigned int);
```

## 本附录没有省略但尚未完成的工作

每个自研入口已列入，但“大 kernel 的完整分支公式”“全部 View 合法输入契约”“所有主机实参配对”尚未全部恢复。需要逐指令复现时，可从上面的 PTX 链接进入；不能将本附录的职责概述当作其完整替代实现。

主文第 23 节列出了尚未确认事项，主文第 21 节说明数值边界、指令语义与验证方法。
