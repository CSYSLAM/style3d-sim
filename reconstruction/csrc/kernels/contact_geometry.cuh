#pragma once
#include "affine_geometry.cuh"

namespace synreal {

// Contacts read the translation; the four rotation floats retain the legacy 28-byte Transform stride.
struct Transform {
    glm::vec3 position;
    float rotation[4];
};
static_assert(sizeof(Transform) == 28);

namespace kernel {

__device__ __forceinline__ float contact_dot(const glm::vec3& a, const glm::vec3& b)
{
    return fmaf(a.z, b.z, fmaf(a.x, b.x, a.y * b.y));
}

__device__ __forceinline__ float contact_dot_x_first(const glm::vec3& a, const glm::vec3& b)
{
    return fmaf(a.z, b.z, fmaf(a.y, b.y, a.x * b.x));
}

__device__ __forceinline__ glm::vec3 contact_normalize(const glm::vec3& a)
{
    return normalized_or_zero(a, sqrtf(contact_dot(a, a)), 0.0f);
}

__device__ __forceinline__ glm::vec3 contact_fma(float a, const glm::vec3& b, const glm::vec3& c)
{
    return glm::vec3(fmaf(a, b.x, c.x), fmaf(a, b.y, c.y), fmaf(a, b.z, c.z));
}

// Newton body ids need not be affine-slot indices. The fallback is a first-match linear search.
__device__ __forceinline__ int contact_body_slot(int body, const int* ids, size_t count)
{
    if (body < 0) return -1;
    if (static_cast<size_t>(body) < count && ids[body] == body) return body;
    for (size_t i = 0; i < count; ++i)
        if (ids[i] == body) return static_cast<int>(i);
    return -1;
}

__device__ __forceinline__ glm::vec3 contact_point(const glm::vec3& point, const glm::ivec4& ids,
                                                 const glm::vec3& com, const glm::vec3* x)
{
    const glm::vec3 d = point - com;
    return contact_fma(d.z, x[ids.w], contact_fma(d.y, x[ids.z], contact_fma(d.x, x[ids.y], x[ids.x])));
}

__device__ __forceinline__ glm::vec3 contact_velocity(int index, const glm::vec3* x, const glm::vec3* previous,
                                                    const glm::vec3* velocity, float inv_dt)
{
    return previous ? (x[index] - previous[index]) * inv_dt : velocity[index];
}

__device__ __forceinline__ glm::vec3 contact_point_velocity(const glm::vec3& point, const glm::ivec4& ids,
    const glm::vec3& com, const glm::vec3* x, const glm::vec3* previous, const glm::vec3* velocity, float inv_dt)
{
    const glm::vec3 d = point - com;
    const glm::vec3 v0 = contact_velocity(ids.x, x, previous, velocity, inv_dt);
    const glm::vec3 v1 = contact_velocity(ids.y, x, previous, velocity, inv_dt);
    const glm::vec3 v2 = contact_velocity(ids.z, x, previous, velocity, inv_dt);
    const glm::vec3 v3 = contact_velocity(ids.w, x, previous, velocity, inv_dt);
    return contact_fma(d.z, v3, contact_fma(d.y, v2, contact_fma(d.x, v1, v0)));
}

__device__ __forceinline__ glm::vec3 contact_surface_velocity(const glm::vec3& v, const glm::ivec4& ids,
                                                           const glm::vec3* x)
{
    return contact_fma(v.z, x[ids.w], contact_fma(v.x, x[ids.y], v.y * x[ids.z]));
}

// Sphere levers use A^-1 when nonsingular, and the transpose of the polar rotation otherwise.
__device__ __forceinline__ glm::vec3 contact_sphere_offset(const glm::vec3& v, const glm::ivec4& ids,
                                                        const glm::vec3* x)
{
    const glm::vec3 a = x[ids.y], b = x[ids.z], c = x[ids.w];
    const glm::vec3 bc = glm::cross(b, c);
    const float det = contact_dot(a, bc);
    if (fabsf(det) > 1e-10f && fabsf(det) < INFINITY) {
        const float inverse = 1.0f / det;
        return glm::vec3(contact_dot(v, bc * inverse), contact_dot(v, glm::cross(c, a) * inverse),
                         contact_dot(v, glm::cross(a, b) * inverse));
    }
    const glm::mat3 r = nearest_rotation(a, b, c);
    return glm::vec3(contact_dot(v, r[0]), contact_dot(v, r[1]), contact_dot(v, r[2]));
}

// Replicated shapes precede the shared-static suffix. Filters use the original global shape id.
__device__ __forceinline__ bool contact_shape(int shape, size_t local_count, size_t per_world, size_t worlds,
                                             int& world, int& local)
{
    if (shape < 0) return false;
    const size_t replicated = per_world * worlds;
    if (static_cast<size_t>(shape) < replicated) {
        world = static_cast<int>(static_cast<size_t>(shape) / per_world);
        local = static_cast<int>(static_cast<size_t>(shape) % per_world);
    } else {
        world = -1;
        const size_t shared = static_cast<size_t>(shape) - replicated + per_world;
        if (shared >= local_count) return false;
        local = static_cast<int>(shared);
    }
    return true;
}

} // namespace kernel
} // namespace synreal
