// synreal::kernel::add_triangle_drag_preconditioner(
//     const ivec3* tri, const vec3* dir, const float* w, mat3* H,
//     size_t n, size_t tile, size_t block_stride)
// 原版 SASS: 248 条 | PTX 149 行（solver_newton）
//
// 逐条对应：
//   i = gid; if (i >= n) return;
//   k = i % tile;  tri[k] 给出 3 个顶点
//   d = dir[i];  weight = w[i];
//   B = weight · (d ⊗ d)          // 6 个独立分量：dxx,dxy,dxz,dyy,dyz,dzz × w
//   base = (i / tile) * block_stride
//   对 3 个顶点各做一次 atomicAdd(H[(v + base)], B)   // 9 个 red.global.add.f32
//
// 注意：块是**对称**的（+4 与 +12 写同一个 f12，+8 与 +24 写同一个 f13，+20 与 +28 写同一个 f15），
// 所以只算了 6 个分量，另外 3 个复用。
#include "vec3.h"
#include <cstddef>

struct IVec3 { int x, y, z; };
struct Mat3  { float m[9]; };

__global__ void add_triangle_drag_preconditioner(
    const IVec3* tri, const Vec3* dir, const float* w, Mat3* H,
    size_t n, size_t tile, size_t block_stride)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const size_t k = i % tile;
    const IVec3  t = tri[k];
    const Vec3   d = dir[i];
    const float  a = w[i];

    const float xx = a * d.x * d.x;
    const float xy = a * d.y * d.x;
    const float xz = a * d.z * d.x;
    const float yy = a * d.y * d.y;
    const float yz = a * d.z * d.y;
    const float zz = a * d.z * d.z;

    const int base = (int)((i / tile) * block_stride);
    const int vs[3] = { t.x, t.y, t.z };

    #pragma unroll
    for (int c = 0; c < 3; ++c) {
        Mat3* B = &H[(size_t)(vs[c] + base)];
        atomicAdd(&B->m[0], xx); atomicAdd(&B->m[1], xy); atomicAdd(&B->m[2], xz);
        atomicAdd(&B->m[3], xy); atomicAdd(&B->m[4], yy); atomicAdd(&B->m[5], yz);
        atomicAdd(&B->m[6], xz); atomicAdd(&B->m[7], yz); atomicAdd(&B->m[8], zz);
    }
}
