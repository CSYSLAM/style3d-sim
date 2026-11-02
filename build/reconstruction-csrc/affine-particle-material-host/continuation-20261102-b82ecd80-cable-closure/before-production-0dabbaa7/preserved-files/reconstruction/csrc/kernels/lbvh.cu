// Linear BVH (Karras radix tree) construction kernels.
#include "types.cuh"

namespace synreal::kernel {

// Spreads the low 10 bits of v so that two zero bits follow each bit (Karras 2012).
__device__ __forceinline__ unsigned expand_bits(unsigned v)
{
    v = (v * 0x00010001u) & 0xFF0000FFu;
    v = (v * 0x00000101u) & 0x0F00F00Fu;
    v = (v * 0x00000011u) & 0xC30C30C3u;
    v = (v * 0x00000005u) & 0x49249249u;
    return v;
}

// 30-bit Morton code of a point in the unit cube; coordinates are clamped to [0, 1) first.
__device__ __forceinline__ unsigned morton_code(const glm::vec3& p)
{
    const float upper = 0.99999994f;  // largest float below 1, so 1024 * upper truncates to 1023
    const unsigned x = static_cast<unsigned>(glm::clamp(p.x, 0.0f, upper) * 1024.0f);
    const unsigned y = static_cast<unsigned>(glm::clamp(p.y, 0.0f, upper) * 1024.0f);
    const unsigned z = static_cast<unsigned>(glm::clamp(p.z, 0.0f, upper) * 1024.0f);
    return expand_bits(x) * 4 + expand_bits(y) * 2 + expand_bits(z);
}

// Morton code of each box centre normalised to the scene box; a flat scene axis maps to 0.5.
__global__ void generate_morton_codes(unsigned* codes, const Aabb* boxes, Aabb scene, unsigned count)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    const glm::vec3 center = (boxes[i].lower + boxes[i].upper) * 0.5f;
    const glm::vec3 extent = scene.upper - scene.lower;
    glm::vec3 unit(0.5f);
    if (extent.x > 0.0f) unit.x = (center.x - scene.lower.x) / extent.x;
    if (extent.y > 0.0f) unit.y = (center.y - scene.lower.y) / extent.y;
    if (extent.z > 0.0f) unit.z = (center.z - scene.lower.z) / extent.z;
    codes[i] = morton_code(unit);
}

// Bottom-up refit: each leaf copies its primitive box, then walks to the root; the second child to arrive at a
// node (atomic visit counter) merges both children. The fences publish the child boxes before the counter.
__global__ void refit_aabbs(Aabb* nodes, const Aabb* primitive_boxes, const int* sorted_primitive, const int* parent,
                            const glm::ivec2* children, unsigned* visits, unsigned count)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    const int leaf = i + count - 1;
    nodes[leaf] = primitive_boxes[sorted_primitive[i]];
    __threadfence();
    int node = parent[leaf];
    while (node >= 0) {
        if (atomicAdd(&visits[node], 1u) == 0) return;
        __threadfence();
        const Aabb& left = nodes[children[node].x];
        const Aabb& right = nodes[children[node].y];
        // fminf/fmaxf (PTX min/max.f32), not glm::min/max: they differ for NaN and signed zeros.
        const glm::vec3 lower(fminf(left.lower.x, right.lower.x), fminf(left.lower.y, right.lower.y),
                              fminf(left.lower.z, right.lower.z));
        const glm::vec3 upper(fmaxf(left.upper.x, right.upper.x), fmaxf(left.upper.y, right.upper.y),
                              fmaxf(left.upper.z, right.upper.z));
        nodes[node] = Aabb{lower, upper};
        __threadfence();
        node = parent[node];
    }
}

// Length of the common prefix of the Morton codes of sorted primitives i and j (Karras' delta); -1 when j is out
// of range. Duplicate codes are disambiguated by the index bits, so the result is 32 + clz(i ^ j).
__device__ __forceinline__ int common_prefix(const unsigned* codes, int count, int i, int j)
{
    if (j < 0 || j >= count) return -1;
    const unsigned difference = codes[i] ^ codes[j];
    if (difference == 0) return 32 + __clz(i ^ j);
    return __clz(difference);
}

// Karras (2012) binary radix tree over n sorted Morton codes: internal node i (< n - 1) finds its key range
// [first, last] and split; children are leaves (n - 1 + index) at the range ends.
__global__ void build_radix_tree(int* parent, glm::ivec2* children, const unsigned* codes, unsigned count)
{
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i + 1 >= count) return;
    const int n = count;
    const int direction = common_prefix(codes, n, i, i + 1) < common_prefix(codes, n, i, i - 1) ? -1 : 1;
    const int prefix_min = common_prefix(codes, n, i, i - direction);
    int length_max = 2;
    while (common_prefix(codes, n, i, i + length_max * direction) > prefix_min) length_max <<= 1;
    int length = 0;
    for (int t = length_max >> 1; t >= 1; t >>= 1)
        if (common_prefix(codes, n, i, i + (length + t) * direction) > prefix_min) length += t;
    const int other = i + length * direction;
    const int first = min(i, other);
    const int last = max(i, other);
    const int prefix_node = common_prefix(codes, n, first, last);
    int split = first;
    int step = last - first;
    do {
        step = (step + 1) >> 1;
        const int candidate = split + step;
        if (candidate < last && common_prefix(codes, n, first, candidate) > prefix_node) split = candidate;
    } while (step > 1);
    const int leaf_offset = n - 1;  // leaves follow the n - 1 internal nodes
    const int left = (split == first ? leaf_offset : 0) + split;
    const int right = (split + 1 == last ? n : 1) + split;
    children[i] = glm::ivec2(left, right);
    parent[right] = i;
    parent[left] = i;
}

// Leaves follow the n - 1 internal nodes; leaf_of_primitive maps an unsorted primitive to its leaf node.
__global__ void build_primitive_leaf_nodes(int* leaf_of_primitive, const int* sorted_primitive, unsigned count)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    const int primitive = sorted_primitive[i];
    leaf_of_primitive[primitive] = i + count - 1;
}

// Escape (skip) links for stackless traversal: climb while the node is its parent's right child, then continue
// at the right sibling; -1 once the root is passed.
__global__ void build_escape_nodes(int* escape, const int* parent, const glm::ivec2* children, unsigned count)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= count) return;
    int node = i;
    int up = parent[node];
    while (up >= 0 && children[up].y == node) {
        node = up;
        up = parent[node];
    }
    escape[i] = up < 0 ? -1 : children[up].y;
}

}  // namespace synreal::kernel
