# SO3 body + tetrahedra实际full-surface接触

当前host image：`8f4127f0f2f3b90fed919ca87f94ff3e5e38fa251b4e24992e065b2f62ac02d2`。
唯一参考仍为项目内处理版64a0be7f；源码不登录，不映射原版so代算。
CUDA数学未改：176唯一入口，digest `f0e0137a1eef9e603495dd9fe04f89f285d0723380099d7ce16951c8a267c79a`。
完整solver仍未验收，`solver_api_ready=False`。此前b945阶段见
[BODY_TETRAHEDRA_HOST_RECOVERY.md](BODY_TETRAHEDRA_HOST_RECOVERY.md)。

## 本轮实现与原版证据

此前body+tet虽有实际体积和正确tangent顺序，但两个step guard仍拒绝任何contact。
新fixture用一个deformed/damped tetrahedron与一个有线速度、角速度的SO3 box接触；
官方CollisionPipeline启用full-surface，保留官方soft mesh默认surface edges。
初始真实接触为W1的10条、W3的30条，surface同时改变tet和body两侧RHS，tet弹性力也实际改变RHS。

预先固定W1/W3×Newton/PD×body block开关×diagonal-only开关，共16组，每组三步。
实际原版force为surface→SO3→stretch→tet→bending；preconditioner为tet→surface，CG为SO3→tet→surface。
这些顺序已经存在于b945源码。生产修改只解除已捕获SO3+tet+full-surface软接触组合的guard，
新增对应supported scope标记；不改算术、归约、阈值或kernel组织。
self、legacy-only contact、hard contact、drag/fluid及body constraints等未捕获混合组合仍受保护。

修改前的27个源码/构建文件在`build/reconstruction-checkpoints/tetrahedron-contact-before-b9456031/`，
`checkpoint.json`同时锁定451个原版capture文件的SHA。原版和源码均保留首次结果，不用新候选替换失败。

## 本轮结果

| 检查 | 结果 |
| --- | --- |
| 16组三步状态、所抓定义post buffer | 全部逐位同，共160份buffer |
| 完整owned参数、geometry与source launch覆盖 | 全同，共8824次调用 |
| 16场景×eager/graph×60步 | 64/64比较逐位同，含32个原版/源码比较及各自eager/graph比较 |
| original/source各32条轨迹×3步initcheck | 两者均0错误 |
| W3完整constructor五项 | 全同：96分配/释放、29上传、57 typed初始化、634 owned指针用途、699核名称时序 |
| 本image无contact tet graph60 / 配置检查 | 32/32逐位同 / 246项同 |
| 完整74回归 | 71严格；particles seed1/2/3严格差异，固定C10为seed2/3通过、seed1失败，CPU复核同 |
| 补充surface view语义绑定 | 63次调用全同；每次26个pointer字段和11个scalar word，外部指针全部识别到实际native Span |

constructor只覆盖捕获的分配身份、长度与时序、HtoD字节、typed字段和用途、flat owned指针offset、
owned/library核名称时序。未宣称所有CUDA API名称、opaque view字段、library geometry或全部copy/clear语义相同。
补充view检查是独立诊断：126个owned allocation用途、945个Model字段、504个实际native State/Contact Span、
63个null全部同；只忽略inv_dt之后4B padding。该view的目标身份已核对，但没有比较全部pointee内容或其它view类型。
本轮contact局部严格同，不能用于解释或销账旧surface/cloth/正式cloth_balls的固定失败。
没有改固定C8门槛，也没有采用旧struct/PTX oracle实验。

证据：

- `build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-b9456031-contact/`：
  原版16组、预检失败与旧harness、checkpoint前原版范围核对、构建日志、精确串行runner。
- `build/reconstruction-csrc/affine-particle-material-host/validation-8f4127f0-tet-contact/`：
  source-first16、graph60、constructor、两组initcheck与后续回归；两个status均complete。
  主队列全退出0，followup保留regression74及C10的非零退出，不能把complete当作全部通过。

初版ABI预检把surface arg0也要求为直接pointer，在任何GPU worker启动前失败。
实际SurfaceContactView的首word是device count pointer，hook按该word解引用；
修正为仅显式允许这个4B count字段，其余仍要求direct pointer。失败输出和旧harness均保留，没有原版轨迹被丢弃。

## particles seed1固定失败的实际定位

