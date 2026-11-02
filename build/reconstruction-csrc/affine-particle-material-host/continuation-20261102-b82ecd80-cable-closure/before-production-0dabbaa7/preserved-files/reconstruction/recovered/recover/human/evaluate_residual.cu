// synreal::kernel::evaluate_residual<NonZeroEntry, float>(
//     const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
//     const float* diag, const vec3* x, const vec3* rhs,
//     const vec3* extra, vec3* residual, size_t n, size_t tile)
// 原版 SASS: 356 条 | 还原依据: PTX ~330 行（pcg 8/20）
//
// 与 multiply_matrix 共用同一套"分块稀疏乘"骨架，差别只有尾部：
//   if (extra != nullptr) acc += extra[gid];      // param6，空指针守卫
//   residual[gid] = rhs[gid] - acc;               // param5 - acc
#include "vec3.h"
#include <cstddef>

struct NonZeroEntry { int col; float val; };

__global__ void evaluate_residual(
    const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
    const float* diag, const Vec3* x, const Vec3* rhs,
    const Vec3* extra, Vec3* residual, size_t n, size_t tile)
{
    const size_t gid = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (gid >= n) return;

    const size_t rowInTile = (tile ? gid % tile : gid);
    const size_t tileBase  = gid - rowInTile;

    int nnz = max_nnz ? row_nnz[rowInTile] : 0;
    if (nnz < 0) nnz = 0;
    if ((size_t)nnz > max_nnz) nnz = (int)max_nnz;

    const float d = diag[gid];
    Vec3 acc{ d * x[gid].x, d * x[gid].y, d * x[gid].z };

    for (int k = 0; k < nnz; ++k) {
        const NonZeroEntry e = entries[(size_t)k * tile + rowInTile];
        if (e.col < 0 || (size_t)e.col >= tile) continue;
        const size_t j = tileBase + (size_t)e.col;
        if (j >= n) continue;
        acc.x += e.val * x[j].x;
        acc.y += e.val * x[j].y;
        acc.z += e.val * x[j].z;
    }

    if (extra != nullptr) {           // PTX: setp.eq.s64 %p30, %rd79, 0
        acc.x += extra[gid].x;
        acc.y += extra[gid].y;
        acc.z += extra[gid].z;
    }

    residual[gid] = Vec3{ rhs[gid].x - acc.x,
                          rhs[gid].y - acc.y,
                          rhs[gid].z - acc.z };
}
