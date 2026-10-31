// 从 PTX 1:1 还原（32 行 PTX，几乎无歧义）
// 原始符号: _ZN7synreal12fluid_kernel16initialize_scaleEPffi
//           -> synreal::fluid_kernel::initialize_scale(float*, float, int)
//
// 对应 PTX:
//   mov %r3,%ctaid.x; mov %r4,%ntid.x; mov %r5,%tid.x
//   mad.lo.s32 %r1, %r3, %r4, %r5      -> i = blockIdx.x*blockDim.x + threadIdx.x
//   setp.ge.s32 %p1, %r1, %r2          -> i >= n ?
//   mul.wide.s32 %rd3, %r1, 4          -> i * sizeof(float)
//   st.global.f32 [%rd4], %f1          -> out[i] = value
//
// 返回值/分支结构与 C 源码一一对应，属于“可直接抄回工程”的还原级别。

__global__ void initialize_scale(float* out, float value, int n)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        out[i] = value;
    }
}
