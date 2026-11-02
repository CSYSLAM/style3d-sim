// 机械还原自 PTX：synreal::kernel::update_velocity(float, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: 7387c62468b81bfc2b5ab669c1cf485d68ec62073bab233df04fb92877c84583
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_velocity(float param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13;
  unsigned r0, r1, r2, r3;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14;
  // PTX:21 ld.param.f32 %f1, [_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m_param_0]
  f1 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param0 + (0))));
  // PTX:22 ld.param.u64 %rd2, [_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m_param_1]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:23 ld.param.u64 %rd3, [_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m_param_2]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:24 ld.param.u64 %rd4, [_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m_param_3]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:25 ld.param.u64 %rd5, [_ZN7synreal6kernel15update_velocityEfPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PS4_m_param_4]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:26 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:27 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:28 mul.wide.u32 %rd6, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd6) : "r"(r1), "r"(r2));
  // PTX:29 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:30 cvt.u64.u32 %rd7, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd7) : "r"(r3));
  // PTX:31 add.s64 %rd1, %rd6, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd6), "l"(rd7));
  // PTX:32 setp.ge.u64 %p1, %rd1, %rd5
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd5)));
  // PTX:33 @%p1 bra $L__BB64_2
  if (p1) { goto L_BB64_2; }
  // PTX:35 cvta.to.global.u64 %rd8, %rd3
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:36 mul.lo.s64 %rd9, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd9) : "l"(rd1));
  // PTX:37 add.s64 %rd10, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd8), "l"(rd9));
  // PTX:38 cvta.to.global.u64 %rd11, %rd2
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:39 add.s64 %rd12, %rd11, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd11), "l"(rd9));
  // PTX:40 ld.global.f32 %f2, [%rd12]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:41 ld.global.f32 %f3, [%rd10]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:42 sub.f32 %f4, %f3, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f4) : "f"(f3), "f"(f2));
  // PTX:43 ld.global.f32 %f5, [%rd12+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:44 ld.global.f32 %f6, [%rd10+4]
  f6 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:45 sub.f32 %f7, %f6, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f6), "f"(f5));
  // PTX:46 ld.global.f32 %f8, [%rd12+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:47 ld.global.f32 %f9, [%rd10+8]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:48 sub.f32 %f10, %f9, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f10) : "f"(f9), "f"(f8));
  // PTX:49 mul.f32 %f11, %f4, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f11) : "f"(f4), "f"(f1));
  // PTX:50 mul.f32 %f12, %f7, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f7), "f"(f1));
  // PTX:51 mul.f32 %f13, %f10, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f13) : "f"(f10), "f"(f1));
  // PTX:52 cvta.to.global.u64 %rd13, %rd4
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:53 add.s64 %rd14, %rd13, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd13), "l"(rd9));
  // PTX:54 st.global.f32 [%rd14], %f11
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0))))) = (float)(f11);
  // PTX:55 st.global.f32 [%rd14+4], %f12
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4))))) = (float)(f12);
  // PTX:56 st.global.f32 [%rd14+8], %f13
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8))))) = (float)(f13);
  // PTX:58 $L__BB64_2:
L_BB64_2:;
  // PTX:59 ret
  return;
}
