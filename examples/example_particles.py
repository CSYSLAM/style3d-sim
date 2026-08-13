"""Simulate free Newton particles with Synreal Solver and display them in ViewerGL."""

import newton
import warp as wp
from newton.viewer import ViewerGL

import synreal_solver


PARTICLE_DIMENSIONS = (6, 6, 6)
PARTICLE_MASS = 1.0
PARTICLE_RADIUS = 0.06
PARTICLE_SPACING = 0.18
FRAME_DT = 1.0 / 60.0


def as_span(array: wp.array | None) -> synreal_solver.Span:
    """Create a non-owning Synreal span for a Warp device array."""
    if array is None:
        return synreal_solver.Span()

    return synreal_solver.Span(ptr=array.ptr, size=array.size)


def build_newton_model(device: wp.Device) -> newton.Model:
    """Create a Newton model containing a regular block of free particles."""
    builder = newton.ModelBuilder(up_axis=newton.Axis.Z)
    width, depth, height = PARTICLE_DIMENSIONS

    for z in range(height):
        for y in range(depth):
            for x in range(width):
                builder.add_particle(
                    pos=(
                        (x - 0.5 * (width - 1)) * PARTICLE_SPACING,
                        (y - 0.5 * (depth - 1)) * PARTICLE_SPACING,
                        1.0 + z * PARTICLE_SPACING,
                    ),
                    vel=(0.0, 0.0, 0.0),
                    mass=PARTICLE_MASS,
                    radius=PARTICLE_RADIUS,
                )

    return builder.finalize(device=device)


def build_synreal_model(
    newton_model: newton.Model,
    particle_indices: wp.array,
) -> synreal_solver.Model:
    """Create a Synreal model that views the Newton model's device arrays."""
    model = synreal_solver.Model()
    model.particle_count = newton_model.particle_count
    model.particle_indices = as_span(particle_indices)
    model.particle_masses = as_span(newton_model.particle_mass)
    return model


def build_synreal_state(newton_state: newton.State) -> synreal_solver.State:
    """Create a Synreal state that views a Newton state's device arrays."""
    state = synreal_solver.State()
    state.particle_q = as_span(newton_state.particle_q)
    state.particle_qd = as_span(newton_state.particle_qd)
    return state


def main() -> None:
    """Build the shared models, run Synreal Solver, and display the result."""
    if not wp.is_cuda_available():
        raise RuntimeError("This example requires a CUDA-capable device.")

    device = wp.get_device("cuda:0")
    newton_model = build_newton_model(device)

    # Synreal needs an explicit particle index array. Keep it alive because the
    # Synreal model stores only a non-owning view of its CUDA allocation.
    particle_indices = wp.array(
        list(range(newton_model.particle_count)),
        dtype=wp.int32,
        device=device,
    )
    model = build_synreal_model(newton_model, particle_indices)

    newton_state_0 = newton_model.state()
    newton_state_1 = newton_model.state()
    state_0 = build_synreal_state(newton_state_0)
    state_1 = build_synreal_state(newton_state_1)

    solver = synreal_solver.Solver()
    solver.initialize(model)

    viewer = ViewerGL()
    viewer.show_particles = True
    viewer.set_model(newton_model)
    sim_time = 0.0

    try:
        while viewer.is_running():
            if viewer.should_step():
                solver.step(state_0, state_1, FRAME_DT, wp.get_stream(device))
                state_0, state_1 = state_1, state_0
                newton_state_0, newton_state_1 = newton_state_1, newton_state_0
                sim_time += FRAME_DT

            viewer.begin_frame(sim_time)
            viewer.log_state(newton_state_0)
            viewer.end_frame()
    finally:
        viewer.close()


if __name__ == "__main__":
    main()
