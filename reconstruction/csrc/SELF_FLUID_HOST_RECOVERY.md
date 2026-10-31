# Self/fluid host recovery

当前source image：`929adeb01ffac876cd7a33508c4541d10eab86fea5098f418fcb50d6567ed35d`。
参考仍项目内`64a0be7f…`，双方不登录，CUDA176/f0未改。完整solver仍未替代。

## 实际依据与改动

- 原版SelfCollision initialize 137fcf先把本地group清0；138030..13804c把fluid所选粒子设1；
  1380b8..1380e1把granular设2，并拒绝fluid/granular重叠。
- 此处两个copy_to_host<int>的CUDA translation-unit符号不同：SelfCollision为1394a0，
  SolverNewton为114090。前者short span suffix是`is smaller than its collision count`，不能用后者model count。
- 下标越界为ValueError，文字与cold分支/实际旧contract一致。静态证据及完整命令/hash：
  `build/reconstruction-csrc/self-fluid-host/static-64a0be7f/`。
- source只恢复分组并移除self+fluid guard；body/granular/full-surface的组合guard保留。
  生产归约、数学、比较阈值均未调整。

## 当前验证范围

原版8组：`build/reconstruction-csrc/self-host/validation-d1a6bd58/self-fluid-reference8/`。
包含cached/fallback、Newton/PD、full/diagonal、W1/W3，以及有未绑定粒子15靠近fluid粒子7的真实混合材料。
原版8组全部finite/group正确；纯fluid full PP增量0，mixed full W1/W3 PP增量1/3。
只读一行query count，未抓所有未初始化候选槽，也不把opaque Model全部字节作为已还原。

当前image输出：`build/reconstruction-csrc/self-fluid-host/validation-929adeb0/`。
0fa首轮全部metadata不同：source把fluid preconditioner放在self之前；原版相反。
929只按实际顺序修正这一处，旧0fa首候选/失败保留在其同名目录与检查点。
run.py串行执行fluid57行为、granular103行为以及source self/fluid8实际A/B。尚未完成，不预先计通过。
首个候选必须保留；若状态不同，先看完整owned metadata和定义buffer，再抓first difference与同输入重放。
每组first-call group/刚度/force/Hessian/preconditioner/tangent的定义prefix都按原版比较；不比较未初始化尾部。

## 命令

只能在本项目没有活动GPU worker时启动新GPU批次。输出用新目录，不能覆盖已有首候选。

```bash
.venv/bin/python -m reconstruction.csrc.build_host
.venv/bin/python -m reconstruction.csrc.self_fluid_ab --backend original \
  --output build/reconstruction-csrc/NEW-self-fluid-reference
.venv/bin/python -m reconstruction.csrc.self_fluid_ab --backend source \
  --references build/reconstruction-csrc/self-host/validation-d1a6bd58/self-fluid-reference8 \
  --output build/reconstruction-csrc/NEW-self-fluid-source
.venv/bin/python -m reconstruction.csrc.fluid_contract_ab --output build/reconstruction-csrc/NEW-fluid-contract
.venv/bin/python -m reconstruction.csrc.granular_contract_ab --output build/reconstruction-csrc/NEW-granular-contract
```

## 修改前检查点与尚未完成

`self-d1a6bd58-before-fluid-self-groups/`保存442源/构建、17252结果SHA，已独立复核0错。
d1a74为71严格，三粒子固定C10通过；self 16/16/8和246项contract通过。
材料56为46严格；10个严格差异case的固定C8为6通过4失败，原报告/首候选全保留。
三个尚无完整原版匹配的first differences，已由真实原版runtime/原版PTX/source在同buffer各64次重放，
所有pointwise和各自两种完整三world scalar tuple全部相同；六份独立PCG重放450 pointwise全同。
这些解释已观察的局部差异，不把C8失败改判，也不代替完整demo验收。

当前新image尚需完成self/fluid实际测试、既有fluid/material/graph检查和同image回归。
尚未恢复self+body/granular/full-surface；官方bag60未验收。solver_api_ready仍须False。


## 929当前验证更新

57项fluid、103项granular行为全部相同。8组三步source全部owned完整metadata/coverage同，6状态严格。
两fallback的post PP RHS不同，但原版/source各自PP前后整个force均不变，差异已在上游发生。
真实四份fluid grid输入points/volume/IDs/world/cells完全同，head/next出现三种合法链；
所有实际输入经source evaluate_rows的六项输出和有效cache prefix全部严格相同。
Newton与PD两组固定首source0及source1/2一次、同协议8原版，三步q/qd全部C内；额外9worker ABI/count同。
原strict报告不改，另存`three-step-stage-audit.json`记录有限阶段判断。

self/fluid 60步graph为21/24严格。W3 Newton只有cross-backend eager和各自eager/graph不同；
source graph与original graph完整60步严格同。固定原eager/graph首候选，排队8原版/3source同模式C核对，
不会混合eager与graph样本；原版自身eager/graph的差异也原样保留。

同image既有fluid graph30全部24比较严格；74与self回归尚在`continuation.py`。
后续`after-continuation.py`等待全部本项目GPU worker退出，再串行做上述cohort和97项fluid topology。
`--suite self-fluid`会重复完整原graph worker，核对fixture/base fixture/runner/image/frames。
该新suite退出码同时要求全部步C内；mesh默认行为保持原样。不要只凭额外ratio判全部通过。


## 929批次最终状态（继续恢复其它组合之前）

同image74为71严格；粒子固定C10只有seed1通过，seed2的一个数组和seed3的六数组失败均保留。
seed2对应整个case三步18字段在旧实际原版中有6份匹配，seed3尚未找到；不能因此改判C10。
self16/16/8、246配置、fluid57/97和granular103行为全部同。

W3 NN graph三条固定source均60/60步C内且完整匹配原版；eager source0的q48/60、qd53/60在C内，
source1/2均60/60且匹配实际原版，eager source0仍未验收，没有重选或盲目扩样。
独立同步60步8580 watched launch的所有after buffer严格同；186次contact input raw差异在valid count内
按唯一(particle,shape)排序后整条记录完全同。此观察器仅部分元数据/输出，不代表全部kernel ABI或所有库启动。
原始trace exit1和first eager source0失败均不改。

颗粒+self原版八组位于当前929目录`self-granular-reference8/`。
`self_fluid_ab --family granular`可复用这些实际参考，但当前source granular+self仍有保护。
需另开新的source输出，先核对完整调度/定义buffer；不能只凭末状态相同。
