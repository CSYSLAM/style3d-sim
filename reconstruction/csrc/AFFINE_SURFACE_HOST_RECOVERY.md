# SO3 body / full-surface host recovery

This document records the completed ff34 surface checkpoint. The current host is b9456031; see
[BODY_TETRAHEDRA_HOST_RECOVERY.md](BODY_TETRAHEDRA_HOST_RECOVERY.md).
Later ff34 stage isolation and independent reference holdouts are in
[SURFACE_STAGE_ISOLATION.md](SURFACE_STAGE_ISOLATION.md). Old failed candidates remain archived.

## Current image and scope

Surface checkpoint image: `ff34e6a18e2a7d62ac9203c1c532c2ffc8c9c698f2eb2dc799f2d3d7a261f042`.
Previous images: `cc09a3c0` (rolling), `25ecf6f4` (surface), and `8fb9d2ee` (published handoff baseline).
Reference: the fixed project-internal processed `_core.so`, SHA256 `64a0be7f…`.
CUDA entry count remains 176; CUDA digest remains `f0e0137a…`. No CUDA arithmetic or tolerance changed.
`solver_api_ready=False`; the complete solver has not been accepted.

This adds the captured SO3 body + cloth + barycentric surface branch, with Newton/PD, body-block,
ordinary springs, self collision, and diagonal-only controls. The cc image also adds captured rolling resistance.
Hard rigid contact, constrained bodies,
cables, fluids, drag, tetrahedra and other rigidity models remain guarded for this new combination.

## Changes recovered from the actual SDK

The previous source SurfaceContactView left its body mapping empty and always passed the particle-only kind array.
The original SDK's real launch arguments and Model span pointers establish these fields:

| Byte offset | Actual field |
| --- | --- |
| 104 | The same body-kind pointer as initialize_step parameter 19 |
| 240 | model.affine_body_ids |
| 248 | model.affine_body_indices |
| 256 | model.body_centers_of_mass |
| 264 | Local body count, not replicated state count |

The source now passes those fields. With bodies, the original force order is rigid contact, rolling resistance
when enabled, surface reaction, legacy soft contact, then SO3 and particle materials. The earlier source placed
surface before rigid contact. This order is corrected.
Particle-only surface behavior is preserved because that path does not launch rigid/rolling body kernels.

The independent fixture uses a box of half-size .025 at z=.479 and the two existing small cloth layers.
Its first W1 frame contains 15 real surface contacts, 8 with non-vertex barycentric weights, and nonzero
surface-force increments on both cloth particles and affine body proxies. W3 has 45 active contacts.
The old cloth fixture and frozen failed source0 were not modified.

## Evidence and strict failures

Prototype evidence and the actual reference eight fixtures are in:
`build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-8fb9d2ee/`.

The first completed surface image (25ecf6f4) validation is in:
`build/reconstruction-csrc/affine-particle-material-host/validation-25ecf6f4/`.

The initial final-image source eight fixtures give five W1 strict passes; three W3 strict state/buffer failures remain.
All eight actual owned ABI schedules and source launch-count coverage match. Do not label all eight bitwise accepted.

Actual W3 input capture showed different contact ordering, despite identical complete contact-record multisets:
source records correspond to original records [1,2,...,14,0,15,...,44]. Material constants, initial x/previous,
kind, mass and body mapping are identical. Shared shape arrays have one element, not three replicated elements.
The first probe incorrectly copied three elements, causing a diagnostic cudaMemcpy error; its failed directory
is preserved. The corrected probes read only initialized contacts and the actual shared template lengths.

For a single actual contact, original runtime, literal original PTX and source PTX outputs match bitwise.
An initial attempt to use rounded per-contact outputs as sum operands was insufficient because normal and
friction are separate atomic additions; that preliminary report is explicitly marked invalid for criterion B.

The corrected diagnostic leaves every red.global.add operation in place and records its actual destination and
float32 operand. On the same real inputs, per-thread atomic sequences match exactly for original and source:

| Operation | Atomic writes | Output scalars |
| --- | --- | --- |
| Surface force | 1440 | 108 |
| Surface stiffness scale | 240 | 36 |
| Surface preconditioner | 4320 | 324 |
| Surface tangent product | 1440 | 108 |

All output scalars in the captured output, three uninstrumented replays and two instrumented replays have exact
float32 permutation witnesses using those true scalar atomic operands and the actual initial output buffers.
This is local arithmetic evidence; it does not infer an old uninstrumented execution order or accept an entire
closed-loop trajectory. The original fixed 8f C8 source0 failure remains preserved and unaccepted.

