// Cloth springs (particle-particle) of synreal::SolverNewton.
#include "types.cuh"

namespace synreal::kernel {

// Spring force k * (d - rest * d/|d|) on the second endpoint, its negation on the first, d = x[b] - x[a].
// Springs are shared by all worlds: thread i handles spring i % springs_per_world of world i / springs_per_world,
// whose particles start at world * particles_per_world.
__global__ void evaluate_spring_force(const glm::vec3* x, const glm::ivec2* springs, const float* stiffness,
                                      const float* rest_length, glm::vec3* force, size_t count,
                                      size_t springs_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / springs_per_world;
    const size_t spring = i % springs_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const int a = springs[spring].x + offset;
    const int b = springs[spring].y + offset;
    const glm::vec3 d = x[b] - x[a];
    const float k = stiffness[spring];
    const float rest = rest_length[spring];
    const float length = glm::length(d);
    // A degenerate spring has no direction; it then pulls with k * d only.
    const glm::vec3 direction = normalized_or_zero(d, length, 0.0f);
    const glm::vec3 f = k * (d - rest * direction);
    atomicAdd(&force[a].x, f.x);
    atomicAdd(&force[a].y, f.y);
    atomicAdd(&force[a].z, f.z);
    atomicAdd(&force[b].x, -f.x);
    atomicAdd(&force[b].y, -f.y);
    atomicAdd(&force[b].z, -f.z);
}

// Gauss-Newton correction of a cloth spring on top of the host's constant k I: B = k (H - I) with
// H = n n^T + max(0, 1 - rest/|d|) (I - n n^T) (H = I for |d| <= 1e-8). B goes to both endpoint diagonals and -B to
// the off-diagonal blocks (a, b) and (b, a), or to the diagonals when a == b. Springs with k <= 0 or rest <= 0 are
// skipped.
__global__ void add_spring_gauss_newton_hessian(const glm::vec3* x, const glm::ivec2* springs, const float* stiffness,
                                                const float* rest_length, glm::mat3* diagonal, const int* row_count,
                                                BlockNonZeroEntry* entries, size_t max_count, size_t count,
                                                size_t springs_per_world, size_t particles_per_world, size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / springs_per_world;
    const size_t spring = i % springs_per_world;
    const float k = stiffness[spring];
    const float rest = rest_length[spring];
    if (!(k > 0.0f) || rest <= 0.0f) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const int a = springs[spring].x + offset;
    const int b = springs[spring].y + offset;
    const glm::vec3 d = x[b] - x[a];
    const float length = glm::length(d);
    glm::mat3 h(1.0f);
    if (length > 1e-8f) {
        const glm::vec3 n = d / length;
        const glm::mat3 nn = glm::outerProduct(n, n);
        h = (glm::mat3(1.0f) - nn) * fmaxf(0.0f, 1.0f - rest / length) + nn;
    }
    const glm::mat3 block = k * (h - glm::mat3(1.0f));
    atomic_add(&diagonal[a], block);
    atomic_add(&diagonal[b], block);
    const glm::mat3 negative = -block;
    if (a == b) {
        atomic_add(&diagonal[a], negative);
        atomic_add(&diagonal[b], negative);
    } else {
        atomic_add_block(row_count, entries, max_count, rows, a, b, negative);
        atomic_add_block(row_count, entries, max_count, rows, b, a, negative);
    }
}

}  // namespace synreal::kernel
