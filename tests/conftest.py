import sys

import pytest


@pytest.fixture(autouse=True)
def authenticated_solver_session(monkeypatch: pytest.MonkeyPatch) -> None:
    # Physics tests use a native build with SYNREAL_SOLVER_SKIP_AUTH=ON. Keep the
    # Python adapter offline too; authentication tests override this stub locally.
    if "newton" in sys.modules:
        from style3d_sim import newton_solver

        monkeypatch.setattr(newton_solver, "is_logged_in", lambda: True)