## Other work on the earlier fixed graph failure

The earlier fixed 8f graph14 audit found 215 kernels, 21 copies and 30 clears; the complete normalized graph,
212 native node parameters and copy/clear pointer-alias wiring match. Three Warp kernels' argument payloads
were not directly covered by that earlier audit. The later Warp diagnostic below checks their payloads on a new
original/frozen8f pair. Pointee values and allocation-relative offsets are not implied.
The old actual contact constructor's 180 C-view words also match under live-allocation identity/offset tracking.

The lower-interference late probe does not hook capture or launch, and loads its CUDA inspection code only after
the worker's existing first target q download. One original and one source diagnostic still did not reproduce
the old fixed failed source0; their last-NL caches matched.

Actual-runtime/original-PTX/source-PTX block apply, affine apply and precomputed-PCG were replayed on the same
allocations, 32 times each. All three pointwise stages matched and the numerator matched.
This last-NL diagnostic cannot be presented as the first differing nonlinear iteration.

## Commands and next work

Use `source scripts/reconstruction_env.sh`. Preserve unique output names and serialize GPU workers.
The tested Compute Sanitizer is shipped under `build/toolchains/diagnostics-13.2/compute-sanitizer/`.
The runner now resolves that project-relative path; its pre-portability version remains in ff34 `versions/`.
This changes tool discovery only, with no change to fixtures, arithmetic, comparisons or saved cohort results.

```bash
# The reference fixtures must already exist; this pins one source image and preserves strict failures.
recon_inputs=build/reconstruction-csrc/affine-particle-material-host/continuation-20261031-8fb9d2ee
.venv/bin/python -m reconstruction.csrc.affine_surface_validation \
  --reference "$recon_inputs/body-surface-reference8" \
  --kernel-inputs "$recon_inputs/surface-four-operation-inputs" \
  --output build/reconstruction-csrc/NEW-surface-validation

# Fixed 3-source/8-original C test, adopting first workers without replacement.
.venv/bin/python -m reconstruction.csrc.affine_graph_cohort --suite surface \
  --baseline build/reconstruction-csrc/affine-particle-material-host/validation-25ecf6f4/surface-graph60 \
  --output build/reconstruction-csrc/NEW-surface-C8
```

The **25 image** serial queue is complete; these counts must not be inherited as cc image results:

| Check | Result |
| --- | --- |
| Same-input four surface operators | Pointwise outputs and per-thread actual atomic operands identical |
| Initial eight surface fixtures | 5/8 strict; all eight owned ABI/coverage match |
| Surface eager/graph60 | 21/32 strict |
| Earlier cloth eager/graph60 | 29/32 strict |
| Surface fixed 3-source/8-original cohort | 11/16 criterion C; **failed** |
| Earlier cloth fixed cohort | 13/16 criterion C; **failed** |
| Surface initcheck, 16 trajectories x 3 steps | Zero errors |
| Config contract | 246 checks passed |
| Full regression | 70/74 strict; seven formal demos each 60 frames strict |

The four strict regression failures are particles seeds 1/2/3 and **pd_mixed_cloth seed3**. Each first source was
frozen and compared to ten originals. `regression-fixed-C10/report-array-steps.json` is the valid CPU re-audit:
particles seeds 1/3 and PD mixed cloth pass; particles seed2 remains outside criterion C at two keys recording
the same velocity state (step1 out and step2 in), ratio 1.07142857. The original `report.json` incorrectly used
the spatial particle axis as time and is marked invalid; raw inputs and source0 remain unchanged.

An isolated `surface-struct220-split-trial/` restores two 220-byte intermediate structures, matching the original
440-byte workspace. Production CUDA and its digest have **not** changed. All 324 serialized boundary comparisons
(3 seeds, 27 fixtures, four operators) match the current reference PTX for both active source and experimental
PTX. Real 45-contact single-contact and atomic-operand checks also pass for the initial struct experiment.
This does not establish that adopting the experiment would fix parallel trajectories. Do not adopt it based on
one coincidentally matching aggregate or call its PTX identical to the original.

`particles-seed2-stage-trace/` isolates the n257 fixture for diagnosis. Its first difference is launch000038,
the second step's first PCG numerator, with identical inputs and z outputs. Both scalar values have exact
float32 permutation witnesses. Actual-runtime/original-PTX/source-PTX, rotating on the same buffers, each ran
32 times and all pointwise outputs matched; the original itself emitted both captured scalar patterns.
All 105 pointwise PCG replay checks passed; six of 42 atomic aggregates differed in that replay.
The traced source does **not** reproduce the frozen failed source0's complete output, so the fixed C10 failure
remains unaccepted and is not replaced by this diagnostic.

