"""Python API for synreal-solver."""

from typing import Any, Protocol

from ._core import (
    AffineBodyRigidityModel,
    Config,
    Contact,
    Control,
    LogLevel,
    Model,
    RigidBodyIntegrator,
    Solver,
    Span,
    State,
    is_logged_in,
    login,
    set_log_callback as _set_log_callback,
)


class LogCallback(Protocol):
    """Callable interface used to receive native solver log messages."""

    def __call__(
        self,
        file_name: str,
        function_name: str,
        line: int,
        level: LogLevel,
        message: str,
        /,
    ) -> None:
        ...


def set_log_callback(callback: LogCallback) -> None:
    """Register a Python callback for native solver log messages."""

    # Keep the native function private so callers see the named callback protocol.
    _set_log_callback(callback)

__all__ = [
    "AffineBodyRigidityModel",
    "Config",
    "Contact",
    "Control",
    "is_logged_in",
    "LogCallback",
    "LogLevel",
    "login",
    "Model",
    "ModelBuilder",
    "NewtonSolver",
    "RigidBodyIntegrator",
    "Solver",
    "Span",
    "State",
    "set_log_callback",
]


def __getattr__(name: str) -> Any:
    """Load the optional Newton adapter only when its public types are requested."""
    if name == "ModelBuilder":
        from .newton_model_builder import ModelBuilder

        globals()[name] = ModelBuilder
        return ModelBuilder
    if name == "NewtonSolver":
        from .newton_solver import NewtonSolver

        globals()[name] = NewtonSolver
        return NewtonSolver
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
