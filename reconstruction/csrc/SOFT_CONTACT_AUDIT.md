# 软接触力与非对角切线 CUDA 恢复

2026-10-30 UTC。参考仍为旧库 SHA256
`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
新增 `kernels/soft_contacts.cu` 两入口，以及 `contact_geometry.cuh`。
这是 kernel 级验证；没有登录完整 solver 或执行 demo 替代验收。

原版/源码各 seed1/2/3 的四个分组全部通过，共24组、1386项检查：
`soft_contact` 5项、`soft_body_contact` 17项、`soft_contact_branches` 189项、`affine` 20项。
每次 source 运行单独记录实际使用入口，两个 soft 入口都已确认由 CUDA 源码提供。

新增测试使用未修改的原版 PTX 与选定后端直接比较完整输出数组的32位值，覆盖：
三世界、局部属性索引、共享静态 suffix、跨世界拒绝、body id 线性查找及重复 id 首匹配、
count/容量/空指针、输出开关、两个 block 指针重合、粒子与刚体索引重合、重复仿射索引、
previous/velocity 分支、零/近奇异/反射仿射矩阵、异常 normal/depth/material、原始 shape filter、
grid-stride 二次迭代和写入尾部。原有测试还检查同一 warp 共享刚体的原子累加顺序。

## 必须保留的细节

- `Transform` 步长28字节；Newton body id 先尝试直接索引，再线性查找第一个匹配项。
- filter 使用原始全局 shape id；mass/radius/kind 使用局部粒子索引。
- sphere 表面偏移用逆仿射矩阵，奇异时使用极分解旋转的转置。
- depth 拒绝是有序 `depth <= 0`，不能替换为 `!(depth > 0)`，NaN 行为不同。
- force 的摩擦速度投影 x-first，off-diagonal 使用 y-first；normal 投影均为 y-first。
- 法向和摩擦反作用分别写入刚体，并保留原子指令先后；block 两份输出逐分量交替写入。
- off-diagonal 排除同一全局粒子 id 的整项，并保留从零开始的首项加减与 FMA 差别。
- off-diagonal 的 host 合约要求 previous 非空：原版在判断该指针前已读取 previous[p]。
  本轮没有自行添加会改变该入口行为的空指针“修复”。

## 发现并修复的 JIT 差异

自然写法 `1 - n_k*n_k` 被新编译器与 normal block 的平方项合并，阻止了旧 JIT 的单次融合，
导致新增测试真实失败。`fusion-probes.json` 记录五种双跑：仅修改速度或摩擦投影仍失败；
只恢复三个摩擦对角项的显式 FMA 就通过。最终代码使用 `fmaf(-n_k, n_k, 1)`。

`dump_soft_contact_jit.py` 用旧入口生成 sm_120 JIT cubin，SASS 在0x6810/0x6830/0x6910处确认：
`FFMA R63, -R63, R63, 1`、`FFMA R61, -R61, R61, 1`、`FFMA R19, -R62, R62, 1`。
GPU 运行的原始 PTX 从未被改写。该修复不能仅靠融合前 DAG 判断。

路径审计对旧版上述三个**单次使用的平方后减法**做明示、限定为恰好三处的诊断融合表示，
以便与显式 FMA 的输出 DAG 比较；没有对其它运算普遍归一化。每seed80调用，写入79050/76622/76688，地址/表达式/32位值/浮点判断均零差异。
详细记录见 dataflow-seed*.json。
静态浮点指令计数仍不同，包含 CSE、分支展开和未使用的计算，不能声称 PTX 文本一致。
完成前另做 seed1 的首版164项完整物理 lane 核对，结果也保留在 pre-expansion-full 文件。

## 复现和证据

```bash
.venv/bin/python -m reconstruction.kernel_ab --only soft_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only soft_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only soft_contact --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only soft_body_contact --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only affine --seed 1
.venv/bin/python -m reconstruction.csrc.audit_soft_contact_ptx 1
.venv/bin/python -m reconstruction.csrc.dump_soft_contact_jit
```

seed再取2/3。审计默认采样含退化输入、世界边界与尾部的 lanes，grid-stride 场景核对全部32物理 lanes；
加 `full` 可核对新增测试全部物理 lanes。实际 GPU 比较始终覆盖完整输出数组。
每个有写入的审计调用要求检出“输出取反”人工错误。
PathAudit 新增逐 lane local scratch 转发和 gridDim，未初始化 local 读取失败；默认已有调用 grid=1。
局部死寄存器允许带 taint 前进，但可观察分支、地址和写入仍禁止未定义值。

证据目录 `build/reconstruction-csrc/soft-contact-audit/`：
`gpu-{original,source}-summary.json`、`final-*.json`、`dataflow-seed*.json`、JIT cubin/SASS、融合探针、
`float-operations.json`、`census.txt`。affine helpers 原样移入 `affine_geometry.cuh` 后，
已有11个 affine 入口的规范化 PTX 与 `affine-before.ptx` 全部不变，三 seed affine 回归也通过。
本批完成时114个源码入口（45 identical、69 different）、17未写；后续 hard 草稿另行验收。