## Simultaneous rolling branch: cc09a3c0

`affine_surface_rolling_scene.py` is independent of the earlier fixtures: the box also contacts a ground plane
at z=.456, with rolling .03 and torsional .015. All eight actual original reference captures are finite and
exercise real rigid (4/W1, 12/W3), surface (17/W1, 51/W3) and rolling reactions. The rolling and surface operators
both change RHS values; surface reaction affects cloth and body proxies.

The actual original order is rigid force, **rolling force**, surface force, legacy soft, then SO3 and cloth.
The cc host restores this order and removes only the rolling guard from the already captured SO3/surface scope.
The earlier kernels already implement rolling; CUDA arithmetic and digest remain unchanged.
Original/source preconditioner order is surface then rolling; tangent is surface, rigid/soft, then rolling.

First eight cc rolling captures are in `affine-particle-material-host/surface-rolling-source-first8/`:
five W1 state/buffer/ABI/coverage strict passes; three W3 state differences with all eight ABI/coverage matching.
Original references are kept under `validation-25ecf6f4/surface-rolling-reference8/` (the directory names the
source image present at capture time; the executed reference is always 64a).

The cc serial queue is complete: full74 is 71 strict, with only particles seeds1/2/3 strict failures;
source8 is 5/8, surface graph21/32, legacy cloth graph25/32, initcheck3 zero errors, config246 matched.
The rolling graph is 20/32 strict, fixed C8 is 11/16 (**failed**), and original/source rolling initcheck3 are both clean.

```bash
.venv/bin/python -m reconstruction.csrc.affine_surface_rolling_graph_ab --frames 60 \
  --output build/reconstruction-csrc/NEW-rolling-graph60
.venv/bin/python -m reconstruction.csrc.affine_graph_cohort --suite surface_rolling \
  --baseline build/reconstruction-csrc/NEW-rolling-graph60 \
  --output build/reconstruction-csrc/NEW-rolling-C8
```

## Current ff34: large-demo host corrections and remaining failures

The unchanged official `examples/example_cloth_balls.py` was run at its defaults: 5 nonlinear iterations,
50 linear iterations and two substeps, for 60 frames. The eager worker records all 120 substeps; the graph worker
retains the example's complete real CUDA graph and records 60 frames. Each mode fixed 8 originals and 3 sources
before observing results. All 22 cc workers passed finite values and the example's test_final checks, but both
mode cohorts failed per-step criterion C. They remain in `validation-cc09a3c0/official-cloth-balls60/`.

The first internal-buffer probe used an incorrect legacy-soft argument index (35 is float inv_dt, not a pointer)
and crashed its original diagnostic process. That failed harness and dumps are retained and marked FAILURE.md.
The corrected probe validates argument types against the actual ABI before any device copy.
It found **520 geometry mismatches in 5214 calls**, all at the surface kernels: the original caps their grid at
32 blocks, while the earlier source used 354 blocks for capacity90567. Actual step disassembly fb7cf..fb7ea
and nine capacity probes establish min(ceil(capacity/256),32). The original full capacity stays in the view;
the kernels must continue processing all contacts through their grid-stride loops.

An intermediate d932 host fixes this launch cap. Four operators on 8191/8192/8193/16385 actual disjoint contacts,
using identical buffers for original-runtime/original-PTX/source, give 16 exact operator/count comparisons.
The final contact changes its outputs and five trailing guard particles remain unchanged in each case.
This test is `surface-grid-stride-final/`; its CUDA code is the same f0 digest as ff34.

The capacity probe also exposed missing default shape tiling. Actual step fb621..fb638 and101020 establish:
only when there is one world and shape_replicated_count is zero, use shape_count. Explicit nonzero tiles and
multiworld shared zero tiles stay as supplied. ff34 applies this to rigid, rolling, hard, legacy-soft and surface
views, as the original's shared step variable does. Nine capacities now match all 351 launch parameters/geometry
and 162 state arrays. Six static W1/W2/W3 tile cases and four body Newton/PD soft/hard cases match 25224 calls
and 168 state arrays, with real rigid contacts and an explicitly unspecified single-world tile.

ff34 official recheck adopts the **exact original8 files** from cc, checks their SHA/fixture/harness identity,
and records three new source trajectories for each mode. All six source workers pass 60-frame physical checks,
but both fixed-C cohorts still fail. Original samples are not expanded and first source candidates are retained.
The ff first-buffer probe now matches all **5214 complete owned ABI/geometry records**. Before the first surface
force all captured defined arrays match; its output still differs. Actual first counts are rigid17/surface1380.

