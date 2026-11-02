# 颗粒六个 CUDA 入口核对

2026-10-30 UTC。新增build_grid、commit_bonds、accumulate_bonds、accumulate_contacts、
multiply_contacts、form_bonds，位于kernels/granular.cu。Model的radius和272..340材料字段按旧PTX补入model.cuh。
旧库SHA256仍为4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6。

## 结果

原版/源码各seed1/2/3：granular25项、新granular_branches187项，共12次分组运行全部通过。
source记录确认六个入口确实来自CUDA；commit_bonds为PTX-identical。
原granular两个入口以及八个fluid入口的规范化PTX没有变化。
当前110/131个源码定义：45 identical、65 different，21未写。未进行完整solver或demo验收。

每seed86次路径审计、37905次写入，地址/表达式/实际32位值/浮点判断零差异。
grid/bond检查所有launch lane及guard；contact/formation检查固定21个首尾、世界、特殊法线和guard lane。
GPU测试比较完整数组，未抽样或放宽标准。有效mul/div人工错误全部检出；
空接触/空cached行及capacity0等不执行相关算术的路径仍比较全部输出，但不要求这类mutation命中。

## 还原细节

- Grid：local半径/列表、replicated粒子偏移、可选world表、floor后hash和atomicExch链表。
  Contact的world过滤要求严格相等，与fluid的world=-1通配不同。
- Bonds：inactive/broken仍将tangent清零；commit仅在断裂时清active，否则更新clamped history。
  近零长度法线按粒子id的(min+max)%3选轴和正负号；保持塑性区间与damping/dt分支。
  tangent对角显式FMA，非对角保留fma(transverse,0,scale*nn)，不简化NaN/Inf行为。
- Contact：重合但有旧位移时使用rsqrt.approx；其余近零位移走grid id选轴。
  接触cache为slot-major、最多32条，但count不截断。Force加到旧值，diagonal直接覆盖。
  Multiply超过32条时重走网格，重新计算摩擦；cached正常分支保留原FMA位置。
- Formation：先释放远离的inactive槽，再逐槽选最近的较大id邻居；
  保留初始bond CSR二分查找、距离/速度限制、重复partner排除、等距时较小id优先及无候选早退。

初版GPU已逐位通过，路径工具仍发现两处真实写入顺序差异：
accumulate_contacts应先count、再按分量力更新、再diagonal；form_bonds应history先于rest。
已经逐项按旧PTX恢复，并重跑完整源码三seed GPU和三seed路径审计。
没有通过放宽比较或排序写入事件让它通过；失败记录dataflow-before-order-fix-seed1.json保留。

其余PTX文本差异为寄存器/地址安排、冗余load/mul/sub的共享、条件选择与位搬运。
所有已审计路径的浮点表达式和判断相同。编译参数、文本比较工具、冻结NumPy公式和旧测试判断不变。

## 边界与近似指令验证

granular_cases.py覆盖三世界、NULL world表、复制模型、local半径、负坐标、无冲突完整head/next；
disjoint bonds的inactive/broken/塑性/弹性/近零长度、断裂阈值及相邻float、NaN/Inf rest/history/坐标、
0/负/NaN damping、dt=0、0/负stiffness；以及32/33-contact cache边界、0/负count、
近零移动法线、摩擦0/负/NaN、负friction damping、空网格、world=-1严格过滤、输出尾部。
Formation测试capacity0/1/3/4/5、broken槽释放、活跃槽保留、初始CSR排除和同距离/已占用候选。
异常输入直接以原版GPU为准，没有为配合NumPy的NaN近似而改源码。

audit_granular_ptx用普通CUDA rsqrtf编译一个独立诊断小kernel，确认PTX只有一条rsqrt.approx.f32，
再从真实GPU取得该输入的32位结果，供具体路径执行；每seed实际调用1个不同输入。
不是用CPU的1/sqrt去近似MUFU.RSQ。辅助kernel在build目录，不计入恢复入口，也不替代原始kernel。
PathAudit仅增加默认关闭的approx_rsqrt回调，已有诊断不受影响。

## 复现

```bash
.venv/bin/python -m reconstruction.kernel_ab --only granular_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only granular_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only granular --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_granular_ptx 1
.venv/bin/python -m reconstruction.csrc.ptx_compare
```

seed再取2/3。证据build/reconstruction-csrc/granular-audit/：final-*.json/.err、gpu-*-summary.json、
dataflow-seed*.json、rsqrt-oracle-seed*.json、失败/修复日志、census及provenance-final.json。
run_gpu_batch.py按backend缓存编译结果，一次运行三个seed。

没有修改src/examples/认证/依赖/旧so，没有账号登录或完整solver/demo验收。
后续先处理hard-contact历史快照和cable penalty初始化，再处理剩余几何/求解主体。
