"""Compare rigid-body midpoint updates and verify the production Warp path.

The energy--momentum checks launch kernels that call the same ``@wp.func``
implementation as ``NewtonSolver``. The NumPy routines are independent
references used only to expose the difference between methods and numerical
precisions.
"""

from __future__ import annotations

# ``I`` is used deliberately as the conventional symbol for rotational inertia.
# ruff: noqa: E741

import numpy as np
import warp as wp

from synreal_solver.rigid_body_dynamics import (
    cayley_increment_from_midpoint,
    recover_midpoint_cayley_end_velocity,
    solve_energy_momentum_midpoint,
)


@wp.kernel
def _shared_energy_momentum_step_kernel(
    inertia: wp.array(dtype=wp.mat33),
    angular_velocity: wp.array(dtype=wp.vec3),
    dt: float,
    relative_rotation: wp.array(dtype=wp.mat33),
    next_angular_velocity: wp.array(dtype=wp.vec3),
    recovered_angular_velocity: wp.array(dtype=wp.vec3),
):
    """Call the same Warp functions used by ``NewtonSolver`` for one step."""
    I = inertia[0]
    inverse_I = wp.inverse(I)
    initial_angular_momentum = I * angular_velocity[0]
    (
        next_angular_momentum,
        midpoint_angular_momentum,
        midpoint_angular_velocity,
    ) = solve_energy_momentum_midpoint(I, initial_angular_momentum, dt)
    dR = cayley_increment_from_midpoint(midpoint_angular_velocity, dt)
    relative_rotation[0] = dR
    next_angular_velocity[0] = inverse_I * next_angular_momentum
    recovered_angular_velocity[0] = recover_midpoint_cayley_end_velocity(I, dR, dt)


@wp.kernel
def _shared_energy_momentum_trajectory_kernel(
    inertia: wp.array(dtype=wp.mat33),
    initial_angular_velocity: wp.array(dtype=wp.vec3),
    dt: float,
    steps: int,
    invariant_errors: wp.array(dtype=wp.vec4),
    max_inverse_error: wp.array(dtype=float),
):
    """Measure long-term invariants of the production Warp implementation."""
    I = inertia[0]
    inverse_I = wp.inverse(I)
    rotation = wp.identity(3, dtype=float)
    angular_momentum = I * initial_angular_velocity[0]
    initial_world_angular_momentum = angular_momentum
    initial_momentum_norm = wp.length(initial_world_angular_momentum)
    initial_energy = 0.5 * wp.dot(initial_angular_velocity[0], angular_momentum)
    maximum_momentum_error = float(0.0)
    maximum_energy_error = float(0.0)
    maximum_inverse_error = float(0.0)
    final_momentum_error = float(0.0)
    final_energy_error = float(0.0)

    for _ in range(steps):
        (
            next_angular_momentum,
            midpoint_angular_momentum,
            midpoint_angular_velocity,
        ) = solve_energy_momentum_midpoint(I, angular_momentum, dt)
        relative_rotation = cayley_increment_from_midpoint(
            midpoint_angular_velocity, dt
        )
        recovered_velocity = recover_midpoint_cayley_end_velocity(
            I, relative_rotation, dt
        )
        next_velocity = inverse_I * next_angular_momentum
        inverse_error = wp.length(recovered_velocity - next_velocity) / (
            1.0 + wp.length(next_velocity)
        )
        if inverse_error > maximum_inverse_error:
            maximum_inverse_error = inverse_error

        rotation = rotation * relative_rotation
        angular_momentum = next_angular_momentum
        world_angular_momentum = rotation * angular_momentum
        energy = 0.5 * wp.dot(next_velocity, angular_momentum)
        final_momentum_error = (
            wp.length(world_angular_momentum - initial_world_angular_momentum)
            / initial_momentum_norm
        )
        final_energy_error = wp.abs(energy - initial_energy) / wp.abs(initial_energy)
        if final_momentum_error > maximum_momentum_error:
            maximum_momentum_error = final_momentum_error
        if final_energy_error > maximum_energy_error:
            maximum_energy_error = final_energy_error

    invariant_errors[0] = wp.vec4(
        final_momentum_error,
        maximum_momentum_error,
        final_energy_error,
        maximum_energy_error,
    )
    max_inverse_error[0] = maximum_inverse_error


