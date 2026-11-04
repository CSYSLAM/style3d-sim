// LD_PRELOAD audit for the compiled source solver: same-input replay of reference vs source kernels.
//
// For sampled cuLaunchKernel calls of the kernels listed in $AUDIT_SPEC, every device allocation reachable from the
// launch parameters (each 8-byte parameter word that cuMemGetAddressRange accepts) is saved, the reference kernel (same
// mangled name, JIT-loaded from the reference image's PTX) is run twice from that state, the state is restored, and the
// source kernel runs as it would have. The outputs are compared word by word; the source run's result is what the solver
// continues with, so the run itself is unchanged. Memory reached only through pointers stored in device memory is not
// saved; such kernels would show reference self-differences.
//
// $AUDIT_SPEC lines: <mangled name> <reference ptx path> <param size>,<param size>,...
// $AUDIT_LOG: output, one line per sampled launch. Launch indices 0, 1, 2, 5, 10, 20, 50, ... of each kernel are
// sampled (late-activating paths such as contacts are reached), at most $AUDIT_SAMPLES (default 12) per kernel.
#define _GNU_SOURCE
#include <cuda.h>
#include <dlfcn.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SPECS 256
#define MAX_PARAMS 64
#define MAX_ALLOCS 256
#define BYTE_CAP (512ull << 20)

typedef struct {
    char name[512];
    char ptx[1024];
    int count;
    size_t sizes[MAX_PARAMS];
    long launches, sampled;
    CUfunction reference;
} Spec;

typedef struct { CUdeviceptr base; size_t size; unsigned char *s0, *r1, *r2, *q, *q2; } Alloc;

static Spec specs[MAX_SPECS];
static int spec_count = -1, samples = 12;
static FILE *log_file;

static void *driver(const char *name) {
    void *f = dlsym(RTLD_NEXT, name);
    if (!f) {
        void *lib = dlopen("libcuda.so.1", RTLD_NOW | RTLD_GLOBAL);
        f = lib ? dlsym(lib, name) : NULL;
    }
    return f;
}

static CUresult (*real_launch)(CUfunction, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned, unsigned,
                               CUstream, void **, void **);
static CUresult (*get_name)(const char **, CUfunction);
static CUresult (*sync_ctx)(void);
static CUresult (*dtoh)(void *, CUdeviceptr, size_t);
static CUresult (*htod)(CUdeviceptr, const void *, size_t);
static CUresult (*range)(CUdeviceptr *, size_t *, CUdeviceptr);
static CUresult (*load_data)(CUmodule *, const void *);
static CUresult (*get_function)(CUfunction *, CUmodule, const char *);
static CUresult (*is_capturing)(CUstream, CUstreamCaptureStatus *);

static void load_specs(void) {
    spec_count = 0;
    const char *path = getenv("AUDIT_SPEC");
    if (getenv("AUDIT_SAMPLES")) samples = atoi(getenv("AUDIT_SAMPLES"));
    log_file = fopen(getenv("AUDIT_LOG") ? getenv("AUDIT_LOG") : "/dev/stderr", "a");
    FILE *f = path ? fopen(path, "r") : NULL;
    if (!f) return;
    char sizes[4096];
    while (spec_count < MAX_SPECS) {
        Spec *s = &specs[spec_count];
        if (fscanf(f, "%511s %1023s %4095s", s->name, s->ptx, sizes) != 3) break;
        for (char *tok = strtok(sizes, ","); tok && s->count < MAX_PARAMS; tok = strtok(NULL, ","))
            s->sizes[s->count++] = strtoull(tok, NULL, 10);
        spec_count++;
    }
    fclose(f);
    real_launch = driver("cuLaunchKernel");
    get_name = driver("cuFuncGetName");
    sync_ctx = driver("cuCtxSynchronize");
    dtoh = driver("cuMemcpyDtoH_v2");
    htod = driver("cuMemcpyHtoD_v2");
    range = driver("cuMemGetAddressRange_v2");
    load_data = driver("cuModuleLoadData");
    get_function = driver("cuModuleGetFunction");
    is_capturing = driver("cuStreamIsCapturing");
}

