# 主机侧恢复报告（第 1 批）

对象：`_core.cpython-312-x86_64-linux-gnu.so` 的主机代码（`.text` 1.55 MB，227 个 `synreal::` 命名函数，194 KB）
手段：`objdump -d -C` + 自写的回边/数据流脚本

---

## 1. launch 配置：grid / block 已量化

机制搞清楚了：调用方执行 `__cudaPushCallConfiguration(grid, block, smem, stream)`，`__device_stub__` 里 `__cudaPopCallConfiguration` 取出，再 `cudaLaunchKernel`。全库共 **227 个 push 点**。

| 项 | 结果 |
|---|---|
| block 尺寸 | **已解析 162/227（71%）**：direct 152 次（点旁直接读到 dim3 常量）、func 10 次（函数级唯一常量回填）；未解析 65 次 |
| grid | 常见路径为 `ceil(n / 256)`；流体路径为 `ceil(n / 128)`；需以各调用点为准 |
| 常量来源 | `.rodata` 里存着 dim3 常量：`0x1fcf70 = (1,1,1,1)`、`0x1fcf90 = (256,1)`、`0x201070 = (1,1,1)` |
| 未解析分布 | 63 处在 thrust/cub 内部（`__parallel_for`、`DeviceReduce`、`DeviceRadixSort`），**自研函数只剩 2 处**：`Fluid::multiply`、`Fluid::add_preconditioner` |

明细见 `LAUNCH_CONFIG.md`（自动提取）与 [主机实参对应](VERIFIED_ARGUMENTS_ZH.md)（直接数据流）。自研入口存在 256 与 128 线程配置；`Fluid::accumulate/limit_step/multiply/add_preconditioner` 使用 128，PCG 融合归约的 `256u` 模板使用 256。是否存在 `__launch_bounds__` 不能由 launch 大小反推。

---

## 1.5 `Config` 在 `SolverNewton` 内的嵌入偏移：**已确认 = `this + 0x8`**

三条独立证据（都来自 `step` 的反汇编，`rbx = this`，见 `mov %rdi,%rbx`）：

| 指令 | 含义 | 与运行时探针一致 |
|---|---|---|
| `cmpl $0x3e7, 0x20(%rbx)` | `nonlinear_iterations > 999` 报错 | Config+0x18 ✅ |
| `mov 0x24(%rbx),%eax; sub $1; cmp $0x3e6; ja err` | `linear_iterations ∉ [1,999]` 报错 | Config+0x1c ✅ |
| `movss 0x28(%rbx),%xmm2` | 读 `fluid_relaxation`（float） | Config+0x20 ✅ |
| `movss 0x48(%rbx),%xmm2` | 读 `rigid_contact_friction_epsilon`（float） | Config+0x40 ✅ |
| `movss 0xc(%rbx),%xmm3` + `comiss 0` | 校验 `constraint_alpha ≥ 0` | Config+0x04 ✅ |
| `movss 0x50(%rbx),%xmm2` | 读 `rigid_contact_alpha`（float） | Config+0x48 ✅ |

顺带**白捡到 `Config` 的合法性约束**（`step` 入口的抛异常分支）：

```
nonlinear_iterations ≤ 999
1 ≤ linear_iterations ≤ 999
constraint_alpha ≥ 0
```

## 1.6 两层循环与 `Config` 的绑定：**已证实**

| 循环 | 计数器位置 | 来源 | 证据 |
|---|---|---|---|
| 非线性（牛顿） | `rbp-0xb20` | `this+0x20` = `config.nonlinear_iterations` | `fb7f7: mov 0x20(%rbx),%eax; mov %eax,-0xb20(%rbp)`，循环条件 `fe100/fe197/fe5f0: cmp ... -0xb20(%rbp)` |
| 线性（PCG） | 作为参数传入 `solve_newton_system` | `this+0x24` = `config.linear_iterations` | `f1794: mov 0x24(%rbx),%r9d` → 第 6 个实参（max_iters） |

于是主控结构**不再是推断**：

```
step():
  校验 config（3 条规则）
  for it in 0 .. config.nonlinear_iterations-1:      # 默认 5
      装配 11 个 launch（0xfc290–0xfe156）
      solve_newton_system(..., max_iters = config.linear_iterations)   # 默认 50
      ...
```

## 2. `SolverNewton::step` 的循环骨架

函数 `0xfb160`–`0x102a90`（约 30 KB），检出 **160 条回边**、17 个最内层循环，74 次 launch 全部归位到循环（详见 `STEP_STRUCTURE.md`）：

