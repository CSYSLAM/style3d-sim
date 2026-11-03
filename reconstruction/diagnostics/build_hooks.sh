#!/usr/bin/env bash
# Build the two LD_PRELOAD diagnostics used by reconstruction/csrc/demo_closure.py (checks A/B and C).
set -euo pipefail
cd "$(dirname "$0")/../.."
out=build/reconstruction-csrc/bodies
mkdir -p "$out"
for hook in launchlog cudahook; do
    gcc -O2 -shared -fPIC -o "$out/$hook.so" "reconstruction/diagnostics/$hook.c" -ldl \
        -I build/toolchains/cuda-12.4/include
done
