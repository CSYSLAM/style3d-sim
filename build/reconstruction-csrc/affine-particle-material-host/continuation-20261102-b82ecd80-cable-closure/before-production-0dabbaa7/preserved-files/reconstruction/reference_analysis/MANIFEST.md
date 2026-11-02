# 交付清单（第 38 轮）

对象：`_core.cpython-312-x86_64-linux-gnu.so`  ·  工作目录 `_re_analysis/`（约 65 MB）

## 文档（18 份）

| 文件 | 作用 |
|---|---|
| `FINAL_SUMMARY.md` | 最终结论：82/131 覆盖、6 个 bug、三条封死的路 |
| `INDEX.md` | 产物索引 + 复现命令 |
| `REPORT.md` | 可见度评估（最早写的，含阅读须知） |
| `KERNEL_INDEX.md` | 206 个 entry 的清单 |
| `CHECKLIST.md` | 131 个 kernel 的逐条对照清单 |
| `LAYOUT_RUNTIME.md` | 114 个字段偏移 |
| `MODEL_ACCESS.md` | 21 个 Model 偏移 → 字段名 |
| `MODEL_INTERNAL.md` | Model 隐藏字段语义 |
| `VIEW_LAYOUT.md` | 13 个按值结构的字段布局 |
| `TYPE_SIZES.md` | 按值类型 sizeof |
| `CONFIG_DEFAULTS.md` | 运行时导出的默认值 |
| `CONFIG_USAGE.md` | 32 个 Config 字段的 89 个访问点 |
| `CONTACT_USAGE.md` | Contact/Control/State 的字段使用 |
| `recover/RECOVERY_REPORT.md` | 还原与保真度 |
| `recover/PCG_PIPELINE.md` | CG 一次完整迭代 |
| `recover/ASSEMBLY_KERNELS.md` | 装配类大 kernel 记录 |
| `recover/KERNEL_COVERAGE.md` | 131 个 kernel 的覆盖状态 |
| `host/HOST_RECOVERY.md` | launch 配置/循环/字段 |
| `host/HOST_PSEUDOCODE.md` | solve_impl + initialize 反编译 |
| `host/DATA_FLOW.md` | kernel ← Solver 成员 |
| `host/LAUNCH_ORDER.md` | 74 次 launch 顺序 |
| `host/STEP_STRUCTURE.md` | 17 个循环分组 |
| `host/LAUNCH_CONFIG.md` | 227 个 push 点 |
| `host/RODATA_REFS.md` | .rodata 常量 |
| `validate/VALIDATION_REPORT.md` | 人工规格验证 + 6 个 bug |
| `validate/AUTO_VALIDATION.md` | 自动规格验证 + 并集 82 |

## 代码与数据

| 内容 | 数量 | 体积 |
|---|---|---|
| `kernels/` 逐 kernel PTX | 253 个 | 6.1 MB |
| `recover/src/` 机械还原 | 131 份 | 3.8 MB |
| `recover/human/` 人工精修 | 32 份 | 0.0 MB |
| `validate/` 测试台与结果 | 340 个文件 | 10.5 MB |

## 脚本（可复跑）

| 脚本 | 作用 |
|---|---|
| `extract_all.sh` | fatbin → 逐 kernel PTX |
| `recover/ptx2c.py` | PTX → C（100% 覆盖） |
| `recover/build_all.sh` | 批量编译 + 失败归类 |
| `validate/ab.cpp` + `run_tests.py` | 人工规格 A/B |
| `validate/auto_ab.py` | 自动规格 A/B（131 个） |
| `host/*.py` | launch/循环/数据流分析 |
| `model_offsets.py` / `view_layout.py` / `config_usage.py` / `contact_usage.py` | 字段语义 |

## 关键数字

| 指标 | 值 |
|---|---|
| 自研 kernel | 131 |
| PTX 指令 / 未识别 | 106,099 / 0 |
| 机械还原编译 | 131/131 |
| 人工规格 A/B | 34/34（23 精确 + 11 容差） |
| 自动规格 A/B | 77 强证据 + 0 加载失败 |
| 并集覆盖 | 82/131（63%） |
| 修掉的 bug | 6（含 2 个翻译器级） |


## 体积说明（第 38 轮清理）

`recover/build_logs/` 里原有 131 个 nvcc 日志，单文件最大 179 MB，合计 **1.5 GB**。
它们只是编译器的完整 stderr，与交付无关。已截断为末尾 40 行（保留错误/警告摘要），
**释放 1467 MB**；`summary.txt`（`OK=131 FAIL=0`）与 131 个 `.cubin` 产物保留。
