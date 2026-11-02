# G1 正常入口的实际 CUDA graph 定义核对

固定原版仍为项目内SDK64a；活动host38b70dcd、公共Core7eb6e847、CUDA176/f0均未改。
本轮只新增诊断与证据，没有改变生产数学、launch、比较阈值或默认入口。`solver_api_ready=False`。

## 已执行及结论

采用旧G1正常公共Core worker的精确源码，只把`graphs.append(True)`改成保留实际Graph对象，
并在60帧、示例测试和状态NPZ保存完成后查询graph。没有向graph插入节点或GPU复制。
原版、源码各预先固定一次，严格串行；两次真实graph和示例test均退出0。
源码未加载原版映像、未使用A/B bridge。这两次是新增诊断，不替换冻结的八原版/三源码。

| 实际图内容 | 原版 | 源码 | 核对 |
| --- | --- | --- | --- |
| 节点 | 17467 | 17467 | 类型、唯一拓扑次序同 |
| 依赖 | 17466 | 17466 | 按拓扑rank逐边相同 |
| 内核节点 | 15672 | 15672 | 名称、三维grid/block、shared及设备ABI布局同 |
| 自有内核节点 | 15636 | 15636 | 原始参数全部保存，按既有显式schema核对 |
| Warp节点 | 36 | 36 | 10种内核，按实际加载模块的生成声明核对全部参数 |
| D2D复制 | 174 | 174 | 原始尺寸、内存类型、坐标、pitch及指针复用关系同 |
| 清零/填充 | 1621 | 1621 | value、elementSize、width、height、pitch及目标复用关系同 |

驱动`cuFuncGetParamInfo`逐函数查询全部参数宽度和设备offset，直到明确返回非法参数index；
129项自有清单的已出现函数还与固定manifest宽度核对。非自有参数也保存原始字节，没有跳过这些节点；
本图36个非自有节点全部为Warp，未出现另外的Thrust/CUB节点。
本图没有child、host、event、未知类型节点；本轮没有声称验证这些未出现的分支。

独立CPU复核用另一种方式直接构造原始地址双向映射，确认95318个标量字段、238397个指针字段出现位置相同，
形成267对唯一非空地址。1969个实际复制/填充范围产生525723次成员/偏移检查，其中4910次地址位于范围内，
全部相同。这个范围核对比单纯NULL或地址身份更强，但仍不是完整分配边界或设备pointee内容证明。

Python ctypes布局由本机CUDA12.4头文件的独立C++ `sizeof/offsetof`程序核对：
unversioned kernel params使用明确的v1，大小56；memcpy200、memset40、host16，每个字段offset均同。
不能用头文件默认的kernel v2别名替代v1来调用旧export。
Warp由实际运行日志指定的模块hash选择生成CU；类型化布局与真实驱动参数宽度相同。
Warp结构仅排除声明中不存在的padding（2500字节出现量），原始字节仍完整保留；没有按数值大小猜指针。

## 仍有差异与证据范围

14种内核、7812个节点的编译资源属性不同，包含register、local bytes及max threads。
具体值见`graph-function-resource-differences.json`。这些差别没有改判为一致，也没有被证明是轨迹根因。
不能为凑资源数量随意改launch bound、数学或原子顺序。

两条新增诊断与冻结11条轨迹都不逐位相同。按原八份固定C8计算，两条新增诊断均未通过，
四字段都是58/60帧位于既定范围；新增原版速度最大偏差约1.119，新增源码约1.111。
这两次没有复现旧source1的23.8513速度尖峰，不能据此覆盖或解释旧失败。
全部统计已由独立CPU代码重新计算，原固定C8报告SHA仍为
`32b6e2a7337aaa80442fa3fd6232896410eb8163e875d35d845d4a8ae82d4e42`。

当前结论只证明这次正常G1捕获图的结构、已类型化参数、地址复用和所记录范围内偏移一致。
没有读取设备pointee，没有证明所有图执行的中间结果一致，也没有恢复旧23.85轨迹的内部状态。
本轮也未抓取kernel-node的额外属性（例如cooperative/priority），未单独验证graph_exec的有效属性；
已抓取的是标准launch参数与CUfunction资源属性，不能写成所有图属性均已比较。
因此整段G1仍未验收，完整solver仍未替代。

## 原始证据与命令

证据目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-graph-definition/`。

- `plan.json`：预先固定两端各一次，242个输入SHA，包含203资产与生产源码/二进制。
- `cuda-graph-abi.cpp`、`abi.json`、编译命令与二进制：真实头文件布局证据。
- `original/`、`source/`：完整as-run worker、provenance、60帧NPZ、runtime、graph.json/DOT及终态日志。
- `warp-as-run/`、`warp-schema.json`：日志选择的CU及编译产物、布局依赖源、全部显式字段。
- `graph-comparison.json`：图定义、完整参数/geometry和资源属性报告。
- `pointer-bijection.json`、`independent-cpu-audit.json`：独立双向映射与实际范围偏移审计。
- `diagnostic-trajectories.json`：不替换固定cohort的新轨迹统计；旧失败仍保留。

运行GPU诊断必须选新目录；下面命令不会改固定cohort。两端必须串行，且不要在其运行期间修改工具或生产源码：

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-graph-definition
.venv/bin/python -m reconstruction.csrc.g1_graph_definition --backend original \
  --abi "$phase/abi.json" --frames 60 --output build/NEW-g1-graph-definition-original
.venv/bin/python -m reconstruction.csrc.g1_graph_definition --backend source \
  --abi "$phase/abi.json" --frames 60 --output build/NEW-g1-graph-definition-source
```

现有原始数据的纯CPU复核：

```bash
.venv/bin/python "$phase/audit-graph-definitions.py"
.venv/bin/python -m reconstruction.csrc.graph_definition_compare \
  "$phase/original/worker/definition-0/graph.json" "$phase/source/worker/definition-0/graph.json" \
  --warp-schema "$phase/warp-schema.json" --output build/NEW-g1-graph-comparison.json
```

初次CPU导入发生Python class comprehension作用域错误，任何GPU worker之前已退出；
旧工具和错误保存在相邻`*-startup-failed/`。CPU生成schema时发现全缓存存在重复symbol，改为实际日志hash选模块；
随后全日志相同断言因最终test_body_state模块名字不同失败，精确旧脚本与错误保存于`prepare-errors/`。
图内全部非自有内核的实际模块、生成声明和运行宽度仍严格核对，未用忽略未知图节点的方式绕过失败。
`prepare-warp-schema-as-run.py`保留成功执行版本；同名维护脚本只修正了一条过度推断的注释。
GPU driver session27273完成两端0后句柄已消失；CPU comparator session87920明确退出0。没有任务仍在运行。

## 下一步

图定义这项已核完，继续新增能保存真实同输入的G1执行诊断，逐帧/六子步定位首个内部buffer差异，
再对这个实际输入做原版运行、原版PTX和源码核回放；涉及归约时按既有真实F32操作数协议核对。
新增诊断必须记录是否复现原冻结失败，不能把不同轨迹或首步PCG证明拼成旧23.85尖峰的解释。
固定原八份、原三份失败、比较门槛和生产数学均保留；不要再把补采SDK加入基准来得到通过。
Windows仍按根交接在WSL2使用固定Linux对照；本轮没有新增原生Windows可用性结论。
