// Granular material (synreal::Granular): breakable plastic bonds and frictional contacts between grains.
#include "model.cuh"

namespace synreal::granular_kernel {

// Adds the granular Gauss-Newton block diagonal to the preconditioner blocks.
__global__ void add_diagonal(const glm::mat3* granular_diagonal, glm::mat3* diagonal, int count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    diagonal[i] += granular_diagonal[i];
}

// Bond tangent times the CG direction: z = K (p_a - p_b) is added to a and subtracted from b (active bonds only).
__global__ void multiply_bonds(const glm::ivec2* bonds, const int* active, const glm::mat3* tangent, int count,
                               const glm::vec3* p, glm::vec3* product)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    if (!active[i]) return;
    const int a = bonds[i].x;
    const int b = bonds[i].y;
    const glm::vec3 z = tangent[i] * (p[a] - p[b]);
    kernel::atomic_add(&product[a], z);
    kernel::atomic_add(&product[b], -z);
}

struct View {
    int* head;
    int* next;
    const int* ids;
    const int* world;
    const glm::ivec3* cells;
    const glm::vec3* positions;
    const glm::vec3* previous;
    const float* radius;
    const int* counts;
    const int* neighbours;
    const glm::vec4* cache;
    int count;
    int slots;
    float cell_size;
    float stiffness;
    float friction;
    float friction_damping;
    float dt;
};
static_assert(sizeof(View) == 120);
static_assert(offsetof(View, count) == 88);
static_assert(offsetof(View, cell_size) == 96);
static_assert(offsetof(View, dt) == 112);

// The radius and grain list are local to a world; positions/previous and output ids use replicated particle offsets.
__global__ void build_grid(Model model, const glm::vec3* x, const glm::vec3* previous, View view,
                            glm::vec3* positions, glm::vec3* previous_positions, float* radius, int* ids, int* worlds,
                            glm::ivec3* cells, int* head, int* next)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= view.count) return;
    const unsigned world = static_cast<unsigned>(i) / model.granular_count;
    const unsigned local = static_cast<unsigned>(i) % model.granular_count;
    const int particle = model.granular_indices[local];
    // The original uses unsigned widening for position addressing (mul.wide.u32).
    const unsigned global_particle = model.particles_per_world * world + particle;
    ids[i] = global_particle;
    int particle_world = world;
    if (model.particle_count <= model.particles_per_world) {
        particle_world = 0;
        if (model.particle_world_count != 0) particle_world = max(model.particle_world[particle], 0);
    }
    worlds[i] = particle_world;
    positions[i] = x[global_particle];
    previous_positions[i] = previous[global_particle];
    radius[i] = model.radius[particle];
    const glm::ivec3 cell(static_cast<int>(floorf(positions[i].x / view.cell_size)),
                          static_cast<int>(floorf(positions[i].y / view.cell_size)),
                          static_cast<int>(floorf(positions[i].z / view.cell_size)));
    cells[i] = cell;
    const int slot = ((cell.x * 73856093) ^ (cell.y * 19349663) ^ (cell.z * 83492791)) & (view.slots - 1);
    next[i] = atomicExch(head + slot, i);
}

__device__ __forceinline__ glm::vec3 coincident_axis(int a, int b)
{
    const int axis = (min(a, b) + max(a, b)) % 3;
    const float sign = a < b ? 1.0f : -1.0f;
    return axis == 1 ? glm::vec3(0.0f, sign, 0.0f) : axis == 2 ? glm::vec3(0.0f, 0.0f, sign) :
                                                               glm::vec3(sign, 0.0f, 0.0f);
}

__device__ __forceinline__ float effective_length(const Model& model, float length, float rest, float history)
{
    return fmaxf(rest * (1.0f - model.bond_max_compaction),
                  fminf(history, fmaf(rest, model.bond_yield_strain, length)));
}

