// 机械还原自 PTX：synreal::kernel::apply_nonlinear_step(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: a71f6da867db9f2e2d06464b5bff9099f2eaf414a3b5f646d8d620386a1e1440
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__apply_nonlinear_step(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3) {
  int p0, p1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14;
  // PTX:20 ld.param.u64 %rd2, [_ZN7synreal6kernel20apply_nonlinear_stepEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPS4_S7_m_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:21 ld.param.u64 %rd3, [_ZN7synreal6kernel20apply_nonlinear_stepEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPS4_S7_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:22 ld.param.u64 %rd4, [_ZN7synreal6kernel20apply_nonlinear_stepEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPS4_S7_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:23 ld.param.u64 %rd5, [_ZN7synreal6kernel20apply_nonlinear_stepEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPS4_S7_m_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:24 mov.u32 %r1, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(blockIdx.x));
  // PTX:25 mov.u32 %r2, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockDim.x));
  // PTX:26 mul.wide.u32 %rd6, %r1, %r2
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd6) : "r"(r1), "r"(r2));
  // PTX:27 mov.u32 %r3, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(threadIdx.x));
  // PTX:28 cvt.u64.u32 %rd7, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd7) : "r"(r3));
  // PTX:29 add.s64 %rd1, %rd6, %rd7
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd6), "l"(rd7));
  // PTX:30 setp.ge.u64 %p1, %rd1, %rd5
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd5)));
  // PTX:31 @%p1 bra $L__BB63_2
  if (p1) { goto L_BB63_2; }
  // PTX:33 cvta.to.global.u64 %rd8, %rd2
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:34 mul.lo.s64 %rd9, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd9) : "l"(rd1));
  // PTX:35 add.s64 %rd10, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd8), "l"(rd9));
  // PTX:36 cvta.to.global.u64 %rd11, %rd4
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:37 add.s64 %rd12, %rd11, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd11), "l"(rd9));
  // PTX:38 ld.global.f32 %f1, [%rd12]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:39 ld.global.f32 %f2, [%rd10]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:40 add.f32 %f3, %f2, %f1
  asm("add.f32 %0, %1, %2;" : "=f"(f3) : "f"(f2), "f"(f1));
  // PTX:41 ld.global.f32 %f4, [%rd12+4]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:42 ld.global.f32 %f5, [%rd10+4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (4)))));
  // PTX:43 add.f32 %f6, %f5, %f4
  asm("add.f32 %0, %1, %2;" : "=f"(f6) : "f"(f5), "f"(f4));
  // PTX:44 ld.global.f32 %f7, [%rd12+8]
  f7 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:45 ld.global.f32 %f8, [%rd10+8]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (8)))));
  // PTX:46 add.f32 %f9, %f8, %f7
  asm("add.f32 %0, %1, %2;" : "=f"(f9) : "f"(f8), "f"(f7));
  // PTX:47 cvta.to.global.u64 %rd13, %rd3
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:48 add.s64 %rd14, %rd13, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd13), "l"(rd9));
  // PTX:49 st.global.f32 [%rd14], %f3
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0))))) = (float)(f3);
  // PTX:50 st.global.f32 [%rd14+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4))))) = (float)(f6);
  // PTX:51 st.global.f32 [%rd14+8], %f9
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8))))) = (float)(f9);
  // PTX:52 mov.u32 %r4, 0
  asm("mov.u32 %0, 0;" : "=r"(r4) : );
  // PTX:53 st.global.u32 [%rd12], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0))))) = (unsigned)(r4);
  // PTX:54 st.global.u32 [%rd12+4], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4))))) = (unsigned)(r4);
  // PTX:55 st.global.u32 [%rd12+8], %r4
  (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8))))) = (unsigned)(r4);
  // PTX:57 $L__BB63_2:
L_BB63_2:;
  // PTX:58 ret
  return;
}
