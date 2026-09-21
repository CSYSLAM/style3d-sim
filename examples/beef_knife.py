# SPDX-FileCopyrightText: Copyright (c) 2026 The Synreal Solver Developers
# SPDX-License-Identifier: Apache-2.0

"""Rigid cleaver geometry and a force-driven cutting motion for the granular beef example."""

import newton
import numpy as np
import warp as wp

KNIFE_MASS = 8.0
KNIFE_HEIGHT = 0.34
KNIFE_LENGTH = 0.70
KNIFE_INITIAL_HEIGHT = 0.45
KNIFE_PUSH_DISTANCE = 0.10


def blade_mesh(spacing: float) -> newton.Mesh:
    """Resolve the bevel inside the lowest particle radius so cutting needs no slot in the board."""
    half_width = 0.35 * spacing
    section = np.array(
        [
            [0.0, 0.0],
            [half_width, 0.12 * spacing],
            [half_width, KNIFE_HEIGHT],
            [-half_width, KNIFE_HEIGHT],
            [-half_width, 0.12 * spacing],
        ],
        dtype=np.float32,
    )
    vertices = np.array(
        [[x, y, z] for y in (-0.5 * KNIFE_LENGTH, 0.5 * KNIFE_LENGTH) for x, z in section],
        dtype=np.float32,
    )
    faces = []
    # The section winds toward -Y. Reverse the far cap and wrap each side outward.
    for i in range(1, 4):
        faces.extend(((0, i, i + 1), (5, i + 6, i + 5)))
    for i in range(5):
        j = (i + 1) % 5
        faces.extend(((i, i + 5, j + 5), (i, j + 5, j)))
    return newton.Mesh(
        vertices,
        np.asarray(faces, dtype=np.int32).ravel(),
        compute_inertia=False,
        maxhullvert=0,
        roughness=0.25,
        metallic=0.8,
    )


def add_knife(builder, spacing: float) -> int:
    """Add a freely simulated cutting tool; all imposed motion is supplied as force and torque."""
    body = builder.add_body(
        xform=wp.transform(wp.vec3(0.0, 0.0, KNIFE_INITIAL_HEIGHT), wp.quat_identity()),
        mass=KNIFE_MASS,
        com=wp.vec3(0.0),
        inertia=wp.mat33(np.diag([0.32, 0.18, 0.22])),
        lock_inertia=True,
        label="knife",
    )
    collision = builder.default_shape_cfg.copy()
    collision.density, collision.ke, collision.kd = 0.0, 2.0e5, 40.0
    collision.mu, collision.kf = 0.1, 20.0
    # The zero-thickness edge is intentional; particle radii provide the contact surface offset.
    collision.margin = 0.0
    builder.add_shape_mesh(body, mesh=blade_mesh(spacing), cfg=collision, color=(0.68, 0.75, 0.82), label="knife_blade")
    visual = collision.copy()
    visual.has_shape_collision, visual.has_particle_collision = False, False
    builder.add_shape_box(
        body,
        xform=wp.transform(wp.vec3(0.0, 0.48, KNIFE_HEIGHT - 0.04), wp.quat_identity()),
        hx=0.032,
        hy=0.15,
        hz=0.035,
        cfg=visual,
        color=(0.16, 0.075, 0.045),
        label="knife_handle",
    )
    return body


@wp.func
def knife_target(time: float, initial_height: float, final_height: float):
    height, speed = initial_height, 0.0
    if time >= 0.5 and time < 2.5:
        u = (time - 0.5) / 2.0
        height = initial_height + (final_height - initial_height) * u * u * (3.0 - 2.0 * u)
        speed = (final_height - initial_height) * 3.0 * u * (1.0 - u)
    elif time >= 2.5 and time < 3.8:
        height = final_height
    elif time >= 3.8 and time < 4.8:
        u = time - 3.8
        height = final_height + (initial_height - final_height) * u * u * (3.0 - 2.0 * u)
        speed = (initial_height - final_height) * 6.0 * u * (1.0 - u)
    return wp.vec2(height, speed)


@wp.func
def knife_push_target(time: float):
    u = wp.clamp(time - 2.8, 0.0, 1.0)
    distance = KNIFE_PUSH_DISTANCE * u * u * (3.0 - 2.0 * u)
    speed = KNIFE_PUSH_DISTANCE * 6.0 * u * (1.0 - u)
    return wp.vec2(distance, speed)


