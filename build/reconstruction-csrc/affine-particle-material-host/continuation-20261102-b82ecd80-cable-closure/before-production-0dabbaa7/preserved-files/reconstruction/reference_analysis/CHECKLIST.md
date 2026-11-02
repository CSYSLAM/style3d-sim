# 源码对照清单

逐行对完就在 `[ ]` 打勾；`PTX` 列是行数，`SASS` 是真实指令数（按 cubin 段大小算）。

## solver_newton.cu（85）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `evaluate_cables` | 11138 | 10,628 |
| [ ] | `evaluate_hard_contacts` | 7099 | 6,064 |
| [ ] | `prepare_cable_tangents` | 5542 | 5,368 |
| [ ] | `build_affine_body_preconditioner<BlockNonZeroEntry>` | 4561 | 4,120 |
| [ ] | `evaluate_contact_tangent` | 4648 | 4,024 |
| [ ] | `build_affine_body_preconditioner<NonZeroEntry>` | 4211 | 4,008 |
| [ ] | `multiply_rolling_contact_tangent` | 4219 | 3,484 |
| [ ] | `update_cable_penalties` | 2512 | 3,444 |
| [ ] | `evaluate_rolling_contact_force` | 4019 | 3,332 |
| [ ] | `multiply_surface_contact_tangent` | 3826 | 3,280 |
| [ ] | `add_rolling_contact_preconditioner` | 3945 | 3,272 |
| [ ] | `add_surface_contact_preconditioner` | 3850 | 3,156 |
| [ ] | `evaluate_surface_contact_force` | 3436 | 2,984 |
| [ ] | `add_surface_contact_stiffness_scale` | 3277 | 2,836 |
| [ ] | `evaluate_contact_force` | 2741 | 2,632 |
| [ ] | `update_hard_contact_duals` | 2096 | 2,188 |
| [ ] | `initialize_hard_contacts` | 2040 | 2,072 |
| [ ] | `evaluate_joint_armature` | 1578 | 2,000 |
| [ ] | `add_body_spring_gauss_newton_hessian` | 1637 | 1,976 |
| [ ] | `evaluate_angular_limits` | 1458 | 1,836 |
| [ ] | `evaluate_soft_contact_force` | 1804 | 1,836 |
| [ ] | `evaluate_joint_drive_load` | 1584 | 1,808 |
| [ ] | `add_joint_body_point_line_gauss_newton_hessian` | 1572 | 1,804 |
| [ ] | `multiply_soft_contact_hessian_off_diagonal` | 1845 | 1,776 |
| [ ] | `multiply_joint_drive_tangent` | 1086 | 1,496 |
| [ ] | `add_joint_drive_preconditioner` | 1188 | 1,344 |
| [ ] | `add_body_point_line_gauss_newton_hessian` | 962 | 1,280 |
| [ ] | `add_affine_body_spring_gauss_newton_hessian` | 1008 | 1,256 |
| [ ] | `add_cloth_membrane_gauss_newton_hessian` | 988 | 1,180 |
| [ ] | `initialize_joint_coordinate_velocities` | 714 | 1,064 |
| [ ] | `add_affine_body_constitutive_preconditioner` | 937 | 916 |
| [ ] | `update_joint_drive_angle_state` | 482 | 804 |
| [ ] | `multiply_affine_body_constitutive_tangent` | 641 | 784 |
| [ ] | `evaluate_affine_body_constitutive_force` | 607 | 772 |
| [ ] | `evaluate_tetrahedron_force` | 673 | 720 |
| [ ] | `update_affine_body_so3_augmented_lagrangian_state` | 506 | 720 |
| [ ] | `add_tetrahedron_preconditioner` | 767 | 676 |
| [ ] | `update_joint_body_point_line_augmented_lagrangian_state` | 483 | 676 |
| [ ] | `evaluate_affine_body_spring_force` | 300 | 648 |
| [ ] | `initialize_affine_body_so3_state` | 399 | 644 |
| [ ] | `evaluate_stretch_force` | 307 | 636 |
| [ ] | `multiply_bending_damping_tangent` | 277 | 616 |
| [ ] | `multiply_tetrahedron_tangent` | 618 | 616 |
| [ ] | `evaluate_body_spring_force` | 394 | 608 |
| [ ] | `add_bending_damping_preconditioner` | 309 | 588 |
| [ ] | `add_spring_gauss_newton_hessian` | 375 | 580 |
| [ ] | `evaluate_body_point_line_force` | 397 | 564 |
| [ ] | `initialize_joint_body_point_line_state` | 382 | 560 |
| [ ] | `evaluate_joint_body_point_line_augmented_lagrangian_force` | 449 | 540 |
| [ ] | `evaluate_bending_force` | 294 | 512 |
| [ ] | `apply_affine_body_preconditioner` | 409 | 500 |
| [ ] | `update_body_distance_constraint_state` | 280 | 476 |
| [ ] | `initialize_step` | 274 | 472 |
| [ ] | `add_joint_body_point_line_augmented_lagrangian_preconditioner` | 465 | 452 |
| [ ] | `refresh_inertial_cache_nonzeros` | 203 | 452 |
| [ ] | `multiply_joint_body_point_line_augmented_lagrangian` | 344 | 448 |
| [ ] | `evaluate_body_distance_constraint_force` | 338 | 440 |
| [ ] | `initialize_body_distance_constraint_state` | 248 | 440 |
| [ ] | `evaluate_joint_body_spring_augmented_lagrangian_force` | 332 | 436 |
| [ ] | `apply_affine_body_torques` | 339 | 428 |
| [ ] | `initialize_rhs` | 383 | 420 |
| [ ] | `add_affine_body_so3_augmented_lagrangian_preconditioner` | 392 | 404 |
| [ ] | `evaluate_triangle_drag` | 192 | 400 |
| [ ] | `initialize_block_non_diagonal` | 103 | 356 |
| [ ] | `initialize_triangle_drag` | 129 | 356 |
| [ ] | `evaluate_spring_force` | 140 | 352 |
| [ ] | `evaluate_affine_body_so3_augmented_lagrangian_force` | 241 | 332 |
| [ ] | `update_joint_body_spring_augmented_lagrangian_state` | 214 | 332 |
| [ ] | `invert_block_preconditioner` | 188 | 304 |
| [ ] | `multiply_affine_body_so3_augmented_lagrangian_tangent` | 200 | 300 |
| [ ] | `multiply_triangle_drag_tangent` | 129 | 260 |
| [ ] | `add_triangle_drag_preconditioner` | 149 | 248 |
| [ ] | `refresh_inertial_cache_diagonals` | 121 | 236 |
| [ ] | `prepare_inverse_preconditioner` | 86 | 212 |
| [ ] | `prepare_cable_penalties` | 159 | 200 |
| [ ] | `snapshot_hard_contacts` | 109 | 192 |
| [ ] | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<BlockNonZeroEntry>, BlockNonZeroEntry>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<BlockNonZeroEntry>, BlockNonZeroEntry>, unsigned long>` | 92 | 76 |
| [ ] | `apply_block_diagonal_preconditioner` | 64 | 48 |
| [ ] | `initialize_block_diagonal` | 63 | 44 |
| [ ] | `apply_nonlinear_step` | 55 | 36 |
| [ ] | `combine_system_non_diagonal` | 87 | 36 |
| [ ] | `update_velocity` | 56 | 36 |
| [ ] | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<NonZeroEntry>, NonZeroEntry>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<NonZeroEntry>, NonZeroEntry>, unsigned long>` | 58 | 32 |
| [ ] | `initialize_joint_body_spring_state` | 34 | 28 |
| [ ] | `reset_selected_joint_drive_state` | 40 | 24 |

