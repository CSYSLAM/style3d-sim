// Verified Model fields used by particle-fluid kernels. Unused ABI regions remain opaque until reconstructed.
#pragma once

#include "types.cuh"

namespace synreal {

struct Model {
    unsigned char reserved0[24];
    unsigned particles_per_world;
    unsigned particle_count;
    unsigned char reserved32[16];
    const float* mass;
    unsigned char reserved56[64];
    const int* particle_world;
    size_t particle_world_count;
    const float* radius;
    unsigned char reserved144[48];
    unsigned fluid_count;
    unsigned char reserved196[4];
    const int* fluid_indices;
    unsigned char reserved208[8];
    float rest_density;
    float smoothing_radius;
    unsigned char reserved224[8];
    unsigned boundary_count;
    unsigned char reserved236[4];
    const glm::vec3* boundary_positions;
    unsigned char reserved248[8];
    const float* boundary_volumes;
    unsigned char reserved264[8];
    unsigned granular_count;
    unsigned char reserved276[4];
    const int* granular_indices;
    unsigned char reserved288[24];
    float bond_damping;
    float bond_yield_strain;
    float bond_max_compaction;
    float bond_break_strain;
    float granular_adhesion;
    float granular_formation_gap;
    float granular_formation_speed;
    int granular_max_dynamic_bonds;
    unsigned char reserved344[1520];
};
static_assert(sizeof(Model) == 1864);
static_assert(alignof(Model) == 8);
static_assert(offsetof(Model, particles_per_world) == 24);
static_assert(offsetof(Model, mass) == 48);
static_assert(offsetof(Model, particle_world) == 120);
static_assert(offsetof(Model, fluid_count) == 192);
static_assert(offsetof(Model, fluid_indices) == 200);
static_assert(offsetof(Model, rest_density) == 216);
static_assert(offsetof(Model, smoothing_radius) == 220);
static_assert(offsetof(Model, boundary_count) == 232);
static_assert(offsetof(Model, boundary_positions) == 240);
static_assert(offsetof(Model, boundary_volumes) == 256);
static_assert(offsetof(Model, radius) == 136);
static_assert(offsetof(Model, granular_count) == 272);
static_assert(offsetof(Model, granular_indices) == 280);
static_assert(offsetof(Model, bond_damping) == 312);
static_assert(offsetof(Model, bond_yield_strain) == 316);
static_assert(offsetof(Model, bond_max_compaction) == 320);
static_assert(offsetof(Model, bond_break_strain) == 324);
static_assert(offsetof(Model, granular_adhesion) == 328);
static_assert(offsetof(Model, granular_formation_gap) == 332);
static_assert(offsetof(Model, granular_formation_speed) == 336);
static_assert(offsetof(Model, granular_max_dynamic_bonds) == 340);

}  // namespace synreal
