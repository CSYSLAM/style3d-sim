// 最小验证：把原始 PTX（sm_52）JIT 到当前 GPU，跑一遍看是否可用
#include <cuda.h>
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>

#define CK(x) do{ CUresult r=(x); if(r!=CUDA_SUCCESS){ const char* s; cuGetErrorString(r,&s); \
  printf("CUDA error %s at %s:%d\n", s, __FILE__, __LINE__); exit(1);} }while(0)

static std::string readf(const char* p){ std::ifstream f(p); std::stringstream ss; ss<<f.rdbuf(); return ss.str(); }

int main(int argc, char** argv){
    const char* ptx_path = argv[1];
    const char* fname    = argv[2];
    int n = 1024;

    CK(cuInit(0));
    CUdevice dev; CK(cuDeviceGet(&dev,0));
    CUcontext ctx; CK(cuCtxCreate(&ctx,0,dev));
    int cc_major=0, cc_minor=0;
    cuDeviceGetAttribute(&cc_major, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR, dev);
    cuDeviceGetAttribute(&cc_minor, CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR, dev);
    printf("device compute capability: %d.%d\n", cc_major, cc_minor);

    std::string src = readf(ptx_path);
    CUmodule mod; 
    CUresult r = cuModuleLoadDataEx(&mod, src.c_str(), 0, nullptr, nullptr);
    if (r != CUDA_SUCCESS) { const char* s; cuGetErrorString(r,&s); printf("PTX load failed: %s\n", s); return 1; }
    CUfunction fn; CK(cuModuleGetFunction(&fn, mod, fname));

    CUdeviceptr dout; CK(cuMemAlloc(&dout, n*sizeof(float)));
    float value = 2.5f;
    void* args[] = { &dout, &value, &n };
    CK(cuLaunchKernel(fn, (n+255)/256,1,1, 256,1,1, 0, nullptr, args, nullptr));
    CK(cuCtxSynchronize());

    std::vector<float> h(n); CK(cuMemcpyDtoH(h.data(), dout, n*sizeof(float)));
    printf("out[0..3] = %.3f %.3f %.3f %.3f  (期望 %.3f)\n", h[0],h[1],h[2],h[3], value);
    int bad=0; for(float x:h) if(x!=value) bad++;
    printf("%s\n", bad? "MISMATCH" : "OK: 全部等于 value");
    return 0;
}
