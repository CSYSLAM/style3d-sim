# G1第4子步CG系数与非线性位置更新

承接d4e13608；SDK64a、host38/Core7eb、CUDA176/f0、依赖、生产数学与旧C8不动。
完整源码替代仍未验收，`solver_api_ready=False`，默认入口保持。

## 实际观测范围

原公共source1 frame30起点，两state buffer复制及原有drive flag reset，预先固定八SDK/三源码各一帧六子步。
正常公共Core、真实graph/test均实际退出0；源码bridge=false且未映射原SDK代算。
原速度helper多行lambda问题保留，CLI退出0不能独立证明速度阈值正确。
这不是旧隐含缓存或原子调度的精确继续，不替换旧冻结8/3轨迹。

维护工具：`g1_cg_scalar_trace.py`、`g1_cg_coefficient_replay.py`。
每次采集第4子步250次CG update之前的实际num/den、5次apply的完整三输入/两输出，以及六子步末particle_qd。
世界参数实际为空指针、width=176、count=176；本场景每组只使用一个F32系数，不将4字节观测外推到其它world布局。
body proxy索引704字节也实际读取并核准覆盖0..175，body12对应48..51。

每端一个68176字节buffer、532个只读D2D节点；原17467节点/17466边完整保留，实际17999/18264。
新增节点的before/after依赖、唯一拓扑次序及全范围经CPU独立核准。
每次从CUDA API实际读回532个CUDA_MEMCPY3D描述符，保存全部原始200字节，核src/dst/width/height/depth。
11次共749936观测字节、1170400实际copy描述符字节；没有只相信预期布局或运行时布尔值。
新增快照可改变原子时序，这一事实保留在provenance中。

## 系数源和实际GPU受控校验

实际图中2750个precondition→num、2750个matrix→den、2750个direction当前num链接均核准。
55次第一迭代的previous_num确实为空；2695次非首迭代previous_num恰为前一F32槽位。
因此beta配对来自实际图消费者，不仅依据数组下标推测。

全部2750组alpha、2695组beta输入保留原始F32 bits，随后预先固定三端受控单位向量调用。
alpha使用实际update_solution_and_residual；beta使用实际update_cg_direction的非首分支。
控制world width设1、beta iteration设1，逐粒子处理所有实际scalar pairs；actual graph中的world width仍176。
这是系数运算校验，方向/乘积/残差/解用已声明的单位向量和固定初值，不能称作原CG全部向量的回放。

原SDK cudaLaunchKernel、原PTX、源码KernelDriver共六次GPU调用，5445组输入/三端16335份scalar pair计算。
三端完整输出全部逐位同；CPU从原字节核73755完整输出word、736080完整after字节、372实际ABI字节及guard/只读输入。
CPU RN单精度除法与GPU读出的alpha/beta位模式也全部相同。

| 量 | alpha | beta |
| --- | --- | --- |
| 实际scalar pairs | 2750 | 2695 |
| 触发guard归零 | 0 | 0 |
| 负分母 | 0 | 0 |
| 最小分母 | 5.573395810642978e-06 | 1.47107102748123e-05 |
| GPU最大系数绝对值 | 18.321388244628906 | 9.632377624511719 |
| CPU RN除法不同word | 0 | 0 |

所有实际num/den都有限，分母均正且超过1e-30阈值至少5.57e24倍。
这批响应分组没有发生CG系数保护分支切换；不能据此排除CG向量/矩阵输入差异或其它帧中的该分支。

## 非线性更新中已经出现的两组响应

55次实际apply的out=x+delta和delta清为正零全部逐位符合CPU F32运算，110完整输出/58080输出word核准。
这里记录的是全部apply输入/输出；CG update只读取系数，并未捕获其全部向量pointee。

下表为描述性观测，精确值和全5轮位置保存在trace-independent-cpu-audit.json，不能作为新验收阈值。

| 运行 | 第2轮body12最大增量 | 第4子步末最大代理速度 | 帧末body12 component4 |
| --- | --- | --- | --- |
| sdk0 | 0.010533 | 13.826688 | 0.889742 |
| sdk1 | 0.001184 | 0.642639 | -23.023016 |
| sdk2 | 0.000967 | 0.660532 | -23.055731 |
| sdk3 | 0.001352 | 0.662018 | -23.251842 |
| sdk4 | 0.001384 | 0.638496 | -23.109482 |
| sdk5 | 0.010512 | 13.879787 | 0.895693 |
| sdk6 | 0.001096 | 0.658804 | -23.063887 |
| sdk7 | 0.001231 | 0.666106 | -23.253881 |
| rebuilt0 | 0.001342 | 0.638127 | -22.960688 |
| rebuilt1 | 0.010631 | 13.832536 | 0.891278 |
| rebuilt2 | 0.001344 | 0.646397 | -23.056398 |

SDK与源码都出现两组；显著分组在第二轮非线性增量中已存在。
第一轮及更早状态已有差异，不称第二轮才产生首次末位差异，也没有证明具体物理原因。
新单帧固定8/3数值C三源码都通过；各自对首SDK的整状态严格差异和旧C8继续保留，不能升级为完整G1验收。

## 实际终态及下一步

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-fourth-cg-scalars/`。
CPU预检实际退出0；驱动session77594实际0，11 worker、公共状态CPU、trace CPU、系数prepare/GPU/CPU全部实际0。
系数链接/范围独立CPU session7986实际0，所有本轮GPU任务都已结束。
实际GPU占用观察保存；外部PID2687317曾占用，未中断，其终端退出码未知。

下一步将完整输入采集位置收敛到第4子步第二轮的RHS/预条件器及必要CG向量。
先比较输入状态/力/矩阵，再按实际首差做共同输入核回放，避免把系数守卫或host早停当作未经证实的原因。
本轮不改生产数学，没有重复74项回归；G1/复杂布料长程、粒子seed2及未捕获host组合仍需继续。
Windows继续既有WSL2固定Linux SDK/CPython3.12流程。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python scripts/verify_reconstruction_snapshot.py
```

所有脚本、as-run、完整原图、描述符、原始blob、公共状态、系数及传参/after都随证据保存。
关闭输出拒绝覆盖；后续需新目录、预先固定输入并保留失败。
