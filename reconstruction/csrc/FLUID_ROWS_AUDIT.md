# 流体五个 CUDA 入口核对

2026-10-30 UTC。新增scale_step、build_grid、evaluate_rows、accumulate_rows、multiply_rows，
源码在kernels/fluid.cu。Model所需字段在kernels/model.cuh按1864B ABI和字节偏移定义，
未使用区仍为opaque padding，不代表完整主机Model已恢复。
旧库SHA256仍为4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6。

## 验证结果

原版/源码各seed1/2/3：fluid20项、fluid_branches最终151项，共12次分组运行全部通过。
stderr确认五个新增入口均来自csrc；原有三个fluid入口规范化PTX仍完全相同。
全量census为104/131：44 identical、60 different、27未写。尚无完整solver或demo验收。

最终每seed39次路径核对、70581写入，地址/表达式/32位值/浮点判断零差异。
三个seed的evaluate_rows选取每世界头尾及guard共9个lane，其余入口检查全部launch lane及guard。
实际GPU测试始终比较完整输出数组，没有抽样或放宽逐位标准。
另保留首次全lane路径记录：34调用、245606写入、零差异（扩展边界/空网格fixture之前）。
38个有实际mul/div作用的调用全部检出人工错误；空网格evaluate只产生固定零结果，
所选mul/div错误在这条路径无输出作用，不要求命中，但完整输出/缓存未写区仍按原版核对。

## 原版行为

- build_grid：replicated model的粒子id为local id+world*particles_per_world，质量按local id读。
  非replicated模型从particle_world表取max(world,0)，表长度为0时取world0。
  边界样本在非replicated模型的world为-1，在replicated模型为该副本world；坐标和volume共享。
  坐标除h后floor，再转int；保留三个hash常数和atomicExch链表插入。
- scale_step：replicated模型按i/particles_per_world取scale，否则走可选world表。
- evaluate_rows：27个精确cell，x方向最快；遍历链表时过滤cell及world，仅保留本world或-1。
  Poly6密度、梯度、严格r2<h2和动态id筛选，最多写64个cache，实际count不截断。
  weight仅在density>1时为K*volume；空遍历的gradient/residual/weight/count为0，cache未写区保留。
- accumulate_rows：先查询点密度力/对角，再邻居；超过64个动态邻居时重新走网格，
  fallback不额外测试support radius，不对重新计算的viscosity强加>0限制。
  cached viscosity则只在>0时散射；保留两端力与完整9项isotropic矩阵（含六个零）的原子写入顺序。
- multiply_rows：cached行先求完整scalar sum，再散射邻居、最后查询点；
  fallback两次按同序遍历，第一次的sum减去dot*volume，第二次邻居项为gradient*-(scale*volume)。
  粘滞分母的原始mul/add留给JIT按旧式融合，未统一成改变舍入位置的近似公式。

scale/build/accumulate的float操作计数与原版相同；evaluate多一次volume重读，leu/gt为IEEE精确互补。
multiply少4个重复的h幂乘法，两次遍历共享同一组常量；各路径写入DAG相同。
初稿显式FMA已按旧PTX恢复成sum -= dot*volume，保留原JIT收缩位置；随后重跑全部验证。
五入口仍标PTX-DIFFERENT，完整diff保留，未修改编译参数、文本比较或容差。

## 新用例及诊断

fluid_cases.py：三世界和partial tail；world表有/无、replicated有/无、打乱粒子id、负坐标、
无hash冲突的完整head/next逐位比较，以及一个warp内的复制边界样本完整缓冲区比较。
固定链表顺序供row测试，避免将原版固有的插入竞争当作算术差异。
包括mu正/0/负/NaN，density与cache、count -1/0/1/3/4/63/64/65/70，
cached负/NaN viscosity、空网格和空fallback、显式输出指针与View缓存指针NULL、完整未写区/尾部哨兵。
另有既有fluid随机场景验证缓存/溢出、静态样本、density活动/非活动行和两种步长限制。
既有build_grid_lists仍按原测试比较slot成员集合；新增可控fixture进一步直接比较整个head/next字节。

audit_fluid_ptx仅在诊断中将向量load/store拆成按分量操作，将by-value参数映射到虚拟只读字节区。
真正GPU调用仍用未改动的原版/源码PTX。PathAudit新增可选128 block、仅用于本批的store forwarding、
u64 load、整数mad/min/max、unsigned wide算术、floor/float-to-int及atomExch。
精确互补谓词归一化扩充leu=!gt/ltu=!ge；不使用容差，也不合并不同浮点算式。
自检覆盖unsigned wide multiply、store forwarding开关和128线程索引；既有EE/EF16调用诊断回归零差异。
初版mutation只改mul，build_grid没有float mul因此不命中，已扩展div mutation并重新跑最终报告。

## 复现

```bash
.venv/bin/python -m reconstruction.kernel_ab --only fluid_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only fluid_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only fluid --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_fluid_ptx 1 sampled
# 去掉sampled可核对全部density lane，耗时更长；seed再取2/3。
.venv/bin/python -m reconstruction.csrc.ptx_compare
```

证据build/reconstruction-csrc/fluid-rows-audit/：最终gpu-*-summary.json、final-*.json/.err、
dataflow-seed*.json、dataflow-final.log；初轮123/139项文件保留，最终151项。
dataflow-full-initial-seed1.*是扩展前的全lane报告；float-op-counts-final.json及各入口diff解释剩余差异。
附修改前副本、诊断自检/回归、census及provenance-final.json。

未改冻结NumPy算术、旧测试判断、src/examples/认证/依赖/旧so。没有账号登录或完整solver/demo验收。
后续转granular模块，Model其余字段需要继续按原PTX核对后再填充，不能猜偏移。
