# 按值结构（View）的字段布局反推

> 扫描 PTX 里对 byval 形参（含 `mov.b64`/`cvta.param` 派生的别名寄存器）的 `ld.param` 访问，
> **支持 `ld.param.v2/v4` 向量形式**（按元素宽度展开成多个偏移）。
> 宽度是分类依据：**u64 → 指针**、**u32 → 计数/索引**、**f32 → 标量**。

工具本身修了两处正则缺陷（都会导致"看起来扫过了、其实一条没扫到"）：
1. 基址操作数漏了**无 `%` 前缀的符号名**形式（`[NAME+80]`）；
2. 只处理 `{r1, r2}` 向量形参,漏了单寄存器形式 `%r1`，
   以及 `ld.param.v2/v4`（多字段被一条指令搬走，需按元素宽度展开）。

## sizeof = 12 B（3 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u32×1 | 1 | solver_newton | 计数/索引 |
| +0x004 | u32×1 | 1 | solver_newton | 计数/索引 |
| +0x008 | u32×1 | 1 | solver_newton | 计数/索引 |

## sizeof = 16 B（6 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×33 | 33 | fluid, granular, lbvh_builder, pcg_solver, self_collision, solver_newton | **指针** |
| +0x008 | u32×19、f32×9、u8×1 | 29 | fluid, granular, lbvh_builder, pcg_solver, self_collision, solver_newton | 计数/索引 |
| +0x009 | u8×1 | 1 | pcg_solver | 计数/索引 |
| +0x00a | u8×1 | 1 | pcg_solver | 计数/索引 |
| +0x00b | u8×1 | 1 | pcg_solver | 计数/索引 |
| +0x00c | u32×6、f32×1 | 7 | granular, lbvh_builder, self_collision, solver_newton | 计数/索引 |

## sizeof = 24 B（6 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×17、u32×9 | 26 | fluid, granular, lbvh_builder, pcg_solver, solver_newton | 指针 / {u32,u32} |
| +0x004 | u32×9 | 9 | lbvh_builder | 计数/索引 |
| +0x008 | u32×20、u64×6 | 26 | fluid, granular, lbvh_builder, pcg_solver, solver_newton | 指针 / {u32,u32} |
| +0x00c | u32×20 | 20 | fluid, granular, lbvh_builder, pcg_solver, solver_newton | 计数/索引 |
| +0x010 | u32×20 | 20 | fluid, granular, lbvh_builder, pcg_solver, solver_newton | 计数/索引 |
| +0x014 | u32×12 | 12 | fluid, granular, lbvh_builder, solver_newton | 计数/索引 |

## sizeof = 32 B（7 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×2 | 2 | self_collision, solver_newton | **指针** |
| +0x008 | u32×1、u64×1 | 2 | self_collision, solver_newton | 指针 / {u32,u32} |
| +0x00c | u32×1 | 1 | self_collision | 计数/索引 |
| +0x010 | u32×1、u64×1 | 2 | self_collision, solver_newton | 指针 / {u32,u32} |
| +0x014 | u32×1 | 1 | self_collision | 计数/索引 |
| +0x018 | u32×1、u64×1 | 2 | self_collision, solver_newton | 指针 / {u32,u32} |
| +0x01c | u32×1 | 1 | self_collision | 计数/索引 |

## sizeof = 40 B（9 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x004 | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x008 | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x00c | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x010 | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x014 | u32×13 | 13 | lbvh_builder, pcg_solver | 计数/索引 |
| +0x018 | u32×5 | 5 | lbvh_builder, pcg_solver | 计数/索引 |
| +0x01c | u32×8 | 8 | lbvh_builder | 计数/索引 |
| +0x020 | u32×8 | 8 | lbvh_builder | 计数/索引 |

## sizeof = 48 B（11 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×7 | 7 | fluid, granular, self_collision, solver_newton | **指针** |
| +0x008 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x00c | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x010 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x014 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x018 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x01c | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x020 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x024 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x028 | u32×7 | 7 | fluid, granular, self_collision, solver_newton | 计数/索引 |
| +0x02c | u32×1 | 1 | solver_newton | 计数/索引 |

## sizeof = 72 B（2 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x020 | u64×1 | 1 | lbvh_builder | **指针** |
| +0x028 | u32×1 | 1 | lbvh_builder | 计数/索引 |

