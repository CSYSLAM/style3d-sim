// synreal::kernel::initialize_zero_solution_and_reduce<256u, glm::mat3>(
//     const vec3* x0, const mat3* M, vec3* x, vec3* r, float* out, size_t n)
// 原版 SASS: 88 条 | 还原依据: PTX 149 行（pcg 10/20）
//
// PTX 结构（逐条对上）：
//   x[i] = x0[i]                       ; 三路 ld/st
//   r[i] = 0                           ; 三路 st 0
//   Mx = M[i] * x0[i]                  ; 9 次 mul/fma
//   v  = Mx · x0                       ; 3 次 mul/fma → x0ᵀ M x0
//   warp 归约：shfl.sync.down 1,2,4,8,16
//   lane==0 → shared[8 + warp*4] = v
//   bar.sync
//   threadIdx.x==0 → v += shared[12..36]（7 个 warp 的和），写 out[blockIdx.x]
#include "vec3.h"
#include <cstddef>

struct Mat3 { float m[9]; };

__device__ __forceinline__ Vec3 mat_vec(const Mat3& A, const Vec3& v)
{
    return Vec3{
        A.m[0]*v.x + A.m[3]*v.y + A.m[6]*v.z,
        A.m[1]*v.x + A.m[4]*v.y + A.m[7]*v.z,
        A.m[2]*v.x + A.m[5]*v.y + A.m[8]*v.z,
    };
}

__global__ void initialize_zero_solution_and_reduce(
    const Vec3* x0, const Mat3* M, Vec3* x, Vec3* r, float* out, size_t n)
{
    __shared__ float red[11];                      // 对应 44 B reduction_storage
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    const int lane = threadIdx.x & 31;
    const int warp = threadIdx.x >> 5;

    float v = 0.0f;
    if (i < n) {
        const Vec3 v0 = x0[i];
        x[i] = v0;                                  // 初值
        r[i] = Vec3{0.0f, 0.0f, 0.0f};              // 残差清零
        const Vec3 Mx = mat_vec(M[i], v0);
        v = Mx.x * v0.x + Mx.y * v0.y + Mx.z * v0.z; // x0ᵀ M x0
    }

    #pragma unroll
    for (int off = 16; off > 0; off >>= 1)
        v += __shfl_down_sync(0xffffffffu, v, off);

    if (lane == 0) red[2 + warp] = v;               // shared +8+warp*4
    __syncthreads();

    if (threadIdx.x == 0) {
        float s = v;
        #pragma unroll
        for (int w = 1; w < 8; ++w) s += red[2 + w]; // 读 +12..+36
        out[blockIdx.x] = s;                        // 每块一个部分和
    }
}
