# 运行时反推的字段偏移（`Config` / `Model` / `State` / `Contact` / `Control`）

> 方法：取 `shared_ptr` holder 指向的 C++ 对象地址 → 快照 → 逐属性写多个极端值 → 内存 diff。
> 偏移已按类型对齐回字段起点；宽度是"观测到的变化字节数"，float 通常 4、bool 1、Span 16。

## Config（32 个可写字段，推断 sizeof ≈ 0x80）

> 一致性：全部对齐且无重叠 ✅

| 偏移 | 宽度 | 类型 | 字段 |
|---|---|---|---|
| +0x004 | 4 | float | `constraint_alpha` |
| +0x00c | 4 | int | `joint_constraint_primal_iterations` |
| +0x010 | 4 | int | `affine_body_rigidity_primal_iterations` |
| +0x014 | 1 | bool | `affine_body_block_preconditioner` |
| +0x015 | 1 | bool | `affine_body_contact_block_preconditioner` |
| +0x018 | 4 | int | `nonlinear_iterations` |
| +0x01c | 4 | int | `linear_iterations` |
| +0x020 | 4 | float | `fluid_relaxation` |
| +0x024 | 4 | float | `fluid_max_step_ratio` |
| +0x028 | 4 | float | `air_density` |
| +0x02c | 12 | tuple | `wind_velocity` |
| +0x038 | 1 | bool | `enable_self_collision` |
| +0x039 | 1 | bool | `enable_collision_hessian_non_diagonal` |
| +0x03c | 4 | float | `rolling_friction_velocity_epsilon` |
| +0x040 | 4 | float | `rigid_contact_friction_epsilon` |
| +0x044 | 1 | bool | `rigid_contact_hard` |
| +0x045 | 1 | bool | `rigid_contact_history` |
| +0x046 | 1 | bool | `rigid_contact_sliding_tangent` |
| +0x048 | 4 | float | `rigid_contact_alpha` |
| +0x04c | 4 | float | `rigid_contact_beta` |
| +0x050 | 4 | float | `rigid_contact_gamma` |
| +0x054 | 4 | float | `rigid_contact_k_start` |
| +0x058 | 4 | float | `cable_linear_beta` |
| +0x05c | 4 | float | `cable_angular_beta` |
| +0x060 | 4 | float | `cable_penalty_gamma` |
| +0x064 | 4 | float | `cable_linear_k_start` |
| +0x068 | 4 | float | `cable_angular_k_start` |
| +0x06c | 4 | float | `self_collision_radius` |
| +0x070 | 4 | float | `self_collision_vertex_face_stiffness` |
| +0x074 | 4 | float | `self_collision_edge_edge_stiffness` |
| +0x078 | 4 | float | `self_collision_edge_face_stiffness` |
| +0x07c | 4 | float | `self_collision_particle_particle_stiffness` |

## Model（51 个可写字段，推断 sizeof ≈ 0x200）

> 一致性：全部对齐且无重叠 ✅

