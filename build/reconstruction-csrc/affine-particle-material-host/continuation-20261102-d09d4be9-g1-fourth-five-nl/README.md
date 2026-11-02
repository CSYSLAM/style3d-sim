# G1当前Core55：同一次第4子步全部五NL、250CG及位置更新

最终目标仍未完成，默认后端和`solver_api_ready=False`保持。
本批host d09d4be9 / Core55d626f0 / SDK64a / CUDA176-f0及原demo、物理、预算、容差均未改。
本批接续05d0cd76db7de4b637a8c1f5c580995e427e78cd，不把此前不同诊断运行拼接成同一次求解。

## 方法和实际完成范围

仍用旧source1 frame30公共检查点；两端public state初始化同、已有drive reset相同。
没有恢复旧隐藏缓存，不是旧正常失败轨迹的内部状态精确续跑，也没有新增或替换任何C8样本。
增加只读图快照可能改变原子调度；所有结论限制在明确记录的实际输入。

同一个实际第4子步中，采全5次非线性求解，每次50轮CG，另采5次apply：
每端1015真实核、7090份D2D快照、45591980字节；实际API回读全部200字节copy描述符。
独立CPU核2836000描述符字节、91183960快照字节、6468实际指针/完整payload连接、8份跨NL实际复制。
每次apply的输出、dx清零及后续首CG清零初值核准；跨NL复制核实际src/dst/长度和完整前后字节。
5份inverse保留各自6336字节完整输入/输出别名，不分离成独立缓冲区。

双端2030真实packet，在SDK runtime / 原PTX / 源码共6090回放：

- 非归约输出7620/7620逐位一致，包含全部250CG向量及五次apply。
- 3000份scalar中1296严格，1704严格失败原样保留。
- CPU核274333440完整after字节、258101280只读/guard字节、408660实际ABI字节。
- 原图17467节点/17466边、kernel名称/geometry/类型化参数及指针身份对应相同。
- 14类核、7812调用的资源属性不同仍保留，不据此改资源或强行模拟原子调度。

固定全部1000份实际归约输入和2148个既有目标，不更换失败结果：
2000字面探针记录352000贡献，原PTX和源码逐贡献同；6000隔离核准1056000独立SDK/PTX/source贡献。
最多79个负贡献，无subnormal；包含捕获/回放/探针的全部2633标量目标都有真实GPU F32证书通过。
每例搜索预算100000，实际最大6929；463408完整硬件before值经独立CPU FTZ逐项重算同。
CPU另核654128000完整after字节、637224000只读/guard字节、706788实际ABI字节。
全部非阻塞回放/探针/证书均先fence pageable H2D reset；生产同步及数学未改。

这是逐目标合法排列证明，不是联合全局调度或正常长程等价证明；1704严格失败不改判。
第1/2/3/5/6子步不在本批完整250CG核对范围内，不能扩称六子步全部1500CG已证。

## 实际响应及准确边界

| body12增量最大绝对值 | SDK | 当前源码 |
| --- | --- | --- |
| NL1 | 0.01121798 | 0.01105857 |
| NL2 | 0.01068641 | 0.01054250 |
| NL3 | 0.02259743 | 0.02358615 |
| NL4 | 0.02309475 | 0.02407009 |
| NL5 | 0.03644598 | 0.03642114 |

本次两端均出现较大响应，不据此解释上一批分组的唯一原因，也不重判旧约23.85尖峰或固定C8失败。
当前正常图C8仍用上批固定八SDK/三源码，123字段/帧越界；本批正常图新C8运行数为零。
原example速度lambda问题仍未改，CLI退出0不证明物理/数值验收通过。

## 实际进程及命令

- 272ab3预检0：两端旧实际图1015布局、完整span和输出核准，GPU未初始化。
- 根session88615 / 269f1d实际0：SDK492411、源码494767、CPU497365、回放499551及CPU499798全0。
- 0480fa原子冻结0：1000输入/2148既有目标预先固定。
- 根session63194 / 08d2bc实际0：GPU500886及独立CPU501294全0。
- 6b4a8e图定义CPU0；718724汇总独立CPU0。
- 额外宽度检查194e18误纳旧133列worker模板而退出1；原样保留模板，ba14e1维护代码门禁0。

自己的GPU worker严格串行、每次记录free/apps，准入最低实际17366MiB；外部worldparticle未停止或等待。
SDK仅在明确original采集及隔离诊断使用；正常源码worker运行时确认SDK未映射，无A/B桥、无登录。
原命令、PID、退出码、全部模板、as-run和原始失败均保存；这些完成目录拒绝覆盖。

```bash
source scripts/reconstruction_env.sh
PH=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-d09d4be9-g1-fourth-five-nl
.venv/bin/python -B "$PH/prepare.py"
.venv/bin/python -B "$PH/run.py"
.venv/bin/python -B "$PH/atomic-prepare.py"
.venv/bin/python -B "$PH/run-atomic.py"
.venv/bin/python -B "$PH/close-independent-cpu.py"
```

上面是实际执行命令，已有结果时不要重新运行；新诊断创建新phase并先冻结新计划。
图定义可用`reconstruction.csrc.graph_definition_compare`和旧warp-schema在新output复核，禁止覆盖旧报告。

## 接续及Windows

这一批排除了所捕获250CG实际输入上的逐粒子算术及apply差异，不把它扩大到所有物理输入。
本范围不需再次只查CG首末；接下来优先回到未完成host组合，在当前d09上接续4f/7ca候选和复杂布料。
保持旧G1长程/C8为活动失败，必要时再从实际组装/RHS/跨子步数据链向前追踪。
发现向量差异就查实际原PTX/ABI/同输入SDK；贡献同的归约才走证书，不修改物理或容差。

Windows仍WSL2/Linux Python3.12，项目内固定SDK/360pyc及真实源码ELF随同一仓库携带。
正常Core55入口命令见上一批README及根交接；本批不是Windows `.pyd`移植，也未声称本机测试过WSL。
历史plan固定绝对路径，换目录会拒绝；新phase需核原SHA、记录路径对应、重新冻结，不删断言或改写旧结果。
过程持续写WORK_LOG，完整阶段结束后集中一次提交，不按单次改动提交。
