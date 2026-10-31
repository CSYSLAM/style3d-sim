// A/B 验证台：同一份输入，分别跑「原始 PTX（JIT）」与「重建 CUDA C（sm_120 cubin）」，逐字节比对所有输出缓冲。
#include <cuda.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <random>

#define CK(x) do{ CUresult r_=(x); if(r_!=CUDA_SUCCESS){ const char* s_; cuGetErrorString(r_,&s_); \
  fprintf(stderr,"CUDA error %s (%s:%d)\n", s_, __FILE__, __LINE__); exit(2);} }while(0)

static std::string slurp(const std::string& p){ std::ifstream f(p); std::stringstream ss; ss<<f.rdbuf(); return ss.str(); }

struct Param { char kind; size_t bytes; float f; long long i; int mode; int mod; };

int main(int argc, char** argv){
    if (argc < 2) { fprintf(stderr, "usage: %s spec.txt\n", argv[0]); return 1; }
    // ---- 解析 spec ----
    std::ifstream in(argv[1]);
    std::string ptx_path, cubin_path, name_ptx, name_cubin, label;
    int gx=1,gy=1,gz=1,bx=256,by=1,bz=1;
    std::vector<Param> params;
    std::string line;
    while (std::getline(in, line)) {
        if (line.empty() || line[0]=='#') continue;
        std::istringstream ls(line); std::string k; ls >> k;
        if (k=="ptx") ls >> ptx_path;
        else if (k=="cubin") ls >> cubin_path;
        else if (k=="name_ptx") ls >> name_ptx;
        else if (k=="name_cubin") ls >> name_cubin;
        else if (k=="label") { std::getline(ls, label); if(!label.empty()&&label[0]==' ') label.erase(0,1); }
        else if (k=="grid") ls >> gx >> gy >> gz;
        else if (k=="block") ls >> bx >> by >> bz;
        else if (k=="ptr") {
            std::string mode; Param p{'p',0,0,0,0,0};
            ls >> mode >> p.bytes;
            if (mode=="randf") p.mode=0;
            else if (mode=="idx") { p.mode=1; ls >> p.mod; }
            else if (mode=="zero") p.mode=2;
            else if (mode=="small") { p.mode=3; }
            else if (mode=="pair") { p.mode=4; ls >> p.mod; }
            else if (mode=="treeparent") { p.mode=5; }
            else if (mode=="idx64") { p.mode=7; ls >> p.mod; }
            else if (mode=="block40") { p.mode=8; ls >> p.mod; }
            else if (mode=="block40id") { p.mode=13; ls >> p.mod; }
            else if (mode=="ident3") { p.mode=9; }
            else if (mode=="ident3s") { p.mode=12; ls >> p.f; }
            else if (mode=="vec3c") { p.mode=10; ls >> p.f; ls >> p.i; ls >> p.mod; }
            else if (mode=="constf") { p.mode=11; ls >> p.f; }
            else if (mode=="treechildren") { p.mode=6; }
            params.push_back(p);
        }
        else if (k=="f32") { Param p{'f',4,0,0}; ls >> p.f; params.push_back(p); }
        else if (k=="u32") { Param p{'u',4,0,0}; ls >> p.i; params.push_back(p); }
        else if (k=="u64") { Param p{'U',8,0,0,0,0}; ls >> p.i; params.push_back(p); }
        else if (k=="byval") { Param p{'b',0,0,0,0,0}; ls >> p.bytes; params.push_back(p); }
        else if (k=="byvalptr") { Param p{'P',0,0,0,0,0}; ls >> p.bytes; params.push_back(p); }
        else if (k=="byvalcnt") { Param p{'C',0,0,0,0,0}; ls >> p.bytes >> p.mod; p.i=8; ls >> p.i; params.push_back(p); }
        else if (k=="view") { Param p{'V',0,0,0,0,0}; int np=0,nu=0,nf=0,cnt=64; ls >> p.bytes >> np >> nu >> nf >> cnt; p.i=np; p.mod=(nu<<8)|nf; p.mode=cnt; params.push_back(p); }
    }
    // ---- CUDA ----
    CK(cuInit(0));
    CUdevice dev; CK(cuDeviceGet(&dev,0));
    CUcontext ctx; CK(cuCtxCreate(&ctx,0,dev));
    CUmodule mA, mB; CUfunction fA, fB;
    CK(cuModuleLoadDataEx(&mA, slurp(ptx_path).c_str(), 0, nullptr, nullptr));
    CK(cuModuleGetFunction(&fA, mA, name_ptx.c_str()));
    CK(cuModuleLoad(&mB, cubin_path.c_str()));
    CK(cuModuleGetFunction(&fB, mB, name_cubin.c_str()));

    // ---- 缓冲（A/B 各一份，内容相同）----
    CUdeviceptr poolA, poolB;
    CK(cuMemAlloc(&poolA, 65536)); CK(cuMemAlloc(&poolB, 65536));
    CK(cuMemsetD8(poolA, 0, 65536)); CK(cuMemsetD8(poolB, 0, 65536));

    std::mt19937 rng(12345);
    std::uniform_real_distribution<float> dist(-2.0f, 2.0f);
    std::vector<CUdeviceptr> pA, pB; std::vector<size_t> sizes;
    std::vector<std::vector<char>> initHost;   // 初始内容，用于判断 kernel 是否真的写了
    for (auto& p : params) if (p.kind=='p') {
        CUdeviceptr a,b; CK(cuMemAlloc(&a,p.bytes)); CK(cuMemAlloc(&b,p.bytes));
        std::vector<char> h(p.bytes);
        if (p.mode==12) {  // scale * I
            for (size_t e=0; e+36<=p.bytes; e+=36) {
                float m[9]={p.f,0,0, 0,p.f,0, 0,0,p.f};
                memcpy(&h[e], m, 36);
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==9) {   // 3x3 单位阵（列主序）
            for (size_t e=0; e+36<=p.bytes; e+=36) {
                float m[9]={1,0,0, 0,1,0, 0,0,1};
                memcpy(&h[e], m, 36);
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==10) {  // 常量 vec3 (f, i, mod)
            for (size_t e=0; e+12<=p.bytes; e+=12) {
                float v[3]={p.f,(float)p.i,(float)p.mod};
                memcpy(&h[e], v, 12);
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==11) {  // 常量 float
            for (size_t e=0; e+4<=p.bytes; e+=4) { float v=p.f; memcpy(&h[e],&v,4); }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==13) {  // 40B 块：col=e%mod，矩阵为单位阵
            for (size_t e=0; e+40<=p.bytes; e+=40) {
                int col = p.mod? (int)((e/40)%p.mod) : (int)(e/40);
                memcpy(&h[e], &col, 4);
                float m[9]={1,0,0, 0,1,0, 0,0,1};
                memcpy(&h[e+4], m, 36);
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==8) {   // 40B 块条目：{int col; float m[9];}
            for (size_t e=0; e+40<=p.bytes; e+=40) {
                int col = p.mod? (int)((e/40)%p.mod) : (int)(e/40);
                memcpy(&h[e], &col, 4);
                for (int k=0;k<9;k++){ float v=dist(rng); memcpy(&h[e+4+4*k],&v,4); }
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        if (p.mode==7) {   // 正确的 u64 递增：每 8 字节一个元素
            for (size_t e=0; e+8<=p.bytes; e+=8) {
                unsigned long long v = p.mod? (e/8)%p.mod : (e/8);
                memcpy(&h[e], &v, 8);
            }
            CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
            pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
            continue;
        }
        for (size_t i=0;i+4<=p.bytes;i+=4){
            if (p.mode==0){ float v=dist(rng); memcpy(&h[i],&v,4); }
            else if (p.mode==1){ int v = p.mod? (int)((i/4)%p.mod) : (int)(i/4); memcpy(&h[i],&v,4); }
            else if (p.mode==2){ int v=0; memcpy(&h[i],&v,4); }
            else if (p.mode==3) { float v = 0.5f + 0.01f*(float)((i/4)%17); memcpy(&h[i],&v,4); }
            else if (p.mode==5) { /* 完全二叉树父链：parent[i]=(i-1)/2，根为 -1 */
                int v = (i/4==0)? -1 : (int)(((i/4)-1)/2); memcpy(&h[i],&v,4);
            }
            else if (p.mode==6) { /* children[p] = {2p+1, 2p+2}，越界给 -1 */
                size_t node=i/8; int slot=(i/4)%2;
                int c = (int)(2*node+1+slot);
                if (c >= (int)(p.bytes/8)) c = -1;
                memcpy(&h[i],&c,4);
            }
            else { /* mode4: 8B 一组 {int 小下标, float 随机} */
                size_t e=i/8;
                if ((i/4)%2==0){ int v = p.mod? (int)(e%p.mod) : (int)e; memcpy(&h[i],&v,4); }
                else { float v=dist(rng); memcpy(&h[i],&v,4); }
            }
        }
        CK(cuMemcpyHtoD(a,h.data(),p.bytes)); CK(cuMemcpyHtoD(b,h.data(),p.bytes));
        pA.push_back(a); pB.push_back(b); sizes.push_back(p.bytes); initHost.push_back(h);
    }
    // ---- 组装参数 ----
    auto build_args=[&](std::vector<CUdeviceptr>& ptrs, std::vector<void*>& hold, std::vector<void*>& args){
        size_t pi=0;
        for (auto& p : params){
            if (p.kind=='p'){ hold.push_back(&ptrs[pi]); args.push_back(hold.back()); pi++; }
            else if (p.kind=='f'){ void* m=calloc(1,8); memcpy(m,&p.f,4); hold.push_back(m); args.push_back(m); }
            else if (p.kind=='u'){ void* m=calloc(1,8); int v=(int)p.i; memcpy(m,&v,4); hold.push_back(m); args.push_back(m); }
            else if (p.kind=='B'){ void* m=calloc(1,8); unsigned char v=(unsigned char)p.i; memcpy(m,&v,1); hold.push_back(m); args.push_back(m); }
            else if (p.kind=='U'){ void* m=malloc(8); memcpy(m,&p.i,8); hold.push_back(m); args.push_back(m); }
            else if (p.kind=='P') {   // byval 的每个 8 字节槽填入 pool 指针
                void* m=calloc(1,p.bytes);
                for (size_t off=0; off+8<=p.bytes; off+=8) memcpy((char*)m+off, &poolA, 8);
                hold.push_back(m); args.push_back(m);
            }
            else if (p.kind=='C') {   // 指针填满 + 在指定偏移写小计数
                void* m=calloc(1,p.bytes);
                for (size_t off=0; off+8<=p.bytes; off+=8) memcpy((char*)m+off, &poolA, 8);
                int cv=p.mod; size_t at=(size_t)p.i;
                if (at+4<=p.bytes) memcpy((char*)m+at, &cv, 4);
                hold.push_back(m); args.push_back(m);
            }            else if (p.kind=='V') {
                void* m=calloc(1,p.bytes);
                int np=(int)p.i, nu=(p.mod>>8), nf=(p.mod&0xff);
                size_t off=0;
                for (int q=0;q<np && off+8<=(size_t)p.bytes;q++,off+=8) memcpy((char*)m+off,&poolA,8);
                int cv = p.mode? p.mode : 64;
                for (int q=0;q<nu && off+4<=(size_t)p.bytes;q++,off+=4){ memcpy((char*)m+off,&cv,4); }
                for (int q=0;q<nf && off+4<=(size_t)p.bytes;q++,off+=4){ float v=0.5f; memcpy((char*)m+off,&v,4); }
                hold.push_back(m); args.push_back(m);
            }
            else { void* m=calloc(1,p.bytes); hold.push_back(m); args.push_back(m); }
        }
    };
    std::vector<void*> hA,hB,argsA,argsB;
    build_args(pA,hA,argsA);
    // B 侧的 byvalptr 要指向 poolB：重新构造一次
    hB.clear(); argsB.clear();
    {
        size_t pi=0;
        for (auto& p : params){
            if (p.kind=='p'){ hB.push_back(&pB[pi]); argsB.push_back(hB.back()); pi++; }
            else if (p.kind=='f'){ void* m=calloc(1,8); memcpy(m,&p.f,4); hB.push_back(m); argsB.push_back(m); }
            else if (p.kind=='u'){ void* m=calloc(1,8); int v=(int)p.i; memcpy(m,&v,4); hB.push_back(m); argsB.push_back(m); }
            else if (p.kind=='B'){ void* m=calloc(1,8); unsigned char v=(unsigned char)p.i; memcpy(m,&v,1); hB.push_back(m); argsB.push_back(m); }
            else if (p.kind=='U'){ void* m=malloc(8); memcpy(m,&p.i,8); hB.push_back(m); argsB.push_back(m); }
            else if (p.kind=='P'){ void* m=calloc(1,p.bytes);
                for (size_t off=0; off+8<=p.bytes; off+=8) memcpy((char*)m+off, &poolB, 8);
                hB.push_back(m); argsB.push_back(m); }
            else if (p.kind=='C'){ void* m=calloc(1,p.bytes);
                for (size_t off=0; off+8<=p.bytes; off+=8) memcpy((char*)m+off, &poolB, 8);
                int cv=p.mod; size_t at=(size_t)p.i;
                if (at+4<=p.bytes) memcpy((char*)m+at, &cv, 4);
                hB.push_back(m); argsB.push_back(m); }            else if (p.kind=='V') {
                void* m=calloc(1,p.bytes);
                int np=(int)p.i, nu=(p.mod>>8), nf=(p.mod&0xff);
                size_t off=0;
                for (int q=0;q<np && off+8<=(size_t)p.bytes;q++,off+=8) memcpy((char*)m+off,&poolB,8);
                int cv = p.mode? p.mode : 64;
                for (int q=0;q<nu && off+4<=(size_t)p.bytes;q++,off+=4){ memcpy((char*)m+off,&cv,4); }
                for (int q=0;q<nf && off+4<=(size_t)p.bytes;q++,off+=4){ float v=0.5f; memcpy((char*)m+off,&v,4); }
                hB.push_back(m); argsB.push_back(m);
            }
            else { void* m=calloc(1,p.bytes); hB.push_back(m); argsB.push_back(m); }
        }
    }

    CK(cuLaunchKernel(fA, gx,gy,gz, bx,by,bz, 0, nullptr, argsA.data(), nullptr));
    CK(cuLaunchKernel(fB, gx,gy,gz, bx,by,bz, 0, nullptr, argsB.data(), nullptr));
    CK(cuCtxSynchronize());

    // ---- 比对 ----
    int badbuf=0, badbyte=0; size_t total=0; double gmaxrel=0, gmaxabs=0;
    for (size_t i=0;i<pA.size();++i){
        std::vector<char> a(sizes[i]), b(sizes[i]);
        CK(cuMemcpyDtoH(a.data(), pA[i], sizes[i]));
        CK(cuMemcpyDtoH(b.data(), pB[i], sizes[i]));
        int diff=0; size_t first=(size_t)-1;
        for (size_t k=0;k<sizes[i];++k) if (a[k]!=b[k]) { diff++; if(first==(size_t)-1) first=k; }
        total += sizes[i];
        if (diff) { badbuf++; badbyte+=diff;
            double maxabs=0, maxrel=0; int nf=0;
            for (size_t k=0;k+4<=sizes[i];k+=4){
                float x=*(float*)&a[k], y=*(float*)&b[k];
                double d=fabs((double)x-(double)y);
                if (d>0){ nf++; if(d>maxabs) maxabs=d;
                          double r=d/(fabs((double)x)+1e-12); if(r>maxrel) maxrel=r; }
            }
            if (maxrel>gmaxrel) gmaxrel=maxrel;
            if (maxabs>gmaxabs) gmaxabs=maxabs;
            printf("  buf%zu: %d/%zu 字节不同 | float 差异 %d 个, max|Δ|=%.3e, max rel=%.3e",
                   i, diff, sizes[i], nf, maxabs, maxrel);
            int shown=0;
            for (size_t k=0;k+4<=sizes[i];k+=4){
                float x=*(float*)&a[k], y=*(float*)&b[k];
                if (x!=y) {
                    if (!shown) printf(" | 首个 @elem%zu: PTX=%.6g mine=%.6g", k/4, x, y);
                    if (shown<40) printf(" [%zu:%.3g/%.3g]", k/4, x, y);
                    shown++;
                }
            }
            printf("\n"); }
    }
    // View 类 kernel 的输出落在 pool 里，也要比对
    {
        std::vector<char> a(65536), b(65536);
        CK(cuMemcpyDtoH(a.data(), poolA, 65536));
        CK(cuMemcpyDtoH(b.data(), poolB, 65536));
        int diff=0; size_t first=(size_t)-1;
        for (size_t k=0;k<65536;++k) if (a[k]!=b[k]) { diff++; if(first==(size_t)-1) first=k; }
        if (diff) {
            double maxabs=0;
            for (size_t k=0;k+4<=65536;k+=4){ double d=fabs((double)*(float*)&a[k]-(double)*(float*)&b[k]); if(d>maxabs) maxabs=d; }
            printf("  pool: %d/65536 字节不同 (首个 @%zu, max|Δ|=%.3e)\n", diff, first, maxabs);
            badbuf++; badbyte+=diff; total+=65536;
            if (maxabs>gmaxabs) gmaxabs=maxabs;
            if (maxabs>1e-3 && maxabs>gmaxrel) gmaxrel=maxabs;
        }
    }
    // 判断"是否真的写了"：与初始内容比对（对 initialize_* 这类写零的 kernel 也有效）
    size_t nz=0, nzt=0;
    for (size_t i=0;i<pA.size();++i){
        std::vector<char> a(sizes[i]);
        CK(cuMemcpyDtoH(a.data(), pA[i], sizes[i]));
        const std::vector<char>& h0 = initHost[i];
        for (size_t k=0;k<sizes[i];++k) { nzt++; if (a[k]!=h0[k]) nz++; }
    }
    // This legacy format has no output type schema. Only byte equality can
    // establish a pass; tolerance checks live in the typed Python suites.
    const char* verdict = badbyte ? "FAIL" : (nz ? "PASS" : "NO_CHANGE");
    printf("RESULT %s | 缓冲 %zu | 不同字节 %d/%zu | max rel=%.3e | 写入 %zu/%zu\n",
           verdict, pA.size(), badbyte, total, gmaxrel, nz, nzt);
    return badbuf? 1 : 0;
}
