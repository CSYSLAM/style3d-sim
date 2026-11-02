// synreal::kernel::refresh_inertial_cache_nonzeros(
//     const float* v1, const size_t* rp1, const int* ci1,
//     const float* v2, const size_t* rp2, const int* ci2,
//     NonZeroEntry* out1, NonZeroEntry* out2, size_t n)
// 原版 SASS: 452 条 | PTX 203 行（solver_newton）
//
// 结构与 refresh_inertial_cache_diagonals 同源，但做两组、且只写 NonZeroEntry 的 .val（+4），
// col（+0）保持不变 —— 也就是"只刷新数值、不重建稀疏结构"。
//
//   s = row_ptr[e]; t = row_ptr[e+1];   // CSR 行偏移
//   sum = Σ_{j∈[s,t)} values[col_idx[j]]
//   out1[e].val = +sum；out2[e].val = −sum（PTX 第二组用 sub.f32）
#include <cstddef>

struct NonZeroEntry { int col; float val; };

__device__ __forceinline__ float row_sum(const float* v, const size_t* rp,
                                         const int* ci, size_t e)
{
    const size_t s = rp[e];
    const size_t t = rp[e + 1];
    float acc = 0.0f;
    for (size_t j = s; j < t; ++j) acc += v[ci[j]];
    return acc;
}

__global__ void refresh_inertial_cache_nonzeros(
    const float* v1, const size_t* rp1, const int* ci1,
    const float* v2, const size_t* rp2, const int* ci2,
    NonZeroEntry* out1, NonZeroEntry* out2, size_t n)
{
    const size_t e = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (e >= n) return;

    if (rp1[e] != rp1[e+1]) out1[e].val = row_sum(v1, rp1, ci1, e);
    if (rp2[e] != rp2[e+1]) out2[e].val = -row_sum(v2, rp2, ci2, e);   // PTX 里第二组是 sub.f32 累加 → 取负
}
