// Data layouts shared between the solver host code and the kernels (names follow the mangled legacy symbols).
#pragma once

#include "common.cuh"

namespace synreal {

// Rigidity model of the affine bodies (Config.affine_body_rigidity_model).
enum class AffineBodyRigidityModel : int {
    CoRotated = 0,
    AbdOrthogonality = 1,
    SixSprings = 2,
    So3AugmentedLagrangian = 3,
};

// One scalar entry of the ELL-packed off-diagonal system matrix (the 3x3 block is value * I).
struct NonZeroEntry {
    int column;
    float value;
};

// One 3x3 block of the block-ELL off-diagonal system matrix.
struct BlockNonZeroEntry {
    int column;
    glm::mat3 value;
};

// Axis-aligned bounding box.
struct Aabb {
    glm::vec3 lower;
    glm::vec3 upper;
};

namespace kernel {

// Atomically adds a 3x3 block to entry (row, column) of the block-ELL matrix (slot-major: entries[slot * rows + row]).
// The row's first min(row_count[row], max_count) slots are sorted by column; a lower-bound search finds the slot and
// blocks whose column is not stored are dropped.
__device__ __forceinline__ void atomic_add_block(const int* row_count, BlockNonZeroEntry* entries, size_t max_count,
                                                 size_t rows, int row, int column, const glm::mat3& value)
{
    const size_t stored = row_count[row];
    const size_t count = stored < max_count ? stored : max_count;
    size_t lower = 0, upper = count;
    while (upper > lower) {
        const size_t middle = lower + ((upper - lower) >> 1);
        if (entries[middle * rows + row].column < column) lower = middle + 1;
        else upper = middle;
    }
    if (lower >= count || entries[lower * rows + row].column != column) return;
    atomic_add(&entries[lower * rows + row].value, value);
}

}  // namespace kernel

}  // namespace synreal
