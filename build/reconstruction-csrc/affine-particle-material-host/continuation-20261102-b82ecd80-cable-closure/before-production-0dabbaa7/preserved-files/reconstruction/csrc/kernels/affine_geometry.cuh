#pragma once
#include "types.cuh"

namespace synreal::kernel {

// v / |v|, or zero when |v| is not positive.
__device__ __forceinline__ glm::vec3 normalize_or_zero(const glm::vec3& v)
{
    return normalized_or_zero(v, glm::length(v), 0.0f);
}

// Rotation closest to the affine matrix [a b c]: scale-normalise, up to eight Newton polar iterations
// X <- (X + cof(X) / det X) / 2 (stopping early when det X is tiny or not finite), then Gram-Schmidt with the third
// axis oriented like c. Degenerate inputs give the identity.
__device__ __forceinline__ glm::mat3 nearest_rotation(glm::vec3 a, glm::vec3 b, glm::vec3 c)
{
    const float scale = std::sqrt((glm::dot(a, a) + glm::dot(b, b) + glm::dot(c, c)) / 3.0f);
    if (!(scale > 1e-8f) || !std::isfinite(scale)) return glm::mat3(1.0f);
    const float inverse_scale = 1.0f / scale;
    a = a * inverse_scale;
    b = b * inverse_scale;
    c = c * inverse_scale;
    for (int iteration = 0; iteration < 8; ++iteration) {
        const glm::vec3 bc = glm::cross(b, c);
        const float determinant = glm::dot(a, bc);
        if (std::abs(determinant) <= 1e-10f || !std::isfinite(determinant)) break;
        const float inverse_determinant = 1.0f / determinant;
        const glm::vec3 ca = glm::cross(c, a);
        const glm::vec3 ab = glm::cross(a, b);
        a = (bc * inverse_determinant + a) * 0.5f;
        b = (ca * inverse_determinant + b) * 0.5f;
        c = (ab * inverse_determinant + c) * 0.5f;
    }
    const glm::vec3 n0 = normalize_or_zero(a);
    glm::vec3 n1 = normalize_or_zero(b - glm::dot(b, n0) * n0);
    if (glm::length(n0) <= 1e-8f || glm::length(n1) <= 1e-8f) return glm::mat3(1.0f);
    glm::vec3 n2 = normalize_or_zero(glm::cross(n0, n1));
    if (glm::dot(c, n2) < 0.0f) {
        n1 = -n1;
        n2 = -n2;
    }
    return glm::mat3(n0, n1, n2);
}

} // namespace synreal::kernel
