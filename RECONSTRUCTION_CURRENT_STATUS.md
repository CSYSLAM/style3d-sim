# 源码替换 SDK：当前状态（2026-11-03）

详细说明见 `reconstruction/README.md`，逐 demo 结果见 `reconstruction/csrc/DEMO_CLOSURE_TABLE.md`，
过程记录见 `reconstruction/WORK_LOG.md`。

## 结论

- `examples/` 共 35 个 demo：32 个闭环，3 个不适用。
  - 闭环：用源码编译的 `_source_solver` 替换原版 `_core`（项目内免登录版，SHA256 `64a0be7f…`），按每个 demo 默认帧数跑完全程，
    结果与原版一致——原版自身可复现的逐位一致，原版自身不可复现的按 A–E 规则与原版的运行间波动比对通过。
  - 不适用：`cloth_h1`（原版即在 `src/style3d_sim/newton_solver.py:1718` 报 ValueError，未进入 so）、
    `robot_cloth_trampoline`（缺资产 `assets/trampoline_v1051.obj`）、`rigidbody_integrators`（不调用 Solver）。
- 比对时关闭了 CUDA graph（逐子步记录）；默认 CUDA graph 模式下抽查 `dzhanibekov`、`body_spring` 最终状态逐位一致，
  `basic_shapes`、`cloth_hanging`、`fluid` 两版均正常运行。

## 现状与限制

- 源码 so 名为 `_source_solver`，通过 `reconstruction/csrc/host_bodies_ab.bridge()` 注册为 `style3d_sim._core` 使用，
  尚不是可直接替换的同名 `_core.so`（docstring 缺失，`Solver.initialize` 参数名、`Span` 构造、`set_log_callback` 签名不同）。
  `login`/`is_logged_in` 不实现。
- `reconstruction/csrc/build_standalone.py` 与 CMake 选项 `SYNREAL_SOLVER_USE_RECONSTRUCTED_SOURCE` 是上一位 agent 写的
  同名 `_core` 构建路径，尚未验证。

## 运行

```bash
# 原版 so / 源码 so 运行同一个 demo（参数原样传给 demo）
.venv/bin/python -m reconstruction.run_demo --backend original examples/example_fluid.py
.venv/bin/python -m reconstruction.run_demo --backend source   examples/example_fluid.py

# 无界面跑完并比较最终状态
.venv/bin/python -m reconstruction.run_demo --backend original examples/example_body_spring.py --viewer null --save-final /tmp/o.npz
.venv/bin/python -m reconstruction.run_demo --backend source   examples/example_body_spring.py --viewer null --save-final /tmp/s.npz
.venv/bin/python -m reconstruction.compare_final /tmp/o.npz /tmp/s.npz
```

## 构建（Linux）

```bash
.venv/bin/python -m reconstruction.csrc.build_native
.venv/bin/python -m reconstruction.csrc.build_host
bash reconstruction/diagnostics/build_hooks.sh
```
