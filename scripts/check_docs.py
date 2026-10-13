"""Check documented snippets and local source links without importing the solver."""

from __future__ import annotations

import ast
from pathlib import Path
import re

from docs_hooks import native_reference, python_reference

ROOT = Path(__file__).resolve().parents[1]


def check_translations() -> int:
    paths = set((ROOT / "docs").rglob("*.md"))
    originals = {path for path in paths if not path.name.endswith(".en.md")}
    translations = {path.with_name(f"{path.stem}.en.md") for path in originals}
    missing = translations - paths
    orphaned = paths - originals - translations
    if missing or orphaned:
        details = ", ".join(str(path.relative_to(ROOT)) for path in sorted(missing | orphaned))
        raise ValueError(f"Missing bilingual page counterpart: {details}")
    for original in originals:
        translated = original.with_name(f"{original.stem}.en.md")
        source = original.read_text(encoding="utf-8")
        target = translated.read_text(encoding="utf-8")
        # Code and explicit cross-page anchors must stay consistent across translations.
        pattern = r"```python[^\n]*\n(.*?)\n\s*```"
        if re.findall(pattern, source, re.DOTALL) != re.findall(pattern, target, re.DOTALL):
            raise ValueError(f"Translated Python snippets differ: {translated.relative_to(ROOT)}")
        if set(re.findall(r"\{#([^}]+)\}", source)) != set(re.findall(r"\{#([^}]+)\}", target)):
            raise ValueError(f"Translated explicit anchors differ: {translated.relative_to(ROOT)}")
    return len(originals)


def main() -> None:
    pages = check_translations()
    snippets = 0
    for path in (ROOT / "docs").rglob("*.md"):
        content = path.read_text(encoding="utf-8")
        for number, snippet in enumerate(re.findall(r"```python[^\n]*\n(.*?)\n\s*```", content, re.DOTALL), 1):
            snippet = re.sub(
                r'--8<--\s+"([^\"]+)"',
                lambda match: (ROOT / match.group(1)).read_text(encoding="utf-8"),
                snippet,
            )
            ast.parse(snippet, filename=f"{path}:{number}")
            snippets += 1
        for target in re.findall(r"--8<--\s+\"([^\"]+)\"", content):
            if not (ROOT / target).is_file():
                raise FileNotFoundError(f"{path}: {target}")
    for path in (ROOT / "docs" / "samples").glob("*.py"):
        ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
    for language in ("zh", "en"):
        for reference in (native_reference(language), python_reference(language)):
            if not reference.strip():
                raise ValueError(f"Generated API reference is empty: {language}")
    print(f"Documentation checks passed: {pages} bilingual page pairs, {snippets} Python snippets, and API references.")


if __name__ == "__main__":
    main()
