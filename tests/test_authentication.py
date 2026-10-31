import pytest

from style3d_sim import newton_solver


@pytest.fixture(autouse=True)
def isolate_saved_credentials(monkeypatch: pytest.MonkeyPatch, tmp_path) -> None:
    monkeypatch.setenv("XDG_CONFIG_HOME", str(tmp_path))
    monkeypatch.delenv("STYLE3D_SIM_ACCOUNT", raising=False)
    monkeypatch.delenv("STYLE3D_SIM_PASSWORD", raising=False)


def test_newton_solver_login_reuses_authenticated_session(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: True)
    monkeypatch.setattr("builtins.input", lambda prompt: pytest.fail("Unexpected account prompt"))
    monkeypatch.setattr(newton_solver.getpass, "getpass", lambda prompt: pytest.fail("Unexpected password prompt"))
    monkeypatch.setattr(newton_solver, "login", lambda *args: pytest.fail("Unexpected login request"))

    newton_solver._ensure_style3d_login()


def test_newton_solver_login_uses_style3d_environment(monkeypatch: pytest.MonkeyPatch) -> None:
    credentials = []
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "environment-account")
    monkeypatch.setenv("STYLE3D_SIM_PASSWORD", "environment-password")
    monkeypatch.setattr("builtins.input", lambda prompt: pytest.fail("Unexpected account prompt"))
    monkeypatch.setattr(newton_solver.getpass, "getpass", lambda prompt: pytest.fail("Unexpected password prompt"))
    monkeypatch.setattr(newton_solver, "login", lambda *args: credentials.append(args) or True)

    newton_solver._ensure_style3d_login()

    assert credentials == [("environment-account", "environment-password", False)]


def test_newton_solver_login_prompts_when_environment_is_incomplete(monkeypatch: pytest.MonkeyPatch) -> None:
    credentials = []
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "environment-account")
    monkeypatch.delenv("STYLE3D_SIM_PASSWORD", raising=False)
    monkeypatch.setattr("builtins.input", lambda prompt: "prompted-account")
    monkeypatch.setattr(newton_solver.getpass, "getpass", lambda prompt: "prompted-password")
    monkeypatch.setattr(newton_solver, "login", lambda *args: credentials.append(args) or True)

    newton_solver._ensure_style3d_login()

    assert credentials == [("prompted-account", "prompted-password", False)]


def test_newton_solver_login_failure(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "account")
    monkeypatch.setenv("STYLE3D_SIM_PASSWORD", "password")
    monkeypatch.setattr(newton_solver, "login", lambda *args: False)

    with pytest.raises(RuntimeError, match="Style3D Sim login failed"):
        newton_solver._ensure_style3d_login()
