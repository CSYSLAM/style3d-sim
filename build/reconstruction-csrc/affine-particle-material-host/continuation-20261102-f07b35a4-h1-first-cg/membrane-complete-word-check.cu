// Diagnostic only: compare every output and guard word, and retain the exact sparse actual values.
extern "C" __global__ void patch_words(unsigned* a, unsigned* b, unsigned n0, const unsigned* targets,
                                      const unsigned* values, unsigned n)
{
    unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        unsigned target = targets[i];
        if (target < n0) a[target] = values[i];
        else b[target - n0] = values[i];
    }
}

extern "C" __global__ void gather_words(const unsigned* a, const unsigned* b, unsigned n0,
                                       const unsigned* targets, unsigned* values, unsigned n)
{
    unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        unsigned target = targets[i];
        values[i] = target < n0 ? a[target] : b[target - n0];
    }
}

extern "C" __global__ void compare_words(const unsigned* a, const unsigned* b, const unsigned* expected_a,
                                        const unsigned* expected_b, unsigned n0, unsigned n1, unsigned* status)
{
    unsigned i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n0 + n1) {
        unsigned actual = i < n0 ? a[i] : b[i - n0];
        unsigned expected = i < n0 ? expected_a[i] : expected_b[i - n0];
        if (actual != expected) {
            atomicAdd(status, 1U);
            atomicMin(status + 1, i);
        }
    }
}
