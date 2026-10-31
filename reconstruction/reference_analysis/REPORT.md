# synreal `_core` 扩展二进制可见度分析报告

分析对象：`/home/oem/code/agent/style3d-sim-bin/Linux/Release/`
分析日期：2026-10-26
分析方式：ELF 静态结构 → 符号表 → pybind11 运行时反射 → CUDA fatbin（PTX/SASS）

---

> **阅读须知（第 34 轮补）**：本文是最早写的"可见度评估"，回答的是"能拿到什么"。
> 后续 30 多轮做了实际还原与数值验证，**当前进度与结论请看 `FINAL_SUMMARY.md`**：
> 131 个 kernel 已全部可加载、可编译；人工规格 34 个数值验证全过；自动规格 77 个有强证据。
> 本文第 4 节的工期估算基于"逐行重写"，实践下来比估算更省——因为 PTX 可机械翻译（已有 131/131 份）。

## 0. 一句话结论

**看不到原始的 `.cpp` / `.cu` 文本，但算法本身是"实质完全可见"的——而且比一般商业库泄露得更彻底。**

原因不是有哪个环节被破解，而是产物里同时留下了三样东西：

| 层 | 遗留物 | 后果 |
|---|---|---|
| Python 绑定层 | pybind11 docstring 全量保留 | 等于拿到一份 API 说明书 + 每个配置项的物理含义 |
| 主机侧符号 | **未 strip**（6503 条符号，其中具名 4127 条：局部函数 1351、模板实例 1093） | 求解器整体架构 + 每个函数签名（含模板实参、glm 类型）全暴露 |
| GPU 侧 | `.nv_fatbin` 里 **6 份 PTX**（206 个 kernel）+ 6 份 sm_52 SASS | 设备端算法可逐行还原，不是"猜"，是"抄" |

看不到的只有三样：**原始注释、DWARF 行号/局部变量名、作者的行文风格**。这些不影响算法复现。

---

## 1. 目标文件客观信息

| 项 | `_core.cpython-311-...so` | `_core.cpython-312-...so` |
|---|---|---|
| 大小 | 7,970,904 | 7,977,432 |
| sha256 | `7a2579e2…c7cb0b` | `4c223854…db34e6` |
| 构建 | GCC 11.4.0 (Ubuntu 22.04) | 同 |
| 加载器 | CPython 3.11 / 3.12 扩展模块，`PyInit__core` | 同 |
| 绑定框架 | **pybind11**（非 Cython、非 pybind11-stubgen 精简版） | 同 |
| 依赖 | `libcudart.so.12`、`libssl.so.3`、`libcrypto.so.3`、`libstdc++` | 同 |
| 调试信息 | **无** `.debug_*` 段 | 同 |
| 符号表 | **存在**，6503 条（具名 4127），`.strtab` 512,458 字节 | 6482 条（具名 4108） |
| CUDA 载荷 | 6 cubin (sm_52) + 6 PTX (ISA 8.4)，`.nv_fatbin` ≈ 4.7 MB | 同 |

两个版本除 CPython ABI 外内容等价，**下面所有结论对两个文件同时成立**（本文档命令以 312 为例）。

---

## 2. 可见度分级（按"拿到它有多省事"排序）

### 级别 A：pybind11 反射 —— 算法说明书，连参数物理含义都给了

模块没有做任何文档剥离，`__doc__` 完整保留。而且 `_core.cpython-311` 与本机 Python 3.11 的 ABI 匹配（206 kernel / 4108 具名符号，与 312 版等价），**可以直接 import 后 `dir()` 反射**：

```bash
/usr/bin/python3.11 _re_analysis/dump_api_full.py     # 已执行，产物 api_surface.txt
```

输出 606 行，13 个类 + `login` / `is_logged_in` / `set_log_callback`，241 个带文档的成员。摘录（原文照抄，未改写）：

```
### Solver
Time-step solver for a Synreal simulation model.
Call initialize() once with a configured Model before calling step().
  .step: step(self, state_in, state_out, control, contact, dt, stream=None) -> None
```

