#pragma once
#include <cstddef>
#include <cstdint>

// Host POD mirror of the recovered CUDA SurfaceContactView. Addresses remain 64-bit CUDA device pointers.
struct SourceSurfaceView {
    std::uint64_t count;
    std::size_t capacity;
    std::uint64_t indices, barycentric, shape, body_pos, body_vel, normal, particle_only;
    std::size_t particle_only_count;
    std::uint64_t radius, mass, flags, kind;
    std::size_t particles_per_world, total_particles;
    std::uint64_t shape_body, shape_type, transform, shape_scale, shape_margin, shape_ke, shape_kd, shape_kf, shape_mu;
    std::size_t local_shape_count, shapes_per_world, worlds;
    float ke, kd, kf, mu;
    std::uint64_t body_ids, body_indices, body_com;
    std::size_t body_count;
    std::uint64_t x, previous;
    float inv_dt;
};
static_assert(sizeof(SourceSurfaceView) == 296);
static_assert(offsetof(SourceSurfaceView, particles_per_world) == 112);
static_assert(offsetof(SourceSurfaceView, ke) == 224);
static_assert(offsetof(SourceSurfaceView, inv_dt) == 288);
