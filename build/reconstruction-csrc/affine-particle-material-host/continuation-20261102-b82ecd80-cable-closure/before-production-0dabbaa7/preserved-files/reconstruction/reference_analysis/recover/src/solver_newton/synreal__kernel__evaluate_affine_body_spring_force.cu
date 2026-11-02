// 机械还原自 PTX：synreal::kernel::evaluate_affine_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, float const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 283724c4fe659a2bee4494b76cc8c8e4be3f00f42191c48f0b98b7bcf57f63a8
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_affine_body_spring_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, float param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55;
  // PTX:24 ld.param.u64 %rd18, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_0]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:25 ld.param.u64 %rd13, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_1]
  rd13 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:26 ld.param.u64 %rd14, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_2]
  rd14 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:27 ld.param.f32 %f74, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_3]
  f74 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param3 + (0))));
  // PTX:28 ld.param.u64 %rd15, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_4]
  rd15 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:29 ld.param.u64 %rd19, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_5]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:30 ld.param.u64 %rd16, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_6]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:31 ld.param.u64 %rd17, [_ZN7synreal6kernel33evaluate_affine_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKffPS4_mmm_param_7]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:32 cvta.to.global.u64 %rd1, %rd18
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:33 mov.u32 %r7, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r7) : "r"(blockIdx.x));
  // PTX:34 mov.u32 %r8, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockDim.x));
  // PTX:35 mul.wide.u32 %rd20, %r7, %r8
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd20) : "r"(r7), "r"(r8));
  // PTX:36 mov.u32 %r9, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(threadIdx.x));
  // PTX:37 cvt.u64.u32 %rd21, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd21) : "r"(r9));
  // PTX:38 add.s64 %rd2, %rd20, %rd21
  asm("add.s64 %0, %1, %2;" : "=l"(rd2) : "l"(rd20), "l"(rd21));
  // PTX:39 setp.ge.u64 %p1, %rd2, %rd19
  p1 = (((unsigned long long)(rd2)) >= ((unsigned long long)(rd19)));
  // PTX:40 @%p1 bra $L__BB14_17
  if (p1) { goto L_BB14_17; }
  // PTX:42 or.b64 %rd22, %rd2, %rd16
  asm("or.b64 %0, %1, %2;" : "=l"(rd22) : "l"(rd2), "l"(rd16));
  // PTX:43 and.b64 %rd23, %rd22, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd23) : "l"(rd22));
  // PTX:44 setp.eq.s64 %p2, %rd23, 0
  p2 = (((long long)(rd23)) == ((long long)(0)));
  // PTX:45 @%p2 bra $L__BB14_3
  if (p2) { goto L_BB14_3; }
  // PTX:47 div.u64 %rd54, %rd2, %rd16
  asm("div.u64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd16));
  // PTX:48 mul.lo.s64 %rd24, %rd54, %rd16
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd24) : "l"(rd54), "l"(rd16));
  // PTX:49 sub.s64 %rd55, %rd2, %rd24
  asm("sub.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd2), "l"(rd24));
  // PTX:50 bra.uni $L__BB14_4
  goto L_BB14_4;
  // PTX:52 $L__BB14_3:
L_BB14_3:;
  // PTX:53 cvt.u32.u64 %r10, %rd16
  asm("cvt.u32.u64 %0, %1;" : "=r"(r10) : "l"(rd16));
  // PTX:54 cvt.u32.u64 %r11, %rd2
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd2));
  // PTX:55 div.u32 %r12, %r11, %r10
  asm("div.u32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r10));
  // PTX:56 mul.lo.s32 %r13, %r12, %r10
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r10));
  // PTX:57 sub.s32 %r14, %r11, %r13
  asm("sub.s32 %0, %1, %2;" : "=r"(r14) : "r"(r11), "r"(r13));
  // PTX:58 cvt.u64.u32 %rd54, %r12
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd54) : "r"(r12));
  // PTX:59 cvt.u64.u32 %rd55, %r14
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd55) : "r"(r14));
  // PTX:61 $L__BB14_4:
