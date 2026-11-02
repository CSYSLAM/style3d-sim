# CUDA kernel 全量导出说明

从 `_core.cpython-312-x86_64-linux-gnu.so` 的 `.nv_fatbin` 中把 **6 份 PTX / 218 条 entry** 全部拆出来，按源文件分组，落到 206 个独立文件。

## 目录结构

```
_re_analysis/
├── KERNEL_INDEX.md          # 总清单：每个模块的自研 kernel 表（SASS 指令数/PTX 行/寄存器/maxntid/特征）
├── CHECKLIST.md             # 打勾清单：按模块列出全部 131 个自研 kernel（另有 3 个 `synreal::` 前缀的实为 thrust 包装），供逐条对源码
├── kernel_prototypes.h      # 精确原型：类型已归一化，行尾带 SASS 指令数
├── TYPE_SIZES.md            # 按值传递类型的 sizeof（View / Model / Aabb …）
├── kernels.json             # 机器可读：206 条记录的完整元数据
├── kernels/
│   ├── solver_newton/       # 97 个（自研 85）
│   ├── fluid/               # 15 个（自研 8）
│   ├── granular/            # 24 个（自研 8）
│   ├── pcg_solver/          # 20 个（自研 12）
│   ├── self_collision/      # 21 个（自研 16）
│   └── lbvh_builder/        # 29 个（自研 5）
├── cuda/
│   ├── all.ptx              # 6.17 MB，原始 PTX 汇总
│   ├── all.sass             # 40.5 MB，SASS 反汇编
│   ├── res_usage.txt        # ptxas 资源占用（REG/SHARED/LOCAL/CONSTANT）
│   └── kernels_pretty.txt   # 131 个 demangle 后的原型
└── reconstructed/           # 已逐条还原的样例（弹簧力 / initialize_scale）
```

每个 kernel 文件头长这样，可直接定位：

```
// [fluid.cu] kernel 3/15   PTX 72 行   SASS 160 条指令
// 签名: synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec3 const*, float, float, float*)
// 归一化原型: synreal::fluid_kernel::bound_scale(synreal::fluid_kernel::View, glm::vec3 const*, float, float, float*)
// maxntid: (未指定)   ptxas: REG=12 SHARED=0 LOCAL=0
// 计数: atomic=1 div=1 sqrt=1 barrier=0 local=0 branch=2
```

## 对照流程（建议按这个顺序）

1. **先对签名**：`kernel_prototypes.h` 里逐个 `diff`。类型/参数个数/顺序对不上，说明版本或 `View` 结构不一致，先解决这个。
2. **再对结构**：打开 `kernels/<模块>/NNN_<名>.ptx`，看 SASS 指令数、`atomic` 次数、`branch` 数。这三项和你源码里的 `atomicAdd` 个数、分支结构一一对应。
3. **再对公式**：PTX 里 `div.rn.f32` = `/`，`fma.rn.f32` = `a*b+c`（编译器合成，源码可能分开写），`sqrt.rn.f32` = `sqrtf`，`red.global.add.f32` = `atomicAdd`。按这个映射逐段抄。
4. **再对结构体**：用 `TYPE_SIZES.md` 的 `sizeof` 卡你本地 struct 定义（`CableView` 160、`HardContactView` 312、`Model` 1864 …）。
5. **最后对边界**：PTX 开头的 `setp.ge.u64 → @%p bra` 就是 `if (i >= n) return;`，这是每个 kernel 的线程越界保护，和你源码的 early-return 一定一致。

## 三个必须知道的偏差

1. **`__device__` 辅助函数全被内联**：PTX 里 `.func` 数量为 **0**，所有 `__forceinline__` 设备函数都摊平进了 kernel。所以你的源码若是 200 行 + 若干 helper，PTX 可能 3000 行——**行数不能直接比，要比"公式和内存访问模式"**。
2. **循环可能被展开**：`lbvh_builder.cu` 的 `build_radix_tree` 之类大 kernel 有 `.local` 数组 + 大量 `ld.local`，是展开后的痕迹。
3. **自研 kernel 一个都没写 `__launch_bounds__`**：`.maxntid` 只出现在 thrust/cub 实例上（radix sort 用 `160`/`512`，其余 `256`）。所以 block 大小是主机侧 `<<<grid, block>>>` 传的，PTX 里查不到——这一项要去主机代码对，别在 PTX 里找。

## 复现

```bash
cd /home/oem/code/agent/style3d-sim-bin/Linux/Release
./_re_analysis/extract_all.sh _core.cpython-312-x86_64-linux-gnu.so
```

脚本会依次做：`cuobjdump -ptx/-sass` → 抽 6 个 cubin 到 `/tmp/cubins` → `build_all.py` 拆分成 206 个文件并生成索引/原型/清单 → `make_types.py` 生成类型尺寸表。
