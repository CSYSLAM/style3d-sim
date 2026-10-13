"""Demonstrate native Span ownership with a small constant-velocity scene."""

import getpass

import numpy as np
import warp as wp

import synreal_solver as sr


def span(array: wp.array) -> sr.Span:
    return sr.Span(ptr=array.ptr, size=array.size)


def main() -> None:
    wp.init()
    if not wp.is_cuda_available():
        raise RuntimeError("This sample requires CUDA")
    if not sr.is_logged_in():
        if not sr.login(input("SynReal account: ").strip(), getpass.getpass("Password: "), False):
            raise RuntimeError("SynReal login failed")

    device = wp.get_device("cuda:0")
    indices = wp.array([0, 1], dtype=wp.int32, device=device)
    masses = wp.array([1.0, 1.0], dtype=wp.float32, device=device)
    gravity = wp.array([[0.0, 0.0, 0.0]], dtype=wp.vec3, device=device)
    positions = wp.array([[0.0, 0.0, 1.0], [1.0, 0.0, 1.0]], dtype=wp.vec3, device=device)
    velocities = wp.array([[0.1, 0.0, 0.0], [0.1, 0.0, 0.0]], dtype=wp.vec3, device=device)
    next_positions = wp.clone(positions)
    next_velocities = wp.clone(velocities)

    model = sr.Model()
    model.particle_count = 2
    model.particle_indices = span(indices)
    model.particle_masses = span(masses)
    model.world_count = 1
    model.gravity = span(gravity)
    state, following = sr.State(), sr.State()
    state.particle_q, state.particle_qd = span(positions), span(velocities)
    following.particle_q, following.particle_qd = span(next_positions), span(next_velocities)
    solver = sr.Solver()
    solver.initialize(model)
    stream = wp.get_stream(device)

    # Keep all Warp allocations alive until asynchronous native work completes.
    for _ in range(60):
        solver.step(state, following, 1.0 / 60.0, stream)
        state, following = following, state
    wp.synchronize()
    assert np.isfinite(positions.numpy()).all()
    print("Native simulation completed")


if __name__ == "__main__":
    main()
