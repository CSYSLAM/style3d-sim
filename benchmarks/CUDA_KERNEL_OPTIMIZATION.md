# CUDA Kernel Optimization Report

## Summary

This change removes the standalone PCG Jacobi-preconditioner CUDA kernel. On
the 256-world Unitree H1 benchmark, median frame time decreased by 7.39% and
median throughput increased by 7.98%.

| Metric | Before | After | Change |
| --- | ---: | ---: | ---: |
| Median frame time | 7.344 ms | 6.801 ms | -7.39% |
| Median throughput | 34,857 world-frames/s | 37,639 world-frames/s | +7.98% |
| Median aggregate real-time | 697.1x | 752.8x | +7.98% |
| Throughput range, 5 runs | 34,580-35,005 | 37,099-37,673 | no overlap |

Raw results:

- [cuda_kernel_before.json](cuda_kernel_before.json)
- [cuda_kernel_after.json](cuda_kernel_after.json)

## Change

Before this change, every PCG iteration performed these operations:

1. Launch `multiply_preconditioner` to write `z = P^-1 r` to global memory.
2. Read `r` and `z` in the CUB reduction that computes `rTz`.
3. Read `z` again while updating the CG direction.

The optimized path applies `P^-1` directly in a CUB zip-transform iterator
during the `rTz` reduction. The CG-direction kernel recomputes `P^-1 r`, so the
standalone kernel and the global `z` workspace are no longer needed.

For the scalar Jacobi preconditioner used by the H1 benchmark, the affected
operations transfer approximately 64 bytes per row per iteration before the
change and 32 bytes after it, excluding traffic common to both versions. The
solver also releases 12 bytes per row of persistent `z` workspace.

The benchmark uses 4 substeps, 10 nonlinear iterations, and 10 linear PCG
iterations. The change therefore removes 400 CUDA kernel launches per frame.

## Method

The before binary was built from commit `0d6dfe5` in an isolated worktree. The
after binary was built from the working tree based on that commit with only the
PCG changes in this report. Path checks confirmed that each run loaded its
intended `_core.cp311-win_amd64.pyd`.

Both variants used the same command and ran consecutively on the same machine:

```console
uv run python benchmarks/benchmark_robot_h1_genesis.py --solver synreal --world-count 256 --headless --steps 500 --warmup-steps 50 --repeats 5
```

Each repeat contains 50 untimed warm-up frames followed by 500 measured frames.
The application submits captured CUDA graphs and synchronizes the GPU before
and after each measured interval. Reported values are medians of five repeats.

## Environment

| Component | Value |
| --- | --- |
| GPU | NVIDIA GeForce RTX 4090, SM 8.9, 24 GiB |
| Driver | 610.62 |
| OS | Windows 10.0.26200 |
| Python | 3.11.14 |
| CUDA build toolkit | 13.3 |
| Warp | 1.15.0 |
| Newton | 1.4.0 |

## Correctness

The optimization preserves the PCG recurrence: both the reduction and direction
update evaluate the same `P^-1 r` expression that was previously materialized
in `z`. The existing C++ tests cover scalar and 3x3 block-diagonal
preconditioners, an additional matrix multiplier, and zero-residual breakdown.
The complete C++ and Python test suites passed after the change.

## Profiler Limitation

Nsight Compute 2026.2 was available and a capture was attempted with a kernel
name filter for `multiply_matrix`. Interception of the Python child process and
captured CUDA graph did not complete within 240 seconds, so no hardware-counter
claims are made here. The optimization is justified by the removed launch and
memory path and evaluated with synchronized end-to-end GPU timings.
