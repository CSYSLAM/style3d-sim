# G1第一次累计力首差：RHS与初始零乘子joint AL

承接edcc36ac；固定SDK64a、host38b70dcd、公共Core7eb6e847、CUDA176/f0、依赖和生产数学均不改。
完整替代尚未验收，`solver_api_ready=False`，默认入口及旧C8保持。

## 先复现旧首差，再定位边界

同一旧source1 frame30公共起点，用已有两state buffer复制和drive flag reset，仅采一次SDK和一次源码正常Core。
这是两份局部算子诊断，不创建或扩充新的统计C队列，也不是旧隐含缓存和原子调度的精确继续。
源码bridge=false、未映射原版SDK代算；两次公共入口真实graph/test均实际退出0。
原demo速度helper的多行lambda问题保留，退出0不单独证明原意图中的速度条件。

实际记录first initialize_rhs(rank25)、joint AL force(rank30)、drive load(rank31)三处完整before/after。
每端70772字节/50快照；原17467节点/17466边完整保留，实际17517/17522且唯一拓扑/前后范围经CPU独立核准。
两端公共起点、控制/配置相同；joint AL的86份实际初始乘子均为零。

| 边界 | 两端调用前force | 两端调用后force | 其它指针输入 |
| --- | --- | --- | --- |
| first RHS25 | 逐位同 | 逐位同 | 全部逐位同 |
| first joint AL30 | 逐位同 | 11个分量不同，最大4.76837158203125e-07 | 全部逐位同 |
| first drive31 | 上述11个差异 | 9个分量不同，最大4.76837158203125e-07 | 全部逐位同 |

新两端drive before的完整force，分别逐位复现上轮冻结sdk0/rebuilt0，原始首差未换样或删改。
11个flat索引为180/181/184/185/186/187/188/192/194/198/201，对应particles60..67。
因此这批首差发生于joint AL核内，不需先扩采contact/rolling来解释这一个首差边界。

## 严格回放及按失败触发的后续证明

六份真实packet、SDK runtime/原版PTX/源码共18调用，30完整输出中26严格。
RHS全部6输出严格；drive全部18输出严格。
joint的SDK runtime两份都未严格复现，原版PTX及源码各1/2严格；四个失败检查原样保留。
独立CPU重核522792完整after字节、482712非输出/guard字节、270指针字段、2808实际ABI字节、
648标量字节及10020完整输出word。不能把回放程序退出0当作30项都严格。

失败后才准备原子后续。两份joint packet逐字节复制到atomic-v2/original和source，来源SHA保留。
实际核准两份全部指针payload及所有非指针scalar字节相同，含zero multiplier和真实非零初始force。
原版/source literal probe各执行两次，共4128个成对核对的实际原子操作数；每份2064，86线程各24次。
完整逐线程/逐目标及跨目标的顺序、地址和值bits相同，零和负零不删除。
CPU直接核67712完整after字节、59264非输出/guard、528实际含探针参数ABI字节及2112完整输出word。

逐弹簧隔离使用原SDK实际cudaLaunchKernel，以及原版PTX和源码KernelDriver。
保持全局body/particle及spring数组，只偏移multiplier指针12*k，并设count=1、spring_count=k+1、joint_count=1。
从正/负零force各执行，1032实际调用全部逐位同；并与真实线程操作数的预测逐位同。
CPU重新核544896个完整输出word和19952个保存的逐lane ABI字节；这些参数在三后端/双初值调用间复用。

对捕获after、原三端回放及有效新probe的全部不同目标bit固定1086份标量证书。
实际非零before force作为初值，最多8项的真实操作数全排列；GPU用真实global F32 atomic执行候选顺序。
1086全部通过，4292个实际GPU历史值经独立CPU重核，无unexplained目标。
这证明这些标量结果都与相同操作数的合法F32顺序一致；不推断原执行顺序，不证明一个共同全局warp调度。
也不据此把旧整段G1 C8或后续大响应改判为通过。

## 两次诊断错误完整保留

atomic/是第一次失败：新探针生产者按256条/线程读取，实际PTX按128条/线程存储，lane43起读到无效零记录。
GPU报告中的初步相同布尔值被独立CPU拒绝，不能作为完整操作数证明。
原源码、plan、as-run PTX、坏解析数据、日志和退出1完整保留；完整物理trace未保存，无法从旧NPZ恢复遗漏lane。

仅修诊断生产者的两个常数为128，在atomic-v2重新执行四次probe；原正常Core采集和六个packet不重复。
失败原源码的SHA为71fa75af…，保存在atomic/g1_first_joint_probe-as-run-v1.py。
两份joint输入及隔离/证书数学模板不变，atomic-revision.json核准修改范围。

随后隔离wrapper在导入reconstruction时失败，尚未创建isolation目录或开始GPU隔离。
旧wrapper、原as-run、日志和退出1保留。V3仅给外层包装器加入项目sys.path，并允许复用字节相同的as-run。
不重复已通过probe，隔离/证书/CPU模板字节均不变，V3后续全部实际退出0。

## 实际终态与接续

目录：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-first-rhs/`。

- CPU预检session10279、初始capture/replay/CPU驱动56089实际退出0；两正常worker及三后续任务全部0。
- atomic驱动67817退出1，probe0/CPU1；v2驱动23608退出1，probe/CPU/prepare均0、wrapper隔离1。
- V3驱动43265实际退出0；1032隔离、1086证书和独立CPU均实际0。
- 所有本轮GPU任务均已结束，原有失败和原始报告未被后续证书替换。

第一处已冻结的joint AL局部差异有了完整真实F32证据，生产数学不做无根据修改。
下一步继续追第4子步明显响应分组：核实际线性迭代的numerator/denominator及guarded ratio、非线性更新位置。
源码实际执行固定5*50轮，不能预设有host早停；应先保存真正的系数与分支输入，再按实际首差回放。
first joint的局部顺序证据尚未证明它导致旧23.85误差，旧C8 SHA32b6e2a7…及全部失败继续保留。
G1/复杂布料长程、粒子seed2、未捕获host组合及默认入口切换仍未验收，Windows继续原交接的WSL2流程。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python scripts/verify_reconstruction_snapshot.py
```

关闭GPU/CPU报告拒绝覆盖；接续实验需新目录并预先固定输入，保留实际退出码和失败数据。
