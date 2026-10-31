// synreal::kernel::invert_block_preconditioner(
//     const mat3* A, const float* scale, const int* mask, mat3* out, size_t nnz, size_t tile)
// 原版 SASS: 304 条 | 还原依据: PTX 188 行（solver_newton）
//
// 结构（逐段对应 PTX）：
//   1) k = gid % tile;  if (!(scale[k] > 0))          → 写 9 个 0 返回
//   2) if (mask && ((mask[k] & 1) != 1))              → 写 9 个 0 返回
//   3) 对称化：s01 = (A[1]+A[3])/2, s02 = (A[2]+A[6])/2, s12 = (A[5]+A[7])/2
//   4) 余子式：c00 = s11*s22 - s12², c01 = s02*s12 - s01*s22, c02 = s01*s12 - s11*s02
//      det = s01*c01 + s00*c00 + s02*c02
//   5) det ≤ 1e-30 或 |det| ≥ inf → 对角倒数回退（各分量 >0 才取 1/x，否则 0）
//      否则 out = (1/det) * 对称余子式矩阵
#include "vec3.h"
#include <cstddef>
#include <cmath>

struct Mat3 { float m[9]; };

__global__ void invert_block_preconditioner(
    const Mat3* A, const float* scale, const int* mask, Mat3* out,
    size_t nnz, size_t tile)
{
    const size_t gid = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (gid >= nnz) return;

    const size_t k = gid % tile;
    const Mat3 zero{ 0,0,0, 0,0,0, 0,0,0 };

    if (!(scale[k] > 0.0f)) { out[gid] = zero; return; }          // setp.leu %p3, f12, 0
    if (mask != nullptr && ((mask[k] & 1) != 1)) { out[gid] = zero; return; }

    const Mat3& M = A[gid];
    const float s00 = M.m[0], s11 = M.m[4], s22 = M.m[8];
    const float s01 = 0.5f * (M.m[1] + M.m[3]);                    // 对称化
    const float s02 = 0.5f * (M.m[2] + M.m[6]);
    const float s12 = 0.5f * (M.m[5] + M.m[7]);

    const float c00 = s11 * s22 - s12 * s12;
    const float c01 = s02 * s12 - s01 * s22;
    const float c02 = s01 * s12 - s11 * s02;
    const float det = s01 * c01 + s00 * c00 + s02 * c02;

    Mat3 inv;
    if (!(det > 1.0e-30f) || !(fabsf(det) < INFINITY)) {               // 退化：对角倒数回退
        inv.m[0] = (s00 > 0.0f) ? 1.0f / s00 : 0.0f;
        inv.m[4] = (s11 > 0.0f) ? 1.0f / s11 : 0.0f;
        inv.m[8] = (s22 > 0.0f) ? 1.0f / s22 : 0.0f;
        inv.m[1] = inv.m[2] = inv.m[3] = inv.m[5] = inv.m[6] = inv.m[7] = 0.0f;
    } else {
        const float id = 1.0f / det;
        const float c11 = s00 * s22 - s02 * s02;
        const float c12 = s01 * s02 - s00 * s12;
        const float c22 = s00 * s11 - s01 * s01;
        inv.m[0] = c00 * id; inv.m[1] = c01 * id; inv.m[2] = c02 * id;
        inv.m[3] = c01 * id; inv.m[4] = c11 * id; inv.m[5] = c12 * id;
        inv.m[6] = c02 * id; inv.m[7] = c12 * id; inv.m[8] = c22 * id;
    }
    out[gid] = inv;
}
