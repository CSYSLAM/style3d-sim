# SynReal solver reconstruction

Compiled CUDA/C++ replacement for the legacy `style3d_sim._core` solver image, plus the tools that prove it gives the
same results as the reference image on every runnable demo in `examples/`.

Reference image (project-internal, no login): `style3d-sim-bin/Linux/Release/_core.cpython-312-x86_64-linux-gnu.so`,
SHA256 `64a0be7f7a3c03cb6afe3c8ccb2eb3b58d64a760954ec7c1da08a7b8dd115c63`.

## Status

`csrc/DEMO_CLOSURE_TABLE.md` has one row per demo: 32 closed, 3 not applicable (35 in `examples/`).
The compiled module is `_source_solver`; `csrc/host_bodies_ab.bridge()` installs it as `style3d_sim._core`.
It is not yet a drop-in file named `_core` (docstrings and a few argument names differ; see `WORK_LOG.md`).
CUDA graph capture is disabled during comparison (every substep is recorded eagerly).

## Layout

| Path | Content |
|---|---|
| `csrc/kernels/`, `csrc/library/`, `csrc/revisions/` | CUDA kernels (188 compiled entries) |
| `csrc/native/source_solver.cpp` | Host `Solver` (pybind11), launches kernels through the driver API |
| `csrc/native/source_cuda.cpp`, `bvh_library.*` | Driver layer and the LBVH bridge |
| `csrc/build_native.py`, `build_bvh_library.py`, `build_host.py` | Build chain (below) |
| `csrc/build_standalone.py` | Unvalidated builder for a drop-in `_core` image |
| `csrc/demo_closure.py` | One-demo closure: stage 1 (1+1 bitwise) or stage 2 (5+5, checks A-E) |
| `csrc/closure_pool.py` | Joint verdict over an independent second round (10 originals as one reference) |
| `csrc/closure_row.py` | Appends a row to `DEMO_CLOSURE_TABLE.md` from `closure.json` |
| `csrc/demo_source_ab.py` | Worker that runs an unmodified example with either image and records every substep |
| `diagnostics/launchlog.c`, `cudahook.c` | LD_PRELOAD hooks for launch order/uploads (A/B) and kernel arguments (C) |
| `*.py` (top level) | Python specification of the solver, imported by the tools |
| `assets/` | Frozen robot assets used by the G1/ANYmal demos |

## Run a demo with either image

```bash
.venv/bin/python -m reconstruction.run_demo --backend original examples/example_fluid.py
.venv/bin/python -m reconstruction.run_demo --backend source   examples/example_fluid.py
# headless, then compare the final states
.venv/bin/python -m reconstruction.run_demo --backend original examples/example_body_spring.py --viewer null --save-final /tmp/o.npz
.venv/bin/python -m reconstruction.run_demo --backend source   examples/example_body_spring.py --viewer null --save-final /tmp/s.npz
.venv/bin/python -m reconstruction.compare_final /tmp/o.npz /tmp/s.npz
```

Example options pass through unchanged and the example runs in its default mode (CUDA graph capture on). Final
states are bitwise identical only for demos whose reference is reproducible against itself (see the closure table).

## Build (Linux)

Needs `build/toolchains/cuda-12.4`, `build/third_party/glm-1.0.1`, a C++17 compiler and the project `.venv`.

```bash
.venv/bin/python -m reconstruction.csrc.build_native   # kernels -> PTX bundle (build/reconstruction-csrc/native)
.venv/bin/python -m reconstruction.csrc.build_host     # BVH bridge + host Solver -> host-particles/_source_solver*.so
bash reconstruction/diagnostics/build_hooks.sh         # closure hooks -> build/reconstruction-csrc/bodies
```

A fresh copy containing only these files rebuilds the same kernels (PTX identical up to nvcc's path-derived
anonymous-namespace names) and passes `example_basic_dzhanibekov` (bitwise) and `example_basic_shapes` (A-E).

## Closure rules

Stage 1: one original and one source run over the example's full default frame count; bitwise identical -> closed.
Otherwise stage 2 with 5 + 5 runs:

- A: identical complete launch sequence (kernel, grid, block)
- B: identical multiset of host-to-device uploads (size, FNV-64)
- C: identical non-pointer kernel arguments over the first 2 frames (by-value `synreal::Model` compared on the bytes
  the reference kernel reads, parsed from its PTX in `build/reconstruction-ptx/64a0be7f7a3c03cb`)
- D: bitwise identical up to the reference's own first run-to-run difference
- E: one-sided exact rank test on substeps-within-spread and ratio_max (leave-one-out); fails only if p < 0.05

A marginal E failure gets an independent second round with a stated hypothesis; `closure_pool.py` then decides.

```bash
env -u STYLE3D_SIM_ACCOUNT -u STYLE3D_SIM_PASSWORD \
    .venv/bin/python -m reconstruction.csrc.demo_closure --example examples/example_fluid.py -- --no-capture
```

Run solver processes strictly one at a time. Raw run data (`.npz`, launch logs) is not kept; each demo keeps
`build/reconstruction-demos-source/<demo>/closure*/closure.json` and the per-run `runtime.json` files.
