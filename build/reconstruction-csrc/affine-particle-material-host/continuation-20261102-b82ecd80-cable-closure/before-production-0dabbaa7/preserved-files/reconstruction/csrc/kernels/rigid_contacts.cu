#include "rigid_contact_geometry.cuh"

namespace synreal::kernel {

// Penalty body/body and body/static contact, with separate raw and friction levers when offsets or spheres occur.
__global__ void evaluate_contact_force(const int* count, size_t capacity, const int* shape0, const int* shape1,
    const glm::vec3* point0, const glm::vec3* point1, const glm::vec3* offset0, const glm::vec3* offset1,
    const glm::vec3* normal, const float* margin0, const float* margin1, const int* shape_body, const int* shape_type,
    const Transform* transform, const glm::vec3* shape_scale, const float* ke, const float* kd, const float* kf,
    const float* mu, float epsilon, size_t local_shape_count, size_t shapes_per_world, size_t worlds,
    const int* body_ids, const glm::ivec4* body_indices, const glm::vec3* body_com, size_t body_count,
    size_t particles_per_world, const glm::vec3* x, const glm::vec3* velocity, const glm::vec3* previous, float inv_dt,
    glm::vec3* force, float* scalar)
{
    const size_t i = thread_index();
    if (i >= capacity || !count || i >= static_cast<size_t>(max(*count, 0))) return;
    const RigidContactView view = {shape0, shape1, point0, point1, offset0, offset1, normal, margin0, margin1,
        shape_body, shape_type, transform, shape_scale, ke, kd, kf, mu, epsilon, local_shape_count, shapes_per_world,
        worlds, body_ids, body_indices, body_com, body_count, particles_per_world, x, velocity, previous, inv_dt};
    RigidContact contact;
    if (!rigid_contact<false>(view, i, contact)) return;
    const glm::vec3 fnv = contact.normal * -contact.fn, ftv = contact.tangent * contact.eta;
    if (force) {
        #pragma unroll
        for (int side = 0; side < 2; ++side) {
            if (contact.slots[side] < 0) continue;
            const glm::vec3 rn = contact.raw[side] - contact.com[side];
            const glm::vec3 rt = contact.adjusted[side] - contact.com[side];
            if (contact.separate) {
                rigid_scatter(force, contact.ids[side], fnv, rn, side == 0);
                rigid_scatter(force, contact.ids[side], ftv, rt, side == 0);
            } else rigid_scatter(force, contact.ids[side], fnv + ftv, rn, side == 0);
        }
    }
    if (scalar) {
        #pragma unroll
        for (int side = 0; side < 2; ++side) {
            if (contact.slots[side] < 0) continue;
            const glm::vec3 rn = contact.raw[side] - contact.com[side];
            const glm::vec3 rt = contact.adjusted[side] - contact.com[side];
            if (contact.separate) {
                rigid_scatter_scalar(scalar, contact.ids[side], contact.normal_stiffness, rn);
                if (contact.friction_stiffness > 0.0f)
                    rigid_scatter_scalar(scalar, contact.ids[side], contact.friction_stiffness, rt);
            } else {
                rigid_scatter_scalar(scalar, contact.ids[side],
                    fmaxf(contact.normal_stiffness, contact.friction_stiffness), rn);
            }
        }
    }
}

// Off-diagonal Jacobian products followed by per-particle corrections to the isotropic diagonal split.
__global__ void evaluate_contact_tangent(const int* count, size_t capacity, const int* shape0, const int* shape1,
    const glm::vec3* point0, const glm::vec3* point1, const glm::vec3* offset0, const glm::vec3* offset1,
    const glm::vec3* normal, const float* margin0, const float* margin1, const int* shape_body, const int* shape_type,
    const Transform* transform, const glm::vec3* shape_scale, const float* ke, const float* kd, const float* kf,
    const float* mu, float epsilon, size_t local_shape_count, size_t shapes_per_world, size_t worlds,
    const int* body_ids, const glm::ivec4* body_indices, const glm::vec3* body_com, size_t body_count,
    const glm::vec3* x, const glm::vec3* previous, const glm::vec3* direction, glm::vec3* product, float inv_dt,
    size_t particles_per_world, glm::mat3* system, glm::mat3* precond)
{
    const size_t i = thread_index();
    if (i >= capacity || !count || i >= static_cast<size_t>(max(*count, 0))) return;
    const RigidContactView view = {shape0, shape1, point0, point1, offset0, offset1, normal, margin0, margin1,
        shape_body, shape_type, transform, shape_scale, ke, kd, kf, mu, epsilon, local_shape_count, shapes_per_world,
        worlds, body_ids, body_indices, body_com, body_count, particles_per_world, x, nullptr, previous, inv_dt};
    RigidContact contact;
    if (!rigid_contact<true>(view, i, contact)) return;
    const glm::vec3 n = contact.normal;
    const float products[6] = {n.x * n.x, n.y * n.x, n.z * n.x, n.y * n.y, n.z * n.y, n.z * n.z};
    const float proj[6] = {1.0f - products[0], 0.0f - products[1], 0.0f - products[2],
                           1.0f - products[3], 0.0f - products[4], 1.0f - products[5]};
    const float c = contact.fn > 0.0f ? contact.normal_stiffness : 0.0f;
    const float f = contact.friction_stiffness;
    int targets[8], entries = 0;
    float normal_weights[8], friction_weights[8];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        if (contact.slots[side] < 0) continue;
        const glm::vec3 rn = contact.raw[side] - contact.com[side];
        const glm::vec3 rf = contact.adjusted[side] - contact.com[side];
        const float sign = side == 0 ? -1.0f : 1.0f;
        const float wn[4] = {sign, sign * rn.x, sign * rn.y, sign * rn.z};
        const float wf[4] = {sign, sign * rf.x, sign * rf.y, sign * rf.z};
        #pragma unroll
        for (int coordinate = 0; coordinate < 4; ++coordinate) {
            targets[entries + coordinate] = contact.ids[side][coordinate];
            normal_weights[entries + coordinate] = wn[coordinate];
            friction_weights[entries + coordinate] = wf[coordinate];
        }
        entries += 4;
    }
    if (direction && product) {
        #pragma unroll
        for (int part = 0; part < 2; ++part) {
            float matrix[6];
            #pragma unroll
            for (int component = 0; component < 6; ++component)
                matrix[component] = part == 0 ? c * products[component] : f * proj[component];
            for (int a = 0; a < entries; ++a) {
                glm::vec3 sum(0.0f);
                for (int b = 0; b < entries; ++b) {
                    if (targets[a] == targets[b]) continue;
                    sum = contact_fma(part == 0 ? normal_weights[b] : friction_weights[b], direction[targets[b]], sum);
                }
                const glm::vec3 y(
                    fmaf(matrix[2], sum.z, fmaf(matrix[0], sum.x, matrix[1] * sum.y)),
                    fmaf(matrix[4], sum.z, fmaf(matrix[1], sum.x, matrix[3] * sum.y)),
                    fmaf(matrix[5], sum.z, fmaf(matrix[2], sum.x, matrix[4] * sum.y)));
                atomic_add(&product[targets[a]], y * (part == 0 ? normal_weights[a] : friction_weights[a]));
            }
        }
    }
    if (!system && !precond) return;
    for (int a = 0; a < entries; ++a) {
        const float n2 = normal_weights[a] * normal_weights[a];
        const float f2 = friction_weights[a] * friction_weights[a];
        const float sf = f * f2;
        const float iso = contact.separate ? fmaf(contact.normal_stiffness, n2, sf) :
            n2 * fmaxf(contact.normal_stiffness, f);
        const float cn = c * n2, zero = iso * 0.0f;
        const float xx = fmaf(cn, products[0], proj[0] * sf) - iso;
        const float xy = fmaf(cn, products[1], proj[1] * sf) - zero;
        const float xz = fmaf(cn, products[2], proj[2] * sf) - zero;
        const float yy = fmaf(cn, products[3], proj[3] * sf) - iso;
        const float yz = fmaf(cn, products[4], proj[4] * sf) - zero;
        const float zz = fmaf(cn, products[5], proj[5] * sf) - iso;
        const glm::mat3 block(glm::vec3(xx, xy, xz), glm::vec3(xy, yy, yz), glm::vec3(xz, yz, zz));
        #pragma unroll
        for (int column = 0; column < 3; ++column) {
            #pragma unroll
            for (int row = 0; row < 3; ++row) {
                if (system) atomicAdd(&system[targets[a]][column][row], block[column][row]);
                if (precond) atomicAdd(&precond[targets[a]][column][row], block[column][row]);
            }
        }
    }
}

} // namespace synreal::kernel
