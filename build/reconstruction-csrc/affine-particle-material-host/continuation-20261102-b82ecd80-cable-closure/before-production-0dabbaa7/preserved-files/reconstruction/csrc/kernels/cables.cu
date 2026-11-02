// Cable penalty state. Geometry and tangent evaluation are reconstructed separately.
#include "types.cuh"
#include "cable_geometry.cuh"

namespace synreal::kernel {

// Clamp the four penalty channels independently, preserving mask, world-local base data and initialization state.
__global__ void prepare_cable_penalties(const glm::vec4* base, glm::vec4* penalty, int* initialized,
                                        size_t per_world, size_t count, float beta0, float beta1, float scale,
                                        float cap0, float cap1, bool reset, bool rescale, const int* mask)
{
    const size_t i = thread_index();
    if (i >= count || (mask != nullptr && mask[i] == 0)) return;
    const glm::vec4 upper = base[i % per_world];
    const glm::vec4 lower(beta0 > 0.0f ? fminf(cap0, upper.x) : upper.x,
                           beta0 > 0.0f ? fminf(cap0, upper.y) : upper.y,
                           beta1 > 0.0f ? fminf(cap1, upper.z) : upper.z,
                           beta1 > 0.0f ? fminf(cap1, upper.w) : upper.w);
    glm::vec4 value = lower;
    if (!reset && initialized[i] != 0) value = penalty[i];
    const float factor = rescale ? scale : 1.0f;
    penalty[i] = glm::vec4(fminf(upper.x, fmaxf(lower.x, factor * value.x)),
                            fminf(upper.y, fmaxf(lower.y, factor * value.y)),
                            fminf(upper.z, fmaxf(lower.z, factor * value.z)),
                            fminf(upper.w, fmaxf(lower.w, factor * value.w)));
    initialized[i] = 1;
}

// Increase the four world-local penalty channels from current stretch/shear/bend/twist residuals.
__global__ void update_cable_penalties(CableView view, const glm::vec3* x, float linear_beta, float angular_beta)
{
    const size_t i = thread_index();
    if (i >= view.total_count) return;
    const size_t local = i % view.per_world, world = i / view.per_world;
    if (view.active && view.active[local] == 0) return;
    const CableFrame parent = cable_world_frame<true>(view, local, world, x);
    const CableFrame child = cable_world_frame<false>(view, local, world, x);
    const CableStrain strain = cable_strain(parent, child, view.rest[local]);
    const float shear = sqrtf(fmaf(strain.linear.x, strain.linear.x, strain.linear.y * strain.linear.y));
    const float bend = sqrtf(fmaf(strain.angular.x, strain.angular.x, strain.angular.y * strain.angular.y));
    const glm::vec4 old = view.penalty[i], upper = view.base[local];
    view.penalty[i] = glm::vec4(fminf(upper.x, fmaf(fabsf(strain.linear.z), linear_beta, old.x)),
        fminf(upper.y, fmaf(shear, linear_beta, old.y)), fminf(upper.z, fmaf(bend, angular_beta, old.z)),
        fminf(upper.w, fmaf(fabsf(strain.angular.z), angular_beta, old.w)));
}

}  // namespace synreal::kernel
