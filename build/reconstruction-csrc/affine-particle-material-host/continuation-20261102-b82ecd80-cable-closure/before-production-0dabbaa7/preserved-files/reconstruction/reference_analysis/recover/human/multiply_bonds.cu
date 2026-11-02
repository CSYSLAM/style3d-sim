// synreal::granular_kernel::multiply_bonds(
//     const ivec2* bonds, const int* active, const mat3* M, int n,
//     const vec3* x, vec3* out)
// 原版 SASS: 80 条 | PTX 98 行（granular）
//
// PTX：
//   if (active[i] == 0) return;            // setp.eq %p2, %r6, 0
//   a = bonds[i].x; b = bonds[i].y;
//   d = x[a] - x[b];                       // sub.f32 ×3（注意是 a 减 b）
//   f = M[i] · d;                          // 3×3 × 3
//   atomicAdd(out[a], f); atomicAdd(out[b], -f);   // red.global.add.f32，符号相反
#include "vec3.h"
#include <cstddef>

struct IVec2 { int x, y; };
struct Mat3 { float m[9]; };

__global__ void multiply_bonds(
    const IVec2* bonds, const int* active, const Mat3* M, int n,
    const Vec3* x, Vec3* out)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;
    if (active[i] == 0) return;

    const int a = bonds[i].x;
    const int b = bonds[i].y;

    const Vec3 d{ x[a].x - x[b].x, x[a].y - x[b].y, x[a].z - x[b].z };

    const Mat3& A = M[i];
    const Vec3 f{ A.m[0]*d.x + A.m[3]*d.y + A.m[6]*d.z,
                  A.m[1]*d.x + A.m[4]*d.y + A.m[7]*d.z,
                  A.m[2]*d.x + A.m[5]*d.y + A.m[8]*d.z };

    atomicAdd(&out[a].x,  f.x); atomicAdd(&out[a].y,  f.y); atomicAdd(&out[a].z,  f.z);
    atomicAdd(&out[b].x, -f.x); atomicAdd(&out[b].y, -f.y); atomicAdd(&out[b].z, -f.z);
}
