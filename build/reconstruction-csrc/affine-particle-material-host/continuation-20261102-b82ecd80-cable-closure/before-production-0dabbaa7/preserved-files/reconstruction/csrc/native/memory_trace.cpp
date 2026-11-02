// Diagnostic allocation/copy tracing. Forward through the selected owner's runtime without changing buffer data.
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <cinttypes>
#include <cstdio>
#include <cstdlib>
#include <filesystem>
#include <mutex>

static FILE* output = nullptr;
static void* owner = nullptr;
static unsigned long long sequence = 0;
static thread_local bool inside = false;
static std::mutex lock;

static void* real_function(const char* name, bool runtime)
{
    void* result = runtime && owner ? dlsym(owner, name) : dlsym(RTLD_NEXT, name);
    if (!result && !runtime) {
        static void* driver = dlopen("libcuda.so.1", RTLD_NOW | RTLD_NOLOAD);
        if (driver) result = dlsym(driver, name);
    }
    if (!result) {
        std::fprintf(stderr, "memory_trace cannot resolve %s\n", name);
        std::abort();
    }
    return result;
}

class Event {
    bool previous_ = inside;
    bool enabled_ = output && !inside;
public:
    Event() { inside = true; }
    ~Event() { inside = previous_; }
    void record(const char* api, int status, std::uint64_t dst, std::uint64_t src,
                std::size_t bytes, int kind = -1, std::uint64_t stream = 0)
    {
        if (!enabled_) return;
        std::lock_guard<std::mutex> guard(lock);
        std::fprintf(output, "{\"seq\":%llu,\"api\":\"%s\",\"status\":%d,\"dst\":\"0x%" PRIx64
            "\",\"src\":\"0x%" PRIx64 "\",\"bytes\":%zu,\"kind\":%d,\"stream\":\"0x%" PRIx64 "\"}\n",
            sequence++, api, status, dst, src, bytes, kind, stream);
        std::fflush(output);
    }
};

extern "C" void solver_memory_trace_begin(const char* directory, const char* owner_path)
{
    std::lock_guard<std::mutex> guard(lock);
    owner = dlopen(owner_path, RTLD_NOW | RTLD_NOLOAD);
    if (!owner) { std::fprintf(stderr, "memory_trace owner is not loaded\n"); std::abort(); }
    if (!output) {
        std::filesystem::create_directories(directory);
        const auto path = std::filesystem::path(directory)/"memory.jsonl";
        output = std::fopen(path.c_str(), "w");
        if (!output) std::abort();
    }
    std::fprintf(output, "{\"event\":\"begin_initialize\"}\n");
    std::fflush(output);
}

extern "C" void solver_memory_trace_mark(const char* label)
{
    std::lock_guard<std::mutex> guard(lock);
    if (output) { std::fprintf(output, "{\"event\":\"%s\"}\n", label); std::fflush(output); }
}

extern "C" void solver_memory_trace_end()
{
    std::lock_guard<std::mutex> guard(lock);
    if (output) { std::fprintf(output, "{\"event\":\"end\"}\n"); std::fclose(output); output = nullptr; }
}

extern "C" cudaError_t CUDARTAPI cudaMalloc(void** pointer, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaMalloc)>(real_function("cudaMalloc", true));
    const auto status = real(pointer, bytes);
    event.record("cudaMalloc", status, status == cudaSuccess ? reinterpret_cast<std::uint64_t>(*pointer) : 0, 0, bytes);
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaFree(void* pointer)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaFree)>(real_function("cudaFree", true));
    const auto status = real(pointer);
    event.record("cudaFree", status, reinterpret_cast<std::uint64_t>(pointer), 0, 0);
    return status;
}

extern "C" CUresult CUDAAPI cuMemAlloc_v2(CUdeviceptr* pointer, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemAlloc_v2)>(real_function("cuMemAlloc_v2", false));
    const auto status = real(pointer, bytes);
    event.record("cuMemAlloc_v2", status, status == CUDA_SUCCESS ? *pointer : 0, 0, bytes);
    return status;
}

extern "C" CUresult CUDAAPI cuMemFree_v2(CUdeviceptr pointer)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemFree_v2)>(real_function("cuMemFree_v2", false));
    const auto status = real(pointer);
    event.record("cuMemFree_v2", status, pointer, 0, 0);
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaMemcpy(void* dst, const void* src, std::size_t bytes, cudaMemcpyKind kind)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaMemcpy)>(real_function("cudaMemcpy", true));
    const auto status = real(dst, src, bytes, kind);
    event.record("cudaMemcpy", status, reinterpret_cast<std::uint64_t>(dst), reinterpret_cast<std::uint64_t>(src),
                 bytes, kind);
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaMemcpyAsync(void* dst, const void* src, std::size_t bytes,
                                                cudaMemcpyKind kind, cudaStream_t stream)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaMemcpyAsync)>(real_function("cudaMemcpyAsync", true));
    const auto status = real(dst, src, bytes, kind, stream);
    event.record("cudaMemcpyAsync", status, reinterpret_cast<std::uint64_t>(dst), reinterpret_cast<std::uint64_t>(src),
                 bytes, kind, reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" CUresult CUDAAPI cuMemcpyDtoDAsync_v2(CUdeviceptr dst, CUdeviceptr src, std::size_t bytes, CUstream stream)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemcpyDtoDAsync_v2)>(real_function("cuMemcpyDtoDAsync_v2", false));
    const auto status = real(dst, src, bytes, stream);
    event.record("cuMemcpyDtoDAsync_v2", status, dst, src, bytes, 3, reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" CUresult CUDAAPI cuMemcpyHtoD_v2(CUdeviceptr dst, const void* src, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemcpyHtoD_v2)>(real_function("cuMemcpyHtoD_v2", false));
    const auto status = real(dst, src, bytes);
    event.record("cuMemcpyHtoD_v2", status, dst, reinterpret_cast<std::uint64_t>(src), bytes, 1);
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaMemsetAsync(void* dst, int value, std::size_t bytes, cudaStream_t stream)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cudaMemsetAsync)>(real_function("cudaMemsetAsync", true));
    const auto status = real(dst, value, bytes, stream);
    event.record("cudaMemsetAsync", status, reinterpret_cast<std::uint64_t>(dst), 0, bytes, value,
                 reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" CUresult CUDAAPI cuMemsetD8Async(CUdeviceptr dst, unsigned char value, std::size_t bytes, CUstream stream)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemsetD8Async)>(real_function("cuMemsetD8Async", false));
    const auto status = real(dst, value, bytes, stream);
    event.record("cuMemsetD8Async", status, dst, 0, bytes, value, reinterpret_cast<std::uint64_t>(stream));
    return status;
}

extern "C" CUresult CUDAAPI cuMemsetD8_v2(CUdeviceptr dst, unsigned char value, std::size_t bytes)
{
    Event event;
    auto real = reinterpret_cast<decltype(&cuMemsetD8_v2)>(real_function("cuMemsetD8_v2", false));
    const auto status = real(dst, value, bytes);
    event.record("cuMemsetD8_v2", status, dst, 0, bytes, value);
    return status;
}