固定source0及10原版完全保留。只有n257_w1_it1_f0的step1/2共7个数组/步超C，最高ratio约1.20536。
与冻结original0相比，7个数组各有6个scalar不同，位置最大2.384185791015625e-7，速度最大1.430511474609375e-5。

particle_full_worker_trace保留完整fixture/adapter顺序，只在目标初始化之后开启已有同步observer。
新original/source目标case各15/15数组分别与冻结original0/source0逐字节同，确实复现了这次失败，
不是用另一条诊断轨迹代替旧失败。102个captured entry的名称与geometry相同；这不是完整ABI比较。

首个post差异在第二步第一次precondition_and_reduce（000038）：inverse、r、z和初始numerator相同，
只有numerator差2 ULP。随后000040的p、Ap及初始denominator同，denominator差1 ULP。
两个entry的规范化PTX指令完全同；相同缓冲区、相同stream上轮换actual SDK runtime/原版PTX/源码PTX各16次，
逐粒子结果全部同，actual SDK runtime自身能产生上述原版和源码两个累计值。
同一份257个真实F32 dot贡献也分别找到两端累计值的精确加法次序见证，无未解释目标。

因此本次首个分歧已定位为原子归约次序，不据此擅改求和或容差。完整固定C10仍是失败，未重判通过。
两次同buffer probe各48次kernel是诊断，不加入10原版cohort。完整10个实际entry中7个规范化文本同，
initialize_step、initialize_rhs和invert_block三者仍有文本差异；不能把首个PCG证明外推为全部文本相同。
完整solver及整段轨迹验收继续为false。

关键数据在`particle-full-worker-trace/stage-audit.json`、`particle-first-divergence-packets/`、
`particle-{numerator,denominator}-witness/`和`particle-{numerator,denominator}-same-buffer16/`。

## 复现命令

每次使用新输出目录。下面均在仓库根目录、同一固定image上串行执行：

```bash
source scripts/reconstruction_env.sh
recon_root=build/reconstruction-csrc/affine-particle-material-host

.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_ab --backend original \
  --output "$recon_root/NEW-tet-contact-original16"
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_ab --backend source \
  --references "$recon_root/NEW-tet-contact-original16" --output "$recon_root/NEW-tet-contact-source16"
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_graph_ab \
  --output "$recon_root/NEW-tet-contact-graph60"
.venv/bin/python -m reconstruction.csrc.affine_tetrahedron_contact_constructor_ab \
  --output "$recon_root/NEW-tet-contact-constructor"

# 额外诊断：实际native Span语义绑定；不改首候选。
.venv/bin/python -m reconstruction.csrc.surface_view_bindings_ab \
  --output "$recon_root/NEW-surface-view-bindings"

mkdir -p "$recon_root/NEW-tet-contact-initcheck-source3"
compute-sanitizer --tool initcheck --error-exitcode 99 .venv/bin/python \
  -m reconstruction.csrc.affine_tetrahedron_contact_graph_ab --worker source --frames 3 \
  --output "$recon_root/NEW-tet-contact-initcheck-source3"
```

换original同样运行initcheck；不能复用旧目录或在GPU验收期间重编译/修改生产源码。
Windows继续按根交接使用WSL2，本轮只证明固定Linux参考；没有证明Windows pyd等价。

复抓固定粒子失败的完整worker（两backend串行），既有trace hook只用于诊断：

```bash
LD_PRELOAD="$PWD/build/reconstruction-csrc/host-particles/host_trace.so" .venv/bin/python \
  -m reconstruction.csrc.particle_full_worker_trace --backend legacy --output "$recon_root/NEW-pcg/legacy"
LD_PRELOAD="$PWD/build/reconstruction-csrc/host-particles/host_trace.so" .venv/bin/python \
  -m reconstruction.csrc.particle_full_worker_trace --backend source --output "$recon_root/NEW-pcg/source"
```

seed1的固定C10仍须保留为失败。继续沿它排查时，先用已复现的102个packet检查后续传播，
对三个文本不同入口补实际同输入回放；不能为贴合某次原子顺序而改数学或扩大cohort。
接着捕获body+tet的legacy particle contact或实际self接触，核对初始化/完整调用/中间输出后再开放guard。
必须有真实接触和实际双方作用，不能用空路径验收；旧surface固定差异仍需独立继续定位。
