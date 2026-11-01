# SO3 body与tetrahedra组合恢复

当前host image：`b94560319d3a1c8aa7c898ce49b37748ae254ec30de28533deae292b4970a278`。
参考仍为项目内处理版64a0be7f，CUDA仍为176入口、f0e0137a digest。求解器自身不登录、不调用原版代算。
完整替代仍未完成，`solver_api_ready=False`。此前ff34的失败与实验见
[SURFACE_STAGE_ISOLATION.md](SURFACE_STAGE_ISOLATION.md)。

## 按实测恢复的实现

此前body初始化绕过`precompute_particle_matrices`，因此没有调用`precompute_tetrahedra`。
新body/tet原版W3构造抓取确认：scalar ELL typed cache之后分配/上传4B体积，紧接着分配/上传32B body kind。
源码现在在相同位置上传tet体积、加载对应三个已有内核。

实际step顺序为SO3 force→stretch→tet force→bending；每轮CG为SO3 tangent→tet tangent。
此前tet tangent在SO3前方，只在未支持的组合中才会暴露；现按原版移至SO3之后。
粒子-only tetrahedra的相对顺序不变。

只开放已捕获的SO3、无body constraints、无contact/self/fluid/drag组合，支持Newton/PD与body block。
其他混合组合保持guard。没有修改CUDA计算、归约或阈值。

修改前ff34完整27个源码/构建文件在`build/reconstruction-checkpoints/body-tetrahedra-before-ff34e6a1/`，
按`checkpoint.json`逐SHA核对；此前各image检查点不改。

## 场景与验证

fixture是一个有初始形变和非零速度/阻尼的实际tetrahedron，加一个带旋转/角速度的SO3 box。
二者共享PCG world；tet force实际改变RHS。使用官方add_soft_mesh默认surface edges，保留其零刚度表面项。
最初禁用edges的fixture仅W1成功，W3在Python适配器读取缺失edge_rest_area时失败，尚未进入原生库；
旧fixture和输出单独保存，改默认edges后重新捕获全部八组原版，未混用。

| 检查 | 当前结果 |
| --- | --- |
| W1/W3×Newton/PD×body block八组，每组3步 | 状态、所抓buffer、完整owned ABI/geometry和源码launch覆盖全部严格相同 |
| 八场景eager/真实graph，各60步，共32项比较 | 全部逐位一致 |
| original/source各16条轨迹×3步initcheck | 两者均0错误 |
| W3完整constructor | 五项全同：96分配/释放事件、29上传、57 typed初始化、508 owned指针、573核名称时序 |
| 完整74项回归 | 70项逐位同；4份固定首次差异各对10原版逐数组/步C10通过，CPU复核同 |
| 原有surface source8 / graph60 / legacy cloth graph60 | 5/8、21/32、28/32严格；失败保留 |
| 原有surface initcheck / config contract | 0错误 / 246项同 |
| 四个surface算子等输入回放 | 局部结果、真实atomic操作数相同；全部scalar次序证书完备 |

74项严格差异是particles seed1/2/3与pd_mixed_cloth seed3。保存的是各自本次首次source输出，
未替换source0、未将C10增加到10以上。四个C10通过也不能解释或销账旧25 seed2/旧8f固定失败。
小force初次随机见证漏1个source-probe scalar，CPU精确补齐为6类输出各108/108，没有重采GPU。

当前image没有另采surface/cloth固定C8或重跑正式cloth_balls的3/8 cohort，不能继承ff34的C结果。
旧失败与原始NPZ仍保存，旧源码布局实验未采纳，完整solver仍未接受。

原版八组及source-first8在`continuation-20261031-ff34e6a1/body-tetrahedron-*`。
该父目录代表本轮开始时的基线，不代表其中所有输出都运行ff34；每份report/build.json均记录真实image。
新image独立验证目录：`build/reconstruction-csrc/affine-particle-material-host/validation-b9456031/`。
`checkpoint-summary.json`汇总这一image真实结果；`status.json`和`followup-status.json`均已complete。
构造审计不声称所有CUDA API名称、opaque view全部字段、所有device copy/clear语义或library几何都相同。

```bash
source scripts/reconstruction_env.sh
recon_root=build/reconstruction-csrc/affine-particle-material-host

.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_ab --backend original \
  --output "$recon_root/NEW-tet-original8"
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_ab --backend source \
  --references "$recon_root/NEW-tet-original8" --output "$recon_root/NEW-tet-source8"
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_graph_ab \
  --output "$recon_root/NEW-tet-graph60"

# 完整构造审计：allocation/release、payload、typed initializer和owned指针用途。
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_constructor_ab \
  --output "$recon_root/NEW-tet-constructor"

# CPU-only：核对本次固定C10，必须与保存统计逐字段一致。
.venv/bin/python -m reconstruction.csrc.audit_regression_fixed_spread \
  --cohort "$recon_root/validation-b9456031/regression-fixed-C10" --report report.json \
  --output "$recon_root/NEW-b945-C10-audit.json"
```

所有GPU任务串行。不要复用已有结果目录，不用trace替换固定失败source0，不因原版holdout也超C就删失败。
换GPU先按根交接在WSL重建环境与校验快照，再在新机器重新跑原版/源码。

下一步可先捕获真正有交互的body/tet+self或body/tet+contact组合，再检查初始化、完整ABI和中间结果，
按实际原版开放相应guard。不要用空contact路径声称该组合支持，也不要只依据旧C8数字修改计算。
