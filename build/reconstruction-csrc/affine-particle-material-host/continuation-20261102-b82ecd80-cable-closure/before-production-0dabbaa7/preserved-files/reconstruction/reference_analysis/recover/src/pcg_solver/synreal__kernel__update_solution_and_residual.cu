// 机械还原自 PTX：synreal::kernel::update_solution_and_residual(int, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: c9e9544f6106b1465f54ade2bcac05f9510b501e32e8b32a99c3aab91e47204c
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_solution_and_residual(unsigned param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3, p4, p5;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24;
  // PTX:24 ld.param.u32 %r1, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_0]
  r1 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd2, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_1]
  rd2 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd3, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_2]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.u64 %rd4, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_3]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd5, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_4]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd6, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_5]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd7, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_6]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd8, [_ZN7synreal6kernel28update_solution_and_residualEiPKfS2_PKN3glm3vecILi3EfLNS3_9qualifierE0EEES8_PS6_S9_m_param_7]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 mov.u32 %r2, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockIdx.x));
  // PTX:33 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:34 mul.wide.u32 %rd9, %r2, %r3
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd9) : "r"(r2), "r"(r3));
  // PTX:35 mov.u32 %r4, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(threadIdx.x));
  // PTX:36 cvt.u64.u32 %rd10, %r4
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd10) : "r"(r4));
  // PTX:37 add.s64 %rd1, %rd9, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd9), "l"(rd10));
  // PTX:38 setp.ge.u64 %p1, %rd1, %rd8
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd8)));
  // PTX:39 mov.f32 %f31, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f31) : );
  // PTX:40 @%p1 bra $L__BB1_5
  if (p1) { goto L_BB1_5; }
  // PTX:42 cvta.to.global.u64 %rd11, %rd2
  rd11 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd2));
  // PTX:43 mul.wide.s32 %rd12, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd12) : "r"(r1));
  // PTX:44 add.s64 %rd13, %rd11, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd11), "l"(rd12));
  // PTX:45 ld.global.f32 %f1, [%rd13]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:46 cvta.to.global.u64 %rd14, %rd3
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:47 add.s64 %rd15, %rd14, %rd12
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd14), "l"(rd12));
  // PTX:48 ld.global.f32 %f2, [%rd15]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:49 abs.f32 %f6, %f2
  asm("abs.f32 %0, %1;" : "=f"(f6) : "f"(f2));
  // PTX:50 setp.leu.f32 %p2, %f6, 0f0DA24260
  p2 = ((isnan(((float)(f6))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f6)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:51 setp.gtu.f32 %p3, %f6, 0f7F800000
  p3 = ((isnan(((float)(f6))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f6)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:52 or.pred %p4, %p2, %p3
  p4 = ((p2) || (p3));
  // PTX:53 @%p4 bra $L__BB1_4
  if (p4) { goto L_BB1_4; }
  // PTX:55 abs.f32 %f8, %f1
  asm("abs.f32 %0, %1;" : "=f"(f8) : "f"(f1));
  // PTX:56 setp.gtu.f32 %p5, %f8, 0f7F800000
  p5 = ((isnan(((float)(f8))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f8)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:57 @%p5 bra $L__BB1_4
  if (p5) { goto L_BB1_4; }
  // PTX:59 div.rn.f32 %f31, %f1, %f2
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f31) : "f"(f1), "f"(f2));
  // PTX:61 $L__BB1_4:
L_BB1_4:;
  // PTX:62 cvta.to.global.u64 %rd16, %rd5
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:63 mul.lo.s64 %rd17, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd17) : "l"(rd1));
  // PTX:64 add.s64 %rd18, %rd16, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd16), "l"(rd17));
  // PTX:65 ld.global.f32 %f9, [%rd18]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:66 mul.f32 %f10, %f31, %f9
  asm("mul.f32 %0, %1, %2;" : "=f"(f10) : "f"(f31), "f"(f9));
  // PTX:67 ld.global.f32 %f11, [%rd18+4]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (4)))));
  // PTX:68 mul.f32 %f12, %f31, %f11
  asm("mul.f32 %0, %1, %2;" : "=f"(f12) : "f"(f31), "f"(f11));
  // PTX:69 ld.global.f32 %f13, [%rd18+8]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (8)))));
  // PTX:70 mul.f32 %f14, %f31, %f13
  asm("mul.f32 %0, %1, %2;" : "=f"(f14) : "f"(f31), "f"(f13));
  // PTX:71 cvta.to.global.u64 %rd19, %rd7
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:72 add.s64 %rd20, %rd19, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd19), "l"(rd17));
  // PTX:73 ld.global.f32 %f15, [%rd20]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0)))));
  // PTX:74 sub.f32 %f16, %f15, %f10
  asm("sub.f32 %0, %1, %2;" : "=f"(f16) : "f"(f15), "f"(f10));
  // PTX:75 ld.global.f32 %f17, [%rd20+4]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (4)))));
  // PTX:76 sub.f32 %f18, %f17, %f12
  asm("sub.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f12));
  // PTX:77 ld.global.f32 %f19, [%rd20+8]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (8)))));
  // PTX:78 sub.f32 %f20, %f19, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f19), "f"(f14));
  // PTX:79 st.global.f32 [%rd20], %f16
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (0))))) = (float)(f16);
  // PTX:80 st.global.f32 [%rd20+4], %f18
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (4))))) = (float)(f18);
  // PTX:81 st.global.f32 [%rd20+8], %f20
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd20) + (8))))) = (float)(f20);
  // PTX:82 cvta.to.global.u64 %rd21, %rd4
  rd21 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:83 add.s64 %rd22, %rd21, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd21), "l"(rd17));
  // PTX:84 ld.global.f32 %f21, [%rd22]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:85 ld.global.f32 %f22, [%rd22+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:86 ld.global.f32 %f23, [%rd22+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:87 cvta.to.global.u64 %rd23, %rd6
  rd23 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:88 add.s64 %rd24, %rd23, %rd17
  asm("add.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd23), "l"(rd17));
  // PTX:89 ld.global.f32 %f24, [%rd24]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0)))));
  // PTX:90 fma.rn.f32 %f25, %f31, %f21, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f31), "f"(f21), "f"(f24));
  // PTX:91 ld.global.f32 %f26, [%rd24+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4)))));
  // PTX:92 fma.rn.f32 %f27, %f31, %f22, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f31), "f"(f22), "f"(f26));
  // PTX:93 ld.global.f32 %f28, [%rd24+8]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8)))));
  // PTX:94 fma.rn.f32 %f29, %f31, %f23, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f31), "f"(f23), "f"(f28));
  // PTX:95 st.global.f32 [%rd24], %f25
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (0))))) = (float)(f25);
  // PTX:96 st.global.f32 [%rd24+4], %f27
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (4))))) = (float)(f27);
  // PTX:97 st.global.f32 [%rd24+8], %f29
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd24) + (8))))) = (float)(f29);
  // PTX:99 $L__BB1_5:
L_BB1_5:;
  // PTX:100 ret
  return;
}
