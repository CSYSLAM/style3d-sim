#include <cub/agent/single_pass_scan_operators.cuh>
#include <cub/util_type.cuh>
#include <cuda/std/functional>
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <iterator>
#include <new>
#include <type_traits>

#define CUDA_CALLABLE
#include "warp-strided-iterator-as-run.inc"

using Input = cub::detail::InputValue<int, int*>;
using Future = cub::FutureValue<int, int*>;
using Iterator = cub_strided_iterator<const int>;
using State = cub::ScanTileState<int, true>;

void print_bytes(const unsigned char* data, std::size_t size) {
    for (std::size_t index = 0; index < size; ++index) std::printf("%02x", data[index]);
}

int main() {
    static_assert(CUB_VERSION == 200802);
    static_assert(sizeof(void*) == 8 && sizeof(int) == 4);
    alignas(Input) unsigned char immediate[sizeof(Input)], future[sizeof(Input)];
    std::memset(immediate, 0xa5, sizeof(immediate));
    std::memset(future, 0xa5, sizeof(future));
    Input* value = new (immediate) Input(0x11223344);
    new (future) Input(Future(reinterpret_cast<int*>(0x1234567812345678ULL)));
    if (static_cast<int>(*value) != 0x11223344) return 1;
    std::printf("{\"CUB_VERSION\":%d,\"iterator\":{\"size\":%zu,\"ptr_offset\":%zu,\"stride_offset\":%zu},",
                CUB_VERSION, sizeof(Iterator), offsetof(Iterator, ptr), offsetof(Iterator, stride));
    std::printf("\"tile_state\":{\"size\":%zu,\"pointer_offset\":%zu},", sizeof(State),
                offsetof(State, d_tile_descriptors));
    std::printf("\"input_value\":{\"size\":%zu,\"alignment\":%zu,\"immediate\":\"", sizeof(Input), alignof(Input));
    print_bytes(immediate, sizeof(immediate));
    std::printf("\",\"future\":\"");
    print_bytes(future, sizeof(future));
    std::printf("\"},\"plus\":{\"size\":%zu,\"empty\":%s},\"null\":{\"size\":%zu,\"empty\":%s}}\n",
                sizeof(cuda::std::plus<void>), std::is_empty<cuda::std::plus<void>>::value ? "true" : "false",
                sizeof(cub::NullType), std::is_empty<cub::NullType>::value ? "true" : "false");
}