def _resolve_dtype(dtype: type[np.floating]) -> np.dtype:
    """Accept only the two floating-point precisions used by this check."""
    resolved = np.dtype(dtype)
    if resolved not in (np.dtype(np.float32), np.dtype(np.float64)):
        raise ValueError("dtype must be np.float32 or np.float64.")
    return resolved


def _skew(v: np.ndarray, dtype: np.dtype) -> np.ndarray:
    """Return the cross-product matrix [v]_x."""
    x, y, z = np.asarray(v, dtype=dtype)
    return np.array([[0.0, -z, y], [z, 0.0, -x], [-y, x, 0.0]], dtype=dtype)


def _so3_exp(rotvec: np.ndarray, dtype: np.dtype) -> np.ndarray:
    """SO(3) exponential map from a rotation vector to a rotation matrix."""
    rotvec = np.asarray(rotvec, dtype=dtype)
    scalar = dtype.type
    theta = scalar(np.linalg.norm(rotvec))
    K = _skew(rotvec, dtype)
    small_angle = scalar(np.sqrt(np.finfo(dtype).eps))

    if theta < small_angle:
        # Stable Taylor expansions of sin(theta)/theta and
        # (1-cos(theta))/theta^2.
        theta2 = theta * theta
        a = scalar(1.0) - theta2 / scalar(6.0) + theta2 * theta2 / scalar(120.0)
        b = scalar(0.5) - theta2 / scalar(24.0) + theta2 * theta2 / scalar(720.0)
    else:
        a = np.sin(theta) / theta
        b = (scalar(1.0) - np.cos(theta)) / (theta * theta)

    return np.asarray(np.eye(3, dtype=dtype) + a * K + b * (K @ K), dtype=dtype)


def _so3_log(R: np.ndarray, dtype: np.dtype) -> np.ndarray:
    """Principal SO(3) logarithm as a rotation vector (angle in [0, pi))."""
    R = np.asarray(R, dtype=dtype)
    scalar = dtype.type
    cos_theta = scalar(
        np.clip(
            (np.trace(R) - scalar(1.0)) * scalar(0.5),
            scalar(-1.0),
            scalar(1.0),
        )
    )
    theta = scalar(np.arccos(cos_theta))
    vee = np.array(
        [R[2, 1] - R[1, 2], R[0, 2] - R[2, 0], R[1, 0] - R[0, 1]],
        dtype=dtype,
    )
    angular_tolerance = scalar(np.sqrt(np.finfo(dtype).eps))

    if theta < angular_tolerance:
        return scalar(0.5) * vee
    if scalar(np.pi) - theta < angular_tolerance:
        raise ValueError("The inverse is ambiguous when the step angle is pi.")
    return np.asarray((theta / (scalar(2.0) * np.sin(theta))) * vee, dtype=dtype)


def _check_inertia(I: np.ndarray, dtype: np.dtype) -> np.ndarray:
    """Validate and return a symmetric positive-definite inertia tensor."""
    I = np.asarray(I, dtype=dtype)
    tolerance = 32.0 * np.finfo(dtype).eps
    if I.shape != (3, 3):
        raise ValueError("I must have shape (3, 3).")
    if not np.allclose(I, I.T, atol=tolerance, rtol=0.0):
        raise ValueError("I must be symmetric.")
    if np.min(np.linalg.eigvalsh(I)) <= 0.0:
        raise ValueError("I must be positive definite.")
    return I


