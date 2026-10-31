#!/usr/bin/env bash
set -euo pipefail
project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$project_dir"
# XPBD works without a Style3D account; later arguments can select SynReal.
exec "$project_dir/.venv/bin/python" examples/example_basic_shapes.py --solver xpbd "$@"
