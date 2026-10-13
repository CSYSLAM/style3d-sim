"""Generate reference content without importing the CUDA package."""

from __future__ import annotations

import ast
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "src" / "synreal_solver"
PYTHON_MODULES = (
    "__init__.py",
    "newton_model_builder.py",
    "newton_solver.py",
    "fluid.py",
    "granular.py",
    "particle_surface.py",
    "viewer_polyscope.py",
)


def _signature(node: ast.FunctionDef) -> str:
    result = f"{node.name}({ast.unparse(node.args)})"
    if node.returns is not None:
        result += f" -> {ast.unparse(node.returns)}"
    return result


def _is_property(node: ast.FunctionDef) -> bool:
    return any(isinstance(item, ast.Name) and item.id == "property" for item in node.decorator_list)


def _is_setter(node: ast.FunctionDef) -> bool:
    return any(isinstance(item, ast.Attribute) and item.attr == "setter" for item in node.decorator_list)


def _public(node: ast.FunctionDef) -> bool:
    return node.name == "__init__" or not node.name.startswith("_")


def _table_cell(value: str) -> str:
    return " ".join(value.split()).replace("|", "&#124;").replace("<", "&lt;").replace(">", "&gt;")


def _class(node: ast.ClassDef, language: str) -> str:
    output = [f"## {node.name}\n", ast.get_docstring(node) or "", ""]
    members = [item for item in node.body if isinstance(item, ast.AnnAssign)]
    enum_names = [item.target.id for item in members if isinstance(item.target, ast.Name) and item.target.id.isupper()]
    if enum_names:
        label = "Members: " if language == "en" else "成员："
        output.extend([label + ", ".join(f"`{name}`" for name in enum_names), ""])
    properties = [item for item in node.body if isinstance(item, ast.FunctionDef) and _is_property(item)]
    if properties:
        header = "| Property | Type | Description |" if language == "en" else "| 属性 | 类型 | 说明 |"
        output.extend([header, "| --- | --- | --- |"])
        for item in properties:
            annotation = ast.unparse(item.returns) if item.returns is not None else "Any"
            output.append(
                f"| `{item.name}` | `{_table_cell(annotation)}` | {_table_cell(ast.get_docstring(item) or '')} |"
            )
        output.append("")
    methods = [
        item for item in node.body
        if isinstance(item, ast.FunctionDef) and _public(item) and not _is_property(item) and not _is_setter(item)
    ]
    # Group overloaded stubs under one heading to keep anchor IDs unambiguous.
    grouped: dict[str, list[ast.FunctionDef]] = {}
    for item in methods:
        grouped.setdefault(item.name, []).append(item)
    for name, overloads in grouped.items():
        output.extend([f"### `{name}`", ""])
        for item in overloads:
            output.extend([f"```text\n{_signature(item)}\n```", "", ast.get_docstring(item) or "", ""])
    return "\n".join(output)


def native_reference(language: str = "zh") -> str:
    tree = ast.parse((SOURCE / "_core.pyi").read_text(encoding="utf-8"))
    output = []
    for item in tree.body:
        if isinstance(item, ast.ClassDef):
            output.append(_class(item, language))
        elif isinstance(item, ast.FunctionDef) and _public(item):
            output.append(f"## `{item.name}`\n\n```text\n{_signature(item)}\n```\n\n{ast.get_docstring(item) or ''}\n")
    return "\n".join(output)


def python_reference(language: str = "zh") -> str:
    output = []
    for filename in PYTHON_MODULES:
        tree = ast.parse((SOURCE / filename).read_text(encoding="utf-8"))
        for item in tree.body:
            if isinstance(item, ast.ClassDef) and item.name in (
                "ModelBuilder", "NewtonSolver", "ParticleSurface", "ParticleSurfaceMesh", "ViewerPolyscope", "LogCallback"
            ):
                output.append(_class(item, language))
            elif isinstance(item, ast.FunctionDef) and _public(item) and filename != "particle_surface.py":
                output.append(f"## `{item.name}`\n\n```text\n{_signature(item)}\n```\n\n{ast.get_docstring(item) or ''}\n")
            elif isinstance(item, ast.FunctionDef) and item.name == "log_surface_mesh":
                output.append(f"## `{item.name}`\n\n```text\n{_signature(item)}\n```\n\n{ast.get_docstring(item) or ''}\n")
    return "\n".join(output)


def on_config(config):
    repository = os.environ.get("GITHUB_REPOSITORY")
    if repository:
        config.repo_url = f"https://github.com/{repository}"
        config.repo_name = repository
    return config


def on_page_markdown(markdown, page, config, files):
    language = config.plugins["i18n"].current_language
    if "<!-- GENERATED_NATIVE_API -->" in markdown:
        markdown = markdown.replace("<!-- GENERATED_NATIVE_API -->", native_reference(language))
    if "<!-- GENERATED_PYTHON_API -->" in markdown:
        markdown = markdown.replace("<!-- GENERATED_PYTHON_API -->", python_reference(language))
    return markdown
