// Cloth self-collision: primitive boxes, candidate traversal, penalty accumulation and contact tangents.
#include "types.cuh"

namespace synreal {

// Shared wire format of the contact list consumed by the matrix-free tangent kernel.
struct SelfCollisionContactTangent {
    int ids[5];
    float weights[5];
    glm::vec3 normal;
    float stiffness;
    int count;
};
static_assert(sizeof(SelfCollisionContactTangent) == 60);
static_assert(offsetof(SelfCollisionContactTangent, weights) == 20);
static_assert(offsetof(SelfCollisionContactTangent, normal) == 40);
static_assert(offsetof(SelfCollisionContactTangent, stiffness) == 52);
static_assert(offsetof(SelfCollisionContactTangent, count) == 56);

}  // namespace synreal

namespace synreal::self_collision_kernel {

using kernel::thread_index;

// Box of a collidable particle inflated by its collision radius. Particle lists and radii are per world-local
// particle and shared by all worlds.
__global__ void build_particle_aabbs(const glm::vec3* x, const int* particles, const float* radius, Aabb* boxes,
                                     size_t count, size_t particles_per_list, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / particles_per_list;
    const size_t entry = i % particles_per_list;
    const int particle = particles[entry];
    const glm::vec3 position = x[world * particles_per_world + particle];
    const float r = radius[particle];
    boxes[i] = Aabb{position - r, position + r};
}

// Box of a collidable edge (vertices in .z/.w of the edge record) inflated by the margin.
__global__ void build_edge_aabbs(const glm::vec3* x, const glm::ivec4* edges, Aabb* boxes, float margin, size_t count,
                                 size_t edges_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world;
    const size_t edge = i % edges_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::vec3& a = x[edges[edge].z + offset];
    const glm::vec3& b = x[edges[edge].w + offset];
    const glm::vec3 lower(fminf(a.x, b.x), fminf(a.y, b.y), fminf(a.z, b.z));
    const glm::vec3 upper(fmaxf(a.x, b.x), fmaxf(a.y, b.y), fmaxf(a.z, b.z));
    boxes[i] = Aabb{lower - margin, upper + margin};
}

// Box of a cloth triangle inflated by the margin.
__global__ void build_triangle_aabbs(const glm::vec3* x, const glm::ivec3* triangles, Aabb* boxes, float margin,
                                     size_t count, size_t triangles_per_world, size_t particles_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / triangles_per_world;
    const size_t triangle = i % triangles_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const glm::vec3& a = x[triangles[triangle].x + offset];
    const glm::vec3& b = x[triangles[triangle].y + offset];
    const glm::vec3& c = x[triangles[triangle].z + offset];
    const glm::vec3 lower = kernel::min_components(a, kernel::min_components(b, c));
    const glm::vec3 upper = kernel::max_components(a, kernel::max_components(b, c));
    boxes[i] = Aabb{lower - margin, upper + margin};
}

// Bottom-up refit of the per-world BVHs. All worlds share one tree topology (parent/children over L leaves);
// world w owns nodes [w (2L - 1), (w + 1)(2L - 1)) and visit counters [w (L - 1), (w + 1)(L - 1)).
__global__ void refit_bvh(const Aabb* leaf_boxes, const int* sorted_leaf, const int* parent,
                          const glm::ivec2* children, unsigned* visits, Aabb* nodes, size_t count,
                          size_t leaves_per_world)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / leaves_per_world;
    const size_t local = i % leaves_per_world;
    const size_t internal_count = leaves_per_world - 1;
    const size_t node_base = world * (internal_count + leaves_per_world);
    const size_t visit_base = world * internal_count;
    const int leaf = static_cast<int>(local + internal_count);
    nodes[node_base + leaf] = leaf_boxes[world * leaves_per_world + sorted_leaf[local]];
    __threadfence();
    int node = parent[leaf];
    while (node >= 0) {
        if (atomicAdd(&visits[visit_base + node], 1u) == 0) return;
        __threadfence();
        const Aabb& left = nodes[node_base + children[node].x];
        const Aabb& right = nodes[node_base + children[node].y];
        const glm::vec3 lower(fminf(left.lower.x, right.lower.x), fminf(left.lower.y, right.lower.y),
                              fminf(left.lower.z, right.lower.z));
        const glm::vec3 upper(fmaxf(left.upper.x, right.upper.x), fmaxf(left.upper.y, right.upper.y),
                              fmaxf(left.upper.z, right.upper.z));
        nodes[node_base + node] = Aabb{lower, upper};
        __threadfence();
        node = parent[node];
    }
}

// Adds the self-collision Hessian diagonal blocks to the system diagonal.
__global__ void add_hessian_diagonal(const glm::mat3* hessian, glm::mat3* diagonal, size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    diagonal[i] = diagonal[i] + hessian[i];
}

// product += H_diag v (diagonal part of the self-collision Hessian times the CG direction).
__global__ void multiply_hessian_diagonal(const glm::mat3* hessian, const glm::vec3* v, glm::vec3* product,
                                          size_t count)
{
    const size_t i = thread_index();
    if (i >= count) return;
    product[i] = hessian[i] * v[i] + product[i];
}

