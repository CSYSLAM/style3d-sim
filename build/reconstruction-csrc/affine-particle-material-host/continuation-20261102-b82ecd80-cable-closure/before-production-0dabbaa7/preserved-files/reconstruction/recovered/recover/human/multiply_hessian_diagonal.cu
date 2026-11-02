// synreal::self_collision_kernel::multiply_hessian_diagonal(
//     const mat3* H, const vec3* x, vec3* out, size_t n)
// 原版 SASS: 56 条 | PTX 70 行（self_collision）
//
// out[i] += H[i] · x[i]（3 次 mul + 6 次 fma）。与 apply_block_diagonal_preconditioner 同构，
// 该入口向已有输出累加 self_collision 的 Hessian 对角贡献。
#include "vec3.h"
#include <cstddef>

struct Mat3 { float m[9]; };

__global__ void multiply_hessian_diagonal(const Mat3* H, const Vec3* x, Vec3* out, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const Mat3& A = H[i];
    const Vec3  v = x[i];
    const Vec3 product = Vec3{
        A.m[0]*v.x + A.m[3]*v.y + A.m[6]*v.z,
        A.m[1]*v.x + A.m[4]*v.y + A.m[7]*v.z,
        A.m[2]*v.x + A.m[5]*v.y + A.m[8]*v.z,
    };
    out[i].x += product.x;
    out[i].y += product.y;
    out[i].z += product.z;
}
