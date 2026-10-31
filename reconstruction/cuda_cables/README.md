# Reconstructed cable CUDA kernels

These three sources are mechanical CUDA reconstructions imported from the legacy analysis tree.
They use C++ control flow and scalar inline PTX, and compile with `nvcc`; they do not load the vendor
solver, its binary, or extracted reference PTX at runtime. They are not yet readable NumPy implementations.
The original file hashes and the only code transformation (`asm` to `asm volatile`) are in `manifest.json`.
Generated register declarations and evidence comments retain their original formatting.

`reconstruction/cable_cuda.py` provides a source build and low-level launch adapter. The caller supplies
a CUDA driver/context, GPU arrays, ctypes scalar parameters, and a 160-byte by-value CableView. This has
not been connected to `native_step` yet. Current build target is compute_120 for the local RTX 5090;
other GPUs/compiler versions have not been validated.

From the project root:

```bash
.venv/bin/python -m reconstruction.diagnostics.cable_cuda_ab --seed 3 \
  --output build/reconstruction-cables/check.json
.venv/bin/python -m reconstruction.diagnostics.kernel_coverage --seed 3 --count 512 \
  --output build/reconstruction-debug/coverage-cables-new
```

The second output directory must be empty. The first command recompiles all three `.cu` sources and
compares them with untouched legacy PTX loaded in separate CUDA modules. This reference dependency exists
only in the A/B diagnostic. Compiler commands, versions and source hashes are recorded in
`build/reconstruction-cables/build.json`; compiler warnings are retained in the per-kernel build logs.

The A/B suite tests nine configurations, two worlds, static/dynamic endpoints, inactive cables, zero
stiffness/damping, tiny/zero/non-orthogonal affine matrices, varied reference matrices/rest angles,
same-body endpoints and 274 cables crossing the 256-thread launch boundary. It compares Jacobians,
indices/counts, penalty updates, force, Hessian products and preconditioner matrices. Evaluate tests
both shared reference Jacobians (isolation) and independently generated Jacobians (pipeline).
Input mutation checks are included. Each cable owns distinct bodies to avoid cross-thread atomic order
as a confounding factor. Arbitrary shared-body accumulation, every exceptional floating-point input,
complete host scheduling and demo trajectories are outside this validation claim.

The unmodified mechanical sources passed near-rotation cases but failed some strongly non-orthogonal
states. Keeping inline operations volatile fixed the observed failures; seed 1..10 passed the expanded
pipeline suite. This is an experimentally verified compiler constraint, not a claim that every changed
machine instruction has been analyzed. Failure reports are retained. The complete 124/124 A/B pass is in
`build/reconstruction-debug/coverage-20261029-cables/`; full demo equivalence is still unverified.

Whole-library audit correction: 124/124 counts only merged SynReal base names. The library contains
188 unique entry symbols; the current suite exercises 130, including 128/131 SynReal instances and
2/57 CUB/Thrust instances. See `reconstruction/WORK_LOG.md` and `diagnostics/kernel_inventory.py`.
