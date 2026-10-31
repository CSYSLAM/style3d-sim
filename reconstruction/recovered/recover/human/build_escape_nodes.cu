// synreal::kernel::build_escape_nodes(int* escape, const int* parent,
//                                     const ivec2* children, unsigned n)
// 原版 SASS: 24 条 | PTX 59 行（lbvh_builder / self_collision）
//
// PTX 循环：node = i; p = parent[node];
//          while (p >= 0 && children[p].y == node) { node = p; p = parent[node]; }
//          escape[i] = (p < 0) ? -1 : children[p].y;
// 语义：沿父链爬升，直到当前节点不是右子（即它是左子，或已到根），
//       输出该父的右子索引作为"逃逸节点"（BVH 遍历用），根节点给 -1。
#include <cstddef>

struct IVec2 { int x, y; };

__global__ void build_escape_nodes(int* escape, const int* parent,
                                   const IVec2* children, unsigned n)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;

    int node = (int)i;
    int p = parent[node];
    while (p >= 0 && children[p].y == node) {
        node = p;
        p = parent[node];
    }
    escape[i] = (p < 0) ? -1 : children[p].y;
}
