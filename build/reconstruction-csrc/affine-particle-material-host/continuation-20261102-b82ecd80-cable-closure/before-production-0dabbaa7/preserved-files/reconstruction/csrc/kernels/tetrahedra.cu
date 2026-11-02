// Volumetric tetrahedra (stable Neo-Hookean-style elasticity with optional strain-rate damping).
#include "common.cuh"

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
    const float scale = bulk * (activation[tet] + (determinant - target));
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

// Derivatives of (F^T F)_ab along the vertex gradient h, in kernel order t00, t01, t02, t11, t12, t22.
struct DampingBasis {
    glm::vec3 t00, t01, t02, t11, t12, t22;
};

__device__ __forceinline__ DampingBasis damping_basis(const Deformation& f, float h0, float h1, float h2)
{
    return DampingBasis{f.c0 * (h0 + h0),     f.c1 * h0 + f.c0 * h1, f.c2 * h0 + f.c0 * h2,
                        f.c1 * (h1 + h1),     f.c2 * h1 + f.c1 * h2, f.c2 * (h2 + h2)};
}

// Matrix-free tangent K p: elastic V (dP h_k) with dP = mu dF + (mu + lambda) (cof F : dF) cof F, plus the
// Gauss-Newton strain-rate damping (c V / h) sum_ab dS_ab t_ab with dS = d(F^T F) along p (c > 0 only).
__global__ void multiply_tetrahedron_tangent(const glm::vec3* x, const glm::vec3* p, const glm::ivec4* tetrahedra,
                                             const glm::mat3* inverse_rest, const glm::vec3* materials,
                                             const float* volume, float inverse_dt, glm::vec3* product, size_t count,
                                             size_t tetrahedra_per_world, size_t particles_per_world)
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
    const Deformation d = deformation(p, v[0], v[1], v[2], v[3], a);
    const glm::vec3 k12 = glm::cross(f.c1, f.c2), k20 = glm::cross(f.c2, f.c0), k01 = glm::cross(f.c0, f.c1);
    const glm::vec3 material = materials[tet];
    const float mu = material.x, damping = material.z;
    const float scale = (mu + material.y) * (glm::dot(k12, d.c0) + glm::dot(k20, d.c1) + glm::dot(k01, d.c2));
    const glm::vec3 dp0 = mu * d.c0 + k12 * scale;
    const glm::vec3 dp1 = mu * d.c1 + k20 * scale;
    const glm::vec3 dp2 = mu * d.c2 + k01 * scale;
    float s00 = glm::dot(f.c0, d.c0);
    s00 = s00 + s00;
    float s01 = glm::dot(f.c1, d.c0) + glm::dot(f.c0, d.c1);
    s01 = s01 + s01;
    float s02 = glm::dot(f.c2, d.c0) + glm::dot(f.c0, d.c2);
    s02 = s02 + s02;
    float s11 = glm::dot(f.c1, d.c1);
    s11 = s11 + s11;
    float s12 = glm::dot(f.c2, d.c1) + glm::dot(f.c1, d.c2);
    s12 = s12 + s12;
    float s22 = glm::dot(f.c2, d.c2);
    s22 = s22 + s22;
    const float vol = volume[tet];
    const float weight = damping * vol * inverse_dt;
    const glm::vec3 h[4] = {-a[0] - a[1] - a[2], a[0], a[1], a[2]};
    for (int k = 0; k < 4; ++k) {
        const float h0 = h[k].x, h1 = h[k].y, h2 = h[k].z;
        glm::vec3 value = vol * (dp0 * h0 + dp1 * h1 + dp2 * h2);
        if (damping > 0.0f) {
            const DampingBasis t = damping_basis(f, h0, h1, h2);
            const glm::vec3 total = s00 * t.t00 + s01 * t.t01 + s02 * t.t02 + s11 * t.t11 + s12 * t.t12 + s22 * t.t22;
            value = weight * total + value;
        }
        atomic_add(&product[v[k]], value);
    }
}

// Diagonal blocks of the tetrahedron tangent for the preconditioner: per vertex mu V |h|^2 I +
// (mu + lambda) V cg cg^T with cg = cof F h, plus (c V / h) sum over the strain-rate basis (off-diagonal basis
// terms weighted twice) when the damping c > 0.
__global__ void add_tetrahedron_preconditioner(const glm::vec3* x, const glm::ivec4* tetrahedra,
                                               const glm::mat3* inverse_rest, const glm::vec3* materials,
                                               const float* volume, float inverse_dt, glm::mat3* preconditioner,
                                               size_t count, size_t tetrahedra_per_world, size_t particles_per_world)
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
    const glm::vec3 k12 = glm::cross(f.c1, f.c2), k20 = glm::cross(f.c2, f.c0), k01 = glm::cross(f.c0, f.c1);
    const glm::vec3 material = materials[tet];
    const float mu = material.x, damping = material.z;
    const float vol = volume[tet];
    const float w_mu = mu * vol;
    const float w_bulk = (mu + material.y) * vol;
    const float w_damp = damping * vol * inverse_dt;
    const glm::vec3 h[4] = {-a[0] - a[1] - a[2], a[0], a[1], a[2]};
    for (int k = 0; k < 4; ++k) {
        const float h0 = h[k].x, h1 = h[k].y, h2 = h[k].z;
        const glm::vec3 cg = k12 * h0 + k20 * h1 + k01 * h2;
        const float iso = w_mu * glm::dot(h[k], h[k]);
        glm::mat3 block = iso * glm::mat3(1.0f) + w_bulk * glm::outerProduct(cg, cg);
        if (damping > 0.0f) {
            const DampingBasis t = damping_basis(f, h0, h1, h2);
            for (int column = 0; column < 3; ++column) {
                for (int row = column; row < 3; ++row) {
                    float sum = fmaf(t.t01[row], t.t01[column], t.t01[row] * t.t01[column]);
                    sum = fmaf(t.t00[row], t.t00[column], sum);
                    sum = fmaf(t.t02[row] * t.t02[column], 2.0f, sum);
                    sum = fmaf(t.t11[row], t.t11[column], sum);
                    sum = fmaf(t.t12[row] * t.t12[column], 2.0f, sum);
                    sum = fmaf(t.t22[row], t.t22[column], sum);
                    block[column][row] = fmaf(w_damp, sum, block[column][row]);
                    block[row][column] = block[column][row];
                }
            }
        }
        atomic_add(&preconditioner[v[k]], block);
    }
}

}  // namespace synreal::kernel