## fluid.cu（8）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `multiply_rows` | 823 | 868 |
| [ ] | `accumulate_rows` | 612 | 620 |
| [ ] | `evaluate_rows` | 406 | 440 |
| [ ] | `build_grid` | 172 | 232 |
| [ ] | `bound_scale` | 72 | 160 |
| [ ] | `scale_step` | 71 | 52 |
| [ ] | `add_diagonal` | 69 | 48 |
| [ ] | `initialize_scale` | 32 | 16 |

## granular.cu（8）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `form_bonds` | 742 | 660 |
| [ ] | `multiply_contacts` | 638 | 652 |
| [ ] | `accumulate_contacts` | 490 | 496 |
| [ ] | `accumulate_bonds` | 286 | 340 |
| [ ] | `build_grid` | 149 | 212 |
| [ ] | `commit_bonds` | 97 | 80 |
| [ ] | `multiply_bonds` | 98 | 80 |
| [ ] | `add_diagonal` | 69 | 48 |

## pcg_solver.cu（12）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 383 | 436 |
| [ ] | `evaluate_residual<BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 316 | 412 |
| [ ] | `evaluate_residual<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 322 | 376 |
| [ ] | `multiply_matrix<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` | 311 | 368 |
| [ ] | `evaluate_residual<NonZeroEntry, float>` | 308 | 356 |
| [ ] | `multiply_matrix<NonZeroEntry, float>` | 297 | 352 |
| [ ] | `update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >` | 204 | 188 |
| [ ] | `update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >` | 100 | 136 |
| [ ] | `update_solution_and_residual` | 97 | 124 |
| [ ] | `update_preconditioned_cg_direction` | 83 | 116 |
| [ ] | `update_cg_direction<float>` | 86 | 116 |
| [ ] | `initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >` | 149 | 88 |

## self_collision.cu（16）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `accumulate_edge_face` | 1037 | 1,160 |
| [ ] | `accumulate_edge_edge` | 870 | 868 |
| [ ] | `accumulate_vertex_face` | 762 | 788 |
| [ ] | `query_vertex_face` | 641 | 684 |
| [ ] | `accumulate_particle_pairs` | 447 | 552 |
| [ ] | `query_edge_edge` | 467 | 548 |
| [ ] | `query_particle_pairs` | 428 | 448 |
| [ ] | `query_edge_face` | 441 | 432 |
| [ ] | `refit_bvh` | 156 | 308 |
| [ ] | `multiply_contact_tangents` | 323 | 260 |
| [ ] | `build_triangle_aabbs` | 112 | 236 |
| [ ] | `build_edge_aabbs` | 99 | 216 |
| [ ] | `build_particle_aabbs` | 90 | 216 |
| [ ] | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_cub::__uninitialized_fill::functor<device_ptr<Aabb>, Aabb>, unsigned long>, cuda_cub::__uninitialized_fill::functor<device_ptr<Aabb>, Aabb>, unsigned long>` | 74 | 60 |
| [ ] | `multiply_hessian_diagonal` | 70 | 56 |
| [ ] | `add_hessian_diagonal` | 71 | 48 |

## lbvh_builder.cu（5）

| 对齐 | kernel | PTX | SASS |
|---|---|---|---|
| [ ] | `generate_morton_codes` | 128 | 168 |
| [ ] | `build_radix_tree` | 277 | 156 |
| [ ] | `refit_aabbs` | 120 | 92 |
| [ ] | `build_escape_nodes` | 59 | 24 |
| [ ] | `build_primitive_leaf_nodes` | 37 | 16 |
