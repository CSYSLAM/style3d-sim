// synreal::kernel::multiply_matrix_and_reduce<256u, BlockNonZeroEntry, mat3>(
//     const int* row_nnz, const BlockNonZeroEntry* entries, size_t max_nnz,
//     const mat3* diag, const vec3* p, const vec3* x, vec3* Ap,
//     float* out, size_t n, size_t tile)
// 原版 SASS: 436 条 | PTX 约 400 行（pcg 13/20）
//
// ⚠ A/B 未通过（见 validate/VALIDATION_REPORT.md「未解决项」）。可控输入探针：
//   diag=I,  param4=(1,0,0), param5=(0,2,0), entries=0 → PTX Ap=(1,2,0)
//   diag=2I, 同上                                      → PTX Ap=(2,2,0)
//   这两组数据与 "diag·p + x" 吻合（1,2,0）/（2,2,0），但按该假设改写后仍有
//   **向量 28 之后**全部不匹配（即使把稀疏项关掉也一样）——说明问题不在公式，
//   而在输出索引/边界（PTX 可能在某个边界后走了另一条写路径）。
//   本文件按 PTX 字面顺序保留，**不建议直接采信**。
// 与 multiply_matrix 同一套 tile 布局，两个差别：
//   1) 条目是**块**：{ int col; float m[9]; }，40 B（PTX 里 `mul ... 40` 就是它）；
//      Ap[i] += m · x[tileBase+col]（9 次 fma）
//   2) 多了内积归约：out[blockIdx.x] = Σ_i p[i]·Ap[i]（warp shuffle + shared，同其它 BlockReduce）
#include "vec3.h"
#include <cstddef>

struct BlockNonZeroEntry { int col; float m[9]; };   // 40 B
struct Mat3 { float m[9]; };

__global__ void multiply_matrix_and_reduce(
    const int* row_nnz, const BlockNonZeroEntry* entries, size_t max_nnz,
    const Mat3* diag, const Vec3* p, const Vec3* x, Vec3* Ap,
    float* out, size_t n, size_t tile)
{
    __shared__ float red[11];
    const size_t i = (size_t)blockIdx.x * blockDim.x + threadIdx.x;
    const int lane = threadIdx.x & 31;
    const int warp = threadIdx.x >> 5;

    float acc = 0.0f;
    if (i < n) {
        const size_t k = i % tile;
        const size_t tileBase = i - k;

        // 对角块：Ap = diag[i] · x[i]（PTX 字面顺序；A/B 显示实际行为更接近 diag·p + x，见文件头）
        const Mat3& D = diag[i];
        const Vec3  v = p[i];
        Vec3 r{ D.m[0]*v.x + D.m[3]*v.y + D.m[6]*v.z,
                D.m[1]*v.x + D.m[4]*v.y + D.m[7]*v.z,
                D.m[2]*v.x + D.m[5]*v.y + D.m[8]*v.z };

        int nnz = row_nnz[k];
        if (nnz < 0) nnz = 0;
        if ((size_t)nnz > max_nnz) nnz = (int)max_nnz;

        for (int e = 0; e < nnz; ++e) {
            const BlockNonZeroEntry en = entries[(size_t)e * tile + k];
            if (en.col < 0 || (size_t)en.col >= tile) continue;
            const size_t j = tileBase + (size_t)en.col;
            if (j >= n) continue;
            const Vec3 w = p[j];
            r.x += en.m[0]*w.x + en.m[3]*w.y + en.m[6]*w.z;
            r.y += en.m[1]*w.x + en.m[4]*w.y + en.m[7]*w.z;
            r.z += en.m[2]*w.x + en.m[5]*w.y + en.m[8]*w.z;
        }
        r.x += x[i].x; r.y += x[i].y; r.z += x[i].z;
        Ap[i] = r;
        acc = p[i].x * r.x + p[i].y * r.y + p[i].z * r.z;   // p·Ap
    }

    #pragma unroll
    for (int off = 16; off > 0; off >>= 1)
        acc += __shfl_down_sync(0xffffffffu, acc, off);
    if (lane == 0) red[2 + warp] = acc;
    __syncthreads();
    if (threadIdx.x == 0) {
        float s = acc;
        #pragma unroll
        for (int w = 1; w < 8; ++w) s += red[2 + w];
        out[blockIdx.x] = s;
    }
}
