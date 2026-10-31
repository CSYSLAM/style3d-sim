#pragma once
#include "cable_types.cuh"
#include "cable_rotation.cuh"

namespace synreal::kernel {

__device__ __forceinline__ glm::vec3 cable_cross(const glm::vec3& a, const glm::vec3& b)
{
    return glm::vec3(a.y * b.z - b.y * a.z, a.z * b.x - b.z * a.x, a.x * b.y - b.x * a.y);
}

template<bool Parent>
__device__ __forceinline__ glm::mat3 cable_authored_basis(const Transform& frame)
{
    const glm::vec3 q(frame.rotation[0], frame.rotation[1], frame.rotation[2]);
    const float w = frame.rotation[3];
    const glm::vec3 zero = q * 0.0f;
    const float w_zero = w * 0.0f;
    glm::vec3 u[3] = {glm::vec3(zero.y - zero.z, q.z - zero.x, zero.x - q.y),
        glm::vec3(zero.y - q.z, zero.z - zero.x, q.x - zero.y),
        glm::vec3(q.y - zero.z, zero.z - q.x, zero.x - zero.y)};
    glm::mat3 basis;
    #pragma unroll
    for (int column = 0; column < 3; ++column) {
        #pragma unroll
        for (int row = 0; row < 3; ++row)
            u[column][row] = row == column ? w + u[column][row] :
                Parent ? u[column][row] + w_zero : fmaf(w, 0.0f, u[column][row]);
        const glm::vec3 rotated = cable_cross(q, u[column]);
        #pragma unroll
        for (int row = 0; row < 3; ++row)
            basis[column][row] = fmaf(rotated[row], 2.0f, row == column ? 1.0f : 0.0f);
    }
    return basis;
}

struct CableFrame {
    glm::vec3 point;
    glm::mat3 basis;
};

template<bool Parent>
__device__ __forceinline__ CableFrame cable_world_frame(const CableView& view, size_t local, size_t world,
                                                       const glm::vec3* x)
{
    const Transform frame = (Parent ? view.frame0 : view.frame1)[local];
    const int body = Parent ? view.body_pairs[local].x : view.body_pairs[local].y;
    CableFrame result{frame.position, cable_authored_basis<Parent>(frame)};
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

// At the antiparallel singularity, select a reproducible axis in the parent's normal plane.
__device__ __forceinline__ glm::vec3 cable_opposite_axis(const glm::vec3& n, const glm::vec3& parent_x)
{
    glm::vec3 projected = parent_x - contact_dot(n, parent_x) * n;
    float length = sqrtf(contact_dot(projected, projected));
    if (length <= 1e-9f) {
        const glm::vec3 axis = fabsf(n.x) > 0.9f ? glm::vec3(0.0f, 1.0f, 0.0f) : glm::vec3(1.0f, 0.0f, 0.0f);
        projected = axis - contact_dot(n, axis) * n;
        length = sqrtf(contact_dot(projected, projected));
    }
    return normalized_or_zero(projected, length, 0.0f);
}

struct CableStrain {
    glm::vec3 linear;
    glm::vec3 angular;
};

__device__ __forceinline__ CableStrain cable_strain(const CableFrame& parent, const CableFrame& child,
                                                  const glm::vec3& rest)
{
    const glm::vec3 difference = child.point - parent.point;
    const glm::vec3 linear(contact_dot(parent.basis[0], difference), contact_dot(parent.basis[1], difference),
                           contact_dot(parent.basis[2], difference));
    const glm::vec3 n = parent.basis[2], m = child.basis[2], px = parent.basis[0];
    const float cosine = fmaxf(-1.0f, fminf(1.0f, contact_dot(n, m)));
    const float denominator = cosine + 1.0f;
    const glm::vec3 cross = cable_cross(n, m);
    glm::vec3 bending;
    if (!(denominator <= 1e-12f) || !(contact_dot(cross, cross) <= 1e-12f)) {
        bending = cross * (2.0f / fmaxf(1e-12f, denominator));
        const float length = sqrtf(contact_dot(bending, bending));
        if (length > 20.0f) bending *= 20.0f / length;
    } else bending = cable_opposite_axis(n, px) * 20.0f;
    glm::vec3 transported;
    if (denominator > 1e-8f) {
        transported = px - (n + m) * (contact_dot(m, px) / denominator);
    } else {
        const float length = sqrtf(contact_dot(cross, cross));
        if (length > 1e-7f) {
            const glm::vec3 axis = cross / length;
            const float angle = atan2f(length, cosine);
            const float cs = cosf(angle), sn = sinf(angle);
            const glm::vec3 base = contact_fma(cs, px, cable_cross(axis, px) * sn);
            transported = contact_fma(contact_dot(axis, px) * (1.0f - cs), axis, base);
        } else {
            const glm::vec3 axis = cable_opposite_axis(n, px);
            const float projection = contact_dot(px, axis);
            transported = (projection + projection) * axis - px;
        }
    }
    transported = contact_normalize(transported);
    const float twist = atan2f(contact_dot(cable_cross(transported, child.basis[0]), m),
                               contact_dot(child.basis[0], transported));
    constexpr float pi = 3.14159265358979323846f, two_pi = 6.28318530717958647692f;
    float twist_error = twist - rest.z;
    if (twist_error > pi) twist_error = twist_error - two_pi;
    else if (twist_error < -pi) twist_error = twist_error + two_pi;
    return {linear, glm::vec3(contact_dot(bending, px) - rest.x,
                              contact_dot(bending, parent.basis[1]) - rest.y, twist_error)};
}

} // namespace synreal::kernel
