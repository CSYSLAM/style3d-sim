# PCG 迭代链路（从还原出的 kernel + launch 顺序拼出来的）

> 依据：`STEP_STRUCTURE.md` 的循环分组、`LAUNCH_ORDER.md` 的调用顺序、以及 21 个已还原 kernel 的公式。
> 标注 **[实证]** 的是 PTX 直接读出来的，**[推断]** 的是从调用顺序 + 命名推的。

## 1. 外层：非线性迭代 [实证]

```
step():
  // 入口校验（实证）
  assert nonlinear_iterations <= 999
  assert 1 <= linear_iterations <= 999
  assert constraint_alpha >= 0

  for it in 0 .. nonlinear_iterations-1:          // 计数器 = rbp-0xb20，初值取自 this+0x20
      装配阶段（11 个 launch，见 STEP_STRUCTURE 的 0xfc290–0xfe156）
      solve_newton_system(..., max_iters = linear_iterations)   // this+0x24
      状态更新
```

## 2. 预条件矩阵的准备链 [实证]

| 顺序 | kernel | 作用（已还原） | 源 |
|---|---|---|---|
| 1 | `initialize_block_diagonal` | `A[i] = diag(a,a,a)`，`B` 非空时同写一份 | `human/initialize_block_diagonal.cu` |
| 2 | `refresh_inertial_cache_diagonals` | `sum = Σ values[col]`；`diag3x[i] = 3·sum`；`row_sum[i] = sum` | `human/refresh_inertial_cache_diagonals.cu` |
| 3 | `prepare_inverse_preconditioner` | `out = (scale>0 && mask&1 && c>0) ? 1/c : 0` | `human/prepare_inverse_preconditioner.cu` |
| 4 | `invert_block_preconditioner` | 对称化 → 余子式 → `det`；退化走对角伪逆 | `human/invert_block_preconditioner.cu` |
| 5 | `apply_block_diagonal_preconditioner` | `z[i] = M[i]·r[i]` | `human/apply_block_diagonal_preconditioner.cu` |

## 3. 单次 PCG 迭代 [实证 + 推断]

```
右端项装配（已还原）：
  initialize_rhs(dt, x_prev, x_cur, mass, row_nnz, entries, max_nnz, base, mask, rhs, n, tile)
      rhs = dt · ((mass·I + A) · (x_cur − x_prev)) + base
      —— "带质量的位移算子"，稀疏项与 multiply_matrix 共用同一套 tile 布局

初始化：
  initialize_zero_solution_and_reduce<256, mat3>
      x = x0; r = 0;  out[block] = Σ x0ᵀ M x0        // 能量归约，warp shuffle + shared
  （随后主机侧用 CUB DeviceReduce 汇总各块部分和 → 得到 r·r 初值）

每次迭代 k：
  evaluate_residual / multiply_matrix
      acc = diag[gid]·x[gid] + Σ_k val_k · x[tileBase + col_k] (+ extra/rhs)
      残差版：r = rhs − acc
  update_cg_direction<mat3>  （有预条件）
      z = M_i·r_i;  β = num[k]/num[k-1];  p = z + β·p
  update_preconditioned_cg_direction （恒等预条件）
      β 同上；p = r + β·p
  multiply_matrix
      Ap = A·p
  update_solution_and_residual
      α = num[k]/den[k]（双守卫）
      x += α·p;  r −= α·Ap
```

> **[推断]** 上面 `α`/`β` 用的是同一组 `num[]/den[]` 数组，具体哪个是 `r·r`、哪个是 `p·Ap`，
> 需要把主机侧写这两个数组的位置对上（`pcg_solver.cu` 的调用点传入的指针）。

## 3.5 α / β 的语义：为什么 num = r·r 历史

`solve_impl<SparseMatrixELL,float>`（`0x130890`，1483 行）里能看到完整链条 [实证]：

| 证据 | 含义 |
|---|---|
| 只直接调用了 2 个 kernel：`update_solution_and_residual`（α）、`update_preconditioned_cg_direction`（β） | 其余 kernel 走**通用 launcher**（4 处 `cudaLaunchKernel`），所以按符号扫不到 |
| 2 次调用 `(anonymous namespace)::reduce_inner_product(...)` | 内积由 CUB `DeviceReduce` 完成，每步一个标量 |
| `update_solution_and_residual(k, num, den, ...)` 用 `num[k]/den[k]` | 与 CG 的 `α = (r·r)/(p·Ap)` 一致 |
| `update_preconditioned_cg_direction(k, r, num, p, n)` 用 `num[k]/num[k-1]` | 与 CG 的 `β = r_new·r_new / r_old·r_old` 一致 |

