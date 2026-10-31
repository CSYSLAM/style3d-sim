# 仿射块预条件器两个模板恢复

基准旧库SHA256：`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
源码 `kernels/affine_block.cu`，两个模板为NonZeroEntry和BlockNonZeroEntry，CableView按值160B。
恢复12x12矩阵组装、缩放Cholesky、12次前后代入、有效标志及最后对称化。
本阶段使用原库提取PTX对比源码编译PTX，GPU为RTX5090 D v2（sm_120），不涉及账号认证。

## GPU 对比

原版/源码各seed1/2/3，每seed302项检查：affine_block_assembly72项和affine_block_branches230项，
共1812项，全部逐位通过。source记录确认两个入口实际选择源码。
72项内有18项直接比较原版与源码组装矩阵，另含逆矩阵、有效标志及原版组装出口对冻结规格的比较。
组装探针仅在测试中替换求逆出口，实际逆矩阵仍用完整入口测试，不能互相替代。

57个扩展场景/模板覆盖禁用/负enabled、可空flags、flags位、零/负/NaN/Inf质量，
零/负/非有限/极大/极小/非对称对角块、pinned坏对角块、cache、后续Cholesky失败及部分输出失败，
SO3参数、ELL空容量/无效列/重复列/有符号容量截断/异常值/signed zero，以及缆绳重复节点、
零/负节点数、空可选指针、非有限材料和偏置。部分失败场景另断言原版确实只改写了部分逆矩阵。
邻接offsets始终提供有效空表；ELL容量非零时rows/entries必须有效，原版不支持随意传NULL。

## 路径审计及表示调整

完整入口和组装出口分别审计，每seed各132次调用；每调用采样8个lane，GPU对比仍覆盖整个输出数组。
完整入口每seed核对191324次有序写入；组装出口每seed123590次。
按下面明确限定的表示处理后，写入地址、表达式、32位值、浮点判断均无差异；
全部写float的调用都检出了人工输出取反错误。这是具体输入和采样路径证据，不是任意输入的数学证明。

- scalar ELL的packed register半字移动仅降为等价32位拷贝；低/高半字逐位保留，
  不支持的packed寄存器用途直接报错，不放宽为常数或省略计算。
- 原PTX会加载三角矩阵vector中的无用上三角local槽。沿用已有dead-value taint机制，
  允许丢弃，仍拒绝未初始化值影响可观察输出、地址、原子或分支。公共审计器未改动。
- 编译器把flags空指针分支的mass>0判断提前，flags存在路径重复同一判断；只将同一mass输入、
  同一gt0谓词且原始计数恰为1/2的重复表示合并，原始计数有记录，其他判断保持严格。
  组装探针不再使用active mask，编译器删除了死质量判断；仅该探针模式记录并忽略它们，
  完整入口审计仍单独检查质量判断。
- 原版SO3第三行三个对角位置在PTX中复用平方后执行加法，但sm_120 JIT会按固定位置融合。
  从原版JIT SASS确认后，仅将这三条特定链（每链三个加法）表示为对应FMA，以核对实际运算。
  修改仅在诊断器中，GPU始终运行未修改原版PTX；不能说PTX文本或未经处理的数据流完全一致。

JIT证据：`build/reconstruction-csrc/affine-block-audit/so3-jit-evidence.txt`与完整cubin/SASS。
原block入口R5/R8/R11读取rotation偏移0x8/0x14/0x20，R98在0x9a00保留rounded x平方；
三条链分别为0x9a70→0x9b00→0x9b30、0xa420→0xa4a0→0xa4e0、0xa450→0xa500→0xa600。
每条先将初始乘积FMA到rounded x平方，再融合y平方、z平方，与冻结Python规格的注释相符。

## 实际修正

- Cholesky和前后代入恢复原mul/sub，由JIT决定融合，避免提前FMA造成不同运算表示。
- 原版缆绳邻接offsets为必需输入，已移除草稿中自行增加的NULL许可。
- ELL组装由容量而非指针启用；容量截断为有符号32位后与非负行数取min。
  scalar先展开为单位块再相加，非对角add-zero也保留，不能只加三个对角分量。
- 缆绳角向bias为空时仍加零，保留原版操作及signed-zero行为。
- 尝试强制保留SO3外层循环后，原PTX运算形式更接近，但真实GPU的融合发生变化，数值测试失败。
  已撤回该写法，保留全展开和原JIT确认的显式融合；失败日志保留在gpu-source-expanded.*等文件中。
  此例再次说明路径表达式检查不能替代真实GPU逐位测试。

## 复现

```bash
.venv/bin/python -m reconstruction.kernel_ab --only affine_block_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only affine_block_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only affine_block_assembly --seed 1
AFFINE_BLOCK_AUDIT_TAG=rerun-inverse .venv/bin/python -m reconstruction.csrc.audit_affine_block_ptx 1
AFFINE_BLOCK_AUDIT_ASSEMBLY=1 AFFINE_BLOCK_AUDIT_TAG=rerun-assembly \
  .venv/bin/python -m reconstruction.csrc.audit_affine_block_ptx 1
```

seed再取2/3。批量GPU命令：

```bash
.venv/bin/python -m build.reconstruction-csrc.affine-block-audit.run-gpu
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m build.reconstruction-csrc.affine-block-audit.run-gpu
.venv/bin/python -m reconstruction.csrc.dump_affine_block_jit
```

最终GPU JSON、审计JSON、source entries、JIT证据、失败探针、census和provenance位于affine-block-audit/。
两个入口完成后，当前阶段已验证128/131；剩余cable3。完整主机调度、Python绑定和登录后的整套demo验收未完成。
