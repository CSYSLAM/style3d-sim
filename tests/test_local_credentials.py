import json
import os
import stat

import pytest

from style3d_sim import local_credentials, newton_solver


@pytest.fixture(autouse=True)
def isolated_credentials(monkeypatch, tmp_path):
    monkeypatch.setenv("XDG_CONFIG_HOME", str(tmp_path))
    monkeypatch.delenv("STYLE3D_SIM_ACCOUNT", raising=False)
    monkeypatch.delenv("STYLE3D_SIM_PASSWORD", raising=False)


def test_save_round_trip_and_replace_private_file():
    path = local_credentials.save_credentials(" test-account ", "special '\"\\\n密码")
    assert local_credentials.load_saved_credentials() == ("test-account", "special '\"\\\n密码")
    if os.name == "posix":
        assert stat.S_IMODE(path.stat().st_mode) == 0o600
    local_credentials.save_credentials("other-account", "replacement")
    assert local_credentials.load_saved_credentials() == ("other-account", "replacement")
    assert not list(path.parent.glob(".credentials-*.tmp"))


def test_saved_pair_is_used_without_prompt(monkeypatch):
    local_credentials.save_credentials("saved-account", "saved-password")
    monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "incomplete-env-account")
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setattr("builtins.input", lambda _: pytest.fail("Unexpected prompt"))
    monkeypatch.setattr(newton_solver.getpass, "getpass", lambda _: pytest.fail("Unexpected password prompt"))
    calls = []
    monkeypatch.setattr(newton_solver, "login", lambda *args: calls.append(args) or True)
    newton_solver._ensure_style3d_login()
    assert calls == [("saved-account", "saved-password", False)]


def test_complete_environment_takes_precedence(monkeypatch):
    local_credentials.save_credentials("saved-account", "saved-password")
    monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "env-account")
    monkeypatch.setenv("STYLE3D_SIM_PASSWORD", "env-password")
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setattr(newton_solver, "load_saved_credentials", lambda: pytest.fail("Unexpected file read"))
    calls = []
    monkeypatch.setattr(newton_solver, "login", lambda *args: calls.append(args) or True)
    newton_solver._ensure_style3d_login()
    assert calls == [("env-account", "env-password", False)]


def test_saved_login_failure_does_not_retry_or_bypass(monkeypatch):
    local_credentials.save_credentials("saved-account", "saved-password")
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setattr("builtins.input", lambda _: pytest.fail("Unexpected prompt"))
    calls = []
    monkeypatch.setattr(newton_solver, "login", lambda *args: calls.append(args) or False)
    with pytest.raises(RuntimeError, match="Style3D Sim login failed"):
        newton_solver._ensure_style3d_login()
    assert calls == [("saved-account", "saved-password", False)]


def test_missing_file_returns_none():
    assert local_credentials.load_saved_credentials() is None


@pytest.mark.parametrize("content", ['{"password": "SECRET",', json.dumps({"password": "SECRET"}), "[]"])
def test_invalid_file_does_not_expose_secret(content):
    path = local_credentials.save_credentials("test-account", "test-password")
    path.write_text(content)
    with pytest.raises(RuntimeError) as error:
        local_credentials.load_saved_credentials()
    assert "SECRET" not in str(error.value)
    assert error.value.__cause__ is None


@pytest.mark.skipif(os.name != "posix", reason="POSIX permissions")
def test_shared_credential_file_is_rejected():
    path = local_credentials.save_credentials("test-account", "test-password")
    path.chmod(0o644)
    with pytest.raises(RuntimeError, match="chmod 600"):
        local_credentials.load_saved_credentials()


def test_empty_password_preserves_existing_file():
    path = local_credentials.save_credentials("test-account", "existing-password")
    before = path.read_bytes()
    with pytest.raises(ValueError):
        local_credentials.save_credentials("test-account", "")
    assert path.read_bytes() == before


@pytest.mark.parametrize("source", ["saved", "environment"])
def test_login_failure_reports_source_without_secrets(monkeypatch, source):
    local_credentials.save_credentials("PRIVATE_ACCOUNT", "PRIVATE_PASSWORD")
    if source == "environment":
        monkeypatch.setenv("STYLE3D_SIM_ACCOUNT", "PRIVATE_ACCOUNT")
        monkeypatch.setenv("STYLE3D_SIM_PASSWORD", "PRIVATE_PASSWORD")
    monkeypatch.setattr(newton_solver, "is_logged_in", lambda: False)
    monkeypatch.setattr(newton_solver, "login", lambda *args: False)
    with pytest.raises(RuntimeError) as error:
        newton_solver._ensure_style3d_login()
    message = str(error.value)
    assert "PRIVATE_ACCOUNT" not in message
    assert "PRIVATE_PASSWORD" not in message
    assert ("environment variables" if source == "environment" else "saved local credential file") in message
    assert "without a detailed reason" in message
