// 机械还原自 PTX：synreal::kernel::evaluate_joint_body_point_line_augmented_lagrangian_force(glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<4, int, (glm::qualifier)0> const*, glm::vec<2, int, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<4, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::vec<3, float, (glm::qualifier)0> const*, float const*, float const*, glm::vec<3, float, (glm::qualifier)0> const*, glm::mat<3, 3, float, (glm::qualifier)0> const*, float, glm::vec<3, float, (glm::qualifier)0>*, unsigned long, unsigned long, unsigned long, unsigned long)
// PTX SHA256: e3cfaac10738a76b10c97efedc5ca07e65672783f71b4a0fcf0ef59b36c1e912
// Scalar inline PTX retains exact type/rounding; CUDA retains control and memory data flow.
#include "px_common.h"

extern "C" __global__ void synreal__kernel__evaluate_joint_body_point_line_augmented_lagrangian_force(unsigned long long param0, unsigned long long param1, unsigned long long param2, unsigned long long param3, unsigned long long param4, unsigned long long param5, unsigned long long param6, unsigned long long param7, unsigned long long param8, unsigned long long param9, unsigned long long param10, unsigned long long param11, float param12, unsigned long long param13, unsigned long long param14, unsigned long long param15, unsigned long long param16, unsigned long long param17) {
  int p0, p1, p2, p3, p4, p5, p6;
  float f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f59, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f76, f77, f78, f79, f80, f81, f82, f83, f84, f85, f86, f87, f88, f89, f90, f91, f92, f93, f94, f95, f96, f97, f98, f99, f100, f101, f102, f103, f104, f105, f106, f107, f108, f109, f110, f111, f112, f113, f114, f115, f116, f117, f118, f119, f120, f121, f122, f123, f124, f125, f126, f127, f128, f129, f130, f131, f132, f133, f134, f135, f136, f137, f138, f139, f140, f141, f142, f143, f144, f145, f146, f147, f148, f149, f150, f151, f152, f153, f154, f155, f156, f157, f158, f159, f160, f161, f162, f163, f164, f165, f166, f167, f168, f169, f170, f171, f172, f173, f174, f175, f176, f177, f178, f179, f180, f181, f182, f183, f184, f185, f186, f187, f188, f189, f190, f191, f192, f193, f194, f195, f196, f197, f198, f199, f200, f201, f202, f203, f204, f205, f206, f207, f208, f209, f210, f211, f212, f213, f214, f215, f216, f217, f218, f219, f220, f221, f222, f223, f224, f225, f226, f227, f228, f229, f230, f231, f232, f233, f234, f235, f236, f237, f238, f239, f240, f241, f242;
  unsigned r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47;
  unsigned long long rd0, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8, rd9, rd10, rd11, rd12, rd13, rd14, rd15, rd16, rd17, rd18, rd19, rd20, rd21, rd22, rd23, rd24, rd25, rd26, rd27, rd28, rd29, rd30, rd31, rd32, rd33, rd34, rd35, rd36, rd37, rd38, rd39, rd40, rd41, rd42, rd43, rd44, rd45, rd46, rd47, rd48, rd49, rd50, rd51, rd52, rd53, rd54, rd55, rd56, rd57, rd58, rd59, rd60, rd61, rd62, rd63, rd64, rd65, rd66, rd67, rd68, rd69, rd70, rd71, rd72, rd73, rd74, rd75, rd76, rd77, rd78, rd79, rd80, rd81, rd82, rd83, rd84, rd85, rd86, rd87, rd88, rd89, rd90, rd91, rd92, rd93, rd94, rd95, rd96, rd97, rd98, rd99, rd100, rd101, rd102, rd103, rd104, rd105, rd106, rd107, rd108, rd109, rd110, rd111, rd112, rd113, rd114, rd115, rd116, rd117, rd118, rd119, rd120, rd121, rd122, rd123, rd124, rd125, rd126, rd127, rd128, rd129, rd130;
  // PTX:34 ld.param.u64 %rd30, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_0]
  rd30 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param0 + (0))));
  // PTX:35 ld.param.u64 %rd31, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_1]
  rd31 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param1 + (0))));
  // PTX:36 ld.param.u64 %rd17, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_2]
  rd17 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param2 + (0))));
  // PTX:37 ld.param.u64 %rd18, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_3]
  rd18 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param3 + (0))));
  // PTX:38 ld.param.u64 %rd19, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_4]
  rd19 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param4 + (0))));
  // PTX:39 ld.param.u64 %rd20, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_5]
  rd20 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param5 + (0))));
  // PTX:40 ld.param.u64 %rd21, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_6]
  rd21 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param6 + (0))));
  // PTX:41 ld.param.u64 %rd22, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_7]
  rd22 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param7 + (0))));
  // PTX:42 ld.param.u64 %rd23, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_8]
  rd23 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param8 + (0))));
  // PTX:43 ld.param.u64 %rd24, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_9]
  rd24 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param9 + (0))));
  // PTX:44 ld.param.u64 %rd25, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_10]
  rd25 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param10 + (0))));
  // PTX:45 ld.param.u64 %rd26, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_11]
  rd26 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param11 + (0))));
  // PTX:46 ld.param.u64 %rd32, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_13]
  rd32 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param13 + (0))));
  // PTX:47 ld.param.u64 %rd33, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_14]
  rd33 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param14 + (0))));
  // PTX:48 ld.param.u64 %rd27, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_15]
  rd27 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param15 + (0))));
  // PTX:49 ld.param.u64 %rd28, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_16]
  rd28 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param16 + (0))));
  // PTX:50 ld.param.u64 %rd29, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_17]
  rd29 = (*reinterpret_cast<volatile unsigned long long*>(((uintptr_t)&param17 + (0))));
  // PTX:51 cvta.to.global.u64 %rd1, %rd32
  rd1 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd32));
  // PTX:52 cvta.to.global.u64 %rd2, %rd30
  rd2 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd30));
  // PTX:53 cvta.to.global.u64 %rd3, %rd31
  rd3 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd31));
  // PTX:54 mov.u32 %r16, %ctaid.x
  asm("mov.u32 %0, %1;" : "=r"(r16) : "r"(blockIdx.x));
  // PTX:55 mov.u32 %r17, %ntid.x
  asm("mov.u32 %0, %1;" : "=r"(r17) : "r"(blockDim.x));
  // PTX:56 mul.wide.u32 %rd34, %r16, %r17
  asm("mul.wide.u32 %0, %1, %2;" : "=l"(rd34) : "r"(r16), "r"(r17));
  // PTX:57 mov.u32 %r18, %tid.x
  asm("mov.u32 %0, %1;" : "=r"(r18) : "r"(threadIdx.x));
  // PTX:58 cvt.u64.u32 %rd35, %r18
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd35) : "r"(r18));
  // PTX:59 add.s64 %rd4, %rd34, %rd35
  asm("add.s64 %0, %1, %2;" : "=l"(rd4) : "l"(rd34), "l"(rd35));
  // PTX:60 setp.ge.u64 %p1, %rd4, %rd33
  p1 = (((unsigned long long)(rd4)) >= ((unsigned long long)(rd33)));
  // PTX:61 @%p1 bra $L__BB35_14
  if (p1) { goto L_BB35_14; }
  // PTX:63 or.b64 %rd36, %rd4, %rd28
  asm("or.b64 %0, %1, %2;" : "=l"(rd36) : "l"(rd4), "l"(rd28));
  // PTX:64 and.b64 %rd37, %rd36, -4294967296
  asm("and.b64 %0, %1, -4294967296;" : "=l"(rd37) : "l"(rd36));
  // PTX:65 setp.eq.s64 %p2, %rd37, 0
  p2 = (((long long)(rd37)) == ((long long)(0)));
  // PTX:66 @%p2 bra $L__BB35_3
  if (p2) { goto L_BB35_3; }
  // PTX:68 div.u64 %rd129, %rd4, %rd28
  asm("div.u64 %0, %1, %2;" : "=l"(rd129) : "l"(rd4), "l"(rd28));
  // PTX:69 mul.lo.s64 %rd38, %rd129, %rd28
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd38) : "l"(rd129), "l"(rd28));
  // PTX:70 sub.s64 %rd130, %rd4, %rd38
  asm("sub.s64 %0, %1, %2;" : "=l"(rd130) : "l"(rd4), "l"(rd38));
  // PTX:71 bra.uni $L__BB35_4
  goto L_BB35_4;
  // PTX:73 $L__BB35_3:
L_BB35_3:;
  // PTX:74 cvt.u32.u64 %r19, %rd28
  asm("cvt.u32.u64 %0, %1;" : "=r"(r19) : "l"(rd28));
  // PTX:75 cvt.u32.u64 %r20, %rd4
  asm("cvt.u32.u64 %0, %1;" : "=r"(r20) : "l"(rd4));
  // PTX:76 div.u32 %r21, %r20, %r19
  asm("div.u32 %0, %1, %2;" : "=r"(r21) : "r"(r20), "r"(r19));
  // PTX:77 mul.lo.s32 %r22, %r21, %r19
  asm("mul.lo.s32 %0, %1, %2;" : "=r"(r22) : "r"(r21), "r"(r19));
  // PTX:78 sub.s32 %r23, %r20, %r22
  asm("sub.s32 %0, %1, %2;" : "=r"(r23) : "r"(r20), "r"(r22));
  // PTX:79 cvt.u64.u32 %rd129, %r21
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd129) : "r"(r21));
  // PTX:80 cvt.u64.u32 %rd130, %r23
  asm("cvt.u64.u32 %0, %1;" : "=l"(rd130) : "r"(r23));
  // PTX:82 $L__BB35_4:
L_BB35_4:;
  // PTX:83 sub.s64 %rd39, %rd27, %rd28
  asm("sub.s64 %0, %1, %2;" : "=l"(rd39) : "l"(rd27), "l"(rd28));
  // PTX:84 add.s64 %rd11, %rd130, %rd39
  asm("add.s64 %0, %1, %2;" : "=l"(rd11) : "l"(rd130), "l"(rd39));
  // PTX:85 mul.lo.s64 %rd40, %rd129, %rd29
  asm("mul.lo.s64 %0, %1, %2;" : "=l"(rd40) : "l"(rd129), "l"(rd29));
  // PTX:86 cvt.u32.u64 %r1, %rd40
  asm("cvt.u32.u64 %0, %1;" : "=r"(r1) : "l"(rd40));
  // PTX:87 cvta.to.global.u64 %rd41, %rd17
  rd41 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd17));
  // PTX:88 shl.b64 %rd42, %rd11, 3
  asm("shl.b64 %0, %1, 3;" : "=l"(rd42) : "l"(rd11));
  // PTX:89 add.s64 %rd43, %rd41, %rd42
  asm("add.s64 %0, %1, %2;" : "=l"(rd43) : "l"(rd41), "l"(rd42));
  // PTX:90 ld.global.s32 %rd12, [%rd43+4]
  rd12 = (*reinterpret_cast<volatile int*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (4)))));
  // PTX:91 ld.global.u32 %r28, [%rd43]
  r28 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd43) + (0)))));
  // PTX:92 mul.wide.s32 %rd44, %r28, 16
  asm("mul.wide.s32 %0, %1, 16;" : "=l"(rd44) : "r"(r28));
  // PTX:93 add.s64 %rd45, %rd3, %rd44
  asm("add.s64 %0, %1, %2;" : "=l"(rd45) : "l"(rd3), "l"(rd44));
  // PTX:94 ld.global.u32 %r29, [%rd45]
  r29 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (0)))));
  // PTX:95 add.s32 %r30, %r29, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r30) : "r"(r29), "r"(r1));
  // PTX:96 ld.global.u32 %r31, [%rd45+4]
  r31 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (4)))));
  // PTX:97 add.s32 %r32, %r31, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r32) : "r"(r31), "r"(r1));
  // PTX:98 ld.global.u32 %r33, [%rd45+8]
  r33 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (8)))));
  // PTX:99 add.s32 %r34, %r33, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r34) : "r"(r33), "r"(r1));
  // PTX:100 ld.global.u32 %r35, [%rd45+12]
  r35 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd45) + (12)))));
  // PTX:101 add.s32 %r36, %r35, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r36) : "r"(r35), "r"(r1));
  // PTX:102 cvta.to.global.u64 %rd46, %rd18
  rd46 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd18));
  // PTX:103 shl.b64 %rd47, %rd11, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd47) : "l"(rd11));
  // PTX:104 add.s64 %rd48, %rd46, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd48) : "l"(rd46), "l"(rd47));
  // PTX:105 cvt.s64.s32 %rd13, %r30
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd13) : "r"(r30));
  // PTX:106 mul.wide.s32 %rd49, %r30, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd49) : "r"(r30));
  // PTX:107 add.s64 %rd50, %rd2, %rd49
  asm("add.s64 %0, %1, %2;" : "=l"(rd50) : "l"(rd2), "l"(rd49));
  // PTX:108 ld.global.f32 %f54, [%rd50]
  f54 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (0)))));
  // PTX:109 ld.global.f32 %f1, [%rd48]
  f1 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (0)))));
  // PTX:110 ld.global.f32 %f55, [%rd50+4]
  f55 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (4)))));
  // PTX:111 ld.global.f32 %f56, [%rd50+8]
  f56 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd50) + (8)))));
  // PTX:112 cvt.s64.s32 %rd14, %r32
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd14) : "r"(r32));
  // PTX:113 mul.wide.s32 %rd51, %r32, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd51) : "r"(r32));
  // PTX:114 add.s64 %rd52, %rd2, %rd51
  asm("add.s64 %0, %1, %2;" : "=l"(rd52) : "l"(rd2), "l"(rd51));
  // PTX:115 ld.global.f32 %f57, [%rd52]
  f57 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (0)))));
  // PTX:116 ld.global.f32 %f2, [%rd48+4]
  f2 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (4)))));
  // PTX:117 mul.f32 %f58, %f2, %f57
  asm("mul.f32 %0, %1, %2;" : "=f"(f58) : "f"(f2), "f"(f57));
  // PTX:118 ld.global.f32 %f59, [%rd52+4]
  f59 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (4)))));
  // PTX:119 mul.f32 %f60, %f2, %f59
  asm("mul.f32 %0, %1, %2;" : "=f"(f60) : "f"(f2), "f"(f59));
  // PTX:120 ld.global.f32 %f61, [%rd52+8]
  f61 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd52) + (8)))));
  // PTX:121 mul.f32 %f62, %f2, %f61
  asm("mul.f32 %0, %1, %2;" : "=f"(f62) : "f"(f2), "f"(f61));
  // PTX:122 fma.rn.f32 %f63, %f1, %f54, %f58
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f63) : "f"(f1), "f"(f54), "f"(f58));
  // PTX:123 fma.rn.f32 %f64, %f1, %f55, %f60
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f64) : "f"(f1), "f"(f55), "f"(f60));
  // PTX:124 fma.rn.f32 %f65, %f1, %f56, %f62
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f65) : "f"(f1), "f"(f56), "f"(f62));
  // PTX:125 cvt.s64.s32 %rd15, %r34
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd15) : "r"(r34));
  // PTX:126 mul.wide.s32 %rd53, %r34, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd53) : "r"(r34));
  // PTX:127 add.s64 %rd54, %rd2, %rd53
  asm("add.s64 %0, %1, %2;" : "=l"(rd54) : "l"(rd2), "l"(rd53));
  // PTX:128 ld.global.f32 %f66, [%rd54]
  f66 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (0)))));
  // PTX:129 ld.global.f32 %f3, [%rd48+8]
  f3 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (8)))));
  // PTX:130 ld.global.f32 %f67, [%rd54+4]
  f67 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (4)))));
  // PTX:131 ld.global.f32 %f68, [%rd54+8]
  f68 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd54) + (8)))));
  // PTX:132 fma.rn.f32 %f69, %f3, %f66, %f63
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f69) : "f"(f3), "f"(f66), "f"(f63));
  // PTX:133 fma.rn.f32 %f70, %f3, %f67, %f64
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f70) : "f"(f3), "f"(f67), "f"(f64));
  // PTX:134 fma.rn.f32 %f71, %f3, %f68, %f65
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f71) : "f"(f3), "f"(f68), "f"(f65));
  // PTX:135 cvt.s64.s32 %rd16, %r36
  asm("cvt.s64.s32 %0, %1;" : "=l"(rd16) : "r"(r36));
  // PTX:136 mul.wide.s32 %rd55, %r36, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd55) : "r"(r36));
  // PTX:137 add.s64 %rd56, %rd2, %rd55
  asm("add.s64 %0, %1, %2;" : "=l"(rd56) : "l"(rd2), "l"(rd55));
  // PTX:138 ld.global.f32 %f72, [%rd56]
  f72 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (0)))));
  // PTX:139 ld.global.f32 %f4, [%rd48+12]
  f4 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd48) + (12)))));
  // PTX:140 ld.global.f32 %f73, [%rd56+4]
  f73 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (4)))));
  // PTX:141 ld.global.f32 %f74, [%rd56+8]
  f74 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd56) + (8)))));
  // PTX:142 fma.rn.f32 %f5, %f4, %f72, %f69
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f5) : "f"(f4), "f"(f72), "f"(f69));
  // PTX:143 fma.rn.f32 %f6, %f4, %f73, %f70
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f6) : "f"(f4), "f"(f73), "f"(f70));
  // PTX:144 fma.rn.f32 %f7, %f4, %f74, %f71
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f7) : "f"(f4), "f"(f74), "f"(f71));
  // PTX:145 setp.lt.s64 %p3, %rd12, 0
  p3 = (((long long)(rd12)) < ((long long)(0)));
  // PTX:146 mov.u32 %r44, 0
  asm("mov.u32 %0, 0;" : "=r"(r44) : );
  // PTX:147 mov.u32 %r45, %r44
  asm("mov.u32 %0, %1;" : "=r"(r45) : "r"(r44));
  // PTX:148 mov.u32 %r46, %r44
  asm("mov.u32 %0, %1;" : "=r"(r46) : "r"(r44));
  // PTX:149 mov.u32 %r47, %r44
  asm("mov.u32 %0, %1;" : "=r"(r47) : "r"(r44));
  // PTX:150 @%p3 bra $L__BB35_6
  if (p3) { goto L_BB35_6; }
  // PTX:152 shl.b64 %rd57, %rd12, 4
  asm("shl.b64 %0, %1, 4;" : "=l"(rd57) : "l"(rd12));
  // PTX:153 add.s64 %rd58, %rd3, %rd57
  asm("add.s64 %0, %1, %2;" : "=l"(rd58) : "l"(rd3), "l"(rd57));
  // PTX:154 ld.global.u32 %r37, [%rd58]
  r37 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (0)))));
  // PTX:155 ld.global.u32 %r38, [%rd58+4]
  r38 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (4)))));
  // PTX:156 ld.global.u32 %r39, [%rd58+8]
  r39 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (8)))));
  // PTX:157 ld.global.u32 %r40, [%rd58+12]
  r40 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd58) + (12)))));
  // PTX:158 add.s32 %r47, %r40, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r47) : "r"(r40), "r"(r1));
  // PTX:159 add.s32 %r46, %r39, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r46) : "r"(r39), "r"(r1));
  // PTX:160 add.s32 %r45, %r38, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r45) : "r"(r38), "r"(r1));
  // PTX:161 add.s32 %r44, %r37, %r1
  asm("add.s32 %0, %1, %2;" : "=r"(r44) : "r"(r37), "r"(r1));
  // PTX:163 $L__BB35_6:
L_BB35_6:;
  // PTX:164 cvta.to.global.u64 %rd59, %rd21
  rd59 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd21));
  // PTX:165 mul.lo.s64 %rd60, %rd11, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd60) : "l"(rd11));
  // PTX:166 add.s64 %rd61, %rd59, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd61) : "l"(rd59), "l"(rd60));
  // PTX:167 ld.global.u32 %r10, [%rd61]
  r10 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (0)))));
  // PTX:168 ld.global.u32 %r11, [%rd61+4]
  r11 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (4)))));
  // PTX:169 ld.global.u32 %r12, [%rd61+8]
  r12 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd61) + (8)))));
  // PTX:170 cvta.to.global.u64 %rd62, %rd22
  rd62 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd22));
  // PTX:171 add.s64 %rd63, %rd62, %rd60
  asm("add.s64 %0, %1, %2;" : "=l"(rd63) : "l"(rd62), "l"(rd60));
  // PTX:172 ld.global.u32 %r13, [%rd63]
  r13 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (0)))));
  // PTX:173 ld.global.u32 %r14, [%rd63+4]
  r14 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (4)))));
  // PTX:174 ld.global.u32 %r15, [%rd63+8]
  r15 = (*reinterpret_cast<volatile unsigned*>(__cvta_global_to_generic(((uintptr_t)(rd63) + (8)))));
  // PTX:175 cvta.to.global.u64 %rd64, %rd19
  rd64 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd19));
  // PTX:176 add.s64 %rd66, %rd64, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd66) : "l"(rd64), "l"(rd47));
  // PTX:177 ld.global.f32 %f8, [%rd66]
  f8 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (0)))));
  // PTX:178 ld.global.f32 %f9, [%rd66+4]
  f9 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (4)))));
  // PTX:179 ld.global.f32 %f10, [%rd66+8]
  f10 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (8)))));
  // PTX:180 ld.global.f32 %f11, [%rd66+12]
  f11 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd66) + (12)))));
  // PTX:181 cvta.to.global.u64 %rd67, %rd20
  rd67 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd20));
  // PTX:182 add.s64 %rd68, %rd67, %rd47
  asm("add.s64 %0, %1, %2;" : "=l"(rd68) : "l"(rd67), "l"(rd47));
  // PTX:183 ld.global.f32 %f12, [%rd68]
  f12 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (0)))));
  // PTX:184 ld.global.f32 %f13, [%rd68+4]
  f13 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (4)))));
  // PTX:185 ld.global.f32 %f14, [%rd68+8]
  f14 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (8)))));
  // PTX:186 ld.global.f32 %f15, [%rd68+12]
  f15 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd68) + (12)))));
  // PTX:187 cvt.u32.u64 %r41, %rd12
  asm("cvt.u32.u64 %0, %1;" : "=r"(r41) : "l"(rd12));
  // PTX:188 setp.lt.s32 %p4, %r41, 0
  p4 = (((int)(r41)) < ((int)(0)));
  // PTX:189 @%p4 bra $L__BB35_8
  if (p4) { goto L_BB35_8; }
  // PTX:191 add.f32 %f75, %f8, %f12
  asm("add.f32 %0, %1, %2;" : "=f"(f75) : "f"(f8), "f"(f12));
  // PTX:192 mul.f32 %f76, %f75, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f76) : "f"(f75));
  // PTX:193 add.f32 %f77, %f9, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f77) : "f"(f9), "f"(f13));
  // PTX:194 mul.f32 %f78, %f77, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f78) : "f"(f77));
  // PTX:195 add.f32 %f79, %f10, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f79) : "f"(f10), "f"(f14));
  // PTX:196 mul.f32 %f80, %f79, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f80) : "f"(f79));
  // PTX:197 add.f32 %f81, %f11, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f81) : "f"(f11), "f"(f15));
  // PTX:198 mul.f32 %f82, %f81, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f82) : "f"(f81));
  // PTX:199 mul.wide.s32 %rd69, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd69) : "r"(r44));
  // PTX:200 add.s64 %rd70, %rd2, %rd69
  asm("add.s64 %0, %1, %2;" : "=l"(rd70) : "l"(rd2), "l"(rd69));
  // PTX:201 ld.global.f32 %f83, [%rd70]
  f83 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (0)))));
  // PTX:202 ld.global.f32 %f84, [%rd70+4]
  f84 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (4)))));
  // PTX:203 ld.global.f32 %f85, [%rd70+8]
  f85 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd70) + (8)))));
  // PTX:204 mul.wide.s32 %rd71, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd71) : "r"(r45));
  // PTX:205 add.s64 %rd72, %rd2, %rd71
  asm("add.s64 %0, %1, %2;" : "=l"(rd72) : "l"(rd2), "l"(rd71));
  // PTX:206 ld.global.f32 %f86, [%rd72]
  f86 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (0)))));
  // PTX:207 mul.f32 %f87, %f78, %f86
  asm("mul.f32 %0, %1, %2;" : "=f"(f87) : "f"(f78), "f"(f86));
  // PTX:208 ld.global.f32 %f88, [%rd72+4]
  f88 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (4)))));
  // PTX:209 mul.f32 %f89, %f78, %f88
  asm("mul.f32 %0, %1, %2;" : "=f"(f89) : "f"(f78), "f"(f88));
  // PTX:210 ld.global.f32 %f90, [%rd72+8]
  f90 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd72) + (8)))));
  // PTX:211 mul.f32 %f91, %f78, %f90
  asm("mul.f32 %0, %1, %2;" : "=f"(f91) : "f"(f78), "f"(f90));
  // PTX:212 fma.rn.f32 %f92, %f76, %f83, %f87
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f92) : "f"(f76), "f"(f83), "f"(f87));
  // PTX:213 fma.rn.f32 %f93, %f76, %f84, %f89
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f93) : "f"(f76), "f"(f84), "f"(f89));
  // PTX:214 fma.rn.f32 %f94, %f76, %f85, %f91
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f94) : "f"(f76), "f"(f85), "f"(f91));
  // PTX:215 mul.wide.s32 %rd73, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd73) : "r"(r46));
  // PTX:216 add.s64 %rd74, %rd2, %rd73
  asm("add.s64 %0, %1, %2;" : "=l"(rd74) : "l"(rd2), "l"(rd73));
  // PTX:217 ld.global.f32 %f95, [%rd74]
  f95 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (0)))));
  // PTX:218 ld.global.f32 %f96, [%rd74+4]
  f96 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (4)))));
  // PTX:219 ld.global.f32 %f97, [%rd74+8]
  f97 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd74) + (8)))));
  // PTX:220 fma.rn.f32 %f98, %f80, %f95, %f92
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f98) : "f"(f80), "f"(f95), "f"(f92));
  // PTX:221 fma.rn.f32 %f99, %f80, %f96, %f93
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f99) : "f"(f80), "f"(f96), "f"(f93));
  // PTX:222 fma.rn.f32 %f100, %f80, %f97, %f94
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f100) : "f"(f80), "f"(f97), "f"(f94));
  // PTX:223 mul.wide.s32 %rd75, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd75) : "r"(r47));
  // PTX:224 add.s64 %rd76, %rd2, %rd75
  asm("add.s64 %0, %1, %2;" : "=l"(rd76) : "l"(rd2), "l"(rd75));
  // PTX:225 ld.global.f32 %f101, [%rd76]
  f101 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (0)))));
  // PTX:226 ld.global.f32 %f102, [%rd76+4]
  f102 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (4)))));
  // PTX:227 ld.global.f32 %f103, [%rd76+8]
  f103 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd76) + (8)))));
  // PTX:228 fma.rn.f32 %f235, %f82, %f101, %f98
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f235) : "f"(f82), "f"(f101), "f"(f98));
  // PTX:229 fma.rn.f32 %f234, %f82, %f102, %f99
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f234) : "f"(f82), "f"(f102), "f"(f99));
  // PTX:230 fma.rn.f32 %f233, %f82, %f103, %f100
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f233) : "f"(f82), "f"(f103), "f"(f100));
  // PTX:231 bra.uni $L__BB35_9
  goto L_BB35_9;
  // PTX:233 $L__BB35_8:
