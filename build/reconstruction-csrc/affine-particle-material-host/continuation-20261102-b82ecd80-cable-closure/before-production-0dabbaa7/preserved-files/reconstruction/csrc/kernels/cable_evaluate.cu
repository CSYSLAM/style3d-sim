#include "cable_evaluate_geometry.cuh"

namespace synreal::kernel {

__device__ __forceinline__ glm::vec3 cable_matrix_vector(const glm::mat3& a, const glm::vec3& v)
{
    return contact_fma(v.z, a[2], contact_fma(v.x, a[0], v.y * a[1]));
}

__device__ __forceinline__ glm::vec3 cable_transpose_vector(const glm::mat3& a, const glm::vec3& v)
{
    return glm::vec3(contact_dot(v, a[0]), contact_dot(v, a[1]), contact_dot(v, a[2]));
}

__device__ __forceinline__ float cable_wrap_twist(float angle)
{
    constexpr float pi = 3.14159265358979323846f, two_pi = 6.28318530717958647692f;
    if (angle > pi) return angle - two_pi;
    if (angle < -pi) return angle + two_pi;
    return angle;
}

// Material tangent is a sum of two diagonal-weighted Gram matrices. Compute six
// entries once and mirror them, retaining native y-first multiply/FMA order.
__device__ __forceinline__ glm::mat3 cable_diagonal_block(const glm::mat3& linear, const glm::mat3& angular,
    const glm::vec3& linear_weight, const glm::vec3& angular_weight)
{
    glm::mat3 result;
    #pragma unroll
    for (int column = 0; column < 3; ++column)
        #pragma unroll
        for (int row = column; row < 3; ++row) {
            const float l = fmaf(linear_weight.z, linear[column].z * linear[row].z,
                fmaf(linear_weight.x, linear[column].x * linear[row].x,
                     linear_weight.y * (linear[column].y * linear[row].y)));
            const float a = fmaf(angular_weight.z, angular[column].z * angular[row].z,
                fmaf(angular_weight.x, angular[column].x * angular[row].x,
                     angular_weight.y * (angular[column].y * angular[row].y)));
            result[column][row] = l + a;
            result[row][column] = result[column][row];
        }
    return result;
}

// Force recomputes current geometry. Product/diagonal modes consume prepared
// caches; a non-NULL diagonal output takes priority over a supplied direction.
__global__ void evaluate_cables(CableView view, const glm::vec3* x, const glm::vec3* previous, float inverse_dt,
    const glm::vec3* direction, glm::vec3* force, glm::mat3* diagonal)
{
    const size_t i = thread_index();
    if (i >= view.total_count) return;
    const size_t local = i % view.per_world, world = i / view.per_world;
    if (view.active && view.active[local] == 0) return;
    CableTangentGeometry geometry;
    if (direction || diagonal) {
        geometry.count = view.count[i];
        for (int slot = 0; slot < geometry.count; ++slot) {
            const size_t at = i * 8 + slot;
            geometry.linear[slot] = view.linear[at];
            geometry.angular[slot] = view.angular[at];
            geometry.indices[slot] = view.indices[at];
        }
    } else geometry = cable_tangent_geometry(view, local, world, x);
    const glm::vec4 penalty = view.penalty ? view.penalty[i] : view.base[local];
    const glm::vec4 damping = view.damping[local];
    const glm::vec4 damping_weight = damping * inverse_dt;
    const glm::vec3 linear_weight(penalty.y + damping_weight.y, penalty.y + damping_weight.y,
                                   penalty.x + damping_weight.x);
    const glm::vec3 bias = view.bias ? view.bias[i] : glm::vec3(0.0f);
    const glm::vec3 angular_weight((penalty.z + damping_weight.z) + bias.x,
        (penalty.z + damping_weight.z) + bias.y, (penalty.w + damping_weight.w) + bias.z);
    glm::vec3 linear_force(0.0f), angular_force(0.0f);
    if (!diagonal) {
        if (direction) {
            glm::vec3 linear_delta(0.0f), angular_delta(0.0f);
            for (int slot = 0; slot < geometry.count; ++slot) {
                const glm::vec3 v = direction[geometry.indices[slot]];
                linear_delta = linear_delta + cable_matrix_vector(geometry.linear[slot], v);
                angular_delta = angular_delta + cable_matrix_vector(geometry.angular[slot], v);
            }
            linear_force = linear_weight * linear_delta;
            angular_force = angular_weight * angular_delta;
        } else {
            const CableStrain current = cable_strain(geometry.parent, geometry.child, view.rest[local]);
            linear_force = -(glm::vec3(penalty.y, penalty.y, penalty.x) * current.linear);
            angular_force = -(glm::vec3(penalty.z, penalty.z, penalty.w) * current.angular);
            if (view.state) angular_force = angular_force - view.state[i];
            if (damping.x > 0.0f || damping.y > 0.0f || damping.z > 0.0f || damping.w > 0.0f) {
                const CableFrame old_parent = cable_previous_frame<true>(view, local, world, previous);
                const CableFrame old_child = cable_previous_frame<false>(view, local, world, previous);
                const CableStrain old = cable_strain(old_parent, old_child, view.rest[local]);
                const glm::vec3 linear_delta = current.linear - old.linear;
                glm::vec3 angular_delta = current.angular - old.angular;
                angular_delta.z = cable_wrap_twist(angular_delta.z);
                linear_force = linear_force - glm::vec3(damping_weight.y, damping_weight.y, damping_weight.x) *
                    linear_delta;
                angular_force = angular_force - glm::vec3(damping_weight.z, damping_weight.z, damping_weight.w) *
                    angular_delta;
            }
        }
    }
    for (int slot = 0; slot < geometry.count; ++slot) {
        const int index = geometry.indices[slot];
        if (diagonal) atomic_add(diagonal + index,
            cable_diagonal_block(geometry.linear[slot], geometry.angular[slot], linear_weight, angular_weight));
        else atomic_add(force + index, cable_transpose_vector(geometry.linear[slot], linear_force) +
            cable_transpose_vector(geometry.angular[slot], angular_force));
    }
}

} // namespace synreal::kernel