| 循环区间 | 大小 | 内含 launch 数 | 内容判读 |
|---|---|---|---|
| `0xfc290`–`0xfe156` | 7.9 KB | **11** | 牛顿迭代主体：`prepare_cable_tangents` → `initialize_rhs` → 各力/接触装配 → `initialize_block_diagonal` → 两个 `add_*_gauss_newton_hessian` → `invert_block_preconditioner` |
| `0xffeeb`–`0x100f61` | 4.2 KB | **19** | 线性求解（PCG）阶段：各种 `multiply_*`、`add_*_preconditioner`、`evaluate_contact_*` 的重复装配 |
| `0xfe610`–`0xfef4c` | 2.4 KB | 9 | 预条件矩阵装配的并行分支 |
| `0xff64f`–`0x1009f9` | 5.0 KB | 9 | 另一组预条件/切线装配 |
| `0x102521`–`0x10294c` | 1.1 KB | 3 | `combine_system_non_diagonal` / `refresh_inertial_cache_nonzeros` / `evaluate_contact_tangent` |
| `0x1027ff`–`0x102a1e` | 0.5 KB | 4 | 收尾：`initialize_joint_coordinate_velocities`、`initialize_affine_body_so3_state`、`initialize_joint_body_*_state` |

顶层（循环外，每步只跑一次）有 4 次 launch：`initialize_step`、`update_velocity`、`update_joint_body_point_line_augmented_lagrangian_state`、`add_affine_body_spring_gauss_newton_hessian`。

> 结合 `Config` 默认值（`nonlinear_iterations=5`、`linear_iterations=50`）**推测**主控结构为：
> `for it in 0..4 { 装配(11 个 launch) → PCG(50 次，每次 19 个 launch) → 更新状态 }`。
> 这是推断，尚未把循环计数器与 `Config` 字段偏移逐条对上；`nonlinear_iterations` 到底控制 0xfc290 那个循环还是外层循环，需要再核。

## 3. 常量池

`.rodata` 中与求解器直接相关的一段：

| 地址 | 内容 |
|---|---|
| `0x1fcf70` | `(1,1,1,1)` — dim3 y/z 常量 |
| `0x1fcf80` | f32 `1.0, 3.0, 0.5, 6.0` — 疑似 Cayley/SO(3) 展开系数 |
| `0x1fcf90` | `(256,1)` dim3 + f32 `0.98, 100.0` — block 尺寸与惩罚/刚度常量 |

（大范围 float 扫描命中 96 处，多半是别段数据的巧合解读，未采信。）

---

## 3.5 结构体字段偏移（运行时差分法，已落地）

方法：pybind11 对象用 `shared_ptr` holder，先解引用拿到 C++ 对象地址，再"快照 → 逐属性写极端值 → 内存 diff"，
偏移按类型对齐回起点，并做**对齐 + 不重叠**一致性检查。

| 类型 | 可写字段 | 已定位最大偏移 | 推断 sizeof | 一致性 |
|---|---|---|---|---|
| `Config` | 32 | +0x07c | ≈ 0x80 (128 B) | 全部对齐、无重叠 ✅ |
| `Model` | 51 | +0x1f0 | ≥ 0x200 | ✅ |
| `State` | 3 | +0x020 | — | ✅ |
| `Contact` | 23 | +0x148 | — | ✅ |
| `Control` | 5 | +0x040 | — | ✅ |

`Config` 的关键偏移（可直接用于读主机代码）：

```
+0x18  nonlinear_iterations      +0x1c  linear_iterations
+0x04  constraint_alpha (f32)    +0x14/0x15  affine_body_block_preconditioner / _contact_
+0x20  fluid_relaxation          +0x28  air_density
+0x40  rigid_contact_friction_epsilon   +0x48  rigid_contact_alpha
```

**一个重要发现**：Python 侧 `Model` 暴露的 51 个字段只铺到 +0x1f0，但 kernel 侧 `synreal::Model` 是按值传的 **1864 B** ——
说明还有约 1.3 KB 的非暴露成员（大概率是 `std::vector` / 内部缓冲），这部分在 Python 层完全不可见。

> 待核：`SolverNewton::config` 在对象内的嵌入偏移尚未确认（`step` 里 `0x568/0x56c(%rbx)` 虽与 config+0x18/+0x1c 数值吻合，
> 但那两处被 `imul` 当元素数用，不能当证据）。因此"循环次数直接来自 Config"这一条仍是推断。

---

## 3.6 `.rodata` 常量：按"引用点"提取（不再是盲扫）

