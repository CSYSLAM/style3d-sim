# Config 字段在 `step` 里的使用点

> `Config` 位于 `SolverNewton +0x8`，`step` 里 `rbx = this`（`mov %rdi,%rbx`），
> 因此 `Config+off` 表现为 `0x(8+off)(%rbx)`。统计范围：`0xfb160`–`0x102a90`。
共 32 个字段，其中 **32** 个在 `step` 内被直接访问，累计 89 个访问点。


| Config 偏移 | 字段 | 类型 | 次数 | 指令分布 | 首条示例 |
|---|---|---|---|---|---|
| +0x004 | `constraint_alpha` | float | 28 | f32 读×27, f32 比较×1 | `fb4b0: movss 0xc(%rbx),%xmm3` |
| +0x00c | `joint_constraint_primal_iterations` | int | 2 | 读×1, idivl×1 | `fb4ce: mov 0x14(%rbx),%eax` |
| +0x010 | `affine_body_rigidity_primal_iterations` | int | 2 | 读×1, 比较×1 | `fb4df: mov 0x18(%rbx),%eax` |
| +0x014 | `affine_body_block_preconditioner` | bool | 1 | and×1 | `fc1c4: and 0x1c(%rbx),%al` |
| +0x015 | `affine_body_contact_block_preconditioner` | bool | 1 | cmpb×1 | `fd43e: cmpb $0x0,0x1d(%rbx)` |
| +0x018 | `nonlinear_iterations` | int | 2 | int 比较×1, 读×1 | `fb492: cmpl $0x3e7,0x20(%rbx)` |
| +0x01c | `linear_iterations` | int | 1 | 读×1 | `fb49f: mov 0x24(%rbx),%eax` |
| +0x020 | `fluid_relaxation` | float | 2 | f32 读×2 | `fb799: movss 0x28(%rbx),%xmm2` |
| +0x024 | `fluid_max_step_ratio` | float | 2 | f32 读×2 | `fb7c7: movss 0x2c(%rbx),%xmm2` |
| +0x028 | `air_density` | float | 3 | f32 读×3 | `fb5cc: movss 0x30(%rbx),%xmm2` |
| +0x02c | `wind_velocity` | tuple | 2 | f32 读×1, movq×1 | `fb5e9: movss 0x34(%rbx),%xmm2` |
| +0x038 | `enable_self_collision` | bool | 1 | bool 读×1 | `fbc1a: movzbl 0x40(%rbx),%eax` |
| +0x039 | `enable_collision_hessian_non_diagonal` | bool | 5 | cmpb×3, bool 读×2 | `fc15b: movzbl 0x41(%rbx),%edx` |
| +0x03c | `rolling_friction_velocity_epsilon` | float | 2 | f32 读×2 | `fb61c: movss 0x44(%rbx),%xmm2` |
| +0x040 | `rigid_contact_friction_epsilon` | float | 2 | f32 读×2 | `fb636: movss 0x48(%rbx),%xmm2` |
| +0x044 | `rigid_contact_hard` | bool | 2 | cmpb×1, bool 读×1 | `fe360: cmpb $0x0,0x4c(%rbx)` |
| +0x045 | `rigid_contact_history` | bool | 2 | cmpb×1, 读×1 | `fe36a: cmpb $0x0,0x4d(%rbx)` |
| +0x046 | `rigid_contact_sliding_tangent` | bool | 1 | 读×1 | `1023c3: mov 0x4e(%rbx),%ah` |
| +0x048 | `rigid_contact_alpha` | float | 2 | f32 读×2 | `fb650: movss 0x50(%rbx),%xmm2` |
| +0x04c | `rigid_contact_beta` | float | 2 | f32 读×2 | `fb69e: movss 0x54(%rbx),%xmm2` |
| +0x050 | `rigid_contact_gamma` | float | 2 | f32 读×2 | `fb67b: movss 0x58(%rbx),%xmm2` |
| +0x054 | `rigid_contact_k_start` | float | 2 | f32 读×2 | `fb6b8: movss 0x5c(%rbx),%xmm2` |
| +0x058 | `cable_linear_beta` | float | 3 | f32 读×3 | `fb942: movss 0x60(%rbx),%xmm0` |
| +0x05c | `cable_angular_beta` | float | 3 | f32 读×3 | `fe9c2: movss 0x64(%rbx),%xmm1` |
| +0x060 | `cable_penalty_gamma` | float | 1 | f32 读×1 | `10214f: movss 0x68(%rbx),%xmm2` |
| +0x064 | `cable_linear_k_start` | float | 1 | f32 读×1 | `10214a: movss 0x6c(%rbx),%xmm3` |
| +0x068 | `cable_angular_k_start` | float | 1 | f32 读×1 | `102143: movss 0x70(%rbx),%xmm4` |
| +0x06c | `self_collision_radius` | float | 3 | f32 读×3 | `fb4f0: movss 0x74(%rbx),%xmm3` |
| +0x070 | `self_collision_vertex_face_stiffness` | float | 2 | f32 读×2 | `fb50a: movss 0x78(%rbx),%xmm3` |
| +0x074 | `self_collision_edge_edge_stiffness` | float | 2 | f32 读×2 | `fb524: movss 0x7c(%rbx),%xmm3` |
| +0x078 | `self_collision_edge_face_stiffness` | float | 2 | f32 读×2 | `fb53e: movss 0x80(%rbx),%xmm3` |
| +0x07c | `self_collision_particle_particle_stiffness` | float | 2 | f32 读×2 | `fb55b: movss 0x84(%rbx),%xmm3` |

## 读法

- `f32 读` / `bool 读` 多为参与内核参数打包或条件判断；
- `作为实参入栈` 说明该字段被直接传给某个 kernel launch（`push` 之后紧接 `call ... cudaLaunchKernel`）；
- `16B 批量拷` 通常是整个 `Config` 被拷进栈上的临时对象（例如传给 lambda 或捕获）。
