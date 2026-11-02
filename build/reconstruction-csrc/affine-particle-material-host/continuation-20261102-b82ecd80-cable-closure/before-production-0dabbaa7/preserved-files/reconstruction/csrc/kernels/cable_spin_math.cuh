#pragma once
#include "cable_rotation.cuh"

namespace synreal::kernel {

// The two off-diagonal cofactors b/e retain the native sign convention. Keep the original zero terms:
// this is H^-1 [v]_cross with the exact double multiplication/subtraction/FMA order used by prepare.
__device__ __forceinline__ glm::mat3 cable_weighted_spin_matrix(double a, double b, double c,
    double d, double e, double f, const glm::dvec3& v)
{
    const double az = a * 0.0, bz = b * 0.0, cz = c * 0.0, ez = e * 0.0;
    const double bvz = b * v.z, evx = e * v.x;
    const glm::dvec3 col0((az - bvz) - c * v.y, fma(e, v.y, d * v.z - bz), (cz - e * v.z) - f * v.y);
    const glm::dvec3 col1(fma(c, v.x, a * (-v.z) - bz), fma(d, 0.0, bvz) - evx,
                          fma(f, v.x, c * (-v.z) - ez));
    const glm::dvec3 col2(cz + fma(b, v.x, a * v.y), (-(d * v.x) - b * v.y) - ez,
                          fma(f, 0.0, fma(c, v.y, evx)));
    return glm::mat3(glm::vec3(col0), glm::vec3(col1), glm::vec3(col2));
}

__device__ __forceinline__ void cable_weighted_spin_maps(const glm::dvec3* rotation, const double j[3][3],
    double scale, const glm::dvec3* hessian, glm::mat3* maps)
{
    const double h00 = hessian[0].x, h01 = hessian[1].x, h02 = hessian[2].x;
    const double h11 = hessian[1].y, h12 = hessian[2].y, h22 = hessian[2].z;
    const double inverse_det = 1.0 / cable_determinant(hessian);
    const double a = (h11 * h22 - h12 * h12) * inverse_det;
    const double b = (h22 * h01 - h12 * h02) * inverse_det;
    const double c = (h01 * h12 - h11 * h02) * inverse_det;
    const double d = (h00 * h22 - h02 * h02) * inverse_det;
    const double e = (h00 * h12 - h02 * h01) * inverse_det;
    const double f = (h00 * h11 - h01 * h01) * inverse_det;
    #pragma unroll
    for (int k = 0; k < 3; ++k) {
        glm::dvec3 v;
        #pragma unroll
        for (int axis = 0; axis < 3; ++axis)
            v[axis] = fma(rotation[2][axis], j[k][2] / scale,
                fma(rotation[0][axis], j[k][0] / scale, rotation[1][axis] * (j[k][1] / scale)));
        maps[k] = cable_weighted_spin_matrix(a, b, c, d, e, f, v);
    }
}

__device__ __forceinline__ glm::mat3 cable_fallback_spin_matrix(float a, float b, float c,
    float d, float e, float f, const glm::vec3& v)
{
    const float bz = b * 0.0f, ez = e * 0.0f, dz = d * 0.0f;
    // The old driver JIT contracts these diagonal cross terms. Shared products in
    // the readable expression otherwise prevent contraction in the new module.
    const glm::vec3 col0(fmaf(-c, v.y, fmaf(a, 0.0f, b * v.z)),
        fmaf(b, 0.0f, d * v.z) - e * v.y, fmaf(c, 0.0f, e * v.z) - f * v.y);
    const glm::vec3 col1(fmaf(v.x, c, bz - a * v.z), fmaf(v.x, e, dz - b * v.z),
                          fmaf(f, v.x, ez - c * v.z));
    const glm::vec3 col2(fmaf(c, 0.0f, a * v.y - b * v.x), fmaf(e, 0.0f, b * v.y - d * v.x),
                          fmaf(f, 0.0f, fmaf(c, v.y, -(e * v.x))));
    return glm::mat3(col0, col1, col2);
}

// The float fallback uses sym(A R^T), without inertia weights, and a diagonal reciprocal if its inverse fails.
__device__ __forceinline__ void cable_fallback_spin_maps(const glm::vec3* a, const glm::mat3& r, glm::mat3* maps)
{
    float product[3][3];
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        #pragma unroll
        for (int column = 0; column < 3; ++column)
            product[row][column] = fmaf(a[2][row], r[2][column],
                fmaf(a[0][row], r[0][column], a[1][row] * r[1][column]));
    const float trace = (product[0][0] + product[1][1]) + product[2][2];
    const float zero = trace * 0.0f;
    const float h00 = trace - product[0][0], h11 = trace - product[1][1], h22 = trace - product[2][2];
    const float h01 = ((zero - product[1][0]) + (zero - product[0][1])) * 0.5f;
    const float h02 = ((zero - product[2][0]) + (zero - product[0][2])) * 0.5f;
    const float h12 = ((zero - product[2][1]) + (zero - product[1][2])) * 0.5f;
    const float c00 = h11 * h22 - h12 * h12;
    const float c01 = h02 * h12 - h22 * h01;
    const float c02 = h01 * h12 - h11 * h02;
    const float determinant = fmaf(h02, c02, fmaf(h00, c00, h01 * c01));
    float aa, bb = 0.0f, cc = 0.0f, dd, ee = 0.0f, ff;
    if (determinant > 1e-30f && fabsf(determinant) < INFINITY) {
        const float inverse = 1.0f / determinant;
        aa = c00 * inverse;
        bb = c01 * inverse;
        cc = c02 * inverse;
        dd = (h00 * h22 - h02 * h02) * inverse;
        ee = (h01 * h02 - h00 * h12) * inverse;
        ff = (h00 * h11 - h01 * h01) * inverse;
    } else {
        aa = h00 > 0.0f ? 1.0f / h00 : 0.0f;
        dd = h11 > 0.0f ? 1.0f / h11 : 0.0f;
        ff = h22 > 0.0f ? 1.0f / h22 : 0.0f;
    }
    #pragma unroll
    for (int k = 0; k < 3; ++k) maps[k] = cable_fallback_spin_matrix(aa, bb, cc, dd, ee, ff, r[k]);
}

} // namespace synreal::kernel