盲扫 float 会得到 96 处噪声，改用**反汇编里 rip 相对寻址的注释地址**做反向索引，再按引用它的指令
（`movss` = 浮点、`mov` = 8 字节整块、`lea` = 取地址）分类，得到真正被代码使用的常量（共 2424 个地址，明细见 `RODATA_REFS.md`）。

| 地址 | 内容 | 引用次数 | 首个引用者 | 判读 |
|---|---|---|---|---|
| `0x1fcf80` | f32 `1.0, 3.0, 0.5, 6.0` | 54 | `step` | 疑似 Cayley / SO(3) 展开系数（1、3、0.5、6 常见于四元数→矩阵） |
| `0x1f478c` | f32 `3.40282e+38 (FLT_MAX), 0.999` | 41 | `step` | 上界钳制 + 衰减系数 |
| `0x1f47a0` | u32 `0x7FC00000`（quiet NaN） | 106 | `step` | "无效值"哨兵 |
| `0x1fcf90` | dim3 `(256,1)` + f32 `0.999, 100.0` | 130 | `reset_joint_drive_state` | launch block 尺寸 + 惩罚系数 |
| `0x1fcf70` | dim3 `(1,1,1,1)` | 113 | `evaluate_contact_*` stub | grid.y/z 常量 |
| `0x201070` | `(1,1,1)` | 140 | `update_preconditioner` stub | grid.y/z 常量 |

> 方法上的收获：把"常量长什么样"换成"谁在引用它"，噪声直接归零——
> 例如 `0x1f478c` 之前盲扫会被当成 `0.999` 的普通浮点，实际它和 `FLT_MAX` 同属一组钳制常量。

## 4. 还没做的

| 项 | 状态 |
|---|---|
| 每个 launch 的**参数实参**（传了哪块内存/哪个标量） | 未做；需要逐点读寄存器/栈，与 `LAUNCH_ORDER.md` 的 74 条对齐 |
| `Config` 字段名 ↔ 偏移 | **已完成**（见 3.5 / `../LAYOUT_RUNTIME.md`） |
| `Model`/`State`/`Contact`/`Control` 字段布局 | **已完成**；但非暴露成员（Model 的 ~1.3 KB）仍不可见 |
| 循环边界与 `Config` 字段的绑定 | **已完成**（见 1.6） |

## 5. 产物

| 文件 | 内容 |
|---|---|
| `LAUNCH_CONFIG.md` | 227 个 push 点的 block/grid 明细 |
| `STEP_STRUCTURE.md` | step 的循环分组与每轮 launch 清单 |
| `LAUNCH_ORDER.md` | 74 次 kernel launch + 12 次宿主调用的顺序（共 86 次 call） |
| `launch_cfg4.py` / `loops.py` / `../layout_probe.py` | 可复跑脚本（`launch_cfg4` 为最终版，带置信度标注） |
| `../recover/human/*.cu` | 27 个可读版 kernel（另 2 个在 `../reconstructed/`）——CG 全链 + Hessian + BVH + 颗粒键 + 流体缩放 |
| `../recover/PCG_PIPELINE.md` | PCG 迭代链路总览（实证/推断分标注） |
| `../recover/ASSEMBLY_KERNELS.md` | 装配类大 kernel 的结构记录 |
| `../recover/KERNEL_COVERAGE.md` | 131 个 kernel 的还原覆盖表（按 SASS 体量排序） |
| `RODATA_REFS.md` | 按引用点提取的 `.rodata` 常量表（浮点 / 整型 dim3 分类） |
| `rodata_refs.py` | 可复跑脚本 |
| `../LAYOUT_RUNTIME.md` | Config/Model/State/Contact/Control 字段偏移表 |

---

## 5. `multiply_matrix` / `evaluate_residual`：**已完成**（上一轮的"进行中"项）

已确认的部分（`pcg_solver.cu` 的 4 个特化，SASS 352–436）：

- 稀疏矩阵按 **AoS** 存储：`NonZeroEntry { int index; float value; }`，步长 8 B（PTX 里 `shl %rd76, 3`）；
- 行偏移表是 `int32*`（`shl %rd75, 2` 索引），取出的值经 `max(.,0)` 再 `min(., nnz_per_row)` 钳制；
- 有"分区"概念：`rem/sub` 把全局 tid 拆成 `(分区号, 行内偏移)`，列索引要加上分区偏移后再与总列数比较；
- 主循环是展开 4 次的 fma 累加（`and.b32 %r114, %r1, 3` 是尾数处理）。

**参数映射已坐实**（用 `ld.param ..._param_N` 的后缀对齐寄存器）：param0 行非零数、param1 实体数组、
param2 nnz 上限、param3 对角、param4 x、param5 rhs、param6 可选修正向量、param7 输出、param8 n、param9 tile。

