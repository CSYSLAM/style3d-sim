#include "cable_tangent_geometry.cuh"

namespace synreal::kernel {

// Native preparation ignores the active mask and appends all four affine slots
// of each dynamic endpoint, including duplicate ids when the bodies coincide.
__global__ void prepare_cable_tangents(CableView view, const glm::vec3* x)
{
    const size_t i = thread_index();
    if (i >= view.total_count) return;
    const CableTangentGeometry geometry = cable_tangent_geometry(view, i % view.per_world, i / view.per_world, x);
    view.count[i] = geometry.count;
    for (int slot = 0; slot < geometry.count; ++slot) {
        const size_t at = i * 8 + slot;
        view.linear[at] = geometry.linear[slot];
        view.angular[at] = geometry.angular[slot];
        view.indices[at] = geometry.indices[slot];
    }
}

} // namespace synreal::kernel
