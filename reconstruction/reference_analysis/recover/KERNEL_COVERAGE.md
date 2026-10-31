# kernel 还原覆盖表

总计 **134** 个自研 kernel。

## ✅ 已还原为可读 C++ —— 39 个 / 6,800 SASS 指令

| SASS | PTX | 模块 | kernel |
|---|---|---|---|
| 452 | 203 | `solver_newton.cu` | `refresh_inertial_cache_nonzeros` |
| 436 | 383 | `pcg_solver.cu` | `multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat<3, 3, float, (glm` |
| 420 | 383 | `solver_newton.cu` | `initialize_rhs` |
| 412 | 316 | `pcg_solver.cu` | `evaluate_residual<BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> ` |
| 376 | 322 | `pcg_solver.cu` | `evaluate_residual<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` |
| 368 | 311 | `pcg_solver.cu` | `multiply_matrix<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >` |
| 356 | 308 | `pcg_solver.cu` | `evaluate_residual<NonZeroEntry, float>` |
| 356 | 103 | `solver_newton.cu` | `initialize_block_non_diagonal` |
| 352 | 297 | `pcg_solver.cu` | `multiply_matrix<NonZeroEntry, float>` |
| 352 | 140 | `solver_newton.cu` | `evaluate_spring_force` |
| 304 | 188 | `solver_newton.cu` | `invert_block_preconditioner` |
| 248 | 149 | `solver_newton.cu` | `add_triangle_drag_preconditioner` |
| 236 | 121 | `solver_newton.cu` | `refresh_inertial_cache_diagonals` |
| 216 | 99 | `self_collision.cu` | `build_edge_aabbs` |
| 216 | 90 | `self_collision.cu` | `build_particle_aabbs` |
| 212 | 86 | `solver_newton.cu` | `prepare_inverse_preconditioner` |
| 188 | 204 | `pcg_solver.cu` | `update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifie` |
| 136 | 100 | `pcg_solver.cu` | `update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >` |
| 124 | 97 | `pcg_solver.cu` | `update_solution_and_residual` |
| 116 | 86 | `pcg_solver.cu` | `update_cg_direction<float>` |
| 116 | 83 | `pcg_solver.cu` | `update_preconditioned_cg_direction` |
| 88 | 149 | `pcg_solver.cu` | `initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifie` |
| 80 | 98 | `granular.cu` | `multiply_bonds` |
| 80 | 97 | `granular.cu` | `commit_bonds` |
| 56 | 70 | `self_collision.cu` | `multiply_hessian_diagonal` |
| 52 | 71 | `fluid.cu` | `scale_step` |
| 48 | 71 | `self_collision.cu` | `add_hessian_diagonal` |
| 48 | 69 | `granular.cu` | `add_diagonal` |
| 48 | 69 | `fluid.cu` | `add_diagonal` |
| 48 | 64 | `solver_newton.cu` | `apply_block_diagonal_preconditioner` |
| 44 | 63 | `solver_newton.cu` | `initialize_block_diagonal` |
| 36 | 87 | `solver_newton.cu` | `combine_system_non_diagonal` |
| 36 | 56 | `solver_newton.cu` | `update_velocity` |
| 36 | 55 | `solver_newton.cu` | `apply_nonlinear_step` |
| 28 | 34 | `solver_newton.cu` | `initialize_joint_body_spring_state` |
| 24 | 59 | `lbvh_builder.cu` | `build_escape_nodes` |
| 24 | 40 | `solver_newton.cu` | `reset_selected_joint_drive_state` |
| 16 | 37 | `lbvh_builder.cu` | `build_primitive_leaf_nodes` |
| 16 | 32 | `fluid.cu` | `initialize_scale` |

## 📝 仅记录结构（未写代码） —— 2 个 / 1,264 SASS 指令

| SASS | PTX | 模块 | kernel |
|---|---|---|---|
| 676 | 767 | `solver_newton.cu` | `add_tetrahedron_preconditioner` |
| 588 | 309 | `solver_newton.cu` | `add_bending_damping_preconditioner` |

## ⬜ 未触及 —— 93 个 / 117,880 SASS 指令

