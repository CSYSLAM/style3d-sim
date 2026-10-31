已验证 CUDA 源码归档

只收录具有独立公式输出检查、并且当前 SHA-256 与原验证报告一致的源码：
  recover/src/：46 个机械还原 CUDA 文件（含标量内联 PTX，保留算术指令语义）。
  recover/human/ + reconstructed/：34 个可读 CUDA 文件。
  recover/px_common.h、recover/human/vec3.h：编译所需头文件。
  validate/：5 份原始数值验证报告；这是导入的证据，不能冒充本次重新运行结果。
  manifest.json：每个源码的哈希、来源、内核名、对应报告与通过检查数。

这些文件按原目录结构保存、源码逐字节未修改；不包含原版 .so 或编译产物。
对应原版旧库 SHA-256：4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6。
接口仓库对应公开版本 e654fb9；当前 e74e136 对 newton_solver.py 的上游内容没有改动。

注意：机械版与可读版有内核重叠，80 份实现不等于 80 个不同物理功能。
只把实际执行源码的检查纳入清单，排除了 human 模式回退执行原 PTX 的检查。
单内核验证通过不代表完整求解器已恢复；当前主机调度实现在 ../solver.py。
源文件保留原始注释与来源信息；此归档没有添加或声称新的授权条款。

从仓库根目录检查完整性并编译（不需要原版 .so、账号或网络）：
  .venv/bin/python -m reconstruction.verify_recovered
  .venv/bin/python -m reconstruction.verify_recovered --compile

编译日志和 cubin 位于 build/reconstruction-kernels/；它们不作为源码入库。
