#include "contact_geometry.cuh"

namespace synreal::kernel {

struct RollingContactView {
    const int* count;
    size_t capacity;
    const int* shape0;
    const int* shape1;
    const glm::vec3* point0;
    const glm::vec3* point1;
    const glm::vec3* offset0;
    const glm::vec3* offset1;
    const glm::vec3* normal;
    const float* margin0;
    const float* margin1;
    const int* shape_body;
    const int* shape_type;
    const Transform* transform;
    const glm::vec3* shape_scale;
    const float* ke;
    const float* kd;
    const float* rolling;
    const float* torsional;
    size_t local_shape_count;
    size_t shapes_per_world;
    size_t worlds;
    const int* body_ids;
    const glm::ivec4* body_indices;
    const glm::vec3* body_com;
    const float* inertia;
    size_t body_count;
    size_t particles_per_world;
    const glm::vec3* x;
    const glm::vec3* previous;
    float inv_dt;
    float epsilon;
};
static_assert(sizeof(RollingContactView) == 248);
static_assert(offsetof(RollingContactView, inertia) == 200);
static_assert(offsetof(RollingContactView, inv_dt) == 240);

struct RollingContact {
    int entries;
    int targets[6];
    glm::vec3 gradient[6][3];
    glm::vec3 omega;
    float roll_coefficient;
    float spin_coefficient;
};

__device__ __forceinline__ bool rolling_finite(const glm::vec3& v)
{
    return fabsf(v.x) < INFINITY && fabsf(v.y) < INFINITY && fabsf(v.z) < INFINITY;
}

__device__ __forceinline__ float rolling_fms(float a, float b, float c, float d)
{
    return a * b - c * d;
}

// Inertia input and the inverse rows are row-major. B_k is A times row k of J = tr(I)/2 I_3 - I.
__device__ __forceinline__ bool rolling_inertia(const glm::ivec4& ids, const float* inertia,
    const glm::vec3* x, glm::vec3* b, glm::vec3* inverse_rows)
{
    const glm::vec3 a0 = x[ids.y], a1 = x[ids.z], a2 = x[ids.w];
    const float half = ((inertia[0] + inertia[4]) + inertia[8]) * 0.5f;
    const float zero = half * 0.0f;
    float j[3][3];
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        #pragma unroll
        for (int column = 0; column < 3; ++column)
            j[row][column] = (row == column ? half : zero) - inertia[3 * row + column];
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        b[row] = contact_fma(j[row][2], a2, contact_fma(j[row][0], a0, a1 * j[row][1]));
    float w[3][3], m[3][3];
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        #pragma unroll
        for (int column = 0; column < 3; ++column)
            w[row][column] = fmaf(a2[row], b[2][column], fmaf(a0[row], b[0][column], a1[row] * b[1][column]));
    const float trace = w[2][2] + (w[0][0] + w[1][1]);
    const float zero_trace = trace * 0.0f;
    #pragma unroll
    for (int row = 0; row < 3; ++row)
        #pragma unroll
        for (int column = 0; column < 3; ++column)
            m[row][column] = (row == column ? trace : zero_trace) - w[row][column];
    const float c00 = rolling_fms(m[1][1], m[2][2], m[2][1], m[1][2]);
    const float c01 = rolling_fms(m[1][2], m[2][0], m[2][2], m[1][0]);
    const float c02 = rolling_fms(m[1][0], m[2][1], m[1][1], m[2][0]);
    const float det = fmaf(m[0][2], c02, fmaf(m[0][0], c00, m[0][1] * c01));
    if (!(det > 1e-30f) || !(fabsf(det) < INFINITY)) return false;
    const float inverse_det = 1.0f / det;
    inverse_rows[0] = glm::vec3(c00, c01, c02) * inverse_det;
    inverse_rows[1] = glm::vec3(rolling_fms(m[2][1], m[0][2], m[2][2], m[0][1]),
        rolling_fms(m[2][2], m[0][0], m[0][2], m[2][0]),
        rolling_fms(m[2][0], m[0][1], m[0][0], m[2][1])) * inverse_det;
    inverse_rows[2] = glm::vec3(rolling_fms(m[0][1], m[1][2], m[1][1], m[0][2]),
        rolling_fms(m[0][2], m[1][0], m[0][0], m[1][2]),
        rolling_fms(m[0][0], m[1][1], m[1][0], m[0][1])) * inverse_det;
    return true;
}

__device__ __forceinline__ glm::vec3 rolling_inverse(const glm::vec3* rows, const glm::vec3& d, bool negate)
{
    glm::vec3 result;
    #pragma unroll
    for (int row = 0; row < 3; ++row) {
        if (negate)
            result[row] = rolling_fms(rows[row].x, -d.x, rows[row].y, d.y) - rows[row].z * d.z;
        else result[row] = contact_dot(rows[row], d);
    }
    return result;
}

template<bool CandidateXFirst = false>
__device__ __forceinline__ bool rolling_contact(const RollingContactView& view, size_t i, RollingContact& contact)
{
    contact.entries = 0;
    contact.omega = glm::vec3(0.0f);
    const int shapes[2] = {view.shape0[i], view.shape1[i]};
    int local[2], worlds[2], slots[2];
    glm::ivec4 ids[2];
    glm::vec3 com[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        if (!contact_shape(shapes[side], view.local_shape_count, view.shapes_per_world, view.worlds,
                           worlds[side], local[side])) return false;
        const int body = view.shape_body[local[side]];
        slots[side] = contact_body_slot(body, view.body_ids, view.body_count);
        if ((body >= 0 && slots[side] < 0) || (slots[side] >= 0 && worlds[side] < 0)) return false;
        ids[side] = slots[side] >= 0 ? view.body_indices[slots[side]] +
            static_cast<int>(static_cast<size_t>(worlds[side]) * view.particles_per_world) : glm::ivec4(0);
        com[side] = slots[side] >= 0 ? view.body_com[slots[side]] : glm::vec3(0.0f);
    }
    if (slots[0] == slots[1]) return false;
    if (worlds[0] >= 0 && worlds[1] >= 0 && worlds[0] != worlds[1]) return false;
    const float mu_r = view.rolling ? fmaxf(view.rolling[local[0]], view.rolling[local[1]]) : 0.0f;
    const float mu_t = view.torsional ? fmaxf(view.torsional[local[0]], view.torsional[local[1]]) : 0.0f;
    if (!(mu_r > 0.0f) && !(mu_t > 0.0f)) return false;
    glm::vec3 n = contact_normalize(view.normal[i]);
    const glm::vec3 points[2] = {view.point0[i], view.point1[i]};
    glm::vec3 raw[2], adjusted[2], world_points[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        raw[side] = view.shape_type[local[side]] == 3 ? view.transform[local[side]].position : points[side];
        world_points[side] = slots[side] >= 0 ? contact_point(raw[side], ids[side], com[side], view.x) : raw[side];
    }
    glm::vec3 candidate(0.0f);
    if (view.shape_type[local[0]] == 3 && view.shape_type[local[1]] == 3)
        candidate = contact_normalize(world_points[1] - world_points[0]);
    // Only the preconditioner tests the sphere candidate with an x-first squared norm. The fallback
    // supplied normal is y-first in all three entries; reuse the selected norm for the final guard.
    float normal_squared = CandidateXFirst ? contact_dot_x_first(candidate, candidate) : contact_dot(candidate, candidate);
    if (normal_squared >= 0.5f) n = candidate;
    else normal_squared = contact_dot(n, n);
    if (!(normal_squared >= 0.5f)) return false;
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        adjusted[side] = raw[side];
        if (view.shape_type[local[side]] == 3) {
            const float radius = view.shape_scale[local[side]].x;
            const glm::vec3 v = side == 0 ? radius * n : -(radius * n);
            adjusted[side] = slots[side] >= 0 ? raw[side] + contact_sphere_offset(v, ids[side], view.x) :
                contact_fma(side == 0 ? radius : -radius, n, raw[side]);
        }
        const glm::vec3* offset = side == 0 ? view.offset0 : view.offset1;
        if (offset) adjusted[side] = points[side] + offset[i];
    }
    const float depth = (view.margin0[i] + view.margin1[i]) - contact_dot(world_points[1] - world_points[0], n);
    if (!(depth > 0.0f)) return false;
    glm::vec3 velocity[2] = {glm::vec3(0.0f), glm::vec3(0.0f)};
    float radius = 0.0f;
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        if (slots[side] < 0) continue;
        velocity[side] = contact_point_velocity(raw[side], ids[side], com[side], view.x, view.previous, nullptr, view.inv_dt);
        const glm::vec3 lever = contact_surface_velocity(adjusted[side] - com[side], ids[side], view.x);
        const float length = sqrtf(contact_dot(lever, lever));
        if (!(length > 0.0f) || !(fabsf(length) < INFINITY)) return false;
        radius = side == 1 && radius > 0.0f ? fminf(radius, length) : length;
    }
    const float vn = contact_dot(velocity[1] - velocity[0], n);
    const float ke = fmaxf(view.ke[local[0]], view.ke[local[1]]);
    const float kd = fmaxf(view.kd[local[0]], view.kd[local[1]]);
    const float fn = fmaxf(depth * ke - vn * kd, 0.0f);
    const float tau_r = radius * (mu_r * fn), tau_t = radius * (mu_t * fn);
    if (!(fn > 0.0f) || !(fabsf(tau_r) < INFINITY) || !(fabsf(tau_t) < INFINITY)) return false;
    const bool near_x = fabsf(n.x) < 0.9f;
    const float ax = near_x ? 1.0f : 0.0f, ay = near_x ? 0.0f : 1.0f;
    const glm::vec3 tangent1 = contact_normalize(glm::vec3(rolling_fms(n.y, 0.0f, ay, n.z),
        rolling_fms(ax, n.z, n.x, 0.0f), rolling_fms(ay, n.x, ax, n.y)));
    const glm::vec3 directions[3] = {tangent1, glm::cross(n, tangent1), n};
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        if (slots[side] < 0) continue;
        glm::vec3 rows[3][3];
        #pragma unroll
        for (int d = 0; d < 3; ++d) {
            glm::vec3 b[3], inverse[3];
            if (!rolling_inertia(ids[side], view.inertia + 9 * slots[side], view.x, b, inverse)) return false;
            const glm::vec3 u = rolling_inverse(inverse, directions[d], side == 1);
            if (!rolling_finite(u)) return false;
            #pragma unroll
            for (int k = 0; k < 3; ++k)
                rows[d][k] = glm::vec3(rolling_fms(b[k].z, u.y, b[k].y, u.z),
                    rolling_fms(b[k].x, u.z, b[k].z, u.x), rolling_fms(b[k].y, u.x, b[k].x, u.y));
        }
        #pragma unroll
        for (int k = 0; k < 3; ++k) {
            const int particle = ids[side][k + 1];
            const glm::vec3 v = (view.x[particle] - view.previous[particle]) * view.inv_dt;
            contact.targets[contact.entries] = particle;
            #pragma unroll
            for (int d = 0; d < 3; ++d) {
                contact.gradient[contact.entries][d] = rows[d][k];
                contact.omega[d] = contact_dot(v, rows[d][k]) + contact.omega[d];
            }
            ++contact.entries;
        }
    }
    const float roll = sqrtf(fmaf(contact.omega.x, contact.omega.x, contact.omega.y * contact.omega.y));
    const float spin = fabsf(contact.omega.z);
    if (!(fabsf(roll) < INFINITY) || !(fabsf(spin) < INFINITY)) return false;
    contact.roll_coefficient = tau_r / fmaxf(view.epsilon, roll);
    contact.spin_coefficient = tau_t / fmaxf(view.epsilon, spin);
    return fabsf(contact.roll_coefficient) < INFINITY && fabsf(contact.spin_coefficient) < INFINITY;
}