`official-inputs-original/` and `official-inputs-source/` capture only initialized 1380-contact packets.
Their full contact-record multisets, scalar view metadata and all read-only arrays match; record order differs.
The initial RHS also matches. On the original packet,
actual original runtime, original PTX and source give identical isolated-contact outputs. The original/source PTX
trace gives all **37920 actual atomic operands** equal per thread. Initial random sum witnesses missed five target
scalars; the CPU completion preserves those failures and searches exact addition orders, including exhaustive
subset states for small nonzero operand sets. `official-force-common-inputs/exact-witness-final.json` now validates
all 5205 scalars in each of seven target outputs, including actual original and source captures: 36435 exact
scalar certificates. The partial reports remain unchanged. These are valid sum orders, not inferred hardware
execution orders or a proof that an entire GPU interleaving has been recovered.
This local diagnostic never replaces the frozen 60-frame candidates or accepts their still-failed criterion C.

The old graph audit gap is now checked on one real original/frozen8f diagnostic pair:
all 215 kernel parameters (212 native + three Warp nodes), 21 copies and 30 clears match under pointer-alias
normalization. All 26 captured post-step Warp arrays match. Allocation-relative offsets are not covered and
post-step values are not prelaunch-input evidence. The original fixed8f failed source0 is still unaccepted.

Current ff evidence is `validation-ff34e6a1/`; the independent final serial queue is complete in `full-validation/`.

| Current ff check | Result |
| --- | --- |
| Four actual 45-contact operators | Pointwise and true atomic operand sequences identical; all scalar witnesses complete |
| Original eight surface fixtures | 5/8 strict; all eight ABI/coverage match |
| Surface eager/graph60 | 21/32 strict |
| Earlier cloth eager/graph60 | 30/32 strict |
| Surface fixed3/8 cohort | 10/16 criterion C; **failed** |
| Earlier cloth fixed3/8 cohort | 13/16 criterion C; **failed** |
| Surface initcheck3 / actual large demo initcheck3 | Both zero errors |
| Config contract | 246 checks matched |
| Regression74 | 71 strict; first three particle failures pass fixed C10, with CPU re-audit |
| Official cloth_balls, six current source runs | 60-frame physical checks pass; both fixed-C mode cohorts **fail** |

The current small force replay initially missed one instrumented-output scalar in its random witness search;
`full-validation/kernel-force/exact-witness-completion.json` completes it exactly without another GPU run.
The old25 seed2 failed C10 and old8f failed source0 remain archived. New-image C results do not explain those
earlier candidates. The new Warp probe likewise differs from the frozen8f failed trajectory at its first step.
Other body/constraint/material combinations remain guarded; `solver_api_ready=False`.

Next agent: start from the current failed cohort reports and their frozen NPZ, identify the earliest outside-C
step, then audit the actual live inputs and non-atomic stages. A new probe that does not reproduce source0 is
diagnostic evidence only. Do not change arithmetic or thresholds to force a cohort pass. The isolated 220-byte
layout trial is still experimental; if pursued, first inspect actual PTX/SASS and validate its complete scope.
Independent original holdouts against the same fixed baseline can diagnose C sensitivity, but must not be added
to that baseline or used to reclassify its saved failures. No such holdouts were collected in this checkpoint.

Original 8f and intermediate 814 source/build inputs and binaries were copied into separately hashed checkpoints
before changes. Future changes must preserve them and keep the processed reference binary unchanged.

## Reproducible diagnostic commands

These commands create independent outputs; never reuse an existing result folder or replace a failed source0.
All GPU commands must run serially. The C10 audit is CPU-only and must reproduce the saved failure.

