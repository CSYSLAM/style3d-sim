# SynReal Go2/G1 训练与部署实现记录

日期：2026-09-01

## 目标与结论

本次实现提供了 Go2 和 G1 29DoF 的 SynReal 平地速度强化学习环境、RSL-RL
训练入口、ONNX/宇树 `deploy.yaml` 导出，以及不启动训练的快速验证。

代码已经通过 ABI、网络形状、历史排列、部署配置和真实 SynReal 短 rollout
验证。Go2/G1 均可使用 RSL-RL 2.3.1 构造 runner，并在当前 `.venv` 中完成
10 个 policy step。当前状态适合开始受控的短训练，但尚不适合跳过
MuJoCo/unitree_mujoco 验证直接上真机。

## 上游基线

实现参考以下固定版本：

- Unitree `unitree_rl_lab`: `4960b84732b0c2ec593dccbfe963fda1bcd7b1e3`
- fan-ziqi `robot_lab`: `500399ed75f510aeaff28705a8ce736c514dbec3`
- fan-ziqi `rl_sar`: `376d42c9b128f963ab08579762d5a216a976ce39`
- `rl_sar_zoo`: `7dd30bdc7806898950b354260655d5a7f0ce844e`

## 代码结构

```text
examples/locomotion/
  configs/go2.yaml       Go2 唯一策略 ABI 和训练参数
  configs/g1.yaml        G1 29DoF 唯一策略 ABI 和训练参数
  policy_spec.py         严格校验、关节映射、ABI 哈希
  observations.py        部署精确观测和 term-major 历史
  math_utils.py          XYZW 四元数变换
  randomization.py       执行器、零偏、延迟和 push
  rewards.py             四足/双足平地奖励与终止
  env.py                 SynReal CUDA VecEnv
  train.py               RSL-RL PPO 入口；默认只校验
  deployment.py          ONNX、deploy.yaml、manifest 导出
  validate.py            CPU ABI 与可选物理 smoke
  deploy/README.md       宇树 C++ FSM 接入说明
tests/test_locomotion_training.py
```

## 冻结的策略合同

| 项目 | Go2 | G1 29DoF |
| --- | ---: | ---: |
| physics dt | 0.005 s | 0.005 s |
| decimation | 4 | 4 |
| policy rate | 50 Hz | 50 Hz |
| 单帧 actor obs | 45 | 96 |
| history | 1 | 5 |
| 最终 actor input | 45 | 480 |
| action | 12 | 29 |

每帧观测顺序为：body angular velocity、projected gravity、velocity command、
relative joint position、joint velocity、last action。Go2 使用 fan-ziqi 真机合同：
角速度 scale `0.25`，hip action scale `0.125`，其余 `0.25`，`kp=20`、
`kd=0.5`。G1 使用宇树 velocity 合同：角速度 scale `0.2`、action scale
`0.25`、5 帧历史和官方 SDK joint map。

G1 历史采用 IsaacLab/宇树默认的 term-major 排列：每个 term 内从最旧到最新，
再连接下一个 term。不是 benchmark 中 RoboMimic 的无历史 96D 合同，也不是
`use_gym_history=true` 的 time-major 排列。

## 环境和训练实现

`SynRealLocomotionEnv` 做了以下事情：

- `ModelBuilder.replicate` 创建批量 world；
- Warp 数组映射为 CUDA Torch tensor；
- 每 20 ms 接收动作并执行四个 5 ms physics step；
- 使用 position PD target；由于当前 adapter 不读取 Newton `joint_effort_limit`，
  每个 physics substep 根据 q/qd 重新计算 PD torque、显式 clamp，再反解等价 target；
  接触奖励对 actor 不可见；
- 批量 reset 后执行 FK 和 `sync_affine_body_state`；
- RSL-RL `VecEnv` 所需的 observation、critic observation、timeout 和 episode 日志；
- actuator gain/motor strength/joint zero offset/action delay/push 随机化；
- actor 只使用真机可获得的 IMU、command、encoder 和 last action。

PPO 使用上游共同配置：24 steps/env，MLP `[512,256,128]`、ELU，5 epochs、
4 minibatches、clip 0.2、gamma 0.99、lambda 0.95、adaptive KL 0.01。

安装训练和部署依赖：

```bash
uv sync --extra locomotion
```

该 extra 固定 `rsl-rl-lib==2.3.1`，沿用仓库的 `torch>=2.7` 兼容范围，并包含
TensorBoard、ONNX、ONNX Script 与 ONNX Runtime。验证记录使用仓库当前 `.venv`，
不要求项目外的启动脚本。

`train.py` 默认不训练：

```bash
uv run --extra locomotion python -m examples.locomotion.train --robot go2
uv run --extra locomotion python -m examples.locomotion.train --robot g1
```

实际训练必须显式执行：

```bash
uv run --extra locomotion python -m examples.locomotion.train \
  --robot go2 --num-envs 2048 --run
uv run --extra locomotion python -m examples.locomotion.train \
  --robot g1 --num-envs 512 --run
```

## 部署流程

配置验证和只导出部署 YAML：

```bash
uv run --extra locomotion python -m examples.locomotion.validate --robot all
uv run --extra locomotion python -m examples.locomotion.deployment \
  --robot go2 --output deploy/go2 --config-only
uv run --extra locomotion python -m examples.locomotion.deployment \
  --robot g1 --output deploy/g1 --config-only
```

训练后导出：