// Inclusive box overlap, with ordered comparisons so any NaN bound rejects the node.
__device__ __forceinline__ bool overlaps(const glm::vec3& lower, const glm::vec3& upper, const Aabb& box)
{
    return lower.x <= box.upper.x && upper.x >= box.lower.x && lower.y <= box.upper.y &&
           upper.y >= box.lower.y && lower.z <= box.upper.z && upper.z >= box.lower.z;
}

// Walk sibling subtrees from the particle leaf to the root, using escape links for stack-free preorder.
// Topology, particle ids, radii and filters are shared by worlds; boxes/positions/output rows are per world.
__global__ void query_particle_pairs(const glm::vec3* x, const int* particles, const float* radius,
                                     const int* particle_world, const int* groups, const Aabb* boxes,
                                     const int* parent, const glm::ivec2* children, const int* order,
                                     const int* escape, const int* leaf, int* counts, int* slots, size_t count,
                                     size_t particles_per_list, size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / particles_per_list;
    const size_t entry = i % particles_per_list;
    const int particle = particles[entry];
    const size_t position_base = world * particles_per_world;
    const glm::vec3 position = x[position_base + particle];
    const float r = radius[particle];
    const glm::vec3 lower = position - r;
    const glm::vec3 upper = position + r;
    const int internal_count = static_cast<int>(particles_per_list) - 1;
    const size_t node_base = world * (2*particles_per_list - 1);
    int node = leaf[entry];
    int ancestor = parent[node];
    int found = 0;
    while (ancestor >= 0 && found < max_slots) {
        const int previous = node;
        node = ancestor;
        const glm::ivec2 pair = children[node];
        int candidate = pair.x == previous ? pair.y : pair.x;
        const int stop = candidate >= 0 ? escape[candidate] : -1;
        while (candidate >= 0 && candidate != stop && found < max_slots) {
            if (overlaps(lower, upper, boxes[node_base + candidate])) {
                if (candidate < internal_count) {
                    candidate = children[candidate].x;
                    continue;
                }
                const int other = particles[order[candidate - internal_count]];
                if (other > particle && !(groups[particle] != 0 && groups[particle] == groups[other]) &&
                    (particle_world == nullptr || particle_world[particle] == particle_world[other] ||
                     (particle_world[particle] | particle_world[other]) < 0)) {
                    const glm::vec3 difference = position - x[position_base + other];
                    const float reach = r + radius[other];
                    if (glm::dot(difference, difference) < reach * reach) {
                        slots[i*max_slots + found] = other;
                        ++found;
                    }
                }
            }
            candidate = escape[candidate];
        }
        ancestor = parent[node];
    }
    counts[i] = found;
}

// Parent/left/right traversal used by the mesh queries (the particle query uses a different escape-link walk).
template <class Visit>
__device__ __forceinline__ int walk_mesh_bvh(const glm::vec3& lower, const glm::vec3& upper, const Aabb* boxes,
                                             const int* parent, const glm::ivec2* children, const int* order,
                                             size_t leaves, int capacity, Visit visit)
{
    if (capacity < 1) return 0;
    const int internal = static_cast<int>(leaves) - 1;
    int previous = -1, current = 0, found = 0;
    do {
        const int ancestor = parent[current];
        int next = previous;
        if (previous == ancestor) {
            if (overlaps(lower, upper, boxes[current])) {
                if (current < internal) next = children[current].x;
                else if (visit(order[current - internal], found)) ++found;
            }
        } else if (current >= internal) {
            next = ancestor;
        } else if (previous == children[current].x) {
            next = children[current].y;
        } else {
            next = ancestor;
        }
        previous = current;
        current = next;
    } while (found < capacity && current >= 0);
    return found;
}

__device__ __forceinline__ bool compatible_groups(const int* groups, int a, int b)
{
    return groups == nullptr || groups[a] == groups[b] || (groups[a] | groups[b]) < 0;
}

// Error-compensated difference of products: both FMA residuals and the final addition are present in legacy PTX.
__device__ __forceinline__ float product_difference(float a, float b, float c, float d)
{
    const float cd = c * d;
    return fmaf(a, b, -cd) + fmaf(-c, d, cd);
}

__device__ __forceinline__ float saturate_parameter(float value)
{
    return fminf(fmaxf(value, 0.0f), 1.0f);
}

__device__ __forceinline__ float segment_distance2(const glm::vec3& p, const glm::vec3& q,
                                                   const glm::vec3& a, const glm::vec3& b)
{
    const glm::vec3 u = q - p, v = b - a, r = p - a;
    const float uu = glm::dot(u, u), vv = glm::dot(v, v), vr = glm::dot(v, r);
    float s = 0.0f, t = 0.0f;
    if (uu <= 1e-5f && vv <= 1e-5f) {
    } else if (uu <= 1e-5f) {
        t = saturate_parameter(vr / vv);
    } else {
        const float ur = glm::dot(u, r);
        if (vv <= 1e-5f) {
            s = saturate_parameter(-ur / uu);
        } else {
            const float uv = glm::dot(u, v);
            const float determinant = product_difference(uu, vv, uv, uv);
            if (determinant > 0.0f) s = saturate_parameter(product_difference(uv, vr, ur, vv) / determinant);
            t = fmaf(uv, s, vr) / vv;
            if (t < 0.0f) {
                t = 0.0f;
                s = saturate_parameter(-ur / uu);
            } else if (t > 1.0f) {
                t = 1.0f;
                s = saturate_parameter((uv - ur) / uu);
            }
        }
    }
    const glm::vec3 first(fmaf(u.x, s, p.x), fmaf(u.y, s, p.y), fmaf(u.z, s, p.z));
    const glm::vec3 second(fmaf(v.x, t, a.x), fmaf(v.y, t, a.y), fmaf(v.z, t, a.z));
    const glm::vec3 difference = first - second;
    return glm::dot(difference, difference);
}

