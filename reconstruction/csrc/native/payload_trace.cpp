// Diagnostic host-to-device payload capture. Never linked into the source solver.
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <cinttypes>
#include <cstdio>
#include <cstdlib>
#include <filesystem>
#include <mutex>
#include <string>

static void* owner = nullptr;
static FILE* output = nullptr;
static std::string directory;
static std::mutex output_lock;
static unsigned long long sequence = 0;

static void* resolve(const char* name, bool runtime)
{
    void* result = runtime && owner ? dlsym(owner, name) : dlsym(RTLD_NEXT, name);
    if (!result && !runtime) {
        static void* driver = dlopen("libcuda.so.1", RTLD_NOW | RTLD_NOLOAD);
        if (driver) result = dlsym(driver, name);
    }
    if (!result) { std::fprintf(stderr, "payload_trace cannot resolve %s\n", name); std::abort(); }
    return result;
}

static void record(const char* api, std::uint64_t destination, const void* source, std::size_t bytes, int status)
{
    std::lock_guard<std::mutex> guard(output_lock);
    if (!output || !bytes) return;
    if (!source || bytes > 8*1024*1024) std::abort();
    const auto name = "copy-"+std::to_string(sequence)+".bin";
    FILE* file = std::fopen((directory+"/"+name).c_str(), "wb");
    if (!file || std::fwrite(source, 1, bytes, file) != bytes) std::abort();
    std::fclose(file);
    std::fprintf(output, "{\"seq\":%llu,\"api\":\"%s\",\"dst\":\"0x%" PRIx64
        "\",\"bytes\":%zu,\"status\":%d,\"file\":\"%s\"}\n",
        sequence++, api, destination, bytes, status, name.c_str());
    std::fflush(output);
}

extern "C" void solver_memory_trace_begin(const char* path, const char* owner_path)
{
    std::lock_guard<std::mutex> guard(output_lock);
    if (output) std::abort();
    owner = dlopen(owner_path, RTLD_NOW | RTLD_NOLOAD);
    if (!owner) std::abort();
    directory = path;
    std::filesystem::create_directories(directory);
    output = std::fopen((directory+"/memory.jsonl").c_str(), "w");
    if (!output) std::abort();
    std::fprintf(output, "{\"event\":\"begin_initialize\"}\n");
}

extern "C" void solver_memory_trace_mark(const char* label)
{
    std::lock_guard<std::mutex> guard(output_lock);
    if (output) { std::fprintf(output, "{\"event\":\"%s\"}\n", label); std::fflush(output); }
}

extern "C" void solver_memory_trace_end()
{
    std::lock_guard<std::mutex> guard(output_lock);
    if (output) { std::fprintf(output, "{\"event\":\"end\"}\n"); std::fclose(output); output = nullptr; }
}

extern "C" cudaError_t CUDARTAPI cudaMemcpy(void* dst, const void* src, std::size_t bytes, cudaMemcpyKind kind)
{
    const auto real = reinterpret_cast<decltype(&cudaMemcpy)>(resolve("cudaMemcpy", true));
    const auto status = real(dst, src, bytes, kind);
    if (kind == cudaMemcpyHostToDevice) record("cudaMemcpy", reinterpret_cast<std::uint64_t>(dst), src, bytes, status);
    return status;
}

extern "C" cudaError_t CUDARTAPI cudaMemcpyAsync(void* dst, const void* src, std::size_t bytes,
                                                 cudaMemcpyKind kind, cudaStream_t stream)
{
    const auto real = reinterpret_cast<decltype(&cudaMemcpyAsync)>(resolve("cudaMemcpyAsync", true));
    const auto status = real(dst, src, bytes, kind, stream);
    if (kind == cudaMemcpyHostToDevice)
        record("cudaMemcpyAsync", reinterpret_cast<std::uint64_t>(dst), src, bytes, status);
    return status;
}

extern "C" CUresult CUDAAPI cuMemcpyHtoD_v2(CUdeviceptr dst, const void* src, std::size_t bytes)
{
    const auto real = reinterpret_cast<decltype(&cuMemcpyHtoD_v2)>(resolve("cuMemcpyHtoD_v2", false));
    const auto status = real(dst, src, bytes);
    record("cuMemcpyHtoD_v2", dst, src, bytes, status);
    return status;
}
