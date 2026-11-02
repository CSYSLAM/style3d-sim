# `step` 里 Contact / Control / State 的字段访问

`step(State const&, State const&, Control const&, Contact const&, float, CUstream*)`
→ `rsi→-0xaf8(%rbp)`、`rdx→-0xb18(%rbp)`、`rcx→-0xb88(%rbp)`、`r8→%r14`（`Contact` 全程留在 `%r14`）。

## contact（23 个已知字段）

| 字段 | 类型 | 访问次数 |
|---|---|---|
| `max_count` | int | 13 |
| `shape0` | Span | 1 |
| `shape1` | Span | 1 |
| `point0` | Span | 1 |
| `point1` | Span | 1 |
| `offset0` | Span | 1 |
| `offset1` | Span | 1 |
| `normal` | Span | 1 |
| `margin0` | Span | 1 |
| `margin1` | Span | 2 |
| `history_refresh` | bool | 1 |
| `soft_count` | Span | 3 |
| `soft_max_count` | int | 8 |
| `soft_particle` | Span | 2 |
| `soft_shape` | Span | 2 |
| `soft_body_pos` | Span | 2 |
| `soft_body_vel` | Span | 2 |
| `soft_normal` | Span | 2 |
| `soft_particle_only_shapes` | Span | 3 |

## control（5 个已知字段）

| 字段 | 类型 | 访问次数 |
|---|---|---|
| `joint_target_q` | Span | 1 |
| `joint_target_qd` | Span | 1 |
| `tetrahedron_activations` | Span | 1 |

## state_a（3 个已知字段）

| 字段 | 类型 | 访问次数 |
|---|---|---|
| `particle_q` | Span | 9 |
| `particle_qd` | Span | 8 |
| `particle_f` | Span | 3 |

## state_b（3 个已知字段）

| 字段 | 类型 | 访问次数 |
|---|---|---|
| `particle_q` | Span | 2 |
| `particle_qd` | Span | 2 |


---

## 一项结构性发现：整结构只在 `step` 里被消费

扫了 190 个自研成员函数，统计"以 `const&` 接收整个结构"的函数个数：

| 结构 | 接收它的函数数 |
|---|---|
| `Model` | 4 |
| `State` | 4 |
| `Control` | **1** |
| `Contact` | **1** |

而"接收 `Span<T>`（单条数组视图）"的函数有 **12** 个（`PcgSolver::solve`、`solve_newton_system`、
`BvhBuilder::build_hierarchy`、`copy_cable_penalties` …）。

**含义**：`Contact` / `Control` 只作为"一批数组的集合"在 `step` 里被拆开，
下游全部按 `Span` 逐个传参。这也解释了为什么 `Contact` 的字段在 `step` 里被读那么多次
（`max_count` 13 次、`soft_max_count` 8 次）——它在 `step` 里负责**容量校验和参数提取**，
真正的计算发生在拿到 `Span` 的 kernel 里。

> 附带结论：`Contact` 没有隐藏的第二层使用点。想找某条数据"从哪来、到哪去"，
> 应该顺着 `Span` 而不是顺着 `Contact`。
