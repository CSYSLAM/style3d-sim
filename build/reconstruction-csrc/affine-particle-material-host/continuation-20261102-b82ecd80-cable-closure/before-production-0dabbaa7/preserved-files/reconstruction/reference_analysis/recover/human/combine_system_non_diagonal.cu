// synreal::kernel::combine_system_non_diagonal(
//     float s0..s5, const NonZeroEntry* e0..e6, NonZeroEntry* out, size_t n)
// 原版 SASS: 36 条 | PTX 87 行（solver_newton）
//
// 参数映射已用 ld.param 的 _param_N 后缀坐实：
//   param0..5  -> s0..s5      (f1..f6)
//   param6..11 -> e0, e1, e2, e3, e4, e5
//   param12    -> e6
//   param13    -> out
//   param14    -> n
//
// PTX 累加链（逐条）：
//   f9  = e2*s1 + e1
//   f11 = e3*s2 + f9
//   f13 = e4*s3 + f11
//   f15 = e5*s4 + f13
//   f17 = e6*s5 + f15
//   f19 = f17*s0 + e0        ← 整体再乘 s0 再加 e0
//
// 即：out.val = e0 + s0 · (e1 + s1·e2 + s2·e3 + s3·e4 + s4·e5 + s5·e6)
// 注意比例因子是"错位一位"配的（s1 配 e2），正好对应源码里 `for k in 1..6: acc += s[k-1]*e[k]` 的写法。
#include <cstddef>

struct NonZeroEntry { int col; float val; };   // 8 B

__global__ void combine_system_non_diagonal(
    float s0, float s1, float s2, float s3, float s4, float s5,
    const NonZeroEntry* e0, const NonZeroEntry* e1, const NonZeroEntry* e2,
    const NonZeroEntry* e3, const NonZeroEntry* e4, const NonZeroEntry* e5,
    const NonZeroEntry* e6, NonZeroEntry* out, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    out[i].col = e0[i].col;

    float acc = e1[i].val;
    acc += s1 * e2[i].val;
    acc += s2 * e3[i].val;
    acc += s3 * e4[i].val;
    acc += s4 * e5[i].val;
    acc += s5 * e6[i].val;

    out[i].val = e0[i].val + s0 * acc;
}
