// synreal::kernel::build_primitive_leaf_nodes(int* out, const int* prim_ids, unsigned n)
// 原版 SASS: 16 条 | PTX 40 行（lbvh/self_collision）
//
// PTX：r6 = i + n; r7 = r6 - 1; out[ prim_ids[i] ] = r7
// 语义：把第 i 个图元映射到二叉树第 (n-1+i) 个节点 —— 内部节点占 [0,n-2]，叶子占 [n-1,2n-2]。
__global__ void build_primitive_leaf_nodes(int* out, const int* prim_ids, unsigned n)
{
    const unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= n) return;
    out[prim_ids[i]] = (int)(i + n - 1);
}
