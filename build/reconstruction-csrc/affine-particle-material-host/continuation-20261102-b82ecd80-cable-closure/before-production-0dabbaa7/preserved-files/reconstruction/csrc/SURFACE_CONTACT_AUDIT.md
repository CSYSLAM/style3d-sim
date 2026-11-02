# 全表面接触四入口 CUDA 恢复

旧库 SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
`kernels/surface_contacts.cu`定义296B SurfaceContactView及force、preconditioner、tangent、stiffness_scale四入口。
原版/源码各seed1/2/3：既有surface_contact5、新surface_contact_branches108全部通过，12组、678项GPU检查。
source entry记录确认四个核均使用源码。每seed112次路径核对零差异，非空调用全部检出人工输出取反错误。
GPU比较全数组；审计对既有9个/扩展11个lane采样，grid-stride用例核对全部32物理lane。

新用例覆盖三世界、跨世界vertex、shared形状、body重排/空表、完整warp/partial容量、
vertex/edge/face与重复vertex、零/负/异常bary、invalid indices、kind/flag/mass及NULL标志指针、
particle-only排除、异常normal/material/point/velocity、零tile、grid-stride及未写尾部。
几何和材料均按原PTX处理；质量/flags只影响有效质量，零权重仍检查kind/radius/world。
normal/friction两份Jacobian在四项展开区之后再写remainder，保持共享body的warp原子累加顺序。

## 发现并修复

- 新多世界用例最初用48 contacts/world，导致下一world的相同body跨两个warp写入。
  三次原版对原版复跑也全部有差异（world-fixture-original-repeat.json），确认是测试输入的原子顺序问题。
  改成64 contacts/world使每个body只由一个warp写入；逐位标准未变，完整输出均通过。
- 原PTX的depth/fn拒绝使用有序 `<=0`，恢复了这一条件；切线投影保持原mul/sub，再由JIT融合。
- stiffness_scale的normal speed实际为x-first，与preconditioner相同；force/tangent为y-first。
  冻结Python helper有vn_x_first参数，本轮仅据PTX修正CUDA，不改原Python计算。
- normal长度门限是未融合的平方和，使用两个rounded-add intrinsic保留原舍入。
  审计仅将恰好两条add.rn.f32表示为默认同样RN的add.f32；未改运行的GPU PTX或其它数学。
- 原PTX会在已知空list分支复制未初始化local scratch。诊断器补齐dead-local taint传递，
  仍拒绝未定义值用于可观察分支、地址、global写入或原子操作，默认严格模式不变。
- 诊断器原来把not.b32当作Boolean not，导致新CUDA的remainder循环被误走。
  已恢复按位取反并自检；所有原SynReal入口及此前已审计CUDA均不含not.b32，不影响早先结论。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only surface_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only surface_contact_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only surface_contact --seed 1
.venv/bin/python -m reconstruction.csrc.audit_surface_contact_ptx 1
```

seed再取2/3。证据 `build/reconstruction-csrc/surface-contact-audit/`：final GPU JSON、dataflow-summary.json、
原版不复现探针、修正前后日志、census及provenance。此批完成到123入口，rolling3草稿后续另验。
未登录完整solver或做demo验收；剩余内核、host/pybind和完整替代验证继续推进。
