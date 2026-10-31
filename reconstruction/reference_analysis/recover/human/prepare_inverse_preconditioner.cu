// synreal::kernel::prepare_inverse_preconditioner(
//     const float* A, const float* scale, const int* mask, float* out, size_t nnz, size_t tile)
// 原版 SASS: 212 条 | PTX 86 行（solver_newton）
//
// PTX：c = A[gid]; w = scale[gid % tile];
//      active = (w > 0) && (mask == null || ((mask[k] & 1) == 1))   ← and/not/or.pred 三连
//      out[gid] = (active && c > 0) ? 1/c : 0
#include <cstddef>

__global__ void prepare_inverse_preconditioner(
    const float* A, const float* scale, const int* mask, float* out,
    size_t nnz, size_t tile)
{
    const size_t gid = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (gid >= nnz) return;

    const size_t k = gid % tile;
    const float c = A[gid];
    const float w = scale[k];

    bool active = (w > 0.0f);
    if (active && mask != nullptr) active = ((mask[k] & 1) == 1);

    out[gid] = (active && c > 0.0f) ? (1.0f / c) : 0.0f;
}
