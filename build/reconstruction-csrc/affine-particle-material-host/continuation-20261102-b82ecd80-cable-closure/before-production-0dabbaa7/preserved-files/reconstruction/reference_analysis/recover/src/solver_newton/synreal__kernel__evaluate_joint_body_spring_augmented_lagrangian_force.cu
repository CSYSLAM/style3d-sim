// 机械还原自 PTX：synreal::kernel::evaluate_joint_body_spring_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: 2ba80550c2bad91f93e1c49c47305a5c039169eea3fa79b880b8c6ece5c7edff
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_joint_body_spring_augmented_lagrangian_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, float param9, unsigned long long param10, unsigned long long param11, unsigned long long param12, unsigned long long param13, unsigned long long param14) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108;
  // PTX:31 ld.param.u64 %rd26, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_0]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:32 ld.param.u64 %rd27, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_1]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:33 ld.param.u64 %rd16, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_2]
  rd16 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:34 ld.param.u64 %rd17, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_3]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:35 ld.param.u64 %rd18, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_4]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:36 ld.param.u64 %rd19, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_5]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:37 ld.param.u64 %rd20, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_6]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:38 ld.param.u64 %rd21, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_7]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:39 ld.param.u64 %rd22, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_8]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:40 ld.param.f32 %f22, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_9]
  f22 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param9 + (0))));
  // PTX:41 ld.param.u64 %rd28, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_10]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:42 ld.param.u64 %rd29, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_11]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:43 ld.param.u64 %rd23, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_12]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param12 + (0))));
  // PTX:44 ld.param.u64 %rd24, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_13]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:45 ld.param.u64 %rd25, [_ZN7synreal6kernel53evaluate_joint_body_spring_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEES6_S6_PKNS2_ILi4EfLS3_0EEESF_PKfS6_fPS4_mmmm_param_14]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:46 cvta.to.global.u64 %rd1, %rd28
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd28));
  // PTX:47 cvta.to.global.u64 %rd2, %rd26
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:48 cvta.to.global.u64 %rd3, %rd27
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd27));
  // PTX:49 mov.u32 %r18, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r18) : "r"(blockIdx.x));
  // PTX:50 mov.u32 %r19, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r19) : "r"(blockDim.x));
  // PTX:51 mul.wide.u32 %rd30, %r18, %r19
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd30) : "r"(r18), "r"(r19));
  // PTX:52 mov.u32 %r20, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r20) : "r"(threadIdx.x));
  // PTX:53 cvt.u64.u32 %rd31, %r20
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd31) : "r"(r20));
  // PTX:54 add.s64 %rd4, %rd30, %rd31
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd30), "l"(rd31));
  // PTX:55 setp.ge.u64 %p1, %rd4, %rd29
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd29)));
  // PTX:56 @%p1 bra $L__BB23_12
  if (p1) { goto L_BB23_12; }
  // PTX:58 or.b64 %rd32, %rd4, %rd24
  asm("or.b64 %0, %1, %2;" : "=l"(rd32) : "l"(rd4), "l"(rd24));
  // PTX:59 and.b64 %rd33, %rd32, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd33) : "l"(rd32));
  // PTX:60 setp.eq.s64 %p2, %rd33, 0
  p2 = (((long long)(rd33)) == ((long long)(0)));
  // PTX:61 @%p2 bra $L__BB23_3
  if (p2) { goto L_BB23_3; }
  // PTX:63 div.u64 %rd107, %rd4, %rd24
  asm("div.u64 %0, %1, %2;" : "=l"(rd107) : "l"(rd4), "l"(rd24));
  // PTX:64 mul.lo.s64 %rd34, %rd107, %rd24
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd34) : "l"(rd107), "l"(rd24));
  // PTX:65 sub.s64 %rd108, %rd4, %rd34
  asm("sub.s64 %0, %1, %2;" : "=l"(rd108) : "l"(rd4), "l"(rd34));
  // PTX:66 bra.uni $L__BB23_4
  goto L_BB23_4;
  // PTX:68 $L__BB23_3:
L_BB23_3:;
  // PTX:69 cvt.u32.u64 %r21, %rd24
  asm("cvt.u32.u64 %0, %1;" : "=r"(r21) : "l"(rd24));
  // PTX:70 cvt.u32.u64 %r22, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r22) : "l"(rd4));
  // PTX:71 div.u32 %r23, %r22, %r21
  asm("div.u32 %0, %1, %2;" : "=r"(r23) : "r"(r22), "r"(r21));
  // PTX:72 mul.lo.s32 %r24, %r23, %r21
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r24) : "r"(r23), "r"(r21));
  // PTX:73 sub.s32 %r25, %r22, %r24
  asm("sub.s32 %0, %1, %2;" : "=r"(r25) : "r"(r22), "r"(r24));
  // PTX:74 cvt.u64.u32 %rd107, %r23
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd107) : "r"(r23));
  // PTX:75 cvt.u64.u32 %rd108, %r25
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd108) : "r"(r25));
  // PTX:77 $L__BB23_4:
L_BB23_4:;
  // PTX:78 sub.s64 %rd35, %rd23, %rd24
  asm("sub.s64 %0, %1, %2;" : "=l"(rd35) : "l"(rd23), "l"(rd24));
  // PTX:79 add.s64 %rd11, %rd108, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd108), "l"(rd35));
  // PTX:80 mul.lo.s64 %rd36, %rd107, %rd25
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd36) : "l"(rd107), "l"(rd25));
  // PTX:81 cvt.u32.u64 %r1, %rd36
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd36));
  // PTX:82 cvta.to.global.u64 %rd37, %rd16
  rd37 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd16));
  // PTX:83 shl.b64 %rd38, %rd11, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd38) : "l"(rd11));
  // PTX:84 add.s64 %rd39, %rd37, %rd38
  asm("add.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd37), "l"(rd38));
  // PTX:85 ld.global.s32 %rd12, [%rd39]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (0)))));
  // PTX:86 ld.global.s32 %rd13, [%rd39+4]
  rd13 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd39) + (4)))));
  // PTX:87 cvta.to.global.u64 %rd40, %rd17
  rd40 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:88 mul.lo.s64 %rd41, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd41) : "l"(rd11));
  // PTX:89 add.s64 %rd42, %rd40, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd42) : "l"(rd40), "l"(rd41));
  // PTX:90 ld.global.f32 %f143, [%rd42]
  f143 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (0)))));
  // PTX:91 ld.global.f32 %f144, [%rd42+4]
  f144 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (4)))));
  // PTX:92 ld.global.f32 %f145, [%rd42+8]
  f145 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd42) + (8)))));
  // PTX:93 cvta.to.global.u64 %rd43, %rd18
  rd43 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:94 add.s64 %rd44, %rd43, %rd41
  asm("add.s64 %0, %1, %2;" : "=l"(rd44) : "l"(rd43), "l"(rd41));
  // PTX:95 ld.global.f32 %f146, [%rd44]
  f146 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (0)))));
  // PTX:96 ld.global.f32 %f147, [%rd44+4]
  f147 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (4)))));
  // PTX:97 ld.global.f32 %f148, [%rd44+8]
  f148 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd44) + (8)))));
  // PTX:98 setp.lt.s64 %p3, %rd12, 0
  p3 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:99 cvta.to.global.u64 %rd45, %rd19
  rd45 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:100 shl.b64 %rd46, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd46) : "l"(rd11));
  // PTX:101 add.s64 %rd14, %rd45, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd14) : "l"(rd45), "l"(rd46));
  // PTX:102 mov.u32 %r49, 0
  asm("mov.u32 %0, 0;" : "=r"(r49) : );
  // PTX:103 mov.u32 %r45, %r49
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r49));
  // PTX:104 mov.u32 %r46, %r49
  asm("mov.u32 %0, %1;" : "=r"(r46) : "r"(r49));
  // PTX:105 mov.u32 %r47, %r49
  asm("mov.u32 %0, %1;" : "=r"(r47) : "r"(r49));
  // PTX:106 mov.u32 %r48, %r49
  asm("mov.u32 %0, %1;" : "=r"(r48) : "r"(r49));
  // PTX:107 @%p3 bra $L__BB23_6
  if (p3) { goto L_BB23_6; }
  // PTX:109 shl.b64 %rd47, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd47) : "l"(rd12));
  // PTX:110 add.s64 %rd48, %rd3, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd3), "l"(rd47));
  // PTX:111 ld.global.u32 %r30, [%rd48]
  r30 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:112 ld.global.u32 %r31, [%rd48+4]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:113 ld.global.u32 %r32, [%rd48+8]
  r32 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:114 ld.global.u32 %r33, [%rd48+12]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (12)))));
  // PTX:115 add.s32 %r48, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r48) : "r"(r33), "r"(r1));
  // PTX:116 add.s32 %r47, %r32, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r47) : "r"(r32), "r"(r1));
  // PTX:117 add.s32 %r46, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r31), "r"(r1));
  // PTX:118 add.s32 %r45, %r30, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r30), "r"(r1));
  // PTX:119 mul.wide.s32 %rd49, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r45));
  // PTX:120 add.s64 %rd50, %rd2, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd2), "l"(rd49));
  // PTX:121 ld.global.f32 %f23, [%rd50]
  f23 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:122 ld.global.f32 %f24, [%rd14]
  f24 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:123 ld.global.f32 %f25, [%rd50+4]
  f25 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:124 ld.global.f32 %f26, [%rd50+8]
  f26 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:125 mul.wide.s32 %rd51, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r46));
  // PTX:126 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:127 ld.global.f32 %f27, [%rd52]
  f27 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:128 ld.global.f32 %f28, [%rd14+4]
  f28 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:129 mul.f32 %f29, %f28, %f27
  asm("mul.f32 %0, %1, %2;" : "=f"(f29) : "f"(f28), "f"(f27));
  // PTX:130 ld.global.f32 %f30, [%rd52+4]
  f30 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:131 mul.f32 %f31, %f28, %f30
  asm("mul.f32 %0, %1, %2;" : "=f"(f31) : "f"(f28), "f"(f30));
  // PTX:132 ld.global.f32 %f32, [%rd52+8]
  f32 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:133 mul.f32 %f33, %f28, %f32
  asm("mul.f32 %0, %1, %2;" : "=f"(f33) : "f"(f28), "f"(f32));
  // PTX:134 fma.rn.f32 %f34, %f24, %f23, %f29
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f34) : "f"(f24), "f"(f23), "f"(f29));
  // PTX:135 fma.rn.f32 %f35, %f24, %f25, %f31
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f35) : "f"(f24), "f"(f25), "f"(f31));
  // PTX:136 fma.rn.f32 %f36, %f24, %f26, %f33
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f36) : "f"(f24), "f"(f26), "f"(f33));
  // PTX:137 mul.wide.s32 %rd53, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd53) : "r"(r47));
  // PTX:138 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:139 ld.global.f32 %f37, [%rd54]
  f37 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:140 ld.global.f32 %f38, [%rd14+8]
  f38 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:141 ld.global.f32 %f39, [%rd54+4]
  f39 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:142 ld.global.f32 %f40, [%rd54+8]
  f40 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:143 fma.rn.f32 %f41, %f38, %f37, %f34
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f41) : "f"(f38), "f"(f37), "f"(f34));
  // PTX:144 fma.rn.f32 %f42, %f38, %f39, %f35
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f42) : "f"(f38), "f"(f39), "f"(f35));
  // PTX:145 fma.rn.f32 %f43, %f38, %f40, %f36
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f43) : "f"(f38), "f"(f40), "f"(f36));
  // PTX:146 mul.wide.s32 %rd55, %r48, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd55) : "r"(r48));
  // PTX:147 add.s64 %rd56, %rd2, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd2), "l"(rd55));
  // PTX:148 ld.global.f32 %f44, [%rd56]
  f44 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:149 ld.global.f32 %f45, [%rd14+12]
  f45 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:150 ld.global.f32 %f46, [%rd56+4]
  f46 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:151 ld.global.f32 %f47, [%rd56+8]
  f47 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:152 fma.rn.f32 %f143, %f45, %f44, %f41
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f143) : "f"(f45), "f"(f44), "f"(f41));
  // PTX:153 fma.rn.f32 %f144, %f45, %f46, %f42
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f144) : "f"(f45), "f"(f46), "f"(f42));
  // PTX:154 fma.rn.f32 %f145, %f45, %f47, %f43
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f45), "f"(f47), "f"(f43));
  // PTX:156 $L__BB23_6:
L_BB23_6:;
  // PTX:157 cvt.u32.u64 %r38, %rd13
  asm("cvt.u32.u64 %0, %1;" : "=r"(r38) : "l"(rd13));
  // PTX:158 setp.lt.s32 %p4, %r38, 0
  p4 = (((int)(r38)) < ((int)(0)));
  // PTX:159 cvta.to.global.u64 %rd57, %rd20
  rd57 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:160 add.s64 %rd15, %rd57, %rd46
  asm("add.s64 %0, %1, %2;" : "=l"(rd15) : "l"(rd57), "l"(rd46));
  // PTX:161 mov.u32 %r50, %r49
  asm("mov.u32 %0, %1;" : "=r"(r50) : "r"(r49));
  // PTX:162 mov.u32 %r51, %r49
  asm("mov.u32 %0, %1;" : "=r"(r51) : "r"(r49));
  // PTX:163 mov.u32 %r52, %r49
  asm("mov.u32 %0, %1;" : "=r"(r52) : "r"(r49));
  // PTX:164 @%p4 bra $L__BB23_8
  if (p4) { goto L_BB23_8; }
  // PTX:166 shl.b64 %rd59, %rd13, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd59) : "l"(rd13));
  // PTX:167 add.s64 %rd60, %rd3, %rd59
  asm("add.s64 %0, %1, %2;" : "=l"(rd60) : "l"(rd3), "l"(rd59));
  // PTX:168 ld.global.u32 %r39, [%rd60]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (0)))));
  // PTX:169 ld.global.u32 %r40, [%rd60+4]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (4)))));
  // PTX:170 ld.global.u32 %r41, [%rd60+8]
  r41 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (8)))));
  // PTX:171 ld.global.u32 %r42, [%rd60+12]
  r42 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd60) + (12)))));
  // PTX:172 add.s32 %r52, %r42, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r52) : "r"(r42), "r"(r1));
  // PTX:173 add.s32 %r51, %r41, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r51) : "r"(r41), "r"(r1));
  // PTX:174 add.s32 %r50, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r50) : "r"(r40), "r"(r1));
  // PTX:175 add.s32 %r49, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r49) : "r"(r39), "r"(r1));
  // PTX:176 mul.wide.s32 %rd61, %r49, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd61) : "r"(r49));
  // PTX:177 add.s64 %rd62, %rd2, %rd61
  asm("add.s64 %0, %1, %2;" : "=l"(rd62) : "l"(rd2), "l"(rd61));
  // PTX:178 ld.global.f32 %f48, [%rd62]
  f48 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (0)))));
  // PTX:179 ld.global.f32 %f49, [%rd15]
  f49 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:180 ld.global.f32 %f50, [%rd62+4]
  f50 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (4)))));
  // PTX:181 ld.global.f32 %f51, [%rd62+8]
  f51 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd62) + (8)))));
  // PTX:182 mul.wide.s32 %rd63, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd63) : "r"(r50));
  // PTX:183 add.s64 %rd64, %rd2, %rd63
  asm("add.s64 %0, %1, %2;" : "=l"(rd64) : "l"(rd2), "l"(rd63));
  // PTX:184 ld.global.f32 %f52, [%rd64]
  f52 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (0)))));
  // PTX:185 ld.global.f32 %f53, [%rd15+4]
  f53 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:186 mul.f32 %f54, %f53, %f52
  asm("mul.f32 %0, %1, %2;" : "=f"(f54) : "f"(f53), "f"(f52));
  // PTX:187 ld.global.f32 %f55, [%rd64+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (4)))));
  // PTX:188 mul.f32 %f56, %f53, %f55
  asm("mul.f32 %0, %1, %2;" : "=f"(f56) : "f"(f53), "f"(f55));
  // PTX:189 ld.global.f32 %f57, [%rd64+8]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd64) + (8)))));
  // PTX:190 mul.f32 %f58, %f53, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f53), "f"(f57));
  // PTX:191 fma.rn.f32 %f59, %f49, %f48, %f54
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f59) : "f"(f49), "f"(f48), "f"(f54));
  // PTX:192 fma.rn.f32 %f60, %f49, %f50, %f56
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f60) : "f"(f49), "f"(f50), "f"(f56));
  // PTX:193 fma.rn.f32 %f61, %f49, %f51, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f61) : "f"(f49), "f"(f51), "f"(f58));
  // PTX:194 mul.wide.s32 %rd65, %r51, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd65) : "r"(r51));
  // PTX:195 add.s64 %rd66, %rd2, %rd65
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd2), "l"(rd65));
  // PTX:196 ld.global.f32 %f62, [%rd66]
  f62 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:197 ld.global.f32 %f63, [%rd15+8]
  f63 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:198 ld.global.f32 %f64, [%rd66+4]
  f64 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:199 ld.global.f32 %f65, [%rd66+8]
  f65 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:200 fma.rn.f32 %f66, %f63, %f62, %f59
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f66) : "f"(f63), "f"(f62), "f"(f59));
  // PTX:201 fma.rn.f32 %f67, %f63, %f64, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f67) : "f"(f63), "f"(f64), "f"(f60));
  // PTX:202 fma.rn.f32 %f68, %f63, %f65, %f61
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f68) : "f"(f63), "f"(f65), "f"(f61));
  // PTX:203 mul.wide.s32 %rd67, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd67) : "r"(r52));
  // PTX:204 add.s64 %rd68, %rd2, %rd67
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd2), "l"(rd67));
  // PTX:205 ld.global.f32 %f69, [%rd68]
  f69 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:206 ld.global.f32 %f70, [%rd15+12]
  f70 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:207 ld.global.f32 %f71, [%rd68+4]
  f71 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:208 ld.global.f32 %f72, [%rd68+8]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:209 fma.rn.f32 %f146, %f70, %f69, %f66
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f70), "f"(f69), "f"(f66));
  // PTX:210 fma.rn.f32 %f147, %f70, %f71, %f67
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f70), "f"(f71), "f"(f67));
  // PTX:211 fma.rn.f32 %f148, %f70, %f72, %f68
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f148) : "f"(f70), "f"(f72), "f"(f68));
  // PTX:213 $L__BB23_8:
L_BB23_8:;
  // PTX:214 cvt.u32.u64 %r43, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r43) : "l"(rd12));
  // PTX:215 setp.lt.s32 %p5, %r43, 0
  p5 = (((int)(r43)) < ((int)(0)));
  // PTX:216 cvta.to.global.u64 %rd69, %rd22
  rd69 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:217 mul.lo.s64 %rd70, %rd4, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd70) : "l"(rd4));
  // PTX:218 add.s64 %rd71, %rd69, %rd70
  asm("add.s64 %0, %1, %2;" : "=l"(rd71) : "l"(rd69), "l"(rd70));
  // PTX:219 ld.global.f32 %f73, [%rd71]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (0)))));
  // PTX:220 sub.f32 %f74, %f146, %f143
  asm("sub.f32 %0, %1, %2;" : "=f"(f74) : "f"(f146), "f"(f143));
  // PTX:221 add.f32 %f75, %f74, %f73
  asm("add.f32 %0, %1, %2;" : "=f"(f75) : "f"(f74), "f"(f73));
  // PTX:222 ld.global.f32 %f76, [%rd71+4]
  f76 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (4)))));
  // PTX:223 sub.f32 %f77, %f147, %f144
  asm("sub.f32 %0, %1, %2;" : "=f"(f77) : "f"(f147), "f"(f144));
  // PTX:224 add.f32 %f78, %f77, %f76
  asm("add.f32 %0, %1, %2;" : "=f"(f78) : "f"(f77), "f"(f76));
  // PTX:225 ld.global.f32 %f79, [%rd71+8]
  f79 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd71) + (8)))));
  // PTX:226 sub.f32 %f80, %f148, %f145
  asm("sub.f32 %0, %1, %2;" : "=f"(f80) : "f"(f148), "f"(f145));
  // PTX:227 add.f32 %f81, %f80, %f79
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f80), "f"(f79));
  // PTX:228 cvta.to.global.u64 %rd72, %rd21
  rd72 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:229 shl.b64 %rd73, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd73) : "l"(rd11));
  // PTX:230 add.s64 %rd74, %rd72, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd72), "l"(rd73));
  // PTX:231 ld.global.f32 %f82, [%rd74]
  f82 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:232 mul.f32 %f83, %f82, %f22
  asm("mul.f32 %0, %1, %2;" : "=f"(f83) : "f"(f82), "f"(f22));
  // PTX:233 mul.f32 %f19, %f75, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f19) : "f"(f75), "f"(f83));
  // PTX:234 mul.f32 %f20, %f78, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f20) : "f"(f78), "f"(f83));
  // PTX:235 mul.f32 %f21, %f81, %f83
  asm("mul.f32 %0, %1, %2;" : "=f"(f21) : "f"(f81), "f"(f83));
  // PTX:236 @%p5 bra $L__BB23_10
  if (p5) { goto L_BB23_10; }
  // PTX:238 ld.global.f32 %f84, [%rd14]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (0)))));
  // PTX:239 mul.f32 %f85, %f19, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f85) : "f"(f19), "f"(f84));
  // PTX:240 mul.f32 %f86, %f20, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f86) : "f"(f20), "f"(f84));
  // PTX:241 mul.f32 %f87, %f21, %f84
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f21), "f"(f84));
  // PTX:242 ld.global.f32 %f88, [%rd14+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (4)))));
  // PTX:243 mul.f32 %f89, %f19, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f19), "f"(f88));
  // PTX:244 mul.f32 %f90, %f20, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f90) : "f"(f20), "f"(f88));
  // PTX:245 mul.f32 %f91, %f21, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f21), "f"(f88));
  // PTX:246 ld.global.f32 %f92, [%rd14+8]
  f92 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (8)))));
  // PTX:247 mul.f32 %f93, %f19, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f93) : "f"(f19), "f"(f92));
  // PTX:248 mul.f32 %f94, %f20, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f94) : "f"(f20), "f"(f92));
  // PTX:249 mul.f32 %f95, %f21, %f92
  asm("mul.f32 %0, %1, %2;" : "=f"(f95) : "f"(f21), "f"(f92));
  // PTX:250 ld.global.f32 %f96, [%rd14+12]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd14) + (12)))));
  // PTX:251 mul.f32 %f97, %f19, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f97) : "f"(f19), "f"(f96));
  // PTX:252 mul.f32 %f98, %f20, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f98) : "f"(f20), "f"(f96));
  // PTX:253 mul.f32 %f99, %f21, %f96
  asm("mul.f32 %0, %1, %2;" : "=f"(f99) : "f"(f21), "f"(f96));
  // PTX:254 mul.wide.s32 %rd75, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r45));
  // PTX:255 add.s64 %rd76, %rd1, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd1), "l"(rd75));
  // PTX:256 red.global.add.f32 [%rd76], %f85
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))), (float)(f85));
  // PTX:257 add.s64 %rd77, %rd76, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd77) : "l"(rd76));
  // PTX:258 red.global.add.f32 [%rd77], %f86
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd77) + (0)))), (float)(f86));
  // PTX:259 add.s64 %rd78, %rd76, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd78) : "l"(rd76));
  // PTX:260 red.global.add.f32 [%rd78], %f87
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))), (float)(f87));
  // PTX:261 mul.wide.s32 %rd79, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd79) : "r"(r46));
  // PTX:262 add.s64 %rd80, %rd1, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd1), "l"(rd79));
  // PTX:263 red.global.add.f32 [%rd80], %f89
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))), (float)(f89));
  // PTX:264 add.s64 %rd81, %rd80, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd81) : "l"(rd80));
  // PTX:265 red.global.add.f32 [%rd81], %f90
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd81) + (0)))), (float)(f90));
  // PTX:266 add.s64 %rd82, %rd80, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd82) : "l"(rd80));
  // PTX:267 red.global.add.f32 [%rd82], %f91
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))), (float)(f91));
  // PTX:268 mul.wide.s32 %rd83, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd83) : "r"(r47));
  // PTX:269 add.s64 %rd84, %rd1, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd1), "l"(rd83));
  // PTX:270 red.global.add.f32 [%rd84], %f93
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))), (float)(f93));
  // PTX:271 add.s64 %rd85, %rd84, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd85) : "l"(rd84));
  // PTX:272 red.global.add.f32 [%rd85], %f94
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd85) + (0)))), (float)(f94));
  // PTX:273 add.s64 %rd86, %rd84, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd86) : "l"(rd84));
  // PTX:274 red.global.add.f32 [%rd86], %f95
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd86) + (0)))), (float)(f95));
  // PTX:275 mul.wide.s32 %rd87, %r48, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd87) : "r"(r48));
  // PTX:276 add.s64 %rd88, %rd1, %rd87
  asm("add.s64 %0, %1, %2;" : "=l"(rd88) : "l"(rd1), "l"(rd87));
  // PTX:277 red.global.add.f32 [%rd88], %f97
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd88) + (0)))), (float)(f97));
  // PTX:278 add.s64 %rd89, %rd88, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd89) : "l"(rd88));
  // PTX:279 red.global.add.f32 [%rd89], %f98
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd89) + (0)))), (float)(f98));
  // PTX:280 add.s64 %rd90, %rd88, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd90) : "l"(rd88));
  // PTX:281 red.global.add.f32 [%rd90], %f99
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))), (float)(f99));
  // PTX:283 $L__BB23_10:
L_BB23_10:;
  // PTX:284 @%p4 bra $L__BB23_12
  if (p4) { goto L_BB23_12; }
  // PTX:286 ld.global.f32 %f112, [%rd15]
  f112 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (0)))));
  // PTX:287 neg.f32 %f113, %f19
  asm("neg.f32 %0, %1;" : "=f"(f113) : "f"(f19));
  // PTX:288 mul.f32 %f114, %f112, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f114) : "f"(f112), "f"(f113));
  // PTX:289 neg.f32 %f115, %f20
  asm("neg.f32 %0, %1;" : "=f"(f115) : "f"(f20));
  // PTX:290 mul.f32 %f116, %f112, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f116) : "f"(f112), "f"(f115));
  // PTX:291 neg.f32 %f117, %f21
  asm("neg.f32 %0, %1;" : "=f"(f117) : "f"(f21));
  // PTX:292 mul.f32 %f118, %f112, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f118) : "f"(f112), "f"(f117));
  // PTX:293 ld.global.f32 %f119, [%rd15+4]
  f119 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (4)))));
  // PTX:294 mul.f32 %f120, %f119, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f120) : "f"(f119), "f"(f113));
  // PTX:295 mul.f32 %f121, %f119, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f119), "f"(f115));
  // PTX:296 mul.f32 %f122, %f119, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f122) : "f"(f119), "f"(f117));
  // PTX:297 ld.global.f32 %f123, [%rd15+8]
  f123 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (8)))));
  // PTX:298 mul.f32 %f124, %f123, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f124) : "f"(f123), "f"(f113));
  // PTX:299 mul.f32 %f125, %f123, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f125) : "f"(f123), "f"(f115));
  // PTX:300 mul.f32 %f126, %f123, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f126) : "f"(f123), "f"(f117));
  // PTX:301 ld.global.f32 %f127, [%rd15+12]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd15) + (12)))));
  // PTX:302 mul.f32 %f128, %f127, %f113
  asm("mul.f32 %0, %1, %2;" : "=f"(f128) : "f"(f127), "f"(f113));
  // PTX:303 mul.f32 %f129, %f127, %f115
  asm("mul.f32 %0, %1, %2;" : "=f"(f129) : "f"(f127), "f"(f115));
  // PTX:304 mul.f32 %f130, %f127, %f117
  asm("mul.f32 %0, %1, %2;" : "=f"(f130) : "f"(f127), "f"(f117));
  // PTX:305 mul.wide.s32 %rd91, %r49, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd91) : "r"(r49));
  // PTX:306 add.s64 %rd92, %rd1, %rd91
  asm("add.s64 %0, %1, %2;" : "=l"(rd92) : "l"(rd1), "l"(rd91));
  // PTX:307 red.global.add.f32 [%rd92], %f114
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd92) + (0)))), (float)(f114));
  // PTX:308 add.s64 %rd93, %rd92, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd93) : "l"(rd92));
  // PTX:309 red.global.add.f32 [%rd93], %f116
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))), (float)(f116));
  // PTX:310 add.s64 %rd94, %rd92, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd94) : "l"(rd92));
  // PTX:311 red.global.add.f32 [%rd94], %f118
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd94) + (0)))), (float)(f118));
  // PTX:312 mul.wide.s32 %rd95, %r50, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd95) : "r"(r50));
  // PTX:313 add.s64 %rd96, %rd1, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd1), "l"(rd95));
  // PTX:314 red.global.add.f32 [%rd96], %f120
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))), (float)(f120));
  // PTX:315 add.s64 %rd97, %rd96, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd97) : "l"(rd96));
  // PTX:316 red.global.add.f32 [%rd97], %f121
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd97) + (0)))), (float)(f121));
  // PTX:317 add.s64 %rd98, %rd96, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd98) : "l"(rd96));
  // PTX:318 red.global.add.f32 [%rd98], %f122
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f122));
  // PTX:319 mul.wide.s32 %rd99, %r51, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd99) : "r"(r51));
  // PTX:320 add.s64 %rd100, %rd1, %rd99
  asm("add.s64 %0, %1, %2;" : "=l"(rd100) : "l"(rd1), "l"(rd99));
  // PTX:321 red.global.add.f32 [%rd100], %f124
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f124));
  // PTX:322 add.s64 %rd101, %rd100, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd101) : "l"(rd100));
  // PTX:323 red.global.add.f32 [%rd101], %f125
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd101) + (0)))), (float)(f125));
  // PTX:324 add.s64 %rd102, %rd100, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd102) : "l"(rd100));
  // PTX:325 red.global.add.f32 [%rd102], %f126
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f126));
  // PTX:326 mul.wide.s32 %rd103, %r52, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd103) : "r"(r52));
  // PTX:327 add.s64 %rd104, %rd1, %rd103
  asm("add.s64 %0, %1, %2;" : "=l"(rd104) : "l"(rd1), "l"(rd103));
  // PTX:328 red.global.add.f32 [%rd104], %f128
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f128));
  // PTX:329 add.s64 %rd105, %rd104, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd105) : "l"(rd104));
  // PTX:330 red.global.add.f32 [%rd105], %f129
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd105) + (0)))), (float)(f129));
  // PTX:331 add.s64 %rd106, %rd104, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd106) : "l"(rd104));
  // PTX:332 red.global.add.f32 [%rd106], %f130
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f130));
  // PTX:334 $L__BB23_12:
L_BB23_12:;
  // PTX:335 ret
  return;
}
