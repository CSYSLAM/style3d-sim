// synreal::kernel::update_velocity(float, const vec3*, const vec3*, vec3*, size_t)
// 原版 SASS: 36 条指令 | 还原依据: PTX 56 行（kernel 81/97）
//
// PTX 关键序列：
//   f4 = x2[i] - x1[i]        (sub.f32 ×3)
//   v[i] = f4 * s             (mul.f32 ×3,  s = param0)
//   store → param3[i]
#include "vec3.h"
#include <cstddef>

__global__ void update_velocity(float s, const Vec3* a, const Vec3* b, Vec3* v, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    // 逐分量相减后再统一乘标量：注意这里没有做 fma，源码大概率就是 (b - a) * s
    v[i].x = (b[i].x - a[i].x) * s;
    v[i].y = (b[i].y - a[i].y) * s;
    v[i].z = (b[i].z - a[i].z) * s;
}
