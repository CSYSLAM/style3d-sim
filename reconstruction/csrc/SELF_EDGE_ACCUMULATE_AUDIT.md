# 边边、边面碰撞累加核对

2026-10-30 UTC。新增 `accumulate_edge_edge`、`accumulate_edge_face`，位于 `kernels/self_collision.cu`。
旧库仍为 SHA256 `4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。

## 已完成

两个 backend 各 seed1/2/3：self_accumulate 6项（含嵌套力/对角/接触记录），
edge_accumulate_branches 96项，self_accumulate_branches 90项，18次分组运行全部通过。
source 的 entry 记录确认 EE/EF 真正加载自编译 CUDA，本批不再回退原版。
此前同文件13入口的规范化PTX改变0；新增2入口后当前99/131，剩32个。
kernel计数不等于完整solver/demo已验收；本批未使用账号或完整solver。

每seed16次PTX路径调用、66,576次写入：写入地址/表达式/32位值/浮点判断零差异。
16次mul→add人工错误全部检出。路径核对仍须结合GPU结果，不能替代JIT融合验证。

## 原版细节

- EE：只保留另一条edge的local id较大、端点不共享、两个最近点参数严格在(0,1)的接触。
  保留补偿乘积差、cvt.sat、ordered退化判断、1e-6严格距离下限及margin严格上限。
  opposite CSR四种成员关系按原顺序查找；相邻时limit为min(thickness,(lengthA+lengthB)/4)。
- EF：边长下限0.0005，三角形法线为 `(b-a) x (c-b)`；两端必须严格跨越三角形平面，
  重心权重均>=0.01。沿opposite顶点构造相邻面法线、折叠方向和方向反射，最终力幅值为2*thickness*k。
  大部分dot的第一个独立乘积是y，方向反射的dg则是x；按原版保留，未统一成一个dot实现。
- 两者保留谐和刚度fallback、finite检查，接触记录先于散射，查询端点FMA局部累加、候选端点乘法后原子加。
  空候选时，合法查询端点仍执行零值原子加；不将其优化掉。
- world共享edges/triangles/opposite，坐标、质量和记录id加particle offset。

初版随机GPU通过；复查原PTX，将EE退化条件写成ordered `<=`，没有沿用NumPy的NaN近似写法。
新增入口最初放在切线前，改变了旧切线PTX内local-depot序号；已将新增入口移到旧入口之后，
完整核对原13入口规范化PTX零变化。

EE/EF仍为PTX-DIFFERENT：EE多少量重复减法及临时移动/存储位类型变化；EF算术计数一致，
多临时移动/选择。对应实际路径的float比较和写入表达式已核对一致，保留完整diff。
编译器、GLM、编译参数、文本比较工具和逐位标准没有更改。

## 测试覆盖

`edge_accumulate_cases.py`使用三世界、partial tail、额外线程、记录未用区和输出尾部哨兵。
互不共享的stencil支持多个候选、NULL记录/计数器、负/零counts、四种adjacency与早停成员查找；
零/退化/平行/端点最近点，精确margin/1e-6及相邻float，边长和重心阈值及相邻float；
0/1/2个opposite、退化opposite、方向抵消、近似平行反射分支、共享顶点、三角形面积退化；
零/次正规/极大质量、乘积/和溢出、NaN/Inf质量和几何、0/负/NaN/Inf刚度与NaN/Inf厚度。

保留一项容易误改的行为：EE的NaN厚度不会让所有接触都消失，adjacency分支的fminf(NaN,finite)
会选择finite。本批fixture仍产生9个记录，原版和源码一致。没有新增输入清洗去改变这一行为。

## 命令和证据

```bash
.venv/bin/python -m reconstruction.kernel_ab --only edge_accumulate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only edge_accumulate_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only self_accumulate --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_edge_accumulate_ptx 1
```

seed再取2/3。批量脚本 `build/reconstruction-csrc/self-edge-accumulate-audit/run_gpu_batch.py`，
用法同上一批：`PYTHONPATH=.`，参数original/csrc，后者设置RECONSTRUCTION_KERNELS=csrc。
最终以该目录gpu-*-summary.json、final-*.json/.err、dataflow-seed*.json和provenance-final.json为准。
另存两份旧PTX、diff、修改前副本、既有入口不变记录和汇总。

新增测试只增加kernel_ab分组/用例，未改冻结NumPy算术、原测试判断、src/examples/认证/依赖/旧so。
下一批：fluid的scale_step、build_grid、evaluate_rows、accumulate_rows、multiply_rows。
