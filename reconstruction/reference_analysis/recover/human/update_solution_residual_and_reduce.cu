// synreal::kernel::update_solution_residual_and_reduce<256u, glm::mat3>(
//     int k, const float* num, const float* den, const vec3* p, const vec3* Ap,
//     const mat3* M, vec3* x, vec3* r, float* out, bool energy, size_t n)
// 原版 SASS: 188 条 | 还原依据: PTX 204 行（pcg 16/20）
//
// 结构：
//   alpha = num[k]/den[k]（与其它 CG kernel 相同的双守卫）
//   r[i] -= alpha * Ap[i]
//   x[i] += alpha * p[i]
//   if (energy) acc = r[i]ᵀ · M[i] · r[i]  else acc = 0     // param9 = bool
//   warp shuffle(1,2,4,8,16) → shared[8+warp*4] → bar.sync → thread0 汇总 → out[blockIdx.x]
//
// 即"α 更新 + 能量（r·M·r）融合归约"，对应块特化里省掉的一次全量读写。
#include "vec3.h"
#include <cstddef>
#include <cmath>

struct Mat3 { float m[9]; };

__global__ void update_solution_residual_and_reduce(
    int k, const float* num, const float* den, const Vec3* p, const Vec3* Ap,
    const Mat3* M, Vec3* x, Vec3* r, float* out, bool energy, size_t n)
{
    __shared__ float red[11];
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    const int lane = threadIdx.x & 31;
    const int warp = threadIdx.x >> 5;

    float acc = 0.0f;
    if (i < n) {
        const float a = num[k];
        const float b = den[k];
        float alpha = 0.0f;
        if (fabsf(b) > 1.0e-30f && fabsf(b) <= INFINITY && fabsf(a) <= INFINITY)
            alpha = a / b;

        r[i].x -= alpha * Ap[i].x;          // r -= alpha * Ap
        r[i].y -= alpha * Ap[i].y;
        r[i].z -= alpha * Ap[i].z;

        x[i].x += alpha * p[i].x;           // x += alpha * p
        x[i].y += alpha * p[i].y;
        x[i].z += alpha * p[i].z;

        if (energy) {                        // rᵀ M r
            const Mat3& A = M[i];
            const Vec3  v = r[i];
            acc = v.x * (A.m[0]*v.x + A.m[3]*v.y + A.m[6]*v.z)
                + v.y * (A.m[1]*v.x + A.m[4]*v.y + A.m[7]*v.z)
                + v.z * (A.m[2]*v.x + A.m[5]*v.y + A.m[8]*v.z);
        }
    }

    #pragma unroll
    for (int off = 16; off > 0; off >>= 1)
        acc += __shfl_down_sync(0xffffffffu, acc, off);
    if (lane == 0) red[2 + warp] = acc;
    __syncthreads();
    if (threadIdx.x == 0) {
        float s = acc;
        #pragma unroll
        for (int w = 1; w < 8; ++w) s += red[2 + w];
        out[blockIdx.x] = s;
    }
}
