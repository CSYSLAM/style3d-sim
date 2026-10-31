# CUDA kernel 全量清单

> 表中出现的 `solver_newton.cu` / `fluid.cu` 等是**目标项目原始源文件名**（由符号与 PTX 注释恢复的归属），
> 不是本目录内的文件；本仓库只有拆出来的 `kernels/<模块>/*.ptx`。

从 `.nv_fatbin` 的 6 份 PTX 中提取，共 **206 个 entry**，其中 mangled 名含 `synreal::` 的 **134 个**——但其中 3 个是 `synreal::…::_kernel_agent` 形式（实为 thrust 的 `_kernel_agent`），**真正的自研 kernel 是 131 个**；其余为 thrust/cub 实例（`DeviceRadixSort*`、`_kernel_agent<...>` 等），单独列出便于排除。

每个 kernel 的完整 PTX：`_re_analysis/kernels/<模块>/NNN_<名>.ptx`（文件头带签名/原型/maxntid/ptxas 资源/指令计数）。

`体量` 按 SASS 指令数分档（☆☆☆☆ <200，★☆☆☆ <800，★★☆☆ <2500，★★★☆ <5000，★★★★ ≥5000）——★越多越值得先对公式、后对细节。

## 总览

| 源文件 | entry | 自研 | SASS 指令合计 | 最大单 kernel |
|---|---|---|---|---|
| `solver_newton.cu` | 97 | 85 | 110,952 | 10,628 |
| `fluid.cu` | 15 | 8 | 2,696 | 868 |
| `granular.cu` | 24 | 8 | 3,180 | 660 |
| `pcg_solver.cu` | 20 | 12 | 5,928 | 1,100 |
| `self_collision.cu` | 21 | 16 | 7,044 | 1,160 |
| `lbvh_builder.cu` | 29 | 5 | 22,116 | 3,428 |
| **合计** | **206** | **134** | **151,916** | |

