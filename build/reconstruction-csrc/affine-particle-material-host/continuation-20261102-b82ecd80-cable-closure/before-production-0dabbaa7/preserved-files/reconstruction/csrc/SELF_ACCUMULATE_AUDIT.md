# 点面、粒子碰撞累加与接触切线 CUDA 核对

2026-10-30 UTC。新增源码在 `kernels/self_collision.cu`：
`accumulate_vertex_face`、`accumulate_particle_pairs`、`multiply_contact_tangents`。
参考旧库 SHA256 为 `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。

## 结果与范围

原版与源码分别运行 seed 1/2/3；每个 backend/seed 的三个分组全部通过：

| 分组 | 顶层检查数 | 内容 |
|---|---:|---|
| self_accumulate | 6 | 既有随机累加、接触记录、切线及对角操作；额外检查嵌套 partials/copy_equal |
| particle_pairs | 8 | 既有随机粒子查询与碰撞累加，包括同位置和零质量 |
| self_accumulate_branches | 90 | 新增直接原版/源码 GPU 对比，覆盖世界偏移、主要判断和记录布局 |

18 个分组运行全部通过，stderr 确认三个目标入口使用源码。
既有 edge-edge/edge-face 累加仍从原版加载，**本轮未将这两个入口计为完成**。

每个 seed 的 14 次累加路径审计共 30,928 次写入，地址、表达式、实际 32 位值和浮点判断均零差异。
14 次人工 mul→add 错误全部检出。切线入口的规范化 PTX 完全一致，另用 GPU 验证动态点数和 grid stride。
同文件原有 10 个入口规范化 PTX 改变 0。

当前 97/131 个源码定义：44 PTX-identical、53 different，剩余 34 个。
此为内核级证据，不代表完整求解器已替换；未登录账号或运行完整 demo。

## 保留的原版行为

- 接触结构体为 60 字节：ids[5]、weights[5]、normal、stiffness、count；所有关键偏移有 static_assert。
- 点面：可选半径按 local vertex 读取；质量、位置和输出按 world offset 读取。
  三角形投影、重心坐标、1e-12 判断及 normal 平方和的非融合加法按旧 PTX 恢复。
  查询点先局部累加，最后一次散射；三角形端每接触散射；计数与记录先于三角形端写入。
- 粒子：半径与候选 id 为 world-local，质量和记录 id 为全局；同位置法线为 `(j ^ i) % 3` 正轴。
  保留零质量分支、谐和刚度的溢出 fallback、全部有限性检查和力/对角/记录的散射顺序。
- 切线：按值复制记录，动态点数循环，分量 FMA 加权和，随后 k*n*n^T 作用及原子散射。
  保留 grid-stride 遍历，不将动态点数强制改为固定四点或五点。

`multiply_contact_tangents` 为 PTX-identical。
`accumulate_particle_pairs` 浮点操作计数完全相同；差异为寄存器、地址、基本块和指令/可交换操作数安排。
点面入口多 2 个 mul 和 1 个 add，为有限分支重复计算相同刚度分子/分母；写入 DAG 仍相同。
另有 geu/lt 的 IEEE 精确互补、浮点/整数位搬运及 normal 存储类型的不同。
没有改比较工具、编译参数或浮点容差；完整 diff 保留。
路径 DAG 不能证明 JIT 融合，因此同时要求上述 GPU 三 seed 逐位结果。

## 边界用例与诊断器

`self_accumulate_cases.py`：三世界、最后世界不满、额外 launch 线程、输出尾部和记录未用区哨兵；
可选半径/记录/计数器 NULL，skip_incident 开关、多个候选、空/负 counts；
点面正/负/零距离、精确距离边界及相邻 float、重心在外、退化及极小法线/面积；
粒子距离严格边界、1e-8 法线分支和三种同位置轴；
零/负/极大/次正规质量、和/乘积溢出、NaN/Inf 输入以及刚度 0/负/NaN/Inf。
切线计数 -1、0、1、2、3、4、5；111 个记录只发射 16 个线程，强制执行多次 grid stride。
所有 stencil 互不共享，防止把跨线程原子顺序噪声当成算术差异。

PTX 路径工具新增 u32 返回值原子加、mul.hi 和可选的未定义寄存器跟踪。
旧 VF 在重心分母过小时先比较未初始化的 wa/wb，再由已知拒绝标记 OR 为 true，最终不写接触。
只在本批原版审计启用跟踪：被已知真/假完全屏蔽的谓词允许继续；
任何未定义值影响地址、写入或分支立即报错。自检验证屏蔽路径通过、其余三类用法被拒绝。
默认保持关闭；既有 armature 诊断器另执行回归，输出放本批 regression 目录。
原子分配在路径审计中按单 lane 模拟；实际跨 lane 分配由 GPU 记录排序后逐字节比较验证。

## 复现命令

仓库根目录运行；seed 再取 2/3。kernel 阶段不需要账号。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only self_accumulate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only self_accumulate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only self_accumulate --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only particle_pairs --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_self_accumulate_ptx 1
.venv/bin/python -m reconstruction.csrc.ptx_compare
```

本批按 backend 合并三个 seed，减少重复编译：

```bash
PYTHONPATH=. .venv/bin/python build/reconstruction-csrc/self-accumulate-audit/run_gpu_batch.py original
RECONSTRUCTION_KERNELS=csrc PYTHONPATH=. \
    .venv/bin/python build/reconstruction-csrc/self-accumulate-audit/run_gpu_batch.py csrc
```

证据目录：`build/reconstruction-csrc/self-accumulate-audit/`。
最终以 `gpu-*-summary.json`、`final-*.json/.err`、`dataflow-seed*.json`、`dataflow-final.log` 为准；
初轮 66 项 branches 文件保留，最终为 90 项。
另存 `legacy.txt`、三个入口 diff、`census.txt`、`unchanged-entries.txt`、诊断自检与回归、
本批修改前的 CUDA/test 副本以及 `provenance-final.json`。

未修改冻结 NumPy 算术、旧测试判断、src/examples/认证/依赖/旧 so，没有 commit/reset/checkout。
下一项：`accumulate_edge_edge`、`accumulate_edge_face`；复用本批刚度和结构体，但几何/融合须继续按旧 PTX 核对。
