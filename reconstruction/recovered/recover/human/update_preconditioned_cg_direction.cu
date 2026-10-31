// synreal::kernel::update_preconditioned_cg_direction(
//     int k, const vec3* r, const float* num, vec3* p, size_t n)
// 原版 SASS: 116 条 | 还原依据: PTX 83 行（pcg 1/20）
//
// PTX 顺序：
//   beta = 0
//   For k>0, divide when |previous|>1e-30 and neither scalar is NaN.
//   p[i] = r[i] + beta * p[i]        (fma ×3)
#include "vec3.h"
#include <cstddef>
#include <cmath>

__global__ void update_preconditioned_cg_direction(
    int k, const Vec3* r, const float* num, Vec3* p, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    float beta = 0.0f;
    if (k > 0) {
        const float cur = num[k];
        const float prev = num[k - 1];
        if (fabsf(prev) > 1.0e-30f && fabsf(prev) <= INFINITY && fabsf(cur) <= INFINITY)
            beta = cur / prev;
    }

    p[i].x = r[i].x + beta * p[i].x;
    p[i].y = r[i].y + beta * p[i].y;
    p[i].z = r[i].z + beta * p[i].z;
}
