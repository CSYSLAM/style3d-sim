# G1冻结公共输入与共同单帧起点核对

固定SDK64a、host38b70dcd、公共Core7eb6e847、CUDA176/f0未改。
源码可以独立编译并运行已支持场景；`solver_api_ready=False`，默认入口未切换，完整替代尚未通过。
本轮不修改生产数学、原始demo、依赖版本、比较阈值或旧固定失败。

## 冻结公共位置上的SO3初始化

目录A：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-frozen-so3-init/`。
维护工具：`g1_frozen_so3_initialization.py`。

固定旧八原版、三源码各60帧，共660份公共particle positions；优先核旧source1 frame30/31，再核其余658份。
映射来自上一阶段真实SO3输入，SHA与closed-packets核准；44个body的176个代理粒子索引无重复且覆盖完整。
两端原实际图六处初始化rank20/2930/5840/8750/11660/14570，geometry1/256、ABI56字节。

SDK实际runtime、原版PTX、源码KernelDriver三端，各用0x7f/0xa5两个输出初值和前后256字节0xd3 guard。
3960次实际GPU调用、7920份完整输出全部逐位同；rotation有限，multiplier为正零。
独立CPU直接重核221760实际ABI字节、15840指针字段、95040标量字节，
19261440非输出/guard字节、31806720完整after字节和3136320完整输出word，全过。

这是冻结公共位置作为共同输入的纯核验证，输出初值受控，不是旧初始化调用的真实before/after。
没有恢复旧内部缓存或原子顺序，不能据此重判旧整段C8，也不能单独解释旧尖峰。
CPU预检session93675、驱动session8072均实际退出0；GPU PID2598059和CPU2598192均由驱动记录退出0。
外部训练PID2594139占用GPU时记录十次真实查询，空闲后才启动；未中断外部任务，其退出码未知。

## 从旧source1 frame30公共状态共同重启一帧

目录B：`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-shared-checkpoint-frame31/`。
维护工具：`g1_checkpoint_restart.py`。八SDK、三源码的11次运行在执行前固定。

两端将body_q/body_qd/particle_q/particle_qd复制到两个state buffer，逐字节核准共同起点。
调用原有reset_joint_drive_state重置native drive initialized，并清零43个Python feedback initialized。
控制/模型输入跨11次逐字节同，七项solver配置同；不改目标、增益、数学或原demo测试。
真实graph仍为17467节点/17466边；一帧六子步，显示时间保持新建示例的0。
源码走正常公共Core，bridge=false且未映射原版SDK代算。

两个buffer同时赋值和flag reset为受控干预；旧inactive buffer、隐含缓存及原子顺序没有恢复。
这是新诊断队列，不是旧运行的精确继续，不扩充或替换旧八原版C8。
旧source1 frame31/body12/component4（flat76）实际值为-22.864168167114258；新SDK八次同分量：

```text
-23.075130462646484, -23.014394760131836, 0.8903260827064514, -23.04071807861328,
-23.1544246673584, -22.974857330322266, 0.8905054330825806, -22.89829444885254
```

源码三次为-23.01171875、-23.039108276367188、0.892413854598999。
相近的大响应也出现在SDK，同一公共起点下不是源码独有；尚未证明与旧尖峰具有同一个内部原因。
与首SDK逐位比较，其余七SDK及三源码的四个完整状态都不同，严格失败保留。
新固定八SDK数值范围下三源码均通过四字段比较，独立CPU重算同；只属于本次受控单帧诊断。
body_qd原版spread20.500147385256632，三源码误差5.964595220983028/5.991984747350216/17.93953738361597。
旧C8 SHA32b6e2a7…、旧23.851294673979282误差和失败结论全部不变。
驱动session95836实际退出0，11个公共Core worker均实际退出0，独立CPU审计退出0。

## 原G1速度测试的源码截断已实测确认

原demo速度lambda跨两行，Python原表达式为`max(abs(qd)) < 0.015`。
CPython inspect只提取第一行，Warp create_warp_function得到的函数只返回`max(abs(qd))`。
Newton helper再转bool，非零速度被视作通过，零速度反而失败。
`end-test-translation-audit.py`实际调用未修改的Newton helper，在CPU/CUDA各测零、0.01、单分量23、全分量23。
两端结果均为零失败、其余通过；原Python意图是零和0.01通过、23失败。
11条受控轨迹的独立数值速度检查都不满足原意图中的阈值；原始退出0记录保留，不能称速度检查正确。
先前demo退出0同样不能单独证明速度正确；独立逐位/固定C状态比较保持原结果。

原demo、Newton/Warp helper、inspect的SHA及CPU/CUDA生成缓存均随证据保存。
该GPU审计输出完整且进程已结束，但末次工具返回在上下文截断时未取得终端退出码；记录unknown，不臆造0。
随后独立CPU重核原完整表达式、八项负控制和11份状态，其退出码单独记录。
原demo和依赖文件保持原字节，数值对照及旧失败不因测试问题改判。

## 接续方向

1. 以共同公共起点继续追预测、drive angle首次初始化及PCG分支完整输入；先核单算子，再追隐含状态。
2. 区分SDK自身波动、共同输入响应与源码缺陷；必须有SDK/PTX/source证据，不预设原因。
3. 原固定G1长程C、复杂布料、粒子seed2及未捕获host组合仍需解决；74项71严格不是总体完成率。
4. 所需场景验收后才切换默认入口；Windows目前使用WSL2固定Linux SDK，原生Windows尚未完成。

```bash
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-38b70dcd-g1-shared-checkpoint-frame31
.venv/bin/python "$phase/end-test-independent-cpu-audit.py" --output build/NEW-g1-test-contract-audit.json
.venv/bin/python scripts/verify_reconstruction_snapshot.py
```

已关闭GPU计划拒绝覆盖旧输出；新增实验先固定计划，使用新目录，保留实际退出码及原始失败。