__device__ __forceinline__ glm::vec3 interpolate_point(const glm::vec3& p, const glm::vec3& direction, float t)
{
    return glm::vec3(fmaf(direction.x, t, p.x), fmaf(direction.y, t, p.y), fmaf(direction.z, t, p.z));
}

__device__ __forceinline__ float point_segment_distance2(const glm::vec3& p, const glm::vec3& a,
                                                         const glm::vec3& direction)
{
    const float length2 = glm::dot(direction, direction);
    float t = 0.0f;
    if (length2 > 0.0f) t = saturate_parameter(glm::dot(p - a, direction) / length2);
    const glm::vec3 difference = p - interpolate_point(a, direction, t);
    return glm::dot(difference, difference);
}

// Ericson triangle regions with the original degenerate-triangle fallback and float32 evaluation order.
__device__ __forceinline__ float triangle_distance2(const glm::vec3& p, const glm::vec3& a,
                                                    const glm::vec3& b, const glm::vec3& c)
{
    const glm::vec3 ab = b - a, ac = c - a;
    const glm::vec3 normal = glm::cross(ab, ac);
    if (glm::dot(normal, normal) < 1e-20f)
        return fminf(point_segment_distance2(p, a, ab),
                     fminf(point_segment_distance2(p, b, c - b), point_segment_distance2(p, c, a - c)));
    const glm::vec3 ap = p - a;
    const float d1 = glm::dot(ab, ap), d2 = glm::dot(ac, ap);
    if (d1 <= 0.0f && d2 <= 0.0f) return glm::dot(ap, ap);
    const glm::vec3 bp = p - b;
    const float d3 = glm::dot(ab, bp), d4 = glm::dot(ac, bp);
    if (d3 >= 0.0f && d4 <= d3) return glm::dot(bp, bp);
    const float vc = d1 * d4 - d2 * d3;
    if (vc <= 0.0f && d1 >= 0.0f && d3 <= 0.0f) {
        const glm::vec3 difference = p - interpolate_point(a, ab, d1 / (d1 - d3));
        return glm::dot(difference, difference);
    }
    const glm::vec3 cp = p - c;
    const float d5 = glm::dot(ab, cp), d6 = glm::dot(ac, cp);
    if (d6 >= 0.0f && d5 <= d6) return glm::dot(cp, cp);
    const float vb = d2 * d5 - d1 * d6;
    if (vb <= 0.0f && d2 >= 0.0f && d6 <= 0.0f) {
        const glm::vec3 difference = p - interpolate_point(a, ac, d2 / (d2 - d6));
        return glm::dot(difference, difference);
    }
    const float va = d3 * d6 - d4 * d5;
    const float edge0 = d4 - d3, edge1 = d5 - d6;
    if (va <= 0.0f && edge0 >= 0.0f && edge1 >= 0.0f) {
        const glm::vec3 difference = p - interpolate_point(b, c - b, edge0 / (edge0 + edge1));
        return glm::dot(difference, difference);
    }
    const float inverse = 1.0f / (vc + (va + vb));
    const glm::vec3 point = interpolate_point(interpolate_point(a, ab, vb * inverse), ac, vc * inverse);
    const glm::vec3 difference = p - point;
    return glm::dot(difference, difference);
}

struct EdgeFaceVisit {
    const glm::ivec3* triangles;
    const int* groups;
    int a, b;
    int* slots;
    __device__ __forceinline__ bool operator()(int primitive, int found) const
    {
        const glm::ivec3 tri = triangles[primitive];
        if (tri.x == a || tri.y == a || tri.z == a || tri.x == b || tri.y == b || tri.z == b) return false;
        if (!compatible_groups(groups, a, tri.x) || !compatible_groups(groups, a, tri.y) ||
            !compatible_groups(groups, a, tri.z) || !compatible_groups(groups, b, tri.x) ||
            !compatible_groups(groups, b, tri.y) || !compatible_groups(groups, b, tri.z)) return false;
        slots[found] = primitive;
        return true;
    }
};

// Broad phase only: reject incident/filtered triangles, with a 2r-expanded edge box and no distance test.
__global__ void query_edge_face(const glm::vec3* x, const glm::ivec4* edges, const glm::ivec3* triangles,
                                 const int* groups, const Aabb* boxes, const int* parent, const glm::ivec2* children,
                                 const int* order, float radius, int* counts, int* slots, size_t count,
                                 size_t edges_per_world, size_t triangles_per_world, size_t particles_per_world,
                                 int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world, edge = i % edges_per_world;
    const int a = edges[edge].z, b = edges[edge].w;
    const size_t offset = world * particles_per_world;
    const glm::vec3 p = x[offset + a], q = x[offset + b];
    const float grow = radius + radius;
    const glm::vec3 lower = kernel::min_components(p, q) - grow;
    const glm::vec3 upper = grow + kernel::max_components(p, q);
    const EdgeFaceVisit visit{triangles, groups, a, b, slots + i * max_slots};
    counts[i] = walk_mesh_bvh(lower, upper, boxes + world * (2*triangles_per_world - 1), parent, children,
                              order, triangles_per_world, max_slots, visit);
}

