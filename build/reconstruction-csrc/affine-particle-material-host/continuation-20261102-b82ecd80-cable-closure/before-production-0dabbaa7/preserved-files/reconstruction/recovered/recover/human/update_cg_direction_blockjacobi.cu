// synreal::kernel::update_cg_direction<glm::mat3>(
//     int k, const mat3* M, const vec3* r, const float* num, vec3* p, size_t n)
// 原版 SASS: 116 条（float 特化）/ 136 条（mat3 特化）| 还原依据: PTX 86 行（pcg 15/20）
//
// 与 update_preconditioned_cg_direction 的唯一差别：这里先用块对角预条件矩阵作用一次
//   z_i = M_i * r_i        （9 次 mul/fma 展开）
// 然后两者一致：
//   beta = num[k]/num[k-1] for k>0, |previous|>1e-30, and non-NaN scalars.
//   p_i  = z_i + beta * p_i
#include "vec3.h"
#include <cstddef>
#include <cmath>

struct Mat3 { float m[9]; };

__device__ __forceinline__ Vec3 mat_vec(const Mat3& A, const Vec3& v)
{
    // glm::mat3 列主序：m[0..2]=col0, m[3..5]=col1, m[6..8]=col2
    return Vec3{
        A.m[0]*v.x + A.m[3]*v.y + A.m[6]*v.z,
        A.m[1]*v.x + A.m[4]*v.y + A.m[7]*v.z,
        A.m[2]*v.x + A.m[5]*v.y + A.m[8]*v.z,
    };
}

__global__ void update_cg_direction_blockjacobi(
    int k, const Mat3* M, const Vec3* r, const float* num, Vec3* p, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const Vec3 z = mat_vec(M[i], r[i]);          // 预条件：z = M r

    float beta = 0.0f;
    if (k > 0) {
        const float cur = num[k];
        const float prev = num[k - 1];
        if (fabsf(prev) > 1.0e-30f && fabsf(prev) <= INFINITY && fabsf(cur) <= INFINITY)
            beta = cur / prev;
    }

    p[i].x = z.x + beta * p[i].x;
    p[i].y = z.y + beta * p[i].y;
    p[i].z = z.z + beta * p[i].z;
}
