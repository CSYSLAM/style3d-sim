// 机械还原自 PTX：synreal::kernel::evaluate_body_spring_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, float const*, float, unsigned long, bool, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 5c7e3e65aa48a5099441707dd429c8f745b9a9114e2a60db9850212c8d9a6356
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_body_spring_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, float param9, unsigned long long param10, unsigned char param11, unsigned long long param12, unsigned long long param13, unsigned long long param14, unsigned long long param15) {
  int p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17;
  unsigned short rs0, rs1;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130, rd131, rd132, rd133, rd134, rd135, rd136, rd137, rd138;
  // PTX:33 ld.param.s8 %rs1, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_11]
  rs1 = (*reinterpret_cast<volatile signed char*>(((uintptr_t)&param11 + (0))));
  // PTX:34 ld.param.u64 %rd42, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_0]
  rd42 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 ld.param.u64 %rd43, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_1]
  rd43 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:36 ld.param.u64 %rd32, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_2]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:37 ld.param.u64 %rd33, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_3]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:38 ld.param.u64 %rd34, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_4]
  rd34 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:39 ld.param.u64 %rd35, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_5]
  rd35 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:40 ld.param.u64 %rd36, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_6]
  rd36 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:41 ld.param.u64 %rd37, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_7]
  rd37 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:42 ld.param.u64 %rd38, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_8]
  rd38 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:43 ld.param.f32 %f56, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_9]
  f56 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:44 ld.param.u64 %rd39, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_10]
  rd39 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:45 ld.param.u64 %rd44, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_12]
  rd44 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:46 ld.param.u64 %rd45, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_13]
  rd45 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd40, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_14]
  rd40 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd41, [_ZN7synreal6kernel26evaluate_body_spring_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfSH_fmbPS4_mmm_param_15]
  rd41 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 cvta.to.global.u64 %rd1, %rd44
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd44));
  // PTX:50 cvta.to.global.u64 %rd2, %rd42
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd42));
  // PTX:51 cvta.to.global.u64 %rd3, %rd43
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd43));
  // PTX:52 mov.u32 %r8, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r8) : "r"(blockIdx.x));
  // PTX:53 mov.u32 %r9, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r9) : "r"(blockDim.x));
  // PTX:54 mul.wide.u32 %rd46, %r8, %r9
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd46) : "r"(r8), "r"(r9));
  // PTX:55 mov.u32 %r10, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r10) : "r"(threadIdx.x));
  // PTX:56 cvt.u64.u32 %rd47, %r10
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd47) : "r"(r10));
  // PTX:57 add.s64 %rd4, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd46), "l"(rd47));
  // PTX:58 setp.ge.u64 %p1, %rd4, %rd45
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd45)));
  // PTX:59 @%p1 bra $L__BB21_27
  if (p1) { goto L_BB21_27; }
  // PTX:61 or.b64 %rd48, %rd4, %rd40
  asm("or.b64 %0, %1, %2;" : "=l"(rd48) : "l"(rd4), "l"(rd40));
  // PTX:62 and.b64 %rd49, %rd48, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd49) : "l"(rd48));
  // PTX:63 setp.eq.s64 %p2, %rd49, 0
  p2 = (((long long)(rd49)) == ((long long)(0)));
  // PTX:64 @%p2 bra $L__BB21_3
  if (p2) { goto L_BB21_3; }
  // PTX:66 div.u64 %rd129, %rd4, %rd40
  asm("div.u64 %0, %1, %2;" : "=l"(rd129) : "l"(rd4), "l"(rd40));
  // PTX:67 mul.lo.s64 %rd50, %rd129, %rd40
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd129), "l"(rd40));
  // PTX:68 sub.s64 %rd130, %rd4, %rd50
  asm("sub.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd4), "l"(rd50));
  // PTX:69 bra.uni $L__BB21_4
  goto L_BB21_4;
  // PTX:71 $L__BB21_3:
L_BB21_3:;
  // PTX:72 cvt.u32.u64 %r11, %rd40
  asm("cvt.u32.u64 %0, %1;" : "=r"(r11) : "l"(rd40));
  // PTX:73 cvt.u32.u64 %r12, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r12) : "l"(rd4));
  // PTX:74 div.u32 %r13, %r12, %r11
  asm("div.u32 %0, %1, %2;" : "=r"(r13) : "r"(r12), "r"(r11));
  // PTX:75 mul.lo.s32 %r14, %r13, %r11
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r14) : "r"(r13), "r"(r11));
  // PTX:76 sub.s32 %r15, %r12, %r14
  asm("sub.s32 %0, %1, %2;" : "=r"(r15) : "r"(r12), "r"(r14));
  // PTX:77 cvt.u64.u32 %rd129, %r13
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd129) : "r"(r13));
  // PTX:78 cvt.u64.u32 %rd130, %r15
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd130) : "r"(r15));
  // PTX:80 $L__BB21_4:
