# 账号登录

`NewtonSolver(model)` 在创建时检查原生会话。已登录就直接继续；未登录就读取凭据并调用原生 `login()`。
直接使用原生 `Solver` 时需要自行调用登录 API。

## 方法一：当前终端的环境变量

=== "PowerShell"

    ```powershell
    $env:STYLE3D_SIM_ACCOUNT = "your-account"
    $env:STYLE3D_SIM_PASSWORD = "your-password"
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

=== "Bash / Zsh"

    ```bash
    export STYLE3D_SIM_ACCOUNT="your-account"
    export STYLE3D_SIM_PASSWORD="your-password"
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

=== "Windows CMD"

    ```bat
    set STYLE3D_SIM_ACCOUNT=your-account
    set STYLE3D_SIM_PASSWORD=your-password
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

请先完成 [安装](installation.md) 中的源码路径设置。
使用 `STYLE3D_SIM_ACCOUNT` 和 `STYLE3D_SIM_PASSWORD` 设置凭据。

变量只作用于当前终端及由它启动的进程。关闭终端不会影响已经启动且继承变量的子进程，
但新开的独立终端不会自动拥有这些值。原生会话的登录状态与环境变量不是同一件事。

清理 PowerShell 中的临时凭据：

```powershell
Remove-Item Env:STYLE3D_SIM_ACCOUNT -ErrorAction SilentlyContinue
Remove-Item Env:STYLE3D_SIM_PASSWORD -ErrorAction SilentlyContinue
```

## 方法二：交互输入

不设置环境变量，直接运行使用 `NewtonSolver` 的程序：

```text
Style3D Sim account: your-account
Password:
```

密码由 `getpass.getpass()` 读取，正常终端不会回显。
如果账号或密码任一变量为空或缺失，程序会重新询问两项，不会只补问缺失项。
在 VS Code 的 Terminal 中运行；Debug Console、无 stdin 的任务和普通 CI 不适合交互提示。

## 方法三：在应用中显式登录

```python
import getpass
import style3d_sim as s3d

if not s3d.is_logged_in():
    account = input("Style3D Sim account: ").strip()
    password = getpass.getpass("Password: ")
    if not s3d.login(account, password, False):
        raise RuntimeError("Style3D Sim login failed")
```

签名为 `login(name: str, password: str, force_signin: bool) -> bool`。
上述调用沿用示例的 `force_signin=False`。第三个参数不是“是否隐藏密码”，不要为一般登录随意改为 `True`。
成功返回 `True`；返回 `False` 时应用应停止创建求解器。自动登录失败会抛出 `RuntimeError`。
底层通信异常也可能直接向上抛出，请保留日志用于排查。

!!! warning "登录必须与求解发生在同一进程"
    不要先运行一个 `python -c` 登录，再启动另一个 Python 进程并假定已经登录。
    在运行求解器的进程内认证，或让 `NewtonSolver` 从环境变量自动认证。

## 在自动化任务中使用

真正的仿真 CI 需要 GPU runner、可获取的二进制或原生源码，以及任务允许使用的凭据。
将凭据保存在 GitHub Actions secrets，通过 `env` 注入使用；不要写到 YAML 明文或打印密码。
本仓库的文档 CI 只做静态解析，不加载库，也不需要这些 secrets。

认证失败的逐项检查见 [常见问题](../troubleshooting.md#authentication)。