// A broken bond leaves its history untouched; intact bonds commit the clamped plastic rest length.
__global__ void commit_bonds(Model model, const glm::vec3* x, const glm::ivec2* bonds, const float* rest,
                              float* history, int* active, int count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count || active[i] == 0) return;
    const glm::vec3 difference = x[bonds[i].x] - x[bonds[i].y];
    const float length = sqrtf(glm::dot(difference, difference));
    if (length > history[i] * (model.bond_break_strain + 1.0f)) active[i] = 0;
    else history[i] = effective_length(model, length, rest[i], history[i]);
}

// The tangent is reset even for inactive/broken bonds. Damping contributes to the tangent for every sign of dt.
__global__ void accumulate_bonds(Model model, const glm::vec3* x, const glm::vec3* previous, float dt,
                                  const glm::ivec2* bonds, const float* rest, const float* history, const int* active,
                                  int count, float stiffness, glm::vec3* force, glm::mat3* diagonal,
                                  glm::mat3* tangent)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    tangent[i] = glm::mat3(0.0f);
    if (active[i] == 0) return;
    const int a = bonds[i].x, b = bonds[i].y;
    const glm::vec3 difference = x[a] - x[b];
    const float length = sqrtf(glm::dot(difference, difference));
    if (length > history[i] * (model.bond_break_strain + 1.0f)) return;
    const glm::vec3 normal = length > 1e-8f ? difference / length : coincident_axis(a, b);
    const float floor = rest[i] * (1.0f - model.bond_max_compaction);
    const float effective = effective_length(model, length, rest[i], history[i]);
    const float stretch = length - effective;
    float magnitude = -(stretch * stiffness);
    const float damping = model.bond_damping / dt;
    if (damping > 0.0f) {
        const glm::vec3 old_difference = previous[a] - previous[b];
        const float reference_length = sqrtf(glm::dot(old_difference, old_difference));
        magnitude -= damping * (length - reference_length);
    }
    const float axial = effective > floor && effective < history[i] ? 0.0f : stiffness;
    const float transverse = (fmaxf(stretch, 0.0f) * stiffness) / fmaxf(length, 1e-8f);
    const float scale = (damping + axial) - transverse;
    const float xx = fmaf(scale, normal.x * normal.x, transverse);
    const float yx = fmaf(transverse, 0.0f, scale * (normal.y * normal.x));
    const float zx = fmaf(transverse, 0.0f, scale * (normal.z * normal.x));
    const float yy = fmaf(scale, normal.y * normal.y, transverse);
    const float zy = fmaf(transverse, 0.0f, scale * (normal.z * normal.y));
    const float zz = fmaf(scale, normal.z * normal.z, transverse);
    const glm::mat3 block(xx, yx, zx, yx, yy, zy, zx, zy, zz);
    tangent[i] = block;
    const glm::vec3 f = normal * magnitude;
    kernel::atomic_add(force + a, f);
    kernel::atomic_add(force + b, -f);
    kernel::atomic_add(diagonal + a, block);
    kernel::atomic_add(diagonal + b, block);
}

// Grain neighbourhoods use the same hash order as fluids, but require exact world equality (no shared world -1).
struct NeighbourIterator {
    const View& view;
    glm::ivec3 origin, cell;
    int world, next_cell, next_point;
    __device__ __forceinline__ NeighbourIterator(const View& state, int query)
        : view(state), origin(state.cells[query] - 1), cell(0), world(state.world[query]), next_cell(0), next_point(-1)
    {
    }
    __device__ __forceinline__ int advance()
    {
        for (;;) {
            while (next_point >= 0) {
                const int point = next_point;
                next_point = view.next[point];
                const glm::ivec3 candidate = view.cells[point];
                if (candidate.x == cell.x && candidate.y == cell.y && candidate.z == cell.z &&
                    view.world[point] == world) return point;
            }
            if (next_cell == 27) return -1;
            cell = origin + glm::ivec3(next_cell % 3, (next_cell / 3) % 3, next_cell / 9);
            ++next_cell;
            const int slot = ((cell.x * 73856093) ^ (cell.y * 19349663) ^ (cell.z * 83492791)) & (view.slots - 1);
            next_point = view.head[slot];
        }
    }
};