## `solver_newton.cu` — 85 个自研 kernel + 12 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `evaluate_cables` | 10,628 | 11138 | 252 | - | atomic×12, div×164, sqrt×52, local数组 | ★★★★ |
| 2 | `evaluate_hard_contacts` | 6,064 | 7099 | 80 | - | atomic×211, div×34, sqrt×17, local数组 | ★★★★ |
| 3 | `prepare_cable_tangents` | 5,368 | 5542 | 252 | - | div×82, sqrt×26, local数组 | ★★★★ |
| 4 | `build_affine_body_preconditioner<BlockNonZeroEntry>` | 4,120 | 4561 | 158 | - | div×35, sqrt×24, local数组 | ★★★☆ |
| 5 | `evaluate_contact_tangent` | 4,024 | 4648 | 77 | - | atomic×75, div×30, sqrt×17, local数组 | ★★★☆ |
| 6 | `build_affine_body_preconditioner<NonZeroEntry>` | 4,008 | 4211 | 158 | - | div×35, sqrt×24, local数组 | ★★★☆ |
| 7 | `multiply_rolling_contact_tangent` | 3,484 | 4219 | 135 | - | atomic×15, div×31, sqrt×18, local数组 | ★★★☆ |
| 8 | `update_cable_penalties` | 3,444 | 2512 | 116 | - | div×40, sqrt×22, local数组 | ★★★☆ |
| 9 | `evaluate_rolling_contact_force` | 3,332 | 4019 | 135 | - | atomic×15, div×31, sqrt×18, local数组 | ★★★☆ |
| 10 | `multiply_surface_contact_tangent` | 3,280 | 3826 | 116 | - | atomic×42, div×22, sqrt×10, local数组 | ★★★☆ |
| 11 | `add_rolling_contact_preconditioner` | 3,272 | 3945 | 134 | - | atomic×9, div×31, sqrt×18, local数组 | ★★★☆ |
| 12 | `add_surface_contact_preconditioner` | 3,156 | 3850 | 116 | - | atomic×126, div×22, sqrt×10, local数组 | ★★★☆ |
| 13 | `evaluate_surface_contact_force` | 2,984 | 3436 | 120 | - | atomic×42, div×22, sqrt×10, local数组 | ★★★☆ |
| 14 | `add_surface_contact_stiffness_scale` | 2,836 | 3277 | 116 | - | atomic×7, div×22, sqrt×10, local数组 | ★★★☆ |
| 15 | `evaluate_contact_force` | 2,632 | 2741 | 71 | - | atomic×96, div×30, sqrt×16 | ★★★☆ |
| 16 | `update_hard_contact_duals` | 2,188 | 2096 | 61 | - | div×30, sqrt×17 | ★★☆☆ |
| 17 | `initialize_hard_contacts` | 2,072 | 2040 | 60 | - | div×29, sqrt×15 | ★★☆☆ |
| 18 | `evaluate_joint_armature` | 2,000 | 1578 | 102 | - | atomic×96, div×48, sqrt×8 | ★★☆☆ |
| 19 | `add_body_spring_gauss_newton_hessian` | 1,976 | 1637 | 62 | - | atomic×261, div×4, sqrt×1, local数组 | ★★☆☆ |
| 20 | `evaluate_angular_limits` | 1,836 | 1458 | 98 | - | atomic×96, div×38, sqrt×6 | ★★☆☆ |
| 21 | `evaluate_soft_contact_force` | 1,836 | 1804 | 60 | - | atomic×63, div×17, sqrt×10, local数组 | ★★☆☆ |
| 22 | `evaluate_joint_drive_load` | 1,808 | 1584 | 103 | - | atomic×60, div×47, sqrt×9 | ★★☆☆ |
| 23 | `add_joint_body_point_line_gauss_newton_hessian` | 1,804 | 1572 | 60 | - | atomic×261, local数组 | ★★☆☆ |
| 24 | `multiply_soft_contact_hessian_off_diagonal` | 1,776 | 1845 | 90 | - | atomic×30, div×17, sqrt×10 | ★★☆☆ |
| 25 | `multiply_joint_drive_tangent` | 1,496 | 1086 | 78 | - | atomic×72, div×32, sqrt×4 | ★★☆☆ |
| 26 | `add_joint_drive_preconditioner` | 1,344 | 1188 | 67 | - | atomic×144, div×32, sqrt×4 | ★★☆☆ |
| 27 | `add_body_point_line_gauss_newton_hessian` | 1,280 | 962 | 61 | - | atomic×45, div×25, local数组 | ★★☆☆ |
| 28 | `add_affine_body_spring_gauss_newton_hessian` | 1,256 | 1008 | 32 | - | atomic×135, div×17, sqrt×5, local数组 | ★★☆☆ |
| 29 | `add_cloth_membrane_gauss_newton_hessian` | 1,180 | 988 | 77 | - | atomic×54, div×24, sqrt×4, local数组 | ★★☆☆ |
| 30 | `initialize_joint_coordinate_velocities` | 1,064 | 714 | 74 | - | div×32, sqrt×4 | ★★☆☆ |
| 31 | `add_affine_body_constitutive_preconditioner` | 916 | 937 | 91 | - | atomic×9, div×10, sqrt×6, local数组 | ★★☆☆ |
| 32 | `update_joint_drive_angle_state` | 804 | 482 | 47 | - | div×11, sqrt×3 | ★★☆☆ |
| 33 | `multiply_affine_body_constitutive_tangent` | 784 | 641 | 46 | - | atomic×12, div×10, sqrt×6 | ★☆☆☆ |
| 34 | `evaluate_affine_body_constitutive_force` | 772 | 607 | 46 | - | atomic×12, div×10, sqrt×6 | ★☆☆☆ |
| 35 | `evaluate_tetrahedron_force` | 720 | 673 | 56 | - | atomic×12, div×1 | ★☆☆☆ |
| 36 | `update_affine_body_so3_augmented_lagrangian_state` | 720 | 506 | 39 | - | div×10, sqrt×6 | ★☆☆☆ |
| 37 | `add_tetrahedron_preconditioner` | 676 | 767 | 64 | - | atomic×36 | ★☆☆☆ |
| 38 | `update_joint_body_point_line_augmented_lagrangian_state` | 676 | 483 | 46 | - | div×14 | ★☆☆☆ |
| 39 | `evaluate_affine_body_spring_force` | 648 | 300 | 42 | - | atomic×12, div×18, sqrt×6 | ★☆☆☆ |
| 40 | `initialize_affine_body_so3_state` | 644 | 399 | 29 | - | div×10, sqrt×6 | ★☆☆☆ |
| 41 | `evaluate_stretch_force` | 636 | 307 | 45 | - | atomic×9, div×18, sqrt×4 | ★☆☆☆ |
| 42 | `multiply_bending_damping_tangent` | 616 | 277 | 38 | - | atomic×12, div×4, sqrt×1 | ★☆☆☆ |
| 43 | `multiply_tetrahedron_tangent` | 616 | 618 | 56 | - | atomic×12 | ★☆☆☆ |
| 44 | `evaluate_body_spring_force` | 608 | 394 | 40 | - | atomic×24, div×3, sqrt×1 | ★☆☆☆ |
| 45 | `add_bending_damping_preconditioner` | 588 | 309 | 35 | - | atomic×36, div×4, sqrt×1 | ★☆☆☆ |
| 46 | `add_spring_gauss_newton_hessian` | 580 | 375 | 28 | - | atomic×54, div×4, sqrt×1 | ★☆☆☆ |
| 47 | `evaluate_body_point_line_force` | 564 | 397 | 48 | - | atomic×24, div×1 | ★☆☆☆ |
| 48 | `initialize_joint_body_point_line_state` | 560 | 382 | 40 | - | div×7 | ★☆☆☆ |
| 49 | `evaluate_joint_body_point_line_augmented_lagrangian_force` | 540 | 449 | 48 | - | atomic×24 | ★☆☆☆ |
| 50 | `evaluate_bending_force` | 512 | 294 | 40 | - | atomic×12, div×4, sqrt×1 | ★☆☆☆ |
| 51 | `apply_affine_body_preconditioner` | 500 | 409 | 32 | - | - | ★☆☆☆ |
| 52 | `update_body_distance_constraint_state` | 476 | 280 | 32 | - | div×2, sqrt×2 | ★☆☆☆ |
| 53 | `initialize_step` | 472 | 274 | 30 | - | div×1 | ★☆☆☆ |
| 54 | `add_joint_body_point_line_augmented_lagrangian_preconditioner` | 452 | 465 | 40 | - | atomic×72 | ★☆☆☆ |
| 55 | `refresh_inertial_cache_nonzeros` | 452 | 203 | 32 | - | - | ★☆☆☆ |
| 56 | `multiply_joint_body_point_line_augmented_lagrangian` | 448 | 344 | 40 | - | atomic×24 | ★☆☆☆ |
| 57 | `evaluate_body_distance_constraint_force` | 440 | 338 | 32 | - | atomic×24 | ★☆☆☆ |
| 58 | `initialize_body_distance_constraint_state` | 440 | 248 | 32 | - | div×1, sqrt×1 | ★☆☆☆ |
| 59 | `evaluate_joint_body_spring_augmented_lagrangian_force` | 436 | 332 | 32 | - | atomic×24 | ★☆☆☆ |
| 60 | `apply_affine_body_torques` | 428 | 339 | 40 | - | atomic×12 | ★☆☆☆ |
| 61 | `initialize_rhs` | 420 | 383 | 31 | - | - | ★☆☆☆ |
| 62 | `add_affine_body_so3_augmented_lagrangian_preconditioner` | 404 | 392 | 32 | - | atomic×27 | ★☆☆☆ |
| 63 | `evaluate_triangle_drag` | 400 | 192 | 32 | - | atomic×9, div×3 | ★☆☆☆ |
| 64 | `initialize_block_non_diagonal` | 356 | 103 | 21 | - | - | ★☆☆☆ |
| 65 | `initialize_triangle_drag` | 356 | 129 | 20 | - | div×3, sqrt×1 | ★☆☆☆ |
| 66 | `evaluate_spring_force` | 352 | 140 | 23 | - | atomic×6, div×3, sqrt×1 | ★☆☆☆ |
| 67 | `evaluate_affine_body_so3_augmented_lagrangian_force` | 332 | 241 | 32 | - | atomic×12 | ★☆☆☆ |
| 68 | `update_joint_body_spring_augmented_lagrangian_state` | 332 | 214 | 32 | - | - | ★☆☆☆ |
| 69 | `invert_block_preconditioner` | 304 | 188 | 22 | - | - | ★☆☆☆ |
| 70 | `multiply_affine_body_so3_augmented_lagrangian_tangent` | 300 | 200 | 32 | - | atomic×9 | ★☆☆☆ |
| 71 | `multiply_triangle_drag_tangent` | 260 | 129 | 27 | - | atomic×9 | ★☆☆☆ |
| 72 | `add_triangle_drag_preconditioner` | 248 | 149 | 21 | - | atomic×27 | ★☆☆☆ |
| 73 | `refresh_inertial_cache_diagonals` | 236 | 121 | 32 | - | - | ★☆☆☆ |
| 74 | `prepare_inverse_preconditioner` | 212 | 86 | 20 | - | - | ★☆☆☆ |
| 75 | `prepare_cable_penalties` | 200 | 159 | 20 | - | - | ★☆☆☆ |
| 76 | `snapshot_hard_contacts` | 192 | 109 | 18 | - | div×3, sqrt×1 | ☆☆☆☆ |
| 77 | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<BlockNonZeroEntry>, BlockNonZeroEntry>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<BlockNonZeroEntry>, BlockNonZeroEntry>, unsigned long>` | 76 | 92 | 13 | 256, 1, 1 | - | ☆☆☆☆ |
| 78 | `apply_block_diagonal_preconditioner` | 48 | 64 | 19 | - | - | ☆☆☆☆ |
| 79 | `initialize_block_diagonal` | 44 | 63 | 12 | - | - | ☆☆☆☆ |
| 80 | `apply_nonlinear_step` | 36 | 55 | 13 | - | - | ☆☆☆☆ |
| 81 | `combine_system_non_diagonal` | 36 | 87 | 18 | - | - | ☆☆☆☆ |
| 82 | `update_velocity` | 36 | 56 | 13 | - | - | ☆☆☆☆ |
| 83 | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<NonZeroEntry>, NonZeroEntry>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<NonZeroEntry>, NonZeroEntry>, unsigned long>` | 32 | 58 | 7 | 256, 1, 1 | - | ☆☆☆☆ |
| 84 | `initialize_joint_body_spring_state` | 28 | 34 | 9 | - | - | ☆☆☆☆ |
| 85 | `reset_selected_joint_drive_state` | 24 | 40 | 8 | - | - | ☆☆☆☆ |