→ **num[] = 每步的 r·r 历史，den[] = 每步的 p·Ap**。**[高置信推断]**，缺最后一步实参追踪。

另外确认了 `Span` 的内存布局（运行时实测）：`{ T* ptr; size_t size; }`，ptr 在 +0。


## 3.6 CG 迭代体：每个特化实际发射的 kernel（通用 launcher 已解析）

上一轮说"CG 里的 kernel 走通用 launcher、扫不到"——已经解决了：解析每次 `cudaLaunchKernel` 前
`mov <got>(%rip),%rdi # <symbol>` 的符号即可，全库 231 个 `cudaLaunchKernel` 里 **144 个能对上 `synreal::kernel::`**。

### `solve_impl<SparseMatrixELL, float>`（标量特化）

| 顺序 | 发射点 | kernel |
|---|---|---|
| 1 | `0x13116d` | `multiply_matrix<NonZeroEntry, float>` |
| 2 | `0x131406` | `update_cg_direction<float>` |
| 3 | `0x131a86` | `cub::DeviceReduceSingleTileKernel<...>`（内积归约） |
| 4 | `0x131f14` | `evaluate_residual<NonZeroEntry, float>` |
| 另 | `0x13123c` | `update_solution_and_residual`（α 更新，直接调用） |
| 另 | `0x131435` | `update_preconditioned_cg_direction`（β 更新，直接调用） |

### `solve_impl<SparseMatrixELL, glm::mat3>`

```
multiply_matrix<NonZeroEntry, mat3>  →  update_cg_direction<mat3>  →  evaluate_residual<NonZeroEntry, mat3>
```

### `solve_impl<SparseBlockMatrixELL, glm::mat3>`（融合归约版）

| 顺序 | 发射点 | kernel |
|---|---|---|
| 1 | `0x137479` | `multiply_matrix_and_reduce<256, BlockNonZeroEntry, mat3>` **[已还原]** 块稀疏乘 + `p·Ap` 归约 |
| 2 | `0x13771c` | `update_cg_direction<mat3>` |
| 3 | `0x137943` | `update_solution_residual_and_reduce<256, mat3>` **[已还原]** α 更新 + `rᵀMr` 能量归约 |
| 4 | `0x137b5f` | `initialize_zero_solution_and_reduce<256, mat3>` |
| 5 | `0x137cfb` | `evaluate_residual<BlockNonZeroEntry, mat3>` |

> 两条分支的差别很清楚：**块特化把"乘 + 内积"融合成 `*_and_reduce` 一个 kernel**（少一次全量读写），
> 标量特化则分成 `multiply_matrix` + CUB `DeviceReduce` 两步。这是性能取舍，不是算法差异。

## 4. 守卫条件（两处一致，说明是同一个 helper 展开）[实证]

```cpp
// 出现在 update_preconditioned_cg_direction、update_cg_direction、update_solution_and_residual
const bool den_ok = !(fabsf(den) <= 1.0e-11f || fabsf(den) > INFINITY);
const bool num_ok = !(fabsf(num)  >  INFINITY);
ratio = (den_ok && num_ok) ? num / den : 0.0f;
```

常数 `0f0DA24260` = **1e-11**（下界），`0f7F800000` = inf（上界）。

## 5. 数据布局（已确认）

```cpp
struct NonZeroEntry      { int col; float val;   };  // 8 B
struct BlockNonZeroEntry { int col; float m[9];  };  // 40 B（"一列 + 一个 3×3 块"）
// entries[k * tile + rowInTile]  —— 按 [k][行] 转置，保证 warp 内相邻行连续访问
// col 是相对 tile 起点的列号，使用时要 tileBase + col，并做 col>=tile / 全局列越界双重判断
```

## 6. 还缺的

| 缺口 | 说明 |
|---|---|
| `num[]/den[]` 的**实参追踪** | 语义已高置信确定（见 3.5），但还没把 `reduce_inner_product` 的两个调用点分别对应到 num/den |
| ~~CG 循环内 kernel 的通用 launcher~~ | **已解决**（见 3.6）：解析 GOT 符号，144/231 命中 |