struct EdgeEdgeVisit {
    const glm::vec3* x;
    const glm::ivec4* edges;
    const int* groups;
    size_t edge;
    int a, b;
    float limit;
    int* slots;
    __device__ __forceinline__ bool operator()(int other, int found) const
    {
        const int c = edges[other].z, d = edges[other].w;
        if (edge >= static_cast<size_t>(other) || a == c || a == d || b == c || b == d) return false;
        if (!compatible_groups(groups, a, c) || !compatible_groups(groups, a, d) ||
            !compatible_groups(groups, b, c) || !compatible_groups(groups, b, d)) return false;
        if (!(segment_distance2(x[a], x[b], x[c], x[d]) < limit)) return false;
        slots[found] = other;
        return true;
    }
};

__global__ void query_edge_edge(const glm::vec3* x, const glm::ivec4* edges, const int* groups, const Aabb* boxes,
                                 const int* parent, const glm::ivec2* children, const int* order, float radius,
                                 int* counts, int* slots, size_t count, size_t edges_per_world,
                                 size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world, edge = i % edges_per_world;
    const glm::vec3* positions = x + world * particles_per_world;
    const int a = edges[edge].z, b = edges[edge].w;
    const glm::vec3 p = positions[a], q = positions[b];
    const glm::vec3 lower = kernel::min_components(p, q) - radius;
    const glm::vec3 upper = kernel::max_components(p, q) + radius;
    const EdgeEdgeVisit visit{positions, edges, groups, edge, a, b, (radius * 9.0f) * radius, slots + i * max_slots};
    counts[i] = walk_mesh_bvh(lower, upper, boxes + world * (2*edges_per_world - 1), parent, children,
                              order, edges_per_world, max_slots, visit);
}

struct VertexFaceVisit {
    const glm::vec3* x;
    const glm::ivec3* triangles;
    const int* groups;
    glm::vec3 point;
    int vertex;
    bool skip_incident;
    float limit;
    int* slots;
    __device__ __forceinline__ bool operator()(int primitive, int found) const
    {
        const glm::ivec3 tri = triangles[primitive];
        if (skip_incident && (vertex == tri.x || vertex == tri.y || vertex == tri.z)) return false;
        if (!compatible_groups(groups, vertex, tri.x) || !compatible_groups(groups, vertex, tri.y) ||
            !compatible_groups(groups, vertex, tri.z)) return false;
        if (!(triangle_distance2(point, x[tri.x], x[tri.y], x[tri.z]) < limit)) return false;
        slots[found] = primitive;
        return true;
    }
};

__global__ void query_vertex_face(const glm::vec3* x, const int* vertices, const float* vertex_radius,
                                   const glm::ivec3* triangles, const int* groups, const Aabb* boxes,
                                   const int* parent, const glm::ivec2* children, const int* order,
                                   float radius, float extra, bool skip_incident, int* counts, int* slots,
                                   size_t count, size_t vertices_per_world, size_t triangles_per_world,
                                   size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / vertices_per_world, entry = i % vertices_per_world;
    const int vertex = vertices[entry];
    const glm::vec3* positions = x + world * particles_per_world;
    const glm::vec3 point = positions[vertex];
    const float r = vertex_radius != nullptr ? vertex_radius[vertex] : radius;
    const float reach = (r + extra) * 1.5f;
    const VertexFaceVisit visit{positions, triangles, groups, point, vertex, skip_incident, reach * reach,
                                slots + i * max_slots};
    counts[i] = walk_mesh_bvh(point - r, point + r, boxes + world * (2*triangles_per_world - 1), parent, children,
                              order, triangles_per_world, max_slots, visit);
}

__device__ __forceinline__ bool finite_vector(const glm::vec3& value)
{
    return std::isfinite(value.x) && std::isfinite(value.y) && std::isfinite(value.z);
}

__device__ __forceinline__ bool finite_matrix(const glm::mat3& value)
{
    return finite_vector(value[0]) && finite_vector(value[1]) && finite_vector(value[2]);
}

// Preserve the overflow fallback, including the zero-mass branch of the original penalty calculation.
__device__ __forceinline__ float contact_stiffness(float first, float second, float stiffness, float scaled)
{
    if (first == 0.0f || second == 0.0f) return (first + second) * stiffness;
    const float numerator = scaled * second;
    const float denominator = first + second;
    if (std::isfinite(numerator) && std::isfinite(denominator)) return numerator / denominator;
    const float lower = fminf(first, second), upper = fmaxf(first, second);
    return (lower / (lower / upper + 1.0f)) * stiffness;
}

