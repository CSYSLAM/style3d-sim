# Affine body and free-particle self-contact recovery

当前image：`00f45665e60c51be7b216ca93355137ce67b6eb4416bb9df34b93e6f375f63d9`。
原版仍为项目内`64a0be7f…`；双方不登录。CUDA176/f0未改，完整solver未完成，solver_api_ready=False。

## 改动与边界

只放开SO3 affine body与自由粒子self的step分支，继续沿用实际恢复的body/self force、preconditioner与tangent调度。
保留self+full-surface、其它刚度模型、body constraints/joints/drive/cable/fluid，以及hard-contact+self保护。
其它Model组合保护也保持。这里的body与self particles在几何上分离，共享PCG；不等于已经验证布料贴附刚体。
1d55首轮实际八组已经结束：七组末状态严格，但所有组完整调用顺序和首个self tangent buffer错误，尚未验收。
原版SO3 tangent在self之前，source相反；每case45对相邻调用、90处不匹配。
W3 ground diagonal还有54次原版没有的rigid tangent（9个preconditioner+45个CG），状态也不同。
按这两个差异解释后八组整个规范化完整参数序列全部匹配；raw strict报告保持不变。
00f已按实际调度修复后重新编译：SO3 tangent先于self，rigid preconditioner/CG tangent均服从Hessian开关。
1d55完整失败检查点独立复核448源/构建、225结果SHA，0差异；不能因七组状态同而接受。
初始groups只观察8项：无ground模板的本地数组本来就是8项；只有W3 ground展开布局是24项，旧观察为prefix。

## 原版参考与验证方法

原版八组：`build/reconstruction-csrc/self-granular-host/validation-d3cb2b96/self-affine-reference8/`。
全部finite/group0正确，full PP W1=2/W3=6；W1/W3、NN/PD、body block、full/diagonal、地面接触。
输入是`self_affine_scene.py`，使用未改的Newton适配器；`self_affine_ab.py`捕获完整owned launch ABI和defined buffer。
所有捕获与source worker分别pin真实image、fixture、hook及runner的SHA，不加载原版到source worker。

当前输出：`build/reconstruction-csrc/self-affine-host/validation-00f45665/`。
首个`original-reference8/`把ground展开布局误套到两个W3无ground case，观察器读取过长，使原版query报告invalid argument。
原始错误保留，没有运行该协议的source；已修正为按实际per_world读取，并逐case核对query实参。
重试位于`original-reference8-correct-local/`与`self-affine8-correct-local/`，生产image仍00f。
修正协议后原版八组/source八组全部通过：3943次完整owned调用、77项defined buffer与完整本地groups同，
全部3步particle/body q/qd严格。1d55旧参考/首候选不改。
无self ground diagonal四组也已通过，覆盖W1/W3、NN/PD、block on/off；完整调用、三种buffer、状态同。
self-affine graph60按八组四种比较共32项全部严格，并断言ground实际生成rigid contacts。
同image完整74已结束：70严格；particles seeds1/2/3分别28/14/14数组不同，PD mixed seed3为7数组不同。
246项self配置全部同；四个固定首次source C10全部通过，不继承旧image结果。
当前47辅助入口也完成三seed实际运行，见CURRENT_AUXILIARY47_RECOVERY.md。
完整solver仍未完成；d3cb/929/d1a的旧失败不能改判。
必须先检查完整metadata、计数覆盖、各defined buffer和finite，再看全步状态；不能只看最终帧。
若严格差异，保留first source；另抓实际首差、同输入重放、必要时固定三source/8原版primary-C。
不能改物理公式/原子顺序/阈值来追逐一次采样，不用同步诊断轨迹替换首次候选。

```bash
.venv/bin/python -m reconstruction.csrc.self_affine_ab --backend source \
  --references build/reconstruction-csrc/self-granular-host/validation-d3cb2b96/self-affine-reference8 \
  --output build/reconstruction-csrc/NEW-self-affine-eight
.venv/bin/python -m reconstruction.csrc.self_affine_graph_ab --frames 60 \
  --output build/reconstruction-csrc/NEW-self-affine-graph60
```

`self_affine_graph_ab.py`对同八组分别运行eager与真实CUDA graph，逐步记录q/qd、body q/qd与有效接触count；
ground必须实际生成rigid contacts。每组四项比较：双端eager、双端graph、原版自身eager/graph、source自身eager/graph。
脚本已py_compile/128列检查；本image实际32项比较全部60步逐位同。

## 上一完整检查点与未过项

`self-d3cb2b96-before-affine-self-host/`独立复核446源/构建、13925结果SHA，0差异。
上一image的颗粒+self八组阶段/graph60完成，完整74为69严格；当前image仍需独立回归。
d3cb的particles seed1/2和NN mixed固定C10未过，fluid新增source1也有C失败，均保留。
当前NN mixed的spring first difference已有拆分贡献、精确排列与648次PCG replay证明；不是整轨迹验收。
929 long-fluid eager source0与d1a旧material C8失败也不能因新分支通过而抹掉。
详情见SELF_GRANULAR_HOST_RECOVERY.md、SELF_FLUID_HOST_RECOVERY.md和WORK_LOG末尾。
