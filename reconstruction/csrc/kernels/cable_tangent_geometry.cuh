#pragma once
#include "cable_spin.cuh"
#include "cable_strain_jacobian.cuh"

namespace synreal::kernel {

struct CableTangentGeometry {
    int count;
    int indices[8];
    glm::mat3 linear[8];
    glm::mat3 angular[8];
    CableFrame parent, child;
};

template<bool Parent>
__device__ __forceinline__ CableFrame cable_prepare_frame(const CableView& view, size_t local, size_t world,
                                                         const glm::vec3* x)
{
    const Transform frame = (Parent ? view.frame0 : view.frame1)[local];
    const int body = Parent ? view.body_pairs[local].x : view.body_pairs[local].y;
    // Unlike update's child frame, prepare retains separate w*0 and additions
    // for both authored quaternion bases.
    CableFrame result{frame.position, cable_authored_basis<true>(frame)};
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

__device__ __forceinline__ glm::mat3 cable_matrix_product(const glm::mat3& a, const glm::mat3& b)
{
    glm::mat3 result;
    #pragma unroll
    for (int column = 0; column < 3; ++column)
        result[column] = contact_fma(b[column].z, a[2], contact_fma(b[column].x, a[0], b[column].y * a[1]));
    return result;
}

// Derivative of the parent's coordinates of the endpoint separation with respect
// to world angular velocity: parent_basis^T [child_point-parent_point]_cross.
__device__ __forceinline__ glm::mat3 cable_linear_rotation_jacobian(const CableFrame& parent,
                                                                  const CableFrame& child)
{
    const glm::vec3 delta = child.point - parent.point;
    glm::mat3 result;
    #pragma unroll
    for (int row = 0; row < 3; ++row) {
        const glm::vec3 basis = parent.basis[row];
        result[0][row] = fmaf(basis.x, 0.0f, delta.z * basis.y) - basis.z * delta.y;
        result[1][row] = fmaf(delta.x, basis.z, basis.y * 0.0f - basis.x * delta.z);
        result[2][row] = fmaf(basis.z, 0.0f, delta.y * basis.x - basis.y * delta.x);
    }
    return result;
}

__device__ __forceinline__ void cable_append_endpoint(const CableView& view, size_t local, size_t world,
    const glm::vec3* x, bool parent_endpoint, CableTangentGeometry& result)
{
    const int body = parent_endpoint ? view.body_pairs[local].x : view.body_pairs[local].y;
    if (body < 0) return;
    const glm::ivec4 ids = view.body_indices[body] + static_cast<int>(world * view.particles_per_world);
    const Transform frame = (parent_endpoint ? view.frame0 : view.frame1)[local];
    const glm::vec3 offset = frame.position - view.body_com[body];
    const float* inertia = reinterpret_cast<const float*>(view.body_matrix) + body * 9;
    const CableSpin spin = cable_rotation_spin(x[ids.y], x[ids.z], x[ids.w], inertia);
    const glm::mat3 angular = parent_endpoint ? cable_angular_jacobian<true>(result.parent, result.child) :
        cable_angular_jacobian<false>(result.parent, result.child);
    const glm::mat3 linear_rotation = cable_linear_rotation_jacobian(result.parent, result.child);
    const glm::mat3 basis_transpose = glm::transpose(result.parent.basis);
    #pragma unroll
    for (int slot = 0; slot < 4; ++slot) {
        const int destination = result.count++;
        result.indices[destination] = ids[slot];
        const float weight = slot == 0 ? 1.0f : offset[slot - 1];
        const float signed_weight = (parent_endpoint ? -1.0f : 1.0f) * weight;
        const glm::mat3 point_jacobian = basis_transpose * signed_weight;
        if (slot == 0) {
            result.linear[destination] = point_jacobian;
            result.angular[destination] = glm::mat3(0.0f);
        } else {
            result.angular[destination] = cable_matrix_product(angular, spin.maps[slot - 1]);
            if (parent_endpoint)
                result.linear[destination] = cable_matrix_product(linear_rotation, spin.maps[slot - 1]) + point_jacobian;
            else result.linear[destination] = point_jacobian;
        }
    }
}

__device__ __forceinline__ CableTangentGeometry cable_tangent_geometry(const CableView& view, size_t local,
    size_t world, const glm::vec3* x)
{
    CableTangentGeometry result;
    result.count = 0;
    result.parent = cable_prepare_frame<true>(view, local, world, x);
    result.child = cable_prepare_frame<false>(view, local, world, x);
    // Retain the native runtime side sign and mul/add assembly form. Folding
    // negative weights into subtraction produced different GPU rounding.
    #pragma unroll 1
    for (int endpoint = 0; endpoint < 2; ++endpoint)
        cable_append_endpoint(view, local, world, x, endpoint == 0, result);
    return result;
}

} // namespace synreal::kernel