| 偏移 | 宽度 | 类型 | 字段 |
|---|---|---|---|
| +0x000 | 4 | int | `world_count` |
| +0x008 | 16 | Span | `gravity` |
| +0x018 | 4 | int | `particle_count` |
| +0x01c | 4 | int | `particle_state_count` |
| +0x020 | 16 | Span | `particle_indices` |
| +0x030 | 16 | Span | `particle_masses` |
| +0x040 | 4 | int | `particle_mass_non_diagonal_count` |
| +0x048 | 16 | Span | `particle_mass_non_diagonal_indices` |
| +0x058 | 16 | Span | `particle_mass_non_diagonal_values` |
| +0x068 | 16 | Span | `particle_flags` |
| +0x078 | 16 | Span | `particle_world` |
| +0x088 | 16 | Span | `particle_radii` |
| +0x098 | 16 | Span | `particle_rest_positions` |
| +0x0a8 | 4 | int | `collision_particle_count` |
| +0x0b0 | 16 | Span | `collision_particle_indices` |
| +0x0c0 | 4 | int | `fluid_particle_count` |
| +0x0c8 | 16 | Span | `fluid_particle_indices` |
| +0x0d8 | 4 | float | `fluid_rest_density` |
| +0x0dc | 4 | float | `fluid_smoothing_radius` |
| +0x0e0 | 4 | float | `fluid_bulk_modulus` |
| +0x0e4 | 4 | float | `fluid_viscosity` |
| +0x0e8 | 4 | int | `fluid_boundary_count` |
| +0x0f0 | 16 | Span | `fluid_boundary_positions` |
| +0x100 | 16 | Span | `fluid_boundary_volumes` |
| +0x110 | 4 | int | `granular_particle_count` |
| +0x118 | 16 | Span | `granular_particle_indices` |
| +0x128 | 4 | float | `granular_contact_stiffness` |
| +0x12c | 4 | float | `granular_friction` |
| +0x130 | 4 | float | `granular_friction_damping` |
| +0x134 | 4 | float | `granular_cohesion` |
| +0x138 | 4 | float | `granular_bond_damping` |
| +0x13c | 4 | float | `granular_yield_strain` |
| +0x140 | 4 | float | `granular_max_compaction` |
| +0x144 | 4 | float | `granular_break_strain` |
| +0x148 | 4 | float | `granular_adhesion` |
| +0x14c | 4 | float | `granular_bond_formation_gap` |
| +0x150 | 4 | float | `granular_bond_formation_speed` |
| +0x154 | 4 | int | `granular_max_dynamic_bonds` |
| +0x158 | 4 | int | `granular_bond_count` |
| +0x160 | 16 | Span | `granular_bond_indices` |
| +0x170 | 16 | Span | `granular_bond_rest_lengths` |
| +0x180 | 4 | int | `collision_triangle_count` |
| +0x188 | 16 | Span | `collision_triangle_indices` |
| +0x198 | 4 | int | `collision_edge_count` |
| +0x1a0 | 16 | Span | `collision_edge_indices` |
| +0x1b0 | 4 | int | `spring_count` |
| +0x1b8 | 16 | Span | `spring_indices` |
| +0x1c8 | 16 | Span | `spring_stiffnesses` |
| +0x1d8 | 16 | Span | `spring_rest_lengths` |
| +0x1e8 | 4 | int | `triangle_count` |
| +0x1f0 | 16 | Span | `triangle_indices` |

## State（3 个可写字段，推断 sizeof ≈ 0x30）

> 一致性：全部对齐且无重叠 ✅

| 偏移 | 宽度 | 类型 | 字段 |
|---|---|---|---|
| +0x000 | 16 | Span | `particle_q` |
| +0x010 | 16 | Span | `particle_qd` |
| +0x020 | 16 | Span | `particle_f` |

## Contact（23 个可写字段，推断 sizeof ≈ 0x158）

> 一致性：全部对齐且无重叠 ✅

| 偏移 | 宽度 | 类型 | 字段 |
|---|---|---|---|
| +0x000 | 16 | Span | `count` |
| +0x010 | 4 | int | `max_count` |
| +0x018 | 16 | Span | `shape0` |
| +0x028 | 16 | Span | `shape1` |
| +0x038 | 16 | Span | `point0` |
| +0x048 | 16 | Span | `point1` |
| +0x058 | 16 | Span | `offset0` |
| +0x068 | 16 | Span | `offset1` |
| +0x078 | 16 | Span | `normal` |
| +0x088 | 16 | Span | `margin0` |
| +0x098 | 16 | Span | `margin1` |
| +0x0a8 | 16 | Span | `match_index` |
| +0x0b8 | 1 | bool | `history_refresh` |
| +0x0c0 | 16 | Span | `soft_count` |
| +0x0d0 | 4 | int | `soft_max_count` |
| +0x0d8 | 16 | Span | `soft_particle` |
| +0x0e8 | 16 | Span | `soft_shape` |
| +0x0f8 | 16 | Span | `soft_body_pos` |
| +0x108 | 16 | Span | `soft_body_vel` |
| +0x118 | 16 | Span | `soft_normal` |
| +0x128 | 16 | Span | `soft_indices` |
| +0x138 | 16 | Span | `soft_barycentric` |
| +0x148 | 16 | Span | `soft_particle_only_shapes` |

## Control（5 个可写字段，推断 sizeof ≈ 0x50）

> 一致性：全部对齐且无重叠 ✅

| 偏移 | 宽度 | 类型 | 字段 |
|---|---|---|---|
| +0x000 | 16 | Span | `joint_f` |
| +0x010 | 16 | Span | `joint_target_q` |
| +0x020 | 16 | Span | `joint_target_qd` |
| +0x030 | 16 | Span | `joint_drive_velocities` |
| +0x040 | 16 | Span | `tetrahedron_activations` |