L_BB35_8:;
  // PTX:234 mov.b32 %f104, %r10
  asm("mov.b32 %0, %1;" : "=f"(f104) : "r"(r10));
  // PTX:235 mov.b32 %f105, %r13
  asm("mov.b32 %0, %1;" : "=f"(f105) : "r"(r13));
  // PTX:236 add.f32 %f106, %f104, %f105
  asm("add.f32 %0, %1, %2;" : "=f"(f106) : "f"(f104), "f"(f105));
  // PTX:237 mov.b32 %f107, %r14
  asm("mov.b32 %0, %1;" : "=f"(f107) : "r"(r14));
  // PTX:238 mov.b32 %f108, %r11
  asm("mov.b32 %0, %1;" : "=f"(f108) : "r"(r11));
  // PTX:239 add.f32 %f109, %f108, %f107
  asm("add.f32 %0, %1, %2;" : "=f"(f109) : "f"(f108), "f"(f107));
  // PTX:240 mov.b32 %f110, %r15
  asm("mov.b32 %0, %1;" : "=f"(f110) : "r"(r15));
  // PTX:241 mov.b32 %f111, %r12
  asm("mov.b32 %0, %1;" : "=f"(f111) : "r"(r12));
  // PTX:242 add.f32 %f112, %f111, %f110
  asm("add.f32 %0, %1, %2;" : "=f"(f112) : "f"(f111), "f"(f110));
  // PTX:243 mul.f32 %f235, %f106, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f235) : "f"(f106));
  // PTX:244 mul.f32 %f234, %f109, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f234) : "f"(f109));
  // PTX:245 mul.f32 %f233, %f112, 0f3F000000
  asm("mul.f32 %0, %1, 0f3F000000;" : "=f"(f233) : "f"(f112));
  // PTX:247 $L__BB35_9:
L_BB35_9:;
  // PTX:248 @%p4 bra $L__BB35_11
  if (p4) { goto L_BB35_11; }
  // PTX:250 sub.f32 %f239, %f12, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f12), "f"(f8));
  // PTX:251 mul.wide.s32 %rd77, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd77) : "r"(r44));
  // PTX:252 add.s64 %rd78, %rd2, %rd77
  asm("add.s64 %0, %1, %2;" : "=l"(rd78) : "l"(rd2), "l"(rd77));
  // PTX:253 ld.global.f32 %f113, [%rd78]
  f113 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (0)))));
  // PTX:254 ld.global.f32 %f114, [%rd78+4]
  f114 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (4)))));
  // PTX:255 ld.global.f32 %f115, [%rd78+8]
  f115 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd78) + (8)))));
  // PTX:256 mul.wide.s32 %rd79, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd79) : "r"(r45));
  // PTX:257 add.s64 %rd80, %rd2, %rd79
  asm("add.s64 %0, %1, %2;" : "=l"(rd80) : "l"(rd2), "l"(rd79));
  // PTX:258 ld.global.f32 %f116, [%rd80]
  f116 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (0)))));
  // PTX:259 sub.f32 %f238, %f13, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f13), "f"(f9));
  // PTX:260 mul.f32 %f117, %f238, %f116
  asm("mul.f32 %0, %1, %2;" : "=f"(f117) : "f"(f238), "f"(f116));
  // PTX:261 ld.global.f32 %f118, [%rd80+4]
  f118 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (4)))));
  // PTX:262 mul.f32 %f119, %f238, %f118
  asm("mul.f32 %0, %1, %2;" : "=f"(f119) : "f"(f238), "f"(f118));
  // PTX:263 ld.global.f32 %f120, [%rd80+8]
  f120 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd80) + (8)))));
  // PTX:264 mul.f32 %f121, %f238, %f120
  asm("mul.f32 %0, %1, %2;" : "=f"(f121) : "f"(f238), "f"(f120));
  // PTX:265 fma.rn.f32 %f122, %f239, %f113, %f117
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f122) : "f"(f239), "f"(f113), "f"(f117));
  // PTX:266 fma.rn.f32 %f123, %f239, %f114, %f119
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f123) : "f"(f239), "f"(f114), "f"(f119));
  // PTX:267 fma.rn.f32 %f124, %f239, %f115, %f121
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f124) : "f"(f239), "f"(f115), "f"(f121));
  // PTX:268 mul.wide.s32 %rd81, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd81) : "r"(r46));
  // PTX:269 add.s64 %rd82, %rd2, %rd81
  asm("add.s64 %0, %1, %2;" : "=l"(rd82) : "l"(rd2), "l"(rd81));
  // PTX:270 ld.global.f32 %f125, [%rd82]
  f125 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (0)))));
  // PTX:271 sub.f32 %f237, %f14, %f10
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f14), "f"(f10));
  // PTX:272 ld.global.f32 %f126, [%rd82+4]
  f126 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (4)))));
  // PTX:273 ld.global.f32 %f127, [%rd82+8]
  f127 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd82) + (8)))));
  // PTX:274 fma.rn.f32 %f128, %f237, %f125, %f122
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f128) : "f"(f237), "f"(f125), "f"(f122));
  // PTX:275 fma.rn.f32 %f129, %f237, %f126, %f123
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f129) : "f"(f237), "f"(f126), "f"(f123));
  // PTX:276 fma.rn.f32 %f130, %f237, %f127, %f124
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f130) : "f"(f237), "f"(f127), "f"(f124));
  // PTX:277 mul.wide.s32 %rd83, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd83) : "r"(r47));
  // PTX:278 add.s64 %rd84, %rd2, %rd83
  asm("add.s64 %0, %1, %2;" : "=l"(rd84) : "l"(rd2), "l"(rd83));
  // PTX:279 ld.global.f32 %f131, [%rd84]
  f131 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (0)))));
  // PTX:280 sub.f32 %f236, %f15, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f15), "f"(f11));
  // PTX:281 ld.global.f32 %f132, [%rd84+4]
  f132 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (4)))));
  // PTX:282 ld.global.f32 %f133, [%rd84+8]
  f133 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd84) + (8)))));
  // PTX:283 fma.rn.f32 %f242, %f236, %f131, %f128
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f242) : "f"(f236), "f"(f131), "f"(f128));
  // PTX:284 fma.rn.f32 %f241, %f236, %f132, %f129
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f241) : "f"(f236), "f"(f132), "f"(f129));
  // PTX:285 fma.rn.f32 %f240, %f236, %f133, %f130
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f240) : "f"(f236), "f"(f133), "f"(f130));
  // PTX:286 bra.uni $L__BB35_12
  goto L_BB35_12;
  // PTX:288 $L__BB35_11:
L_BB35_11:;
  // PTX:289 mov.b32 %f134, %r13
  asm("mov.b32 %0, %1;" : "=f"(f134) : "r"(r13));
  // PTX:290 mov.b32 %f135, %r10
  asm("mov.b32 %0, %1;" : "=f"(f135) : "r"(r10));
  // PTX:291 sub.f32 %f242, %f134, %f135
  asm("sub.f32 %0, %1, %2;" : "=f"(f242) : "f"(f134), "f"(f135));
  // PTX:292 mov.b32 %f136, %r11
  asm("mov.b32 %0, %1;" : "=f"(f136) : "r"(r11));
  // PTX:293 mov.b32 %f137, %r14
  asm("mov.b32 %0, %1;" : "=f"(f137) : "r"(r14));
  // PTX:294 sub.f32 %f241, %f137, %f136
  asm("sub.f32 %0, %1, %2;" : "=f"(f241) : "f"(f137), "f"(f136));
  // PTX:295 mov.b32 %f138, %r12
  asm("mov.b32 %0, %1;" : "=f"(f138) : "r"(r12));
  // PTX:296 mov.b32 %f139, %r15
  asm("mov.b32 %0, %1;" : "=f"(f139) : "r"(r15));
  // PTX:297 sub.f32 %f240, %f139, %f138
  asm("sub.f32 %0, %1, %2;" : "=f"(f240) : "f"(f139), "f"(f138));
  // PTX:298 sub.f32 %f239, %f12, %f8
  asm("sub.f32 %0, %1, %2;" : "=f"(f239) : "f"(f12), "f"(f8));
  // PTX:299 sub.f32 %f238, %f13, %f9
  asm("sub.f32 %0, %1, %2;" : "=f"(f238) : "f"(f13), "f"(f9));
  // PTX:300 sub.f32 %f237, %f14, %f10
  asm("sub.f32 %0, %1, %2;" : "=f"(f237) : "f"(f14), "f"(f10));
  // PTX:301 sub.f32 %f236, %f15, %f11
  asm("sub.f32 %0, %1, %2;" : "=f"(f236) : "f"(f15), "f"(f11));
  // PTX:303 $L__BB35_12:
L_BB35_12:;
  // PTX:304 ld.param.f32 %f232, [_ZN7synreal6kernel57evaluate_joint_body_point_line_augmented_lagrangian_forceEPKN3glm3vecILi3EfLNS1_9qualifierE0EEEPKNS2_ILi4EiLS3_0EEEPKNS2_ILi2EiLS3_0EEEPKNS2_ILi4EfLS3_0EEESF_SF_S6_S6_PKfSH_S6_PKNS1_3matILi3ELi3EfLS3_0EEEfPS4_mmmm_param_12]
  f232 = (*reinterpret_cast<volatile float*>(((uintptr_t)&param12 + (0))));
  // PTX:305 cvta.to.global.u64 %rd85, %rd24
  rd85 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd24));
  // PTX:306 shl.b64 %rd86, %rd4, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd86) : "l"(rd4));
  // PTX:307 add.s64 %rd87, %rd85, %rd86
  asm("add.s64 %0, %1, %2;" : "=l"(rd87) : "l"(rd85), "l"(rd86));
  // PTX:308 ld.global.f32 %f140, [%rd87]
  f140 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd87) + (0)))));
  // PTX:309 mul.f32 %f141, %f140, %f239
  asm("mul.f32 %0, %1, %2;" : "=f"(f141) : "f"(f140), "f"(f239));
  // PTX:310 mul.f32 %f142, %f140, %f238
  asm("mul.f32 %0, %1, %2;" : "=f"(f142) : "f"(f140), "f"(f238));
  // PTX:311 mul.f32 %f143, %f140, %f237
  asm("mul.f32 %0, %1, %2;" : "=f"(f143) : "f"(f140), "f"(f237));
  // PTX:312 mul.f32 %f144, %f140, %f236
  asm("mul.f32 %0, %1, %2;" : "=f"(f144) : "f"(f140), "f"(f236));
  // PTX:313 fma.rn.f32 %f145, %f242, %f140, %f235
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f145) : "f"(f242), "f"(f140), "f"(f235));
  // PTX:314 fma.rn.f32 %f146, %f241, %f140, %f234
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f146) : "f"(f241), "f"(f140), "f"(f234));
  // PTX:315 fma.rn.f32 %f147, %f240, %f140, %f233
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f147) : "f"(f240), "f"(f140), "f"(f233));
  // PTX:316 sub.f32 %f148, %f145, %f5
  asm("sub.f32 %0, %1, %2;" : "=f"(f148) : "f"(f145), "f"(f5));
  // PTX:317 sub.f32 %f149, %f146, %f6
  asm("sub.f32 %0, %1, %2;" : "=f"(f149) : "f"(f146), "f"(f6));
  // PTX:318 sub.f32 %f150, %f147, %f7
  asm("sub.f32 %0, %1, %2;" : "=f"(f150) : "f"(f147), "f"(f7));
  // PTX:319 cvta.to.global.u64 %rd88, %rd25
  rd88 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd25));
  // PTX:320 mul.lo.s64 %rd89, %rd4, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd89) : "l"(rd4));
  // PTX:321 add.s64 %rd90, %rd88, %rd89
  asm("add.s64 %0, %1, %2;" : "=l"(rd90) : "l"(rd88), "l"(rd89));
  // PTX:322 ld.global.f32 %f151, [%rd90]
  f151 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (0)))));
  // PTX:323 add.f32 %f152, %f148, %f151
  asm("add.f32 %0, %1, %2;" : "=f"(f152) : "f"(f148), "f"(f151));
  // PTX:324 ld.global.f32 %f153, [%rd90+4]
  f153 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (4)))));
  // PTX:325 add.f32 %f154, %f149, %f153
  asm("add.f32 %0, %1, %2;" : "=f"(f154) : "f"(f149), "f"(f153));
  // PTX:326 ld.global.f32 %f155, [%rd90+8]
  f155 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd90) + (8)))));
  // PTX:327 add.f32 %f156, %f150, %f155
  asm("add.f32 %0, %1, %2;" : "=f"(f156) : "f"(f150), "f"(f155));
  // PTX:328 cvta.to.global.u64 %rd91, %rd26
  rd91 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd26));
  // PTX:329 mul.lo.s64 %rd92, %rd4, 36
  asm("mul.lo.s64 %0, %1, 36;" : "=l"(rd92) : "l"(rd4));
  // PTX:330 add.s64 %rd93, %rd91, %rd92
  asm("add.s64 %0, %1, %2;" : "=l"(rd93) : "l"(rd91), "l"(rd92));
  // PTX:331 ld.global.f32 %f157, [%rd93]
  f157 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (0)))));
  // PTX:332 ld.global.f32 %f158, [%rd93+12]
  f158 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (12)))));
  // PTX:333 mul.f32 %f159, %f154, %f158
  asm("mul.f32 %0, %1, %2;" : "=f"(f159) : "f"(f154), "f"(f158));
  // PTX:334 fma.rn.f32 %f160, %f152, %f157, %f159
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f160) : "f"(f152), "f"(f157), "f"(f159));
  // PTX:335 ld.global.f32 %f161, [%rd93+24]
  f161 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (24)))));
  // PTX:336 fma.rn.f32 %f162, %f156, %f161, %f160
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f162) : "f"(f156), "f"(f161), "f"(f160));
  // PTX:337 ld.global.f32 %f163, [%rd93+4]
  f163 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (4)))));
  // PTX:338 ld.global.f32 %f164, [%rd93+16]
  f164 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (16)))));
  // PTX:339 mul.f32 %f165, %f154, %f164
  asm("mul.f32 %0, %1, %2;" : "=f"(f165) : "f"(f154), "f"(f164));
  // PTX:340 fma.rn.f32 %f166, %f152, %f163, %f165
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f166) : "f"(f152), "f"(f163), "f"(f165));
  // PTX:341 ld.global.f32 %f167, [%rd93+28]
  f167 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (28)))));
  // PTX:342 fma.rn.f32 %f168, %f156, %f167, %f166
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f168) : "f"(f156), "f"(f167), "f"(f166));
  // PTX:343 ld.global.f32 %f169, [%rd93+8]
  f169 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (8)))));
  // PTX:344 ld.global.f32 %f170, [%rd93+20]
  f170 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (20)))));
  // PTX:345 mul.f32 %f171, %f154, %f170
  asm("mul.f32 %0, %1, %2;" : "=f"(f171) : "f"(f154), "f"(f170));
  // PTX:346 fma.rn.f32 %f172, %f152, %f169, %f171
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f172) : "f"(f152), "f"(f169), "f"(f171));
  // PTX:347 ld.global.f32 %f173, [%rd93+32]
  f173 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd93) + (32)))));
  // PTX:348 fma.rn.f32 %f174, %f156, %f173, %f172
  asm("fma.rn.f32 %0, %1, %2, %3;" : "=f"(f174) : "f"(f156), "f"(f173), "f"(f172));
  // PTX:349 cvta.to.global.u64 %rd94, %rd23
  rd94 = (unsigned long long)(uintptr_t)__cvta_generic_to_global(reinterpret_cast<const void*>(rd23));
  // PTX:350 shl.b64 %rd95, %rd11, 2
  asm("shl.b64 %0, %1, 2;" : "=l"(rd95) : "l"(rd11));
  // PTX:351 add.s64 %rd96, %rd94, %rd95
  asm("add.s64 %0, %1, %2;" : "=l"(rd96) : "l"(rd94), "l"(rd95));
  // PTX:352 ld.global.f32 %f175, [%rd96]
  f175 = (*reinterpret_cast<volatile float*>(__cvta_global_to_generic(((uintptr_t)(rd96) + (0)))));
  // PTX:353 mul.f32 %f176, %f175, %f232
  asm("mul.f32 %0, %1, %2;" : "=f"(f176) : "f"(f175), "f"(f232));
  // PTX:354 mul.f32 %f46, %f162, %f176
  asm("mul.f32 %0, %1, %2;" : "=f"(f46) : "f"(f162), "f"(f176));
  // PTX:355 mul.f32 %f47, %f168, %f176
  asm("mul.f32 %0, %1, %2;" : "=f"(f47) : "f"(f168), "f"(f176));
  // PTX:356 mul.f32 %f48, %f174, %f176
  asm("mul.f32 %0, %1, %2;" : "=f"(f48) : "f"(f174), "f"(f176));
  // PTX:357 mul.f32 %f177, %f1, %f46
  asm("mul.f32 %0, %1, %2;" : "=f"(f177) : "f"(f1), "f"(f46));
  // PTX:358 mul.f32 %f178, %f1, %f47
  asm("mul.f32 %0, %1, %2;" : "=f"(f178) : "f"(f1), "f"(f47));
  // PTX:359 mul.f32 %f179, %f1, %f48
  asm("mul.f32 %0, %1, %2;" : "=f"(f179) : "f"(f1), "f"(f48));
  // PTX:360 mul.f32 %f180, %f46, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f180) : "f"(f46), "f"(f2));
  // PTX:361 mul.f32 %f181, %f47, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f181) : "f"(f47), "f"(f2));
  // PTX:362 mul.f32 %f182, %f48, %f2
  asm("mul.f32 %0, %1, %2;" : "=f"(f182) : "f"(f48), "f"(f2));
  // PTX:363 mul.f32 %f183, %f46, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f183) : "f"(f46), "f"(f3));
  // PTX:364 mul.f32 %f184, %f47, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f184) : "f"(f47), "f"(f3));
  // PTX:365 mul.f32 %f185, %f48, %f3
  asm("mul.f32 %0, %1, %2;" : "=f"(f185) : "f"(f48), "f"(f3));
  // PTX:366 mul.f32 %f186, %f46, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f186) : "f"(f46), "f"(f4));
  // PTX:367 mul.f32 %f187, %f47, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f187) : "f"(f47), "f"(f4));
  // PTX:368 mul.f32 %f188, %f48, %f4
  asm("mul.f32 %0, %1, %2;" : "=f"(f188) : "f"(f48), "f"(f4));
  // PTX:369 add.f32 %f189, %f11, %f15
  asm("add.f32 %0, %1, %2;" : "=f"(f189) : "f"(f11), "f"(f15));
  // PTX:370 add.f32 %f190, %f10, %f14
  asm("add.f32 %0, %1, %2;" : "=f"(f190) : "f"(f10), "f"(f14));
  // PTX:371 add.f32 %f191, %f9, %f13
  asm("add.f32 %0, %1, %2;" : "=f"(f191) : "f"(f9), "f"(f13));
  // PTX:372 add.f32 %f192, %f8, %f12
  asm("add.f32 %0, %1, %2;" : "=f"(f192) : "f"(f8), "f"(f12));
  // PTX:373 mul.lo.s64 %rd97, %rd13, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd97) : "l"(rd13));
  // PTX:374 add.s64 %rd98, %rd1, %rd97
  asm("add.s64 %0, %1, %2;" : "=l"(rd98) : "l"(rd1), "l"(rd97));
  // PTX:375 red.global.add.f32 [%rd98], %f177
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd98) + (0)))), (float)(f177));
  // PTX:376 add.s64 %rd99, %rd98, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd99) : "l"(rd98));
  // PTX:377 red.global.add.f32 [%rd99], %f178
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd99) + (0)))), (float)(f178));
  // PTX:378 add.s64 %rd100, %rd98, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd100) : "l"(rd98));
  // PTX:379 red.global.add.f32 [%rd100], %f179
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd100) + (0)))), (float)(f179));
  // PTX:380 mul.lo.s64 %rd101, %rd14, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd101) : "l"(rd14));
  // PTX:381 add.s64 %rd102, %rd1, %rd101
  asm("add.s64 %0, %1, %2;" : "=l"(rd102) : "l"(rd1), "l"(rd101));
  // PTX:382 red.global.add.f32 [%rd102], %f180
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd102) + (0)))), (float)(f180));
  // PTX:383 add.s64 %rd103, %rd102, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd103) : "l"(rd102));
  // PTX:384 red.global.add.f32 [%rd103], %f181
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd103) + (0)))), (float)(f181));
  // PTX:385 add.s64 %rd104, %rd102, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd104) : "l"(rd102));
  // PTX:386 red.global.add.f32 [%rd104], %f182
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd104) + (0)))), (float)(f182));
  // PTX:387 mul.lo.s64 %rd105, %rd15, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd105) : "l"(rd15));
  // PTX:388 add.s64 %rd106, %rd1, %rd105
  asm("add.s64 %0, %1, %2;" : "=l"(rd106) : "l"(rd1), "l"(rd105));
  // PTX:389 red.global.add.f32 [%rd106], %f183
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd106) + (0)))), (float)(f183));
  // PTX:390 add.s64 %rd107, %rd106, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd107) : "l"(rd106));
  // PTX:391 red.global.add.f32 [%rd107], %f184
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd107) + (0)))), (float)(f184));
  // PTX:392 add.s64 %rd108, %rd106, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd108) : "l"(rd106));
  // PTX:393 red.global.add.f32 [%rd108], %f185
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd108) + (0)))), (float)(f185));
  // PTX:394 mul.lo.s64 %rd109, %rd16, 12
  asm("mul.lo.s64 %0, %1, 12;" : "=l"(rd109) : "l"(rd16));
  // PTX:395 add.s64 %rd110, %rd1, %rd109
  asm("add.s64 %0, %1, %2;" : "=l"(rd110) : "l"(rd1), "l"(rd109));
  // PTX:396 red.global.add.f32 [%rd110], %f186
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd110) + (0)))), (float)(f186));
  // PTX:397 add.s64 %rd111, %rd110, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd111) : "l"(rd110));
  // PTX:398 red.global.add.f32 [%rd111], %f187
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd111) + (0)))), (float)(f187));
  // PTX:399 add.s64 %rd112, %rd110, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd112) : "l"(rd110));
  // PTX:400 red.global.add.f32 [%rd112], %f188
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd112) + (0)))), (float)(f188));
  // PTX:401 fma.rn.f32 %f49, %f192, 0f3F000000, %f141
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f49) : "f"(f192), "f"(f141));
  // PTX:402 fma.rn.f32 %f50, %f191, 0f3F000000, %f142
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f50) : "f"(f191), "f"(f142));
  // PTX:403 fma.rn.f32 %f51, %f190, 0f3F000000, %f143
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f51) : "f"(f190), "f"(f143));
  // PTX:404 fma.rn.f32 %f52, %f189, 0f3F000000, %f144
  asm("fma.rn.f32 %0, %1, 0f3F000000, %2;" : "=f"(f52) : "f"(f189), "f"(f144));
  // PTX:405 @%p4 bra $L__BB35_14
  if (p4) { goto L_BB35_14; }
  // PTX:407 neg.f32 %f205, %f46
  asm("neg.f32 %0, %1;" : "=f"(f205) : "f"(f46));
  // PTX:408 mul.f32 %f206, %f49, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f206) : "f"(f49), "f"(f205));
  // PTX:409 neg.f32 %f207, %f47
  asm("neg.f32 %0, %1;" : "=f"(f207) : "f"(f47));
  // PTX:410 mul.f32 %f208, %f49, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f208) : "f"(f49), "f"(f207));
  // PTX:411 neg.f32 %f209, %f48
  asm("neg.f32 %0, %1;" : "=f"(f209) : "f"(f48));
  // PTX:412 mul.f32 %f210, %f49, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f210) : "f"(f49), "f"(f209));
  // PTX:413 mul.f32 %f211, %f50, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f211) : "f"(f50), "f"(f205));
  // PTX:414 mul.f32 %f212, %f50, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f212) : "f"(f50), "f"(f207));
  // PTX:415 mul.f32 %f213, %f50, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f213) : "f"(f50), "f"(f209));
  // PTX:416 mul.f32 %f214, %f51, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f214) : "f"(f51), "f"(f205));
  // PTX:417 mul.f32 %f215, %f51, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f215) : "f"(f51), "f"(f207));
  // PTX:418 mul.f32 %f216, %f51, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f216) : "f"(f51), "f"(f209));
  // PTX:419 mul.f32 %f217, %f52, %f205
  asm("mul.f32 %0, %1, %2;" : "=f"(f217) : "f"(f52), "f"(f205));
  // PTX:420 mul.f32 %f218, %f52, %f207
  asm("mul.f32 %0, %1, %2;" : "=f"(f218) : "f"(f52), "f"(f207));
  // PTX:421 mul.f32 %f219, %f52, %f209
  asm("mul.f32 %0, %1, %2;" : "=f"(f219) : "f"(f52), "f"(f209));
  // PTX:422 mul.wide.s32 %rd113, %r44, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd113) : "r"(r44));
  // PTX:423 add.s64 %rd114, %rd1, %rd113
  asm("add.s64 %0, %1, %2;" : "=l"(rd114) : "l"(rd1), "l"(rd113));
  // PTX:424 red.global.add.f32 [%rd114], %f206
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd114) + (0)))), (float)(f206));
  // PTX:425 add.s64 %rd115, %rd114, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd115) : "l"(rd114));
  // PTX:426 red.global.add.f32 [%rd115], %f208
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd115) + (0)))), (float)(f208));
  // PTX:427 add.s64 %rd116, %rd114, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd116) : "l"(rd114));
  // PTX:428 red.global.add.f32 [%rd116], %f210
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd116) + (0)))), (float)(f210));
  // PTX:429 mul.wide.s32 %rd117, %r45, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd117) : "r"(r45));
  // PTX:430 add.s64 %rd118, %rd1, %rd117
  asm("add.s64 %0, %1, %2;" : "=l"(rd118) : "l"(rd1), "l"(rd117));
  // PTX:431 red.global.add.f32 [%rd118], %f211
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd118) + (0)))), (float)(f211));
  // PTX:432 add.s64 %rd119, %rd118, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd119) : "l"(rd118));
  // PTX:433 red.global.add.f32 [%rd119], %f212
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd119) + (0)))), (float)(f212));
  // PTX:434 add.s64 %rd120, %rd118, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd120) : "l"(rd118));
  // PTX:435 red.global.add.f32 [%rd120], %f213
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd120) + (0)))), (float)(f213));
  // PTX:436 mul.wide.s32 %rd121, %r46, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd121) : "r"(r46));
  // PTX:437 add.s64 %rd122, %rd1, %rd121
  asm("add.s64 %0, %1, %2;" : "=l"(rd122) : "l"(rd1), "l"(rd121));
  // PTX:438 red.global.add.f32 [%rd122], %f214
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd122) + (0)))), (float)(f214));
  // PTX:439 add.s64 %rd123, %rd122, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd123) : "l"(rd122));
  // PTX:440 red.global.add.f32 [%rd123], %f215
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd123) + (0)))), (float)(f215));
  // PTX:441 add.s64 %rd124, %rd122, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd124) : "l"(rd122));
  // PTX:442 red.global.add.f32 [%rd124], %f216
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd124) + (0)))), (float)(f216));
  // PTX:443 mul.wide.s32 %rd125, %r47, 12
  asm("mul.wide.s32 %0, %1, 12;" : "=l"(rd125) : "r"(r47));
  // PTX:444 add.s64 %rd126, %rd1, %rd125
  asm("add.s64 %0, %1, %2;" : "=l"(rd126) : "l"(rd1), "l"(rd125));
  // PTX:445 red.global.add.f32 [%rd126], %f217
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd126) + (0)))), (float)(f217));
  // PTX:446 add.s64 %rd127, %rd126, 4
  asm("add.s64 %0, %1, 4;" : "=l"(rd127) : "l"(rd126));
  // PTX:447 red.global.add.f32 [%rd127], %f218
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd127) + (0)))), (float)(f218));
  // PTX:448 add.s64 %rd128, %rd126, 8
  asm("add.s64 %0, %1, 8;" : "=l"(rd128) : "l"(rd126));
  // PTX:449 red.global.add.f32 [%rd128], %f219
  atomicAdd(reinterpret_cast<float*>(__cvta_global_to_generic(((uintptr_t)(rd128) + (0)))), (float)(f219));
  // PTX:451 $L__BB35_14:
L_BB35_14:;
  // PTX:452 ret
  return;
}