<details><summary>第三方实例 12 个（点击展开）</summary>

- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 40
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>

## `fluid.cu` — 8 个自研 kernel + 7 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `multiply_rows` | 868 | 823 | 50 | - | atomic×18, div×10 | ★★☆☆ |
| 2 | `accumulate_rows` | 620 | 612 | 54 | - | atomic×84, div×6 | ★☆☆☆ |
| 3 | `evaluate_rows` | 440 | 406 | 52 | - | div×7 | ★☆☆☆ |
| 4 | `build_grid` | 232 | 172 | 22 | - | atomic×1, div×4 | ★☆☆☆ |
| 5 | `bound_scale` | 160 | 72 | 12 | - | atomic×1, div×1, sqrt×1 | ☆☆☆☆ |
| 6 | `scale_step` | 52 | 71 | 10 | - | - | ☆☆☆☆ |
| 7 | `add_diagonal` | 48 | 69 | 11 | - | - | ☆☆☆☆ |
| 8 | `initialize_scale` | 16 | 32 | 4 | - | - | ☆☆☆☆ |

<details><summary>第三方实例 7 个（点击展开）</summary>

- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 40
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>

## `granular.cu` — 8 个自研 kernel + 16 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `form_bonds` | 660 | 742 | 48 | - | sqrt×1 | ★☆☆☆ |
| 2 | `multiply_contacts` | 652 | 638 | 48 | - | div×5, sqrt×3 | ★☆☆☆ |
| 3 | `accumulate_contacts` | 496 | 490 | 60 | - | div×5, sqrt×3 | ★☆☆☆ |
| 4 | `accumulate_bonds` | 340 | 286 | 30 | - | atomic×24, div×5, sqrt×2 | ★☆☆☆ |
| 5 | `build_grid` | 212 | 149 | 22 | - | atomic×1, div×3 | ★☆☆☆ |
| 6 | `commit_bonds` | 80 | 97 | 17 | - | sqrt×1 | ☆☆☆☆ |
| 7 | `multiply_bonds` | 80 | 98 | 28 | - | atomic×6 | ☆☆☆☆ |
| 8 | `add_diagonal` | 48 | 69 | 11 | - | - | ☆☆☆☆ |

