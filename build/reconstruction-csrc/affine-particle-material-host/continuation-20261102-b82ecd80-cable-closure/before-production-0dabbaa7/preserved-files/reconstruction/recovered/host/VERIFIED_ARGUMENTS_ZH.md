# 主机实参与设备公式的数据对应

本文以当前 `.so` 的 x86-64 主机反汇编、设备 PTX 和运行时字段布局为依据。地址是 ELF 内的虚拟地址，不是进程加载后的绝对地址。原始指令保存在 [verified 目录清单](verified/manifest.json)，二进制 SHA-256 为 `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。

## 1. 时间步的来源与缩放

`SolverNewton::step(..., float h, ...)` 入口的 `xmm0` 保存时间步。以下各条链都追踪到调用前的实参，而不是根据反编译变量名判断。

| 数据链 | 地址与指令 | 结论 |
|---|---|---|
| 保存时间步 | `fb1ba: movss %xmm0,-0xae4(%rbp)` | 栈槽 `rbp-0xae4` 为 `h` |
| 计算平方 | `fb238: movaps %xmm0,%xmm2`；`fb599: mulss %xmm2,%xmm2` | `xmm2=h²` |
| 计算惯性系数 | `fb5af` 读常量 `1.0`；`fb5b7: divss %xmm2,%xmm3`；`fb5be` 保存到 `rbp-0xacc` | 系数为 `1/h²` |
| 右端初始化 | `fc48f` 从 `rbp-0xacc` 读入 `xmm0`；`fc4b5` 调用 `initialize_rhs` | 第一个浮点形参为 `1/h²` |
| 弯曲阻尼 | `fea95` 读 `1.0`；`feaa0` 除以 `rbp-0xae4`；`feaa8` 调用 | 标量为 `1/h` |
| 四面体阻尼 | `feb37` 读 `1.0`；`feb3f` 除以 `rbp-0xae4`；`feba7` 调用 | 标量为 `1/h` |
| 三角形空气阻力 | `fc59c` 读 `1.0`；`fc5aa` 除以 `rbp-0xae4`；`fc5c9` 调用 | 对应标量为 `1/h` |
| 流体累积 | `fed83` 读取 `rbp-0xae4`；`fed8e` 调用 `Fluid::accumulate` | 模块接收 `h` |
| 颗粒累积 | `fedc4` 读取 `rbp-0xae4`；`fedcf` 调用 `Granular::accumulate` | 模块接收 `h` |

常量 `1.0` 的地址为 `0x1fcf80`。指令原文见 [step.asm](verified/step.asm)。这里确认的是上述调用点，不能据此把所有浮点实参都替换为同一种时间缩放。

## 2. 流体 View、黏性与世界步长

`Fluid::accumulate` 在 `1207f3` 把传入的 `h` 保存到对象 `+0x760`。构造 112 字节 View 时，连续四个浮点值来自：

| View 字节偏移 | 主机来源 | 含义 |
|---|---|---|
| 96 | 对象 `+0xdc`，与 Model 同名字段一致 | 平滑半径 `h_f` |
| 100 | 对象 `+0xe0` | 体积模量 `K` |
| 104 | 对象 `+0xe4` | 黏性系数 `μ` |
| 108 | 对象 `+0x760` | 时间步 `h` |

`120bf7–120c2d` 的向量打包和 `120f1c–120f48` 的打包均形成同一顺序。字段名称同时可与 [运行时布局](../LAYOUT_RUNTIME.md) 对照。

`Fluid::limit_step(dx, relaxation, ratio, stream)` 的链条为：

1. `120d02` 保存 `ratio`；`relaxation` 保存在 `r14d`。
2. `120e1d–120e25` 以 **1.0** 调用 `initialize_scale`。
3. `120ee3` 把 `h_f` 读入 `xmm1`。
4. `120f59` 把 `relaxation` 放入 `xmm0`。
5. `120fa4` 将 `xmm1` 乘保存的 `ratio`；此时栈已下移 `0x70`，原来的 `rsp+0xc` 对应现在的 `rsp+0x7c`。
6. `120faa` 调用 `bound_scale`，两个浮点参数分别为 `relaxation` 和 `ratio*h_f`。

因此，世界尺度初始化为 1，最大位移上界为 `d_max=ratio*h_f`。没有任何流体粒子参与归约的世界保留尺度 1。黏性配对系数、缓存与回退的完整局部公式见 [算法主文第 15 节](../ALGORITHM_ANALYSIS_ZH.md#s15)。

流体主机 launch 使用 **128 线程/块**：`12086a`、`120d08`、`120ff6`、`12119b` 的 `0x100000080` 表示 `(128,1)`，另一个维度为 1；grid 对正元素数执行 `(n+127)/128`。这与 PCG 的 `256u` 模板归约配置应分别处理。原文见 [fluid.asm](verified/fluid.asm)。

## 3. 颗粒原始长度与历史长度的跨入口绑定

下表偏移均相对于 `Granular` 对象；列中保存的是设备缓冲指针。

| 键集合 | 两端索引 | 原始长度 `L0` | 历史长度 `Lh` | 活动标记 | 数量字段 | 累积调用 | 提交调用 |
|---|---|---|---|---|---|---|---|
| 初始键 | `+0x910` | `+0x930` | `+0x950` | `+0x970` | `+0x754` | `126a47` | `127052` |
| 动态键 | `+0x9f0` | `+0xa10` | `+0xa30` | `+0xa50` | `+0x758` | `126977` | `127281` |

例如初始键累积时，`rdx/rcx/r8/r9` 分别为键、`L0`、`Lh`、活动标记；提交时，相应位置为 `rsi/rdx/rcx/r8`。两者指向相同的对象字段。原始长度参与压实下限，提交只写历史长度和活动状态，语义与设备夹紧公式一致。

这确认了两类键在这两个入口之间的数据绑定；新键生成的配对、容量处理以及完整跨步调度仍是另外的问题。原文见 [granular.asm](verified/granular.asm)。

## 4. Newton 与 PD-Newton 的线性求解分派

| 调用路径 | 稀疏部分 | 对角与逆预条件类型 | 对角/逆缓存指针字段 | 附加行为 |
|---|---|---|---|---|
| `solve_pd_newton_system`，布尔参数为 false | `SparseMatrixELL` | `float / float` | `this+0x2f10 / +0x2f50` | `f1618` 调用对应 PCG 重载 |
| 同一函数，布尔参数为 true | `SparseMatrixELL` | `mat3 / mat3` | `this+0x2f70 / +0x2f90` | `f1692` 构造 affine-body 预条件回调，`f16ef` 调用 PCG |
| `solve_newton_system` | `SparseBlockMatrixELL`，`this+0x2bb8` | `mat3 / mat3` | `this+0x2f70 / +0x2f90` | `f1788` 构造回调，`f17e5` 调用 PCG |

迭代上限来自 `this+0x24`，对应 `Config.linear_iterations`。上述表格确认线性系统的存储类型和调用分支，尚不构成 PD 外层局部投影、全局步和历史缓存更新的完整数学定义。原文见 [linear_dispatch.asm](verified/linear_dispatch.asm)。