// A query vertex keeps its own sum locally; triangle contributions are scattered for each accepted contact.
__global__ void accumulate_vertex_face(const glm::vec3* x, const int* vertices, const float* vertex_radius,
                                        const glm::ivec3* triangles, const int* counts, const int* slots,
                                        const float* mass, float radius, float extra, bool skip_incident,
                                        float stiffness, glm::vec3* force, glm::mat3* diagonal,
                                        SelfCollisionContactTangent* contacts, unsigned* counter, size_t count,
                                        size_t vertices_per_world, size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / vertices_per_world;
    const int local_vertex = vertices[i % vertices_per_world];
    const int offset = static_cast<int>(world * particles_per_world);
    const int vertex = local_vertex + offset;
    const glm::vec3 point = x[vertex];
    const float vertex_mass = mass[vertex];
    if (vertex_radius != nullptr) radius = vertex_radius[local_vertex];
    const float limit = radius + extra;
    if (!finite_vector(point) || !std::isfinite(vertex_mass) || !std::isfinite(radius) || !std::isfinite(limit)) return;
    const float scaled = vertex_mass * stiffness;
    glm::vec3 accumulated_force(0.0f);
    glm::mat3 accumulated_diagonal(0.0f);
    for (int slot = 0; slot < counts[i]; ++slot) {
        const glm::ivec3 triangle = triangles[slots[i * max_slots + slot]];
        if (skip_incident && (local_vertex == triangle.x || local_vertex == triangle.y || local_vertex == triangle.z))
            continue;
        const glm::ivec3 ids = triangle + offset;
        const glm::vec3 a = x[ids.x], b = x[ids.y], c = x[ids.z];
        if (!finite_vector(a) || !finite_vector(b) || !finite_vector(c)) continue;
        const glm::vec3 cross = glm::cross(b - a, c - a);
        const float length = sqrtf(glm::dot(cross, cross));
        const glm::vec3 normal = length < 1e-12f ? glm::vec3(0.0f) : cross / length;
        if (!finite_vector(normal)) continue;
        const float xx = normal.x * normal.x, yy = normal.y * normal.y, zz = normal.z * normal.z;
        if (zz + (xx + yy) == 0.0f) continue;
        const float distance = glm::dot(point - a, normal);
        if (!std::isfinite(distance) || fabsf(distance) > limit) continue;
        const glm::vec3 projected = point - distance * normal;
        const glm::vec3 v0 = a - c, v1 = b - c, v2 = projected - c;
        const float d00 = glm::dot(v0, v0), d01 = glm::dot(v0, v1), d02 = glm::dot(v0, v2);
        const float d11 = glm::dot(v1, v1), d12 = glm::dot(v1, v2);
        const float denominator = d00 * d11 - d01 * d01;
        if (fabsf(denominator) < 1e-12f) continue;
        const float inverse = 1.0f / denominator;
        const float wa = inverse * (d11 * d02 - d01 * d12);
        const float wb = inverse * (d00 * d12 - d01 * d02);
        const float wc = (1.0f - wa) - wb;
        if (!std::isfinite(wa) || !std::isfinite(wb) || !std::isfinite(wc) || wa < 0.0f || wb < 0.0f || wc < 0.0f)
            continue;
        const float face_mass = ((mass[ids.y] + mass[ids.x]) + mass[ids.z]) / 3.0f;
        const float k = contact_stiffness(vertex_mass, face_mass, stiffness, scaled);
        const float sign = distance > 0.0f ? 1.0f : (distance < 0.0f ? -1.0f : 0.0f);
        const glm::vec3 f = (sign * ((limit - fabsf(distance)) * k)) * normal;
        const float yx = normal.y * normal.x, zx = normal.z * normal.x, zy = normal.z * normal.y;
        const glm::mat3 h(xx * k, yx * k, zx * k, yx * k, yy * k, zy * k, zx * k, zy * k, zz * k);
        if (!finite_vector(f) || !finite_matrix(h)) continue;
        accumulated_force = accumulated_force + f;
        accumulated_diagonal = accumulated_diagonal + h;
        if (contacts != nullptr) {
            const unsigned contact = atomicAdd(counter, 1u);
            contacts[contact] = SelfCollisionContactTangent{{vertex, ids.x, ids.y, ids.z, 0},
                                                           {1.0f, -wa, -wb, -wc, 0.0f}, normal, k, 4};
        }
        kernel::atomic_add(force + ids.x, f * -wa);
        kernel::atomic_add(diagonal + ids.x, (wa * wa) * h);
        kernel::atomic_add(force + ids.y, f * -wb);
        kernel::atomic_add(diagonal + ids.y, (wb * wb) * h);
        kernel::atomic_add(force + ids.z, f * -wc);
        kernel::atomic_add(diagonal + ids.z, (wc * wc) * h);
    }
    kernel::atomic_add(force + vertex, accumulated_force);
    kernel::atomic_add(diagonal + vertex, accumulated_diagonal);
}

