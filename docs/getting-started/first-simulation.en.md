# First Simulation

Simulate a falling particle with ground contact on CUDA. This program needs no window, external models,
or textures, making it a useful first check of installation and authentication.

## 1. Check the Environment

Complete [Installation](installation.en.md) and [Authentication](authentication.en.md).
Confirm that `_core` points to the current build and `warp.is_cuda_available()` is `True`.
Run the commands below from the repository root.

## 2. Run the Complete Program

The repository includes [first_simulation.py](../samples/first_simulation.py):

```bash
uv run python docs/samples/first_simulation.py
```

Without credential variables, it first asks for your account and password.
It prints a position every 30 frames and finishes with:

```text
Simulation completed: 120 frames
```

Warp may compile kernels on the first run and reuse its cache afterwards.
Exact positions depend on configuration and version; decimal values are not a cross-version acceptance criterion.

## 3. Complete Code

```python
--8<-- "docs/samples/first_simulation.py"
```

## 4. What Each Step Does

| Step | Purpose |
| --- | --- |
| `wp.init()` | Initialize Warp and detect devices |
| `sr.ModelBuilder()` | Prepare scene objects and contact materials |
| `add_particle()` | Set position, velocity, mass, and contact radius |
| `finalize(device="cuda:0")` | Allocate the model on the GPU |
| `sr.NewtonSolver(model)` | Authenticate and initialize the adapter |
| Two calls to `model.state()` | Create input and output buffers |
| `CollisionPipeline` | Generate contacts between particles and shapes |
| `step()` | Advance one substep using those contacts |
| Swap the states | Use the latest output as the next input |

The frame rate is 60 Hz with four substeps per frame, so `step()` receives `dt=1/240` seconds.
Collision detection runs on every substep to generate ground contacts from the current state.

## 5. Open a Viewer

Try the existing rigid body scene:

```bash
uv run python examples/example_basic_shapes.py --solver synreal --device cuda:0
```

These examples need the `examples` extra and a graphical environment; some assets download on first use.
Without a display, continue with this page's script or use `--viewer null` where supported.

## 6. Next Steps

Change the initial height, radius, and substep count to observe the landing behavior.
Then read [Models, States, and Simulation Loop](../guides/simulation-loop.en.md)
to add a viewer, apply forces, and reset the scene.
