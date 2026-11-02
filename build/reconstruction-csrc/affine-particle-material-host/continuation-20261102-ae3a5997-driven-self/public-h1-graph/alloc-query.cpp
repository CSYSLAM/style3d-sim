#include <cuda.h>
#include <cstdint>
#include <cstring>
#include <iomanip>
#include <sstream>

extern "C" int h1_allocation_node(std::uint64_t handle, int kind, char* output, std::size_t capacity) {
    const auto node = reinterpret_cast<CUgraphNode>(handle);
    std::ostringstream json;
    json << "{";
    if (kind == 10) {
        CUDA_MEM_ALLOC_NODE_PARAMS value{};
        const auto result = cuGraphMemAllocNodeGetParams(node, &value);
        if (result != CUDA_SUCCESS) return result;
        if (value.accessDescCount > 64 || (value.accessDescCount && !value.accessDescs)) return -10001;
        const auto& pool = value.poolProps;
        json << "\"pool.allocType\":" << pool.allocType << ",\"pool.handleTypes\":" << pool.handleTypes
             << ",\"pool.location.type\":" << pool.location.type << ",\"pool.location.id\":" << pool.location.id
             << ",\"pool.win32SecurityAttributes\":" << reinterpret_cast<std::uintptr_t>(pool.win32SecurityAttributes)
             << ",\"pool.maxSize\":" << pool.maxSize << ",\"pool.usage\":" << pool.usage
             << ",\"pool.reserved_hex\":\"";
        for (auto byte : pool.reserved) json << std::hex << std::setfill('0') << std::setw(2) << unsigned(byte);
        json << std::dec << "\",\"accessDescCount\":" << value.accessDescCount
             << ",\"bytesize\":" << value.bytesize << ",\"dptr\":" << value.dptr;
        for (std::size_t index = 0; index < value.accessDescCount; ++index) {
            const auto& access = value.accessDescs[index];
            json << ",\"access[" << index << "].location.type\":" << access.location.type
                 << ",\"access[" << index << "].location.id\":" << access.location.id
                 << ",\"access[" << index << "].flags\":" << access.flags;
        }
    } else if (kind == 11) {
        CUdeviceptr pointer = 0;
        const auto result = cuGraphMemFreeNodeGetParams(node, &pointer);
        if (result != CUDA_SUCCESS) return result;
        json << "\"dptr\":" << pointer;
    } else {
        return -10002;
    }
    json << "}";
    const auto text = json.str();
    if (text.size() + 1 > capacity) return -10003;
    std::memcpy(output, text.c_str(), text.size() + 1);
    return 0;
}