// Candidate ids/radii are world-local, whereas masses, positions and recorded contact ids include the world offset.
__global__ void accumulate_particle_pairs(const glm::vec3* x, const int* particles, const float* radius,
                                           const int* counts, const int* slots, const float* mass, float stiffness,
                                           glm::vec3* force, glm::mat3* diagonal, SelfCollisionContactTangent* contacts,
                                           unsigned* counter, size_t count, size_t particles_per_list,
                                           size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / particles_per_list;
    const int local_particle = particles[i % particles_per_list];
    const int offset = static_cast<int>(world * particles_per_world);
    const int particle = local_particle + offset;
    const glm::vec3 position = x[particle];
    const float first_mass = mass[particle];
    if (!finite_vector(position) || !std::isfinite(first_mass)) return;
    const float scaled = first_mass * stiffness;
    for (int slot = 0; slot < counts[i]; ++slot) {
        const int local_other = slots[i * max_slots + slot];
        const int other = local_other + offset;
        const glm::vec3 other_position = x[other];
        const float other_radius = radius[local_other];
        if (!finite_vector(other_position) || !std::isfinite(other_radius)) continue;
        const glm::vec3 difference = position - other_position;
        const float distance = sqrtf(glm::dot(difference, difference));
        const float reach = radius[local_particle] + other_radius;
        if (!std::isfinite(distance) || !std::isfinite(reach) || distance >= reach) continue;
        glm::vec3 normal;
        if (distance > 1e-8f) normal = difference / distance;
        else {
            const int axis = (local_other ^ local_particle) % 3;
            normal = glm::vec3(axis == 0 ? 1.0f : 0.0f, axis == 1 ? 1.0f : 0.0f,
                               axis == 0 || axis == 1 ? 0.0f : 1.0f);
        }
        const float k = contact_stiffness(first_mass, mass[other], stiffness, scaled);
        if (!std::isfinite(k)) continue;
        const glm::vec3 f = ((reach - distance) * k) * normal;
        const glm::mat3 h = glm::outerProduct(normal, normal) * k;
        if (!finite_vector(f) || !finite_matrix(h)) continue;
        kernel::atomic_add(force + particle, f);
        kernel::atomic_add(force + other, -f);
        kernel::atomic_add(diagonal + particle, h);
        kernel::atomic_add(diagonal + other, h);
        if (contacts != nullptr) {
            const unsigned contact = atomicAdd(counter, 1u);
            contacts[contact] = SelfCollisionContactTangent{{particle, other, 0, 0, 0},
                                                           {1.0f, -1.0f, 0.0f, 0.0f, 0.0f}, normal, k, 2};
        }
    }
}

// The point count is dynamic (up to five); preserve the by-value record and grid-stride traversal.
__global__ void multiply_contact_tangents(const SelfCollisionContactTangent* contacts, const unsigned* counter,
                                          const glm::vec3* direction, glm::vec3* product)
{
    for (size_t i = thread_index(); i < *counter; i += static_cast<size_t>(gridDim.x) * blockDim.x) {
        const SelfCollisionContactTangent contact = contacts[i];
        glm::vec3 sum(0.0f);
        for (int point = 0; point < contact.count; ++point)
            sum = contact.weights[point] * direction[contact.ids[point]] + sum;
        const float scale = contact.stiffness * glm::dot(sum, contact.normal);
        const glm::vec3 tangent = scale * contact.normal;
        for (int point = 0; point < contact.count; ++point)
            kernel::atomic_add(product + contact.ids[point], tangent * contact.weights[point]);
    }
}

// The accumulation kernel keeps the closest-point parameters as well as the distance. Degeneracy comparisons
// are ordered; the complementary PTX branch uses gtu so NaNs must not select a degenerate-segment fallback.
__device__ __forceinline__ glm::vec2 contact_segment_parameters(const glm::vec3& p, const glm::vec3& q,
                                                                const glm::vec3& a, const glm::vec3& b)
{
    const glm::vec3 u = q - p, v = b - a, r = p - a;
    const float uu = glm::dot(u, u), vv = glm::dot(v, v), vr = glm::dot(v, r);
    float s = 0.0f, t = 0.0f;
    if (uu <= 1e-5f && vv <= 1e-5f) {
    } else if (uu <= 1e-5f) {
        t = saturate_parameter(vr / vv);
    } else {
        const float ur = glm::dot(u, r);
        if (vv <= 1e-5f) {
            s = saturate_parameter(-ur / uu);
        } else {
            const float uv = glm::dot(u, v);
            const float determinant = product_difference(uu, vv, uv, uv);
            if (determinant > 0.0f) s = saturate_parameter(product_difference(uv, vr, ur, vv) / determinant);
            t = fmaf(uv, s, vr) / vv;
            if (t < 0.0f) {
                t = 0.0f;
                s = saturate_parameter(-ur / uu);
            } else if (t > 1.0f) {
                t = 1.0f;
                s = saturate_parameter((uv - ur) / uu);
            }
        }
    }
    return glm::vec2(s, t);
}

__device__ __forceinline__ bool opposite_contains(const int* offsets, const int* opposite, size_t edge, int vertex)
{
    for (int entry = offsets[edge]; entry < offsets[edge + 1]; ++entry)
        if (opposite[entry] == vertex) return true;
    return false;
}

// Endpoint sums use FMA, whereas candidate scatters multiply before the atomic add (which also flushes subnormals).
__device__ __forceinline__ void accumulate_endpoint(glm::vec3& force, glm::mat3& diagonal, const glm::vec3& f,
                                                     const glm::mat3& h, float weight)
{
    force = f * weight + force;
    diagonal = h * (weight * weight) + diagonal;
}

