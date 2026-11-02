// Shared helpers for the synreal kernels.
#pragma once

#include <cmath>
#include <cstddef>

#include <cuda.h>  // defines CUDA_VERSION, which glm checks before enabling its CUDA support
#define GLM_FORCE_CUDA
#include <glm/glm.hpp>

namespace synreal::kernel {

// Global 1-D thread index. The legacy kernels widen blockIdx * blockDim to 64 bits before adding threadIdx
// (PTX: mul.wide.u32 + add.s64), so the bound check compares against a size_t count.
__device__ __forceinline__ size_t thread_index()
{
    return static_cast<size_t>(blockIdx.x) * blockDim.x + threadIdx.x;
}

// num / den for the CG coefficients, or 0 when the denominator is tiny (|den| <= 1e-30) or either value is NaN,
// so a converged or broken-down iteration leaves the direction/solution unchanged instead of producing NaN.
__device__ __forceinline__ float guarded_ratio(float num, float den)
{
    if (fabsf(den) > 1e-30f && !std::isnan(den) && !std::isnan(num)) return num / den;
    return 0.0f;
}

// v / length when length > threshold, else zero. Written as `length > threshold` so a NaN length also yields zero.
__device__ __forceinline__ glm::vec3 normalized_or_zero(const glm::vec3& v, float length, float threshold)
{
    if (length > threshold) return v / length;
    return glm::vec3(0.0f);
}

// Component-wise fminf/fmaxf (PTX min/max.f32). Not glm::min/max: those compile to compare+select and treat NaN
// and signed zeros differently.
__device__ __forceinline__ glm::vec3 min_components(const glm::vec3& a, const glm::vec3& b)
{
    return glm::vec3(fminf(a.x, b.x), fminf(a.y, b.y), fminf(a.z, b.z));
}

__device__ __forceinline__ glm::vec3 max_components(const glm::vec3& a, const glm::vec3& b)
{
    return glm::vec3(fmaxf(a.x, b.x), fmaxf(a.y, b.y), fmaxf(a.z, b.z));
}

// Component-wise atomic accumulation (red.global.add.f32 per float, x/y/z then column-major for matrices).
__device__ __forceinline__ void atomic_add(glm::vec3* target, const glm::vec3& value)
{
    atomicAdd(&target->x, value.x);
    atomicAdd(&target->y, value.y);
    atomicAdd(&target->z, value.z);
}

__device__ __forceinline__ void atomic_add(glm::mat3* target, const glm::mat3& value)
{
    for (int column = 0; column < 3; ++column)
        for (int row = 0; row < 3; ++row) atomicAdd(&(*target)[column][row], value[column][row]);
}

}  // namespace synreal::kernel