<details><summary>第三方实例 16 个（点击展开）</summary>

- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 40
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 32
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 32
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 32
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>

## `pcg_solver.cu` — 12 个自研 kernel + 8 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 436 | 383 | 32 | - | bar×1 | ★☆☆☆ |
| 2 | `evaluate_residual<BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 412 | 316 | 32 | - | - | ★☆☆☆ |
| 3 | `evaluate_residual<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 376 | 322 | 29 | - | - | ★☆☆☆ |
| 4 | `multiply_matrix<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 368 | 311 | 29 | - | - | ★☆☆☆ |
| 5 | `evaluate_residual<NonZeroEntry, float>` | 356 | 308 | 29 | - | - | ★☆☆☆ |
| 6 | `multiply_matrix<NonZeroEntry, float>` | 352 | 297 | 29 | - | - | ★☆☆☆ |
| 7 | `update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >` | 188 | 204 | 23 | - | div×1, bar×1 | ☆☆☆☆ |
| 8 | `update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >` | 136 | 100 | 19 | - | div×1 | ☆☆☆☆ |
| 9 | `update_solution_and_residual` | 124 | 97 | 20 | - | div×1 | ☆☆☆☆ |
| 10 | `update_preconditioned_cg_direction` | 116 | 83 | 16 | - | div×1 | ☆☆☆☆ |
| 11 | `update_cg_direction<float>` | 116 | 86 | 16 | - | div×1 | ☆☆☆☆ |
| 12 | `initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >` | 88 | 149 | 20 | - | bar×1 | ☆☆☆☆ |

<details><summary>第三方实例 8 个（点击展开）</summary>

- `CUB_200302_520_NS::DeviceReduceKernel<CUB_200302_520_NS::DeviceReducePolicy<float, unsigned int, cuda::std::__4::plus<vo` — SASS 1100
- `CUB_200302_520_NS::DeviceReduceSingleTileKernel<CUB_200302_520_NS::DeviceReducePolicy<float, unsigned int, cuda::std::__` — SASS 928
- `CUB_200302_520_NS::DeviceReduceSingleTileKernel<CUB_200302_520_NS::DeviceReducePolicy<float, unsigned int, cuda::std::__` — SASS 704
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 44
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 24
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>

## `self_collision.cu` — 16 个自研 kernel + 5 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `accumulate_edge_face` | 1,160 | 1037 | 95 | - | atomic×61, div×27, sqrt×5 | ★★☆☆ |
| 2 | `accumulate_edge_edge` | 868 | 870 | 81 | - | atomic×49, div×12, sqrt×3 | ★★☆☆ |
| 3 | `accumulate_vertex_face` | 788 | 762 | 65 | - | atomic×49, div×7, sqrt×1 | ★☆☆☆ |
| 4 | `query_vertex_face` | 684 | 641 | 53 | - | div×6 | ★☆☆☆ |
| 5 | `accumulate_particle_pairs` | 552 | 447 | 48 | - | atomic×25, div×6, sqrt×1 | ★☆☆☆ |
| 6 | `query_edge_edge` | 548 | 467 | 55 | - | div×6 | ★☆☆☆ |
| 7 | `query_particle_pairs` | 448 | 428 | 37 | - | - | ★☆☆☆ |
| 8 | `query_edge_face` | 432 | 441 | 32 | - | - | ★☆☆☆ |
| 9 | `refit_bvh` | 308 | 156 | 30 | - | atomic×1 | ★☆☆☆ |
| 10 | `multiply_contact_tangents` | 260 | 323 | 32 | - | atomic×21, local数组 | ★☆☆☆ |
| 11 | `build_triangle_aabbs` | 236 | 112 | 22 | - | - | ★☆☆☆ |
| 12 | `build_edge_aabbs` | 216 | 99 | 20 | - | - | ★☆☆☆ |
| 13 | `build_particle_aabbs` | 216 | 90 | 20 | - | - | ★☆☆☆ |
| 14 | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<Aabb>, Aabb>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<Aabb>, Aabb>, unsigned long>` | 60 | 74 | 12 | 256, 1, 1 | - | ☆☆☆☆ |
| 15 | `multiply_hessian_diagonal` | 56 | 70 | 23 | - | - | ☆☆☆☆ |
| 16 | `add_hessian_diagonal` | 48 | 71 | 23 | - | - | ☆☆☆☆ |

