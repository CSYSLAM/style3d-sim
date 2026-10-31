#pragma once
#include "contact_geometry.cuh"

namespace synreal::kernel {

// Shared 160-byte cable view. Prepared Jacobians are eight column-major mat3 values per cable.
struct CableView {
    const glm::ivec4* body_indices;
    const glm::vec3* body_com;
    const glm::mat3* body_matrix;
    const glm::ivec2* body_pairs;
    const Transform* frame0;
    const Transform* frame1;
    const glm::vec4* base;
    glm::vec4* penalty;
    const glm::vec4* damping;
    const glm::vec3* rest;
    glm::vec3* state;
    glm::vec3* bias;
    const int* active;
    glm::mat3* linear;
    glm::mat3* angular;
    int* indices;
    int* count;
    size_t per_world;
    size_t total_count;
    size_t particles_per_world;
};
static_assert(sizeof(CableView) == 160);
static_assert(offsetof(CableView, base) == 48);
static_assert(offsetof(CableView, linear) == 104);
static_assert(offsetof(CableView, per_world) == 136);

} // namespace synreal::kernel
