# 装配类 kernel 的结构记录（未写成 .cu 的部分）

这里记录几个体量大、还没整理成可读 C++ 的 kernel —— 已确认的结构写清楚，未确认的**明确标出**，避免把猜测当结论。

## 1. `add_bending_damping_preconditioner`（588 SASS / 309 PTX）

### 参数

```
(param0) const vec3*   points
(param1) const float*  weight        // 逐约束
(param2) const vec4*   coeff         // 4 个系数/约束（16 B）
(param3) const ivec4*  idx           // 4 个顶点下标（16 B）
(param4) const vec2*   rest          // 2 个静止量（8 B）
(param5) float         stiffness
(param6) mat3*         H             // 输出：Hessian 块
(param7/8/9) size_t    n, tile, ...
```

### 守卫（已确认，逐条对应）

```
k = i % tile
v = idx[k]                              // 4 个 int
if (任一下标 < 0)                     skip
if (v[0]==v[1] || v[0]==v[2] || v[0]==v[3] ||
    v[1]==v[2] || v[1]==v[3] || v[2]==v[3])  skip   // 退化约束
if (weight[k] <= 0)                  skip
if (rest[k].y <= 0)                  skip
```

那 6 个两两比较是编译期展开的**去重检查**，说明这个约束不能有重复顶点。

### 梯度系数（已确认）

`coeff[k]` 的 4 个 float 记为 `c0,c1,c2,c3`，PTX 里立刻组合成 3 个：

```
w_prev = -c1 - c3
w_next =  c2 + c3
w_self =  c0 + c1
```

随后 `grad = w_prev·d_prev + w_self·d_self + w_next·d_next`（`fma` 链，`d_*` 是相邻边的向量）。

→ 弯曲约束的**四点差分模板**，系数在 `coeff` 里预存，kernel 里只做线性组合。

### 未确认

- 4 个顶点如何 scatter 到 4×4 个 3×3 块（上三角还是全部）；
- `rest` 的两个分量各代表什么（夹角/长度？）；
- `stiffness` 与 `weight` 的乘序。

## 2. `fluid_kernel::scale_step`（52 SASS / 71 PTX）

行为很简单：`x[i] *= scale[k]`。**但 `k` 的来历有两条路径**：

```
if (Model->word24.x < Model->word24.y)   k = i / divisor
else if (index_array != null)            k = max(index_array[i], 0)
else                                      k = 0
```

**已解决**：`Model+24` 的两个 u32 是 `particle_count` / `particle_state_count`（与运行时布局 +0x18/+0x1c 一致），
`divisor` 就是 `particle_count`；世界索引来自 `particle_world`（Model+120 指针、+128 长度）。
已写成 `human/scale_step.cu`。div 路径的**语义**仍存疑（为什么是 i/count），代码里按 PTX 直译并标注。

## 3. `initialize_block_non_diagonal`（356 SASS / 103 PTX）

**已解决**（`human/initialize_block_non_diagonal.cu`）：`i` 拆成 `k = i/group`、`mid = i%group`、`row = mid%tile`；
守卫 `k < row_nnz[row]`；输入按 tile 转置取 `src = k*tile + row`；输出把标量升级成 3×3 对角块，
列号加 `mid - row`（tile 起点偏移）。

## 结论

这三类 kernel 的共同点是：**数学部分（模板系数、梯度合成）反而容易读，难的是索引/布局的语义**。
索引一旦定错，整段就是错的，所以宁可停在"结构已记录"也不硬写。
下一轮优先把 `Model+24` 那两个 u32 和 `initialize_block_non_diagonal` 的 tile 层级钉死。

## 4. `add_tetrahedron_preconditioner`（676 SASS / 767 PTX）

### 参数

```
(param0) const vec3*   points
(param1) const ivec4*  tet            // 4 个顶点下标，16 B
(param2) const mat3*   Dm_inv         // 逐约束的 3x3（36 B）
(param3) const vec3*   aux            // 逐约束的 vec3（12 B）
(param4) const float*  weight
(param5) float         stiffness
(param6) mat3*         H              // 输出
(param7/8/9) size_t    n, tile, ...
```

### 已确认

- 顶点下标带批次偏移：`idx = tet[k].{x,y,z,w} + (i/tile)*tile`；
- **Dm⁻¹ 是在 kernel 内联算的**：PTX 里能清楚看到 2 项差（`mul` 后 `sub`）组成的余子式，
  以及随后的交叉项组合 —— 不是完全从 param2 读现成的逆；
- 输出散射：**36 条 `red.global.add.f32`** = 4 个顶点 × 9 分量，即只写 4×4 块矩阵的**对角块**。

### 未确认

- 4 个块之间是否有对称复用（36 而非 24，说明 9 个分量都单独算了，没有复用对称性）；
- `aux`（param3）参与的到底是哪个物理量（体积？参考长度？）；
- `stiffness` 与 `weight` 的乘序。

→ 因此**没有写成 .cu**：内联求逆 + 36 路散射的组合，错一处整块就错。