L_BB14_4:;
  // PTX:62 mul.lo.s64 %rd25, %rd54, %rd17
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd25) : "l"(rd54), "l"(rd17));
  // PTX:63 cvt.u32.u64 %r1, %rd25
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd25));
  // PTX:64 cvta.to.global.u64 %rd26, %rd13
  rd26 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd13));
  // PTX:65 shl.b64 %rd27, %rd55, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd27) : "l"(rd55));
  // PTX:66 add.s64 %rd28, %rd26, %rd27
  asm("add.s64 %0, %1, %2;" : "=l"(rd28) : "l"(rd26), "l"(rd27));
  // PTX:67 ld.global.u32 %r2, [%rd28]
  r2 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (0)))));
  // PTX:68 ld.global.u32 %r15, [%rd28+4]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (4)))));
  // PTX:69 add.s32 %r16, %r15, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r1));
  // PTX:70 ld.global.u32 %r3, [%rd28+8]
  r3 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (8)))));
  // PTX:71 ld.global.u32 %r4, [%rd28+12]
  r4 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd28) + (12)))));
  // PTX:72 cvta.to.global.u64 %rd29, %rd14
  rd29 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd14));
  // PTX:73 shl.b64 %rd30, %rd55, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd30) : "l"(rd55));
  // PTX:74 add.s64 %rd31, %rd29, %rd30
  asm("add.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd29), "l"(rd30));
  // PTX:75 ld.global.f32 %f78, [%rd31]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd31) + (0)))));
  // PTX:76 mul.f32 %f1, %f78, %f74
  asm("mul.f32 %0, %1, %2;" : "=f"(f1) : "f"(f78), "f"(f74));
  // PTX:77 cvt.s64.s32 %rd9, %r16
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd9) : "r"(r16));
  // PTX:78 mul.wide.s32 %rd32, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd32) : "r"(r16));
  // PTX:79 add.s64 %rd33, %rd1, %rd32
  asm("add.s64 %0, %1, %2;" : "=l"(rd33) : "l"(rd1), "l"(rd32));
  // PTX:80 ld.global.f32 %f2, [%rd33]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (0)))));
  // PTX:81 mul.f32 %f79, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f79) : "f"(f2), "f"(f2));
  // PTX:82 ld.global.f32 %f3, [%rd33+4]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (4)))));
  // PTX:83 ld.global.f32 %f4, [%rd33+8]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd33) + (8)))));
  // PTX:84 fma.rn.f32 %f80, %f3, %f3, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f3), "f"(f3), "f"(f79));
  // PTX:85 fma.rn.f32 %f81, %f4, %f4, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f4), "f"(f4), "f"(f80));
  // PTX:86 sqrt.rn.f32 %f5, %f81
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f5) : "f"(f81));
  // PTX:87 setp.leu.f32 %p3, %f5, 0f00000000
  p3 = ((isnan(((float)(f5))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f5)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:88 mov.f32 %f184, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f184) : );
  // PTX:89 mov.f32 %f181, %f184
  asm("mov.f32 %0, %1;" : "=f"(f181) : "f"(f184));
  // PTX:90 mov.f32 %f182, %f184
  asm("mov.f32 %0, %1;" : "=f"(f182) : "f"(f184));
  // PTX:91 mov.f32 %f183, %f184
  asm("mov.f32 %0, %1;" : "=f"(f183) : "f"(f184));
  // PTX:92 @%p3 bra $L__BB14_6
  if (p3) { goto L_BB14_6; }
  // PTX:94 add.f32 %f82, %f5, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f82) : "f"(f5));
  // PTX:95 abs.f32 %f83, %f82
  asm("abs.f32 %0, %1;" : "=f"(f83) : "f"(f82));
  // PTX:96 setp.le.f32 %p4, %f83, 0f35800000
  p4 = (!(isnan(((float)(f83))) || isnan(((float)(as_f32(0x35800000u))))) && (((float)(f83)) <= ((float)(as_f32(0x35800000u)))));
  // PTX:97 selp.f32 %f84, 0f00000000, %f82, %p4
  f84 = p4 ? as_f32(0x00000000u) : f82;
  // PTX:98 mul.f32 %f85, %f1, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f1), "f"(f84));
  // PTX:99 mul.f32 %f86, %f2, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f2), "f"(f85));
  // PTX:100 mul.f32 %f87, %f3, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f3), "f"(f85));
  // PTX:101 mul.f32 %f88, %f4, %f85
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f4), "f"(f85));
  // PTX:102 div.rn.f32 %f183, %f86, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f183) : "f"(f86), "f"(f5));
  // PTX:103 div.rn.f32 %f182, %f87, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f182) : "f"(f87), "f"(f5));
  // PTX:104 div.rn.f32 %f181, %f88, %f5
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f181) : "f"(f88), "f"(f5));
  // PTX:106 $L__BB14_6:
