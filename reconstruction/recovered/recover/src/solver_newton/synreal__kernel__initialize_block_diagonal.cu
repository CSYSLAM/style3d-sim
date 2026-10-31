// 机械还原自 PTX：synreal::kernel::initialize_block_diagonal(float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, glm::mat<3, 3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: 569e05a6eb0b7a7ca2fe8138c3e1c95e5e27bf80bebbfae1608fb033c778070b
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__initialize_block_diagonal(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3) {
  int p0, p1, p2;
  float f0, f1, f2;
  unsigned r0, r1, r2, r3;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16;
  // PTX:20 ld.param.u64 %rd2, [_ZN7synreal6kernel25initialize_block_diagonalEPKfPN3glm3matILi3ELi3EfLNS3_9qualifierE0EEES7_m_param_0]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:21 ld.param.u64 %rd3, [_ZN7synreal6kernel25initialize_block_diagonalEPKfPN3glm3matILi3ELi3EfLNS3_9qualifierE0EEES7_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:22 ld.param.u64 %rd4, [_ZN7synreal6kernel25initialize_block_diagonalEPKfPN3glm3matILi3ELi3EfLNS3_9qualifierE0EEES7_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:23 ld.param.u64 %rd5, [_ZN7synreal6kernel25initialize_block_diagonalEPKfPN3glm3matILi3ELi3EfLNS3_9qualifierE0EEES7_m_param_3]
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
  // PTX:31 @%p1 bra $L__BB50_3
  if (p1) { goto L_BB50_3; }
  // PTX:33 cvta.to.global.u64 %rd8, %rd2
  rd8 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:34 shl.b64 %rd9, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd9) : "l"(rd1));
  // PTX:35 add.s64 %rd10, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd10) : "l"(rd8), "l"(rd9));
  // PTX:36 ld.global.f32 %f1, [%rd10]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd10) + (0)))));
  // PTX:37 mul.f32 %f2, %f1, 0f00000000
  asm("mul.f32 %0, %1, 0f00000000;" : "=f"(f2) : "f"(f1));
  // PTX:38 cvta.to.global.u64 %rd11, %rd3
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:39 mul.lo.s64 %rd12, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd12) : "l"(rd1));
  // PTX:40 add.s64 %rd13, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd11), "l"(rd12));
  // PTX:41 st.global.f32 [%rd13], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0))))) = (float)(f1);
  // PTX:42 st.global.f32 [%rd13+4], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4))))) = (float)(f2);
  // PTX:43 st.global.f32 [%rd13+8], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8))))) = (float)(f2);
  // PTX:44 st.global.f32 [%rd13+12], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12))))) = (float)(f2);
  // PTX:45 st.global.f32 [%rd13+16], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (16))))) = (float)(f1);
  // PTX:46 st.global.f32 [%rd13+20], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (20))))) = (float)(f2);
  // PTX:47 st.global.f32 [%rd13+24], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (24))))) = (float)(f2);
  // PTX:48 st.global.f32 [%rd13+28], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (28))))) = (float)(f2);
  // PTX:49 st.global.f32 [%rd13+32], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (32))))) = (float)(f1);
  // PTX:50 setp.eq.s64 %p2, %rd4, 0
  p2 = (((long long)(rd4)) == ((long long)(0)));
  // PTX:51 @%p2 bra $L__BB50_3
  if (p2) { goto L_BB50_3; }
  // PTX:53 cvta.to.global.u64 %rd14, %rd4
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:54 add.s64 %rd16, %rd14, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd12));
  // PTX:55 st.global.f32 [%rd16], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0))))) = (float)(f1);
  // PTX:56 st.global.f32 [%rd16+4], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4))))) = (float)(f2);
  // PTX:57 st.global.f32 [%rd16+8], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8))))) = (float)(f2);
  // PTX:58 st.global.f32 [%rd16+12], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12))))) = (float)(f2);
  // PTX:59 st.global.f32 [%rd16+16], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (16))))) = (float)(f1);
  // PTX:60 st.global.f32 [%rd16+20], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (20))))) = (float)(f2);
  // PTX:61 st.global.f32 [%rd16+24], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (24))))) = (float)(f2);
  // PTX:62 st.global.f32 [%rd16+28], %f2
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (28))))) = (float)(f2);
  // PTX:63 st.global.f32 [%rd16+32], %f1
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (32))))) = (float)(f1);
  // PTX:65 $L__BB50_3:
L_BB50_3:;
  // PTX:66 ret
  return;
}
