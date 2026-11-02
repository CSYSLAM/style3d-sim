# PTX、机械 CUDA 与可读实现的验证报告

本文记录当前实现和验证范围，配合 [算法主文](ALGORITHM_ANALYSIS_ZH.md)、[131 个入口附录](ALGORITHM_KERNEL_CATALOG_ZH.md) 与 [主机实参表](host/VERIFIED_ARGUMENTS_ZH.md) 阅读。

## 1. 对照对象与结论

| 对照层次 | 覆盖 | 结果 |
|---|---:|---|
| 当前二进制 PTX 与保存的快照 | 131 个入口 | 完整函数体一致，忽略空白 |
| PTX 语句与机械源文件的行号映射 | 106,114 条语句 | 全部计入，含 15 个内嵌 shuffle 复合块 |
| 机械 CUDA 编译 / 加载 | 131 / 131 | 全部通过 |
| 原始 PTX 模块 JIT 加载 | 131 | 全部通过 |
| 原始 PTX 与独立公式 | 46 个入口、408 项输出检查 | 全部通过 |
| 机械 CUDA 与独立公式 | 46 个入口、408 项输出检查 | 全部通过 |
| 人工可读 CUDA 与独立公式 | 全部 34 个文件、195 项输出检查 | 全部通过 |

这里的“语句”不计标签及声明；内嵌 shuffle 复合块按一条源语句计数，它内部包含多条指令。131 项静态覆盖不是 131 项完整物理模型证明。没有独立公式测试的 85 个入口，在后面的逐入口表中明确显示为 0。

二进制 SHA-256：

```text
4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6
```

环境：NVIDIA GeForce RTX 5090 D v2，驱动 595.71.05。全入口机械编译使用 `nvcc -cubin -arch=sm_120`；数值测试中的原始 PTX 由当前驱动 JIT，机械/人工 CUDA 编译为 PTX 后加载。这里核对 PTX 语义，不声称与二进制每一种目标架构 SASS 的逐位执行轨迹等同。

## 2. 机械源文件如何对应原始指令

[翻译器](recover/ptx2c.py) 使用 CUDA C++ 表达参数、标签、分支、谓词、地址转换、访存、原子和同步；标量运算保留为小段内联 PTX，以保留位宽、signed/unsigned、FMA、转换舍入、近似指令及位模式。它是混合表达，不是全部变量已恢复物理命名的高级源码。

- 每条源语句保留 `// PTX:行号 原文`，可以直接回到对应快照。
- 访存按实际类型执行；shared/local/global 地址转换分别处理。向量访存拆成分量访问，缓存策略与性能不作为等价性结论。
- `atomicAdd/Min/Max/Exch/CAS` 等分别映射，保留操作类别；分支保留有序/无序浮点比较。
- warp shuffle 的有效 lane 谓词与相应加法保存在同一个内联块中，避免丢掉内部语句。
- 三角函数慢路径用到的 `__cudart_i2opi_f` 常量数据随相关入口提供。
- 未支持的语法、指令或全局符号会使生成终止，不产生成功占位结果。

[全入口审计脚本](validate/audit_ptx_sources.py) 从 `.so` 重新提取 PTX，独立逐行扫描语句，核对源行映射，重新生成 CUDA 并比较完整文本，再编译与加载。结果见 [ptx_source_audit.json](validate/ptx_source_audit.json)，每个入口的编译日志和 cubin 位于 `validate/audit_build/`。

## 3. 独立公式场景

参考答案由 NumPy 公式和显式整数索引计算，未用机械翻译器产生参考值。三套场景的入口并集为 46；17+27+3 中 `evaluate_rows` 重叠一次。每项检查对应一个输出数组或矩阵块，不等于同数量的独立物理场景。

| 套件 | 不同入口 | 输出检查 | 主要范围 |
|---|---:|---:|---|
| [基础算法公式](validate/review_algorithm_claims.py) | 17 | 216 | 弹簧、膜内、弯曲、四面体、SO(3)、空气阻力、颗粒提交、CG、块逆、流体网格/核 |
| [可读实现对应场景](validate/review_readable_kernels.py) | 27 | 152 | 稀疏布局、批世界、AABB、缓存、非零输出、活动掩码、可选指针、空行/零容量、融合归约 |
| [流体完整局部行](validate/review_fluid_paths.py) | 3 | 40 | 密度、压力权重、梯度、黏性、参考坐标、边界过滤、64/65 动态邻居两侧、力/块对角/矩阵作用 |

