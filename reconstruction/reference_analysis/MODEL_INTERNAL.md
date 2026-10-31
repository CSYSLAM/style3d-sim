# `Model` 的 kernel 侧内部字段

`_core` 里 `synreal::Model` 是 1864 B，按值传进多个 kernel。Python 侧只暴露了 51 个字段（铺到 +0x1f0），
但 kernel 里还会读**未暴露**的内部字段。这里记录已确认的部分。

## 已确认

| 偏移 | 默认值 | 证据 | 语义 |
|---|---|---|---|
| `+0x13c` (316) | **0.03** | `granular_yield_strain`（Python 侧字段名） | `lo = rest·(1−0.03)`：每步最多收缩 3% |
| `+0x140` (320) | **0.40** | `granular_max_compaction` | `hi = min(rest, 0.4·rest + len)` |
| `+0x144` (324) | **0.1** | `granular_break_strain` | 断裂应变阈值 |

默认值来源：构造函数里 `.rodata 0x1f4760` 的两个 float `(0.03, 0.4)` 被一条 8 字节写指令整体写到 `0x13c`。

## 构造函数的写入序列（`0x9a014` 附近）

```
rep stos                      ; 先把整个对象清零
movss  %xmm0, 0x738(%rdx)     ; +1848
movabs $0x50003dcccccd447a → 0xda(%rdx)   ; +218 起 8 字节
mov    $0x4843 → 0xe2(%rdx)               ; +226  2 字节
movabs $0x3f00000044fa → 0x12a(%rdx)      ; +298
movabs $0x4348000041a0 → 0x132(%rdx)      ; +306
mov    0x1f4760(%rip) → 0x13c(%rdx)       ; +316 = (0.03, 0.4)
movl   $0x3dcccccd → 0x144(%rdx)          ; +324 = 0.1
movl   $0xc3f80 → 0x152(%rdx)             ; +338
movl   $0x3f800000 → 0x540(%rdx)          ; +1344 = 1.0
```

解包后的常量（f32）：`+218: 1000.0`, `+298: 0.5`, `+306: 20.0/200.0`, `+316: 0.03`, `+320: 0.4`, `+324: 0.1`, `+1344: 1.0`。

## 待查

- `+324 = 0.1` 被哪个 kernel 使用；
- `+1848`、`+1344` 的语义；
- 其余约 1.3 KB 未暴露字段（Python 层完全不可见）。

## kernel 侧访问图（`MODEL_ACCESS.md`）

对 PTX 里 `Model`（按值 1864 B）形参的访问做全量扫描，并把 `mov.b64 %rdN, param` +
`add.s64 %rdM, %rdN, K` 的基址链跟随一层，得到 **21 个被访问的偏移**，其中 20 个能与 Python 侧字段名对上：

| 偏移 | 字段 | 访问方 |
|---|---|---|
| 0x018 | `particle_count` | fluid ×5, granular ×2 |
| 0x030 | `particle_masses` | fluid |
| 0x078 / 0x080 | `particle_world`（ptr / size） | fluid, granular |
| 0x088 | `particle_radii` | granular |
| 0x0c0 / 0x0c8 | `fluid_particle_count` / `fluid_particle_indices` | fluid |
| 0x0d8 / 0x0dc | `fluid_rest_density` / `fluid_smoothing_radius` | fluid |
| 0x0e8 / 0x0f0 / 0x100 | fluid 边界计数/位置/体积 | fluid |
| 0x110 / 0x118 | `granular_particle_count` / `_indices` | granular |
| 0x138 | `granular_bond_damping` | granular |
| 0x13c | `granular_yield_strain` | granular |
| 0x140 | `granular_max_compaction` | granular ×3 |
| 0x144 | `granular_break_strain` | granular ×2 |
| 0x14c | `granular_bond_formation_gap` | granular ×6 |
| 0x150 | `granular_bond_formation_speed` | granular |
| 0x154 | `granular_max_dynamic_bonds` | granular |

**结论**：kernel 读的字段全部是 Python 也暴露的字段——之前"1.3 KB 隐藏区"的担心可以收敛：
隐藏成员确实存在（1848 B 之前还有大片未访问区），但**被 kernel 用到的部分没有一个是完全隐藏的**，
这也解释了为什么 `commit_bonds` 的两个系数能直接对上名字。
