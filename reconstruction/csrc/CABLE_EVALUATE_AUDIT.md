# evaluate_cables：源码及验证记录

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
对应旧 PTX：`_re_analysis/kernels/solver_newton/030_evaluate_cables.ptx`，11138 行。

完整 evaluate 入口已恢复并验证，至此 **131/131 个 SynReal 自有 CUDA 入口**都有可编译源码并通过本阶段验证。
这不等于完整 solver 已替代：旧库总清单还含 57 个库辅助模板入口；主机调度、绑定、模板实例化和同 demo 的
账号登录后原版/新 so A/B 仍待完成。不要把前期 NumPy 的188入口覆盖当作本轮新 so 已验收。

## 实现

`kernels/cable_evaluate.cu` 实现具名的 force、tangent product、diagonal preconditioner 公式，
复用已验证的 `cable_tangent_geometry.cuh` / `cable_strain_jacobian.cuh`。
`cable_evaluate_geometry.cuh` 保留 previous frame 的独立 w*0 舍入，避免死轴消除后被编译器提前融合。
没有用机械 PTX 包装替代源码，也没有修改旧库、认证、示例、依赖或编译参数。

已按原版确认并保留：

- 先检查 count，再按 world-local active==0 过滤；active 可为 NULL，负数视为启用。
- Force 自行计算当前 Jacobian，忽略 prepared cache；product/diagonal 读取该缓存。
- diagonal 非 NULL 时优先，包括同时传 direction 的 mixed 情况，force 输出保持原值。
- penalty 为 NULL 时使用 world-local authored base。damping 乘 inverse_dt 后加入切线权重，
  可选 bias 只加入 angular tangent，state 只从 angular force 扣除。
- 仅任一 authored damping>0 时计算 previous strain；并不根据 damping*inverse_dt 决定是否进入。
  一旦进入，四个阻尼系数均照原式使用，包含负数。twist 差再次只做一次 ±2pi 折返。
- 依原槽顺序累加 Jacobian*direction；输出采用原 y-first dot/FMA，矩阵先算六项再镜像。
  不合并同一 cable 中重复粒子 id，保持其原子写入顺序。

## GPU 证据

65 个输入场景、每 seed 311 次 evaluate 调用；六种基础模式加专项边界，
每个原版/源码进程 **12944 检查**，seed1/2/3 全通过，合计 **77664 检查**。
source 日志同时记录实际重建的 evaluate 和 pipeline prepare 入口。

比较完整 force/diagonal 数组和尾部、prepared cache 及其未写槽，以及每个非 NULL 输入数组。
包含任意朝向的近反向、零/异常惯性与仿射、NaN/Inf 四元数、NULL 或过期 force cache、
cached 模式 NULL 几何、NULL penalty/state/bias、奇数/负数/零 cache count、随机/NaN/Inf Jacobian、
正/负/零/NaN 阻尼、inverse_dt 的零/负/NaN/Inf、rest 大角度、mask、空/部分 count 和重复 id。
每 cable 的粒子与其它 cable 分离，避免把跨线程原子加的不确定顺序混入本次数学对比。

GPU 比较始终使用原始 uint32 逐位相等，包含 NaN 和有符号零；没有新增容差。
这是未修改的旧 PTX 对比新编译 CUDA，不是账号登录后完整 `_core.so` 的 demo 验收。

## 完整入口采样数据流

每 seed **311 调用、64212 次有序原子写入操作数**，最多13个采样 lane。
三 seed 合计 **933 调用、192636 写入**：地址、DAG、有限值位模式零差异；
每 seed297个有写入调用均检测到写入位翻转 mutant，其余14调用没有写入。
本轮最终 CPU NaN 符号修正数为0；GPU 仍逐位比较全部 NaN 输出。

诊断处理的范围：

1. 仅将12个 current-pose float spin 对角按原 JIT 融合建模。
   对应原块 BB74_47/86 与 prepare 已验证的 BB72_41 归一化文本完全一致；
   previous-pose 的 BB74_283/322 只参与原版的无用导数，不拿它们充当新源码输出。
2. 统一可交换因子、乘法负号位置、乘 ±1、显式 rn 和默认 rn 的表示；不任意重排求和或改 FMA。
3. 去除重复次数后，源码浮点判断均存在于原版轨迹。
   原版独有判断只来自 previous float spin 逆矩阵的 BB74_274/277/279/281/313/316/318/320，
   以及 previous Jacobian BB74_380..449。这些导数不参与阻尼值。
4. BB74_450 的 twist wrap 属于有效计算，**没有当作死代码跳过**。
   其额外 angle<-pi 检查只在结果为 false、且源码同一 angle>pi 已为 true 时归为被前一判断支配。
   三 seed 分别2/1/2次，原始判断、出处和分类都保留。
5. 诊断仅保留当前 launch 参数中确切指向的分配，所有非 NULL 根指针必须已捕获。
   seed1 的调用0/174/310分别比较全量分配/精简分配下的原版及源码完整轨迹，共6项自检通过。
   此优化只减少地址查询，未更改运算。actual GPU 参考和 source PTX 完全不改写。

旧/新完整 JIT cubin/SASS 已保存在证据目录。这些采样检查不等于全部输入、全部 GPU 的形式证明，
也不能代替接下来的 host 调度和逐 demo 测试。

## 复现

仓库根目录运行；重新审计换新 tag，避免覆盖最终证据。

```bash
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only cable_evaluate --seed 1
CABLE_EVALUATE_AUDIT_TAG=rerun-seed1 CABLE_EVALUATE_VERIFY_MEMORY=1 \
  .venv/bin/python -m reconstruction.csrc.audit_cable_evaluate_ptx 1
.venv/bin/python -m reconstruction.csrc.dump_cable_evaluate_jit
.venv/bin/python -m reconstruction.csrc.ptx_compare
```

其它 seed 使用2/3；全量 GPU 批命令保存在 `build/reconstruction-csrc/cable-evaluate-audit/run-gpu.py`。
最后的 census：45 PTX-identical、86 different、131个自有入口无缺失。
数据、源码、工具和编译产物 hashes 见同目录 `provenance-final.json`。