可读实现对应场景用 300 元素覆盖跨块和尾部线程，用不同 `tile/stride` 覆盖世界索引，用非零初始输出区分累加、覆盖和保留；流体专项使用非恒等粒子映射、非单位体积、时间步 0.17、平滑半径 1.3、非零黏性及欠密输入。PCG 融合入口使用 256 线程块；流体专项使用主机实际的 128 线程块。

整数按整数比较，结构化条目分别比较列号和数值。基础套件通常使用 `rtol=4e-5, atol=3e-6`，具体特殊判据见脚本与结果；可读套件为 `rtol=5e-5, atol=5e-6`，先核对非有限值类别；流体专项为 `rtol=1e-4, atol=3e-5`。浮点原子加的顺序和 FMA 可能影响末位，结论是规定容差内一致，不是所有浮点结果逐位一致。

| 报告 | 原始 PTX | 机械 CUDA | 人工 CUDA |
|---|---|---|---|
| 基础 | [216 项](validate/review_algorithm_results.json) | [216 项](validate/review_algorithm_mechanical_results.json) | [报告](validate/review_algorithm_human_results.json)：其中 43 项实际执行人工 CUDA |
| 可读场景 | [152 项](validate/readable_original_results.json) | [152 项](validate/readable_mechanical_results.json) | [152 项](validate/readable_human_results.json) |
| 流体专项 | [40 项](validate/fluid_original_results.json) | [40 项](validate/fluid_mechanical_results.json) | 无人工实现 |

人工基础模式中的另外 173 项回退执行原始 PTX，未算入 195 项人工覆盖。原始和机械模式执行相同输入，因此其检查数也不应相加作为不同场景数。

## 4. 主机实参与运行检查

已由主机指令追踪确认：`initialize_rhs` 的系数 `1/h²`；弯曲、四面体阻尼和空气阻力的系数 `1/h`；流体 View 的 `h_f/K/μ/h`；流体世界尺度初始值 1 与位移上限 `ratio*h_f`；初始键/动态键的 `L0/Lh/active` 跨入口绑定；Newton 和 PD-Newton 的三种线性分派。逐项地址、寄存器与对象偏移见 [主机实参表](host/VERIFIED_ARGUMENTS_ZH.md)。

Compute Sanitizer 在机械版本上报告：

| 检查 | 场景 | 结果 |
|---|---|---|
| [memcheck](validate/memcheck_algorithm.log) | 基础 216 项 | 0 errors |
| [memcheck](validate/memcheck_readable.log) | 可读对应 152 项 | 0 errors |
| [memcheck](validate/memcheck_fluid.log) | 流体 40 项 | 0 errors |
| [synccheck](validate/synccheck_readable.log) | 可读对应场景，含融合归约 | 0 errors |

这些结果限定于已运行输入；memcheck/synccheck 也不是完整数据竞争证明。所有新文档采用上述具有类型和独立公式的测试结果。通用 `ab.cpp` 仅把逐字节相同视为 `PASS`，零变化为 `NO_CHANGE`；需要浮点容差的结论由这些独立脚本提供。

## 5. 复现命令

在 `_re_analysis/` 目录执行，需要 NumPy、CUDA Driver、可用 GPU、`cuobjdump`、`nvcc`，内存/同步检查另需 `compute-sanitizer`。

```bash
python3 validate/audit_ptx_sources.py
python3 validate/review_algorithm_claims.py
python3 validate/review_algorithm_claims.py --mechanical
python3 validate/review_algorithm_claims.py --human
python3 validate/review_readable_kernels.py original
python3 validate/review_readable_kernels.py mechanical
python3 validate/review_readable_kernels.py human
python3 validate/review_fluid_paths.py original
python3 validate/review_fluid_paths.py mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_algorithm.log python3 validate/review_algorithm_claims.py --mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_readable.log python3 validate/review_readable_kernels.py mechanical
compute-sanitizer --tool memcheck --error-exitcode 99 --log-file validate/memcheck_fluid.log python3 validate/review_fluid_paths.py mechanical
compute-sanitizer --tool synccheck --error-exitcode 99 --log-file validate/synccheck_readable.log python3 validate/review_readable_kernels.py mechanical
python3 validate/summarize_verification.py
```

