#include "hard_contact_geometry.cuh"

namespace synreal::kernel {

__device__ __forceinline__ glm::mat3 hard_symmetric(float xx, float xy, float xz, float yy, float yz, float zz)
{
    return glm::mat3(glm::vec3(xx, xy, xz), glm::vec3(xy, yy, yz), glm::vec3(xz, yz, zz));
}

// Hard-contact force and split Hessian outputs. Entries are ordered by body side and affine coordinate;
// equal global particle indices are excluded from the off-diagonal product and combined in body blocks.
__global__ void evaluate_hard_contacts(HardContactView view, glm::vec3* force, float* scalar,
    const glm::vec3* direction, glm::vec3* product, glm::mat3* system, glm::mat3* precond, float* affine_blocks)
{
    const size_t i = thread_index();
    if (i >= view.capacity || !view.count || i >= static_cast<size_t>(max(*view.count, 0))) return;
    HardGeometry geometry;
    if (!hard_geometry(view, i, geometry)) return;
    const glm::vec3 n = geometry.normal;
    const glm::vec3 dual = view.dual[i], anchor = view.anchor[i];
    const float dn = contact_dot(dual, n), an = contact_dot(anchor, n);
    const float gap = geometry.depth - view.alpha * an;
    const float penalty = view.penalty[i];
    if (!(penalty > 0.0f) || ((geometry.depth <= 1e-9f || gap <= 1e-9f) && dn <= 0.0f)) return;
    const float fn = fmaxf(fmaf(penalty, gap, dn), 0.0f);
    glm::vec3 now[2], old[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        const glm::vec3 point = geometry.adjusted[side];
        now[side] = geometry.slots[side] >= 0 ?
            contact_point(point, geometry.ids[side], geometry.com[side], view.x) : point;
        old[side] = geometry.slots[side] >= 0 ?
            contact_point(point, geometry.ids[side], geometry.com[side], view.previous) : point;
    }
    const glm::vec3 delta = ((now[1] - old[1]) - now[0]) + old[0];
    const float mu = sqrtf(fmaxf(view.shape_mu[geometry.shapes[0]] * view.shape_mu[geometry.shapes[1]], 0.0f));
    glm::vec3 tangent(0.0f), unit(0.0f);
    float kt = 0.0f;
    bool sliding = false;
    if (mu > 0.0f && fn > 0.0f) {
        glm::vec3 correction = contact_dot(delta, n) * n - delta;
        correction = contact_fma(1.0f - view.alpha, anchor - an * n, correction);
        tangent = contact_fma(penalty, correction, dual) - dn * n;
        const float length = sqrtf(contact_dot(tangent, tangent));
        const float bound = fn * mu;
        kt = penalty;
        if (length > bound && length > 0.0f) {
            const float factor = bound / length;
            if (view.exact_friction) {
                unit = tangent / length;
                kt = penalty * factor;
                sliding = true;
            }
            tangent = tangent * factor;
        }
    }
    const glm::vec3 raw[2] = {view.point0[i], view.point1[i]};
    glm::vec3 velocity[2];
    #pragma unroll
    for (int side = 0; side < 2; ++side)
        velocity[side] = geometry.slots[side] >= 0 ? contact_point_velocity(raw[side], geometry.ids[side],
            geometry.com[side], view.x, view.previous, nullptr, view.inv_dt) : glm::vec3(0.0f);
    const float vn = contact_dot(velocity[1] - velocity[0], n);
    const float damping = fn > 0.0f && vn < 0.0f ?
        (view.shape_kd[geometry.shapes[0]] + view.shape_kd[geometry.shapes[1]]) * 0.5f : 0.0f;
    const glm::vec3 normal_force = fn * n - (vn * damping) * n;
    const float kn = fmaf(damping, view.inv_dt, penalty);
    int targets[8];
    float normal_weights[8], tangent_weights[8];
    int entries = 0;
    #pragma unroll
    for (int side = 0; side < 2; ++side) {
        if (geometry.slots[side] < 0) continue;
        const glm::vec3 rn = raw[side] - geometry.com[side];
        const glm::vec3 rt = geometry.adjusted[side] - geometry.com[side];
        const float sign = side == 0 ? -1.0f : 1.0f;
        const float wn[4] = {sign, sign * rn.x, sign * rn.y, sign * rn.z};
        const float wt[4] = {sign, sign * rt.x, sign * rt.y, sign * rt.z};
        #pragma unroll
        for (int coordinate = 0; coordinate < 4; ++coordinate) {
            targets[entries + coordinate] = geometry.ids[side][coordinate];
            normal_weights[entries + coordinate] = wn[coordinate];
            tangent_weights[entries + coordinate] = wt[coordinate];
        }
        #pragma unroll
        for (int part = 0; part < 2; ++part) {
            const glm::vec3 unsigned_value = part == 0 ? normal_force : tangent;
            const glm::vec3 value = side == 0 ? -unsigned_value : unsigned_value;
            const glm::vec3 lever = part == 0 ? rn : rt;
            #pragma unroll
            for (int coordinate = 0; coordinate < 4; ++coordinate) {
                const int target = geometry.ids[side][coordinate];
                if (force) atomic_add(&force[target], coordinate == 0 ? value : lever[coordinate - 1] * value);
            }
        }
        #pragma unroll
        for (int part = 0; part < 2; ++part) {
            const float stiffness = part == 0 ? kn : kt;
            const glm::vec3 lever = part == 0 ? rn : rt;
            #pragma unroll
            for (int coordinate = 0; coordinate < 4; ++coordinate) {
                const float value = coordinate == 0 ? stiffness :
                    lever[coordinate - 1] * (stiffness * lever[coordinate - 1]);
                if (scalar) atomicAdd(&scalar[geometry.ids[side][coordinate]], value);
            }
        }
        entries += 4;
    }
    const float nx2 = n.x * n.x, ny2 = n.y * n.y, nz2 = n.z * n.z;
    const float nxy = n.y * n.x, nxz = n.z * n.x, nyz = n.z * n.y;
    const glm::mat3 normal_matrix = hard_symmetric(kn * nx2, kn * nxy, kn * nxz, kn * ny2, kn * nyz, kn * nz2);
    glm::mat3 tangent_matrix = hard_symmetric(kt * (1.0f - nx2), kt * (0.0f - nxy), kt * (0.0f - nxz),
                                             kt * (1.0f - ny2), kt * (0.0f - nyz), kt * (1.0f - nz2));
    if (sliding) {
        #pragma unroll
        for (int column = 0; column < 3; ++column)
            #pragma unroll
            for (int row = 0; row < 3; ++row)
                tangent_matrix[column][row] = tangent_matrix[column][row] - kt * (unit[row] * unit[column]);
    }
    if (direction && product) {
        #pragma unroll
        for (int part = 0; part < 2; ++part) {
            const glm::mat3 matrix = part == 0 ? normal_matrix : tangent_matrix;
            for (int a = 0; a < entries; ++a) {
                glm::vec3 sum(0.0f);
                for (int b = 0; b < entries; ++b) {
                    if (targets[b] == targets[a]) continue;
                    const float weight = part == 0 ? normal_weights[b] : tangent_weights[b];
                    sum = contact_fma(weight, direction[targets[b]], sum);
                }
                const glm::vec3 y(contact_dot(matrix[0], sum), contact_dot(matrix[1], sum), contact_dot(matrix[2], sum));
                atomic_add(&product[targets[a]], y * (part == 0 ? normal_weights[a] : tangent_weights[a]));
            }
        }
    }
    if (affine_blocks) {
        int last_body = -1;
        #pragma unroll
        for (int side = 0; side < 2; ++side) {
            if (geometry.slots[side] < 0) continue;
            const int shape = side == 0 ? view.shape0[i] : view.shape1[i];
            const size_t world = static_cast<size_t>(shape) / view.shapes_per_world;
            const int body = static_cast<int>(geometry.slots[side] + world * view.body_count);
            if (body == last_body) continue;
            last_body = body;
            float wn[4] = {0.0f, 0.0f, 0.0f, 0.0f}, wt[4] = {0.0f, 0.0f, 0.0f, 0.0f};
            for (int a = 0; a < entries; ++a) {
                #pragma unroll
                for (int coordinate = 0; coordinate < 4; ++coordinate) {
                    if (targets[a] != geometry.ids[side][coordinate]) continue;
                    wn[coordinate] += normal_weights[a];
                    wt[coordinate] += tangent_weights[a];
                }
            }
            #pragma unroll
            for (int row = 0; row < 4; ++row) {
                #pragma unroll
                for (int column = 0; column < 4; ++column) {
                    if (row == column) continue;
                    const float a = wn[row] * wn[column], b = wt[row] * wt[column];
                    #pragma unroll
                    for (int r = 0; r < 3; ++r) {
                        #pragma unroll
                        for (int c = 0; c < 3; ++c) {
                            const float value = fmaf(a, normal_matrix[c][r], b * tangent_matrix[c][r]);
                            atomicAdd(&affine_blocks[static_cast<size_t>(body) * 144 + (3 * row + r) * 12 + 3 * column + c],
                                      value);
                        }
                    }
                }
            }
        }
    }
    if (system || precond) {
        for (int a = 0; a < entries; ++a) {
            const float n2 = normal_weights[a] * normal_weights[a];
            const float t2 = tangent_weights[a] * tangent_weights[a];
            const float iso = fmaf(kn, n2, kt * t2);
            glm::mat3 block;
            #pragma unroll
            for (int column = 0; column < 3; ++column)
                #pragma unroll
                for (int row = 0; row < 3; ++row)
                    block[column][row] = fmaf(n2, normal_matrix[column][row], t2 * tangent_matrix[column][row]) -
                        iso * (row == column ? 1.0f : 0.0f);
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

}

} // namespace synreal::kernel