```
### Config
  .affine_body_rigidity_model  ::  Rigidity law used for affine bodies:
                                   co-rotated, original ABD orthogonality, six springs, or SO(3) AL.
  .affine_body_rigidity_primal_iterations
        :: Primal Newton iterations performed with a fixed affine-body SO(3) AL state
           before each update.
  .cable_penalty_gamma  ::  Cable penalty decay per step, clamped to its initial floor and authored cap.
  .joint_constraint_mode :: Joint-constraint enforcement method; PENALTY preserves the legacy behavior.
  .nonlinear_solver :: Implicit-Euler nonlinear method: NEWTON or the legacy PD_NEWTON method.
  .rigid_contact_friction_epsilon
        :: VBD-style rigid Coulomb smoothing speed [m/s]; zero preserves the native secant law.
  .rigid_contact_sliding_tangent
        :: Differentiate the hard-contact Coulomb disk at fixed normal load;
           False keeps the legacy tangent.
  .enable_collision_hessian_non_diagonal :: Include coupled contact tangents for rigid,
           particle-shape, and all self-collision contacts...
```

也就是说：**算法流派（ABD / co-rotated / SO(3) AL / VBD / PD-Newton）、每个开关的数学作用、单位、零值语义、legacy 行为对照，全在二进制里。** 这不是"泄露实现细节"，这是"泄露设计文档"。

### 级别 B：未 strip 的符号表 —— 整个求解器的骨架图

```bash
nm -a -C _core.cpython-312-x86_64-linux-gnu.so | grep synreal
```

| 统计 | 数量 |
|---|---|
| symtab 总条目 | 6503（含段/文件符号） |
| 局部函数（`t`，保留名字） | 1351 |
| 弱符号/模板实例（`W`） | 1093 |
| 导出（`T`） | 359 |
| CUDA kernel 名（`synreal::` 前缀，含完整模板实参） | 134（其中 3 个是 `_kernel_agent` 包装 → 自研 131） |

函数名把架构讲完了，例如（demangle 后原文）：

```
synreal::SolverNewton::step(State const&, State const&, Control const&, Contact const&,
                            float, CUstream_st*)            ← 主时间步
synreal::SolverNewton::solve_newton_system(...)             ← Newton 线性求解
synreal::SolverNewton::solve_pd_newton_system(...)          ← PD-Newton 分支
synreal::SolverNewton::affine_body_preconditioner(...)      ← ABD 预条件
synreal::SolverNewton::precompute_matrices(...)
synreal::fluid_kernel::{build_grid, evaluate_rows, accumulate_rows, multiply_rows, bound_scale}
synreal::granular_kernel::{form_bonds, commit_bonds, accumulate_contacts, multiply_bonds}
synreal::self_collision_kernel::{build_primitive_leaf_nodes, build_edge_aabbs,
                                 build_triangle_aabbs, refit_bvh, multiply_contact_tangents}
synreal::kernel::evaluate_hard_contacts(...)                ← 硬接触
synreal::kernel::evaluate_cables(...)                       ← 线缆
synreal::kernel::evaluate_affine_body_so3_augmented_lagrangian_force(...)
synreal::kernel::{add_*_gauss_newton_hessian, add_*_preconditioner, apply_*_preconditioner}
```

模板实参也在名字里，比如 `kernel::build_affine_body_preconditioner<BlockNonZeroEntry>` /
`<NonZeroEntry>` 两个实例并存 —— 直接告诉读的人"稀疏块结构有两套布局"。

CUDA kernel 的**形参类型完全展开**，等于拿到了设备端函数原型：

```
synreal::kernel::evaluate_spring_force(
    const glm::vec3*, const glm::vec2i*, const float*, const float*,
    glm::vec3*, unsigned long, unsigned long, unsigned long)
synreal::kernel::add_cloth_membrane_gauss_newton_hessian(
    const glm::vec3*, const glm::vec3i*, const glm::mat2*, const float*,
    const glm::vec3*, glm::mat3*, const int*, synreal::BlockNonZeroEntry*, ...)
```

### 级别 C：CUDA fatbin 里嵌了 PTX —— 设备端算法可逐行还原

这是最要命的一环。fatbin 里 **PTX 与 SASS 同时存在**（默认 `-gencode arch=compute_52,code=[compute_52,sm_52]` 的产物）：

