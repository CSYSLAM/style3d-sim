// synreal::kernel::multiply_matrix<NonZeroEntry, float>(
//     const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
//     const float* diag, const vec3* x, const vec3* rhs, vec3* out,
//     size_t n, size_t tile)
// 原版 SASS: 352 条 | 还原依据: PTX 297 行（pcg 11/20）
//
// 关键还原点（参数映射已用 ld.param 的 _param_N 后缀坐实）：
//   param0 int*    → row_nnz[][]        （每行非零数，经 max(.,0)/min(.,max_nnz) 钳制）
//   param1 Entry*  → entries            （AoS { int col; float val; }，步长 8 B）
//   param2 size_t  → max_nnz
//   param3 float*  → diag               （逐行对角元，gid 索引）
//   param4 vec3*   → x
//   param5 vec3*   → rhs（可为 nullptr；非空时最后加到结果上）
//   param6 vec3*   → out
//   param7 size_t  → n（总行/列数）
//   param8 size_t  → tile（每块覆盖的行数，同时是列索引的上界）
//
// 数据布局：entries 按 [k][rowInTile] 存放（k 步长 = tile*8 字节）——转置成"行连续"，
// 让同一 warp 内相邻行访问相邻地址，这是 coalescing 的关键，也是 PTX 里
// entries + rowInTile*8、每次 += tile*8 的来源。
#include "vec3.h"
#include <cstddef>

struct NonZeroEntry { int col; float val; };   // <- AoS，8 B

__global__ void multiply_matrix(
    const int* row_nnz, const NonZeroEntry* entries, size_t max_nnz,
    const float* diag, const Vec3* x, const Vec3* rhs, Vec3* out,
    size_t n, size_t tile)
{
    const size_t gid = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    if (gid >= n) return;

    const size_t rowInTile = (tile ? gid % tile : gid);
    const size_t tileBase  = gid - rowInTile;      // tile 的起始全局列

    int nnz = max_nnz ? row_nnz[rowInTile] : 0;
    if (nnz < 0) nnz = 0;
    if ((size_t)nnz > max_nnz) nnz = (int)max_nnz;

    // 对角项先入账：acc = diag[gid] * x[gid]
    const float d = diag[gid];
    Vec3 acc{ d * x[gid].x, d * x[gid].y, d * x[gid].z };

    // 非对角项：entries[k*tile + rowInTile]
    for (int k = 0; k < nnz; ++k) {
        const NonZeroEntry e = entries[(size_t)k * tile + rowInTile];
        const int  col = e.col;
        if (col < 0 || (size_t)col >= tile) continue;   // 越界列直接跳过
        const size_t j = tileBase + (size_t)col;
        if (j >= n) continue;                            // 尾部 tile 的越界保护
        acc.x += e.val * x[j].x;
        acc.y += e.val * x[j].y;
        acc.z += e.val * x[j].z;
    }

    // 可选 rhs：PTX 里是 `setp.eq.s64 %p30, %rd36, 0` 空指针判断
    if (rhs != nullptr) {
        acc.x += rhs[gid].x;
        acc.y += rhs[gid].y;
        acc.z += rhs[gid].z;
    }

    out[gid] = acc;
}
