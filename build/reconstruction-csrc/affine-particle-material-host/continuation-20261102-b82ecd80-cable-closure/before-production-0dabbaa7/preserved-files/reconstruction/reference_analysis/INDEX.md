# 产物索引（`_re_analysis/`）

> 由脚本生成，列出产物与**生成方式**，便于复跑与接手。

## 0. 一句话

- `.so` 里 **206** 个 CUDA entry，自研 **131** 个（另 3 个 `synreal::` 前缀的实为 thrust `_kernel_agent` 实例）；
- 已还原为可读 C++：**32 份代码 / 39 个 kernel**（部分 kernel 共享实现）；
- 主机侧：74 次 kernel launch 顺序、227 个 push 点的 grid/block、114 个字段偏移、`.rodata` 常量表。

## 1. 关键结论文件

| 文件 | 内容 |
|---|---|
| `FINAL_SUMMARY.md` | **当前真实状态**：四项子目标、两个验证数字、5 个 bug、三条已封路线 |
| `REPORT.md` | 第一层：二进制可见度总报告（4 级证据） |
| `recover/RECOVERY_REPORT.md` | 第二层：131 个 kernel 的还原结果与保真度量化 |
| `recover/PCG_PIPELINE.md` | PCG 一次完整迭代的链路（含三个特化的发射序列） |
| `recover/ASSEMBLY_KERNELS.md` | 装配类大 kernel 的结构记录（已确认/未确认分开） |
| `recover/KERNEL_COVERAGE.md` | 131 个 kernel 的覆盖表（按 SASS 体量排序） |
| `host/HOST_RECOVERY.md` | 主机侧：launch 配置、循环骨架、字段偏移、常量池 |
| `host/LAUNCH_ORDER.md` | `step` 内 74 次 kernel launch + 12 次宿主调用顺序 |
| `host/STEP_STRUCTURE.md` | 17 个最内层循环与 launch 归属 |
| `host/LAUNCH_CONFIG.md` | 227 个 push 点的 block/grid 明细 |
| `LAYOUT_RUNTIME.md` | 114 个字段偏移（Config/Model/State/Contact/Control） |
| `MODEL_INTERNAL.md` | Model 的 kernel 侧字段语义（含 `granular_yield_strain` 等真实字段名） |
| `MODEL_ACCESS.md` | **21 个被 kernel 访问的 Model 偏移，全部对上 Python 字段名** |
| `VIEW_LAYOUT.md` | **13 个按值结构的字段布局**（指针/计数/标量分类），如 `fluid::View` 10 指针 + 4 计数 + 4 标量 |
| `CONFIG_USAGE.md` | **32 个 Config 字段在 `step` 里的 89 个访问点**（含指令类型） |
| `CONTACT_USAGE.md` | **`step` 里 Contact / Control / State 的字段访问**（如 `max_count`×13、`particle_q`×9） |
| `host/HOST_PSEUDOCODE.md` | **主机侧反编译**：`solve_impl` 迭代序列 + `initialize` 的 34 个设备缓冲偏移 |
| `host/DATA_FLOW.md` | **每个 kernel launch 用到的 Solver 成员偏移**（数据从哪来） |
| `TYPE_SIZES.md` | 按值类型 sizeof 与元素尺寸（含 stride 反推） |
| `host/RODATA_REFS.md` | 按引用点提取的 `.rodata` 常量 |
| `validate/VALIDATION_REPORT.md` | **人工规格 A/B**：34 个 kernel，23 精确 / 11 容差 / 0 失败 |
| `validate/AUTO_VALIDATION.md` | **自动规格 A/B**：131 个中 **82 个有强证据**（63%：自动 77 + 人工补 5），其余已归因 |
| `CONFIG_DEFAULTS.md` | 运行时导出的 Config 默认值与枚举 |
| `api_surface.txt` | pybind11 反射：13 个类、241 个带文档成员 |

## 2. 代码产物

| 路径 | 内容 |
|---|---|
| `recover/src/<模块>/*.cu` | 机械还原，131 份，100% 指令覆盖，全部通过 nvcc |
| `recover/human/*.cu` | 人工精修 32 份 |
| `reconstructed/*.cu` | 最早的 2 个样例（弹簧力 / initialize_scale） |
| `recover/px_common.h` | `LD/ST/BASE/ByVal` 宏 |

## 3. 脚本 → 产出

| 脚本 | 作用 | 产出 |
|---|---|---|
| `extract_all.sh` | cuobjdump → 逐 kernel 拆分 → 索引 | `kernels/`、`KERNEL_INDEX.md` |
| `recover/ptx2c.py` | PTX → C 翻译器（100% 覆盖、0 未识别） | `recover/src/` |
| `recover/build_all.sh` | 批量编译 + 失败归类 | `recover/build_logs/` |
| `recover/coverage_map.py` | 覆盖表 | `recover/KERNEL_COVERAGE.md` |
| `layout_probe.py` | 运行时差分测字段偏移 | `LAYOUT_RUNTIME.md` |
| `dump_defaults.py` | import 模块读默认值 | `CONFIG_DEFAULTS.md` |
| `host/launch_cfg4.py` | push 点 grid/block | `host/LAUNCH_CONFIG.md` |
| `host/loops.py` | 回边/循环分组 | `host/STEP_STRUCTURE.md` |
| `host/launch_order.py` | 发射顺序 | `host/LAUNCH_ORDER.md` |
| `host/generic_launches.py` | 通用 launcher 的 GOT 符号 | `PCG_PIPELINE.md` 3.6 |
| `host/rodata_refs.py` | 按引用点提常量 | `host/RODATA_REFS.md` |
| `validate/ab.cpp` + `run_tests.py` | PTX JIT vs 重建 C 的逐字节比对 | `validate/VALIDATION_REPORT.md` |

## 4. 复现顺序

```bash
cd /home/oem/code/agent/style3d-sim-bin/Linux/Release
./_re_analysis/extract_all.sh _core.cpython-312-x86_64-linux-gnu.so
python3 _re_analysis/recover/ptx2c.py
cd _re_analysis/recover && ./build_all.sh
/usr/bin/python3.11 _re_analysis/layout_probe.py
python3 _re_analysis/host/launch_cfg4.py
python3 _re_analysis/host/loops.py
python3 _re_analysis/host/launch_order.py
```

## 5. 目录规模

| 目录 | 文件数 | 体积 |
|---|---|---|
| `.` | 20 | 0.9 MB |
| `cuda` | 4 | 44.6 MB |
| `kernels` | 206 | 0.0 MB |
| `recover` | 11 | 0.1 MB |
| `recover/src` | 131 | — |
| `recover/human` | 32 | — |
| `host` | 14 | 0.1 MB |

## 6. 已知缺口

| 缺口 | 影响 |
|---|---|
| 原始变量名 / 行号 / 注释 | 不可得（无 DWARF，PTX 仅 22 条 `.loc`） |
| 结构体未访问字段 | `CableView` 等只反出部分偏移 |
| 第三方 launch 的 65 处配置 | cub 运行时按 occupancy 决定 |
| `reduce_inner_product` 实参归属 | 语义已定，未逐寄存器对上 |
| 93 个 kernel 未精修 | 分类与建议见 `FINAL_SUMMARY.md` 第 4 节 |