```bash
cuobjdump -lelf  _core.cpython-312-x86_64-linux-gnu.so   # 6 个 sm_52 cubin
cuobjdump -lptx  _core.cpython-312-x86_64-linux-gnu.so   # 6 个 PTX（压缩存储，工具自动解压）
cuobjdump -ptx   _core.cpython-312-x86_64-linux-gnu.so > all.ptx    # 6.17 MB / 206 kernel
cuobjdump -sass  _core.cpython-312-x86_64-linux-gnu.so > all.sass   # 40.5 MB / 323,094 行
```

PTX 分块与源文件对应关系直接从 `_INTERNAL_*` 符号读出来：

| PTX# | 对应 `.cu` | entry 数 | 大小 |
|---|---|---|---|
| 1 | `solver_newton.cu` | 97 | 3.43 MB |
| 2 | `fluid.cu` | 15 | 90 KB |
| 3 | `granular.cu` | 24 | 129 KB |
| 4 | `pcg_solver.cu` | 20 | 530 KB |
| 5 | `self_collision.cu` | 21 | 227 KB |
| 6 | `lbvh_builder.cu` | 29 | 1.76 MB |

PTX 是**带虚拟寄存器、带类型、带分支标签的结构化中间表示**，不是汇编级别的"噪音"。举例：`initialize_scale` 全部 32 行 PTX 就是

```
mad.lo.s32  %r1, %r3, %r4, %r5      // i = blockIdx.x*blockDim.x + threadIdx.x
setp.ge.s32 %p1, %r1, %r2           // i >= n ?
mul.wide.s32 %rd3, %r1, 4           // i * 4
st.global.f32 [%rd4], %f1           // out[i] = value
```

→ 还原结果见 `_re_analysis/reconstructed/initialize_scale.cu`（1:1，无歧义）。

更有代表性的是 `evaluate_spring_force`，113 行 PTX 足以把公式完整抄回来，包括**符号约定和批处理布局**（这些在头文件里都看不出来）：

```
div.u64 %rd46, %rd1, %rd15          // batch = i / springs_per_batch
sub.s64 %rd47, %rd1, batch*N        // slot  = i % springs_per_batch
mul.lo.s64 %rd24, %rd46, %rd16      // offset = batch * particle_stride
sub.f32  (x3)                       // d = x[b] - x[a]
fma.rn.f32 (x2) + sqrt.rn.f32       // len = |d|
setp.leu.f32 %p3, %f6, 0f00000000   // 退化保护: len <= 0 跳过归一化
div.rn.f32 (x3)                     // unit = d / len
mul.f32 %f20, %f5, %f19             // rest_len * unit
sub.f32 (x3) / mul.f32 %f28, %f4, %f25   // f = k * (d - rest_len*unit)
red.global.add.f32 [a], f  /  [b], -f    // atomicAdd 到两端点，符号相反
```

→ 完整还原见 `_re_analysis/reconstructed/evaluate_spring_force.cu`，即

```cpp
f = k * (|d| - rest) * (d / |d|)   // 标准 Hooke, 逐弹簧 k, 多 batch 偏移
```

**这就是"能不能看到算法"的直接答案：核心公式不是"推测出来"的，是读出来的。**

另外 `.sass` 里 323,094 行、206 个 kernel，含全部 cub/thrust 实例（`DeviceRadixSort*`、`DeviceReduceKernel` 等），说明 LBVH 用的是 CUB radix sort —— 连第三方算法选型都不用猜。

### 级别 D：主机侧 C++ 反编译 —— 近源码级

主机 `.text` = 1.55 MB（0x17b482），无 DWARF，所以**没有行号、没有局部变量名**。但因为符号全在，Ghidra/IDA 反编译出来是"函数名齐全、类型齐全"的 C++：

```bash
objdump -d -C --no-show-raw-insn _core.cpython-312-x86_64-linux-gnu.so | less
```

对比一下：一个被 strip 的库，反编译出来是 `FUN_0012ab40(void*, long)`；你这个是
`synreal::SolverNewton::solve_newton_system(Span<glm::vec3 const>, unsigned long, std::function<...> const&, CUstream_st*)`。
**中间差的不是一点工作量，是"要不要重建设计"的区别。**

---

## 3. 顺带泄露的元信息（比算法更该在意）

这些不是算法，是运营信息，风险等级更高：

