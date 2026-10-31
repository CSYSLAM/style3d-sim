"""Read and configure per-user credentials for automatic Style3D Sim login."""

from __future__ import annotations

import getpass
import json
import os
from pathlib import Path
import stat
import tempfile


def credentials_path() -> Path:
    base = os.environ.get("XDG_CONFIG_HOME")
    return (Path(base).expanduser() if base else Path.home() / ".config") / "style3d-sim" / "credentials.json"


def load_saved_credentials() -> tuple[str, str] | None:
    path = credentials_path()
    try:
        with path.open(encoding="utf-8") as handle:
            if os.name == "posix" and stat.S_IMODE(os.fstat(handle.fileno()).st_mode) & 0o077:
                raise RuntimeError(f"Credential file must be private: chmod 600 {path}")
            data = json.load(handle)
    except FileNotFoundError:
        return None
    except (OSError, ValueError):
        # JSON decoder errors may contain credentials; do not propagate their text.
        raise RuntimeError(f"Cannot read credential file: {path}. Run python -m style3d_sim.local_credentials again.") from None
    if not isinstance(data, dict):
        raise RuntimeError(f"Invalid credential file: {path}")
    account, password = data.get("account"), data.get("password")
    if not isinstance(account, str) or not account.strip() or not isinstance(password, str) or not password:
        raise RuntimeError(f"Incomplete credential file: {path}")
    return account.strip(), password


def save_credentials(account: str, password: str) -> Path:
    account = account.strip()
    if not account or not password:
        raise ValueError("Account and password must not be empty")
    path = credentials_path()
    path.parent.mkdir(parents=True, exist_ok=True, mode=0o700)
    # mkstemp creates a private file before any secret bytes are written.
    fd, temporary = tempfile.mkstemp(prefix=".credentials-", suffix=".tmp", dir=path.parent)
    temporary_path = Path(temporary)
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as handle:
            json.dump({"account": account, "password": password}, handle, ensure_ascii=False)
            handle.write("\n")
            handle.flush()
            os.fsync(handle.fileno())
        os.replace(temporary_path, path)
    finally:
        temporary_path.unlink(missing_ok=True)
    return path


def main() -> None:
    print("Configure automatic Style3D Sim login.")
    print("Credentials are stored as plaintext in a private local file (0600 on Linux).")
    try:
        account = input("Style3D Sim account: ").strip()
        password = getpass.getpass("Password: ")
        confirmation = getpass.getpass("Confirm password: ")
        if password != confirmation:
            raise SystemExit("Passwords do not match; nothing was saved.")
        path = save_credentials(account, password)
    except (EOFError, KeyboardInterrupt):
        raise SystemExit("\nCancelled; nothing was saved.") from None
    except ValueError as exc:
        raise SystemExit(str(exc)) from None
    print(f"Saved credentials to {path}. Demos will authenticate automatically.")
    print("The account has not been validated; the next demo run will perform normal login.")


if __name__ == "__main__":
    main()
