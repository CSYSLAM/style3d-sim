"""Locate assets from the Style3D Sim asset repository."""

from __future__ import annotations

import os
from pathlib import Path
import subprocess
import sys
import tempfile


_REPOSITORY = "https://github.com/Style3D/style3d-sim-assets.git"
_ASSETS_DIR_ENV = "STYLE3D_SIM_ASSETS_DIR"


def _cache_root() -> Path:
    return Path.home() / ".cache" / "style3d_sim" / "assets"


def get_assets() -> str:
    """Return the asset root, cloning the repository on first use.

    Set STYLE3D_SIM_ASSETS_DIR to use an existing checkout instead. The asset
    repository root must contain the asset groups directly.
    """
    override = os.environ.get(_ASSETS_DIR_ENV)
    if override:
        root = Path(override).expanduser().resolve()
        if not root.is_dir():
            raise FileNotFoundError(f"{_ASSETS_DIR_ENV} is not a directory: {root}")
        return str(root)

    root = _cache_root()
    if root.is_dir():
        return str(root)
    if root.exists():
        raise NotADirectoryError(f"Asset cache path is not a directory: {root}")

    root.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="assets-", dir=root.parent) as staging:
        checkout = Path(staging) / "checkout"
        print(f"Downloading Style3D Sim assets from {_REPOSITORY}...", file=sys.stderr, flush=True)
        try:
            subprocess.run(
                ["git", "clone", "--progress", "--depth", "1", "--", _REPOSITORY, str(checkout)],
                check=True,
            )
        except FileNotFoundError as exc:
            raise RuntimeError("Git is required to download Style3D Sim assets") from exc
        except subprocess.CalledProcessError as exc:
            raise RuntimeError(f"Could not clone Style3D Sim assets from {_REPOSITORY} (git exit code {exc.returncode})") from exc

        # Publish only a completed checkout; another process may have populated the cache meanwhile.
        if not root.exists():
            try:
                checkout.rename(root)
            except OSError:
                if not root.is_dir():
                    raise
    print(f"Style3D Sim assets ready at {root}", file=sys.stderr, flush=True)
    return str(root)


def get_asset(filename: str | os.PathLike[str]) -> str:
    """Return an asset path, cloning the repository on first use."""
    root = Path(get_assets()).resolve()
    asset = (root / filename).resolve()
    if not asset.is_relative_to(root):
        raise ValueError(f"Asset path escapes the asset root: {filename}")
    return str(asset)
