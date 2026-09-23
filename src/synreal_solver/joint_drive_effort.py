"""Read-only actuator-law evaluation at a completed Newton rigid-body state."""

import warp as wp


@wp.func
def _point_velocity(pose: wp.transform, twist: wp.spatial_vector, center: wp.vec3, point: wp.vec3):
    world_center = wp.transform_point(pose, center)
    return wp.spatial_top(twist) + wp.cross(wp.spatial_bottom(twist), point - world_center)


@wp.func
def _unwrap_near(value: float, reference: float):
    """Return the 2*pi-equivalent of ``value`` nearest ``reference``."""
    turns = (reference - value) / (2.0 * wp.pi)
    nearest_turn = wp.sign(turns) * wp.floor(wp.abs(turns) + 0.5)
    return value + (2.0 * wp.pi) * nearest_turn


@wp.kernel
def evaluate_joint_drive_effort(
    body_q: wp.array(dtype=wp.transform),
    previous_body_q: wp.array(dtype=wp.transform),
    previous_angles: wp.array(dtype=wp.float32),
    angle_initialized: wp.array(dtype=wp.int32),
    body_qd: wp.array(dtype=wp.spatial_vector),
    body_com: wp.array(dtype=wp.vec3),
    affine_body_ids: wp.array(dtype=wp.int32),
    drive_types: wp.array(dtype=wp.int32),
    drive_bodies: wp.array(dtype=wp.vec2i),
    parent_origins: wp.array(dtype=wp.vec3),
    child_origins: wp.array(dtype=wp.vec3),
    parent_axis_points: wp.array(dtype=wp.vec3),
    parent_references: wp.array(dtype=wp.vec3),
    child_references: wp.array(dtype=wp.vec3),
    dof_indices: wp.array(dtype=wp.int32),
    target_indices: wp.array(dtype=wp.int32),
    stiffness: wp.array(dtype=wp.float32),
    damping: wp.array(dtype=wp.float32),
    effort_limits: wp.array(dtype=wp.float32),  # Retained for launch ABI compatibility.
    feedforward: wp.array(dtype=wp.float32),
    target_q: wp.array(dtype=wp.float32),
    target_qd: wp.array(dtype=wp.float32),
    inverse_dt: float,
    use_discrete_velocity: int,
    use_persistent_angle_state: int,
    advance_angle_state: int,
    effort: wp.array(dtype=wp.float32),
):
    drive = wp.tid()
    bodies = drive_bodies[drive]
    child = affine_body_ids[bodies[1]]
    child_pose = body_q[child]
    child_twist = body_qd[child]
    child_origin = wp.transform_point(child_pose, child_origins[drive])
    child_reference = wp.transform_point(child_pose, child_references[drive])
    child_velocity = _point_velocity(child_pose, child_twist, body_com[child], child_origin)

    parent_origin = parent_origins[drive]
    parent_axis_point = parent_axis_points[drive]
    parent_reference = parent_references[drive]
    parent_velocity = wp.vec3(0.0)
    parent_omega = wp.vec3(0.0)
    if bodies[0] >= 0:
        parent = affine_body_ids[bodies[0]]
        parent_pose = body_q[parent]
        parent_twist = body_qd[parent]
        parent_origin = wp.transform_point(parent_pose, parent_origin)
        parent_axis_point = wp.transform_point(parent_pose, parent_axis_point)
        parent_reference = wp.transform_point(parent_pose, parent_reference)
        parent_velocity = _point_velocity(parent_pose, parent_twist, body_com[parent], parent_origin)
        parent_omega = wp.spatial_bottom(parent_twist)

    axis_vector = parent_axis_point - parent_origin
    axis_length = wp.length(axis_vector)
    if axis_length <= 1.0e-8:
        return
    axis = axis_vector / axis_length
    displacement = child_origin - parent_origin
    q = wp.dot(displacement, axis)
    # The paper defines drive velocity from the generalized coordinate itself:
    #   q_dot = (q - q^t) / h.
    # Keep the twist-based expression only as a compatibility fallback for
    # direct calls that do not provide the beginning-of-step pose.
    qd = wp.float32(0.0)
    if use_discrete_velocity == 0:
        # Differentiate the coordinate in the moving parent frame, including any finite constraint error.
        qd = wp.dot(child_velocity - parent_velocity, axis) + wp.dot(displacement, wp.cross(parent_omega, axis))
    dof = dof_indices[drive]
    target = target_q[target_indices[drive]]
    if drive_types[drive] == 1:
        parent_arm = parent_reference - parent_origin
        child_arm = child_reference - child_origin
        parent_arm = parent_arm - wp.dot(parent_arm, axis) * axis
        child_arm = child_arm - wp.dot(child_arm, axis) * axis
        if wp.length(parent_arm) <= 1.0e-8 or wp.length(child_arm) <= 1.0e-8:
            return
        raw_q = wp.atan2(wp.dot(axis, wp.cross(parent_arm, child_arm)), wp.dot(parent_arm, child_arm))

        if use_discrete_velocity != 0:
            previous_child_pose = previous_body_q[child]
            previous_child_origin = wp.transform_point(previous_child_pose, child_origins[drive])
            previous_child_reference = wp.transform_point(previous_child_pose, child_references[drive])
            previous_parent_origin = parent_origins[drive]
            previous_parent_axis_point = parent_axis_points[drive]
            previous_parent_reference = parent_references[drive]
            if bodies[0] >= 0:
                previous_parent = affine_body_ids[bodies[0]]
                previous_parent_pose = previous_body_q[previous_parent]
                previous_parent_origin = wp.transform_point(previous_parent_pose, parent_origins[drive])
                previous_parent_axis_point = wp.transform_point(previous_parent_pose, parent_axis_points[drive])
                previous_parent_reference = wp.transform_point(previous_parent_pose, parent_references[drive])
            previous_axis_vector = previous_parent_axis_point - previous_parent_origin
            previous_axis_length = wp.length(previous_axis_vector)
            if previous_axis_length <= 1.0e-8:
                return
            previous_axis = previous_axis_vector / previous_axis_length
            previous_parent_arm = previous_parent_reference - previous_parent_origin
            previous_child_arm = previous_child_reference - previous_child_origin
            previous_parent_arm = previous_parent_arm - wp.dot(previous_parent_arm, previous_axis) * previous_axis
            previous_child_arm = previous_child_arm - wp.dot(previous_child_arm, previous_axis) * previous_axis
            if wp.length(previous_parent_arm) <= 1.0e-8 or wp.length(previous_child_arm) <= 1.0e-8:
                return
            raw_previous_q = wp.atan2(
                wp.dot(previous_axis, wp.cross(previous_parent_arm, previous_child_arm)),
                wp.dot(previous_parent_arm, previous_child_arm),
            )
            # Preserve the beginning-of-step local branch.  The target is not
            # allowed to redefine theta^t when it requests multiple turns.
            previous_q = raw_previous_q
            if use_persistent_angle_state != 0 and angle_initialized[drive] != 0:
                if advance_angle_state != 0:
                    previous_q = previous_angles[drive]
                    q = _unwrap_near(raw_q, previous_q)
                else:
                    # A post-step read sees the branch state after it advanced.
                    # Recover theta^t by unwrapping the supplied prior pose near
                    # the cached current coordinate.
                    q = _unwrap_near(raw_q, previous_angles[drive])
                    previous_q = _unwrap_near(raw_previous_q, q)
            elif use_persistent_angle_state != 0:
                previous_angles[drive] = raw_previous_q
                angle_initialized[drive] = 1
                q = _unwrap_near(raw_q, previous_q)
            else:
                q = _unwrap_near(raw_q, previous_q)
            qd = (q - previous_q) * inverse_dt
            if advance_angle_state != 0:
                previous_angles[drive] = q
                angle_initialized[drive] = 1
        else:
            # For a direct query without a beginning-of-step pose, choose the
            # periodic branch nearest the commanded target.
            q = _unwrap_near(raw_q, target)
            qd = wp.dot(wp.spatial_bottom(child_twist) - parent_omega, axis)

    elif use_discrete_velocity != 0:
        previous_child_pose = previous_body_q[child]
        previous_child_origin = wp.transform_point(previous_child_pose, child_origins[drive])
        previous_parent_origin = parent_origins[drive]
        previous_parent_axis_point = parent_axis_points[drive]
        if bodies[0] >= 0:
            previous_parent = affine_body_ids[bodies[0]]
            previous_parent_pose = previous_body_q[previous_parent]
            previous_parent_origin = wp.transform_point(previous_parent_pose, parent_origins[drive])
            previous_parent_axis_point = wp.transform_point(previous_parent_pose, parent_axis_points[drive])
        previous_axis_vector = previous_parent_axis_point - previous_parent_origin
        previous_axis_length = wp.length(previous_axis_vector)
        if previous_axis_length <= 1.0e-8:
            return
        previous_axis = previous_axis_vector / previous_axis_length
        previous_q = wp.dot(previous_child_origin - previous_parent_origin, previous_axis)
        qd = (q - previous_q) * inverse_dt

    requested = feedforward[dof] + stiffness[dof] * (target - q) + damping[dof] * (target_qd[dof] - qd)
    # The paper's actuator law reports the raw feedforward-plus-PD effort.
    # Effort limits belong to the native solve's saturation policy and are not
    # part of this generalized-force evaluation.
    wp.atomic_add(effort, dof, requested)
