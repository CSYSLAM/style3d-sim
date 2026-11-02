#pragma once
#include "contact_geometry.cuh"

namespace synreal::kernel {

struct RigidContactView {
    const int* shape0;
    const int* shape1;
    const glm::vec3* point0;
    const glm::vec3* point1;
    const glm::vec3* offset0;
    const glm::vec3* offset1;
    const glm::vec3* normal;
    const float* margin0;
    const float* margin1;
    const int* shape_body;
    const int* shape_type;
    const Transform* transform;
    const glm::vec3* shape_scale;
    const float* ke;
    const float* kd;
    const float* kf;
    const float* mu;
    float epsilon;
    size_t local_shape_count;
    size_t shapes_per_world;
    size_t worlds;
    const int* body_ids;
    const glm::ivec4* body_indices;
    const glm::vec3* body_com;
    size_t body_count;
    size_t particles_per_world;
    const glm::vec3* x;
    const glm::vec3* velocity;
    const glm::vec3* previous;
    float inv_dt;
};

struct RigidContact {
    int shapes[2];
    int slots[2];
    glm::ivec4 ids[2];
    glm::vec3 com[2];
    glm::vec3 raw[2];
    glm::vec3 adjusted[2];
    glm::vec3 normal;
    glm::vec3 tangent;
    float fn;
    float eta;
    float normal_stiffness;
    float friction_stiffness;
    bool separate;
};

// Raw sphere centres determine gap and normal; adjusted points determine friction velocities and reaction levers.
template <bool Tangent>
__device__ __forceinline__ bool rigid_contact(const RigidContactView& view, size_t i, RigidContact& contact)
{
    const int shape_ids[2] = {view.shape0[i], view.shape1[i]};
    int worlds[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        int s, world;
        if (!contact_shape(shape_ids[side], view.local_shape_count, view.shapes_per_world, view.worlds, world, s))
            return false;
        const int body = view.shape_body[s];
        const int slot = contact_body_slot(body, view.body_ids, view.body_count);
        if ((body >= 0 && slot < 0) || (slot >= 0 && world < 0)) return false;
        contact.shapes[side] = s;
        contact.slots[side] = slot;
        contact.ids[side] = slot >= 0 ? view.body_indices[slot] +
            static_cast<int>(static_cast<size_t>(world) * view.particles_per_world) : glm::ivec4(0);
        contact.com[side] = slot >= 0 ? view.body_com[slot] : glm::vec3(0.0f);
        worlds[side] = world;
    }
    if (contact.slots[0] < 0 && contact.slots[1] < 0) return false;
    if (worlds[0] >= 0 && worlds[1] >= 0 && worlds[0] != worlds[1]) return false;
    const glm::vec3 supplied = contact_normalize(view.normal[i]);
    const glm::vec3 points[2] = {view.point0[i], view.point1[i]};
    glm::vec3 world_points[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const int s = contact.shapes[side];
        contact.raw[side] = view.shape_type[s] == 3 ? view.transform[s].position : points[side];
        world_points[side] = contact.slots[side] >= 0 ?
            contact_point(contact.raw[side], contact.ids[side], contact.com[side], view.x) : contact.raw[side];
    }
    glm::vec3 candidate(0.0f);
    if (view.shape_type[contact.shapes[0]] == 3 && view.shape_type[contact.shapes[1]] == 3) {
        const glm::vec3 diff = world_points[1] - world_points[0];
        candidate = normalized_or_zero(diff, sqrtf(contact_dot_x_first(diff, diff)), 0.0f);
    }
    const float candidate_length_squared = Tangent ? contact_dot_x_first(candidate, candidate) :
        contact_dot(candidate, candidate);
    const glm::vec3 n = candidate_length_squared >= 0.5f ? candidate : supplied;
    if constexpr (Tangent) {
        const float length_squared = __fadd_rn(__fadd_rn(n.x * n.x, n.y * n.y), n.z * n.z);
        if (!(length_squared >= 0.5f)) return false;
    } else {
        if (!(contact_dot(n, n) >= 0.5f)) return false;
    }
    contact.normal = n;
    contact.separate = view.offset0 || view.offset1 || view.shape_type[contact.shapes[0]] == 3 ||
        view.shape_type[contact.shapes[1]] == 3;
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const int s = contact.shapes[side];
        glm::vec3 adjusted = contact.raw[side];
        if (view.shape_type[s] == 3) {
            const glm::vec3 offset = side == 0 ? view.shape_scale[s].x * n : -(view.shape_scale[s].x * n);
            adjusted = contact.raw[side] + (contact.slots[side] >= 0 ?
                contact_sphere_offset(offset, contact.ids[side], view.x) : offset);
        }
        const glm::vec3* offset = side == 0 ? view.offset0 : view.offset1;
        if (offset) adjusted = points[side] + offset[i];
        contact.adjusted[side] = adjusted;
    }
    const float depth = (view.margin0[i] + view.margin1[i]) - contact_dot(world_points[1] - world_points[0], n);
    if (depth <= 0.0f) return false;
    glm::vec3 normal_velocity[2], tangent_velocity[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        normal_velocity[side] = contact.slots[side] >= 0 ? contact_point_velocity(contact.raw[side],
            contact.ids[side], contact.com[side], view.x, view.previous, view.velocity, view.inv_dt) : glm::vec3(0.0f);
        tangent_velocity[side] = contact.slots[side] >= 0 ? contact_point_velocity(contact.adjusted[side],
            contact.ids[side], contact.com[side], view.x, view.previous, view.velocity, view.inv_dt) : glm::vec3(0.0f);
    }
    const int s0 = contact.shapes[0], s1 = contact.shapes[1];
    const bool smooth = view.epsilon > 0.0f;
    const float ke = smooth ? (view.ke[s0] + view.ke[s1]) * 0.5f : fmaxf(view.ke[s0], view.ke[s1]);
    const float kd = smooth ? (view.kd[s0] + view.kd[s1]) * 0.5f : fmaxf(view.kd[s0], view.kd[s1]);
    const float vn = contact_dot_x_first(normal_velocity[1] - normal_velocity[0], n);
    const float elastic = depth * ke;
    const float effective_kd = smooth && vn >= 0.0f ? 0.0f : kd;
    const float raw_force = elastic - vn * effective_kd;
    contact.fn = smooth ? raw_force : fmaxf(raw_force, 0.0f);
    const glm::vec3 dv = tangent_velocity[1] - tangent_velocity[0];
    contact.tangent = dv - contact_dot_x_first(dv, n) * n;
    const float speed = sqrtf(contact_dot(contact.tangent, contact.tangent));
    const float mu = smooth ? sqrtf(fmaxf(view.mu[s0] * view.mu[s1], 0.0f)) : fmaxf(view.mu[s0], view.mu[s1]);
    const float bound = (smooth ? elastic : contact.fn) * mu;
    float eta = 0.0f;
    if (smooth) {
        if (bound > 0.0f && speed > 0.0f) {
            if (!(speed <= view.epsilon)) eta = bound / speed;
            else eta = ((2.0f - speed / view.epsilon) * bound) / view.epsilon;
        }
    } else if (bound > 0.0f) {
        eta = fminf(fmaxf(view.kf[s0], view.kf[s1]), bound / fmaxf(speed, 1e-8f));
    }
    contact.eta = eta;
    contact.normal_stiffness = fmaf(effective_kd, view.inv_dt, ke);
    contact.friction_stiffness = eta * view.inv_dt;
    return true;
}

__device__ __forceinline__ void rigid_scatter(glm::vec3* force, const glm::ivec4& ids, const glm::vec3& value,
                                             const glm::vec3& lever, bool positive)
{
    atomic_add(&force[ids.x], positive ? value : -value);
    atomic_add(&force[ids.y], positive ? value * lever.x : -(value * lever.x));
    atomic_add(&force[ids.z], positive ? value * lever.y : -(value * lever.y));
    atomic_add(&force[ids.w], positive ? value * lever.z : -(value * lever.z));
}

__device__ __forceinline__ void rigid_scatter_scalar(float* scalar, const glm::ivec4& ids, float stiffness,
                                                    const glm::vec3& lever)
{
    atomicAdd(&scalar[ids.x], stiffness);
    atomicAdd(&scalar[ids.y], lever.x * (stiffness * lever.x));
    atomicAdd(&scalar[ids.z], lever.y * (stiffness * lever.y));
    atomicAdd(&scalar[ids.w], lever.z * (stiffness * lever.z));
}

} // namespace synreal::kernel