def lie_group_midpoint_forward(
    I: np.ndarray,
    w: np.ndarray,
    dt: float = 1.0,
    *,
    max_iterations: int = 100,
    tolerance: float | None = None,
    report_iterations: bool = True,
    dtype: type[np.floating] = np.float64,
) -> np.ndarray:
    """Compute dR from inertia ``I`` and the initial angular velocity ``w``.

    The force-free world angular momentum L = I w is held fixed.  The midpoint
    angular velocity satisfies

        w_mid = R_mid I^{-1} R_mid^T L,
        R_mid = Exp(0.5 dt [w_mid]_x).

    The returned relative rotation is dR = Exp(dt [w_mid]_x).
    """
    dtype = _resolve_dtype(dtype)
    I = _check_inertia(I, dtype)
    w = np.asarray(w, dtype=dtype)
    scalar = dtype.type
    if tolerance is None:
        tolerance = 32.0 * np.finfo(dtype).eps
    if w.shape != (3,):
        raise ValueError("w must have shape (3,).")
    if not np.isfinite(dt) or dt <= 0.0:
        raise ValueError("dt must be positive and finite.")

    L = I @ w
    w_mid = w.copy()
    for iter in range(max_iterations):
        R_mid = _so3_exp(scalar(0.5 * dt) * w_mid, dtype)
        w_next = R_mid @ np.linalg.solve(I, R_mid.T @ L)
        if np.linalg.norm(w_next - w_mid) <= tolerance * (1.0 + np.linalg.norm(w_next)):
            w_mid = w_next
            if report_iterations:
                print(f"iteration: {iter}")
            break
        w_mid = w_next
    else:
        raise RuntimeError("Lie-group midpoint fixed-point iteration did not converge.")

    return _so3_exp(scalar(dt) * w_mid, dtype)


def _cayley(A: np.ndarray, dtype: np.dtype) -> np.ndarray:
    """Return cay(A) = (I - A/2)^(-1) (I + A/2)."""
    identity = np.eye(3, dtype=dtype)
    return np.linalg.solve(
        identity - dtype.type(0.5) * A,
        identity + dtype.type(0.5) * A,
    )


def energy_momentum_midpoint_cayley_step(
    I: np.ndarray,
    w: np.ndarray,
    dt: float = 1.0,
    *,
    max_iterations: int = 20,
    tolerance: float | None = None,
    dtype: type[np.floating] = np.float64,
) -> tuple[np.ndarray, np.ndarray]:
    """Advance one force-free rigid-body step in body coordinates.

    ``I`` and ``w`` are expressed in the body frame at the beginning of the
    step.  The returned ``dR`` is the right-multiplicative increment satisfying
    ``R_next = R @ dR``; ``w_next`` is in the new body frame.  The matched
    midpoint/Cayley equations preserve spatial angular momentum and rotational
    kinetic energy to the nonlinear solve tolerance.
    """
    dtype = _resolve_dtype(dtype)
    I = _check_inertia(I, dtype)
    w = np.asarray(w, dtype=dtype)
    scalar = dtype.type
    if w.shape != (3,):
        raise ValueError("w must have shape (3,).")
    if not np.isfinite(dt) or dt <= 0.0:
        raise ValueError("dt must be positive and finite.")
    if tolerance is None:
        tolerance = 64.0 * np.finfo(dtype).eps

    I_inv = np.linalg.inv(I)
    Pi_n = I @ w
    # Explicit Euler provides only the initial guess for the 3D nonlinear
    # midpoint equation.
    Pi_next = Pi_n + scalar(dt) * np.cross(Pi_n, I_inv @ Pi_n)
    identity = np.eye(3, dtype=dtype)

    for _ in range(max_iterations):
        Pi_mid = scalar(0.5) * (Pi_n + Pi_next)
        w_mid = I_inv @ Pi_mid
        residual = Pi_next - Pi_n - scalar(dt) * np.cross(Pi_mid, w_mid)
        if np.linalg.norm(residual) <= tolerance * (1.0 + np.linalg.norm(Pi_n)):
            break

        jacobian = (
            identity
            + scalar(0.5 * dt) * _skew(w_mid, dtype)
            - scalar(0.5 * dt) * (_skew(Pi_mid, dtype) @ I_inv)
        )
        Pi_next += np.linalg.solve(jacobian, -residual)
    else:
        raise RuntimeError(
            "Energy-momentum midpoint Newton iteration did not converge."
        )

    Pi_mid = scalar(0.5) * (Pi_n + Pi_next)
    w_mid = I_inv @ Pi_mid
    dR = _cayley(scalar(dt) * _skew(w_mid, dtype), dtype)
    return np.asarray(dR, dtype=dtype), np.asarray(I_inv @ Pi_next, dtype=dtype)


