# Authentication

`NewtonSolver(model)` checks the native session during construction. It continues if already authenticated;
otherwise, it reads credentials and calls native `login()`. When using native `Solver` directly,
call the authentication API yourself.

## Option 1: Environment Variables in the Current Terminal

=== "PowerShell"

    ```powershell
    $env:STYLE3D_ACCOUNT = "your-account"
    $env:STYLE3D_PASSWORD = "your-password"
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

=== "Bash / Zsh"

    ```bash
    export STYLE3D_ACCOUNT="your-account"
    export STYLE3D_PASSWORD="your-password"
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

=== "Windows CMD"

    ```bat
    set STYLE3D_ACCOUNT=your-account
    set STYLE3D_PASSWORD=your-password
    uv run python examples/example_basic_shapes.py --solver synreal
    ```

First set the source path as described in [Installation](installation.en.md).
Use `STYLE3D_ACCOUNT` and `STYLE3D_PASSWORD` for credentials.

These variables belong to the current terminal process and processes launched from it.
Closing the terminal does not remove values already inherited by a running child process,
but a new independent terminal does not automatically inherit them.
Native session authentication and environment variables are separate states.

To remove temporary credentials in PowerShell:

```powershell
Remove-Item Env:STYLE3D_ACCOUNT -ErrorAction SilentlyContinue
Remove-Item Env:STYLE3D_PASSWORD -ErrorAction SilentlyContinue
```

## Option 2: Interactive Input

Run a program that uses `NewtonSolver` without setting credential variables:

```text
Style3D Sim account: your-account
Password:
```

The password is read with `getpass.getpass()` and is hidden in a normal terminal.
If either credential is missing or empty, the program asks for both again.
Use the VS Code Terminal. The Debug Console, tasks without stdin, and ordinary CI jobs cannot handle these prompts.

## Option 3: Explicit Authentication in Your Application

```python
import getpass
import style3d_sim as s3d

if not s3d.is_logged_in():
    account = input("Style3D Sim account: ").strip()
    password = getpass.getpass("Password: ")
    if not s3d.login(account, password, False):
        raise RuntimeError("Style3D Sim login failed")
```

The signature is `login(name: str, password: str, force_signin: bool) -> bool`.
This example uses `force_signin=False`. The third parameter does not control password visibility;
keep it `False` for the ordinary login flow.
Success returns `True`. On `False`, stop before creating the solver.
Automatic login failure raises `RuntimeError`; underlying communication exceptions may also propagate.
Keep useful diagnostic logs without credentials.

!!! warning "Authenticate in the process that runs the solver"
    Logging in with a separate `python -c` command does not authenticate another Python process.
    Authenticate inside the simulation process or let `NewtonSolver` use the environment variables.

## Automated Jobs

Simulation CI requires a GPU runner, accessible binaries or native source, and credentials available to the job.
Store credentials in GitHub Actions secrets and inject them through `env`.
Avoid plaintext credentials in YAML and never print passwords.
Documentation CI only performs static parsing and needs no authentication secrets.

For a login checklist, see [Troubleshooting](../troubleshooting.en.md#authentication).
