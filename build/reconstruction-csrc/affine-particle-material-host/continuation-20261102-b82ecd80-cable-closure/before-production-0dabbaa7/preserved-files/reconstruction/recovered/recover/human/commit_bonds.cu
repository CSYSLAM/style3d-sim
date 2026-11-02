// synreal::granular_kernel::commit_bonds(Model, x, bonds, original, history, active, n)
// Model: yield strain +316, max compaction +320, break strain +324.
// Break when length > history*(1+break_strain); otherwise commit
// max(original*(1-max_compaction), min(history, length+yield_strain*original)).
#include "vec3.h"
#include <cstddef>
#include <cmath>

struct IVec2 { int x, y; };
struct alignas(8) ModelView {
    unsigned char pad[316];
    float yield_strain;
    float max_compaction;
    float break_strain;
    unsigned char rest[1864 - 328];
};
static_assert(sizeof(ModelView) == 1864, "Model ABI size");
static_assert(offsetof(ModelView, yield_strain) == 316, "yield offset");
static_assert(offsetof(ModelView, max_compaction) == 320, "compaction offset");
static_assert(offsetof(ModelView, break_strain) == 324, "break offset");

__global__ void commit_bonds(
    ModelView model, const Vec3* x, const IVec2* bonds, const float* original,
    float* history, int* active, int n)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n || active[i] == 0) return;
    const int a = bonds[i].x, b = bonds[i].y;
    const Vec3 d{ x[a].x-x[b].x, x[a].y-x[b].y, x[a].z-x[b].z };
    const float len = sqrtf(fmaf(d.z, d.z, fmaf(d.x, d.x, d.y*d.y)));
    const float current = history[i];
    if (len > current * (1.0f + model.break_strain)) {
        active[i] = 0;
        return;
    }
    const float initial = original[i];
    history[i] = fmaxf(initial*(1.0f-model.max_compaction),
                      fminf(current, fmaf(initial, model.yield_strain, len)));
}
