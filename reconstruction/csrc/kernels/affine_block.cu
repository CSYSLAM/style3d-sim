#include "types.cuh"
#include "cable_types.cuh"
#include <type_traits>

namespace synreal::kernel {

template <typename Entry>
__device__ __forceinline__ void assemble_affine_body(const glm::ivec4* body_indices, const float* weight,
    const float* mass, const int* flags, const glm::mat3* diagonal, const int* row_count, const Entry* entries,
    size_t max_count, size_t tile, const glm::mat3* rotation, float alpha, CableView cables,
    const size_t* cable_offsets, const int* cable_ids, float inv_dt, const float* cache,
    size_t body, size_t per_world, size_t particles_per_world, float* matrix, bool* active)
{
    const size_t local = body % per_world, world = body / per_world;
    const glm::ivec4 ids = body_indices[local] + static_cast<int>(world * particles_per_world);
    for (int at = 0; at < 144; ++at) matrix[at] = cache ? cache[body * 144 + at] : 0.0f;
    #pragma unroll
    for (int i = 0; i < 4; ++i) {
        const int particle = ids[i];
        const size_t local_particle = static_cast<size_t>(particle) % particles_per_world;
        const bool enabled = flags ? mass[local_particle] > 0.0f && (flags[local_particle] & 1) :
                                     mass[local_particle] > 0.0f;
        #pragma unroll
        for (int row = 0; row < 3; ++row) {
            active[3 * i + row] = enabled;
            #pragma unroll
            for (int column = 0; column < 3; ++column)
                matrix[(3 * i + row) * 12 + 3 * i + column] = diagonal[particle][column][row];
        }
        if (max_count) {
            const size_t row = static_cast<size_t>(particle) % tile;
            const int bound = min(static_cast<int>(max_count), max(row_count[row], 0));
            for (int slot = 0; slot < bound; ++slot) {
                const Entry entry = entries[slot * tile + row];
                if (entry.column < 0 || static_cast<size_t>(entry.column) >= tile) continue;
                const int target = static_cast<int>(static_cast<size_t>(particle) - row + entry.column);
                #pragma unroll
                for (int j = 0; j < 4; ++j) {
                    if (target != ids[j]) continue;
                    if constexpr (std::is_same_v<Entry, NonZeroEntry>) {
                        // The scalar entry is expanded to an identity block before addition. Off-diagonal
                        // add-zero operations are observable for signed zeros and must also be retained.
                        #pragma unroll
                        for (int r = 0; r < 3; ++r)
                            #pragma unroll
                            for (int c = 0; c < 3; ++c)
                                matrix[(3 * i + r) * 12 + 3 * j + c] += r == c ? entry.value : 0.0f;
                    } else {
                        #pragma unroll
                        for (int r = 0; r < 3; ++r)
                            #pragma unroll
                            for (int c = 0; c < 3; ++c)
                                matrix[(3 * i + r) * 12 + 3 * j + c] += entry.value[c][r];
                    }
                }
            }
        }
    }
    if (alpha > 0.0f) {
        const glm::mat3 r = rotation[body];
        const float factor = (weight[local] * alpha) * 0.5f;
        #pragma unroll
        for (int j = 0; j < 3; ++j) {
            #pragma unroll
            for (int k = 0; k < 3; ++k) {
                #pragma unroll
                for (int a = 0; a < 3; ++a) {
                    #pragma unroll
                    for (int b = 0; b < 3; ++b) {
                        float value = r[k][a] * r[j][b];
                        if (j == k) {
                            if (a == 2 && b == 2) {
                                value = fmaf(r[k][2], r[j][2], r[0][2] * r[0][2]);
                                value = fmaf(r[1][2], r[1][2], value);
                                value = fmaf(r[2][2], r[2][2], value);
                            } else {
                                #pragma unroll
                                for (int axis = 0; axis < 3; ++axis) value = fmaf(r[axis][a], r[axis][b], value);
                            }
                        }
                        const int at = (3 + 3 * j + a) * 12 + 3 + 3 * k + b;
                        matrix[at] = fmaf(factor, value, matrix[at]);
                    }
                }
            }
        }
    }
    // The original always reads the adjacency offsets, even when every cable list is empty.
    {
        for (size_t at = cable_offsets[local]; at < cable_offsets[local + 1]; ++at) {
            const size_t cable = static_cast<size_t>(cable_ids[at]) + world * cables.per_world;
            const size_t local_cable = cable % cables.per_world;
            if (cables.active && cables.active[local_cable] == 0) continue;
            float linear[3][12] = {}, angular[3][12] = {};
            for (int node = 0; node < cables.count[cable]; ++node) {
                const int particle = cables.indices[cable * 8 + node];
                #pragma unroll
                for (int i = 0; i < 4; ++i) {
                    if (particle != ids[i]) continue;
                    const glm::mat3 jl = cables.linear[cable * 8 + node], ja = cables.angular[cable * 8 + node];
                    #pragma unroll
                    for (int row = 0; row < 3; ++row)
                        #pragma unroll
                        for (int column = 0; column < 3; ++column) {
                            linear[row][3 * i + column] = jl[column][row] + linear[row][3 * i + column];
                            angular[row][3 * i + column] = ja[column][row] + angular[row][3 * i + column];
                        }
                }
            }
            const glm::vec4 penalty = cables.penalty ? cables.penalty[cable] : cables.base[local_cable];
            const glm::vec4 damping = cables.damping[local_cable];
            const glm::vec4 stiffness(fmaf(damping.x, inv_dt, penalty.x), fmaf(damping.y, inv_dt, penalty.y),
                                      fmaf(damping.z, inv_dt, penalty.z), fmaf(damping.w, inv_dt, penalty.w));
            const glm::vec3 lin(stiffness.y, stiffness.y, stiffness.x);
            glm::vec3 ang(stiffness.z, stiffness.z, stiffness.w);
            ang = ang + (cables.bias ? cables.bias[cable] : glm::vec3(0.0f));
            for (int row = 0; row < 12; ++row)
                for (int column = 0; column < 12; ++column)
                    #pragma unroll
                    for (int axis = 0; axis < 3; ++axis) {
                        const float term = fmaf(lin[axis] * linear[axis][row], linear[axis][column],
                            (ang[axis] * angular[axis][row]) * angular[axis][column]);
                        matrix[row * 12 + column] = matrix[row * 12 + column] + term;
                    }
        }
    }
}

// Scaled Cholesky, twelve triangular solves, then explicit symmetrization. Failure preserves partial writes.
__device__ __forceinline__ bool invert_affine_body(const float* matrix, const bool* active, float* output)
{
    float scale[12], lower[12][12] = {};
    for (int i = 0; i < 12; ++i) {
        const float value = active[i] ? matrix[i * 12 + i] : 1.0f;
        if (!(value > 0.0f) || !(fabsf(value) < INFINITY)) return false;
        scale[i] = 1.0f / sqrtf(value);
    }
    for (int i = 0; i < 12; ++i) {
        for (int j = 0; j <= i; ++j) {
            float value = i == j ? 1.0f : 0.0f;
            if (active[i] && active[j])
                value = (scale[i] * ((matrix[i * 12 + j] + matrix[j * 12 + i]) * 0.5f)) * scale[j];
            for (int k = 0; k < j; ++k) value = value - lower[i][k] * lower[j][k];
            if (i == j) {
                if (!(value > 0.0f) || !(fabsf(value) < INFINITY)) return false;
                lower[i][j] = sqrtf(value);
            } else lower[i][j] = value / lower[j][j];
        }
    }
    for (int column = 0; column < 12; ++column) {
        float y[12] = {}, x[12] = {};
        for (int i = 0; i < 12; ++i) {
            float value = i == column ? 1.0f : 0.0f;
            for (int k = 0; k < i; ++k) value = value - lower[i][k] * y[k];
            y[i] = value / lower[i][i];
        }
        for (int i = 11; i >= 0; --i) {
            float value = y[i];
            for (int k = i + 1; k < 12; ++k) value = value - lower[k][i] * x[k];
            x[i] = value / lower[i][i];
        }
        for (int i = 0; i < 12; ++i) {
            const float value = active[i] && active[column] ? (scale[i] * x[i]) * scale[column] : 0.0f;
            if (!(fabsf(value) < INFINITY)) return false;
            output[i * 12 + column] = value;
        }
    }
    for (int i = 0; i < 12; ++i)
        for (int j = 0; j < i; ++j) {
            const float value = (output[i * 12 + j] + output[j * 12 + i]) * 0.5f;
            output[i * 12 + j] = value;
            output[j * 12 + i] = value;
        }
    return true;
}

template <typename Entry>
__global__ void build_affine_body_preconditioner(const glm::ivec4* body_indices, const float* weight,
    const float* mass, const int* flags, const glm::mat3* diagonal, const int* row_count, const Entry* entries,
    size_t max_count, size_t tile, const glm::mat3* rotation, float alpha, CableView cables,
    const size_t* cable_offsets, const int* cable_ids, float inv_dt, const int* enabled, const float* cache,
    float* output, int* valid, size_t count, size_t per_world, size_t particles_per_world)
{
    const size_t body = thread_index();
    if (body >= count) return;
    valid[body] = 0;
    if (!enabled[body % per_world]) return;
    float matrix[144];
    bool active[12];
    assemble_affine_body(body_indices, weight, mass, flags, diagonal, row_count, entries, max_count, tile,
        rotation, alpha, cables, cable_offsets, cable_ids, inv_dt, cache, body, per_world, particles_per_world,
        matrix, active);
    valid[body] = invert_affine_body(matrix, active, output + body * 144);
}

template __global__ void build_affine_body_preconditioner<NonZeroEntry>(const glm::ivec4*, const float*, const float*,
    const int*, const glm::mat3*, const int*, const NonZeroEntry*, size_t, size_t, const glm::mat3*, float,
    CableView, const size_t*, const int*, float, const int*, const float*, float*, int*, size_t, size_t, size_t);
template __global__ void build_affine_body_preconditioner<BlockNonZeroEntry>(const glm::ivec4*, const float*, const float*,
    const int*, const glm::mat3*, const int*, const BlockNonZeroEntry*, size_t, size_t, const glm::mat3*, float,
    CableView, const size_t*, const int*, float, const int*, const float*, float*, int*, size_t, size_t, size_t);

} // namespace synreal::kernel
