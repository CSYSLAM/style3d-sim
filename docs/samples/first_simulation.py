"""Run a small headless Newton scene through SynReal."""

import numpy as np
import newton
import warp as wp

import style3d_sim as s3d


def main() -> None:
    wp.init()
    if not wp.is_cuda_available():
        raise RuntimeError("This sample requires a CUDA-capable device")

    builder = s3d.ModelBuilder(up_axis=newton.Axis.Z)
    builder.add_ground_plane()
    builder.add_particle(pos=(0.0, 0.0, 1.0), vel=(0.0, 0.0, 0.0), mass=1.0, radius=0.05)
    model = builder.finalize(device="cuda:0")
    solver = s3d.NewtonSolver(model)
    solver.config.nonlinear_solver = s3d.NonlinearSolver.NEWTON
    solver.config.nonlinear_iterations = 4
    solver.config.linear_iterations = 50

    # Allocate states after the solver has finalized any affine particle proxies.
    state, following = model.state(), model.state()
    control = model.control()
    pipeline = newton.CollisionPipeline(model)
    contacts = pipeline.contacts()
    frame_dt = 1.0 / 60.0
    substeps = 4
    dt = frame_dt / substeps

    for frame in range(120):
        for _ in range(substeps):
            state.clear_forces()
            pipeline.collide(state, contacts)
            solver.step(state, following, control, contacts, dt)
            state, following = following, state
        if frame % 30 == 0:
            position = state.particle_q.numpy()[0]
            print(f"t={(frame + 1) * frame_dt:.3f}s, particle position={position}")

    wp.synchronize()
    assert np.isfinite(state.particle_q.numpy()).all(), "Non-finite particle position"
    print("Simulation completed: 120 frames")


if __name__ == "__main__":
    main()
