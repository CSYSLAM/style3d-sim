源码 solver 逐步还原

范围：原 _re_analysis/ALGORITHM_ANALYSIS_ZH.md 与六个 CUDA 模块。
唯一参考：旧版 so，SHA256 4c223854a5a554140ed6cf0e99d5687aa5846bbe49465a85a5819079f3db34e6。

solver.py / numerics.py：独立 Python/NumPy/SciPy 求解实现，不导入官方 so。
当前用 CPU 稀疏装配和 PCG，Newton/Warp 负责场景与状态数组；不是完整 GPU solver。
recovered/：已有数值验证记录的 46 份机械 CUDA、34 份可读 CUDA，及来源记录。
这些归档代码已在当前仓库编译通过，尚未全部接入主机调度。

已测：悬挂布料 4x4，120 帧、240 子步，位置和速度在固定容差内一致。
本次增加：四面体弹性、体积激活、应变阻尼与 GN 切线；预拉伸软体球 20 帧、160 子步的位置/速度对照已通过（尚未触地）。
未完成：接触/摩擦、自碰撞、刚体/关节、流体、颗粒、线缆与完整多世界调度。
未实现功能报错，不回退调用原版，也不把单内核通过当作完整模块通过。

运行源码版（无需登录官方账号）：
  .venv/bin/python examples/example_cloth_hanging.py --solver reconstructed --width 4 --height 4 --viewer null --num-frames 120 --test
  .venv/bin/python examples/example_ball.py --solver reconstructed --initial-stretch 1.1 --viewer null --num-frames 20 --test

原版/源码对照（原版使用已保存账号正常登录）：
  .venv/bin/python -m reconstruction.validate --frames 120 --width 4 --height 4
  .venv/bin/python -m reconstruction.validate --demo ball --initial-stretch 1.1 --frames 20
结果保存在 build/reconstruction-validation/，numerical_pass 才表示数值通过。
原版退出崩溃与数值结果分开记录；退出异常不会伪装成干净成功。

本地测试：.venv/bin/python -m pytest reconstruction/tests -q
归档源码编译：.venv/bin/python -m reconstruction.verify_recovered --compile
