// 机械还原自 PTX：synreal::kernel::evaluate_body_point_line_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: ea7194d57a9e4cb90c18e56afbae50aa42187dcb25395c173a328791988053a2
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_body_point_line_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, float param11, unsigned long long param12, unsigned char param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124;
  // PTX:35 ld.param.s8 %rs1, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_13]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param13 + (0))));
  // PTX:36 ld.param.u64 %rd37, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_0]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:37 ld.param.u64 %rd38, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_2]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:38 ld.param.u64 %rd27, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_3]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:39 ld.param.u64 %rd28, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_4]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:40 ld.param.u64 %rd29, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_5]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:41 ld.param.u64 %rd30, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_6]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:42 ld.param.u64 %rd31, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_7]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:43 ld.param.u64 %rd32, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_8]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:44 ld.param.u64 %rd33, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_9]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:45 ld.param.f32 %f63, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_11]
  f63 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param11 + (0))));
  // PTX:46 ld.param.u64 %rd34, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_12]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:47 ld.param.u64 %rd39, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_14]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd40, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_15]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 ld.param.u64 %rd35, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_16]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:50 ld.param.u64 %rd36, [_ZN7synreal6kernel30evaluate_body_point_line_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEES6_PKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_fmbPS4_mmm_param_17]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:51 cvta.to.global.u64 %rd1, %rd39
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd39));
  // PTX:52 cvta.to.global.u64 %rd2, %rd37
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:53 cvta.to.global.u64 %rd3, %rd38
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:54 mov.u32 %r2, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r2) : "r"(blockIdx.x));
  // PTX:55 mov.u32 %r3, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r3) : "r"(blockDim.x));
  // PTX:56 mul.wide.u32 %rd41, %r2, %r3
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd41) : "r"(r2), "r"(r3));
  // PTX:57 mov.u32 %r4, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r4) : "r"(threadIdx.x));
  // PTX:58 cvt.u64.u32 %rd42, %r4
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd42) : "r"(r4));
  // PTX:59 add.s64 %rd4, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd41), "l"(rd42));
  // PTX:60 setp.ge.u64 %p1, %rd4, %rd40
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd40)));
  // PTX:61 @%p1 bra $L__BB33_18
  if (p1) { goto L_BB33_18; }
  // PTX:63 or.b64 %rd43, %rd4, %rd35
  asm("or.b64 %0, %1, %2;" : "=l"(rd43) : "l"(rd4), "l"(rd35));
  // PTX:64 and.b64 %rd44, %rd43, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd44) : "l"(rd43));
  // PTX:65 setp.eq.s64 %p2, %rd44, 0
  p2 = (((long long)(rd44)) == ((long long)(0)));
  // PTX:66 @%p2 bra $L__BB33_3
  if (p2) { goto L_BB33_3; }
  // PTX:68 div.u64 %rd119, %rd4, %rd35
  asm("div.u64 %0, %1, %2;" : "=l"(rd119) : "l"(rd4), "l"(rd35));
  // PTX:69 mul.lo.s64 %rd45, %rd119, %rd35
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd119), "l"(rd35));
  // PTX:70 sub.s64 %rd120, %rd4, %rd45
  asm("sub.s64 %0, %1, %2;" : "=l"(rd120) : "l"(rd4), "l"(rd45));
  // PTX:71 bra.uni $L__BB33_4
  goto L_BB33_4;
  // PTX:73 $L__BB33_3:
L_BB33_3:;
  // PTX:74 cvt.u32.u64 %r5, %rd35
  asm("cvt.u32.u64 %0, %1;" : "=r"(r5) : "l"(rd35));
  // PTX:75 cvt.u32.u64 %r6, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r6) : "l"(rd4));
  // PTX:76 div.u32 %r7, %r6, %r5
  asm("div.u32 %0, %1, %2;" : "=r"(r7) : "r"(r6), "r"(r5));
  // PTX:77 mul.lo.s32 %r8, %r7, %r5
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r8) : "r"(r7), "r"(r5));
  // PTX:78 sub.s32 %r9, %r6, %r8
  asm("sub.s32 %0, %1, %2;" : "=r"(r9) : "r"(r6), "r"(r8));
  // PTX:79 cvt.u64.u32 %rd119, %r7
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd119) : "r"(r7));
  // PTX:80 cvt.u64.u32 %rd120, %r9
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd120) : "r"(r9));
  // PTX:82 $L__BB33_4:
L_BB33_4:;
  // PTX:83 mul.lo.s64 %rd50, %rd119, %rd36
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd119), "l"(rd36));
  // PTX:84 cvt.u32.u64 %r1, %rd50
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd50));
  // PTX:85 cvta.to.global.u64 %rd51, %rd27
  rd51 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:86 shl.b64 %rd52, %rd120, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd52) : "l"(rd120));
  // PTX:87 add.s64 %rd53, %rd51, %rd52
  asm("add.s64 %0, %1, %2;" : "=l"(rd53) : "l"(rd51), "l"(rd52));
  // PTX:88 ld.global.s32 %rd11, [%rd53+4]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (4)))));
  // PTX:89 mov.u64 %rd121, 0
  asm("mov.u64 %0, 0;" : "=l"(rd121) : );
  // PTX:90 ld.global.u32 %r10, [%rd53]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd53) + (0)))));
  // PTX:91 mul.wide.s32 %rd54, %r10, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd54) : "r"(r10));
  // PTX:92 add.s64 %rd55, %rd3, %rd54
  asm("add.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd3), "l"(rd54));
  // PTX:93 ld.global.u32 %r11, [%rd55]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (0)))));
  // PTX:94 add.s32 %r12, %r11, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r12) : "r"(r11), "r"(r1));
  // PTX:95 ld.global.u32 %r13, [%rd55+4]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (4)))));
  // PTX:96 add.s32 %r14, %r13, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r1));
  // PTX:97 ld.global.u32 %r15, [%rd55+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (8)))));
  // PTX:98 add.s32 %r16, %r15, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r16) : "r"(r15), "r"(r1));
  // PTX:99 ld.global.u32 %r17, [%rd55+12]
  r17 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd55) + (12)))));
  // PTX:100 add.s32 %r18, %r17, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r18) : "r"(r17), "r"(r1));
  // PTX:101 cvta.to.global.u64 %rd56, %rd28
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:102 shl.b64 %rd57, %rd120, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd57) : "l"(rd120));
  // PTX:103 add.s64 %rd58, %rd56, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd56), "l"(rd57));
  // PTX:104 cvt.s64.s32 %rd12, %r12
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd12) : "r"(r12));
  // PTX:105 mul.wide.s32 %rd59, %r12, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd59) : "r"(r12));
  // PTX:106 add.s64 %rd60, %rd2, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd2), "l"(rd59));
  // PTX:107 ld.global.f32 %f64, [%rd60]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:108 ld.global.f32 %f1, [%rd58]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:109 ld.global.f32 %f65, [%rd60+4]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:110 ld.global.f32 %f66, [%rd60+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:111 cvt.s64.s32 %rd13, %r14
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r14));
  // PTX:112 mul.wide.s32 %rd61, %r14, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r14));
  // PTX:113 add.s64 %rd62, %rd2, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd2), "l"(rd61));
  // PTX:114 ld.global.f32 %f67, [%rd62]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:115 ld.global.f32 %f2, [%rd58+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:116 mul.f32 %f68, %f2, %f67
  asm("mul.f32 %0, %1, %2;" : "=f"(f68) : "f"(f2), "f"(f67));
  // PTX:117 ld.global.f32 %f69, [%rd62+4]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:118 mul.f32 %f70, %f2, %f69
  asm("mul.f32 %0, %1, %2;" : "=f"(f70) : "f"(f2), "f"(f69));
  // PTX:119 ld.global.f32 %f71, [%rd62+8]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:120 mul.f32 %f72, %f2, %f71
  asm("mul.f32 %0, %1, %2;" : "=f"(f72) : "f"(f2), "f"(f71));
  // PTX:121 fma.rn.f32 %f73, %f1, %f64, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f73) : "f"(f1), "f"(f64), "f"(f68));
  // PTX:122 fma.rn.f32 %f74, %f1, %f65, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f74) : "f"(f1), "f"(f65), "f"(f70));
  // PTX:123 fma.rn.f32 %f75, %f1, %f66, %f72
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f1), "f"(f66), "f"(f72));
  // PTX:124 cvt.s64.s32 %rd14, %r16
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r16));
  // PTX:125 mul.wide.s32 %rd63, %r16, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r16));
  // PTX:126 add.s64 %rd64, %rd2, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd2), "l"(rd63));
  // PTX:127 ld.global.f32 %f76, [%rd64]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:128 ld.global.f32 %f3, [%rd58+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:129 ld.global.f32 %f77, [%rd64+4]
  f77 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:130 ld.global.f32 %f78, [%rd64+8]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:131 fma.rn.f32 %f79, %f3, %f76, %f73
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f79) : "f"(f3), "f"(f76), "f"(f73));
  // PTX:132 fma.rn.f32 %f80, %f3, %f77, %f74
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f80) : "f"(f3), "f"(f77), "f"(f74));
  // PTX:133 fma.rn.f32 %f81, %f3, %f78, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f81) : "f"(f3), "f"(f78), "f"(f75));
  // PTX:134 cvt.s64.s32 %rd15, %r18
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r18));
  // PTX:135 mul.wide.s32 %rd65, %r18, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r18));
  // PTX:136 add.s64 %rd66, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd2), "l"(rd65));
  // PTX:137 ld.global.f32 %f82, [%rd66]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:138 ld.global.f32 %f4, [%rd58+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (12)))));
  // PTX:139 ld.global.f32 %f83, [%rd66+4]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:140 ld.global.f32 %f84, [%rd66+8]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:141 fma.rn.f32 %f5, %f4, %f82, %f79
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f4), "f"(f82), "f"(f79));
  // PTX:142 fma.rn.f32 %f6, %f4, %f83, %f80
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f4), "f"(f83), "f"(f80));
  // PTX:143 fma.rn.f32 %f7, %f4, %f84, %f81
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f4), "f"(f84), "f"(f81));
  // PTX:144 cvta.to.global.u64 %rd67, %rd31
  rd67 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:145 mul.lo.s64 %rd68, %rd120, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd68) : "l"(rd120));
  // PTX:146 add.s64 %rd69, %rd67, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd67), "l"(rd68));
  // PTX:147 ld.global.f32 %f189, [%rd69]
  f189 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:148 ld.global.f32 %f190, [%rd69+4]
  f190 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:149 ld.global.f32 %f191, [%rd69+8]
  f191 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:150 cvta.to.global.u64 %rd70, %rd32
  rd70 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:151 add.s64 %rd71, %rd70, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd70), "l"(rd68));
  // PTX:152 ld.global.f32 %f186, [%rd71]
  f186 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:153 ld.global.f32 %f187, [%rd71+4]
  f187 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:154 ld.global.f32 %f188, [%rd71+8]
  f188 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:155 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:156 cvta.to.global.u64 %rd72, %rd29
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd29));
  // PTX:157 add.s64 %rd16, %rd72, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd16) : "l"(rd72), "l"(rd57));
  // PTX:158 cvta.to.global.u64 %rd73, %rd30
  rd73 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:159 add.s64 %rd17, %rd73, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd17) : "l"(rd73), "l"(rd57));
  // PTX:160 mov.u64 %rd122, %rd121
  asm("mov.u64 %0, %1;" : "=l"(rd122) : "l"(rd121));
  // PTX:161 mov.u64 %rd123, %rd121
  asm("mov.u64 %0, %1;" : "=l"(rd123) : "l"(rd121));
  // PTX:162 mov.u64 %rd124, %rd121
  asm("mov.u64 %0, %1;" : "=l"(rd124) : "l"(rd121));
  // PTX:163 @%p3 bra $L__BB33_6
  if (p3) { goto L_BB33_6; }
  // PTX:165 shl.b64 %rd74, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd74) : "l"(rd11));
  // PTX:166 add.s64 %rd75, %rd3, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd3), "l"(rd74));
  // PTX:167 ld.global.u32 %r19, [%rd75]
  r19 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:168 add.s32 %r20, %r19, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r20) : "r"(r19), "r"(r1));
  // PTX:169 ld.global.u32 %r21, [%rd75+4]
  r21 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:170 add.s32 %r22, %r21, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r22) : "r"(r21), "r"(r1));
  // PTX:171 ld.global.u32 %r23, [%rd75+8]
  r23 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:172 add.s32 %r24, %r23, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r1));
  // PTX:173 ld.global.u32 %r25, [%rd75+12]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (12)))));
  // PTX:174 add.s32 %r26, %r25, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r1));
  // PTX:175 cvt.s64.s32 %rd121, %r20
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd121) : "r"(r20));
  // PTX:176 mul.wide.s32 %rd76, %r20, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd76) : "r"(r20));
  // PTX:177 add.s64 %rd77, %rd2, %rd76
  asm("add.s64 %0, %1, %2;" : "=l"(rd77) : "l"(rd2), "l"(rd76));
  // PTX:178 ld.global.f32 %f85, [%rd77]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))));
  // PTX:179 ld.global.f32 %f86, [%rd16]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:180 ld.global.f32 %f87, [%rd77+4]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (4)))));
  // PTX:181 ld.global.f32 %f88, [%rd77+8]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (8)))));
  // PTX:182 cvt.s64.s32 %rd122, %r22
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd122) : "r"(r22));
  // PTX:183 mul.wide.s32 %rd78, %r22, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd78) : "r"(r22));
  // PTX:184 add.s64 %rd79, %rd2, %rd78
  asm("add.s64 %0, %1, %2;" : "=l"(rd79) : "l"(rd2), "l"(rd78));
  // PTX:185 ld.global.f32 %f89, [%rd79]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (0)))));
  // PTX:186 ld.global.f32 %f90, [%rd16+4]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:187 mul.f32 %f91, %f90, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f90), "f"(f89));
  // PTX:188 ld.global.f32 %f92, [%rd79+4]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (4)))));
  // PTX:189 mul.f32 %f93, %f90, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f90), "f"(f92));
  // PTX:190 ld.global.f32 %f94, [%rd79+8]
  f94 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd79) + (8)))));
  // PTX:191 mul.f32 %f95, %f90, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f90), "f"(f94));
  // PTX:192 fma.rn.f32 %f96, %f86, %f85, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f96) : "f"(f86), "f"(f85), "f"(f91));
  // PTX:193 fma.rn.f32 %f97, %f86, %f87, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f97) : "f"(f86), "f"(f87), "f"(f93));
  // PTX:194 fma.rn.f32 %f98, %f86, %f88, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f86), "f"(f88), "f"(f95));
  // PTX:195 cvt.s64.s32 %rd123, %r24
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd123) : "r"(r24));
  // PTX:196 mul.wide.s32 %rd80, %r24, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd80) : "r"(r24));
  // PTX:197 add.s64 %rd81, %rd2, %rd80
  asm("add.s64 %0, %1, %2;" : "=l"(rd81) : "l"(rd2), "l"(rd80));
  // PTX:198 ld.global.f32 %f99, [%rd81]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))));
  // PTX:199 ld.global.f32 %f100, [%rd16+8]
  f100 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:200 ld.global.f32 %f101, [%rd81+4]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (4)))));
  // PTX:201 ld.global.f32 %f102, [%rd81+8]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (8)))));
  // PTX:202 fma.rn.f32 %f103, %f100, %f99, %f96
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f103) : "f"(f100), "f"(f99), "f"(f96));
  // PTX:203 fma.rn.f32 %f104, %f100, %f101, %f97
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f104) : "f"(f100), "f"(f101), "f"(f97));
  // PTX:204 fma.rn.f32 %f105, %f100, %f102, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f105) : "f"(f100), "f"(f102), "f"(f98));
  // PTX:205 cvt.s64.s32 %rd124, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd124) : "r"(r26));
  // PTX:206 mul.wide.s32 %rd82, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd82) : "r"(r26));
  // PTX:207 add.s64 %rd83, %rd2, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd2), "l"(rd82));
  // PTX:208 ld.global.f32 %f106, [%rd83]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:209 ld.global.f32 %f107, [%rd16+12]
  f107 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:210 ld.global.f32 %f108, [%rd83+4]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4)))));
  // PTX:211 ld.global.f32 %f109, [%rd83+8]
  f109 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (8)))));
  // PTX:212 fma.rn.f32 %f189, %f107, %f106, %f103
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f189) : "f"(f107), "f"(f106), "f"(f103));
  // PTX:213 fma.rn.f32 %f190, %f107, %f108, %f104
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f190) : "f"(f107), "f"(f108), "f"(f104));
  // PTX:214 fma.rn.f32 %f191, %f107, %f109, %f105
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f191) : "f"(f107), "f"(f109), "f"(f105));
  // PTX:215 ld.global.f32 %f110, [%rd17]
  f110 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:216 ld.global.f32 %f111, [%rd17+4]
  f111 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:217 mul.f32 %f112, %f111, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f112) : "f"(f111), "f"(f89));
  // PTX:218 mul.f32 %f113, %f111, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f113) : "f"(f111), "f"(f92));
  // PTX:219 mul.f32 %f114, %f111, %f94
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f111), "f"(f94));
  // PTX:220 fma.rn.f32 %f115, %f110, %f85, %f112
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f115) : "f"(f110), "f"(f85), "f"(f112));
  // PTX:221 fma.rn.f32 %f116, %f110, %f87, %f113
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f116) : "f"(f110), "f"(f87), "f"(f113));
  // PTX:222 fma.rn.f32 %f117, %f110, %f88, %f114
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f117) : "f"(f110), "f"(f88), "f"(f114));
  // PTX:223 ld.global.f32 %f118, [%rd17+8]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:224 fma.rn.f32 %f119, %f118, %f99, %f115
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f119) : "f"(f118), "f"(f99), "f"(f115));
  // PTX:225 fma.rn.f32 %f120, %f118, %f101, %f116
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f120) : "f"(f118), "f"(f101), "f"(f116));
  // PTX:226 fma.rn.f32 %f121, %f118, %f102, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f121) : "f"(f118), "f"(f102), "f"(f117));
  // PTX:227 ld.global.f32 %f122, [%rd17+12]
  f122 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:228 fma.rn.f32 %f186, %f122, %f106, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f186) : "f"(f122), "f"(f106), "f"(f119));
  // PTX:229 fma.rn.f32 %f187, %f122, %f108, %f120
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f187) : "f"(f122), "f"(f108), "f"(f120));
  // PTX:230 fma.rn.f32 %f188, %f122, %f109, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f188) : "f"(f122), "f"(f109), "f"(f121));
  // PTX:232 $L__BB33_6:
L_BB33_6:;
  // PTX:233 sub.f32 %f26, %f186, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f26) : "f"(f186), "f"(f189));
  // PTX:234 sub.f32 %f27, %f187, %f190
  asm("sub.f32 %0, %1, %2;" : "=f"(f27) : "f"(f187), "f"(f190));
  // PTX:235 mul.f32 %f124, %f27, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f27), "f"(f27));
  // PTX:236 sub.f32 %f28, %f188, %f191
  asm("sub.f32 %0, %1, %2;" : "=f"(f28) : "f"(f188), "f"(f191));
  // PTX:237 fma.rn.f32 %f125, %f26, %f26, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f125) : "f"(f26), "f"(f26), "f"(f124));
  // PTX:238 fma.rn.f32 %f29, %f28, %f28, %f125
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f29) : "f"(f28), "f"(f28), "f"(f125));
  // PTX:239 setp.leu.f32 %p4, %f29, 0f2B8CBCCC
  p4 = ((isnan(((float)(f29))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) || (((float)(f29)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:240 mov.f32 %f192, 0f00000000
  asm("mov.f32 %0, 0f00000000;" : "=f"(f192) : );
  // PTX:241 @%p4 bra $L__BB33_8
  if (p4) { goto L_BB33_8; }
  // PTX:243 sub.f32 %f126, %f5, %f189
  asm("sub.f32 %0, %1, %2;" : "=f"(f126) : "f"(f5), "f"(f189));
  // PTX:244 sub.f32 %f127, %f6, %f190
  asm("sub.f32 %0, %1, %2;" : "=f"(f127) : "f"(f6), "f"(f190));
  // PTX:245 mul.f32 %f128, %f127, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f27));
  // PTX:246 sub.f32 %f129, %f7, %f191
  asm("sub.f32 %0, %1, %2;" : "=f"(f129) : "f"(f7), "f"(f191));
  // PTX:247 fma.rn.f32 %f130, %f126, %f26, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f126), "f"(f26), "f"(f128));
  // PTX:248 fma.rn.f32 %f131, %f129, %f28, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f131) : "f"(f129), "f"(f28), "f"(f130));
  // PTX:249 div.rn.f32 %f132, %f131, %f29
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f132) : "f"(f131), "f"(f29));
  // PTX:250 cvt.sat.f32.f32 %f192, %f132
  asm("cvt.sat.f32.f32 %0, %1;" : "=f"(f192) : "f"(f132));
  // PTX:252 $L__BB33_8:
L_BB33_8:;
  // PTX:253 ld.global.f32 %f133, [%rd16]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (0)))));
  // PTX:254 mov.f32 %f134, 0f3F800000
  asm("mov.f32 %0, 0f3F800000;" : "=f"(f134) : );
  // PTX:255 sub.f32 %f135, %f134, %f192
  asm("sub.f32 %0, %1, %2;" : "=f"(f135) : "f"(f134), "f"(f192));
  // PTX:256 ld.global.f32 %f136, [%rd16+4]
  f136 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (4)))));
  // PTX:257 ld.global.f32 %f137, [%rd16+8]
  f137 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (8)))));
  // PTX:258 ld.global.f32 %f138, [%rd16+12]
  f138 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd16) + (12)))));
  // PTX:259 ld.global.f32 %f139, [%rd17]
  f139 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (0)))));
  // PTX:260 mul.f32 %f140, %f192, %f139
  asm("mul.f32 %0, %1, %2;" : "=f"(f140) : "f"(f192), "f"(f139));
  // PTX:261 ld.global.f32 %f141, [%rd17+4]
  f141 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (4)))));
  // PTX:262 mul.f32 %f142, %f192, %f141
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f192), "f"(f141));
  // PTX:263 ld.global.f32 %f143, [%rd17+8]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (8)))));
  // PTX:264 mul.f32 %f144, %f192, %f143
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f192), "f"(f143));
  // PTX:265 ld.global.f32 %f145, [%rd17+12]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd17) + (12)))));
  // PTX:266 mul.f32 %f146, %f192, %f145
  asm("mul.f32 %0, %1, %2;" : "=f"(f146) : "f"(f192), "f"(f145));
  // PTX:267 fma.rn.f32 %f32, %f133, %f135, %f140
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f32) : "f"(f133), "f"(f135), "f"(f140));
  // PTX:268 fma.rn.f32 %f33, %f135, %f136, %f142
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f33) : "f"(f135), "f"(f136), "f"(f142));
  // PTX:269 fma.rn.f32 %f34, %f135, %f137, %f144
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f135), "f"(f137), "f"(f144));
  // PTX:270 fma.rn.f32 %f35, %f135, %f138, %f146
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f135), "f"(f138), "f"(f146));
  // PTX:271 fma.rn.f32 %f147, %f26, %f192, %f189
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f26), "f"(f192), "f"(f189));
  // PTX:272 fma.rn.f32 %f148, %f27, %f192, %f190
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f27), "f"(f192), "f"(f190));
  // PTX:273 fma.rn.f32 %f149, %f28, %f192, %f191
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f149) : "f"(f28), "f"(f192), "f"(f191));
  // PTX:274 sub.f32 %f36, %f147, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f36) : "f"(f147), "f"(f5));
  // PTX:275 sub.f32 %f37, %f148, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f37) : "f"(f148), "f"(f6));
  // PTX:276 sub.f32 %f38, %f149, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f38) : "f"(f149), "f"(f7));
  // PTX:277 sub.s64 %rd26, %rd35, %rd34
  asm("sub.s64 %0, %1, %2;" : "=l"(rd26) : "l"(rd35), "l"(rd34));
  // PTX:278 setp.ge.u64 %p5, %rd120, %rd26
  p5 = (((unsigned long long)(rd120)) >= ((unsigned long long)(rd26)));
  // PTX:279 setp.eq.s16 %p6, %rs1, 0
  p6 = (((short)(rs1)) == ((short)(0)));
  // PTX:280 and.pred %p7, %p6, %p5
  p7 = ((p6) && (p5));
  // PTX:281 @%p7 bra $L__BB33_18
  if (p7) { goto L_BB33_18; }
  // PTX:283 cvta.to.global.u64 %rd84, %rd33
  rd84 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:284 shl.b64 %rd85, %rd120, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd85) : "l"(rd120));
  // PTX:285 add.s64 %rd86, %rd84, %rd85
  asm("add.s64 %0, %1, %2;" : "=l"(rd86) : "l"(rd84), "l"(rd85));
  // PTX:286 setp.lt.u64 %p8, %rd120, %rd26
  p8 = (((unsigned long long)(rd120)) < ((unsigned long long)(rd26)));
  // PTX:287 selp.f32 %f150, 0f3F800000, %f63, %p8
  f150 = p8 ? as_f32(0x3F800000u) : f63;
  // PTX:288 ld.global.f32 %f151, [%rd86]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))));
  // PTX:289 mul.f32 %f152, %f150, %f151
  asm("mul.f32 %0, %1, %2;" : "=f"(f152) : "f"(f150), "f"(f151));
  // PTX:290 mul.f32 %f39, %f36, %f152
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f36), "f"(f152));
  // PTX:291 mul.f32 %f40, %f37, %f152
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f37), "f"(f152));
  // PTX:292 mul.f32 %f41, %f38, %f152
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f38), "f"(f152));
  // PTX:293 mul.f32 %f153, %f40, %f40
  asm("mul.f32 %0, %1, %2;" : "=f"(f153) : "f"(f40), "f"(f40));
  // PTX:294 fma.rn.f32 %f154, %f39, %f39, %f153
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f154) : "f"(f39), "f"(f39), "f"(f153));
  // PTX:295 fma.rn.f32 %f155, %f41, %f41, %f154
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f41), "f"(f41), "f"(f154));
  // PTX:296 setp.le.f32 %p9, %f155, 0f2B8CBCCC
  p9 = (!(isnan(((float)(f155))) || isnan(((float)(as_f32(0x2B8CBCCCu))))) && (((float)(f155)) <= ((float)(as_f32(0x2B8CBCCCu)))));
  // PTX:297 @%p9 bra $L__BB33_18
  if (p9) { goto L_BB33_18; }
  // PTX:299 cvt.u32.u64 %r27, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r27) : "l"(rd11));
  // PTX:300 setp.lt.s32 %p10, %r27, 0
  p10 = (((int)(r27)) < ((int)(0)));
  // PTX:301 mul.f32 %f42, %f39, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f39), "f"(f2));
  // PTX:302 mul.f32 %f43, %f40, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f40), "f"(f2));
  // PTX:303 mul.f32 %f44, %f41, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f41), "f"(f2));
  // PTX:304 mul.f32 %f45, %f39, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f39), "f"(f3));
  // PTX:305 mul.f32 %f46, %f40, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f40), "f"(f3));
  // PTX:306 mul.f32 %f47, %f41, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f41), "f"(f3));
  // PTX:307 mul.f32 %f48, %f39, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f39), "f"(f4));
  // PTX:308 mul.f32 %f49, %f40, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f40), "f"(f4));
  // PTX:309 mul.f32 %f50, %f41, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f41), "f"(f4));
  // PTX:310 neg.f32 %f51, %f39
  asm("neg.f32 %0, %1;" : "=f"(f51) : "f"(f39));
  // PTX:311 neg.f32 %f52, %f40
  asm("neg.f32 %0, %1;" : "=f"(f52) : "f"(f40));
  // PTX:312 neg.f32 %f53, %f41
  asm("neg.f32 %0, %1;" : "=f"(f53) : "f"(f41));
  // PTX:313 mul.lo.s64 %rd87, %rd12, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd87) : "l"(rd12));
  // PTX:314 add.s64 %rd88, %rd1, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd1), "l"(rd87));
  // PTX:315 mul.f32 %f156, %f39, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f156) : "f"(f39), "f"(f1));
  // PTX:316 red.global.add.f32 [%rd88], %f156
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f156));
  // PTX:317 add.s64 %rd89, %rd88, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd89) : "l"(rd88));
  // PTX:318 mul.f32 %f158, %f40, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f158) : "f"(f40), "f"(f1));
  // PTX:319 red.global.add.f32 [%rd89], %f158
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f158));
  // PTX:320 add.s64 %rd90, %rd88, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd90) : "l"(rd88));
  // PTX:321 mul.f32 %f160, %f41, %f1
  asm("mul.f32 %0, %1, %2;" : "=f"(f160) : "f"(f41), "f"(f1));
  // PTX:322 red.global.add.f32 [%rd90], %f160
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f160));
  // PTX:323 @%p10 bra $L__BB33_12
  if (p10) { goto L_BB33_12; }
  // PTX:325 mul.lo.s64 %rd91, %rd121, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd91) : "l"(rd121));
  // PTX:326 add.s64 %rd92, %rd1, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd1), "l"(rd91));
  // PTX:327 mul.f32 %f162, %f32, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f162) : "f"(f32), "f"(f51));
  // PTX:328 red.global.add.f32 [%rd92], %f162
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f162));
  // PTX:329 add.s64 %rd93, %rd92, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd93) : "l"(rd92));
  // PTX:330 mul.f32 %f164, %f32, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f164) : "f"(f32), "f"(f52));
  // PTX:331 red.global.add.f32 [%rd93], %f164
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f164));
  // PTX:332 add.s64 %rd94, %rd92, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd94) : "l"(rd92));
  // PTX:333 mul.f32 %f166, %f32, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f166) : "f"(f32), "f"(f53));
  // PTX:334 red.global.add.f32 [%rd94], %f166
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f166));
  // PTX:336 $L__BB33_12:
L_BB33_12:;
  // PTX:337 mul.lo.s64 %rd95, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd95) : "l"(rd13));
  // PTX:338 add.s64 %rd96, %rd1, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd1), "l"(rd95));
  // PTX:339 red.global.add.f32 [%rd96], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f42));
  // PTX:340 add.s64 %rd97, %rd96, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd97) : "l"(rd96));
  // PTX:341 red.global.add.f32 [%rd97], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f43));
  // PTX:342 add.s64 %rd98, %rd96, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd98) : "l"(rd96));
  // PTX:343 red.global.add.f32 [%rd98], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f44));
  // PTX:344 mul.f32 %f54, %f35, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f35), "f"(f53));
  // PTX:345 mul.f32 %f55, %f35, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f35), "f"(f52));
  // PTX:346 mul.f32 %f56, %f35, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f35), "f"(f51));
  // PTX:347 mul.f32 %f57, %f34, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f57) : "f"(f34), "f"(f53));
  // PTX:348 mul.f32 %f58, %f34, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f34), "f"(f52));
  // PTX:349 mul.f32 %f59, %f34, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f59) : "f"(f34), "f"(f51));
  // PTX:350 mul.f32 %f60, %f33, %f53
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f33), "f"(f53));
  // PTX:351 mul.f32 %f61, %f33, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f61) : "f"(f33), "f"(f52));
  // PTX:352 mul.f32 %f62, %f33, %f51
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f33), "f"(f51));
  // PTX:353 @%p10 bra $L__BB33_14
  if (p10) { goto L_BB33_14; }
  // PTX:355 mul.lo.s64 %rd99, %rd122, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd99) : "l"(rd122));
  // PTX:356 add.s64 %rd100, %rd1, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd1), "l"(rd99));
  // PTX:357 red.global.add.f32 [%rd100], %f62
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f62));
  // PTX:358 add.s64 %rd101, %rd100, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd101) : "l"(rd100));
  // PTX:359 red.global.add.f32 [%rd101], %f61
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f61));
  // PTX:360 add.s64 %rd102, %rd100, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd102) : "l"(rd100));
  // PTX:361 red.global.add.f32 [%rd102], %f60
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f60));
  // PTX:363 $L__BB33_14:
L_BB33_14:;
  // PTX:364 mul.lo.s64 %rd103, %rd14, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd103) : "l"(rd14));
  // PTX:365 add.s64 %rd104, %rd1, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd1), "l"(rd103));
  // PTX:366 red.global.add.f32 [%rd104], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f45));
  // PTX:367 add.s64 %rd105, %rd104, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd105) : "l"(rd104));
  // PTX:368 red.global.add.f32 [%rd105], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f46));
  // PTX:369 add.s64 %rd106, %rd104, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd106) : "l"(rd104));
  // PTX:370 red.global.add.f32 [%rd106], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f47));
  // PTX:371 @%p10 bra $L__BB33_16
  if (p10) { goto L_BB33_16; }
  // PTX:373 mul.lo.s64 %rd107, %rd123, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd107) : "l"(rd123));
  // PTX:374 add.s64 %rd108, %rd1, %rd107
  asm("add.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd1), "l"(rd107));
  // PTX:375 red.global.add.f32 [%rd108], %f59
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f59));
  // PTX:376 add.s64 %rd109, %rd108, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd109) : "l"(rd108));
  // PTX:377 red.global.add.f32 [%rd109], %f58
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd109) + (0)))), (float)(f58));
  // PTX:378 add.s64 %rd110, %rd108, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd110) : "l"(rd108));
  // PTX:379 red.global.add.f32 [%rd110], %f57
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f57));
  // PTX:381 $L__BB33_16:
L_BB33_16:;
  // PTX:382 mul.lo.s64 %rd111, %rd15, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd111) : "l"(rd15));
  // PTX:383 add.s64 %rd112, %rd1, %rd111
  asm("add.s64 %0, %1, %2;" : "=l"(rd112) : "l"(rd1), "l"(rd111));
  // PTX:384 red.global.add.f32 [%rd112], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f48));
  // PTX:385 add.s64 %rd113, %rd112, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd113) : "l"(rd112));
  // PTX:386 red.global.add.f32 [%rd113], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd113) + (0)))), (float)(f49));
  // PTX:387 add.s64 %rd114, %rd112, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd114) : "l"(rd112));
  // PTX:388 red.global.add.f32 [%rd114], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f50));
  // PTX:389 @%p10 bra $L__BB33_18
  if (p10) { goto L_BB33_18; }
  // PTX:391 mul.lo.s64 %rd115, %rd124, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd115) : "l"(rd124));
  // PTX:392 add.s64 %rd116, %rd1, %rd115
  asm("add.s64 %0, %1, %2;" : "=l"(rd116) : "l"(rd1), "l"(rd115));
  // PTX:393 red.global.add.f32 [%rd116], %f56
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f56));
  // PTX:394 add.s64 %rd117, %rd116, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd117) : "l"(rd116));
  // PTX:395 red.global.add.f32 [%rd117], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd117) + (0)))), (float)(f55));
  // PTX:396 add.s64 %rd118, %rd116, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd118) : "l"(rd116));
  // PTX:397 red.global.add.f32 [%rd118], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f54));
  // PTX:399 $L__BB33_18:
L_BB33_18:;
  // PTX:400 ret
  return;
}