def energy_momentum_midpoint_cayley_inverse(
    I: np.ndarray,
    dR: np.ndarray,
    dt: float = 1.0,
    *,
    dtype: type[np.floating] = np.float64,
) -> np.ndarray:
    """Recover the beginning-of-step body angular velocity from ``dR``.

    This is the inverse of :func:`energy_momentum_midpoint_cayley_step` for a
    Cayley increment whose rotation angle is not pi.  No nonlinear iteration
    is needed: inverse Cayley gives the midpoint angular velocity, after which
    the midpoint Euler equation gives both endpoint angular momenta.
    """
    dtype = _resolve_dtype(dtype)
    I = _check_inertia(I, dtype)
    dR = np.asarray(dR, dtype=dtype)
    scalar = dtype.type
    tolerance = 128.0 * np.finfo(dtype).eps
    if dR.shape != (3, 3):
        raise ValueError("dR must have shape (3, 3).")
    if not np.isfinite(dt) or dt <= 0.0:
        raise ValueError("dt must be positive and finite.")
    if not np.allclose(dR.T @ dR, np.eye(3, dtype=dtype), atol=tolerance, rtol=0.0):
        raise ValueError("dR must be an orthogonal rotation matrix.")
    if not np.isclose(np.linalg.det(dR), 1.0, atol=tolerance, rtol=0.0):
        raise ValueError("dR must have determinant +1.")

    identity = np.eye(3, dtype=dtype)
    if np.linalg.cond(dR + identity) >= scalar(1.0) / np.finfo(dtype).eps:
        raise ValueError("Inverse Cayley is singular for a rotation angle of pi.")

    # A = cay^{-1}(dR) = 2 (dR - I) (dR + I)^{-1}.  The transposed solve
    # evaluates the right matrix division without forming an explicit inverse.
    A = np.linalg.solve(
        (dR + identity).T,
        (scalar(2.0) * (dR - identity)).T,
    ).T
    # Remove round-off from the theoretically skew-symmetric matrix A.
    A = scalar(0.5) * (A - A.T)
    w_mid = np.array([A[2, 1], A[0, 2], A[1, 0]], dtype=dtype) / scalar(dt)

    Pi_mid = I @ w_mid
    Pi_delta = scalar(dt) * np.cross(Pi_mid, w_mid)
    Pi_n = Pi_mid - scalar(0.5) * Pi_delta
    return np.asarray(np.linalg.solve(I, Pi_n), dtype=dtype)


