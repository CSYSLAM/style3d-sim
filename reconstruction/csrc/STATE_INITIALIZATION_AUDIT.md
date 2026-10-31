# 硬接触快照和线缆罚参数初始化

2026-10-30 UTC。新增kernels/hard_contacts.cu的snapshot_hard_contacts和kernels/cables.cu的prepare_cable_penalties。
HardContactView按312B ABI定义已使用字段，其余区保留opaque，尚未实现其它三个hard入口。
参考旧库仍为SHA256 4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6。

原版/源码各seed1/2/3：hard_history70项、cables704项、新state_initialization_branches204项，
共18个分组全部通过。source entry记录确认两入口使用CUDA。
每seed84次全lane路径审计，写入4005/3765/4125，地址/表达式/32位值/浮点判断零差异。
两个入口float操作计数与原版相同，仍为PTX-DIFFERENT（寄存器/地址/指令和可交换操作数安排）。
当前112/131定义：45 identical、67 different，19未写；未做完整solver/demo验收。

保留的行为：snapshot线程0即使capacity0也写previous_count，NULL/负count钳到0，
copy范围同时受size_t capacity和非负count约束；penalty/dual直接复制，normal仅在length>0时归一化。
capacity向signed int的转换按原PTX保留，没有把超出正常分配范围的语义自行“修正”。
线缆四个通道分别按beta开关选择下界；reset/init非零、rescale、world-local base和mask均按原版处理。
fminf/fmaxf保留NaN行为，mask非零（含负值）仍执行；不额外添加finite过滤。

既有704项线缆用例覆盖192组开关/缩放组合；新204项补充NaN/Inf/次正规/大幅normal、
直接复制NaN/Inf dual/penalty、0/负/空count，NaN beta/scale/cap、负scale、非canonical init整数、
负/零mask、partial world和完整输出尾部。先原版再源码，新旧测试判定均未放宽。
PathAudit补充1字节signed/unsigned load以核对bool参数；32/64位路径不变。
auditor复用fluid的参数/向量内存降级，GPU运行的PTX没有被修改。
空前缀/全零mask的乘除mutation无输出作用，不要求命中，其余有效计算均检出。

```bash
.venv/bin/python -m reconstruction.kernel_ab --only state_initialization_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only state_initialization_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only hard_history --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only cables --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_state_initialization_ptx 1
```

seed再取2/3。证据build/reconstruction-csrc/state-initialization-audit/：final-*.json/.err、
gpu-*-summary.json、dataflow-seed*.json、diff、census、provenance-final.json。
未改冻结规格、旧测试判断、src/examples/认证/依赖/旧so，没有账号登录或完整solver/demo验收。
剩余19入口均涉及较大的接触几何/仿射块/线缆主体，继续从两个soft-contact入口恢复共享几何。
