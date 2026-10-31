// synreal::fluid_kernel::scale_step(Model model, vec3* x, const float* scale, int n)
// 原版 SASS: 52 条 | PTX 71 行（fluid）
//
// 逐条直译（注意 k 的来历有三路）：
//   i = gid; if (i >= n) return;
//   count      = Model+24  (0x18, particle_count)
//   stateCount = Model+28  (0x1c, particle_state_count)
//   if (stateCount > count)      k = i / count;                       // div 路径
//   else if (world_ptr != null)  k = max(particle_world[i], 0);       // 按"世界"索引
//   else                         k = 0;
//   x[i] *= scale[k];
//
// 其中 particle_world 的偏移已与运行时布局对上：
//   Model+120 (0x78) = particle_world.ptr，Model+128 (0x80) = particle_world.size
//
// ⚠ div 路径的语义（为什么是 i/count）与"按世界索引"的直觉不符，此处按 PTX 直译保留，
//    不做"修正"；如需确认请对照上层调用方传入的 scale 数组长度。
#include "vec3.h"
#include <cstddef>

struct ModelView {
    unsigned char pad0[24];
    unsigned int  particle_count;        // +24
    unsigned int  particle_state_count;  // +28
    unsigned char pad1[120 - 32];
    const int*    particle_world;        // +120
    size_t        particle_world_size;   // +128
    unsigned char rest[1864 - 136];      // 补齐到原版 sizeof(Model)=1864
};

__global__ void scale_step(ModelView model, Vec3* x, const float* scale, int n)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    int k;
    if (model.particle_state_count > model.particle_count) {
        k = i / (int)model.particle_count;                  // div 路径
    } else if (model.particle_world != nullptr) {
        k = model.particle_world[i];
        if (k < 0) k = 0;                                    // max.s32
    } else {
        k = 0;
    }

    const float s = scale[k];
    x[i].x *= s;
    x[i].y *= s;
    x[i].z *= s;
}
