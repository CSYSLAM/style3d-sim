# G1 晚期帧最后一次矩阵乘法：真实同输入回放与F32原子证书

生产仍为host38b70dcd、公共Core7eb6e847、CUDA176/f0；唯一原版仍为项目内SDK64a。
没有修改生产源码、数学、阈值、固定失败或默认入口，`solver_api_ready=False`。

## 本轮实际执行

在[G1图定义核对](G1_GRAPH_DEFINITION_AUDIT.md)之后，新增两端各一次正常公共Core、真实graph60帧/test。
原版和源码严格串行，都退出0。源码仍public_core_abi true、bridge false、没有映射原版so。
每帧在旧worker四个状态数组的既有下载全部完成后，读取最后一次block ELL矩阵乘法缓存；没有新增GPU分配或图节点。
额外CPU/读回工作可影响后续原子调度，不能当作旧固定轨迹的逐位复现。

这是每帧第六子步、最后非线性轮、最后CG轮的实际输入，不是重复旧首子步的packet：
图中rank17456，总17467节点。总粒子/行数176，每行最多19个40字节BlockNonZeroEntry，单一隐式world。
每端60份，共120份。全部120份direction和Ap各528个F32分量都非零，排除了全零末轮造成的空验证。

## 为什么帧结束后的输入仍可用于这个调用

矩阵本身只存储参数6的Ap与参数9的归约值；二者与所有已捕获读输入区间不重叠。
随后只有10个节点：5种自有核、2种Warp核、1次D2D及2次填充。
新增`ptx_store_origins.py`核对原版及源码实际PTX的store/atomic参数指针来源，拒绝非内联调用、未解析或间接store地址。
Warp同时使用上一轮保存的实际生成类型与ctypes布局。按这些输出的有效尺寸列出的19个潜在写区间，
都不覆盖矩阵的row counts、entries、blocks、direction、extra、Ap或归约值。
两端旧实际图的CPU预检和本次实际图都通过了区间检查；原始PTX、逐指令来源和实际布局保留。
该来源分析不单独证明任意非法输入下的所有索引边界；本结论针对本次有效模型和所记录输出范围。

GPU运行前，CPU工具先暴露了vector参数load未处理的问题，之后修正逐lane offset；
还修正了把谓词/内存容器地址误当成读出数据指针来源的过度传播。
旧分析器、旧报告和失败记录保存在`cpu-preflight-errors/`；这些修正均发生在GPU采集之前。
两端区间预检通过后另修正一条131字符行，未改变逻辑。

## 三端回放与原子证书

每份实际输入在同一组设备buffer上运行：SDK64a实际cudaLaunchKernel、固定原版提取PTX、当前独立源码PTX。
保留真实重叠关系和指针mod256对齐，完整三维grid/block及shared不变，轮换后端顺序。
Ap调用前旧字节没有被采集，明确使用0x7f、0xa5两个受控初值；归约初值为受控零，不能写成已观测的调用前值。

720次Ap逐位对照全部相同，GPU worker逐次完整读回检查输入/非输出字节均未变。
全部720份输出原始NPZ已保存，可独立CPU重核。非输出完整读回字节未另存，CPU只能核查对应运行标志，
不能把这一部分称作CPU从完整after字节独立重算。

归约输出与各自实际帧捕获值的逐位匹配为：SDK runtime80/240、原版PTX89/240、源码PTX84/240。
其余467项没有改判成严格一致。全部120份输入中，捕获值及各回放值形成211份需要核对的目标证书。
先固定全部目标及每份输入10000次CPU合法排列搜索上限，再采原版/源码PTX真实GPU原子操作数。

- 每份输入176个活动lane各一次atomic，80个多余lane为零次；两端实际操作数全部逐位同，共保存42240个lane操作数。
- 按每份输入计算，真实操作数中共有7658个负值、无subnormal；没有假设它们全非负。
- 全部211份目标均找到合法lane排列，最大搜索次数2311；每条排列在GPU执行真实`atom.global.add.f32`。
- 211个最终目标及37136个GPU逐项累加前值全部由独立CPU从原始数组重核相同；每个排列恰含176个lane各一次。
- 当前该矩阵核原版/源码规范化PTX文本也相同。该结论只针对这个已选定核，不能外推到其它内核或资源属性。

证书说明在受控零初值下，这些结果可以由同样的真实F32操作数和合法原子次序产生。
没有推断旧运行的真实顺序，也没有把整段G1或旧23.85尖峰改判通过。

## 固定整段失败仍保留

这两次新诊断与旧11条冻结轨迹均不逐位相同。原版四字段各59/60帧位于固定C8范围；
源码为body_q57/60、body_qd58/60、particle_q57/60、particle_qd57/60，两端仍未通过整段固定C。
新原版最大速度字段偏差1.34154，源码1.10486，没有复现旧source1的23.8513。
旧八原版/三源码与报告SHA32b6e2a7…不变，未补入新基准或改变门槛。
最后一次矩阵乘法的这120个真实输入已核对，下一步应向前定位形成direction/extra的晚期阶段，不能重复首步核查来解释旧尖峰。

## 数据、命令和接续

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-last-matrix/`。

- `plan.json`固定两端各60帧、720回放及242输入SHA（含203资产）；`tail-store-origins.json`保存实际PTX写来源。
- `original/`、`source/`含完整图JSON/DOT、每帧packet、状态、runtime、布局及as-run worker。
- `replay/`含全部720份输出和逐项状态；`certification-plan.json`含全部211个目标，不筛掉失败目标。
- `certificates/`含实际原子记录、计数、两端操作数、合法排列、GPU逐项历史及使用的完整探针PTX。
- `independent-cpu-audit.py/json`重核720输出、42240操作数、211证书/37136历史及固定C统计。

本轮全部GPU任务已终止：capture session81278、replay95100、certificates10223，均实际退出0。
未为了这项纯诊断再重跑74项；生产二进制和来源未改，不能把新增局部结果当成全局验收通过。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-last-matrix
.venv/bin/python "$phase/independent-cpu-audit.py"
.venv/bin/python -m reconstruction.csrc.g1_last_matrix_replay \
  --capture "$phase" --output build/NEW-g1-last-matrix-replay
.venv/bin/python -m reconstruction.csrc.g1_last_matrix_certificates \
  --capture "$phase" --output build/NEW-g1-last-matrix-certificates
```

重采必须使用新目录，传入本阶段`tail-store-origins.json`，以及上一图定义阶段的`abi.json`和`warp-schema.json`：

```bash
.venv/bin/python -m reconstruction.csrc.g1_last_matrix_capture --backend original --frames 60 \
  --proof "$phase/tail-store-origins.json" \
  --abi "${phase%-last-matrix}-graph-definition/abi.json" \
  --warp-schema "${phase%-last-matrix}-graph-definition/warp-schema.json" --output build/NEW-g1-matrix-original
```

然后用同样参数、另一个新目录运行`--backend source`，必须串行。
Windows仍按根交接使用WSL2；原始JSON中的旧机绝对路径不改字节，异目录接续须按根交接映射旧repo前缀并核对资产缓存。
没有在原生Windows执行这些Linux二进制，也没有把Windows文件当作同一处理版。

后续重点：最后矩阵的Ap在本轮已核对，向前追其direction及extra的形成阶段。
相关位置输入q会在后续apply中被覆盖，不能由q_out减dx来猜回原始F32输入；需要明确记录观察影响的图内快照或独立执行诊断。
新诊断应继续保存完整输入，按SDK实际运行/原版PTX/源码三端及真实F32操作数协议核对，旧尖峰内部状态仍缺失。
