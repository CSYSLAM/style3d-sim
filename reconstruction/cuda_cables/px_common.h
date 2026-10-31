// PTX 还原代码的运行时辅助（无外部依赖）
#pragma once
#include <cstdint>
#include <cstring>
#include <cmath>

__device__ __forceinline__ float    as_f32(uint32_t u) { return __uint_as_float(u); }
__device__ __forceinline__ uint32_t as_u32(float f)    { return __float_as_uint(f); }
__device__ __forceinline__ float    as_f32(int32_t  u) { return __uint_as_float((uint32_t)u); }
__device__ __forceinline__ int32_t  as_i32(float f)    { return (int32_t)__float_as_uint(f); }

// 从"参数基址 + 字节偏移"取值：还原 PTX 的 ld.param / ld.global 语义
#define LD(T, base, off)   (*reinterpret_cast<T*>((uintptr_t)(base) + (off)))
#define ST(T, base, off)   (*reinterpret_cast<T*>((uintptr_t)(base) + (off)))
#define BASE(p)            ((uintptr_t)(p))

// 按值传入的 kernel 参数（struct）：只知道大小和对齐
template <int N, int A>
struct __align__(A) ByVal { unsigned char d[N]; };

__device__ __forceinline__ double as_f64(uint64_t u) { return __longlong_as_double((long long)u); }
