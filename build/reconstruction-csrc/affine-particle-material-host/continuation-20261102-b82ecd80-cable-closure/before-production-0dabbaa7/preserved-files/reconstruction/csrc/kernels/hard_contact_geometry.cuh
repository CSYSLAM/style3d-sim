#pragma once
#include "contact_geometry.cuh"

namespace synreal::kernel {

struct HardContactView {
    const int* count;
    size_t capacity;
    const int* shape0;
    const int* shape1;
    const glm::vec3* point0;
    const glm::vec3* point1;
    const glm::vec3* offset0;
    const glm::vec3* offset1;
    const glm::vec3* normal;
    const float* margin0;
    const float* margin1;
    const int* match;
    const int* shape_body;
    const int* shape_type;
    const Transform* shape_transform;
    const glm::vec3* shape_scale;
    const float* shape_ke;
    const float* shape_kd;
    const float* shape_mu;
    size_t local_shape_count;
    size_t shapes_per_world;
    size_t worlds;
    const int* body_ids;
    const glm::ivec4* body_indices;
    const glm::vec3* body_com;
    size_t body_count;
    size_t particles_per_world;
    const glm::vec3* x;
    const glm::vec3* previous;
    float inv_dt;
    float alpha;
    float beta;
    float gamma;
    float start;
    unsigned char history;
    unsigned char exact_friction;
    unsigned char reset;
    unsigned char reserved255;
    float* penalty;
    glm::vec3* dual;
    glm::vec3* anchor;
    float* previous_penalty;
    glm::vec3* previous_dual;
    glm::vec3* previous_normal;
    int* previous_count;
};
static_assert(sizeof(HardContactView) == 312);
static_assert(offsetof(HardContactView, normal) == 64);
static_assert(offsetof(HardContactView, shape_body) == 96);
static_assert(offsetof(HardContactView, x) == 216);
static_assert(offsetof(HardContactView, history) == 252);
static_assert(offsetof(HardContactView, penalty) == 256);
static_assert(offsetof(HardContactView, previous_count) == 304);

struct HardGeometry {
    int shapes[2];
    int slots[2];
    glm::ivec4 ids[2];
    glm::vec3 com[2];
    glm::vec3 adjusted[2];
    glm::vec3 normal;
    float depth;
};

// Unlike soft contact, hard-contact depth keeps the supplied normal and raw pipeline points. The sphere-centre
// direction affects only the adjusted friction levers, and explicit pipeline offsets override those levers.
__device__ __forceinline__ bool hard_geometry(const HardContactView& view, size_t i, HardGeometry& geometry)
{
    const int shape_ids[2] = {view.shape0[i], view.shape1[i]};
    int shape_worlds[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        int s, world;
        if (!contact_shape(shape_ids[side], view.local_shape_count, view.shapes_per_world, view.worlds, world, s))
            return false;
        const int body = view.shape_body[s];
        const int slot = contact_body_slot(body, view.body_ids, view.body_count);
        if ((body >= 0 && slot < 0) || (slot >= 0 && world < 0)) return false;
        geometry.shapes[side] = s;
        geometry.slots[side] = slot;
        shape_worlds[side] = world;
        geometry.ids[side] = slot >= 0 ? view.body_indices[slot] +
            static_cast<int>(static_cast<size_t>(world) * view.particles_per_world) : glm::ivec4(0);
        geometry.com[side] = slot >= 0 ? view.body_com[slot] : glm::vec3(0.0f);
    }
    if (geometry.slots[0] < 0 && geometry.slots[1] < 0) return false;
    if (shape_worlds[0] >= 0 && shape_worlds[1] >= 0 && shape_worlds[0] != shape_worlds[1]) return false;
    glm::vec3 raw[2];
    const glm::vec3 points[2] = {view.point0[i], view.point1[i]};
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const int s = geometry.shapes[side];
        raw[side] = view.shape_type[s] == 3 ? view.shape_transform[s].position : points[side];
    }
    const glm::vec3 supplied_normal = contact_normalize(view.normal[i]);
    glm::vec3 direction(0.0f);
    if (view.shape_type[geometry.shapes[0]] == 3 && view.shape_type[geometry.shapes[1]] == 3) {
        const glm::vec3 w0 = geometry.slots[0] >= 0 ?
            contact_point(raw[0], geometry.ids[0], geometry.com[0], view.x) : raw[0];
        const glm::vec3 w1 = geometry.slots[1] >= 0 ?
            contact_point(raw[1], geometry.ids[1], geometry.com[1], view.x) : raw[1];
        direction = contact_normalize(w1 - w0);
    }
    if (!(contact_dot(direction, direction) >= 0.5f)) direction = supplied_normal;
    if (!(contact_dot(direction, direction) >= 0.5f)) return false;
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const int s = geometry.shapes[side];
        glm::vec3 adjusted = raw[side];
        if (view.shape_type[s] == 3) {
            const float radius = view.shape_scale[s].x;
            const glm::vec3 offset = side == 0 ? radius * direction : -(radius * direction);
            adjusted = geometry.slots[side] >= 0 ?
                raw[side] + contact_sphere_offset(offset, geometry.ids[side], view.x) :
                (side == 0 ? raw[side] + radius * direction : raw[side] - radius * direction);
        }
        const glm::vec3* offset = side == 0 ? view.offset0 : view.offset1;
        if (offset) adjusted = points[side] + offset[i];
        geometry.adjusted[side] = adjusted;
    }
    geometry.normal = contact_normalize(view.normal[i]);
    const glm::vec3 n = geometry.normal;
    if (contact_dot_x_first(n, n) < 0.5f) return false;
    const glm::vec3 p0 = geometry.slots[0] >= 0 ?
        contact_point(points[0], geometry.ids[0], geometry.com[0], view.x) : points[0];
    const glm::vec3 p1 = geometry.slots[1] >= 0 ?
        contact_point(points[1], geometry.ids[1], geometry.com[1], view.x) : points[1];
    geometry.depth = (view.margin0[i] + view.margin1[i]) - contact_dot(p1 - p0, n);
    return true;
}

} // namespace synreal::kernel
