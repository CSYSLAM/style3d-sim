// Keep the first observer immutable; add kernel boundaries and synchronous operations for full sequence diagnosis.
#include "memory_trace.cpp"

extern "C" cudaError_t CUDARTAPI cudaLaunchKernel(const void* function, dim3 grid, dim3 block, void** args,
                                                 std::size_t shared, cudaStream_t stream)
{
    Event event;
    // This observer is followed by the pinned launch observer in LD_PRELOAD, preserving its argument capture.
    auto next = reinterpret_cast<decltype(&cudaLaunchKernel)>(real_function("cudaLaunchKernel", false));
    Dl_info symbol{};
    dladdr(function, &symbol);
    const auto status = next(function, grid, block, args, shared, stream);
    event.record(symbol.dli_sname ? symbol.dli_sname : "unnamed_runtime_kernel", status,
                 reinterpret_cast<std::uint64_t>(function), 0, shared, -2, reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" CUresult CUDAAPI cuLaunchKernel(CUfunction function, unsigned gx, unsigned gy, unsigned gz,
    unsigned bx, unsigned by, unsigned bz, unsigned shared, CUstream stream, void** args, void** extra)
{
    Event event;
    using Name = CUresult (CUDAAPI*)(const char**, CUfunction);
    const auto get_name = reinterpret_cast<Name>(real_function("cuFuncGetName", false));
    const char* name = nullptr;
    get_name(&name, function);
    auto next = reinterpret_cast<decltype(&cuLaunchKernel)>(real_function("cuLaunchKernel", false));
    const auto status = next(function, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
    event.record(name ? name : "unnamed_driver_kernel", status,
                 reinterpret_cast<std::uint64_t>(function), 0, shared, -2, reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaMemset(void* dst, int value, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaMemset)>(real_function("cudaMemset", true));
    const auto status = real(dst, value, bytes);
    event.record("cudaMemset", status, reinterpret_cast<std::uint64_t>(dst), 0, bytes, value);
    return status;
}

extern "C" CUresult CUDAAPI cuMemcpyDtoD_v2(CUdeviceptr dst, CUdeviceptr src, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemcpyDtoD_v2)>(real_function("cuMemcpyDtoD_v2", false));
    const auto status = real(dst, src, bytes);
    event.record("cuMemcpyDtoD_v2", status, dst, src, bytes, 3);
    return status;
}
