// synreal::kernel::initialize_block_diagonal(const float* diag, mat3* A, mat3* B, size_t n)
// 原版 SASS: 44 条 | PTX 63 行（solver_newton 50/97）
//
// PTX：a = diag[i]；A[i] = diag(a,a,a)（对角 9 写，其余位由 a*0 得到 0）；
//      若 B 非空（setp.eq.s64 %p2, %rd4, 0 判空），B[i] 写同样的对角阵。
// 注意：B 分支写的**不是** 1/a —— 逐元素看是同一组 a/0，逆矩阵由 invert_block_preconditioner 另算。
#include "vec3.h"
#include <cstddef>

struct Mat3 { float m[9]; };

__global__ void initialize_block_diagonal(const float* diag, Mat3* A, Mat3* B, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const float a = diag[i];
    const float zero = __fmul_rn(a, 0.0f);
    const Mat3 m{ a, zero, zero,
                  zero, a, zero,
                  zero, zero, a };
    A[i] = m;
    if (B != nullptr) B[i] = m;
}
