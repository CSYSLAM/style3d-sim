// Diagnostic-only kernel substitution to distinguish source host scheduling from reconstructed PTX behavior.
// Never link this observer into the delivered solver or use its trajectories as source acceptance candidates.
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <dlfcn.h>
#include <cstdlib>
#include <fstream>
#include <map>
#include <stdexcept>
#include <string>

static void checked(CUresult code)
{
    if (code != CUDA_SUCCESS) throw std::runtime_error("CUDA failure in diagnostic PTX oracle");
}

extern "C" CUresult CUDAAPI cuLaunchKernel(CUfunction function, unsigned gx, unsigned gy, unsigned gz,
    unsigned bx, unsigned by, unsigned bz, unsigned shared, CUstream stream, void** args, void** extra)
{
    static auto next = reinterpret_cast<decltype(&cuLaunchKernel)>(dlsym(RTLD_NEXT, "cuLaunchKernel"));
    if (!next) throw std::runtime_error("Cannot resolve cuLaunchKernel in diagnostic oracle");
    static thread_local bool inside_runtime = false;
    if (inside_runtime) return next(function, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
    const char* raw_name = nullptr;
    checked(cuFuncGetName(&raw_name, function));
    const std::string name = raw_name ? raw_name : "";
    if (name.rfind("_ZN7synreal", 0) != 0)
        return next(function, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
    static const auto index = [] {
        const char* path = std::getenv("RECON_ORACLE_PTX_INDEX");
        if (!path) throw std::runtime_error("Missing diagnostic PTX index");
        std::ifstream file(path);
        if (!file) throw std::runtime_error("Cannot read diagnostic PTX index");
        std::map<std::string, std::string> result;
        std::string line;
        while (std::getline(file, line)) {
            const auto tab = line.find('\t');
            if (tab == std::string::npos) throw std::runtime_error("Invalid diagnostic PTX index");
            result.emplace(line.substr(0, tab), line.substr(tab + 1));
        }
        return result;
    }();
    const auto wanted = index.find(name);
    if (wanted == index.end())
        return next(function, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
    if (const char* path = std::getenv("RECON_ORACLE_RUNTIME")) {
        static void* sdk = dlopen(path, RTLD_NOW | RTLD_LOCAL);
        if (!sdk) throw std::runtime_error("Cannot load diagnostic original SDK runtime");
        using RuntimeLaunch = cudaError_t (*)(const void*, dim3, dim3, void**, size_t, cudaStream_t);
        static auto runtime = reinterpret_cast<RuntimeLaunch>(dlsym(sdk, "cudaLaunchKernel"));
        static std::map<std::string, void*> stubs;
        auto found = stubs.find(name);
        if (found == stubs.end()) {
            void* stub = dlsym(sdk, name.c_str());
            if (!stub || !runtime) throw std::runtime_error("Missing original SDK kernel entry");
            found = stubs.emplace(name, stub).first;
            const char* log_path = std::getenv("RECON_ORACLE_PTX_LOG");
            if (!log_path) throw std::runtime_error("Missing runtime oracle provenance log");
            std::ofstream log(log_path, std::ios::app);
            log << name << "\tSDK_RUNTIME:" << path << '\n';
        }
        // Reentrant launches from cudart must reach the real driver, never substitute themselves again.
        inside_runtime = true;
        const auto status = runtime(found->second, dim3(gx, gy, gz), dim3(bx, by, bz), args, shared,
                                    reinterpret_cast<cudaStream_t>(stream));
        inside_runtime = false;
        if (status != cudaSuccess) throw std::runtime_error("Original SDK runtime oracle launch failed");
        return CUDA_SUCCESS;
    }
    CUcontext context = nullptr;
    checked(cuCtxGetCurrent(&context));
    // Function handles can be recycled when scene-owned source modules unload. Cache by context and name instead.
    static std::map<std::pair<CUcontext, std::string>, CUmodule> modules;
    static std::map<std::pair<CUcontext, std::string>, CUfunction> functions;
    const auto key = std::make_pair(context, name);
    auto found = functions.find(key);
    if (found == functions.end()) {
        const auto module_key = std::make_pair(context, wanted->second);
        auto module = modules.find(module_key);
        if (module == modules.end()) {
            std::ifstream file(wanted->second);
            std::string ptx((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
            if (ptx.empty()) throw std::runtime_error("Empty diagnostic PTX module");
            CUmodule loaded = nullptr;
            checked(cuModuleLoadData(&loaded, ptx.c_str()));
            module = modules.emplace(module_key, loaded).first;
        }
        CUfunction replacement = nullptr;
        checked(cuModuleGetFunction(&replacement, module->second, name.c_str()));
        found = functions.emplace(key, replacement).first;
        const char* path = std::getenv("RECON_ORACLE_PTX_LOG");
        if (!path) throw std::runtime_error("Missing diagnostic provenance log");
        std::ofstream log(path, std::ios::app);
        log << name << '\t' << wanted->second << '\n';
    }
    return next(found->second, gx, gy, gz, bx, by, bz, shared, stream, args, extra);
}
