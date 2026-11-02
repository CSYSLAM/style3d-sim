# 缆绳 host 恢复合入及当前版本验证

本批将已验证的缆绳缓存与plain约束组合恢复到主源码。完整solver替代仍未完成，默认后端和readyFalse保持。
本批按完整验证阶段集中提交；所有GPU worker串行、允许外部应用、每次启动核free>=4096MiB。

## 当前实现与固定版本

- 原版唯一对照仍为项目内SDK64a，360份pyc保持；没有改原版so或使用源码运行时的SDK代算。
- 新生产host完整SHA：`d09d4be940335764a1e1e7d2f4978366c47e96caf20a3b556d3ac6cfe79e5c68`。
  编译结果与已实测的d09隔离候选逐字节同，176 kernel specs及CUDA digest与旧0dab完全同。
- 匹配的公开Core位于`build/reconstruction-csrc/source-core/9cb2fcaa1082d1df/`，完整SHA为
  `55d626f06c10c7f6cbc48663bf7fde25be1cfcd8edfb4ce8cf57f30fd300dab5`。
  正常Dzhanibekov60、plastic_bag3、G1 graph60入口实际退出0、未映射SDK；不代替G1长程一致性或物理验收。
- 旧0dab的2130个源码/构建文件、3344份结果SHA保存在`before-production-0dabbaa7/`。
  `checkpoint.json`兼容`reconstruction.csrc.source_checkpoint.load`；旧0dab/Core715及其失败不改判。

主线C++为最终隔离候选的原字节，恢复六块提前typed-zero缓存、准入已捕获plain cable范围，以及weight上传顺序。
没有改CUDA数学、浮点门槛、迭代预算、launch大小或默认后端。

## 补查与实际发现

| 检查 | 已实际完成 |
| --- | --- |
| spring＋distance、point-line＋distance，world attachment | 16双端三步组合严格、7416 owned调用核准、60步64比较严格 |
| 两刚体均运动、非负body-body端点 | 同样16组合与7416调用严格，实际128条body轨迹确实运动，60步64比较严格 |
| 原有完整penalty矩阵并双bodyblock | 48组合／96 worker实际0，30步状态及840份penalty数组严格 |
| d09修正后的动态构造 | 两类的12 GPU＋2 CPU进程实际0，既有五项全同 |
| d09动态重验 | 16组合严格、7416调用核准、64项60步比较严格 |
| 新生产d09 | 104个源码worker全0，全部状态严格，840份penalty及25512 owned调用核准 |

五项构造核对为分配/释放身份字节位置、上传字节和顺序、typed初始化字段/顺序、flat owned指针身份/偏移、
owned＋library内核次序；没有把它扩大为所有CUDA API或所有外部分配/pointee已证明。

实际发现point-line＋distance＋cable的上传身份仍不一致，尽管状态和长程都相同：
SDK的distance为owned48/49、line为50/51/52，b82反过来分配。全部32个上传仅24..28需排列
`[27,28,24,25,26]`；精确五身份映射后全部flat目标也相同。原失败保留在`constructors-dynamic/`。

查源码发现原`plain_distance_before_line`谓词仍排除cable；只去掉这个排除项后形成d09候选。
新候选构造五项全部核准，再合入主线；没有交换物理累计顺序或改模型数据。
实际SDK输入/调用和独立CPU证明见`weight-order-independent-cpu.json`，两个候选及真实so均保存。

第一次合入预检还拒绝了CPU摘要遗留literal96的问题：实际已逐字节核64对，JSON摘要错误。
旧脚本/报告保留，改为`len(pairs)`后只重做CPU审计，GPU样本/门槛未改变。
生成审计的嵌套hash循环缩进问题也在执行前修正并保留旧版本，没有把错误版本算作通过。

## 当前版本的整体复验

`validation-d09d4be9-v2/`记录当前image的既有验证流程，包含短程、扩展布局、bonds、实际graph、
匹配Core、三种contract和74回归；必要时沿首次source0建固定C10并独立CPU复核。
真实根工具71438/651672退出0，全部27个阶段都有实际终态；regression74严格检查退出1，完整失败保留。
独立CPU总核对见`current-image-independent-cpu.json`，没有继承0dab的69/74：

- 四短程及六bonds严格，六扩展布局状态/ABI/覆盖同；原先非严格的中间buffer仍按实际报告保存。
- bonds的24项60步比较严格，granular103、fluid57、self246 contract检查零差异。
- 当前74为71项严格，失败仅particles seed1/2/3；每例采用首次source0及固定10次SDK，三例均within。
  C10独立CPU复核相同，没有替换source0、增加原版样本或把严格失败写成逐位一致。
- 匹配Core的三个正常入口加用户五例各60帧，共八次实际退出0、原版未映射。
  五例为cloth particles、ball cloth、cable bend、bundle、ANYmal，使用原例子的正常graph路径。
  本批正常入口没有逐帧图状态对照，不能称Graph数值等价；旧G1/ANYmal速度测试问题及全部长程失败保持。

`production-cables-d09d4be9/`的104个新源码测试固定采用原来首次SDK捕获：24单family、16world mixed、
16moving mixed、48penalty。不重采/扩大原版参考；所有源码worker在结束前检查原版未映射。

## Windows／新机器命令

Windows继续用WSL2、Linux Python3.12。先按根交接恢复工具链，再核快照；本机没有实际执行Windows/WSL验证。
当前生产profile使用严格SHA和读取时路径重定位，可在新仓库位置运行：

```bash
export PYTHONDONTWRITEBYTECODE=1
python3 -B scripts/verify_reconstruction_snapshot.py
source scripts/reconstruction_env.sh
phase=build/reconstruction-csrc/affine-particle-material-host/continuation-20261102-b82ecd80-cable-closure
for backend in original source
do
  .venv/bin/python -B -m reconstruction.csrc.candidate_demo_worker \
    --backend "$backend" --candidate-build "$phase/production-build/candidate-profile.json" \
    --example reconstruction/csrc/cable_body_mixed_dynamic_scene.py --frames 60 \
    --output "build/windows-check/cable-mixed-d09/$backend" \
    -- --constraint point-line-distance --worlds 3 --mode pd --body-block
done
```

输出目录必须尚不存在；显存够用即可，自己的worker串行。源码不登录、没有SDK映射。
正常公开Core示例应使用新`9cb2fcaa1082d1df/build.json`，旧715不能作为当前host的匹配Core。

旧b82候选metadata固定了0dab源码字节；主线更新后其旧原机命令会正确拒绝SHA不符。
不要绕过断言或改旧manifest。需要复现旧b82时可checkout`bf35c4be9`，旧0dab则可用本批checkpoint加载。
旧一次性run脚本与原路径记录都保持as-run；新运行必须新建输出并记录自己的环境。

接续目标仍包括G1/复杂布料长程、4f/7ca固定失败、其余未捕获host组合及最终默认切换；
本批缆绳恢复和正常CLI成功不能作为全solver已经完全替代的证明。
