#pragma once
#include "types.cuh"

// Preserve the original translation-unit-local ABI identifiers in template names.
// These are ordinary named C++ operators; no original binary or PTX is embedded.
namespace _GLOBAL__N__501f50b1_13_pcg_solver_cu_933d4eae {

struct Vec3InnerProduct {
    __host__ __device__ float operator()(const glm::vec3& a, const glm::vec3& b) const
    {
        return glm::dot(a, b);
    }
};

template<class Preconditioner>
struct PreconditionedResidualInnerProduct {
    __host__ __device__ float operator()(const glm::vec3& r, const Preconditioner& p) const
    {
        return glm::dot(p * r, r);
    }
};

} // namespace _GLOBAL__N__501f50b1_13_pcg_solver_cu_933d4eae

namespace _GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f {

struct MergeAabbs {
    __host__ __device__ synreal::Aabb operator()(const synreal::Aabb& a, const synreal::Aabb& b) const
    {
        return {glm::vec3(fminf(a.lower.x, b.lower.x), fminf(a.lower.y, b.lower.y), fminf(a.lower.z, b.lower.z)),
                glm::vec3(fmaxf(a.upper.x, b.upper.x), fmaxf(a.upper.y, b.upper.y), fmaxf(a.upper.z, b.upper.z))};
    }
};

struct PrimitiveCentroidAabb {
    __host__ __device__ synreal::Aabb operator()(const synreal::Aabb& box) const
    {
        const float x = (box.lower.x + box.upper.x) * 0.5f;
        const float y = (box.lower.y + box.upper.y) * 0.5f;
        const float z = (box.lower.z + box.upper.z) * 0.5f;
        const glm::vec3 center(x, y, z);
        return {center, center};
    }
};

} // namespace _GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f
