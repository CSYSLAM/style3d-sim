// synreal::kernel::initialize_rhs(
//     float inv_dt_sq, const vec3* x_prev, const vec3* x_cur, const float* mass,
//     const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
//     const vec3* base, const int* mask, vec3* rhs, size_t n, size_t tile)
// 原版 SASS: 420 条 | 还原依据: PTX 383 行（pcg_solver）
//
// 结构（逐段对应 PTX）：
//   i = gid; k = i % tile
//   if (mass[k] <= 0 || (mask && !(mask[k]&1))) { rhs[i] = 0; return; }   // BB12_7
//   d   = x_cur[i] - x_prev[i]                       // 位移，三分量
//   acc = mass[k] * d                                // 对角/惯性项
//   for e in row:                                    // 稀疏项（同 multiply_matrix 的 tile 布局）
//        acc += e.val * (x_cur[tileBase+col] - x_prev[tileBase+col])
//   rhs[i] = acc * inv_dt_sq + (base ? base[i] : 0)         // fma(f5, inv_dt_sq, base)
//
// 结论：这是一个"带质量的位移算子"：rhs = inv_dt_sq · ((mass·I + A) · (x_cur − x_prev)) + base
// SolverNewton::step supplies inv_dt_sq = 1/(h*h).
#include "vec3.h"
#include <cstddef>

struct NonZeroEntry { int col; float val; };

__global__ void initialize_rhs(
    float inv_dt_sq, const Vec3* x_prev, const Vec3* x_cur, const float* mass,
    const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
    const Vec3* base, const int* mask, Vec3* rhs, size_t n, size_t tile)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const size_t k = i % tile;
    if (!(mass[k] > 0.0f)) { rhs[i] = Vec3{0,0,0}; return; }
    if (mask != nullptr && ((mask[k] & 1) != 1)) { rhs[i] = Vec3{0,0,0}; return; }

    const size_t tileBase = i - k;

    const Vec3 d = Vec3{ x_cur[i].x - x_prev[i].x,
                         x_cur[i].y - x_prev[i].y,
                         x_cur[i].z - x_prev[i].z };
    Vec3 acc{ mass[k] * d.x, mass[k] * d.y, mass[k] * d.z };

    int nnz = max_nnz ? row_nnz[k] : 0;
    if (nnz < 0) nnz = 0;
    if ((size_t)nnz > max_nnz) nnz = (int)max_nnz;

    for (int e = 0; e < nnz; ++e) {
        const NonZeroEntry en = entries[(size_t)e * tile + k];
        if (en.col < 0 || (size_t)en.col >= tile) continue;
        const size_t j = tileBase + (size_t)en.col;
        if (j >= n) continue;
        acc.x += en.val * (x_cur[j].x - x_prev[j].x);
        acc.y += en.val * (x_cur[j].y - x_prev[j].y);
        acc.z += en.val * (x_cur[j].z - x_prev[j].z);
    }

    const Vec3 b = (base != nullptr) ? base[i] : Vec3{0,0,0};
    rhs[i] = Vec3{ acc.x * inv_dt_sq + b.x, acc.y * inv_dt_sq + b.y, acc.z * inv_dt_sq + b.z };
}
