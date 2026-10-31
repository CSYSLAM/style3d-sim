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
