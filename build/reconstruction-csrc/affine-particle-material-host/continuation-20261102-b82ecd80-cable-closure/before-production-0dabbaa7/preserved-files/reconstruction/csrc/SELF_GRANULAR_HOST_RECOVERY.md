# Self/granular host recovery

当前image：`d3cb2b9650f48a8071e4d17db7f900ce7af2f10ef977738a70ffc03c7f294074`。
原版仍`64a0be7f…`，CUDA176/f0未改。只移除granular+self step guard；本image队列已结束，完整solver仍未通过。
body/full-surface与self组合以及granular与body/fluid/材料的其它混合仍有保护；solver_api_ready=False。

## 当前实际参考与测试

原版8组：`build/reconstruction-csrc/self-fluid-host/validation-929adeb0/self-granular-reference8/`。
覆盖cached/fallback、selected subset、authored/dynamic/mixed bonds、soft ground、W1/W3、NN/PD、full/diagonal。
原版全部finite/group正确，纯grain PP0，W1 subset authored PP8，W3 subset none/dynamic PP24。
分组本地默认0、选中grain2；与fluid1的排斥及下标校验已在929按原版恢复，见SELF_FLUID_HOST_RECOVERY。

当前输出：`build/reconstruction-csrc/self-granular-host/validation-d3cb2b96/`。
run.py已完成实际8组和103 granular/57 fluid行为；行为全部相同。八组全部finite、group正确，
全部已定义buffer、完整owned launch metadata及计数覆盖相同。七组状态严格，唯一严格差异为fallback W1 Newton。
首候选必须保留；所有ND解释/后续cohort另建目录，不改strict报告。

## 当前实际结果

- `dense-trace/`用原版实际调用模板抓取fallback；`dense-replay/`的6次颗粒evaluate_rows和30次颗粒CG接触乘积，
  在各自实际输入上逐元素及有效cache全部相同。局部回放不替代完整轨迹验收。
- `dense-cohort8/`保留八组中的原始source0，追加source1/2各一次与同协议8原版；
  三条source全部3步q/qd均在primary-C原版LOO波动范围内。
  `dense-primary-c-and-owned-audit.json`独立核对上述逐步条件，以及新增9个worker的完整metadata/计数覆盖。
- `self-granular-graph60/`三variant（pure cached、subset authored+ground、W3 subset mixed+ground diagonal），
  NN/PD各自eager/真实CUDA graph：原版/源码及各自eager/graph共24项比较全部60步逐位相同。
- 同image `self-fluid8/`六条状态严格，两个fallback仍严格不同；全部finite与完整metadata同。
  两个fallback的source0全部三步q/qd C内，source2也全过；新增source1却有Newton q/qd各2步、PD qd1步未过。
  `fluid-primary-c-and-owned-audit.json`另证新增18个worker完整metadata/coverage全同；两cohort整体primary-C失败。
- 完整74为69严格。粒子seeds1/2/3分别28/14/21数组严格不同；mixed_cloth seed3有11数组、PD有7数组不同。
  固定候选C10只有particle seed3与PD mixed通过；particle seed1/2及NN mixed未通过，报告原样保留。
  同image cloth16/mesh16/PP8及246项self配置全部通过。
- 两个未过particle case的完整三步15个记录数组，在63份兼容实际原版worker中分别找到4/6份完整case逐位匹配。
  NN mixed在18份中无完整case匹配；这是存在性证据，不是整NPZ匹配，也不改变C10结论。
- 当前NN mixed真实402次同步trace首差在launch2 spring force的after.rhs，两float词不同；此前输入相同。
  每根spring拆成独立顶点，双端正/负零各2322标量相同，捕获rhs双端各1161标量均有精确float32求和排列。
  双端实际输入的独立PCG回放共648调用、810个pointwise和324个aggregate全部严格同。
  此诊断不能替换固定C10首候选或据此验收整个失败轨迹。

## 下一组合的参考

`self-affine-reference8/`已实际捕获SO3 body+自由粒子self，W1/W3、NN/PD、body block、full/diagonal、地面接触。
全部finite/group0正确，full PP W1为2、W3为6；此处只完成原版参考，d3cb生产guard仍拒绝该组合。
新增fixture/runner为`self_affine_scene.py`/`self_affine_ab.py`。接入前必须保存当前完整检查点。

命令及每一步退出码分别记录在当前输出目录的`*.command.json`、`continuation-status.json`。
`driver-complete.json`仅表示八组初始driver完成，不表示完整solver完成。

```bash
.venv/bin/python -m reconstruction.csrc.self_fluid_ab --family granular --backend source \
  --references build/reconstruction-csrc/self-fluid-host/validation-929adeb0/self-granular-reference8 \
  --output build/reconstruction-csrc/NEW-self-granular-source
```

## 修改前检查点与未完成

`self-929adeb0-before-granular-self-host/`保存完整929源/构建/结果，独立复核443源/构建与170979结果SHA，0差异。
复核记录`previous-checkpoint-verification.json`位于当前d3cb结果目录。
929的self/fluid三步8组已完成，长程graph primary-C/实际整轨迹通过；eager source0仍失败。
929完整74为71严格，seed1粒子C10过、seed2/3未过，旧失败不能抹掉或套到当前image。
完整交接与原版/源码重放证据见SELF_FLUID_HOST_RECOVERY.md及WORK_LOG末尾。