L_BB21_4:;
  // PTX:81 mul.lo.s64 %rd55, %rd129, %rd41
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd55) : "l"(rd129), "l"(rd41));
  // PTX:82 cvt.u32.u64 %r1, %rd55
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd55));
  // PTX:83 cvta.to.global.u64 %rd56, %rd32
  rd56 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:84 shl.b64 %rd57, %rd130, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd57) : "l"(rd130));
  // PTX:85 add.s64 %rd58, %rd56, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd56), "l"(rd57));
  // PTX:86 ld.global.s32 %rd11, [%rd58]
  rd11 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:87 mov.u64 %rd135, 0
  asm("mov.u64 %0, 0;" : "=l"(rd135) : );
  // PTX:88 ld.global.s32 %rd12, [%rd58+4]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:89 cvta.to.global.u64 %rd59, %rd33
  rd59 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd33));
  // PTX:90 mul.lo.s64 %rd60, %rd130, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd60) : "l"(rd130));
  // PTX:91 add.s64 %rd61, %rd59, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd59), "l"(rd60));
  // PTX:92 ld.global.f32 %f157, [%rd61]
  f157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:93 ld.global.f32 %f156, [%rd61+4]
  f156 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:94 ld.global.f32 %f155, [%rd61+8]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:95 cvta.to.global.u64 %rd62, %rd34
  rd62 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd34));
  // PTX:96 add.s64 %rd63, %rd62, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd62), "l"(rd60));
  // PTX:97 ld.global.f32 %f160, [%rd63]
  f160 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:98 ld.global.f32 %f159, [%rd63+4]
  f159 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:99 ld.global.f32 %f158, [%rd63+8]
  f158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:100 setp.lt.s64 %p3, %rd11, 0
  p3 = (((long long)(rd11)) < ((long long)(0)));
  // PTX:101 cvta.to.global.u64 %rd64, %rd35
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd35));
  // PTX:102 shl.b64 %rd65, %rd130, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd65) : "l"(rd130));
  // PTX:103 add.s64 %rd13, %rd64, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd13) : "l"(rd64), "l"(rd65));
  // PTX:104 mov.u64 %rd131, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd131) : "l"(rd135));
  // PTX:105 mov.u64 %rd132, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd132) : "l"(rd135));
  // PTX:106 mov.u64 %rd133, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd133) : "l"(rd135));
  // PTX:107 mov.u64 %rd134, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd134) : "l"(rd135));
  // PTX:108 @%p3 bra $L__BB21_6
  if (p3) { goto L_BB21_6; }
  // PTX:110 shl.b64 %rd66, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd66) : "l"(rd11));
  // PTX:111 add.s64 %rd67, %rd3, %rd66
  asm("add.s64 %0, %1, %2;" : "=l"(rd67) : "l"(rd3), "l"(rd66));
  // PTX:112 ld.global.u32 %r16, [%rd67]
  r16 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (0)))));
  // PTX:113 add.s32 %r17, %r16, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r17) : "r"(r16), "r"(r1));
  // PTX:114 ld.global.u32 %r18, [%rd67+4]
  r18 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (4)))));
  // PTX:115 add.s32 %r19, %r18, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r19) : "r"(r18), "r"(r1));
  // PTX:116 ld.global.u32 %r20, [%rd67+8]
  r20 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (8)))));
  // PTX:117 add.s32 %r21, %r20, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r1));
  // PTX:118 ld.global.u32 %r22, [%rd67+12]
  r22 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd67) + (12)))));
  // PTX:119 add.s32 %r23, %r22, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r23) : "r"(r22), "r"(r1));
  // PTX:120 cvt.s64.s32 %rd131, %r17
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd131) : "r"(r17));
  // PTX:121 mul.wide.s32 %rd68, %r17, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd68) : "r"(r17));
  // PTX:122 add.s64 %rd69, %rd2, %rd68
  asm("add.s64 %0, %1, %2;" : "=l"(rd69) : "l"(rd2), "l"(rd68));
  // PTX:123 ld.global.f32 %f57, [%rd69]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (0)))));
  // PTX:124 ld.global.f32 %f58, [%rd13]
  f58 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:125 ld.global.f32 %f59, [%rd69+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (4)))));
  // PTX:126 ld.global.f32 %f60, [%rd69+8]
  f60 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd69) + (8)))));
  // PTX:127 cvt.s64.s32 %rd132, %r19
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd132) : "r"(r19));
  // PTX:128 mul.wide.s32 %rd70, %r19, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd70) : "r"(r19));
  // PTX:129 add.s64 %rd71, %rd2, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd2), "l"(rd70));
  // PTX:130 ld.global.f32 %f61, [%rd71]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:131 ld.global.f32 %f62, [%rd13+4]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:132 mul.f32 %f63, %f62, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f63) : "f"(f62), "f"(f61));
  // PTX:133 ld.global.f32 %f64, [%rd71+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:134 mul.f32 %f65, %f62, %f64
  asm("mul.f32 %0, %1, %2;" : "=f"(f65) : "f"(f62), "f"(f64));
  // PTX:135 ld.global.f32 %f66, [%rd71+8]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:136 mul.f32 %f67, %f62, %f66
  asm("mul.f32 %0, %1, %2;" : "=f"(f67) : "f"(f62), "f"(f66));
  // PTX:137 fma.rn.f32 %f68, %f58, %f57, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f58), "f"(f57), "f"(f63));
  // PTX:138 fma.rn.f32 %f69, %f58, %f59, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f58), "f"(f59), "f"(f65));
  // PTX:139 fma.rn.f32 %f70, %f58, %f60, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f58), "f"(f60), "f"(f67));
  // PTX:140 cvt.s64.s32 %rd133, %r21
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd133) : "r"(r21));
  // PTX:141 mul.wide.s32 %rd72, %r21, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd72) : "r"(r21));
  // PTX:142 add.s64 %rd73, %rd2, %rd72
  asm("add.s64 %0, %1, %2;" : "=l"(rd73) : "l"(rd2), "l"(rd72));
  // PTX:143 ld.global.f32 %f71, [%rd73]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (0)))));
  // PTX:144 ld.global.f32 %f72, [%rd13+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:145 ld.global.f32 %f73, [%rd73+4]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (4)))));
  // PTX:146 ld.global.f32 %f74, [%rd73+8]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd73) + (8)))));
  // PTX:147 fma.rn.f32 %f75, %f72, %f71, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f75) : "f"(f72), "f"(f71), "f"(f68));
  // PTX:148 fma.rn.f32 %f76, %f72, %f73, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f76) : "f"(f72), "f"(f73), "f"(f69));
  // PTX:149 fma.rn.f32 %f77, %f72, %f74, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f77) : "f"(f72), "f"(f74), "f"(f70));
  // PTX:150 cvt.s64.s32 %rd134, %r23
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd134) : "r"(r23));
  // PTX:151 mul.wide.s32 %rd74, %r23, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd74) : "r"(r23));
  // PTX:152 add.s64 %rd75, %rd2, %rd74
  asm("add.s64 %0, %1, %2;" : "=l"(rd75) : "l"(rd2), "l"(rd74));
  // PTX:153 ld.global.f32 %f78, [%rd75]
  f78 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (0)))));
  // PTX:154 ld.global.f32 %f79, [%rd13+12]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:155 ld.global.f32 %f80, [%rd75+4]
  f80 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (4)))));
  // PTX:156 ld.global.f32 %f81, [%rd75+8]
  f81 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd75) + (8)))));
  // PTX:157 fma.rn.f32 %f157, %f79, %f78, %f75
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f157) : "f"(f79), "f"(f78), "f"(f75));
  // PTX:158 fma.rn.f32 %f156, %f79, %f80, %f76
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f156) : "f"(f79), "f"(f80), "f"(f76));
  // PTX:159 fma.rn.f32 %f155, %f79, %f81, %f77
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f155) : "f"(f79), "f"(f81), "f"(f77));
  // PTX:161 $L__BB21_6:
L_BB21_6:;
  // PTX:162 cvt.u32.u64 %r24, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r24) : "l"(rd12));
  // PTX:163 setp.lt.s32 %p4, %r24, 0
  p4 = (((int)(r24)) < ((int)(0)));
  // PTX:164 cvta.to.global.u64 %rd80, %rd36
  rd80 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd36));
  // PTX:165 add.s64 %rd22, %rd80, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd22) : "l"(rd80), "l"(rd65));
  // PTX:166 mov.u64 %rd136, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd136) : "l"(rd135));
  // PTX:167 mov.u64 %rd137, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd137) : "l"(rd135));
  // PTX:168 mov.u64 %rd138, %rd135
  asm("mov.u64 %0, %1;" : "=l"(rd138) : "l"(rd135));
  // PTX:169 @%p4 bra $L__BB21_8
  if (p4) { goto L_BB21_8; }
  // PTX:171 shl.b64 %rd82, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd82) : "l"(rd12));
  // PTX:172 add.s64 %rd83, %rd3, %rd82
  asm("add.s64 %0, %1, %2;" : "=l"(rd83) : "l"(rd3), "l"(rd82));
  // PTX:173 ld.global.u32 %r25, [%rd83]
  r25 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (0)))));
  // PTX:174 add.s32 %r26, %r25, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r26) : "r"(r25), "r"(r1));
  // PTX:175 ld.global.u32 %r27, [%rd83+4]
  r27 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (4)))));
  // PTX:176 add.s32 %r28, %r27, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r28) : "r"(r27), "r"(r1));
  // PTX:177 ld.global.u32 %r29, [%rd83+8]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (8)))));
  // PTX:178 add.s32 %r30, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r1));
  // PTX:179 ld.global.u32 %r31, [%rd83+12]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd83) + (12)))));
  // PTX:180 add.s32 %r32, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r32) : "r"(r31), "r"(r1));
  // PTX:181 cvt.s64.s32 %rd136, %r26
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd136) : "r"(r26));
  // PTX:182 mul.wide.s32 %rd84, %r26, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd84) : "r"(r26));
  // PTX:183 add.s64 %rd85, %rd2, %rd84
  asm("add.s64 %0, %1, %2;" : "=l"(rd85) : "l"(rd2), "l"(rd84));
  // PTX:184 ld.global.f32 %f82, [%rd85]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))));
  // PTX:185 ld.global.f32 %f83, [%rd22]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:186 ld.global.f32 %f84, [%rd85+4]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (4)))));
  // PTX:187 ld.global.f32 %f85, [%rd85+8]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (8)))));
  // PTX:188 cvt.s64.s32 %rd135, %r28
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd135) : "r"(r28));
  // PTX:189 mul.wide.s32 %rd86, %r28, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd86) : "r"(r28));
  // PTX:190 add.s64 %rd87, %rd2, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd2), "l"(rd86));
  // PTX:191 ld.global.f32 %f86, [%rd87]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:192 ld.global.f32 %f87, [%rd22+4]
  f87 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:193 mul.f32 %f88, %f87, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f88) : "f"(f87), "f"(f86));
  // PTX:194 ld.global.f32 %f89, [%rd87+4]
  f89 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (4)))));
  // PTX:195 mul.f32 %f90, %f87, %f89
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f87), "f"(f89));
  // PTX:196 ld.global.f32 %f91, [%rd87+8]
  f91 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (8)))));
  // PTX:197 mul.f32 %f92, %f87, %f91
  asm("mul.f32 %0, %1, %2;" : "=f"(f92) : "f"(f87), "f"(f91));
  // PTX:198 fma.rn.f32 %f93, %f83, %f82, %f88
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f83), "f"(f82), "f"(f88));
  // PTX:199 fma.rn.f32 %f94, %f83, %f84, %f90
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f83), "f"(f84), "f"(f90));
  // PTX:200 fma.rn.f32 %f95, %f83, %f85, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f95) : "f"(f83), "f"(f85), "f"(f92));
  // PTX:201 cvt.s64.s32 %rd137, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd137) : "r"(r30));
  // PTX:202 mul.wide.s32 %rd88, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd88) : "r"(r30));
  // PTX:203 add.s64 %rd89, %rd2, %rd88
  asm("add.s64 %0, %1, %2;" : "=l"(rd89) : "l"(rd2), "l"(rd88));
  // PTX:204 ld.global.f32 %f96, [%rd89]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))));
  // PTX:205 ld.global.f32 %f97, [%rd22+8]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:206 ld.global.f32 %f98, [%rd89+4]
  f98 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (4)))));
  // PTX:207 ld.global.f32 %f99, [%rd89+8]
  f99 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (8)))));
  // PTX:208 fma.rn.f32 %f100, %f97, %f96, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f100) : "f"(f97), "f"(f96), "f"(f93));
  // PTX:209 fma.rn.f32 %f101, %f97, %f98, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f101) : "f"(f97), "f"(f98), "f"(f94));
  // PTX:210 fma.rn.f32 %f102, %f97, %f99, %f95
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f102) : "f"(f97), "f"(f99), "f"(f95));
  // PTX:211 cvt.s64.s32 %rd138, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd138) : "r"(r32));
  // PTX:212 mul.wide.s32 %rd90, %r32, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd90) : "r"(r32));
  // PTX:213 add.s64 %rd91, %rd2, %rd90
  asm("add.s64 %0, %1, %2;" : "=l"(rd91) : "l"(rd2), "l"(rd90));
  // PTX:214 ld.global.f32 %f103, [%rd91]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (0)))));
  // PTX:215 ld.global.f32 %f104, [%rd22+12]
  f104 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (12)))));
  // PTX:216 ld.global.f32 %f105, [%rd91+4]
  f105 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (4)))));
  // PTX:217 ld.global.f32 %f106, [%rd91+8]
  f106 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd91) + (8)))));
  // PTX:218 fma.rn.f32 %f160, %f104, %f103, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f104), "f"(f103), "f"(f100));
  // PTX:219 fma.rn.f32 %f159, %f104, %f105, %f101
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f159) : "f"(f104), "f"(f105), "f"(f101));
  // PTX:220 fma.rn.f32 %f158, %f104, %f106, %f102
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f158) : "f"(f104), "f"(f106), "f"(f102));
  // PTX:222 $L__BB21_8:
L_BB21_8:;
  // PTX:223 sub.f32 %f19, %f160, %f157
  asm("sub.f32 %0, %1, %2;" : "=f"(f19) : "f"(f160), "f"(f157));
  // PTX:224 sub.f32 %f20, %f159, %f156
  asm("sub.f32 %0, %1, %2;" : "=f"(f20) : "f"(f159), "f"(f156));
  // PTX:225 sub.f32 %f21, %f158, %f155
  asm("sub.f32 %0, %1, %2;" : "=f"(f21) : "f"(f158), "f"(f155));
  // PTX:226 sub.s64 %rd31, %rd40, %rd39
  asm("sub.s64 %0, %1, %2;" : "=l"(rd31) : "l"(rd40), "l"(rd39));
  // PTX:227 setp.ge.u64 %p5, %rd130, %rd31
  p5 = (((unsigned long long)(rd130)) >= ((unsigned long long)(rd31)));
  // PTX:228 setp.eq.s16 %p6, %rs1, 0
  p6 = (((short)(rs1)) == ((short)(0)));
  // PTX:229 and.pred %p7, %p6, %p5
  p7 = ((p6) && (p5));
  // PTX:230 @%p7 bra $L__BB21_27
  if (p7) { goto L_BB21_27; }
  // PTX:232 cvta.to.global.u64 %rd92, %rd37
  rd92 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd37));
  // PTX:233 shl.b64 %rd93, %rd130, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd93) : "l"(rd130));
  // PTX:234 add.s64 %rd94, %rd92, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd94) : "l"(rd92), "l"(rd93));
  // PTX:235 setp.lt.u64 %p8, %rd130, %rd31
  p8 = (((unsigned long long)(rd130)) < ((unsigned long long)(rd31)));
  // PTX:236 selp.f32 %f107, 0f3F800000, %f56, %p8
  f107 = p8 ? as_f32(0x3F800000u) : f56;
  // PTX:237 ld.global.f32 %f108, [%rd94]
  f108 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))));
  // PTX:238 mul.f32 %f22, %f107, %f108
  asm("mul.f32 %0, %1, %2;" : "=f"(f22) : "f"(f107), "f"(f108));
  // PTX:239 cvta.to.global.u64 %rd95, %rd38
  rd95 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd38));
  // PTX:240 add.s64 %rd96, %rd95, %rd93
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd95), "l"(rd93));
  // PTX:241 ld.global.f32 %f23, [%rd96]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:242 mul.f32 %f109, %f19, %f19
  asm("mul.f32 %0, %1, %2;" : "=f"(f109) : "f"(f19), "f"(f19));
  // PTX:243 fma.rn.f32 %f110, %f20, %f20, %f109
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f110) : "f"(f20), "f"(f20), "f"(f109));
  // PTX:244 fma.rn.f32 %f111, %f21, %f21, %f110
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f111) : "f"(f21), "f"(f21), "f"(f110));
  // PTX:245 sqrt.rn.f32 %f24, %f111
  asm("sqrt.rn.f32 %0, %1;" : "=f"(f24) : "f"(f111));
  // PTX:246 setp.leu.f32 %p9, %f24, 0f00000000
  p9 = ((isnan(((float)(f24))) || isnan(((float)(as_f32(0x00000000u))))) || (((float)(f24)) <= ((float)(as_f32(0x00000000u)))));
  // PTX:247 mov.u32 %r44, 0
  asm("mov.u32 %0, 0;" : "=r"(r44) : );
  // PTX:248 mov.u32 %r45, %r44
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r44));
  // PTX:249 mov.u32 %r46, %r44
  asm("mov.u32 %0, %1;" : "=r"(r46) : "r"(r44));
  // PTX:250 @%p9 bra $L__BB21_11
  if (p9) { goto L_BB21_11; }
  // PTX:252 div.rn.f32 %f112, %f19, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f112) : "f"(f19), "f"(f24));
  // PTX:253 div.rn.f32 %f113, %f20, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f113) : "f"(f20), "f"(f24));
  // PTX:254 div.rn.f32 %f114, %f21, %f24
  asm("div.rn.f32 %0, %1, %2;" : "=f"(f114) : "f"(f21), "f"(f24));
  // PTX:255 mov.b32 %r46, %f114
  asm("mov.b32 %0, %1;" : "=r"(r46) : "f"(f114));
  // PTX:256 mov.b32 %r45, %f113
  asm("mov.b32 %0, %1;" : "=r"(r45) : "f"(f113));
  // PTX:257 mov.b32 %r44, %f112
  asm("mov.b32 %0, %1;" : "=r"(r44) : "f"(f112));
  // PTX:259 $L__BB21_11:
L_BB21_11:;
  // PTX:260 cvt.u32.u64 %r36, %rd11
  asm("cvt.u32.u64 %0, %1;" : "=r"(r36) : "l"(rd11));
  // PTX:261 setp.lt.s32 %p10, %r36, 0
  p10 = (((int)(r36)) < ((int)(0)));
  // PTX:262 mov.b32 %f115, %r44
  asm("mov.b32 %0, %1;" : "=f"(f115) : "r"(r44));
  // PTX:263 mul.f32 %f116, %f23, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f23), "f"(f115));
  // PTX:264 mov.b32 %f117, %r45
  asm("mov.b32 %0, %1;" : "=f"(f117) : "r"(r45));
  // PTX:265 mul.f32 %f118, %f23, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f23), "f"(f117));
  // PTX:266 mov.b32 %f119, %r46
  asm("mov.b32 %0, %1;" : "=f"(f119) : "r"(r46));
  // PTX:267 mul.f32 %f120, %f23, %f119
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f23), "f"(f119));
  // PTX:268 sub.f32 %f121, %f19, %f116
  asm("sub.f32 %0, %1, %2;" : "=f"(f121) : "f"(f19), "f"(f116));
  // PTX:269 sub.f32 %f122, %f20, %f118
  asm("sub.f32 %0, %1, %2;" : "=f"(f122) : "f"(f20), "f"(f118));
  // PTX:270 sub.f32 %f123, %f21, %f120
  asm("sub.f32 %0, %1, %2;" : "=f"(f123) : "f"(f21), "f"(f120));
  // PTX:271 mul.f32 %f25, %f22, %f121
  asm("mul.f32 %0, %1, %2;" : "=f"(f25) : "f"(f22), "f"(f121));
  // PTX:272 mul.f32 %f26, %f22, %f122
  asm("mul.f32 %0, %1, %2;" : "=f"(f26) : "f"(f22), "f"(f122));
  // PTX:273 mul.f32 %f27, %f22, %f123
  asm("mul.f32 %0, %1, %2;" : "=f"(f27) : "f"(f22), "f"(f123));
  // PTX:274 ld.global.f32 %f28, [%rd13+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (4)))));
  // PTX:275 ld.global.f32 %f29, [%rd13+8]
  f29 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (8)))));
  // PTX:276 ld.global.f32 %f30, [%rd13+12]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (12)))));
  // PTX:277 ld.global.f32 %f31, [%rd22]
  f31 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (0)))));
  // PTX:278 ld.global.f32 %f32, [%rd22+4]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (4)))));
  // PTX:279 ld.global.f32 %f33, [%rd22+8]
  f33 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (8)))));
  // PTX:280 ld.global.f32 %f34, [%rd22+12]
  f34 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd22) + (12)))));
  // PTX:281 @%p10 bra $L__BB21_13
  if (p10) { goto L_BB21_13; }
  // PTX:283 ld.global.f32 %f124, [%rd13]
  f124 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd13) + (0)))));
  // PTX:284 mul.lo.s64 %rd97, %rd131, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd97) : "l"(rd131));
  // PTX:285 add.s64 %rd98, %rd1, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd1), "l"(rd97));
  // PTX:286 mul.f32 %f125, %f124, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f124), "f"(f25));
  // PTX:287 red.global.add.f32 [%rd98], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f125));
  // PTX:288 add.s64 %rd99, %rd98, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd99) : "l"(rd98));
  // PTX:289 mul.f32 %f127, %f124, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f127) : "f"(f124), "f"(f26));
  // PTX:290 red.global.add.f32 [%rd99], %f127
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f127));
  // PTX:291 add.s64 %rd100, %rd98, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd100) : "l"(rd98));
  // PTX:292 mul.f32 %f129, %f124, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f124), "f"(f27));
  // PTX:293 red.global.add.f32 [%rd100], %f129
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f129));
  // PTX:295 $L__BB21_13:
L_BB21_13:;
  // PTX:296 neg.f32 %f35, %f25
  asm("neg.f32 %0, %1;" : "=f"(f35) : "f"(f25));
  // PTX:297 neg.f32 %f36, %f26
  asm("neg.f32 %0, %1;" : "=f"(f36) : "f"(f26));
  // PTX:298 neg.f32 %f37, %f27
  asm("neg.f32 %0, %1;" : "=f"(f37) : "f"(f27));
  // PTX:299 mul.f32 %f38, %f30, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f38) : "f"(f30), "f"(f27));
  // PTX:300 mul.f32 %f39, %f30, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f39) : "f"(f30), "f"(f26));
  // PTX:301 mul.f32 %f40, %f30, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f40) : "f"(f30), "f"(f25));
  // PTX:302 mul.f32 %f41, %f29, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f41) : "f"(f29), "f"(f27));
  // PTX:303 mul.f32 %f42, %f29, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f42) : "f"(f29), "f"(f26));
  // PTX:304 mul.f32 %f43, %f29, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f43) : "f"(f29), "f"(f25));
  // PTX:305 mul.f32 %f44, %f28, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f44) : "f"(f28), "f"(f27));
  // PTX:306 mul.f32 %f45, %f28, %f26
  asm("mul.f32 %0, %1, %2;" : "=f"(f45) : "f"(f28), "f"(f26));
  // PTX:307 mul.f32 %f46, %f28, %f25
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f28), "f"(f25));
  // PTX:308 @%p4 bra $L__BB21_15
  if (p4) { goto L_BB21_15; }
  // PTX:310 mul.lo.s64 %rd101, %rd136, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd101) : "l"(rd136));
  // PTX:311 add.s64 %rd102, %rd1, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd1), "l"(rd101));
  // PTX:312 mul.f32 %f131, %f31, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f131) : "f"(f31), "f"(f35));
  // PTX:313 red.global.add.f32 [%rd102], %f131
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f131));
  // PTX:314 add.s64 %rd103, %rd102, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd103) : "l"(rd102));
  // PTX:315 mul.f32 %f133, %f31, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f133) : "f"(f31), "f"(f36));
  // PTX:316 red.global.add.f32 [%rd103], %f133
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f133));
  // PTX:317 add.s64 %rd104, %rd102, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd104) : "l"(rd102));
  // PTX:318 mul.f32 %f135, %f31, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f135) : "f"(f31), "f"(f37));
  // PTX:319 red.global.add.f32 [%rd104], %f135
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f135));
  // PTX:321 $L__BB21_15:
L_BB21_15:;
  // PTX:322 mul.f32 %f47, %f32, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f32), "f"(f35));
  // PTX:323 mul.f32 %f48, %f32, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f32), "f"(f36));
  // PTX:324 mul.f32 %f49, %f32, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f49) : "f"(f32), "f"(f37));
  // PTX:325 mul.f32 %f50, %f33, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f50) : "f"(f33), "f"(f35));
  // PTX:326 mul.f32 %f51, %f33, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f51) : "f"(f33), "f"(f36));
  // PTX:327 mul.f32 %f52, %f33, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f52) : "f"(f33), "f"(f37));
  // PTX:328 mul.f32 %f53, %f34, %f35
  asm("mul.f32 %0, %1, %2;" : "=f"(f53) : "f"(f34), "f"(f35));
  // PTX:329 mul.f32 %f54, %f34, %f36
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f34), "f"(f36));
  // PTX:330 mul.f32 %f55, %f34, %f37
  asm("mul.f32 %0, %1, %2;" : "=f"(f55) : "f"(f34), "f"(f37));
  // PTX:331 @%p10 bra $L__BB21_17
  if (p10) { goto L_BB21_17; }
  // PTX:333 mul.lo.s64 %rd105, %rd132, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd105) : "l"(rd132));
  // PTX:334 add.s64 %rd106, %rd1, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd1), "l"(rd105));
  // PTX:335 red.global.add.f32 [%rd106], %f46
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f46));
  // PTX:336 add.s64 %rd107, %rd106, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd107) : "l"(rd106));
  // PTX:337 red.global.add.f32 [%rd107], %f45
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f45));
  // PTX:338 add.s64 %rd108, %rd106, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd108) : "l"(rd106));
  // PTX:339 red.global.add.f32 [%rd108], %f44
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f44));
  // PTX:341 $L__BB21_17:
L_BB21_17:;
  // PTX:342 @%p4 bra $L__BB21_19
  if (p4) { goto L_BB21_19; }
  // PTX:344 mul.lo.s64 %rd109, %rd135, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd109) : "l"(rd135));
  // PTX:345 add.s64 %rd110, %rd1, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd1), "l"(rd109));
  // PTX:346 red.global.add.f32 [%rd110], %f47
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f47));
  // PTX:347 add.s64 %rd111, %rd110, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd111) : "l"(rd110));
  // PTX:348 red.global.add.f32 [%rd111], %f48
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f48));
  // PTX:349 add.s64 %rd112, %rd110, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd112) : "l"(rd110));
  // PTX:350 red.global.add.f32 [%rd112], %f49
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f49));
  // PTX:352 $L__BB21_19:
L_BB21_19:;
  // PTX:353 @%p10 bra $L__BB21_21
  if (p10) { goto L_BB21_21; }
  // PTX:355 mul.lo.s64 %rd113, %rd133, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd113) : "l"(rd133));
  // PTX:356 add.s64 %rd114, %rd1, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd1), "l"(rd113));
  // PTX:357 red.global.add.f32 [%rd114], %f43
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f43));
  // PTX:358 add.s64 %rd115, %rd114, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd115) : "l"(rd114));
  // PTX:359 red.global.add.f32 [%rd115], %f42
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f42));
  // PTX:360 add.s64 %rd116, %rd114, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd116) : "l"(rd114));
  // PTX:361 red.global.add.f32 [%rd116], %f41
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f41));
  // PTX:363 $L__BB21_21:
L_BB21_21:;
  // PTX:364 @%p4 bra $L__BB21_23
  if (p4) { goto L_BB21_23; }
  // PTX:366 mul.lo.s64 %rd117, %rd137, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd117) : "l"(rd137));
  // PTX:367 add.s64 %rd118, %rd1, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd1), "l"(rd117));
  // PTX:368 red.global.add.f32 [%rd118], %f50
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f50));
  // PTX:369 add.s64 %rd119, %rd118, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd119) : "l"(rd118));
  // PTX:370 red.global.add.f32 [%rd119], %f51
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f51));
  // PTX:371 add.s64 %rd120, %rd118, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd120) : "l"(rd118));
  // PTX:372 red.global.add.f32 [%rd120], %f52
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f52));
  // PTX:374 $L__BB21_23:
L_BB21_23:;
  // PTX:375 @%p10 bra $L__BB21_25
  if (p10) { goto L_BB21_25; }
  // PTX:377 mul.lo.s64 %rd121, %rd134, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd121) : "l"(rd134));
  // PTX:378 add.s64 %rd122, %rd1, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd122) : "l"(rd1), "l"(rd121));
  // PTX:379 red.global.add.f32 [%rd122], %f40
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f40));
  // PTX:380 add.s64 %rd123, %rd122, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd123) : "l"(rd122));
  // PTX:381 red.global.add.f32 [%rd123], %f39
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f39));
  // PTX:382 add.s64 %rd124, %rd122, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd124) : "l"(rd122));
  // PTX:383 red.global.add.f32 [%rd124], %f38
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f38));
  // PTX:385 $L__BB21_25:
L_BB21_25:;
  // PTX:386 @%p4 bra $L__BB21_27
  if (p4) { goto L_BB21_27; }
  // PTX:388 mul.lo.s64 %rd125, %rd138, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd125) : "l"(rd138));
  // PTX:389 add.s64 %rd126, %rd1, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd1), "l"(rd125));
  // PTX:390 red.global.add.f32 [%rd126], %f53
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f53));
  // PTX:391 add.s64 %rd127, %rd126, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd127) : "l"(rd126));
  // PTX:392 red.global.add.f32 [%rd127], %f54
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f54));
  // PTX:393 add.s64 %rd128, %rd126, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd128) : "l"(rd126));
  // PTX:394 red.global.add.f32 [%rd128], %f55
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f55));
  // PTX:396 $L__BB21_27:
L_BB21_27:;
  // PTX:397 ret
  return;
}