| 类别 | 泄露内容 | 出处 |
|---|---|---|
| CI 路径 | `/mnt/d/GitLab-Runner/builds/023e6bf74/0/Simulation/synreal-solver/bindings/python/auth.h` | `.strtab`（`auth.h` 的 `__FILE__`/预处理路径） |
| 仓库结构 | 项目名 `synreal-solver`，模块 `bindings/python`，Windows 侧 `D:\` 盘 runner | 同上 |
| 源文件清单 | `module.cpp client.cpp http.cpp utils.cpp logger.cpp protocol.cpp signature.cpp` + 6 个 `.cu` | `_GLOBAL__sub_I_*` / `_INTERNAL_*` |
| 授权服务端 | `https://software.style3d.com`<br>`https://apigateway-test.style3d.com/cloud.x/software` | `.rodata` 明文字符串 |
| 协议字段 | `accessToken`、`expiresIn`、`invalid_token`、`invalid_response_signature`、`Bearer `、`auth-int` | 同上 |
| 业务文案 | `Authentication failed! Account signed in other device!`、`Authenticate the SynReal client.` | 同上 |
| HTTP 栈 | `httplib::SSLClient`（cpp-httplib + OpenSSL） | `_ZTIZZN7httplib9SSLClient...` |
| 内部命名空间 | `s3dnet::Client::startHeartbeat(std::chrono::duration<long, std::ratio<1,1>>)` | 符号表 |

**这意味着**：测试网关域名、字段名、签名校验失败的分支名全部可读；再配合 `libcrypto` 的本地验签逻辑（`signature.cpp` 的符号也在），"改二进制跳过授权"是纯体力活，不是难题。既然这是你自己的产品，这条建议优先级应高于算法保密。

---

## 4. 还原成本评估（现实口径）

| 目标 | 可行性 | 估算 |
|---|---|---|
| 拿到完整 API 与配置语义 | 已达成（`import` 即可） | 0.5 天 |
| 还原 131 个自研 CUDA kernel 的公式 | **已完成机械化**：131 份逐指令翻译，100% 覆盖，131/131 编译通过 | 已达成（见 `recover/`） |
| 还原 Newton/PCG 主机调度 | 已恢复：74 次 launch 顺序、17 个循环、两层迭代计数器、`solve_impl` 单轮序列 | 已达成（见 `host/`） |
| 编出可跑的同构求解器 | 需自己写测试对齐数值 | 再加 2–4 周 |

结论：**"抄算法"的门槛是几周工程时间，不是"不可能"。** 若这套求解器是产品护城河，当前发布形态等于把护城河标注在地图上。

---

## 5. 复现步骤（一条龙）

```bash
cd /home/oem/code/agent/style3d-sim-bin/Linux/Release
export PATH=/usr/local/cuda/bin:$PATH
F=_core.cpython-312-x86_64-linux-gnu.so

file $F && readelf -SW $F | grep -Ei 'debug|symtab|nv_fatbin'   # 无 debug 段、有 symtab、有 fatbin
readelf -p .comment $F                                            # GCC 11.4.0
nm -a -C $F | grep synreal                                        # 主机侧骨架
cuobjdump -lptx $F && cuobjdump -lelf $F                          # 6 PTX + 6 cubin
cuobjdump -ptx  $F > _re_analysis/cuda/all.ptx                    # 206 kernel
cuobjdump -sass $F > _re_analysis/cuda/all.sass
/usr/bin/python3.11 _re_analysis/dump_api_full.py                 # pybind11 反射
```

---

## 6. 加固方案（按性价比排序）

### 6.1 立刻做（几乎零成本，收益最大）

1. **strip 符号**：`objcopy --strip-all` 或链接时 `-s`。
   ```bash
   cp $F $F.bak && objcopy --strip-all $F && nm -a $F | wc -l   # 期望 0
   ```
   注意：**只 strip `.symtab`，不要动 `.dynsym`**（`PyInit__core` 必须导出）。
2. **不嵌 PTX**：只保留 SASS。
   ```cmake
   # 去掉 compute_XX，只留 sm_XX
   set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -gencode arch=compute_52,code=sm_52")
   ```
   验证：`cuobjdump -lptx $F` 应输出空（当前输出 6 行）。
