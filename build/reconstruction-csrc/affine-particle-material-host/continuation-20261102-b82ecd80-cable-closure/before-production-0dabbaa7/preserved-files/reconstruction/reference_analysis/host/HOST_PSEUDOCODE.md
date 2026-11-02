# 主机侧关键函数的反编译笔记

对象：`_core.cpython-312-x86_64-linux-gnu.so` 里 `synreal::` 命名空间下的成员/自由函数。
方法：`objdump -d -C` + 回边分析 + 调用点归类。

---

## 1. `(anonymous namespace)::solve_impl<SparseMatrixELL, float>`

区间 `0x130890`–`0x132820`，**1481 条指令**，87 条回边，13 个最内层循环。
这是标量特化的 CG 求解器主循环。

### 单次迭代的操作序列（实证，按地址）

| 地址 | 操作 |
|---|---|
| `0x130d9d` | `reduce_inner_product(...)` —— 内积归约（内部走 CUB `DeviceReduce`） |
| `0x13116d` | `cudaLaunchKernel` → `multiply_matrix<NonZeroEntry, float>`（通用 launcher） |
| `0x1311c8` | `cudaMemcpyAsync` —— **把标量拷回 host** |
| `0x1311eb` | `cudaMemsetAsync` —— 清零累加缓冲 |
| `0x13123c` | `update_solution_and_residual(...)` —— α 更新 + 残差 |
| `0x131243` | 回边 → `0x130cdb`（迭代体） |

外层循环回边：`0x1311fe → 0x130c15`。

### 两个值得注意的结论

**结论 1：每轮迭代都同步一次。** `cudaMemcpyAsync` 把归约标量拷回 host，说明 α/β 的计算在 **host 上**完成，
而不是留在 device 侧。这是性能上的关键设计点——每轮一个 D2H 拷贝。

**结论 2：CG 没有收敛判据，是固定迭代次数。**
整个函数 **37 条 `cmp` 指令里没有一条浮点比较**（`comiss`/`ucomiss` 出现 0 次），
也没有基于残差的早退分支。迭代上限由实参传入（`SolverNewton::solve_newton_system` 里取 `this+0x24`，
即 `Config.linear_iterations`，默认 50）。

> 这条修正了一个常见假设：不是"跑到收敛或到上限"，而是"**跑满 `linear_iterations` 次**"。

### 伪代码（据上述证据）

```cpp
void solve_impl(matrix A, vec b, vec x, size_t max_iters /* = linear_iterations */, ...)
{
    // 初始化：r = b - A x，z = M⁻¹ r，p = z
    launch(evaluate_residual, A, x, b, r);
    reduce_inner_product(r, &rr);      // r·r

    for (size_t k = 0; k < max_iters; ++k) {      // 无收敛判断
        launch(multiply_matrix, A, p, Ap);
        reduce_inner_product(p, Ap, &pAp);        // p·Ap
        cudaMemcpyAsync(&pAp_h, pAp, D2H);        // ← 每轮同步
        cudaMemsetAsync(scratch, 0);
        launch(update_solution_and_residual, k, &rr, &pAp, p, Ap, x, r);
        reduce_inner_product(r, &rr_new);
        launch(update_cg_direction<...>, k, ...); // β 更新 + 方向
    }
}
```

> 其中 α/β 的具体配对（`num[]` = r·r、`den[]` = p·Ap）已在 `../recover/PCG_PIPELINE.md` 3.5 节论证。

---

## 2. 三个特化的差异（与 `PCG_PIPELINE.md` 3.6 节一致）

| 特化 | 迭代体里的算子 |
|---|---|
| `SparseMatrixELL, float` | `multiply_matrix` + CUB reduce（两步） |
| `SparseMatrixELL, mat3` | `multiply_matrix<...,mat3>` + CUB reduce |
| `SparseBlockMatrixELL, mat3` | `multiply_matrix_and_reduce` / `update_solution_residual_and_reduce`（融合，省一次全量读写） |

---