```bash
uv run --extra locomotion python -m examples.locomotion.deployment \
  --robot go2 --checkpoint logs/.../model_1000.pt --output deploy/go2
uv run --extra locomotion python -m examples.locomotion.deployment \
  --robot g1 --checkpoint logs/.../model_1000.pt --output deploy/g1
```

输出兼容宇树 C++ `ManagerBasedRLEnv + OrtRunner`：ONNX input `obs`、output
`actions`，并包含 joint map、PD、default pose、action offset/scale、command
range 和逐 term history。`policy.onnx` 固定为 opset 17 自包含单文件；已有的
external-data ONNX 通过 `--policy-onnx` 输入时也会被重写为单文件。将宇树
`FSM.Velocity.policy_dir` 指向输出目录即可。

生产端仍必须使用 Passive/FixStand/Velocity FSM、state timeout、姿态保护和 G1
`mode_machine=5`。`manifest.json` 另外列出尚需补齐的 command slew、q/dq/tau
硬限制、NaN、推理 deadline、温度/电压和物理急停。

## 本次验证记录

### 通过

命令：

```bash
uv run --extra locomotion pytest -q tests/test_locomotion_training.py
```

结果：`9 passed`。覆盖：

- Go2 45→12、G1 480→29；
- 50 Hz 策略周期；
- Go2 fan-ziqi 关节顺序和逐关节 action scale；
- G1 官方 SDK map；
- G1 term-major 5 帧历史；
- RSL-RL PPO 配置；
- `deploy.yaml` 与训练 observation/action 维数完全一致；
- Go2/G1 foot-slide reward 均严格输出 `[env]`；
- ONNX 导出明确关闭 external data。

当前 `.venv` 中的运行版本为 Torch 2.13.0+cu130、RSL-RL 2.3.1、ONNX 1.22.0、
ONNX Runtime 1.29.0 和 ONNX Script 0.7.1。Go2/G1 单 world 分别完成 10 个
真实 solver policy step，观测和 reward 全部有限。两个 `OnPolicyRunner` 使用
`iterations=0` 完成构造：Go2 `45 -> 12`，G1 `480 -> 29`；G1 本次正常退出，
Go2 首次退出触发状态码 134、重跑正常，属于下述偶发 teardown 问题。

物理验证命令：

```bash
uv run --extra locomotion python -m examples.locomotion.validate \
  --robot go2 --physics --steps 10
uv run --extra locomotion python -m examples.locomotion.validate \
  --robot g1 --physics --steps 10
```

命令：

```bash
uv run --extra locomotion python -m examples.locomotion.validate --robot all
```

两个合同均通过，ABI 哈希为：

- Go2: `a4ca52f48304595b93ea6bd11f5d415e6d2a3f29c7f7a163fbae791dd9c92177`
- G1: `c58ad0463b37e62a9d848a29d51777d50d4de1ab83cc8969348f048cac9936cc`

部署验证使用 Go2 临时 actor checkpoint 和本地宇树 G1 `model_6999.pt`。两者均
生成唯一的 `exported/policy.onnx`，opset 17，且没有 `.data` sidecar。ONNX
Runtime 相对 Torch 的最大绝对误差分别为 `7.45e-8` 和 `3.81e-6`，满足
`<1e-5`。另用带 external tensor data 的 Go2 模型验证了 `--policy-onnx` 会正确
内联权重并输出单文件。

### 未通过或未执行

1. Go2 已用 1 和 4 个环境各完成一次真实 PPO rollout、GAE 和 update；4 环境共
   96 timesteps，约 126--138 steps/s，并成功写出 checkpoint、TensorBoard 和配置。
   `runner.learn()` 返回并打印 `training complete` 后，解释器退出阶段仍偶发以
   `std::runtime_error` 和状态码 134 abort。显式释放 runner、solver、Warp/Torch
   view 不能消除问题；同一命令在 GDB 下正常退出，进一步表明这是时序相关竞态。
   因此没有用 `os._exit(0)` 掩盖。该现象只在本机自定义 CUDA/登录启动环境中观察到，
   尚不能判定为通用训练代码问题；本机长训练前仍需定位 Torch、Warp 或 SynReal 的
   全局 teardown。
2. 现有 SynReal/MuJoCo 报告仍显示 articulated inertia、joint coupling、drive、
   penetration/friction 和 exact-action open-loop parity 未达到真机准入门槛。
3. 域随机化中的执行器、零偏、延迟和 push 已用于 VecEnv；质量、COM、形状材质的
   per-world 运行时随机化需要 native/model builder 确认可安全修改后再开启。YAML 中
   保留目标范围，但当前环境没有假装已应用这些字段。
4. 当前脚接触奖励使用 ankle/calf 高度和速度的 GPU 近似，不是精确 contact impulse。
   在训练前应为 SynReal 增加 world-aware foot contact reduction kernel。
5. RL SAR 多模型 pytest 在原生库解释器退出阶段仍偶发 SIGSEGV；Go2/G1 solver
   rollout 正常退出，runner 则有上述偶发 abort。该问题不阻断短 rollout 和 PPO
   update，但在长训前仍需继续定位第三方 CUDA/MuJoCo/SynReal teardown 竞态。

## 下一步准入顺序

1. 修复/验收单关节与两关节 qacc、固定基座 one-step、接触和 open-loop replay。
2. 用 Go2 小批量环境运行短 PPO，检查 reward 分解、reset、吞吐和显存稳定性。
3. Go2 先训练 stand/flat velocity；通过 MuJoCo/unitree_mujoco 后才开始 G1。
4. 真机前完成吊架、低 gain、低速、硬限位、watchdog 和急停评审。
