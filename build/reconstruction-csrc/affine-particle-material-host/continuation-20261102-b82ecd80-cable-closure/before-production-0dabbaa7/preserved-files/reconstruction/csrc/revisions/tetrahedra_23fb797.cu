// Volumetric tetrahedra (stable Neo-Hookean-style elasticity with optional strain-rate damping).
#include "../kernels/common.cuh"

namespace synreal::kernel {

// Deformation gradient columns F_j = sum_i e_i A[i][j] (e_i = x_i - x_0, A the inverse rest shape).
struct Deformation {
    glm::vec3 c0, c1, c2;
};

__device__ __forceinline__ Deformation deformation(const glm::vec3* x, int v0, int v1, int v2, int v3,
                                                   const glm::mat3& a)
{
    const glm::vec3& x0 = x[v0];
    const glm::vec3 e1 = x[v1] - x0, e2 = x[v2] - x0, e3 = x[v3] - x0;
    return Deformation{e1 * a[0][0] + e2 * a[1][0] + e3 * a[2][0], e1 * a[0][1] + e2 * a[1][1] + e3 * a[2][1],
                       e1 * a[0][2] + e2 * a[1][2] + e3 * a[2][2]};
}

// Elastic force -V P h_k with P = mu F + (mu + lambda) (activation + det F - target) cof F, target = 1 + mu /
// (mu + lambda) (1 when mu + lambda <= 0), h_k the rest-shape gradient of vertex k. With damping c > 0, the
// strain-rate term -c V sum_ab g_ab t_ab is added, g = (F^T F - F_prev^T F_prev) / h (off-diagonal entries
// doubled) and t_ab the derivative of (F^T F)_ab along h_k.
__global__ void evaluate_tetrahedron_force(const glm::vec3* x, const glm::vec3* previous, const glm::ivec4* tetrahedra,
                                           const glm::mat3* inverse_rest, const glm::vec3* materials,
                                           const float* volume, const float* activation, float inverse_dt,
                                           glm::vec3* force, size_t count, size_t tetrahedra_per_world,
                                           size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / tetrahedra_per_world;
    const size_t tet = i % tetrahedra_per_world;
    const glm::ivec4 local = tetrahedra[tet];
    const int offset = static_cast<int>(world * particles_per_world);
    const int v[4] = {local.x + offset, local.y + offset, local.z + offset, local.w + offset};
    const glm::mat3& a = inverse_rest[tet];
    const Deformation f = deformation(x, v[0], v[1], v[2], v[3], a);
    const glm::vec3 k12 = glm::cross(f.c1, f.c2);
    const float determinant = glm::dot(f.c0, k12);
    const glm::vec3 material = materials[tet];
    const float mu = material.x, damping = material.z;
    const float bulk = mu + material.y;
    const float target = bulk > 0.0f ? mu / bulk + 1.0f : 1.0f;
    // The processed original guards NULL and uses the global tetrahedron-state index.
    const float activation_value = activation ? activation[i] : 0.0f;
    const float scale = bulk * (activation_value + (determinant - target));
    const glm::vec3 k20 = glm::cross(f.c2, f.c0);
    const glm::vec3 k01 = glm::cross(f.c0, f.c1);
    const glm::vec3 p0 = mu * f.c0 + k12 * scale;
    const glm::vec3 p1 = mu * f.c1 + k20 * scale;
    const glm::vec3 p2 = mu * f.c2 + k01 * scale;
    float g00 = 0.0f, g01 = 0.0f, g02 = 0.0f, g11 = 0.0f, g12 = 0.0f, g22 = 0.0f;
    if (damping > 0.0f) {
        const Deformation r = deformation(previous, v[0], v[1], v[2], v[3], a);
        const float d00 = glm::dot(f.c0, f.c0) - glm::dot(r.c0, r.c0);
        const float d01 = glm::dot(f.c0, f.c1) - glm::dot(r.c0, r.c1);
        const float d02 = glm::dot(f.c0, f.c2) - glm::dot(r.c0, r.c2);
        const float d11 = glm::dot(f.c1, f.c1) - glm::dot(r.c1, r.c1);
        const float d12 = glm::dot(f.c1, f.c2) - glm::dot(r.c1, r.c2);
        const float d22 = glm::dot(f.c2, f.c2) - glm::dot(r.c2, r.c2);
        g00 = d00 * inverse_dt;
        g11 = d11 * inverse_dt;
        g22 = d22 * inverse_dt;
        g01 = d01 * inverse_dt + d01 * inverse_dt;
        g02 = d02 * inverse_dt + d02 * inverse_dt;
        g12 = d12 * inverse_dt + d12 * inverse_dt;
    }
    const float weight = damping * volume[tet];
    const float negative_volume = -volume[tet];
    const glm::vec3 h[4] = {-a[0] - a[1] - a[2], a[0], a[1], a[2]};
    for (int k = 0; k < 4; ++k) {
        const float h0 = h[k].x, h1 = h[k].y, h2 = h[k].z;
        glm::vec3 total = (p0 * h0 + p1 * h1 + p2 * h2) * negative_volume;
        if (damping > 0.0f) {
            const glm::vec3 t00 = f.c0 * (h0 + h0);
            const glm::vec3 t01 = f.c1 * h0 + f.c0 * h1;
            const glm::vec3 t02 = f.c2 * h0 + f.c0 * h2;
            const glm::vec3 t11 = f.c1 * (h1 + h1);
            const glm::vec3 t12 = f.c2 * h1 + f.c1 * h2;
            const glm::vec3 t22 = f.c2 * (h2 + h2);
            const glm::vec3 rate = g00 * t00 + g01 * t01 + g02 * t02 + g11 * t11 + g12 * t12 + g22 * t22;
            total = total - weight * rate;
        }
        atomic_add(&force[v[k]], total);
    }
}


}  // namespace synreal::kernel