def shared_warp_energy_momentum_step(
    I: np.ndarray,
    w: np.ndarray,
    dt: float,
    *,
    device: str | None = None,
) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Run one step through the production ``@wp.func`` implementation."""
    selected_device = wp.get_preferred_device() if device is None else device
    inertia = wp.array(
        (wp.mat33(np.asarray(I, dtype=np.float32)),),
        dtype=wp.mat33,
        device=selected_device,
    )
    angular_velocity = wp.array(
        (wp.vec3(*np.asarray(w, dtype=np.float32)),),
        dtype=wp.vec3,
        device=selected_device,
    )
    relative_rotation = wp.empty(1, dtype=wp.mat33, device=selected_device)
    next_angular_velocity = wp.empty(1, dtype=wp.vec3, device=selected_device)
    recovered_angular_velocity = wp.empty(1, dtype=wp.vec3, device=selected_device)
    wp.launch(
        _shared_energy_momentum_step_kernel,
        dim=1,
        inputs=[inertia, angular_velocity, dt],
        outputs=[
            relative_rotation,
            next_angular_velocity,
            recovered_angular_velocity,
        ],
        device=selected_device,
    )
    wp.synchronize_device(selected_device)
    return (
        relative_rotation.numpy()[0],
        next_angular_velocity.numpy()[0],
        recovered_angular_velocity.numpy()[0],
    )


def shared_warp_long_term_invariants(
    I: np.ndarray,
    w: np.ndarray,
    dt: float,
    steps: int,
    *,
    device: str | None = None,
) -> tuple[np.ndarray, float]:
    """Run a trajectory using the shared production midpoint functions."""
    selected_device = wp.get_preferred_device() if device is None else device
    inertia = wp.array(
        (wp.mat33(np.asarray(I, dtype=np.float32)),),
        dtype=wp.mat33,
        device=selected_device,
    )
    angular_velocity = wp.array(
        (wp.vec3(*np.asarray(w, dtype=np.float32)),),
        dtype=wp.vec3,
        device=selected_device,
    )
    invariant_errors = wp.empty(1, dtype=wp.vec4, device=selected_device)
    inverse_error = wp.empty(1, dtype=float, device=selected_device)
    wp.launch(
        _shared_energy_momentum_trajectory_kernel,
        dim=1,
        inputs=[inertia, angular_velocity, dt, steps],
        outputs=[invariant_errors, inverse_error],
        device=selected_device,
    )
    wp.synchronize_device(selected_device)
    return invariant_errors.numpy()[0], float(inverse_error.numpy()[0])


def _rotation_invariants(
    I_body: np.ndarray,
    R: np.ndarray,
    w_body: np.ndarray,
) -> tuple[np.ndarray, float]:
    """Return spatial angular momentum and rotational kinetic energy."""
    Pi_body = I_body @ w_body
    angular_momentum = R @ Pi_body
    energy = 0.5 * float(w_body @ Pi_body)
    return angular_momentum, energy


def compare_long_term_invariants(
    I_body: np.ndarray,
    w_body_0: np.ndarray,
    dt: float,
    steps: int,
) -> None:
    """Compare angular-momentum and energy drift of both updates."""
    dtype = np.dtype(np.float64)
    I_body = _check_inertia(I_body, dtype)
    w_body_0 = np.asarray(w_body_0, dtype=dtype)
    R0 = np.eye(3, dtype=dtype)
    L0, E0 = _rotation_invariants(I_body, R0, w_body_0)

    # Existing method: spatial L is prescribed exactly, but energy is not an
    # invariant of the discrete rotation update.
    R_lie = R0.copy()
    lie_energy_errors = []
    lie_momentum_errors = []
    for _ in range(steps):
        I_world = R_lie @ I_body @ R_lie.T
        w_world = np.linalg.solve(I_world, L0)
        dR_world = lie_group_midpoint_forward(
            I_world,
            w_world,
            dt,
            report_iterations=False,
            dtype=np.float64,
        )
        R_lie = dR_world @ R_lie
        I_world = R_lie @ I_body @ R_lie.T
        w_world = np.linalg.solve(I_world, L0)
        L = I_world @ w_world
        E = 0.5 * float(w_world @ L)
        lie_momentum_errors.append(np.linalg.norm(L - L0) / np.linalg.norm(L0))
        lie_energy_errors.append(abs(E - E0) / abs(E0))

    # Energy-momentum method: body angular momentum and rotation increment are
    # produced by the same discrete equation.
    R_em = R0.copy()
    w_body_em = w_body_0.copy()
    em_energy_errors = []
    em_momentum_errors = []
    for _ in range(steps):
        dR_body, w_body_em = energy_momentum_midpoint_cayley_step(
            I_body, w_body_em, dt, dtype=np.float64
        )
        R_em = R_em @ dR_body
        L, E = _rotation_invariants(I_body, R_em, w_body_em)
        em_momentum_errors.append(np.linalg.norm(L - L0) / np.linalg.norm(L0))
        em_energy_errors.append(abs(E - E0) / abs(E0))

    print(f"\nlong-term invariant comparison: dt={dt}, steps={steps}")
    print(
        "method                         final |dL|/|L0|   max |dL|/|L0|"
        "   final |dE|/E0    max |dE|/E0"
    )
    print(
        "fixed-L Lie midpoint        "
        f"{lie_momentum_errors[-1]:14.6e} {max(lie_momentum_errors):14.6e}"
        f" {lie_energy_errors[-1]:14.6e} {max(lie_energy_errors):14.6e}"
    )
    print(
        "energy-momentum midpoint    "
        f"{em_momentum_errors[-1]:14.6e} {max(em_momentum_errors):14.6e}"
        f" {em_energy_errors[-1]:14.6e} {max(em_energy_errors):14.6e}"
    )


def lie_group_midpoint_inverse(
    I: np.ndarray,
    dR: np.ndarray,
    dt: float = 1.0,
    *,
    dtype: type[np.floating] = np.float64,
) -> np.ndarray:
    """Recover the initial angular velocity ``w`` from ``I`` and ``dR``.

    This is the inverse of :func:`lie_group_midpoint_forward` for a principal
    step rotation with angle smaller than pi.
    """
    dtype = _resolve_dtype(dtype)
    I = _check_inertia(I, dtype)
    dR = np.asarray(dR, dtype=dtype)
    tolerance = 64.0 * np.finfo(dtype).eps
    if dR.shape != (3, 3):
        raise ValueError("dR must have shape (3, 3).")
    if not np.isfinite(dt) or dt <= 0.0:
        raise ValueError("dt must be positive and finite.")
    if not np.allclose(dR.T @ dR, np.eye(3, dtype=dtype), atol=tolerance, rtol=0.0):
        raise ValueError("dR must be an orthogonal rotation matrix.")
    if not np.isclose(np.linalg.det(dR), 1.0, atol=tolerance, rtol=0.0):
        raise ValueError("dR must have determinant +1.")

    rotvec = _so3_log(dR, dtype)
    w_mid = rotvec / dtype.type(dt)
    R_mid = _so3_exp(dtype.type(0.5) * rotvec, dtype)

    # Recover the fixed world angular momentum, then map it back to the
    # initial angular velocity (the initial rotation is the identity here).
    L = R_mid @ I @ R_mid.T @ w_mid
    return np.linalg.solve(I, L)


def main() -> None:
    # A general symmetric positive-definite inertia tensor.  Its off-diagonal
    # entries are nonzero, so the coordinate axes are not principal axes.
    I = np.array(
        [
            [1.7, 0.3, -0.2],
            [0.3, 2.4, 0.4],
            [-0.2, 0.4, 3.1],
        ],
    )
    w = np.array([0.7, 1.3, -0.4])
    dt = 0.02

    np.set_printoptions(precision=12, suppress=True)
    for dtype in (np.float32, np.float64):
        dR = lie_group_midpoint_forward(I, w, dt, dtype=dtype)
        w_recovered = lie_group_midpoint_inverse(I, dR, dt, dtype=dtype)
        w_typed = np.asarray(w, dtype=dtype)
        comparison_tolerance = 128.0 * np.finfo(dtype).eps

        print(f"\ndtype = {np.dtype(dtype).name}")
        print("I =\n", np.asarray(I, dtype=dtype))
        print("w input       =", w_typed)
        print("dR =\n", dR)
        print("w recovered   =", w_recovered)
        print("absolute error=", np.linalg.norm(w_recovered - w_typed))
        print(
            "allclose      =",
            np.allclose(
                w_recovered,
                w_typed,
                atol=comparison_tolerance,
                rtol=comparison_tolerance,
            ),
        )

    compare_long_term_invariants(I, w, dt=dt, steps=2000)

    dR_em, w_next_em = energy_momentum_midpoint_cayley_step(I, w, dt)
    w_recovered_em = energy_momentum_midpoint_cayley_inverse(I, dR_em, dt)
    print("\nenergy-momentum midpoint-Cayley forward/inverse check")
    print("w input       =", w)
    print("w next        =", w_next_em)
    print("w recovered   =", w_recovered_em)
    print("absolute error=", np.linalg.norm(w_recovered_em - w))

    dR_warp, w_next_warp, w_recovered_warp = shared_warp_energy_momentum_step(I, w, dt)
    dR_reference, w_next_reference = energy_momentum_midpoint_cayley_step(
        I, w, dt, dtype=np.float32
    )
    print("\nshared Warp implementation versus NumPy reference")
    print("|dR_warp - dR_numpy|       =", np.linalg.norm(dR_warp - dR_reference))
    print(
        "|w_next_warp - w_next_numpy|=", np.linalg.norm(w_next_warp - w_next_reference)
    )
    print(
        "shared inverse end-w error  =", np.linalg.norm(w_recovered_warp - w_next_warp)
    )

    errors, inverse_error = shared_warp_long_term_invariants(I, w, dt=dt, steps=2000)
    print("\nshared Warp long-term check: dt=0.02, steps=2000")
    print("final |dL|/|L0| =", errors[0])
    print("max   |dL|/|L0| =", errors[1])
    print("final |dE|/E0   =", errors[2])
    print("max   |dE|/E0   =", errors[3])
    print("max inverse error=", inverse_error)


if __name__ == "__main__":
    main()
