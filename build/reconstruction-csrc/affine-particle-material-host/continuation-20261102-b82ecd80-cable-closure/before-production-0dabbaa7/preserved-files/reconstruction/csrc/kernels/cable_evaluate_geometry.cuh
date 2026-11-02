#pragma once
#include "cable_tangent_geometry.cuh"

namespace synreal::kernel {

// Only the child's x/z axes survive in the damping value path. Keep the old
// separately rounded w*0 even when dead-axis elimination changes product reuse.
__device__ __forceinline__ glm::mat3 cable_previous_authored_basis(const Transform& frame)
{
    const glm::vec3 q(frame.rotation[0], frame.rotation[1], frame.rotation[2]);
    const float w = frame.rotation[3], w_zero = __fmul_rn(w, 0.0f);
    const glm::vec3 zero = q * 0.0f;
    glm::vec3 u[3] = {glm::vec3(zero.y - zero.z, q.z - zero.x, zero.x - q.y),
        glm::vec3(zero.y - q.z, zero.z - zero.x, q.x - zero.y),
        glm::vec3(q.y - zero.z, zero.z - q.x, zero.x - zero.y)};
    glm::mat3 result;
    #pragma unroll
    for (int column = 0; column < 3; ++column) {
        #pragma unroll
        for (int row = 0; row < 3; ++row)
            u[column][row] = row == column ? w + u[column][row] : u[column][row] + w_zero;
        const glm::vec3 rotated = cable_cross(q, u[column]);
        #pragma unroll
        for (int row = 0; row < 3; ++row)
            result[column][row] = fmaf(rotated[row], 2.0f, row == column ? 1.0f : 0.0f);
    }
    return result;
}

template<bool Parent>
__device__ __forceinline__ CableFrame cable_previous_frame(const CableView& view, size_t local, size_t world,
                                                          const glm::vec3* x)
{
    const Transform frame = (Parent ? view.frame0 : view.frame1)[local];
    const int body = Parent ? view.body_pairs[local].x : view.body_pairs[local].y;
    CableFrame result{frame.position, cable_previous_authored_basis(frame)};
    if (body < 0) return result;
    const glm::ivec4 ids = view.body_indices[body] + static_cast<int>(world * view.particles_per_world);
    result.point = contact_point(frame.position, ids, view.body_com[body], x);
    const float* inertia = reinterpret_cast<const float*>(view.body_matrix) + body * 9;
    const glm::mat3 rotation = cable_rotation(x[ids.y], x[ids.z], x[ids.w], inertia).rotation;
    #pragma unroll
    for (int column = 0; column < 3; ++column) {
        const glm::vec3 v = result.basis[column];
        result.basis[column] = contact_fma(v.z, rotation[2], contact_fma(v.x, rotation[0], v.y * rotation[1]));
    }
    return result;
}

} // namespace synreal::kernel
