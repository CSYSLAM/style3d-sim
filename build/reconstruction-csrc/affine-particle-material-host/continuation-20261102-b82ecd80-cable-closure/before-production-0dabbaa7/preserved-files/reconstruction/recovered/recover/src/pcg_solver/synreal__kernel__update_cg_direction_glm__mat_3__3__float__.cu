// 机械还原自 PTX：void synreal::kernel::update_cg_direction<glm::mat<3, 3, float, (glm::qualifier)0> >(int, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0>*, unsigned long)
// PTX SHA256: 36e96cc484d70f26e3b72669bb2beb8db27aa32354b563cfd6f840900416f757
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_cg_direction_glm__mat_3__3__float__(unsigned param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43;
  unsigned r0, r1, r2, r3, r4;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19;
  // PTX:22 ld.param.u32 %r1, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_0]
  r1 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (0))));
  // PTX:23 ld.param.u64 %rd3, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:24 ld.param.u64 %rd4, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:25 ld.param.u64 %rd5, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:26 ld.param.u64 %rd6, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_4]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:27 ld.param.u64 %rd7, [_ZN7synreal6kernel19update_cg_directionIN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKT_PKNS2_3vecILi3EfLS4_0EEEPKfPSA_m_param_5]
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
  // PTX:35 @%p1 bra $L__BB7_7
  if (p1) { goto L_BB7_7; }
  // PTX:37 cvta.to.global.u64 %rd10, %rd4
  rd10 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:38 mul.lo.s64 %rd11, %rd1, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd11) : "l"(rd1));
  // PTX:39 add.s64 %rd12, %rd10, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd10), "l"(rd11));
  // PTX:40 cvta.to.global.u64 %rd13, %rd3
  rd13 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:41 mul.lo.s64 %rd14, %rd1, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd14) : "l"(rd1));
  // PTX:42 add.s64 %rd15, %rd13, %rd14
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd13), "l"(rd14));
  // PTX:43 ld.global.f32 %f14, [%rd12]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))));
  // PTX:44 ld.global.f32 %f15, [%rd15]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:45 ld.global.f32 %f16, [%rd12+4]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (4)))));
  // PTX:46 ld.global.f32 %f17, [%rd15+12]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:47 mul.f32 %f18, %f17, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f18) : "f"(f17), "f"(f16));
  // PTX:48 fma.rn.f32 %f19, %f15, %f14, %f18
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f19) : "f"(f15), "f"(f14), "f"(f18));
  // PTX:49 ld.global.f32 %f20, [%rd12+8]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (8)))));
  // PTX:50 ld.global.f32 %f21, [%rd15+24]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (24)))));
  // PTX:51 fma.rn.f32 %f41, %f21, %f20, %f19
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f21), "f"(f20), "f"(f19));
  // PTX:52 ld.global.f32 %f22, [%rd15+4]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:53 ld.global.f32 %f23, [%rd15+16]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (16)))));
  // PTX:54 mul.f32 %f24, %f23, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f23), "f"(f16));
  // PTX:55 fma.rn.f32 %f25, %f22, %f14, %f24
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f25) : "f"(f22), "f"(f14), "f"(f24));
  // PTX:56 ld.global.f32 %f26, [%rd15+28]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (28)))));
  // PTX:57 fma.rn.f32 %f42, %f26, %f20, %f25
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f26), "f"(f20), "f"(f25));
  // PTX:58 ld.global.f32 %f27, [%rd15+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:59 ld.global.f32 %f28, [%rd15+20]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (20)))));
  // PTX:60 mul.f32 %f29, %f28, %f16
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f16));
  // PTX:61 fma.rn.f32 %f30, %f27, %f14, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f30) : "f"(f27), "f"(f14), "f"(f29));
  // PTX:62 ld.global.f32 %f31, [%rd15+32]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (32)))));
  // PTX:63 fma.rn.f32 %f43, %f31, %f20, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f31), "f"(f20), "f"(f30));
  // PTX:64 cvta.to.global.u64 %rd16, %rd6
  rd16 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:65 add.s64 %rd2, %rd16, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd16), "l"(rd11));
  // PTX:66 setp.gt.s32 %p2, %r1, 0
  p2 = (((int)(r1)) > ((int)(0)));
  // PTX:67 mov.f32 %f40, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f40) : );
  // PTX:68 @%p2 bra $L__BB7_2
  if (p2) { goto L_BB7_2; }
  // PTX:69 bra.uni $L__BB7_6
  goto L_BB7_6;
  // PTX:71 $L__BB7_2:
L_BB7_2:;
  // PTX:72 cvta.to.global.u64 %rd17, %rd5
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:73 mul.wide.s32 %rd18, %r1, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd18) : "r"(r1));
  // PTX:74 add.s64 %rd19, %rd17, %rd18
  asm("add.s64 %0, %1, %2;" : "=l"(rd19) : "l"(rd17), "l"(rd18));
  // PTX:75 ld.global.f32 %f4, [%rd19]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (0)))));
  // PTX:76 ld.global.f32 %f5, [%rd19+-4]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd19) + (-4)))));
  // PTX:77 abs.f32 %f33, %f5
  asm("abs.f32 %0, %1;" : "=f"(f33) : "f"(f5));
  // PTX:78 setp.leu.f32 %p3, %f33, 0f0DA24260
  p3 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f33)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:79 setp.gtu.f32 %p4, %f33, 0f7F800000
  p4 = ((isnan(((float)(f33))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f33)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:80 or.pred %p5, %p3, %p4
  p5 = ((p3) || (p4));
  // PTX:81 @%p5 bra $L__BB7_5
  if (p5) { goto L_BB7_5; }
  // PTX:83 abs.f32 %f35, %f4
  asm("abs.f32 %0, %1;" : "=f"(f35) : "f"(f4));
  // PTX:84 setp.gtu.f32 %p6, %f35, 0f7F800000
  p6 = ((isnan(((float)(f35))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f35)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:85 @%p6 bra $L__BB7_5
  if (p6) { goto L_BB7_5; }
  // PTX:87 div.rn.f32 %f40, %f4, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f40) : "f"(f4), "f"(f5));
  // PTX:89 $L__BB7_5:
L_BB7_5:;
  // PTX:90 ld.global.f32 %f36, [%rd2]
  f36 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0)))));
  // PTX:91 ld.global.f32 %f37, [%rd2+4]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4)))));
  // PTX:92 ld.global.f32 %f38, [%rd2+8]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8)))));
  // PTX:93 fma.rn.f32 %f41, %f40, %f36, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f40), "f"(f36), "f"(f41));
  // PTX:94 fma.rn.f32 %f42, %f40, %f37, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f40), "f"(f37), "f"(f42));
  // PTX:95 fma.rn.f32 %f43, %f40, %f38, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f40), "f"(f38), "f"(f43));
  // PTX:97 $L__BB7_6:
L_BB7_6:;
  // PTX:98 st.global.f32 [%rd2], %f41
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (0))))) = (float)(f41);
  // PTX:99 st.global.f32 [%rd2+4], %f42
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (4))))) = (float)(f42);
  // PTX:100 st.global.f32 [%rd2+8], %f43
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd2) + (8))))) = (float)(f43);
  // PTX:102 $L__BB7_7:
L_BB7_7:;
  // PTX:103 ret
  return;
}
