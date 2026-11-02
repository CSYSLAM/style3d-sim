// synreal::self_collision_kernel::build_edge_aabbs(
//     const vec3* x, const ivec4* edges, Aabb* out, float thickness,
//     size_t n, size_t tile, size_t stride)
// 原版 SASS: 216 条 | PTX 约 95 行（self_collision）
//
// PTX 直读（两个细节容易看错）：
//   1) 顶点取自 ivec4 的 **.z / .w**（读的是 +8 和 +12，不是 +0/+4）；
//   2) 两个下标都加批次偏移 base = (i/tile) * stride；
//   lo = min(x[a], x[b]) − thickness
//   hi = max(x[a], x[b]) + thickness
//   out[i] = { lo, hi }
#include <cstddef>

struct Vec3f { float x, y, z; };
struct IVec4 { int x, y, z, w; };
struct Aabb  { float mn[3]; float mx[3]; };

__global__ void build_edge_aabbs(
    const Vec3f* x, const IVec4* edges, Aabb* out, float thickness,
    size_t n, size_t tile, size_t stride)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const size_t k     = i % tile;
    const size_t batch = i / tile;
    const IVec4  e     = edges[k];
    const int    base  = (int)(batch * stride);

    const Vec3f p = x[(size_t)(e.z + base)];   // ⚠ 用的是 .z
    const Vec3f q = x[(size_t)(e.w + base)];   // ⚠ 用的是 .w

    Aabb a;
    a.mn[0] = fminf(p.x, q.x) - thickness;
    a.mn[1] = fminf(p.y, q.y) - thickness;
    a.mn[2] = fminf(p.z, q.z) - thickness;
    a.mx[0] = fmaxf(p.x, q.x) + thickness;
    a.mx[1] = fmaxf(p.y, q.y) + thickness;
    a.mx[2] = fmaxf(p.z, q.z) + thickness;
    out[i] = a;
}
