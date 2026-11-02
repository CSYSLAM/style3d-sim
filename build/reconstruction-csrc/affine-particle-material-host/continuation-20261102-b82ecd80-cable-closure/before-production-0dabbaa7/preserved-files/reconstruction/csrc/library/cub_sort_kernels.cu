#include <cub/cub.cuh>

static_assert(CUB_VERSION == 200302, "Match the legacy CUDA 12.4 CUB source");
using Key = unsigned int;
using Offset = unsigned int;
using Identity = cub::detail::identity_decomposer_t;
template<class Value>
using SortPolicy = typename cub::DeviceRadixSortPolicy<Key, Value, Offset>::Policy900;

// Preserve both policies' six/seven-bit sweep alternatives. Host dispatch will
// choose the same concrete instances; a newer default policy is not substituted.
#define INSTANTIATE_SWEEPS(Value, Alternate) \
    template __global__ void cub::DeviceRadixSortUpsweepKernel< \
        SortPolicy<Value>, Alternate, false, Key, Offset, Identity>( \
        const Key*, Offset*, Offset, int, int, cub::GridEvenShare<Offset>, Identity); \
    template __global__ void cub::DeviceRadixSortDownsweepKernel< \
        SortPolicy<Value>, Alternate, false, Key, Value, Offset, Identity>( \
        const Key*, Key*, const Value*, Value*, Offset*, Offset, int, int, cub::GridEvenShare<Offset>, Identity)

#define INSTANTIATE_SORT(Value) \
    INSTANTIATE_SWEEPS(Value, false); \
    INSTANTIATE_SWEEPS(Value, true); \
    template __global__ void cub::RadixSortScanBinsKernel<SortPolicy<Value>, Offset>(Offset*, int); \
    template __global__ void cub::DeviceRadixSortExclusiveSumKernel<SortPolicy<Value>, Offset>(Offset*); \
    template __global__ void cub::DeviceRadixSortSingleTileKernel< \
        SortPolicy<Value>, false, Key, Value, Offset, Identity>( \
        const Key*, Key*, const Value*, Value*, Offset, int, int, Identity); \
    template __global__ void cub::DeviceRadixSortHistogramKernel< \
        SortPolicy<Value>, false, Key, Offset, Identity>(Offset*, const Key*, Offset, int, int, Identity); \
    template __global__ void cub::DeviceRadixSortOnesweepKernel< \
        SortPolicy<Value>, false, Key, Value, Offset, int, int, Identity>( \
        int*, int*, Offset*, const Offset*, Key*, const Key*, Value*, const Value*, int, int, int, Identity)

INSTANTIATE_SORT(int);
INSTANTIATE_SORT(unsigned int);

#undef INSTANTIATE_SORT
#undef INSTANTIATE_SWEEPS
