// Diagnostic callbacks see runtime-private driver calls and kernel names without intercepting CUDA APIs.
#include <cupti.h>
#include <atomic>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <map>
#include <mutex>
#include <string>
#include <sstream>
#include <vector>

static FILE* output = nullptr;
static std::string directory;
static std::mutex output_lock;
static std::atomic<bool> active{false};
static CUpti_SubscriberHandle subscriber;
static unsigned long long sequence = 0;
static std::map<std::string, std::vector<std::size_t>> layouts;

static void checked(CUptiResult status)
{
    if (status != CUPTI_SUCCESS) {
        const char* text = nullptr;
        cuptiGetResultString(status, &text);
        std::fprintf(stderr, "CUPTI trace: %s\n", text ? text : "unknown error");
        std::abort();
    }
}

static void CUPTIAPI callback(void*, CUpti_CallbackDomain domain, CUpti_CallbackId id, const void* data)
{
    if (!active.load()) return;
    std::lock_guard<std::mutex> guard(output_lock);
    if (!output) return;
    if (domain == CUPTI_CB_DOMAIN_RUNTIME_API || domain == CUPTI_CB_DOMAIN_DRIVER_API) {
        const auto* api = static_cast<const CUpti_CallbackData*>(data);
        if (api->callbackSite != CUPTI_API_ENTER) return;
        // CUPTI defines symbolName only for kernel launch callbacks; other callback fields may be uninitialized.
        const bool kernel_launch = api->functionName && std::strstr(api->functionName, "LaunchKernel");
        const char* symbol = kernel_launch && api->symbolName ? api->symbolName : "";
        std::fprintf(output, "{\"seq\":%llu,\"api\":\"%s\",\"symbol\":\"%s\",\"domain\":%u,\"correlation\":%u",
            sequence++, api->functionName ? api->functionName : "", symbol,
            static_cast<unsigned>(domain), api->correlationId);
        const auto layout = layouts.find(symbol);
        void** arguments = nullptr;
        unsigned gx = 0, bx = 0;
        if (layout != layouts.end() && std::strcmp(api->functionName, "cudaLaunchKernel") == 0) {
            const auto* params = static_cast<const cudaLaunchKernel_v7000_params*>(api->functionParams);
            arguments = params->args; gx = params->gridDim.x; bx = params->blockDim.x;
        } else if (layout != layouts.end() && std::strcmp(api->functionName, "cuLaunchKernel") == 0) {
            const auto* params = static_cast<const cuLaunchKernel_params*>(api->functionParams);
            arguments = params->kernelParams; gx = params->gridDimX; bx = params->blockDimX;
        }
        if (arguments) {
            std::fprintf(output, ",\"grid_x\":%u,\"block_x\":%u,\"parameters\":[", gx, bx);
            for (std::size_t i = 0; i < layout->second.size(); ++i) {
                std::fprintf(output, "%s\"", i ? "," : "");
                const auto* bytes = static_cast<const unsigned char*>(arguments[i]);
                for (std::size_t j = 0; j < layout->second[i]; ++j) std::fprintf(output, "%02x", bytes[j]);
                std::fputc('"', output);
            }
            std::fputc(']', output);
        }
        std::fprintf(output, "}\n");
    } else if (domain == CUPTI_CB_DOMAIN_RESOURCE && id == CUPTI_CBID_RESOURCE_MODULE_LOADED) {
        const auto* resource = static_cast<const CUpti_ResourceData*>(data);
        const auto* module = static_cast<const CUpti_ModuleResourceData*>(resource->resourceDescriptor);
        if (module && module->pCubin && module->cubinSize) {
            const auto name = "module-"+std::to_string(module->moduleId)+".cubin";
            FILE* file = std::fopen((directory+"/"+name).c_str(), "wb");
            if (!file || std::fwrite(module->pCubin, 1, module->cubinSize, file) != module->cubinSize) std::abort();
            std::fclose(file);
            std::fprintf(output, "{\"seq\":%llu,\"event\":\"module_loaded\",\"file\":\"%s\",\"bytes\":%zu}\n",
                         sequence++, name.c_str(), module->cubinSize);
        }
    }
    std::fflush(output);
}

extern "C" void solver_memory_trace_begin(const char* path, const char*)
{
    if (active.load()) return;
    directory = path;
    std::filesystem::create_directories(directory);
    output = std::fopen((directory+"/memory.jsonl").c_str(), "w");
    if (!output) std::abort();
    std::fprintf(output, "{\"event\":\"begin_initialize\"}\n");
    if (const auto* path = std::getenv("CUPTI_KERNEL_LAYOUT_FILE")) {
        std::ifstream file(path);
        std::string line;
        while (std::getline(file, line)) {
            const auto split = line.find('\t');
            if (split == std::string::npos) std::abort();
            auto widths = line.substr(split+1);
            for (auto& ch : widths) if (ch == ',') ch = ' ';
            std::istringstream sizes(widths);
            std::size_t size;
            auto& target = layouts[line.substr(0, split)];
            while (sizes >> size) { if (!size || size > 4096) std::abort(); target.push_back(size); }
        }
    }
    active.store(true);
    checked(cuptiSubscribe(&subscriber, callback, nullptr));
    checked(cuptiEnableDomain(1, subscriber, CUPTI_CB_DOMAIN_RUNTIME_API));
    checked(cuptiEnableDomain(1, subscriber, CUPTI_CB_DOMAIN_DRIVER_API));
    if (std::getenv("CUPTI_TRACE_MODULES"))
        checked(cuptiEnableCallback(1, subscriber, CUPTI_CB_DOMAIN_RESOURCE, CUPTI_CBID_RESOURCE_MODULE_LOADED));
}

extern "C" void solver_memory_trace_mark(const char* label)
{
    std::lock_guard<std::mutex> guard(output_lock);
    if (output) { std::fprintf(output, "{\"event\":\"%s\"}\n", label); std::fflush(output); }
}

extern "C" void solver_memory_trace_end()
{
    active.store(false);
    checked(cuptiUnsubscribe(subscriber));
    std::lock_guard<std::mutex> guard(output_lock);
    if (output) { std::fprintf(output, "{\"event\":\"end\"}\n"); std::fclose(output); output = nullptr; }
}