__device__ __forceinline__ void rolling_scatter(const RollingContact& contact, const glm::vec3& scale,
                                               glm::vec3* output)
{
    const int unrolled = contact.entries & ~3;
    for (int at = 0; at < unrolled; at += 4) {
        #pragma unroll
        for (int k = 0; k < 4; ++k) {
            const glm::vec3* g = contact.gradient[at + k];
            atomic_add(&output[contact.targets[at + k]], contact_fma(scale.z, g[2],
                contact_fma(scale.x, g[0], scale.y * g[1])));
        }
    }
    for (int at = unrolled; at < contact.entries; ++at) {
        const glm::vec3* g = contact.gradient[at];
        atomic_add(&output[contact.targets[at]], contact_fma(scale.z, g[2],
            contact_fma(scale.x, g[0], scale.y * g[1])));
    }
}

__global__ void evaluate_rolling_contact_force(RollingContactView view, glm::vec3* force)
{
    const size_t i = thread_index();
    if (!view.count || i >= view.capacity || i >= static_cast<size_t>(max(*view.count, 0))) return;
    RollingContact contact;
    if (!rolling_contact(view, i, contact)) return;
    rolling_scatter(contact, glm::vec3(-(contact.roll_coefficient * contact.omega.x),
        -(contact.roll_coefficient * contact.omega.y), -(contact.spin_coefficient * contact.omega.z)), force);
}

