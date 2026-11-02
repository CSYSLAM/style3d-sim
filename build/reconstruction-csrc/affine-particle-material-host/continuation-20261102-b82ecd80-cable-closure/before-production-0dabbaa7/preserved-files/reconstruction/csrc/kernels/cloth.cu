// Cloth (Style3D anisotropic membrane and cotangent bending) kernels of synreal::SolverNewton.
#include "types.cuh"

namespace synreal::kernel {

// Bending hinge vector q = sum_k w_k (x_k - x_0) over the edge's other three vertices, accumulated from zero.
__device__ __forceinline__ glm::vec3 hinge_vector(const glm::vec3* x, int v0, int v1, int v2, int v3, float w1,
                                                  float w2, float w3)
{
    const glm::vec3& base = x[v0];
    glm::vec3 q(0.0f);
    q += w1 * (x[v1] - base);
    q += w2 * (x[v2] - base);
    q += w3 * (x[v3] - base);
    return q;
}

// An edge (o0, o1, e0, e1) bends only when both opposite vertices exist, all four vertices are distinct and the
// hinge area is positive.
__device__ __forceinline__ bool bending_edge_valid(const glm::ivec4& e, float area)
{
    return !(e.x < 0 || e.y < 0 || e.x == e.y || e.x == e.z || e.x == e.w || e.y == e.z || e.y == e.w ||
             e.z == e.w || area <= 0.0f);
}

// Anisotropic membrane force. With the rest-pose inverse m (glm column-major mat2), the deformed warp and weft
// vectors are a = e1 m00 + e2 m10 and b = e1 m01 + e2 m11 (e1, e2 the triangle edges from vertex 0). Strain
// energies: ku (|a| - 1) and kv (|b| - 1) along the unit vectors, ks times the shear a.b / (|a| |b|) (lengths
// regularised by 1e-12 in the shear). Vertex k has weights (wu, wv) = (-m00 - m10, -m01 - m11), (m00, m01),
// (m10, m11); its force is -area times the weighted gradient.
__global__ void evaluate_stretch_force(const glm::vec3* x, const float* area, const glm::mat2* poses,
                                       const glm::ivec3* triangles, const glm::vec3* stiffness, glm::vec3* force,
                                       size_t count, size_t triangles_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec3 local = triangles[triangle];
    const int v0 = local.x + offset, v1 = local.y + offset, v2 = local.z + offset;
    const glm::vec3 e1 = x[v1] - x[v0];
    const glm::vec3 e2 = x[v2] - x[v0];
    const glm::mat2& pose = poses[triangle];
    const float m00 = pose[0][0], m01 = pose[0][1], m10 = pose[1][0], m11 = pose[1][1];
    const glm::vec3 a = e1 * m00 + e2 * m10;
    const glm::vec3 b = e1 * m01 + e2 * m11;
    const float a2 = glm::dot(a, a);
    const float a_length = std::sqrt(a2);
    const glm::vec3 a_unit = normalized_or_zero(a, a_length, 0.0f);
    const float b2 = glm::dot(b, b);
    const float b_length = std::sqrt(b2);
    const glm::vec3 b_unit = normalized_or_zero(b, b_length, 0.0f);
    const float wu0 = -m00 - m10;
    const float wv0 = -m01 - m11;
    const float a_regular = std::sqrt(a2 + 1e-12f);
    const float b_regular = std::sqrt(b2 + 1e-12f);
    const glm::vec3 aa = a / a_regular;
    const glm::vec3 bb = b / b_regular;
    const float shear = glm::dot(aa, bb);
    const glm::vec3 da = (bb - aa * shear) / a_regular;
    const glm::vec3 db = (aa - bb * shear) / b_regular;
    const float wu[3] = {wu0, m00, m10};
    const float wv[3] = {wv0, m01, m11};
    glm::vec3 ta[3], tb[3], ts[3];
    for (int k = 0; k < 3; ++k) {
        ta[k] = wu[k] * a_unit;
        tb[k] = wv[k] * b_unit;
        ts[k] = da * wu[k] + db * wv[k];
    }
    const glm::vec3 k = stiffness[triangle];
    const float ca = k.x * (a_length - 1.0f);
    const float cb = k.y * (b_length - 1.0f);
    const float cs = k.z * shear;
    const int vertices[3] = {v0, v1, v2};
    for (int v = 0; v < 3; ++v) atomic_add(&force[vertices[v]], (ta[v] * ca + tb[v] * cb + ts[v] * cs) * -area[triangle]);
}

// Cotangent bending: with weights from the edge cotangents c, w = (-c0 - c2, -c1 - c3, c2 + c3, c0 + c1) and the
// hinge vector q, the force on vertex k is w_k (d - (3/A) kb q), where the damping d = -(3/A) kd (q_rate . n) n uses
// the hinge rate (q - q_previous) / h along n = q / |q| (only when (3/A) kd > 0; n = 0 for |q| <= 1e-12).
__global__ void evaluate_bending_force(const glm::vec3* x, const glm::vec3* x_previous, const float* area,
                                       const glm::vec4* cotangents, const glm::ivec4* edges,
                                       const glm::vec2* properties, float inverse_dt, glm::vec3* force,
                                       size_t count, size_t edges_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world;
    const size_t edge = i % edges_per_world;
    const glm::ivec4 e = edges[edge];
    const float a = area[edge];
    if (!bending_edge_valid(e, a)) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const int v0 = e.x + offset, v1 = e.y + offset, v2 = e.z + offset, v3 = e.w + offset;
    const glm::vec4 c = cotangents[edge];
    const float w1 = -c.y - c.w;
    const float w2 = c.z + c.w;
    const float w3 = c.x + c.y;
    const glm::vec2& property = properties[edge];
    const glm::vec3 q = hinge_vector(x, v0, v1, v2, v3, w1, w2, w3);
    const float scale = 3.0f / a;
    const float damping = scale * property.y;
    glm::vec3 d(0.0f);
    if (damping > 0.0f) {
        const glm::vec3 n = normalized_or_zero(q, glm::length(q), 1e-12f);
        const glm::vec3 rate = (q - hinge_vector(x_previous, v0, v1, v2, v3, w1, w2, w3)) * inverse_dt;
        d = n * -(damping * glm::dot(rate, n));
    }
    const float w0 = -c.x - c.z;
    const glm::vec3 total = d - q * (scale * property.x);
    atomic_add(&force[v0], total * w0);
    atomic_add(&force[v1], total * w1);
    atomic_add(&force[v2], total * w2);
    atomic_add(&force[v3], total * w3);
}

// Bending-damping preconditioner: w_k^2 c n n^T on vertex k's diagonal block, c = kd (3/A) / h, for valid hinges
// with kd > 0.
__global__ void add_bending_damping_preconditioner(const glm::vec3* x, const float* area,
                                                   const glm::vec4* cotangents, const glm::ivec4* edges,
                                                   const glm::vec2* properties, float inverse_dt,
                                                   glm::mat3* preconditioner, size_t count, size_t edges_per_world,
                                                   size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world;
    const size_t edge = i % edges_per_world;
    const glm::ivec4 e = edges[edge];
    const float a = area[edge];
    if (!bending_edge_valid(e, a)) return;
    const float kd = properties[edge].y;
    if (kd <= 0.0f) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const int v0 = e.x + offset, v1 = e.y + offset, v2 = e.z + offset, v3 = e.w + offset;
    const glm::vec4 c = cotangents[edge];
    const float w1 = -c.y - c.w;
    const float w2 = c.z + c.w;
    const float w3 = c.x + c.y;
    const glm::vec3 q = hinge_vector(x, v0, v1, v2, v3, w1, w2, w3);
    const glm::vec3 n = normalized_or_zero(q, glm::length(q), 1e-12f);
    const float coefficient = kd * (3.0f / a) * inverse_dt;
    const glm::mat3 scaled = coefficient * glm::outerProduct(n, n);
    const float w0 = -c.x - c.z;
    atomic_add(&preconditioner[v0], scaled * (w0 * w0));
    atomic_add(&preconditioner[v1], scaled * (w1 * w1));
    atomic_add(&preconditioner[v2], scaled * (w2 * w2));
    atomic_add(&preconditioner[v3], scaled * (w3 * w3));
}

// Bending-damping tangent times a direction p: vertex k receives w_k c (dq . n) n with dq the hinge vector of p.
__global__ void multiply_bending_damping_tangent(const glm::vec3* x, const glm::vec3* p, const float* area,
                                                 const glm::vec4* cotangents, const glm::ivec4* edges,
                                                 const glm::vec2* properties, float inverse_dt, glm::vec3* product,
                                                 size_t count, size_t edges_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world;
    const size_t edge = i % edges_per_world;
    const glm::ivec4 e = edges[edge];
    const float a = area[edge];
    if (!bending_edge_valid(e, a)) return;
    const float kd = properties[edge].y;
    if (kd <= 0.0f) return;
    const int offset = static_cast<int>(world * particles_per_world);
    const int v0 = e.x + offset, v1 = e.y + offset, v2 = e.z + offset, v3 = e.w + offset;
    const glm::vec4 c = cotangents[edge];
    const float w1 = -c.y - c.w;
    const float w2 = c.z + c.w;
    const float w3 = c.x + c.y;
    const glm::vec3 q = hinge_vector(x, v0, v1, v2, v3, w1, w2, w3);
    const glm::vec3 n = normalized_or_zero(q, glm::length(q), 1e-12f);
    const glm::vec3 dq = hinge_vector(p, v0, v1, v2, v3, w1, w2, w3);
    const float coefficient = kd * (3.0f / a) * inverse_dt;
    const glm::vec3 g = coefficient * glm::dot(dq, n) * n;
    const float w0 = -c.x - c.z;
    atomic_add(&product[v0], g * w0);
    atomic_add(&product[v1], g * w1);
    atomic_add(&product[v2], g * w2);
    atomic_add(&product[v3], g * w3);
}

// Projector n n^T + max(0, 1 - 1/|v|) (I - n n^T) of a membrane direction v; the identity when |v| <= 1e-8.
__device__ __forceinline__ glm::mat3 stretch_projector(const glm::vec3& v, float length)
{
    glm::mat3 m(1.0f);
    if (length > 1e-8f) {
        const glm::vec3 n = v / length;
        const glm::mat3 nn = glm::outerProduct(n, n);
        const float s = fmaxf(0.0f, 1.0f - 1.0f / length);
        m = (glm::mat3(1.0f) - nn) * s + nn;
    }
    return m;
}

// Membrane Gauss-Newton Hessian blocks for vertex pairs (i, j): area (ku u_i u_j Pa + kv v_i v_j Pb +
// ks t_i t_j^T - iso I) with Pa, Pb the warp/weft projectors and t the shear gradients. The isotropic part
// iso = (ku + ks) u_i u_j + (kv + ks) v_i v_j lives in the host's constant matrix and is removed here. Blocks go to
// the diagonal (same particle) or to the block-ELL entry (row v_i, column v_j).
__global__ void add_cloth_membrane_gauss_newton_hessian(const glm::vec3* x, const glm::ivec3* triangles,
                                                        const glm::mat2* poses, const float* area,
                                                        const glm::vec3* stiffness, glm::mat3* diagonal,
                                                        const int* row_count, BlockNonZeroEntry* entries,
                                                        size_t max_count, size_t count, size_t triangles_per_world,
                                                        size_t particles_per_world, size_t rows)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::ivec3 local = triangles[triangle];
    const int vertices[3] = {local.x + offset, local.y + offset, local.z + offset};
    const glm::vec3 e1 = x[vertices[1]] - x[vertices[0]];
    const glm::vec3 e2 = x[vertices[2]] - x[vertices[0]];
    const glm::mat2& pose = poses[triangle];
    const float m00 = pose[0][0], m01 = pose[0][1], m10 = pose[1][0], m11 = pose[1][1];
    const glm::vec3 a = e1 * m00 + e2 * m10;
    const glm::vec3 b = e1 * m01 + e2 * m11;
    const float a2 = glm::dot(a, a);
    const float b2 = glm::dot(b, b);
    const float a_regular = std::sqrt(a2 + 1e-12f);
    const float b_regular = std::sqrt(b2 + 1e-12f);
    const glm::vec3 aa = a / a_regular;
    const glm::vec3 bb = b / b_regular;
    const float shear = glm::dot(aa, bb);
    const glm::vec3 da = (bb - aa * shear) / a_regular;
    const glm::vec3 db = (aa - bb * shear) / b_regular;
    const float wu[3] = {-m00 - m10, m00, m10};
    const float wv[3] = {-m01 - m11, m01, m11};
    glm::vec3 t[3];
    for (int k = 0; k < 3; ++k) t[k] = da * wu[k] + db * wv[k];
    const glm::mat3 pa = stretch_projector(a, std::sqrt(a2));
    const glm::mat3 pb = stretch_projector(b, std::sqrt(b2));
    const glm::vec3 k = stiffness[triangle];
    const float kua = k.x + k.z, kvb = k.y + k.z;
    const float s = area[triangle];
    for (int vi = 0; vi < 3; ++vi) {
        for (int vj = 0; vj < 3; ++vj) {
            const float uu = wu[vi] * wu[vj], vv = wv[vi] * wv[vj];
            const float iso = kua * uu + kvb * vv;
            const glm::mat3 block = s * ((k.x * uu) * pa + (k.y * vv) * pb + k.z * glm::outerProduct(t[vi], t[vj]) -
                                         iso * glm::mat3(1.0f));
            const int row = vertices[vi], column = vertices[vj];
            if (row == column) atomic_add(&diagonal[row], block);
            else atomic_add_block(row_count, entries, max_count, rows, row, column, block);
        }
    }
}

}  // namespace synreal::kernel
