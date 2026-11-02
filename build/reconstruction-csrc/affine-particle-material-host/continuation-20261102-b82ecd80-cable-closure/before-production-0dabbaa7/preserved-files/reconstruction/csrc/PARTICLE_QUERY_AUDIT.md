# query_particle_pairs CUDA 验证

2026-10-30 UTC，旧so SHA256：
`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
源码：`kernels/self_collision.cu` 的 `query_particle_pairs` 和 `overlaps`。
既有CUDA入口的规范化PTX变化0，仅新增1个入口；关节CUDA文件与前一批验证后的SHA256相同。

## 结果

- particle_pairs（8检查）和新增particle_query_branches（82检查），原版/源码分别seed1/2/3，12次分组运行全部exit0。
- 源码stderr的两个组均包含`20query_particle_pairs`，没有回退。
- 每seed38次路径审计，写入地址、表达式、实际32位整数值和浮点判断全部相同。
  写入计数分别1920/1893/1967；每seed15个有候选槽写入的调用，人工乘法改加法均被检出。
  无候选/容量非正/单叶/空查询的调用没有执行距离乘法，不要求该mutation检出。
- 新诊断器只增加可选写入值和`+-offset`地址支持，默认返回格式保持原状；前一批35调用限位审计回归exit0。
- 原版/源码全部静态float操作计数相同，包含2份world/no-world分支的距离和AABB判断。
  PTX文本仍不同，差异是地址/索引、寄存器、基本块和指令排列；具体执行路径核对见报告。

当前定义91/131个SynReal CUDA入口（43 PTX-identical、48 different、40未写）。
这个计数不代表全部入口已完成严格审阅。本轮验证是直接执行旧so提取的PTX与编译源码，未登录或运行完整demo。

## 行为与参数

按旧PTX及kernel_ab的launch核对：x、particles、radius、particle_world（可NULL）、groups、boxes、parent、
children、order、escape、leaf、counts、slots、总count、每世界list长度、每世界粒子数、max_slots。

从当前粒子叶节点向根爬升；每层走兄弟子树，用escape跳过子树，重叠内部节点下降到左子节点。
每query独占一个输出行，候选顺序固定，没有原子竞争：

1. AABB重叠为闭区间，包含恰好相接；NaN参与的平面判断拒绝。
2. 只保留other particle id更大的粒子；相同非零group排除。
3. 可选world过滤：相同world，或任意一方为负world时允许。
4. 距离平方严格小于半径和的平方才写入。保留y乘积先算、两次FMA的原版顺序。
5. 饱和后立即终止，保留候选遍历顺序；counts总会覆盖有效query，未使用slots及超出count的输出保持原值。

拓扑、粒子列表、radius/group/world过滤数组每世界共享；x、BVH boxes及输出行按世界偏移。
拓扑必须是有效BVH；没有将非法指针或破坏的树作为支持输入。

## 覆盖

已有particle_pairs每seed生成不同的250叶BVH、随机位置、半径、group和world过滤；检验无过滤、过滤和饱和查询。
新增82项固定边界检查：三世界、最后一世界不足一整批、打乱粒子列表、同位置粒子、零半径、
world负值通配、相同非零group、NaN box/position、单叶树、空查询、容量-1/0/1/3/12。

新增用例将完整counts/slots（包括未使用槽及尾部哨兵）与冻结NumPy规格逐位比较，
先独立验证原版，再切到源码。另显式确认恰好距离=半径和时拒绝，相邻float内侧接受、外侧拒绝；
确认饱和分支、同group和单叶树确实产生预期结果。边界组本身是固定数据，随机覆盖来自原有粒子组。

## 命令及证据

从仓库根目录执行，seed同样取2和3：

```bash
.venv/bin/python -m reconstruction.kernel_ab --only particle_query_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only particle_query_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only particle_pairs --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_particle_query_ptx 1
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff query_particle_pairs
```

`build/reconstruction-csrc/particle-query-audit/`：

- gpu-final-summary.json、final-*.json/.err：12次最终GPU组运行。
- audit-final-summary.json、dataflow-final-seed*.log、dataflow-seed*.json：38调用/seed路径核对。
- legacy.txt、final.ptx、final.diff、float-op-counts-final.json：PTX依据及计数。
- changed-entries-final.json、ptx-status-final.txt：既有入口未变和完整编译统计。
- self_collision-before.cu、kernel_ab-before.py、audit-drive-before.py：本批前的源码和精确诊断器版本。
- regression/limits-audit、limits-regression-seed1.log：诊断器默认API回归。
- provenance-final.json：最终源码、报告及证据SHA256。

没有修改冻结规格、旧测试、容差、旧so、src/examples、依赖或认证，未commit/reset/checkout。
数据流工具不模拟JIT指令融合，必须继续和GPU逐位验证共同使用。
下一项建议`query_edge_face`，然后其它自碰撞查询/累加入口。
