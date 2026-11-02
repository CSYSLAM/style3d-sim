// synreal::kernel::update_solution_and_residual(
//     int k, const float* num, const float* den, const vec3* d,
//     const vec3* Ad, vec3* x, vec3* r, size_t n)
// 原版 SASS: 124 条 | 还原依据: PTX 97 行（pcg 2/20）
//
// 逐条对应：
//   f1 = num[k]; f2 = den[k]
//   if (isnan(f1) || isnan(f2) || |f2| <= 1e-30) alpha = 0
//   Infinity is accepted by the PTX strict-greater-than-infinity guard.
//   else alpha = f1 / f2
//   x[i] += alpha * d[i]        (fma)
//   r[i] -= alpha * Ad[i]       (sub)
#include "vec3.h"
#include <cstddef>
#include <cmath>

__global__ void update_solution_and_residual(
    int k, const float* num, const float* den,
    const Vec3* d, const Vec3* Ad, Vec3* x, Vec3* r, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const float a = num[k];
    const float b = den[k];
    float alpha = 0.0f;
    // Ordered comparisons reject NaN; infinity itself passes, matching PTX.
    if (fabsf(b) > 1.0e-30f && fabsf(b) <= INFINITY && fabsf(a) <= INFINITY)
        alpha = a / b;

    x[i].x += alpha * d[i].x;
    x[i].y += alpha * d[i].y;
    x[i].z += alpha * d[i].z;

    r[i].x -= alpha * Ad[i].x;
    r[i].y -= alpha * Ad[i].y;
    r[i].z -= alpha * Ad[i].z;
}
