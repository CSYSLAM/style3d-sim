// Particle fluid (synreal::Fluid): density constraints solved inside the Newton step.
#include "model.cuh"

namespace synreal::fluid_kernel {

// Device view of the fluid solver state. Grid points are the fluid particles followed by static boundary samples,
// `stride` points per world; `rows` = fluid particles of all worlds.
struct View {
    int* head;            // spatial hash: first point per slot (-1 = empty)
    int* next;            // spatial hash: next point in the slot list
    const int* ids;       // grid point -> particle index
    const int* world;     // grid point -> world
    glm::ivec3* cells;    // grid point -> integer cell coordinates
    glm::vec3* positions; // grid point positions of the current iterate
    float* volumes;       // grid point volumes
    int* counts;          // per row: cached neighbours
    int* neighbours;      // per row: cached neighbour points (64 slots)
    glm::vec4* cache;     // per row: cached kernel gradient and value per neighbour
    int slots;
    int stride;
    int fluid_count;
    int rows;
    float smoothing_radius;
    float bulk_modulus;
    float viscosity;
    float dt;
};

__global__ void initialize_scale(float* scale, float value, int count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    scale[i] = value;
}

// Adds the fluid Gauss-Newton block diagonal D to the preconditioner blocks.
__global__ void add_diagonal(const glm::mat3* fluid_diagonal, glm::mat3* diagonal, int count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    diagonal[i] += fluid_diagonal[i];
}

// Step limiter: per world, the smallest of `relaxation` and max_step / |dx| over its fluid particles. Positive floats
// order like their bit patterns as signed ints, so an integer atomicMin gives the float minimum.
__global__ void bound_scale(View view, const glm::vec3* solution, float relaxation, float max_step, float* scale)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= view.rows) return;
    const int world = i / view.fluid_count;
    const int point = world * view.stride + i % view.fluid_count;
    const float length = glm::length(solution[view.ids[point]]);
    float limit = relaxation;
    if (max_step > 0.0f && length > max_step) limit = fminf(limit, max_step / length);
    atomicMin(reinterpret_cast<int*>(&scale[view.world[point]]), __float_as_int(limit));
}

// World selection differs for replicated models and single-copy models with an explicit particle-world table.
__global__ void scale_step(Model model, glm::vec3* solution, const float* scale, int count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    int world = 0;
    if (model.particle_count > model.particles_per_world) world = static_cast<unsigned>(i) / model.particles_per_world;
    else if (model.particle_world_count != 0) world = max(model.particle_world[i], 0);
    const float factor = scale[world];
    solution[i] *= factor;
}

// Each replicated world shares the local mass/boundary arrays but scatters dynamic ids into its particle range.
__global__ void build_grid(Model model, const glm::vec3* x, glm::vec3* positions, float* volumes, int* ids,
                            int* worlds, glm::ivec3* cells, int* head, int* next, int count, int slots)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    const unsigned stride = model.fluid_count + model.boundary_count;
    const unsigned world = static_cast<unsigned>(i) / stride, local = static_cast<unsigned>(i) % stride;
    if (local < model.fluid_count) {
        const int particle = model.fluid_indices[local];
        ids[i] = model.particles_per_world * world + particle;
        int particle_world = world;
        if (model.particle_count <= model.particles_per_world) {
            particle_world = 0;
            if (model.particle_world_count != 0) particle_world = max(model.particle_world[particle], 0);
        }
        worlds[i] = particle_world;
        positions[i] = x[ids[i]];
        volumes[i] = model.mass[particle] / model.rest_density;
    } else {
        const unsigned boundary = local - model.fluid_count;
        ids[i] = -1;
        worlds[i] = model.particle_count > model.particles_per_world ? static_cast<int>(world) : -1;
        positions[i] = model.boundary_positions[boundary];
        volumes[i] = model.boundary_volumes[boundary];
    }
    const glm::ivec3 cell(static_cast<int>(floorf(positions[i].x / model.smoothing_radius)),
                          static_cast<int>(floorf(positions[i].y / model.smoothing_radius)),
                          static_cast<int>(floorf(positions[i].z / model.smoothing_radius)));
    cells[i] = cell;
    const int slot = ((cell.x * 73856093) ^ (cell.y * 19349663) ^ (cell.z * 83492791)) & (slots - 1);
    next[i] = atomicExch(head + slot, i);
}

static_assert(sizeof(View) == 112);
static_assert(offsetof(View, slots) == 80);
static_assert(offsetof(View, smoothing_radius) == 96);

// Traverse exact cells in x-fastest order, retaining only this world or the shared static world (-1).
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
                    (view.world[point] == world || view.world[point] == -1)) return point;
            }
            if (next_cell == 27) return -1;
            cell = origin + glm::ivec3(next_cell % 3, (next_cell / 3) % 3, next_cell / 9);
            ++next_cell;
            const int slot = ((cell.x * 73856093) ^ (cell.y * 19349663) ^ (cell.z * 83492791)) & (view.slots - 1);
            next_point = view.head[slot];
        }
    }
};

