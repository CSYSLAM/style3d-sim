// 机械还原自 PTX：synreal::kernel::add_spring_gauss_newton_hessian(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, float const*, float const*, glm::mat<3, 3, float, (glm::qualifier)0>*, int const*, synreal::BlockNonZeroEntry*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: a498e380397935371b16e5e4df320e79bf8e2f1961d60a168b2d13524a2ba0d5
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__add_spring_gauss_newton_hessian(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138, rd139, rd140, rd141, rd142, rd143, rd144, rd145, rd146, rd147, rd148, rd149, rd150, rd151, rd152, rd153, rd154, rd155, rd156, rd157;
  // PTX:28 ld.param.u64 %rd28, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_0]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:29 ld.param.u64 %rd29, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_1]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:30 ld.param.u64 %rd30, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_2]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:31 ld.param.u64 %rd31, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_3]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:32 ld.param.u64 %rd32, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_4]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:33 ld.param.u64 %rd37, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_5]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:34 ld.param.u64 %rd38, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_6]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:35 ld.param.u64 %rd39, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_8]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:36 ld.param.u64 %rd34, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_9]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:37 ld.param.u64 %rd35, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_10]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:38 ld.param.u64 %rd36, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_11]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:39 cvta.to.global.u64 %rd1, %rd38
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:40 cvta.to.global.u64 %rd2, %rd37
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:41 mov.u32 %r21, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r21) : "r"(blockIdx.x));
  // PTX:42 mov.u32 %r22, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r22) : "r"(blockDim.x));
  // PTX:43 mul.wide.u32 %rd40, %r21, %r22
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd40) : "r"(r21), "r"(r22));
  // PTX:44 mov.u32 %r23, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r23) : "r"(threadIdx.x));
  // PTX:45 cvt.u64.u32 %rd41, %r23
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd41) : "r"(r23));
  // PTX:46 add.s64 %rd3, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd3) : "l"(rd40), "l"(rd41));
  // PTX:47 setp.ge.u64 %p1, %rd3, %rd39
  p1 = (((unsigned long long)(rd3)) >= ((unsigned long long)(rd39)));
  // PTX:48 @%p1 bra $L__BB53_23
  if (p1) { goto L_BB53_23; }
  // PTX:50 or.b64 %rd42, %rd3, %rd34
  asm("or.b64 %0, %1, %2;" : "=l"(rd42) : "l"(rd3), "l"(rd34));
  // PTX:51 and.b64 %rd43, %rd42, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd43) : "l"(rd42));
  // PTX:52 setp.eq.s64 %p2, %rd43, 0
  p2 = (((long long)(rd43)) == ((long long)(0)));
  // PTX:53 @%p2 bra $L__BB53_3
  if (p2) { goto L_BB53_3; }
  // PTX:55 div.u64 %rd150, %rd3, %rd34
  asm("div.u64 %0, %1, %2;" : "=l"(rd150) : "l"(rd3), "l"(rd34));
  // PTX:56 mul.lo.s64 %rd44, %rd150, %rd34
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd150), "l"(rd34));
  // PTX:57 sub.s64 %rd151, %rd3, %rd44
  asm("sub.s64 %0, %1, %2;" : "=l"(rd151) : "l"(rd3), "l"(rd44));
  // PTX:58 bra.uni $L__BB53_4
  goto L_BB53_4;
  // PTX:60 $L__BB53_3:
L_BB53_3:;
  // PTX:61 cvt.u32.u64 %r24, %rd34
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd34));
  // PTX:62 cvt.u32.u64 %r25, %rd3
  asm("cvt.u32.u64 %0, %1;" : "=r"(r25) : "l"(rd3));
  // PTX:63 div.u32 %r26, %r25, %r24
  asm("div.u32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r24));
  // PTX:64 mul.lo.s32 %r27, %r26, %r24
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r27) : "r"(r26), "r"(r24));
  // PTX:65 sub.s32 %r28, %r25, %r27
  asm("sub.s32 %0, %1, %2;" : "=r"(r28) : "r"(r25), "r"(r27));
  // PTX:66 cvt.u64.u32 %rd150, %r26
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd150) : "r"(r26));
  // PTX:67 cvt.u64.u32 %rd151, %r28
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd151) : "r"(r28));
  // PTX:69 $L__BB53_4:
L_BB53_4:;
  // PTX:70 cvta.to.global.u64 %rd45, %rd28
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:71 mul.lo.s64 %rd46, %rd150, %rd35
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd46) : "l"(rd150), "l"(rd35));
  // PTX:72 cvt.u32.u64 %r29, %rd46
  asm("cvt.u32.u64 %0, %1;" : "=r"(r29) : "l"(rd46));
  // PTX:73 cvta.to.global.u64 %rd47, %rd29
  rd47 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:74 shl.b64 %rd48, %rd151, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd48) : "l"(rd151));
  // PTX:75 add.s64 %rd49, %rd47, %rd48
  asm("add.s64 %0, %1, %2;" : "=l"(rd49) : "l"(rd47), "l"(rd48));
  // PTX:76 ld.global.u32 %r30, [%rd49]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (0)))));
  // PTX:77 add.s32 %r31, %r30, %r29
  asm("add.s32 %0, %1, %2;" : "=r"(r31) : "r"(r30), "r"(r29));
  // PTX:78 ld.global.u32 %r32, [%rd49+4]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd49) + (4)))));
  // PTX:79 add.s32 %r33, %r32, %r29
  asm("add.s32 %0, %1, %2;" : "=r"(r33) : "r"(r32), "r"(r29));
  // PTX:80 cvt.s64.s32 %rd10, %r31
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd10) : "r"(r31));
  // PTX:81 cvt.s64.s32 %rd11, %r33
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd11) : "r"(r33));
  // PTX:82 mul.wide.s32 %rd50, %r33, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd50) : "r"(r33));
  // PTX:83 add.s64 %rd51, %rd45, %rd50
  asm("add.s64 %0, %1, %2;" : "=l"(rd51) : "l"(rd45), "l"(rd50));
  // PTX:84 mul.wide.s32 %rd52, %r31, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd52) : "r"(r31));
  // PTX:85 add.s64 %rd53, %rd45, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd45), "l"(rd52));
  // PTX:86 ld.global.f32 %f16, [%rd53]
  f16 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:87 ld.global.f32 %f17, [%rd51]
  f17 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (0)))));
  // PTX:88 sub.f32 %f1, %f17, %f16
  asm("sub.f32 %0, %1, %2;" : "=f"(f1) : "f"(f17), "f"(f16));
  // PTX:89 ld.global.f32 %f18, [%rd53+4]
  f18 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:90 ld.global.f32 %f19, [%rd51+4]
  f19 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (4)))));
  // PTX:91 sub.f32 %f2, %f19, %f18
  asm("sub.f32 %0, %1, %2;" : "=f"(f2) : "f"(f19), "f"(f18));
  // PTX:92 ld.global.f32 %f20, [%rd53+8]
  f20 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (8)))));
  // PTX:93 ld.global.f32 %f21, [%rd51+8]
  f21 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd51) + (8)))));
  // PTX:94 sub.f32 %f3, %f21, %f20
  asm("sub.f32 %0, %1, %2;" : "=f"(f3) : "f"(f21), "f"(f20));
  // PTX:95 cvta.to.global.u64 %rd54, %rd30
  rd54 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:96 shl.b64 %rd55, %rd151, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd55) : "l"(rd151));
  // PTX:97 add.s64 %rd56, %rd54, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd54), "l"(rd55));
  // PTX:98 ld.global.f32 %f4, [%rd56]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:99 setp.leu.f32 %p3, %f4, 0f00000000
  p3 = ((isnan(((float)(f4))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f4)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:100 cvta.to.global.u64 %rd57, %rd31
  rd57 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:101 add.s64 %rd58, %rd57, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd57), "l"(rd55));
  // PTX:102 ld.global.f32 %f5, [%rd58]
  f5 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:103 setp.le.f32 %p4, %f5, 0f00000000
  p4 = (!(isnan(((float)(f5))) || isnan(((float)(as_f32(0x00000000u))))) && (((float)(f5)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:104 or.pred %p5, %p4, %p3
  p5 = ((p4) || (p3));
  // PTX:105 @%p5 bra $L__BB53_23
  if (p5) { goto L_BB53_23; }
  // PTX:107 mul.f32 %f22, %f2, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f2), "f"(f2));
  // PTX:108 fma.rn.f32 %f23, %f1, %f1, %f22
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f23) : "f"(f1), "f"(f1), "f"(f22));
  // PTX:109 fma.rn.f32 %f24, %f3, %f3, %f23
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f24) : "f"(f3), "f"(f3), "f"(f23));
  // PTX:110 sqrt.rn.f32 %f6, %f24
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f6) : "f"(f24));
  // PTX:111 setp.le.f32 %p6, %f6, 0f322BCC77
  p6 = (!(isnan(((float)(f6))) || isnan(((float)(as_f32(0x322BCC77u))))) && (((float)(f6)) <= ((float)(as_f32(0x322BCC77u)))));
  // PTX:112 mov.u32 %r51, 1065353216
  asm("mov.u32 %0, 1065353216;" : "=r"(r51) : );
  // PTX:113 mov.u32 %r52, 0
  asm("mov.u32 %0, 0;" : "=r"(r52) : );
  // PTX:114 mov.u32 %r53, %r52
  asm("mov.u32 %0, %1;" : "=r"(r53) : "r"(r52));
  // PTX:115 mov.u32 %r54, %r51
  asm("mov.u32 %0, %1;" : "=r"(r54) : "r"(r51));
  // PTX:116 mov.u32 %r55, %r52
  asm("mov.u32 %0, %1;" : "=r"(r55) : "r"(r52));
  // PTX:117 mov.u32 %r56, %r51
  asm("mov.u32 %0, %1;" : "=r"(r56) : "r"(r51));
  // PTX:118 @%p6 bra $L__BB53_7
  if (p6) { goto L_BB53_7; }
  // PTX:120 div.rn.f32 %f25, %f1, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f25) : "f"(f1), "f"(f6));
  // PTX:121 mul.f32 %f26, %f25, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f25), "f"(f25));
  // PTX:122 div.rn.f32 %f27, %f2, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f27) : "f"(f2), "f"(f6));
  // PTX:123 mul.f32 %f28, %f27, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f28) : "f"(f27), "f"(f25));
  // PTX:124 div.rn.f32 %f29, %f3, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f29) : "f"(f3), "f"(f6));
  // PTX:125 mul.f32 %f30, %f29, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f30) : "f"(f29), "f"(f25));
  // PTX:126 mul.f32 %f31, %f27, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f27), "f"(f27));
  // PTX:127 mul.f32 %f32, %f29, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f32) : "f"(f29), "f"(f27));
  // PTX:128 mul.f32 %f33, %f29, %f29
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f29), "f"(f29));
  // PTX:129 div.rn.f32 %f34, %f5, %f6
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f34) : "f"(f5), "f"(f6));
  // PTX:130 mov.f32 %f35, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f35) : );
  // PTX:131 sub.f32 %f36, %f35, %f34
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f35), "f"(f34));
  // PTX:132 mov.f32 %f37, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f37) : );
  // PTX:133 max.f32 %f38, %f37, %f36
  asm("max.f32 %0, %1, %2;" : "=f"(f38) : "f"(f37), "f"(f36));
  // PTX:134 sub.f32 %f39, %f35, %f26
  asm("sub.f32 %0, %1, %2;" : "=f"(f39) : "f"(f35), "f"(f26));
  // PTX:135 sub.f32 %f40, %f37, %f28
  asm("sub.f32 %0, %1, %2;" : "=f"(f40) : "f"(f37), "f"(f28));
  // PTX:136 sub.f32 %f41, %f37, %f30
  asm("sub.f32 %0, %1, %2;" : "=f"(f41) : "f"(f37), "f"(f30));
  // PTX:137 sub.f32 %f42, %f35, %f31
  asm("sub.f32 %0, %1, %2;" : "=f"(f42) : "f"(f35), "f"(f31));
  // PTX:138 sub.f32 %f43, %f37, %f32
  asm("sub.f32 %0, %1, %2;" : "=f"(f43) : "f"(f37), "f"(f32));
  // PTX:139 sub.f32 %f44, %f35, %f33
  asm("sub.f32 %0, %1, %2;" : "=f"(f44) : "f"(f35), "f"(f33));
  // PTX:140 fma.rn.f32 %f45, %f39, %f38, %f26
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f45) : "f"(f39), "f"(f38), "f"(f26));
  // PTX:141 fma.rn.f32 %f46, %f40, %f38, %f28
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f46) : "f"(f40), "f"(f38), "f"(f28));
  // PTX:142 fma.rn.f32 %f47, %f41, %f38, %f30
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f47) : "f"(f41), "f"(f38), "f"(f30));
  // PTX:143 fma.rn.f32 %f48, %f42, %f38, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f48) : "f"(f42), "f"(f38), "f"(f31));
  // PTX:144 fma.rn.f32 %f49, %f43, %f38, %f32
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f49) : "f"(f43), "f"(f38), "f"(f32));
  // PTX:145 fma.rn.f32 %f50, %f44, %f38, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f50) : "f"(f44), "f"(f38), "f"(f33));
  // PTX:146 mov.b32 %r56, %f50
  asm("mov.b32 %0, %1;" : "=r"(r56) : "f"(f50));
  // PTX:147 mov.b32 %r55, %f49
  asm("mov.b32 %0, %1;" : "=r"(r55) : "f"(f49));
  // PTX:148 mov.b32 %r53, %f47
  asm("mov.b32 %0, %1;" : "=r"(r53) : "f"(f47));
  // PTX:149 mov.b32 %r54, %f48
  asm("mov.b32 %0, %1;" : "=r"(r54) : "f"(f48));
  // PTX:150 mov.b32 %r52, %f46
  asm("mov.b32 %0, %1;" : "=r"(r52) : "f"(f46));
  // PTX:151 mov.b32 %r51, %f45
  asm("mov.b32 %0, %1;" : "=r"(r51) : "f"(f45));
  // PTX:153 $L__BB53_7:
L_BB53_7:;
  // PTX:154 cvta.to.global.u64 %rd59, %rd32
  rd59 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:155 mov.b32 %f51, %r51
  asm("mov.b32 %0, %1;" : "=f"(f51) : "r"(r51));
  // PTX:156 add.f32 %f52, %f51, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f52) : "f"(f51));
  // PTX:157 mov.b32 %f53, %r52
  asm("mov.b32 %0, %1;" : "=f"(f53) : "r"(r52));
  // PTX:158 mov.b32 %f54, %r53
  asm("mov.b32 %0, %1;" : "=f"(f54) : "r"(r53));
  // PTX:159 mov.b32 %f55, %r52
  asm("mov.b32 %0, %1;" : "=f"(f55) : "r"(r52));
  // PTX:160 mov.b32 %f56, %r54
  asm("mov.b32 %0, %1;" : "=f"(f56) : "r"(r54));
  // PTX:161 add.f32 %f57, %f56, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f57) : "f"(f56));
  // PTX:162 mov.b32 %f58, %r55
  asm("mov.b32 %0, %1;" : "=f"(f58) : "r"(r55));
  // PTX:163 mov.b32 %f59, %r53
  asm("mov.b32 %0, %1;" : "=f"(f59) : "r"(r53));
  // PTX:164 mov.b32 %f60, %r55
  asm("mov.b32 %0, %1;" : "=f"(f60) : "r"(r55));
  // PTX:165 mov.b32 %f61, %r56
  asm("mov.b32 %0, %1;" : "=f"(f61) : "r"(r56));
  // PTX:166 add.f32 %f62, %f61, 0fBF800000
  asm("add.f32 %0, %1, 0fBF800000;" : "=f"(f62) : "f"(f61));
  // PTX:167 mul.f32 %f63, %f4, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f4), "f"(f52));
  // PTX:168 mul.f32 %f64, %f4, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f64) : "f"(f4), "f"(f53));
  // PTX:169 mul.f32 %f65, %f4, %f54
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f4), "f"(f54));
  // PTX:170 mul.f32 %f66, %f4, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f66) : "f"(f4), "f"(f55));
  // PTX:171 mul.f32 %f67, %f4, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f4), "f"(f57));
  // PTX:172 mul.f32 %f68, %f4, %f58
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f4), "f"(f58));
  // PTX:173 mul.f32 %f69, %f4, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f69) : "f"(f4), "f"(f59));
  // PTX:174 mul.f32 %f70, %f4, %f60
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f4), "f"(f60));
  // PTX:175 mul.f32 %f71, %f4, %f62
  asm("mul.f32 %0, %1, %2;" : "=f"(f71) : "f"(f4), "f"(f62));
  // PTX:176 mul.lo.s64 %rd60, %rd10, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd60) : "l"(rd10));
  // PTX:177 add.s64 %rd12, %rd59, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd12) : "l"(rd59), "l"(rd60));
  // PTX:178 red.global.add.f32 [%rd12], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))), (float)(f63));
  // PTX:179 add.s64 %rd61, %rd12, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd61) : "l"(rd12));
  // PTX:180 red.global.add.f32 [%rd61], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f64));
  // PTX:181 add.s64 %rd62, %rd12, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd62) : "l"(rd12));
  // PTX:182 red.global.add.f32 [%rd62], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f65));
  // PTX:183 add.s64 %rd63, %rd12, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd63) : "l"(rd12));
  // PTX:184 red.global.add.f32 [%rd63], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f66));
  // PTX:185 add.s64 %rd64, %rd12, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd64) : "l"(rd12));
  // PTX:186 red.global.add.f32 [%rd64], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f67));
  // PTX:187 add.s64 %rd65, %rd12, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd65) : "l"(rd12));
  // PTX:188 red.global.add.f32 [%rd65], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f68));
  // PTX:189 add.s64 %rd66, %rd12, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd66) : "l"(rd12));
  // PTX:190 red.global.add.f32 [%rd66], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f69));
  // PTX:191 add.s64 %rd67, %rd12, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd67) : "l"(rd12));
  // PTX:192 red.global.add.f32 [%rd67], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f70));
  // PTX:193 add.s64 %rd68, %rd12, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd68) : "l"(rd12));
  // PTX:194 red.global.add.f32 [%rd68], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f71));
  // PTX:195 mul.lo.s64 %rd69, %rd11, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd69) : "l"(rd11));
  // PTX:196 add.s64 %rd13, %rd59, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd59), "l"(rd69));
  // PTX:197 red.global.add.f32 [%rd13], %f63
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))), (float)(f63));
  // PTX:198 add.s64 %rd70, %rd13, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd70) : "l"(rd13));
  // PTX:199 red.global.add.f32 [%rd70], %f64
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f64));
  // PTX:200 add.s64 %rd71, %rd13, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd71) : "l"(rd13));
  // PTX:201 red.global.add.f32 [%rd71], %f65
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f65));
  // PTX:202 add.s64 %rd72, %rd13, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd72) : "l"(rd13));
  // PTX:203 red.global.add.f32 [%rd72], %f66
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f66));
  // PTX:204 add.s64 %rd73, %rd13, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd73) : "l"(rd13));
  // PTX:205 red.global.add.f32 [%rd73], %f67
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f67));
  // PTX:206 add.s64 %rd74, %rd13, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd74) : "l"(rd13));
  // PTX:207 red.global.add.f32 [%rd74], %f68
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f68));
  // PTX:208 add.s64 %rd75, %rd13, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd75) : "l"(rd13));
  // PTX:209 red.global.add.f32 [%rd75], %f69
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))), (float)(f69));
  // PTX:210 add.s64 %rd76, %rd13, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd76) : "l"(rd13));
  // PTX:211 red.global.add.f32 [%rd76], %f70
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f70));
  // PTX:212 add.s64 %rd77, %rd13, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd77) : "l"(rd13));
  // PTX:213 red.global.add.f32 [%rd77], %f71
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f71));
  // PTX:214 neg.f32 %f7, %f63
  asm("neg.f32 %0, %1;" : "=f"(f7) : "f"(f63));
  // PTX:215 neg.f32 %f8, %f64
  asm("neg.f32 %0, %1;" : "=f"(f8) : "f"(f64));
  // PTX:216 neg.f32 %f9, %f65
  asm("neg.f32 %0, %1;" : "=f"(f9) : "f"(f65));
  // PTX:217 neg.f32 %f10, %f66
  asm("neg.f32 %0, %1;" : "=f"(f10) : "f"(f66));
  // PTX:218 neg.f32 %f11, %f67
  asm("neg.f32 %0, %1;" : "=f"(f11) : "f"(f67));
  // PTX:219 neg.f32 %f12, %f68
  asm("neg.f32 %0, %1;" : "=f"(f12) : "f"(f68));
  // PTX:220 neg.f32 %f13, %f69
  asm("neg.f32 %0, %1;" : "=f"(f13) : "f"(f69));
  // PTX:221 neg.f32 %f14, %f70
  asm("neg.f32 %0, %1;" : "=f"(f14) : "f"(f70));
  // PTX:222 neg.f32 %f15, %f71
  asm("neg.f32 %0, %1;" : "=f"(f15) : "f"(f71));
  // PTX:223 cvt.u32.u64 %r19, %rd10
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd10));
  // PTX:224 cvt.u32.u64 %r20, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r20) : "l"(rd11));
  // PTX:225 setp.eq.s32 %p7, %r19, %r20
  p7 = (((int)(r19)) == ((int)(r20)));
  // PTX:226 @%p7 bra $L__BB53_14
  if (p7) { goto L_BB53_14; }
  // PTX:227 bra.uni $L__BB53_8
  goto L_BB53_8;
  // PTX:229 $L__BB53_14:
L_BB53_14:;
  // PTX:230 red.global.add.f32 [%rd12], %f7
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd12) + (0)))), (float)(f7));
  // PTX:231 red.global.add.f32 [%rd61], %f8
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))), (float)(f8));
  // PTX:232 red.global.add.f32 [%rd62], %f9
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))), (float)(f9));
  // PTX:233 red.global.add.f32 [%rd63], %f10
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))), (float)(f10));
  // PTX:234 red.global.add.f32 [%rd64], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))), (float)(f11));
  // PTX:235 red.global.add.f32 [%rd65], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd65) + (0)))), (float)(f12));
  // PTX:236 red.global.add.f32 [%rd66], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))), (float)(f13));
  // PTX:237 red.global.add.f32 [%rd67], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))), (float)(f14));
  // PTX:238 red.global.add.f32 [%rd68], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))), (float)(f15));
  // PTX:239 bra.uni $L__BB53_15
  goto L_BB53_15;
  // PTX:241 $L__BB53_8:
L_BB53_8:;
  // PTX:242 ld.param.u64 %rd149, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd149 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:243 shl.b64 %rd79, %rd10, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd79) : "l"(rd10));
  // PTX:244 add.s64 %rd80, %rd2, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd2), "l"(rd79));
  // PTX:245 ld.global.s32 %rd81, [%rd80]
  rd81 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:246 mov.u64 %rd154, 0
  asm("mov.u64 %0, 0;" : "=l"(rd154) : );
  // PTX:247 min.u64 %rd14, %rd81, %rd149
  asm("min.u64 %0, %1, %2;" : "=l"(rd14) : "l"(rd81), "l"(rd149));
  // PTX:248 setp.eq.s64 %p8, %rd14, 0
  p8 = (((long long)(rd14)) == ((long long)(0)));
  // PTX:249 @%p8 bra $L__BB53_11
  if (p8) { goto L_BB53_11; }
  // PTX:251 mov.u64 %rd154, 0
  asm("mov.u64 %0, 0;" : "=l"(rd154) : );
  // PTX:252 mov.u64 %rd152, %rd14
  asm("mov.u64 %0, %1;" : "=l"(rd152) : "l"(rd14));
  // PTX:254 $L__BB53_10:
L_BB53_10:;
  // PTX:255 sub.s64 %rd83, %rd152, %rd154
  asm("sub.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd152), "l"(rd154));
  // PTX:256 shr.u64 %rd84, %rd83, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd84) : "l"(rd83));
  // PTX:257 add.s64 %rd85, %rd84, %rd154
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd84), "l"(rd154));
  // PTX:258 mul.lo.s64 %rd86, %rd85, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd85), "l"(rd36));
  // PTX:259 add.s64 %rd87, %rd86, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd86), "l"(rd10));
  // PTX:260 mul.lo.s64 %rd88, %rd87, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd88) : "l"(rd87));
  // PTX:261 add.s64 %rd89, %rd1, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd1), "l"(rd88));
  // PTX:262 ld.global.u32 %r43, [%rd89]
  r43 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:263 setp.lt.s32 %p9, %r43, %r20
  p9 = (((int)(r43)) < ((int)(r20)));
  // PTX:264 add.s64 %rd90, %rd85, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd90) : "l"(rd85));
  // PTX:265 selp.b64 %rd154, %rd90, %rd154, %p9
  rd154 = p9 ? rd90 : rd154;
  // PTX:266 selp.b64 %rd152, %rd152, %rd85, %p9
  rd152 = p9 ? rd152 : rd85;
  // PTX:267 setp.gt.u64 %p10, %rd152, %rd154
  p10 = (((unsigned long long)(rd152)) > ((unsigned long long)(rd154)));
  // PTX:268 @%p10 bra $L__BB53_10
  if (p10) { goto L_BB53_10; }
  // PTX:270 $L__BB53_11:
L_BB53_11:;
  // PTX:271 setp.ge.u64 %p11, %rd154, %rd14
  p11 = (((unsigned long long)(rd154)) >= ((unsigned long long)(rd14)));
  // PTX:272 @%p11 bra $L__BB53_15
  if (p11) { goto L_BB53_15; }
  // PTX:274 mul.lo.s64 %rd91, %rd154, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd154), "l"(rd36));
  // PTX:275 add.s64 %rd20, %rd91, %rd10
  asm("add.s64 %0, %1, %2;" : "=l"(rd20) : "l"(rd91), "l"(rd10));
  // PTX:276 mul.lo.s64 %rd92, %rd20, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd92) : "l"(rd20));
  // PTX:277 add.s64 %rd93, %rd1, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd1), "l"(rd92));
  // PTX:278 ld.global.u32 %r46, [%rd93]
  r46 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:279 setp.ne.s32 %p12, %r46, %r20
  p12 = (((int)(r46)) != ((int)(r20)));
  // PTX:280 @%p12 bra $L__BB53_15
  if (p12) { goto L_BB53_15; }
  // PTX:282 add.s64 %rd96, %rd93, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd96) : "l"(rd93));
  // PTX:283 red.global.add.f32 [%rd96], %f7
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f7));
  // PTX:284 add.s64 %rd97, %rd93, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd97) : "l"(rd93));
  // PTX:285 red.global.add.f32 [%rd97], %f8
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f8));
  // PTX:286 add.s64 %rd98, %rd93, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd98) : "l"(rd93));
  // PTX:287 red.global.add.f32 [%rd98], %f9
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f9));
  // PTX:288 add.s64 %rd99, %rd93, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd99) : "l"(rd93));
  // PTX:289 red.global.add.f32 [%rd99], %f10
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f10));
  // PTX:290 add.s64 %rd100, %rd93, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd100) : "l"(rd93));
  // PTX:291 red.global.add.f32 [%rd100], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f11));
  // PTX:292 add.s64 %rd101, %rd93, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd101) : "l"(rd93));
  // PTX:293 red.global.add.f32 [%rd101], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f12));
  // PTX:294 add.s64 %rd102, %rd93, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd102) : "l"(rd93));
  // PTX:295 red.global.add.f32 [%rd102], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f13));
  // PTX:296 add.s64 %rd103, %rd93, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd103) : "l"(rd93));
  // PTX:297 red.global.add.f32 [%rd103], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f14));
  // PTX:298 add.s64 %rd104, %rd93, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd104) : "l"(rd93));
  // PTX:299 red.global.add.f32 [%rd104], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f15));
  // PTX:301 $L__BB53_15:
L_BB53_15:;
  // PTX:302 @%p7 bra $L__BB53_22
  if (p7) { goto L_BB53_22; }
  // PTX:303 bra.uni $L__BB53_16
  goto L_BB53_16;
  // PTX:305 $L__BB53_22:
L_BB53_22:;
  // PTX:306 red.global.add.f32 [%rd13], %f7
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))), (float)(f7));
  // PTX:307 red.global.add.f32 [%rd70], %f8
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))), (float)(f8));
  // PTX:308 red.global.add.f32 [%rd71], %f9
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))), (float)(f9));
  // PTX:309 red.global.add.f32 [%rd72], %f10
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))), (float)(f10));
  // PTX:310 red.global.add.f32 [%rd73], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))), (float)(f11));
  // PTX:311 red.global.add.f32 [%rd74], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))), (float)(f12));
  // PTX:312 red.global.add.f32 [%rd75], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))), (float)(f13));
  // PTX:313 red.global.add.f32 [%rd76], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f14));
  // PTX:314 red.global.add.f32 [%rd77], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f15));
  // PTX:315 bra.uni $L__BB53_23
  goto L_BB53_23;
  // PTX:317 $L__BB53_16:
L_BB53_16:;
  // PTX:318 ld.param.u64 %rd148, [_ZN7synreal6kernel31add_spring_gauss_newton_hessianEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi2EiLS3_0EEEPKfSB_PNS1_3matILi3ELi3EfLS3_0EEEPKiPNS_17BlockNonZeroEntryEmmmmm_param_7]
  rd148 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:319 shl.b64 %rd114, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd114) : "l"(rd11));
  // PTX:320 add.s64 %rd115, %rd2, %rd114
  asm("add.s64 %0, %1, %2;" : "=l"(rd115) : "l"(rd2), "l"(rd114));
  // PTX:321 ld.global.s32 %rd116, [%rd115]
  rd116 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))));
  // PTX:322 mov.u64 %rd157, 0
  asm("mov.u64 %0, 0;" : "=l"(rd157) : );
  // PTX:323 min.u64 %rd21, %rd116, %rd148
  asm("min.u64 %0, %1, %2;" : "=l"(rd21) : "l"(rd116), "l"(rd148));
  // PTX:324 setp.eq.s64 %p14, %rd21, 0
  p14 = (((long long)(rd21)) == ((long long)(0)));
  // PTX:325 @%p14 bra $L__BB53_19
  if (p14) { goto L_BB53_19; }
  // PTX:327 mov.u64 %rd157, 0
  asm("mov.u64 %0, 0;" : "=l"(rd157) : );
  // PTX:328 mov.u64 %rd155, %rd21
  asm("mov.u64 %0, %1;" : "=l"(rd155) : "l"(rd21));
  // PTX:330 $L__BB53_18:
L_BB53_18:;
  // PTX:331 sub.s64 %rd118, %rd155, %rd157
  asm("sub.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd155), "l"(rd157));
  // PTX:332 shr.u64 %rd119, %rd118, 1
  asm("shr.u64 %0, %1, 1;" : "=l"(rd119) : "l"(rd118));
  // PTX:333 add.s64 %rd120, %rd119, %rd157
  asm("add.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd119), "l"(rd157));
  // PTX:334 mul.lo.s64 %rd121, %rd120, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd121) : "l"(rd120), "l"(rd36));
  // PTX:335 add.s64 %rd122, %rd121, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd122) : "l"(rd121), "l"(rd11));
  // PTX:336 mul.lo.s64 %rd123, %rd122, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd123) : "l"(rd122));
  // PTX:337 add.s64 %rd124, %rd1, %rd123
  asm("add.s64 %0, %1, %2;" : "=l"(rd124) : "l"(rd1), "l"(rd123));
  // PTX:338 ld.global.u32 %r47, [%rd124]
  r47 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))));
  // PTX:339 setp.lt.s32 %p15, %r47, %r19
  p15 = (((int)(r47)) < ((int)(r19)));
  // PTX:340 add.s64 %rd125, %rd120, 1
  asm("add.s64 %0, %1, 1;" : "=l"(rd125) : "l"(rd120));
  // PTX:341 selp.b64 %rd157, %rd125, %rd157, %p15
  rd157 = p15 ? rd125 : rd157;
  // PTX:342 selp.b64 %rd155, %rd155, %rd120, %p15
  rd155 = p15 ? rd155 : rd120;
  // PTX:343 setp.gt.u64 %p16, %rd155, %rd157
  p16 = (((unsigned long long)(rd155)) > ((unsigned long long)(rd157)));
  // PTX:344 @%p16 bra $L__BB53_18
  if (p16) { goto L_BB53_18; }
  // PTX:346 $L__BB53_19:
L_BB53_19:;
  // PTX:347 setp.ge.u64 %p17, %rd157, %rd21
  p17 = (((unsigned long long)(rd157)) >= ((unsigned long long)(rd21)));
  // PTX:348 @%p17 bra $L__BB53_23
  if (p17) { goto L_BB53_23; }
  // PTX:350 mul.lo.s64 %rd126, %rd157, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd157), "l"(rd36));
  // PTX:351 add.s64 %rd27, %rd126, %rd11
  asm("add.s64 %0, %1, %2;" : "=l"(rd27) : "l"(rd126), "l"(rd11));
  // PTX:352 mul.lo.s64 %rd127, %rd27, 40
  asm("mul.lo.s64 %0, %1, 40;" : "=l"(rd127) : "l"(rd27));
  // PTX:353 add.s64 %rd128, %rd1, %rd127
  asm("add.s64 %0, %1, %2;" : "=l"(rd128) : "l"(rd1), "l"(rd127));
  // PTX:354 ld.global.u32 %r50, [%rd128]
  r50 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))));
  // PTX:355 setp.ne.s32 %p18, %r50, %r19
  p18 = (((int)(r50)) != ((int)(r19)));
  // PTX:356 @%p18 bra $L__BB53_23
  if (p18) { goto L_BB53_23; }
  // PTX:358 add.s64 %rd131, %rd128, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd131) : "l"(rd128));
  // PTX:359 red.global.add.f32 [%rd131], %f7
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd131) + (0)))), (float)(f7));
  // PTX:360 add.s64 %rd132, %rd128, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd132) : "l"(rd128));
  // PTX:361 red.global.add.f32 [%rd132], %f8
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd132) + (0)))), (float)(f8));
  // PTX:362 add.s64 %rd133, %rd128, 12
  asm("add.s64 %0, %1, 12;" : "=l"(rd133) : "l"(rd128));
  // PTX:363 red.global.add.f32 [%rd133], %f9
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd133) + (0)))), (float)(f9));
  // PTX:364 add.s64 %rd134, %rd128, 16
  asm("add.s64 %0, %1, 16;" : "=l"(rd134) : "l"(rd128));
  // PTX:365 red.global.add.f32 [%rd134], %f10
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd134) + (0)))), (float)(f10));
  // PTX:366 add.s64 %rd135, %rd128, 20
  asm("add.s64 %0, %1, 20;" : "=l"(rd135) : "l"(rd128));
  // PTX:367 red.global.add.f32 [%rd135], %f11
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd135) + (0)))), (float)(f11));
  // PTX:368 add.s64 %rd136, %rd128, 24
  asm("add.s64 %0, %1, 24;" : "=l"(rd136) : "l"(rd128));
  // PTX:369 red.global.add.f32 [%rd136], %f12
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd136) + (0)))), (float)(f12));
  // PTX:370 add.s64 %rd137, %rd128, 28
  asm("add.s64 %0, %1, 28;" : "=l"(rd137) : "l"(rd128));
  // PTX:371 red.global.add.f32 [%rd137], %f13
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd137) + (0)))), (float)(f13));
  // PTX:372 add.s64 %rd138, %rd128, 32
  asm("add.s64 %0, %1, 32;" : "=l"(rd138) : "l"(rd128));
  // PTX:373 red.global.add.f32 [%rd138], %f14
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd138) + (0)))), (float)(f14));
  // PTX:374 add.s64 %rd139, %rd128, 36
  asm("add.s64 %0, %1, 36;" : "=l"(rd139) : "l"(rd128));
  // PTX:375 red.global.add.f32 [%rd139], %f15
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd139) + (0)))), (float)(f15));
  // PTX:377 $L__BB53_23:
L_BB53_23:;
  // PTX:378 ret
  return;
}