## sizeof = 112 B（18 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×3 | 3 | fluid | **指针** |
| +0x008 | u64×3 | 3 | fluid | **指针** |
| +0x010 | u64×4 | 4 | fluid | **指针** |
| +0x018 | u64×4 | 4 | fluid | **指针** |
| +0x020 | u64×3 | 3 | fluid | **指针** |
| +0x028 | u64×3 | 3 | fluid | **指针** |
| +0x030 | u64×5 | 5 | fluid | **指针** |
| +0x038 | u64×2 | 2 | fluid | **指针** |
| +0x040 | u64×2 | 2 | fluid | **指针** |
| +0x048 | u64×2 | 2 | fluid | **指针** |
| +0x050 | u32×4 | 4 | fluid | 计数/索引 |
| +0x054 | u32×4 | 4 | fluid | 计数/索引 |
| +0x058 | u32×4 | 4 | fluid | 计数/索引 |
| +0x05c | u32×4 | 4 | fluid | 计数/索引 |
| +0x060 | f32×3 | 3 | fluid | 标量 f32 |
| +0x064 | f32×3 | 3 | fluid | 标量 f32 |
| +0x068 | f32×3 | 3 | fluid | 标量 f32 |
| +0x06c | f32×3 | 3 | fluid | 标量 f32 |

## sizeof = 120 B（18 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×8 | 8 | granular, solver_newton | **指针** |
| +0x008 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x010 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x018 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x020 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x028 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x030 | u64×11 | 11 | granular, solver_newton | **指针** |
| +0x038 | u64×6 | 6 | granular, solver_newton | **指针** |
| +0x040 | u64×9 | 9 | granular, solver_newton | **指针** |
| +0x048 | u64×9 | 9 | granular, solver_newton | **指针** |
| +0x050 | u64×5 | 5 | granular, solver_newton | **指针** |
| +0x058 | u32×4、u64×2 | 6 | granular, solver_newton | 指针 / {u32,u32} |
| +0x05c | u32×4 | 4 | granular | 计数/索引 |
| +0x060 | u64×3、f32×3 | 6 | granular, solver_newton | 指针 / {u32,u32} |
| +0x064 | f32×3 | 3 | granular | 标量 f32 |
| +0x068 | u64×3、f32×2 | 5 | granular, solver_newton | 指针 / {u32,u32} |
| +0x06c | f32×2 | 2 | granular | 标量 f32 |
| +0x070 | u64×3、f32×3 | 6 | granular, solver_newton | 指针 / {u32,u32} |

## sizeof = 160 B（1 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x090 | u64×3 | 3 | solver_newton | **指针** |

## sizeof = 248 B（1 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×3 | 3 | solver_newton | **指针** |

## sizeof = 296 B（2 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×4 | 4 | solver_newton | **指针** |
| +0x008 | u64×4 | 4 | solver_newton | **指针** |

## sizeof = 312 B（2 个偏移）

| 偏移 | 宽度 | 次数 | 模块 | 推断 |
|---|---|---|---|---|
| +0x000 | u64×3 | 3 | solver_newton | **指针** |
| +0x008 | u64×3 | 3 | solver_newton | **指针** |


---

## 一个特例：`CableView`（160 B）用负偏移访问

`evaluate_cables` 里对 `CableView` 的读取不是 `[param+off]`，而是：

```asm
add.s64 %rd4, %param_base, 48      ; 先把基址推到中间
ld.param.u64 %rd5,  [%rd4 - 8]     ; 实际 = param+40
ld.param.u64 %rd9,  [%rd4 - 48]    ; 实际 = param+0
ld.param.u64 %rd239,[%rd4 - 16]    ; 实际 = param+32
```

所以静态扫描只识别出 1 个偏移（+0x090），**其余 19 个需要还原"基址 + 负偏移"的等价关系**。
160 B = 20 个 8 字节槽，按同族结构的惯例应为「18 个指针 + 2 个计数」。

尝试构造（20 槽全部指向同一零池 + 在 +0x90 写计数 8/64）后，kernel 仍不产生写入——
说明池里的数据必须构成**合法的线缆拓扑**（每根缆的端点索引、静止长度、刚度表彼此一致），
不是"填满指针"能满足的。这属于"逐 kernel 数据契约"，本轮到此为止。
