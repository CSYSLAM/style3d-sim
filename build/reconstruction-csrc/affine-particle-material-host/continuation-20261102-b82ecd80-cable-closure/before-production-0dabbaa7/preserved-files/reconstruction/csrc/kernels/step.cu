// Per-substep Newton bookkeeping kernels of synreal::SolverNewton.
#include "types.cuh"

namespace synreal::kernel {

// x_out = x + dx after a Newton iteration; dx is cleared for the next linear solve.
__global__ void apply_nonlinear_step(const glm::vec3* x, glm::vec3* x_out, glm::vec3* dx, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    x_out[i] = x[i] + dx[i];
    dx[i] = glm::vec3(0.0f);
}

// Velocity of the finished substep, v = (x - x_previous) / h with the host-computed reciprocal 1 / h.
__global__ void update_velocity(float inverse_dt, const glm::vec3* x_previous, const glm::vec3* x, glm::vec3* v,
                                size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    v[i] = (x[i] - x_previous[i]) * inverse_dt;
}

// Diagonal blocks m * I of the system matrix (and optionally of a second copy, e.g. the inertial cache).
// The identity is scaled as a matrix, so the off-diagonal entries are m * 0 (NaN/-0 propagate as in the legacy).
__global__ void initialize_block_diagonal(const float* mass, glm::mat3* diagonal, glm::mat3* copy, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const glm::mat3 block = mass[i] * glm::mat3(1.0f);
    diagonal[i] = block;
    if (copy) copy[i] = block;
}

// Off-diagonal ELL values of the Newton system from the slot-aligned template matrices of one model:
// A0 + scale * (A1 + w1 A2 + ... + w5 A6). All templates share the sparsity pattern (columns) of A0.
__global__ void combine_system_non_diagonal(float scale, float w1, float w2, float w3, float w4, float w5,
                                            const NonZeroEntry* a0, const NonZeroEntry* a1, const NonZeroEntry* a2,
                                            const NonZeroEntry* a3, const NonZeroEntry* a4, const NonZeroEntry* a5,
                                            const NonZeroEntry* a6, NonZeroEntry* out, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    out[i].column = a0[i].column;
    out[i].value = (a1[i].value + a2[i].value * w1 + a3[i].value * w2 + a4[i].value * w3 + a5[i].value * w4
                    + a6[i].value * w5) * scale + a0[i].value;
}

// Inertial-cache refresh of the off-diagonal ELL values from the per-entry contribution lists (CSR): entry e of the
// first matrix gets the sum of its list, of the second the negated sum, both accumulated in list order from +0.
// Entries with an empty list keep their value.
__global__ void refresh_inertial_cache_nonzeros(const float* values_a, const size_t* offsets_a, const int* ids_a,
                                                const float* values_b, const size_t* offsets_b, const int* ids_b,
                                                NonZeroEntry* entries_a, NonZeroEntry* entries_b, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t begin_a = offsets_a[i], end_a = offsets_a[i + 1];
    if (begin_a != end_a) {
        float sum = 0.0f;
        for (size_t k = begin_a; k < end_a; ++k) sum += values_a[ids_a[k]];
        entries_a[i].value = sum;
    }
    const size_t begin_b = offsets_b[i], end_b = offsets_b[i + 1];
    if (begin_b != end_b) {
        float sum = 0.0f;
        for (size_t k = begin_b; k < end_b; ++k) sum -= values_b[ids_b[k]];
        entries_b[i].value = sum;
    }
}

// Inertial-cache refresh of the diagonal: s = sum of the row's contributions; stores 3 s and s.
__global__ void refresh_inertial_cache_diagonals(const float* values, const size_t* offsets, const int* ids,
                                                 float* scaled, float* sum, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t begin = offsets[i], end = offsets[i + 1];
    if (begin == end) return;
    float s = 0.0f;
    for (size_t k = begin; k < end; ++k) s += values[ids[k]];
    scaled[i] = s * 3.0f;
    sum[i] = s;
}

// Start of a substep for particle i (in-world index p = i % per_world):
//   previous = x;
//   inactive (mass <= 0 or no ACTIVE flag): x_hat = x, diagonal = 0; affine-body particles (kind != 0) get
//     previous = x - h v so that update_velocity reproduces their velocity;
//   active: diagonal = host_diagonal[p] + (m + sum_k D_k[p] c_k) / h^2 and x_hat = x + h v + h^2 g, also written
//     back to x. g is the gravity of the particle's world (index clamped to the gravity array), zero for affine
//     columns (kind 2) or without gravity.
__global__ void initialize_step(float dt, const glm::vec3* gravity, size_t gravity_count, const int* particle_world,
                                const glm::vec3* velocity, glm::vec3* x, const float* host_diagonal, const float* d1,
                                float c1, const float* d2, float c2, const float* d3, float c3, const float* d4,
                                float c4, const float* d5, float c5, const float* mass, const int* flags,
                                const int* kind, glm::vec3* previous, glm::vec3* x_hat, float* diagonal, size_t count,
                                size_t per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t particle = i % per_world;
    const glm::vec3 position = x[i];
    const float m = mass[particle];
    const bool active = m > 0.0f && (flags == nullptr || (flags[particle] & 1));
    previous[i] = position;
    if (!active) {
        if (kind != nullptr && kind[particle] != 0) previous[i] = position - velocity[i] * dt;
        x_hat[i] = position;
        diagonal[i] = 0.0f;
        return;
    }
    const int world = particle_world != nullptr ? particle_world[particle] : static_cast<int>(i / per_world);
    const bool affine_column = kind != nullptr && kind[particle] == 2;
    glm::vec3 g(0.0f);
    if (gravity_count != 0 && !affine_column) g = gravity[min(max(world, 0), static_cast<int>(gravity_count) - 1)];
    const glm::vec3 v = velocity[i];
    float inertia = m;
    inertia += d1[particle] * c1;
    inertia += d2[particle] * c2;
    inertia += d3[particle] * c3;
    inertia += d4[particle] * c4;
    inertia += d5[particle] * c5;
    const float dt2 = dt * dt;
    diagonal[i] = host_diagonal[particle] + inertia / dt2;
    const glm::vec3 prediction = position + v * dt + dt2 * g;
    x_hat[i] = prediction;
    x[i] = prediction;
}

// Newton right-hand side rhs = (m (target - x) + sum_j M_ij (target_j - x_j)) / h^2 + base, zero for inactive
// particles. The optional off-diagonal mass rows (affine-body second moments) are scalar ELL entries of one world,
// slot-major (entries[slot * per_world + p]), with in-world columns; columns outside the world or past the particle
// count are ignored.
__global__ void initialize_rhs(float inverse_dt2, const glm::vec3* x, const glm::vec3* target, const float* mass,
                               const int* row_count, const NonZeroEntry* entries, size_t max_count,
                               const glm::vec3* base, const int* mask, glm::vec3* rhs, size_t count, size_t per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t particle = i % per_world;
    const float m = mass[particle];
    if (!(m > 0.0f) || (mask != nullptr && !(mask[particle] & 1))) {
        rhs[i] = glm::vec3(0.0f);
        return;
    }
    const glm::vec3 inertia = m * (target[i] - x[i]);
    glm::vec3 coupling(0.0f);
    if (max_count != 0) {
        const size_t world_base = i - particle;
        const int slots = min(max(row_count[particle], 0), static_cast<int>(max_count));
        for (int k = 0; k < slots; ++k) {
            const NonZeroEntry entry = entries[k * per_world + particle];
            const int column = entry.column;
            if (column < 0 || static_cast<size_t>(column) >= per_world) continue;
            const size_t j = world_base + column;
            if (j >= count) continue;
            coupling = coupling + entry.value * (target[j] - x[j]);
        }
    }
    const glm::vec3 b = base != nullptr ? base[i] : glm::vec3(0.0f);
    rhs[i] = (inertia + coupling) * inverse_dt2 + b;
}

}  // namespace synreal::kernel