// One JIT module per reference PTX file, shared by all kernels from that file.
static CUmodule module_for(const char *ptx) {
    static char paths[16][1024];
    static CUmodule modules[16];
    static int n;
    for (int i = 0; i < n; i++)
        if (!strcmp(paths[i], ptx)) return modules[i];
    FILE *f = fopen(ptx, "rb");
    if (!f || n == 16) return NULL;
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    char *text = malloc(size + 1);
    text[fread(text, 1, size, f)] = 0;
    fclose(f);
    CUmodule m = NULL;
    CUresult r = load_data(&m, text);
    free(text);
    if (r != CUDA_SUCCESS) {
        fprintf(log_file, "MODULE-LOAD-FAILED %s %d\n", ptx, r);
        return NULL;
    }
    strcpy(paths[n], ptx);
    modules[n] = m;
    return modules[n++];
}

static int sampled_index(long i) {
    if (i < 3) return 1;
    while (i % 10 == 0) i /= 10;
    return i == 1 || i == 2 || i == 5;
}

static int collect(Spec *s, void **params, Alloc *allocs) {
    int n = 0;
    for (int p = 0; p < s->count; p++) {
        if (s->sizes[p] < 8) continue;
        const unsigned char *bytes = params[p];
        for (size_t off = 0; off + 8 <= s->sizes[p]; off += 8) {
            CUdeviceptr value, base;
            size_t size;
            memcpy(&value, bytes + off, 8);
            if (value < 0x10000 || range(&base, &size, value) != CUDA_SUCCESS) continue;
            int seen = 0;
            for (int i = 0; i < n; i++) seen |= allocs[i].base == base;
            if (!seen && n < MAX_ALLOCS) allocs[n++] = (Alloc){base, size, 0, 0, 0, 0, 0};
        }
    }
    return n;
}

static void save(Alloc *a, int n, int which) {
    sync_ctx();
    for (int i = 0; i < n; i++) {
        unsigned char **dst = which == 0 ? &a[i].s0 : which == 1 ? &a[i].r1 : which == 2 ? &a[i].r2
                            : which == 3 ? &a[i].q : &a[i].q2;
        if (!*dst) *dst = malloc(a[i].size);
        dtoh(*dst, a[i].base, a[i].size);
    }
}

static void restore(Alloc *a, int n) {
    sync_ctx();
    for (int i = 0; i < n; i++) htod(a[i].base, a[i].s0, a[i].size);
    sync_ctx();
}

typedef struct { unsigned long long n, big; double max; } Pair;

// Count differing words; size them against the allocation's largest magnitude (NaN/inf mismatch counts as big).
static void tally(Pair *p, float x, float y, double scale) {
    if (!memcmp(&x, &y, 4)) return;
    p->n++;
    double d = (isfinite(x) && isfinite(y)) ? fabs((double)x - (double)y) / (scale > 0 ? scale : 1.0) : INFINITY;
    p->big += d > 1e-5;
    p->max = fmax(p->max, d);
}

