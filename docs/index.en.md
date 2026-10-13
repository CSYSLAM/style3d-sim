# SynReal Solver Documentation

SynReal Solver is a CUDA implicit physics library with a Python adapter for Newton Physics.
These guides take you from environment setup, native builds, and authentication to particles,
rigid bodies, cloth, deformable bodies, and material configuration.

## Demo Showcase

<div class="demo-grid" markdown="1">
<figure markdown="1">

![G1 humanoid on deformable jelly blocks](images/g1_jelly_drop_demo.png)

<figcaption>G1 Jelly Drop · Rigid body contact with tetrahedral soft bodies</figcaption>
</figure>
<figure markdown="1">

![Piper arm carrying a deformable bag](images/piper_scene_demo.png)

<figcaption>Piper Bag Transport · Robotic manipulation of a cloth bag</figcaption>
</figure>
</div>

See [Demos and Rendering](guides/demos.en.md) to run these scenes.
The images are offline renders; the appearance in a real-time viewer may differ.

## Where to Start

| Your goal | Reading order |
| --- | --- |
| First time using the library | [Install][install], [authenticate][auth], then [run your first simulation][first] |
| Integrate an existing Newton project | [Simulation loop](guides/simulation-loop.en.md), then [rigid bodies][rigid] |
| Simulate cloth or soft bodies | [Cloth and tetrahedral bodies](guides/deformables.en.md) |
| Simulate fluids, grains, or fracture | [Particle materials](guides/particles.en.md) |
| Improve speed and stability | [Configuration and performance](guides/configuration.en.md) |
| Find API signatures | [API overview](reference/index.en.md) |

[install]: getting-started/installation.en.md
[auth]: getting-started/authentication.en.md
[first]: getting-started/first-simulation.en.md
[rigid]: guides/rigid-bodies.en.md

## Three Core Concepts

**Newton builds the scene.** `ModelBuilder` defines particles, rigid bodies, joints, and collision shapes;
`model.state()` creates state buffers.

**SynReal advances physics.** `NewtonSolver.step()` accepts Newton states, controls, and contacts
and performs the native CUDA solve.

**Viewers display the result.** Real-time viewers and offline rendering consume the simulation output.
Use a headless mode or a standalone simulation script when no window is needed.

!!! note "Documentation builds and simulation runs have different requirements"
    The documentation needs only Python and MkDocs and builds on a standard GitHub runner.
    Running the solver requires a compatible NVIDIA GPU, the native extension, and valid credentials.

## Supported Workflows

Common workflows include particles, tetrahedral bodies, Style3D cloth, affine rigid bodies,
contacts, joint drives, particle fluids, and bonded granular materials.
Some Newton features require additional adaptation: generic triangle elasticity must use Style3D attributes,
and `requires_grad=True` does not guarantee that the native solve is differentiable.
For adapter errors, read the relevant guide and [Troubleshooting](troubleshooting.en.md).
