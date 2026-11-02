# 驱动布料/self：原始ABI核对与完整输入回放

本批继续两组7ca候选的固定失败，不修改生产0dab/Core715、SDK64a、CUDA176/f0、容差或旧C8样本。
最终仍要让独立源码solver通过正式demo和长程验收；下面的参数传输核对不是整段数值一致性通过。

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-replay/`。

## 已完成：真实参数字节

四类constructor此前的CUPTI捕获保留了原版runtime及源码driver实际收到的参数，
本批逐条对照同一进程的hook日志，没有拼接不同运行的参数。
新`hook_parameter_bytes.py`恢复整数、F32及完整by-value视图；文本NaN无法还原payload时会拒绝，不能默默代成另一个NaN。

CPU实际退出0：八份真实捕获共6272调用、68440参数、737758字节全部同。
原始view padding也在同一调用内逐字节核对，没有归零或屏蔽；压缩packet另保留实际CUPTI字段和关联号。
这个结论仅证明本批日志的参数重建正确，不证明pointee内容或整个求解器的数学相同。
CUPTI这份记录只提供grid/block的x维，不能写成独立核准了全部geometry。

## 排队：1188份完整同输入

前置`linear-captures-v2`针对两组失败各采原版/源码三步，共四worker。
本批固定选取每worker全部297个full-input阶段，共1188份输入、计划3564次调用。
包含所有三步、九次非线性迭代及全部五轮CG，而非只选首尾或容易通过的位置。
14种kernel的输出写域已由前一批28份实际原版/源码PTX静态核准。

新增`driven_self_flow_replay.py`按捕获地址保留重叠、别名和每个pointer的256字节内对齐，
在同一初始buffer上轮换调用SDK runtime、SDK PTX及候选7ca的独立源码PTX。
实际geometry取自本次捕获，不调整资源属性或launch参数。完整输出、实际ABI、只读数据及两端guard都保存。
自碰撞记录保持原始次序，完整容量的严格差异会原样报告；不能用排序后的输出冒充原始逐位一致。
新增独立CPU审计器会重读实际NPZ、捕获输入和参数，重建初始buffer及write区间，复算完整比较结果。

注意：回放进程作为诊断会明确映射SDK；交付的源码demo仍必须独立运行且没有SDK映射。
脚本`execution_complete=True`仅表示完成3564调用，`strict_packets`才是完整输出严格数；
即便执行器退出0，也不能把未通过的数值项或旧完整轨迹改判。

## 当前任务与命令

原机器pipeline工具session97272、PID3311307；身份及真实等待见`pipeline/runner-identity.json`和`verified-wait-receipt.json`。
它先等待同一flow队列3301837/session37865结束，再准备实际packet，GPU空闲后串行回放，最后运行独立CPU审计。
当前仅CPU参数核对和请求准备完成；新回放GPU调用尚未开始。
原scalar工具67261及其CPU接续2752仍是更前置的任务；根线程需取得各原工具实际退出码，不从文件推断。

```bash
source scripts/reconstruction_env.sh
replay_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-replay
ps -p 3311307,3301837,3272557,3280049 -o pid,etime,stat,args
nvidia-smi --query-compute-apps=pid,process_name --format=csv,noheader
cat "$replay_phase/pipeline/status.json"
```

现有pipeline已串起以下三条命令，勿在原目录重复启动：

```bash
.venv/bin/python -m reconstruction.csrc.driven_self_flow_replay --phase "$replay_phase" --mode prepare
.venv/bin/python -m reconstruction.csrc.driven_self_flow_replay --phase "$replay_phase" --mode run
.venv/bin/python -m reconstruction.csrc.driven_self_flow_replay_audit --phase "$replay_phase"
```

Windows仍按主交接进入WSL2。原机器PID不能迁移；新机器不得直接重启旧pipeline。
仅复核历史ABI字节可以新建兄弟目录，复制CPU审计脚本后运行，不会创建GPU context：

```bash
abi_repeat=build/reconstruction-csrc/affine-particle-material-host/abi-cpu-repeat-$(date +%Y%m%d-%H%M%S)
mkdir "$abi_repeat"
cp "$replay_phase/audit-hook-raw-ABI.py" "$abi_repeat/"
.venv/bin/python "$abi_repeat/audit-hook-raw-ABI.py"
```

这是旧捕获的字节重读，不能算新机器的solver验收。新机器GPU验证需新计划/目录、路径及构建provenance，串行跑新原版/源码。

## 输出后继续哪里

先看flow的逐NL apply增量、CG生产/消费关系及是否复现冻结失败，再看完整输入回放的首个严格差异。
对CG标量、接触记录顺序和其它向量分别查实际输入与原版调用，不能预设所有差异都是原子顺序。
有原子差异时继续采真实F32操作数和GPU证书；非原子点值不同则据固定SDK/PTX定位并修源码。
所有局部结论均不得替代两组旧C8、G1/复杂布料长程、正常Core入口或完整host组合验收。
