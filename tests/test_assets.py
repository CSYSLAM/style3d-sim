import subprocess
from pathlib import Path

import pytest

from style3d_sim import assets


def test_get_assets_clones_once_and_get_asset_uses_checkout(
    tmp_path: Path, monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture[str]
) -> None:
    root = tmp_path / "cache" / "assets"
    calls = []

    def clone(command: list[str], **kwargs: object) -> subprocess.CompletedProcess[str]:
        calls.append(command)
        asset = Path(command[-1]) / "joints" / "ball" / "ball.urdf"
        asset.parent.mkdir(parents=True)
        asset.write_text("<robot/>", encoding="utf-8")
        return subprocess.CompletedProcess(command, 0)

    monkeypatch.delenv("STYLE3D_SIM_ASSETS_DIR", raising=False)
    monkeypatch.setattr(assets, "_cache_root", lambda: root)
    monkeypatch.setattr(assets.subprocess, "run", clone)

    assert assets.get_assets() == str(root)
    assert Path(assets.get_asset("joints/ball/ball.urdf")).read_text(encoding="utf-8") == "<robot/>"
    assert assets.get_assets() == str(root)
    assert len(calls) == 1
    assert calls[0][:7] == ["git", "clone", "--progress", "--depth", "1", "--", assets._REPOSITORY]
    output = capsys.readouterr().err
    assert "Downloading Style3D Sim assets" in output
    assert f"Style3D Sim assets ready at {root}" in output


def test_get_assets_uses_existing_directory(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("STYLE3D_SIM_ASSETS_DIR", str(tmp_path))
    monkeypatch.setattr(assets, "_cache_root", lambda: pytest.fail("Unexpected cache access"))

    assert assets.get_assets() == str(tmp_path)


def test_get_assets_does_not_publish_failed_clone(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    root = tmp_path / "cache" / "assets"
    monkeypatch.delenv("STYLE3D_SIM_ASSETS_DIR", raising=False)
    monkeypatch.setattr(assets, "_cache_root", lambda: root)

    def fail_clone(command: list[str], **kwargs: object) -> None:
        raise subprocess.CalledProcessError(128, command)

    monkeypatch.setattr(assets.subprocess, "run", fail_clone)

    with pytest.raises(RuntimeError, match="git exit code 128"):
        assets.get_assets()
    assert not root.exists()


def test_get_asset_rejects_paths_outside_root(tmp_path: Path, monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("STYLE3D_SIM_ASSETS_DIR", str(tmp_path))

    with pytest.raises(ValueError, match="escapes the asset root"):
        assets.get_asset("../outside.usd")