3. **关掉 pybind11 自动签名**：
   ```cpp
   py::options opts;
   opts.disable_function_signatures();   // 去掉 "(self: _core.Solver, ...) -> None"
   ```
   并停止在 `def()` 第三个参数写说明性 docstring（尤其 `Config` 那 40 多个属性的物理含义）。
4. **`-fvisibility=hidden`**：把非绑定符号全部隐藏，配合 strip 后连 `synreal::` 命名空间都不剩。

### 6.2 结构性调整（1–2 天）

5. **不要用 `__FILE__` 参与构建**：`auth.h` 路径泄露来自断言/日志宏。用 `-DNDEBUG` 关断言，日志宏改成只打模块名。
6. **授权校验外移**：本地只做"验证服务端签发的短期票据"，把 `accessToken` 流程、签名算法、错误分支从客户端移走；现在 `signature.cpp` + `libcrypto` + 明文 URL 三者齐备，本地绕过成本极低。
7. **域名/字段名不再明文**：测试网关 `apigateway-test.style3d.com` 不应出现在 release 产物里（编译期常量换成运行时注入）。

### 6.3 真要防逆向（成本高，按需）

8. `lto` + `-O3` 后 strip，能抹掉跨编译单元的语义化符号；
9. 自定义 mangling（内部命名空间改成无语义短名），避免 `evaluate_affine_body_so3_augmented_lagrangian_force` 这种自解释名字进入产物；
10. 关键 kernel 做常量/控制流混淆（把系数拆成运行时派生值），提高 PTX/SASS 阅读成本；
11. 最终手段：把核心 solver 放到服务端，客户端只留传输层。

### 6.4 验收清单

```bash
nm -a $F | wc -l                      # 0（.symtab 已删）
cuobjdump -lptx $F                    # 空（无 PTX）
cuobjdump -lelf $F                    # 仍有 sm_52 cubin（正常，硬件需要）
strings -a $F | grep -Ei 'style3d|GitLab-Runner|\.cu$'   # 空
/usr/bin/python3.11 -c "import _core as c; print(c.Solver.step.__doc__)"  # 只剩签名，无说明
```

---

## 7. 关于 "purge 插件"

`purge_apply / purge_revert / purge_status` 是 DSH 的**指令权威性清洗插件**（补丁提示词层与代码默认值），它只输出插件/补丁状态，不具备二进制分析能力 —— 本次调用它得到的只是 `58/63 applied` 这类状态信息。上面所有结论来自 `readelf / nm / objcopy / cuobjdump / python3.11` 链路。

---

## 8. 本次产物

| 路径 | 内容 |
|---|---|
| `_re_analysis/README.md` | 产物说明 + 5 步源码对照流程 + 3 个必知偏差 |
| `_re_analysis/KERNEL_INDEX.md` | **206 个 kernel 全清单**：按 6 个 `.cu` 分组，含 SASS 指令数/PTX 行/REG/maxntid/atomic 计数 |
| `_re_analysis/CHECKLIST.md` | 131 个自研 kernel 的打勾清单，用于逐条对源码 |
| `_re_analysis/kernel_prototypes.h` | 131 个精确原型（类型归一化，行尾标 SASS 指令数） |
| `_re_analysis/TYPE_SIZES.md` | 按值传递类型 `sizeof`：`CableView`=160、`HardContactView`=312、`Model`=1864 … |
| `_re_analysis/kernels/<模块>/NNN_<名>.ptx` | 每个 kernel 一份完整 PTX，文件头带签名/原型/寄存器/特征计数 |
| `_re_analysis/kernels.json` | 机器可读元数据（206 条，不含 PTX 正文） |
| `_re_analysis/api_surface.txt` | 606 行 pybind11 反射结果：13 个类、241 个带文档成员 |
| `_re_analysis/cuda/all.ptx` | 6.17 MB，6 份 PTX 汇总 |
| `_re_analysis/cuda/all.sass` | 40.5 MB，323,094 行 SASS |
| `_re_analysis/cuda/res_usage.txt` | ptxas 逐 kernel 资源占用 |
| `_re_analysis/reconstructed/*.cu` | 已逐条还原的样例（弹簧力、initialize_scale） |
| `_re_analysis/extract_all.sh` | 一键复现（`./extract_all.sh [so]`） |
| `_re_analysis/host_symbols.txt` | 主机侧 `synreal::` / `s3dnet::` 符号清单 |