struct Contact {
    glm::vec3 normal;
    glm::vec3 force;
    float viscosity;
};

// Nearly coincident grains use the original approximate reciprocal square root of their previous separation.
__device__ __forceinline__ bool contact(const View& view, int i, int j, Contact& result)
{
    if (j == i) return false;
    const glm::vec3 difference = view.positions[i] - view.positions[j];
    const float reach = view.radius[i] + view.radius[j];
    const float distance2 = glm::dot(difference, difference);
    if (distance2 >= reach * reach) return false;
    const glm::vec3 old_difference = view.previous[i] - view.previous[j];
    const float distance = sqrtf(distance2);
    glm::vec3 normal;
    if (distance > 1e-8f) normal = difference / distance;
    else {
        const float old_length2 = glm::dot(old_difference, old_difference);
        normal = old_length2 > 1e-16f ? old_difference * rsqrtf(old_length2) : coincident_axis(i, j);
    }
    const glm::vec3 relative = difference - old_difference;
    const float normal_displacement = glm::dot(relative, normal);
    const glm::vec3 tangential = relative - normal_displacement * normal;
    const float normal_force = view.stiffness * (reach - distance);
    const float tangent_length = sqrtf(glm::dot(tangential, tangential));
    const float viscosity = fminf(view.friction_damping / view.dt,
                                  (view.friction * normal_force) / fmaxf(tangent_length, 1e-8f));
    result.normal = normal;
    result.force = normal_force * normal - viscosity * tangential;
    result.viscosity = viscosity;
    return true;
}

__device__ __forceinline__ glm::mat3 contact_block(const glm::vec3& n, float stiffness, float viscosity)
{
    const float scale = stiffness - viscosity;
    const float xx = fmaf(scale, n.x * n.x, viscosity);
    const float yx = fmaf(viscosity, 0.0f, scale * (n.y * n.x));
    const float zx = fmaf(viscosity, 0.0f, scale * (n.z * n.x));
    const float yy = fmaf(scale, n.y * n.y, viscosity);
    const float zy = fmaf(viscosity, 0.0f, scale * (n.z * n.y));
    const float zz = fmaf(scale, n.z * n.z, viscosity);
    return glm::mat3(xx, yx, zx, yx, yy, zy, zx, zy, zz);
}

// A grain owns its output row: add the force sum, overwrite the diagonal, and store the first 32 contacts slot-major.
__global__ void accumulate_contacts(View view, glm::vec3* force, glm::mat3* diagonal, int* counts, int* neighbours,
                                     glm::vec4* cache)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= view.count) return;
    NeighbourIterator iterator(view, i);
    glm::vec3 accumulated_force(0.0f);
    glm::mat3 accumulated_diagonal(0.0f);
    int found = 0;
    for (int j = iterator.advance(); j >= 0; j = iterator.advance()) {
        Contact pair;
        if (!contact(view, i, j, pair)) continue;
        if (found < 32) {
            const size_t slot = static_cast<size_t>(found) * view.count + i;
            neighbours[slot] = j;
            cache[slot] = glm::vec4(pair.normal, pair.viscosity);
        }
        accumulated_force = accumulated_force + pair.force;
        accumulated_diagonal = accumulated_diagonal + contact_block(pair.normal, view.stiffness, pair.viscosity);
        ++found;
    }
    counts[i] = found;
    const int a = view.ids[i];
    force[a] += accumulated_force;
    diagonal[a] = accumulated_diagonal;
}

__device__ __forceinline__ glm::vec3 contact_product(const glm::vec3& normal, float viscosity, float stiffness,
                                                     const glm::vec3& difference)
{
    const float scale = (stiffness - viscosity) * glm::dot(normal, difference);
    return glm::vec3(fmaf(viscosity, difference.x, normal.x * scale),
                      fmaf(viscosity, difference.y, normal.y * scale),
                      fmaf(viscosity, difference.z, normal.z * scale));
}

