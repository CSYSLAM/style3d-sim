#pragma once
#include <cstddef>

enum class SourceCacheType { Scalar, Vector3, Matrix3, BlockEntry, Integer, Unsigned, Index2, Box, ScalarEntry, Index3, Vector4 };

// CUDA 12.4 library bridge; the independent build validates its embedded device entries.
extern "C" __attribute__((visibility("default"))) int source_cache_initialize(
    void* data, std::size_t count, SourceCacheType type);
extern "C" __attribute__((visibility("default"))) int source_bvh_sequence_fill(
    int* sorted, int* parent, unsigned count, void* stream);
extern "C" __attribute__((visibility("default"))) int source_bvh_reduce(
    void* temporary, std::size_t* bytes, const void* boxes, void* scene,
                                  unsigned count, void* stream);
extern "C" __attribute__((visibility("default"))) int source_bvh_sort(
    void* temporary, std::size_t* bytes, unsigned* keys, unsigned* alternate_keys,
                                int* values, int* alternate_values, unsigned count, int* selectors, void* stream);