## 3. `SolverNewton::initialize` —— 设备缓冲池

> **更正（第 29 轮）**：本函数里 **`rbx = Model`（第 2 个形参，`mov %rsi,%rbx`）**，
> `this` 先被存到 `0x20(%rsp)`、之后常驻 **`%r15`**（`lea 0x2ee8(%r15),%rdi`）。
> 之前笼统写"`rbx = this`"是错的；不过池偏移 `0x2ee8..0x3578` 的提取里那些 `%rbx` 基址
> 都是寄存器被复用后的 `this`（Model 只有 1864 B，不可能有 0x3000 级偏移），结论不受影响。

函数区间 `0x270c6` 起，**1949 条指令**。函数体内 **40 次 `thrust::vector_base<...>` 操作**，
其中 **35 次能反出 Solver 内的成员偏移**（34 个不同偏移）。

| Solver 偏移 | 元素类型 | 操作 |
|---|---|---|
| `+0x2ee8` | `float` | `device_allocator<float` |
| `+0x2f08` | `float` | `device_allocator<float` |
| `+0x2f28` | `float` | `device_allocator<float` |
| `+0x2f48` | `float` | `device_allocator<float` |
| `+0x2f68` | `glm::mat<3` | `qualifier)0` |
| `+0x2f88` | `glm::mat<3` | `qualifier)0` |
| `+0x2fa8` | `float` | `device_allocator<float` |
| `+0x2fc8` | `int` | `device_allocator<int` |
| `+0x2fe8` | `int` | `device_allocator<int` |
| `+0x3008` | `unsigned long` | `device_allocator<unsigned long` |
| `+0x3028` | `int` | `device_allocator<int` |
| `+0x3048` | `glm::vec<3` | `qualifier)0` |
| `+0x3068` | `glm::vec<3` | `qualifier)0` |
| `+0x3088` | `glm::vec<3` | `qualifier)0` |
| `+0x30a8` | `glm::vec<3` | `qualifier)0` |
| `+0x30c8` | `glm::mat<3` | `qualifier)0` |
| `+0x30e8` | `glm::mat<3` | `qualifier)0` |
| `+0x3108` | `int` | `device_allocator<int` |
| `+0x3128` | `int` | `device_allocator<int` |
| `+0x3148` | `glm::vec<4` | `qualifier)0` |
| `+0x3168` | `float` | `device_allocator<float` |
| `+0x3168` | `int` | `device_allocator<int` |
| `+0x3248` | `int` | `device_allocator<int` |
| `+0x32a8` | `float` | `device_allocator<float` |
| `+0x3310` | `glm::vec<3` | `qualifier)0` |
| `+0x3330` | `float` | `device_allocator<float` |
| `+0x3350` | `float` | `device_allocator<float` |
| `+0x3378` | `glm::mat<3` | `qualifier)0` |
| `+0x3398` | `glm::mat<3` | `qualifier)0` |
| `+0x3438` | `glm::vec<3` | `qualifier)0` |
| `+0x3498` | `glm::vec<3` | `qualifier)0` |
| `+0x34b8` | `glm::vec<3` | `qualifier)0` |
| `+0x3538` | `float` | `device_allocator<float` |
| `+0x3558` | `glm::mat<3` | `qualifier)0` |
| `+0x3578` | `glm::vec<3` | `qualifier)0` |
| ? | `int` | `device_allocator<int` |
| ? | `float` | `device_allocator<float` |
| ? | `int` | `device_allocator<int` |
| ? | `glm::vec<3` | `qualifier)0` |
| ? | `float` | `device_allocator<float` |

### 结构发现

- 偏移从 **`+0x2ee8`** 到 **`+0x3578`**，**步长 0x20（32 B）**，连续排布 → 一个**设备缓冲池**；
- `thrust::vector_base` 本身 24 B（3 指针），32 B 步长说明外层还有包装或对齐；
- 类型分布：`float`×12、`vec<3`×10、`int`×9、`mat<3`×7、`unsigned long`×1、`vec<4`×1；
- 同函数内另有 4 次 `memset`、4 次 `memmove`（整块拷贝，可能是把 Model 的 Span 内容搬进内部缓冲）。

