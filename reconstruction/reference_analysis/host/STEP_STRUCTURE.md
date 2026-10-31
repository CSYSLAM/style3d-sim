# `SolverNewton::step` 的循环骨架与每轮 launch

函数区间 `0xfb160`–`0x102a90`，检出回边 160 条、最内层循环 17 个。

> 判定方式：向后跳转即回边，取其 [目标, 跳转] 区间为循环体；每次 launch 归入**最内层**包含它的循环。
>
> **已确认**：外层牛顿循环的计数器是 `rbp-0xb20`，初值取自 `this+0x20`（`config.nonlinear_iterations`）；
> PCG 的迭代上限 `this+0x24`（`config.linear_iterations`）作为实参传给 `solve_newton_system`。详见 `HOST_RECOVERY.md` 1.6。

## 循环 `0xfc290` – `0xfe156`（7878 B）

含 **11 次** launch：

- `0xfc37d` `prepare_cable_tangents`
- `0xfc4b5` `initialize_rhs`
- `0xfc5c9` `evaluate_triangle_drag`
- `0xfc7db` `evaluate_rolling_contact_force`
- `0xfca4d` `evaluate_soft_contact_force`
- `0xfd0c4` `initialize_block_diagonal`
- `0xfd25b` `add_body_spring_gauss_newton_hessian`
- `0xfd3b5` `add_joint_body_point_line_gauss_newton_hessian`
- `0xfd696` `evaluate_soft_contact_force`
- `0xfdfa9` `invert_block_preconditioner`
- `0xfe0aa` `apply_nonlinear_step`

## 循环 `0xfe610` – `0xfef4c`（2364 B）

含 **9 次** launch：

- `0xfe716` `prepare_inverse_preconditioner`
- `0xfe7ed` `update_body_distance_constraint_state`
- `0xfe8ae` `update_hard_contact_duals`
- `0xfe9ca` `update_cable_penalties`
- `0xfeaa8` `evaluate_bending_force`
- `0xfeba7` `evaluate_tetrahedron_force`
- `0xfec6e` `evaluate_stretch_force`
- `0xfed34` `evaluate_spring_force`
- `0xfef12` `update_joint_body_spring_augmented_lagrangian_state`

## 循环 `0xff64f` – `0x1009f9`（5034 B）

含 **9 次** launch：

- `0xff790` `add_rolling_contact_preconditioner`
- `0xff861` `add_surface_contact_preconditioner`
- `0xff922` `add_triangle_drag_preconditioner`
- `0xffa0c` `add_joint_body_point_line_augmented_lagrangian_preconditioner`
- `0xffb33` `add_joint_drive_preconditioner`
- `0xffc55` `add_bending_damping_preconditioner`
- `0xffd35` `add_tetrahedron_preconditioner`
- `0xffe07` `add_affine_body_constitutive_preconditioner`
- `0xffed0` `evaluate_affine_body_constitutive_force`

## 循环 `0xffeeb` – `0x100f61`（4214 B）

含 **19 次** launch：

- `0xfffca` `add_surface_contact_stiffness_scale`
- `0x100069` `evaluate_body_point_line_force`
- `0x1000f0` `evaluate_body_spring_force`
- `0x1001d1` `evaluate_joint_drive_load`
- `0x10025c` `evaluate_joint_armature`
- `0x1002f1` `evaluate_cables`
- `0x1003aa` `add_affine_body_so3_augmented_lagrangian_preconditioner`
- `0x100493` `evaluate_contact_force`
- `0x10054a` `add_affine_body_so3_augmented_lagrangian_preconditioner`
- `0x1006a4` `evaluate_joint_armature`
- `0x10071f` `evaluate_body_distance_constraint_force`
- `0x1007bc` `evaluate_angular_limits`
- `0x100886` `add_cloth_membrane_gauss_newton_hessian`
- `0x100965` `add_spring_gauss_newton_hessian`
- `0x1009ac` `evaluate_surface_contact_force`
- `0x1009ed` `evaluate_hard_contacts`
- `0x100a80` `evaluate_cables`
- `0x100b18` `evaluate_cables`
- `0x100bbc` `evaluate_angular_limits`

## 循环 `0x10175a` – `0x101e81`（1831 B）

含 **5 次** launch：

- `0x1019da` `update_affine_body_so3_augmented_lagrangian_state`
- `0x101ad4` `add_body_point_line_gauss_newton_hessian`
- `0x101d4c` `evaluate_affine_body_spring_force`
- `0x101dc1` `evaluate_affine_body_so3_augmented_lagrangian_force`
- `0x101e78` `update_joint_drive_angle_state`

## 循环 `0x1018ff` – `0x10205f`（1888 B）

含 **6 次** launch：

- `0x101ea9` `snapshot_hard_contacts`
- `0x101f39` `evaluate_joint_body_point_line_augmented_lagrangian_force`
- `0x101fb3` `evaluate_joint_body_spring_augmented_lagrangian_force`
- `0x101fec` `initialize_block_non_diagonal`
- `0x102019` `initialize_hard_contacts`
- `0x10205a` `refresh_inertial_cache_diagonals`

## 循环 `0x10197f` – `0x1021ab`（2092 B）

含 **4 次** launch：

- `0x10209c` `initialize_triangle_drag`
- `0x10210c` `initialize_body_distance_constraint_state`
- `0x102162` `prepare_cable_penalties`
- `0x10219f` `evaluate_hard_contacts`

## 循环 `0x102521` – `0x10294c`（1067 B）

含 **3 次** launch：

- `0x102541` `combine_system_non_diagonal`
- `0x1025d8` `refresh_inertial_cache_nonzeros`
- `0x1026d5` `evaluate_contact_tangent`

## 循环 `0x1027ff` – `0x102a1e`（543 B）

含 **4 次** launch：

- `0x10293b` `initialize_joint_coordinate_velocities`
- `0x102988` `initialize_affine_body_so3_state`
- `0x1029fd` `initialize_joint_body_point_line_state`
- `0x102a19` `initialize_joint_body_spring_state`

## 顶层（循环外，一次）

含 **4 次** launch：

- `0xfbf79` `initialize_step`
- `0xfe2d4` `update_velocity`
- `0xff01c` `update_joint_body_point_line_augmented_lagrangian_state`
- `0xff12c` `add_affine_body_spring_gauss_newton_hessian`

