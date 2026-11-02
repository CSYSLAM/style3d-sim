# 驱动布料/self：完整输入回放结果及继续点

生产仍为host0dab/Core715，唯一SDK64a、CUDA176/f0、360份冻结pyc及全部旧失败保持。
候选7ca未合入，默认原版、`solver_api_ready=False`。本页的局部通过不等于完整solver替换通过。

## 已完成的实际结果

| 项目 | 实际范围 | 结果 |
| --- | --- | --- |
| 隔离首表面力F32证书 | 593次GPU标量调用、2304来源标量 | 原始数据及独立CPU通过；旧根工具退出码unknown |
| RHS/self/CG完整采集 | 四worker、2376阶段、29844快照文件 | 四GPU worker和独立CPU均记录退出0 |
| 完整输入三端回放 | 1188份、3564调用、6318输出buffer | 全部逐位一致，独立CPU通过 |
| 只读/guard与实际ABI | 104222592保护字节、76248参数字节、6354指针字段 | 独立CPU全部核准 |
| 首surface scale逐contact | 四份真实输入、792次三端隔离调用 | 全同，每端1416个实际F32操作数同 |
| scale标量GPU证书 | 155调用、768来源标量、1636历史word | GPU实际退出0、独立CPU退出0 |
| 刚体块三算子 | 198完整输入、594实际三端调用 | 全部逐位同，根GPU编排和独立CPU实际退出0 |
| 刚体块传播 | 每端243阶段、2106快照、327生产消费链接 | CPU实际退出0；新完整轨迹仍不同 |

四条完整采集轨迹均没有复现原冻结轨迹。新轨迹仍有明显差异：
SO3三步最大particle_qd差约14.13737，SIX约8.87093；两组旧固定C8仍三source全部false。
每一份捕获输入的三端结果相同，不能据此把不同输入下的完整轨迹改判为相同。

旧排队期间运行环境boot_id发生变化，原67261/2752/37865/97272工具句柄均不可取回；根退出码保留unknown。
读取的是这些任务实际保存的子进程退出记录及完整GPU输出；当前环境已再次核对全部相关审计输入SHA。
没有把`report.complete`当作根进程退出0，也没有因旧PID/工具消失重启原任务。

## 首轮差异：核准与排除

两组的首surface scale输入具有相同完整contact行集合，但各有16个行位置不同。
这里仅用CPU Counter核对完整记录集合，实际GPU输入从未排序或改写。
非contact输入和初始scale相同；两端按目标收集的原始F32操作数多重集合也相同。
155份真实GPU折叠证书覆盖捕获向量及三端aggregate的全部768个来源标量，不推断生产中的全局线程调度。

scale差异落在SO3的粒子26/42、SIX的粒子40，均为仿射刚体代理。
首轮self顶点索引为0..7；实际VF/EE/EF三个self Hessian都逐字节相同。
因此不能把scale的0.0078125差异直接认作后续大响应的原因。
CPU审计首版因错误假设contact数组顺序相同而退出1；as-run及失败receipt保留，v2修正后实际退出0。

第一条完整SIX轨迹在surface preconditioner之后有两个矩阵元素不同，随后进入刚体块装配。
该配置的`precondition_and_reduce`使用`precomputed=True`，z已由两个apply kernel计算；
不能只看这个reduce kernel便断言逆矩阵是否影响结果。

## 已完成：三个刚体块算子及实际传播

目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-body-block/`。

相同SIX夹具的原版/源码三步均已实际退出0，补抓此前1188回放未覆盖的：

- `build_affine_body_preconditioner<BlockNonZeroEntry>`：包含完整非空CableView指针及所有flat输入。
- `apply_block_diagonal_preconditioner`。
- `apply_affine_body_preconditioner`。

每端99个完整输入阶段，共198份实际输入、594次三端调用全部逐位一致。
独立CPU核14400实际参数字节、498960输出字节、4075920保护字节、18个别名组，全部通过。
相同捕获还核准每端243上下文阶段、2106快照及327个实际生产消费链接，包括：
body inverse/valid到affine apply、particle inverse到block apply、combined z到precomputed reduce、
残差到下一轮、最后delta到公开q。首矩阵/逆矩阵/六valid标志均同。

同一次新捕获在首CG之前的RHS已有1.52587890625e-5差异；首affine apply的z差9.313225746154785e-10。
随后五轮CG末delta差0.0003235340118408203，第一轮apply的q差与其相同。
三步公开particle_qd最大差14.736923217773438。新捕获不替换旧样本，首力来源仍需同运行进一步追踪。
首逆矩阵观测条件数约31122/204656只是诊断信息，不证明根因，也不修改阈值。

两次诊断错误均保留：原编排session85093/子48768实际退出1，原因是子Python缺少仓库PYTHONPATH，
在创建GPU上下文前失败；v2只修启动环境，原回放引擎/输入/数学不变，session7251实际退出0。
传播审计v1错误假设surface preconditioner之后直接进入body build，实际中间有drive/limit/rolling更新。
v2改为核对真正相邻生产消费字段，实际退出0，原始失败脚本及receipt均保留。

```bash
source scripts/reconstruction_env.sh
body_phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-7ca67172-driven-self-body-block
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["complete"],d["completed"])' \
  "$body_phase/operator-status-v2.json"
.venv/bin/python -c 'import json,sys;d=json.load(open(sys.argv[1]));print(d["strict_packets"],d["counts"])' \
  "$body_phase/replay-independent-cpu-audit.json"
```

上述任务均已结束，勿重启其旧PID或覆盖输出；冻结清单为body-evidence-manifest.json。
继续应抓首轮各个力的实际RHS生产、CG方向/矩阵/标量在同一运行中的传播。
BODY捕获没有完整保存首表面力输入，不能拿另一条FLOW轨迹的证书冒充它的首差证明。
不从公开q重建旧私有状态、不替换旧失败、不调数学/资源/容差来配结果。
Windows继续按主交接使用WSL2；新机器建立新计划并串行跑原版和源码。
