# Self contacts with full-surface ground contacts

当前image：`668a6e1d3cf2c5dfc539fc49aaa440a08e0aa1377aeb9107c80022644b23e2ea`。
参考仍项目内64a0be7f；CUDA176/f0未改，双方不登录。完整solver未完成，solver_api_ready=False。

## 按实际原版恢复

八组原版在`build/reconstruction-csrc/self-affine-host/validation-00f45665/self-surface-reference8/`。
它使用官方Style3D cloth与spring/tet/drag、真实Newton full-surface pipeline和ground，W1/W3、NN/PD、full/diagonal。
W1首步24条实际接触，其中10条含多个非零barycentric顶点；W3为72/30，不是只有顶点退化接触。
full PP首计数W1=1/W3=3。

- 原版surface force、legacy soft之后，调用`35add_surface_contact_stiffness_scale`，再所有self accumulate。
  该输出地址与PP stiffness输入相同，与initialize_step diagonal不同。source先复制diagonal，再调用此核更新self scale。
- 原版tangent为bending→self→surface→legacy soft。source将surface移到self之后，SO3仍先于self，保持已核对body组合。
- 只放开无body/fluid/granular的self+surface；body+surface及其它未捕获组合保护保持。

## 当前结果与命令

输出`build/reconstruction-csrc/self-surface-host/validation-668a6e1d/`。
`self-surface8/`八组全部严格：5145次完整owned调用、93项defined buffer比较、source计数覆盖，以及全部3步q/qd相同。
buffer包括scale、self H、RHS、preconditioner与tangent；只读已定义部分，没有拿未初始化contact/cache尾部判定。
新接核的scale输出同时由紧随其后的self stiffness输入捕获核对，不能误用base diagonal。

```bash
.venv/bin/python -m reconstruction.csrc.self_surface_ab --backend source \
  --references build/reconstruction-csrc/self-affine-host/validation-00f45665/self-surface-reference8 \
  --output build/reconstruction-csrc/NEW-self-surface-eight
.venv/bin/python -m reconstruction.csrc.self_surface_graph_ab --frames 60 \
  --output build/reconstruction-csrc/NEW-self-surface-graph60
```

graph60已完成：全部32项比较所有60步严格。它逐步记录状态、soft/rigid count与实际non-vertex count，
每组双端eager/graph和各自eager/graph共32项比较。无body时不记录空body数组。
当前image的body/self八组复测全部严格；完整74为70严格，其余四个固定首次source C10全过，246配置同。
结果均在本image实际重跑，00f结果不冒充当前运行。

## 检查点与剩余

修改前`self-00f45665-before-surface-self-host/`独立复核453源/构建、1966结果SHA，0差异。
00f的body/self八组、无self四控制、graph60全部通过；完整74为70严格，其余四固定source C10全过，246配置同。
00f辅助47的三seed10422项实际检查全部同，见CURRENT_AUXILIARY47_RECOVERY.md；source CUDA digest仍未变。
其它host组合、正式bag60和旧d3cb/929/d1a的失败仍未全部闭合，不能标记完整替代。
生产代码当前不允许body+surface、body+cloth等尚未捕获组合。
