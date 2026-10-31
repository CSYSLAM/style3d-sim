// synreal::kernel::apply_block_diagonal_preconditioner(
//     const mat3* M, const vec3* r, vec3* z, size_t n)
// 原版 SASS: 48 条 | PTX 64 行（solver_newton 75/97）
//
// PTX：标准 3x3 × 3 矩阵向量乘（1 次 mul + 2 次 fma 每行），z[i] = M[i]·r[i]。
#include "vec3.h"
#include <cstddef>

struct Mat3 { float m[9]; };

__global__ void apply_block_diagonal_preconditioner(
    const Mat3* M, const Vec3* r, Vec3* z, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const Mat3& A = M[i];
    const Vec3  v = r[i];
    z[i] = Vec3{
        A.m[0]*v.x + A.m[3]*v.y + A.m[6]*v.z,
        A.m[1]*v.x + A.m[4]*v.y + A.m[7]*v.z,
        A.m[2]*v.x + A.m[5]*v.y + A.m[8]*v.z,
    };
}
