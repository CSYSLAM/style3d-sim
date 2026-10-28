# Piper package transport

A Piper robot grips the loose film of two sealed parcels, lifts each parcel, shakes it with three wrist flicks,
and releases it onto the floor. The 30-second animation uses one `style3d_sim.NewtonSolver` for the robot,
both cloth bags, a rigid carton, and a tetrahedral jelly payload. Grasping uses contact with the original Piper
fingers; the parcels are not attached to the robot. Rendering reads the simulated motion cache.

## Run

Run these commands from the repository root using the existing Python environment:

```powershell
uv run --no-sync python demos/piper_package_transport/demo_piper_package_transport.py
```

`--viewer` defaults to `true`: direct execution opens Newton ViewerGL at its default window size and does not
create USD, trajectory, or run-metadata files. Bare `--viewer` and `--viewer=true` have the same behavior.
Closing the window stops the simulation. Set `--viewer=false` to record headlessly for rendering:

```powershell
uv run --no-sync python demos/piper_package_transport/demo_piper_package_transport.py --viewer=false
```

Interactive playback and render recording use the same default simulation parameters:
60 Hz with 4 substeps, 4 nonlinear iterations, and 50 PCG iterations per substep.

## Render

Blender with Cycles and an NVIDIA GPU supporting OptiX is required for the renderer. Pass `--blender` if the
executable is not on `PATH`. No dependency installation or native rebuild is performed by the workflow.

Simulate, validate, render, and encode a preview:

```powershell
uv run --no-sync python demos/piper_package_transport/workflow.py --quality preview
```

The workflow invokes the demo with `--viewer=false`, writes the USD and trajectory, then validates,
renders, and encodes them. Its default output directory is
`demos/piper_package_transport/output_wrist_flick_drop`; use `--output` to choose another directory.
Interactive runs ignore `--output` and create no recording directory.

Render an existing recording at full quality:

```powershell
uv run --no-sync python demos/piper_package_transport/workflow.py --render-only --quality final `
  --output demos/piper_package_transport/output_wrist_flick_drop