@wp.func
def knife_tilt_sample(index: int, seed: int):
    random_state = wp.rand_init(seed, index)
    return wp.vec3(
        0.6 * wp.randf(random_state, -1.0, 1.0),
        wp.randf(random_state, -1.0, 1.0),
        0.1 * wp.randf(random_state, -1.0, 1.0),
    )


@wp.func
def knife_orientation_target(time: float, tilt_degrees: float, seed: int):
    # Smooth seeded targets make the cutting plane wander without injecting frame-rate-dependent torque noise.
    phase = wp.max(time, 0.0) / 0.7
    index = int(wp.floor(phase))
    blend = phase - float(index)
    blend = blend * blend * (3.0 - 2.0 * blend)
    ramp = wp.min(phase, 1.0)
    ramp = ramp * ramp * (3.0 - 2.0 * ramp)
    first, second = knife_tilt_sample(index, seed), knife_tilt_sample(index + 1, seed)
    angles = (first + blend * (second - first)) * (tilt_degrees * 0.017453292519943295 * ramp)
    # Keep yaw small so the knife nudges the cut face without scraping far along it.
    roll = wp.quat_from_axis_angle(wp.vec3(1.0, 0.0, 0.0), angles[0])
    lean = wp.quat_from_axis_angle(wp.vec3(0.0, 1.0, 0.0), angles[1])
    yaw = wp.quat_from_axis_angle(wp.vec3(0.0, 0.0, 1.0), angles[2])
    return yaw * lean * roll


@wp.kernel
def drive_knife(
    body_q: wp.array[wp.transform],
    body_qd: wp.array[wp.spatial_vector],
    body_f: wp.array[wp.spatial_vector],
    clock: wp.array[float],
    dt: float,
    body: int,
    mass: float,
    initial_height: float,
    final_height: float,
    enabled: wp.array[int],
    pick_body: wp.array[int],
    tilt_degrees: float,
    tilt_seed: int,
):
    pose, velocity = body_q[body], body_qd[body]
    position, rotation = wp.transform_get_translation(pose), wp.transform_get_rotation(pose)
    linear, angular = wp.spatial_top(velocity), wp.spatial_bottom(velocity)
    target = wp.vec2(initial_height, 0.0)
    push = wp.vec2(0.0, 0.0)
    if enabled[0] != 0:
        target = knife_target(clock[0] + dt, initial_height, final_height)
        push = knife_push_target(clock[0] + dt)
    force = wp.vec3(0.0, 0.0, 9.81 * mass)
    if pick_body[0] != body:
        # Backward PD gains remain well behaved as substeps change; contact reaction can still deflect the tool.
        omega = 80.0
        denominator = 1.0 + 2.0 * omega * dt + omega * omega * dt * dt
        error = wp.vec3(push[0], 0.0, target[0]) - position - dt * linear
        target_velocity = wp.vec3(push[1], 0.0, target[1])
        acceleration = (omega * omega * error + 2.0 * omega * (target_velocity - linear)) / denominator
        drive = mass * acceleration
        magnitude = wp.length(drive)
        if magnitude > 4500.0:
            drive *= 4500.0 / magnitude
        force += drive
    # Retain orientation assistance while picked so a screen-space drag can operate the cutting edge.
    target_rotation = knife_orientation_target(clock[0] + dt, tilt_degrees, tilt_seed)
    # Level the edge near the solid board while preserving the random lean of the cutting plane.
    edge = wp.quat_rotate(target_rotation, wp.vec3(0.0, 1.0, 0.0))
    edge_level = wp.quat_between_vectors(edge, wp.vec3(0.0, 1.0, 0.0))
    near_board = 1.0 - wp.clamp((target[0] - final_height) / 0.12, 0.0, 1.0)
    near_board = near_board * near_board * (3.0 - 2.0 * near_board)
    target_rotation = wp.quat_slerp(wp.quat_identity(), edge_level, near_board) * target_rotation
    rotation_delta = target_rotation * wp.quat_inverse(rotation)
    sign = 1.0
    if rotation_delta[3] < 0.0:
        sign = -1.0
    error_rotation = 2.0 * sign * wp.vec3(rotation_delta[0], rotation_delta[1], rotation_delta[2])
    torque = (2000.0 * (error_rotation - dt * angular) - 70.0 * angular) / (1.0 + 400.0 * dt)
    magnitude_torque = wp.length(torque)
    if magnitude_torque > 600.0:
        torque *= 600.0 / magnitude_torque
    body_f[body] = body_f[body] + wp.spatial_vector(force, torque)


@wp.kernel
def advance_clock(clock: wp.array[float], dt: float):
    clock[0] += dt
