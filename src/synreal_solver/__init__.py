"""Python API for synreal-solver."""

from typing import Any

from ._core import Config, Contact, Control, Model, Solver, Span, State, is_logged_in, login

__all__ = [
    "Config",
    "Contact",
    "Control",
    "is_logged_in",
    "login",
    "Model",
    "ModelBuilder",
    "NewtonSolver",
    "Solver",
    "Span",
    "State",
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