**布局结论**：`entries[k * tile + rowInTile]` —— 即按 `[k][行]` 转置存放，同一 warp 的相邻行访问相邻地址（coalescing）。
每个列索引是**相对 tile 起点**的（`tileBase + col`），越界要双重判断（`col >= tile` 和 `tileBase+col >= n`）。
`evaluate_residual` 与它共用同一骨架，尾部改成 `r = rhs - acc`。

还原代码见 `../recover/human/multiply_matrix.cu` 与 `evaluate_residual.cu`（均已 nvcc 编译通过）。

---

## 6. 重要修正：CG 循环里的 kernel 走的是**通用 launcher**

之前统计的 74 次 launch 只覆盖了"有独立 host wrapper"的发射点。实际上
`(anonymous namespace)::solve_impl<SparseMatrixELL,float>`（`0x130890`，1483 行）里是 4 处
**直接调用 `cudaLaunchKernel`**——内核指针从 GOT 取，符号级扫描看不到。

因此：

- `LAUNCH_ORDER.md` 的 74 次是**下界**，CG 迭代体内的 matvec/归约还没算进去；
- **已补**：解析每次 `cudaLaunchKernel` 前那条 `mov <got>(%rip),%rdi # <symbol>`，全库 231 处里 **144 处命中 `synreal::kernel::`**；
  三个 `solve_impl` 特化的 kernel 顺序已写进 `../recover/PCG_PIPELINE.md` 的 3.6 节；
- `solve_impl` 里还能看到 2 次 `reduce_inner_product`（CUB DeviceReduce）和 2 个直接调用的 kernel（α/β 更新），这给了 CG 每一步的操作顺序。

这条修正已同步到 `../recover/PCG_PIPELINE.md` 的 3.5 节。

---

## 7. `Model` 的 kernel 侧内部字段（新发现）

`commit_bonds` 是按值接收 1864 B 的 `Model` 的，PTX 里对它的访问是：

```
add.s64 %rd3, %rd5, 324;              // Model + 324
ld.param.f32 %f18, [%rd3+-4];         // Model + 320
ld.param.f32 %f23, [%rd3+-8];         // Model + 316
```

| 偏移 | 默认值 | 语义（由用法反推） |
|---|---|---|
| `Model+316` | **0.03** | 每步静止长度最多收缩 3%（`lo = rest·(1−0.03)`） |
| `Model+320` | **0.40** | 向当前长度靠拢的比例（`hi = min(rest, 0.4·rest + len)`） |

默认值来源：`Model` 构造函数里 `.rodata 0x1f4760` 的两个 float（0.03, 0.4）被一条 8 字节写指令整体写到 `0x13c`。

> 这一节修正了我此前的说法（先说 +324/+328，实际是 +316/+320）。`Model+324` 处确实有常量 0.1，但**不参与** `commit_bonds`。

---

## 8. `solve_impl` 的反编译要点（详见 `HOST_PSEUDOCODE.md`）

- 区间 `0x130890`–`0x132820`，1481 条指令，13 个最内层循环；
- 单轮迭代：`reduce_inner_product` → launch matvec → **`cudaMemcpyAsync` 拷回 host** → `cudaMemsetAsync` → `update_solution_and_residual`；
- **37 条 `cmp` 里没有一条浮点比较** → CG 是**固定迭代次数**（跑满 `linear_iterations`），没有基于残差的早退。

## 9. 更正：1.5 节里两处 f32 示例的字段名标错了

当初判 `Config = this+0x8` 时，四条证据里两条（`0x28(%rbx)` / `0x48(%rbx)`）的**字段名标错**——
偏移换算是对的，但我把 `0x28(%rbx)` 直接当成了 `Config+0x28`，忘了加基址 0x8。正确对应是：

| 指令 | 实际读的字段 |
|---|---|
| `movss 0x28(%rbx)` | `Config+0x20 = fluid_relaxation`（不是 `air_density`） |
| `movss 0x48(%rbx)` | `Config+0x40 = rigid_contact_friction_epsilon`（不是 `rigid_contact_alpha`） |
| `movss 0x50(%rbx)` | `Config+0x48 = rigid_contact_alpha` |
| `movss 0x30(%rbx)` | `Config+0x28 = air_density` |

结论（`Config = this+0x8`）不受影响——它是由 `cmpl $0x3e7, 0x20(%rbx)` 与
`mov 0x24(%rbx)` 这两条**整数**证据确定的，那两条的偏移换算当时是对的。
完整逐字段核对见 `../CONFIG_USAGE.md`（32 个字段、89 个访问点）。
