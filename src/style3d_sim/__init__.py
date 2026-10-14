"""Python API for Style3D Sim."""

from typing import Any, Protocol

from ._core import (
    AffineBodyRigidityModel,
    Config,
    Contact,
    Control,
    JointConstraintMode,
    LogLevel,
    Model,
    InertiaMode,
    NonlinearSolver,
    Solver,
    Span,
    State,
    is_logged_in,
    login,
    set_log_callback as _set_log_callback,
)
from .viewer_polyscope import ViewerPolyscope


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
    "configure_fluid",
    "configure_granular",
    "AffineBodyRigidityModel",
    "Config",
    "Contact",
    "Control",
    "is_logged_in",
    "JointConstraintMode",
    "LogCallback",
    "LogLevel",
    "login",
    "Model",
    "ModelBuilder",
    "NewtonSolver",
    "InertiaMode",
    "NonlinearSolver",
    "ParticleSurface",
    "ParticleSurfaceMesh",
    "Solver",
    "Span",
    "State",
    "set_log_callback",
    "log_surface_mesh",
    "ViewerPolyscope",
]


def __getattr__(name: str) -> Any:
    """Load optional Newton and Warp helpers only when their public types are requested."""
    if name in ("ParticleSurface", "ParticleSurfaceMesh", "log_surface_mesh"):
        from . import particle_surface

        value = getattr(particle_surface, name)
        globals()[name] = value
        return value
    if name == "configure_granular":
        from .granular import configure_granular

        globals()[name] = configure_granular
        return configure_granular
    if name == "configure_fluid":
        from .fluid import configure_fluid

        globals()[name] = configure_fluid
        return configure_fluid
    if name == "ModelBuilder":
        from .newton_model_builder import ModelBuilder

        globals()[name] = ModelBuilder
        return ModelBuilder
    if name == "NewtonSolver":
        from .newton_solver import NewtonSolver

        globals()[name] = NewtonSolver
        return NewtonSolver
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
