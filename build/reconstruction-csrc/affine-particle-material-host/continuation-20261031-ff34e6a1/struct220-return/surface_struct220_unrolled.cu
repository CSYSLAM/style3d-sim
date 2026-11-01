#include "/home/oem/code/agent/style3d-sim/reconstruction/csrc/kernels/contact_geometry.cuh"

namespace synreal::kernel {

struct SurfaceContactView {
    const int* count;
    size_t capacity;
    const glm::ivec3* indices;
    const glm::vec3* barycentric;
    const int* shape;
    const glm::vec3* body_pos;
    const glm::vec3* body_vel;
    const glm::vec3* normal;
    const int* particle_only;
    size_t particle_only_count;
    const float* radius;
    const float* mass;
    const int* flags;
    const int* kind;
    size_t particles_per_world;
    size_t total_particles;
    const int* shape_body;
    const int* shape_type;
    const Transform* transform;
    const glm::vec3* shape_scale;
    const float* shape_margin;
    const float* shape_ke;
    const float* shape_kd;
    const float* shape_kf;
    const float* shape_mu;
    size_t local_shape_count;
    size_t shapes_per_world;
    size_t worlds;
    float ke;
    float kd;
    float kf;
    float mu;
    const int* body_ids;
    const glm::ivec4* body_indices;
    const glm::vec3* body_com;
    size_t body_count;
    const glm::vec3* x;
    const glm::vec3* previous;
    float inv_dt;
};
static_assert(sizeof(SurfaceContactView) == 296);
static_assert(offsetof(SurfaceContactView, particles_per_world) == 112);
static_assert(offsetof(SurfaceContactView, ke) == 224);
static_assert(offsetof(SurfaceContactView, inv_dt) == 288);

struct SurfaceJacobianTrial {
    int targets[7];
    float weights[7];
    int count;
    __device__ __forceinline__ void append(int target, float weight) {
        targets[count] = target;
        weights[count] = weight;
        ++count;
    }
};
struct SurfaceContactTrial {
    SurfaceJacobianTrial normal_jacobian, friction_jacobian;
    glm::vec3 normal_force, friction_force;
    glm::mat3 normal_matrix, friction_matrix;
    float stiffness_sum;
};
static_assert(sizeof(SurfaceJacobianTrial) == 60);
static_assert(sizeof(SurfaceContactTrial) == 220);
static_assert(offsetof(SurfaceContactTrial, normal_force) == 120);
static_assert(offsetof(SurfaceContactTrial, normal_matrix) == 144);
static_assert(offsetof(SurfaceContactTrial, stiffness_sum) == 216);

__device__ __forceinline__ glm::mat3 trial_matrix(const glm::vec3& n, float scale, bool friction)
{
    const float xx = friction ? 1.0f - n.x * n.x : n.x * n.x;
    const float xy = friction ? 0.0f - n.y * n.x : n.y * n.x;
    const float xz = friction ? 0.0f - n.z * n.x : n.z * n.x;
    const float yy = friction ? 1.0f - n.y * n.y : n.y * n.y;
    const float yz = friction ? 0.0f - n.z * n.y : n.z * n.y;
    const float zz = friction ? 1.0f - n.z * n.z : n.z * n.z;
    return glm::mat3(glm::vec3(xx, xy, xz) * scale, glm::vec3(xy, yy, yz) * scale, glm::vec3(xz, yz, zz) * scale);
}

__device__ __forceinline__ bool surface_finite(const glm::vec3& v)
{
    return fabsf(v.x) < INFINITY && fabsf(v.y) < INFINITY && fabsf(v.z) < INFINITY;
}

// The three vertices share a world. Zero barycentric weights still participate in kind/radius validation,
// but only nonzero weights enter either Jacobian list. Mass/flag activity controls the damping mass alone.
template <bool NormalXFirst, bool TangentXFirst>
__device__ __forceinline__ SurfaceContactTrial surface_contact(const SurfaceContactView& view, size_t i)
{
    SurfaceContactTrial contact{};
    contact.normal_jacobian.count = contact.friction_jacobian.count = 0;
    if (view.particles_per_world == 0) return SurfaceContactTrial{};
    const int raw_shape = view.shape[i];
    if (view.particle_only && raw_shape >= 0 && static_cast<size_t>(raw_shape) < view.particle_only_count &&
        view.particle_only[raw_shape] != 0) return SurfaceContactTrial{};
    const glm::ivec3 vertices = view.indices[i];
    const glm::vec3 weights = view.barycentric[i];
    if (vertices.x < 0 || static_cast<size_t>(vertices.x) >= view.total_particles) return SurfaceContactTrial{};
    const size_t world = static_cast<size_t>(vertices.x) / view.particles_per_world;
    if (world >= view.worlds) return SurfaceContactTrial{};
    int shape_world, s;
    if (!contact_shape(raw_shape, view.local_shape_count, view.shapes_per_world, view.worlds, shape_world, s)) return SurfaceContactTrial{};
    if (shape_world >= 0 && shape_world != static_cast<int>(world)) return SurfaceContactTrial{};
    glm::vec3 point(0.0f), velocity(0.0f);
    float radius = 0.0f, inverse_mass = 0.0f, total = 0.0f;
    #pragma unroll
    for (int j = 0; j < 3; ++j) {
        const int vertex = vertices[j];
        if (vertex < 0) continue;
        const float b = weights[j];
        if (!(fabsf(b) < INFINITY) || b < 0.0f || static_cast<size_t>(vertex) >= view.total_particles) return SurfaceContactTrial{};
        if (static_cast<size_t>(vertex) / view.particles_per_world != world) return SurfaceContactTrial{};
        const size_t local = static_cast<size_t>(vertex) % view.particles_per_world;
        if (view.kind && view.kind[local] != 0) return SurfaceContactTrial{};
        radius = fmaxf(radius, view.radius[local]);
        if (b == 0.0f) continue;
        contact.normal_jacobian.append(vertex, b);
        contact.friction_jacobian.append(vertex, b);
        total = total + b;
        point = contact_fma(b, view.x[vertex], point);
        velocity = contact_fma(b * view.inv_dt, view.x[vertex] - view.previous[vertex], velocity);
        const float mass = view.mass[local];
        if (mass > 0.0f && (!view.flags || (view.flags[local] & 1))) inverse_mass = (b * b) / mass + inverse_mass;
    }
    if (!(fabsf(radius) < INFINITY) || !contact.normal_jacobian.count || fabsf(total - 1.0f) > 1e-4f) return SurfaceContactTrial{};
    const int body = view.shape_body[s];
    const int slot = contact_body_slot(body, view.body_ids, view.body_count);
    if ((body >= 0 && slot < 0) || (slot >= 0 && shape_world < 0)) return SurfaceContactTrial{};
    const glm::ivec4 ids = slot >= 0 ? view.body_indices[slot] +
        static_cast<int>(static_cast<size_t>(shape_world) * view.particles_per_world) : glm::ivec4(0);
    const glm::vec3 com = slot >= 0 ? view.body_com[slot] : glm::vec3(0.0f);
    glm::vec3 n = contact_normalize(view.normal[i]);
    const bool sphere = view.shape_type[s] == 3;
    const glm::vec3 raw = sphere ? view.transform[s].position : view.body_pos[i];
    glm::vec3 world_point = slot >= 0 ? contact_point(raw, ids, com, view.x) : raw;
    glm::vec3 adjusted = raw;
    if (sphere) {
        const glm::vec3 d = point - world_point;
        const glm::vec3 alternative = normalized_or_zero(d, sqrtf(contact_dot_x_first(d, d)), 0.0f);
        if (contact_dot(alternative, alternative) >= 0.5f) n = alternative;
        const glm::vec3 rn = view.shape_scale[s].x * n;
        adjusted = raw + (slot >= 0 ? contact_sphere_offset(rn, ids, view.x) : rn);
        world_point = rn + world_point;
    }
    const float n2 = __fadd_rn(n.z * n.z, __fadd_rn(n.y * n.y, n.x * n.x));
    if (!(n2 >= 0.5f)) return SurfaceContactTrial{};
    glm::vec3 raw_velocity = view.body_vel[i], adjusted_velocity = raw_velocity;
    if (slot >= 0) {
        const glm::vec3 body_velocity = contact_surface_velocity(raw_velocity, ids, view.x);
        raw_velocity = body_velocity + contact_point_velocity(raw, ids, com, view.x, view.previous, nullptr, view.inv_dt);
        adjusted_velocity = body_velocity +
            contact_point_velocity(adjusted, ids, com, view.x, view.previous, nullptr, view.inv_dt);
        const glm::vec3 rn = raw - com, rt = adjusted - com;
        const float wn[4] = {-1.0f, -rn.x, -rn.y, -rn.z};
        const float wt[4] = {-1.0f, -rt.x, -rt.y, -rt.z};
        #pragma unroll
        for (int j = 0; j < 4; ++j) {
            contact.normal_jacobian.append(ids[j], wn[j]);
            contact.friction_jacobian.append(ids[j], wt[j]);
        }
    }
    const glm::vec3 relative = point - world_point, r1 = velocity - raw_velocity, r2 = velocity - adjusted_velocity;
    if (!surface_finite(relative) || !surface_finite(r1) || !surface_finite(r2)) return SurfaceContactTrial{};
    const float depth = (radius + view.shape_margin[s]) - contact_dot(relative, n);
    if (!(fabsf(depth) < INFINITY) || depth <= 0.0f) return SurfaceContactTrial{};
    const float ke = fminf(view.ke, view.shape_ke[s]);
    float kd = fminf(view.kd, view.shape_kd[s]);
    if (inverse_mass > 0.0f) {
        const float root = sqrtf(ke / inverse_mass);
        kd = fminf(kd, root + root);
    }
    const float vn = NormalXFirst ? contact_dot_x_first(r1, n) : contact_dot(r1, n);
    if (!(fabsf(vn) < INFINITY)) return SurfaceContactTrial{};
    const float kdh = kd * view.inv_dt;
    const float ahead = fmaxf(depth + vn / view.inv_dt, 0.0f);
    const float fn = fmaxf(fmaf(depth, ke, kdh * (depth - ahead)), 0.0f);
    if (fn <= 0.0f) return SurfaceContactTrial{};
    const float vn2 = TangentXFirst ? contact_dot_x_first(r2, n) : contact_dot(r2, n);
    const glm::vec3 tangent = r2 - vn2 * n;
    const float speed = sqrtf(contact_dot(tangent, tangent));
    if (!(fabsf(speed) < INFINITY)) return SurfaceContactTrial{};
    const float limit = fn * fminf(view.mu, view.shape_mu[s]);
    float eta = 0.0f;
    if (limit > 0.0f)
        eta = fminf(fminf(view.kf, view.shape_kf[s]), limit / fmaxf(speed, 1e-8f));
    contact.normal_force = fn * n;
    contact.friction_force = -eta * tangent;
    contact.stiffness_sum = ke + kdh;
    contact.normal_matrix = trial_matrix(n, fmaf(kd, view.inv_dt, ke), false);
    contact.friction_matrix = trial_matrix(n, eta * view.inv_dt, true);
    return contact;
}


__device__ __forceinline__ void trial_scatter(const SurfaceJacobianTrial& jacobian,
                                              const glm::vec3& value, glm::vec3* output)
{
    for (int j = 0; j < jacobian.count; ++j)
        atomic_add(&output[jacobian.targets[j]], jacobian.weights[j] * value);
}

__device__ __forceinline__ void trial_scatter_blocks(const SurfaceJacobianTrial& jacobian,
                                                    const glm::mat3& matrix, glm::mat3* output)
{
    #pragma unroll
    for (int j = 0; j < 7; ++j) {
        if (j >= jacobian.count) break;
        const float w = jacobian.weights[j];
        atomic_add(&output[jacobian.targets[j]], matrix * (w * w));
    }
}

__device__ __forceinline__ void trial_product(const SurfaceJacobianTrial& jacobian,
                                             const glm::mat3& matrix, const glm::vec3* direction, glm::vec3* output)
{
    glm::vec3 sum(0.0f);
    for (int j = 0; j < jacobian.count; ++j)
        sum = contact_fma(jacobian.weights[j], direction[jacobian.targets[j]], sum);
    const glm::vec3 value(contact_dot(matrix[0], sum), contact_dot(matrix[1], sum), contact_dot(matrix[2], sum));
    trial_scatter(jacobian, value, output);
}

__global__ void evaluate_surface_contact_force(SurfaceContactView view, glm::vec3* force)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact = surface_contact<false, true>(view, i);
        trial_scatter(contact.normal_jacobian, contact.normal_force, force);
        trial_scatter(contact.friction_jacobian, contact.friction_force, force);
    }
}

__global__ void add_surface_contact_stiffness_scale(SurfaceContactView view, float* scale)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact = surface_contact<true, true>(view, i);
        for (int j = 0; j < contact.normal_jacobian.count; ++j) {
            const float w = contact.normal_jacobian.weights[j];
            atomicAdd(&scale[contact.normal_jacobian.targets[j]], (w * w) * contact.stiffness_sum);
        }
    }
}

__global__ void add_surface_contact_preconditioner(SurfaceContactView view, glm::mat3* blocks)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact = surface_contact<true, true>(view, i);
        trial_scatter_blocks(contact.normal_jacobian, contact.normal_matrix, blocks);
        trial_scatter_blocks(contact.friction_jacobian, contact.friction_matrix, blocks);
    }
}

__global__ void multiply_surface_contact_tangent(SurfaceContactView view, const glm::vec3* direction,
                                                glm::vec3* product)
{
    const size_t bound = min(view.capacity, static_cast<size_t>(max(*view.count, 0)));
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        SurfaceContactTrial contact = surface_contact<false, false>(view, i);
        trial_product(contact.normal_jacobian, contact.normal_matrix, direction, product);
        trial_product(contact.friction_jacobian, contact.friction_matrix, direction, product);
    }
}
} // namespace synreal::kernel
