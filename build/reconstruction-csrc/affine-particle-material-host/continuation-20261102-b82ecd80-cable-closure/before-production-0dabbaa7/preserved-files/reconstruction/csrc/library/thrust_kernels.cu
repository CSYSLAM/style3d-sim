#include "types.cuh"
#include <cub/cub.cuh>
#include <thrust/device_ptr.h>
#include <thrust/iterator/detail/normal_iterator.h>
#include <thrust/system/cuda/detail/fill.h>
#include <thrust/system/cuda/detail/tabulate.h>
#include <thrust/system/cuda/detail/uninitialized_fill.h>
#include <thrust/system/detail/generic/sequence.h>

static_assert(CUB_VERSION == 200302 && THRUST_VERSION == 200302, "Match the legacy CUDA library source versions");

// Instantiate the actual CUDA 12.4 library kernels, rather than reimplementing
// their launch ABI or retaining a binary/PTX implementation of fill and sequence.
template<class T>
using UninitializedFill = thrust::cuda_cub::__uninitialized_fill::functor<thrust::device_ptr<T>, T>;
template<class T>
using InitializedFill = thrust::cuda_cub::__fill::functor<
    thrust::detail::normal_iterator<thrust::device_ptr<T>>, T>;

#define INSTANTIATE_AGENT(Functor, Index) \
    template __global__ void thrust::cuda_cub::core::_kernel_agent< \
        thrust::cuda_cub::__parallel_for::ParallelForAgent<Functor, Index>, Functor, Index>(Functor, Index)

INSTANTIATE_AGENT(UninitializedFill<glm::mat3>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<glm::ivec2>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<glm::vec3>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<glm::ivec3>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<glm::vec4>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<synreal::NonZeroEntry>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<synreal::BlockNonZeroEntry>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<synreal::Aabb>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<float>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<unsigned char>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<int>, unsigned long);
INSTANTIATE_AGENT(UninitializedFill<unsigned int>, unsigned long);

#define INSTANTIATE_FILL(Type) \
    INSTANTIATE_AGENT(InitializedFill<Type>, long); \
    INSTANTIATE_AGENT(InitializedFill<Type>, unsigned long)
INSTANTIATE_FILL(glm::mat3);
INSTANTIATE_FILL(glm::ivec2);
INSTANTIATE_FILL(glm::vec3);
INSTANTIATE_FILL(float);
INSTANTIATE_FILL(int);

using Sequence = thrust::cuda_cub::__tabulate::functor<thrust::device_ptr<int>,
    thrust::system::detail::generic::detail::compute_sequence_value<int, void>, long>;
INSTANTIATE_AGENT(Sequence, long);

template __global__ void cub::EmptyKernel<void>();

#undef INSTANTIATE_FILL
#undef INSTANTIATE_AGENT
