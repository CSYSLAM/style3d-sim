// synreal::kernel::refresh_inertial_cache_diagonals(
//     const float* values, const size_t* row_ptr, const int* col_idx,
//     float* diag3x, float* row_sum, size_t n)
// 原版 SASS: 236 条 | PTX 121 行（solver_newton）
//
// PTX：
//   s = row_ptr[i]; e = row_ptr[i+1]          （CSR 行偏移；PTX 里是 [rd31] 与 [rd31+8]）
//   sum = Σ_{j∈[s,e)} values[ col_idx[j] ]
//   diag3x[i]  = sum * 3.0f                      （0f40400000；vec3 三个自由度的对角）
//   row_sum[i] = sum
// 循环体被展开 4 次，余数用 .pragma "nounroll" 的尾循环处理。
#include <cstddef>

__global__ void refresh_inertial_cache_diagonals(
    const float* values, const size_t* row_ptr, const int* col_idx,
    float* diag3x, float* row_sum, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const size_t s = row_ptr[i];
    const size_t e = row_ptr[i + 1];
    if (s == e) return;

    float sum = 0.0f;
    for (size_t j = s; j < e; ++j)
        sum += values[col_idx[j]];

    diag3x[i]  = 3.0f * sum;   // 三个分量共用
    row_sum[i] = sum;
}