```bash
source scripts/reconstruction_env.sh
recon_case_root=build/reconstruction-csrc/affine-particle-material-host

.venv/bin/python -m reconstruction.csrc.audit_regression_fixed_spread \
  --cohort "$recon_case_root/validation-25ecf6f4/regression-fixed-C10" \
  --output "$recon_case_root/NEW-C10-audit.json"

.venv/bin/python -m reconstruction.csrc.host_particles_ab --seed 2 \
  --trace-case n257_w1_it1_f0 --trace-label diagnostic-one-pair \
  --output "$recon_case_root/NEW-particles-seed2-trace"
# The last command returns 1 when strict differences exist; preserve its arrays and logs.

.venv/bin/python -m reconstruction.csrc.prepare_surface_layout_trial \
  --output "$recon_case_root/NEW-struct220"
.venv/bin/python -m reconstruction.csrc.surface_layout_branch_ab \
  --trial "$recon_case_root/NEW-struct220/surface_struct220_trial.ptx" \
  --output "$recon_case_root/NEW-struct220-branches"

# Capture the next combination from the real original before enabling any additional source scope.
.venv/bin/python -m reconstruction.csrc.affine_surface_rolling_ab --backend original \
  --output "$recon_case_root/NEW-rolling-original8"
.venv/bin/python -m reconstruction.csrc.affine_surface_rolling_ab --backend source \
  --references "$recon_case_root/NEW-rolling-original8" \
  --output "$recon_case_root/NEW-rolling-source8"
```

Current ff34 results can be inspected or reproduced independently with the following commands. The existing
`full-validation/status.json` is complete, including nonzero exits for strict differences. Completion does not
mean every comparison passed. The current C10 CPU audit expects all three cases within C; the old25 command
above expects its saved seed2 failure. New GPU diagnostics are separate samples and must not replace saved NPZ.

```bash
source scripts/reconstruction_env.sh
recon_case_root=build/reconstruction-csrc/affine-particle-material-host
recon_current="$recon_case_root/validation-ff34e6a1"

# CPU-only: reproduce the current three fixed particle C10 results.
.venv/bin/python -m reconstruction.csrc.audit_regression_fixed_spread \
  --cohort "$recon_current/regression-fixed-C10" --report report.json \
  --output "$recon_case_root/NEW-ff34-C10-audit.json"

# Same original8 files as the saved cc cohort; only collect three source workers in each mode.
.venv/bin/python -m reconstruction.csrc.official_cloth_balls_recheck \
  --baseline "$recon_case_root/validation-cc09a3c0/official-cloth-balls60" \
  --output "$recon_case_root/NEW-official-recheck"

# CPU-only: revalidate saved exact scalar sum certificates, including the actual source capture.
.venv/bin/python -m reconstruction.csrc.surface_sum_witness_completion \
  --replay "$recon_current/official-force-common-inputs" \
  --capture "$recon_current/official-inputs-original" \
  --source-capture "$recon_current/official-inputs-source" \
  --resume "$recon_current/official-force-common-inputs/exact-witness-final.json" \
  --output "$recon_case_root/NEW-exact-witness-audit.json"

# Optional new diagnostic pair. Load the frozen8f only in this worker; keep the active ff34 image untouched.
.venv/bin/python -m reconstruction.csrc.late_cloth_warp_probe --backend original \
  --output "$recon_case_root/NEW-old8-warp-original"
.venv/bin/python -m reconstruction.csrc.late_cloth_warp_probe --backend source \
  --source-checkpoint build/reconstruction-checkpoints/body-surface-before-8fb9d2ee \
  --output "$recon_case_root/NEW-old8-warp-source"
.venv/bin/python -m reconstruction.csrc.cloth_snapshot_audit \
  --original "$recon_case_root/NEW-old8-warp-original" \
  --source "$recon_case_root/NEW-old8-warp-source" \
  --output "$recon_case_root/NEW-old8-graph-audit.json"
```

For the next full regression, use the earlier `affine_surface_validation` command and a new output folder.
For current surface/cloth C8, pass `--suite surface` or `--suite cloth` and the corresponding new full-validation
`surface-graph60` or `legacy-cloth-graph60` folder to `affine_graph_cohort`. It adopts the first pair verbatim and
collects the remaining fixed workers. Use `regression_fixed_spread --validation NEW-full-validation --output NEW-C10`
to collect ten originals against each first strict regression failure. A newly built image requires a new
validation directory and source hash; results listed here apply only to ff34.

The five `build/reconstruction-checkpoints/body-surface-*` folders preserve the exact 27 source/build inputs
for 8f, 814, 25, cc and d932. Each `checkpoint.json` lists hashes under `preserved-files/`.
Historical fixture hashes are byte-pinned; keep their original formatting when reproducing these captures.

`late_cloth_warp_probe.py` extends the post-download diagnostic to the previously unexamined three Warp nodes.
It queries actual parameter widths using cuFuncGetParamInfo, preserves raw arguments, masks only documented
struct padding for comparison, and snapshots initialized array storage after the existing download.
Post-step arrays must not be described as prelaunch inputs. A frozen source checkpoint may be loaded in that
diagnostic worker only, without overwriting the active source image. Its results and limits must be recorded
before claiming that the old graph audit gap has been closed.
