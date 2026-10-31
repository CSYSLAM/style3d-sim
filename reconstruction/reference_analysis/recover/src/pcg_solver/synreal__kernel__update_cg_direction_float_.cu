// 机械还原自 PTX：void synreal::kernel::update_cg_direction<float>(int, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: cf727e20f6f57ba690f8f67c07e8a24bb67829fd99e7e753d88fa4917be0371c
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_cg_direction_float_(unsigned param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19;
  // PTX:22 ld.param.u32 %r1, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_0]
  r1 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd3, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd4, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd5, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd6, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_4]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd7, [_ZN7synreal6kernel19update_cg_directionIfEEviPKT_PKN3glm3vecILi3EfLNS5_9qualifierE0EEEPKfPS8_m_param_5]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:28 mov.u32 %r2, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockIdx.x));
  // PTX:29 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:30 mul.wide.u32 %rd8, %r2, %r3
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd8) : "r"(r2), "r"(r3));
  // PTX:31 mov.u32 %r4, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(threadIdx.x));
  // PTX:32 cvt.u64.u32 %rd9, %r4
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd9) : "r"(r4));
  // PTX:33 add.s64 %rd1, %rd8, %rd9
  asm("add.s64 %0, %1, %2;" : "=l"(rd1) : "l"(rd8), "l"(rd9));
  // PTX:34 setp.ge.u64 %p1, %rd1, %rd7
  p1 = (((unsigned long long)(rd1)) >= ((unsigned long long)(rd7)));
  // PTX:35 @%p1 bra $L__BB3_7
  if (p1) { goto L_BB3_7; }
  // PTX:37 cvta.to.global.u64 %rd10, %rd3
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:38 shl.b64 %rd11, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd11) : "l"(rd1));
  // PTX:39 add.s64 %rd12, %rd10, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd10), "l"(rd11));
  // PTX:40 cvta.to.global.u64 %rd13, %rd4
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:41 mul.lo.s64 %rd14, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd14) : "l"(rd1));
  // PTX:42 add.s64 %rd15, %rd13, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd13), "l"(rd14));
  // PTX:43 ld.global.f32 %f14, [%rd15]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:44 ld.global.f32 %f15, [%rd12]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:45 mul.f32 %f27, %f15, %f14
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f15), "f"(f14));
  // PTX:46 ld.global.f32 %f16, [%rd15+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:47 mul.f32 %f28, %f15, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f15), "f"(f16));
  // PTX:48 ld.global.f32 %f17, [%rd15+8]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:49 mul.f32 %f29, %f15, %f17
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f15), "f"(f17));
  // PTX:50 cvta.to.global.u64 %rd16, %rd6
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:51 add.s64 %rd2, %rd16, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd16), "l"(rd14));
  // PTX:52 setp.gt.s32 %p2, %r1, 0
  p2 = (((int)(r1)) > ((int)(0)));
  // PTX:53 mov.f32 %f26, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f26) : );
  // PTX:54 @%p2 bra $L__BB3_2
  if (p2) { goto L_BB3_2; }
  // PTX:55 bra.uni $L__BB3_6
  goto L_BB3_6;
  // PTX:57 $L__BB3_2:
L_BB3_2:;
  // PTX:58 cvta.to.global.u64 %rd17, %rd5
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:59 mul.wide.s32 %rd18, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd18) : "r"(r1));
  // PTX:60 add.s64 %rd19, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd17), "l"(rd18));
  // PTX:61 ld.global.f32 %f4, [%rd19]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:62 ld.global.f32 %f5, [%rd19+-4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (-4)))));
  // PTX:63 abs.f32 %f19, %f5
  asm("abs.f32 %0, %1;" : "=f"(f19) : "f"(f5));
  // PTX:64 setp.leu.f32 %p3, %f19, 0f0DA24260
  p3 = ((isnan(((float)(f19))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f19)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:65 setp.gtu.f32 %p4, %f19, 0f7F800000
  p4 = ((isnan(((float)(f19))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f19)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:66 or.pred %p5, %p3, %p4
  p5 = ((p3) || (p4));
  // PTX:67 @%p5 bra $L__BB3_5
  if (p5) { goto L_BB3_5; }
  // PTX:69 abs.f32 %f21, %f4
  asm("abs.f32 %0, %1;" : "=f"(f21) : "f"(f4));
  // PTX:70 setp.gtu.f32 %p6, %f21, 0f7F800000
  p6 = ((isnan(((float)(f21))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f21)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:71 @%p6 bra $L__BB3_5
  if (p6) { goto L_BB3_5; }
  // PTX:73 div.rn.f32 %f26, %f4, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f26) : "f"(f4), "f"(f5));
  // PTX:75 $L__BB3_5:
L_BB3_5:;
  // PTX:76 ld.global.f32 %f22, [%rd2]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:77 ld.global.f32 %f23, [%rd2+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:78 ld.global.f32 %f24, [%rd2+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:79 fma.rn.f32 %f27, %f26, %f22, %f27
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f27) : "f"(f26), "f"(f22), "f"(f27));
  // PTX:80 fma.rn.f32 %f28, %f26, %f23, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f28) : "f"(f26), "f"(f23), "f"(f28));
  // PTX:81 fma.rn.f32 %f29, %f26, %f24, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f26), "f"(f24), "f"(f29));
  // PTX:83 $L__BB3_6:
L_BB3_6:;
  // PTX:84 st.global.f32 [%rd2], %f27
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (float)(f27);
  // PTX:85 st.global.f32 [%rd2+4], %f28
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4))))) = (float)(f28);
  // PTX:86 st.global.f32 [%rd2+8], %f29
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8))))) = (float)(f29);
  // PTX:88 $L__BB3_7:
L_BB3_7:;
  // PTX:89 ret
  return;
}