### 未解决

每次 `resize` 的**尺寸**来自栈上计算值（如 `mov 0x10(%rsp),%rsi`），未能直接追到 Model 字段；需跟踪栈槽。

---

## 3.2 尺寸追踪结果（部分成功）

对 `%rsi` 做深度 ≤4 的反向数据流。**35 个带偏移的 resize** 中：

- **10 个**尺寸追到了内存/立即数/移位表达式（可信）；
- **25 个**停在上游栈槽（线性回溯找不到写入点，需要 CFG 级别的追踪）。

### 可信的尺寸（摘录）

| Solver 偏移 | 元素类型 | 尺寸 |
|---|---|---|
| `+0x2fa8` | `float` | `(si<<$0x4)` |
| `+0x2fc8` | `int` | `[rbx+0x308]` |
| `+0x2fe8` | `int` | `[rbx+0x4dc]` |
| `+0x3008` | `unsigned long` | `[rbx+0x308]` |
| `+0x3028` | `int` | `…` |
| `+0x30c8` | `glm::mat<3` | `13` |
| `+0x30e8` | `glm::mat<3` | `13` |
| `+0x3108` | `int` | `13` |
| `+0x3148` | `glm::vec<4` | `(($0x18+…)-(…+(…-…)))` |
| `+0x3248` | `int` | `$0x1` |

### 观察

- 出现 `[rbx+0x308]`、`[rbx+0x4dc]` 这类 Solver 内部计数（`rbx = this`）——说明多个缓冲共用同一批计数；
- 出现 `(si<<$0x4)` 说明某缓冲按 16 元素为一组分配（`size << 4`）；
- 大量缓冲共用同一个栈槽 `0x58(%rsp)`，即**一次算好、多处复用**的公共尺寸。

### 结论

完整"缓冲名 + 大小公式"表**没有拿到**——需要 CFG 感知的活跃变量分析，
而不是线性反向扫描。已在 `HOST_PSEUDOCODE.md` 记录方法与当前可得的 16 条。

---

## 3.3 CFG 感知的追踪：**失败了，记录原因**

按分支/调用切基本块后做前向数据流（寄存器 + 栈槽抽象值，汇合处取 φ），迭代到不动点。

| 方法 | 解析成功 |
|---|---|
| 线性反向回溯（3.2） | **10 / 35** |
| CFG 前向数据流（本次） | **2 / 35** |

**反而更差**，原因是：

1. 合流点（`φ`）太多：`initialize` 里有大量条件分支，同一个栈槽在不同路径上有不同含义，
   一取 φ 就丢失了具体表达式；
2. 我只实现了 `mov/imul/add/sub/shl/lea` 五类传递，遇到 `movdqu`/`movups`（16 B 搬移）
   和 `rep movsq`（整块拷贝）就断链——而这个函数里恰好大量使用它们；
3. 没有别名分析：同一栈槽可能被不同宽度的写覆盖（4 B / 8 B / 16 B），简单按偏移匹配会串。

结论：**要拿到完整的"缓冲名 + 大小公式"表，需要一个真正的反编译器级数据流引擎**（Ghidra/IDA 的
decompiler 或 angr 之类），自研轻量脚本在这个规模上不划算。

现有 10 条（3.2 节）已够说明结构（共用计数、16 元素分组）；剩下的 25 条不再追。

---

## 4. 还没做的

| 项 | 说明 |
|---|---|
| `initialize_rhs` 的调用上下文 | 只知道它算 `rhs = dt·((mass·I+A)·Δx) + base`，主机侧传参未逐条对 |
| 预条件装配的调用顺序 | `build_affine_body_preconditioner` 的主机侧循环体未拆 |
| `Config` 到 kernel 实参的映射 | 89 个访问点已列出（`../CONFIG_USAGE.md`），但"哪个字段进哪个 kernel 的哪个参数"未逐条连 |