```

The input directory must contain `simulation.usdc`, `trajectory.npz`, and `run.json`. It should also contain
`piper_materials.json`; the workflow can recover the original Piper material bindings for older recordings
that lack this file. Use the same output directory as the recording, or copy these inputs to a separate one.

| Quality | Resolution | Cycles samples | Video encoding | Video filename |
| --- | --- | ---: | --- | --- |
| `preview` | 960 x 540 | 16 | H.264, CRF 20 | `piper_package_transport_preview.mp4` |
| `final` | 1920 x 1080 | 256 | H.264, CRF 16 | `piper_package_transport_final.mp4` |

Both modes output 30 fps and use OpenImageDenoise, adaptive sampling, and motion blur. Resolution and sample
budgets come from `../piper_bag_transport/render_config.json`. The workflow also saves `<quality>.blend` and
`<quality>_render.json`. Frame directories include the quality and hashes of the simulation, renderer,
material manifest, and reference assets. Rerunning a completed or interrupted render reuses matching frames.

The floor, five area lights, studio HDRI, plastic film shader, camera position and target, 30-degree horizontal
field of view, f/8 depth of field, exposure, and color transform match `demos/piper_bag_transport`.
The film uses the reference crumpled normal map, developed panel UVs, and one render subdivision level.
Normal maps and the HDRI are packed into the Blender project. Shipping labels remain on the simulated film.

The robot retains the original MJCF asset's 88 visual meshes and 11 materials. Display RGB is decoded into
linear color during USD export; normals, UVs, textures, and original finish parameters are preserved.
`material_validation.json` checks the evaluated robot materials at the first, middle, and last frames.
`render_style_validation.json` checks the reference scene, camera, packed textures, and animated film UVs.

## Scene and motion

Both payloads measure 170 x 200 x 20 mm. Each loose bag measures 230 x 280 x 38 mm and consists of two
rectangular film panels welded along their perimeter, with no box-shaped side walls. Each bag has 3,668
dynamic vertices and 7,332 triangles. The gripper closes on loose film beyond the payload edge.

| Component | Model and parameters |
| --- | --- |
| Carton | One beveled convex rigid body; density 120 kg/m^3 |
| Jelly | 495 nodes, 1,400 tetrahedra; density 450 kg/m^3; shear modulus 1,500 Pa; lambda 15,000 Pa |
| Film | Stretch stiffness `(1200, 1200, 500)`; bending stiffness `1e-7`; bending damping `2e-7` |
| Film mass | Surface density 0.1 kg/m^2 |
| Damping | Mass-proportional velocity damping of 3 s^-1 on film and jelly |

Finite-stiffness adhesion springs connect dynamic jelly and film particles. Both ends participate in simulation.

The parcels start 420 mm apart. The gripper approaches with a 70 mm opening and closes horizontally along
world X between local times 3 and 4 seconds. The nominal grip point is 30 mm above the floor and 35 mm beyond
the near payload edge. Between 4 and 7.1 seconds, the grip rises 310 mm so the entire 280 mm bag clears the floor.

From 7.5 to 10.5 seconds, the gripper executes three horizontal world-Y oscillations with a 40 mm amplitude
(80 mm total travel). Simultaneous world-X wrist pitch is centered at 25 degrees with a 15-degree amplitude.
The fingertips pitch upward on the forward stroke and downward on the return stroke. Smooth envelopes avoid
abrupt starts and stops. The two parcels use the same relative motion.

The fingers open to 70 mm between 10.5 and 10.65 seconds and retract 100 mm by 10.7 seconds, allowing the bag
to detach and fall under gravity. Landing, rebound, and settling are simulated. The second sequence starts
at global time 15.5 seconds and releases at 26 seconds. At 14 seconds, the second grip target is updated
using the jelly's measured position.

IK respects the original joint limits. The wrist rolls before approach so the local jaw axis is horizontal.
Pitch remains free during approach for reachability, then transitions to explicit tracking during the lift
so IK cannot cancel the wrist flick.

## Solver configuration

The demo uses NEWTON with 4 nonlinear and 50 PCG iterations per substep. Joint and ABD constraints use
augmented Lagrangian enforcement, one joint primal iteration, and constraint alpha 500. Full surface contact
is enabled. Particle and self-collision radii are 1.5 mm; the EF coefficient is 0.1 and VF/EE retain solver
defaults. Soft-contact search margin is 6 mm, `(ke, kd) = (2000, 1)`, and friction is 4. CCD and barrier
contacts are not used. Geometry, collision, and iteration settings are independent of render quality.

## Validation

```powershell
uv run --no-sync python -m pytest -p no:cacheprovider demos/piper_package_transport/test_geometry.py `
  demos/piper_package_transport/test_materials.py demos/piper_package_transport/test_runtime.py -q
```

Tests cover bag closure and slack, positive and conforming tetrahedra, initial containment, joint limits,
IK continuity and wrist tracking, matching three-cycle motions, horizontal finger closure, release timing,
and original materials through the MJCF-to-Newton-to-USD path. Runtime tests verify that interactive playback
does not export files and that the render workflow explicitly requests headless recording.

`validate.py` checks the full 30-second recording for finite states, ground penetration, positive tetrahedral
volumes, payload containment, shake direction and amplitude, three wrist-pitch peaks, horizontal jaw motion,
complete clearance above the floor, sustained grasping, prompt detachment, free fall, and final settling.
Clearance uses the lowest bag and payload points; free fall is checked within the release window.
Old flip-only and translation-only recordings do not satisfy the current motion contract.

The accepted travel and pitch ranges are 75-85 mm and 27-33 degrees, respectively. Each recording's
`validation.json` contains its measured results, and `run.json` records the simulation parameters used.

## Files and generated output

| Files | Purpose |
| --- | --- |
| `demo_piper_package_transport.py`, `geometry.py`, `motion.py` | Scene, geometry, and motion control |
| `export_scene.py`, `piper_materials.py` | Simulation export and original robot materials |
| `render_preview.py`, `workflow.py` | Preview/final rendering and video encoding |
| `validate.py`, `test_*.py` | Trajectory validation and regression tests |
| `run_native.py` | Run with an explicit native build without replacing the installed extension |

Generated recordings, frame sequences, Blender projects, videos, validation JSON, and logs
are local artifacts and are ignored by Git. Keep reusable source, tests, and documentation in this directory.
The completed high-quality render and its reusable simulation inputs are archived locally under
`build/piper_package_transport/final`; they are not part of the source distribution.

