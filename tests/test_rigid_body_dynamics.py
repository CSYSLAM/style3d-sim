import numpy as np
import pytest

wp = pytest.importorskip("warp")

from synreal_solver.rigid_body_dynamics import (  # noqa: E402
    integrate_rigid_body,
    recover_rigid_body_end_velocity,
)


INTEGRATORS = (
    pytest.param(0, id="explicit-euler"),
    pytest.param(1, id="implicit-euler"),
    pytest.param(2, id="lie-group-midpoint"),
    pytest.param(3, id="midpoint-cayley"),
)


@wp.kernel
def _integrate_and_recover(
    inertia: wp.array(dtype=wp.mat33),
    angular_momentum: wp.array(dtype=wp.vec3),
    dt: float,
    integrator: int,
    next_angular_momentum: wp.array(dtype=wp.vec3),
    relative_rotation: wp.array(dtype=wp.mat33),
    recovered_end_velocity: wp.array(dtype=wp.vec3),
):
    next_momentum, rotation = integrate_rigid_body(
        inertia[0],
        angular_momentum[0],
        dt,
        integrator,
    )
    next_angular_momentum[0] = next_momentum
    relative_rotation[0] = rotation
    recovered_end_velocity[0] = recover_rigid_body_end_velocity(
        inertia[0],
        rotation,
        dt,
        integrator,
    )


def _run_step(
    inertia: np.ndarray,
    angular_velocity: np.ndarray,
    dt: float,
    integrator: int,
    device: str,
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    initial_momentum = inertia @ angular_velocity
    inertia_wp = wp.array((wp.mat33(inertia),), dtype=wp.mat33, device=device)
    momentum_wp = wp.array((wp.vec3(*initial_momentum),), dtype=wp.vec3, device=device)
    next_momentum_wp = wp.empty(1, dtype=wp.vec3, device=device)
    rotation_wp = wp.empty(1, dtype=wp.mat33, device=device)
    recovered_velocity_wp = wp.empty(1, dtype=wp.vec3, device=device)

    wp.launch(
        _integrate_and_recover,
        dim=1,
        inputs=[inertia_wp, momentum_wp, dt, integrator],
        outputs=[next_momentum_wp, rotation_wp, recovered_velocity_wp],
        device=device,
    )
    wp.synchronize_device(device)
    return (
        next_momentum_wp.numpy()[0],
        rotation_wp.numpy()[0],
        recovered_velocity_wp.numpy()[0],
    )


@pytest.mark.parametrize("integrator", INTEGRATORS)
@pytest.mark.parametrize(
    "device",
    (
        "cpu",
        pytest.param(
            "cuda:0",
            marks=pytest.mark.skipif(
                not wp.is_cuda_available(), reason="CUDA unavailable"
            ),
        ),
    ),
)
def test_inertia_mode_equations_and_endpoint_recovery(
    integrator: int,
    device: str,
) -> None:
    inertia = np.array(
        ((1.7, 0.3, -0.2), (0.3, 2.4, 0.4), (-0.2, 0.4, 3.1)),
        dtype=np.float32,
    )
    initial_velocity = np.array((0.7, 1.3, -0.4), dtype=np.float32)
    initial_momentum = inertia @ initial_velocity
    dt = 0.02

    next_momentum, rotation, recovered_velocity = _run_step(
        inertia,
        initial_velocity,
        dt,
        integrator,
        device,
    )
    next_velocity = np.linalg.solve(inertia, next_momentum)

    assert np.allclose(rotation.T @ rotation, np.eye(3), atol=2.0e-6)
    assert np.isclose(np.linalg.det(rotation), 1.0, atol=2.0e-6)
    assert np.allclose(recovered_velocity, next_velocity, atol=2.0e-5)

    if integrator == 0:
        expected = initial_momentum + dt * np.cross(initial_momentum, initial_velocity)
        assert np.allclose(next_momentum, expected, atol=2.0e-6)
    elif integrator == 1:
        residual = (
            next_momentum
            - initial_momentum
            - dt * np.cross(next_momentum, next_velocity)
        )
        assert np.linalg.norm(residual) < 2.0e-6
    elif integrator == 2:
        assert np.allclose(
            rotation @ next_momentum,
            initial_momentum,
            atol=2.0e-6,
        )
    else:
        initial_energy = 0.5 * initial_velocity @ initial_momentum
        next_energy = 0.5 * next_velocity @ next_momentum
        assert np.allclose(
            rotation @ next_momentum,
            initial_momentum,
            atol=2.0e-6,
        )
        assert np.isclose(next_energy, initial_energy, rtol=2.0e-6)


@pytest.mark.parametrize("integrator", INTEGRATORS)
def test_principal_axis_rotation_is_exact(integrator: int) -> None:
    inertia = np.diag((1.0, 2.0, 3.0)).astype(np.float32)
    initial_velocity = np.array((0.0, 0.0, 4.0), dtype=np.float32)
    dt = 0.05

    next_momentum, rotation, recovered_velocity = _run_step(
        inertia,
        initial_velocity,
        dt,
        integrator,
        "cpu",
    )
    expected_rotation = np.array(
        (
            (np.cos(0.2), -np.sin(0.2), 0.0),
            (np.sin(0.2), np.cos(0.2), 0.0),
            (0.0, 0.0, 1.0),
        ),
        dtype=np.float32,
    )
    if integrator == 3:
        cayley_angle = 2.0 * np.arctan(0.5 * dt * initial_velocity[2])
        expected_rotation = np.array(
            (
                (np.cos(cayley_angle), -np.sin(cayley_angle), 0.0),
                (np.sin(cayley_angle), np.cos(cayley_angle), 0.0),
                (0.0, 0.0, 1.0),
            ),
            dtype=np.float32,
        )

    assert np.allclose(next_momentum, inertia @ initial_velocity, atol=2.0e-6)
    assert np.allclose(rotation, expected_rotation, atol=2.0e-6)
    assert np.allclose(recovered_velocity, initial_velocity, atol=2.0e-6)


@pytest.mark.parametrize("integrator", INTEGRATORS[:3])
def test_exponential_methods_use_step_angle_for_small_velocity(integrator: int) -> None:
    inertia = np.diag((1.0, 2.0, 3.0)).astype(np.float32)
    initial_velocity = np.array((0.0, 0.0, 1.0e-9), dtype=np.float32)
    dt = 1.0e9

    _, rotation, recovered_velocity = _run_step(
        inertia,
        initial_velocity,
        dt,
        integrator,
        "cpu",
    )
    expected_rotation = np.array(
        (
            (np.cos(1.0), -np.sin(1.0), 0.0),
            (np.sin(1.0), np.cos(1.0), 0.0),
            (0.0, 0.0, 1.0),
        ),
        dtype=np.float32,
    )

    assert np.allclose(rotation, expected_rotation, atol=2.0e-6)
    assert np.allclose(recovered_velocity, initial_velocity, rtol=2.0e-6, atol=1.0e-12)
