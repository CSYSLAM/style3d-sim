#include "reduction_functors.cuh"
#include <cub/cub.cuh>
#include <thrust/device_ptr.h>
#include <thrust/iterator/transform_iterator.h>
#include <thrust/iterator/zip_iterator.h>
#include <thrust/system/cuda/detail/util.h>
#include <thrust/tuple.h>
#include <thrust/zip_function.h>

static_assert(CUB_VERSION == 200302 && THRUST_VERSION == 200302, "Match the legacy library source versions");
namespace pcg_functors = _GLOBAL__N__501f50b1_13_pcg_solver_cu_933d4eae;
namespace bvh_functors = _GLOBAL__N__17933b98_15_lbvh_builder_cu_f487594f;
using Sum = cuda::std::plus<void>;
using FloatPolicy = cub::DeviceReducePolicy<float, unsigned int, Sum>::Policy600;
template<class Offset>
using BoxPolicy = typename cub::DeviceReducePolicy<synreal::Aabb, Offset, bvh_functors::MergeAabbs>::Policy600;
template<class Second, class Operation>
using ProductIterator = thrust::transform_iterator<thrust::zip_function<Operation>,
    thrust::zip_iterator<thrust::tuple<const glm::vec3*, const Second*>>>;
using DotIterator = ProductIterator<glm::vec3, pcg_functors::Vec3InnerProduct>;
using ScalarIterator = ProductIterator<float, pcg_functors::PreconditionedResidualInnerProduct<float>>;
using BlockIterator = ProductIterator<glm::mat3, pcg_functors::PreconditionedResidualInnerProduct<glm::mat3>>;
using CentroidIterator = thrust::cuda_cub::transform_input_iterator_t<synreal::Aabb,
    thrust::device_ptr<const synreal::Aabb>, bvh_functors::PrimitiveCentroidAabb>;

// Explicit policies retain the original vector-load/striped-load reduction trees.
#define INSTANTIATE_FLOAT(Iterator) \
    template __global__ void cub::DeviceReduceKernel<FloatPolicy, Iterator, unsigned int, Sum, float>( \
        Iterator, float*, unsigned int, cub::GridEvenShare<unsigned int>, Sum); \
    template __global__ void cub::DeviceReduceSingleTileKernel< \
        FloatPolicy, Iterator, float*, unsigned int, Sum, float, float>(Iterator, float*, unsigned int, Sum, float)

INSTANTIATE_FLOAT(const float*);
INSTANTIATE_FLOAT(DotIterator);
INSTANTIATE_FLOAT(ScalarIterator);
INSTANTIATE_FLOAT(BlockIterator);
template __global__ void cub::DeviceReduceSingleTileKernel<
    FloatPolicy, float*, float*, int, Sum, float, float>(float*, float*, int, Sum, float);

#define INSTANTIATE_BOX(Offset) \
    template __global__ void cub::DeviceReduceKernel< \
        BoxPolicy<Offset>, CentroidIterator, Offset, bvh_functors::MergeAabbs, synreal::Aabb>( \
        CentroidIterator, synreal::Aabb*, Offset, cub::GridEvenShare<Offset>, bvh_functors::MergeAabbs); \
    template __global__ void cub::DeviceReduceSingleTileKernel< \
        BoxPolicy<Offset>, CentroidIterator, synreal::Aabb*, Offset, bvh_functors::MergeAabbs, synreal::Aabb, \
        synreal::Aabb>(CentroidIterator, synreal::Aabb*, Offset, bvh_functors::MergeAabbs, synreal::Aabb); \
    template __global__ void cub::DeviceReduceSingleTileKernel< \
        BoxPolicy<Offset>, synreal::Aabb*, synreal::Aabb*, int, bvh_functors::MergeAabbs, synreal::Aabb, \
        synreal::Aabb>(synreal::Aabb*, synreal::Aabb*, int, bvh_functors::MergeAabbs, synreal::Aabb)

INSTANTIATE_BOX(unsigned int);
INSTANTIATE_BOX(unsigned long long);

#undef INSTANTIATE_BOX
#undef INSTANTIATE_FLOAT
