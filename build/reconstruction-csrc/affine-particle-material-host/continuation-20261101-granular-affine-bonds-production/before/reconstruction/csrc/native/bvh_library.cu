// The host dispatch uses the same CUDA 12.4 CUB/Thrust headers as the restored library kernels.
// The independent build validates the device entries before the Solver build links this object.
#include "bvh_library.h"
#include "../library/reduction_functors.cuh"
#include <cfloat>
#include <cub/cub.cuh>
#include <thrust/device_ptr.h>
#include <thrust/fill.h>
#include <thrust/iterator/detail/normal_iterator.h>
#include <thrust/sequence.h>
#include <thrust/uninitialized_fill.h>
#include <thrust/system/cuda/detail/util.h>

static_assert(CUB_VERSION == 200302 && THRUST_VERSION == 200302, "Use the original CUDA 12.4 library version");
namespace bvh_functors = _GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f;

template <class T> static void initialize_cache(void* data, std::size_t count, const T& value)
{
    auto first = thrust::device_pointer_cast(static_cast<T*>(data));
    thrust::uninitialized_fill_n(thrust::cuda::par.on(cudaStreamLegacy), first, count, value);
}

extern "C" int source_cache_initialize(void* data, std::size_t count, SourceCacheType type)
{
    if (!count) return cudaSuccess;
    // Actual original captures contain zero value fields for these device-vector cache types.
    switch (type) {
    case SourceCacheType::Scalar: initialize_cache(data, count, 0.0f); break;
    case SourceCacheType::Vector3: initialize_cache(data, count, glm::vec3(0.0f)); break;
    case SourceCacheType::Matrix3: initialize_cache(data, count, glm::mat3(0.0f)); break;
    case SourceCacheType::BlockEntry: initialize_cache(data, count, synreal::BlockNonZeroEntry{0, glm::mat3(0.0f)}); break;
    case SourceCacheType::Integer: initialize_cache(data, count, int(0)); break;
    case SourceCacheType::Unsigned: initialize_cache(data, count, unsigned(0)); break;
    case SourceCacheType::Index2: initialize_cache(data, count, glm::ivec2(0)); break;
    case SourceCacheType::Box: initialize_cache(data, count, synreal::Aabb{glm::vec3(0.0f), glm::vec3(0.0f)}); break;
    case SourceCacheType::ScalarEntry: initialize_cache(data, count, synreal::NonZeroEntry{0, 0.0f}); break;
    case SourceCacheType::Index3: initialize_cache(data, count, glm::ivec3(0)); break;
    case SourceCacheType::Vector4: initialize_cache(data, count, glm::vec4(0.0f)); break;
    default: return cudaErrorInvalidValue;
    }
    return cudaGetLastError();
}

extern "C" int source_bvh_sequence_fill(int* sorted, int* parent, unsigned count, void* stream)
{
    if (!count) return cudaSuccess;
    auto policy = thrust::cuda::par.on(static_cast<cudaStream_t>(stream));
    auto first = thrust::device_pointer_cast(sorted);
    thrust::sequence(policy, first, first + static_cast<long>(count), 0);
    using Iterator = thrust::detail::normal_iterator<thrust::device_ptr<int>>;
    Iterator begin(thrust::device_pointer_cast(parent));
    thrust::fill(policy, begin, begin + (2 * static_cast<long>(count) - 1), -1);
    return cudaGetLastError();
}

extern "C" int source_bvh_reduce(void* temporary, std::size_t* bytes, const void* boxes, void* scene,
                                  unsigned count, void* stream)
{
    using Input = thrust::cuda_cub::transform_input_iterator_t<synreal::Aabb,
        thrust::device_ptr<const synreal::Aabb>, bvh_functors::PrimitiveCentroidAabb>;
    Input input(thrust::device_pointer_cast(static_cast<const synreal::Aabb*>(boxes)),
                bvh_functors::PrimitiveCentroidAabb{});
    // The original host .rodata uses finite +/-FLT_MAX, rather than infinities, for the empty scene box.
    synreal::Aabb initial{glm::vec3(FLT_MAX), glm::vec3(-FLT_MAX)};
    return cub::DeviceReduce::Reduce(temporary, *bytes, input, static_cast<synreal::Aabb*>(scene),
                                      static_cast<int>(count), bvh_functors::MergeAabbs{}, initial,
                                      static_cast<cudaStream_t>(stream));
}

extern "C" int source_bvh_sort(void* temporary, std::size_t* bytes, unsigned* keys, unsigned* alternate_keys,
                                int* values, int* alternate_values, unsigned count, int* selectors, void* stream)
{
    cub::DoubleBuffer<unsigned> key_buffers(keys, alternate_keys);
    cub::DoubleBuffer<int> value_buffers(values, alternate_values);
    auto error = cub::DeviceRadixSort::SortPairs(temporary, *bytes, key_buffers, value_buffers,
                                                 static_cast<int>(count), 0, 32, static_cast<cudaStream_t>(stream));
    selectors[0] = key_buffers.selector;
    selectors[1] = value_buffers.selector;
    return error;
}
