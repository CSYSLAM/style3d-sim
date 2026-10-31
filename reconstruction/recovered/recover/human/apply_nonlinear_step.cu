// synreal::kernel::apply_nonlinear_step(const vec3*, vec3*, vec3*, size_t)
// 原版 SASS: 36 条指令 | 还原依据: PTX 55 行（kernel 20/97）
//
// PTX 关键序列：
//   f3 = param2[i] + param0[i]   (add.f32 ×3)   → 写到 param1[i]
//   然后对 param2[i] 三个分量写 0 (st.global.u32 %r4=0)
//
// 语义：out = in + delta; delta = 0 —— 即“把牛顿增量并入状态并清零增量缓冲”。
#include "vec3.h"
#include <cstddef>

__global__ void apply_nonlinear_step(const Vec3* in, Vec3* out, Vec3* delta, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    out[i].x = in[i].x + delta[i].x;
    out[i].y = in[i].y + delta[i].y;
    out[i].z = in[i].z + delta[i].z;

    delta[i].x = 0.0f;
    delta[i].y = 0.0f;
    delta[i].z = 0.0f;
}