__global__ void add_rolling_contact_preconditioner(RollingContactView view, glm::mat3* blocks)
{
    const size_t i = thread_index();
    if (!view.count || i >= view.capacity || i >= static_cast<size_t>(max(*view.count, 0))) return;
    RollingContact contact;
    if (!rolling_contact<true>(view, i, contact)) return;
    const float sr = view.inv_dt * contact.roll_coefficient, st = view.inv_dt * contact.spin_coefficient;
    for (int at = 0; at < contact.entries; ++at) {
        const glm::vec3* g = contact.gradient[at];
        #pragma unroll
        for (int component = 0; component < 9; ++component) {
            const int row = component / 3, column = component % 3;
            const int lo = row < column ? row : column, hi = row > column ? row : column;
            const float value = fmaf(st, g[2][lo] * g[2][hi],
                fmaf(sr, g[0][lo] * g[0][hi], sr * (g[1][lo] * g[1][hi])));
            atomicAdd(reinterpret_cast<float*>(&blocks[contact.targets[at]]) + component, value);
        }
    }
}

__global__ void multiply_rolling_contact_tangent(RollingContactView view, const glm::vec3* direction,
                                                 glm::vec3* product)
{
    const size_t i = thread_index();
    if (!view.count || i >= view.capacity || i >= static_cast<size_t>(max(*view.count, 0))) return;
    RollingContact contact;
    if (!rolling_contact(view, i, contact)) return;
    glm::vec3 sum(0.0f);
    for (int at = 0; at < contact.entries; ++at) {
        const glm::vec3 p = direction[contact.targets[at]];
        #pragma unroll
        for (int d = 0; d < 3; ++d) sum[d] = contact_dot(contact.gradient[at][d], p) + sum[d];
    }
    rolling_scatter(contact, glm::vec3((view.inv_dt * contact.roll_coefficient) * sum.x,
        (view.inv_dt * contact.roll_coefficient) * sum.y, (view.inv_dt * contact.spin_coefficient) * sum.z), product);
}

} // namespace synreal::kernel