// Overflowed rows recompute geometry and friction; a truncated cache is never treated as the complete row.
__global__ void multiply_contacts(View view, const glm::vec3* direction, glm::vec3* product)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= view.count) return;
    const int a = view.ids[i];
    glm::vec3 accumulated(0.0f);
    if (view.counts[i] < 33) {
        for (int entry = 0; entry < view.counts[i]; ++entry) {
            const size_t slot = static_cast<size_t>(entry) * view.count + i;
            const int b = view.ids[view.neighbours[slot]];
            const glm::vec4 cached = view.cache[slot];
            accumulated = accumulated + contact_product(glm::vec3(cached), cached.w, view.stiffness,
                                                         direction[a] - direction[b]);
        }
    } else {
        NeighbourIterator iterator(view, i);
        for (int j = iterator.advance(); j >= 0; j = iterator.advance()) {
            Contact pair;
            if (!contact(view, i, j, pair)) continue;
            accumulated = accumulated + contact_product(pair.normal, pair.viscosity, view.stiffness,
                                                         direction[a] - direction[view.ids[j]]);
        }
    }
    product[a] = accumulated + product[a];
}

// Initial-bond CSR is sorted. Search before considering geometry or occupancy of dynamic slots.
__device__ __forceinline__ bool initial_bond(const int* offsets, const int* columns, int row, int other)
{
    int lower = offsets[row], upper = offsets[row + 1];
    const int end = upper;
    while (lower < upper) {
        const int middle = lower + (upper - lower) / 2;
        if (columns[middle] < other) lower = middle + 1;
        else upper = middle;
    }
    return lower < end && columns[lower] == other;
}

// Release separated inactive slots, then greedily fill each free slot with the nearest eligible higher-index grain.
__global__ void form_bonds(Model model, View view, const int* offsets, const int* columns, int* partner,
                            glm::ivec2* bonds, float* rest, float* history, int* active)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= view.count) return;
    const unsigned capacity = model.granular_max_dynamic_bonds;
    const int base = capacity * i;
    if (capacity == 0) return;
    for (unsigned slot = 0; slot < capacity; ++slot) {
        const int entry = base + slot, j = partner[entry];
        if (j < 0 || active[entry] != 0) continue;
        const float reach = (view.radius[i] + view.radius[j]) + model.granular_formation_gap;
        const glm::vec3 difference = view.positions[i] - view.positions[j];
        if (glm::dot(difference, difference) > reach * reach) partner[entry] = -1;
    }
    for (unsigned slot = 0; slot < capacity; ++slot) {
        const int entry = base + slot;
        if (partner[entry] >= 0) continue;
        int best = -1;
        float best_distance2 = INFINITY;
        NeighbourIterator iterator(view, i);
        for (int j = iterator.advance(); j >= 0; j = iterator.advance()) {
            if (j <= i || initial_bond(offsets, columns, i, j)) continue;
            const glm::vec3 difference = view.positions[i] - view.positions[j];
            const float distance2 = glm::dot(difference, difference);
            const float reach = (view.radius[i] + view.radius[j]) + model.granular_formation_gap;
            if (distance2 <= 1e-16f || distance2 > reach * reach) continue;
            const float maximum_displacement = view.dt * model.granular_formation_speed;
            const glm::vec3 relative = difference - (view.previous[i] - view.previous[j]);
            if (glm::dot(relative, relative) > maximum_displacement * maximum_displacement) continue;
            bool occupied = false;
            for (unsigned existing = 0; existing < capacity; ++existing) {
                if (partner[base + existing] == j) { occupied = true; break; }
            }
            if (occupied) continue;
            if (distance2 < best_distance2 || (distance2 == best_distance2 && j < best)) {
                best = j;
                best_distance2 = distance2;
            }
        }
        if (best < 0) return;
        partner[entry] = best;
        bonds[entry] = glm::ivec2(view.ids[i], view.ids[best]);
        const float length = sqrtf(best_distance2);
        history[entry] = length;
        rest[entry] = length;
        active[entry] = 1;
    }
}

}  // namespace synreal::granular_kernel
