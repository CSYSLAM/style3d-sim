# 机械还原的批量 A/B 验证（131 个）

> **本目录有两份验证报告，读之前先看这段：**
> - `VALIDATION_REPORT.md`（本文件之外那份）＝ **人工规格**：34 个 kernel，随机数据 + 合法布局，**全部通过**；
> - `AUTO_VALIDATION.md` ＝ **自动规格**：131 个机械还原，按签名自动生成输入，**77 个有强证据**（要求"确实写入内存"）。
>
> 两者覆盖有交集但不重合：人工那 34 个覆盖 CG 全链路与主要算子；自动那 77 个把范围推到全部还原代码。
> **判据**：两侧输出逐字节一致 **且** 该 kernel 确实改写过内存（与运行前快照比较），否则记为 `PASS_EMPTY`。


## 判定标准：**必须证明 kernel 真的写了**

比对"两侧输出相同"是不够的——如果两边都没干活，输出当然相同。所以加了硬条件：

> 把每个参数缓冲的**初始内容**留一份副本，跑完后统计**有多少字节被改写**。
> `写入 = 0` 表示 kernel 什么都没做 → 记为 `PASS_EMPTY`（空转），**不计入通过**。

> ⚠ 我上一版用的是"输出非零"这个判据，它是**错的**：
> 输入缓冲本来就填了非零数据，kernel 不写也仍然非零 → 所有 kernel 都会被误判为"有干活"。
> 改用"与初始内容比较"后，虚高的部分全部暴露。

## 结果：**82/131 个 kernel 有强证据（63%）

| 状态 | 数量 | 说明 |
|---|---|---|
| **PASS** | **68** | 逐字节相同 **且 写入 > 0** |
| **PASS_TOL** | **9** | 仅浮点末位差异 **且 写入 > 0** |
| PASS_EMPTY | 38 | 两侧一致但**一行都没写**（空转，不计入） |
| OOB | 6 | 需 `View` 内部真实指针 |
| TIMEOUT | 7 | BVH/查询类，输入不合法导致成环 |
| FAIL | 0 | ——（本轮清零，见下） |

## 空转项的主因（41 个中 5 个已由人工覆盖，余 36）

| 原因 | 数量（约） | 说明 |
|---|---|---|
| `View` 形参全零 → 计数为 0 | 12 | `fluid::*`、`granular::*`、`*hard_contact*`：`View` 里有 `count`，为 0 就一行不跑 |
| 需要合法稀疏结构 | ~8 | `build_affine_body_preconditioner`、`multiply_matrix` 变体 |
| 需要合法键值对/配对 | ~6 | `accumulate_particle_pairs`、`accumulate_contacts` |
| 只在上游数据结构完整时才有输出 | ~12 | `commit_bonds`、`form_bonds`、`update_hard_contact_duals` 等 |

## 这一轮修正了什么

| 版本 | 判据 | 结果 | 问题 |
|---|---|---|---|
| 第 19 轮 | 仅比对相等 | 115 | 大量空转被算作通过 |
| 第 22 轮 | 输出非零 | 106 | **判据本身有缺陷**：输入非零即"输出非零" |
| 本轮 | **与初始内容比较（写入 > 0）** | **77** | 尚未处理 `View` 全零等结构性问题 |

## 与人工规格验证的关系

| 方式 | 覆盖 | 结果 |
|---|---|---|
| 人工规格（`run_tests.py`，随机数据 + 合法布局 + 计数非零） | 34 个 | **全部通过**（23 精确 / 11 容差），且输出经确认为非平凡 |
| 自动规格（`auto_ab.py`，写入判据） | 131 个 | **77 个强证据** |

> 人工规格那 34 个不受本轮判据变化影响：它们用的是随机浮点 + 合法计数，
> 输出里 `Ap`、`residual`、`diag` 等都有实际数值差异（如 `multiply_matrix_and_reduce` 的 0/12800 差异来自真实计算）。


---

## 一次失败尝试：用 `VIEW_LAYOUT.md` 构造真实 `View`

思路：`fluid::View`（112 B）的字段已由 `VIEW_LAYOUT.md` 定为「10 指针 + 4×u32 + 4×f32」，
据此填「指针→共用零池、计数=8、标量=0.5」，让 kernel 真正跑起来。

