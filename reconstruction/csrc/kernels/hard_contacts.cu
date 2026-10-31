// Hard-contact history and geometry, with the exact 312-byte by-value legacy view.
#include "hard_contact_geometry.cuh"

namespace synreal::kernel {

// Thread zero stores the clamped signed count even with zero capacity; the other outputs retain their unused tails.
__global__ void snapshot_hard_contacts(HardContactView view)
{
    const size_t i = thread_index();
    if (i == 0) {
        int count = 0;
        if (view.count != nullptr) count = min(max(*view.count, 0), static_cast<int>(view.capacity));
        *view.previous_count = count;
    }
    if (i >= view.capacity || view.count == nullptr || i >= static_cast<size_t>(max(*view.count, 0))) return;
    view.previous_penalty[i] = view.penalty[i];
    view.previous_dual[i] = view.dual[i];
    const glm::vec3 normal = view.normal[i];
    const float length = sqrtf(glm::dot(normal, normal));
    view.previous_normal[i] = normalized_or_zero(normal, length, 0.0f);
}

// Initialize contact penalties, rotate matched duals into the current normal, and record the displacement anchor.
__global__ void initialize_hard_contacts(HardContactView view)
{
    const size_t i = thread_index();
    if (i >= view.capacity || !view.count || i >= static_cast<size_t>(max(*view.count, 0))) return;
    HardGeometry geometry;
    if (!hard_geometry(view, i, geometry)) {
        view.penalty[i] = 0.0f;
        view.dual[i] = glm::vec3(0.0f);
        view.anchor[i] = glm::vec3(0.0f);
        return;
    }
    const float upper = (view.shape_ke[geometry.shapes[0]] + view.shape_ke[geometry.shapes[1]]) * 0.5f;
    const float lower = view.beta > 0.0f ? fminf(view.start, upper) : upper;
    float penalty = lower;
    glm::vec3 dual(0.0f);
    if (!view.reset && *view.previous_count != 0) {
        penalty = view.penalty[i];
        dual = view.dual[i];
    } else {
        const int match = view.history && view.match ? view.match[i] : -1;
        if (match >= 0 && match < *view.previous_count) {
            penalty = fminf(fmaxf(view.previous_penalty[match], lower), upper);
            const glm::vec3 old_n = view.previous_normal[match], old_dual = view.previous_dual[match];
            const float normal_part = contact_dot(old_n, old_dual);
            const glm::vec3 tangent = old_dual - old_n * normal_part;
            dual = contact_fma(normal_part, geometry.normal, tangent) - contact_dot(tangent, geometry.normal) *
                geometry.normal;
        }
    }
    view.penalty[i] = fminf(fmaxf(penalty * view.gamma, lower), upper);
    view.dual[i] = !view.history && view.reset ? glm::vec3(0.0f) : dual * (view.alpha * view.gamma);
    const glm::vec3 p0 = geometry.slots[0] >= 0 ?
        contact_point(geometry.adjusted[0], geometry.ids[0], geometry.com[0], view.x) : geometry.adjusted[0];
    const glm::vec3 p1 = geometry.slots[1] >= 0 ?
        contact_point(geometry.adjusted[1], geometry.ids[1], geometry.com[1], view.x) : geometry.adjusted[1];
    const glm::vec3 diff = p1 - p0;
    const glm::vec3 tangent = diff - contact_dot(diff, geometry.normal) * geometry.normal;
    view.anchor[i] = geometry.depth * geometry.normal - tangent;
}

// Project the dual onto the Coulomb cone; the relative displacement uses the legacy subtraction sequence.
__global__ void update_hard_contact_duals(HardContactView view)
{
    const size_t i = thread_index();
    if (i >= view.capacity || !view.count || i >= static_cast<size_t>(max(*view.count, 0))) return;
    HardGeometry geometry;
    if (!hard_geometry(view, i, geometry)) return;
    const glm::vec3 n = geometry.normal;
    const glm::vec3 anchor = view.anchor[i], dual = view.dual[i];
    const float an = contact_dot(anchor, n), dn = contact_dot(dual, n);
    const float corrected_depth = geometry.depth < 0.0f ? geometry.depth : geometry.depth - view.alpha * an;
    const float penalty = view.penalty[i];
    const float normal_force = fmaxf(fmaf(penalty, corrected_depth, dn), 0.0f);
    glm::vec3 now[2], old[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const glm::vec3 p = geometry.adjusted[side];
        now[side] = geometry.slots[side] >= 0 ? contact_point(p, geometry.ids[side], geometry.com[side], view.x) : p;
        old[side] = geometry.slots[side] >= 0 ? contact_point(p, geometry.ids[side], geometry.com[side], view.previous) : p;
    }
    const glm::vec3 delta = ((now[1] - old[1]) - now[0]) + old[0];
    glm::vec3 correction = contact_dot(delta, n) * n - delta;
    correction = contact_fma(1.0f - view.alpha, anchor - an * n, correction);
    glm::vec3 tangent = contact_fma(penalty, correction, dual - dn * n);
    const float length = sqrtf(contact_dot(tangent, tangent));
    const float mu = sqrtf(fmaxf(view.shape_mu[geometry.shapes[0]] * view.shape_mu[geometry.shapes[1]], 0.0f));
    const float bound = normal_force * mu;
    if (length > bound && length > 0.0f) tangent = (bound / length) * tangent;
    view.dual[i] = contact_fma(normal_force, n, tangent);
    if (geometry.depth > 0.0f) {
        const float upper = (view.shape_ke[geometry.shapes[0]] + view.shape_ke[geometry.shapes[1]]) * 0.5f;
        view.penalty[i] = fminf(upper, fmaf(view.beta, geometry.depth, penalty));
    }
}

}  // namespace synreal::kernel
