# 缆绳＋刚体约束：实际缺口、六缓存修正和验证

目标仍是源码独立替代固定SDK64a。生产仍host0dab/Core715、readyFalse；旧正常demo及固定C8/C10失败不改判。
本批已恢复并验证三个单family组合的隔离候选，没有切换生产或默认后端。
所有GPU worker串行，允许外部程序，逐次检查free>=4096MiB；原版仍项目内固定处理版，不使用另一仓库的so。

## 实现与发现

`reconstruction/csrc/cable_body_constraint_scene.py`让缆绳与一个plain spring、point-line或distance约束
共同作用于同一移动刚体，另一段固定。W1/W3、Newton/PD、body block开关，共24组合。
SDK24组实际三步正常且两个force模块都改变RHS；生产24组均在precompute_cables被guard拒绝。

第一候选 `candidate-scope-only/source_solver.cpp` 只准入该范围，image `d2c07018`。
24组状态及10680 owned调用的已审计标量/view空值/完整geometry相同；60步eager/真实graph的96比较全部严格。
但首构造核对明确失败：分配62/62却顺序不同，typed initializer为33/27，不能据轨迹同而宣布恢复正确。

实际SDK初始化先创建六块带类型的零缓存：mat3×8N、mat3×8N、int×8N、int×N、vec4×N、int×N。
原源码晚分配，且五块未初始化。`cable-cache-difference.json`将实际CableView104/112/120/128字段与前四分配对应，
删去SDK这六项后，其余27个typed signature及顺序完全相同。实际initialize/reset/copy反汇编也已保存。

修正后的 `candidate-cache-order/source_solver.cpp` 保留准入调整，只将六缓存改为上述typed-zero并提前初始化；
其image完整SHA为 `b82ecd80c2d8b355645e5d8d0b131636da74d55f550d2293c6bcada70bfb226d`。
没有改变CUDA176、库版本、求解数学、迭代预算、容差或真实原子顺序。
两个候选的C++、编译命令、输入SHA和真实so均在本仓库，不靠SDK代算。

## 已经实测

| 检查 | 缓存修正候选的实际结果 |
| --- | --- |
| 24个三步组合 | 全部退出0、状态逐位相同；10680 owned调用覆盖完整 |
| 三步独立CPU | 直接核全部状态及96份force before/after原始buffer，相同 |
| 六类构造 | 36个GPU＋6个CPU子进程全部0，五项检查全部相同 |
| 原／源typed数量 | spring及point-line各33/33，distance35/35 |
| 完整CableView | 459对，scalar、17指针字段及owned四缓存完整span核准 |
| 60步eager／真实graph | 双worker退出0，96/96完整比较逐位相同 |
| graph独立CPU | 两候选各3409920状态字节，192项比较全部相同 |
| 六类双端initcheck60 | 12个实际sanitizer退出0，全部零错误 |
| initcheck独立CPU | 六对完整60步状态逐位同、原始日志及image/mapping正确 |

构造五项是分配/释放字节身份位置、上传字节与顺序、typed初始化字段与顺序、flat owned指针身份/偏移、
owned＋library内核次序。完整CUDA API覆盖、外部Warp真实allocation边界及全部pointee内容不在该检查的证明范围。
launch比较自身只核指针空值与view标量，不能代替构造中的指针身份检查。

首轮W3夹具用replicate漏带手工spring，缺少实际force，检查器因此退出1；旧夹具、原运行和失败完整保留。
当前逐世界显式构造，不修改生产builder。旧constructor失败同样保留，不覆盖或改成通过。
131列generator原运行保存为as-run，现版本仅拆行；生成worker及GPU结果没改。

## Windows／新目录接续命令

Windows仍用WSL2和Linux Python3.12；Linux so不能作为Windows pyd加载。本机没有实际执行WSL测试。
先依根交接恢复环境，然后核快照。不要直接重启原机器一次性run脚本，它们保留旧路径和输出拒绝覆盖。

新增 `reconstruction/csrc/candidate_demo_worker.py` 在读取时重定位记录的仓库前缀，
逐文件和image严格校验原SHA，不修改原manifest、不绕过校验。
真实验证用了不同的记录前缀，源码独立运行三步与SDK全状态相同；错误image SHA、父目录逃逸及repo外路径
三项负控制均在GPU前被拒绝。`portable-candidate-check/`保留原始记录，这不是实际Windows/WSL运行证明。

```bash
export PYTHONDONTWRITEBYTECODE=1
python3 -B scripts/verify_reconstruction_snapshot.py
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-0dabbaa7-cable-body-constraints
for backend in original source
do
  .venv/bin/python -B -m reconstruction.csrc.candidate_demo_worker \
    --backend "$backend" --candidate-build "$phase/candidate-cache-order/build.json" \
    --example reconstruction/csrc/cable_body_constraint_scene.py --frames 60 \
    --output "build/windows-check/cable-plain/$backend" \
    -- --constraint spring --worlds 3 --mode pd --body-block
done
```

输出目录必须尚不存在，原版和源码依次运行。源码worker不登录、不映射SDK。
原机可以用各 `audit-*.py` 重新复核对应冻结数据；包含旧绝对路径的原审计不直接冒充新机器可运行命令。
新机器重编译应保留旧image与证据，使用本地工具链重建并独立验收；不得把路径导致的ELF变化直接当旧image已通过。

## 下一位agent接着做

1. 补新准入谓词实际还会放行的spring＋distance、point-line＋distance组合；spring＋point-line＋cable仍由旧guard拒绝。
2. 核原有cable penalty API、ramp开关及全量/选择reset分支，特别是这次提前初始化的vec4与initialized缓存。
3. 保存当前0dab完整构建checkpoint，再将已验证修改合入生产、重新编译匹配的公开Core。
   对新image重新跑必要回归、固定失败cohort和相关正常demo，不能继承旧image的69/74或局部C结果。
4. 继续原来的G1、复杂布料、4f/7ca及正常长程固定失败；完整solver替代尚未完成。

本批准入保留joint/cable、自碰撞、外部接触和其它物理组合限制；没有把单family的24样本改称完整host范围封闭。
