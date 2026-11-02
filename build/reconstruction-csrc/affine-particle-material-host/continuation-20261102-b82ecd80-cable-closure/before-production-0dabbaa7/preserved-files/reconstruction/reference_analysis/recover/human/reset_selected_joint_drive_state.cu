// synreal::kernel::reset_selected_joint_drive_state(const int* mask, int* state, size_t n)
// 原版 SASS: 24 条 | PTX 44 行（solver_newton）
//
// PTX：读 mask[i]，非 0 才把 state[i] 写 0（只有一个分支，无 else）。
__global__ void reset_selected_joint_drive_state(const int* mask, int* state, size_t n)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;
    if (mask[i] != 0) state[i] = 0;
}
