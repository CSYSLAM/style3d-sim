# G1第4子步第2轮完整线性阶段核对

承接fe39faab；固定SDK64a、生产host38/Core7eb、CUDA176/f0、数学、阈值和旧失败保持。
本阶段实际局部核对已结束；`solver_api_ready=False`，完整源码替代仍未验收。

## 固定范围及验证方法

沿用旧source1 frame30公共检查点，真实正常Core各执行一次SDK/source，均是一帧六子步。
这两次用于局部算子诊断，不新增或替换旧8/3数值验收队列。
采第4子步第2轮RHS9332、inverse9350、首尾CG的precondition/direction/matrix/update，共十处实际调用。
保存所有非空指针输入、完整输出及实际ABI；三端SDK runtime/原PTX/源码PTX共60次回放、96份完整输出。
输出和guard/只读输入、实际重定位指针、原始scalar字节由独立CPU直接重核，严格失败如实保留。

原版inverse参数0与3确为同一地址、同样6336字节。采集和span replay保持此完整别名，不以分离缓冲区替代。
每端69个只读D2D、421756字节；从CUDA API读取每个真实200字节copy描述符，独立核src/dst及长度。
相邻调用用统一快照链保持唯一拓扑次序；原17467节点/17466边须完整保留。
单独从实际SO3初始化指针读取704字节body代理映射，并核对实际producer/consumer地址和完整数据链。
RHS初始化后仍有接触/关节等力累加，不能直接假设RHS初始化输出等于最终CG residual。
增加图快照可能改变原子调度，不把诊断新轨迹视为旧隐含内部状态的精确续跑。

## 当前进度、错误及接续

维护工具：`g1_nl2_linear.py`；完整证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-fourth-nl2-linear/`。

- 前一goal轮仅回答状态，属于no progress。本轮重查HEAD fe39faab及未提交采集adapter，继续实际预检和采集。
- 首次维护脚本AST/128列检查退出1：adapter第94行131列；修为两个相邻字符串，渲染结果不变。
  首CPU preflight session26272实际0；修改前plan/CPU-preflight以before-formatting文件保留，随后重新冻结。
- 重新冻结session23707实际0，所有十处实际ABI和两端PTX潜在写字段通过；预检未创建GPU context。
- 驱动session20100已启动；当时外部worldparticle PID2704714实际占用GPU，持续记录查询并等待，没有终止外部任务。
  真实运行状态以run.status.json、followup.status.json及实际终端返回为准；不能从等待超时推断进程已停。
- 首次文档patch因错误匹配WORK_LOG标题被工具拒绝，无文件写入；改为独立新增文档及追加日志。

采集完成后先运行独立CPU审计、60次三端回放及完整after/ABI审计。
若只有归约scalar严格失败，再按实际捕获初值取真实GPU原子操作数，必要时SDK逐粒子隔离及真实F32顺序证书。
任何向量/矩阵逐粒子差异先查实际原PTX/源码与输入，不能一概归因原子顺序。
不为诊断修改生产源、原demo、已知速度helper问题、固定C8或验收容差。
后续全部终态和原始失败追加本文件及WORK_LOG，关闭证据后校验快照、提交推送，Windows仍使用WSL2。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-fourth-nl2-linear/run.py
```

该命令已有任务且目录拒绝覆盖；接续时先核具体进程/session及status，不重复执行。

## 实际结果

驱动session20100实际退出0：SDK PID2714271、source2714659、CPU2714970、replay2715049、replay CPU2715218均实际0。
69份copy每端421756字节、两端27600实际描述符字节、28条实际指针与完整payload producer/consumer链独立核准。
实际17536节点/17555边，原17467/17466完整保留。源码正常公共Core无bridge、未映射原SDK。
外部PID2704714随后已不在进程表，未中断；其实际退出码未知。

60次三端回放：72份非归约输出全部严格，含两端实际输入的RHS、原地inverse、precondition向量、方向、矩阵向量及解/残差更新。
归约scalar仅9/24严格，合计81/96严格，15失败原样保留。CPU直接核2481792完整after字节、2304288只读/guard字节、
4068实际ABI字节、318指针字段、1524标量字节和44376完整输出word。
不能将这些首末CG调用表述为全部50轮CG向量都已回放。

真实NL2两端输入早已不同：RHS位置/预测位置和inverse输入各有差异；质量/flags/固定ELL与基础diagonal则同。
两份body12最终NL2增量约0.001427/0.001231，本次没有采到上批约0.0105的那组，不能据此解释其根因。
`linear-input-audit.py`实际0：两端176块全有限、176正有限determinant，无diagonal fallback，最小约9.33e12。
实际有限输入符合inverse唯一乘法操作数交换的核对范围，仍不外推NaN payload语义。
解初值、首末numerator均正零，residual消费链及first方向复制全部逐位核准。

## 真实原子贡献、SDK隔离及GPU顺序证书

新维护工具`g1_nl2_atomic.py`；atomic-plan预先冻结八份实际precondition/matrix首末输入与17个既有scalar目标。
每份原PTX/source探针均保存完整256×128×16原始记录和256计数，正确匹配PTX实际2048字节lane stride。
16次实际探针记录2816贡献，两端所有操作数逐位同；matrix含4..69个负贡献，不假设所有归约项为正。

仅将world空指针改成唯一0..175索引，scalar输出换为176份独立guard slot；其它所有输入和count/width保持实际值。
正零/负零×SDK runtime/原PTX/源码共48真实调用，8448个独立贡献均与真实操作数预测逐位同；完整pointwise向量也全严格。
这属于明确声明的受控隔离，不声称world参数仍为空或替代实际全线程共同目标的调度。

将捕获/原三端回放/两探针所有scalar目标合并，共21份真实GPU单线程F32原子顺序证书全部通过。
每份使用全部176个实际贡献和实际捕获初值，包含负数与完整3696个硬件before历史值；CPU独立FTZ逐步重算全同。
证明每个scalar结果与这些相同操作数的合法排列一致，不推断旧全局warp顺序；15份严格失败不重判。
证书搜索预算每输入100000、固定种子，实际2..36次找到全部目标；未发现subnormal贡献。

atomic prepare及维护脚本AST/128列门禁实际0；驱动session45158实际0，GPU PID2718125和CPU2718174均实际0。
CPU直接重核5233024完整after字节、5097792只读/guard字节、5652实际ABI字节和33792完整pointwise输出word。
本轮所有自有GPU任务已终止；没有重跑74或更改生产代码、SDK、pyc、原demo或固定验收。

下一步以实际SDK调用确定未覆盖host组合是否支持及其调度，优先补功能范围；G1整段及布料/粒子固定失败继续保持活动。
固定参考/生产版本不改，Windows仍WSL2。发布前关闭证据并完整校验RECONSTRUCTION_SNAPSHOT，再提交推送。
