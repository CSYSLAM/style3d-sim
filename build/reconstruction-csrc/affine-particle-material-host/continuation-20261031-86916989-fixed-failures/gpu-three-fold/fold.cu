extern "C" __global__ void atomic_fold_three(const float* initial, const float* values,
                                             const int* orders, float* output, unsigned long long count)
{
    const unsigned long long i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i >= 6 * count) return;
    const unsigned long long element = i % count;
    const int permutation = static_cast<int>(i / count);
    output[i] = initial[element];
    for (int step = 0; step < 3; ++step) {
        const float value = values[static_cast<unsigned long long>(orders[3 * permutation + step]) * count + element];
        float previous;
        asm volatile("atom.global.add.f32 %0, [%1], %2;" : "=f"(previous) : "l"(output + i), "f"(value) : "memory");
    }
}