struct Smoothing {
    float h2, h3, h5, minus_two_mu, soft2;

    __device__ __forceinline__ explicit Smoothing(const View& view)
    {
        const float h = view.smoothing_radius;
        h2 = h * h;
        h3 = h * h2;
        h5 = h * (h * h3);
        minus_two_mu = view.viscosity * -2.0f;
        soft2 = h * (h * 0.01f);
    }
};

__device__ __forceinline__ int row_point(const View& view, int row)
{
    return (row / view.fluid_count) * view.stride + row % view.fluid_count;
}

__device__ __forceinline__ glm::vec3 smoothing_gradient(const Smoothing& smoothing, const glm::vec3& difference,
                                                        float z)
{
    const float factor = z * (z * __int_as_float(0xc11666c3));
    return (difference * factor) / smoothing.h5;
}

__device__ __forceinline__ float viscosity_scale(const View& view, const Smoothing& smoothing, int query,
                                                 int neighbour, const glm::vec3& difference, float distance2,
                                                 const glm::vec3& gradient)
{
    const float scale = (smoothing.minus_two_mu * view.volumes[query]) * view.volumes[neighbour];
    return ((glm::dot(difference, gradient) * scale) / (smoothing.soft2 + distance2)) / view.dt;
}

// Cache at most 64 dynamic neighbours, but count every neighbour so the later kernels can choose their fallback.
__global__ void evaluate_rows(View view, glm::vec3* gradients, float* residuals, float* weights, int* counts,
                               int* neighbours, glm::vec4* cache)
{
    const int row = blockIdx.x * blockDim.x + threadIdx.x;
    if (row >= view.rows) return;
    const int query = row_point(view, row);
    const Smoothing smoothing(view);
    NeighbourIterator iterator(view, query);
    float density = 0.0f;
    glm::vec3 gradient(0.0f);
    int found = 0;
    for (int j = iterator.advance(); j >= 0; j = iterator.advance()) {
        const glm::vec3 difference = view.positions[query] - view.positions[j];
        const float distance2 = glm::dot(difference, difference);
        const float z = fmaxf(1.0f - distance2 / smoothing.h2, 0.0f);
        const float value = (z * (z * (z * __int_as_float(0x3fc88904)))) / smoothing.h3;
        const float volume = view.volumes[j];
        density = fmaf(volume, value, density);
        if (j == query) continue;
        const glm::vec3 g = smoothing_gradient(smoothing, difference, z);
        gradient = g * volume + gradient;
        if (view.ids[j] < 0 || !(distance2 < smoothing.h2)) continue;
        if (found < 64) {
            const int slot = row * 64 + found;
            neighbours[slot] = j;
            float viscosity = 0.0f;
            if (view.viscosity > 0.0f && j > query)
                viscosity = viscosity_scale(view, smoothing, query, j, difference, distance2, g);
            cache[slot] = glm::vec4(g * -view.volumes[j], viscosity);
        }
        ++found;
    }
    gradients[row] = gradient;
    residuals[row] = fmaxf(density + -1.0f, 0.0f);
    weights[row] = density > 1.0f ? view.bulk_modulus * view.volumes[query] : 0.0f;
    counts[row] = found;
}

// Cached and recomputed viscosity both scatter a full isotropic block, including its six zero entries.
__device__ __forceinline__ void scatter_viscosity(glm::vec3* force, glm::mat3* diagonal, int a, int b,
                                                  const glm::vec3& difference, float viscosity)
{
    const glm::vec3 f = difference * -viscosity;
    kernel::atomic_add(force + a, f);
    kernel::atomic_add(force + b, -f);
    kernel::atomic_add(diagonal + a, glm::mat3(viscosity));
    kernel::atomic_add(diagonal + b, glm::mat3(viscosity));
}

