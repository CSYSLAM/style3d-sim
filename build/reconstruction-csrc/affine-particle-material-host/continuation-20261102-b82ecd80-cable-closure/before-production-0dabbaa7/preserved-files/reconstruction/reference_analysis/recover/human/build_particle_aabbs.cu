// synreal::self_collision_kernel::build_particle_aabbs(
//     const vec3* x, const int* ids, const float* radii, Aabb* out,
//     size_t n, size_t tile, size_t stride)
// 原版 SASS: 216 条 | PTX 约 90 行（self_collision）
//
// PTX 直读：
//   i = gid; if (i >= n) return;
//   k = i % tile;  batch = i / tile;
//   id  = ids[k];
//   idx = batch * stride + id;          // 位置按批次偏移
//   r   = radii[id];                    // ⚠ 半径只按 id 取，未加批次偏移
//   out[i] = Aabb{ x[idx] - r, x[idx] + r }   // min/max 各 3 个分量
//
// 备注：半径不加 batch 偏移这一点是从 PTX 里直接看到的（`mul.wide.s32 %rd30, %r9, 4`，
// r9 = id），如果源码里 radii 是逐世界不同的，这里就是个值得复查的点。
#include <cstddef>

struct Vec3f { float x, y, z; };
struct Aabb  { float mn[3]; float mx[3]; };   // 24 B

__global__ void build_particle_aabbs(
    const Vec3f* x, const int* ids, const float* radii, Aabb* out,
    size_t n, size_t tile, size_t stride)
{
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    const size_t k     = i % tile;
    const size_t batch = i / tile;
    const int    id    = ids[k];
    const size_t idx   = batch * stride + (size_t)id;
    const float  r     = radii[id];

    const Vec3f p = x[idx];
    Aabb a;
    a.mn[0] = p.x - r; a.mn[1] = p.y - r; a.mn[2] = p.z - r;
    a.mx[0] = p.x + r; a.mx[1] = p.y + r; a.mx[2] = p.z + r;
    out[i] = a;
}
