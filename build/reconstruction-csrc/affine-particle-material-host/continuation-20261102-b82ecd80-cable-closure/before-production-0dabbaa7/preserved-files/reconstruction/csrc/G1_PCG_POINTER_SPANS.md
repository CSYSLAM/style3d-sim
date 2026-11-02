# G1 PCG 实际指针跨度诊断：eb661284

固定SDK64a、host eb661284、CUDA176/f0；本阶段只改诊断工具，没有改生产源或原版库。
完整替代仍未通过，`solver_api_ready=False`。

旧G1首步1000份回放没有证明原指针alias关系，不能把分别分配的buffer当作原布局已验证。
新增`pcg_alias_capture.py`生成独立观察器，只观察两种glm PCG入口，记录全部原始参数、
调用前z/ap及原有输入、完整三维grid/block/shared。未覆盖其它owned调用，观察器会同步执行。

当前新采集两端各500调用；`pcg_alias_replay.py`按实际指针区间合并重叠跨度，
校验重叠字节一致，并保留区间内偏移、参数空值、所有标量字节和指针mod256对齐。
各端复用同一套设备分配，轮换实际SDK runtime、固定SDK提取PTX、源码PTX。
每次完整恢复已捕获区间的调用前内容，同时检查输出之外的已捕获字节没有改变。

结果：1000份packet、3000项逐粒子输出全部逐字节复现各自实际捕获；3000项非输出字节检查全过。
实际这1000份的非空参数跨度全部不重叠；两端500对调用的标量字节、完整geometry及全部指针相对偏移相同。
500份precondition均precomputed=false，1000份world指针均null。
独立CPU审计重算区间交集、逐项核对输入SHA、输出SHA及全部报告，结果相同。

归约标量逐位复现captured的比例仍只有runtime520/1000、原PTX509/1000、源码PTX509/1000。
不把逐粒子通过改写成归约或整段通过。两端这次三帧状态仍不同，且没有与历史冻结G1失败轨迹关联；
新证据不能追认旧1000份实际alias，也不能证明完整设备分配归属、跨不相交区间间距或原实际原子执行顺序。

证据根目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-eb661284-g1-pcg-alias/`。

- `first-step/`：固定SDK/源码实际采集、独立观察器源码/so/编译命令、当前build及203资产SHA核验。
- `replay/`：逐packet三端原始报告及输入SHA。
- `independent-audit.json`与`audit-capture-and-replay.py`：独立CPU核验及明确限制。
- 每端10500份原始文件lossless归档为`actual-content.tar.gz`，raw原件本机仍保留；归档roundtrip已验证。

在仓库根目录，使用新目录，GPU任务串行：

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.pcg_alias_capture --output build/NEW-g1-pcg-spans
.venv/bin/python -m reconstruction.csrc.pcg_alias_replay \
  --capture build/NEW-g1-pcg-spans --output build/NEW-g1-pcg-span-replay
```

WSL恢复原始文件：对各端`actual-archive.json`运行`scripts/unpack_reconstruction_trace.py`。
完整G1仍按[正式G1验收](OFFICIAL_G1_RECOVERY.md)及[copy恢复](G1_COPY_ORDER_RECOVERY.md)保留失败并继续定位。
