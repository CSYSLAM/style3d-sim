// PCG revision 23fb797: separate CG coefficients per world, using per-particle atomic sums.
// Retain the accepted matrix/ELL helpers verbatim; only the seven new overloads below belong to this revision.
#include "../kernels/pcg.cu"

namespace synreal::kernel {

__device__ __forceinline__ int coefficient_world(size_t i, const int* world, unsigned particles_per_world)
{
    return world != nullptr ? world[i] : static_cast<unsigned>(i) / particles_per_world;
}

__global__ void update_cg_direction(int iteration, const glm::vec3* z, const int* world, unsigned particles_per_world,
                                   const float* numerator, const float* previous_numerator, glm::vec3* direction,
                                   size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const int w = coefficient_world(i, world, particles_per_world);
    glm::vec3 value = z[i];
    if (iteration > 0) value += guarded_ratio(numerator[w], previous_numerator[w]) * direction[i];
    direction[i] = value;
}

__global__ void update_solution_and_residual(const int* world, unsigned particles_per_world, const float* numerator,
                                            const float* denominator, const glm::vec3* direction,
                                            const glm::vec3* product, glm::vec3* solution, glm::vec3* residual,
                                            size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const int w = coefficient_world(i, world, particles_per_world);
    const float alpha = guarded_ratio(numerator[w], denominator[w]);
    residual[i] -= alpha * product[i];
    solution[i] += alpha * direction[i];
}

template <typename Preconditioner>
__global__ void precondition_and_reduce(const Preconditioner* inverse, const glm::vec3* residual, glm::vec3* z,
                                        bool precomputed, const int* world, unsigned particles_per_world,
                                        float* numerator, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const glm::vec3 value = precomputed ? z[i] : inverse[i] * residual[i];
    z[i] = value;
    const int w = coefficient_world(i, world, particles_per_world);
    atomicAdd(numerator + w, glm::dot(value, residual[i]));
}

template <typename Entry, typename Diagonal>
__global__ void multiply_matrix_and_reduce(const int* row_count, const Entry* entries, size_t max_count,
                                           const Diagonal* diagonal, const glm::vec3* direction,
                                           const glm::vec3* extra, glm::vec3* product, const int* world,
                                           unsigned particles_per_world, float* denominator, size_t count,
                                           size_t rows_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    glm::vec3 value = diagonal[i] * direction[i] + ell_product(row_count, entries, max_count, direction, i, count,
                                                            rows_per_world);
    if (extra != nullptr) value += extra[i];
    product[i] = value;
    const int w = coefficient_world(i, world, particles_per_world);
    atomicAdd(denominator + w, glm::dot(value, direction[i]));
}

template __global__ void precondition_and_reduce<float>(const float*, const glm::vec3*, glm::vec3*, bool,
                                                        const int*, unsigned, float*, size_t);
template __global__ void precondition_and_reduce<glm::mat3>(const glm::mat3*, const glm::vec3*, glm::vec3*, bool,
                                                            const int*, unsigned, float*, size_t);
template __global__ void multiply_matrix_and_reduce<NonZeroEntry, float>(const int*, const NonZeroEntry*, size_t,
    const float*, const glm::vec3*, const glm::vec3*, glm::vec3*, const int*, unsigned, float*, size_t, size_t);
template __global__ void multiply_matrix_and_reduce<NonZeroEntry, glm::mat3>(const int*, const NonZeroEntry*, size_t,
    const glm::mat3*, const glm::vec3*, const glm::vec3*, glm::vec3*, const int*, unsigned, float*, size_t, size_t);
template __global__ void multiply_matrix_and_reduce<BlockNonZeroEntry, glm::mat3>(const int*, const BlockNonZeroEntry*,
    size_t, const glm::mat3*, const glm::vec3*, const glm::vec3*, glm::vec3*, const int*, unsigned, float*, size_t, size_t);

}  // namespace synreal::kernel
