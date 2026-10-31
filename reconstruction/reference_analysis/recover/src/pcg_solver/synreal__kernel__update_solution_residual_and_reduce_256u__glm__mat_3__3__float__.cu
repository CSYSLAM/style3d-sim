// 机械还原自 PTX：void synreal::kernel::update_solution_residual_and_reduce<256u, glm::mat<3, 3, float, (glm::qualifier)0> >(int, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0>*, glm::vec<3, float, (glm::qualifier)0>*, float*, bool, unsigned long)
// PTX SHA256: 26563330486353e23b6fea715071d3e05d459922f7efbee3ab2c923c8f1b5382
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__update_solution_residual_and_reduce_256u__glm__mat_3__3__float__(unsigned param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned char param9, unsigned long long param10) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33;
  __shared__ __align__(4) unsigned char _ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage[44];
  // PTX:29 ld.param.s8 %rs1, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_9]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param9 + (0))));
  // PTX:30 ld.param.u32 %r2, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_0]
  r2 = (*reinterpret_cast<volatile unsigned*>(((uintptr_t)&param0 + (0))));
  // PTX:31 ld.param.u64 %rd3, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_1]
  rd3 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:32 ld.param.u64 %rd4, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_2]
  rd4 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:33 ld.param.u64 %rd5, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_3]
  rd5 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:34 ld.param.u64 %rd6, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_4]
  rd6 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:35 ld.param.u64 %rd7, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_5]
  rd7 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:36 ld.param.u64 %rd8, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_6]
  rd8 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:37 ld.param.u64 %rd9, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_7]
  rd9 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:38 ld.param.u64 %rd10, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_8]
  rd10 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:39 ld.param.u64 %rd11, [_ZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_Pfbm_param_10]
  rd11 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:40 mov.u32 %r3, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockIdx.x));
  // PTX:41 cvt.u64.u32 %rd1, %r3
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd1) : "r"(r3));
  // PTX:42 mov.u32 %r4, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(blockDim.x));
  // PTX:43 mul.wide.u32 %rd12, %r3, %r4
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd12) : "r"(r3), "r"(r4));
  // PTX:44 mov.u32 %r1, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r1) : "r"(threadIdx.x));
  // PTX:45 cvt.u64.u32 %rd13, %r1
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd13) : "r"(r1));
  // PTX:46 add.s64 %rd2, %rd12, %rd13
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd12), "l"(rd13));
  // PTX:47 setp.ge.u64 %p1, %rd2, %rd11
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd11)));
  // PTX:48 mov.f32 %f87, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f87) : );
  // PTX:49 mov.f32 %f86, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f86) : );
  // PTX:50 @%p1 bra $L__BB9_6
  if (p1) { goto L_BB9_6; }
  // PTX:52 cvta.to.global.u64 %rd14, %rd3
  rd14 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd3));
  // PTX:53 mul.wide.s32 %rd15, %r2, 4
  asm("mul.wide.s32 %0, %1, 4;" : "=l"(rd15) : "r"(r2));
  // PTX:54 add.s64 %rd16, %rd14, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd14), "l"(rd15));
  // PTX:55 ld.global.f32 %f1, [%rd16]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:56 cvta.to.global.u64 %rd17, %rd4
  rd17 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd4));
  // PTX:57 add.s64 %rd18, %rd17, %rd15
  asm("add.s64 %0, %1, %2;" : "=l"(rd18) : "l"(rd17), "l"(rd15));
  // PTX:58 ld.global.f32 %f2, [%rd18]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd18) + (0)))));
  // PTX:59 abs.f32 %f15, %f2
  asm("abs.f32 %0, %1;" : "=f"(f15) : "f"(f2));
  // PTX:60 setp.leu.f32 %p2, %f15, 0f0DA24260
  p2 = ((isnan(((float)(f15))) || isnan(((float)(as_f32(0x0DA24260u))))) || (((float)(f15)) <= ((float)(as_f32(0x0DA24260u)))));
  // PTX:61 setp.gtu.f32 %p3, %f15, 0f7F800000
  p3 = ((isnan(((float)(f15))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f15)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:62 or.pred %p4, %p2, %p3
  p4 = ((p2) || (p3));
  // PTX:63 @%p4 bra $L__BB9_4
  if (p4) { goto L_BB9_4; }
  // PTX:65 abs.f32 %f17, %f1
  asm("abs.f32 %0, %1;" : "=f"(f17) : "f"(f1));
  // PTX:66 setp.gtu.f32 %p5, %f17, 0f7F800000
  p5 = ((isnan(((float)(f17))) || isnan(((float)(as_f32(0x7F800000u))))) || (((float)(f17)) > ((float)(as_f32(0x7F800000u)))));
  // PTX:67 @%p5 bra $L__BB9_4
  if (p5) { goto L_BB9_4; }
  // PTX:69 div.rn.f32 %f86, %f1, %f2
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f86) : "f"(f1), "f"(f2));
  // PTX:71 $L__BB9_4:
L_BB9_4:;
  // PTX:72 cvta.to.global.u64 %rd19, %rd6
  rd19 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd6));
  // PTX:73 mul.lo.s64 %rd20, %rd2, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd20) : "l"(rd2));
  // PTX:74 add.s64 %rd21, %rd19, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd21) : "l"(rd19), "l"(rd20));
  // PTX:75 ld.global.f32 %f19, [%rd21]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (0)))));
  // PTX:76 mul.f32 %f20, %f86, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f86), "f"(f19));
  // PTX:77 ld.global.f32 %f21, [%rd21+4]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (4)))));
  // PTX:78 mul.f32 %f22, %f86, %f21
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f86), "f"(f21));
  // PTX:79 ld.global.f32 %f23, [%rd21+8]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd21) + (8)))));
  // PTX:80 mul.f32 %f24, %f86, %f23
  asm("mul.f32 %0, %1, %2;" : "=f"(f24) : "f"(f86), "f"(f23));
  // PTX:81 cvta.to.global.u64 %rd22, %rd9
  rd22 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd9));
  // PTX:82 add.s64 %rd23, %rd22, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd23) : "l"(rd22), "l"(rd20));
  // PTX:83 ld.global.f32 %f25, [%rd23]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0)))));
  // PTX:84 sub.f32 %f5, %f25, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f5) : "f"(f25), "f"(f20));
  // PTX:85 ld.global.f32 %f26, [%rd23+4]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4)))));
  // PTX:86 sub.f32 %f6, %f26, %f22
  asm("sub.f32 %0, %1, %2;" : "=f"(f6) : "f"(f26), "f"(f22));
  // PTX:87 ld.global.f32 %f27, [%rd23+8]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8)))));
  // PTX:88 sub.f32 %f7, %f27, %f24
  asm("sub.f32 %0, %1, %2;" : "=f"(f7) : "f"(f27), "f"(f24));
  // PTX:89 st.global.f32 [%rd23], %f5
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (0))))) = (float)(f5);
  // PTX:90 st.global.f32 [%rd23+4], %f6
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (4))))) = (float)(f6);
  // PTX:91 st.global.f32 [%rd23+8], %f7
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd23) + (8))))) = (float)(f7);
  // PTX:92 cvta.to.global.u64 %rd24, %rd5
  rd24 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd5));
  // PTX:93 add.s64 %rd25, %rd24, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd24), "l"(rd20));
  // PTX:94 ld.global.f32 %f28, [%rd25]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (0)))));
  // PTX:95 ld.global.f32 %f29, [%rd25+4]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (4)))));
  // PTX:96 ld.global.f32 %f30, [%rd25+8]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd25) + (8)))));
  // PTX:97 cvta.to.global.u64 %rd26, %rd8
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd8));
  // PTX:98 add.s64 %rd27, %rd26, %rd20
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd26), "l"(rd20));
  // PTX:99 ld.global.f32 %f31, [%rd27]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0)))));
  // PTX:100 fma.rn.f32 %f32, %f86, %f28, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f86), "f"(f28), "f"(f31));
  // PTX:101 ld.global.f32 %f33, [%rd27+4]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4)))));
  // PTX:102 fma.rn.f32 %f34, %f86, %f29, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f86), "f"(f29), "f"(f33));
  // PTX:103 ld.global.f32 %f35, [%rd27+8]
  f35 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8)))));
  // PTX:104 fma.rn.f32 %f36, %f86, %f30, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f86), "f"(f30), "f"(f35));
  // PTX:105 st.global.f32 [%rd27], %f32
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (0))))) = (float)(f32);
  // PTX:106 st.global.f32 [%rd27+4], %f34
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (4))))) = (float)(f34);
  // PTX:107 st.global.f32 [%rd27+8], %f36
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd27) + (8))))) = (float)(f36);
  // PTX:108 setp.eq.s16 %p6, %rs1, 0
  p6 = (((short)(rs1)) == ((short)(0)));
  // PTX:109 mov.f32 %f87, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f87) : );
  // PTX:110 @%p6 bra $L__BB9_6
  if (p6) { goto L_BB9_6; }
  // PTX:112 cvta.to.global.u64 %rd28, %rd7
  rd28 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd7));
  // PTX:113 mul.lo.s64 %rd29, %rd2, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd29) : "l"(rd2));
  // PTX:114 add.s64 %rd30, %rd28, %rd29
  asm("add.s64 %0, %1, %2;" : "=l"(rd30) : "l"(rd28), "l"(rd29));
  // PTX:115 ld.global.f32 %f37, [%rd30]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (0)))));
  // PTX:116 ld.global.f32 %f38, [%rd30+12]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (12)))));
  // PTX:117 mul.f32 %f39, %f6, %f38
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f6), "f"(f38));
  // PTX:118 fma.rn.f32 %f40, %f5, %f37, %f39
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f40) : "f"(f5), "f"(f37), "f"(f39));
  // PTX:119 ld.global.f32 %f41, [%rd30+24]
  f41 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (24)))));
  // PTX:120 fma.rn.f32 %f42, %f7, %f41, %f40
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f7), "f"(f41), "f"(f40));
  // PTX:121 ld.global.f32 %f43, [%rd30+4]
  f43 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (4)))));
  // PTX:122 ld.global.f32 %f44, [%rd30+16]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (16)))));
  // PTX:123 mul.f32 %f45, %f6, %f44
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f6), "f"(f44));
  // PTX:124 fma.rn.f32 %f46, %f5, %f43, %f45
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f5), "f"(f43), "f"(f45));
  // PTX:125 ld.global.f32 %f47, [%rd30+28]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (28)))));
  // PTX:126 fma.rn.f32 %f48, %f7, %f47, %f46
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f7), "f"(f47), "f"(f46));
  // PTX:127 ld.global.f32 %f49, [%rd30+8]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (8)))));
  // PTX:128 ld.global.f32 %f50, [%rd30+20]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (20)))));
  // PTX:129 mul.f32 %f51, %f6, %f50
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f6), "f"(f50));
  // PTX:130 fma.rn.f32 %f52, %f5, %f49, %f51
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f52) : "f"(f5), "f"(f49), "f"(f51));
  // PTX:131 ld.global.f32 %f53, [%rd30+32]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd30) + (32)))));
  // PTX:132 fma.rn.f32 %f54, %f7, %f53, %f52
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f54) : "f"(f7), "f"(f53), "f"(f52));
  // PTX:133 mul.f32 %f55, %f6, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f6), "f"(f48));
  // PTX:134 fma.rn.f32 %f56, %f5, %f42, %f55
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f56) : "f"(f5), "f"(f42), "f"(f55));
  // PTX:135 fma.rn.f32 %f87, %f7, %f54, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f87) : "f"(f7), "f"(f54), "f"(f56));
  // PTX:137 $L__BB9_6:
L_BB9_6:;
  // PTX:138 setp.eq.s16 %p7, %rs1, 0
  p7 = (((short)(rs1)) == ((short)(0)));
  // PTX:139 @%p7 bra $L__BB9_13
  if (p7) { goto L_BB9_13; }
  // PTX:142 mov.u32 %r5, %laneid
  asm("mov.u32 %0, %1;" : "=r"(r5) : "r"((threadIdx.x & 31u)));
  // PTX:144 mov.u32 %r7, 1
  asm("mov.u32 %0, 1;" : "=r"(r7) : );
  // PTX:145 mov.u32 %r20, 31
  asm("mov.u32 %0, 31;" : "=r"(r20) : );
  // PTX:146 mov.u32 %r21, -1
  asm("mov.u32 %0, -1;" : "=r"(r21) : );
  // PTX:148 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f87, %r7, %r20, %r21; @p add.f32 r0, r0, %f87; mov.f32 %f57, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f57) : "f"(f87), "r"(r7), "r"(r20), "r"(r21));
  // PTX:150 mov.u32 %r10, 2
  asm("mov.u32 %0, 2;" : "=r"(r10) : );
  // PTX:152 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f57, %r10, %r20, %r21; @p add.f32 r0, r0, %f57; mov.f32 %f60, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f60) : "f"(f57), "r"(r10), "r"(r20), "r"(r21));
  // PTX:154 mov.u32 %r13, 4
  asm("mov.u32 %0, 4;" : "=r"(r13) : );
  // PTX:156 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f60, %r13, %r20, %r21; @p add.f32 r0, r0, %f60; mov.f32 %f63, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f63) : "f"(f60), "r"(r13), "r"(r20), "r"(r21));
  // PTX:158 mov.u32 %r16, 8
  asm("mov.u32 %0, 8;" : "=r"(r16) : );
  // PTX:160 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f63, %r16, %r20, %r21; @p add.f32 r0, r0, %f63; mov.f32 %f66, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f66) : "f"(f63), "r"(r16), "r"(r20), "r"(r21));
  // PTX:162 mov.u32 %r19, 16
  asm("mov.u32 %0, 16;" : "=r"(r19) : );
  // PTX:164 { .reg .f32 r0; .reg .pred p; shfl.sync.down.b32 r0|p, %f66, %r19, %r20, %r21; @p add.f32 r0, r0, %f66; mov.f32 %f88, r0;}
  asm volatile("{ .reg .f32 v; .reg .pred q; shfl.sync.down.b32 v|q, %1, %2, %3, %4; @q add.f32 v, v, %1; mov.f32 %0, v; }" : "=f"(f88) : "f"(f66), "r"(r19), "r"(r20), "r"(r21));
  // PTX:166 setp.ne.s32 %p8, %r5, 0
  p8 = (((int)(r5)) != ((int)(0)));
  // PTX:167 @%p8 bra $L__BB9_9
  if (p8) { goto L_BB9_9; }
  // PTX:169 shr.s32 %r22, %r1, 31
  asm("shr.s32 %0, %1, 31;" : "=r"(r22) : "r"(r1));
  // PTX:170 shr.u32 %r23, %r22, 27
  asm("shr.u32 %0, %1, 27;" : "=r"(r23) : "r"(r22));
  // PTX:171 add.s32 %r24, %r1, %r23
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r1), "r"(r23));
  // PTX:172 shr.s32 %r25, %r24, 5
  asm("shr.s32 %0, %1, 5;" : "=r"(r25) : "r"(r24));
  // PTX:173 shl.b32 %r26, %r25, 2
  asm("shl.b32 %0, %1, 2;" : "=r"(r26) : "r"(r25));
  // PTX:174 mov.u32 %r27, _ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage
  r27 = (unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage);
  // PTX:175 add.s32 %r28, %r27, %r26
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r26));
  // PTX:176 st.shared.f32 [%r28+8], %f88
  (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)(r28) + (8))))) = (float)(f88);
  // PTX:178 $L__BB9_9:
L_BB9_9:;
  // PTX:179 bar.sync 0
  __syncthreads();
  // PTX:180 setp.ne.s32 %p9, %r1, 0
  p9 = (((int)(r1)) != ((int)(0)));
  // PTX:181 @%p9 bra $L__BB9_11
  if (p9) { goto L_BB9_11; }
  // PTX:183 ld.shared.f32 %f72, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+12]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (12)))));
  // PTX:184 add.f32 %f73, %f88, %f72
  asm("add.f32 %0, %1, %2;" : "=f"(f73) : "f"(f88), "f"(f72));
  // PTX:185 ld.shared.f32 %f74, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+16]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (16)))));
  // PTX:186 add.f32 %f75, %f73, %f74
  asm("add.f32 %0, %1, %2;" : "=f"(f75) : "f"(f73), "f"(f74));
  // PTX:187 ld.shared.f32 %f76, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+20]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (20)))));
  // PTX:188 add.f32 %f77, %f75, %f76
  asm("add.f32 %0, %1, %2;" : "=f"(f77) : "f"(f75), "f"(f76));
  // PTX:189 ld.shared.f32 %f78, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+24]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (24)))));
  // PTX:190 add.f32 %f79, %f77, %f78
  asm("add.f32 %0, %1, %2;" : "=f"(f79) : "f"(f77), "f"(f78));
  // PTX:191 ld.shared.f32 %f80, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+28]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (28)))));
  // PTX:192 add.f32 %f81, %f79, %f80
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f79), "f"(f80));
  // PTX:193 ld.shared.f32 %f82, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+32]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (32)))));
  // PTX:194 add.f32 %f83, %f81, %f82
  asm("add.f32 %0, %1, %2;" : "=f"(f83) : "f"(f81), "f"(f82));
  // PTX:195 ld.shared.f32 %f84, [_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage+36]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_shared_to_generic(((uintptr_t)((unsigned)__cvta_generic_to_shared(_ZZN7synreal6kernel35update_solution_residual_and_reduceILj256EN3glm3matILi3ELi3EfLNS2_9qualifierE0EEEEEviPKfS7_PKNS2_3vecILi3EfLS4_0EEESB_PKT0_PS9_SF_PfbmE17reduction_storage)) + (36)))));
  // PTX:196 add.f32 %f88, %f83, %f84
  asm("add.f32 %0, %1, %2;" : "=f"(f88) : "f"(f83), "f"(f84));
  // PTX:198 $L__BB9_11:
L_BB9_11:;
  // PTX:199 @%p9 bra $L__BB9_13
  if (p9) { goto L_BB9_13; }
  // PTX:201 cvta.to.global.u64 %rd31, %rd10
  rd31 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd10));
  // PTX:202 shl.b64 %rd32, %rd1, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd32) : "l"(rd1));
  // PTX:203 add.s64 %rd33, %rd31, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd31), "l"(rd32));
  // PTX:204 st.global.f32 [%rd33], %f88
  (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0))))) = (float)(f88);
  // PTX:206 $L__BB9_13:
L_BB9_13:;
  // PTX:207 ret
  return;
}
