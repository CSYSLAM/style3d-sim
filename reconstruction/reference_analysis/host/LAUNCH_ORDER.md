# 主机侧 kernel 发射顺序（从 `SolverNewton::step` 反汇编恢复）

> 内核由**导出的 host wrapper** 发射（`call <synreal::kernel::x(...)@plt>` → `__device_stub__` → `cudaLaunchKernel`）。
> 顺序＝函数体内 call 指令地址顺序；标记 KERNEL 的是发射点，host 是宿主侧成员函数调用。

## SolverNewton::step

`0x00000000000fb160` — 共 86 次调用：**74 次 kernel launch** + 12 次宿主调用（去重目标 79 个）

| # | 调用点 | 类型 | 目标 |
|---|---|---|---|
| 1 | 0xfbf79 | **KERNEL** | `kernel::initialize_step` |
| 2 | 0xfc37d | **KERNEL** | `kernel::prepare_cable_tangents` |
| 3 | 0xfc4b5 | **KERNEL** | `kernel::initialize_rhs` |
| 4 | 0xfc5c9 | **KERNEL** | `kernel::evaluate_triangle_drag` |
| 5 | 0xfc7db | **KERNEL** | `kernel::evaluate_rolling_contact_force` |
| 6 | 0xfca4d | **KERNEL** | `kernel::evaluate_soft_contact_force` |
| 7 | 0xfd0c4 | **KERNEL** | `kernel::initialize_block_diagonal` |
| 8 | 0xfd25b | **KERNEL** | `kernel::add_body_spring_gauss_newton_hessian` |
| 9 | 0xfd3b5 | **KERNEL** | `kernel::add_joint_body_point_line_gauss_newton_hessian` |
| 10 | 0xfd696 | **KERNEL** | `kernel::evaluate_soft_contact_force` |
| 11 | 0xfdfa9 | **KERNEL** | `kernel::invert_block_preconditioner` |
| 12 | 0xfdff6 | host | `SolverNewton::solve_newton_system` |
| 13 | 0xfe029 | host | `Fluid::limit_step` |
| 14 | 0xfe0aa | **KERNEL** | `kernel::apply_nonlinear_step` |
| 15 | 0xfe23f | host | `Granular::commit` |
| 16 | 0xfe2d4 | **KERNEL** | `kernel::update_velocity` |
| 17 | 0xfe672 | host | `SolverNewton::solve_pd_newton_system` |
| 18 | 0xfe716 | **KERNEL** | `kernel::prepare_inverse_preconditioner` |
| 19 | 0xfe7ed | **KERNEL** | `kernel::update_body_distance_constraint_state` |
| 20 | 0xfe8ae | **KERNEL** | `kernel::update_hard_contact_duals` |
| 21 | 0xfe9ca | **KERNEL** | `kernel::update_cable_penalties` |
| 22 | 0xfeaa8 | **KERNEL** | `kernel::evaluate_bending_force` |
| 23 | 0xfeba7 | **KERNEL** | `kernel::evaluate_tetrahedron_force` |
| 24 | 0xfec6e | **KERNEL** | `kernel::evaluate_stretch_force` |
| 25 | 0xfed34 | **KERNEL** | `kernel::evaluate_spring_force` |
| 26 | 0xfed8e | host | `Fluid::accumulate` |
| 27 | 0xfedcf | host | `Granular::accumulate` |
| 28 | 0xfee26 | host | `SelfCollision::accumulate` |
| 29 | 0xfef12 | **KERNEL** | `kernel::update_joint_body_spring_augmented_lagrangian_state` |
| 30 | 0xff01c | **KERNEL** | `kernel::update_joint_body_point_line_augmented_lagrangian_state` |
| 31 | 0xff12c | **KERNEL** | `kernel::add_affine_body_spring_gauss_newton_hessian` |
| 32 | 0xff790 | **KERNEL** | `kernel::add_rolling_contact_preconditioner` |
| 33 | 0xff7d5 | host | `Granular::add_preconditioner` |
| 34 | 0xff861 | **KERNEL** | `kernel::add_surface_contact_preconditioner` |
| 35 | 0xff922 | **KERNEL** | `kernel::add_triangle_drag_preconditioner` |
| 36 | 0xffa0c | **KERNEL** | `kernel::add_joint_body_point_line_augmented_lagrangian_preconditioner` |
| 37 | 0xffb33 | **KERNEL** | `kernel::add_joint_drive_preconditioner` |
| 38 | 0xffb6d | host | `Fluid::add_preconditioner` |
| 39 | 0xffb95 | host | `SelfCollision::add_preconditioner` |
| 40 | 0xffc55 | **KERNEL** | `kernel::add_bending_damping_preconditioner` |
| 41 | 0xffd35 | **KERNEL** | `kernel::add_tetrahedron_preconditioner` |
| 42 | 0xffe07 | **KERNEL** | `kernel::add_affine_body_constitutive_preconditioner` |
| 43 | 0xffed0 | **KERNEL** | `kernel::evaluate_affine_body_constitutive_force` |
| 44 | 0xfffca | **KERNEL** | `kernel::add_surface_contact_stiffness_scale` |
| 45 | 0x100069 | **KERNEL** | `kernel::evaluate_body_point_line_force` |
| 46 | 0x1000f0 | **KERNEL** | `kernel::evaluate_body_spring_force` |
| 47 | 0x1001d1 | **KERNEL** | `kernel::evaluate_joint_drive_load` |
| 48 | 0x10025c | **KERNEL** | `kernel::evaluate_joint_armature` |
| 49 | 0x1002f1 | **KERNEL** | `kernel::evaluate_cables` |
| 50 | 0x1003aa | **KERNEL** | `kernel::add_affine_body_so3_augmented_lagrangian_preconditioner` |
| 51 | 0x100493 | **KERNEL** | `kernel::evaluate_contact_force` |
| 52 | 0x10054a | **KERNEL** | `kernel::add_affine_body_so3_augmented_lagrangian_preconditioner` |
| 53 | 0x1006a4 | **KERNEL** | `kernel::evaluate_joint_armature` |
| 54 | 0x10071f | **KERNEL** | `kernel::evaluate_body_distance_constraint_force` |
| 55 | 0x1007bc | **KERNEL** | `kernel::evaluate_angular_limits` |
| 56 | 0x100886 | **KERNEL** | `kernel::add_cloth_membrane_gauss_newton_hessian` |
| 57 | 0x100965 | **KERNEL** | `kernel::add_spring_gauss_newton_hessian` |
| 58 | 0x1009ac | **KERNEL** | `kernel::evaluate_surface_contact_force` |
| 59 | 0x1009ed | **KERNEL** | `kernel::evaluate_hard_contacts` |
| 60 | 0x100a80 | **KERNEL** | `kernel::evaluate_cables` |
| 61 | 0x100b18 | **KERNEL** | `kernel::evaluate_cables` |
| 62 | 0x100bbc | **KERNEL** | `kernel::evaluate_angular_limits` |
| 63 | 0x101649 | host | `SelfCollision::begin_frame` |
| 64 | 0x101927 | host | `SelfCollision::available` |
| 65 | 0x1019da | **KERNEL** | `kernel::update_affine_body_so3_augmented_lagrangian_state` |
| 66 | 0x101ad4 | **KERNEL** | `kernel::add_body_point_line_gauss_newton_hessian` |
| 67 | 0x101d4c | **KERNEL** | `kernel::evaluate_affine_body_spring_force` |
| 68 | 0x101dc1 | **KERNEL** | `kernel::evaluate_affine_body_so3_augmented_lagrangian_force` |
| 69 | 0x101e78 | **KERNEL** | `kernel::update_joint_drive_angle_state` |
| 70 | 0x101ea9 | **KERNEL** | `kernel::snapshot_hard_contacts` |
| 71 | 0x101f39 | **KERNEL** | `kernel::evaluate_joint_body_point_line_augmented_lagrangian_force` |
| 72 | 0x101fb3 | **KERNEL** | `kernel::evaluate_joint_body_spring_augmented_lagrangian_force` |
| 73 | 0x101fec | **KERNEL** | `kernel::initialize_block_non_diagonal` |
| 74 | 0x102019 | **KERNEL** | `kernel::initialize_hard_contacts` |
| 75 | 0x10205a | **KERNEL** | `kernel::refresh_inertial_cache_diagonals` |
| 76 | 0x10209c | **KERNEL** | `kernel::initialize_triangle_drag` |
| 77 | 0x10210c | **KERNEL** | `kernel::initialize_body_distance_constraint_state` |
| 78 | 0x102162 | **KERNEL** | `kernel::prepare_cable_penalties` |
| 79 | 0x10219f | **KERNEL** | `kernel::evaluate_hard_contacts` |
| 80 | 0x102541 | **KERNEL** | `kernel::combine_system_non_diagonal` |
| 81 | 0x1025d8 | **KERNEL** | `kernel::refresh_inertial_cache_nonzeros` |
| 82 | 0x1026d5 | **KERNEL** | `kernel::evaluate_contact_tangent` |
| 83 | 0x10293b | **KERNEL** | `kernel::initialize_joint_coordinate_velocities` |
| 84 | 0x102988 | **KERNEL** | `kernel::initialize_affine_body_so3_state` |
| 85 | 0x1029fd | **KERNEL** | `kernel::initialize_joint_body_point_line_state` |
| 86 | 0x102a19 | **KERNEL** | `kernel::initialize_joint_body_spring_state` |

## SolverNewton::solve_newton_system

`0x000000000006da70` — 共 0 次调用：**0 次 kernel launch** + 0 次宿主调用（去重目标 0 个）

| # | 调用点 | 类型 | 目标 |
|---|---|---|---|

## SolverNewton::solve_pd_newton_system

`0x000000000006cc60` — 共 0 次调用：**0 次 kernel launch** + 0 次宿主调用（去重目标 0 个）

| # | 调用点 | 类型 | 目标 |
|---|---|---|---|

## SolverNewton::precompute_matrices

`0x000000000006d940` — 共 0 次调用：**0 次 kernel launch** + 0 次宿主调用（去重目标 0 个）

| # | 调用点 | 类型 | 目标 |
|---|---|---|---|

