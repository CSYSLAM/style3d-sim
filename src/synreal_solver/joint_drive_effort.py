"""Read-only actuator-law evaluation at a completed Newton rigid-body state."""

import warp as wp


@wp.func
def _point_velocity(pose: wp.transform, twist: wp.spatial_vector, center: wp.vec3, point: wp.vec3):
    world_center = wp.transform_point(pose, center)
    return wp.spatial_top(twist) + wp.cross(wp.spatial_bottom(twist), point - world_center)


@wp.kernel
def evaluate_joint_drive_effort(
    body_q: wp.array(dtype=wp.transform),
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
    effort_limits: wp.array(dtype=wp.float32),
    feedforward: wp.array(dtype=wp.float32),
    target_q: wp.array(dtype=wp.float32),
    target_qd: wp.array(dtype=wp.float32),
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
        q = wp.atan2(wp.dot(axis, wp.cross(parent_arm, child_arm)), wp.dot(parent_arm, child_arm))
        # Choose the equivalent angle nearest the target, matching the motor's periodic position error.
        turns = (target - q) / (2.0 * wp.pi)
        nearest_turn = wp.sign(turns) * wp.floor(wp.abs(turns) + 0.5)
        q = q + (2.0 * wp.pi) * nearest_turn
        qd = wp.dot(wp.spatial_bottom(child_twist) - parent_omega, axis)

    requested = feedforward[dof] + stiffness[dof] * (target - q) + damping[dof] * (target_qd[dof] - qd)
    # A malformed actuator state must remain visible to callers instead of masquerading as zero effort.
    value = requested
    if wp.isfinite(requested):
        value = wp.clamp(requested, -effort_limits[dof], effort_limits[dof])
    wp.atomic_add(effort, dof, value)
