// synreal::kernel::initialize_joint_body_spring_state(vec3*, size_t)
// 原版 SASS: 28 条指令 | 还原依据: PTX 34 行（kernel 51/97）
//
// PTX：对 i < n 的每个元素，向 +0/+4/+8 写 u32 0 —— 即整块清零 vec3 数组。
#include "vec3.h"
#include <cstddef>

__global__ void initialize_joint_body_spring_state(Vec3* state, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;
    state[i] = Vec3{0.0f, 0.0f, 0.0f};
}