结果：`accumulate_rows` 在 `cuCtxSynchronize()` 处**非法访存**。

原因分析：那 10 个"指针"并不都是独立数组指针——`View` 里存在 `{ptr, size}` 成对字段，
以及需要与计数保持一致的第二层索引（如 `grid[i]` 指向的区间）。把所有指针指向同一块零池，
会让「区间起点/终点」这类字段失去一致性，从而越界。

**结论**：`View` 类 kernel 的验证不是"填对偏移"就能解决，需要**每个 kernel 各自的数据结构**
（哪些字段配对、哪些是 CSR 的 `row_ptr`）。这 12 个 kernel 保持 `PASS_EMPTY` 是诚实的。

---

## 第 6 个 bug：所谓"libdevice 阻塞"是我自己的提取器缺陷

前三轮我一直把这 3 个 kernel 列为"无法验证"：

| kernel | 当时判断 |
|---|---|
| `evaluate_cables` | 引用 libdevice `__cudart_i2opi_f`，驱动 JIT 解析失败 |
| `prepare_cable_tangents` | 同上 |
| `update_cable_penalties` | 同上 |

**真相**：`__cudart_i2opi_f` **不是函数，是 24 字节的全局常量表**（2/π 的定点表示）：

```
.global .align 4 .b8 __cudart_i2opi_f[24] = {65, 144, 67, 60, 153, 149, ...}
```

kernel 只是取它的地址（`mov.u64 %rd, __cudart_i2opi_f`）。**我的 per-kernel PTX 提取只切了 kernel 体，
没带上模块级的 `.global` 定义**，于是 JIT 报"找不到符号"，我又把它误判成 libdevice 外部函数。

修法两处：
1. `mkjit.py`：提取时把 `all.ptx` 里所有 `.global` 定义一并带上；
2. `ptx2c.py`：不再生成 `px_stub_/px_addr_` 占位，而是**原样复制**这张表
   （`__device__ unsigned char px_tbl___cudart_i2opi_f[24] = {65,144,...}`），地址取表地址。

修完后：**FAIL 从 3 → 0**，这 3 个 kernel 可以正常加载运行了（当前因输入结构不足仍是 `PASS_EMPTY`）。

> 这是第 6 个"测试台/工具自身的 bug"，也是第 3 次我把工具缺陷误判成"目标不可达"。

---

## 合并两套验证后的真实覆盖：82/131（63%）

单看自动跑会**低估**：有 5 个 kernel 在自动规格下是 `PASS_EMPTY`（自动填充构造不出合法结构），
但它们在**人工规格**里已经通过：

| kernel | 自动 | 人工 |
|---|---|---|
| `commit_bonds` | PASS_EMPTY | PASS_TOL |
| `invert_block_preconditioner` | PASS_EMPTY | PASS_TOL |
| `prepare_inverse_preconditioner` | PASS_EMPTY | PASS |
| `update_preconditioned_cg_direction` | PASS_EMPTY | PASS |
| `update_solution_and_residual` | PASS_EMPTY | PASS |

所以正确的口径是**并集**：

| 口径 | 数量 | 占比 |
|---|---|---|
| 自动强证据 | 77 | 59% |
| 人工强证据 | 35 | 27% |
| **并集（不同 kernel）** | **82** | **63%** |
| 仍未验证 | 49 | 37% |

---

## 又一次失败尝试：把 `View` 的指针分散到不同区域

想法：之前 `View` 的 10 个指针全都指向同一块零池，可能因此数据不自洽；改成
"第 i 个指针 → pool + i×4KB"，让每片区域独立。

结果：`accumulate_rows`、`multiply_rows`、`bound_scale` 仍在 `cuCtxSynchronize()` 处非法访存，
`evaluate_rows` 能跑但一行不写。

**原因**：问题不在"是否共享池"，而在**计数与数组长度的对应关系**。`View` 里的 4 个 u32 计数
约束着 10 个指针指向的数组该有多长，而我把计数设成 4、数组设成 256 元素，两者不成比例；
kernel 用计数算出的索引会落到别的字段上。

真正的解法是给每个 `View` 写**字段语义表**（哪个计数管哪个指针、元素类型是什么），
这等价于重写一遍这套数据结构——超出本轮范围。实验已回退，测试台恢复原状（人工 34 个仍全过）。