L_BB14_6:;
  // PTX:107 add.s32 %r17, %r3, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r3), "r"(r1));
  // PTX:108 cvt.s64.s32 %rd10, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r17));
  // PTX:109 mul.wide.s32 %rd34, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd34) : "r"(r17));
  // PTX:110 add.s64 %rd35, %rd1, %rd34
  asm("add.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd1), "l"(rd34));
  // PTX:111 ld.global.f32 %f12, [%rd35]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (0)))));
  // PTX:112 mul.f32 %f92, %f12, %f12
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f12), "f"(f12));
  // PTX:113 ld.global.f32 %f13, [%rd35+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (4)))));
  // PTX:114 ld.global.f32 %f14, [%rd35+8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd35) + (8)))));
  // PTX:115 fma.rn.f32 %f93, %f13, %f13, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f13), "f"(f13), "f"(f92));
  // PTX:116 fma.rn.f32 %f94, %f14, %f14, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f14), "f"(f14), "f"(f93));
  // PTX:117 sqrt.rn.f32 %f15, %f94
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f15) : "f"(f94));
  // PTX:118 setp.leu.f32 %p5, %f15, 0f00000000
  p5 = ((isnan(((float)(f15))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f15)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:119 add.s32 %r5, %r4, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r5) : "r"(r4), "r"(r1));
  // PTX:120 add.s32 %r6, %r2, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r6) : "r"(r2), "r"(r1));
  // PTX:121 mov.f32 %f185, %f184
  asm("mov.f32 %0, %1;" : "=f"(f185) : "f"(f184));
  // PTX:122 mov.f32 %f186, %f184
  asm("mov.f32 %0, %1;" : "=f"(f186) : "f"(f184));
  // PTX:123 @%p5 bra $L__BB14_8
  if (p5) { goto L_BB14_8; }
  // PTX:125 add.f32 %f95, %f15, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f95) : "f"(f15));
  // PTX:126 abs.f32 %f96, %f95
  asm("abs.f32 %0, %1;" : "=f"(f96) : "f"(f95));
  // PTX:127 setp.le.f32 %p6, %f96, 0f35800000
  p6 = (!(isnan(((float)(f96))) || isnan(((float)(as_f32(0x35800000u))))) && (((float)(f96)) <= ((float)(as_f32(0x35800000u)))));
  // PTX:128 selp.f32 %f97, 0f00000000, %f95, %p6
  f97 = p6 ? as_f32(0x00000000u) : f95;
  // PTX:129 mul.f32 %f98, %f1, %f97
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f1), "f"(f97));
  // PTX:130 mul.f32 %f99, %f12, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f12), "f"(f98));
  // PTX:131 mul.f32 %f100, %f13, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f100) : "f"(f13), "f"(f98));
  // PTX:132 mul.f32 %f101, %f14, %f98
  asm("mul.f32 %0, %1, %2;" : "=f"(f101) : "f"(f14), "f"(f98));
  // PTX:133 div.rn.f32 %f186, %f99, %f15
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f186) : "f"(f99), "f"(f15));
  // PTX:134 div.rn.f32 %f185, %f100, %f15
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f185) : "f"(f100), "f"(f15));
  // PTX:135 div.rn.f32 %f184, %f101, %f15
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f184) : "f"(f101), "f"(f15));
  // PTX:137 $L__BB14_8:
L_BB14_8:;
  // PTX:138 cvt.s64.s32 %rd11, %r5
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r5));
  // PTX:139 mul.wide.s32 %rd36, %r5, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd36) : "r"(r5));
  // PTX:140 add.s64 %rd37, %rd1, %rd36
  asm("add.s64 %0, %1, %2;" : "=l"(rd37) : "l"(rd1), "l"(rd36));
  // PTX:141 ld.global.f32 %f22, [%rd37]
  f22 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (0)))));
  // PTX:142 mul.f32 %f105, %f22, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f105) : "f"(f22), "f"(f22));
  // PTX:143 ld.global.f32 %f23, [%rd37+4]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (4)))));
  // PTX:144 ld.global.f32 %f24, [%rd37+8]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd37) + (8)))));
  // PTX:145 fma.rn.f32 %f106, %f23, %f23, %f105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f106) : "f"(f23), "f"(f23), "f"(f105));
  // PTX:146 fma.rn.f32 %f107, %f24, %f24, %f106
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f107) : "f"(f24), "f"(f24), "f"(f106));
  // PTX:147 sqrt.rn.f32 %f25, %f107
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f25) : "f"(f107));
  // PTX:148 setp.leu.f32 %p7, %f25, 0f00000000
  p7 = ((isnan(((float)(f25))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f25)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:149 mov.f32 %f190, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f190) : );
  // PTX:150 mov.f32 %f187, %f190
  asm("mov.f32 %0, %1;" : "=f"(f187) : "f"(f190));
  // PTX:151 mov.f32 %f188, %f190
  asm("mov.f32 %0, %1;" : "=f"(f188) : "f"(f190));
  // PTX:152 mov.f32 %f189, %f190
  asm("mov.f32 %0, %1;" : "=f"(f189) : "f"(f190));
  // PTX:153 @%p7 bra $L__BB14_10
  if (p7) { goto L_BB14_10; }
  // PTX:155 add.f32 %f108, %f25, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f108) : "f"(f25));
  // PTX:156 abs.f32 %f109, %f108
  asm("abs.f32 %0, %1;" : "=f"(f109) : "f"(f108));
  // PTX:157 setp.le.f32 %p8, %f109, 0f35800000
  p8 = (!(isnan(((float)(f109))) || isnan(((float)(as_f32(0x35800000u))))) && (((float)(f109)) <= ((float)(as_f32(0x35800000u)))));
  // PTX:158 selp.f32 %f110, 0f00000000, %f108, %p8
  f110 = p8 ? as_f32(0x00000000u) : f108;
  // PTX:159 mul.f32 %f111, %f1, %f110
  asm("mul.f32 %0, %1, %2;" : "=f"(f111) : "f"(f1), "f"(f110));
  // PTX:160 mul.f32 %f112, %f22, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f22), "f"(f111));
  // PTX:161 mul.f32 %f113, %f23, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f23), "f"(f111));
  // PTX:162 mul.f32 %f114, %f24, %f111
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f24), "f"(f111));
  // PTX:163 div.rn.f32 %f189, %f112, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f189) : "f"(f112), "f"(f25));
  // PTX:164 div.rn.f32 %f188, %f113, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f188) : "f"(f113), "f"(f25));
  // PTX:165 div.rn.f32 %f187, %f114, %f25
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f187) : "f"(f114), "f"(f25));
  // PTX:167 $L__BB14_10:
L_BB14_10:;
  // PTX:168 sub.f32 %f32, %f12, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f32) : "f"(f12), "f"(f2));
  // PTX:169 mul.f32 %f118, %f32, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f32), "f"(f32));
  // PTX:170 sub.f32 %f33, %f13, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f33) : "f"(f13), "f"(f3));
  // PTX:171 sub.f32 %f34, %f14, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f34) : "f"(f14), "f"(f4));
  // PTX:172 fma.rn.f32 %f119, %f33, %f33, %f118
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f33), "f"(f33), "f"(f118));
  // PTX:173 fma.rn.f32 %f120, %f34, %f34, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f34), "f"(f34), "f"(f119));
  // PTX:174 sqrt.rn.f32 %f35, %f120
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f35) : "f"(f120));
  // PTX:175 setp.leu.f32 %p9, %f35, 0f00000000
  p9 = ((isnan(((float)(f35))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f35)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:176 mov.f32 %f191, %f190
  asm("mov.f32 %0, %1;" : "=f"(f191) : "f"(f190));
  // PTX:177 mov.f32 %f192, %f190
  asm("mov.f32 %0, %1;" : "=f"(f192) : "f"(f190));
  // PTX:178 @%p9 bra $L__BB14_12
  if (p9) { goto L_BB14_12; }
  // PTX:180 add.f32 %f121, %f35, 0fBFB504F3
  asm("add.f32 %0, %1, 0fBFB504F3;" : "=f"(f121) : "f"(f35));
  // PTX:181 abs.f32 %f122, %f121
  asm("abs.f32 %0, %1;" : "=f"(f122) : "f"(f121));
  // PTX:182 setp.le.f32 %p10, %f122, 0f35B504F3
  p10 = (!(isnan(((float)(f122))) || isnan(((float)(as_f32(0x35B504F3u))))) && (((float)(f122)) <= ((float)(as_f32(0x35B504F3u)))));
  // PTX:183 selp.f32 %f123, 0f00000000, %f121, %p10
  f123 = p10 ? as_f32(0x00000000u) : f121;
  // PTX:184 mul.f32 %f124, %f1, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f1), "f"(f123));
  // PTX:185 mul.f32 %f125, %f32, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f32), "f"(f124));
  // PTX:186 mul.f32 %f126, %f33, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f33), "f"(f124));
  // PTX:187 mul.f32 %f127, %f34, %f124
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f34), "f"(f124));
  // PTX:188 div.rn.f32 %f192, %f125, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f192) : "f"(f125), "f"(f35));
  // PTX:189 div.rn.f32 %f191, %f126, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f191) : "f"(f126), "f"(f35));
  // PTX:190 div.rn.f32 %f190, %f127, %f35
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f190) : "f"(f127), "f"(f35));
  // PTX:192 $L__BB14_12:
L_BB14_12:;
  // PTX:193 cvta.to.global.u64 %rd12, %rd15
  rd12 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd15));
  // PTX:194 mov.f32 %f196, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f196) : );
  // PTX:195 sub.f32 %f131, %f196, %f183
  asm("sub.f32 %0, %1, %2;" : "=f"(f131) : "f"(f196), "f"(f183));
  // PTX:196 add.f32 %f42, %f192, %f131
  asm("add.f32 %0, %1, %2;" : "=f"(f42) : "f"(f192), "f"(f131));
  // PTX:197 sub.f32 %f132, %f196, %f182
  asm("sub.f32 %0, %1, %2;" : "=f"(f132) : "f"(f196), "f"(f182));
  // PTX:198 add.f32 %f43, %f191, %f132
  asm("add.f32 %0, %1, %2;" : "=f"(f43) : "f"(f191), "f"(f132));
  // PTX:199 sub.f32 %f133, %f196, %f181
  asm("sub.f32 %0, %1, %2;" : "=f"(f133) : "f"(f196), "f"(f181));
  // PTX:200 add.f32 %f44, %f190, %f133
  asm("add.f32 %0, %1, %2;" : "=f"(f44) : "f"(f190), "f"(f133));
  // PTX:201 sub.f32 %f134, %f196, %f186
  asm("sub.f32 %0, %1, %2;" : "=f"(f134) : "f"(f196), "f"(f186));
  // PTX:202 sub.f32 %f45, %f134, %f192
  asm("sub.f32 %0, %1, %2;" : "=f"(f45) : "f"(f134), "f"(f192));
  // PTX:203 sub.f32 %f135, %f196, %f185
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f196), "f"(f185));
  // PTX:204 sub.f32 %f46, %f135, %f191
  asm("sub.f32 %0, %1, %2;" : "=f"(f46) : "f"(f135), "f"(f191));
  // PTX:205 sub.f32 %f136, %f196, %f184
  asm("sub.f32 %0, %1, %2;" : "=f"(f136) : "f"(f196), "f"(f184));
  // PTX:206 sub.f32 %f47, %f136, %f190
  asm("sub.f32 %0, %1, %2;" : "=f"(f47) : "f"(f136), "f"(f190));
  // PTX:207 sub.f32 %f48, %f22, %f2
  asm("sub.f32 %0, %1, %2;" : "=f"(f48) : "f"(f22), "f"(f2));
  // PTX:208 mul.f32 %f137, %f48, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f137) : "f"(f48), "f"(f48));
  // PTX:209 sub.f32 %f49, %f23, %f3
  asm("sub.f32 %0, %1, %2;" : "=f"(f49) : "f"(f23), "f"(f3));
  // PTX:210 sub.f32 %f50, %f24, %f4
  asm("sub.f32 %0, %1, %2;" : "=f"(f50) : "f"(f24), "f"(f4));
  // PTX:211 fma.rn.f32 %f138, %f49, %f49, %f137
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f138) : "f"(f49), "f"(f49), "f"(f137));
  // PTX:212 fma.rn.f32 %f139, %f50, %f50, %f138
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f139) : "f"(f50), "f"(f50), "f"(f138));
  // PTX:213 sqrt.rn.f32 %f51, %f139
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f51) : "f"(f139));
  // PTX:214 setp.leu.f32 %p11, %f51, 0f00000000
  p11 = ((isnan(((float)(f51))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f51)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:215 mov.f32 %f193, %f196
  asm("mov.f32 %0, %1;" : "=f"(f193) : "f"(f196));
  // PTX:216 mov.f32 %f194, %f196
  asm("mov.f32 %0, %1;" : "=f"(f194) : "f"(f196));
  // PTX:217 mov.f32 %f195, %f196
  asm("mov.f32 %0, %1;" : "=f"(f195) : "f"(f196));
  // PTX:218 @%p11 bra $L__BB14_14
  if (p11) { goto L_BB14_14; }
  // PTX:220 add.f32 %f140, %f51, 0fBFB504F3
  asm("add.f32 %0, %1, 0fBFB504F3;" : "=f"(f140) : "f"(f51));
  // PTX:221 abs.f32 %f141, %f140
  asm("abs.f32 %0, %1;" : "=f"(f141) : "f"(f140));
  // PTX:222 setp.le.f32 %p12, %f141, 0f35B504F3
  p12 = (!(isnan(((float)(f141))) || isnan(((float)(as_f32(0x35B504F3u))))) && (((float)(f141)) <= ((float)(as_f32(0x35B504F3u)))));
  // PTX:223 selp.f32 %f142, 0f00000000, %f140, %p12
  f142 = p12 ? as_f32(0x00000000u) : f140;
  // PTX:224 mul.f32 %f143, %f1, %f142
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f1), "f"(f142));
  // PTX:225 mul.f32 %f144, %f48, %f143
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f48), "f"(f143));
  // PTX:226 mul.f32 %f145, %f49, %f143
  asm("mul.f32 %0, %1, %2;" : "=f"(f145) : "f"(f49), "f"(f143));
  // PTX:227 mul.f32 %f146, %f50, %f143
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f50), "f"(f143));
  // PTX:228 div.rn.f32 %f195, %f144, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f195) : "f"(f144), "f"(f51));
  // PTX:229 div.rn.f32 %f194, %f145, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f194) : "f"(f145), "f"(f51));
  // PTX:230 div.rn.f32 %f193, %f146, %f51
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f193) : "f"(f146), "f"(f51));
  // PTX:232 $L__BB14_14:
L_BB14_14:;
  // PTX:233 add.f32 %f58, %f195, %f42
  asm("add.f32 %0, %1, %2;" : "=f"(f58) : "f"(f195), "f"(f42));
  // PTX:234 add.f32 %f59, %f194, %f43
  asm("add.f32 %0, %1, %2;" : "=f"(f59) : "f"(f194), "f"(f43));
  // PTX:235 add.f32 %f60, %f193, %f44
  asm("add.f32 %0, %1, %2;" : "=f"(f60) : "f"(f193), "f"(f44));
  // PTX:236 sub.f32 %f150, %f196, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f196), "f"(f189));
  // PTX:237 sub.f32 %f61, %f150, %f195
  asm("sub.f32 %0, %1, %2;" : "=f"(f61) : "f"(f150), "f"(f195));
  // PTX:238 sub.f32 %f151, %f196, %f188
  asm("sub.f32 %0, %1, %2;" : "=f"(f151) : "f"(f196), "f"(f188));
  // PTX:239 sub.f32 %f62, %f151, %f194
  asm("sub.f32 %0, %1, %2;" : "=f"(f62) : "f"(f151), "f"(f194));
  // PTX:240 sub.f32 %f152, %f196, %f187
  asm("sub.f32 %0, %1, %2;" : "=f"(f152) : "f"(f196), "f"(f187));
  // PTX:241 sub.f32 %f63, %f152, %f193
  asm("sub.f32 %0, %1, %2;" : "=f"(f63) : "f"(f152), "f"(f193));
  // PTX:242 sub.f32 %f64, %f22, %f12
  asm("sub.f32 %0, %1, %2;" : "=f"(f64) : "f"(f22), "f"(f12));
  // PTX:243 mul.f32 %f153, %f64, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f64), "f"(f64));
  // PTX:244 sub.f32 %f65, %f23, %f13
  asm("sub.f32 %0, %1, %2;" : "=f"(f65) : "f"(f23), "f"(f13));
  // PTX:245 sub.f32 %f66, %f24, %f14
  asm("sub.f32 %0, %1, %2;" : "=f"(f66) : "f"(f24), "f"(f14));
  // PTX:246 fma.rn.f32 %f154, %f65, %f65, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f65), "f"(f65), "f"(f153));
  // PTX:247 fma.rn.f32 %f155, %f66, %f66, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f66), "f"(f66), "f"(f154));
  // PTX:248 sqrt.rn.f32 %f67, %f155
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f67) : "f"(f155));
  // PTX:249 setp.leu.f32 %p13, %f67, 0f00000000
  p13 = ((isnan(((float)(f67))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f67)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:250 mov.f32 %f197, %f196
  asm("mov.f32 %0, %1;" : "=f"(f197) : "f"(f196));
  // PTX:251 mov.f32 %f198, %f196
  asm("mov.f32 %0, %1;" : "=f"(f198) : "f"(f196));
  // PTX:252 @%p13 bra $L__BB14_16
  if (p13) { goto L_BB14_16; }
  // PTX:254 add.f32 %f156, %f67, 0fBFB504F3
  asm("add.f32 %0, %1, 0fBFB504F3;" : "=f"(f156) : "f"(f67));
  // PTX:255 abs.f32 %f157, %f156
  asm("abs.f32 %0, %1;" : "=f"(f157) : "f"(f156));
  // PTX:256 setp.le.f32 %p14, %f157, 0f35B504F3
  p14 = (!(isnan(((float)(f157))) || isnan(((float)(as_f32(0x35B504F3u))))) && (((float)(f157)) <= ((float)(as_f32(0x35B504F3u)))));
  // PTX:257 selp.f32 %f158, 0f00000000, %f156, %p14
  f158 = p14 ? as_f32(0x00000000u) : f156;
  // PTX:258 mul.f32 %f159, %f1, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f1), "f"(f158));
  // PTX:259 mul.f32 %f160, %f64, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f64), "f"(f159));
  // PTX:260 mul.f32 %f161, %f65, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f161) : "f"(f65), "f"(f159));
  // PTX:261 mul.f32 %f162, %f66, %f159
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f66), "f"(f159));
  // PTX:262 div.rn.f32 %f198, %f160, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f198) : "f"(f160), "f"(f67));
  // PTX:263 div.rn.f32 %f197, %f161, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f197) : "f"(f161), "f"(f67));
  // PTX:264 div.rn.f32 %f196, %f162, %f67
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f196) : "f"(f162), "f"(f67));
  // PTX:266 $L__BB14_16:
L_BB14_16:;
  // PTX:267 mul.wide.s32 %rd38, %r6, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd38) : "r"(r6));
  // PTX:268 add.s64 %rd39, %rd12, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd12), "l"(rd38));
  // PTX:269 red.global.add.f32 [%rd39], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:270 add.s64 %rd40, %rd39, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd40) : "l"(rd39));
  // PTX:271 red.global.add.f32 [%rd40], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd40) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:272 add.s64 %rd41, %rd39, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd41) : "l"(rd39));
  // PTX:273 red.global.add.f32 [%rd41], 0f00000000
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd41) + (0)))), (float)(as_f32(0x00000000u)));
  // PTX:274 mul.lo.s64 %rd42, %rd9, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd42) : "l"(rd9));
  // PTX:275 add.s64 %rd43, %rd12, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd12), "l"(rd42));
  // PTX:276 red.global.add.f32 [%rd43], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))), (float)(f58));
  // PTX:277 add.s64 %rd44, %rd43, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd44) : "l"(rd43));
  // PTX:278 red.global.add.f32 [%rd44], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))), (float)(f59));
  // PTX:279 add.s64 %rd45, %rd43, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd45) : "l"(rd43));
  // PTX:280 red.global.add.f32 [%rd45], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))), (float)(f60));
  // PTX:281 mul.lo.s64 %rd46, %rd10, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd46) : "l"(rd10));
  // PTX:282 add.s64 %rd47, %rd12, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd47) : "l"(rd12), "l"(rd46));
  // PTX:283 add.f32 %f169, %f198, %f45
  asm("add.f32 %0, %1, %2;" : "=f"(f169) : "f"(f198), "f"(f45));
  // PTX:284 red.global.add.f32 [%rd47], %f169
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd47) + (0)))), (float)(f169));
  // PTX:285 add.s64 %rd48, %rd47, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd48) : "l"(rd47));
  // PTX:286 add.f32 %f171, %f197, %f46
  asm("add.f32 %0, %1, %2;" : "=f"(f171) : "f"(f197), "f"(f46));
  // PTX:287 red.global.add.f32 [%rd48], %f171
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))), (float)(f171));
  // PTX:288 add.s64 %rd49, %rd47, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd49) : "l"(rd47));
  // PTX:289 add.f32 %f173, %f196, %f47
  asm("add.f32 %0, %1, %2;" : "=f"(f173) : "f"(f196), "f"(f47));
  // PTX:290 red.global.add.f32 [%rd49], %f173
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))), (float)(f173));
  // PTX:291 mul.lo.s64 %rd50, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd50) : "l"(rd11));
  // PTX:292 add.s64 %rd51, %rd12, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd12), "l"(rd50));
  // PTX:293 sub.f32 %f175, %f61, %f198
  asm("sub.f32 %0, %1, %2;" : "=f"(f175) : "f"(f61), "f"(f198));
  // PTX:294 red.global.add.f32 [%rd51], %f175
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))), (float)(f175));
  // PTX:295 add.s64 %rd52, %rd51, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd52) : "l"(rd51));
  // PTX:296 sub.f32 %f177, %f62, %f197
  asm("sub.f32 %0, %1, %2;" : "=f"(f177) : "f"(f62), "f"(f197));
  // PTX:297 red.global.add.f32 [%rd52], %f177
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))), (float)(f177));
  // PTX:298 add.s64 %rd53, %rd51, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd53) : "l"(rd51));
  // PTX:299 sub.f32 %f179, %f63, %f196
  asm("sub.f32 %0, %1, %2;" : "=f"(f179) : "f"(f63), "f"(f196));
  // PTX:300 red.global.add.f32 [%rd53], %f179
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))), (float)(f179));
  // PTX:302 $L__BB14_17:
L_BB14_17:;
  // PTX:303 ret
  return;
}
