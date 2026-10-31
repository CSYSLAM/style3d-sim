// synreal::self_collision_kernel::add_hessian_diagonal(const mat3* A, mat3* H, size_t n)
// 原版 SASS: 48 条 | PTX 71 行（self_collision）
//
// 逐分量 H[i] += A[i]，9 个 float（mat3 = 36 B）。与 fluid 的 add_diagonal 同构。
#include <cstddef>

struct Mat3 { float m[9]; };

__global__ void add_hessian_diagonal(const Mat3* A, Mat3* H, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    Mat3 acc = H[i];
    const Mat3 a = A[i];
    #pragma unroll
    for (int c = 0; c < 9; ++c) acc.m[c] += a.m[c];
    H[i] = acc;
}
