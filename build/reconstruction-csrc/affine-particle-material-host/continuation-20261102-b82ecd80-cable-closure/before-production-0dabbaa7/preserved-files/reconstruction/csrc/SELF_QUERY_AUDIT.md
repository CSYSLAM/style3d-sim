# 三个网格自碰撞查询 CUDA 验证

2026-10-30 UTC。本批新增 `query_edge_face`、`query_edge_edge`、`query_vertex_face`，源码在
`kernels/self_collision.cu`。复用父/左右子节点遍历，几何函数为正常 CUDA/C++，没有内联 PTX 包装。
旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。

## 结果

原版和源码各执行seed1/2/3：

- self_queries：7项折叠布料查询检查，三个目标入口全部使用csrc。
- mesh_query_branches：最终128项边界检查，三个目标入口全部使用csrc。
- particle_query_branches：82项既有粒子查询回归，使用csrc。

共18个最终分组结果全部通过。为减少重复编译，每个backend在一个进程中跑完各seed，缓存编译PTX；
极薄三角形用例随后只重跑了新增几何组，其它源码/测试均未改变。

每seed60次小场景PTX路径审计：写入地址/表达式/实际整数值/浮点判断零差异，写入数3653/3610/3641。
另重新执行最初发现EE判断差异的折叠布料seed1全部7次调用，修复后写入和判断均零差异。
既有CUDA入口的规范化PTX变化0，新增3；当前94/131个定义（43 identical、51 different、37未写）。
定义数不等于全部入口已严格验收；本批没有账号登录、完整求解器或demo级验收。

## 还原的关键行为

参数含义和次序按kernel_ab旧launch核对，mangled name与旧PTX对应。
所有拓扑、索引、group以及可选vertex-radius为世界共享；x、nodes和输出按各自世界跨度寻址。

- 三类网格查询从根节点出发，记录previous/current，通过parent/children返回，按固定顺序填槽。
  这与粒子查询的escape-link遍历不同，未混用。
- EF仅做2r扩张盒、共享顶点排除和6组group条件；不添加距离测试。
- EE仅保留j>i且端点不共享的边；四组group条件；距离阈值保持 `(radius*9)*radius`。
  最近点参数保留1e-5退化判断、误差补偿的difference-of-products、显式FMA及cvt.sat。
- VF支持可选按local vertex寻址的半径、skip_incident以及三组group条件。
  距离阈值保持 `((r+extra)*1.5)^2`；七个三角形区域和面积平方<1e-20时的三线段fallback逐项恢复。
- group条件为相同或任意一方为负；容量不足立即退出，未用槽和超出count的输出保持原值。

初版GPU整数结果已通过，但PTX路径审计发现EE中ordered le与unordered leu不同。
按原PTX将退化分支恢复为 `uu <= 1e-5`、`vv <= 1e-5`，不以 `!(uu > ...)` 替代。
在NaN输入下也保持原路径；没有修改冻结NumPy规格去迁就源码。

最终VF的全部float操作计数与原版一致；EE的算术/判断计数一致，加载/临时寄存器安排不同。
EF将原版group/no-group两份遍历的盒判断共享，静态少一份6-plane判断；每条实际路径的判断完全一致。
三个入口仍是PTX-DIFFERENT，完整diff及路径报告保留，不修改文本比较工具或编译参数。

## 新用例

mesh_query_branches使用三世界与partial tail，完整counts/slots/未用区/尾部哨兵和冻结规格逐位比较。
覆盖：三角形七个区域、共线/点三角形、面积阈值附近的极薄三角形、精确距离阈值及两侧、
线段两端退化/单端退化/平行/交叉/近退化、共享顶点、group负值通配、可选vertex半径、
skip_incident开/关、NaN query/edge端点、容量0/1/4/20和饱和。
另明确确认EF只做broad phase：位于三角形实际区域外但盒重叠的边仍被收集。

扩展NaN用例时，一次新fixture变量替换错误造成UnboundLocalError，发生在launch前，已修复并重跑。
极薄三角形扩展前的127项报告保留；最终mesh报告为128项，汇总以expanded-gpu-*-summary为准。
诊断器仅增加cvt.sat.f32.f32支持，未改变既有指令语义或比较标准。
数据流工具不能模拟JIT融合，须与GPU结果同时使用。

## 复现

仓库根目录，seed同样取2/3：

```bash
.venv/bin/python -m reconstruction.kernel_ab --only mesh_query_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only mesh_query_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only self_queries --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_self_queries_ptx 1
# 原始折叠布料路径
.venv/bin/python -m reconstruction.csrc.audit_self_queries_ptx 1 folded
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff query_edge_face query_edge_edge query_vertex_face
```

证据 `build/reconstruction-csrc/self-query-audit/`：

- gpu-final-summary.json、final-*.json/.err：合并后的18项最终分组结果。
- gpu-*-summary.json：初轮批量结果；expanded-gpu-*-summary.json：最终128项几何组。
- audit-final-summary.json、dataflow-final-seed*.log、dataflow-seed*.json：60调用/seed审计。
- folded-dataflow-seed1.json、folded-dataflow-final-seed1.log：最初失败样本的重跑；dataflow-first-seed1.log保留修复前结果。
- legacy.txt、*-final.diff、float-op-counts-final.json、changed-entries-final.json、ptx-status-final.txt。
- self_collision-before.cu、kernel_ab-before.py、audit-drive-before.py、provenance-final.json。

未改冻结规格、旧测试、容差、旧so、src/examples、依赖、认证，未commit/reset/checkout。
下一批是self_collision的4个accumulate入口和multiply_contact_tangents，建议从accumulate_vertex_face开始。
