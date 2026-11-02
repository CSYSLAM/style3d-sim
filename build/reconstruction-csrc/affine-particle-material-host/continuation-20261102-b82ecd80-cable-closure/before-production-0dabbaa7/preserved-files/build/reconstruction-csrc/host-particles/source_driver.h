#include <cuda.h>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <algorithm>
#include <cstdint>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

#include "source_ptx_bundle.h"

namespace py = pybind11;

static void check(CUresult result, const char* operation)
{
    if (result == CUDA_SUCCESS) return;
    const char *name = nullptr, *description = nullptr;
    cuGetErrorName(result, &name);
    cuGetErrorString(result, &description);
    throw std::runtime_error(std::string(operation) + ": " + (name ? name : "CUDA error") + " (" +
                             (description ? description : "unknown") + ")");
}

// Respect an existing Warp/test context and restore the caller's context on
// every operation. Retain the primary context when the caller has none current.
class ContextScope {
    bool pushed_ = false;
public:
    explicit ContextScope(CUcontext context)
    {
        CUcontext previous = nullptr;
        check(cuCtxGetCurrent(&previous), "cuCtxGetCurrent");
        if (previous != context) {
            check(cuCtxPushCurrent(context), "cuCtxPushCurrent");
            pushed_ = true;
        }
    }
    ~ContextScope()
    {
        if (pushed_) {
            CUcontext ignored = nullptr;
            cuCtxPopCurrent(&ignored);
        }
    }
};

class Driver {
    CUcontext context_ = nullptr;
    bool owns_primary_reference_ = false;
    CUdevice primary_device_ = 0;
    std::vector<CUmodule> modules_;
    std::unordered_map<std::string, CUfunction> functions_;
    std::unordered_map<std::uintptr_t, const KernelSpec*> specifications_;
    std::unordered_map<CUdeviceptr, std::size_t> allocations_;

    void check_range(CUdeviceptr pointer, std::size_t size) const
    {
        auto found = allocations_.find(pointer);
        if (found == allocations_.end() || size > found->second)
            throw std::invalid_argument("Device allocation is missing or too small");
    }

public:
    explicit Driver(int device = 0) : modules_(source_modules.size(), nullptr)
    {
        check(cuInit(0), "cuInit");
        check(cuCtxGetCurrent(&context_), "cuCtxGetCurrent");
        CUdevice requested;
        check(cuDeviceGet(&requested, device), "cuDeviceGet");
        if (context_) {
            CUdevice current;
            check(cuCtxGetDevice(&current), "cuCtxGetDevice");
            if (current != requested) throw std::invalid_argument("Current CUDA context uses a different device");
        } else {
            // Warp and the CUDA runtime use the primary context. A private new
            // context would not establish the intended ownership for their spans.
            check(cuDevicePrimaryCtxRetain(&context_, requested), "cuDevicePrimaryCtxRetain");
            owns_primary_reference_ = true;
            primary_device_ = requested;
        }
    }

    ~Driver()
    {
        // Interpreter shutdown can follow destruction of an externally owned
        // context. Never throw from cleanup; explicit free() reports failures.
        try {
            ContextScope scope(context_);
            for (const auto& item : allocations_) cuMemFree(item.first);
            for (auto module : modules_) if (module) cuModuleUnload(module);
        } catch (...) {}
        if (owns_primary_reference_) cuDevicePrimaryCtxRelease(primary_device_);
    }

    std::uintptr_t context() const { return reinterpret_cast<std::uintptr_t>(context_); }

    std::uint64_t allocate(std::size_t bytes)
    {
        ContextScope scope(context_);
        CUdeviceptr pointer;
        const auto size = std::max<std::size_t>(bytes, 1);
        check(cuMemAlloc(&pointer, size), "cuMemAlloc");
        allocations_[pointer] = size;
        return pointer;
    }

    std::uint64_t upload(py::bytes payload)
    {
        const auto bytes = payload.cast<std::string>();
        const auto pointer = allocate(bytes.size());
        ContextScope scope(context_);
        if (!bytes.empty()) check(cuMemcpyHtoD(pointer, bytes.data(), bytes.size()), "cuMemcpyHtoD");
        return pointer;
    }

    py::bytes download(std::uint64_t pointer, std::size_t size)
    {
        check_range(pointer, size);
        ContextScope scope(context_);
        std::string bytes(size, '\0');
        if (size) check(cuMemcpyDtoH(bytes.data(), pointer, size), "cuMemcpyDtoH");
        return py::bytes(bytes);
    }

    void release(std::uint64_t pointer)
    {
        check_range(pointer, 0);
        ContextScope scope(context_);
        check(cuMemFree(pointer), "cuMemFree");
        allocations_.erase(pointer);
    }

    std::uintptr_t function(const std::string& name)
    {
        auto loaded = functions_.find(name);
        if (loaded != functions_.end()) return reinterpret_cast<std::uintptr_t>(loaded->second);
        const auto spec = std::find_if(source_kernels.begin(), source_kernels.end(),
            [&](const KernelSpec& value) { return name == value.name; });
        if (spec == source_kernels.end()) throw std::invalid_argument("No compiled source kernel: " + name);
        ContextScope scope(context_);
        auto& module = modules_[spec->module];
        if (!module) check(cuModuleLoadData(&module, source_modules[spec->module].ptx), "cuModuleLoadData");
        CUfunction value;
        check(cuModuleGetFunction(&value, module, name.c_str()), "cuModuleGetFunction");
        functions_[name] = value;
        const auto token = reinterpret_cast<std::uintptr_t>(value);
        specifications_[token] = &*spec;
        return token;
    }

    void launch(std::uintptr_t token, unsigned int grid, unsigned int block, const std::vector<py::bytes>& args,
                std::uintptr_t stream = 0, unsigned int shared_bytes = 0)
    {
        const auto found = specifications_.find(token);
        if (found == specifications_.end()) throw std::invalid_argument("Unknown source kernel handle");
        const auto& expected = found->second->parameters;
        if (args.size() != expected.size()) throw std::invalid_argument("Kernel argument count does not match ABI");
        if (!grid || !block) throw std::invalid_argument("CUDA grid and block must be nonzero");
        std::vector<std::string> values;
        values.reserve(args.size());
        for (std::size_t i = 0; i < args.size(); ++i) {
            values.push_back(args[i].cast<std::string>());
            if (values.back().size() != expected[i])
                throw std::invalid_argument("Kernel argument byte size does not match ABI");
        }
        std::vector<void*> parameters;
        for (auto& value : values) parameters.push_back(value.data());
        ContextScope scope(context_);
        check(cuLaunchKernel(reinterpret_cast<CUfunction>(token), grid, 1, 1, block, 1, 1, shared_bytes,
            reinterpret_cast<CUstream>(stream), parameters.data(), nullptr), "cuLaunchKernel");
    }

    void synchronize()
    {
        ContextScope scope(context_);
        check(cuCtxSynchronize(), "cuCtxSynchronize");
    }
};