| SASS | PTX | 模块 | kernel |
|---|---|---|---|
| 10,628 | 11138 | `solver_newton.cu` | `evaluate_cables` |
| 6,064 | 7099 | `solver_newton.cu` | `evaluate_hard_contacts` |
| 5,368 | 5542 | `solver_newton.cu` | `prepare_cable_tangents` |
| 4,120 | 4561 | `solver_newton.cu` | `build_affine_body_preconditioner<BlockNonZeroEntry>` |
| 4,024 | 4648 | `solver_newton.cu` | `evaluate_contact_tangent` |
| 4,008 | 4211 | `solver_newton.cu` | `build_affine_body_preconditioner<NonZeroEntry>` |
| 3,484 | 4219 | `solver_newton.cu` | `multiply_rolling_contact_tangent` |
| 3,444 | 2512 | `solver_newton.cu` | `update_cable_penalties` |
| 3,332 | 4019 | `solver_newton.cu` | `evaluate_rolling_contact_force` |
| 3,280 | 3826 | `solver_newton.cu` | `multiply_surface_contact_tangent` |
| 3,272 | 3945 | `solver_newton.cu` | `add_rolling_contact_preconditioner` |
| 3,156 | 3850 | `solver_newton.cu` | `add_surface_contact_preconditioner` |
| 2,984 | 3436 | `solver_newton.cu` | `evaluate_surface_contact_force` |
| 2,836 | 3277 | `solver_newton.cu` | `add_surface_contact_stiffness_scale` |
| 2,632 | 2741 | `solver_newton.cu` | `evaluate_contact_force` |
| 2,188 | 2096 | `solver_newton.cu` | `update_hard_contact_duals` |
| 2,072 | 2040 | `solver_newton.cu` | `initialize_hard_contacts` |
| 2,000 | 1578 | `solver_newton.cu` | `evaluate_joint_armature` |
| 1,976 | 1637 | `solver_newton.cu` | `add_body_spring_gauss_newton_hessian` |
| 1,836 | 1804 | `solver_newton.cu` | `evaluate_soft_contact_force` |
| 1,836 | 1458 | `solver_newton.cu` | `evaluate_angular_limits` |
| 1,808 | 1584 | `solver_newton.cu` | `evaluate_joint_drive_load` |
| 1,804 | 1572 | `solver_newton.cu` | `add_joint_body_point_line_gauss_newton_hessian` |
| 1,776 | 1845 | `solver_newton.cu` | `multiply_soft_contact_hessian_off_diagonal` |
| 1,496 | 1086 | `solver_newton.cu` | `multiply_joint_drive_tangent` |
| 1,344 | 1188 | `solver_newton.cu` | `add_joint_drive_preconditioner` |
| 1,280 | 962 | `solver_newton.cu` | `add_body_point_line_gauss_newton_hessian` |
| 1,256 | 1008 | `solver_newton.cu` | `add_affine_body_spring_gauss_newton_hessian` |
| 1,180 | 988 | `solver_newton.cu` | `add_cloth_membrane_gauss_newton_hessian` |
| 1,160 | 1037 | `self_collision.cu` | `accumulate_edge_face` |
| 1,064 | 714 | `solver_newton.cu` | `initialize_joint_coordinate_velocities` |
| 916 | 937 | `solver_newton.cu` | `add_affine_body_constitutive_preconditioner` |
| 868 | 870 | `self_collision.cu` | `accumulate_edge_edge` |
| 868 | 823 | `fluid.cu` | `multiply_rows` |
| 804 | 482 | `solver_newton.cu` | `update_joint_drive_angle_state` |
| 788 | 762 | `self_collision.cu` | `accumulate_vertex_face` |
| 784 | 641 | `solver_newton.cu` | `multiply_affine_body_constitutive_tangent` |
| 772 | 607 | `solver_newton.cu` | `evaluate_affine_body_constitutive_force` |
| 720 | 673 | `solver_newton.cu` | `evaluate_tetrahedron_force` |
| 720 | 506 | `solver_newton.cu` | `update_affine_body_so3_augmented_lagrangian_state` |
| 684 | 641 | `self_collision.cu` | `query_vertex_face` |
| 676 | 483 | `solver_newton.cu` | `update_joint_body_point_line_augmented_lagrangian_state` |
| 660 | 742 | `granular.cu` | `form_bonds` |
| 652 | 638 | `granular.cu` | `multiply_contacts` |
| 648 | 300 | `solver_newton.cu` | `evaluate_affine_body_spring_force` |
| 644 | 399 | `solver_newton.cu` | `initialize_affine_body_so3_state` |
| 636 | 307 | `solver_newton.cu` | `evaluate_stretch_force` |
| 620 | 612 | `fluid.cu` | `accumulate_rows` |
| 616 | 618 | `solver_newton.cu` | `multiply_tetrahedron_tangent` |
| 616 | 277 | `solver_newton.cu` | `multiply_bending_damping_tangent` |
| 608 | 394 | `solver_newton.cu` | `evaluate_body_spring_force` |
| 580 | 375 | `solver_newton.cu` | `add_spring_gauss_newton_hessian` |
| 564 | 397 | `solver_newton.cu` | `evaluate_body_point_line_force` |
| 560 | 382 | `solver_newton.cu` | `initialize_joint_body_point_line_state` |
| 552 | 447 | `self_collision.cu` | `accumulate_particle_pairs` |
| 548 | 467 | `self_collision.cu` | `query_edge_edge` |
| 540 | 449 | `solver_newton.cu` | `evaluate_joint_body_point_line_augmented_lagrangian_force` |
| 512 | 294 | `solver_newton.cu` | `evaluate_bending_force` |
| 500 | 409 | `solver_newton.cu` | `apply_affine_body_preconditioner` |
| 496 | 490 | `granular.cu` | `accumulate_contacts` |
| 476 | 280 | `solver_newton.cu` | `update_body_distance_constraint_state` |
| 472 | 274 | `solver_newton.cu` | `initialize_step` |
| 452 | 465 | `solver_newton.cu` | `add_joint_body_point_line_augmented_lagrangian_preconditioner` |
| 448 | 428 | `self_collision.cu` | `query_particle_pairs` |
| 448 | 344 | `solver_newton.cu` | `multiply_joint_body_point_line_augmented_lagrangian` |
| 440 | 406 | `fluid.cu` | `evaluate_rows` |
| 440 | 338 | `solver_newton.cu` | `evaluate_body_distance_constraint_force` |
| 440 | 248 | `solver_newton.cu` | `initialize_body_distance_constraint_state` |
| 436 | 332 | `solver_newton.cu` | `evaluate_joint_body_spring_augmented_lagrangian_force` |
| 432 | 441 | `self_collision.cu` | `query_edge_face` |
| 428 | 339 | `solver_newton.cu` | `apply_affine_body_torques` |
| 404 | 392 | `solver_newton.cu` | `add_affine_body_so3_augmented_lagrangian_preconditioner` |
| 400 | 192 | `solver_newton.cu` | `evaluate_triangle_drag` |
| 356 | 129 | `solver_newton.cu` | `initialize_triangle_drag` |
| 340 | 286 | `granular.cu` | `accumulate_bonds` |
| 332 | 241 | `solver_newton.cu` | `evaluate_affine_body_so3_augmented_lagrangian_force` |
| 332 | 214 | `solver_newton.cu` | `update_joint_body_spring_augmented_lagrangian_state` |
| 308 | 156 | `self_collision.cu` | `refit_bvh` |
| 300 | 200 | `solver_newton.cu` | `multiply_affine_body_so3_augmented_lagrangian_tangent` |
| 260 | 323 | `self_collision.cu` | `multiply_contact_tangents` |
| 260 | 129 | `solver_newton.cu` | `multiply_triangle_drag_tangent` |
| 236 | 112 | `self_collision.cu` | `build_triangle_aabbs` |
| 232 | 172 | `fluid.cu` | `build_grid` |
| 212 | 149 | `granular.cu` | `build_grid` |
| 200 | 159 | `solver_newton.cu` | `prepare_cable_penalties` |
| 192 | 109 | `solver_newton.cu` | `snapshot_hard_contacts` |
| 168 | 128 | `lbvh_builder.cu` | `generate_morton_codes` |
| 160 | 72 | `fluid.cu` | `bound_scale` |
| 156 | 277 | `lbvh_builder.cu` | `build_radix_tree` |
| 92 | 120 | `lbvh_builder.cu` | `refit_aabbs` |
| 76 | 92 | `solver_newton.cu` | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_` |
| 60 | 74 | `self_collision.cu` | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_` |
| 32 | 58 | `solver_newton.cu` | `cuda_cub::core::_kernel_agent<cuda_cub::__parallel_for::ParallelForAgent<cuda_` |