// Only interior-interior closest points contribute. Opposite-vertex adjacency can reduce the collision margin.
__global__ void accumulate_edge_edge(const glm::vec3* x, const glm::ivec4* edges, const int* opposite_offsets,
                                      const int* opposite, const int* counts, const int* slots, const float* mass,
                                      float thickness, float stiffness, glm::vec3* force, glm::mat3* diagonal,
                                      SelfCollisionContactTangent* contacts, unsigned* counter, size_t count,
                                      size_t edges_per_world, size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world, edge = i % edges_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const int za = edges[edge].z, wa = edges[edge].w;
    const int first = za + offset, second = wa + offset;
    const glm::vec3 p = x[first], q = x[second];
    const glm::vec3 length_vector = p - q;
    const float length = sqrtf(glm::dot(length_vector, length_vector));
    const float edge_mass = (mass[first] + mass[second]) * 0.5f;
    if (!finite_vector(p) || !finite_vector(q) || !std::isfinite(length) || !std::isfinite(edge_mass)) return;
    const float scaled = edge_mass * stiffness;
    glm::vec3 first_force(0.0f), second_force(0.0f);
    glm::mat3 first_diagonal(0.0f), second_diagonal(0.0f);
    for (int slot = 0; slot < counts[i]; ++slot) {
        const int other = slots[i * max_slots + slot];
        if (edge >= static_cast<size_t>(other)) continue;
        const int zc = edges[other].z, wc = edges[other].w;
        if (za == zc || za == wc || wa == zc || wa == wc) continue;
        const int third = zc + offset, fourth = wc + offset;
        const glm::vec3 a = x[third], b = x[fourth];
        if (!finite_vector(a) || !finite_vector(b)) continue;
        const glm::vec2 parameters = contact_segment_parameters(p, q, a, b);
        const float s = parameters.x, t = parameters.y;
        if (!std::isfinite(s) || !std::isfinite(t) || s <= 0.0f || s >= 1.0f || t <= 0.0f || t >= 1.0f) continue;
        const glm::vec3 difference = interpolate_point(p, q - p, s) - interpolate_point(a, b - a, t);
        const float distance = sqrtf(glm::dot(difference, difference));
        const glm::vec3 other_vector = a - b;
        const float other_length = sqrtf(glm::dot(other_vector, other_vector));
        const float mean = (length + other_length) * 0.5f;
        if (!std::isfinite(distance) || !std::isfinite(mean)) continue;
        float limit = thickness;
        if (opposite_contains(opposite_offsets, opposite, edge, zc) ||
            opposite_contains(opposite_offsets, opposite, edge, wc) ||
            opposite_contains(opposite_offsets, opposite, other, za) ||
            opposite_contains(opposite_offsets, opposite, other, wa)) limit = fminf(thickness, mean * 0.5f);
        if (distance >= limit || distance <= 1e-6f) continue;
        const glm::vec3 normal = difference / distance;
        const float other_mass = (mass[third] + mass[fourth]) * 0.5f;
        const float k = contact_stiffness(edge_mass, other_mass, stiffness, scaled);
        if (!std::isfinite(k)) continue;
        const glm::vec3 f = normal * ((limit - distance) * k);
        const glm::mat3 h = glm::outerProduct(normal, normal) * k;
        if (!finite_vector(f) || !finite_matrix(h)) continue;
        const float one_s = 1.0f - s, one_t = 1.0f - t;
        if (contacts != nullptr) {
            const unsigned contact = atomicAdd(counter, 1u);
            contacts[contact] = SelfCollisionContactTangent{{first, second, third, fourth, 0},
                                                           {one_s, s, -one_t, -t, 0.0f}, normal, k, 4};
        }
        accumulate_endpoint(first_force, first_diagonal, f, h, one_s);
        kernel::atomic_add(force + third, f * -one_t);
        kernel::atomic_add(diagonal + third, (one_t * one_t) * h);
        accumulate_endpoint(second_force, second_diagonal, f, h, s);
        kernel::atomic_add(force + fourth, f * -t);
        kernel::atomic_add(diagonal + fourth, (t * t) * h);
    }
    kernel::atomic_add(force + first, first_force);
    kernel::atomic_add(diagonal + first, first_diagonal);
    kernel::atomic_add(force + second, second_force);
    kernel::atomic_add(diagonal + second, second_diagonal);
}

