#include "contact_geometry.cuh"

namespace synreal::kernel {

// Particle/affine penalty contact: normal reactions use the raw lever, friction uses the sphere surface lever.
// The two optional block copies are updated component by component, including when their pointers alias.
__global__ void evaluate_soft_contact_force(const int* count, size_t capacity, const int* particle,
    const int* shape, const glm::vec3* body_pos, const glm::vec3* body_vel, const glm::vec3* normal,
    const float* radius, const float* mass, const int* particle_kind, size_t particles_per_world,
    size_t total_particles, const int* shape_body, const int* shape_type, const Transform* shape_transform,
    const glm::vec3* shape_scale, const float* shape_margin, const float* shape_ke, const float* shape_kd,
    const float* shape_kf, const float* shape_mu, size_t local_shape_count, size_t shapes_per_world, size_t worlds,
    float global_ke, float global_kd, float global_kf, float global_mu, const int* body_ids,
    const glm::ivec4* body_indices, const glm::vec3* body_com, size_t body_count, const glm::vec3* x,
    const glm::vec3* velocity, const glm::vec3* previous, float inv_dt, glm::vec3* force, float* scalar,
    const int* shape_filter, size_t filter_count, glm::mat3* system, glm::mat3* precond)
{
    const size_t i = thread_index();
    const size_t active = count ? static_cast<size_t>(max(*count, 0)) : 0;
    if (i >= min(active, capacity)) return;
    const int p = particle[i], raw_shape = shape[i];
    if (shape_filter && (raw_shape < 0 || static_cast<size_t>(raw_shape) >= filter_count || !shape_filter[raw_shape]))
        return;
    if (p < 0 || static_cast<size_t>(p) >= total_particles || particles_per_world == 0) return;
    const size_t particle_world = static_cast<size_t>(p) / particles_per_world;
    int shape_world, s;
    if (!contact_shape(raw_shape, local_shape_count, shapes_per_world, worlds, shape_world, s)) return;
    if (shape_world >= 0 && shape_world != static_cast<int>(particle_world)) return;
    const size_t local_p = static_cast<size_t>(p) % particles_per_world;
    const float particle_mass = mass[local_p];
    if (!(particle_mass > 0.0f) || (particle_kind && particle_kind[local_p] != 0)) return;
    const int body = shape_body[s];
    const int slot = contact_body_slot(body, body_ids, body_count);
    if ((body >= 0 && slot < 0) || (slot >= 0 && shape_world < 0)) return;
    glm::ivec4 ids(0);
    glm::vec3 com(0.0f);
    if (slot >= 0) {
        ids = body_indices[slot] + static_cast<int>(static_cast<size_t>(shape_world) * particles_per_world);
        com = body_com[slot];
    }
    const bool sphere = shape_type[s] == 3;
    const glm::vec3 raw = sphere ? shape_transform[s].position : body_pos[i];
    glm::vec3 world_point = slot >= 0 ? contact_point(raw, ids, com, x) : raw;
    glm::vec3 n = contact_normalize(normal[i]);
    const glm::vec3 xp = x[p];
    const float r = shape_scale[s].x;
    glm::vec3 adjusted = raw;
    if (sphere) {
        const glm::vec3 alternative = contact_normalize(xp - world_point);
        if (contact_dot(alternative, alternative) >= 0.5f) n = alternative;
        adjusted = slot >= 0 ? raw + contact_sphere_offset(r * n, ids, x) : contact_fma(r, n, raw);
    }
    const float nx2 = n.x * n.x, ny2 = n.y * n.y, nz2 = n.z * n.z;
    if (!(nz2 + (ny2 + nx2) > 0.0f)) return;
    if (sphere) world_point = contact_fma(r, n, world_point);
    const float depth = (radius[local_p] + shape_margin[s]) - contact_dot(xp - world_point, n);
    if (depth <= 0.0f) return;
    const glm::vec3 vp = contact_velocity(p, x, previous, velocity, inv_dt);
    glm::vec3 v_raw = body_vel[i], v_adjusted = v_raw;
    if (slot >= 0) {
        const glm::vec3 bv = contact_surface_velocity(v_raw, ids, x);
        v_raw = contact_point_velocity(raw, ids, com, x, previous, velocity, inv_dt) + bv;
        v_adjusted = contact_point_velocity(adjusted, ids, com, x, previous, velocity, inv_dt) + bv;
    }
    const glm::vec3 r1 = vp - v_raw, r2 = vp - v_adjusted;
    const float ke = fminf(global_ke, shape_ke[s]);
    const float root = sqrtf(ke * particle_mass);
    const float kd = fminf(fminf(global_kd, shape_kd[s]), root + root);
    const float vn = contact_dot(r1, n);
    const float raw_fn = depth * ke - vn * kd;
    const float fn = fmaxf(raw_fn, 0.0f);
    const glm::vec3 tangent = r2 - contact_dot_x_first(r2, n) * n;
    const float limit = fn * fminf(global_mu, shape_mu[s]);
    float eta = 0.0f;
    if (limit > 0.0f)
        eta = fminf(fminf(global_kf, shape_kf[s]), limit / fmaxf(sqrtf(contact_dot(tangent, tangent)), 1e-8f));
    const glm::vec3 normal_force = fn * n, friction_force = -eta * tangent;
    const glm::vec3 d = raw - com, e = adjusted - com;
    if (force) {
        atomic_add(&force[p], normal_force + friction_force);
        if (slot >= 0) {
            atomic_add(&force[ids.x], -normal_force);
            atomic_add(&force[ids.y], -(normal_force * d.x));
            atomic_add(&force[ids.z], -(normal_force * d.y));
            atomic_add(&force[ids.w], -(normal_force * d.z));
            atomic_add(&force[ids.x], -friction_force);
            atomic_add(&force[ids.y], -(friction_force * e.x));
            atomic_add(&force[ids.z], -(friction_force * e.y));
            atomic_add(&force[ids.w], -(friction_force * e.z));
        }
    }
    const float stiff = fmaf(kd, inv_dt, ke), fric = eta * inv_dt;
    const float iso = sphere ? stiff : fmaxf(stiff, fric);
    if (scalar) {
        atomicAdd(&scalar[p], (sphere ? fric : 0.0f) + iso);
        if (slot >= 0) {
            atomicAdd(&scalar[ids.x], iso);
            atomicAdd(&scalar[ids.y], d.x * (iso * d.x));
            atomicAdd(&scalar[ids.z], d.y * (iso * d.y));
            atomicAdd(&scalar[ids.w], d.z * (iso * d.z));
            if (sphere && fric > 0.0f) {
                atomicAdd(&scalar[ids.x], fric);
                atomicAdd(&scalar[ids.y], e.x * (fric * e.x));
                atomicAdd(&scalar[ids.z], e.y * (fric * e.y));
                atomicAdd(&scalar[ids.w], e.z * (fric * e.z));
            }
        }
    }
    if (!system && !precond) return;
    const int targets[5] = {p, ids.x, ids.y, ids.z, ids.w};
    const float normal_weights[5] = {1.0f, -1.0f, -d.x, -d.y, -d.z};
    const float friction_weights[5] = {1.0f, -1.0f, -e.x, -e.y, -e.z};
    const float products[6] = {nx2, n.y * n.x, n.z * n.x, ny2, n.z * n.y, nz2};
    for (int j = 0; j < (slot >= 0 ? 5 : 1); ++j) {
        const float wn2 = normal_weights[j] * normal_weights[j];
        const float wf2 = friction_weights[j] * friction_weights[j];
        const float g = fric * wf2;
        const float iso_j = sphere ? fmaf(stiff, wn2, g) : wn2 * fmaxf(stiff, fric);
        const float a = (fn > 0.0f ? stiff : 0.0f) * wn2;
        const float zero = iso_j * 0.0f;
        const float xx = fmaf(a, products[0], (1.0f - products[0]) * g) - iso_j;
        const float xy = fmaf(a, products[1], (0.0f - products[1]) * g) - zero;
        const float xz = fmaf(a, products[2], (0.0f - products[2]) * g) - zero;
        const float yy = fmaf(a, products[3], (1.0f - products[3]) * g) - iso_j;
        const float yz = fmaf(a, products[4], (0.0f - products[4]) * g) - zero;
        const float zz = fmaf(a, products[5], (1.0f - products[5]) * g) - iso_j;
        const glm::mat3 block(glm::vec3(xx, xy, xz), glm::vec3(xy, yy, yz), glm::vec3(xz, yz, zz));
        for (int c = 0; c < 3; ++c) {
            for (int row = 0; row < 3; ++row) {
                if (system) atomicAdd(&system[targets[j]][c][row], block[c][row]);
                if (precond) atomicAdd(&precond[targets[j]][c][row], block[c][row]);
            }
        }
    }
}

// Only off-diagonal particle/body couplings are emitted. Equal global state indices exclude the entire term.
// The host supplies previous positions; the legacy entry unconditionally reads previous[p].
__global__ void multiply_soft_contact_hessian_off_diagonal(const int* count, size_t capacity,
    const int* particle, const int* shape, const glm::vec3* body_pos, const glm::vec3* normal, const float* radius,
    const int* shape_body, const int* shape_type, const Transform* shape_transform, const glm::vec3* shape_scale,
    const float* mass, const int* particle_kind, const float* shape_margin, const float* shape_ke,
    const float* shape_kd, size_t local_shape_count, size_t shapes_per_world, size_t worlds, const int* body_ids,
    const glm::ivec4* body_indices, const glm::vec3* body_com, size_t body_count, const glm::vec3* x,
    const glm::vec3* direction, glm::vec3* product, float inv_dt, size_t particles_per_world, float global_ke,
    float global_kd, size_t total_particles, const int* shape_filter, size_t filter_count,
    const float* shape_kf, const float* shape_mu, float global_kf, float global_mu,
    const glm::vec3* body_vel, const glm::vec3* previous)
{
    if (particles_per_world == 0) return;
    const size_t active = count ? static_cast<size_t>(max(*count, 0)) : 0;
    const size_t bound = min(active, capacity);
    for (size_t i = thread_index(); i < bound; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        const int p = particle[i], raw_shape = shape[i];
        if (p < 0 || raw_shape < 0 || static_cast<size_t>(p) >= total_particles) continue;
        const size_t local_p = static_cast<size_t>(p) % particles_per_world;
        const float particle_mass = mass[local_p];
        if (!(particle_mass > 0.0f) || (particle_kind && particle_kind[local_p] != 0)) continue;
        if (shape_filter && (static_cast<size_t>(raw_shape) >= filter_count || !shape_filter[raw_shape])) continue;
        int shape_world, s;
        if (!contact_shape(raw_shape, local_shape_count, shapes_per_world, worlds, shape_world, s)) continue;
        if (shape_world < 0 || shape_world != static_cast<int>(static_cast<size_t>(p) / particles_per_world)) continue;
        const int slot = contact_body_slot(shape_body[s], body_ids, body_count);
        if (slot < 0) continue;
        const glm::ivec4 ids = body_indices[slot] + static_cast<int>(static_cast<size_t>(shape_world) * particles_per_world);
        const glm::vec3 com = body_com[slot];
        const bool sphere = shape_type[s] == 3;
        const glm::vec3 raw = sphere ? shape_transform[s].position : body_pos[i];
        glm::vec3 world_point = contact_point(raw, ids, com, x);
        glm::vec3 n = contact_normalize(normal[i]);
        const glm::vec3 xp = x[p];
        const float r = shape_scale[s].x;
        if (sphere) {
            const glm::vec3 alternative = contact_normalize(xp - world_point);
            if (contact_dot(alternative, alternative) >= 0.5f) n = alternative;
            world_point = contact_fma(r, n, world_point);
        }
        const float nx2 = n.x * n.x, ny2 = n.y * n.y, nz2 = n.z * n.z;
        if (!(nz2 + (ny2 + nx2) > 0.0f)) continue;
        const float depth = (radius[local_p] + shape_margin[s]) - contact_dot(xp - world_point, n);
        if (depth <= 0.0f) continue;
        const float ke = fminf(global_ke, shape_ke[s]);
        const float root = sqrtf(ke * particle_mass);
        const float kd = fminf(fminf(global_kd, shape_kd[s]), root + root);
        const glm::vec3 adjusted = sphere ? raw + contact_sphere_offset(r * n, ids, x) : raw;
        const glm::vec3 bv = contact_surface_velocity(body_vel[i], ids, x);
        const glm::vec3 v_raw = contact_point_velocity(raw, ids, com, x, previous, nullptr, inv_dt) + bv;
        const glm::vec3 v_adjusted = contact_point_velocity(adjusted, ids, com, x, previous, nullptr, inv_dt) + bv;
        const glm::vec3 dx = xp - previous[p];
        const glm::vec3 r1 = dx * inv_dt - v_raw;
        const glm::vec3 r2 = dx * inv_dt - v_adjusted;
        const float vn = contact_dot(r1, n);
        const float raw_fn = depth * ke - vn * kd;
        const float fn = fmaxf(raw_fn, 0.0f);
        const glm::vec3 tangent = r2 - contact_dot(r2, n) * n;
        const float limit = fn * fminf(global_mu, shape_mu[s]);
        float eta = 0.0f;
        if (limit > 0.0f)
            eta = fminf(fminf(global_kf, shape_kf[s]), limit / fmaxf(sqrtf(contact_dot(tangent, tangent)), 1e-8f));
        const float stiff = fn > 0.0f ? fmaf(kd, inv_dt, ke) : 0.0f;
        const float fric = eta * inv_dt;
        const float nxy = n.y * n.x, nxz = n.z * n.x, nyz = n.z * n.y;
        const glm::mat3 normal_block(glm::vec3(stiff * nx2, stiff * nxy, stiff * nxz),
            glm::vec3(stiff * nxy, stiff * ny2, stiff * nyz), glm::vec3(stiff * nxz, stiff * nyz, stiff * nz2));
        // The old JIT contracts these single-use squares. Reusing nx2/ny2/nz2 suppresses that contraction.
        const float fxx = fric * fmaf(-n.x, n.x, 1.0f), fyy = fric * fmaf(-n.y, n.y, 1.0f);
        const float fzz = fric * fmaf(-n.z, n.z, 1.0f);
        const float fxy = fric * (0.0f - nxy), fxz = fric * (0.0f - nxz), fyz = fric * (0.0f - nyz);
        const glm::mat3 friction_block(glm::vec3(fxx, fxy, fxz), glm::vec3(fxy, fyy, fyz), glm::vec3(fxz, fyz, fzz));
        const glm::vec3 d = raw - com, e = adjusted - com;
        const int targets[5] = {p, ids.x, ids.y, ids.z, ids.w};
        #pragma unroll
        for (int part = 0; part < 2; ++part) {
            const glm::vec3 lever = part == 0 ? d : e;
            const float weights[5] = {1.0f, -1.0f, -lever.x, -lever.y, -lever.z};
            const glm::mat3 k = part == 0 ? normal_block : friction_block;
            #pragma unroll
            for (int a = 0; a < 5; ++a) {
                glm::vec3 sum(0.0f);
                bool first = true;
                #pragma unroll
                for (int b = 0; b < 5; ++b) {
                    if (b == a || targets[b] == targets[a]) continue;
                    const glm::vec3 db = direction[targets[b]];
                    if (first) {
                        if (b == 1) sum = glm::vec3(0.0f) - db;
                        else if (b == 0) sum = db + glm::vec3(0.0f);
                        else sum = contact_fma(weights[b], db, glm::vec3(0.0f));
                    } else if (b == 1) sum = sum - db;
                    else sum = contact_fma(weights[b], db, sum);
                    first = false;
                }
                glm::vec3 y(contact_dot(k[0], sum), contact_dot(k[1], sum), contact_dot(k[2], sum));
                if (a == 1) y = -y;
                else if (a >= 2) y = y * weights[a];
                atomic_add(&product[targets[a]], y);
            }
        }
    }
}

} // namespace synreal::kernel
