# G1 设备复制顺序恢复：141c18f6

当前host：`141c18f6269ef4c4044756d681550e18f4e334693bb462ef8dae6a7519d646c3`。
固定SDK64a及CUDA176/f0不变，`solver_api_ready=False`；不能继承23012dc5的回归或demo结论。

从已有G1 full-memory日志新增离线审计，比较D2D复制及D8清零的源/目标、范围、异步属性、stream关系、
相对owned launch的位置。原/源各486次复制、4788次清零；旧源码有36条顺序差异。
每子步SDK先复制43个驱动速度float（172字节），再将176个对角float（704字节）复制到base缓存；
旧源码正好反序，18子步各两项。

已对固定SDK `SolverNewton::step`精确范围反汇编再次验证SHA：
`29e26dc337f28446e40c9c1222b5f6565683f47e676e01d1e543c3f3cc874c49`。
有control velocity时，`fbeb7`分支至`101b40`，从Control的0x30取源、复制到Solver的0x3280字段，
`101b5b`调用cudaMemcpyAsync，`101b6e`回到`fbf36`，随后`fbf6c`复制基础对角缓存。
因此修复来自实际运行顺序和静态控制流，不是为了让轨迹碰巧通过。

仅将 supplied drive-velocity copy 移到base diagonal copy之前；缺少control span时的velocity kernel位置保持。
未修改CUDA数学、迭代参数、tolerance、固定原版或任何既有失败轨迹。
修改前27份源/build/so保存于`build/reconstruction-checkpoints/g1-copy-order-before-23012dc5/`。

新结果目录：
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261101-23012dc5-g1-copy-order/`。

- `official-g1-copy-clear-audit.json`：新源码与原固定捕获的5274项记录序列全部同，0差异。
- `old-copy-order-evidence.json`：旧36条差异恰为18对互换的原始证据。
- `official-g1-constructor3/`：逐字节采用旧SDK捕获，仅运行新源码三观察器。
  分配/上传/typed initializer/owned及library时序四项同；raw pointer一项false，保留继续核对。
- `official-g1-fixed-original8-source3/`：预先固定三次新源码，沿用旧C8的八份原版，不新增原版或更换旧失败。
  三次均结束，独立CPU复算同，整体仍失败：source0四字段过；source1四字段未全过；source2位置过、速度未全过。
  不把改正copy顺序等同数值失败已经闭合。

审计仍有18次外部Control源地址未语义绑定，保持原地址记录；model span由已有Model标签解析，
其它external anchor只证明首次核参数使用关系，未证明pointee内容。
记录序列相同不等于所有CUDA API或完整copy/clear语义已证明；新工具会明确输出这些限制。
这项调度差异是否解释旧G1数值失败尚未证明，旧3帧eager及60帧graph C8失败均保留。

旧源码的真正_core fb2f1e86仍是历史构建；新源码已重新build_core，目录`source-core/2f64faf07f385323/`，
SHA为`749397b566ba224c46b7f409fb9d5e408dd564460f33576b9aab1c1a9e66a4af`，对应host141c18f6。
三个正常_core入口示例graph/test均已结束并通过：Dzhanibekov60帧、plastic bag3帧、G1 60帧，源码进程均不映射原版。
`run-current-validation.py`当前继续完整74回归；未结束项目不能提前计通过，也不能拿自检代替数值一致性。
完整替代还需当前image自己的完整回归、正常graph固定A/B/C及未实现组合，不能只通过重命名或切换加载路径完成。

```bash
source scripts/reconstruction_env.sh
.venv/bin/python -m reconstruction.csrc.device_memory_sequence_audit \
  --capture build/NEW-constructor/full-memory --output build/NEW-copy-clear-audit.json
```

GPU验证严格串行，输出目录必须全新；先看现有进程和完成状态，不能重复采样覆盖首候选。
