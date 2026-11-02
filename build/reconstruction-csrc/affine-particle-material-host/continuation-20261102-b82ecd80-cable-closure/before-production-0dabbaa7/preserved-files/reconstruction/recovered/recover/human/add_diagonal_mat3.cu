// synreal::fluid_kernel::add_diagonal(const mat3*, mat3*, int)
// 原版 SASS: 48 条 | 还原依据: PTX 69 行（fluid 2/15）
//
// PTX: 对 i<n 的元素，逐分量 out[i][c] += a[i][c]，共 9 个 float（mat3 = 36 B）。
#include "vec3.h"
#include <cstddef>

struct Mat3 { float m[9]; };

__global__ void add_diagonal_mat3(const Mat3* a, Mat3* out, int n)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;
    Mat3 v = out[i];
    const Mat3 w = a[i];
    #pragma unroll
    for (int c = 0; c < 9; ++c) v.m[c] += w.m[c];
    out[i] = v;
}
