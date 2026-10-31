// synreal::kernel::initialize_block_non_diagonal(
//     const NonZeroEntry* in, const int* row_nnz, size_t tile,
//     size_t max_nnz, BlockNonZeroEntry* out, size_t group)
// 原版 SASS: 356 条 | PTX 103 行（solver_newton）
//
// 下标三层拆解（PTX 里 div/rem 两次）：
//   k    = i / group        (param5)
//   mid  = i % group
//   row  = mid % tile       (param2)
// 守卫：k < row_nnz[row]，否则直接返回。
//
// 输入按 tile 转置布局取：src = k * tile + row（与 multiply_matrix 一致）
// 输出：把标量条目升级成 3×3 对角块
//   out[i].col = in[src].col + (mid - row)      // mid - row 就是 tile 起点偏移
//   out[i].m   = diag(v, v, v)
#include <cstddef>

struct NonZeroEntry      { int col; float val; };
struct BlockNonZeroEntry { int col; float m[9]; };

__global__ void initialize_block_non_diagonal(
    const NonZeroEntry* in, const int* row_nnz, size_t tile,
    size_t max_nnz, BlockNonZeroEntry* out, size_t group)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;

    if (i >= group * max_nnz) return;
    const size_t k   = i / group;
    const size_t mid = i % group;
    const size_t row = mid % tile;

    if (k >= (size_t)row_nnz[row]) return;

    const size_t src = k * tile + row;
    const float  v   = in[src].val;
    const float zero = __fmul_rn(v, 0.0f);
    const int    c   = in[src].col + (int)(mid - row);

    out[i].col = c;
    out[i].m[0] = v; out[i].m[1] = zero; out[i].m[2] = zero;
    out[i].m[3] = zero; out[i].m[4] = v; out[i].m[5] = zero;
    out[i].m[6] = zero; out[i].m[7] = zero; out[i].m[8] = v;
}