// Density forces and Gauss-Newton diagonal, with a second grid walk when the 64-entry row cache overflows.
__global__ void accumulate_rows(View view, const glm::vec3* gradients, const float* residuals, const float* weights,
                                 const glm::vec3* previous, glm::vec3* force, glm::mat3* diagonal)
{
    const int row = blockIdx.x * blockDim.x + threadIdx.x;
    if (row >= view.rows) return;
    const int query = row_point(view, row), a = view.ids[query];
    const float k = weights[row];
    const glm::vec3 g = gradients[row];
    kernel::atomic_add(force + a, g * -(k * residuals[row]));
    kernel::atomic_add(diagonal + a, glm::outerProduct(g, g) * k);
    if (view.counts[row] < 65) {
        for (int entry = 0; entry < view.counts[row]; ++entry) {
            const int slot = row * 64 + entry, neighbour = view.neighbours[slot], b = view.ids[neighbour];
            const glm::vec4 cached = view.cache[slot];
            const glm::vec3 c(cached);
            kernel::atomic_add(force + b, c * -(k * residuals[row]));
            kernel::atomic_add(diagonal + b, glm::outerProduct(c, c) * k);
            if (cached.w > 0.0f) {
                const glm::vec3 dx = view.positions[query] - view.positions[neighbour];
                const glm::vec3 dy = previous[a] - previous[b];
                scatter_viscosity(force, diagonal, a, b, dx - dy, cached.w);
            }
        }
    } else {
        const Smoothing smoothing(view);
        NeighbourIterator iterator(view, query);
        for (int j = iterator.advance(); j >= 0; j = iterator.advance()) {
            const int b = view.ids[j];
            if (j == query || b < 0) continue;
            const glm::vec3 difference = view.positions[query] - view.positions[j];
            const float distance2 = glm::dot(difference, difference);
            const float z = fmaxf(1.0f - distance2 / smoothing.h2, 0.0f);
            const glm::vec3 g = smoothing_gradient(smoothing, difference, z);
            const glm::vec3 c = g * -view.volumes[j];
            kernel::atomic_add(force + b, c * -(k * residuals[row]));
            kernel::atomic_add(diagonal + b, glm::outerProduct(c, c) * k);
            // The fallback deliberately has no radius or computed-viscosity positivity check.
            if (view.viscosity > 0.0f && j > query) {
                const float viscosity = viscosity_scale(view, smoothing, query, j, difference, distance2, g);
                const glm::vec3 dy = previous[a] - previous[b];
                scatter_viscosity(force, diagonal, a, b, difference - dy, viscosity);
            }
        }
    }
}

// Matrix-free density/viscosity operator. Overflowed rows traverse their neighbourhood twice in the same order.
__global__ void multiply_rows(View view, const glm::vec3* gradients, const float* weights,
                               const glm::vec3* direction, glm::vec3* product)
{
    const int row = blockIdx.x * blockDim.x + threadIdx.x;
    if (row >= view.rows) return;
    const int query = row_point(view, row), a = view.ids[query];
    const glm::vec3 g = gradients[row];
    float sum = glm::dot(g, direction[a]);
    if (view.counts[row] < 65) {
        for (int entry = 0; entry < view.counts[row]; ++entry) {
            const int slot = row * 64 + entry, b = view.ids[view.neighbours[slot]];
            sum += glm::dot(glm::vec3(view.cache[slot]), direction[b]);
        }
        const float scale = sum * weights[row];
        glm::vec3 accumulated = g * scale;
        for (int entry = 0; entry < view.counts[row]; ++entry) {
            const int slot = row * 64 + entry, b = view.ids[view.neighbours[slot]];
            const glm::vec4 cached = view.cache[slot];
            const glm::vec3 viscous = cached.w * (direction[a] - direction[b]);
            accumulated = accumulated + viscous;
            kernel::atomic_add(product + b, scale * glm::vec3(cached) - viscous);
        }
        kernel::atomic_add(product + a, accumulated);
    } else {
        const Smoothing smoothing(view);
        NeighbourIterator first_pass(view, query);
        for (int j = first_pass.advance(); j >= 0; j = first_pass.advance()) {
            const int b = view.ids[j];
            if (j == query || b < 0) continue;
            const glm::vec3 difference = view.positions[query] - view.positions[j];
            const float distance2 = glm::dot(difference, difference);
            const float z = fmaxf(1.0f - distance2 / smoothing.h2, 0.0f);
            const glm::vec3 g = smoothing_gradient(smoothing, difference, z);
            sum -= glm::dot(g, direction[b]) * view.volumes[j];
        }
        const float scale = sum * weights[row];
        kernel::atomic_add(product + a, g * scale);
        NeighbourIterator second_pass(view, query);
        for (int j = second_pass.advance(); j >= 0; j = second_pass.advance()) {
            const int b = view.ids[j];
            if (j == query || b < 0) continue;
            const glm::vec3 difference = view.positions[query] - view.positions[j];
            const float distance2 = glm::dot(difference, difference);
            const float z = fmaxf(1.0f - distance2 / smoothing.h2, 0.0f);
            const glm::vec3 g = smoothing_gradient(smoothing, difference, z);
            kernel::atomic_add(product + b, g * -(scale * view.volumes[j]));
            if (view.viscosity > 0.0f && j > query) {
                const float viscosity = viscosity_scale(view, smoothing, query, j, difference, distance2, g);
                const glm::vec3 viscous = (direction[a] - direction[b]) * viscosity;
                kernel::atomic_add(product + a, viscous);
                kernel::atomic_add(product + b, -viscous);
            }
        }
    }
}

}  // namespace synreal::fluid_kernel
