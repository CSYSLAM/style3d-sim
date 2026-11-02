// Preconditioned conjugate gradient kernels of the Newton linear solve.
#include <cub/block/block_reduce.cuh>

#include "types.cuh"

namespace synreal::kernel {

// 1 / d for active particles (positive mass and, when flags are given, the ACTIVE bit) with d > 0, else 0.
// Masses and flags are per particle of one world and shared by all worlds.
__global__ void prepare_inverse_preconditioner(const float* diagonal, const float* mass, const int* flags,
                                               float* inverse, size_t count, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t particle = i % particles_per_world;
    const float d = diagonal[i];
    const bool active = mass[particle] > 0.0f && (flags == nullptr || (flags[particle] & 1));
    inverse[i] = active && d > 0.0f ? 1.0f / d : 0.0f;
}

// z = M r with the 3x3 diagonal blocks of the system matrix.
__global__ void apply_block_diagonal_preconditioner(const glm::mat3* blocks, const glm::vec3* r, glm::vec3* z,
                                                    size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    z[i] = blocks[i] * r[i];
}

// p = z + beta p with beta = num[k] / num[k - 1]; the first iteration (k = 0) takes p = z.
__global__ void update_preconditioned_cg_direction(int k, const glm::vec3* z, const float* num, glm::vec3* direction,
                                                   size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    glm::vec3 p = z[i];
    if (k > 0) {
        const float beta = guarded_ratio(num[k], num[k - 1]);
        p += beta * direction[i];
    }
    direction[i] = p;
}

// One CG step with alpha = num[k] / den[k]: r -= alpha A p, x += alpha p.
__global__ void update_solution_and_residual(int k, const float* num, const float* den, const glm::vec3* direction,
                                             const glm::vec3* product, glm::vec3* solution, glm::vec3* residual,
                                             size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const float alpha = guarded_ratio(num[k], den[k]);
    residual[i] = residual[i] - alpha * product[i];
    solution[i] = solution[i] + alpha * direction[i];
}

// p = M r + beta p with beta = num[k] / num[k - 1] (first iteration: p = M r). M is the scalar inverse diagonal
// (float) or the inverted 3x3 diagonal blocks (mat3).
template <typename Preconditioner>
__global__ void update_cg_direction(int k, const Preconditioner* preconditioner, const glm::vec3* residual,
                                    const float* num, glm::vec3* direction, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    glm::vec3 z = preconditioner[i] * residual[i];
    if (k > 0) {
        const float beta = guarded_ratio(num[k], num[k - 1]);
        z += beta * direction[i];
    }
    direction[i] = z;
}

template __global__ void update_cg_direction<float>(int, const float*, const glm::vec3*, const float*, glm::vec3*,
                                                    size_t);
template __global__ void update_cg_direction<glm::mat3>(int, const glm::mat3*, const glm::vec3*, const float*,
                                                        glm::vec3*, size_t);

// Block-ELL copy of the scalar ELL matrix for all worlds: slot-major layout entries[slot * rows + row], one world's
// rows repeated per world with the column shifted by the world's first row. Slots past the row's count stay unset.
__global__ void initialize_block_non_diagonal(const NonZeroEntry* entries, const int* row_count, size_t rows_per_world,
                                              size_t max_count, BlockNonZeroEntry* blocks, size_t rows)
{
    const size_t i = thread_index();
    if (i >= max_count * rows) return;
    const size_t slot = i / rows;
    const size_t row = i % rows;
    const size_t local_row = row % rows_per_world;
    if (slot >= row_count[local_row]) return;
    const size_t world_offset = row - local_row;
    const NonZeroEntry entry = (entries + slot * rows_per_world)[local_row];
    blocks[i].column = entry.column + static_cast<int>(world_offset);
    blocks[i].value = entry.value * glm::mat3(1.0f);
}

// First PCG iteration with x0 = 0: r = b, x = 0, and the block's partial sum of r . (M r) for the initial residual
// norm (summed over blocks by the host-side reduction).
template <unsigned BlockSize, typename Preconditioner>
__global__ void initialize_zero_solution_and_reduce(const glm::vec3* rhs, const Preconditioner* preconditioner,
                                                    glm::vec3* residual, glm::vec3* solution, float* partial,
                                                    size_t count)
{
    using BlockReduce = cub::BlockReduce<float, BlockSize>;
    __shared__ typename BlockReduce::TempStorage reduction_storage;
    const size_t i = thread_index();
    float value = 0.0f;
    if (i < count) {
        const glm::vec3 r = rhs[i];
        residual[i] = r;
        solution[i] = glm::vec3(0.0f);
        value = glm::dot(preconditioner[i] * r, r);
    }
    const float total = BlockReduce(reduction_storage).Sum(value);
    if (threadIdx.x == 0) partial[blockIdx.x] = total;
}

template __global__ void initialize_zero_solution_and_reduce<256u, glm::mat3>(const glm::vec3*, const glm::mat3*,
                                                                               glm::vec3*, glm::vec3*, float*, size_t);

// CG step x += alpha p, r -= alpha A p (alpha = num[k] / den[k]); optionally the block's partial sum of
// r . (M r) for the next iteration's numerator.
template <unsigned BlockSize, typename Preconditioner>
__global__ void update_solution_residual_and_reduce(int k, const float* num, const float* den,
                                                    const glm::vec3* direction, const glm::vec3* product,
                                                    const Preconditioner* preconditioner, glm::vec3* solution,
                                                    glm::vec3* residual, float* partial, bool reduce, size_t count)
{
    using BlockReduce = cub::BlockReduce<float, BlockSize>;
    __shared__ typename BlockReduce::TempStorage reduction_storage;
    const size_t i = thread_index();
    float value = 0.0f;
    if (i < count) {
        const float alpha = guarded_ratio(num[k], den[k]);
        const glm::vec3 r = residual[i] - alpha * product[i];
        residual[i] = r;
        solution[i] = solution[i] + alpha * direction[i];
        if (reduce) value = glm::dot(r, preconditioner[i] * r);
    }
    if (!reduce) return;
    const float total = BlockReduce(reduction_storage).Sum(value);
    if (threadIdx.x == 0) partial[blockIdx.x] = total;
}

template __global__ void update_solution_residual_and_reduce<256u, glm::mat3>(int, const float*, const float*,
                                                                               const glm::vec3*, const glm::vec3*,
                                                                               const glm::mat3*, glm::vec3*,
                                                                               glm::vec3*, float*, bool, size_t);

// Inverse of the symmetrised 3x3 block by cofactors; when the determinant is not a finite value > 1e-30 the
// reciprocals of the positive diagonal entries are used instead (zero for non-positive ones).
__device__ __forceinline__ glm::mat3 invert_symmetrized(const glm::mat3& m)
{
    const float s01 = (m[0][1] + m[1][0]) * 0.5f;
    const float s02 = (m[0][2] + m[2][0]) * 0.5f;
    const float s12 = (m[1][2] + m[2][1]) * 0.5f;
    const float s00 = m[0][0], s11 = m[1][1], s22 = m[2][2];
    const float c00 = s11 * s22 - s12 * s12;
    const float c01 = s02 * s12 - s01 * s22;
    const float c02 = s01 * s12 - s11 * s02;
    const float determinant = s00 * c00 + s01 * c01 + s02 * c02;
    const float c11 = s00 * s22 - s02 * s02;
    const float c12 = s01 * s02 - s00 * s12;
    const float c22 = s00 * s11 - s01 * s01;
    if (determinant > 1e-30f && std::isfinite(determinant)) {
        const float inverse = 1.0f / determinant;
        return glm::mat3(c00 * inverse, c01 * inverse, c02 * inverse, c01 * inverse, c11 * inverse, c12 * inverse,
                         c02 * inverse, c12 * inverse, c22 * inverse);
    }
    return glm::mat3(s00 > 0.0f ? 1.0f / s00 : 0.0f, 0.0f, 0.0f, 0.0f, s11 > 0.0f ? 1.0f / s11 : 0.0f, 0.0f, 0.0f,
                     0.0f, s22 > 0.0f ? 1.0f / s22 : 0.0f);
}

// Block-Jacobi preconditioner: inverted diagonal blocks for active particles (positive mass and, with flags, the
// ACTIVE bit), zero otherwise. Masses and flags are per particle of one world.
__global__ void invert_block_preconditioner(const glm::mat3* blocks, const float* mass, const int* flags,
                                            glm::mat3* inverse, size_t count, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t particle = i % particles_per_world;
    glm::mat3 result(0.0f);
    if (mass[particle] > 0.0f && (flags == nullptr || (flags[particle] & 1))) result = invert_symmetrized(blocks[i]);
    inverse[i] = result;
}

// Affine-body block preconditioner: for bodies with a valid inverted 12x12 block (row-major), the four state rows
// (translation, three affine columns) of z become M r, each row accumulated from +0 in column order. Rows of other
// particles keep the block-diagonal result already in z.
__global__ void apply_affine_body_preconditioner(const glm::ivec4* body_particles, const float* inverse,
                                                 const int* valid, const glm::vec3* residual, glm::vec3* z,
                                                 size_t count, size_t bodies_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    if (!valid[i]) return;
    const size_t world = i / bodies_per_world;
    const size_t body = i % bodies_per_world;
    const glm::ivec4 particles = body_particles[body] + static_cast<int>(world * particles_per_world);
    const glm::vec3 r[4] = {residual[particles.x], residual[particles.y], residual[particles.z],
                            residual[particles.w]};
    const float* m = inverse + 144 * i;
#pragma unroll
    for (int row = 0; row < 12; ++row) {
        float sum = 0.0f;
#pragma unroll
        for (int k = 0; k < 12; ++k) sum += m[row * 12 + k] * r[k / 3][k % 3];
        z[particles[row / 3]][row % 3] = sum;
    }
}

// Off-diagonal ELL product of row i: sum over the row's first min(row_count, max_count) slots (slot-major,
// entries[slot * per_world + local]) of value * v[column], accumulated from zero. Matrices store one world with
// in-world columns; columns outside the world or past the particle count are skipped.
template <typename Entry>
__device__ __forceinline__ glm::vec3 ell_product(const int* row_count, const Entry* entries, size_t max_count,
                                                 const glm::vec3* v, size_t i, size_t count, size_t per_world)
{
    glm::vec3 sum(0.0f);
    if (max_count == 0) return sum;  // no off-diagonal storage
    const size_t local = per_world != 0 ? i % per_world : i;
    const size_t world_base = i - local;
    const int slots = min(max(row_count[local], 0), static_cast<int>(max_count));
    for (int k = 0; k < slots; ++k) {
        const Entry entry = entries[k * per_world + local];
        const int column = entry.column;
        if (column < 0 || static_cast<size_t>(column) >= per_world) continue;
        const size_t j = world_base + column;
        if (j >= count) continue;
        sum = sum + entry.value * v[j];
    }
    return sum;
}

// A p = (D p + ELL p) + extra, D the scalar or 3x3 diagonal; extra (e.g. contact tangents) is optional.
template <typename Entry, typename Diagonal>
__global__ void multiply_matrix(const int* row_count, const Entry* entries, size_t max_count, const Diagonal* diagonal,
                                const glm::vec3* p, const glm::vec3* extra, glm::vec3* product, size_t count,
                                size_t per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    glm::vec3 ap = diagonal[i] * p[i] + ell_product(row_count, entries, max_count, p, i, count, per_world);
    if (extra != nullptr) ap += extra[i];
    product[i] = ap;
}

// r = b - A x with A x as in multiply_matrix.
template <typename Entry, typename Diagonal>
__global__ void evaluate_residual(const int* row_count, const Entry* entries, size_t max_count,
                                  const Diagonal* diagonal, const glm::vec3* x, const glm::vec3* b,
                                  const glm::vec3* extra, glm::vec3* residual, size_t count, size_t per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    glm::vec3 ax = diagonal[i] * x[i] + ell_product(row_count, entries, max_count, x, i, count, per_world);
    if (extra != nullptr) ax += extra[i];
    residual[i] = b[i] - ax;
}

// A p as in multiply_matrix plus the block's partial sum of p . (A p) (the CG denominator).
template <unsigned BlockSize, typename Entry, typename Diagonal>
__global__ void multiply_matrix_and_reduce(const int* row_count, const Entry* entries, size_t max_count,
                                           const Diagonal* diagonal, const glm::vec3* p, const glm::vec3* extra,
                                           glm::vec3* product, float* partial, size_t count, size_t per_world)
{
    using BlockReduce = cub::BlockReduce<float, BlockSize>;
    __shared__ typename BlockReduce::TempStorage reduction_storage;
    const size_t i = thread_index();
    float value = 0.0f;
    if (i < count) {
        glm::vec3 ap = diagonal[i] * p[i] + ell_product(row_count, entries, max_count, p, i, count, per_world);
        if (extra != nullptr) ap += extra[i];
        product[i] = ap;
        value = glm::dot(ap, p[i]);
    }
    const float total = BlockReduce(reduction_storage).Sum(value);
    if (threadIdx.x == 0) partial[blockIdx.x] = total;
}

template __global__ void multiply_matrix<NonZeroEntry, float>(const int*, const NonZeroEntry*, size_t, const float*,
                                                              const glm::vec3*, const glm::vec3*, glm::vec3*, size_t,
                                                              size_t);
template __global__ void multiply_matrix<NonZeroEntry, glm::mat3>(const int*, const NonZeroEntry*, size_t,
                                                                  const glm::mat3*, const glm::vec3*,
                                                                  const glm::vec3*, glm::vec3*, size_t, size_t);
template __global__ void evaluate_residual<NonZeroEntry, float>(const int*, const NonZeroEntry*, size_t, const float*,
                                                                const glm::vec3*, const glm::vec3*, const glm::vec3*,
                                                                glm::vec3*, size_t, size_t);
template __global__ void evaluate_residual<NonZeroEntry, glm::mat3>(const int*, const NonZeroEntry*, size_t,
                                                                    const glm::mat3*, const glm::vec3*,
                                                                    const glm::vec3*, const glm::vec3*, glm::vec3*,
                                                                    size_t, size_t);
template __global__ void evaluate_residual<BlockNonZeroEntry, glm::mat3>(const int*, const BlockNonZeroEntry*, size_t,
                                                                         const glm::mat3*, const glm::vec3*,
                                                                         const glm::vec3*, const glm::vec3*,
                                                                         glm::vec3*, size_t, size_t);
template __global__ void multiply_matrix_and_reduce<256u, BlockNonZeroEntry, glm::mat3>(
    const int*, const BlockNonZeroEntry*, size_t, const glm::mat3*, const glm::vec3*, const glm::vec3*, glm::vec3*,
    float*, size_t, size_t);

}  // namespace synreal::kernel
