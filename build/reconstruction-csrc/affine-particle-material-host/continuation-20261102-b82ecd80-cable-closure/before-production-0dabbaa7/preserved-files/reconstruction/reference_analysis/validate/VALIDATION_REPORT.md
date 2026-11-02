# 数值验证报告（A/B 比对）

> **本目录有两份验证报告，读之前先看这段：**
> - `VALIDATION_REPORT.md`（本文件之外那份）＝ **人工规格**：34 个 kernel，随机数据 + 合法布局，**全部通过**；
> - `AUTO_VALIDATION.md` ＝ **自动规格**：131 个机械还原，按签名自动生成输入，**77 个有强证据**（要求"确实写入内存"）。
>
> 两者覆盖有交集但不重合：人工那 34 个覆盖 CG 全链路与主要算子；自动那 77 个把范围推到全部还原代码。
> **判据**：两侧输出逐字节一致 **且** 该 kernel 确实改写过内存（与运行前快照比较），否则记为 `PASS_EMPTY`。


## 方法

1. 驱动 API 把**原始 PTX**（sm_52）JIT 到当前 GPU（RTX 5090, sm_120）——PTX 前向兼容；
2. **重建的 CUDA C** 用 nvcc 编到 sm_120；
3. 同一份输入缓冲，各自发射、同步、回读；
4. 逐字节比对所有指针参数对应的输出缓冲。

## 结果：34 个 kernel —— **全部通过**（23 精确 / 11 容差 / 0 失败）

覆盖：`recover/human/` 的 **32 个文件全部纳入**，另加 `reconstructed/` 的 2 个。

| kernel | 结果 |
|---|---|
| `add_diagonal_mat3` | PASS |
| `add_hessian_diagonal` | PASS |
| `apply_block_diagonal_preconditioner` | PASS |
| `apply_nonlinear_step` | PASS |
| `build_edge_aabbs` | PASS |
| `build_escape_nodes` | PASS |
| `build_particle_aabbs` | PASS |
| `build_primitive_leaf_nodes` | PASS |
| `combine_system_non_diagonal` | PASS |
| `evaluate_spring_force` | PASS |
| `initialize_joint_body_spring_state` | PASS |
| `initialize_scale` | PASS |
| `multiply_bonds` | PASS |
| `multiply_hessian_diagonal` | PASS |
| `prepare_inverse_preconditioner` | PASS |
| `refresh_inertial_cache_diagonals` | PASS |
| `refresh_inertial_cache_nonzeros` | PASS |
| `reset_selected_joint_drive_state` | PASS |
| `scale_step` | PASS |
| `update_cg_direction_blockjacobi` | PASS |
| `update_preconditioned_cg_direction` | PASS |
| `update_solution_and_residual` | PASS |
| `update_velocity` | PASS |
| `add_triangle_drag_preconditioner` | PASS_TOL |
| `commit_bonds` | PASS_TOL |
| `evaluate_residual` | PASS_TOL |
| `initialize_block_diagonal` | PASS_TOL |
| `initialize_block_non_diagonal` | PASS_TOL |
| `initialize_rhs` | PASS_TOL |
| `initialize_zero_solution_and_reduce` | PASS_TOL |
| `invert_block_preconditioner` | PASS_TOL |
| `multiply_matrix` | PASS_TOL |
| `multiply_matrix_and_reduce` | PASS_TOL |
| `update_solution_residual_and_reduce` | PASS_TOL |

容差来源：原子加顺序、块归约求和顺序、±0 符号。max rel ≤ 2.4e-5。

## 验证过程中发现并修复的四个问题

### 1) CSR 行偏移误读（代码 bug，已修）

```cpp
const size_t s = row_ptr[2*i];  const size_t t = row_ptr[2*i+1];   // 错
const size_t s = row_ptr[i];    const size_t t = row_ptr[i+1];     // 对，CSR
```
影响 `refresh_inertial_cache_diagonals` / `refresh_inertial_cache_nonzeros`。

### 2) 第二组求和符号相反（代码 bug，已修）

`refresh_inertial_cache_nonzeros` 第二组用 `sub.f32` 累加 → 结果取负。

### 3) `multiply_matrix_and_reduce` 参数角色（代码 bug，已修）

真实语义与 PTX 字面顺序相反：

```cpp
// PTX 形参顺序：... const vec3* param4, const vec3* param5, vec3* Ap ...
// 实际语义：对角项与稀疏项都作用于 param5，param4 只是最后叠加的项
Ap[i] = diag[i]·p[i] + Σ block·p[tileBase+col] + x[i];   // p=param4, x=param5
```
确定方法：可控输入探针（diag=I / 2I，p=(1,0,0)，x=(0,2,0)，关掉稀疏项），
PTX 输出分别为 (1,2,0) 和 (2,2,0)，与上式吻合；按字面顺序实现则对不上。

### 4) 测试台自己的 bug（工具 bug，已修）

该 kernel 的 `diag` 缓冲只分配了 576 B（=16 个 mat3），而 n=64 需要 2304 B。
越界读使两个实现读到不同的相邻内存，造成"怎么改都对不上"的假象。
**教训：A/B 对不上时，先核对缓冲尺寸，再怀疑公式。**


## 第 5 个 bug（翻译器级）：`mov.b32 %rN, %fM` 被当成数值转换

`update_affine_body_so3_augmented_lagrangian_state` 零输入 PASS、随机输入 rel≈600，
定位过程：

1. 逐条比对 18 条 `st.global`：类型、基址寄存器、偏移**全部一致** → 结构没问题；
2. 差异在**被存的值**；
3. 追到 PTX 的 `mov.b32 %r133, %f193`（浮点→整数的**位转换**），
   翻译器当时按 `r133 = f193;` 输出 → C 里这是**数值转换**，浮点被截断成 0/±1。

修复（`ptx2c.py`）：

```cpp
// 错误：数值转换
r133 = f193;            // 0.707f → 0
// 正确：位转换
r133 = as_u32(f193);    // 0.707f → 0x3F35...
```

**影响面**：重新生成后 **61 / 131** 个还原文件含此类位转换（`grep -l 'as_u32(f' src/*/*.cu`）。

验证：修复后该 kernel 手动规格下 **0/6400 字节差异**；131 个全部重新生成 + 编译通过
（`OK=131 FAIL=0`，覆盖率仍 100%）；人工矩阵 34 个**无回归**（23 精确 / 11 容差）。

## 复跑

```bash
cd _re_analysis/validate
export PATH=/usr/local/cuda/bin:$PATH
nvcc -O2 -arch=sm_120 -o ab ab.cpp -lcuda
python3 -u run_tests.py
```