最后一条重新核对二进制、翻译器、所有机械/人工源文件的 SHA-256，计算去重覆盖，输出本文及 [汇总 JSON](validate/verification_summary.json)。若源文件已经变化而结果尚未重跑，它会拒绝使用旧摘要。

## 6. 逐入口完整覆盖表

每行的静态、编译、加载均已通过。数值列是该入口对应的输出检查数量；0 表示未加入独立公式运行场景，不是运行失败，也不是运行通过。人工列只统计实际执行人工源文件的检查。完整签名与功能解释见 [入口附录](ALGORITHM_KERNEL_CATALOG_ZH.md)。

| 模块 / 入口 | PTX 语句数 | 静态/编译/加载 | 原始数值 | 机械数值 | 人工数值 |
|---|---:|---|---:|---:|---:|
| [fluid/accumulate_rows](kernels/fluid/001_accumulate_rows.ptx) | 538 | 通过 | 10 | 10 | 0 |
| [fluid/add_diagonal](kernels/fluid/002_add_diagonal.ptx) | 51 | 通过 | 4 | 4 | 4 |
| [fluid/bound_scale](kernels/fluid/003_bound_scale.ptx) | 49 | 通过 | 1 | 1 | 0 |
| [fluid/build_grid](kernels/fluid/004_build_grid.ptx) | 136 | 通过 | 2 | 2 | 0 |
| [fluid/evaluate_rows](kernels/fluid/005_evaluate_rows.ptx) | 328 | 通过 | 27 | 27 | 0 |
| [fluid/initialize_scale](kernels/fluid/006_initialize_scale.ptx) | 14 | 通过 | 4 | 4 | 4 |
| [fluid/multiply_rows](kernels/fluid/007_multiply_rows.ptx) | 697 | 通过 | 5 | 5 | 0 |
| [fluid/scale_step](kernels/fluid/008_scale_step.ptx) | 45 | 通过 | 3 | 3 | 3 |
| [granular/accumulate_bonds](kernels/granular/001_accumulate_bonds.ptx) | 243 | 通过 | 0 | 0 | 0 |
| [granular/accumulate_contacts](kernels/granular/002_accumulate_contacts.ptx) | 406 | 通过 | 0 | 0 | 0 |
| [granular/add_diagonal](kernels/granular/003_add_diagonal.ptx) | 51 | 通过 | 0 | 0 | 0 |
| [granular/build_grid](kernels/granular/004_build_grid.ptx) | 117 | 通过 | 0 | 0 | 0 |
| [granular/commit_bonds](kernels/granular/005_commit_bonds.ptx) | 70 | 通过 | 2 | 2 | 2 |
| [granular/form_bonds](kernels/granular/006_form_bonds.ptx) | 607 | 通过 | 0 | 0 | 0 |
| [granular/multiply_bonds](kernels/granular/007_multiply_bonds.ptx) | 76 | 通过 | 4 | 4 | 4 |
| [granular/multiply_contacts](kernels/granular/008_multiply_contacts.ptx) | 546 | 通过 | 0 | 0 | 0 |
| [lbvh_builder/build_escape_nodes](kernels/lbvh_builder/001_build_escape_nodes.ptx) | 33 | 通过 | 4 | 4 | 4 |
| [lbvh_builder/build_primitive_leaf_nodes](kernels/lbvh_builder/002_build_primitive_leaf_nodes.ptx) | 20 | 通过 | 4 | 4 | 4 |
| [lbvh_builder/build_radix_tree](kernels/lbvh_builder/003_build_radix_tree.ptx) | 197 | 通过 | 0 | 0 | 0 |
| [lbvh_builder/generate_morton_codes](kernels/lbvh_builder/004_generate_morton_codes.ptx) | 100 | 通过 | 0 | 0 | 0 |
| [lbvh_builder/refit_aabbs](kernels/lbvh_builder/005_refit_aabbs.ptx) | 94 | 通过 | 0 | 0 | 0 |
| [pcg_solver/evaluate_residual<BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/007_evaluate_residual<BlockNonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 261 | 通过 | 0 | 0 | 0 |
| [pcg_solver/evaluate_residual<NonZeroEntry, float>](kernels/pcg_solver/008_evaluate_residual<NonZeroEntry__float>.ptx) | 241 | 通过 | 6 | 6 | 6 |
| [pcg_solver/evaluate_residual<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/009_evaluate_residual<NonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 255 | 通过 | 0 | 0 | 0 |
| [pcg_solver/initialize_zero_solution_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/010_initialize_zero_solution_and_reduce<256u__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 106 | 通过 | 12 | 12 | 12 |
| [pcg_solver/multiply_matrix<NonZeroEntry, float>](kernels/pcg_solver/011_multiply_matrix<NonZeroEntry__float>.ptx) | 231 | 通过 | 6 | 6 | 6 |
| [pcg_solver/multiply_matrix<NonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/012_multiply_matrix<NonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 245 | 通过 | 0 | 0 | 0 |
| [pcg_solver/multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/013_multiply_matrix_and_reduce<256u__BlockNonZeroEntry__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 306 | 通过 | 12 | 12 | 12 |
| [pcg_solver/update_cg_direction<float>](kernels/pcg_solver/014_update_cg_direction<float>.ptx) | 57 | 通过 | 0 | 0 | 0 |
| [pcg_solver/update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/015_update_cg_direction<glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 71 | 通过 | 4 | 4 | 4 |
| [pcg_solver/update_preconditioned_cg_direction](kernels/pcg_solver/001_update_preconditioned_cg_direction.ptx) | 55 | 通过 | 4 | 4 | 4 |
| [pcg_solver/update_solution_and_residual](kernels/pcg_solver/002_update_solution_and_residual.ptx) | 70 | 通过 | 8 | 8 | 8 |
| [pcg_solver/update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >](kernels/pcg_solver/016_update_solution_residual_and_reduce<256u__glm::mat<3__3__float___glm::qualifier_0>_>.ptx) | 149 | 通过 | 6 | 6 | 6 |
| [self_collision/accumulate_edge_edge](kernels/self_collision/001_accumulate_edge_edge.ptx) | 718 | 通过 | 0 | 0 | 0 |
| [self_collision/accumulate_edge_face](kernels/self_collision/002_accumulate_edge_face.ptx) | 890 | 通过 | 0 | 0 | 0 |
| [self_collision/accumulate_particle_pairs](kernels/self_collision/003_accumulate_particle_pairs.ptx) | 351 | 通过 | 0 | 0 | 0 |
| [self_collision/accumulate_vertex_face](kernels/self_collision/004_accumulate_vertex_face.ptx) | 636 | 通过 | 0 | 0 | 0 |
| [self_collision/add_hessian_diagonal](kernels/self_collision/005_add_hessian_diagonal.ptx) | 53 | 通过 | 4 | 4 | 4 |
| [self_collision/build_edge_aabbs](kernels/self_collision/006_build_edge_aabbs.ptx) | 72 | 通过 | 4 | 4 | 4 |
| [self_collision/build_particle_aabbs](kernels/self_collision/007_build_particle_aabbs.ptx) | 63 | 通过 | 4 | 4 | 4 |
| [self_collision/build_triangle_aabbs](kernels/self_collision/008_build_triangle_aabbs.ptx) | 85 | 通过 | 0 | 0 | 0 |
| [self_collision/multiply_contact_tangents](kernels/self_collision/009_multiply_contact_tangents.ptx) | 277 | 通过 | 0 | 0 | 0 |
| [self_collision/multiply_hessian_diagonal](kernels/self_collision/010_multiply_hessian_diagonal.ptx) | 51 | 通过 | 4 | 4 | 4 |
| [self_collision/query_edge_edge](kernels/self_collision/011_query_edge_edge.ptx) | 368 | 通过 | 0 | 0 | 0 |
| [self_collision/query_edge_face](kernels/self_collision/012_query_edge_face.ptx) | 346 | 通过 | 0 | 0 | 0 |
| [self_collision/query_particle_pairs](kernels/self_collision/013_query_particle_pairs.ptx) | 331 | 通过 | 0 | 0 | 0 |
| [self_collision/query_vertex_face](kernels/self_collision/014_query_vertex_face.ptx) | 518 | 通过 | 0 | 0 | 0 |
| [self_collision/refit_bvh](kernels/self_collision/015_refit_bvh.ptx) | 124 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_affine_body_constitutive_preconditioner](kernels/solver_newton/001_add_affine_body_constitutive_preconditioner.ptx) | 856 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_affine_body_so3_augmented_lagrangian_preconditioner](kernels/solver_newton/002_add_affine_body_so3_augmented_lagrangian_preconditioner.ptx) | 364 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_affine_body_spring_gauss_newton_hessian](kernels/solver_newton/003_add_affine_body_spring_gauss_newton_hessian.ptx) | 902 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_bending_damping_preconditioner](kernels/solver_newton/004_add_bending_damping_preconditioner.ptx) | 270 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_body_point_line_gauss_newton_hessian](kernels/solver_newton/005_add_body_point_line_gauss_newton_hessian.ptx) | 846 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_body_spring_gauss_newton_hessian](kernels/solver_newton/006_add_body_spring_gauss_newton_hessian.ptx) | 1389 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_cloth_membrane_gauss_newton_hessian](kernels/solver_newton/007_add_cloth_membrane_gauss_newton_hessian.ptx) | 849 | 通过 | 84 | 84 | 0 |
| [solver_newton/add_joint_body_point_line_augmented_lagrangian_preconditioner](kernels/solver_newton/008_add_joint_body_point_line_augmented_lagrangian_preconditioner.ptx) | 430 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_joint_body_point_line_gauss_newton_hessian](kernels/solver_newton/009_add_joint_body_point_line_gauss_newton_hessian.ptx) | 1331 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_joint_drive_preconditioner](kernels/solver_newton/010_add_joint_drive_preconditioner.ptx) | 1118 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_rolling_contact_preconditioner](kernels/solver_newton/011_add_rolling_contact_preconditioner.ptx) | 3627 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_spring_gauss_newton_hessian](kernels/solver_newton/012_add_spring_gauss_newton_hessian.ptx) | 315 | 通过 | 12 | 12 | 0 |
| [solver_newton/add_surface_contact_preconditioner](kernels/solver_newton/013_add_surface_contact_preconditioner.ptx) | 3562 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_surface_contact_stiffness_scale](kernels/solver_newton/014_add_surface_contact_stiffness_scale.ptx) | 3003 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_tetrahedron_preconditioner](kernels/solver_newton/015_add_tetrahedron_preconditioner.ptx) | 725 | 通过 | 0 | 0 | 0 |
| [solver_newton/add_triangle_drag_preconditioner](kernels/solver_newton/016_add_triangle_drag_preconditioner.ptx) | 122 | 通过 | 4 | 4 | 4 |
| [solver_newton/apply_affine_body_preconditioner](kernels/solver_newton/017_apply_affine_body_preconditioner.ptx) | 380 | 通过 | 0 | 0 | 0 |
| [solver_newton/apply_affine_body_torques](kernels/solver_newton/018_apply_affine_body_torques.ptx) | 302 | 通过 | 0 | 0 | 0 |
| [solver_newton/apply_block_diagonal_preconditioner](kernels/solver_newton/019_apply_block_diagonal_preconditioner.ptx) | 45 | 通过 | 4 | 4 | 4 |
| [solver_newton/apply_nonlinear_step](kernels/solver_newton/020_apply_nonlinear_step.ptx) | 36 | 通过 | 8 | 8 | 8 |
| [solver_newton/build_affine_body_preconditioner<BlockNonZeroEntry>](kernels/solver_newton/083_build_affine_body_preconditioner<BlockNonZeroEntry>.ptx) | 3836 | 通过 | 0 | 0 | 0 |
| [solver_newton/build_affine_body_preconditioner<NonZeroEntry>](kernels/solver_newton/084_build_affine_body_preconditioner<NonZeroEntry>.ptx) | 3485 | 通过 | 0 | 0 | 0 |
| [solver_newton/combine_system_non_diagonal](kernels/solver_newton/021_combine_system_non_diagonal.ptx) | 57 | 通过 | 8 | 8 | 8 |
| [solver_newton/evaluate_affine_body_constitutive_force](kernels/solver_newton/022_evaluate_affine_body_constitutive_force.ptx) | 545 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_affine_body_so3_augmented_lagrangian_force](kernels/solver_newton/023_evaluate_affine_body_so3_augmented_lagrangian_force.ptx) | 211 | 通过 | 12 | 12 | 0 |
| [solver_newton/evaluate_affine_body_spring_force](kernels/solver_newton/024_evaluate_affine_body_spring_force.ptx) | 254 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_angular_limits](kernels/solver_newton/025_evaluate_angular_limits.ptx) | 1337 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_bending_force](kernels/solver_newton/026_evaluate_bending_force.ptx) | 256 | 通过 | 12 | 12 | 0 |
| [solver_newton/evaluate_body_distance_constraint_force](kernels/solver_newton/027_evaluate_body_distance_constraint_force.ptx) | 293 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_body_point_line_force](kernels/solver_newton/028_evaluate_body_point_line_force.ptx) | 340 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_body_spring_force](kernels/solver_newton/029_evaluate_body_spring_force.ptx) | 325 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_cables](kernels/solver_newton/030_evaluate_cables.ptx) | 10363 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_contact_force](kernels/solver_newton/031_evaluate_contact_force.ptx) | 2373 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_contact_tangent](kernels/solver_newton/032_evaluate_contact_tangent.ptx) | 3838 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_hard_contacts](kernels/solver_newton/033_evaluate_hard_contacts.ptx) | 6007 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_joint_armature](kernels/solver_newton/034_evaluate_joint_armature.ptx) | 1451 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_joint_body_point_line_augmented_lagrangian_force](kernels/solver_newton/035_evaluate_joint_body_point_line_augmented_lagrangian_force.ptx) | 397 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_joint_body_spring_augmented_lagrangian_force](kernels/solver_newton/036_evaluate_joint_body_spring_augmented_lagrangian_force.ptx) | 287 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_joint_drive_load](kernels/solver_newton/037_evaluate_joint_drive_load.ptx) | 1418 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_rolling_contact_force](kernels/solver_newton/038_evaluate_rolling_contact_force.ptx) | 3694 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_soft_contact_force](kernels/solver_newton/039_evaluate_soft_contact_force.ptx) | 1524 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_spring_force](kernels/solver_newton/040_evaluate_spring_force.ptx) | 109 | 通过 | 13 | 13 | 13 |
| [solver_newton/evaluate_stretch_force](kernels/solver_newton/041_evaluate_stretch_force.ptx) | 272 | 通过 | 12 | 12 | 0 |
| [solver_newton/evaluate_surface_contact_force](kernels/solver_newton/042_evaluate_surface_contact_force.ptx) | 3151 | 通过 | 0 | 0 | 0 |
| [solver_newton/evaluate_tetrahedron_force](kernels/solver_newton/043_evaluate_tetrahedron_force.ptx) | 620 | 通过 | 12 | 12 | 0 |
| [solver_newton/evaluate_triangle_drag](kernels/solver_newton/044_evaluate_triangle_drag.ptx) | 158 | 通过 | 24 | 24 | 0 |
| [solver_newton/initialize_affine_body_so3_state](kernels/solver_newton/045_initialize_affine_body_so3_state.ptx) | 348 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_block_diagonal](kernels/solver_newton/046_initialize_block_diagonal.ptx) | 43 | 通过 | 6 | 6 | 6 |
| [solver_newton/initialize_block_non_diagonal](kernels/solver_newton/047_initialize_block_non_diagonal.ptx) | 71 | 通过 | 2 | 2 | 2 |
| [solver_newton/initialize_body_distance_constraint_state](kernels/solver_newton/048_initialize_body_distance_constraint_state.ptx) | 202 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_hard_contacts](kernels/solver_newton/049_initialize_hard_contacts.ptx) | 1805 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_joint_body_point_line_state](kernels/solver_newton/050_initialize_joint_body_point_line_state.ptx) | 330 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_joint_body_spring_state](kernels/solver_newton/051_initialize_joint_body_spring_state.ptx) | 18 | 通过 | 4 | 4 | 4 |
| [solver_newton/initialize_joint_coordinate_velocities](kernels/solver_newton/052_initialize_joint_coordinate_velocities.ptx) | 651 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_rhs](kernels/solver_newton/053_initialize_rhs.ptx) | 309 | 通过 | 5 | 5 | 5 |
| [solver_newton/initialize_step](kernels/solver_newton/054_initialize_step.ptx) | 198 | 通过 | 0 | 0 | 0 |
| [solver_newton/initialize_triangle_drag](kernels/solver_newton/055_initialize_triangle_drag.ptx) | 99 | 通过 | 0 | 0 | 0 |
| [solver_newton/invert_block_preconditioner](kernels/solver_newton/056_invert_block_preconditioner.ptx) | 142 | 通过 | 6 | 6 | 6 |
| [solver_newton/multiply_affine_body_constitutive_tangent](kernels/solver_newton/057_multiply_affine_body_constitutive_tangent.ptx) | 578 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_affine_body_so3_augmented_lagrangian_tangent](kernels/solver_newton/058_multiply_affine_body_so3_augmented_lagrangian_tangent.ptx) | 171 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_bending_damping_tangent](kernels/solver_newton/059_multiply_bending_damping_tangent.ptx) | 237 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_joint_body_point_line_augmented_lagrangian](kernels/solver_newton/060_multiply_joint_body_point_line_augmented_lagrangian.ptx) | 305 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_joint_drive_tangent](kernels/solver_newton/061_multiply_joint_drive_tangent.ptx) | 1001 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_rolling_contact_tangent](kernels/solver_newton/062_multiply_rolling_contact_tangent.ptx) | 3880 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_soft_contact_hessian_off_diagonal](kernels/solver_newton/063_multiply_soft_contact_hessian_off_diagonal.ptx) | 1549 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_surface_contact_tangent](kernels/solver_newton/064_multiply_surface_contact_tangent.ptx) | 3515 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_tetrahedron_tangent](kernels/solver_newton/065_multiply_tetrahedron_tangent.ptx) | 575 | 通过 | 0 | 0 | 0 |
| [solver_newton/multiply_triangle_drag_tangent](kernels/solver_newton/066_multiply_triangle_drag_tangent.ptx) | 101 | 通过 | 0 | 0 | 0 |
| [solver_newton/prepare_cable_penalties](kernels/solver_newton/067_prepare_cable_penalties.ptx) | 105 | 通过 | 0 | 0 | 0 |
| [solver_newton/prepare_cable_tangents](kernels/solver_newton/068_prepare_cable_tangents.ptx) | 5169 | 通过 | 0 | 0 | 0 |
| [solver_newton/prepare_inverse_preconditioner](kernels/solver_newton/069_prepare_inverse_preconditioner.ptx) | 53 | 通过 | 4 | 4 | 4 |
| [solver_newton/refresh_inertial_cache_diagonals](kernels/solver_newton/070_refresh_inertial_cache_diagonals.ptx) | 87 | 通过 | 8 | 8 | 8 |
| [solver_newton/refresh_inertial_cache_nonzeros](kernels/solver_newton/071_refresh_inertial_cache_nonzeros.ptx) | 151 | 通过 | 16 | 16 | 16 |
| [solver_newton/reset_selected_joint_drive_state](kernels/solver_newton/072_reset_selected_joint_drive_state.ptx) | 22 | 通过 | 4 | 4 | 4 |
| [solver_newton/snapshot_hard_contacts](kernels/solver_newton/073_snapshot_hard_contacts.ptx) | 83 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_affine_body_so3_augmented_lagrangian_state](kernels/solver_newton/074_update_affine_body_so3_augmented_lagrangian_state.ptx) | 452 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_body_distance_constraint_state](kernels/solver_newton/075_update_body_distance_constraint_state.ptx) | 230 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_cable_penalties](kernels/solver_newton/076_update_cable_penalties.ptx) | 2288 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_hard_contact_duals](kernels/solver_newton/077_update_hard_contact_duals.ptx) | 1873 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_joint_body_point_line_augmented_lagrangian_state](kernels/solver_newton/078_update_joint_body_point_line_augmented_lagrangian_state.ptx) | 424 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_joint_body_spring_augmented_lagrangian_state](kernels/solver_newton/079_update_joint_body_spring_augmented_lagrangian_state.ptx) | 176 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_joint_drive_angle_state](kernels/solver_newton/080_update_joint_drive_angle_state.ptx) | 416 | 通过 | 0 | 0 | 0 |
| [solver_newton/update_velocity](kernels/solver_newton/081_update_velocity.ptx) | 36 | 通过 | 4 | 4 | 4 |

## 7. 仍需单独完成的范围

剩余工作主要是完整 `step` 的动态控制流与长时间轨迹，PD 外层分裂，全部 affine-body 块预条件及其他刚性模型，SO(3) 退化/对偶更新，硬接触与 surface/rolling 的全部历史分支，自碰撞过滤/解缠，新键形成，以及 Cosserat/Dahl 的完整应变与历史状态。详细范围见 [主文第 23 节](ALGORITHM_ANALYSIS_ZH.md#s23)。

这些部分可以继续依靠 PTX 和主机数据流恢复；当前尚未展开的分支没有足够证据写成确定公式。静态完整、局部数值通过和完整系统等价是三个不同结论。