CUresult cuLaunchKernel(CUfunction f, unsigned gx, unsigned gy, unsigned gz, unsigned bx, unsigned by, unsigned bz,
                        unsigned shared, CUstream stream, void **params, void **extra) {
    if (spec_count < 0) load_specs();
    if (!real_launch) real_launch = driver("cuLaunchKernel");
    const char *name = NULL;
    Spec *s = NULL;
    if (spec_count > 0 && params && get_name && get_name(&name, f) == CUDA_SUCCESS)
        for (int i = 0; i < spec_count; i++)
            if (!strcmp(specs[i].name, name)) s = &specs[i];
    if (!s) return real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    // Launches recorded into a CUDA graph do not execute now; synchronising or copying would break the capture.
    CUstreamCaptureStatus capture = CU_STREAM_CAPTURE_STATUS_NONE;
    if (is_capturing && is_capturing(stream, &capture) == CUDA_SUCCESS && capture != CU_STREAM_CAPTURE_STATUS_NONE)
        return real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    long index = s->launches++;
    if (s->sampled >= samples || !sampled_index(index))
        return real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    if (!s->reference) {
        CUmodule m = module_for(s->ptx);
        if (!m || get_function(&s->reference, m, s->name) != CUDA_SUCCESS) {
            fprintf(log_file, "NO-REFERENCE %s\n", s->name);
            s->sampled = samples;
            return real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
        }
    }
    Alloc allocs[MAX_ALLOCS];
    int n = collect(s, params, allocs);
    unsigned long long total = 0;
    for (int i = 0; i < n; i++) total += allocs[i].size;
    if (total > BYTE_CAP) {
        fprintf(log_file, "SKIP-TOO-LARGE %s launch=%ld bytes=%llu\n", s->name, index, total);
        return real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    }
    s->sampled++;
    save(allocs, n, 0);
    CUresult r1 = real_launch(s->reference, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    save(allocs, n, 1);
    restore(allocs, n);
    CUresult r2 = real_launch(s->reference, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    save(allocs, n, 2);
    restore(allocs, n);
    CUresult rq = real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    save(allocs, n, 4);
    restore(allocs, n);
    // The run the solver continues with is a fresh source launch from the saved state.
    rq = real_launch(f, gx, gy, gz, bx, by, bz, shared, stream, params, extra);
    save(allocs, n, 3);
    // Pairs: reference vs reference (R1,R2), source vs source (Q1,Q2), reference vs source (R1,Q1). A difference is
    // "big" when it exceeds 1e-5 of the largest finite magnitude in its allocation (cancellation-safe scale).
    // DETDIFF: both images are deterministic here and still disagree, i.e. different arithmetic.
    Pair rr = {0}, qq = {0}, rq_pair = {0};
    unsigned long long changed = 0;
    for (int i = 0; i < n; i++) {
        size_t words = allocs[i].size / 4;
        const float *s0 = (const float *)allocs[i].s0, *a = (const float *)allocs[i].r1,
                    *b = (const float *)allocs[i].r2, *q = (const float *)allocs[i].q, *q2 = (const float *)allocs[i].q2;
        double scale = 0;
        for (size_t w = 0; w < words; w++)
            if (isfinite(a[w])) scale = fmax(scale, fabs(a[w]));
        for (size_t w = 0; w < words; w++) {
            changed += memcmp(s0 + w, a + w, 4) != 0 || memcmp(s0 + w, q + w, 4) != 0;
            tally(&rr, a[w], b[w], scale);
            tally(&qq, q[w], q2[w], scale);
            tally(&rq_pair, a[w], q[w], scale);
        }
        free(allocs[i].s0); free(allocs[i].r1); free(allocs[i].r2); free(allocs[i].q); free(allocs[i].q2);
    }
    unsigned long long self_big = rr.big > qq.big ? rr.big : qq.big, self_n = rr.n > qq.n ? rr.n : qq.n;
    double self_max = fmax(rr.max, qq.max);
    const char *verdict = !rq_pair.n ? "SAME"
                        : !rr.n && !qq.n ? "DETDIFF"
                        : rq_pair.big <= 2 * self_big + 2 && rq_pair.max <= 4 * self_max + 1e-6 ? "NOISE" : "DIFF";
    fprintf(log_file, "%s %s launch=%ld grid=%u block=%u allocs=%d bytes=%llu changed=%llu "
            "rr=%llu/%llu/%.2e qq=%llu/%llu/%.2e rq=%llu/%llu/%.2e status=%d,%d,%d\n",
            verdict, s->name, index, gx, bx, n, total, changed, rr.n, rr.big, rr.max, qq.n, qq.big, qq.max,
            rq_pair.n, rq_pair.big, rq_pair.max, r1, r2, rq);
    (void)self_n;
    fflush(log_file);
    return rq;
}