<details><summary>第三方实例 5 个（点击展开）</summary>

- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 72
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 32
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>

## `lbvh_builder.cu` — 5 个自研 kernel + 24 个第三方实例

| # | kernel | SASS | PTX 行 | REG | maxntid | 关键特征 | 体量 |
|---|---|---|---|---|---|---|---|
| 1 | `generate_morton_codes` | 168 | 128 | 18 | - | div×3 | ☆☆☆☆ |
| 2 | `build_radix_tree` | 156 | 277 | 18 | - | - | ☆☆☆☆ |
| 3 | `refit_aabbs` | 92 | 120 | 24 | - | atomic×1 | ☆☆☆☆ |
| 4 | `build_escape_nodes` | 24 | 59 | 8 | - | - | ☆☆☆☆ |
| 5 | `build_primitive_leaf_nodes` | 16 | 37 | 7 | - | - | ☆☆☆☆ |

<details><summary>第三方实例 24 个（点击展开）</summary>

- `CUB_200302_520_NS::DeviceRadixSortDownsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned i` — SASS 3428
- `CUB_200302_520_NS::DeviceRadixSortDownsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, u` — SASS 3428
- `CUB_200302_520_NS::DeviceRadixSortOnesweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned in` — SASS 2160
- `CUB_200302_520_NS::DeviceRadixSortOnesweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, un` — SASS 2160
- `CUB_200302_520_NS::DeviceRadixSortDownsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned i` — SASS 1752
- `CUB_200302_520_NS::DeviceRadixSortDownsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, u` — SASS 1752
- `CUB_200302_520_NS::DeviceRadixSortUpsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned int` — SASS 1224
- `CUB_200302_520_NS::DeviceRadixSortUpsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, uns` — SASS 1224
- `CUB_200302_520_NS::DeviceRadixSortUpsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned int` — SASS 744
- `CUB_200302_520_NS::DeviceRadixSortUpsweepKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, uns` — SASS 744
- `CUB_200302_520_NS::DeviceRadixSortSingleTileKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned ` — SASS 552
- `CUB_200302_520_NS::DeviceRadixSortSingleTileKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, ` — SASS 552
- `CUB_200302_520_NS::RadixSortScanBinsKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned int>::Po` — SASS 476
- `CUB_200302_520_NS::RadixSortScanBinsKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, unsigned` — SASS 476
- `CUB_200302_520_NS::DeviceRadixSortHistogramKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigned i` — SASS 360
- `CUB_200302_520_NS::DeviceRadixSortHistogramKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int, u` — SASS 360
- `CUB_200302_520_NS::DeviceRadixSortExclusiveSumKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, int, unsigne` — SASS 56
- `CUB_200302_520_NS::DeviceRadixSortExclusiveSumKernel<CUB_200302_520_NS::DeviceRadixSortPolicy<unsigned int, unsigned int` — SASS 56
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__tabulate::functor<device_ptr<int>, ` — SASS 36
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 32
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__fill::functor<detail::normal_iterat` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_` — SASS 28
- `CUB_200302_520_NS::EmptyKernel<void>` — SASS 4

</details>
