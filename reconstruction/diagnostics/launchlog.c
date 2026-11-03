// Diagnostic LD_PRELOAD: log every cudaLaunchKernel (mangled symbol, grid, block) to $LAUNCHLOG, one line each.
// Unlike cudahook.c it needs no per-kernel argument layout, so it shows the complete launch order of a binary.
#define _GNU_SOURCE
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

cudaError_t cudaLaunchKernel(const void* func, dim3 grid, dim3 block, void** args, size_t shm, cudaStream_t s)
{
    static cudaError_t (*real)(const void*, dim3, dim3, void**, size_t, cudaStream_t) = NULL;
    Dl_info info;
    int found = dladdr(func, &info);
    if (!real) {
        real = dlsym(RTLD_NEXT, "cudaLaunchKernel");
        // The extension's CUDA runtime may be RTLD_LOCAL; resolve through the launching module then.
        if (!real && found && info.dli_fname) {
            void* owner = dlopen(info.dli_fname, RTLD_NOW | RTLD_NOLOAD);
            if (owner) real = dlsym(owner, "cudaLaunchKernel");
        }
    }
    const char* path = getenv("LAUNCHLOG");
    if (path) {
        FILE* f = fopen(path, "a");
        if (f) {
            fprintf(f, "%s grid=%u block=%u\n", found && info.dli_sname ? info.dli_sname : "?", grid.x, block.x);
            fclose(f);
        }
    }
    return real(func, grid, block, args, shm, s);
}

// ---- Driver-API launches (compiled source module) and host->device uploads of both builds ----
// libcuda is often dlopen'ed outside the global scope (Warp), so fall back to an explicit handle.
#include <cuda.h>
#include <stdint.h>
#include <string.h>

static void* driver_symbol(const char* name)
{
    void* f = dlsym(RTLD_NEXT, name);
    if (!f) {
        void* lib = dlopen("libcuda.so.1", RTLD_NOW | RTLD_NOLOAD);
        if (!lib) lib = dlopen("libcuda.so.1", RTLD_NOW);
        if (lib) f = dlsym(lib, name);
    }
    return f;
}

CUresult cuLaunchKernel(CUfunction f, unsigned gx, unsigned gy, unsigned gz, unsigned bx, unsigned by, unsigned bz,
                        unsigned shm, CUstream s, void** params, void** extra)
{
    static CUresult (*real)(CUfunction, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned,
                            CUstream, void**, void**) = NULL;
    static CUresult (*get_name)(const char**, CUfunction) = NULL;
    if (!real) real = driver_symbol("cuLaunchKernel");
    if (!get_name) get_name = driver_symbol("cuFuncGetName");
    const char* name = NULL;
    const char* path = getenv("LAUNCHLOG");
    if (path && get_name && get_name(&name, f) == CUDA_SUCCESS && name && strstr(name, "synreal")) {
        FILE* out = fopen(path, "a");
        if (out) { fprintf(out, "%s grid=%u block=%u\n", name, gx, bx); fclose(out); }
    }
    return real(f, gx, gy, gz, bx, by, bz, shm, s, params, extra);
}

// $UPLOADLOG: one line "bytes fnv64" per host->device upload, to compare host-built data as a multiset.
static void log_upload(const void* src, size_t bytes)
{
    const char* path = getenv("UPLOADLOG");
    if (!path || !src || !bytes) return;
    uint64_t h = 1469598103934665603ull;
    const unsigned char* p = (const unsigned char*)src;
    for (size_t i = 0; i < bytes; ++i) { h ^= p[i]; h *= 1099511628211ull; }
    FILE* out = fopen(path, "a");
    if (out) { fprintf(out, "%zu %016llx\n", bytes, (unsigned long long)h); fclose(out); }
}

static void* runtime_symbol(const char* name)
{
    void* f = dlsym(RTLD_NEXT, name);
    if (!f) {
        void* lib = dlopen("libcudart.so.12", RTLD_NOW | RTLD_NOLOAD);
        if (lib) f = dlsym(lib, name);
    }
    return f;
}

static int from_host(const void* src, enum cudaMemcpyKind kind)
{
    if (kind == cudaMemcpyHostToDevice) return 1;
    if (kind != cudaMemcpyDefault) return 0;
    struct cudaPointerAttributes a;
    cudaError_t (*attr)(struct cudaPointerAttributes*, const void*) = runtime_symbol("cudaPointerGetAttributes");
    if (!attr || attr(&a, src) != cudaSuccess) return 0;
    return a.type == cudaMemoryTypeHost || a.type == cudaMemoryTypeUnregistered;
}

cudaError_t cudaMemcpy(void* dst, const void* src, size_t count, enum cudaMemcpyKind kind)
{
    cudaError_t (*real)(void*, const void*, size_t, enum cudaMemcpyKind) = runtime_symbol("cudaMemcpy");
    if (from_host(src, kind)) log_upload(src, count);
    return real(dst, src, count, kind);
}

cudaError_t cudaMemcpyAsync(void* dst, const void* src, size_t count, enum cudaMemcpyKind kind, cudaStream_t s)
{
    cudaError_t (*real)(void*, const void*, size_t, enum cudaMemcpyKind, cudaStream_t) =
        runtime_symbol("cudaMemcpyAsync");
    if (from_host(src, kind)) log_upload(src, count);
    return real(dst, src, count, kind, s);
}

CUresult cuMemcpyHtoD_v2(CUdeviceptr dst, const void* src, size_t bytes)
{
    static CUresult (*real)(CUdeviceptr, const void*, size_t) = NULL;
    if (!real) real = driver_symbol("cuMemcpyHtoD_v2");
    log_upload(src, bytes);
    return real(dst, src, bytes);
}
