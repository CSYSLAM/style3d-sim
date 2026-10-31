# evaluate_angular_limits CUDA 验证

2026-10-30 UTC。旧 so SHA256：
`4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6`。
新增源码在 `kernels/joints.cu`，包含 `AngularLimitView`（32B）及 `evaluate_angular_limits`。
复用已经核对的 armature 几何辅助函数，没有改动既有 CUDA 入口。

## 本轮结果

原版及源码各执行 seed1/2/3 的四个组，共24次分组运行，全部 exit0，失败列表为空：

| 分组 | 每 seed、每 backend 检查数 |
|---|---:|
| joint_drives | 20 |
| joint_drive_branches | 40 |
| joint_armature_branches | 96 |
| joint_limit_branches（新增） | 280 |

两个使用限位内核的源码组，其 stderr 均包含 `23evaluate_angular_limits`，没有回退。
每 seed 的35次限位路径审计，写入地址/表达式/浮点判断零差异；写入表达式数分别为36288、36108、35928。
有写入的调用均检出了人工 mul->add 错误。既有4个关节入口的审计器回归也全部通过。

PTX 仍是文本不同，不能称为 PTX-identical；当前定义90/131（43 identical、47 different、41未写）。
以上是覆盖用例上的 GPU 逐位及 PTX 数据流验证，没有登录完整求解器或运行 demo，不代表全部入口均已验收。

## 核对的行为

参数按原版 launch 确认：JointCoordinateView(120B)、AngularLimitView(32B)、positions、previous、
angle、initialized、inverse_dt、direction、force、block。限位数组按 local dof 访问，状态按 global joint 访问。

- 只处理 type==1；ke、kd 同时为零才跳过，保留负系数的原版行为。
- initialized 任意非零值读取保存角度，否则从 previous 求角度。所有输出模式都需要这个状态选择。
- 保留 add.rz + trunc + FMA 的角度展开顺序；不更新 angle/initialized 数组。
- 下限恢复力取 max(0, ke*(lower-q)-kd*w)，上限取 min(0, ke*(upper-q)-kd*w)。边界相等不激活。
- 原版按初始恢复力是否非零、有限决定激活，随后才选择输出模式。s=FMA(kd,inverse_dt,ke) 不强制为正。
- block 优先于 direction；对角块及投影均 child/parent 按slot交错，向量写回先child再parent。
- direction 投影后的 tau 没有第二次有限性检查；非有限 direction 的 GPU 对比专门覆盖了这个区别。

初版已有随机组即通过。路径审计先报告原版 geu 与源码 lt 的判断表达不同；
两者是 `geu = !lt` 的精确IEEE互补（含NaN），基本块方向相反。诊断器增加这个规范化并比较规范化后的真假，
没有把有序和无序判断混为一谈；所有新增边界和异常值 GPU 用例也通过。

静态 mul/fma/sub/sqrt/div/min/max/rounding/atomic 数目均相同。
源码少4条 abs，是原版当前 atan2 路径对同一 sin/cos 重复求绝对值的公共计算复用：
原版 legacy.txt 行400/402、417/418、434/435 的相同输入可直接核对。
原版一个 geu 变为其精确互补 lt，其余为加载、寄存器、基本块和指令调度差异。
完整表达式与判断审计不能替代 JIT 后 GPU 结果，本轮两个层面均通过。

## 新增分支和激活覆盖

`joint_limit_branches` 使用三世界，最后一世界不足32个joint，独立刚体、打乱dof、输出尾部哨兵。
32类场景包含：上下限、区间内、精确边界、相邻float边界、阻尼抵消、纯阻尼、双零系数、type0/2/-1、
有效/无效previous、已存状态忽略无效previous、退化轴/参考、NaN上下限/系数、Inf系数/角度、多圈展开、
负系数以及s为零但初始恢复力非零。

新增32项激活断言直接检查原版输出是否改变，确认预期激活/不激活的场景确实被命中；原版先独立通过。
另覆盖mixed/stored/previous三种状态：全stored时previous=NULL，全previous时angle=NULL。
执行force/tangent/block/block_priority、非有限direction、inverse_dt=0/-240，核对完整输出、尾部、状态只读性。
新增用例直接以原版GPU为参照；没有修改冻结NumPy公式、旧测试或比较容差。

## 复现命令

从仓库根目录执行，seed同样取2和3：

```bash
.venv/bin/python -m reconstruction.kernel_ab --only joint_limit_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_limit_branches --seed 1
RECONSTRUCTION_KERNELS=csrc .venv/bin/python -m reconstruction.kernel_ab --only joint_drives --seed 1
env -u RECONSTRUCTION_KERNELS .venv/bin/python -m reconstruction.csrc.audit_limits_ptx 1
.venv/bin/python -m reconstruction.csrc.ptx_compare --show-diff evaluate_angular_limits
```

## 证据和后续

`build/reconstruction-csrc/limits-audit/`：

- gpu-final-summary.json、final-*.json/.err：最终24次GPU组测试。
- audit-final-summary.json、dataflow-final-seed*.log、dataflow-seed*.json：最终35调用/seed审计。
- regression/armature-audit、regression/drive-audit 及 *-regression-seed*.log：旧4个入口回归，输出放在本批目录。
- coverage-legacy-seed1.*：原版激活覆盖先验证。
- dataflow-first-seed1.log：规范化互补判断前的报告；没有数值/写入差异。
- legacy.txt、final.ptx、final.diff、float-op-counts-final.json：PTX依据。
- changed-entries-final.json：既有入口变化0、新增1；ptx-status-final.txt：完整编译进度。
- kernel_ab-added-tests.diff、joints-before.cu、provenance-final.json：修改范围、基线源码及最终SHA256。

一次新增激活断言的补丁因定位字符串不唯一而被assert拦截，未写入文件；随后限定在新增函数内完成。
本轮未改旧so、src、examples、依赖、认证，未commit/reset/checkout。
下一项建议 `query_particle_pairs`（self_collision.cu，已有particle_pairs测试组和selfcollision.py规格）。
