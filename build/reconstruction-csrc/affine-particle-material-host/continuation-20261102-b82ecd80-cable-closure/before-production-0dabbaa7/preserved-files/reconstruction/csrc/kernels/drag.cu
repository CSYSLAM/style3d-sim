// Aerodynamic drag on cloth triangles (linearised about the triangle normal of the step start).
#include "common.cuh"

namespace synreal::kernel {

// Per triangle of every world: unit normal (zero for a degenerate triangle) and area at the step start.
__global__ void initialize_triangle_drag(const glm::vec3* x, const glm::ivec3* triangles, glm::vec3* normal,
                                         float* area, size_t count, size_t triangles_per_world,
                                         size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const glm::ivec3 local = triangles[triangle];
    const int offset = static_cast<int>(world * particles_per_world);
    const int a = local.x + offset, b = local.y + offset, c = local.z + offset;
    const glm::vec3 n = glm::cross(x[b] - x[a], x[c] - x[a]);
    const float length = glm::length(n);
    area[i] = length * 0.5f;
    normal[i] = normalized_or_zero(n, length, 1e-12f);
}

// Drag tangent times a direction p: every vertex receives c n (n . (p_a + p_b + p_c)) with the triangle's
// coefficient c from evaluate_triangle_drag.
__global__ void multiply_triangle_drag_tangent(const glm::vec3* p, const glm::ivec3* triangles,
                                               const glm::vec3* normal, const float* coefficient,
                                               glm::vec3* product, size_t count, size_t triangles_per_world,
                                               size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const glm::ivec3 local = triangles[triangle];
    const int offset = static_cast<int>(world * particles_per_world);
    const int a = local.x + offset, b = local.y + offset, c = local.z + offset;
    const glm::vec3& n = normal[i];
    const glm::vec3 sum = p[a] + p[b] + p[c];
    const glm::vec3 f = n * (coefficient[i] * glm::dot(n, sum));
    atomic_add(&product[a], f);
    atomic_add(&product[b], f);
    atomic_add(&product[c], f);
}

// Drag force for the current iterate (Newton linearisation point x): relative velocity from the vertex
// displacements of the substep, vn = n . (v - wind), q = rho/2 Cd area; each vertex receives -(q vn |vn|) / 3 n.
// Also stores the tangent scalar 2 q |vn| / (9 h) used by the preconditioner and the tangent product.
__global__ void evaluate_triangle_drag(const glm::vec3* x, const glm::vec3* x_previous, const glm::ivec3* triangles,
                                       const float* drag_coefficient, const glm::vec3* normal, const float* area,
                                       float density, glm::vec3 wind, float inverse_dt, glm::vec3* force,
                                       float* tangent_scalar, size_t count, size_t triangles_per_world,
                                       size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const glm::ivec3 local = triangles[triangle];
    const int offset = static_cast<int>(world * particles_per_world);
    const int a = local.x + offset, b = local.y + offset, c = local.z + offset;
    const glm::vec3 displacement = (x[a] - x_previous[a]) + (x[b] - x_previous[b]) + (x[c] - x_previous[c]);
    const glm::vec3 relative = inverse_dt / 3.0f * displacement - wind;
    const glm::vec3& n = normal[i];
    const float vn = glm::dot(relative, n);
    const float qa = density * 0.5f * drag_coefficient[triangle] * area[i];
    const float flux = qa * vn;
    const glm::vec3 f = n * (std::abs(vn) * flux / -3.0f);
    atomic_add(&force[a], f);
    atomic_add(&force[b], f);
    atomic_add(&force[c], f);
    tangent_scalar[i] = std::abs(vn) * (qa + qa) * inverse_dt / 9.0f;
}

// Drag preconditioner: c n n^T on the diagonal blocks of the three vertices.
__global__ void add_triangle_drag_preconditioner(const glm::ivec3* triangles, const glm::vec3* normal,
                                                 const float* tangent_scalar, glm::mat3* preconditioner, size_t count,
                                                 size_t triangles_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const glm::ivec3 local = triangles[triangle];
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::vec3 n = normal[i];
    const float xx = n.x * n.x, yx = n.y * n.x, zx = n.z * n.x, yy = n.y * n.y, zy = n.z * n.y, zz = n.z * n.z;
    const float c = tangent_scalar[i];
    const glm::mat3 block(c * xx, c * yx, c * zx, c * yx, c * yy, c * zy, c * zx, c * zy, c * zz);
    atomic_add(&preconditioner[local.x + offset], block);
    atomic_add(&preconditioner[local.y + offset], block);
    atomic_add(&preconditioner[local.z + offset], block);
}

}  // namespace synreal::kernel