// Intersections use a folded direction formed from adjacent faces, not the triangle normal penalty of VF.
__global__ void accumulate_edge_face(const glm::vec3* x, const glm::ivec4* edges, const int* opposite_offsets,
                                      const int* opposite, const glm::ivec3* triangles, const int* counts,
                                      const int* slots, const float* mass, float thickness, float stiffness,
                                      glm::vec3* force, glm::mat3* diagonal, SelfCollisionContactTangent* contacts,
                                      unsigned* counter, size_t count, size_t edges_per_world,
                                      size_t particles_per_world, int max_slots)
{
    const size_t i = thread_index();
    if (i >= count) return;
    const size_t world = i / edges_per_world, edge = i % edges_per_world;
    const int offset = static_cast<int>(world * particles_per_world);
    const int z = edges[edge].z, w = edges[edge].w, first = z + offset, second = w + offset;
    const glm::vec3 xz = x[first], xw = x[second], e = xz - xw;
    const float length = sqrtf(glm::dot(e, e));
    if (!finite_vector(xz) || !finite_vector(xw) || !std::isfinite(length) || length < 0.0005f) return;
    const glm::vec3 direction = length > 0.0f ? e / length : glm::vec3(0.0f);
    const float edge_mass = (mass[first] + mass[second]) * 0.5f;
    if (!std::isfinite(edge_mass)) return;
    const float scaled = edge_mass * stiffness, twice = thickness + thickness;
    glm::vec3 first_force(0.0f), second_force(0.0f);
    glm::mat3 first_diagonal(0.0f), second_diagonal(0.0f);
    for (int slot = 0; slot < counts[i]; ++slot) {
        const glm::ivec3 tri = triangles[slots[i * max_slots + slot]];
        if (z == tri.x || z == tri.y || z == tri.z || w == tri.x || w == tri.y || w == tri.z) continue;
        const glm::ivec3 ids = tri + offset;
        const glm::vec3 a = x[ids.x], b = x[ids.y], c = x[ids.z];
        if (!finite_vector(a) || !finite_vector(b) || !finite_vector(c)) continue;
        const glm::vec3 cross = glm::cross(b - a, c - b);
        const float area = sqrtf(glm::dot(cross, cross));
        if (!std::isfinite(area) || area < 1e-8f) continue;
        const glm::vec3 tn = cross / area;
        const float dz = glm::dot(xz - a, tn), dw = glm::dot(xw - a, tn);
        if (!std::isfinite(dz) || !std::isfinite(dw) || dz * dw >= 0.0f) continue;
        const float az = fabsf(dz), aw = fabsf(dw), total = az + aw;
        if (!std::isfinite(total) || total <= 0.0f) continue;
        const glm::vec3 point((fmaf(xw.x, az, xz.x * aw)) / total, (fmaf(xw.y, az, xz.y * aw)) / total,
                               (fmaf(xw.z, az, xz.z * aw)) / total);
        const glm::vec3 v0 = a - c, v1 = b - c, v2 = point - c;
        const float d00 = glm::dot(v0, v0), d01 = glm::dot(v0, v1), d02 = glm::dot(v0, v2);
        const float d11 = glm::dot(v1, v1), d12 = glm::dot(v1, v2);
        const float denominator = d00 * d11 - d01 * d01;
        if (fabsf(denominator) < 1e-12f) continue;
        const float inverse = 1.0f / denominator;
        const float wa = inverse * (d11 * d02 - d01 * d12), wb = inverse * (d00 * d12 - d01 * d02);
        const float wc = (1.0f - wa) - wb;
        if (!std::isfinite(wa) || !std::isfinite(wb) || !std::isfinite(wc) || wa < 0.01f || wb < 0.01f || wc < 0.01f)
            continue;
        glm::vec3 accumulated(0.0f);
        const float tn_direction = glm::dot(tn, direction);
        for (int entry = opposite_offsets[edge]; entry < opposite_offsets[edge + 1]; ++entry) {
            const glm::vec3 xo = x[opposite[entry] + offset];
            const glm::vec3 face_cross = glm::cross(xw - xz, xo - xz);
            const float face_length = sqrtf(glm::dot(face_cross, face_cross));
            const glm::vec3 face_normal = face_length < 1e-12f ? glm::vec3(0.0f) : face_cross / face_length;
            if (!finite_vector(face_normal)) continue;
            const glm::vec3 folded_cross = glm::cross(tn, face_normal);
            const float folded_length = sqrtf(glm::dot(folded_cross, folded_cross));
            glm::vec3 g = folded_length < 1e-6f ? glm::vec3(0.0f) : folded_cross / folded_length;
            const glm::vec3 h = glm::cross(direction, g), r = xo - point;
            const glm::vec3 m = glm::cross(direction, r);
            if (glm::dot(m, h) < 0.0f) g = -g;
            if (fabsf(tn_direction) > 1e-6f) {
                // This dot product starts with x*x; the surrounding geometric dots start with y*y.
                const float dg = fmaf(direction.z, g.z, fmaf(direction.y, g.y, direction.x * g.x));
                g = g - ((tn + tn) * dg) / tn_direction;
            }
            accumulated = accumulated + g;
        }
        const float direction_length = sqrtf(glm::dot(accumulated, accumulated));
        if (!std::isfinite(direction_length) || direction_length < 1e-12f) continue;
        const glm::vec3 normal = accumulated / direction_length;
        const float face_mass = ((mass[ids.y] + mass[ids.x]) + mass[ids.z]) / 3.0f;
        const float k = contact_stiffness(edge_mass, face_mass, stiffness, scaled);
        if (!std::isfinite(k)) continue;
        const glm::vec3 f = normal * (twice * k);
        const glm::mat3 h = glm::outerProduct(normal, normal) * k;
        if (!finite_vector(f) || !finite_matrix(h)) continue;
        const float wz = aw / total, ww = az / total;
        if (contacts != nullptr) {
            const unsigned contact = atomicAdd(counter, 1u);
            contacts[contact] = SelfCollisionContactTangent{{first, second, ids.x, ids.y, ids.z},
                                                           {wz, ww, -wa, -wb, -wc}, normal, k, 5};
        }
        accumulate_endpoint(first_force, first_diagonal, f, h, wz);
        accumulate_endpoint(second_force, second_diagonal, f, h, ww);
        kernel::atomic_add(force + ids.x, f * -wa);
        kernel::atomic_add(diagonal + ids.x, (wa * wa) * h);
        kernel::atomic_add(force + ids.y, f * -wb);
        kernel::atomic_add(diagonal + ids.y, (wb * wb) * h);
        kernel::atomic_add(force + ids.z, f * -wc);
        kernel::atomic_add(diagonal + ids.z, (wc * wc) * h);
    }
    kernel::atomic_add(force + first, first_force);
    kernel::atomic_add(diagonal + first, first_diagonal);
    kernel::atomic_add(force + second, second_force);
    kernel::atomic_add(diagonal + second, second_diagonal);
}

}  // namespace synreal::self_collision_kernel
