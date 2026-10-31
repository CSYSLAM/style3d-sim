#!/usr/bin/env bash
# Source this file from Bash before building or running a reconstructed solver worker.
reconstruction_project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export PATH="$reconstruction_project_dir/build/toolchains/cuda-12.4/bin:"\
"$reconstruction_project_dir/build/toolchains/diagnostics-13.2/compute-sanitizer:"\
"$reconstruction_project_dir/build/toolchains/diagnostics-13.2/bin:$PATH"
export LD_LIBRARY_PATH="$reconstruction_project_dir/build/toolchains/cuda-12.4/lib:"\
"$reconstruction_project_dir/build/toolchains/diagnostics-13.2/lib:/usr/lib/wsl/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export LIBRARY_PATH="/usr/lib/wsl/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"
export PYTHONDONTWRITEBYTECODE=1
unset reconstruction_project_dir
