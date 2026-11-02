// Affine bodies (ABD): each body is four state particles, the translation x and the columns of the affine matrix
// A = [y z w]. The SO(3) augmented-Lagrangian rigidity keeps A close to a rotation R with multiplier matrix Lambda.
#include "affine_geometry.cuh"

namespace synreal::kernel {

// Rigidity force -(w alpha) R sym(G^T R) on the affine columns, G = (A - R) + Lambda. The translation particle gets
// an explicit zero contribution (it has no rigidity term).
__global__ void evaluate_affine_body_so3_augmented_lagrangian_force(const glm::vec3* x, const glm::ivec4* body_particles,
                                                                    const float* weight, const glm::mat3* rotation,
                                                                    const glm::mat3* multiplier, float alpha,
                                                                    glm::vec3* force, size_t count,
                                                                    size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::vec3& a0 = x[particles.y];
    const glm::vec3& a1 = x[particles.z];
    const glm::vec3& a2 = x[particles.w];
    const glm::mat3& r = rotation[i];
    const glm::mat3& lambda = multiplier[i];
    const float scale = weight[body] * alpha;
    const glm::mat3 g(a0 - r[0] + lambda[0], a1 - r[1] + lambda[1], a2 - r[2] + lambda[2]);
    const glm::mat3 s = glm::transpose(g) * r;
    const glm::mat3 y = (s + glm::transpose(s)) * 0.5f;
    const glm::mat3 f = r * y * -scale;
    atomic_add(&force[particles.x], glm::vec3(0.0f));
    atomic_add(&force[particles.y], f[0]);
    atomic_add(&force[particles.z], f[1]);
    atomic_add(&force[particles.w], f[2]);
}

// Rigidity tangent times a direction: the affine columns receive (w alpha) R sym(D^T R), D = [p_y p_z p_w].
__global__ void multiply_affine_body_so3_augmented_lagrangian_tangent(const glm::vec3* p,
                                                                      const glm::ivec4* body_particles,
                                                                      const float* weight, const glm::mat3* rotation,
                                                                      float alpha, glm::vec3* product, size_t count,
                                                                      size_t bodies_per_world,
                                                                      size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 d(p[particles.y], p[particles.z], p[particles.w]);
    const glm::mat3& r = rotation[i];
    const float scale = weight[body] * alpha;
    const glm::mat3 s = glm::transpose(d) * r;
    const glm::mat3 y = (s + glm::transpose(s)) * 0.5f;
    const glm::mat3 f = r * y * scale;
    atomic_add(&product[particles.y], f[0]);
    atomic_add(&product[particles.z], f[1]);
    atomic_add(&product[particles.w], f[2]);
}

// Start of a step: R = nearest rotation to A, Lambda = 0.
__global__ void initialize_affine_body_so3_state(const glm::vec3* x, const glm::ivec4* body_particles,
                                                 glm::mat3* rotation, glm::mat3* multiplier, size_t count,
                                                 size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    rotation[i] = nearest_rotation(x[particles.y], x[particles.z], x[particles.w]);
    multiplier[i] = glm::mat3(0.0f);
}

// After a Newton iteration: B = A + Lambda, R = nearest rotation to B and, when the multiplier step is due,
// Lambda = R sym((B - R)^T R).
__global__ void update_affine_body_so3_augmented_lagrangian_state(const glm::vec3* x, const glm::ivec4* body_particles,
                                                                  glm::mat3* rotation, glm::mat3* multiplier,
                                                                  bool update_multiplier, size_t count,
                                                                  size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 b = glm::mat3(x[particles.y], x[particles.z], x[particles.w]) + multiplier[i];
    const glm::mat3 r = nearest_rotation(b[0], b[1], b[2]);
    rotation[i] = r;
    if (!update_multiplier) return;
    const glm::mat3 s = glm::transpose(b - r) * r;
    multiplier[i] = r * ((s + glm::transpose(s)) * 0.5f);
}

// Diagonal 3x3 blocks of the rigidity tangent: the tangent applied to the unit direction e_c placed in affine
// column j gives block column c of column j's particle. Built literally from unit matrices (the multiplications
// by zero are kept, so NaN/inf in R propagate exactly as in the full tangent).
__global__ void add_affine_body_so3_augmented_lagrangian_preconditioner(const glm::ivec4* body_particles,
                                                                       const float* weight,
                                                                       const glm::mat3* rotation, float alpha,
                                                                       glm::mat3* preconditioner, size_t count,
                                                                       size_t bodies_per_world,
                                                                       size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const float scale = weight[body] * alpha;
    const glm::mat3& r = rotation[i];
    for (int column = 0; column < 3; ++column) {
        glm::mat3 block;
        for (int c = 0; c < 3; ++c) {
            glm::mat3 d(0.0f);
            d[column][c] = 1.0f;
            const glm::mat3 s = glm::transpose(d) * r;
            block[c] = scale * (r * ((s + glm::transpose(s)) * 0.5f))[column];
        }
        atomic_add(&preconditioner[particles[column + 1]], block);
    }
}

// External torque tau on an affine body as particle forces. With J the body inertia, K = (tr J / 2) I - J,
// M = A K and E = tr(N) I - N for N = A M^T, the angular velocity direction is omega = E^-1 tau (cofactor inverse;
// skipped when det E is not a finite value > 1e-30 or omega is not finite) and column j receives omega x M_j.
// Bodies with |tau| <= 1e-12 in every component are skipped; the translation gets an explicit zero.
__global__ void apply_affine_body_torques(const glm::vec3* x, const glm::ivec4* body_particles,
                                          const glm::mat3* inertia, const glm::vec3* torque, glm::vec3* force,
                                          size_t count, size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const glm::vec3 tau = torque[i];
    if (std::abs(tau.x) <= 1e-12f && std::abs(tau.y) <= 1e-12f && std::abs(tau.z) <= 1e-12f) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 a(x[particles.y], x[particles.z], x[particles.w]);
    const glm::mat3& j = inertia[body];
    const float half_trace = (j[0][0] + j[1][1] + j[2][2]) * 0.5f;
    const glm::mat3 k = half_trace * glm::mat3(1.0f) - j;
    const glm::mat3 m = a * k;
    const glm::mat3 n = a * glm::transpose(m);
    const float trace = n[0][0] + n[1][1] + n[2][2];
    const glm::mat3 e = trace * glm::mat3(1.0f) - n;
    // Cofactor inverse of E (glm e[c][r] = E_rc).
    const float c00 = e[1][1] * e[2][2] - e[1][2] * e[2][1];
    const float c01 = e[2][1] * e[0][2] - e[2][2] * e[0][1];
    const float c02 = e[0][1] * e[1][2] - e[1][1] * e[0][2];
    const float determinant = e[0][0] * c00 + e[1][0] * c01 + e[2][0] * c02;
    if (!(determinant > 1e-30f) || !std::isfinite(determinant)) return;
    const float r = 1.0f / determinant;
    const float i00 = c00 * r, i01 = c01 * r, i02 = c02 * r;
    const float i10 = (e[1][2] * e[2][0] - e[2][2] * e[1][0]) * r;
    const float i11 = (e[2][2] * e[0][0] - e[2][0] * e[0][2]) * r;
    const float i12 = (e[0][2] * e[1][0] - e[0][0] * e[1][2]) * r;
    const float i20 = (e[1][0] * e[2][1] - e[1][1] * e[2][0]) * r;
    const float i21 = (e[2][0] * e[0][1] - e[0][0] * e[2][1]) * r;
    const float i22 = (e[0][0] * e[1][1] - e[0][1] * e[1][0]) * r;
    const glm::vec3 omega(tau.x * i00 + i01 * tau.y + i02 * tau.z, tau.x * i10 + i11 * tau.y + i12 * tau.z,
                          tau.x * i20 + i21 * tau.y + i22 * tau.z);
    if (!std::isfinite(omega.x) || !std::isfinite(omega.y) || !std::isfinite(omega.z)) return;
    atomic_add(&force[particles.x], glm::vec3(0.0f));
    atomic_add(&force[particles.y], glm::cross(omega, m[0]));
    atomic_add(&force[particles.z], glm::cross(omega, m[1]));
    atomic_add(&force[particles.w], glm::cross(omega, m[2]));
}

// Force of one six-spring rigidity spring along v: v (k e) / |v| with strain e = |v| - rest, snapped to zero when
// |e| <= snap (and no force for |v| <= 0). |v|^2 = fma(z, z, fma(y, y, x x)) as written with explicit fmaf.
__device__ __forceinline__ glm::vec3 rigidity_spring_force(const glm::vec3& v, float k, float rest, float snap)
{
    const float length = std::sqrt(fmaf(v.z, v.z, fmaf(v.y, v.y, v.x * v.x)));
    if (!(length > 0.0f)) return glm::vec3(0.0f);
    float strain = length - rest;
    if (std::abs(strain) <= snap) strain = 0.0f;
    return v * (k * strain) / length;
}

// SIX_SPRINGS rigidity: springs on the affine columns (rest 1) and on their differences (rest sqrt 2) with
// stiffness w alpha. Column forces accumulate from zero; the translation receives an explicit zero.
__global__ void evaluate_affine_body_spring_force(const glm::vec3* x, const glm::ivec4* body_particles,
                                                  const float* weight, float alpha, glm::vec3* force, size_t count,
                                                  size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const float k = weight[body] * alpha;
    const glm::vec3& a0 = x[particles.y];
    const glm::vec3& a1 = x[particles.z];
    const glm::vec3& a2 = x[particles.w];
    const float unit_snap = 9.5367431640625e-07f;      // 2^-20
    const float diagonal_snap = 1.3486991523486091e-06f;  // sqrt(2) 2^-20
    const float sqrt2 = 1.41421356f;
    glm::vec3 f0 = glm::vec3(0.0f) - rigidity_spring_force(a0, k, 1.0f, unit_snap);
    glm::vec3 f1 = glm::vec3(0.0f) - rigidity_spring_force(a1, k, 1.0f, unit_snap);
    glm::vec3 f2 = glm::vec3(0.0f) - rigidity_spring_force(a2, k, 1.0f, unit_snap);
    const glm::vec3 f10 = rigidity_spring_force(a1 - a0, k, sqrt2, diagonal_snap);
    f0 = f0 + f10;
    f1 = f1 - f10;
    const glm::vec3 f20 = rigidity_spring_force(a2 - a0, k, sqrt2, diagonal_snap);
    f0 = f0 + f20;
    f2 = f2 - f20;
    const glm::vec3 f21 = rigidity_spring_force(a2 - a1, k, sqrt2, diagonal_snap);
    f1 = f1 + f21;
    f2 = f2 - f21;
    atomic_add(&force[particles.x], glm::vec3(0.0f));
    atomic_add(&force[particles.y], f0);
    atomic_add(&force[particles.z], f1);
    atomic_add(&force[particles.w], f2);
}

// Gauss-Newton correction k (M - I) of a six-spring rigidity spring along v: M = n n^T + s (I - n n^T) with
// s = max(0, 1 - 1/|v|) for a column spring and max(0, 1 - sqrt(2)/|v|) for a column-difference spring; M = I when
// |v| <= 1e-8.
__device__ __forceinline__ glm::mat3 rigidity_spring_correction(const glm::vec3& v, float k, bool column)
{
    const float length = glm::length(v);
    glm::mat3 m(1.0f);
    if (length > 1e-8f) {
        const glm::vec3 n = v / length;
        const glm::mat3 nn = glm::outerProduct(n, n);
        const float s = fmaxf(0.0f, column ? 1.0f - 1.0f / length : -1.41421356f / length + 1.0f);
        m = (glm::mat3(1.0f) - nn) * s + nn;
    }
    return k * (m - glm::mat3(1.0f));
}

// SIX_SPRINGS rigidity Gauss-Newton Hessian, one thread per body: column springs into the column diagonals, then
// (when k > 0) each column pair (i, j): the correction into both diagonals and its negation into blocks (i, j) and
// (j, i) of the off-diagonal ELL matrix (or the diagonal when both columns are the same particle).
__global__ void add_affine_body_spring_gauss_newton_hessian(const glm::vec3* x, const glm::ivec4* body_particles,
                                                            const float* weight, float alpha, glm::mat3* diagonal,
                                                            const int* row_count, BlockNonZeroEntry* entries,
                                                            size_t max_count, size_t count, size_t bodies_per_world,
                                                            size_t particles_per_world, size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const float k = weight[body] * alpha;
    for (int c = 1; c < 4; ++c)
        atomic_add(&diagonal[particles[c]], rigidity_spring_correction(x[particles[c]], k, true));
    if (!(k > 0.0f)) return;
    for (int a = 1; a < 4; ++a) {
        for (int b = a + 1; b < 4; ++b) {
            const int ci = particles[a], cj = particles[b];
            const glm::mat3 block = rigidity_spring_correction(x[cj] - x[ci], k, false);
            atomic_add(&diagonal[ci], block);
            atomic_add(&diagonal[cj], block);
            const glm::mat3 negative = -block;
            if (ci == cj) atomic_add(&diagonal[ci], negative);
            else atomic_add_block(row_count, entries, max_count, rows, ci, cj, negative);
            if (cj == ci) atomic_add(&diagonal[cj], negative);
            else atomic_add_block(row_count, entries, max_count, rows, cj, ci, negative);
        }
    }
}

// r . a with x^2-style ordering: fma(rz, az, fma(ry, ay, rx ax)) (explicit fmaf).
__device__ __forceinline__ float dot_x_first(const glm::vec3& r, const glm::vec3& a)
{
    return fmaf(r.z, a.z, fmaf(r.y, a.y, r.x * a.x));
}

// Column gradients G of the constitutive rigidity energy (before the -weight alpha scale).
//   ABD_ORTHOGONALITY: G = (A A^T - I) A.
//   CO_ROTATED (and any other model): R = nearest rotation, S = R^T A, P = (S + S^T - 2 I) + (tr S - 3) I, G = R P.
__device__ __forceinline__ glm::mat3 constitutive_gradient(const glm::mat3& a, AffineBodyRigidityModel model)
{
    if (model == AffineBodyRigidityModel::AbdOrthogonality)
        return (a * glm::transpose(a) - glm::mat3(1.0f)) * a;
    const glm::mat3 r = nearest_rotation(a[0], a[1], a[2]);
    glm::mat3 s;
    for (int j = 0; j < 3; ++j)
        for (int i = 0; i < 3; ++i) s[j][i] = dot_x_first(r[i], a[j]);
    const glm::mat3 e = s + glm::transpose(s) - 2.0f * glm::mat3(1.0f);
    const float trace = s[0][0] + s[1][1] + s[2][2] - 3.0f;
    const glm::mat3 p = e + trace * glm::mat3(1.0f);
    // G = R P written per column; the second column leads with its diagonal term, which decides the rounded
    // product of the fma chain.
    return glm::mat3(r[0] * p[0][0] + r[1] * p[0][1] + r[2] * p[0][2],
                     r[1] * p[1][1] + r[0] * p[1][0] + r[2] * p[1][2],
                     r[0] * p[2][0] + r[1] * p[2][1] + r[2] * p[2][2]);
}

// Directional derivative of the column gradients along D (before the weight alpha scale).
//   ABD_ORTHOGONALITY: G = (A D^T + D A^T) A.
//   CO_ROTATED: T = R^T D, P = (T + T^T) + tr(T) I, G = R P (R frozen).
__device__ __forceinline__ glm::mat3 constitutive_tangent(const glm::mat3& a, const glm::mat3& d,
                                                         AffineBodyRigidityModel model)
{
    if (model == AffineBodyRigidityModel::AbdOrthogonality) {
        const glm::mat3 m = a * glm::transpose(d);
        return (m + glm::transpose(m)) * a;
    }
    const glm::mat3 r = nearest_rotation(a[0], a[1], a[2]);
    const glm::mat3 t = glm::transpose(r) * d;
    const float trace = t[0][0] + t[1][1] + t[2][2];
    return r * (t + glm::transpose(t) + trace * glm::mat3(1.0f));
}

// Constitutive rigidity force: column j receives -(w alpha) G_j, the translation an explicit -0 scaled term.
__global__ void evaluate_affine_body_constitutive_force(const glm::vec3* x, const glm::ivec4* body_particles,
                                                        const float* weight, float alpha,
                                                        AffineBodyRigidityModel model, glm::vec3* force,
                                                        size_t count, size_t bodies_per_world,
                                                        size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 g = constitutive_gradient(glm::mat3(x[particles.y], x[particles.z], x[particles.w]), model);
    const float scale = weight[body] * alpha;
    atomic_add(&force[particles.x], glm::vec3(scale * -0.0f));
    atomic_add(&force[particles.y], g[0] * -scale);
    atomic_add(&force[particles.z], g[1] * -scale);
    atomic_add(&force[particles.w], g[2] * -scale);
}

// Constitutive rigidity tangent times a direction: column j receives (w alpha) G_j(D), the translation s 0.
__global__ void multiply_affine_body_constitutive_tangent(const glm::vec3* x, const glm::vec3* p,
                                                          const glm::ivec4* body_particles, const float* weight,
                                                          float alpha, AffineBodyRigidityModel model,
                                                          glm::vec3* product, size_t count, size_t bodies_per_world,
                                                          size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 g = constitutive_tangent(glm::mat3(x[particles.y], x[particles.z], x[particles.w]),
                                             glm::mat3(p[particles.y], p[particles.z], p[particles.w]), model);
    const float scale = weight[body] * alpha;
    atomic_add(&product[particles.x], glm::vec3(scale * 0.0f));
    atomic_add(&product[particles.y], scale * g[0]);
    atomic_add(&product[particles.z], scale * g[1]);
    atomic_add(&product[particles.w], scale * g[2]);
}

// Diagonal blocks of the constitutive tangent: block column k of column j's particle is (w alpha) G_j for the
// unit direction e_k placed in column j (built literally from unit matrices); the translation gets s 0.
__global__ void add_affine_body_constitutive_preconditioner(const glm::vec3* x, const glm::ivec4* body_particles,
                                                            const float* weight, float alpha,
                                                            AffineBodyRigidityModel model, glm::mat3* preconditioner,
                                                            size_t count, size_t bodies_per_world,
                                                            size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::mat3 a(x[particles.y], x[particles.z], x[particles.w]);
    const float scale = weight[body] * alpha;
    atomic_add(&preconditioner[particles.x], glm::mat3(scale * 0.0f));
    for (int column = 0; column < 3; ++column) {
        glm::mat3 block;
        for (int k = 0; k < 3; ++k) {
            glm::mat3 d(0.0f);
            d[column][k] = 1.0f;
            block[k] = scale * constitutive_tangent(a, d, model)[column];
        }
        atomic_add(&preconditioner[particles[column + 1]], block);
    }
}

}  // namespace synreal::kernel
